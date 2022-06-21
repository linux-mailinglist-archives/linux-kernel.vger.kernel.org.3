Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587E1553870
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352775AbiFURCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352719AbiFURCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:02:42 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C45E2B1B3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:02:41 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id n15so17263247qvh.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9E6OOWWmHUnFPmVEUbaaoDgDCcF2pNqS9Ky9WNG+x4=;
        b=h9wEohlZyV+hnFpWZ9mmnBLqNOfe8FMx/TR8gS3CaffcEBrn34wday/X9XEVnIbmbU
         V+8p9mJwxQKKUZGaj8gYJwyuPTGvqtonDL1aMKPIC50YoHYj1W+URMN9xmSwAoiiWgAu
         dH6VdS8zgCJj4cNMzAo1IaD3bfmCiVr6VIsyv21B4W7qhp4Dcbh24RLFaO+O2riErUHT
         Qb8YcCdRJJpnUXWBJFQZjvxios/x0A6+dCjl3hzLSkladovZNNm6BmnAH/j7wCkOVXZ3
         cmP4dgiKJxIefRNew0ajmo7MVUax647xIve8XB8zCXtPiLTLU0169BqHi8Q+F0rEqmem
         iTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9E6OOWWmHUnFPmVEUbaaoDgDCcF2pNqS9Ky9WNG+x4=;
        b=oEexn6FSelYdk6KoUyMJsWHwlwVB0ghsNO5uINtCX2rjbi/9VaWTz8RB5Y8f3hbWZD
         ykauaX78ErZsgDNEv35z5znsAYSMSuBVc+VUoCP5AkKkULoTMTmPi8F2uSJXUEETIylq
         SxSeqpQZ8wAJW1rQHp0hb2MJrPskqQsv1kulw1nUtxo5ilrKsGsVdfUWGtjMex28zK5v
         gYamNi1P9C5+1PICN9xIbVvzruOk1ddU5XdLus0B/RT8winLBBO8rIIZzNbEFq6FfaV7
         ATTRdtTFuoBiL0+8eLpzmQPbycBNKTWZ7errwaOODSvMOv/CZzf23Skm+Zq0dC8yzV+Q
         x4GQ==
X-Gm-Message-State: AJIora8DTL+TehnZvzookEESwwppvZsIMlxE+atrvn6qIAtKubfxMxeX
        8LWCJylKGMNZOZnzVf0pGz0KdvbHODjaWjtseACelA==
X-Google-Smtp-Source: AGRyM1v5pbIf8EsEEmdzUNlCqqSg+CLeUO/O65ZywOsSGIeTy6hl/Pt6uNtbQLt4+TpW5mnuINQ7K+PnCrozaGtC7J8=
X-Received: by 2002:ac8:7e87:0:b0:306:6575:6035 with SMTP id
 w7-20020ac87e87000000b0030665756035mr24919815qtj.629.1655830959689; Tue, 21
 Jun 2022 10:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160621.24415-1-y.oudjana@protonmail.com> <20220621160621.24415-3-y.oudjana@protonmail.com>
In-Reply-To: <20220621160621.24415-3-y.oudjana@protonmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Jun 2022 20:02:28 +0300
Message-ID: <CAA8EJpq4YYdeXVtYORaDROiFLRL6p-_jmjx3mj4JtrYDhik3hQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] clk: qcom: msm8996-cpu: Statically define PLL dividers
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
> This will allow for adding them to clk_parent_data arrays
> in an upcoming patch.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  drivers/clk/qcom/clk-cpu-8996.c | 66 +++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
> index 5dc68dc3621f..217f9392c23d 100644
> --- a/drivers/clk/qcom/clk-cpu-8996.c
> +++ b/drivers/clk/qcom/clk-cpu-8996.c
> @@ -135,6 +135,34 @@ static struct clk_alpha_pll pwrcl_pll = {
>         },
>  };
>
> +static struct clk_fixed_factor pwrcl_pll_postdiv = {
> +       .mult = 1,
> +       .div = 2,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "pwrcl_pll_postdiv",
> +               .parent_data = &(const struct clk_parent_data){
> +                       .hw = &pwrcl_pll.clkr.hw
> +               },
> +               .num_parents = 1,
> +               .ops = &clk_fixed_factor_ops,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_fixed_factor perfcl_pll_postdiv = {
> +       .mult = 1,
> +       .div = 2,
> +       .hw.init = &(struct clk_init_data){
> +               .name = "perfcl_pll_postdiv",
> +               .parent_data = &(const struct clk_parent_data){
> +                       .hw = &perfcl_pll.clkr.hw
> +               },
> +               .num_parents = 1,
> +               .ops = &clk_fixed_factor_ops,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
>  static const struct pll_vco alt_pll_vco_modes[] = {
>         VCO(3,  250000000,  500000000),
>         VCO(2,  500000000,  750000000),
> @@ -261,7 +289,7 @@ static struct clk_cpu_8996_mux pwrcl_smux = {
>                 .name = "pwrcl_smux",
>                 .parent_names = (const char *[]){
>                         "xo",
> -                       "pwrcl_pll_main",
> +                       "pwrcl_pll_postdiv",
>                 },
>                 .num_parents = 2,
>                 .ops = &clk_cpu_8996_mux_ops,
> @@ -277,7 +305,7 @@ static struct clk_cpu_8996_mux perfcl_smux = {
>                 .name = "perfcl_smux",
>                 .parent_names = (const char *[]){
>                         "xo",
> -                       "perfcl_pll_main",
> +                       "perfcl_pll_postdiv",
>                 },
>                 .num_parents = 2,
>                 .ops = &clk_cpu_8996_mux_ops,
> @@ -354,32 +382,25 @@ static int qcom_cpu_clk_msm8996_register_clks(struct device *dev,
>  {
>         int i, ret;
>
> -       perfcl_smux.pll = clk_hw_register_fixed_factor(dev, "perfcl_pll_main",
> -                                                      "perfcl_pll",
> -                                                      CLK_SET_RATE_PARENT,
> -                                                      1, 2);
> -       if (IS_ERR(perfcl_smux.pll)) {
> -               dev_err(dev, "Failed to initialize perfcl_pll_main\n");
> -               return PTR_ERR(perfcl_smux.pll);
> +       ret = devm_clk_hw_register(dev, &pwrcl_pll_postdiv.hw);

No need to. I'd suggest picking up the
devm_clk_hw_register_fixed_factor patch from my patchset and using
this API.

> +       if (ret) {
> +               dev_err(dev, "Failed to register pwrcl_pll_postdiv: %d", ret);
> +               return ret;
>         }
>
> -       pwrcl_smux.pll = clk_hw_register_fixed_factor(dev, "pwrcl_pll_main",
> -                                                     "pwrcl_pll",
> -                                                     CLK_SET_RATE_PARENT,
> -                                                     1, 2);
> -       if (IS_ERR(pwrcl_smux.pll)) {
> -               dev_err(dev, "Failed to initialize pwrcl_pll_main\n");
> -               clk_hw_unregister(perfcl_smux.pll);
> -               return PTR_ERR(pwrcl_smux.pll);
> +       ret = devm_clk_hw_register(dev, &perfcl_pll_postdiv.hw);
> +       if (ret) {
> +               dev_err(dev, "Failed to register perfcl_pll_postdiv: %d", ret);
> +               return ret;
>         }
>
> +       pwrcl_smux.pll = &pwrcl_pll_postdiv.hw;
> +       perfcl_smux.pll = &perfcl_pll_postdiv.hw;
> +
>         for (i = 0; i < ARRAY_SIZE(cpu_msm8996_clks); i++) {
>                 ret = devm_clk_register_regmap(dev, cpu_msm8996_clks[i]);
> -               if (ret) {
> -                       clk_hw_unregister(perfcl_smux.pll);
> -                       clk_hw_unregister(pwrcl_smux.pll);
> +               if (ret)
>                         return ret;
> -               }
>         }
>
>         clk_alpha_pll_configure(&perfcl_pll, regmap, &hfpll_config);
> @@ -409,9 +430,6 @@ static int qcom_cpu_clk_msm8996_unregister_clks(void)
>         if (ret)
>                 return ret;
>
> -       clk_hw_unregister(perfcl_smux.pll);
> -       clk_hw_unregister(pwrcl_smux.pll);
> -
>         return 0;
>  }
>
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
