Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A2C4651CC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351040AbhLAPk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbhLAPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:40:28 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8154BC061748;
        Wed,  1 Dec 2021 07:37:06 -0800 (PST)
Received: from [192.168.1.101] (83.6.166.111.neoplus.adsl.tpnet.pl [83.6.166.111])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 576393F767;
        Wed,  1 Dec 2021 16:37:03 +0100 (CET)
Message-ID: <2649eada-3e80-cec3-5dca-bded67fa5f80@somainline.org>
Date:   Wed, 1 Dec 2021 16:37:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 3/4] clk: qcom: Add clock driver for SM8450
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211201072310.3968679-1-vkoul@kernel.org>
 <20211201072310.3968679-4-vkoul@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211201072310.3968679-4-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.12.2021 08:23, Vinod Koul wrote:
> This adds Global Clock controller (GCC) driver for SM8450 SoC including
> the gcc resets and gdsc.
>
> This patch is based on initial code downstream by Vivek Aknurwar
> <viveka@codeaurora.org>
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/clk/qcom/Kconfig      |    8 +
>  drivers/clk/qcom/Makefile     |    1 +
>  drivers/clk/qcom/gcc-sm8450.c | 3314 +++++++++++++++++++++++++++++++++
>  3 files changed, 3323 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-sm8450.c
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 74efc82127e1..3a568e7ad886 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -618,6 +618,14 @@ config SM_GCC_8350
>  	  Say Y if you want to use peripheral devices such as UART,
>  	  SPI, I2C, USB, SD/UFS, PCIe etc.
>  
> +config SM_GCC_8450
> +	tristate "SM8450 Global Clock Controller"
> +	select QCOM_GDSC
> +	help
> +	  Support for the global clock controller on SM8450 devices.
> +	  Say Y if you want to use peripheral devices such as UART,
> +	  SPI, I2C, USB, SD/UFS, PCIe etc.
> +
>  config SM_GPUCC_8150
>  	tristate "SM8150 Graphics Clock Controller"
>  	select SM_GCC_8150
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 1718c34d3551..efb0837ea199 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -90,6 +90,7 @@ obj-$(CONFIG_SM_GCC_6350) += gcc-sm6350.o
>  obj-$(CONFIG_SM_GCC_8150) += gcc-sm8150.o
>  obj-$(CONFIG_SM_GCC_8250) += gcc-sm8250.o
>  obj-$(CONFIG_SM_GCC_8350) += gcc-sm8350.o
> +obj-$(CONFIG_SM_GCC_8450) += gcc-sm8450.o
>  obj-$(CONFIG_SM_GPUCC_8150) += gpucc-sm8150.o
>  obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
>  obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
> diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
> new file mode 100644
> index 000000000000..175c18a1cdbe
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-sm8450.c
> @@ -0,0 +1,3314 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021, Linaro Limited
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,gcc-sm8450.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +	P_BI_TCXO,
> +	P_GCC_GPLL0_OUT_EVEN,
> +	P_GCC_GPLL0_OUT_MAIN,
> +	P_GCC_GPLL4_OUT_MAIN,
> +	P_GCC_GPLL9_OUT_MAIN,
> +	P_PCIE_0_PIPE_CLK,
> +	P_PCIE_1_PHY_AUX_CLK,
> +	P_PCIE_1_PIPE_CLK,
> +	P_SLEEP_CLK,
> +	P_UFS_PHY_RX_SYMBOL_0_CLK,
> +	P_UFS_PHY_RX_SYMBOL_1_CLK,
> +	P_UFS_PHY_TX_SYMBOL_0_CLK,
> +	P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK,
> +};
> +
> +static struct clk_alpha_pll gcc_gpll0 = {
> +	.offset = 0x0,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
> +	.clkr = {
> +		.enable_reg = 0x62018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_gpll0",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "bi_tcxo",
> +				.name = "bi_tcxo",

I don't think we want .name for new drivers, as we do things cleanly

from the start and don't have DT incompatibility problems.

[...]


> +
> +static int gcc_sm8450_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = qcom_cc_map(pdev, &gcc_sm8450_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
> +				       ARRAY_SIZE(gcc_dfs_clocks));
> +	if (ret)
> +		return ret;
> +
> +	/* FORCE_MEM_CORE_ON for ufs phy ice core clocks */
> +	regmap_update_bits(regmap, gcc_ufs_phy_ice_core_clk.halt_reg, BIT(14), BIT(14));
> +
> +	/* Keep the critical clock always-On

I think the general style for multiline comments is to start with /* and then add a newline



> +	 * gcc_camera_ahb_clk, gcc_camera_xo_clk, gcc_disp_ahb_clk,
> +	 * gcc_disp_xo_clk, gcc_gpu_cfg_ahb_clk, gcc_video_ahb_clk,
> +	 * gcc_video_xo_clk
> +	 */
> +	regmap_update_bits(regmap, 0x36004, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x36020, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x37004, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x3701c, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x81004, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x42004, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x42028, BIT(0), BIT(0));
> +
> +	ret = qcom_cc_really_probe(pdev, &gcc_sm8450_desc, regmap);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register GCC clocks\n");

That's a bad downstream leftover that we don't want..



> +		return ret;
> +	}
> +
> +	dev_info(&pdev->dev, "Registered GCC clocks\n");

And so is this.



> +
> +	return ret;

You can simply return qcom_cc_really_probe(pdev, &gcc_sm8450_desc, regmap);


Konrad

