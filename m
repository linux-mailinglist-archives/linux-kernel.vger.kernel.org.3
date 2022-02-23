Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBC04C1086
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiBWKn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbiBWKny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:43:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCAE58E76
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:43:26 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nMp6z-0002iI-GX; Wed, 23 Feb 2022 11:43:09 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nMp6y-00055q-Kh; Wed, 23 Feb 2022 11:43:08 +0100
Date:   Wed, 23 Feb 2022 11:43:08 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        abel.vesa@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 4/5] clk: imx: support fracn gppll
Message-ID: <20220223104308.GI22780@pengutronix.de>
References: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
 <20220223064358.4097307-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220223064358.4097307-5-peng.fan@oss.nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:20:37 up 74 days, 19:06, 87 users,  load average: 0.24, 0.16,
 0.17
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,SUSP_UTF8_WORD_COMBO,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the late review, but this PLL seems to have some copy-pasted
code I just cleaned up in another PLL, so I thought I have a closer
look.


On Wed, Feb 23, 2022 at 02:43:57PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This PLL module is a Fractional-N synthesizer,
> supporting 30-bit numerator and denominator. Numerator is a signed
> number. It has feature to adjust fractional portion of feedback
> divider dynamically. This fracn gppll is used in i.MX93.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/Makefile          |   1 +
>  drivers/clk/imx/clk-fracn-gppll.c | 328 ++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h             |  21 ++
>  3 files changed, 350 insertions(+)
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
> index 000000000000..6c9946a4bdb7
> --- /dev/null
> +++ b/drivers/clk/imx/clk-fracn-gppll.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 NXP
> + */
> +
> +#include <linux/bits.h>
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
> +#define PLL_MFI_SHIFT		16
> +#define PLL_RDIV_MASK		GENMASK(15, 13)
> +#define PLL_RDIV_SHIFT		13
> +#define PLL_ODIV_MASK		GENMASK(7, 0)
> +
> +#define PLL_DFS_CTRL(x)		(0x70 + (x) * 0x10)
> +
> +#define PLL_STATUS		0xF0
> +#define LOCK_STATUS		BIT(0)
> +
> +#define DFS_STATUS		0xF4
> +
> +#define LOCK_TIMEOUT_US		200
> +
> +#define PLL_FRACN_GP(_rate, _mfi, _mfn, _mfd, _rdiv, _odiv)	\
> +	{							\
> +		.rate	=	(_rate),			\
> +		.mfi	=	(_mfi),				\
> +		.mfn	=	(_mfn),				\
> +		.mfd	=	(_mfd),				\
> +		.rdiv	=	(_rdiv),			\
> +		.odiv	=	(_odiv),			\
> +	}
> +
> +struct clk_fracn_gppll {
> +	struct clk_hw			hw;
> +	void __iomem			*base;
> +	const struct imx_fracn_gppll_rate_table *rate_table;
> +	int rate_count;
> +};
> +
> +#define to_clk_fracn_gppll(_hw) container_of(_hw, struct clk_fracn_gppll, hw)

Consider using a static inline function instead.

> +
> +/*
> + * Fvco = 𝐹𝑟𝑒𝑓∙(𝑀𝐹𝐼+𝑀𝐹𝑁/𝑀𝐹𝐷)
> + * Fout = Fvco / (rdiv * odiv)
> + */
> +static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
> +	PLL_FRACN_GP(650000000U, 81, 0, 0, 0, 3),
> +	PLL_FRACN_GP(594000000U, 198, 0, 0, 0, 8),
> +	PLL_FRACN_GP(560000000U, 70, 0, 0, 0, 3),
> +	PLL_FRACN_GP(400000000U, 50, 0, 0, 0, 3),
> +	PLL_FRACN_GP(393216000U, 81, 92, 100, 0, 5)
> +};
> +
> +struct imx_fracn_gppll_clk imx_fracn_gppll = {
> +	.rate_table = fracn_tbl,
> +	.rate_count = ARRAY_SIZE(fracn_tbl),
> +};
> +EXPORT_SYMBOL_GPL(imx_fracn_gppll);
> +
> +static const struct imx_fracn_gppll_rate_table *
> +imx_get_pll_settings(struct clk_fracn_gppll *pll, unsigned long rate)
> +{
> +	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
> +	int i;
> +
> +	for (i = 0; i < pll->rate_count; i++)
> +		if (rate == rate_table[i].rate)
> +			return &rate_table[i];
> +
> +	return NULL;
> +}
> +
> +static long clk_fracn_gppll_round_rate(struct clk_hw *hw, unsigned long rate,
> +				       unsigned long *prate)
> +{
> +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> +	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
> +	int i;
> +
> +	/* Assumming rate_table is in descending order */

s/Assumming/Assuming/

> +	for (i = 0; i < pll->rate_count; i++)
> +		if (rate >= rate_table[i].rate)
> +			return rate_table[i].rate;
> +
> +	if (i == pll->rate_count)

This is always true when you're here,

> +		pr_err("Not able to round rate for %s: %lu\n", clk_hw_get_name(hw), rate);

but this message shouldn't be needed at all. When a rate is passed in
here that is too low then the driver should silently round up to the
lowest supported rate.

> +
> +	/* return minimum supported value */
> +	return rate_table[i - 1].rate;

IMO rate_table[pll->rate_count - 1].rate makes it clearer what is meant
here.

> +}
> +
> +static unsigned long clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> +	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
> +	u32 pll_numerator, pll_denominator, pll_div;
> +	u32 mfi, mfn, mfd, rdiv, odiv;
> +	u64 fvco = parent_rate;
> +	long rate = 0;
> +	int i;
> +
> +	pll_numerator = readl_relaxed(pll->base + PLL_NUMERATOR);
> +	mfn = (pll_numerator & PLL_MFN_MASK) >> PLL_MFN_SHIFT;

Have a look at FIELD_GET/FIELD_PREP, it really makes setting and reading
fields easier and nicer to look at.

> +
> +	pll_denominator = readl_relaxed(pll->base + PLL_DENOMINATOR);
> +	mfd = pll_denominator & PLL_MFD_MASK;
> +
> +	pll_div = readl_relaxed(pll->base + PLL_DIV);
> +	mfi = (pll_div & PLL_MFI_MASK) >> PLL_MFI_SHIFT;
> +
> +	rdiv = (pll_div & PLL_RDIV_MASK) >> PLL_RDIV_SHIFT;
> +	rdiv = rdiv + 1;
> +	odiv = pll_div & PLL_ODIV_MASK;
> +	switch (odiv) {
> +	case 0:
> +		odiv = 2;
> +		break;
> +	case 1:
> +		odiv = 3;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/*
> +	 * Sometimes, the recalculated rate has deviation due to
> +	 * the frac part. So find the accurate pll rate from the table
> +	 * first, if no match rate in the table, use the rate calculated
> +	 * from the equation below.
> +	 */
> +	for (i = 0; i < pll->rate_count; i++) {
> +		if (rate_table[i].mfn == mfn && rate_table[i].mfi == mfi &&
> +		    rate_table[i].mfd == mfd && rate_table[i].rdiv == rdiv &&
> +		    rate_table[i].odiv == odiv)
> +			rate = rate_table[i].rate;
> +	}
> +
> +	/* Fvco = 𝐹𝑟𝑒𝑓∙(𝑀𝐹𝐼+𝑀𝐹𝑁/𝑀𝐹𝐷) */
> +	fvco = fvco * mfi + fvco * mfn / mfd;
> +
> +	do_div(fvco, rdiv * odiv);
> +
> +	return rate ? (unsigned long) rate : (unsigned long)fvco;

You could bail out early here instead of calculating fvco which you then
don't use.

> +}
> +
> +static int clk_fracn_gppll_wait_lock(struct clk_fracn_gppll *pll)
> +{
> +	u32 val;
> +
> +	return readl_poll_timeout(pll->base + PLL_STATUS, val,
> +				  val & LOCK_STATUS, 0, LOCK_TIMEOUT_US);
> +}
> +
> +static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
> +				    unsigned long prate)
> +{
> +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> +	const struct imx_fracn_gppll_rate_table *rate;
> +	u32 tmp, pll_div, ana_mfn;
> +	int ret;
> +
> +	rate = imx_get_pll_settings(pll, drate);
> +	if (!rate) {
> +		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
> +			drate, clk_hw_get_name(hw));
> +		return -EINVAL;
> +	}

The core does a round_rate() before doing a set_rate(), so this should
never happen. I think this can be dropped, in doubt the resulting NULL
pointer deref provides enough developer information to debug this
internal error.

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
> +	pll_div = (rate->rdiv << PLL_RDIV_SHIFT) | rate->odiv | (rate->mfi << PLL_MFI_SHIFT);
> +	writel_relaxed(pll_div, pll->base + PLL_DIV);
> +	writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
> +	writel_relaxed(rate->mfn << PLL_MFN_SHIFT, pll->base + PLL_NUMERATOR);
> +
> +	/* Wait for 5us according to fracn mode pll doc */
> +	udelay(5);
> +
> +	/* Enable Powerup */
> +	tmp |= POWERUP_MASK;
> +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> +
> +	/* Wait Lock*/

Nitpick: Space missing at end of comment.

> +	ret = clk_fracn_gppll_wait_lock(pll);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable output */
> +	tmp |= CLKMUX_EN;
> +	writel_relaxed(tmp, pll->base + PLL_CTRL);
> +
> +	ana_mfn = (readl_relaxed(pll->base + PLL_STATUS) & PLL_MFN_MASK) >> PLL_MFN_SHIFT;
> +
> +	WARN(ana_mfn != rate->mfn, "ana_mfn != rate->mfn\n");
> +
> +	return 0;
> +}
> +
> +static int clk_fracn_gppll_prepare(struct clk_hw *hw)
> +{
> +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> +	u32 val;
> +	int ret;
> +
> +	val = readl_relaxed(pll->base + PLL_CTRL);
> +	if (val & POWERUP_MASK)
> +		return 0;
> +
> +	val |= CLKMUX_BYPASS;
> +	writel_relaxed(val, pll->base + PLL_CTRL);
> +
> +	val |= POWERUP_MASK;
> +	writel_relaxed(val, pll->base + PLL_CTRL);
> +
> +	val |= CLKMUX_EN;
> +	writel_relaxed(val, pll->base + PLL_CTRL);
> +
> +	ret = clk_fracn_gppll_wait_lock(pll);
> +	if (ret)
> +		return ret;
> +
> +	val &= ~CLKMUX_BYPASS;
> +	writel_relaxed(val, pll->base + PLL_CTRL);
> +
> +	return 0;
> +}
> +
> +static int clk_fracn_gppll_is_prepared(struct clk_hw *hw)
> +{
> +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> +	u32 val;
> +
> +	val = readl_relaxed(pll->base + PLL_CTRL);
> +
> +	return (val & POWERUP_MASK) ? 1 : 0;
> +}
> +
> +static void clk_fracn_gppll_unprepare(struct clk_hw *hw)
> +{
> +	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
> +	u32 val;
> +
> +	val = readl_relaxed(pll->base + PLL_CTRL);
> +	val &= ~POWERUP_MASK;
> +	writel_relaxed(val, pll->base + PLL_CTRL);
> +}
> +
> +static const struct clk_ops clk_fracn_gppll_ops = {
> +	.prepare	= clk_fracn_gppll_prepare,
> +	.unprepare	= clk_fracn_gppll_unprepare,
> +	.is_prepared	= clk_fracn_gppll_is_prepared,
> +	.recalc_rate	= clk_fracn_gppll_recalc_rate,
> +	.round_rate	= clk_fracn_gppll_round_rate,
> +	.set_rate	= clk_fracn_gppll_set_rate,
> +};
> +
> +struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
> +				   const struct imx_fracn_gppll_clk *pll_clk)
> +{
> +	struct clk_fracn_gppll *pll;
> +	struct clk_hw *hw;
> +	struct clk_init_data init;
> +	int ret;
> +	u32 val;
> +
> +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.flags = pll_clk->flags;
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +	init.ops = &clk_fracn_gppll_ops;
> +
> +	pll->base = base;
> +	pll->hw.init = &init;
> +	pll->rate_table = pll_clk->rate_table;
> +	pll->rate_count = pll_clk->rate_count;
> +
> +	hw = &pll->hw;
> +
> +	ret = clk_hw_register(NULL, hw);
> +	if (ret) {
> +		pr_err("%s: failed to register pll %s %d\n", __func__, name, ret);
> +		kfree(pll);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return hw;
> +}
> +EXPORT_SYMBOL_GPL(imx_clk_fracn_gppll);
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 63eb7c53b123..a7cbbcd1a3f4 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -72,6 +72,27 @@ extern struct imx_pll14xx_clk imx_1416x_pll;
>  extern struct imx_pll14xx_clk imx_1443x_pll;
>  extern struct imx_pll14xx_clk imx_1443x_dram_pll;
>  
> +/* NOTE: Rate table should be kept sorted in descending order. */
> +struct imx_fracn_gppll_rate_table {
> +	unsigned int rate;
> +	unsigned int mfi;
> +	unsigned int mfn;
> +	unsigned int mfd;
> +	unsigned int rdiv;
> +	unsigned int odiv;
> +};
> +
> +struct imx_fracn_gppll_clk {
> +	const struct imx_fracn_gppll_rate_table *rate_table;
> +	int rate_count;
> +	int flags;
> +};
> +
> +struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
> +				   const struct imx_fracn_gppll_clk *pll_clk);
> +
> +extern struct imx_fracn_gppll_clk imx_fracn_gppll;
> +
>  #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
>  	to_clk(imx_clk_hw_cpu(name, parent_name, div, mux, pll, step))
>  
> -- 
> 2.25.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
