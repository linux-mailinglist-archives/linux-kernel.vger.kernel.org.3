Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03FB465F8E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 09:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbhLBIiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:38:00 -0500
Received: from cpanel.siel.si ([46.19.9.99]:35472 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241126AbhLBIh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=50NrMl5trPApnR1HnsTIfr+L19Vcwp/lvKAchEeW0ic=; b=lKwa7F3hz19cFkBiO9cz7hlkdU
        L+a3109FO8lli4ZzOpmiipS3ilKlPoOn/YZPH6QHjFY+H4J3eABr88DY12B+xyYO3gXksHfmTmCVU
        waS/NjbI6QVJx9glLssED22cLQsNUpZ4x+3cPC/TDntcoU5+BMim+C3xTS5j/KC5V/e5r1TgWwh7l
        +OIYQnqDe7LxfcM6LLpaHjyOycY2mIZQeDQjByiCtnqCpENbcJYY22CpBJloLvYKrYie8Wm5xUKkz
        /qSFLH7EAX755kPpyugD1M3glzdQFHLoCKxi3G8OcBED/73bXbwXHPBNEBUvrQAa0q7b90TTOqJqc
        aRQ6pTsg==;
Received: from [89.212.21.243] (port=50490 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mshXt-00DFh4-1K; Thu, 02 Dec 2021 09:34:32 +0100
Subject: Re: [PATCH v3 2/4] watchdog: da9062: reset board on watchdog timeout
To:     Guenter Roeck <linux@roeck-us.net>, support.opensource@diasemi.com,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
References: <20211201081512.3580837-1-andrej.picej@norik.com>
 <20211201081512.3580837-2-andrej.picej@norik.com>
 <fa9eb129-a152-4f22-9bf4-07bf27ec441f@roeck-us.net>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <4414c18e-83dd-0d64-325b-f69807ba49f4@norik.com>
Date:   Thu, 2 Dec 2021 09:34:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fa9eb129-a152-4f22-9bf4-07bf27ec441f@roeck-us.net>
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



On 1. 12. 21 22:26, Guenter Roeck wrote:
> On 12/1/21 12:15 AM, Andrej Picej wrote:
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
>>   - no changes
>>
>> Changes in v2:
>>   - don't force the "reset" for all da9062-watchdog users, instead add DT
>>     binding where the behavior can be selected
>> ---
>>   drivers/watchdog/da9062_wdt.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/watchdog/da9062_wdt.c 
>> b/drivers/watchdog/da9062_wdt.c
>> index f02cbd530538..e342e9e50cb1 100644
>> --- a/drivers/watchdog/da9062_wdt.c
>> +++ b/drivers/watchdog/da9062_wdt.c
>> @@ -85,8 +85,33 @@ static int da9062_wdt_start(struct watchdog_device 
>> *wdd)
>>   {
>>       struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
>>       unsigned int selector;
>> +    unsigned int mask;
>> +    u32 val;
>>       int ret;
>> +    /* Configure what happens on watchdog timeout. Can be specified with
>> +     * "dlg,wdt-sd" dt-binding (0 -> POWERDOWN, 1 -> SHUTDOWN).
>> +     * If "dlg,wdt-sd" dt-binding is NOT set use the default.
>> +     */
> 
> Please use standard multi-line comments. This is not the networking
> subsystem.
> 
> Also, if you think this code should be here and not in the probe function,
> as suggested by Adam, please provide a rationale.
> 

I will fix the multi-line comment, move this code to probe and
submit the changes in the next patch version.

Thanks,
Andrej
