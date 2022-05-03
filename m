Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F43518AF2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbiECRZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbiECRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:25:17 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57B526AC4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:21:41 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id l203so18917346oif.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eMxTqh4AXXw2ToswN6Uz1TAgY1ltPuptr18ff8gyuzo=;
        b=VblqE6I5cLnWrwjEK90jN6cNI06EPDP8Vce2AC7TAd7ITkac2y0FyL6hq0yPq8v9qN
         096Kze9QvPlU+xi4iy8/Ag5YozJbm/CzyEBCUOkoHkHietf7Xkn1Ps2q6UHn7QRINJ1D
         HSTVZbHHK80JRCyJQJrltEm6e5MRJpgE5uSffKlhJ+6Bfomyo103wkmMUJDERnMTy1Jn
         CW1Avx94hjrALhs1Se7axlj0mDbclBZ5hiHQPNrv7tV3I3MHrEnVxDOVdGSZZoNF8aMV
         af7Fch5OsRoIlDeiEVmhSQz616wuwZ17NHsyh74n1M8iIaU/puQO1wKS5YRwJGbZrlQG
         6DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eMxTqh4AXXw2ToswN6Uz1TAgY1ltPuptr18ff8gyuzo=;
        b=zFNgqTfUFPIjblvv60tsV7A0orbqpYYOCDiPvtmMO0fWDs6O2rDVYbju/Aml+fo2SP
         ftn+ocx1vISjhW4ybH63v2Qp5EoZzMlMbvMd1/FKrHfko/eOtFoeksStwWaOINiNggW3
         mFtHJrnRioaRm6uIPWmfwhdsu9+z+X7O+GOtfq8Vzy0/ByUa4msMeNAp12KUYBZ6m9ql
         joj/tXENM1SVxWes8oHwhCEGAKvSgBA1bthRxSTL40nRtTOt6t+E/knuggnNG4aPRKit
         +ZfrLKXG/WDXehkIlf7V2E6HQGyva1dOqO4nO1g7gSYwEsXzz/ZiK8mEbGS4etybD7Yt
         Y8pQ==
X-Gm-Message-State: AOAM533eQDJ5RwGeAx8A74uTD/R0m6JDMpiL8m5KnEo6AMSQuvhxXeIs
        pfx0RcyGdaZ1ybI2TFC65mI6ww==
X-Google-Smtp-Source: ABdhPJzqPPhx3aMeMih9ciqRdpZvx9FTBuv77iNNCwFgTOZX7ddHUs+eq763akrEyOcseCo9tI65pg==
X-Received: by 2002:a05:6808:1897:b0:325:b4b7:379c with SMTP id bi23-20020a056808189700b00325b4b7379cmr2250699oib.210.1651598500470;
        Tue, 03 May 2022 10:21:40 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w6-20020a056870e2c600b000e686d13874sm7032030oad.14.2022.05.03.10.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:21:39 -0700 (PDT)
Date:   Tue, 3 May 2022 12:21:35 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 4/8] clk: qcom: add support for SM8350 GPUCC
Message-ID: <YnFkn3CMS+VdJ9u7@builder.lan>
References: <20220503130448.520470-1-robert.foss@linaro.org>
 <20220503130448.520470-4-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503130448.520470-4-robert.foss@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03 May 08:04 CDT 2022, Robert Foss wrote:

> From: Jonathan Marek <jonathan@marek.ca>
> 
> The GPUCC manages the clocks for the Adreno GPU found on the
> sm8350 SoCs.
> 

If the patch is authored by Jonathan, we need Jonathan's S-o-b as well.

> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
> 
> Changes since v1
>  - Remove .name assignments for clk_parent_data - Dmitry
>  - Use ARRAY_SIZE where possible - Dmitry
>  - Remove commented out code - Dmitry
>  - Set CLAMP_IO flag for gpu_gx_gdsc - Dmitry
>  - Assign .parent_hws instead of .hw - Dmitry
> 
>  drivers/clk/qcom/Kconfig        |   8 +
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/gpucc-sm8350.c | 636 ++++++++++++++++++++++++++++++++
>  3 files changed, 645 insertions(+)
>  create mode 100644 drivers/clk/qcom/gpucc-sm8350.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index e27f37ac2d9c..9b1f54e634b9 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -703,6 +703,14 @@ config SM_GPUCC_8250
>  	  Say Y if you want to support graphics controller devices and
>  	  functionality such as 3D graphics.
>  
> +config SM_GPUCC_8350
> +	tristate "SM8350 Graphics Clock Controller"
> +	select SM_GCC_8350
> +	help
> +	  Support for the graphics clock controller on SM8350 devices.
> +	  Say Y if you want to support graphics controller devices and
> +	  functionality such as 3D graphics.
> +
>  config SM_VIDEOCC_8150
>  	tristate "SM8150 Video Clock Controller"
>  	select SM_GCC_8150
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index dff6aeb980e6..e1b7e49c8da4 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_SM_GCC_8450) += gcc-sm8450.o
>  obj-$(CONFIG_SM_GPUCC_6350) += gpucc-sm6350.o
>  obj-$(CONFIG_SM_GPUCC_8150) += gpucc-sm8150.o
>  obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
> +obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
>  obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
>  obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
>  obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
> diff --git a/drivers/clk/qcom/gpucc-sm8350.c b/drivers/clk/qcom/gpucc-sm8350.c
> new file mode 100644
> index 000000000000..84225bed7a18
> --- /dev/null
> +++ b/drivers/clk/qcom/gpucc-sm8350.c
> @@ -0,0 +1,636 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.

I think we touched this, so please add Copyright Linaro 2022 as well.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,gpucc-sm8350.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "common.h"
> +#include "clk-regmap-mux.h"
> +#include "clk-regmap-divider.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +	P_BI_TCXO,
> +	P_GPLL0_OUT_MAIN,
> +	P_GPLL0_OUT_MAIN_DIV,
> +	P_GPU_CC_PLL0_OUT_MAIN,
> +	P_GPU_CC_PLL1_OUT_MAIN,
> +};
> +
> +static struct pll_vco lucid_5lpe_vco[] = {
> +	{ 249600000, 1750000000, 0 },
> +};
> +
> +static const struct alpha_pll_config gpu_cc_pll0_config = {
> +	.l = 0x18,
> +	.alpha = 0x6000,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00002261,
> +	.config_ctl_hi1_val = 0x2A9A699C,
> +	.test_ctl_val = 0x00000000,
> +	.test_ctl_hi_val = 0x00000000,
> +	.test_ctl_hi1_val = 0x01800000,
> +	.user_ctl_val = 0x00000000,
> +	.user_ctl_hi_val = 0x00000805,
> +	.user_ctl_hi1_val = 0x00000000,
> +};
> +
> +static struct clk_alpha_pll gpu_cc_pll0 = {
> +	.offset = 0x0,
> +	.vco_table = lucid_5lpe_vco,
> +	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data){

This cast can be const as well.

> +			.name = "gpu_cc_pll0",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "bi_tcxo",

It seems suitable to break out the bi_tcxo parent_data and just
reference that.

> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_5lpe_ops,
> +		},
> +	},
> +};
> +
> +static const struct alpha_pll_config gpu_cc_pll1_config = {
> +	.l = 0x1A,
> +	.alpha = 0xAAA,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00002261,
> +	.config_ctl_hi1_val = 0x2A9A699C,
> +	.test_ctl_val = 0x00000000,
> +	.test_ctl_hi_val = 0x00000000,
> +	.test_ctl_hi1_val = 0x01800000,
> +	.user_ctl_val = 0x00000000,
> +	.user_ctl_hi_val = 0x00000805,
> +	.user_ctl_hi1_val = 0x00000000,
> +};
> +
> +static struct clk_alpha_pll gpu_cc_pll1 = {
> +	.offset = 0x100,
> +	.vco_table = lucid_5lpe_vco,
> +	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_pll1",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "bi_tcxo",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_5lpe_ops,
> +		},
> +	},
> +};
> +
> +static const struct parent_map gpu_cc_parent_map_0[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPU_CC_PLL0_OUT_MAIN, 1 },
> +	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
> +	{ P_GPLL0_OUT_MAIN, 5 },
> +	{ P_GPLL0_OUT_MAIN_DIV, 6 },
> +};
> +
> +static const struct clk_parent_data gpu_cc_parent_data_0[] = {
> +	{ .fw_name = "bi_tcxo" },

Let's conclude the discussion with Stephen on how clock drivers should
refer to their incoming clocks. The current suggestion leans towards us
relying on "index" over "fw_name" for new bindings/drivers. I'll let you
know this week!

> +	{ .hw = &gpu_cc_pll0.clkr.hw },
> +	{ .hw = &gpu_cc_pll1.clkr.hw },
> +	{ .fw_name = "gcc_gpu_gpll0_clk_src" },
> +	{ .fw_name = "gcc_gpu_gpll0_div_clk_src" },
> +};
> +
> +static const struct parent_map gpu_cc_parent_map_1[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
> +	{ P_GPLL0_OUT_MAIN, 5 },
> +	{ P_GPLL0_OUT_MAIN_DIV, 6 },
> +};
> +
> +static const struct clk_parent_data gpu_cc_parent_data_1[] = {
> +	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },

The .name here can go, regardless.

> +	{ .hw = &gpu_cc_pll1.clkr.hw },
> +	{ .fw_name = "gcc_gpu_gpll0_clk_src" },
> +	{ .fw_name = "gcc_gpu_gpll0_div_clk_src" },
> +};
> +
> +static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(200000000, P_GPLL0_OUT_MAIN_DIV, 1.5, 0, 0),
> +	F(500000000, P_GPU_CC_PLL1_OUT_MAIN, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gpu_cc_gmu_clk_src = {
> +	.cmd_rcgr = 0x1120,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gpu_cc_parent_map_0,
> +	.freq_tbl = ftbl_gpu_cc_gmu_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpu_cc_gmu_clk_src",
> +		.parent_data = gpu_cc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gpu_cc_hub_clk_src[] = {
> +	F(150000000, P_GPLL0_OUT_MAIN_DIV, 2, 0, 0),
> +	F(240000000, P_GPLL0_OUT_MAIN, 2.5, 0, 0),
> +	F(300000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gpu_cc_hub_clk_src = {
> +	.cmd_rcgr = 0x117c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gpu_cc_parent_map_1,
> +	.freq_tbl = ftbl_gpu_cc_hub_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpu_cc_hub_clk_src",
> +		.parent_data = gpu_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div gpu_cc_hub_ahb_div_clk_src = {
> +	.reg = 0x11c0,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "gpu_cc_hub_ahb_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&gpu_cc_hub_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_regmap_div gpu_cc_hub_cx_int_div_clk_src = {
> +	.reg = 0x11bc,
> +	.shift = 0,
> +	.width = 4,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "gpu_cc_hub_cx_int_div_clk_src",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&gpu_cc_hub_clk_src.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_regmap_div_ro_ops,
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_ahb_clk = {
> +	.halt_reg = 0x1078,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x1078,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gpu_cc_hub_ahb_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cb_clk = {
> +	.halt_reg = 0x1170,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1170,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_crc_ahb_clk = {
> +	.halt_reg = 0x107c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x107c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_crc_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gpu_cc_hub_ahb_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_apb_clk = {
> +	.halt_reg = 0x1088,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1088,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_apb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_gmu_clk = {
> +	.halt_reg = 0x1098,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1098,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_gmu_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gpu_cc_gmu_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_aon_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_qdss_at_clk = {
> +	.halt_reg = 0x1080,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1080,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_qdss_at_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_qdss_trig_clk = {
> +	.halt_reg = 0x1094,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1094,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_qdss_trig_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_qdss_tsctr_clk = {
> +	.halt_reg = 0x1084,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1084,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_qdss_tsctr_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cx_snoc_dvm_clk = {
> +	.halt_reg = 0x108c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x108c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cx_snoc_dvm_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cxo_aon_clk = {
> +	.halt_reg = 0x1004,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cxo_aon_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_cxo_clk = {
> +	.halt_reg = 0x109c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x109c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_cxo_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_freq_measure_clk = {
> +	.halt_reg = 0x120c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x120c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_freq_measure_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_gx_gmu_clk = {
> +	.halt_reg = 0x1064,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1064,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_gx_gmu_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gpu_cc_gmu_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_gx_qdss_tsctr_clk = {
> +	.halt_reg = 0x105c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x105c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_gx_qdss_tsctr_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_gx_vsense_clk = {
> +	.halt_reg = 0x1058,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_gx_vsense_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_hlos1_vote_gpu_smmu_clk = {
> +	.halt_reg = 0x5000,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x5000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_hlos1_vote_gpu_smmu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_hub_aon_clk = {
> +	.halt_reg = 0x1178,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1178,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_hub_aon_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gpu_cc_hub_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_aon_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_hub_cx_int_clk = {
> +	.halt_reg = 0x1204,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1204,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_hub_cx_int_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gpu_cc_hub_cx_int_div_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_aon_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_mnd1x_0_gfx3d_clk = {
> +	.halt_reg = 0x802c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x802c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_mnd1x_0_gfx3d_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_mnd1x_1_gfx3d_clk = {
> +	.halt_reg = 0x8030,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8030,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_mnd1x_1_gfx3d_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gpu_cc_sleep_clk = {
> +	.halt_reg = 0x1090,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x1090,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpu_cc_sleep_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct gdsc gpu_cx_gdsc = {
> +	.gdscr = 0x106c,
> +	.gds_hw_ctrl = 0x1540,
> +	.pd = {
> +		.name = "gpu_cx_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = VOTABLE,
> +};
> +
> +static struct gdsc gpu_gx_gdsc = {
> +	.gdscr = 0x100c,
> +	.clamp_io_ctrl = 0x1508,
> +	.pd = {
> +		.name = "gpu_gx_gdsc",
> +		.power_on = gdsc_gx_do_nothing_enable,
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = CLAMP_IO | AON_RESET | POLL_CFG_GDSCR,
> +};
> +
> +static struct clk_regmap *gpu_cc_sm8350_clocks[] = {
> +	[GPU_CC_AHB_CLK] = &gpu_cc_ahb_clk.clkr,
> +	[GPU_CC_CB_CLK] = &gpu_cc_cb_clk.clkr,
> +	[GPU_CC_CRC_AHB_CLK] = &gpu_cc_crc_ahb_clk.clkr,
> +	[GPU_CC_CX_APB_CLK] = &gpu_cc_cx_apb_clk.clkr,
> +	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
> +	[GPU_CC_CX_QDSS_AT_CLK] = &gpu_cc_cx_qdss_at_clk.clkr,
> +	[GPU_CC_CX_QDSS_TRIG_CLK] = &gpu_cc_cx_qdss_trig_clk.clkr,
> +	[GPU_CC_CX_QDSS_TSCTR_CLK] = &gpu_cc_cx_qdss_tsctr_clk.clkr,
> +	[GPU_CC_CX_SNOC_DVM_CLK] = &gpu_cc_cx_snoc_dvm_clk.clkr,
> +	[GPU_CC_CXO_AON_CLK] = &gpu_cc_cxo_aon_clk.clkr,
> +	[GPU_CC_CXO_CLK] = &gpu_cc_cxo_clk.clkr,
> +	[GPU_CC_FREQ_MEASURE_CLK] = &gpu_cc_freq_measure_clk.clkr,
> +	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
> +	[GPU_CC_GX_GMU_CLK] = &gpu_cc_gx_gmu_clk.clkr,
> +	[GPU_CC_GX_QDSS_TSCTR_CLK] = &gpu_cc_gx_qdss_tsctr_clk.clkr,
> +	[GPU_CC_GX_VSENSE_CLK] = &gpu_cc_gx_vsense_clk.clkr,
> +	[GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK] = &gpu_cc_hlos1_vote_gpu_smmu_clk.clkr,
> +	[GPU_CC_HUB_AHB_DIV_CLK_SRC] = &gpu_cc_hub_ahb_div_clk_src.clkr,
> +	[GPU_CC_HUB_AON_CLK] = &gpu_cc_hub_aon_clk.clkr,
> +	[GPU_CC_HUB_CLK_SRC] = &gpu_cc_hub_clk_src.clkr,
> +	[GPU_CC_HUB_CX_INT_CLK] = &gpu_cc_hub_cx_int_clk.clkr,
> +	[GPU_CC_HUB_CX_INT_DIV_CLK_SRC] = &gpu_cc_hub_cx_int_div_clk_src.clkr,
> +	[GPU_CC_MND1X_0_GFX3D_CLK] = &gpu_cc_mnd1x_0_gfx3d_clk.clkr,
> +	[GPU_CC_MND1X_1_GFX3D_CLK] = &gpu_cc_mnd1x_1_gfx3d_clk.clkr,
> +	[GPU_CC_PLL0] = &gpu_cc_pll0.clkr,
> +	[GPU_CC_PLL1] = &gpu_cc_pll1.clkr,
> +	[GPU_CC_SLEEP_CLK] = &gpu_cc_sleep_clk.clkr,
> +};
> +
> +static const struct qcom_reset_map gpu_cc_sm8350_resets[] = {
> +	[GPUCC_GPU_CC_ACD_BCR] = { 0x1160 },
> +	[GPUCC_GPU_CC_CB_BCR] = { 0x116c },
> +	[GPUCC_GPU_CC_CX_BCR] = { 0x1068 },
> +	[GPUCC_GPU_CC_FAST_HUB_BCR] = { 0x1174 },
> +	[GPUCC_GPU_CC_GFX3D_AON_BCR] = { 0x10a0 },
> +	[GPUCC_GPU_CC_GMU_BCR] = { 0x111c },
> +	[GPUCC_GPU_CC_GX_BCR] = { 0x1008 },
> +	[GPUCC_GPU_CC_XO_BCR] = { 0x1000 },
> +};
> +
> +static struct gdsc *gpu_cc_sm8350_gdscs[] = {
> +	[GPU_CX_GDSC] = &gpu_cx_gdsc,
> +	[GPU_GX_GDSC] = &gpu_gx_gdsc,
> +};
> +
> +static const struct regmap_config gpu_cc_sm8350_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x8030,
> +	.fast_io = true,
> +};
> +
> +static const struct qcom_cc_desc gpu_cc_sm8350_desc = {
> +	.config = &gpu_cc_sm8350_regmap_config,
> +	.clks = gpu_cc_sm8350_clocks,
> +	.num_clks = ARRAY_SIZE(gpu_cc_sm8350_clocks),
> +	.resets = gpu_cc_sm8350_resets,
> +	.num_resets = ARRAY_SIZE(gpu_cc_sm8350_resets),
> +	.gdscs = gpu_cc_sm8350_gdscs,
> +	.num_gdscs = ARRAY_SIZE(gpu_cc_sm8350_gdscs),
> +};
> +
> +static const struct of_device_id gpu_cc_sm8350_match_table[] = {
> +	{ .compatible = "qcom,sm8350-gpucc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gpu_cc_sm8350_match_table);

I like when the of_device_id is down by the platform_driver
definition...

> +
> +static int gpu_cc_sm8350_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = qcom_cc_map(pdev, &gpu_cc_sm8350_desc);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&pdev->dev, "Failed to map gpu cc registers\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	clk_lucid_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
> +	clk_lucid_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
> +
> +	return qcom_cc_really_probe(pdev, &gpu_cc_sm8350_desc, regmap);
> +}
> +
> +static struct platform_driver gpu_cc_sm8350_driver = {
> +	.probe = gpu_cc_sm8350_probe,
> +	.driver = {
> +		.name = "sm8350-gpucc",
> +		.of_match_table = gpu_cc_sm8350_match_table,
> +	},
> +};
> +
> +static int __init gpu_cc_sm8350_init(void)
> +{
> +	return platform_driver_register(&gpu_cc_sm8350_driver);
> +}
> +subsys_initcall(gpu_cc_sm8350_init);

We're in no rush, so module_platform_driver(gpu_cc_sm8350_driver) should
be fine.

Regards,
Bjorn

> +
> +static void __exit gpu_cc_sm8350_exit(void)
> +{
> +	platform_driver_unregister(&gpu_cc_sm8350_driver);
> +}
> +module_exit(gpu_cc_sm8350_exit);
> +
> +MODULE_DESCRIPTION("QTI GPU_CC SM8350 Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.34.1
> 
