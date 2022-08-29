Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115345A5611
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiH2VYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2VYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:24:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D4E86B7A;
        Mon, 29 Aug 2022 14:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6116561210;
        Mon, 29 Aug 2022 21:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67B8C433C1;
        Mon, 29 Aug 2022 21:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661808275;
        bh=YhHEv7KSm28wyjioyO11RwThDZ/cHhzV+SbcRuiXD30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a1Pp0y7GLcgpoARejTqXecBwJYgsTTnho1MwnzIMCjMYulc3Z2EJxhBICOVZoYhFc
         Lw8CmTX1gfXpy/NFy7OtU5hR83H1ciRYsIKculDi7GXkuky8EY6yCHNR0rdXF0T8TU
         8L4tDQ8duZLUyTyeMfya3UcpQ3qu5t09cexv6pkCggAiLqs/DyxSB8ANEGI+00hzZg
         PBuLxWVEtrMFbqHkQBg8fsfaOXk1OX04tFozEcr6hCW9HGA7Rhf1HKhcMxEwrxqTDK
         SdZHz5AHlFaCEoXnuJfYMxUGacb57kDRlwV2Mwgk6jout9xHtKxPT0Glk9XO/D0D58
         Xr+uR3Hxc7IXA==
Date:   Mon, 29 Aug 2022 16:24:32 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clk: qcom: Add display clock controller driver
 for SM6115
Message-ID: <20220829212432.nyxvcw6amypuwhwp@builder.lan>
References: <20220819201231.23474-1-a39.skl@gmail.com>
 <20220819201231.23474-3-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819201231.23474-3-a39.skl@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 10:12:22PM +0200, Adam Skladowski wrote:
> Add support for the display clock controller found in SM6115/SM4250
> based devices. This clock controller feeds the Multimedia Display
> SubSystem (MDSS).
> This driver is based upon one submitted for QCM2290.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  drivers/clk/qcom/Kconfig         |   9 +
>  drivers/clk/qcom/Makefile        |   1 +
>  drivers/clk/qcom/dispcc-sm6115.c | 615 +++++++++++++++++++++++++++++++
>  3 files changed, 625 insertions(+)
>  create mode 100644 drivers/clk/qcom/dispcc-sm6115.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 1cf1ef70e347..852888a849ae 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -616,6 +616,15 @@ config SM_CAMCC_8450
>  	  Support for the camera clock controller on SM8450 devices.
>  	  Say Y if you want to support camera devices and camera functionality.
>  
> +config SM_DISPCC_6115
> +	tristate "SM6115 Display Clock Controller"
> +	depends on SM_GCC_6115
> +	help
> +	  Support for the display clock controller on Qualcomm Technologies, Inc
> +	  SM6115/SM4250 devices.
> +	  Say Y if you want to support display devices and functionality such as
> +	  splash screen
> +
>  config SM_DISPCC_6125
>  	tristate "SM6125 Display Clock Controller"
>  	depends on SM_GCC_6125
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index fbcf04073f07..a732ccb3b912 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -90,6 +90,7 @@ obj-$(CONFIG_SDX_GCC_55) += gcc-sdx55.o
>  obj-$(CONFIG_SDX_GCC_65) += gcc-sdx65.o
>  obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
>  obj-$(CONFIG_SM_CAMCC_8450) += camcc-sm8450.o
> +obj-$(CONFIG_SM_DISPCC_6115) += dispcc-sm6115.o
>  obj-$(CONFIG_SM_DISPCC_6125) += dispcc-sm6125.o
>  obj-$(CONFIG_SM_DISPCC_6350) += dispcc-sm6350.o
>  obj-$(CONFIG_SM_DISPCC_8250) += dispcc-sm8250.o
> diff --git a/drivers/clk/qcom/dispcc-sm6115.c b/drivers/clk/qcom/dispcc-sm6115.c
> new file mode 100644
> index 000000000000..6a8994bfe9d0
> --- /dev/null
> +++ b/drivers/clk/qcom/dispcc-sm6115.c
> @@ -0,0 +1,615 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Based on dispcc-qcm2290.c
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021, Linaro Ltd.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,sm6115-dispcc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "common.h"
> +#include "gdsc.h"
> +
> +enum {
> +	P_BI_TCXO,
> +	P_DISP_CC_PLL0_OUT_MAIN,
> +	P_DSI0_PHY_PLL_OUT_BYTECLK,
> +	P_DSI0_PHY_PLL_OUT_DSICLK,
> +	P_DSI1_PHY_PLL_OUT_DSICLK,
> +	P_GPLL0_OUT_MAIN,
> +	P_SLEEP_CLK,
> +};
> +
> +static const struct pll_vco spark_vco[] = {
> +	{ 500000000, 1000000000, 2 },
> +};
> +
> +/* 768MHz configuration */
> +static const struct alpha_pll_config disp_cc_pll0_config = {
> +	.l = 0x28,
> +	.alpha = 0x0,
> +	.alpha_en_mask = BIT(24),
> +	.vco_val = 0x2 << 20,
> +	.vco_mask = GENMASK(21, 20),
> +	.main_output_mask = BIT(0),
> +	.config_ctl_val = 0x4001055B,
> +};
> +
> +static struct clk_alpha_pll disp_cc_pll0 = {
> +	.offset = 0x0,
> +	.vco_table = spark_vco,
> +	.num_vco = ARRAY_SIZE(spark_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data){
> +			.name = "disp_cc_pll0",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "bi_tcxo",

It's recently been decided that we would like to avoid using fw_name in
new Qualcomm clock bindings/drivers. Can you please rework this to use
.index instead?

As done in e.g.:
https://lore.kernel.org/all/20220811041211.3825786-3-bjorn.andersson@linaro.org/


Also for bi_tcxo, I'd prefer if you break that out to its own definition
that you can reuse.

> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_ops,
> +		},
> +	},
> +};
[..]
> +static int __init disp_cc_sm6115_init(void)
> +{
> +	return platform_driver_register(&disp_cc_sm6115_driver);
> +}
> +subsys_initcall(disp_cc_sm6115_init);

module_platform_driver() should be sufficient, and is slightly cleaner.

> +
> +static void __exit disp_cc_sm6115_exit(void)
> +{
> +	platform_driver_unregister(&disp_cc_sm6115_driver);
> +}
> +module_exit(disp_cc_sm6115_exit);
> +
> +MODULE_DESCRIPTION("QTI DISP_CC sm6115 Driver");

"Qualcomm SM6115 Display Clock controller"?

> +MODULE_LICENSE("GPL v2");

As reported by checkpatch, this should simply be "GPL".

Regards,
Bjorn

> -- 
> 2.25.1
> 
