Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F15467397
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379404AbhLCJCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:02:31 -0500
Received: from cpanel.siel.si ([46.19.9.99]:44618 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351168AbhLCJC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SusT965a0ta5c2aDyA4YCYsj79hiy5hbuJlqiijsxnM=; b=Ll6dxuzuFyJ22sroDwYh3iICLA
        TFR2jx/1rxJzsWCIX80rvWx0P5F+6fFzQrvKwVEYCVPIpbo0iOaD6pLp41E/4GRLvxdOMZzcF98qH
        BJ1rwD8X3SXHHHLVdr7+9dvlBCmMGAI0Cp4N142wWg1fJ4oEICWWVyUQAwYKKrs2WuZhaFoWRkJHN
        tXlNQel9FC8139ETFOgC4iwYFNW/lNc/kF+2IWEXbX7W2CSxVv+s3ixvjx+fMXR0Rqz5G3kmvQTvr
        aFjnMf4wvUXwb60Dt9/YQ3iwYZ5ksUvOhPw4u1nkwEFrxcrQnrIFWrtqaeA6BHNxFYhqbiv4hsdSN
        eCS9XbcQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:39492 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mt4P8-001CNz-3X; Fri, 03 Dec 2021 09:59:01 +0100
Subject: Re: [PATCH v4 1/4] mfd: da9062: make register CONFIG_I writable
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
References: <20211202093230.3951996-1-andrej.picej@norik.com>
 <9e35530f629044e595decb101a097fde@dh-electronics.com>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <9524a32b-d7f5-487c-e791-12bf0554a90f@norik.com>
Date:   Fri, 3 Dec 2021 09:59:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9e35530f629044e595decb101a097fde@dh-electronics.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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



On 2. 12. 21 16:18, Christoph Niedermaier wrote:
> From: Andrej Picej
> Sent: Thursday, December 2, 2021 10:32 AM
>> From: Stefan Christ <s.christ@phytec.de>
>>
>> Make the config register CONFIG_I writable to change the watchdog mode.
>>
>> Signed-off-by: Stefan Christ <s.christ@phytec.de>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> ---
>> Chnages in v4:
>>   - no changes
>>
>> Changes in v3:
>>   - no chagnes
>>
>> Changes in v2:
>>   - no changes
>> ---
>>   drivers/mfd/da9062-core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
>> index 01f8e10dfa55..7041ba53efb4 100644
>> --- a/drivers/mfd/da9062-core.c
>> +++ b/drivers/mfd/da9062-core.c
>> @@ -556,6 +556,7 @@ static const struct regmap_range
>> da9062_aa_writeable_ranges[] = {
>>          regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
>>          regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
>>          regmap_reg_range(DA9062AA_BBAT_CONT, DA9062AA_BBAT_CONT),
>> +       regmap_reg_range(DA9062AA_CONFIG_I, DA9062AA_CONFIG_I),
>>          regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
>>   };

> Could you also include the CONFIG_I for the DA9061?
> So I can test it on my system.
> 

Yes, I don't see the problem here.
@Maintainers, should I send a new version with this (then I would also 
fix the minor spelling mistake in commit message of 2/4), or do you 
prefer a separate patch?

Thanks,
Andrej.
