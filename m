Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508F14A8378
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350382AbiBCMCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:02:05 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:42929 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiBCMCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:02:04 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 79D392222E;
        Thu,  3 Feb 2022 13:02:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643889723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NTKbcBpoiYDkOsEDeKtcGrOMlbvfpxDBPFpxqLdDLUk=;
        b=Gm32dI471/sgaP/AKInSH3IndMBaEUWcOSdGNPjN/nREMDvXC9KGysXp/JPTbVIR8KDNx7
        gHEkgEoi14WBzENrhzmRoFyr6JM7EFZ2rQ9tQIsHIaPTPMnZ8NlfRuUW9sHTtXh1tU7IcE
        6n1eov/X/yMVu7o/RCnemWAlfoHSdPE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Feb 2022 13:02:02 +0100
From:   Michael Walle <michael@walle.cc>
To:     Carl Richard Theodor Schneider <dev.linux@crtified.me>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, microcaicai@gmail.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: spi-nor: Init xtx flash xt25f32b, xt25f128b
In-Reply-To: <20220201002535.2186484-1-dev.linux@crtified.me>
References: <20220201002535.2186484-1-dev.linux@crtified.me>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <28b2114224604fcc673b000e15a9e3cd@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-02-01 01:25, schrieb Carl Richard Theodor Schneider:
> Add the JEDEC identifiers for xt25f32b and xt25f128b.
> Based on the referenced previous patch from microcai.
> 
> Only xt25f32b was verified in hardware (On both Radxa RockPi 4A and 
> 4C),
> but the ID of the xt25f128b can also be found in u-boot patches from
> Armbian.

We require SFDP dumps of new flashes. Therefore, you can only add
flashes which you actually have (and have tested). See [1] how to
provide such a dump.

> Link:
> https://lore.kernel.org/lkml/CAMgqO2y9MYDj6antOaWLBRKU8vGEwqCB-Y1TkXTSWsmsed+W6A@mail.gmail.com/
> Link:
> https://datasheet.lcsc.com/szlcsc/2005251035_XTX-XT25F32BSOIGU-S_C558851.pdf
> Link:
> https://datasheet.lcsc.com/szlcsc/2005251034_XTX-XT25F128BSSIGT_C558844.pdf
> Link:
> https://github.com/armbian/build/blob/master/patch/u-boot/u-boot-rockchip64/general-add-xtx-spi-nor-chips.patch
> 
> Signed-off-by: Carl Richard Theodor Schneider <dev.linux@crtified.me>
> ---
>  drivers/mtd/spi-nor/Makefile |  1 +
>  drivers/mtd/spi-nor/core.c   |  1 +
>  drivers/mtd/spi-nor/core.h   |  1 +
>  drivers/mtd/spi-nor/xtx.c    | 25 +++++++++++++++++++++++++
>  4 files changed, 28 insertions(+)
>  create mode 100644 drivers/mtd/spi-nor/xtx.c
> 
> diff --git a/drivers/mtd/spi-nor/Makefile 
> b/drivers/mtd/spi-nor/Makefile
> index 6b904e439372..e344077e3054 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -17,6 +17,7 @@ spi-nor-objs			+= sst.o
>  spi-nor-objs			+= winbond.o
>  spi-nor-objs			+= xilinx.o
>  spi-nor-objs			+= xmc.o
> +spi-nor-objs			+= xtx.o
>  obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
> 
>  obj-$(CONFIG_MTD_SPI_NOR)	+= controllers/
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 04ea180118e3..44017ab54726 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1846,6 +1846,7 @@ static const struct spi_nor_manufacturer
> *manufacturers[] = {
>  	&spi_nor_winbond,
>  	&spi_nor_xilinx,
>  	&spi_nor_xmc,
> +	&spi_nor_xtx,
>  };
> 
>  static const struct flash_info *
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 2afb610853a9..8adac5da6851 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -536,6 +536,7 @@ extern const struct spi_nor_manufacturer 
> spi_nor_sst;
>  extern const struct spi_nor_manufacturer spi_nor_winbond;
>  extern const struct spi_nor_manufacturer spi_nor_xilinx;
>  extern const struct spi_nor_manufacturer spi_nor_xmc;
> +extern const struct spi_nor_manufacturer spi_nor_xtx;
> 
>  extern const struct attribute_group *spi_nor_sysfs_groups[];
> 
> diff --git a/drivers/mtd/spi-nor/xtx.c b/drivers/mtd/spi-nor/xtx.c
> new file mode 100644
> index 000000000000..2c9028e5d719
> --- /dev/null
> +++ b/drivers/mtd/spi-nor/xtx.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2005, Intec Automation Inc.
> + * Copyright (C) 2014, Freescale Semiconductor, Inc.
> + */

Can this be dropped? I don't think there is any of the
original code left here. no?

> +
> +#include <linux/mtd/spi-nor.h>
> +
> +#include "core.h"
> +
> +static const struct flash_info xtx_parts[] = {
> +	/* XTX (Shenzhen Xin Tian Xia Tech) */
> +	{ "xt25f32b", INFO(0x0b4016, 0, 64 * 1024, 64)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			SPI_NOR_QUAD_READ) },

You'd either need to specify SPI_NOR_SKIP_SFDP or PARSE_SFDP
and drop the NO_SFDP_FLAGS if there is SFDP support.

But more importantly, xtx is missing the continuation bytes
and is probably reusing the manufacturer id from another
vendor. So, this would have to be rebased on Tudors id
collision patchset [2]. There is already support for the
xt25f128b btw.

> +	{ "xt25f128b", INFO(0x0b4018, 0, 64 * 1024, 256)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			SPI_NOR_QUAD_READ) },
> +};
> +
> +const struct spi_nor_manufacturer spi_nor_xtx = {
> +	.name = "xtx",
> +	.parts = xtx_parts,
> +	.nparts = ARRAY_SIZE(xtx_parts),
> +};

[1] 
https://lore.kernel.org/linux-mtd/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
[2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=270725
-- 
-michael
