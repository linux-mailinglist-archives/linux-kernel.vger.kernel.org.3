Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D8047A832
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhLTLFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:05:23 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:57670
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229866AbhLTLFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:05:21 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C08683FFE5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639998320;
        bh=rfxgFKJr8uFxyqYsEDegaiygwVOsUgBbe3UebWQ+Qqk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jx9H5PQY2TdS4HJWd12NHXKnY1ebvx0i57L+qMpG7xIz/sFUYCDALggAw/tABoZcm
         l38JFUKF5nO6PO7EMsGf211gL/OJOrd/xoHYFfKd0RwOm5Z43TVliCYiuIneCJ+2aS
         7Gv/FDI3G2qXjXAeeBF9pL3drg3p3bDvC76qBRmiq6aGAKvjQfMS1sBjVMOLsGsP8E
         svfr5+SdNfAVhTKr/EOmKzdEI7PGcuQbpvv7YHEHiZGGLy0JZ58XwnkSBAeRf6ZgtP
         O++kLlTLYHsDdy2NhheiRQA438RjPTPOhjrSHCdgK4gB8GwWwuNkOy7UHn2RuuofLd
         yh0/l+ML6CBPA==
Received: by mail-lf1-f71.google.com with SMTP id b4-20020a056512304400b00425cf422539so1252582lfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 03:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rfxgFKJr8uFxyqYsEDegaiygwVOsUgBbe3UebWQ+Qqk=;
        b=tK2JZbQxFxEoT5MhKUtva8YdG/uU3yLQU8XINj0FiMkPRL11oOYxv1ZcqAGV/NXrTY
         k+9dqa4VsQaZaPOSDe56SqoBV+B7BYcHne9UhN9SkGPMCMV38xGyRcQQDSECwydsS9Lk
         naFCKTujK9ZhuL+yxQFhZCfKggytwksqCwS83n3Lsz428wSh7fcTJrBw46cILlzhqE3O
         FtDc/ayCLBDOCUaAdjoIeXEfjNDhcZxSWEfb5WGr9bZukY5FqIqj+Eg5Ja//+8hExJpN
         jLQmw5Z6iTzEDJlZhywBtQbSd9xeoxKqOQ58lGiO3dGrpxNLlx2Q1dPO46meboEpUvSd
         VRbg==
X-Gm-Message-State: AOAM53169DY6jivvNJlKkWCWa+6SKuMSPg9NYg2nHIr2DvmCPD6Tfkd3
        jziQhTpVIdWtBD4c8IRggbV6ae2Oy/owJftUfdKwg63Un1RVhJrgluBBSVbovVuzTm5hXP48s8D
        Z6xt3YqQiksNbB0qAhV9ASHVZDQFveC03ifZ/u/BJdg==
X-Received: by 2002:a05:6512:2116:: with SMTP id q22mr11055860lfr.258.1639998320141;
        Mon, 20 Dec 2021 03:05:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNbc2ruMbmHj+tpQvut9QPgh/PTxOJeTtLsuw8ozg9BYgnJdISEnWmJrdHlhAWA8Lu/NQdsg==
X-Received: by 2002:a05:6512:2116:: with SMTP id q22mr11055845lfr.258.1639998319955;
        Mon, 20 Dec 2021 03:05:19 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id t25sm2475752ljd.24.2021.12.20.03.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 03:05:19 -0800 (PST)
Message-ID: <691a7ace-f18c-157e-88d2-303213aa0ee8@canonical.com>
Date:   Mon, 20 Dec 2021 12:05:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 3/4] memory: omap-gpmc: Use a compatible match table
 when checking for NAND controller
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211217102945.17432-1-rogerq@kernel.org>
 <20211217102945.17432-4-rogerq@kernel.org>
 <88ff0e3e-6709-68fc-88cb-f915dfddbe86@canonical.com>
 <76076ff5-22d9-82d8-ba9e-77755e1ac433@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <76076ff5-22d9-82d8-ba9e-77755e1ac433@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2021 11:53, Roger Quadros wrote:
> 
> 
> On 17/12/2021 17:21, Krzysztof Kozlowski wrote:
>> On 17/12/2021 11:29, Roger Quadros wrote:
>>> As more compatibles can be added to the GPMC NAND controller driver
>>> use a compatible match table.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>> ---
>>>  drivers/memory/omap-gpmc.c                   | 8 +++++++-
>>>  drivers/mtd/nand/raw/omap2.c                 | 2 +-
>>>  include/linux/platform_data/mtd-nand-omap2.h | 5 +++++
>>>  3 files changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
>>> index 624153048182..814ddb45c13d 100644
>>> --- a/drivers/memory/omap-gpmc.c
>>> +++ b/drivers/memory/omap-gpmc.c
>>> @@ -2091,6 +2091,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>>  	u32 val;
>>>  	struct gpio_desc *waitpin_desc = NULL;
>>>  	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
>>> +	bool is_nand = false;
>>>  
>>>  	if (of_property_read_u32(child, "reg", &cs) < 0) {
>>>  		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
>>> @@ -2183,7 +2184,12 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>>  		}
>>>  	}
>>>  
>>> -	if (of_device_is_compatible(child, "ti,omap2-nand")) {
>>> +#if defined(CONFIG_MTD_NAND_OMAP2)
>>
>> if (IS_ENABLED()) is preferred. If needed, you could make omap_nand_ids
>> symbol visible always (so without ifdef around it), because extern
>> structure should not have impact when not defined (if I recall
>> correctly...).
>>
>>> +	if (of_match_node(omap_nand_ids, child))
>>> +		is_nand = true;
>>> +#endif
>>> +
>>> +	if (is_nand) {
>>>  		/* NAND specific setup */
>>>  		val = 8;
>>>  		of_property_read_u32(child, "nand-bus-width", &val);
>>> diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
>>> index b26d4947af02..fff834ee726f 100644
>>> --- a/drivers/mtd/nand/raw/omap2.c
>>> +++ b/drivers/mtd/nand/raw/omap2.c
>>> @@ -2352,7 +2352,7 @@ static int omap_nand_remove(struct platform_device *pdev)
>>>  	return ret;
>>>  }
>>>  
>>> -static const struct of_device_id omap_nand_ids[] = {
>>> +const struct of_device_id omap_nand_ids[] = {
>>>  	{ .compatible = "ti,omap2-nand", },
>>>  	{},
>>>  };
>>
>> I think OMAP2 NAND driver can be a module, so this should have
>> EXPORT_SYMBOL.
> 
> To make it work in all combinations (e.g. omap_gpmc built in and
> nand/raw/omap2.c as module) I had to define omap_nand_ids table as static
> in the linux/platform_data/mtd-nand-omap2.h header.
> 
> EXPORT_SYMBOL will of course be not required there. ;)
> 
Which case exactly does it require to be static in the header?

Best regards,
Krzysztof
