Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DF04C59D7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 08:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiB0G4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 01:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiB0G4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 01:56:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06F712A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 22:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=uGkwfFG4oU2IF8mA/LqOVsaAtXKwdEqo5q9NlTqW6Ec=; b=tFxG6LJoMhStLrLnbYRZVqD7Tw
        E3FYoNCTtueEYnqHYSO80ZXl6SzegIrNC5IrXFLppG00CEdyR/kCTahiULtivSeoqhldEr7ELzMlT
        jfG5l13oGqF+I5Oeq2EY6k6nLcP+CWeLpy8AY1c8Nfg4Ss5WUQA1v9XUj/X/+wkL8jq/C3eqZhJYj
        hoiIwAwOS8dDYv5AchG+VXxl/oMrU771IfhJltvYHZ2Fyd7h+hpIiy+3ilTuT+/qpdaxjTRSy19vg
        VD2j3Nk4TkAG/8ZpPaQJ2yoojBAiT6C4b0HBW54sdloOzBqsuPCBdI7asIb1bFAZuO6En+RvASvkY
        Ghdciz9Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nODSw-007N3w-58; Sun, 27 Feb 2022 06:55:34 +0000
Message-ID: <4bbe337e-8cd8-a4d6-303d-d5aa21bee2e0@infradead.org>
Date:   Sat, 26 Feb 2022 22:55:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mtd: rawnand: omap2: Actually prevent invalid
 configuration and build error
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Roger Quadros <rogerq@kernel.org>
Cc:     miquel.raynal@bootlin.com, krzysztof.kozlowski@canonical.com,
        vigneshr@ti.com, nm@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220220004415.GA1519274@roeck-us.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220220004415.GA1519274@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/22 16:44, Guenter Roeck wrote:
> On Sat, Feb 19, 2022 at 09:36:00PM +0200, Roger Quadros wrote:
>> The root of the problem is that we are selecting symbols that have
>> dependencies. This can cause random configurations that can fail.
>> The cleanest solution is to avoid using select.
>>
>> This driver uses interfaces from the OMAP_GPMC driver so we have to
>> depend on it instead.
>>
>> Fixes: 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid configuration and build error")
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> 
>> ---
>>  drivers/mtd/nand/raw/Kconfig | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>> index 36e697456ec4..9b078e78f3fa 100644
>> --- a/drivers/mtd/nand/raw/Kconfig
>> +++ b/drivers/mtd/nand/raw/Kconfig
>> @@ -42,8 +42,7 @@ config MTD_NAND_OMAP2
>>  	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
>>  	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>>  	depends on HAS_IOMEM
>> -	select MEMORY
>> -	select OMAP_GPMC
>> +	depends on OMAP_GPMC
>>  	help
>>  	  Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
>>  	  and Keystone platforms.
>> -- 
>> 2.17.1
>>

-- 
~Randy
