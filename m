Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8360F4A7B26
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 23:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347923AbiBBWe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 17:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347917AbiBBWeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:34:23 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22032C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 14:34:23 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id o25so1008739qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 14:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1V8DE0Ku28hciWaqKV70UHjnsuP1wsl0fwvfIUT1QM=;
        b=fwcHlRJYWNeBJc83Xv3kWElEbZdkPvUddtgwgErkxt4JWXWUVg+JWaDt8uNOjrE1U0
         NkPnBgLHLAvnk/qMrRwrbsBR5wbspfpbFKF/op+yDh4QyVGFtGHLha7AinKkXUb+sdNp
         6uOqbsr+sotlfTjQtebNYncBbBTj7heG+3ymFkBTAm6uT2FU7JWZzykA4fMO4lqPeJqb
         O/ehSsCeQRiCOtc4oxNIyhVd72HFRD8XHnv4VtUgB69XtmrN+m5TrzHT9fJU3wZonv7D
         PtUtkweAplL5QfDie+VRDFJLMxHhoidrGIIRNdJC5F1pdq7hW3QTvI/CVHD8M/GOjUSP
         Sa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1V8DE0Ku28hciWaqKV70UHjnsuP1wsl0fwvfIUT1QM=;
        b=CoCYnraKOPkp63h65bXX7WUOLdX21JAIB7t3e4CVHbf/P18N346/49EFkrT1vGrAwP
         ZIE9bEf310qeKs7T+G1/BYMr3vLCRhY2D1tyrMUekZCIEiKvKwnV9j2SUt/wZzvCb3Pl
         v+CZxoWUKB9LjcK74sOAXqR//vzZ4Hv/0NjZOQpTNBoQ5uYIrC8gUDmPsFZ5d1ymhGjc
         TsJZwCwK5pKOR5qQSAAcp7hr1RDfRNgj/7JPAWcVGf92eSLbTegQfKXJleHR3fupiGa/
         NDlQTCHe6DALM30KOVzruuoJAjGrZRpGm6DqD5vW3/wNfGrZsxUOsVXo/TwXszHpoZDc
         DBog==
X-Gm-Message-State: AOAM530xKCgsGpA+kMcSlLdeVHxulVr/xotS0dlg7KcLZVQ0H4OCMU7d
        q4gOIsANyOKfAj0RGoZ405fyU1NyoMQX3+vkx5l/3A==
X-Google-Smtp-Source: ABdhPJzKMjY0yLA3UG5bGmLXKRo45byzLIQ6tQd7LGVUC1fL/bLOmE/ODBoowQv2lg+Bz8lxmtM8QvL2nXf/wD6BhmE=
X-Received: by 2002:a05:620a:280b:: with SMTP id f11mr21398426qkp.59.1643841262124;
 Wed, 02 Feb 2022 14:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20220202182053.22925-1-tdas@codeaurora.org> <20220202182053.22925-2-tdas@codeaurora.org>
In-Reply-To: <20220202182053.22925-2-tdas@codeaurora.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 3 Feb 2022 01:34:11 +0300
Message-ID: <CAA8EJpqWUm5C5nc3fZzjF4XfAEZo8m=PY0Rj6WeDgSJEey=D_A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] clk: qcom: sc7280: Update clk_init_data to const
 for clock controllers
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 at 21:23, Taniya Das <tdas@codeaurora.org> wrote:
>
> Update clk_init_data to const and also use index instead of fw_name for
> graphics, lpasscc and video clock controller.

What is the benefit from using indices here? In my opinion the code
becomes more fragile with such a change.

>
> Fixes: 3e0f01d6c7e74 ("clk: qcom: Add graphics clock controller driver for SC7280")
> Fixes: 4ab43d171181d ("clk: qcom: Add lpass clock controller driver for SC7280")
> Fixes: fae7617bb1428 ("clk: qcom: Add video clock controller driver for SC7280")
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/clk/qcom/gpucc-sc7280.c   | 56 +++++++++++++++----------------
>  drivers/clk/qcom/lpasscc-sc7280.c | 14 ++++----
>  drivers/clk/qcom/videocc-sc7280.c | 26 +++++++-------
>  3 files changed, 48 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
> index 9a832f2bcf49..e8f6abc5261f 100644
> --- a/drivers/clk/qcom/gpucc-sc7280.c
> +++ b/drivers/clk/qcom/gpucc-sc7280.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2022, The Linux Foundation. All rights reserved.
>   */
>
>  #include <linux/clk-provider.h>
> @@ -36,10 +36,10 @@ static struct clk_alpha_pll gpu_cc_pll0 = {
>         .num_vco = ARRAY_SIZE(lucid_vco),
>         .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
>         .clkr = {
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_pll0",
>                         .parent_data = &(const struct clk_parent_data){
> -                               .fw_name = "bi_tcxo",
> +                               .index = 0,
>                         },
>                         .num_parents = 1,
>                         .ops = &clk_alpha_pll_lucid_ops,
> @@ -65,10 +65,10 @@ static struct clk_alpha_pll gpu_cc_pll1 = {
>         .num_vco = ARRAY_SIZE(lucid_vco),
>         .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
>         .clkr = {
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_pll1",
>                         .parent_data = &(const struct clk_parent_data){
> -                               .fw_name = "bi_tcxo",
> +                               .index = 0,
>                         },
>                         .num_parents = 1,
>                         .ops = &clk_alpha_pll_lucid_ops,
> @@ -85,11 +85,11 @@ static const struct parent_map gpu_cc_parent_map_0[] = {
>  };
>
>  static const struct clk_parent_data gpu_cc_parent_data_0[] = {
> -       { .fw_name = "bi_tcxo" },
> +       { .index = 0 },
>         { .hw = &gpu_cc_pll0.clkr.hw },
>         { .hw = &gpu_cc_pll1.clkr.hw },
> -       { .fw_name = "gcc_gpu_gpll0_clk_src" },
> -       { .fw_name = "gcc_gpu_gpll0_div_clk_src" },
> +       { .index = 1 }, /* gcc_gpu_gpll0_clk_src */
> +       { .index = 2 }, /* gcc_gpu_gpll0_div_clk_src */
>  };
>
>  static const struct parent_map gpu_cc_parent_map_1[] = {
> @@ -100,10 +100,10 @@ static const struct parent_map gpu_cc_parent_map_1[] = {
>  };
>
>  static const struct clk_parent_data gpu_cc_parent_data_1[] = {
> -       { .fw_name = "bi_tcxo", },
> +       { .index = 0, },
>         { .hw = &gpu_cc_pll1.clkr.hw },
> -       { .fw_name = "gcc_gpu_gpll0_clk_src", },
> -       { .fw_name = "gcc_gpu_gpll0_div_clk_src", },
> +       { .index = 1 }, /* gcc_gpu_gpll0_clk_src */
> +       { .index = 2 }, /* gcc_gpu_gpll0_div_clk_src */
>  };
>
>  static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
> @@ -119,7 +119,7 @@ static struct clk_rcg2 gpu_cc_gmu_clk_src = {
>         .hid_width = 5,
>         .parent_map = gpu_cc_parent_map_0,
>         .freq_tbl = ftbl_gpu_cc_gmu_clk_src,
> -       .clkr.hw.init = &(struct clk_init_data){
> +       .clkr.hw.init = &(const struct clk_init_data){
>                 .name = "gpu_cc_gmu_clk_src",
>                 .parent_data = gpu_cc_parent_data_0,
>                 .num_parents = ARRAY_SIZE(gpu_cc_parent_data_0),
> @@ -140,7 +140,7 @@ static struct clk_rcg2 gpu_cc_hub_clk_src = {
>         .hid_width = 5,
>         .parent_map = gpu_cc_parent_map_1,
>         .freq_tbl = ftbl_gpu_cc_hub_clk_src,
> -       .clkr.hw.init = &(struct clk_init_data){
> +       .clkr.hw.init = &(const struct clk_init_data){
>                 .name = "gpu_cc_hub_clk_src",
>                 .parent_data = gpu_cc_parent_data_1,
>                 .num_parents = ARRAY_SIZE(gpu_cc_parent_data_1),
> @@ -152,7 +152,7 @@ static struct clk_regmap_div gpu_cc_hub_ahb_div_clk_src = {
>         .reg = 0x11c0,
>         .shift = 0,
>         .width = 4,
> -       .clkr.hw.init = &(struct clk_init_data) {
> +       .clkr.hw.init = &(const struct clk_init_data) {
>                 .name = "gpu_cc_hub_ahb_div_clk_src",
>                 .parent_hws = (const struct clk_hw*[]){
>                         &gpu_cc_hub_clk_src.clkr.hw,
> @@ -167,7 +167,7 @@ static struct clk_regmap_div gpu_cc_hub_cx_int_div_clk_src = {
>         .reg = 0x11bc,
>         .shift = 0,
>         .width = 4,
> -       .clkr.hw.init = &(struct clk_init_data) {
> +       .clkr.hw.init = &(const struct clk_init_data) {
>                 .name = "gpu_cc_hub_cx_int_div_clk_src",
>                 .parent_hws = (const struct clk_hw*[]){
>                         &gpu_cc_hub_clk_src.clkr.hw,
> @@ -184,7 +184,7 @@ static struct clk_branch gpu_cc_ahb_clk = {
>         .clkr = {
>                 .enable_reg = 0x1078,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_ahb_clk",
>                         .parent_hws = (const struct clk_hw*[]){
>                                 &gpu_cc_hub_ahb_div_clk_src.clkr.hw,
> @@ -202,7 +202,7 @@ static struct clk_branch gpu_cc_crc_ahb_clk = {
>         .clkr = {
>                 .enable_reg = 0x107c,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_crc_ahb_clk",
>                         .parent_hws = (const struct clk_hw*[]){
>                                 &gpu_cc_hub_ahb_div_clk_src.clkr.hw,
> @@ -220,7 +220,7 @@ static struct clk_branch gpu_cc_cx_gmu_clk = {
>         .clkr = {
>                 .enable_reg = 0x1098,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_cx_gmu_clk",
>                         .parent_hws = (const struct clk_hw*[]){
>                                 &gpu_cc_gmu_clk_src.clkr.hw,
> @@ -238,7 +238,7 @@ static struct clk_branch gpu_cc_cx_snoc_dvm_clk = {
>         .clkr = {
>                 .enable_reg = 0x108c,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_cx_snoc_dvm_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> @@ -251,7 +251,7 @@ static struct clk_branch gpu_cc_cxo_aon_clk = {
>         .clkr = {
>                 .enable_reg = 0x1004,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_cxo_aon_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> @@ -264,7 +264,7 @@ static struct clk_branch gpu_cc_cxo_clk = {
>         .clkr = {
>                 .enable_reg = 0x109c,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_cxo_clk",
>                         .ops = &clk_branch2_aon_ops,
>                 },
> @@ -277,7 +277,7 @@ static struct clk_branch gpu_cc_gx_gmu_clk = {
>         .clkr = {
>                 .enable_reg = 0x1064,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_gx_gmu_clk",
>                         .parent_hws = (const struct clk_hw*[]){
>                                 &gpu_cc_gmu_clk_src.clkr.hw,
> @@ -295,7 +295,7 @@ static struct clk_branch gpu_cc_hlos1_vote_gpu_smmu_clk = {
>         .clkr = {
>                 .enable_reg = 0x5000,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_hlos1_vote_gpu_smmu_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> @@ -308,7 +308,7 @@ static struct clk_branch gpu_cc_hub_aon_clk = {
>         .clkr = {
>                 .enable_reg = 0x1178,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_hub_aon_clk",
>                         .parent_hws = (const struct clk_hw*[]){
>                                 &gpu_cc_hub_clk_src.clkr.hw,
> @@ -326,7 +326,7 @@ static struct clk_branch gpu_cc_hub_cx_int_clk = {
>         .clkr = {
>                 .enable_reg = 0x1204,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_hub_cx_int_clk",
>                         .parent_hws = (const struct clk_hw*[]){
>                                 &gpu_cc_hub_cx_int_div_clk_src.clkr.hw,
> @@ -344,7 +344,7 @@ static struct clk_branch gpu_cc_mnd1x_0_gfx3d_clk = {
>         .clkr = {
>                 .enable_reg = 0x802c,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_mnd1x_0_gfx3d_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> @@ -357,7 +357,7 @@ static struct clk_branch gpu_cc_mnd1x_1_gfx3d_clk = {
>         .clkr = {
>                 .enable_reg = 0x8030,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_mnd1x_1_gfx3d_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> @@ -370,7 +370,7 @@ static struct clk_branch gpu_cc_sleep_clk = {
>         .clkr = {
>                 .enable_reg = 0x1090,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "gpu_cc_sleep_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
> index b39ee1c9647b..ef055706b442 100644
> --- a/drivers/clk/qcom/lpasscc-sc7280.c
> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2022, The Linux Foundation. All rights reserved.
>   */
>
>  #include <linux/clk-provider.h>
> @@ -23,7 +23,7 @@ static struct clk_branch lpass_q6ss_ahbm_clk = {
>         .clkr = {
>                 .enable_reg = 0x1c,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "lpass_q6ss_ahbm_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> @@ -36,7 +36,7 @@ static struct clk_branch lpass_q6ss_ahbs_clk = {
>         .clkr = {
>                 .enable_reg = 0x20,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "lpass_q6ss_ahbs_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> @@ -49,7 +49,7 @@ static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk = {
>         .clkr = {
>                 .enable_reg = 0x0,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "lpass_top_cc_lpi_q6_axim_hs_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> @@ -63,7 +63,7 @@ static struct clk_branch lpass_qdsp6ss_core_clk = {
>         .clkr = {
>                 .enable_reg = 0x20,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "lpass_qdsp6ss_core_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> @@ -77,7 +77,7 @@ static struct clk_branch lpass_qdsp6ss_xo_clk = {
>         .clkr = {
>                 .enable_reg = 0x38,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "lpass_qdsp6ss_xo_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> @@ -91,7 +91,7 @@ static struct clk_branch lpass_qdsp6ss_sleep_clk = {
>         .clkr = {
>                 .enable_reg = 0x3c,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "lpass_qdsp6ss_sleep_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> diff --git a/drivers/clk/qcom/videocc-sc7280.c b/drivers/clk/qcom/videocc-sc7280.c
> index 615695d82319..ba192ce6163e 100644
> --- a/drivers/clk/qcom/videocc-sc7280.c
> +++ b/drivers/clk/qcom/videocc-sc7280.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2022, The Linux Foundation. All rights reserved.
>   */
>
>  #include <linux/clk-provider.h>
> @@ -45,10 +45,10 @@ static struct clk_alpha_pll video_pll0 = {
>         .num_vco = ARRAY_SIZE(lucid_vco),
>         .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
>         .clkr = {
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "video_pll0",
>                         .parent_data = &(const struct clk_parent_data){
> -                               .fw_name = "bi_tcxo",
> +                               .index = 0,
>                         },
>                         .num_parents = 1,
>                         .ops = &clk_alpha_pll_lucid_ops,
> @@ -62,7 +62,7 @@ static const struct parent_map video_cc_parent_map_0[] = {
>  };
>
>  static const struct clk_parent_data video_cc_parent_data_0[] = {
> -       { .fw_name = "bi_tcxo" },
> +       { .index = 0 },
>         { .hw = &video_pll0.clkr.hw },
>  };
>
> @@ -89,7 +89,7 @@ static struct clk_rcg2 video_cc_iris_clk_src = {
>         .hid_width = 5,
>         .parent_map = video_cc_parent_map_0,
>         .freq_tbl = ftbl_video_cc_iris_clk_src,
> -       .clkr.hw.init = &(struct clk_init_data){
> +       .clkr.hw.init = &(const struct clk_init_data){
>                 .name = "video_cc_iris_clk_src",
>                 .parent_data = video_cc_parent_data_0,
>                 .num_parents = ARRAY_SIZE(video_cc_parent_data_0),
> @@ -109,7 +109,7 @@ static struct clk_rcg2 video_cc_sleep_clk_src = {
>         .hid_width = 5,
>         .parent_map = video_cc_parent_map_1,
>         .freq_tbl = ftbl_video_cc_sleep_clk_src,
> -       .clkr.hw.init = &(struct clk_init_data){
> +       .clkr.hw.init = &(const struct clk_init_data){
>                 .name = "video_cc_sleep_clk_src",
>                 .parent_data = video_cc_parent_data_1,
>                 .num_parents = ARRAY_SIZE(video_cc_parent_data_1),
> @@ -123,7 +123,7 @@ static struct clk_branch video_cc_iris_ahb_clk = {
>         .clkr = {
>                 .enable_reg = 0x5004,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "video_cc_iris_ahb_clk",
>                         .parent_hws = (const struct clk_hw*[]){
>                                 &video_cc_iris_clk_src.clkr.hw,
> @@ -141,7 +141,7 @@ static struct clk_branch video_cc_mvs0_axi_clk = {
>         .clkr = {
>                 .enable_reg = 0x800c,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "video_cc_mvs0_axi_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> @@ -156,7 +156,7 @@ static struct clk_branch video_cc_mvs0_core_clk = {
>         .clkr = {
>                 .enable_reg = 0x3010,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "video_cc_mvs0_core_clk",
>                         .parent_hws = (const struct clk_hw*[]){
>                                 &video_cc_iris_clk_src.clkr.hw,
> @@ -174,7 +174,7 @@ static struct clk_branch video_cc_mvsc_core_clk = {
>         .clkr = {
>                 .enable_reg = 0x2014,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "video_cc_mvsc_core_clk",
>                         .parent_hws = (const struct clk_hw*[]){
>                                 &video_cc_iris_clk_src.clkr.hw,
> @@ -192,7 +192,7 @@ static struct clk_branch video_cc_mvsc_ctl_axi_clk = {
>         .clkr = {
>                 .enable_reg = 0x8004,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "video_cc_mvsc_ctl_axi_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> @@ -205,7 +205,7 @@ static struct clk_branch video_cc_sleep_clk = {
>         .clkr = {
>                 .enable_reg = 0x7034,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "video_cc_sleep_clk",
>                         .parent_hws = (const struct clk_hw*[]){
>                                 &video_cc_sleep_clk_src.clkr.hw,
> @@ -223,7 +223,7 @@ static struct clk_branch video_cc_venus_ahb_clk = {
>         .clkr = {
>                 .enable_reg = 0x801c,
>                 .enable_mask = BIT(0),
> -               .hw.init = &(struct clk_init_data){
> +               .hw.init = &(const struct clk_init_data){
>                         .name = "video_cc_venus_ahb_clk",
>                         .ops = &clk_branch2_ops,
>                 },
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
>


-- 
With best wishes
Dmitry
