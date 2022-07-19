Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAC5579213
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbiGSEmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiGSEmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:42:36 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687E1275F0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:42:33 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10c0052da61so29269757fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DqxDvYEr+gB1MZ75zB/i+cJ3gbi/iImapHHEhKwMGp0=;
        b=ibNhcfjJMZvLgR3nla6KMgp+uR7V8fCYS5fevoTqT8+wrsdtFuoSyDOQKXc2bWcq7S
         KqwdbE3FUTT0f3+SAU2QUCgAfkY1LkTZ16T7US5/JoL2QfbbMctTwprDBPu65/K3SMku
         bO4YUdWXIEthXg5pVNFA0ia201pK/lMcecHMoKIwWmCRA8N7Zf7vpuE4NMgJJgH/xiN0
         DboSeoWjW21hm98XQOVHHOvzsZrhv81cAlOCBK+qpcGkZexwxLbAdMmqIekktpN+nlBs
         RHLVOwruGpn2PZdBwv3/635Dpa8gDNFI/eZHMxClzJgll17Pchl+r2qyEiAnqFWhoA57
         88Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DqxDvYEr+gB1MZ75zB/i+cJ3gbi/iImapHHEhKwMGp0=;
        b=51ExUxfgN9nQ0QOZ3mDTkMdw9YkZZSK9T5qSID5pzjTzUwapnBBpXJpKTZIHkQElhQ
         a3sp2D3YD0gzbCzjowFAVoCE5UUaRaQv75oZ3MIkVAvCbSjKRIWTgpHEkzKS75U6Nku9
         4gsPvstXh9d+5nvLORvev5TjPWobbk8BGDA1Et12qx1g2txDpLxHLsbHymAv5qfU8zq8
         Iw3vB8ZM+7F2rMc7qmcCPOndVsKIAZG3Ip67C1dcn22XYd+jVqIYcgwd8+bMnc7hlLi1
         B10sW4hBdpBbl4yIAP5YMkDTJV/DzVXpVggapjErlTA40lyVhi0QnE2yhVCQNdhIdvxh
         N58Q==
X-Gm-Message-State: AJIora8SDfIe1GXMsF2wz71mZEcMuFsK6yCensPzDBaOHbjTznPHPYOd
        +dNuhLQFNBVV8EIJaTe1DRHkawmXWCGm4w==
X-Google-Smtp-Source: AGRyM1vSEM/3Pj/hXG3oMIuKBibX32Ek9SiDnlmhmIhRnOyrXpIprygk5BgZf4AC9vuXkgx5Db9ZCw==
X-Received: by 2002:a05:6808:181e:b0:33a:6f26:f011 with SMTP id bh30-20020a056808181e00b0033a6f26f011mr4906731oib.57.1658205752593;
        Mon, 18 Jul 2022 21:42:32 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bu27-20020a0568300d1b00b0061b8653b0c9sm5905941otb.22.2022.07.18.21.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 21:42:31 -0700 (PDT)
Date:   Mon, 18 Jul 2022 23:42:29 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/3] clk: qcom: lcc-ipq806x: convert to parent data
Message-ID: <YtY2NWYq3Xbxu2pc@builder.lan>
References: <20220708000338.26572-1-ansuelsmth@gmail.com>
 <20220708000338.26572-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708000338.26572-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Jul 19:03 CDT 2022, Christian Marangi wrote:

> Convert lcc-ipq806x driver to parent_data API.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> v5:
> - Fix the same compilation error (don't know what the hell happen
>   to my buildroot)
> v4:
> - Fix compilation error
> v3:
>  - Inline pxo pll4 parent
>  - Change .name from pxo to pxo_board
> 
>  drivers/clk/qcom/lcc-ipq806x.c | 77 ++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
> index ba90bebba597..72d6aea5be30 100644
> --- a/drivers/clk/qcom/lcc-ipq806x.c
> +++ b/drivers/clk/qcom/lcc-ipq806x.c
> @@ -34,7 +34,9 @@ static struct clk_pll pll4 = {
>  	.status_bit = 16,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "pll4",
> -		.parent_names = (const char *[]){ "pxo" },
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "pxo", .name = "pxo_board",

This changes the behavior from looking for the globally named "pxo" to
look for the globally named "pxo_board", in the event that no
clock-names of "pxo" was found (based on the .fw_name).

So you probably want to keep this as .fw_name = "pxo", .name = "pxo".

> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -64,9 +66,9 @@ static const struct parent_map lcc_pxo_pll4_map[] = {
>  	{ P_PLL4, 2 }
>  };
>  
> -static const char * const lcc_pxo_pll4[] = {
> -	"pxo",
> -	"pll4_vote",
> +static const struct clk_parent_data lcc_pxo_pll4[] = {
> +	{ .fw_name = "pxo", .name = "pxo" },
> +	{ .fw_name = "pll4_vote", .name = "pll4_vote" },

This is a reference to a clock defined in this same driver, so you can
use { .hw = &pll4_vote.clkr.hw } to avoid the lookup all together.

>  };
>  
>  static struct freq_tbl clk_tbl_aif_mi2s[] = {
> @@ -131,18 +133,14 @@ static struct clk_rcg mi2s_osr_src = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "mi2s_osr_src",
> -			.parent_names = lcc_pxo_pll4,
> -			.num_parents = 2,
> +			.parent_data = lcc_pxo_pll4,
> +			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
>  		},
>  	},
>  };
>  
> -static const char * const lcc_mi2s_parents[] = {
> -	"mi2s_osr_src",
> -};
> -
>  static struct clk_branch mi2s_osr_clk = {
>  	.halt_reg = 0x50,
>  	.halt_bit = 1,
> @@ -152,7 +150,9 @@ static struct clk_branch mi2s_osr_clk = {
>  		.enable_mask = BIT(17),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "mi2s_osr_clk",
> -			.parent_names = lcc_mi2s_parents,
> +			.parent_hws = (const struct clk_hw*[]){
> +				&mi2s_osr_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -167,7 +167,9 @@ static struct clk_regmap_div mi2s_div_clk = {
>  	.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "mi2s_div_clk",
> -			.parent_names = lcc_mi2s_parents,
> +			.parent_hws = (const struct clk_hw*[]){

It would be wonderful if you could keep a space between ) and { in
these.

> +				&mi2s_osr_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_regmap_div_ops,
>  		},
> @@ -183,7 +185,9 @@ static struct clk_branch mi2s_bit_div_clk = {
>  		.enable_mask = BIT(15),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "mi2s_bit_div_clk",
> -			.parent_names = (const char *[]){ "mi2s_div_clk" },
> +			.parent_hws = (const struct clk_hw*[]){
> +				&mi2s_div_clk.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -191,6 +195,10 @@ static struct clk_branch mi2s_bit_div_clk = {
>  	},
>  };
>  
> +static const struct clk_parent_data lcc_mi2s_bit_div_codec_clk[] = {
> +	{ .hw = &mi2s_bit_div_clk.clkr.hw, },
> +	{ .fw_name = "mi2s_codec_clk", .name = "mi2s_codec_clk" },

Is mi2s_codec_clk and external clock? I don't see it documented in the
DT binding. And if we're introducing new clock-names, perhaps we could
skip the _clk suffix - because obviously it's a clock :)

Regards,
Bjorn

> +};
>  
>  static struct clk_regmap_mux mi2s_bit_clk = {
>  	.reg = 0x48,
> @@ -199,11 +207,8 @@ static struct clk_regmap_mux mi2s_bit_clk = {
>  	.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "mi2s_bit_clk",
> -			.parent_names = (const char *[]){
> -				"mi2s_bit_div_clk",
> -				"mi2s_codec_clk",
> -			},
> -			.num_parents = 2,
> +			.parent_data = lcc_mi2s_bit_div_codec_clk,
> +			.num_parents = ARRAY_SIZE(lcc_mi2s_bit_div_codec_clk),
>  			.ops = &clk_regmap_mux_closest_ops,
>  			.flags = CLK_SET_RATE_PARENT,
>  		},
> @@ -245,8 +250,8 @@ static struct clk_rcg pcm_src = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "pcm_src",
> -			.parent_names = lcc_pxo_pll4,
> -			.num_parents = 2,
> +			.parent_data = lcc_pxo_pll4,
> +			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
>  		},
> @@ -262,7 +267,9 @@ static struct clk_branch pcm_clk_out = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "pcm_clk_out",
> -			.parent_names = (const char *[]){ "pcm_src" },
> +			.parent_hws = (const struct clk_hw*[]){
> +				&pcm_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -270,6 +277,11 @@ static struct clk_branch pcm_clk_out = {
>  	},
>  };
>  
> +static const struct clk_parent_data lcc_pcm_clk_out_codec_clk[] = {
> +	{ .hw = &pcm_clk_out.clkr.hw, },
> +	{ .fw_name = "pcm_codec_clk", .name = "pcm_codec_clk" },
> +};
> +
>  static struct clk_regmap_mux pcm_clk = {
>  	.reg = 0x54,
>  	.shift = 10,
> @@ -277,11 +289,8 @@ static struct clk_regmap_mux pcm_clk = {
>  	.clkr = {
>  		.hw.init = &(struct clk_init_data){
>  			.name = "pcm_clk",
> -			.parent_names = (const char *[]){
> -				"pcm_clk_out",
> -				"pcm_codec_clk",
> -			},
> -			.num_parents = 2,
> +			.parent_data = lcc_pcm_clk_out_codec_clk,
> +			.num_parents = ARRAY_SIZE(lcc_pcm_clk_out_codec_clk),
>  			.ops = &clk_regmap_mux_closest_ops,
>  			.flags = CLK_SET_RATE_PARENT,
>  		},
> @@ -325,18 +334,14 @@ static struct clk_rcg spdif_src = {
>  		.enable_mask = BIT(9),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "spdif_src",
> -			.parent_names = lcc_pxo_pll4,
> -			.num_parents = 2,
> +			.parent_data = lcc_pxo_pll4,
> +			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
>  			.ops = &clk_rcg_ops,
>  			.flags = CLK_SET_RATE_GATE,
>  		},
>  	},
>  };
>  
> -static const char * const lcc_spdif_parents[] = {
> -	"spdif_src",
> -};
> -
>  static struct clk_branch spdif_clk = {
>  	.halt_reg = 0xd4,
>  	.halt_bit = 1,
> @@ -346,7 +351,9 @@ static struct clk_branch spdif_clk = {
>  		.enable_mask = BIT(12),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "spdif_clk",
> -			.parent_names = lcc_spdif_parents,
> +			.parent_hws = (const struct clk_hw*[]){
> +				&spdif_src.clkr.hw,
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch_ops,
>  			.flags = CLK_SET_RATE_PARENT,
> @@ -384,8 +391,8 @@ static struct clk_rcg ahbix_clk = {
>  		.enable_mask = BIT(11),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "ahbix",
> -			.parent_names = lcc_pxo_pll4,
> -			.num_parents = 2,
> +			.parent_data = lcc_pxo_pll4,
> +			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
>  			.ops = &clk_rcg_lcc_ops,
>  		},
>  	},
> -- 
> 2.36.1
> 
