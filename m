Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F2E58FCB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiHKMrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiHKMq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:46:58 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5FF2558F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:46:57 -0700 (PDT)
Received: from [192.168.1.101] (abxh187.neoplus.adsl.tpnet.pl [83.9.1.187])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 103193F64F;
        Thu, 11 Aug 2022 14:46:55 +0200 (CEST)
Message-ID: <3ad241c6-3b94-2c4e-8e17-ba526383cecf@somainline.org>
Date:   Thu, 11 Aug 2022 14:46:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] clk: qcom: Add SC8280XP GPU clock controller
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220811042855.3867774-1-bjorn.andersson@linaro.org>
 <20220811042855.3867774-3-bjorn.andersson@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220811042855.3867774-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.08.2022 06:28, Bjorn Andersson wrote:
> Add driver for the GPU clock controller in the Qualcomm SC8280XP
> platform.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig          |   8 +
>  drivers/clk/qcom/Makefile         |   1 +
>  drivers/clk/qcom/gpucc-sc8280xp.c | 460 ++++++++++++++++++++++++++++++
>  3 files changed, 469 insertions(+)
>  create mode 100644 drivers/clk/qcom/gpucc-sc8280xp.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 7ea5c2208a86..64a9cf245295 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -454,6 +454,14 @@ config SC_GPUCC_7280
>  	  Say Y if you want to support graphics controller devices and
>  	  functionality such as 3D graphics.
>  
> +config SC_GPUCC_8280XP
> +	tristate "SC8280XP Graphics Clock Controller"
> +	select SC_GCC_8280XP
> +	help
> +	  Support for the graphics clock controller on SC8280XP devices.
> +	  Say Y if you want to support graphics controller devices and
> +	  functionality such as 3D graphics.
> +
>  config SC_LPASSCC_7280
>  	tristate "SC7280 Low Power Audio Subsystem (LPASS) Clock Controller"
>  	select SC_GCC_7280
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 4fd88ee7679b..6cdb05152548 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_SC_GCC_8180X) += gcc-sc8180x.o
>  obj-$(CONFIG_SC_GCC_8280XP) += gcc-sc8280xp.o
>  obj-$(CONFIG_SC_GPUCC_7180) += gpucc-sc7180.o
>  obj-$(CONFIG_SC_GPUCC_7280) += gpucc-sc7280.o
> +obj-$(CONFIG_SC_GPUCC_8280XP) += gpucc-sc8280xp.o
>  obj-$(CONFIG_SC_LPASSCC_7280) += lpasscc-sc7280.o
>  obj-$(CONFIG_SC_LPASS_CORECC_7180) += lpasscorecc-sc7180.o
>  obj-$(CONFIG_SC_LPASS_CORECC_7280) += lpasscorecc-sc7280.o lpassaudiocc-sc7280.o
> diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
> new file mode 100644
> index 000000000000..555fd4ff58ab
> --- /dev/null
> +++ b/drivers/clk/qcom/gpucc-sc8280xp.c
> @@ -0,0 +1,460 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,gpucc-sc8280xp.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap-divider.h"
> +#include "common.h"
> +#include "reset.h"
> +#include "gdsc.h"
> +
> +/* Need to match the order of clocks in DT binding */
> +enum {
> +	DT_BI_TCXO,
> +	DT_GCC_GPU_GPLL0_CLK_SRC,
> +	DT_GCC_GPU_GPLL0_DIV_CLK_SRC,
> +};
> +
> +enum {
> +	P_BI_TCXO,
> +	P_GCC_GPU_GPLL0_CLK_SRC,
> +	P_GCC_GPU_GPLL0_DIV_CLK_SRC,
> +	P_GPU_CC_PLL0_OUT_MAIN,
> +	P_GPU_CC_PLL1_OUT_MAIN,
> +};
> +
> +static const struct clk_parent_data parent_data_tcxo = { .index = DT_BI_TCXO };
> +
> +static const struct pll_vco lucid_5lpe_vco[] = {
> +	{ 249600000, 1800000000, 0 },
> +};
> +
> +static struct alpha_pll_config gpu_cc_pll0_config = {
> +	.l = 0x1c,
> +	.alpha = 0xa555,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00002261,
> +	.config_ctl_hi1_val = 0x2a9a699c,
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
> +			.name = "gpu_cc_pll0",
> +			.parent_data = &parent_data_tcxo,
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_5lpe_ops,
> +		},
> +	},
> +};
> +
> +static struct alpha_pll_config gpu_cc_pll1_config = {
> +	.l = 0x1A,
> +	.alpha = 0xAAA,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00002261,
> +	.config_ctl_hi1_val = 0x2A9A699C,
Lowercase hex, please.

Otherwise, this looks nice:

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
