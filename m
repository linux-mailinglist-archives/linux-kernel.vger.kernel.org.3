Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E54C22A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiBXDtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiBXDto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:49:44 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D77625456B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:49:14 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id u17-20020a056830231100b005ad13358af9so467640ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ABjI1saay7GYkCuy5TMmzHkPENxFhoiYz1hU6Vap3dY=;
        b=gt4dC5+8iOAFgL4mndZgUGWW2NqmjPVTY+xMPVsPTnL4RCXX1Txktg7/22aRW2aN1U
         tk2Y3Upumj5neUW68p3NfJKI+V+h3UoqoSabpFW3NlqWh7eeU+ji1MWctwDzZcLu1R05
         38EBbStloc/XMlYu91cGEQ7cV0iIQkh88tsFaCPVJZ9hcTJKKaeXNo7iVxJL0Pxgf0Sd
         Ildd+Is5ObFHJQQ4zQZMpxaUxlpQylo42Ny3oo1NuqsuIpcYZAp264c8nH6q4zZlBlPs
         xI/usadhGLLBwXDItgze6+piOPrrop3ySR5bYMRCdsYpf7I1XWWqyk5q8+jqq4DlMRo9
         hjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ABjI1saay7GYkCuy5TMmzHkPENxFhoiYz1hU6Vap3dY=;
        b=pY06K+xN1KN6wsEecsnsYxVVAwJuXDogwdkJEeFQQaZxTqYcAZ7GGo4U9wiPBT4YjJ
         O2nKmKHbx+tmtM+IXjHbBAwJ0C9YAjt/EWT3umakjGRiSYAghwNWe/p+YdRotsaLvSZb
         6hXnN1CeZZyAq9bXvrAA9W3ERGYkT0G24v0sqf/IHGWr/8qMpDVT92V7aT/z0s5qU/25
         Kh2KrfnOdY/M++gJHmSQem4ZslrgV1MHwisrLsPbfi7zHsl39jkU2h8YPmOGpkVIVQMR
         qQn2EOUrLoJVj7+1oVcHcEJXqnpaPfkP6jaInnE0L6bl9Kiy1GxuvfG19VQpiwZdI7Ge
         +8jw==
X-Gm-Message-State: AOAM533AqT8X93Y9up4BcS4LOWKCB3tj+QtGoRym8IAM7H3OIFiVMVgn
        eMF6Q7JXl7m3BPUnzjEigY/heA==
X-Google-Smtp-Source: ABdhPJyTsJ1fZ5gBNiitTJSXy+eJ5ja45e4KsyWpJAQHHSesA1HOJZZkQKYwVkizhbuw4QozfjIqZg==
X-Received: by 2002:a9d:176:0:b0:5ae:ed94:f1c0 with SMTP id 109-20020a9d0176000000b005aeed94f1c0mr275592otu.74.1645674553358;
        Wed, 23 Feb 2022 19:49:13 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id y17sm674413otk.70.2022.02.23.19.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 19:49:12 -0800 (PST)
Date:   Wed, 23 Feb 2022 21:49:11 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/16] clk: qcom: gcc-ipq806x: use ARRAY_SIZE for
 num_parents
Message-ID: <YhcANw99BMk9PHTS@builder.lan>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-7-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217235703.26641-7-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Feb 17:56 CST 2022, Ansuel Smith wrote:

> Use ARRAY_SIZE for num_parents instead of hardcoding the value.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq806x.c | 68 +++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> index 828383c30322..f6db7247835e 100644
> --- a/drivers/clk/qcom/gcc-ipq806x.c
> +++ b/drivers/clk/qcom/gcc-ipq806x.c
> @@ -373,7 +373,7 @@ static struct clk_rcg gsbi1_uart_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi1_uart_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
>  		},
> @@ -424,7 +424,7 @@ static struct clk_rcg gsbi2_uart_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi2_uart_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
>  		},
> @@ -475,7 +475,7 @@ static struct clk_rcg gsbi4_uart_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi4_uart_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
>  		},
> @@ -526,7 +526,7 @@ static struct clk_rcg gsbi5_uart_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi5_uart_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
>  		},
> @@ -577,7 +577,7 @@ static struct clk_rcg gsbi6_uart_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi6_uart_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
>  		},
> @@ -628,7 +628,7 @@ static struct clk_rcg gsbi7_uart_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi7_uart_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
>  		},
> @@ -692,7 +692,7 @@ static struct clk_rcg gsbi1_qup_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi1_qup_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
>  		},
> @@ -743,7 +743,7 @@ static struct clk_rcg gsbi2_qup_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi2_qup_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
>  		},
> @@ -794,7 +794,7 @@ static struct clk_rcg gsbi4_qup_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi4_qup_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
>  		},
> @@ -845,7 +845,7 @@ static struct clk_rcg gsbi5_qup_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi5_qup_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
>  		},
> @@ -896,7 +896,7 @@ static struct clk_rcg gsbi6_qup_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi6_qup_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
>  		},
> @@ -947,7 +947,7 @@ static struct clk_rcg gsbi7_qup_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi7_qup_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
>  		},
> @@ -1099,7 +1099,7 @@ static struct clk_rcg gp0_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gp0_src",
>  			.parent_data = gcc_pxo_pll8_cxo,
> -			.num_parents = 3,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_cxo),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
>  		},
> @@ -1150,7 +1150,7 @@ static struct clk_rcg gp1_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gp1_src",
>  			.parent_data = gcc_pxo_pll8_cxo,
> -			.num_parents = 3,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_cxo),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
>  		},
> @@ -1201,7 +1201,7 @@ static struct clk_rcg gp2_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gp2_src",
>  			.parent_data = gcc_pxo_pll8_cxo,
> -			.num_parents = 3,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_cxo),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
>  		},
> @@ -1257,7 +1257,7 @@ static struct clk_rcg prng_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "prng_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  		},
>  	},
> @@ -1321,7 +1321,7 @@ static struct clk_rcg sdc1_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "sdc1_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  		},
>  	}
> @@ -1371,7 +1371,7 @@ static struct clk_rcg sdc3_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "sdc3_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  		},
>  	}
> @@ -1456,7 +1456,7 @@ static struct clk_rcg tsif_ref_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "tsif_ref_src",
>  			.parent_data = gcc_pxo_pll8,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
>  			.ops = &clk_rcg_ops,
>  		},
>  	}
> @@ -1620,7 +1620,7 @@ static struct clk_rcg pcie_ref_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "pcie_ref_src",
>  			.parent_data = gcc_pxo_pll3,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
>  		},
> @@ -1714,7 +1714,7 @@ static struct clk_rcg pcie1_ref_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "pcie1_ref_src",
>  			.parent_data = gcc_pxo_pll3,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
>  		},
> @@ -1808,7 +1808,7 @@ static struct clk_rcg pcie2_ref_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "pcie2_ref_src",
>  			.parent_data = gcc_pxo_pll3,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
>  		},
> @@ -1907,7 +1907,7 @@ static struct clk_rcg sata_ref_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "sata_ref_src",
>  			.parent_data = gcc_pxo_pll3,
> -			.num_parents = 2,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll3),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
>  		},
> @@ -2048,7 +2048,7 @@ static struct clk_rcg usb30_master_clk_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb30_master_ref_src",
>  			.parent_data = gcc_pxo_pll8_pll0,
> -			.num_parents = 3,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
>  		},
> @@ -2122,7 +2122,7 @@ static struct clk_rcg usb30_utmi_clk = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb30_utmi_clk",
>  			.parent_data = gcc_pxo_pll8_pll0,
> -			.num_parents = 3,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
>  		},
> @@ -2196,7 +2196,7 @@ static struct clk_rcg usb_hs1_xcvr_clk_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb_hs1_xcvr_src",
>  			.parent_data = gcc_pxo_pll8_pll0,
> -			.num_parents = 3,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
>  		},
> @@ -2262,7 +2262,7 @@ static struct clk_rcg usb_fs1_xcvr_clk_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb_fs1_xcvr_src",
>  			.parent_data = gcc_pxo_pll8_pll0,
> -			.num_parents = 3,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
>  		},
> @@ -2398,7 +2398,7 @@ static struct clk_dyn_rcg gmac_core1_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gmac_core1_src",
>  			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
> -			.num_parents = 5,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
>  			.ops = &clk_dyn_rcg_ops,
>  		},
>  	},
> @@ -2470,7 +2470,7 @@ static struct clk_dyn_rcg gmac_core2_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gmac_core2_src",
>  			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
> -			.num_parents = 5,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
>  			.ops = &clk_dyn_rcg_ops,
>  		},
>  	},
> @@ -2542,7 +2542,7 @@ static struct clk_dyn_rcg gmac_core3_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gmac_core3_src",
>  			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
> -			.num_parents = 5,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
>  			.ops = &clk_dyn_rcg_ops,
>  		},
>  	},
> @@ -2614,7 +2614,7 @@ static struct clk_dyn_rcg gmac_core4_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gmac_core4_src",
>  			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
> -			.num_parents = 5,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
>  			.ops = &clk_dyn_rcg_ops,
>  		},
>  	},
> @@ -2674,7 +2674,7 @@ static struct clk_dyn_rcg nss_tcm_src = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "nss_tcm_src",
>  			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
> -			.num_parents = 5,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
>  			.ops = &clk_dyn_rcg_ops,
>  		},
>  	},
> @@ -2752,7 +2752,7 @@ static struct clk_dyn_rcg ubi32_core1_src_clk = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "ubi32_core1_src_clk",
>  			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
> -			.num_parents = 5,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
>  			.ops = &clk_dyn_rcg_ops,
>  			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
>  		},
> @@ -2805,7 +2805,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "ubi32_core2_src_clk",
>  			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
> -			.num_parents = 5,
> +			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll14_pll18_pll0),
>  			.ops = &clk_dyn_rcg_ops,
>  			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
>  		},
> -- 
> 2.34.1
> 
