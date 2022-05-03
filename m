Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE1C5187B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbiECPFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbiECPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:05:00 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68143981D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:01:26 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-ed9a75c453so6885708fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UfIE70xQm2YU+6K/Ttf9zAPKZ0PU7B5HIydVLGsmlJ4=;
        b=l36uMbuQkvZDIyOcKxfb1sUiQtpNr89zAPwIB+/FfSpDvk2QOQj529Ex0mPdSgw7IU
         rCjzODxW+uxMBPDpc9AgPJLDCTSKoVbUCjiNYeom6XP9kYt4ThUNE3hc8XS8SjbJkDZ+
         P1qM7f94z3bBMJvftCiayATqDJXFPqhkQsMw3zIflRX/uDB3q1la63xCJZIEdw6UgKx1
         Ly1XLi1d2PrqnoDAjtSNsarad16am9qhT78Vah99PZJXqhWFw1QPIJZd/MeSHe/MwELq
         VmqWJEN9mbG0jTK5/YlHCKItVBqDF1DIUl0U7JtKysKQxFfnqZO3xwwc7yx5nfT+Km+i
         XxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UfIE70xQm2YU+6K/Ttf9zAPKZ0PU7B5HIydVLGsmlJ4=;
        b=2aaWRBJ87moUy3iYjG4AeYsdgIN1m+CWoO4YyWFzt9s05X6/V/v0t3pLRk7RnsJGqn
         Jccj1QBJzE/X0mTdoghhMHFdCFdpX/dvudJRK3+8c3cUm54iR0t2S3YXvgW+IpyySGBz
         ZJSSGbUhxiXHKFfuNHmS4V7r3BADBM91qITtRBHJzq1kPwqf3em9snQNVe8KyFEX8fks
         Wxn1NQbwMHmfyu6Trh8uiBx0n7iGPLJuhw0WIxhiYXJia0pCxvIc34wOobPXxRiN/VD7
         EDOwdRH0Xl++Ta+r/0IamiL1XL9nE6FRwE+6Bxkw+uw5LjJMYCvw3KuDlBM8XT2nTecw
         6YnQ==
X-Gm-Message-State: AOAM533KpGJQG+/kXUvExcDjC+7WIwm2MMeg7AOG8Cs/kD40+MqhLVof
        0xE4HoZwq0sQs+kIYJPnomUKpw==
X-Google-Smtp-Source: ABdhPJx8w+yhm4KptfWPxu2XUQshHWFWOqOuN/CC7q0vNKFoXdHftEkryd18W19JwhYmh96Qw36GmA==
X-Received: by 2002:a05:6870:581b:b0:e5:9baf:cd2a with SMTP id r27-20020a056870581b00b000e59bafcd2amr1810418oap.233.1651590085861;
        Tue, 03 May 2022 08:01:25 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o13-20020a9d404d000000b0060603221271sm3976053oti.65.2022.05.03.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:01:25 -0700 (PDT)
Date:   Tue, 3 May 2022 10:01:21 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH v2 1/8] clk: qcom: rcg2: Cache rate changes for parked
 RCGs
Message-ID: <YnFDwUvFCgrH12zY@builder.lan>
References: <20220503130448.520470-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503130448.520470-1-robert.foss@linaro.org>
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

> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> As GDSCs are turned on and off some associated clocks are momentarily
> enabled for house keeping purposes. Failure to enable these clocks seems
> to have been silently ignored in the past, but starting in SM8350 this
> failure will prevent the GDSC to turn on.
> 
> At least on SM8350 this operation will enable the RCG per the
> configuration in CFG_REG. This means that the current model where the
> current configuration is written back to CF_REG immediately after
> parking the RCG doesn't work.
> 
> Instead, keep track of the currently requested rate of the clock and
> upon enabling the clock reapply the configuration per the saved rate.
> 
> Fixes: 7ef6f11887bd ("clk: qcom: Configure the RCGs to a safe source as needed")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> ---

This patch has been iterated since and the latest incarnation can be
found on below link. A reference to that in the cover letter would be
sufficient.

https://lore.kernel.org/linux-arm-msm/20220426212136.1543984-1-bjorn.andersson@linaro.org/

Thanks,
Bjorn

>  drivers/clk/qcom/clk-rcg.h  |  2 ++
>  drivers/clk/qcom/clk-rcg2.c | 32 +++++++++++++++++---------------
>  2 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index 00cea508d49e..8b41244b8dbf 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -140,6 +140,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
>   * @freq_tbl: frequency table
>   * @clkr: regmap clock handle
>   * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
> + * @current_rate: cached rate for parked RCGs
>   */
>  struct clk_rcg2 {
>  	u32			cmd_rcgr;
> @@ -150,6 +151,7 @@ struct clk_rcg2 {
>  	const struct freq_tbl	*freq_tbl;
>  	struct clk_regmap	clkr;
>  	u8			cfg_off;
> +	unsigned long		current_rate;
>  };
>  
>  #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index f675fd969c4d..81fd3a2db709 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -167,6 +167,7 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
>  {
>  	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>  	u32 cfg, hid_div, m = 0, n = 0, mode = 0, mask;
> +	unsigned long rate;
>  
>  	regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
>  
> @@ -186,7 +187,11 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
>  	hid_div = cfg >> CFG_SRC_DIV_SHIFT;
>  	hid_div &= mask;
>  
> -	return calc_rate(parent_rate, m, n, mode, hid_div);
> +	rate = calc_rate(parent_rate, m, n, mode, hid_div);
> +	if (!rcg->current_rate)
> +		rcg->current_rate = rate;
> +
> +	return rate;
>  }
>  
>  static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
> @@ -978,12 +983,14 @@ static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
>  	if (!f)
>  		return -EINVAL;
>  
> +	rcg->current_rate = rate;
> +
>  	/*
> -	 * In case clock is disabled, update the CFG, M, N and D registers
> -	 * and don't hit the update bit of CMD register.
> +	 * In the case that the shared RCG is parked, current_rate will be
> +	 * applied as the clock is unparked again, so just return here.
>  	 */
>  	if (!__clk_is_enabled(hw->clk))
> -		return __clk_rcg2_configure(rcg, f);
> +		return 0;
>  
>  	return clk_rcg2_shared_force_enable_clear(hw, f);
>  }
> @@ -997,8 +1004,13 @@ static int clk_rcg2_shared_set_rate_and_parent(struct clk_hw *hw,
>  static int clk_rcg2_shared_enable(struct clk_hw *hw)
>  {
>  	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +	const struct freq_tbl *f = NULL;
>  	int ret;
>  
> +	f = qcom_find_freq(rcg->freq_tbl, rcg->current_rate);
> +	if (!f)
> +		return -EINVAL;
> +
>  	/*
>  	 * Set the update bit because required configuration has already
>  	 * been written in clk_rcg2_shared_set_rate()
> @@ -1007,7 +1019,7 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
>  	if (ret)
>  		return ret;
>  
> -	ret = update_config(rcg);
> +	ret = clk_rcg2_configure(rcg, f);
>  	if (ret)
>  		return ret;
>  
> @@ -1017,13 +1029,6 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
>  static void clk_rcg2_shared_disable(struct clk_hw *hw)
>  {
>  	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> -	u32 cfg;
> -
> -	/*
> -	 * Store current configuration as switching to safe source would clear
> -	 * the SRC and DIV of CFG register
> -	 */
> -	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
>  
>  	/*
>  	 * Park the RCG at a safe configuration - sourced off of safe source.
> @@ -1041,9 +1046,6 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
>  	update_config(rcg);
>  
>  	clk_rcg2_clear_force_enable(hw);
> -
> -	/* Write back the stored configuration corresponding to current rate */
> -	regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, cfg);
>  }
>  
>  const struct clk_ops clk_rcg2_shared_ops = {
> -- 
> 2.34.1
> 
