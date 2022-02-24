Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F1A4C22A3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiBXDtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiBXDtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:49:19 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F8A19E003
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:48:48 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so1712595ooi.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PiZRCkT93sFuayBwB1xNP2rtK4QBBQDElK070sJbl20=;
        b=kWLCOEIIoARj8rSjwrhQdP1BxIimAbTDawAsKCgZVaS/Psc+uZ1JyikdmjP6ymoEV4
         1VPNmeAn5EcxSHRuwb5VspBLmXjCjdULzq9moCqW58e041uA1FiwBkUlk59NYVUUuFDP
         /b1+ITJj0wb9UD8MMq8DWkbl8YyqKbxMcpLFy8DQB60wztZEvRE+K0RgBMfR5bVAhADH
         f29fbfQL55ro9aoh05VZ/rs55XvfPBYcr+2VwTKYSup38YDXebAd4dvCrEhvbI9+tWeZ
         JIl+kbYVahux6z9LBYafKUdecvM09H1ylJRMtZ5S/SYjyvvjOGSE+E5nfsvbWW8CxJaF
         eGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PiZRCkT93sFuayBwB1xNP2rtK4QBBQDElK070sJbl20=;
        b=TADaZZlqhVeP8ads2uxYAdyB0bIfc9UioTDMT2ip9m3Db2lWU7mPlYSsxEn7V79cEQ
         9hTygY63oxNnTxPy+c6Zt9VOHx5IZBdRGZIXRrvEOpb8loRHlje6Sk9JoPoxJyJD8s4G
         xVs0R9zt6BcnmRV6UNU5dRL8ZpqPSmxyD80D05iGstjnGK8HdhkRuL6CqOsKU82NdcNY
         VOXsfdUvLLkr5JhsBCdEkkz8Qs9bQQhS2Bt9dB7VI6K/B4wicPqhdREy5bIciHwVJ37T
         GvAurNO+izH//7aDVYqBPJzelt9MJJol21gbf/0Y+NhMo+hVrzwI3s/KrFigko2YbuHk
         rvuA==
X-Gm-Message-State: AOAM533isene+OmrptZs+2DwDddqUJjsq2p5Ok62u7q3RZWn3/8BamCk
        ZtMGcpBkpDRCcrV9GKaLutxqEA==
X-Google-Smtp-Source: ABdhPJxpRKS9EU1A1z6bjy/RblCyFIMKM+1oZF3OhJTobvfA0c4mNBj9lNyKrtKKLExZyW1HVEZupg==
X-Received: by 2002:a05:6870:3652:b0:d3:4ada:37cb with SMTP id v18-20020a056870365200b000d34ada37cbmr5516789oak.328.1645674527359;
        Wed, 23 Feb 2022 19:48:47 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id gn26sm853445oab.24.2022.02.23.19.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 19:48:46 -0800 (PST)
Date:   Wed, 23 Feb 2022 21:48:45 -0600
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
Subject: Re: [PATCH v4 05/16] clk: qcom: gcc-ipq806x: convert parent_names to
 parent_data
Message-ID: <YhcAHQdtvSeROhT+@builder.lan>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-6-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217235703.26641-6-ansuelsmth@gmail.com>
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

> Convert parent_names to parent_data to modernize the driver.
> Where possible use parent_hws directly.
> 

Really nice to see this kind of cleanup. Unfortunately I have two
comments below.

> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq806x.c | 286 ++++++++++++++++++++-------------
>  1 file changed, 173 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> index 34cddf461dba..828383c30322 100644
> --- a/drivers/clk/qcom/gcc-ipq806x.c
> +++ b/drivers/clk/qcom/gcc-ipq806x.c
> @@ -25,6 +25,10 @@
>  #include "clk-hfpll.h"
>  #include "reset.h"
>  
> +static const struct clk_parent_data gcc_pxo[] = {
> +	{ .fw_name = "pxo" },

I expect that this will break booting these boards with existing dtb,
because there's not yet a clocks <&pxo_board> in the gcc node.

If you also add .name = "pxo" here that it should still fall back to map
to the board clock registered in gcc_ipq806x_probe() and once we have
passed 1-2 kernel releases we can clean out the old mapping.

> +};
> +
>  static struct clk_pll pll0 = {
>  	.l_reg = 0x30c4,
>  	.m_reg = 0x30c8,
> @@ -35,7 +39,7 @@ static struct clk_pll pll0 = {
>  	.status_bit = 16,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "pll0",
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = gcc_pxo,
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -46,7 +50,9 @@ static struct clk_regmap pll0_vote = {
>  	.enable_mask = BIT(0),
>  	.hw.init = &(struct clk_init_data){
>  		.name = "pll0_vote",
> -		.parent_names = (const char *[]){ "pll0" },
> +		.parent_hws = (const struct clk_hw*[]){
> +			&pll0.clkr.hw,
> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_vote_ops,
>  	},
> @@ -62,7 +68,7 @@ static struct clk_pll pll3 = {
>  	.status_bit = 16,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "pll3",
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = gcc_pxo,
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -89,7 +95,7 @@ static struct clk_pll pll8 = {
>  	.status_bit = 16,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "pll8",
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = gcc_pxo,
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -100,7 +106,9 @@ static struct clk_regmap pll8_vote = {
>  	.enable_mask = BIT(8),
>  	.hw.init = &(struct clk_init_data){
>  		.name = "pll8_vote",
> -		.parent_names = (const char *[]){ "pll8" },
> +		.parent_hws = (const struct clk_hw*[]){
> +			&pll8.clkr.hw,
> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_vote_ops,
>  	},
> @@ -123,7 +131,7 @@ static struct hfpll_data hfpll0_data = {
>  static struct clk_hfpll hfpll0 = {
>  	.d = &hfpll0_data,
>  	.clkr.hw.init = &(struct clk_init_data){
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = gcc_pxo,
>  		.num_parents = 1,
>  		.name = "hfpll0",
>  		.ops = &clk_ops_hfpll,
> @@ -149,7 +157,7 @@ static struct hfpll_data hfpll1_data = {
>  static struct clk_hfpll hfpll1 = {
>  	.d = &hfpll1_data,
>  	.clkr.hw.init = &(struct clk_init_data){
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = gcc_pxo,
>  		.num_parents = 1,
>  		.name = "hfpll1",
>  		.ops = &clk_ops_hfpll,
> @@ -175,7 +183,7 @@ static struct hfpll_data hfpll_l2_data = {
>  static struct clk_hfpll hfpll_l2 = {
>  	.d = &hfpll_l2_data,
>  	.clkr.hw.init = &(struct clk_init_data){
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = gcc_pxo,
>  		.num_parents = 1,
>  		.name = "hfpll_l2",
>  		.ops = &clk_ops_hfpll,
> @@ -194,7 +202,7 @@ static struct clk_pll pll14 = {
>  	.status_bit = 16,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "pll14",
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = gcc_pxo,
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -205,7 +213,9 @@ static struct clk_regmap pll14_vote = {
>  	.enable_mask = BIT(14),
>  	.hw.init = &(struct clk_init_data){
>  		.name = "pll14_vote",
> -		.parent_names = (const char *[]){ "pll14" },
> +		.parent_hws = (const struct clk_hw*[]){
> +			&pll14.clkr.hw,
> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_vote_ops,
>  	},
> @@ -238,7 +248,7 @@ static struct clk_pll pll18 = {
>  	.freq_tbl = pll18_freq_tbl,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "pll18",
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = gcc_pxo,
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -259,9 +269,9 @@ static const struct parent_map gcc_pxo_pll8_map[] = {
>  	{ P_PLL8, 3 }
>  };
>  
> -static const char * const gcc_pxo_pll8[] = {
> -	"pxo",
> -	"pll8_vote",
> +static const struct clk_parent_data gcc_pxo_pll8[] = {
> +	{ .fw_name = "pxo" },
> +	{ .hw = &pll8_vote.hw },
>  };
>  
>  static const struct parent_map gcc_pxo_pll8_cxo_map[] = {
> @@ -270,10 +280,10 @@ static const struct parent_map gcc_pxo_pll8_cxo_map[] = {
>  	{ P_CXO, 5 }
>  };
>  
> -static const char * const gcc_pxo_pll8_cxo[] = {
> -	"pxo",
> -	"pll8_vote",
> -	"cxo",
> +static const struct clk_parent_data gcc_pxo_pll8_cxo[] = {
> +	{ .fw_name = "pxo" },
> +	{ .hw = &pll8_vote.hw },
> +	{ .fw_name = "cxo" },

As with "pxo", I think you need a .name = "cxo" here as well.

Regards,
Bjorn
