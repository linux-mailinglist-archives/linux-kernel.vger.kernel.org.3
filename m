Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0104C2284
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiBXDnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiBXDnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:43:39 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCB425A30B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:43:09 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id i5so1243545oih.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LQV2Ce0Cqm3fFzgko900zEq9hMhH+dYL1BenORkgZSE=;
        b=cLYZ+u45ycfZDh38NHEb/21XbNgNJUZG3on3NOdklDWSJ7PYJ+mdinq7E890TK38OQ
         tSkQUxI/xCNA/cht+qvJAbH0cwiq7f7N3rXRxmjZbGS3GHMwWBev1n1I02+bJN7zW90S
         Y73yWgHuDPVmf6+iArbNDFcrS1A79n7D5oRnf5N/FJ8ywVtznp2wcRdZ9W46JWcAonIF
         XUk4j4BQcWTfayGWJUrM4yxLtlsHnLKU4H2WPmutQHSw3DikI6o0QvBR6/NDcFEpdp1e
         5No0/Xf00aVJsSrQu/9VrUfDI9OA88oOlURFV1yzpkIuS88PD7aWFFrnlzjG3lTTSP1/
         +wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LQV2Ce0Cqm3fFzgko900zEq9hMhH+dYL1BenORkgZSE=;
        b=zaQlrdfLY3t74AVhSesWNPUfBp+LwRZYfUa62hVS/vdIexGotlKLwcb4SpwlxsiBv7
         1q4EZ5DmqlLabV/54wAVkT8V8d7UdkxhWUyPKE77cTqpKVCkXT+Vp5gDRfGhuTe8gY+e
         4S0fBvIEVqsOvDqAfAtEegDEc0TnJDV5kwfOeFsJ/wiIFnPHWOVLLIrIWTNOaodnLaE2
         avcN1PXtJ5FgaGRX/+thuqBVlgELAe6hoPslHofUKo6syWAF9pSu14NdqidKPnFaZkMm
         dW1TK2diXW/3ofQ+tj/0Bty2i5MH88YONO+hA614ZDq0EYv1rytowHIvqWfbi06od2Xs
         hxTw==
X-Gm-Message-State: AOAM5311Qg33BLXqos2BTuXSmE9LA9aGL/O5kbVIcJy35BSLRlLMUi6w
        CrSpz5KMnEMWxPHfM94vHAICAg==
X-Google-Smtp-Source: ABdhPJzgnESy4fUgWr9qkHrfCBVEALdcwUFNttweBpXgPrGC9ko/0af5qYzPPWqA86hfZugFItirDw==
X-Received: by 2002:aca:32c1:0:b0:2ce:6ee7:2c9f with SMTP id y184-20020aca32c1000000b002ce6ee72c9fmr6192858oiy.205.1645674189114;
        Wed, 23 Feb 2022 19:43:09 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id e9sm604775oos.19.2022.02.23.19.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 19:43:08 -0800 (PST)
Date:   Wed, 23 Feb 2022 21:43:06 -0600
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
Subject: Re: [PATCH v4 04/16] clk: qcom: gcc-ipq806x: fix wrong naming for
 gcc_pxo_pll8_pll0
Message-ID: <Yhb+yiSIBmO9iJNs@builder.lan>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-5-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217235703.26641-5-ansuelsmth@gmail.com>
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

> Parent gcc_pxo_pll8_pll0 had the parent definition and parent map
> swapped. Fix this naming error.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/clk/qcom/gcc-ipq806x.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> index d6b7adb4be38..34cddf461dba 100644
> --- a/drivers/clk/qcom/gcc-ipq806x.c
> +++ b/drivers/clk/qcom/gcc-ipq806x.c
> @@ -291,13 +291,13 @@ static const char * const gcc_pxo_pll3[] = {
>  	"pll3",
>  };
>  
> -static const struct parent_map gcc_pxo_pll8_pll0[] = {
> +static const struct parent_map gcc_pxo_pll8_pll0_map[] = {
>  	{ P_PXO, 0 },
>  	{ P_PLL8, 3 },
>  	{ P_PLL0, 2 }
>  };
>  
> -static const char * const gcc_pxo_pll8_pll0_map[] = {
> +static const char * const gcc_pxo_pll8_pll0[] = {
>  	"pxo",
>  	"pll8_vote",
>  	"pll0_vote",
> @@ -1993,7 +1993,7 @@ static struct clk_rcg usb30_master_clk_src = {
>  	},
>  	.s = {
>  		.src_sel_shift = 0,
> -		.parent_map = gcc_pxo_pll8_pll0,
> +		.parent_map = gcc_pxo_pll8_pll0_map,
>  	},
>  	.freq_tbl = clk_tbl_usb30_master,
>  	.clkr = {
> @@ -2001,7 +2001,7 @@ static struct clk_rcg usb30_master_clk_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb30_master_ref_src",
> -			.parent_names = gcc_pxo_pll8_pll0_map,
> +			.parent_names = gcc_pxo_pll8_pll0,
>  			.num_parents = 3,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> @@ -2063,7 +2063,7 @@ static struct clk_rcg usb30_utmi_clk = {
>  	},
>  	.s = {
>  		.src_sel_shift = 0,
> -		.parent_map = gcc_pxo_pll8_pll0,
> +		.parent_map = gcc_pxo_pll8_pll0_map,
>  	},
>  	.freq_tbl = clk_tbl_usb30_utmi,
>  	.clkr = {
> @@ -2071,7 +2071,7 @@ static struct clk_rcg usb30_utmi_clk = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb30_utmi_clk",
> -			.parent_names = gcc_pxo_pll8_pll0_map,
> +			.parent_names = gcc_pxo_pll8_pll0,
>  			.num_parents = 3,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> @@ -2133,7 +2133,7 @@ static struct clk_rcg usb_hs1_xcvr_clk_src = {
>  	},
>  	.s = {
>  		.src_sel_shift = 0,
> -		.parent_map = gcc_pxo_pll8_pll0,
> +		.parent_map = gcc_pxo_pll8_pll0_map,
>  	},
>  	.freq_tbl = clk_tbl_usb,
>  	.clkr = {
> @@ -2141,7 +2141,7 @@ static struct clk_rcg usb_hs1_xcvr_clk_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb_hs1_xcvr_src",
> -			.parent_names = gcc_pxo_pll8_pll0_map,
> +			.parent_names = gcc_pxo_pll8_pll0,
>  			.num_parents = 3,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> @@ -2197,7 +2197,7 @@ static struct clk_rcg usb_fs1_xcvr_clk_src = {
>  	},
>  	.s = {
>  		.src_sel_shift = 0,
> -		.parent_map = gcc_pxo_pll8_pll0,
> +		.parent_map = gcc_pxo_pll8_pll0_map,
>  	},
>  	.freq_tbl = clk_tbl_usb,
>  	.clkr = {
> @@ -2205,7 +2205,7 @@ static struct clk_rcg usb_fs1_xcvr_clk_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb_fs1_xcvr_src",
> -			.parent_names = gcc_pxo_pll8_pll0_map,
> +			.parent_names = gcc_pxo_pll8_pll0,
>  			.num_parents = 3,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> -- 
> 2.34.1
> 
