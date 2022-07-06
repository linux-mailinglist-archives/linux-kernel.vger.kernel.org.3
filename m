Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE79456894D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiGFNVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiGFNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:21:18 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2F75F7B;
        Wed,  6 Jul 2022 06:21:16 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D02993F74A;
        Wed,  6 Jul 2022 15:21:14 +0200 (CEST)
Message-ID: <bab08104-8474-0247-6d64-d6335535c37c@somainline.org>
Date:   Wed, 6 Jul 2022 15:21:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 3/3] clk: qcom: Add IPQ8074 APSS clock controller
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
References: <20220705191017.1683716-1-robimarko@gmail.com>
 <20220705191017.1683716-3-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220705191017.1683716-3-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.07.2022 21:10, Robert Marko wrote:
> IPQ8074 APSS clock controller provides the clock for the IPQ8074 CPU
> cores, thus also providing support for CPU frequency scaling.
> 
> It looks like they are clocked by the XO and a custom APSS type PLL.
> 
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v5:
> * Drop F define as its already defined in clk-rgc.h
> * Correct the driver name to not include commas
> * Correct Christian-s SoB
> * Add MODULE_ALIAS so it gets loaded if built as a module
> 
> Changes in v2:
> * Convert to using parent-data instead of parent-names
> ---
>  drivers/clk/qcom/Kconfig        |  11 +++
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/apss-ipq8074.c | 169 ++++++++++++++++++++++++++++++++
>  3 files changed, 181 insertions(+)
>  create mode 100644 drivers/clk/qcom/apss-ipq8074.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index fc45d00eec42..a3ba541a9dee 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -134,6 +134,17 @@ config IPQ_APSS_6018
>  	  Say Y if you want to support CPU frequency scaling on
>  	  ipq based devices.
>  
> +config IPQ_APSS_8074
> +	tristate "IPQ8074 APSS Clock Controller"
> +	select IPQ_GCC_8074
> +	depends on QCOM_APCS_IPC || COMPILE_TEST
> +	help
> +	  Support for APSS clock controller on IPQ8074 platforms. The
> +	  APSS clock controller manages the Mux and enable block that feeds the
> +	  CPUs.
> +	  Say Y if you want to support CPU frequency scaling on
> +	  IPQ8074 based devices.
> +
>  config IPQ_GCC_4019
>  	tristate "IPQ4019 Global Clock Controller"
>  	help
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 08594230c1c1..226f3b5cefde 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_APQ_MMCC_8084) += mmcc-apq8084.o
>  obj-$(CONFIG_CLK_GFM_LPASS_SM8250) += lpass-gfm-sm8250.o
>  obj-$(CONFIG_IPQ_APSS_PLL) += apss-ipq-pll.o
>  obj-$(CONFIG_IPQ_APSS_6018) += apss-ipq6018.o
> +obj-$(CONFIG_IPQ_APSS_8074) += apss-ipq8074.o
>  obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
>  obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>  obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
> diff --git a/drivers/clk/qcom/apss-ipq8074.c b/drivers/clk/qcom/apss-ipq8074.c
> new file mode 100644
> index 000000000000..36fafa71c4ea
> --- /dev/null
> +++ b/drivers/clk/qcom/apss-ipq8074.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,apss-ipq8074.h>
> +
> +#include "common.h"
> +#include "clk-regmap.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-branch.h"
> +#include "clk-alpha-pll.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +
> +enum {
> +	P_XO,
> +	P_GPLL0,
> +	P_GPLL2,
> +	P_GPLL4,
> +	P_APSS_PLL_EARLY,
> +	P_APSS_PLL
> +};
> +
> +static struct clk_alpha_pll apss_pll_early = {
> +	.offset = 0x5000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_APSS],
> +	.clkr = {
> +		.enable_reg = 0x5000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "apss_pll_early",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.fw_name = "xo", .name = "xo"
Since you're only adding this driver now, no DT uses it an you
should drop the .name lookup.


> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_huayra_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_alpha_pll_postdiv apss_pll = {
> +	.offset = 0x5000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_APSS],
> +	.width = 2,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "apss_pll",
> +		.parent_hws = (const struct clk_hw *[]){
> +			&apss_pll_early.clkr.hw },
> +		.num_parents = 1,
> +		.ops = &clk_alpha_pll_postdiv_ro_ops,
> +	},
> +};
> +
> +static const struct clk_parent_data parents_apcs_alias0_clk_src[] = {
> +	{ .fw_name = "xo", .name = "xo" },
> +	{ .fw_name = "gpll0", .name = "gpll0" },
> +	{ .fw_name = "gpll2", .name = "gpll2" },
> +	{ .fw_name = "gpll4", .name = "gpll4" },
> +	{ .hw = &apss_pll.clkr.hw },
> +	{ .hw = &apss_pll_early.clkr.hw },
> +};
> +
> +static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL0, 4 },
> +	{ P_GPLL2, 2 },
> +	{ P_GPLL4, 1 },
> +	{ P_APSS_PLL, 3 },
> +	{ P_APSS_PLL_EARLY, 5 },
Looks like it only supports frequencies with APSS_PLL_EARLY and XO
as parents? Are all of these other PLLs necessary here?

> +};
> +
> +struct freq_tbl ftbl_apcs_alias0_clk_src[] = {
> +	F(19200000, P_XO, 1, 0, 0),
> +	F(403200000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(806400000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(1017600000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(1382400000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(1651200000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(1843200000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(1920000000, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(2208000000UL, P_APSS_PLL_EARLY, 1, 0, 0),
Every frequency is a div1 and comes from a single clock..
is this correct? This sounds like a simple mux that only
switches between XO and APSS_PLL_EARLY..

> +	{ }
> +};
> +
> +struct clk_rcg2 apcs_alias0_clk_src = {
> +	.cmd_rcgr = 0x0050,
> +	.freq_tbl = ftbl_apcs_alias0_clk_src,
> +	.hid_width = 5,
> +	.parent_map = parents_apcs_alias0_clk_src_map,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "apcs_alias0_clk_src",
> +		.parent_data = parents_apcs_alias0_clk_src,
> +		.num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
> +		.ops = &clk_rcg2_ops,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_branch apcs_alias0_core_clk = {
> +	.halt_reg = 0x0058,
> +	.halt_bit = 31,
> +	.clkr = {
> +		.enable_reg = 0x0058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "apcs_alias0_core_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&apcs_alias0_clk_src.clkr.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT |
> +				CLK_IS_CRITICAL,
This can fit in a single line.

> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_regmap *apss_ipq8074_clks[] = {
> +	[APSS_PLL_EARLY] = &apss_pll_early.clkr,
> +	[APSS_PLL] = &apss_pll.clkr,
> +	[APCS_ALIAS0_CLK_SRC] = &apcs_alias0_clk_src.clkr,
> +	[APCS_ALIAS0_CORE_CLK] = &apcs_alias0_core_clk.clkr,
> +};
> +
> +static const struct regmap_config apss_ipq8074_regmap_config = {
> +	.reg_bits       = 32,
> +	.reg_stride     = 4,
> +	.val_bits       = 32,
> +	.max_register   = 0x5ffc,
> +	.fast_io	= true,
> +};
> +
> +static const struct qcom_cc_desc apss_ipq8074_desc = {
> +	.config = &apss_ipq8074_regmap_config,
> +	.clks = apss_ipq8074_clks,
> +	.num_clks = ARRAY_SIZE(apss_ipq8074_clks),
> +};
> +
> +static int apss_ipq8074_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	return qcom_cc_really_probe(pdev, &apss_ipq8074_desc, regmap);
qcom_cc_probe?

> +}
> +
> +static struct platform_driver apss_ipq8074_driver = {
> +	.probe = apss_ipq8074_probe,
> +	.driver = {
> +		.name   = "qcom-apss-ipq8074-clk",
> +	},
> +};
> +
> +module_platform_driver(apss_ipq8074_driver);
> +
> +MODULE_ALIAS("platform:qcom-apss-ipq8074-clk");
> +MODULE_DESCRIPTION("Qualcomm IPQ8074 APSS clock driver");
> +MODULE_LICENSE("GPL");
"GPL v2"?

Konrad
