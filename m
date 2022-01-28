Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E65449F870
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbiA1Lkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbiA1Lkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:40:42 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD123C061714;
        Fri, 28 Jan 2022 03:40:41 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 17EA760008;
        Fri, 28 Jan 2022 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643370040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQ1me8J/Zy0/NpDBsjxiNJCRMDYVYBgfgf4KXYlMBQE=;
        b=mhkRrkTFQg/3TwqlXdkqBpBcXYqooijDEC2Kv+kedQOmu14iMZ3uqYYp7BiMJpKHPzO7iy
        K64mkM4MAc2MJ7OVlGPAgcqvyNzthsTgD/NKZuOl7ELRyABV+8rc8HwoIbzZmAtRAuWGg+
        fzwgwjlFGo6ML3GP5Mj3WTlewRxkK7vgDTYSnmuUQ8OA+C5eK0WJSiW0qjzuSdhgMtfPC0
        8FQsAx5DK5K0oJiMV2V1Tq1YhS+iDXdMMvRuwx48thJ7g0dGuFvVEItgQzpadG/4q3RABR
        FvkCkJISCwUQzpok9OZsWFy77buG+yRQap9aK4cOeMt6MKRMAkLsFcmMpngpDg==
Date:   Fri, 28 Jan 2022 12:40:36 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: rawnand: meson: discard the common MMC sub
 clock framework
Message-ID: <20220128124036.25fe0539@xps13>
In-Reply-To: <20220128113237.39996-2-liang.yang@amlogic.com>
References: <20220128113237.39996-1-liang.yang@amlogic.com>
        <20220128113237.39996-2-liang.yang@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

liang.yang@amlogic.com wrote on Fri, 28 Jan 2022 19:32:36 +0800:

> EMMC and NAND has the same clock control register named 'SD_EMMC_CLOCK' w=
hich is

have

> defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is the divider=
 and
> bit6~7 is the mux for fix pll and xtal.

> Previously a common MMC sub clock framework is implemented and shared by =
EMMC and

I believe you meant that this hasa already been contributed? I would
then rephrase with:

A common MMC and NAND sub-clock has been implemented and can be used by
the eMMC and NAND controller (which are mutually exclusive anyway).

Let's use this new clock.

> NAND, but that is coupling the EMMC and NAND, although EMMC and NAND is m=
utually
> exclusive.
>=20
> Change-Id: Ibeb4c7ff886f5886aac4d6c664d7bbd1b1bcb997

No change Ids.

> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 161 +++++++++++++++++-------------
>  1 file changed, 89 insertions(+), 72 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index ac3be92872d0..f6a3d5c2ea1c 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -2,7 +2,7 @@
>  /*
>   * Amlogic Meson Nand Flash Controller Driver
>   *
> - * Copyright (c) 2018 Amlogic, inc.
> + * Copyright (c) 2018-2021 Amlogic, inc.

Please don't.

>   * Author: Liang Yang <liang.yang@amlogic.com>
>   */
> =20
> @@ -10,6 +10,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mfd/syscon.h>
> @@ -19,6 +20,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_address.h>
>  #include <linux/sched/task_stack.h>
> =20
>  #define NFC_REG_CMD		0x00
> @@ -104,6 +106,9 @@
> =20
>  #define PER_INFO_BYTE		8
> =20
> +#define CLK_DIV_SHIFT		0
> +#define CLK_DIV_WIDTH		6
> +
>  struct meson_nfc_nand_chip {
>  	struct list_head node;
>  	struct nand_chip nand;
> @@ -151,15 +156,17 @@ struct meson_nfc {
>  	struct nand_controller controller;
>  	struct clk *core_clk;
>  	struct clk *device_clk;
> -	struct clk *phase_tx;
> -	struct clk *phase_rx;
> +	struct clk *nand_clk;
> +	struct clk_divider nand_divider;
> =20
>  	unsigned long clk_rate;
>  	u32 bus_timing;
> =20
>  	struct device *dev;
> -	void __iomem *reg_base;
> -	struct regmap *reg_clk;
> +	struct {
> +		void __iomem *reg_base;
> +		void __iomem *sd_emmc_clock;
> +	} res;

Please split your commit: first the mechanical changes, then the use of
the new area or something like that.

Otherwise there are too many lines changed, I can't spot where it is
interesting.

Thanks,
Miqu=C3=A8l
