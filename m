Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA97E465ED6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355854AbhLBHqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:46:50 -0500
Received: from cpanel.siel.si ([46.19.9.99]:50440 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345486AbhLBHqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tBo6YAMnSGqoGlwdEydrQuSMok3rjMTScuODlnhntX8=; b=jPnrRaMDRPb/8TzJvoiYHeQg5d
        aaRXeZ0jx0NHqRihC0eHsrwqTiyWdEdu5pkJxjyIRDuw02XvE6lTU1ioHrwrB8dNuA9oi7H6FwLuW
        Q55J9GHYqVbA4OLzNGr4q6L94AZR5N5koF+s6NxJlh33w3CEcUNQxf97Wx5/6T7xcaLowH+MfH58b
        kEz0LdjcORRGcnwMXhAaoEUOPDBqQzJmoIuWEtPdWMMcc4VOTQSOkbm0bQO/vjRY7z6zK/40CGuJE
        vzY00yG6/tpX9tagP2rll5hHCOh1vE1mmKaWz81eiG/ZyXYVL/yXV+wGSDfczENcJPaOhZPHn9qY6
        +zCsDZTw==;
Received: from [89.212.21.243] (port=49188 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1msgkO-00D7S7-37; Thu, 02 Dec 2021 08:43:23 +0100
Subject: Re: [PATCH v3 2/4] watchdog: da9062: reset board on watchdog timeout
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211201081512.3580837-1-andrej.picej@norik.com>
 <20211201081512.3580837-2-andrej.picej@norik.com>
 <13e0b9047f114722a0b4ebb4c1d24f2b@dh-electronics.com>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <9298e77a-d74e-f51a-187f-830da184e67d@norik.com>
Date:   Thu, 2 Dec 2021 08:43:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <13e0b9047f114722a0b4ebb4c1d24f2b@dh-electronics.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 1. 12. 21 15:11, Christoph Niedermaier wrote:
> From: Andrej Picej
> Sent: Wednesday, December 1, 2021 9:15 AM
>> Implement a method to change watchdog timeout configuration based on DT
>> binding ("dlg,wdt-sd"). There is a possibility to change the bahaviour
>> of watchdog reset. Setting WATCHDOG_SD bit enables SHUTDOWN mode, and
>> clearing it enables POWERDOWN mode on watchdog timeout.
>>
>> If no DT binding is specified the WATCHDOG_SD bit stays in default
>> configuration, not breaking behaviour of devices which might depend on
>> default fuse configuration.
>>
>> Note: This patch requires that the config register CONFIG_I is
>> configured as writable in the da9062 multi function device.
>>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> ---
>> Changes in v3:
>>   - no changes
>>
>> Changes in v2:
>>   - don't force the "reset" for all da9062-watchdog users, instead add DT
>>     binding where the behavior can be selected
>> ---
>>   drivers/watchdog/da9062_wdt.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
>> index f02cbd530538..e342e9e50cb1 100644
>> --- a/drivers/watchdog/da9062_wdt.c
>> +++ b/drivers/watchdog/da9062_wdt.c
>> @@ -85,8 +85,33 @@ static int da9062_wdt_start(struct watchdog_device *wdd)
>>   {
>>          struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
>>          unsigned int selector;
>> +       unsigned int mask;
>> +       u32 val;
>>          int ret;
>>
>> +       /* Configure what happens on watchdog timeout. Can be specified with
>> +        * "dlg,wdt-sd" dt-binding (0 -> POWERDOWN, 1 -> SHUTDOWN).
>> +        * If "dlg,wdt-sd" dt-binding is NOT set use the default.
>> +        */
>> +       ret = device_property_read_u32(wdd->parent, "dlg,wdt-sd", &val);
>> +       if (!ret) {
>> +               if (val)
>> +                       /* Use da9062's SHUTDOWN mode */
>> +                       mask = DA9062AA_WATCHDOG_SD_MASK;
>> +               else
>> +                       /* Use da9062's POWERDOWN mode. */
>> +                       mask = 0x0;
>> +
>> +               ret = regmap_update_bits(wdt->hw->regmap,
>> +                                               DA9062AA_CONFIG_I,
>> +                                               DA9062AA_WATCHDOG_SD_MASK,
>> +                                               mask);
>> +
>> +               if (ret)
>> +                       dev_err(wdt->hw->dev, "failed to set wdt reset mode:
>> %d\n",
>> +                               ret);
>> +       }
>> +
>>          selector = da9062_wdt_timeout_to_sel(wdt->wdtdev.timeout);
>>          ret = da9062_wdt_update_timeout_register(wdt, selector);
>>          if (ret)
>> --
>> 2.25.1
>>
> 
> I have a question how to correctly restart the system after
> watchdog timeout.
> If I understand it correct after watchdog timeout the system
> restarts only if WATCHDOG_SD (Bit 3) in register CONFIG_I is
> set.
> What is the difference if WATCHDOG_SD isn't set, but WAKE_UP
> (Bit 2) in register CONTROL_F is set? From outside on my
> system I observe the same behavior. After watchdog timeout
> my system restarts. So where are the differences?
> It would be nice if you could answer this question, as you
> certainly know this chip very well.

To be honest I don't really know the chip that well, I'm just trying to 
add this feature and hopefully help others if they run into the same 
problem. I think @Adam will be more helpful here.

But from quick look at da9062 datasheet, mainly chapter "8.8 Power 
Modes" I see next main differences:
- setting WATCHDOG_SD enables SHUTDOWN sequence when the watchdog 
timeout is triggered. This puts the chip (da9062) in RESET mode.
Taken from DA9062 datasheet:
> In RESET mode, the internal supplies, and LDO1 (if configured as an always-on supply) are enabled. 
> All other DA9062 supplies are disabled.
> DA9062 is in RESET mode whenever a complete application shutdown is required
> The DA9062’s register configuration will be re-loaded from OTP when leaving the RESET mode

- if you set the WAKE_UP bit than the chip enters POWERDOWN mode on 
watchdog timeout. I understand the POWERDOWN mode as a not that "deep" 
mode as a RESET mode Device will go from RESET mode to POWERDOWN mode in 
the sequence of powering-up.

The above explanation is just my understanding after quick look, @Adam 
please correct me if I'm talking nonsense.

Please have a look at the DA9062 datasheet for more information. Sorry, 
that I can't be more helpful here.

Best regards,
Andrej
