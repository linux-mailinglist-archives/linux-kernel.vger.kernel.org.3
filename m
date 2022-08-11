Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939AE58FCAC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiHKMpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiHKMpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:45:11 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDFD8983F;
        Thu, 11 Aug 2022 05:45:08 -0700 (PDT)
Received: from [192.168.1.101] (abxh187.neoplus.adsl.tpnet.pl [83.9.1.187])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id EC7893F4E9;
        Thu, 11 Aug 2022 14:45:04 +0200 (CEST)
Message-ID: <524afba8-2644-a255-1319-69cbfc14bbf5@somainline.org>
Date:   Thu, 11 Aug 2022 14:45:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] clk: qcom: Add SC8280XP display clock controller
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220811041211.3825786-1-bjorn.andersson@linaro.org>
 <20220811041211.3825786-3-bjorn.andersson@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220811041211.3825786-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.08.2022 06:12, Bjorn Andersson wrote:
> The Qualcomm SC8280XP platform has two display clock controller
> instances, add support for these. Duplication between the two
> implementations is reduced by reusing any constant data between the two
> sets of clock data.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig           |    9 +
>  drivers/clk/qcom/Makefile          |    1 +
>  drivers/clk/qcom/dispcc-sc8280xp.c | 3218 ++++++++++++++++++++++++++++
>  3 files changed, 3228 insertions(+)
>  create mode 100644 drivers/clk/qcom/dispcc-sc8280xp.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 1cf1ef70e347..7ea5c2208a86 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -393,6 +393,15 @@ config SC_DISPCC_7280
>  	  Say Y if you want to support display devices and functionality such as
>  	  splash screen.
>  
> +config SC_DISPCC_8280XP
> +	tristate "SC8280XP Display Clock Controller"
> +	select SC_GCC_8280XP
> +	help
> +	  Support for the two display clock controllers on Qualcomm
> +	  Technologies, Inc. SC8280XP devices.
> +	  Say Y if you want to support display devices and functionality such as
> +	  splash screen.
> +
>  config SC_GCC_7180
>  	tristate "SC7180 Global Clock Controller"
>  	select QCOM_GDSC
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index fbcf04073f07..4fd88ee7679b 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_SC_CAMCC_7180) += camcc-sc7180.o
>  obj-$(CONFIG_SC_CAMCC_7280) += camcc-sc7280.o
>  obj-$(CONFIG_SC_DISPCC_7180) += dispcc-sc7180.o
>  obj-$(CONFIG_SC_DISPCC_7280) += dispcc-sc7280.o
> +obj-$(CONFIG_SC_DISPCC_8280XP) += dispcc-sc8280xp.o
>  obj-$(CONFIG_SC_GCC_7180) += gcc-sc7180.o
>  obj-$(CONFIG_SC_GCC_7280) += gcc-sc7280.o
>  obj-$(CONFIG_SC_GCC_8180X) += gcc-sc8180x.o
> diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
> new file mode 100644
> index 000000000000..78f47db197aa
> --- /dev/null
> +++ b/drivers/clk/qcom/dispcc-sc8280xp.c
> @@ -0,0 +1,3218 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Ltd.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/pm_clock.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap-divider.h"
> +#include "common.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +/* Need to match the order of clocks in DT binding */
> +enum {
> +	DT_IFACE,
> +	DT_BI_TCXO,
> +	DT_SLEEP_CLK,
> +	DT_DP0_PHY_PLL_LINK_CLK,
> +	DT_DP0_PHY_PLL_VCO_DIV_CLK,
> +	DT_DP1_PHY_PLL_LINK_CLK,
> +	DT_DP1_PHY_PLL_VCO_DIV_CLK,
> +	DT_DP2_PHY_PLL_LINK_CLK,
> +	DT_DP2_PHY_PLL_VCO_DIV_CLK,
> +	DT_DP3_PHY_PLL_LINK_CLK,
> +	DT_DP3_PHY_PLL_VCO_DIV_CLK,
> +	DT_DSI0_PHY_PLL_OUT_BYTECLK,
> +	DT_DSI0_PHY_PLL_OUT_DSICLK,
> +	DT_DSI1_PHY_PLL_OUT_BYTECLK,
> +	DT_DSI1_PHY_PLL_OUT_DSICLK,
> +};
> +
> +enum {
> +	P_BI_TCXO,
> +	P_DP0_PHY_PLL_LINK_CLK,
> +	P_DP0_PHY_PLL_VCO_DIV_CLK,
> +	P_DP1_PHY_PLL_LINK_CLK,
> +	P_DP1_PHY_PLL_VCO_DIV_CLK,
> +	P_DP2_PHY_PLL_LINK_CLK,
> +	P_DP2_PHY_PLL_VCO_DIV_CLK,
> +	P_DP3_PHY_PLL_LINK_CLK,
> +	P_DP3_PHY_PLL_VCO_DIV_CLK,
> +	P_DSI0_PHY_PLL_OUT_BYTECLK,
> +	P_DSI0_PHY_PLL_OUT_DSICLK,
> +	P_DSI1_PHY_PLL_OUT_BYTECLK,
> +	P_DSI1_PHY_PLL_OUT_DSICLK,
> +	P_DISPn_CC_PLL0_OUT_MAIN,
> +	P_DISPn_CC_PLL1_OUT_EVEN,
> +	P_DISPn_CC_PLL1_OUT_MAIN,
> +	P_DISPn_CC_PLL2_OUT_MAIN,
> +	P_SLEEP_CLK,
> +};
> +
> +static const struct clk_parent_data parent_data_tcxo = { .index = DT_BI_TCXO };
> +
> +static const struct pll_vco lucid_5lpe_vco[] = {
> +	{ 249600000, 1800000000, 0 },
> +};
> +
> +static const struct alpha_pll_config disp_cc_pll0_config = {
> +	.l = 0x4E,
> +	.alpha = 0x2000,
> +	.config_ctl_val = 0x20485699,
> +	.config_ctl_hi_val = 0x00002261,
> +	.config_ctl_hi1_val = 0x2A9A699C,
Lowercase hex throughout the file, please.

> +	.test_ctl_val = 0x00000000,
> +	.test_ctl_hi_val = 0x00000000,
> +	.test_ctl_hi1_val = 0x01800000,
> +	.user_ctl_val = 0x00000000,
> +	.user_ctl_hi_val = 0x00000805,
> +	.user_ctl_hi1_val = 0x00000000,
> +};
> +

[...]

> +
> +#define clkr_to_alpha_clk_pll(_clkr) container_of(_clkr, struct clk_alpha_pll, clkr)
> +
> +static int disp_cc_sc8280xp_probe(struct platform_device *pdev)
> +{
> +	const struct qcom_cc_desc *desc;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	desc = device_get_match_data(&pdev->dev);
> +
> +	ret = devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pm_clk_create(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_clk_add(&pdev->dev, NULL);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to acquire ahb clock\n");
> +		return ret;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	regmap = qcom_cc_map(pdev, desc);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		goto out_pm_runtime_put;
> +	}
> +
> +	clk_lucid_pll_configure(clkr_to_alpha_clk_pll(desc->clks[DISP_CC_PLL0]), regmap, &disp_cc_pll0_config);
> +	clk_lucid_pll_configure(clkr_to_alpha_clk_pll(desc->clks[DISP_CC_PLL1]), regmap, &disp_cc_pll1_config);
> +	clk_lucid_pll_configure(clkr_to_alpha_clk_pll(desc->clks[DISP_CC_PLL2]), regmap, &disp_cc_pll2_config);
> +
> +	ret = qcom_cc_really_probe(pdev, desc, regmap);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register DISP CC 0 clocks\n");
This is not always dispcc0.

Konrad
> +		goto out_pm_runtime_put;
> +	}
> +
> +	/* DISP_CC_XO_CLK always-on */
> +	regmap_update_bits(regmap, 0x605c, BIT(0), BIT(0));
> +
> +out_pm_runtime_put:
> +	pm_runtime_put_sync(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id disp_cc_sc8280xp_match_table[] = {
> +	{ .compatible = "qcom,sc8280xp-dispcc0", .data = &disp0_cc_sc8280xp_desc },
> +	{ .compatible = "qcom,sc8280xp-dispcc1", .data = &disp1_cc_sc8280xp_desc },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, disp_cc_sc8280xp_match_table);
> +
> +static struct platform_driver disp_cc_sc8280xp_driver = {
> +	.probe = disp_cc_sc8280xp_probe,
> +	.driver = {
> +		.name = "disp_cc-sc8280xp",
> +		.of_match_table = disp_cc_sc8280xp_match_table,
> +	},
> +};
> +
> +static int __init disp_cc_sc8280xp_init(void)
> +{
> +	return platform_driver_register(&disp_cc_sc8280xp_driver);
> +}
> +subsys_initcall(disp_cc_sc8280xp_init);
> +
> +static void __exit disp_cc_sc8280xp_exit(void)
> +{
> +	platform_driver_unregister(&disp_cc_sc8280xp_driver);
> +}
> +module_exit(disp_cc_sc8280xp_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm SC8280XP dispcc driver");
> +MODULE_LICENSE("GPL");
