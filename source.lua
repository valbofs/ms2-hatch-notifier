--You have to rejoin when you already execute it.

if game.PlaceId == 9551640993 then
if not game:IsLoaded() then game.Loaded:Wait() end

local a = require(game:GetService("ReplicatedStorage").SharedModules.Data.Eggs)
local b = require(game:GetService("ReplicatedStorage").ClientModules.LocalData).GetData()
local List = {"K","M","B","T"}

if _G.Executed == nil then
    _G.Executed = true
    
    function c3toDecimal(c3)
      return tonumber(c3:ToHex(), 16)
    end
    function NumberSuffix(Num)
        local ListCount = 0
        while Num / 1000 >= 1 do
            ListCount = ListCount + 1 
            Num = Num / 1000 
        end
        if ListCount == 0 then return Num end 
        return math.floor(Num*10)/10 ..List[ListCount]
    end
    
    game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller.ChildAdded:Connect(function(child)
        local okay = string.split(child.TextLabel.Text, " ")
        local kkay = string.split(child.TextLabel.Text, "[Server]: ")
        local Message = nil
        if okay[1] == "[Server]:" and okay[2] == game.Players.LocalPlayer.Name then
            for i,v in pairs(_G.PetsToPing) do
                if string.find(child.TextLabel.Text, v) and _G.RoleID ~= "" then
                    Message = " :loudspeaker: <@&" .. tostring(_G.RoleID) .. ">"
                            
                            msg = {
                    ["content"] = Message,
                    ["embeds"] = {{
                        ["title"] = "Eggs Hatched: "..NumberSuffix(game:GetService("Players").LocalPlayer.leaderstats.Eggs.Value).."   |   ".."Coins: "..NumberSuffix(math.floor(b.Coins)).."   |   "..NumberSuffix(math.floor(b.Coins / a[game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.EggDisplay.Title.Text].Cost[2])).." Eggs remaining",
                        ["description"] = kkay[2],
                        ["color"] = c3toDecimal(child.TextLabel.TextColor3),
                    }}
                }
                local response = syn.request(
                    {
                        Url = _G.Webhook,
                        Method = "POST",
                        Headers = {
                        ["Content-Type"] = "application/json"
                        },
                        Body = game:GetService("HttpService"):JSONEncode(msg)
                    }
                )
                            
                end
            end
            
            end
        end)
    end
end
