Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A92483536
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiACQ4W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jan 2022 11:56:22 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42373 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiACQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:56:16 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7D4312000C;
        Mon,  3 Jan 2022 16:56:07 +0000 (UTC)
Date:   Mon, 3 Jan 2022 17:56:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-wireless@vger.kernel.org (open list:BROADCOM SPECIFIC AMBA DRIVER
        (BCMA)),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER)
Subject: Re: [PATCH 4/9] mtd: rawnand: brcmnand: Move OF operations out of
 brcmnand_init_cs()
Message-ID: <20220103175606.71a4eb93@xps13>
In-Reply-To: <20211223002225.3738385-5-f.fainelli@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
        <20211223002225.3738385-5-f.fainelli@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

f.fainelli@gmail.com wrote on Wed, 22 Dec 2021 16:22:20 -0800:

> In order to initialize a given chip select object for use by the
> brcmnand driver, move all of the Device Tree specific routines outside
> of brcmnand_init_cs() in order to make it usable in a platform data
> configuration which will be necessary for supporting BCMA chips.

TBH I'm note a big fan of the idea. I'm not sure going back to
supporting platform data this way really is a good idea... There are so
much things that are well described with DT that we now rely upon that
I am not entirely convinced by these changes :-/ The move is generally
in the other direction: getting rid of the legacy platform data.

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Cheers,
Miquèl

> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index 35f8d8e02d4a..60a7f375df83 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -2760,7 +2760,7 @@ static const struct nand_controller_ops brcmnand_controller_ops = {
>  	.attach_chip = brcmnand_attach_chip,
>  };
>  
> -static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
> +static int brcmnand_init_cs(struct brcmnand_host *host)
>  {
>  	struct brcmnand_controller *ctrl = host->ctrl;
>  	struct device *dev = ctrl->dev;
> @@ -2769,16 +2769,9 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
>  	int ret;
>  	u16 cfg_offs;
>  
> -	ret = of_property_read_u32(dn, "reg", &host->cs);
> -	if (ret) {
> -		dev_err(dev, "can't get chip-select\n");
> -		return -ENXIO;
> -	}
> -
>  	mtd = nand_to_mtd(&host->chip);
>  	chip = &host->chip;
>  
> -	nand_set_flash_node(chip, dn);
>  	nand_set_controller_data(chip, host);
>  	mtd->name = devm_kasprintf(dev, GFP_KERNEL, "brcmnand.%d",
>  				   host->cs);
> @@ -3179,7 +3172,16 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
>  			host->pdev = pdev;
>  			host->ctrl = ctrl;
>  
> -			ret = brcmnand_init_cs(host, child);
> +			ret = of_property_read_u32(dn, "reg", &host->cs);
> +			if (ret) {
> +				dev_err(dev, "can't get chip-select\n");
> +				devm_kfree(dev, host);
> +				continue;
> +			}
> +
> +			nand_set_flash_node(&host->chip, dn);
> +
> +			ret = brcmnand_init_cs(host);
>  			if (ret) {
>  				devm_kfree(dev, host);
>  				continue; /* Try all chip-selects */
