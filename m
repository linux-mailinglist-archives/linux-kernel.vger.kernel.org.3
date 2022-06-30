Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A49562660
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiF3XD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiF3XDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:03:24 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EAF1D0CF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:03:20 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-101ab23ff3fso1315853fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2u2YZMhrWv4L5+6h5FH1RGOeqhkvcTZS+V1CddsxjIo=;
        b=x3GdZmsPH5IMBUiN0blLp/kNEOosTbILcQjqZ8+QwRw3a2N30r11giTOZuIYS1Dyg8
         +CaSi6ZyGH+vTIeNYlghgljABhiiQYJ+A5blItCkKOquBh4gy4ifInVOAbO0v0wjxOJj
         Ob58WK4hF3bb9jwBdW4nLREptQ8Qge6y/pCRhJDlQ4iwY07Y5SOnzpFNoYzEoHXM3eUh
         DERJenUq/ZlSV13n/yJv2S9mh1NDdTdgetzGrFPJBBIauiUiV3ANngervyjeb6cinb1J
         1s6zmxQA6+zoHkfPthqyL3Mye5GXIgkrATTblwSGlyaCkKuVJCubuZd0z+VlmU0iEvAj
         Zc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2u2YZMhrWv4L5+6h5FH1RGOeqhkvcTZS+V1CddsxjIo=;
        b=zCU4OJp03yJcGkYo/koZBhujux8oHSoePzzZyoyJ1C0knjk2zSGT4uwrLxpW0+pLe5
         HAHpBBza/ZpeK4UPZZB7JMY5TVD16CyfSEs2vHaWW0T9sLhGZQb+5wqPmcxbtGOF8X8z
         qQNCTJyMxbaLO4rQ6PuNic0BtcVhGsP9I+vE6R1OEC6nu5caXQ22kf2LiCna1Aig3/gU
         VOrIwBpMtXe5vE2ccWCCEuc6qy8veR/JX9QhBPOIgtPpsiOL1QOiLCvgvA0VTCmVWGgn
         YcSadhc4OmDgFk2cq8fXdP5rjUX4p5+83rdAEC8DR+DlhcQKW3HgKAGHvpZQVjBvNcZN
         WgiQ==
X-Gm-Message-State: AJIora+97KXMVe/c4xavJaXlhXmpfU3d9iMxl51GKi6CAgGsN0jQ2N2k
        ELD3n80OqRapdKnP4TLxUIr9Vg==
X-Google-Smtp-Source: AGRyM1vrlUaKev4FDkHS0GD231W6Uh3/BweOthH0zL3I2QqyCz+O0jSDmsurvnetlbz4/0X81SuG0w==
X-Received: by 2002:a05:6870:d10c:b0:102:820:1231 with SMTP id e12-20020a056870d10c00b0010208201231mr7042238oac.122.1656630199504;
        Thu, 30 Jun 2022 16:03:19 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l2-20020a05687040c200b00101fae1b82fsm13805944oal.4.2022.06.30.16.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:03:18 -0700 (PDT)
Date:   Thu, 30 Jun 2022 18:03:17 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Ansuel Smith <ansuelsmth@gmail.com>
Subject: Re: [PATCH v4 3/6] clk: qcom: Add IPQ8074 APSS clock controller
Message-ID: <Yr4rte8Va+TgG9CM@builder.lan>
References: <20220515204540.477711-1-robimarko@gmail.com>
 <20220515204540.477711-3-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220515204540.477711-3-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 15 May 15:45 CDT 2022, Robert Marko wrote:

> IPQ8074 APSS clock controller provides the clock for the IPQ8074 CPU
> cores, thus also providing support for CPU frequency scaling.
> 
> It looks like they are clocked by the XO and a custom APSS type PLL.
> 
> Co-developed-by: Ansuel Smith <ansuelsmth@gmail.com>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v2:
> * Convert to using parent-data instead of parent-names
> ---
>  drivers/clk/qcom/Kconfig        |  11 +++
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/apss-ipq8074.c | 170 ++++++++++++++++++++++++++++++++
>  3 files changed, 182 insertions(+)
>  create mode 100644 drivers/clk/qcom/apss-ipq8074.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 00fe5f066de5..9494eb74374a 100644
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
> index 671cf5821af1..7b2da6dd570c 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_APQ_MMCC_8084) += mmcc-apq8084.o
>  obj-$(CONFIG_CLK_GFM_LPASS_SM8250) += lpass-gfm-sm8250.o
>  obj-$(CONFIG_IPQ_APSS_PLL) += apss-ipq-pll.o
>  obj-$(CONFIG_IPQ_APSS_6018) += apss-ipq6018.o
> +obj-$(CONFIG_IPQ_APSS_8074) += apss-ipq8074.o
>  obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
>  obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>  obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
> diff --git a/drivers/clk/qcom/apss-ipq8074.c b/drivers/clk/qcom/apss-ipq8074.c
> new file mode 100644
> index 000000000000..38d03cd0ff76
> --- /dev/null
> +++ b/drivers/clk/qcom/apss-ipq8074.c
> @@ -0,0 +1,170 @@
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
> +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
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
> +}
> +
> +static struct platform_driver apss_ipq8074_driver = {
> +	.probe = apss_ipq8074_probe,
> +	.driver = {
> +		.name   = "qcom,apss-ipq8074-clk",

As pointed out by Krzysztof, this shouldn't have a ',' in there and if
you look at msm8916 it uses "qcom-apcs-msm8916-clk", so please follow
that.

I don't know if you intend to actually build this as a module, but if
so, wouldn't you also need
MODULE_ALIAS("platform:qcom-apss-ipq8074-clk"); to make module loading
pick this thing up?

Regards,
Bjorn

> +	},
> +};
> +
> +module_platform_driver(apss_ipq8074_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm IPQ8074 APSS clock driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.36.1
> 
