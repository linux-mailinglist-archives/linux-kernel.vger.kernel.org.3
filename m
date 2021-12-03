Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BED4679F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245352AbhLCPID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhLCPID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:08:03 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0200DC061751;
        Fri,  3 Dec 2021 07:04:39 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q25so6457071oiw.0;
        Fri, 03 Dec 2021 07:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1vqMEDUS1H0SnLLPkXCfCEBwl6uCB0FBvQHL6Bcsucw=;
        b=cxCcg8kmiquENGZFnDLoExIDnrYr+9g/XFwQOoN4d18BKwCJf9f3WYZP0X/qRo2Cts
         Nzp4SDnRhyrYPCmj7embrhDNYRsvDmDXATys2PJEAyNqjP+f8JAVVSwb2xKuEP8wryEZ
         JMfpMhE0EYXDCtiEZrTI+uAWV540g07lY4bM5V/sQuN47qvZ5VJHzG78rvCBBKY6sqkd
         hVDLw5QH1iURautyki7zvPyxv2AcD0mh2nwf9nc3QMS55aWSad8nXd1Bz++ina7jPI0m
         bebvb6qDMGNKu9RUeLzViS2BKRLsGusd7fdkvhXA+sXNu1oFDWbGloOiA0eymevwrnVi
         Zcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1vqMEDUS1H0SnLLPkXCfCEBwl6uCB0FBvQHL6Bcsucw=;
        b=8JNnGfTK3syu1WD/R6t+aoA3H5TspSa/w9j6FYw83UqTaov+6Y1bkMT7Moz6Yc6cMf
         O2tGL4EeFrUR1utEm1r2RoNvWmND67FhMejutqiG4agRrf0CcUCuQwb7SLe+2uG12g1x
         QE1C1Gjd0POYSP7445SfRh6QMK0nLLDv+JP9GKLvOSsC4XRrqUL5er2I3akwPTGVPqrJ
         i6I+922qUaARLAT0c10fDxGNHPz4p3UJHovSq0FsPFvD3MLAuama2NKWAXZquJeVCO9K
         hdK9bGqyxB1ot3u9T/ZTM6VknZG7skcziYO8i7o+AGIcj0jzyXyp1pbqGWgZcWzvb1Cr
         H8Lg==
X-Gm-Message-State: AOAM53379bwgbZouvLU8fPEGn6MlK2q+mvPt1z2DLdqbGAe1euzkUQcE
        8KYZkiB+CUeE7wUzboWDYsY=
X-Google-Smtp-Source: ABdhPJy659tpX/p3wcX/7DptF9TEfCvniSXNxyUUPx5jBLsWivbOTj4/M3QnfFxFHAF1MJlNpFzt5g==
X-Received: by 2002:aca:581:: with SMTP id 123mr10450925oif.13.1638543878369;
        Fri, 03 Dec 2021 07:04:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bq5sm783955oib.55.2021.12.03.07.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 07:04:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Andrej Picej <andrej.picej@norik.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
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
 <9524a32b-d7f5-487c-e791-12bf0554a90f@norik.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 1/4] mfd: da9062: make register CONFIG_I writable
Message-ID: <905f50ba-8646-1f47-0a2c-d58ec9a86fa1@roeck-us.net>
Date:   Fri, 3 Dec 2021 07:04:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9524a32b-d7f5-487c-e791-12bf0554a90f@norik.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 12:59 AM, Andrej Picej wrote:
> 
> 
> On 2. 12. 21 16:18, Christoph Niedermaier wrote:
>> From: Andrej Picej
>> Sent: Thursday, December 2, 2021 10:32 AM
>>> From: Stefan Christ <s.christ@phytec.de>
>>>
>>> Make the config register CONFIG_I writable to change the watchdog mode.
>>>
>>> Signed-off-by: Stefan Christ <s.christ@phytec.de>
>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>>> ---
>>> Chnages in v4:
>>>   - no changes
>>>
>>> Changes in v3:
>>>   - no chagnes
>>>
>>> Changes in v2:
>>>   - no changes
>>> ---
>>>   drivers/mfd/da9062-core.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
>>> index 01f8e10dfa55..7041ba53efb4 100644
>>> --- a/drivers/mfd/da9062-core.c
>>> +++ b/drivers/mfd/da9062-core.c
>>> @@ -556,6 +556,7 @@ static const struct regmap_range
>>> da9062_aa_writeable_ranges[] = {
>>>          regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
>>>          regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
>>>          regmap_reg_range(DA9062AA_BBAT_CONT, DA9062AA_BBAT_CONT),
>>> +       regmap_reg_range(DA9062AA_CONFIG_I, DA9062AA_CONFIG_I),
>>>          regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
>>>   };
> 
>> Could you also include the CONFIG_I for the DA9061?
>> So I can test it on my system.
>>
> 
> Yes, I don't see the problem here.
> @Maintainers, should I send a new version with this (then I would also fix the minor spelling mistake in commit message of 2/4), or do you prefer a separate patch?
> 

Either way is fine, with a slight preference on sending a new version.

Guenter
