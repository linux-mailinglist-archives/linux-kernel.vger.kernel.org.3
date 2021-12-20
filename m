Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB60B47A7F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhLTKxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLTKxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:53:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE97FC061574;
        Mon, 20 Dec 2021 02:53:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D19E60F59;
        Mon, 20 Dec 2021 10:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A4AC36AE8;
        Mon, 20 Dec 2021 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639997628;
        bh=4e786f0nM+mUPF/RnX4DJlDxDuErC7twDTA11GFsfkM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c26GdbOJX6ha7RvGLKeMPcY4aT7JoOuGBijU2Gw/DzzBU8A7E7cfqi572C8gz9xw5
         679vtS7a5fuaHz9Ya8ZdGB3fQaXAC/jeNmjPqRlkKslaf6TRHObn+U1PosPQEoWMKn
         FH+xg1ouyr7WTsVTxiih7rHIkQtoiIyNJkof6RKXaWwa8v3fQKeYgOHsn2vcCBK837
         SNgIrYiOPjAhCFk8gYTRCRQfqZWPMkNOUWLUgjP3jUFTTHaz9wIcEK1ZZ7q/d1Bf8D
         YR8CVUZLtRaFq/YJF6QOJkDbmmQVgn8yi4QtVzf8Jjn4u2gdQ6iiwbIaiQbVujyjIS
         yfVcmsXawbshg==
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
Message-ID: <76076ff5-22d9-82d8-ba9e-77755e1ac433@kernel.org>
Date:   Mon, 20 Dec 2021 12:53:44 +0200
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

To make it work in all combinations (e.g. omap_gpmc built in and
nand/raw/omap2.c as module) I had to define omap_nand_ids table as static
in the linux/platform_data/mtd-nand-omap2.h header.

EXPORT_SYMBOL will of course be not required there. ;)

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
