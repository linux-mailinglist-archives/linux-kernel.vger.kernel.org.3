Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3675A586C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 02:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiH3A25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 20:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiH3A2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 20:28:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FF671BD6;
        Mon, 29 Aug 2022 17:28:52 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B5251481;
        Tue, 30 Aug 2022 02:28:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661819330;
        bh=zxpH6Sf67WNedZLPAcjgjNZ2TYbZLVZgCYxCvdhwoUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iF05VX7Oqvolo1hoAjFfHNGFA68qZWg36UaCo87MQd9DsPJaIrFHswR1WCZ7q2QHi
         g+lCz6iHDQyhMTiFfpVUeDBxs5IMh04DRI+9jZiu78zzmfsR1CthqFc+fsT/KWkhif
         27HSkzgIkkjT8XqMxjmZO0EBjMVgncmYaGZZ+N9A=
Date:   Tue, 30 Aug 2022 03:28:40 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 3/4] media: platform: Add Renesas RZ/G2L MIPI CSI-2
 receiver driver
Message-ID: <Yw1ZuKevVXRuyE5m@pendragon.ideasonboard.com>
References: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220801214718.16943-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220801214718.16943-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thank you for the patch.

On Mon, Aug 01, 2022 at 10:47:17PM +0100, Lad Prabhakar wrote:
> Add MIPI CSI-2 receiver driver for Renesas RZ/G2L. The MIPI
> CSI-2 is part of the CRU module found on RZ/G2L family.
> 
> Based on a patch in the BSP by Hien Huynh
> <hien.huynh.px@renesas.com>
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC v2 -> v1
> * Fixed initialization sequence of DPHY and link
> * Exported DPHY and link initialization functions so that the
>   CRU core driver can initialize the CRU and CSI2 as per the HW manual.
> 
> RFC v1 -> RFC v2
> * new patch (split up as new driver compared to v1)
> ---
>  drivers/media/platform/renesas/Kconfig        |   1 +
>  drivers/media/platform/renesas/Makefile       |   1 +
>  .../media/platform/renesas/rzg2l-cru/Kconfig  |  17 +
>  .../media/platform/renesas/rzg2l-cru/Makefile |   3 +
>  .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 702 ++++++++++++++++++
>  .../platform/renesas/rzg2l-cru/rzg2l-csi2.h   |  49 ++
>  6 files changed, 773 insertions(+)
>  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Kconfig
>  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Makefile
>  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
>  create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.h
> 
> diff --git a/drivers/media/platform/renesas/Kconfig b/drivers/media/platform/renesas/Kconfig
> index 9fd90672ea2d..ed788e991f74 100644
> --- a/drivers/media/platform/renesas/Kconfig
> +++ b/drivers/media/platform/renesas/Kconfig
> @@ -41,6 +41,7 @@ config VIDEO_SH_VOU
>  	  Support for the Video Output Unit (VOU) on SuperH SoCs.
>  
>  source "drivers/media/platform/renesas/rcar-vin/Kconfig"
> +source "drivers/media/platform/renesas/rzg2l-cru/Kconfig"
>  
>  # Mem2mem drivers
>  
> diff --git a/drivers/media/platform/renesas/Makefile b/drivers/media/platform/renesas/Makefile
> index 3ec226ef5fd2..55854e868887 100644
> --- a/drivers/media/platform/renesas/Makefile
> +++ b/drivers/media/platform/renesas/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  obj-y += rcar-vin/
> +obj-y += rzg2l-cru/
>  obj-y += vsp1/
>  
>  obj-$(CONFIG_VIDEO_RCAR_DRIF) += rcar_drif.o
> diff --git a/drivers/media/platform/renesas/rzg2l-cru/Kconfig b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> new file mode 100644
> index 000000000000..150bf16f167c
> --- /dev/null
> +++ b/drivers/media/platform/renesas/rzg2l-cru/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config VIDEO_RZG2L_CSI2
> +	tristate "RZ/G2L MIPI CSI-2 Receiver"
> +	depends on V4L_PLATFORM_DRIVERS
> +	depends on VIDEO_DEV && OF
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	select MEDIA_CONTROLLER
> +	select VIDEO_V4L2_SUBDEV_API
> +	select RESET_CONTROLLER
> +	select V4L2_FWNODE

Please order these alphabetically.

> +	help
> +	  Support for Renesas RZ/G2L (and alike SoC's) MIPI CSI-2
> +	  Receiver driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called rzg2l-csi2.
> diff --git a/drivers/media/platform/renesas/rzg2l-cru/Makefile b/drivers/media/platform/renesas/rzg2l-cru/Makefile
> new file mode 100644
> index 000000000000..91ea97a944e6
> --- /dev/null
> +++ b/drivers/media/platform/renesas/rzg2l-cru/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_VIDEO_RZG2L_CSI2) += rzg2l-csi2.o
> diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
> new file mode 100644
> index 000000000000..252e33ddb6e8
> --- /dev/null
> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
> @@ -0,0 +1,702 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Renesas RZ/G2L MIPI CSI-2 Receiver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corp.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_graph.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <linux/sys_soc.h>
> +#include <linux/units.h>
> +
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-fwnode.h>
> +#include <media/v4l2-mc.h>
> +#include <media/v4l2-subdev.h>
> +
> +#include "rzg2l-csi2.h"
> +
> +/* LINK registers */
> +/* Module Configuration Register */
> +#define CSI2nMCG			0x0
> +#define CSI2nMCG_SDLN			GENMASK(11, 8)
> +
> +/* Module Control Register 0 */
> +#define CSI2nMCT0			0x10
> +#define CSI2nMCT0_VDLN(x)		((x) << 0)
> +
> +/* Module Control Register 2 */
> +#define CSI2nMCT2			0x18
> +#define CSI2nMCT2_FRRSKW(x)		((x) << 16)
> +#define CSI2nMCT2_FRRCLK(x)		((x) << 0)
> +
> +/* Module Control Register 3 */
> +#define CSI2nMCT3			0x1c
> +#define CSI2nMCT3_RXEN			BIT(0)
> +
> +/* Reset Control Register */
> +#define CSI2nRTCT			0x28
> +#define CSI2nRTCT_VSRST			BIT(0)
> +
> +/* Reset Status Register */
> +#define CSI2nRTST			0x2c
> +#define CSI2nRTST_VSRSTS		BIT(0)
> +
> +/* Receive Data Type Enable Low Register */
> +#define CSI2nDTEL			0x60
> +
> +/* Receive Data Type Enable High Register */
> +#define CSI2nDTEH			0x64
> +
> +/* Power Management Status Register */
> +#define CSI2nPMST			0x200
> +
> +/* Power Management Status Clear Register */
> +#define CSI2nPMSC			0x204
> +
> +/* DPHY registers */
> +/* D-PHY Control Register 0 */
> +#define CSIDPHYCTRL0			0x400
> +#define CSIDPHYCTRL0_EN_LDO1200		BIT(1)
> +#define CSIDPHYCTRL0_EN_BGR		BIT(0)
> +
> +/* D-PHY Timing Register 0 */
> +#define CSIDPHYTIM0			0x404
> +#define CSIDPHYTIM0_TCLK_MISS(x)	((x) << 24)
> +#define CSIDPHYTIM0_T_INIT(x)		((x) << 0)
> +
> +/* D-PHY Timing Register 1 */
> +#define CSIDPHYTIM1			0x408
> +#define CSIDPHYTIM1_THS_PREPARE(x)	((x) << 24)
> +#define CSIDPHYTIM1_TCLK_PREPARE(x)	((x) << 16)
> +#define CSIDPHYTIM1_THS_SETTLE(x)	((x) << 8)
> +#define CSIDPHYTIM1_TCLK_SETTLE(x)	((x) << 0)
> +
> +/* D-PHY Skew Adjustment Function */
> +#define CSIDPHYSKW0			0x460
> +#define CSIDPHYSKW0_UTIL_DL0_SKW_ADJ(x)	((x) & 0x3)
> +#define CSIDPHYSKW0_UTIL_DL1_SKW_ADJ(x)	(((x) & 0x3) << 4)
> +#define CSIDPHYSKW0_UTIL_DL2_SKW_ADJ(x)	(((x) & 0x3) << 8)
> +#define CSIDPHYSKW0_UTIL_DL3_SKW_ADJ(x)	(((x) & 0x3) << 12)
> +#define CSIDPHYSKW0_DEFAULT_SKW		CSIDPHYSKW0_UTIL_DL0_SKW_ADJ(1) | \
> +					CSIDPHYSKW0_UTIL_DL1_SKW_ADJ(1) | \
> +					CSIDPHYSKW0_UTIL_DL2_SKW_ADJ(1) | \
> +					CSIDPHYSKW0_UTIL_DL3_SKW_ADJ(1)
> +
> +#define VSRSTS_RETRIES			20
> +
> +struct timings {

Such a generic name risks creating conflicts later. Could you name the
structure rzg2l_csi2_timings ? Same for the dphy_timings enum.

> +	u32 t_init;
> +	u32 tclk_miss;
> +	u32 tclk_settle;
> +	u32 ths_settle;
> +	u32 tclk_prepare;
> +	u32 ths_prepare;
> +};
> +
> +enum dphy_timings {
> +	TRANSMISSION_RATE_80_MBPS = 0,
> +	TRANSMISSION_RATE_125_MBPS,
> +	TRANSMISSION_RATE_250_MBPS,
> +	TRANSMISSION_RATE_360_MBPS,
> +	TRANSMISSION_RATE_360_PLUS_MBPS,
> +};
> +
> +static const struct timings global_timings[] = {

And there, rzg2l_csi2_global_timings.

> +	[TRANSMISSION_RATE_80_MBPS] = {
> +		.t_init = 79801,
> +		.tclk_miss = 4,
> +		.tclk_settle = 23,
> +		.ths_settle = 31,
> +		.tclk_prepare = 10,
> +		.ths_prepare = 19,
> +	},
> +	[TRANSMISSION_RATE_125_MBPS] = {
> +		.t_init = 79801,
> +		.tclk_miss = 4,
> +		.tclk_settle = 23,
> +		.ths_settle = 28,
> +		.tclk_prepare = 10,
> +		.ths_prepare = 19,
> +	},
> +	[TRANSMISSION_RATE_250_MBPS] = {
> +		.t_init = 79801,
> +		.tclk_miss = 4,
> +		.tclk_settle = 23,
> +		.ths_settle = 22,
> +		.tclk_prepare = 10,
> +		.ths_prepare = 16,
> +	},
> +	[TRANSMISSION_RATE_360_MBPS] = {
> +		.t_init = 79801,
> +		.tclk_miss = 4,
> +		.tclk_settle = 18,
> +		.ths_settle = 19,
> +		.tclk_prepare = 10,
> +		.ths_prepare = 10,
> +	},
> +	[TRANSMISSION_RATE_360_PLUS_MBPS] = {
> +		.t_init = 79801,
> +		.tclk_miss = 4,
> +		.tclk_settle = 18,
> +		.ths_settle = 18,
> +		.tclk_prepare = 10,
> +		.ths_prepare = 10,
> +	},
> +};
> +
> +struct rzg2l_csi2_format {
> +	u32 code;
> +	unsigned int datatype;
> +	unsigned int bpp;
> +};
> +
> +static const struct rzg2l_csi2_format rzg2l_csi2_formats[] = {
> +	{ .code = MEDIA_BUS_FMT_UYVY8_1X16,	.datatype = 0x1e, .bpp = 16 },
> +};
> +
> +static const struct rzg2l_csi2_format *rzg2l_csi2_code_to_fmt(unsigned int code)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(rzg2l_csi2_formats); i++)
> +		if (rzg2l_csi2_formats[i].code == code)
> +			return &rzg2l_csi2_formats[i];
> +
> +	return NULL;
> +}
> +
> +static inline struct rzg2l_csi2 *notifier_to_csi2(struct v4l2_async_notifier *n)
> +{
> +	return container_of(n, struct rzg2l_csi2, notifier);
> +}
> +
> +static u32 rzg2l_csi2_read(struct rzg2l_csi2 *csi2, unsigned int reg)
> +{
> +	return ioread32(csi2->base + reg);
> +}
> +
> +static void rzg2l_csi2_write(struct rzg2l_csi2 *csi2, unsigned int reg,
> +			     u32 data)
> +{
> +	iowrite32(data, csi2->base + reg);
> +}
> +
> +static void rzg2l_csi2_set(struct rzg2l_csi2 *csi2, unsigned int reg, u32 set)
> +{
> +	rzg2l_csi2_write(csi2, reg, rzg2l_csi2_read(csi2, reg) | set);
> +}
> +
> +static void rzg2l_csi2_clr(struct rzg2l_csi2 *csi2, unsigned int reg, u32 clr)
> +{
> +	rzg2l_csi2_write(csi2, reg, rzg2l_csi2_read(csi2, reg) & ~clr);
> +}
> +
> +static int rzg2l_csi2_calc_mbps(struct rzg2l_csi2 *csi2)
> +{
> +	const struct rzg2l_csi2_format *format;
> +	struct v4l2_subdev *source;
> +	struct v4l2_ctrl *ctrl;
> +	u64 mbps;
> +
> +	if (!csi2->remote)
> +		return -ENODEV;

Can this happen, given that the remote field is set in the bound()
handler ?

> +
> +	source = csi2->remote;
> +
> +	/* Read the pixel rate control from remote. */
> +	ctrl = v4l2_ctrl_find(source->ctrl_handler, V4L2_CID_PIXEL_RATE);
> +	if (!ctrl) {
> +		dev_err(csi2->dev, "no pixel rate control in subdev %s\n",
> +			source->name);
> +		return -EINVAL;
> +	}
> +
> +	format = rzg2l_csi2_code_to_fmt(csi2->mf.code);
> +
> +	/*
> +	 * Calculate hsfreq in Mbps
> +	 * hsfreq = (pixel_rate * bits_per_sample) / number_of_lanes
> +	 */
> +	mbps = v4l2_ctrl_g_ctrl_int64(ctrl) * format->bpp;
> +	do_div(mbps, csi2->lanes * 1000000);
> +
> +	return mbps;
> +}
> +
> +int rzg2l_csi2_cmn_rstb_deassert(struct rzg2l_csi2 *csi2)
> +{
> +	return reset_control_deassert(csi2->rstc);
> +}
> +EXPORT_SYMBOL_GPL(rzg2l_csi2_cmn_rstb_deassert);

I don't think you need to export this, or the
rzg2l_csi2_mipi_link_setting() function. They're called by the CRU
driver just before or after calling the .s_stream() operation, so you
can move the calls there.

> +
> +/* -----------------------------------------------------------------------------
> + * DPHY setting
> + */
> +
> +int rzg2l_csi2_dphy_setting(struct rzg2l_csi2 *csi2, bool on)
> +{
> +	int lanes, mbps;
> +
> +	dev_dbg(csi2->dev, "Input size (%ux%u%c)\n",
> +		csi2->mf.width, csi2->mf.height,
> +		csi2->mf.field == V4L2_FIELD_NONE ? 'p' : 'i');
> +
> +	/* Checking the maximum lanes support for CSI-2 module */
> +	lanes = (rzg2l_csi2_read(csi2, CSI2nMCG) & CSI2nMCG_SDLN) >> 8;
> +	if (lanes < csi2->lanes) {
> +		dev_err(csi2->dev,
> +			"Failed to support %d data lanes\n", csi2->lanes);
> +		return -EINVAL;
> +	}

You should read and validate the number of lanes at probe time.

> +
> +	mbps = rzg2l_csi2_calc_mbps(csi2);
> +	if (mbps < 0)
> +		return mbps;
> +
> +	csi2->hsfreq = mbps;

This is only needed in the (on) branch.

> +
> +	if (on) {

The two branches share no code. Split them in two separate functions.

> +		struct timings dphy_timing;

Make this a const pointer.

> +		u32 dphytim0, dphytim1;
> +
> +		/* Set DPHY timing parameters */
> +		if (csi2->hsfreq <= 80)
> +			dphy_timing = global_timings[TRANSMISSION_RATE_80_MBPS];
> +		else if (csi2->hsfreq <= 125)
> +			dphy_timing = global_timings[TRANSMISSION_RATE_125_MBPS];
> +		else if (csi2->hsfreq <= 250)
> +			dphy_timing = global_timings[TRANSMISSION_RATE_250_MBPS];
> +		else if (csi2->hsfreq <= 360)
> +			dphy_timing = global_timings[TRANSMISSION_RATE_360_MBPS];
> +		else if (csi2->hsfreq <= 1500)
> +			dphy_timing = global_timings[TRANSMISSION_RATE_360_PLUS_MBPS];
> +		else
> +			return -EINVAL;
> +
> +		/* Set D-PHY timing parameters */
> +		dphytim0 = CSIDPHYTIM0_TCLK_MISS(dphy_timing.tclk_miss) |
> +			   CSIDPHYTIM0_T_INIT(dphy_timing.t_init);
> +		dphytim1 = CSIDPHYTIM1_THS_PREPARE(dphy_timing.ths_prepare) |
> +			   CSIDPHYTIM1_TCLK_PREPARE(dphy_timing.tclk_prepare) |
> +			   CSIDPHYTIM1_THS_SETTLE(dphy_timing.ths_settle) |
> +			   CSIDPHYTIM1_TCLK_SETTLE(dphy_timing.tclk_settle);
> +		rzg2l_csi2_write(csi2, CSIDPHYTIM0, dphytim0);
> +		rzg2l_csi2_write(csi2, CSIDPHYTIM1, dphytim1);
> +
> +		/* Enable D-PHY power control 0 */
> +		rzg2l_csi2_write(csi2, CSIDPHYSKW0, CSIDPHYSKW0_DEFAULT_SKW);
> +
> +		/* Set the EN_BGR bit */
> +		rzg2l_csi2_set(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_BGR);
> +
> +		/* Delay 20us to be stable */
> +		usleep_range(20, 40);
> +
> +		/* Enable D-PHY power control 1 */
> +		rzg2l_csi2_set(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_LDO1200);
> +
> +		/* Delay 10us to be stable */
> +		usleep_range(10, 20);
> +
> +		/* Start supplying the internal clock for the D-PHY block */
> +		pm_runtime_get_sync(csi2->dev);

Missing error handling (and use pm_runtime_resume_and_get() to make that
easier). But it doesn't seem quite right, you're not supposed to resume
the device after writing register, but before.

> +	} else {
> +		/* Reset the CRU (D-PHY) */
> +		reset_control_assert(csi2->rstc);
> +
> +		/* Stop the D-PHY clock */
> +		pm_runtime_put(csi2->dev);

Same here, that should to after the register writes.

> +
> +		/* Cancel the EN_LDO1200 register setting */
> +		rzg2l_csi2_clr(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_LDO1200);
> +
> +		/* Cancel the EN_BGR register setting */
> +		rzg2l_csi2_clr(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_BGR);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(rzg2l_csi2_dphy_setting);

Would it be a problem to also move this call to .s_stream() to avoid
direct calls from the CRU driver ?

> +
> +void rzg2l_csi2_mipi_link_setting(struct rzg2l_csi2 *csi2, bool on)
> +{
> +	if (on) {

Here too the two branches share no code, split them in two separate
functions.

> +		unsigned long vclk_rate = csi2->vclk_rate / HZ_PER_MHZ;
> +		u32 frrskw, frrclk, frrskw_coeff, frrclk_coeff;
> +
> +		/* Select data lanes */
> +		rzg2l_csi2_write(csi2, CSI2nMCT0, CSI2nMCT0_VDLN(csi2->lanes));
> +
> +		frrskw_coeff = 3 * vclk_rate * 8;
> +		frrclk_coeff = frrskw_coeff / 2;
> +		frrskw = DIV_ROUND_UP(frrskw_coeff, csi2->hsfreq);
> +		frrclk = DIV_ROUND_UP(frrclk_coeff, csi2->hsfreq);
> +		rzg2l_csi2_write(csi2, CSI2nMCT2,
> +				 CSI2nMCT2_FRRSKW(frrskw) | CSI2nMCT2_FRRCLK(frrclk));
> +
> +		/*
> +		 * Select data type.
> +		 * FS, FE, LS, LE, Generic Short Packet Codes 1 to 8,
> +		 * Generic Long Packet Data Types 1 to 4 YUV422 8-bit,
> +		 * RGB565, RGB888, RAW8 to RAW20, User-defined 8-bit
> +		 * data types 1 to 8
> +		 */
> +		rzg2l_csi2_write(csi2, CSI2nDTEL, 0xf778ff0f);
> +		rzg2l_csi2_write(csi2, CSI2nDTEH, 0x00ffff1f);
> +
> +		/* Enable LINK reception */
> +		rzg2l_csi2_set(csi2, CSI2nMCT3, CSI2nMCT3_RXEN);

Would it be an issue to use rzg2l_csi2_write() here ?

> +	} else {
> +		unsigned int timeout = VSRSTS_RETRIES;
> +
> +		/* Stop LINK reception */
> +		rzg2l_csi2_clr(csi2, CSI2nMCT3, CSI2nMCT3_RXEN);

Same here, rzg2l_csi2_write(csi2, CSI2nMCT3, 0);

Same for the other usage of rzg2l_csi2_set() and rzg2l_csi2_clr() above,
to avoid having to read back the value first.

> +
> +		/* Request a software reset of the LINK Video Pixel Interface */
> +		rzg2l_csi2_write(csi2, CSI2nRTCT, CSI2nRTCT_VSRST);
> +
> +		/* Make sure CSI2nRTST.VSRSTS bit is cleared */
> +		while (timeout--) {
> +			if (!(rzg2l_csi2_read(csi2, CSI2nRTST) & CSI2nRTST_VSRSTS))
> +				break;
> +			usleep_range(100, 200);
> +		};
> +	}
> +}
> +EXPORT_SYMBOL_GPL(rzg2l_csi2_mipi_link_setting);
> +
> +static int rzg2l_csi2_s_stream(struct v4l2_subdev *sd, int enable)
> +{
> +	struct rzg2l_csi2 *csi2 = sd_to_csi2(sd);
> +	int ret = 0;
> +
> +	mutex_lock(&csi2->lock);
> +
> +	if (!csi2->remote) {
> +		ret = -ENODEV;
> +		goto out;
> +	}

I don't think this can happen either.

> +
> +	if (enable && !csi2->stream_count) {
> +		ret = v4l2_subdev_call(csi2->remote, video, s_stream, 1);
> +		if (ret)
> +			goto out;
> +	} else if (!enable && csi2->stream_count == 1) {
> +		v4l2_subdev_call(csi2->remote, video, s_stream, 0);
> +	}
> +
> +	csi2->stream_count += enable ? 1 : -1;

Drop stream_count, .s_stream() is not reference-counted.

> +out:
> +	mutex_unlock(&csi2->lock);
> +
> +	return ret;
> +}
> +
> +static int rzg2l_csi2_set_format(struct v4l2_subdev *sd,
> +				 struct v4l2_subdev_state *state,
> +				 struct v4l2_subdev_format *format)
> +{
> +	struct rzg2l_csi2 *csi2 = sd_to_csi2(sd);
> +	struct v4l2_mbus_framefmt *framefmt;
> +
> +	mutex_lock(&csi2->lock);
> +
> +	if (!rzg2l_csi2_code_to_fmt(format->format.code))
> +		format->format.code = rzg2l_csi2_formats[0].code;
> +
> +	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
> +		csi2->mf = format->format;

Please use the subdev active state storage to avoid manually storing the
format. See https://lore.kernel.org/linux-media/20220823005822.13805-3-laurent.pinchart@ideasonboard.com/
and in particular

- How the .get_fmt() and .set_fmt() handlers use
  v4l2_subdev_get_pad_format() unconditionally to get the format,
  regardless of whether it's the active or try format.
- The v4l2_subdev_lock_and_get_active_state() call in .s_stream() to get
  the active state, and access the format from it.
- You're already calling v4l2_subdev_init_finalize() in probe, good :-)

You'll need to implement .init_cfg(), and you'll be able to drop the
lock field in rzg2l_csi2.

> +	} else {
> +		framefmt = v4l2_subdev_get_try_format(sd, state, 0);
> +		*framefmt = format->format;
> +	}
> +
> +	mutex_unlock(&csi2->lock);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_csi2_get_pad_format(struct v4l2_subdev *sd,
> +				     struct v4l2_subdev_state *sd_state,
> +				     struct v4l2_subdev_format *format)
> +{
> +	struct rzg2l_csi2 *csi2 = sd_to_csi2(sd);
> +
> +	mutex_lock(&csi2->lock);
> +	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE)
> +		format->format = csi2->mf;
> +	else
> +		format->format = *v4l2_subdev_get_try_format(sd, sd_state, 0);
> +	mutex_unlock(&csi2->lock);
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_subdev_video_ops rzg2l_csi2_video_ops = {
> +	.s_stream = rzg2l_csi2_s_stream,
> +};
> +
> +static const struct v4l2_subdev_pad_ops rzg2l_csi2_pad_ops = {
> +	.set_fmt = rzg2l_csi2_set_format,
> +	.get_fmt = rzg2l_csi2_get_pad_format,

Missing enum functions for format and sizes, and missing .init_cfg().

> +};
> +
> +static const struct v4l2_subdev_ops rzg2l_csi2_subdev_ops = {
> +	.video	= &rzg2l_csi2_video_ops,
> +	.pad	= &rzg2l_csi2_pad_ops,
> +};
> +
> +/* -----------------------------------------------------------------------------
> + * Async handling and registration of subdevices and links.
> + */
> +
> +static int rzg2l_csi2_notify_bound(struct v4l2_async_notifier *notifier,
> +				   struct v4l2_subdev *subdev,
> +				   struct v4l2_async_subdev *asd)
> +{
> +	struct rzg2l_csi2 *csi2 = notifier_to_csi2(notifier);
> +	int pad;
> +
> +	pad = media_entity_get_fwnode_pad(&subdev->entity, asd->match.fwnode,
> +					  MEDIA_PAD_FL_SOURCE);
> +	if (pad < 0) {
> +		dev_err(csi2->dev, "Failed to find pad for %s\n", subdev->name);
> +		return pad;
> +	}


I think you can skip this and just hardcode pad to RZG2L_CSI2_SINK in
the media_create_pad_link(), there's no other input.

> +
> +	csi2->remote = subdev;
> +
> +	dev_dbg(csi2->dev, "Bound %s pad: %d\n", subdev->name, pad);
> +
> +	return media_create_pad_link(&subdev->entity, pad,
> +				     &csi2->subdev.entity, 0,
> +				     MEDIA_LNK_FL_ENABLED |
> +				     MEDIA_LNK_FL_IMMUTABLE);
> +}
> +
> +static void rzg2l_csi2_notify_unbind(struct v4l2_async_notifier *notifier,
> +				     struct v4l2_subdev *subdev,
> +				     struct v4l2_async_subdev *asd)
> +{
> +	struct rzg2l_csi2 *csi2 = notifier_to_csi2(notifier);
> +
> +	csi2->remote = NULL;
> +
> +	dev_dbg(csi2->dev, "Unbind %s\n", subdev->name);
> +}
> +
> +static const struct v4l2_async_notifier_operations rzg2l_csi2_notify_ops = {
> +	.bound = rzg2l_csi2_notify_bound,
> +	.unbind = rzg2l_csi2_notify_unbind,
> +};
> +
> +static int rzg2l_csi2_parse_v4l2(struct rzg2l_csi2 *csi2,
> +				 struct v4l2_fwnode_endpoint *vep)
> +{
> +	/* Only port 0 endpoint 0 is valid. */
> +	if (vep->base.port || vep->base.id)
> +		return -ENOTCONN;
> +
> +	if (vep->bus_type != V4L2_MBUS_CSI2_DPHY) {
> +		dev_err(csi2->dev, "Unsupported bus: %u\n", vep->bus_type);
> +		return -EINVAL;
> +	}

I'm not sure you need this check as the DT bindings should make it clear
that only CSI-2 sources are valid. Maybe require the bus-type property
in DT ? Up to you.

> +
> +	csi2->lanes = vep->bus.mipi_csi2.num_data_lanes;
> +	if (csi2->lanes != 1 && csi2->lanes != 2 && csi2->lanes != 4) {
> +		dev_err(csi2->dev, "Unsupported number of data-lanes: %u\n",
> +			csi2->lanes);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rzg2l_csi2_parse_dt(struct rzg2l_csi2 *csi2)
> +{
> +	struct v4l2_fwnode_endpoint v4l2_ep = {
> +		.bus_type = V4L2_MBUS_CSI2_DPHY
> +	};
> +	struct v4l2_async_subdev *asd;
> +	struct fwnode_handle *fwnode;
> +	struct fwnode_handle *ep;
> +	int ret;
> +
> +	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(csi2->dev), 0, 0, 0);
> +	if (!ep) {
> +		dev_err(csi2->dev, "Not connected to subdevice\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = v4l2_fwnode_endpoint_parse(ep, &v4l2_ep);
> +	if (ret) {
> +		dev_err(csi2->dev, "Could not parse v4l2 endpoint\n");
> +		fwnode_handle_put(ep);
> +		return -EINVAL;
> +	}
> +
> +	ret = rzg2l_csi2_parse_v4l2(csi2, &v4l2_ep);
> +	if (ret) {
> +		fwnode_handle_put(ep);
> +		return ret;
> +	}
> +
> +	fwnode = fwnode_graph_get_remote_endpoint(ep);
> +	fwnode_handle_put(ep);
> +
> +	dev_dbg(csi2->dev, "Found '%pOF'\n", to_of_node(fwnode));
> +
> +	v4l2_async_nf_init(&csi2->notifier);
> +	csi2->notifier.ops = &rzg2l_csi2_notify_ops;
> +
> +	asd = v4l2_async_nf_add_fwnode(&csi2->notifier, fwnode,
> +				       struct v4l2_async_subdev);
> +	fwnode_handle_put(fwnode);
> +	if (IS_ERR(asd))
> +		return PTR_ERR(asd);
> +
> +	ret = v4l2_async_subdev_nf_register(&csi2->subdev, &csi2->notifier);
> +	if (ret)
> +		v4l2_async_nf_cleanup(&csi2->notifier);
> +
> +	return ret;
> +}
> +
> +/* -----------------------------------------------------------------------------
> + * Platform Device Driver.
> + */
> +
> +static const struct media_entity_operations rzg2l_csi2_entity_ops = {
> +	.link_validate = v4l2_subdev_link_validate,
> +};
> +
> +static int rzg2l_csi2_probe(struct platform_device *pdev)
> +{
> +	struct rzg2l_csi2 *csi2;
> +	struct clk *vclk;
> +	unsigned int i;
> +	int ret;
> +
> +	csi2 = devm_kzalloc(&pdev->dev, sizeof(*csi2), GFP_KERNEL);
> +	if (!csi2)
> +		return -ENOMEM;
> +
> +	csi2->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(csi2->base))
> +		return PTR_ERR(csi2->base);
> +
> +	csi2->rstc = devm_reset_control_get(&pdev->dev, "cmn-rstb");
> +	if (IS_ERR(csi2->rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(csi2->rstc),
> +				     "failed to get cpg cmn-rstb\n");
> +
> +	vclk = devm_clk_get(&pdev->dev, "vclk");
> +	if (IS_ERR(vclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(vclk),
> +				     "failed to get vclk clock\n");
> +
> +	csi2->vclk_rate = clk_get_rate(vclk);
> +	devm_clk_put(&pdev->dev, vclk);

Is there no need to ensure at runtime at the clock is on ?

> +
> +	csi2->dev = &pdev->dev;
> +	mutex_init(&csi2->lock);
> +	csi2->stream_count = 0;
> +
> +	platform_set_drvdata(pdev, csi2);
> +
> +	ret = rzg2l_csi2_parse_dt(csi2);
> +	if (ret)
> +		goto error_mutex;
> +
> +	csi2->subdev.owner = THIS_MODULE;

You don't need this, v4l2_subdev_init() handles it.

> +	csi2->subdev.dev = &pdev->dev;
> +	v4l2_subdev_init(&csi2->subdev, &rzg2l_csi2_subdev_ops);
> +	v4l2_set_subdevdata(&csi2->subdev, &pdev->dev);
> +	snprintf(csi2->subdev.name, V4L2_SUBDEV_NAME_SIZE, "%s %s",

sizeof(csi2->subdev.name) instead of V4L2_SUBDEV_NAME_SIZE, it's less
error-prone.

> +		 KBUILD_MODNAME, dev_name(&pdev->dev));

Don't use KBUILD_MODNAME but set a device name here, for instance use
"csi-%s" as the format string. The subdev name shouldn't change if the
module is renamed.

> +	csi2->subdev.flags = V4L2_SUBDEV_FL_HAS_DEVNODE;
> +
> +	csi2->subdev.entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;

I think MEDIA_ENT_F_VID_IF_BRIDGE would be more appropriate. The pixel
formatter reads or writes pixels from/to memory.

> +	csi2->subdev.entity.ops = &rzg2l_csi2_entity_ops;
> +
> +	csi2->pads[RZG2L_CSI2_SINK].flags = MEDIA_PAD_FL_SINK;
> +	for (i = RZG2L_CSI2_SOURCE_VC0; i < NR_OF_RZG2L_CSI2_PAD; i++)
> +		csi2->pads[i].flags = MEDIA_PAD_FL_SOURCE;

One source pad only. Support for multiple virtual channels should be
implemented using the stream API that is under development (see
https://lore.kernel.org/linux-media/20220810121122.3149086-1-tomi.valkeinen@ideasonboard.com/T/#t).

> +
> +	ret = media_entity_pads_init(&csi2->subdev.entity, NR_OF_RZG2L_CSI2_PAD, csi2->pads);
> +	if (ret)
> +		goto error_async;
> +
> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret = v4l2_subdev_init_finalize(&csi2->subdev);
> +	if (ret < 0)
> +		goto error_pm;
> +
> +	ret = v4l2_async_register_subdev(&csi2->subdev);
> +	if (ret < 0)
> +		goto error_subdev;
> +
> +	dev_info(csi2->dev, "%d lanes found\n", csi2->lanes);
> +
> +	return 0;
> +
> +error_subdev:
> +	v4l2_subdev_cleanup(&csi2->subdev);
> +error_pm:
> +	pm_runtime_disable(&pdev->dev);
> +error_async:
> +	v4l2_async_nf_unregister(&csi2->notifier);
> +	v4l2_async_nf_cleanup(&csi2->notifier);
> +error_mutex:
> +	mutex_destroy(&csi2->lock);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id rzg2l_csi2_of_table[] = {
> +	{ .compatible = "renesas,rzg2l-csi2", },
> +	{ /* sentinel */ }
> +};
> +
> +static int rzg2l_csi2_remove(struct platform_device *pdev)
> +{
> +	struct rzg2l_csi2 *csi2 = platform_get_drvdata(pdev);
> +
> +	v4l2_async_nf_unregister(&csi2->notifier);
> +	v4l2_async_nf_cleanup(&csi2->notifier);
> +	v4l2_async_unregister_subdev(&csi2->subdev);
> +	v4l2_subdev_cleanup(&csi2->subdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	mutex_destroy(&csi2->lock);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver rzg2l_csi2_pdrv = {
> +	.remove	= rzg2l_csi2_remove,
> +	.probe	= rzg2l_csi2_probe,
> +	.driver	= {
> +		.name = "rzg2l-csi2",
> +		.of_match_table = rzg2l_csi2_of_table,
> +	},
> +};
> +
> +module_platform_driver(rzg2l_csi2_pdrv);
> +
> +MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/G2L MIPI CSI2 receiver driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.h b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.h
> new file mode 100644
> index 000000000000..7192923517f6
> --- /dev/null
> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2022 Renesas Electronics Corp.
> + */
> +
> +#ifndef __RZG2L_CSI2__
> +#define __RZG2L_CSI2__
> +
> +enum rzg2l_csi2_pads {
> +	RZG2L_CSI2_SINK = 0,
> +	RZG2L_CSI2_SOURCE_VC0,
> +	RZG2L_CSI2_SOURCE_VC1,
> +	RZG2L_CSI2_SOURCE_VC2,
> +	RZG2L_CSI2_SOURCE_VC3,
> +	NR_OF_RZG2L_CSI2_PAD,
> +};
> +
> +struct rzg2l_csi2 {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct reset_control *rstc;
> +	unsigned long vclk_rate;
> +
> +	struct v4l2_subdev subdev;
> +	struct media_pad pads[NR_OF_RZG2L_CSI2_PAD];
> +
> +	struct v4l2_async_notifier notifier;
> +	struct v4l2_subdev *remote;

You can name this field source (or remote_source, up to you), it will be
more explicit.

> +
> +	struct v4l2_mbus_framefmt mf;
> +
> +	struct mutex lock;
> +	int stream_count;
> +
> +	unsigned short lanes;
> +
> +	unsigned long hsfreq;
> +};
> +
> +static inline struct rzg2l_csi2 *sd_to_csi2(struct v4l2_subdev *sd)
> +{
> +	return container_of(sd, struct rzg2l_csi2, subdev);
> +}
> +
> +int rzg2l_csi2_cmn_rstb_deassert(struct rzg2l_csi2 *csi2);
> +int rzg2l_csi2_dphy_setting(struct rzg2l_csi2 *csi2, bool on);
> +void rzg2l_csi2_mipi_link_setting(struct rzg2l_csi2 *csi2, bool on);
> +
> +#endif

-- 
Regards,

Laurent Pinchart
