Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF980553894
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352983AbiFURJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352201AbiFURJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:09:22 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F380F29C95
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:09:20 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c144so10578593qkg.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7blovD8yZIVSMDnF6wpQvtTZGOIDSOmS5ueDQXNEg4=;
        b=NeG3Kaj7vE75G3AkBh2+Yw84vXZI5c+6emC1Wwt5NzbaCSOEMo0R+IgeRsgZ2aoHy/
         xt/JdsNWanaZL5XtJgQ7G7FPbsZmAzZzQhYSHV7fDUsXOviWLHhqow5EGSRA5ZVhIC8W
         lHXyZX8fXR2Ax489AidUmQYUIVTaYY38D2KOQEn9IOc0RbiXHayDXC3F2lVah4XrN4G1
         umL9z9YB8em2O6K8hnlCaXLjdOCDtGG6HX5fe6fKNNySnPOkAtYtXSFUzC8jukqqMmMs
         nqiIoibpyBkamgXTMQRhCDi/mktwUfjkLHR/4NWr9NFeyLerDsRYG8aOyIKF7Wtz/Yqb
         Knng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7blovD8yZIVSMDnF6wpQvtTZGOIDSOmS5ueDQXNEg4=;
        b=SzpsyYCkTrbqDTgxhoDyxEbCUHUFqBmt3mjwU7pFJqPv5ThMf9B1PRRVE3kqsNpPkk
         LUAiMcApUFKvvpi3Knrd/NYsf1BuhFAEwrWP1kvKghDyIRgY86BWJc3eJNkPSDMbrMOZ
         3YWzcUCFsTx0YoTtmkFYHIP8ggbIsrAnHg5Xp2qTPpoIDdc/YJ97l78C2Vq3EXIt9kGO
         kIp2CzN4zNBpmXcN6gUvzESG5mHYgb96OQoZDmCET5SB25aLj3XlN3tldSy1n+nAcat8
         ptzLFOLpxzVnZyHIfM+tPuqKtCP5HNxzrYbT3eUi/a2e9mPqBZ53Y+2Zw92+2tkVs5Vu
         bnzw==
X-Gm-Message-State: AJIora+nkk01FxMlPO1Fx9iFNYw7WoHzWXA05/eMywQoYoZ5SAROq2e4
        IqdnbZkdYq3f74k+F1hv3HEJ48Kt3+4rwzBogPOO3A==
X-Google-Smtp-Source: AGRyM1vzX9rdE/oum8gEQi8Myh0QDcna7eZrIKYriBs6e5jUFmi+GI0nMJFeYRWdeZlQ0Ly7vp+EGPfSyGI7dzPvJ2U=
X-Received: by 2002:a05:620a:4156:b0:6a6:f8d2:6d9e with SMTP id
 k22-20020a05620a415600b006a6f8d26d9emr21129486qko.30.1655831359859; Tue, 21
 Jun 2022 10:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160621.24415-1-y.oudjana@protonmail.com> <20220621160621.24415-7-y.oudjana@protonmail.com>
In-Reply-To: <20220621160621.24415-7-y.oudjana@protonmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Jun 2022 20:09:08 +0300
Message-ID: <CAA8EJpo8E68_nw+H54CqVm7w_5WDYLQYt=UXdyzy=bZobEAs=Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] clk: qcom: msm8996-cpu: Use parent_data for all clocks
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 19:07, Yassine Oudjana <yassine.oudjana@gmail.com> wrote:
>
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> Replace parent_names in PLLs, secondary muxes and primary muxes with
> parent_data. For primary muxes there were never any *cl_pll_acd clocks,
> so instead of adding them, put the primary PLLs in both PLL_INDEX and
> ACD_INDEX, then make sure ACD_INDEX is always picked over PLL_INDEX when
> setting parent since we always want ACD when using the primary PLLs.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  drivers/clk/qcom/clk-cpu-8996.c | 79 ++++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
> index b3ad9245874d..cdb7b2ef3367 100644
> --- a/drivers/clk/qcom/clk-cpu-8996.c
> +++ b/drivers/clk/qcom/clk-cpu-8996.c
> @@ -112,14 +112,18 @@ static const struct alpha_pll_config hfpll_config = {
>         .early_output_mask = BIT(3),
>  };
>
> +static const struct clk_parent_data pll_parent[] = {
> +       { .fw_name = "xo" },
> +};
> +
>  static struct clk_alpha_pll pwrcl_pll = {
>         .offset = PWRCL_REG_OFFSET,
>         .regs = prim_pll_regs,
>         .flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
>         .clkr.hw.init = &(struct clk_init_data){
>                 .name = "pwrcl_pll",
> -               .parent_names = (const char *[]){ "xo" },
> -               .num_parents = 1,
> +               .parent_data = pll_parent,
> +               .num_parents = ARRAY_SIZE(pll_parent),
>                 .ops = &clk_alpha_pll_huayra_ops,
>         },
>  };
> @@ -130,8 +134,8 @@ static struct clk_alpha_pll perfcl_pll = {
>         .flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
>         .clkr.hw.init = &(struct clk_init_data){
>                 .name = "perfcl_pll",
> -               .parent_names = (const char *[]){ "xo" },
> -               .num_parents = 1,
> +               .parent_data = pll_parent,
> +               .num_parents = ARRAY_SIZE(pll_parent),
>                 .ops = &clk_alpha_pll_huayra_ops,
>         },
>  };
> @@ -190,8 +194,8 @@ static struct clk_alpha_pll pwrcl_alt_pll = {
>         .flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
>         .clkr.hw.init = &(struct clk_init_data) {
>                 .name = "pwrcl_alt_pll",
> -               .parent_names = (const char *[]){ "xo" },
> -               .num_parents = 1,
> +               .parent_data = pll_parent,
> +               .num_parents = ARRAY_SIZE(pll_parent),
>                 .ops = &clk_alpha_pll_hwfsm_ops,
>         },
>  };
> @@ -204,8 +208,8 @@ static struct clk_alpha_pll perfcl_alt_pll = {
>         .flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
>         .clkr.hw.init = &(struct clk_init_data) {
>                 .name = "perfcl_alt_pll",
> -               .parent_names = (const char *[]){ "xo" },
> -               .num_parents = 1,
> +               .parent_data = pll_parent,
> +               .num_parents = ARRAY_SIZE(pll_parent),
>                 .ops = &clk_alpha_pll_hwfsm_ops,
>         },
>  };
> @@ -252,6 +256,9 @@ static int clk_cpu_8996_pmux_set_parent(struct clk_hw *hw, u8 index)
>         u32 val;
>
>         val = index;
> +       /* We always want ACD when using the primary PLL */
> +       if (val == PLL_INDEX)
> +               val = ACD_INDEX;
>         val <<= cpuclk->shift;
>
>         return regmap_update_bits(clkr->regmap, cpuclk->reg, mask, val);
> @@ -282,17 +289,24 @@ static const struct clk_ops clk_cpu_8996_pmux_ops = {
>         .determine_rate = clk_cpu_8996_pmux_determine_rate,
>  };
>
> +static const struct clk_parent_data pwrcl_smux_parents[] = {
> +       { .fw_name = "xo" },
> +       { .hw = &pwrcl_pll_postdiv.hw },
> +};
> +
> +static const struct clk_parent_data perfcl_smux_parents[] = {
> +       { .fw_name = "xo" },
> +       { .hw = &perfcl_pll_postdiv.hw },
> +};
> +
>  static struct clk_regmap_mux pwrcl_smux = {
>         .reg = PWRCL_REG_OFFSET + MUX_OFFSET,
>         .shift = 2,
>         .width = 2,
>         .clkr.hw.init = &(struct clk_init_data) {
>                 .name = "pwrcl_smux",
> -               .parent_names = (const char *[]){
> -                       "xo",
> -                       "pwrcl_pll_postdiv",
> -               },
> -               .num_parents = 2,
> +               .parent_data = pwrcl_smux_parents,
> +               .num_parents = ARRAY_SIZE(pwrcl_smux_parents),
>                 .ops = &clk_regmap_mux_closest_ops,
>                 .flags = CLK_SET_RATE_PARENT,
>         },
> @@ -304,16 +318,27 @@ static struct clk_regmap_mux perfcl_smux = {
>         .width = 2,
>         .clkr.hw.init = &(struct clk_init_data) {
>                 .name = "perfcl_smux",
> -               .parent_names = (const char *[]){
> -                       "xo",
> -                       "perfcl_pll_postdiv",
> -               },
> -               .num_parents = 2,
> +               .parent_data = perfcl_smux_parents,
> +               .num_parents = ARRAY_SIZE(perfcl_smux_parents),
>                 .ops = &clk_regmap_mux_closest_ops,
>                 .flags = CLK_SET_RATE_PARENT,
>         },
>  };
>
> +static const struct clk_parent_data pwrcl_pmux_parents[] = {
> +       [SMUX_INDEX] = { .hw = &pwrcl_smux.clkr.hw },
> +       [PLL_INDEX] = { .hw = &pwrcl_pll.clkr.hw },
> +       [ACD_INDEX] = { .hw = &pwrcl_pll.clkr.hw },
> +       [ALT_INDEX] = { .hw = &pwrcl_alt_pll.clkr.hw },
> +};
> +
> +static const struct clk_parent_data perfcl_pmux_parents[] = {
> +       [SMUX_INDEX] = { .hw = &perfcl_smux.clkr.hw },
> +       [PLL_INDEX] = { .hw = &perfcl_pll.clkr.hw },
> +       [ACD_INDEX] = { .hw = &perfcl_pll.clkr.hw },
> +       [ALT_INDEX] = { .hw = &perfcl_alt_pll.clkr.hw },
> +};
> +
>  static struct clk_cpu_8996_pmux pwrcl_pmux = {
>         .reg = PWRCL_REG_OFFSET + MUX_OFFSET,
>         .shift = 0,
> @@ -323,13 +348,8 @@ static struct clk_cpu_8996_pmux pwrcl_pmux = {
>         .nb.notifier_call = cpu_clk_notifier_cb,
>         .clkr.hw.init = &(struct clk_init_data) {
>                 .name = "pwrcl_pmux",
> -               .parent_names = (const char *[]){
> -                       "pwrcl_smux",
> -                       "pwrcl_pll",
> -                       "pwrcl_pll_acd",
> -                       "pwrcl_alt_pll",
> -               },
> -               .num_parents = 4,
> +               .parent_data = pwrcl_pmux_parents,

Please use parent_hws here and below.

> +               .num_parents = ARRAY_SIZE(pwrcl_pmux_parents),
>                 .ops = &clk_cpu_8996_pmux_ops,
>                 /* CPU clock is critical and should never be gated */
>                 .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> @@ -345,13 +365,8 @@ static struct clk_cpu_8996_pmux perfcl_pmux = {
>         .nb.notifier_call = cpu_clk_notifier_cb,
>         .clkr.hw.init = &(struct clk_init_data) {
>                 .name = "perfcl_pmux",
> -               .parent_names = (const char *[]){
> -                       "perfcl_smux",
> -                       "perfcl_pll",
> -                       "perfcl_pll_acd",
> -                       "perfcl_alt_pll",
> -               },
> -               .num_parents = 4,
> +               .parent_data = perfcl_pmux_parents,
> +               .num_parents = ARRAY_SIZE(perfcl_pmux_parents),
>                 .ops = &clk_cpu_8996_pmux_ops,
>                 /* CPU clock is critical and should never be gated */
>                 .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
