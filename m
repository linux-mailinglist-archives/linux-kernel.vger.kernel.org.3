Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E8E518B08
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbiECR3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbiECR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:29:29 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9AD24BFA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:25:56 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q8so18442861oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3z/l1HSH3jqNGmslwWFKhYP79wtIMsIjce3evgDJdtg=;
        b=QdWxIGrXR3JpHNjL30920kkqzAh8W/wO9AGGilYIUrMxy8MgkViTYpniUDZ5Sq/FeZ
         qRqO2b59Im3UPbcaM7MZFKwYC/ZBy9Uo+BBQeVk9HGE5qG0/fwJzKiCEkDJqWr82/xzB
         ed4Qxl6zcOFX59AN0FqAM30m/YHfyz7fPwhnr9tjMKUq61iD518IDXhhq5Q6JNt/CV0g
         qeJQwGBpQ3Xm2vwZ2p+TsrG5PWPFaGL/41QIdiriYYLmRkxKVSTTlfjPbsjWFh0G/ia3
         6ZleHqUaL4qx5DNbLrXpgUyFzzVPgaHJxhHB/ps472lHWqzAgn+/lNu51i09ZgdqLSva
         TycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3z/l1HSH3jqNGmslwWFKhYP79wtIMsIjce3evgDJdtg=;
        b=hs0C+whFx4Y1L8yR21fSBedDcCbvHQgcXEGKFTD0ZhrOs6JZteSHd3Qfi+sMZj4xrN
         nisutAMJaC4Tw+icIrIiEe8uzepphUdn0DaYb821SiGXMp1KRGJ0BVHLilAoG3wUJksg
         mzovAxH9NYnqqEc9MI6DI++XgKrIdIiRmNLfItdvJ6cejIaUZoiyaCZF1/69HB6+sCDJ
         gDwrZ+QoVxWH/LKmLLME9bzwM5AmxJGlRughh3hZKUj2o99qq1TDsOIgDYxsourckyUV
         Ung1v6BXdXxgrXh3k+7H6XzJVZdiIAZ1GEmsG3DDYDkULlK86RV06xURA9fnfqP/UJlg
         +njw==
X-Gm-Message-State: AOAM532J+BeZcfnBbtwWfxvuI42crWNee5K+5WX1sZtt+xbfqeeyb9Pp
        Twyl/0/5LGp9QA/Adp10tjCDUA==
X-Google-Smtp-Source: ABdhPJz79mDfmes/G5w0bR7ZzDpUjHbnOTtAnHt9X3X3VgcAXabvNa+4GPBGQ6ot5AvtpOMB36avHQ==
X-Received: by 2002:aca:5d0a:0:b0:326:2fed:bd95 with SMTP id r10-20020aca5d0a000000b003262fedbd95mr1941582oib.97.1651598755159;
        Tue, 03 May 2022 10:25:55 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f9-20020a0568301c2900b0060603221247sm4166803ote.23.2022.05.03.10.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:25:54 -0700 (PDT)
Date:   Tue, 3 May 2022 12:25:49 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 6/8] clk: qcom: add support for SM8350 DISPCC
Message-ID: <YnFlnbPsf6oBf+A1@builder.lan>
References: <20220503130448.520470-1-robert.foss@linaro.org>
 <20220503130448.520470-6-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503130448.520470-6-robert.foss@linaro.org>
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
> Add support to the SM8350 display clock controller by extending the SM8250
> display clock controller, which is almost identical but has some minor
> differences.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

You handled this patch, as such your S-o-b should be here as well.

The rest looks good to me.

Regards,
Bjorn

> ---
> 
> Changes since v1
>  - Remove comment - Dmitry
>  
> 
>  drivers/clk/qcom/Kconfig         |  4 +--
>  drivers/clk/qcom/dispcc-sm8250.c | 60 +++++++++++++++++++++++++++++++-
>  2 files changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 9b1f54e634b9..1752ca0ee405 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -609,11 +609,11 @@ config SM_DISPCC_6125
>  	  splash screen
>  
>  config SM_DISPCC_8250
> -	tristate "SM8150 and SM8250 Display Clock Controller"
> +	tristate "SM8150/SM8250/SM8350 Display Clock Controller"
>  	depends on SM_GCC_8150 || SM_GCC_8250
>  	help
>  	  Support for the display clock controller on Qualcomm Technologies, Inc
> -	  SM8150 and SM8250 devices.
> +	  SM8150/SM8250/SM8350 devices.
>  	  Say Y if you want to support display devices and functionality such as
>  	  splash screen.
>  
> diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
> index 22d9cbabecab..daa3714cfc7d 100644
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
> +		disp_cc_pll0_config.config_ctl_hi1_val = 0x2A9A699C;
> +		disp_cc_pll0_config.test_ctl_hi1_val = 0x01800000;
> +		disp_cc_pll0_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
> +		disp_cc_pll0.vco_table = lucid_5lpe_vco;
> +		disp_cc_pll1_config.config_ctl_hi1_val = 0x2A9A699C;
> +		disp_cc_pll1_config.test_ctl_hi1_val = 0x01800000;
> +		disp_cc_pll1_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
> +		disp_cc_pll1.vco_table = lucid_5lpe_vco;
>  	}
>  
>  	clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
> -- 
> 2.34.1
> 
