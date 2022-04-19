Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A295076CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355031AbiDSRvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351055AbiDSRvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:51:51 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE211A02
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:49:07 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e2a00f2cc8so18305096fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v0Lgvd+pxbfJ2W3ZxRXaPCr1PNTgOZ2EXZjCi/26sfE=;
        b=HZ24tsFgTS0UneQxy/kJndTWpEV6TY/9sL3Ls4gEv6Z/xQJrtYc+EAVFY9m5xD285H
         jK9Fdya2MWf9M/zifs91uMFst8nMzD5+JNkC50O382u4rqEgzAYnbIUl+kLc4TwSc+CQ
         fca28DaLXvTMUstMgYKQOXdEEmvRhtJskkrxNSVofqbbNflnrpQhGCNeNGRWDyAIt9He
         SKcRVBcYn8xpK+sn0O+GZIf8YIMqrsKSzrLyHnNHFyA618WyCTgZqyV7f0hr+CVzd8Sy
         6qZnVNJrlQGOldsoFpDb76F35hQkdUpLIAJrpwsxtKzKZ8CWG2QrzGpG+e1ADanK3gAY
         rHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v0Lgvd+pxbfJ2W3ZxRXaPCr1PNTgOZ2EXZjCi/26sfE=;
        b=WeMYozKDtn0BNNdN1VJkP8aW7V6ftaeF3KOBPwhwIdR57CzhAXEOmcN/d5u2ByOnT6
         wy6QibC9UGqX4mkX9DWSoMWRos8LDI2665HlE9f9yZ45yuk2cIty1MiMXg2PO5RYwRtJ
         WwyW8DpFsggM75sNletKU0xzRMa8MfAjevHcKXTceAWRfLpObXy2ZN40AWn45fkWrqMl
         EY43adyDs44WQZPQGTpO56TbSU9RalXcjQRpjLFd2MDkV+BfOJotbkzQQEM3Kr9dvEWF
         ED4Go0IFSKqhNEaJS4RmOUTnayZDaJn8SWEvwOZ4PuKtKiU/mXVNcvOp0pi2KjjuWCq1
         Ts7Q==
X-Gm-Message-State: AOAM5314A5M4BYbsIjvYdsB7A2MgmewrYTAteFZgbG4YfcevoZ/WD2ws
        qioVzfkPzk/otuRq2+HmgT9zcQ==
X-Google-Smtp-Source: ABdhPJxKMEvgdGQ9s2QWLdj0NvPXza+GmM2oiG9jDhMtaY06uZWgp4xyPNG00nQX0j7wUUwmUSNHuQ==
X-Received: by 2002:a05:6870:6098:b0:e1:cb99:9c47 with SMTP id t24-20020a056870609800b000e1cb999c47mr8588508oae.59.1650390546755;
        Tue, 19 Apr 2022 10:49:06 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3-20020a4a9703000000b0033336ab4909sm5668955ooi.7.2022.04.19.10.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:49:06 -0700 (PDT)
Date:   Tue, 19 Apr 2022 12:49:04 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/9] clk: qcom: msm8996-cpu: Add MSM8996 Pro CBF
 support
Message-ID: <Yl72EFQbntGUi2tm@builder.lan>
References: <kXrAkKv7RZct22X0wivLWqOAiLKpFuDCAY1KY_KSx649kn7BNmJ2IFFMrsYPAyDlcxIjbQCQ1PHb5KaNFawm9IGIXUbch-DI9OI_l73BAaM=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kXrAkKv7RZct22X0wivLWqOAiLKpFuDCAY1KY_KSx649kn7BNmJ2IFFMrsYPAyDlcxIjbQCQ1PHb5KaNFawm9IGIXUbch-DI9OI_l73BAaM=@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 Apr 23:16 CDT 2022, Yassine Oudjana wrote:

> MSM8996 Pro (MSM8996SG) has a /4 divisor on the CBF clock
> instead of /2. This allows it to reach a lower minimum frequency
> of 192000000Hz compared to 307200000Hz on regular MSM8996.
> Add support for setting the CBF clock divisor to /4 for MSM8996 Pro.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  drivers/clk/qcom/clk-cpu-8996.c | 61 +++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
> index 8afc271f92d0..231d8224fa16 100644
> --- a/drivers/clk/qcom/clk-cpu-8996.c
> +++ b/drivers/clk/qcom/clk-cpu-8996.c
> @@ -70,11 +70,11 @@ enum _pmux_input {
> 
>  enum {
>  	CBF_PLL_INDEX = 1,
> -	CBF_DIV_2_INDEX,
> +	CBF_DIV_INDEX,
>  	CBF_SAFE_INDEX
>  };

I don't have this enum in my tree. Could you please double check that
this works on linux-next?

And can you please send the next revision using git send-email with a
cover-letter, so that the patches are related in my inbox.

Thanks,
Bjorn

> 
> -#define DIV_2_THRESHOLD		600000000
> +#define DIV_THRESHOLD		600000000
>  #define PWRCL_REG_OFFSET 0x0
>  #define PERFCL_REG_OFFSET 0x80000
>  #define MUX_OFFSET	0x40
> @@ -142,6 +142,17 @@ static const struct alpha_pll_config cbfpll_config = {
>  	.early_output_mask = BIT(3),
>  };
> 
> +static const struct alpha_pll_config cbfpll_config_pro = {
> +	.l = 72,
> +	.config_ctl_val = 0x200d4aa8,
> +	.config_ctl_hi_val = 0x006,
> +	.pre_div_mask = BIT(12),
> +	.post_div_mask = 0x3 << 8,
> +	.post_div_val = 0x3 << 8,
> +	.main_output_mask = BIT(0),
> +	.early_output_mask = BIT(3),
> +};
> +
>  static struct clk_alpha_pll perfcl_pll = {
>  	.offset = PERFCL_REG_OFFSET,
>  	.regs = prim_pll_regs,
> @@ -230,7 +241,8 @@ struct clk_cpu_8996_mux {
>  	u8	width;
>  	struct notifier_block nb;
>  	struct clk_hw	*pll;
> -	struct clk_hw	*pll_div_2;
> +	struct clk_hw	*pll_div;
> +	u8 div;
>  	struct clk_regmap clkr;
>  };
> 
> @@ -280,11 +292,11 @@ static int clk_cpu_8996_mux_determine_rate(struct clk_hw *hw,
>  	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
>  	struct clk_hw *parent = cpuclk->pll;
> 
> -	if (cpuclk->pll_div_2 && req->rate < DIV_2_THRESHOLD) {
> -		if (req->rate < (DIV_2_THRESHOLD / 2))
> +	if (cpuclk->pll_div && req->rate < DIV_THRESHOLD) {
> +		if (req->rate < (DIV_THRESHOLD / cpuclk->div))
>  			return -EINVAL;
> 
> -		parent = cpuclk->pll_div_2;
> +		parent = cpuclk->pll_div;
>  	}
> 
>  	req->best_parent_rate = clk_hw_round_rate(parent, req->rate);
> @@ -336,7 +348,8 @@ static struct clk_cpu_8996_mux pwrcl_pmux = {
>  	.shift = 0,
>  	.width = 2,
>  	.pll = &pwrcl_pll.clkr.hw,
> -	.pll_div_2 = &pwrcl_smux.clkr.hw,
> +	.pll_div = &pwrcl_smux.clkr.hw,
> +	.div = 2,
>  	.nb.notifier_call = cpu_clk_notifier_cb,
>  	.clkr.hw.init = &(struct clk_init_data) {
>  		.name = "pwrcl_pmux",
> @@ -358,7 +371,8 @@ static struct clk_cpu_8996_mux perfcl_pmux = {
>  	.shift = 0,
>  	.width = 2,
>  	.pll = &perfcl_pll.clkr.hw,
> -	.pll_div_2 = &perfcl_smux.clkr.hw,
> +	.pll_div = &perfcl_smux.clkr.hw,
> +	.div = 2,
>  	.nb.notifier_call = cpu_clk_notifier_cb,
>  	.clkr.hw.init = &(struct clk_init_data) {
>  		.name = "perfcl_pmux",
> @@ -481,19 +495,23 @@ static int qcom_cbf_clk_msm8996_register_clks(struct device *dev,
>  					      struct regmap *regmap)
>  {
>  	int ret;
> +	bool is_pro = of_device_is_compatible(dev->of_node, "qcom,msm8996pro-apcc");
> 
> -	cbf_mux.pll_div_2 = clk_hw_register_fixed_factor(dev, "cbf_pll_main",
> -						      "cbf_pll", CLK_SET_RATE_PARENT,
> -						      1, 2);
> -	if (IS_ERR(cbf_mux.pll_div_2)) {
> +	cbf_mux.div = is_pro ? 4 : 2;
> +	cbf_mux.pll_div = clk_hw_register_fixed_factor(dev, "cbf_pll_main",
> +						       "cbf_pll", CLK_SET_RATE_PARENT,
> +						       1, cbf_mux.div);
> +
> +	if (IS_ERR(cbf_mux.pll_div)) {
>  		dev_err(dev, "Failed to initialize cbf_pll_main\n");
> -		return PTR_ERR(cbf_mux.pll_div_2);
> +		return PTR_ERR(cbf_mux.pll_div);
>  	}
> 
>  	ret = devm_clk_register_regmap(dev, cbf_msm8996_clks[0]);
>  	ret = devm_clk_register_regmap(dev, cbf_msm8996_clks[1]);
> 
> -	clk_alpha_pll_configure(&cbf_pll, regmap, &cbfpll_config);
> +	clk_alpha_pll_configure(&cbf_pll, regmap, is_pro ?
> +				&cbfpll_config_pro : &cbfpll_config);
>  	clk_set_rate(cbf_pll.clkr.hw.clk, 614400000);
>  	clk_prepare_enable(cbf_pll.clkr.hw.clk);
>  	clk_notifier_register(cbf_mux.clkr.hw.clk, &cbf_mux.nb);
> @@ -575,7 +593,7 @@ static int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
>  		qcom_cpu_clk_msm8996_acd_init(base);
>  		break;
>  	case POST_RATE_CHANGE:
> -		if (cnd->new_rate < DIV_2_THRESHOLD)
> +		if (cnd->new_rate < DIV_THRESHOLD)
>  			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
>  							  DIV_2_INDEX);
>  		else
> @@ -600,15 +618,15 @@ static int cbf_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
> 
>  	switch (event) {
>  	case PRE_RATE_CHANGE:
> -		parent = clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_DIV_2_INDEX);
> -		ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_2_INDEX);
> +		parent = clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_DIV_INDEX);
> +		ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_INDEX);
> 
> -		if (cnd->old_rate > DIV_2_THRESHOLD && cnd->new_rate < DIV_2_THRESHOLD)
> -			ret = clk_set_rate(parent->clk, cnd->old_rate / 2);
> +		if (cnd->old_rate > DIV_THRESHOLD && cnd->new_rate < DIV_THRESHOLD)
> +			ret = clk_set_rate(parent->clk, cnd->old_rate / cbfclk->div);
>  		break;
>  	case POST_RATE_CHANGE:
> -		if (cnd->new_rate < DIV_2_THRESHOLD)
> -			ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_2_INDEX);
> +		if (cnd->new_rate < DIV_THRESHOLD)
> +			ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_INDEX);
>  		else {
>  			parent = clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_PLL_INDEX);
>  			ret = clk_set_rate(parent->clk, cnd->new_rate);
> @@ -676,6 +694,7 @@ static int qcom_cpu_clk_msm8996_driver_remove(struct platform_device *pdev)
> 
>  static const struct of_device_id qcom_cpu_clk_msm8996_match_table[] = {
>  	{ .compatible = "qcom,msm8996-apcc" },
> +	{ .compatible = "qcom,msm8996pro-apcc" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, qcom_cpu_clk_msm8996_match_table);
> --
> 2.35.1
> 
