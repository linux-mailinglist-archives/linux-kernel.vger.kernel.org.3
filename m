Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BD2492D96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348219AbiARSlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:41:31 -0500
Received: from relay01.th.seeweb.it ([5.144.164.162]:40781 "EHLO
        relay01.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348220AbiARSl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:41:26 -0500
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B9D9A1FAA6;
        Tue, 18 Jan 2022 19:41:20 +0100 (CET)
Date:   Tue, 18 Jan 2022 19:41:19 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/14] drivers: clk: qcom: gcc-ipq806x: convert
 parent_names to parent_data
Message-ID: <20220118184119.qzl4yanefjpmwkzi@SoMainline.org>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
 <20220118004434.17095-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118004434.17095-4-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-18 01:44:23, Ansuel Smith wrote:
> Convert parent_names to parent_data to modernize the driver.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq806x.c | 300 ++++++++++++++++++++-------------
>  1 file changed, 187 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> index 34cddf461dba..cbacd56f52d4 100644
> --- a/drivers/clk/qcom/gcc-ipq806x.c
> +++ b/drivers/clk/qcom/gcc-ipq806x.c
> @@ -35,7 +35,9 @@ static struct clk_pll pll0 = {
>  	.status_bit = 16,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "pll0",
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.fw_name = "pxo",
> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -46,7 +48,9 @@ static struct clk_regmap pll0_vote = {
>  	.enable_mask = BIT(0),
>  	.hw.init = &(struct clk_init_data){
>  		.name = "pll0_vote",
> -		.parent_names = (const char *[]){ "pll0" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.hw = &pll0.clkr.hw,

Much like the other "gcc modernization" patches referred to in the cover
letter, this could be converted to parent_hws directly instead of seeing
an intermediate clk_parent_data + .hw = state.  You can effectively
squash patch 06 into this and retitle.

- Marijn

> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_vote_ops,
>  	},
> @@ -62,7 +66,9 @@ static struct clk_pll pll3 = {
>  	.status_bit = 16,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "pll3",
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.fw_name = "pxo",
> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -89,7 +95,9 @@ static struct clk_pll pll8 = {
>  	.status_bit = 16,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "pll8",
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.fw_name = "pxo",
> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -100,7 +108,9 @@ static struct clk_regmap pll8_vote = {
>  	.enable_mask = BIT(8),
>  	.hw.init = &(struct clk_init_data){
>  		.name = "pll8_vote",
> -		.parent_names = (const char *[]){ "pll8" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.hw = &pll8.clkr.hw,
> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_vote_ops,
>  	},
> @@ -123,7 +133,9 @@ static struct hfpll_data hfpll0_data = {
>  static struct clk_hfpll hfpll0 = {
>  	.d = &hfpll0_data,
>  	.clkr.hw.init = &(struct clk_init_data){
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.fw_name = "pxo",
> +		},
>  		.num_parents = 1,
>  		.name = "hfpll0",
>  		.ops = &clk_ops_hfpll,
> @@ -149,7 +161,9 @@ static struct hfpll_data hfpll1_data = {
>  static struct clk_hfpll hfpll1 = {
>  	.d = &hfpll1_data,
>  	.clkr.hw.init = &(struct clk_init_data){
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.fw_name = "pxo",
> +		},
>  		.num_parents = 1,
>  		.name = "hfpll1",
>  		.ops = &clk_ops_hfpll,
> @@ -175,7 +189,9 @@ static struct hfpll_data hfpll_l2_data = {
>  static struct clk_hfpll hfpll_l2 = {
>  	.d = &hfpll_l2_data,
>  	.clkr.hw.init = &(struct clk_init_data){
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.fw_name = "pxo",
> +		},
>  		.num_parents = 1,
>  		.name = "hfpll_l2",
>  		.ops = &clk_ops_hfpll,
> @@ -194,7 +210,9 @@ static struct clk_pll pll14 = {
>  	.status_bit = 16,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "pll14",
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.fw_name = "pxo",
> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -205,7 +223,9 @@ static struct clk_regmap pll14_vote = {
>  	.enable_mask = BIT(14),
>  	.hw.init = &(struct clk_init_data){
>  		.name = "pll14_vote",
> -		.parent_names = (const char *[]){ "pll14" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.hw = &pll14.clkr.hw,
> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_vote_ops,
>  	},
> @@ -238,7 +258,9 @@ static struct clk_pll pll18 = {
>  	.freq_tbl = pll18_freq_tbl,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "pll18",
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.fw_name = "pxo",
> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -259,9 +281,9 @@ static const struct parent_map gcc_pxo_pll8_map[] = {
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
> @@ -270,10 +292,10 @@ static const struct parent_map gcc_pxo_pll8_cxo_map[] = {
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
>  };
>  
>  static const struct parent_map gcc_pxo_pll3_map[] = {
> @@ -286,9 +308,9 @@ static const struct parent_map gcc_pxo_pll3_sata_map[] = {
>  	{ P_PLL3, 6 }
>  };
>  
> -static const char * const gcc_pxo_pll3[] = {
> -	"pxo",
> -	"pll3",
> +static const struct clk_parent_data gcc_pxo_pll3[] = {
> +	{ .fw_name = "pxo" },
> +	{ .hw = &pll3.clkr.hw },
>  };
>  
>  static const struct parent_map gcc_pxo_pll8_pll0_map[] = {
> @@ -297,10 +319,10 @@ static const struct parent_map gcc_pxo_pll8_pll0_map[] = {
>  	{ P_PLL0, 2 }
>  };
>  
> -static const char * const gcc_pxo_pll8_pll0[] = {
> -	"pxo",
> -	"pll8_vote",
> -	"pll0_vote",
> +static const struct clk_parent_data gcc_pxo_pll8_pll0[] = {
> +	{ .fw_name = "pxo" },
> +	{ .hw = &pll8_vote.hw },
> +	{ .hw = &pll0_vote.hw },
>  };
>  
>  static const struct parent_map gcc_pxo_pll8_pll14_pll18_pll0_map[] = {
> @@ -311,12 +333,12 @@ static const struct parent_map gcc_pxo_pll8_pll14_pll18_pll0_map[] = {
>  	{ P_PLL18, 1 }
>  };
>  
> -static const char * const gcc_pxo_pll8_pll14_pll18_pll0[] = {
> -	"pxo",
> -	"pll8_vote",
> -	"pll0_vote",
> -	"pll14",
> -	"pll18",
> +static const struct clk_parent_data gcc_pxo_pll8_pll14_pll18_pll0[] = {
> +	{ .fw_name = "pxo" },
> +	{ .hw = &pll8_vote.hw },
> +	{ .hw = &pll0_vote.hw },
> +	{ .hw = &pll14.clkr.hw },
> +	{ .hw = &pll18.clkr.hw },
>  };
>  
>  static struct freq_tbl clk_tbl_gsbi_uart[] = {
> @@ -362,7 +384,7 @@ static struct clk_rcg gsbi1_uart_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi1_uart_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
> @@ -378,8 +400,8 @@ static struct clk_branch gsbi1_uart_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi1_uart_clk",
> -			.parent_names = (const char *[]){
> -				"gsbi1_uart_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gsbi1_uart_src.clkr.hw,
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
> @@ -413,7 +435,7 @@ static struct clk_rcg gsbi2_uart_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi2_uart_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
> @@ -429,8 +451,8 @@ static struct clk_branch gsbi2_uart_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi2_uart_clk",
> -			.parent_names = (const char *[]){
> -				"gsbi2_uart_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gsbi2_uart_src.clkr.hw,
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
> @@ -464,7 +486,7 @@ static struct clk_rcg gsbi4_uart_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi4_uart_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
> @@ -480,8 +502,8 @@ static struct clk_branch gsbi4_uart_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi4_uart_clk",
> -			.parent_names = (const char *[]){
> -				"gsbi4_uart_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gsbi4_uart_src.clkr.hw,
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
> @@ -515,7 +537,7 @@ static struct clk_rcg gsbi5_uart_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi5_uart_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
> @@ -531,8 +553,8 @@ static struct clk_branch gsbi5_uart_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi5_uart_clk",
> -			.parent_names = (const char *[]){
> -				"gsbi5_uart_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gsbi5_uart_src.clkr.hw,
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
> @@ -566,7 +588,7 @@ static struct clk_rcg gsbi6_uart_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi6_uart_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
> @@ -582,8 +604,8 @@ static struct clk_branch gsbi6_uart_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi6_uart_clk",
> -			.parent_names = (const char *[]){
> -				"gsbi6_uart_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gsbi6_uart_src.clkr.hw,
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
> @@ -617,7 +639,7 @@ static struct clk_rcg gsbi7_uart_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi7_uart_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
> @@ -633,8 +655,8 @@ static struct clk_branch gsbi7_uart_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi7_uart_clk",
> -			.parent_names = (const char *[]){
> -				"gsbi7_uart_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gsbi7_uart_src.clkr.hw,
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
> @@ -681,7 +703,7 @@ static struct clk_rcg gsbi1_qup_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi1_qup_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
> @@ -697,7 +719,9 @@ static struct clk_branch gsbi1_qup_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi1_qup_clk",
> -			.parent_names = (const char *[]){ "gsbi1_qup_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gsbi1_qup_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -730,7 +754,7 @@ static struct clk_rcg gsbi2_qup_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi2_qup_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
> @@ -746,7 +770,9 @@ static struct clk_branch gsbi2_qup_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi2_qup_clk",
> -			.parent_names = (const char *[]){ "gsbi2_qup_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gsbi2_qup_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -779,7 +805,7 @@ static struct clk_rcg gsbi4_qup_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi4_qup_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
> @@ -795,7 +821,9 @@ static struct clk_branch gsbi4_qup_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi4_qup_clk",
> -			.parent_names = (const char *[]){ "gsbi4_qup_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gsbi4_qup_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -828,7 +856,7 @@ static struct clk_rcg gsbi5_qup_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi5_qup_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
> @@ -844,7 +872,9 @@ static struct clk_branch gsbi5_qup_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi5_qup_clk",
> -			.parent_names = (const char *[]){ "gsbi5_qup_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gsbi5_qup_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -877,7 +907,7 @@ static struct clk_rcg gsbi6_qup_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi6_qup_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
> @@ -893,7 +923,9 @@ static struct clk_branch gsbi6_qup_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi6_qup_clk",
> -			.parent_names = (const char *[]){ "gsbi6_qup_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gsbi6_qup_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -926,7 +958,7 @@ static struct clk_rcg gsbi7_qup_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi7_qup_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
> @@ -942,7 +974,9 @@ static struct clk_branch gsbi7_qup_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gsbi7_qup_clk",
> -			.parent_names = (const char *[]){ "gsbi7_qup_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gsbi7_qup_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -1076,7 +1110,7 @@ static struct clk_rcg gp0_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gp0_src",
> -			.parent_names = gcc_pxo_pll8_cxo,
> +			.parent_data = gcc_pxo_pll8_cxo,
>  			.num_parents = 3,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_PARENT_GATE,
> @@ -1092,7 +1126,9 @@ static struct clk_branch gp0_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gp0_clk",
> -			.parent_names = (const char *[]){ "gp0_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gp0_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -1125,7 +1161,7 @@ static struct clk_rcg gp1_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gp1_src",
> -			.parent_names = gcc_pxo_pll8_cxo,
> +			.parent_data = gcc_pxo_pll8_cxo,
>  			.num_parents = 3,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> @@ -1141,7 +1177,9 @@ static struct clk_branch gp1_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gp1_clk",
> -			.parent_names = (const char *[]){ "gp1_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gp1_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -1174,7 +1212,7 @@ static struct clk_rcg gp2_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gp2_src",
> -			.parent_names = gcc_pxo_pll8_cxo,
> +			.parent_data = gcc_pxo_pll8_cxo,
>  			.num_parents = 3,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> @@ -1190,7 +1228,9 @@ static struct clk_branch gp2_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gp2_clk",
> -			.parent_names = (const char *[]){ "gp2_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gp2_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -1228,7 +1268,7 @@ static struct clk_rcg prng_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "prng_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  		},
> @@ -1244,7 +1284,9 @@ static struct clk_branch prng_clk = {
>  		.enable_mask = BIT(10),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "prng_clk",
> -			.parent_names = (const char *[]){ "prng_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &prng_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  		},
> @@ -1290,7 +1332,7 @@ static struct clk_rcg sdc1_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "sdc1_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  		},
> @@ -1305,7 +1347,9 @@ static struct clk_branch sdc1_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "sdc1_clk",
> -			.parent_names = (const char *[]){ "sdc1_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &sdc1_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -1338,7 +1382,7 @@ static struct clk_rcg sdc3_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "sdc3_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  		},
> @@ -1353,7 +1397,9 @@ static struct clk_branch sdc3_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "sdc3_clk",
> -			.parent_names = (const char *[]){ "sdc3_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &sdc3_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -1421,7 +1467,7 @@ static struct clk_rcg tsif_ref_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "tsif_ref_src",
> -			.parent_names = gcc_pxo_pll8,
> +			.parent_data = gcc_pxo_pll8,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  		},
> @@ -1436,7 +1482,9 @@ static struct clk_branch tsif_ref_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "tsif_ref_clk",
> -			.parent_names = (const char *[]){ "tsif_ref_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &tsif_ref_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -1583,7 +1631,7 @@ static struct clk_rcg pcie_ref_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "pcie_ref_src",
> -			.parent_names = gcc_pxo_pll3,
> +			.parent_data = gcc_pxo_pll3,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> @@ -1599,7 +1647,9 @@ static struct clk_branch pcie_ref_src_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "pcie_ref_src_clk",
> -			.parent_names = (const char *[]){ "pcie_ref_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &pcie_ref_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -1675,7 +1725,7 @@ static struct clk_rcg pcie1_ref_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "pcie1_ref_src",
> -			.parent_names = gcc_pxo_pll3,
> +			.parent_data = gcc_pxo_pll3,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> @@ -1691,7 +1741,9 @@ static struct clk_branch pcie1_ref_src_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "pcie1_ref_src_clk",
> -			.parent_names = (const char *[]){ "pcie1_ref_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &pcie1_ref_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -1767,7 +1819,7 @@ static struct clk_rcg pcie2_ref_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "pcie2_ref_src",
> -			.parent_names = gcc_pxo_pll3,
> +			.parent_data = gcc_pxo_pll3,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> @@ -1783,7 +1835,9 @@ static struct clk_branch pcie2_ref_src_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "pcie2_ref_src_clk",
> -			.parent_names = (const char *[]){ "pcie2_ref_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &pcie2_ref_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -1864,7 +1918,7 @@ static struct clk_rcg sata_ref_src = {
>  		.enable_mask = BIT(7),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "sata_ref_src",
> -			.parent_names = gcc_pxo_pll3,
> +			.parent_data = gcc_pxo_pll3,
>  			.num_parents = 2,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> @@ -1880,7 +1934,9 @@ static struct clk_branch sata_rxoob_clk = {
>  		.enable_mask = BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "sata_rxoob_clk",
> -			.parent_names = (const char *[]){ "sata_ref_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &sata_ref_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -1896,7 +1952,9 @@ static struct clk_branch sata_pmalive_clk = {
>  		.enable_mask = BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "sata_pmalive_clk",
> -			.parent_names = (const char *[]){ "sata_ref_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &sata_ref_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -1912,7 +1970,9 @@ static struct clk_branch sata_phy_ref_clk = {
>  		.enable_mask = BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "sata_phy_ref_clk",
> -			.parent_names = (const char *[]){ "pxo" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "pxo",
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  		},
> @@ -2001,7 +2061,7 @@ static struct clk_rcg usb30_master_clk_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb30_master_ref_src",
> -			.parent_names = gcc_pxo_pll8_pll0,
> +			.parent_data = gcc_pxo_pll8_pll0,
>  			.num_parents = 3,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> @@ -2017,7 +2077,9 @@ static struct clk_branch usb30_0_branch_clk = {
>  		.enable_mask = BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb30_0_branch_clk",
> -			.parent_names = (const char *[]){ "usb30_master_ref_src", },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &usb30_master_clk_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -2033,7 +2095,9 @@ static struct clk_branch usb30_1_branch_clk = {
>  		.enable_mask = BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb30_1_branch_clk",
> -			.parent_names = (const char *[]){ "usb30_master_ref_src", },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &usb30_master_clk_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -2071,7 +2135,7 @@ static struct clk_rcg usb30_utmi_clk = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb30_utmi_clk",
> -			.parent_names = gcc_pxo_pll8_pll0,
> +			.parent_data = gcc_pxo_pll8_pll0,
>  			.num_parents = 3,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> @@ -2087,7 +2151,9 @@ static struct clk_branch usb30_0_utmi_clk_ctl = {
>  		.enable_mask = BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb30_0_utmi_clk_ctl",
> -			.parent_names = (const char *[]){ "usb30_utmi_clk", },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &usb30_utmi_clk.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -2103,7 +2169,9 @@ static struct clk_branch usb30_1_utmi_clk_ctl = {
>  		.enable_mask = BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb30_1_utmi_clk_ctl",
> -			.parent_names = (const char *[]){ "usb30_utmi_clk", },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &usb30_utmi_clk.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -2141,7 +2209,7 @@ static struct clk_rcg usb_hs1_xcvr_clk_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb_hs1_xcvr_src",
> -			.parent_names = gcc_pxo_pll8_pll0,
> +			.parent_data = gcc_pxo_pll8_pll0,
>  			.num_parents = 3,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> @@ -2157,7 +2225,9 @@ static struct clk_branch usb_hs1_xcvr_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb_hs1_xcvr_clk",
> -			.parent_names = (const char *[]){ "usb_hs1_xcvr_src" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &usb_hs1_xcvr_clk_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -2205,7 +2275,7 @@ static struct clk_rcg usb_fs1_xcvr_clk_src = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb_fs1_xcvr_src",
> -			.parent_names = gcc_pxo_pll8_pll0,
> +			.parent_data = gcc_pxo_pll8_pll0,
>  			.num_parents = 3,
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
> @@ -2221,7 +2291,9 @@ static struct clk_branch usb_fs1_xcvr_clk = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb_fs1_xcvr_clk",
> -			.parent_names = (const char *[]){ "usb_fs1_xcvr_src", },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &usb_fs1_xcvr_clk_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -2237,7 +2309,9 @@ static struct clk_branch usb_fs1_sys_clk = {
>  		.enable_mask = BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "usb_fs1_sys_clk",
> -			.parent_names = (const char *[]){ "usb_fs1_xcvr_src", },
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &usb_fs1_xcvr_clk_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -2337,7 +2411,7 @@ static struct clk_dyn_rcg gmac_core1_src = {
>  		.enable_mask = BIT(1),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gmac_core1_src",
> -			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
> +			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
>  			.num_parents = 5,
>  			.ops = &clk_dyn_rcg_ops,
>  		},
> @@ -2354,8 +2428,8 @@ static struct clk_branch gmac_core1_clk = {
>  		.enable_mask = BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gmac_core1_clk",
> -			.parent_names = (const char *[]){
> -				"gmac_core1_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gmac_core1_src.clkr.hw,
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
> @@ -2409,7 +2483,7 @@ static struct clk_dyn_rcg gmac_core2_src = {
>  		.enable_mask = BIT(1),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gmac_core2_src",
> -			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
> +			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
>  			.num_parents = 5,
>  			.ops = &clk_dyn_rcg_ops,
>  		},
> @@ -2426,8 +2500,8 @@ static struct clk_branch gmac_core2_clk = {
>  		.enable_mask = BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gmac_core2_clk",
> -			.parent_names = (const char *[]){
> -				"gmac_core2_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gmac_core2_src.clkr.hw,
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
> @@ -2481,7 +2555,7 @@ static struct clk_dyn_rcg gmac_core3_src = {
>  		.enable_mask = BIT(1),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gmac_core3_src",
> -			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
> +			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
>  			.num_parents = 5,
>  			.ops = &clk_dyn_rcg_ops,
>  		},
> @@ -2498,8 +2572,8 @@ static struct clk_branch gmac_core3_clk = {
>  		.enable_mask = BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gmac_core3_clk",
> -			.parent_names = (const char *[]){
> -				"gmac_core3_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gmac_core3_src.clkr.hw,
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
> @@ -2553,7 +2627,7 @@ static struct clk_dyn_rcg gmac_core4_src = {
>  		.enable_mask = BIT(1),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gmac_core4_src",
> -			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
> +			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
>  			.num_parents = 5,
>  			.ops = &clk_dyn_rcg_ops,
>  		},
> @@ -2570,8 +2644,8 @@ static struct clk_branch gmac_core4_clk = {
>  		.enable_mask = BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gmac_core4_clk",
> -			.parent_names = (const char *[]){
> -				"gmac_core4_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &gmac_core4_src.clkr.hw,
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
> @@ -2613,7 +2687,7 @@ static struct clk_dyn_rcg nss_tcm_src = {
>  		.enable_mask = BIT(1),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "nss_tcm_src",
> -			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
> +			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
>  			.num_parents = 5,
>  			.ops = &clk_dyn_rcg_ops,
>  		},
> @@ -2628,8 +2702,8 @@ static struct clk_branch nss_tcm_clk = {
>  		.enable_mask = BIT(6) | BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "nss_tcm_clk",
> -			.parent_names = (const char *[]){
> -				"nss_tcm_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.hw = &nss_tcm_src.clkr.hw,
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
> @@ -2691,7 +2765,7 @@ static struct clk_dyn_rcg ubi32_core1_src_clk = {
>  		.enable_mask = BIT(1),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "ubi32_core1_src_clk",
> -			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
> +			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
>  			.num_parents = 5,
>  			.ops = &clk_dyn_rcg_ops,
>  			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> @@ -2744,7 +2818,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
>  		.enable_mask = BIT(1),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "ubi32_core2_src_clk",
> -			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
> +			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
>  			.num_parents = 5,
>  			.ops = &clk_dyn_rcg_ops,
>  			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> -- 
> 2.33.1
> 
