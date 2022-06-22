Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF46F5546C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348255AbiFVKXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351561AbiFVKXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:23:09 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C744615A0B;
        Wed, 22 Jun 2022 03:22:59 -0700 (PDT)
Received: from [192.168.1.101] (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 459CA20597;
        Wed, 22 Jun 2022 12:22:57 +0200 (CEST)
Message-ID: <adf27e62-246a-9c5f-e517-f225d17fe1cd@somainline.org>
Date:   Wed, 22 Jun 2022 12:22:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 4/6] clk: qcom: add support for SM8350 DISPCC
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>, bjorn.andersson@linaro.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20220621233412.506768-1-robert.foss@linaro.org>
 <20220621233412.506768-5-robert.foss@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220621233412.506768-5-robert.foss@linaro.org>
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



On 22.06.2022 01:34, Robert Foss wrote:
> From: Jonathan Marek <jonathan@marek.ca>
> 
> Add support to the SM8350 display clock controller by extending the SM8250
> display clock controller, which is almost identical but has some minor
> differences.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> 
> Changes since v1
>  - Remove comment - Dmitry
> 
> Changes since v2
>  - Add my SoB - Bjorn
>  - Remove CLK_ASSUME_ENABLED_WHEN_UNUSED flag
> 
> Changes since v3
>  - Add kconfig dependency on SM_GCC_8350 - Konrad
>  - Change hex to lowercase - Konrad
>  - Split from dispcc-sm8250.c implementation
>  - Switch from .fw_name to .index
> 
> Changes since v4
>  - Hex to lowercase - Konrad
>  - Remove bad match table entries - Konrad
> 
> Changes since v5
>  - Reverted split from dispcc-sm8250
>  - Re-added tags from v3
> 
> 
>  drivers/clk/qcom/Kconfig         |  4 +--
>  drivers/clk/qcom/dispcc-sm8250.c | 60 +++++++++++++++++++++++++++++++-
>  2 files changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index b11235c21952..4c3d1a548b7a 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -618,11 +618,11 @@ config SM_DISPCC_6125
>  	  splash screen
>  
>  config SM_DISPCC_8250
> -	tristate "SM8150 and SM8250 Display Clock Controller"
> +	tristate "SM8150/SM8250/SM8350 Display Clock Controller"
>  	depends on SM_GCC_8150 || SM_GCC_8250
|| SM_GCC_8350

>  	help
>  	  Support for the display clock controller on Qualcomm Technologies, Inc
> -	  SM8150 and SM8250 devices.
> +	  SM8150/SM8250/SM8350 devices.
>  	  Say Y if you want to support display devices and functionality such as
>  	  splash screen.
>  
> diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
> index db9379634fb2..4e101d584115 100644
> --- a/drivers/clk/qcom/dispcc-sm8250.c
> +++ b/drivers/clk/qcom/dispcc-sm8250.c
> @@ -43,6 +43,10 @@ static struct pll_vco vco_table[] = {
>  	{ 249600000, 2000000000, 0 },
>  };
>  
> +static struct pll_vco lucid_5lpe_vco[] = {
> +	{ 249600000, 1750000000, 0 },
> +};
> +
>  static struct alpha_pll_config disp_cc_pll0_config = {
>  	.l = 0x47,
>  	.alpha = 0xE000,
> @@ -1228,6 +1232,7 @@ static const struct of_device_id disp_cc_sm8250_match_table[] = {
>  	{ .compatible = "qcom,sc8180x-dispcc" },
>  	{ .compatible = "qcom,sm8150-dispcc" },
>  	{ .compatible = "qcom,sm8250-dispcc" },
> +	{ .compatible = "qcom,sm8350-dispcc" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, disp_cc_sm8250_match_table);
> @@ -1258,7 +1263,7 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
>  		return PTR_ERR(regmap);
>  	}
>  
> -	/* note: trion == lucid, except for the prepare() op */
> +	/* Apply differences for SM8150 and SM8350 */
I think both comments should stay, as the one you're adding doesn't explain the BUILD_BUG_ON()


Konrad
>  	BUILD_BUG_ON(CLK_ALPHA_PLL_TYPE_TRION != CLK_ALPHA_PLL_TYPE_LUCID);
>  	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sc8180x-dispcc") ||
>  	    of_device_is_compatible(pdev->dev.of_node, "qcom,sm8150-dispcc")) {
> @@ -1270,6 +1275,59 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
>  		disp_cc_pll1_config.config_ctl_hi1_val = 0x00000024;
>  		disp_cc_pll1_config.user_ctl_hi1_val = 0x000000D0;
>  		disp_cc_pll1_init.ops = &clk_alpha_pll_trion_ops;
> +	} else if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8350-dispcc")) {
> +		static struct clk_rcg2 * const rcgs[] = {
> +			&disp_cc_mdss_byte0_clk_src,
> +			&disp_cc_mdss_byte1_clk_src,
> +			&disp_cc_mdss_dp_aux1_clk_src,
> +			&disp_cc_mdss_dp_aux_clk_src,
> +			&disp_cc_mdss_dp_link1_clk_src,
> +			&disp_cc_mdss_dp_link_clk_src,
> +			&disp_cc_mdss_dp_pixel1_clk_src,
> +			&disp_cc_mdss_dp_pixel2_clk_src,
> +			&disp_cc_mdss_dp_pixel_clk_src,
> +			&disp_cc_mdss_esc0_clk_src,
> +			&disp_cc_mdss_mdp_clk_src,
> +			&disp_cc_mdss_pclk0_clk_src,
> +			&disp_cc_mdss_pclk1_clk_src,
> +			&disp_cc_mdss_rot_clk_src,
> +			&disp_cc_mdss_vsync_clk_src,
> +		};
> +		static struct clk_regmap_div * const divs[] = {
> +			&disp_cc_mdss_byte0_div_clk_src,
> +			&disp_cc_mdss_byte1_div_clk_src,
> +			&disp_cc_mdss_dp_link1_div_clk_src,
> +			&disp_cc_mdss_dp_link_div_clk_src,
> +		};
> +		unsigned int i;
> +		static bool offset_applied;
> +
> +		/* only apply the offsets once (in case of deferred probe) */
> +		if (!offset_applied) {
> +			for (i = 0; i < ARRAY_SIZE(rcgs); i++)
> +				rcgs[i]->cmd_rcgr -= 4;
> +
> +			for (i = 0; i < ARRAY_SIZE(divs); i++) {
> +				divs[i]->reg -= 4;
> +				divs[i]->width = 4;
> +			}
> +
> +			disp_cc_mdss_ahb_clk.halt_reg -= 4;
> +			disp_cc_mdss_ahb_clk.clkr.enable_reg -= 4;
> +
> +			offset_applied = true;
> +		}
> +
> +		disp_cc_mdss_ahb_clk_src.cmd_rcgr = 0x22a0;
> +
> +		disp_cc_pll0_config.config_ctl_hi1_val = 0x2a9a699c;
> +		disp_cc_pll0_config.test_ctl_hi1_val = 0x01800000;
> +		disp_cc_pll0_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
> +		disp_cc_pll0.vco_table = lucid_5lpe_vco;
> +		disp_cc_pll1_config.config_ctl_hi1_val = 0x2a9a699c;
> +		disp_cc_pll1_config.test_ctl_hi1_val = 0x01800000;
> +		disp_cc_pll1_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
> +		disp_cc_pll1.vco_table = lucid_5lpe_vco;
>  	}
>  
>  	clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
