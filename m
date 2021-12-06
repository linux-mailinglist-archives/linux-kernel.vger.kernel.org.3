Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8046246A0E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385759AbhLFQRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359329AbhLFQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:16:28 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D6CC09B056
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:02:21 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id t19so22313365oij.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 08:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5ehRZ3e6YydzKEdH5dihrftPgsniO5TK+pWDJIrByyY=;
        b=wbb36U0aYnmyVW7YYAYJAjVdStOzQWywsWY+Pqpwy+VoupgtSUeeIu/Z6tvjtbxr3R
         gLi8AM5EXhltE3yIngjvbtTemuQ1AdrV779MCB7wr2rP7/YdcGZrt7d5OBJ3c6YzUugg
         9J3BE6nNMBMIebjNiiF+XjmGeYmlcHVqe+GGp3kIrcsojhCM5wXhhFGm1EpU8OiG5JUu
         uv77mb0/v+lvBRj0Eu4jCug+BP4mZ0uqdePzN7ZOwtFSbtuG4Zkj3SS2mfMhh2pwV6mP
         1x7vibc22OXxImjcaVsDmeogOpNEgobRjjygXVAQ11BA0sGBipZzrvNKAcEE4MB2DDI8
         AjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ehRZ3e6YydzKEdH5dihrftPgsniO5TK+pWDJIrByyY=;
        b=OkVOaRt6Qcd38ZMaB9kqF4NVPdhnEJ7Cj4D0vzSpK92X6x8zBf8sxXSeBMzgf5s0ox
         AkSIUpOw2u189FpdEdmPJjEsKZ74P7knhaaXL5Bl16KhcMDRIDj3Ie5TEahN4xV+tpai
         ci1Rze/7SGXPVVnkW1XfDcvFL1LgZDnJVvesyi0/HUMGAHCrOmtJFmJywIJ6+Dkuk6I/
         a2cpcYmQjkuhYYYGlAoPuqIz6MhCXW/fXw4V2pbkOu1MqWpdkda51YPn5HPyfOw5HPTL
         wexDiHvhsbRg/zGwelknKfhwiNoAOQctybKBmm9zepbeQfELpR1XYCvrRQOQaNEoiVlb
         FN8A==
X-Gm-Message-State: AOAM532hbDD3rMmglDMxvvTgulYIoWsGFRe/PQGqHv2vzHNRwRH9nkJ1
        aVDiyQRClXUoo+DgFVIi6zPMCg==
X-Google-Smtp-Source: ABdhPJx2VF3KeCNWIo/D/xsrhaomIyVigspEvtrXLGFEEdvgZ5UtNlBKu0yCRzRphozsoC8i1yCQCA==
X-Received: by 2002:a05:6808:682:: with SMTP id k2mr25664378oig.63.1638806539621;
        Mon, 06 Dec 2021 08:02:19 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w18sm2267167otm.1.2021.12.06.08.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:02:19 -0800 (PST)
Date:   Mon, 6 Dec 2021 10:02:15 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc:     linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-msm8974: Modernize the driver
Message-ID: <Ya40B1QkGmWmhSUX@builder.lan>
References: <20211118153107.8590-1-ivo.ivanov.ivanov1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118153107.8590-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18 Nov 09:31 CST 2021, Ivaylo Ivanov wrote:

> Switch to the newer-style parent_data, use ARRAY_SIZE()
> for num_parents. Add .name to every xo and sleep clock
> reference to ensure it's still compatible with old DTs.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
> Resent due to issues with my old email ivo.ivanov@disroot.org
>  drivers/clk/qcom/gcc-msm8974.c | 640 +++++++++++++--------------------
>  1 file changed, 253 insertions(+), 387 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8974.c b/drivers/clk/qcom/gcc-msm8974.c
> index bf305fa9e522..53d500adc5c3 100644
> --- a/drivers/clk/qcom/gcc-msm8974.c
> +++ b/drivers/clk/qcom/gcc-msm8974.c
> @@ -32,28 +32,6 @@ enum {
>  	P_GPLL4,
>  };
>  
> -static const struct parent_map gcc_xo_gpll0_map[] = {
> -	{ P_XO, 0 },
> -	{ P_GPLL0, 1 }
> -};
> -
> -static const char * const gcc_xo_gpll0[] = {
> -	"xo",
> -	"gpll0_vote",
> -};
> -
> -static const struct parent_map gcc_xo_gpll0_gpll4_map[] = {
> -	{ P_XO, 0 },
> -	{ P_GPLL0, 1 },
> -	{ P_GPLL4, 5 }
> -};
> -
> -static const char * const gcc_xo_gpll0_gpll4[] = {
> -	"xo",
> -	"gpll0_vote",
> -	"gpll4_vote",
> -};
> -
>  static struct clk_pll gpll0 = {
>  	.l_reg = 0x0004,
>  	.m_reg = 0x0008,
> @@ -64,7 +42,10 @@ static struct clk_pll gpll0 = {
>  	.status_bit = 17,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "gpll0",
> -		.parent_names = (const char *[]){ "xo" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.fw_name = "xo_board",
> +			.name = "xo_board",

"xo_board" is actually the crystal feeding the PMIC with a reference
clock, of interest here is that this is split up in the 2 digital and 3
analog RPM_SMD_CX_{Dx,Ay} clocks. Out of these you have RPM_SMD_CXO_D0
being wired up on the CXO pin on the msm8974.

Back when this was devices we didn't have the means of dealing with
rpmcc as parent to gcc, so you can in gcc_msm8974_probe() find the
registration of a clock "xo" which is a 19.2MHz clock parented by
"xo_board".

As such, the appropriate .name here would be "xo".

Likewise "xo" (or actually "cxo") would be a better name for the
DT-based input clock - and it should point to &rpmcc RPM_SMD_CXO_D0
(iiuc).


The rest looks good.

Thanks,
Bjorn

> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -75,20 +56,30 @@ static struct clk_regmap gpll0_vote = {
>  	.enable_mask = BIT(0),
>  	.hw.init = &(struct clk_init_data){
>  		.name = "gpll0_vote",
> -		.parent_names = (const char *[]){ "gpll0" },
> +		.parent_hws = (const struct clk_hw *[]){ &gpll0.clkr.hw },
>  		.num_parents = 1,
>  		.ops = &clk_pll_vote_ops,
>  	},
>  };
>  
> +static const struct parent_map gcc_xo_gpll0_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL0, 1 }
> +};
> +
> +static const struct clk_parent_data gcc_xo_gpll0[] = {
> +	{ .fw_name = "xo_board", .name = "xo_board" },
> +	{ .hw = &gpll0.clkr.hw },
> +};
> +
>  static struct clk_rcg2 config_noc_clk_src = {
>  	.cmd_rcgr = 0x0150,
>  	.hid_width = 5,
>  	.parent_map = gcc_xo_gpll0_map,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "config_noc_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -99,8 +90,8 @@ static struct clk_rcg2 periph_noc_clk_src = {
>  	.parent_map = gcc_xo_gpll0_map,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "periph_noc_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -111,8 +102,8 @@ static struct clk_rcg2 system_noc_clk_src = {
>  	.parent_map = gcc_xo_gpll0_map,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "system_noc_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -127,7 +118,10 @@ static struct clk_pll gpll1 = {
>  	.status_bit = 17,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "gpll1",
> -		.parent_names = (const char *[]){ "xo" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.fw_name = "xo_board",
> +			.name = "xo_board",
> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -138,7 +132,7 @@ static struct clk_regmap gpll1_vote = {
>  	.enable_mask = BIT(1),
>  	.hw.init = &(struct clk_init_data){
>  		.name = "gpll1_vote",
> -		.parent_names = (const char *[]){ "gpll1" },
> +		.parent_hws = (const struct clk_hw *[]){ &gpll1.clkr.hw },
>  		.num_parents = 1,
>  		.ops = &clk_pll_vote_ops,
>  	},
> @@ -154,7 +148,10 @@ static struct clk_pll gpll4 = {
>  	.status_bit = 17,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "gpll4",
> -		.parent_names = (const char *[]){ "xo" },
> +		.parent_data = &(const struct clk_parent_data){
> +			.fw_name = "xo_board",
> +			.name = "xo_board",
> +		},
>  		.num_parents = 1,
>  		.ops = &clk_pll_ops,
>  	},
> @@ -165,12 +162,24 @@ static struct clk_regmap gpll4_vote = {
>  	.enable_mask = BIT(4),
>  	.hw.init = &(struct clk_init_data){
>  		.name = "gpll4_vote",
> -		.parent_names = (const char *[]){ "gpll4" },
> +		.parent_hws = (const struct clk_hw *[]){ &gpll4.clkr.hw },
>  		.num_parents = 1,
>  		.ops = &clk_pll_vote_ops,
>  	},
>  };
>  
> +static const struct parent_map gcc_xo_gpll0_gpll4_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL0, 1 },
> +	{ P_GPLL4, 5 }
> +};
> +
> +static const struct clk_parent_data gcc_xo_gpll0_gpll4[] = {
> +	{ .fw_name = "xo_board", .name = "xo_board" },
> +	{ .hw = &gpll0.clkr.hw },
> +	{ .hw = &gpll4.clkr.hw },
> +};
> +
>  static const struct freq_tbl ftbl_gcc_usb30_master_clk[] = {
>  	F(125000000, P_GPLL0, 1, 5, 24),
>  	{ }
> @@ -184,8 +193,8 @@ static struct clk_rcg2 usb30_master_clk_src = {
>  	.freq_tbl = ftbl_gcc_usb30_master_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "usb30_master_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -204,8 +213,8 @@ static struct clk_rcg2 blsp1_qup1_i2c_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_i2c_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_qup1_i2c_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -229,8 +238,8 @@ static struct clk_rcg2 blsp1_qup1_spi_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_spi_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_qup1_spi_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -242,8 +251,8 @@ static struct clk_rcg2 blsp1_qup2_i2c_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_i2c_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_qup2_i2c_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -256,8 +265,8 @@ static struct clk_rcg2 blsp1_qup2_spi_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_spi_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_qup2_spi_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -269,8 +278,8 @@ static struct clk_rcg2 blsp1_qup3_i2c_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_i2c_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_qup3_i2c_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -283,8 +292,8 @@ static struct clk_rcg2 blsp1_qup3_spi_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_spi_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_qup3_spi_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -296,8 +305,8 @@ static struct clk_rcg2 blsp1_qup4_i2c_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_i2c_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_qup4_i2c_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -310,8 +319,8 @@ static struct clk_rcg2 blsp1_qup4_spi_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_spi_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_qup4_spi_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -323,8 +332,8 @@ static struct clk_rcg2 blsp1_qup5_i2c_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_i2c_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_qup5_i2c_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -337,8 +346,8 @@ static struct clk_rcg2 blsp1_qup5_spi_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_spi_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_qup5_spi_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -350,8 +359,8 @@ static struct clk_rcg2 blsp1_qup6_i2c_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_i2c_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_qup6_i2c_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -364,8 +373,8 @@ static struct clk_rcg2 blsp1_qup6_spi_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_spi_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_qup6_spi_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -397,8 +406,8 @@ static struct clk_rcg2 blsp1_uart1_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_uart1_6_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_uart1_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -411,8 +420,8 @@ static struct clk_rcg2 blsp1_uart2_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_uart1_6_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_uart2_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -425,8 +434,8 @@ static struct clk_rcg2 blsp1_uart3_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_uart1_6_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_uart3_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -439,8 +448,8 @@ static struct clk_rcg2 blsp1_uart4_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_uart1_6_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_uart4_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -453,8 +462,8 @@ static struct clk_rcg2 blsp1_uart5_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_uart1_6_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_uart5_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -467,8 +476,8 @@ static struct clk_rcg2 blsp1_uart6_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_uart1_6_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp1_uart6_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -480,8 +489,8 @@ static struct clk_rcg2 blsp2_qup1_i2c_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_i2c_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_qup1_i2c_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -494,8 +503,8 @@ static struct clk_rcg2 blsp2_qup1_spi_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_spi_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_qup1_spi_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -507,8 +516,8 @@ static struct clk_rcg2 blsp2_qup2_i2c_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_i2c_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_qup2_i2c_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -521,8 +530,8 @@ static struct clk_rcg2 blsp2_qup2_spi_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_spi_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_qup2_spi_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -534,8 +543,8 @@ static struct clk_rcg2 blsp2_qup3_i2c_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_i2c_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_qup3_i2c_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -548,8 +557,8 @@ static struct clk_rcg2 blsp2_qup3_spi_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_spi_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_qup3_spi_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -561,8 +570,8 @@ static struct clk_rcg2 blsp2_qup4_i2c_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_i2c_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_qup4_i2c_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -575,8 +584,8 @@ static struct clk_rcg2 blsp2_qup4_spi_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_spi_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_qup4_spi_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -588,8 +597,8 @@ static struct clk_rcg2 blsp2_qup5_i2c_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_i2c_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_qup5_i2c_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -602,8 +611,8 @@ static struct clk_rcg2 blsp2_qup5_spi_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_spi_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_qup5_spi_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -615,8 +624,8 @@ static struct clk_rcg2 blsp2_qup6_i2c_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_i2c_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_qup6_i2c_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -629,8 +638,8 @@ static struct clk_rcg2 blsp2_qup6_spi_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_qup1_6_spi_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_qup6_spi_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -643,8 +652,8 @@ static struct clk_rcg2 blsp2_uart1_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_uart1_6_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_uart1_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -657,8 +666,8 @@ static struct clk_rcg2 blsp2_uart2_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_uart1_6_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_uart2_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -671,8 +680,8 @@ static struct clk_rcg2 blsp2_uart3_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_uart1_6_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_uart3_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -685,8 +694,8 @@ static struct clk_rcg2 blsp2_uart4_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_uart1_6_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_uart4_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -699,8 +708,8 @@ static struct clk_rcg2 blsp2_uart5_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_uart1_6_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_uart5_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -713,8 +722,8 @@ static struct clk_rcg2 blsp2_uart6_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_blsp1_2_uart1_6_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "blsp2_uart6_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -740,8 +749,8 @@ static struct clk_rcg2 ce1_clk_src = {
>  	.freq_tbl = ftbl_gcc_ce1_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "ce1_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -761,8 +770,8 @@ static struct clk_rcg2 ce2_clk_src = {
>  	.freq_tbl = ftbl_gcc_ce2_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "ce2_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -793,8 +802,8 @@ static struct clk_rcg2 gp1_clk_src = {
>  	.freq_tbl = ftbl_gcc_gp_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "gp1_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -807,8 +816,8 @@ static struct clk_rcg2 gp2_clk_src = {
>  	.freq_tbl = ftbl_gcc_gp_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "gp2_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -821,8 +830,8 @@ static struct clk_rcg2 gp3_clk_src = {
>  	.freq_tbl = ftbl_gcc_gp_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "gp3_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -839,8 +848,8 @@ static struct clk_rcg2 pdm2_clk_src = {
>  	.freq_tbl = ftbl_gcc_pdm2_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "pdm2_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -871,8 +880,8 @@ static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_pro[] = {
>  
>  static struct clk_init_data sdcc1_apps_clk_src_init = {
>  	.name = "sdcc1_apps_clk_src",
> -	.parent_names = gcc_xo_gpll0,
> -	.num_parents = 2,
> +	.parent_data = gcc_xo_gpll0,
> +	.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  	.ops = &clk_rcg2_floor_ops,
>  };
>  
> @@ -893,8 +902,8 @@ static struct clk_rcg2 sdcc2_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_sdcc1_4_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "sdcc2_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_floor_ops,
>  	},
>  };
> @@ -907,8 +916,8 @@ static struct clk_rcg2 sdcc3_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_sdcc1_4_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "sdcc3_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_floor_ops,
>  	},
>  };
> @@ -921,8 +930,8 @@ static struct clk_rcg2 sdcc4_apps_clk_src = {
>  	.freq_tbl = ftbl_gcc_sdcc1_4_apps_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "sdcc4_apps_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_floor_ops,
>  	},
>  };
> @@ -940,8 +949,8 @@ static struct clk_rcg2 tsif_ref_clk_src = {
>  	.freq_tbl = ftbl_gcc_tsif_ref_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "tsif_ref_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -958,8 +967,8 @@ static struct clk_rcg2 usb30_mock_utmi_clk_src = {
>  	.freq_tbl = ftbl_gcc_usb30_mock_utmi_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "usb30_mock_utmi_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -977,8 +986,8 @@ static struct clk_rcg2 usb_hs_system_clk_src = {
>  	.freq_tbl = ftbl_gcc_usb_hs_system_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "usb_hs_system_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -993,6 +1002,11 @@ static const struct parent_map usb_hsic_clk_src_map[] = {
>  	{ P_GPLL1, 4 }
>  };
>  
> +static const struct clk_parent_data gcc_xo_gpll1_vote[] = {
> +	{ .fw_name = "xo_board", .name = "xo_board" },
> +	{ .hw = &gpll1_vote.hw },
> +};
> +
>  static struct clk_rcg2 usb_hsic_clk_src = {
>  	.cmd_rcgr = 0x0440,
>  	.hid_width = 5,
> @@ -1000,10 +1014,7 @@ static struct clk_rcg2 usb_hsic_clk_src = {
>  	.freq_tbl = ftbl_gcc_usb_hsic_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "usb_hsic_clk_src",
> -		.parent_names = (const char *[]){
> -			"xo",
> -			"gpll1_vote",
> -		},
> +		.parent_data = gcc_xo_gpll1_vote,
>  		.num_parents = 2,
>  		.ops = &clk_rcg2_ops,
>  	},
> @@ -1021,8 +1032,8 @@ static struct clk_rcg2 usb_hsic_io_cal_clk_src = {
>  	.freq_tbl = ftbl_gcc_usb_hsic_io_cal_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "usb_hsic_io_cal_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 1,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -1040,8 +1051,8 @@ static struct clk_rcg2 usb_hsic_system_clk_src = {
>  	.freq_tbl = ftbl_gcc_usb_hsic_system_clk,
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "usb_hsic_system_clk_src",
> -		.parent_names = gcc_xo_gpll0,
> -		.num_parents = 2,
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
>  		.ops = &clk_rcg2_ops,
>  	},
>  };
> @@ -1051,9 +1062,7 @@ static struct clk_regmap gcc_mmss_gpll0_clk_src = {
>  	.enable_mask = BIT(26),
>  	.hw.init = &(struct clk_init_data){
>  		.name = "mmss_gpll0_vote",
> -		.parent_names = (const char *[]){
> -			"gpll0_vote",
> -		},
> +		.parent_hws = (const struct clk_hw *[]){ &gpll0_vote.hw },
>  		.num_parents = 1,
>  		.ops = &clk_branch_simple_ops,
>  	},
> @@ -1067,9 +1076,7 @@ static struct clk_branch gcc_bam_dma_ahb_clk = {
>  		.enable_mask = BIT(12),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_bam_dma_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"periph_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &periph_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -1084,9 +1091,7 @@ static struct clk_branch gcc_blsp1_ahb_clk = {
>  		.enable_mask = BIT(17),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"periph_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &periph_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -1100,9 +1105,7 @@ static struct clk_branch gcc_blsp1_qup1_i2c_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_qup1_i2c_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_qup1_i2c_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_qup1_i2c_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1117,9 +1120,7 @@ static struct clk_branch gcc_blsp1_qup1_spi_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_qup1_spi_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_qup1_spi_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_qup1_spi_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1134,9 +1135,7 @@ static struct clk_branch gcc_blsp1_qup2_i2c_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_qup2_i2c_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_qup2_i2c_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_qup2_i2c_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1151,9 +1150,7 @@ static struct clk_branch gcc_blsp1_qup2_spi_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_qup2_spi_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_qup2_spi_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_qup2_spi_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1168,9 +1165,7 @@ static struct clk_branch gcc_blsp1_qup3_i2c_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_qup3_i2c_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_qup3_i2c_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_qup3_i2c_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1185,9 +1180,7 @@ static struct clk_branch gcc_blsp1_qup3_spi_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_qup3_spi_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_qup3_spi_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_qup3_spi_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1202,9 +1195,7 @@ static struct clk_branch gcc_blsp1_qup4_i2c_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_qup4_i2c_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_qup4_i2c_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_qup4_i2c_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1219,9 +1210,7 @@ static struct clk_branch gcc_blsp1_qup4_spi_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_qup4_spi_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_qup4_spi_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_qup4_spi_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1236,9 +1225,7 @@ static struct clk_branch gcc_blsp1_qup5_i2c_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_qup5_i2c_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_qup5_i2c_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_qup5_i2c_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1253,9 +1240,7 @@ static struct clk_branch gcc_blsp1_qup5_spi_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_qup5_spi_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_qup5_spi_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_qup5_spi_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1270,9 +1255,7 @@ static struct clk_branch gcc_blsp1_qup6_i2c_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_qup6_i2c_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_qup6_i2c_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_qup6_i2c_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1287,9 +1270,7 @@ static struct clk_branch gcc_blsp1_qup6_spi_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_qup6_spi_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_qup6_spi_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_qup6_spi_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1304,9 +1285,7 @@ static struct clk_branch gcc_blsp1_uart1_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_uart1_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_uart1_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_uart1_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1321,9 +1300,7 @@ static struct clk_branch gcc_blsp1_uart2_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_uart2_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_uart2_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_uart2_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1338,9 +1315,7 @@ static struct clk_branch gcc_blsp1_uart3_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_uart3_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_uart3_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_uart3_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1355,9 +1330,7 @@ static struct clk_branch gcc_blsp1_uart4_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_uart4_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_uart4_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_uart4_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1372,9 +1345,7 @@ static struct clk_branch gcc_blsp1_uart5_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_uart5_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_uart5_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_uart5_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1389,9 +1360,7 @@ static struct clk_branch gcc_blsp1_uart6_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_uart6_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp1_uart6_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp1_uart6_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1407,9 +1376,7 @@ static struct clk_branch gcc_blsp2_ahb_clk = {
>  		.enable_mask = BIT(15),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"periph_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &periph_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -1423,9 +1390,7 @@ static struct clk_branch gcc_blsp2_qup1_i2c_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_qup1_i2c_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_qup1_i2c_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_qup1_i2c_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1440,9 +1405,7 @@ static struct clk_branch gcc_blsp2_qup1_spi_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_qup1_spi_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_qup1_spi_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_qup1_spi_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1457,9 +1420,7 @@ static struct clk_branch gcc_blsp2_qup2_i2c_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_qup2_i2c_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_qup2_i2c_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_qup2_i2c_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1474,9 +1435,7 @@ static struct clk_branch gcc_blsp2_qup2_spi_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_qup2_spi_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_qup2_spi_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_qup2_spi_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1491,9 +1450,7 @@ static struct clk_branch gcc_blsp2_qup3_i2c_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_qup3_i2c_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_qup3_i2c_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_qup3_i2c_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1508,9 +1465,7 @@ static struct clk_branch gcc_blsp2_qup3_spi_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_qup3_spi_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_qup3_spi_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_qup3_spi_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1525,9 +1480,7 @@ static struct clk_branch gcc_blsp2_qup4_i2c_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_qup4_i2c_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_qup4_i2c_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_qup4_i2c_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1542,9 +1495,7 @@ static struct clk_branch gcc_blsp2_qup4_spi_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_qup4_spi_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_qup4_spi_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_qup4_spi_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1559,9 +1510,7 @@ static struct clk_branch gcc_blsp2_qup5_i2c_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_qup5_i2c_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_qup5_i2c_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_qup5_i2c_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1576,9 +1525,7 @@ static struct clk_branch gcc_blsp2_qup5_spi_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_qup5_spi_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_qup5_spi_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_qup5_spi_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1593,9 +1540,7 @@ static struct clk_branch gcc_blsp2_qup6_i2c_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_qup6_i2c_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_qup6_i2c_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_qup6_i2c_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1610,9 +1555,7 @@ static struct clk_branch gcc_blsp2_qup6_spi_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_qup6_spi_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_qup6_spi_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_qup6_spi_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1627,9 +1570,7 @@ static struct clk_branch gcc_blsp2_uart1_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_uart1_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_uart1_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_uart1_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1644,9 +1585,7 @@ static struct clk_branch gcc_blsp2_uart2_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_uart2_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_uart2_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_uart2_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1661,9 +1600,7 @@ static struct clk_branch gcc_blsp2_uart3_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_uart3_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_uart3_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_uart3_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1678,9 +1615,7 @@ static struct clk_branch gcc_blsp2_uart4_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_uart4_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_uart4_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_uart4_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1695,9 +1630,7 @@ static struct clk_branch gcc_blsp2_uart5_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_uart5_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_uart5_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_uart5_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1712,9 +1645,7 @@ static struct clk_branch gcc_blsp2_uart6_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_uart6_apps_clk",
> -			.parent_names = (const char *[]){
> -				"blsp2_uart6_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &blsp2_uart6_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1730,9 +1661,7 @@ static struct clk_branch gcc_boot_rom_ahb_clk = {
>  		.enable_mask = BIT(10),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_boot_rom_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"config_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &config_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -1747,9 +1676,7 @@ static struct clk_branch gcc_ce1_ahb_clk = {
>  		.enable_mask = BIT(3),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_ce1_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"config_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &config_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -1764,9 +1691,7 @@ static struct clk_branch gcc_ce1_axi_clk = {
>  		.enable_mask = BIT(4),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_ce1_axi_clk",
> -			.parent_names = (const char *[]){
> -				"system_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &system_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -1781,9 +1706,7 @@ static struct clk_branch gcc_ce1_clk = {
>  		.enable_mask = BIT(5),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_ce1_clk",
> -			.parent_names = (const char *[]){
> -				"ce1_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &ce1_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1799,9 +1722,7 @@ static struct clk_branch gcc_ce2_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_ce2_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"config_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &config_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -1816,9 +1737,7 @@ static struct clk_branch gcc_ce2_axi_clk = {
>  		.enable_mask = BIT(1),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_ce2_axi_clk",
> -			.parent_names = (const char *[]){
> -				"system_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &system_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -1833,9 +1752,7 @@ static struct clk_branch gcc_ce2_clk = {
>  		.enable_mask = BIT(2),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_ce2_clk",
> -			.parent_names = (const char *[]){
> -				"ce2_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &ce2_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1850,9 +1767,7 @@ static struct clk_branch gcc_gp1_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_gp1_clk",
> -			.parent_names = (const char *[]){
> -				"gp1_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &gp1_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1867,9 +1782,7 @@ static struct clk_branch gcc_gp2_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_gp2_clk",
> -			.parent_names = (const char *[]){
> -				"gp2_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &gp2_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1884,9 +1797,7 @@ static struct clk_branch gcc_gp3_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_gp3_clk",
> -			.parent_names = (const char *[]){
> -				"gp3_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &gp3_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1901,9 +1812,7 @@ static struct clk_branch gcc_lpass_q6_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_lpass_q6_axi_clk",
> -			.parent_names = (const char *[]){
> -				"system_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &system_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -1917,9 +1826,7 @@ static struct clk_branch gcc_mmss_noc_cfg_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_mmss_noc_cfg_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"config_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &config_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  			.flags = CLK_IGNORE_UNUSED,
> @@ -1934,9 +1841,7 @@ static struct clk_branch gcc_ocmem_noc_cfg_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_ocmem_noc_cfg_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"config_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &config_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -1950,9 +1855,7 @@ static struct clk_branch gcc_mss_cfg_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_mss_cfg_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"config_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &config_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -1966,9 +1869,7 @@ static struct clk_branch gcc_mss_q6_bimc_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_mss_q6_bimc_axi_clk",
> -			.parent_names = (const char *[]){
> -				"system_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &system_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -1982,9 +1883,7 @@ static struct clk_branch gcc_pdm2_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pdm2_clk",
> -			.parent_names = (const char *[]){
> -				"pdm2_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &pdm2_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -1999,9 +1898,7 @@ static struct clk_branch gcc_pdm_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pdm_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"periph_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &periph_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -2015,7 +1912,10 @@ static struct clk_branch gcc_pdm_xo4_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pdm_xo4_clk",
> -			.parent_names = (const char *[]){ "xo" },
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo_board",
> +				.name = "xo_board",
> +			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -2030,9 +1930,7 @@ static struct clk_branch gcc_prng_ahb_clk = {
>  		.enable_mask = BIT(13),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_prng_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"periph_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &periph_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -2046,9 +1944,7 @@ static struct clk_branch gcc_sdcc1_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc1_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"periph_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &periph_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -2062,9 +1958,7 @@ static struct clk_branch gcc_sdcc1_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc1_apps_clk",
> -			.parent_names = (const char *[]){
> -				"sdcc1_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &sdcc1_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -2079,8 +1973,9 @@ static struct clk_branch gcc_sdcc1_cdccal_ff_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc1_cdccal_ff_clk",
> -			.parent_names = (const char *[]){
> -				"xo"
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo_board",
> +				.name = "xo_board",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
> @@ -2095,8 +1990,9 @@ static struct clk_branch gcc_sdcc1_cdccal_sleep_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc1_cdccal_sleep_clk",
> -			.parent_names = (const char *[]){
> -				"sleep_clk_src"
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "sleep_clk",
> +				.name = "sleep_clk",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
> @@ -2111,9 +2007,7 @@ static struct clk_branch gcc_sdcc2_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc2_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"periph_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &periph_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -2127,9 +2021,7 @@ static struct clk_branch gcc_sdcc2_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc2_apps_clk",
> -			.parent_names = (const char *[]){
> -				"sdcc2_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &sdcc2_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -2144,9 +2036,7 @@ static struct clk_branch gcc_sdcc3_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc3_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"periph_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &periph_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -2160,9 +2050,7 @@ static struct clk_branch gcc_sdcc3_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc3_apps_clk",
> -			.parent_names = (const char *[]){
> -				"sdcc3_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &sdcc3_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -2177,9 +2065,7 @@ static struct clk_branch gcc_sdcc4_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc4_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"periph_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &periph_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -2193,9 +2079,7 @@ static struct clk_branch gcc_sdcc4_apps_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc4_apps_clk",
> -			.parent_names = (const char *[]){
> -				"sdcc4_apps_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &sdcc4_apps_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -2210,9 +2094,7 @@ static struct clk_branch gcc_sys_noc_usb3_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sys_noc_usb3_axi_clk",
> -			.parent_names = (const char *[]){
> -				"usb30_master_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &usb30_master_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -2227,9 +2109,7 @@ static struct clk_branch gcc_tsif_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_tsif_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"periph_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &periph_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -2243,9 +2123,7 @@ static struct clk_branch gcc_tsif_ref_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_tsif_ref_clk",
> -			.parent_names = (const char *[]){
> -				"tsif_ref_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &tsif_ref_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -2260,8 +2138,9 @@ static struct clk_branch gcc_usb2a_phy_sleep_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb2a_phy_sleep_clk",
> -			.parent_names = (const char *[]){
> -				"sleep_clk_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "sleep_clk",
> +				.name = "sleep_clk",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
> @@ -2276,8 +2155,9 @@ static struct clk_branch gcc_usb2b_phy_sleep_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb2b_phy_sleep_clk",
> -			.parent_names = (const char *[]){
> -				"sleep_clk_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "sleep_clk",
> +				.name = "sleep_clk",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
> @@ -2292,9 +2172,7 @@ static struct clk_branch gcc_usb30_master_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb30_master_clk",
> -			.parent_names = (const char *[]){
> -				"usb30_master_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &usb30_master_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -2309,9 +2187,7 @@ static struct clk_branch gcc_usb30_mock_utmi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb30_mock_utmi_clk",
> -			.parent_names = (const char *[]){
> -				"usb30_mock_utmi_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &usb30_mock_utmi_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -2326,8 +2202,9 @@ static struct clk_branch gcc_usb30_sleep_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb30_sleep_clk",
> -			.parent_names = (const char *[]){
> -				"sleep_clk_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "sleep_clk",
> +				.name = "sleep_clk",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
> @@ -2342,9 +2219,7 @@ static struct clk_branch gcc_usb_hs_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb_hs_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"periph_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &periph_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -2358,9 +2233,7 @@ static struct clk_branch gcc_usb_hs_system_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb_hs_system_clk",
> -			.parent_names = (const char *[]){
> -				"usb_hs_system_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &usb_hs_system_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -2375,9 +2248,7 @@ static struct clk_branch gcc_usb_hsic_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb_hsic_ahb_clk",
> -			.parent_names = (const char *[]){
> -				"periph_noc_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &periph_noc_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
> @@ -2391,9 +2262,7 @@ static struct clk_branch gcc_usb_hsic_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb_hsic_clk",
> -			.parent_names = (const char *[]){
> -				"usb_hsic_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &usb_hsic_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -2408,9 +2277,7 @@ static struct clk_branch gcc_usb_hsic_io_cal_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb_hsic_io_cal_clk",
> -			.parent_names = (const char *[]){
> -				"usb_hsic_io_cal_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &usb_hsic_io_cal_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -2425,8 +2292,9 @@ static struct clk_branch gcc_usb_hsic_io_cal_sleep_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb_hsic_io_cal_sleep_clk",
> -			.parent_names = (const char *[]){
> -				"sleep_clk_src",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "sleep_clk",
> +				.name = "sleep_clk",
>  			},
>  			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
> @@ -2441,9 +2309,7 @@ static struct clk_branch gcc_usb_hsic_system_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb_hsic_system_clk",
> -			.parent_names = (const char *[]){
> -				"usb_hsic_system_clk_src",
> -			},
> +			.parent_hws = (const struct clk_hw *[]){ &usb_hsic_system_clk_src.clkr.hw },
>  			.num_parents = 1,
>  			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
> @@ -2844,7 +2710,7 @@ static void msm8226_clock_override(void)
>  
>  static void msm8974_pro_clock_override(void)
>  {
> -	sdcc1_apps_clk_src_init.parent_names = gcc_xo_gpll0_gpll4;
> +	sdcc1_apps_clk_src_init.parent_data = gcc_xo_gpll0_gpll4;
>  	sdcc1_apps_clk_src_init.num_parents = 3;
>  	sdcc1_apps_clk_src.freq_tbl = ftbl_gcc_sdcc1_apps_clk_pro;
>  	sdcc1_apps_clk_src.parent_map = gcc_xo_gpll0_gpll4_map;
> -- 
> 2.25.1
> 
