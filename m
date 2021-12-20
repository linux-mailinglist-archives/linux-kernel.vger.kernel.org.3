Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E014D47A901
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhLTLvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:51:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33338 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhLTLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:51:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1A3460FEC;
        Mon, 20 Dec 2021 11:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF3BC36AE8;
        Mon, 20 Dec 2021 11:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640001072;
        bh=kXqeDeBF2OqJFVlF3rFyHi2mcnamomdIOID9swW1Xhk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i8jAdNDb87eQVo060yfrln8TxHsggR9KA1XItN/XFbM8VbL1XHY0TXjPpah+/BiNa
         bADVq8QCR4cin1aKCGy4gfCqlGKtJleH53+rlcU2vGIQTbUghyMnbo0IJNJB8GaIPV
         f20MJlMiHvLvQ7I2EFuIPaDFLOT5JRLJJZc8l9LCC+FY/AsX3P568f3dYuJU5J1cZx
         8kTMlaot7pRBMd1tUloluXC9de583bdgS61aacasKkU85COtT9Q6MjVctT+NBAWk5Q
         gIAkUwAEPkhjrUgdygj2CZgD6sDDBykrd+xjLVaZCa8DT00BR5f/QzIaYtYsPGkOA0
         GG0tawXgUEM6A==
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
 <76076ff5-22d9-82d8-ba9e-77755e1ac433@kernel.org>
 <691a7ace-f18c-157e-88d2-303213aa0ee8@canonical.com>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <645e4b90-c866-d8cf-6a1a-fdcc10278124@kernel.org>
Date:   Mon, 20 Dec 2021 13:51:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <691a7ace-f18c-157e-88d2-303213aa0ee8@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/2021 13:05, Krzysztof Kozlowski wrote:
> On 20/12/2021 11:53, Roger Quadros wrote:
>>
>>
>> On 17/12/2021 17:21, Krzysztof Kozlowski wrote:
>>> On 17/12/2021 11:29, Roger Quadros wrote:
>>>> As more compatibles can be added to the GPMC NAND controller driver
>>>> use a compatible match table.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>> ---
>>>>  drivers/memory/omap-gpmc.c                   | 8 +++++++-
>>>>  drivers/mtd/nand/raw/omap2.c                 | 2 +-
>>>>  include/linux/platform_data/mtd-nand-omap2.h | 5 +++++
>>>>  3 files changed, 13 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
>>>> index 624153048182..814ddb45c13d 100644
>>>> --- a/drivers/memory/omap-gpmc.c
>>>> +++ b/drivers/memory/omap-gpmc.c
>>>> @@ -2091,6 +2091,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>>>  	u32 val;
>>>>  	struct gpio_desc *waitpin_desc = NULL;
>>>>  	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
>>>> +	bool is_nand = false;
>>>>  
>>>>  	if (of_property_read_u32(child, "reg", &cs) < 0) {
>>>>  		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
>>>> @@ -2183,7 +2184,12 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>>>  		}
>>>>  	}
>>>>  
>>>> -	if (of_device_is_compatible(child, "ti,omap2-nand")) {
>>>> +#if defined(CONFIG_MTD_NAND_OMAP2)
>>>
>>> if (IS_ENABLED()) is preferred. If needed, you could make omap_nand_ids
>>> symbol visible always (so without ifdef around it), because extern
>>> structure should not have impact when not defined (if I recall
>>> correctly...).
>>>
>>>> +	if (of_match_node(omap_nand_ids, child))
>>>> +		is_nand = true;
>>>> +#endif
>>>> +
>>>> +	if (is_nand) {
>>>>  		/* NAND specific setup */
>>>>  		val = 8;
>>>>  		of_property_read_u32(child, "nand-bus-width", &val);
>>>> diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
>>>> index b26d4947af02..fff834ee726f 100644
>>>> --- a/drivers/mtd/nand/raw/omap2.c
>>>> +++ b/drivers/mtd/nand/raw/omap2.c
>>>> @@ -2352,7 +2352,7 @@ static int omap_nand_remove(struct platform_device *pdev)
>>>>  	return ret;
>>>>  }
>>>>  
>>>> -static const struct of_device_id omap_nand_ids[] = {
>>>> +const struct of_device_id omap_nand_ids[] = {
>>>>  	{ .compatible = "ti,omap2-nand", },
>>>>  	{},
>>>>  };
>>>
>>> I think OMAP2 NAND driver can be a module, so this should have
>>> EXPORT_SYMBOL.
>>
>> To make it work in all combinations (e.g. omap_gpmc built in and
>> nand/raw/omap2.c as module) I had to define omap_nand_ids table as static
>> in the linux/platform_data/mtd-nand-omap2.h header.
>>
>> EXPORT_SYMBOL will of course be not required there. ;)
>>
> Which case exactly does it require to be static in the header?

Maybe there is a better way to do it.
e.g. If omap_gpmc.c is built-in and nand/raw/omap2.c is not built or built as
a module, what better way we can use?

--
cheers,
-roger
