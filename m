Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046C14C28BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiBXJ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiBXJ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:59:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF012D0B2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:59:00 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nNAtb-0001Q8-7W; Thu, 24 Feb 2022 10:58:47 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nNAta-00063u-ID; Thu, 24 Feb 2022 10:58:46 +0100
Date:   Thu, 24 Feb 2022 10:58:46 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        abel.vesa@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 4/5] clk: imx: support fracn gppll
Message-ID: <20220224095846.GT9136@pengutronix.de>
References: <20220224082251.1397754-1-peng.fan@oss.nxp.com>
 <20220224082251.1397754-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224082251.1397754-5-peng.fan@oss.nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:48:59 up 75 days, 18:34, 86 users,  load average: 0.05, 0.27,
 0.29
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:22:50PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This PLL module is a Fractional-N synthesizer,
> supporting 30-bit numerator and denominator. Numerator is a signed
> number. It has feature to adjust fractional portion of feedback
> divider dynamically. This fracn gppll is used in i.MX93.
> 
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/Makefile          |   1 +
>  drivers/clk/imx/clk-fracn-gppll.c | 326 ++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h             |  21 ++
>  3 files changed, 348 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
> 
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 36c04922d789..60c8a4bb7574 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -5,6 +5,7 @@ mxc-clk-objs += clk-busy.o
>  mxc-clk-objs += clk-composite-7ulp.o
>  mxc-clk-objs += clk-composite-8m.o
>  mxc-clk-objs += clk-composite-93.o
> +mxc-clk-objs += clk-fracn-gppll.o
>  mxc-clk-objs += clk-cpu.o
>  mxc-clk-objs += clk-divider-gate.o
>  mxc-clk-objs += clk-fixup-div.o
> diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
> new file mode 100644
> index 000000000000..b6add3a2e472
> --- /dev/null
> +++ b/drivers/clk/imx/clk-fracn-gppll.c
> @@ -0,0 +1,326 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 NXP
> + */
> +
> +#include <asm/div64.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +
> +#include "clk.h"
> +
> +#define PLL_CTRL		0x0
> +#define CLKMUX_BYPASS		BIT(2)
> +#define CLKMUX_EN		BIT(1)
> +#define POWERUP_MASK		BIT(0)
> +
> +#define PLL_ANA_PRG		0x10
> +#define PLL_SPREAD_SPECTRUM	0x30
> +
> +#define PLL_NUMERATOR		0x40
> +#define PLL_MFN_MASK		GENMASK(31, 2)
> +#define PLL_MFN_SHIFT		2
> +
> +#define PLL_DENOMINATOR		0x50
> +#define PLL_MFD_MASK		GENMASK(29, 0)
> +
> +#define PLL_DIV			0x60
> +#define PLL_MFI_MASK		GENMASK(24, 16)

Is the MFI field really 9 bits wide? Could be, I don't have the
reference manual. It just looks like it could be a one-off.

> +#define PLL_MFI_SHIFT		16
> +#define PLL_RDIV_MASK		GENMASK(15, 13)
> +#define PLL_RDIV_SHIFT		13
> +#define PLL_ODIV_MASK		GENMASK(7, 0)

The *_SHIFT defines can be removed.

> +static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
> +				    unsigned long prate)
> +{
> +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> +	const struct imx_fracn_gppll_rate_table *rate;
> +	u32 tmp, pll_div, ana_mfn;
> +	int ret;
> +
> +	rate = imx_get_pll_settings(pll, drate);
> +
> +	/* Disable output */
> +	tmp = readl_relaxed(pll->base + PLL_CTRL);
> +	tmp &= ~CLKMUX_EN;
> +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> +
> +	/* Power Down */
> +	tmp &= ~POWERUP_MASK;
> +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> +
> +	/* Disable BYPASS */
> +	tmp &= ~CLKMUX_BYPASS;
> +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> +
> +	pll_div = FIELD_PREP(PLL_RDIV_MASK, rate->rdiv) | rate->odiv |
> +		FIELD_PREP(PLL_MFI_MASK, rate->mfi);
> +	writel_relaxed(pll_div, pll->base + PLL_DIV);
> +	writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
> +	writel_relaxed(rate->mfn << PLL_MFN_SHIFT, pll->base + PLL_NUMERATOR);

FIELD_PREP

> +
> +	/* Wait for 5us according to fracn mode pll doc */
> +	udelay(5);
> +
> +	/* Enable Powerup */
> +	tmp |= POWERUP_MASK;
> +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> +
> +	/* Wait Lock */
> +	ret = clk_fracn_gppll_wait_lock(pll);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable output */
> +	tmp |= CLKMUX_EN;
> +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> +
> +	ana_mfn = (readl_relaxed(pll->base + PLL_STATUS) & PLL_MFN_MASK) >> PLL_MFN_SHIFT;

FIELD_GET

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
