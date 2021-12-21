Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D6947C7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhLUUBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhLUUBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:01:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E870C061574;
        Tue, 21 Dec 2021 12:01:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ED5EB819B2;
        Tue, 21 Dec 2021 20:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1DFC36AE8;
        Tue, 21 Dec 2021 20:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640116892;
        bh=vJkLjaATflEPsX+S3P13UPpgq8GAW8ytUv0DIV3pq8A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L7NkvhBKk8LWq5KpKKI3MfV/2OUSKilcD0MPAhJFzYbs6WDWSHpy7kTkKsizL2Pux
         9pP7ahSftL8dbC7iGD5Wll8t+Lc5jlA5Hlz22y80o7I+k0NvYf5CjBjYeVcotP56U5
         UiLwWU7Bb0ngLAuOHwiL1DkF+OHC+P4cIozUR3cvQOKl9i9X4gJm9woahhlXUaPQQ/
         nUqeKPIlO1xn5pX1gfGuYd+HIsOib1LRyxeKQOWB1g8C/6p+srbfJo4FWgUccYZTnK
         PBRDqop+reGNUjbTPQfVV7KOzZm0hkadmvw6qfvpPL/P+4SrBGGE4G+mp7X7/LLFlm
         LKlt9tzZMabuQ==
Subject: Re: [PATCH v4 3/4] memory: omap-gpmc: Use a compatible match table
 when checking for NAND controller
To:     krzysztof.kozlowski@canonical.com, miquel.raynal@bootlin.com,
        tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20211221131757.2030-1-rogerq@kernel.org>
 <20211221131757.2030-4-rogerq@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <51b8e895-95e1-0024-1457-ec534985c9f0@kernel.org>
Date:   Tue, 21 Dec 2021 22:01:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221131757.2030-4-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 21/12/2021 15:17, Roger Quadros wrote:
> As more compatibles can be added to the GPMC NAND controller driver
> use a compatible match table.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c                   | 6 +++++-
>  drivers/mtd/nand/raw/omap2.c                 | 5 +----

Will need your Ack for this one as well. Thanks :)


>  include/linux/platform_data/mtd-nand-omap2.h | 9 ++++++++-
>  3 files changed, 14 insertions(+), 6 deletions(-)

cheers,
-roger

> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index 624153048182..d19ffc895e5b 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -2091,6 +2091,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  	u32 val;
>  	struct gpio_desc *waitpin_desc = NULL;
>  	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
> +	bool is_nand = false;
>  
>  	if (of_property_read_u32(child, "reg", &cs) < 0) {
>  		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
> @@ -2183,7 +2184,10 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  		}
>  	}
>  
> -	if (of_device_is_compatible(child, "ti,omap2-nand")) {
> +	if (of_match_node(omap_nand_ids, child))
> +		is_nand = true;
> +
> +	if (is_nand) {
>  		/* NAND specific setup */
>  		val = 8;
>  		of_property_read_u32(child, "nand-bus-width", &val);
> diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
> index b26d4947af02..e6dd8b4cf0d2 100644
> --- a/drivers/mtd/nand/raw/omap2.c
> +++ b/drivers/mtd/nand/raw/omap2.c
> @@ -2352,10 +2352,7 @@ static int omap_nand_remove(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static const struct of_device_id omap_nand_ids[] = {
> -	{ .compatible = "ti,omap2-nand", },
> -	{},
> -};
> +/* omap_nand_ids defined in linux/platform_data/mtd-nand-omap2.h */
>  MODULE_DEVICE_TABLE(of, omap_nand_ids);
>  
>  static struct platform_driver omap_nand_driver = {
> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
> index de6ada739121..92f011805ad4 100644
> --- a/include/linux/platform_data/mtd-nand-omap2.h
> +++ b/include/linux/platform_data/mtd-nand-omap2.h
> @@ -7,6 +7,7 @@
>  #define	_MTD_NAND_OMAP2_H
>  
>  #include <linux/mtd/partitions.h>
> +#include <linux/mod_devicetable.h>
>  
>  #define	GPMC_BCH_NUM_REMAINDER	8
>  
> @@ -61,4 +62,10 @@ struct gpmc_nand_regs {
>  	void __iomem	*gpmc_bch_result5[GPMC_BCH_NUM_REMAINDER];
>  	void __iomem	*gpmc_bch_result6[GPMC_BCH_NUM_REMAINDER];
>  };
> -#endif
> +
> +static const struct of_device_id omap_nand_ids[] = {
> +	{ .compatible = "ti,omap2-nand", },
> +	{},
> +};
> +
> +#endif /* _MTD_NAND_OMAP2_H */
> 
