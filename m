Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9254C3F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbiBYHhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbiBYHhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:37:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220FDFA23F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:37:05 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nNV9j-0006p5-Rk; Fri, 25 Feb 2022 08:36:47 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nNV9h-0003AS-UF; Fri, 25 Feb 2022 08:36:45 +0100
Date:   Fri, 25 Feb 2022 08:36:45 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        abel.vesa@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 4/5] clk: imx: support fracn gppll
Message-ID: <20220225073645.GA19585@pengutronix.de>
References: <20220225014234.1766305-1-peng.fan@oss.nxp.com>
 <20220225014234.1766305-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225014234.1766305-5-peng.fan@oss.nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:36:19 up 76 days, 16:21, 81 users,  load average: 0.34, 0.19,
 0.13
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

On Fri, Feb 25, 2022 at 09:42:33AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This PLL module is a Fractional-N synthesizer,
> supporting 30-bit numerator and denominator. Numerator is a signed
> number. It has feature to adjust fractional portion of feedback
> divider dynamically. This fracn gppll is used in i.MX93.
> 
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/clk/imx/Makefile          |   1 +
>  drivers/clk/imx/clk-fracn-gppll.c | 324 ++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h             |  21 ++
>  3 files changed, 346 insertions(+)
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
> index 000000000000..57b38147f05a
> --- /dev/null
> +++ b/drivers/clk/imx/clk-fracn-gppll.c
> @@ -0,0 +1,324 @@
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
> +
> +#define PLL_DENOMINATOR		0x50
> +#define PLL_MFD_MASK		GENMASK(29, 0)
> +
> +#define PLL_DIV			0x60
> +#define PLL_MFI_MASK		GENMASK(24, 16)
> +#define PLL_RDIV_MASK		GENMASK(15, 13)
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
> +/*
> + * Fvco = Fref * (MFI + MFN / MFD)
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
> +static inline struct clk_fracn_gppll *to_clk_fracn_gppll(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct clk_fracn_gppll, hw);
> +}
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
> +	/* Assuming rate_table is in descending order */
> +	for (i = 0; i < pll->rate_count; i++)
> +		if (rate >= rate_table[i].rate)
> +			return rate_table[i].rate;
> +
> +	/* return minimum supported value */
> +	return rate_table[pll->rate_count - 1].rate;
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
> +	mfn = FIELD_GET(PLL_MFN_MASK, pll_numerator);
> +
> +	pll_denominator = readl_relaxed(pll->base + PLL_DENOMINATOR);
> +	mfd = FIELD_GET(PLL_MFD_MASK, pll_denominator);
> +
> +	pll_div = readl_relaxed(pll->base + PLL_DIV);
> +	mfi = FIELD_GET(PLL_MFI_MASK, pll_div);
> +
> +	rdiv = FIELD_GET(PLL_RDIV_MASK, pll_div);
> +	rdiv = rdiv + 1;
> +	odiv = FIELD_GET(PLL_ODIV_MASK, pll_div);
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
> +	if (rate)
> +		return (unsigned long)rate;
> +
> +	/* Fvco = Fref * (MFI + MFN / MFD) */
> +	fvco = fvco * mfi * mfd + fvco * mfn;
> +	do_div(fvco, mfd * rdiv * odiv);
> +
> +	return (unsigned long)fvco;
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
> +	writel_relaxed(FIELD_PREP(PLL_MFN_MASK, rate->mfn), pll->base + PLL_NUMERATOR);
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
> +	ana_mfn = readl_relaxed(pll->base + PLL_STATUS);
> +	ana_mfn = FIELD_GET(PLL_MFN_MASK, ana_mfn);
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
