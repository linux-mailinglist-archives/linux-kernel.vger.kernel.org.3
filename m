Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70413471ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 00:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhLLX2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 18:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhLLX2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 18:28:38 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED001C061751
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 15:28:37 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q25so21206527oiw.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 15:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vh/wbUgkfdUKYGNf++vDHtfUUGTEz/aDqpk4svRd0AU=;
        b=eFCYdoOnvicz305xpH32Kg8EG8w2nlSE/gKoZN+QDT0H8gjFjq9u+UK7t6hsKx9edk
         vycsb162kCx//Be7+ctj2oHH4iauI1LBvJQhhDPhvIYRy0SN7EsFY7NBZBKVtFGP0FwZ
         onqFNZlUwxK+y4f2a/dpfmjZJYOUgNVFC4EArWVnCp4TR5jT2yitkffWtafNPDXgSrg+
         bu1bjOzNBu2mdMSGt+u7HPKjQGtC4PR2livr67HoE3RUrdGTx4GmW1Bk5t4M7f5MQf43
         FlPvugwqwS0nsPToCBWxkbGHQahSkjIUBxStx3nZtbc/iFKRHG2yve04vvANPQzzG+Qa
         Vmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vh/wbUgkfdUKYGNf++vDHtfUUGTEz/aDqpk4svRd0AU=;
        b=hLlDdK+2z2eHbWMF2hZwREP+J3MguivRJwa7yNhTi1VWobE+gw1FxTBLJgV+zr8qUX
         SApC3LXdPwZkdn0IC9YWHaIodOGTGLVd4+ZwM2ke9wBdyaWXxVZDVdd1KOixHBg0Z4uY
         e0Tj7Ct+ByV5wIHR9lkDxv5goiqcm7Krz4Nlsyw1sn3nn/gM12APUbCTEwTnqDp6y8dE
         h5lXOERmRKqi2IZqzVVpVVJPDxW8H6ZgwnE54wNLp0wwAnGX/OGIKW4VokJKL4HheRpD
         ZBGcq4anvUZe7WUnisODuny4bOIRhk9O0lPLz8OL96b6Oe30bdIzlk8WO4HYonDb0a8X
         ULBA==
X-Gm-Message-State: AOAM530amjPbyrjwCwO6MWac58UbuFmaeIatxFf8HA5JxKoag/UtIMtC
        KSz8ToDjzXknM7DC+5d8lG7SZw==
X-Google-Smtp-Source: ABdhPJynYL4sOmYh81k1oyCXWiDgoSrW3Neq8jhKGC61PeMkyTcbrmEIWYxN8k2HFvsYnGzbWYIlbg==
X-Received: by 2002:aca:eb53:: with SMTP id j80mr23670708oih.85.1639351717273;
        Sun, 12 Dec 2021 15:28:37 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id c8sm1933033otk.40.2021.12.12.15.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 15:28:36 -0800 (PST)
Message-ID: <89dfda08-a7cf-0acb-4b3d-6c57577a548e@kali.org>
Date:   Sun, 12 Dec 2021 17:28:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH] clk: qcom: rcg2: Cache rate changes for parked RCGs
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211203035601.3505780-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20211203035601.3505780-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/2/21 9:56 PM, Bjorn Andersson wrote:
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
> ---
>   drivers/clk/qcom/clk-rcg.h  |  2 ++
>   drivers/clk/qcom/clk-rcg2.c | 32 +++++++++++++++++---------------
>   2 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index 99efcc7f8d88..6939f4e62768 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -139,6 +139,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
>    * @freq_tbl: frequency table
>    * @clkr: regmap clock handle
>    * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
> + * @current_rate: cached rate for parked RCGs
>    */
>   struct clk_rcg2 {
>   	u32			cmd_rcgr;
> @@ -149,6 +150,7 @@ struct clk_rcg2 {
>   	const struct freq_tbl	*freq_tbl;
>   	struct clk_regmap	clkr;
>   	u8			cfg_off;
> +	unsigned long		current_rate;
>   };
>   
>   #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index e1b1b426fae4..b574b38dcbd5 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -167,6 +167,7 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
>   {
>   	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>   	u32 cfg, hid_div, m = 0, n = 0, mode = 0, mask;
> +	unsigned long rate;
>   
>   	regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
>   
> @@ -186,7 +187,11 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
>   	hid_div = cfg >> CFG_SRC_DIV_SHIFT;
>   	hid_div &= mask;
>   
> -	return calc_rate(parent_rate, m, n, mode, hid_div);
> +	rate = calc_rate(parent_rate, m, n, mode, hid_div);
> +	if (!rcg->current_rate)
> +		rcg->current_rate = rate;
> +
> +	return rate;
>   }
>   
>   static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
> @@ -968,12 +973,14 @@ static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
>   	if (!f)
>   		return -EINVAL;
>   
> +	rcg->current_rate = rate;
> +
>   	/*
> -	 * In case clock is disabled, update the CFG, M, N and D registers
> -	 * and don't hit the update bit of CMD register.
> +	 * In the case that the shared RCG is parked, current_rate will be
> +	 * applied as the clock is unparked again, so just return here.
>   	 */
>   	if (!__clk_is_enabled(hw->clk))
> -		return __clk_rcg2_configure(rcg, f);
> +		return 0;
>   
>   	return clk_rcg2_shared_force_enable_clear(hw, f);
>   }
> @@ -987,8 +994,13 @@ static int clk_rcg2_shared_set_rate_and_parent(struct clk_hw *hw,
>   static int clk_rcg2_shared_enable(struct clk_hw *hw)
>   {
>   	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +	const struct freq_tbl *f = NULL;
>   	int ret;
>   
> +	f = qcom_find_freq(rcg->freq_tbl, rcg->current_rate);
> +	if (!f)
> +		return -EINVAL;
> +
>   	/*
>   	 * Set the update bit because required configuration has already
>   	 * been written in clk_rcg2_shared_set_rate()
> @@ -997,7 +1009,7 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
>   	if (ret)
>   		return ret;
>   
> -	ret = update_config(rcg);
> +	ret = clk_rcg2_configure(rcg, f);
>   	if (ret)
>   		return ret;
>   
> @@ -1007,13 +1019,6 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
>   static void clk_rcg2_shared_disable(struct clk_hw *hw)
>   {
>   	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> -	u32 cfg;
> -
> -	/*
> -	 * Store current configuration as switching to safe source would clear
> -	 * the SRC and DIV of CFG register
> -	 */
> -	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
>   
>   	/*
>   	 * Park the RCG at a safe configuration - sourced off of safe source.
> @@ -1031,9 +1036,6 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
>   	update_config(rcg);
>   
>   	clk_rcg2_clear_force_enable(hw);
> -
> -	/* Write back the stored configuration corresponding to current rate */
> -	regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, cfg);
>   }
>   
>   const struct clk_ops clk_rcg2_shared_ops = {

Revisiting this...

With Dmitry's patches applied ( 
https://lore.kernel.org/linux-arm-msm/20211208022210.1300773-1-dmitry.baryshkov@linaro.org/ 
) as well as these, and clk_ignore_unused, I get both

[ 4.767487] ------------[ cut here ]------------ [ 4.767495] 
disp_cc_mdss_pclk0_clk_src: rcg didn't update its configuration.

and


[ 6.449518] ------------[ cut here ]------------ [ 6.449525] 
video_cc_venus_clk_src: rcg didn't update its configuration.

This includes after modifying Dmitry's patches to park the above 2 clocks.

Removing "clk_ignore_unused" from the kernel command line, while keeping 
Dmitry's patchset as well as this patch,

results in the disp_cc_mdss_pclk0_clk_src going away, but the 
video_cc_venus_clk_src still shows up.

Applying Dmitry's patches, removing this one, and removing 
"clk_ignore_unused" from command line arguments ends up

with none of these rcg didn't update its configuration messages. As can 
be seen in http://paste.debian.net/1222931

-- steev

