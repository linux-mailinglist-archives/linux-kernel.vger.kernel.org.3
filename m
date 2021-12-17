Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F6747964E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhLQVdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:33:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37166 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhLQVdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:33:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5226B82AE0;
        Fri, 17 Dec 2021 21:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44082C36AE2;
        Fri, 17 Dec 2021 21:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639776792;
        bh=rhDnjeMzVYpu9f7uhwp02RFYSwBirm1uAXGX5FvyMtA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bxCFhkmoygmiGemAVSIw3IEF22iB0KXDKzqIK7AhLiPoPjGmkSAZicrvTMD4vk74q
         40XIVrSQPwXiEfpg7xGt90/pkCDJTzEw8zGOgTZW98J/P5YWDQaQI+wDA84Gcrjw/X
         0DXL6j1siOokfCrLrXSoXXfYsdd/Whk/ly/OCP80sBTJIOJFWvz55K83rz0dsEp+gN
         ZkK7e/zuNqTJDAw0sYCAGANgffIl8LRrqVD1AZaoP/QBqWrKgzo2AYaqW2xdh2EPvW
         Jq1VEFgfYVcE92qk/tUC2jzUHPtN8eTKoz7EZo6r/h1LVBI3tImVJBnwZJF150Vi/u
         X8pYmLgrxDHJg==
Subject: Re: [PATCH v3 3/4] memory: omap-gpmc: Use a compatible match table
 when checking for NAND controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211217102945.17432-1-rogerq@kernel.org>
 <20211217102945.17432-4-rogerq@kernel.org>
 <88ff0e3e-6709-68fc-88cb-f915dfddbe86@canonical.com>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <81b30647-5ae3-76b6-0317-e6fc16e788ca@kernel.org>
Date:   Fri, 17 Dec 2021 23:33:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <88ff0e3e-6709-68fc-88cb-f915dfddbe86@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/12/2021 17:21, Krzysztof Kozlowski wrote:
> On 17/12/2021 11:29, Roger Quadros wrote:
>> As more compatibles can be added to the GPMC NAND controller driver
>> use a compatible match table.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/memory/omap-gpmc.c                   | 8 +++++++-
>>  drivers/mtd/nand/raw/omap2.c                 | 2 +-
>>  include/linux/platform_data/mtd-nand-omap2.h | 5 +++++
>>  3 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
>> index 624153048182..814ddb45c13d 100644
>> --- a/drivers/memory/omap-gpmc.c
>> +++ b/drivers/memory/omap-gpmc.c
>> @@ -2091,6 +2091,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>  	u32 val;
>>  	struct gpio_desc *waitpin_desc = NULL;
>>  	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
>> +	bool is_nand = false;
>>  
>>  	if (of_property_read_u32(child, "reg", &cs) < 0) {
>>  		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
>> @@ -2183,7 +2184,12 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>  		}
>>  	}
>>  
>> -	if (of_device_is_compatible(child, "ti,omap2-nand")) {
>> +#if defined(CONFIG_MTD_NAND_OMAP2)
> 
> if (IS_ENABLED()) is preferred. If needed, you could make omap_nand_ids
> symbol visible always (so without ifdef around it), because extern
> structure should not have impact when not defined (if I recall
> correctly...).

OK.

> 
>> +	if (of_match_node(omap_nand_ids, child))
>> +		is_nand = true;
>> +#endif
>> +
>> +	if (is_nand) {
>>  		/* NAND specific setup */
>>  		val = 8;
>>  		of_property_read_u32(child, "nand-bus-width", &val);
>> diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
>> index b26d4947af02..fff834ee726f 100644
>> --- a/drivers/mtd/nand/raw/omap2.c
>> +++ b/drivers/mtd/nand/raw/omap2.c
>> @@ -2352,7 +2352,7 @@ static int omap_nand_remove(struct platform_device *pdev)
>>  	return ret;
>>  }
>>  
>> -static const struct of_device_id omap_nand_ids[] = {
>> +const struct of_device_id omap_nand_ids[] = {
>>  	{ .compatible = "ti,omap2-nand", },
>>  	{},
>>  };
> 
> I think OMAP2 NAND driver can be a module, so this should have
> EXPORT_SYMBOL.

Indeed. Good catch!
> 
>> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
>> index de6ada739121..e1bb90a8db03 100644
>> --- a/include/linux/platform_data/mtd-nand-omap2.h
>> +++ b/include/linux/platform_data/mtd-nand-omap2.h
>> @@ -61,4 +61,9 @@ struct gpmc_nand_regs {
>>  	void __iomem	*gpmc_bch_result5[GPMC_BCH_NUM_REMAINDER];
>>  	void __iomem	*gpmc_bch_result6[GPMC_BCH_NUM_REMAINDER];
>>  };
>> +
>> +#if defined(CONFIG_MTD_NAND_OMAP2)
>> +extern const struct of_device_id omap_nand_ids[];
>> +#endif
>> +
>>  #endif
>>
> 
> 
> Best regards,
> Krzysztof
> 

cheers,
-roger
