Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5148F531EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiEWWef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiEWWeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:34:31 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740DB95A09
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:34:30 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id r84so2459718qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQ0pqMkGPO55UZVFteq/t7UQsL7DsWYAaeh+h0/4AHw=;
        b=Elmb2wuJeIQwOwyoYtoXj7BMSqe1Ie8BhMSfyh7oszPuVrwBsMgj+6CDb4Og1WmnoC
         yzCf/MLIHHgn/Pz7iiqxLv3R4bE+fIiEEWspknnAEwYJjZCm98MVTVRUI7tmwaVW5Di9
         rFVAyxuXvCOU+QdvbjKPWisSl0ds/fgP3xFm8H3zMzUQhGyqwFPBpybsSkuPOBoIr0a6
         vjG+HxijuuXo61DoNWYo2Hr2ZnF0GwEK5JrWPS08r9bGmBDUKLoj8L+aPLujis4pA2db
         6cQ9JUfalXO06Or3s8GRa7C8474FrG9EPSYgnZBfAGap5G9vIVYoa/uWBJAo2g3h7bIk
         IRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQ0pqMkGPO55UZVFteq/t7UQsL7DsWYAaeh+h0/4AHw=;
        b=G4Y9kXqtGwdGVvKm4wdPcIeeZexNf0UyH9cezAM8vKk04ivYCrD6K7v7lze6aPwea0
         NiqnOorEBiTCiF8QjYGfhscpGlXB+tKpHdLDi3xKQniGoqnFjbbatLpMkwvQyw7RgXED
         WIT4A9G0lHZ1g96lIcmTOZ7fHUjXhrYfJGWhdEGM+ORHMO08Kq51d9V3aCUA3eTES7ca
         eepin+g31YXZ90FRG5zrTMgBEfizi0r8PFl+1ygV6hS5hknndloF54uEt9QSqioerYeS
         9fHAAkN/kwhL9hUtS32o3qLGT70yfPE+A1TFAeuuHLmr65uP5CasSk1APLagtWkEzmOR
         qqjw==
X-Gm-Message-State: AOAM532rc0RkgEFfGiZrISOQiIq8tO5O5XxJSxERoA9lYVVS1hL4Z7mr
        kdo4E8ezbo5z1y43omBx6U1OkPDSDKA4/34p7gaD07u7HNg=
X-Google-Smtp-Source: ABdhPJzgyd8M6po0gCsUtNfX7wRhP9f0kou7QpoyTW7nIY6wdzgcbzEl3gTil8T/z7vmEVnCVWL5Hvi0+mDVLNLoPMY=
X-Received: by 2002:a37:6883:0:b0:6a3:42ae:e17b with SMTP id
 d125-20020a376883000000b006a342aee17bmr13039864qkc.59.1653345269240; Mon, 23
 May 2022 15:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220523213837.1016542-1-marijn.suijten@somainline.org> <20220523213837.1016542-5-marijn.suijten@somainline.org>
In-Reply-To: <20220523213837.1016542-5-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 24 May 2022 01:34:18 +0300
Message-ID: <CAA8EJpqcN=UdqVnuShetYY45f2QV8w5nk_vKW47B7oS74O38yQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] drm/msm/dsi_phy_28nm: Replace parent names with
 clk_hw pointers
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2022 at 00:38, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> parent_hw pointers are easier to manage and cheaper to use than
> repeatedly formatting the parent name and subsequently leaving the clk
> framework to perform lookups based on that name.
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>



> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c | 52 +++++++++-------------
>  1 file changed, 22 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> index 48eab80b548e..6926c8ff6255 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> @@ -519,7 +519,7 @@ static int dsi_28nm_pll_restore_state(struct msm_dsi_phy *phy)
>
>  static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **provided_clocks)
>  {
> -       char clk_name[32], parent1[32], parent2[32], vco_name[32];
> +       char clk_name[32], vco_name[32];

While we are at it, we might also get rid of vco_name and use clk_name
everywhere.

>         struct clk_init_data vco_init = {
>                 .parent_data = &(const struct clk_parent_data) {
>                         .fw_name = "ref", .name = "xo",
> @@ -529,7 +529,7 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
>                 .flags = CLK_IGNORE_UNUSED,
>         };
>         struct device *dev = &pll_28nm->phy->pdev->dev;
> -       struct clk_hw *hw;
> +       struct clk_hw *hw, *analog_postdiv, *indirect_path_div2, *byte_mux;
>         int ret;
>
>         DBG("%d", pll_28nm->phy->id);
> @@ -546,48 +546,40 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
>                 return ret;
>
>         snprintf(clk_name, 32, "dsi%danalog_postdiv_clk", pll_28nm->phy->id);
> -       snprintf(parent1, 32, "dsi%dvco_clk", pll_28nm->phy->id);
> -       hw = devm_clk_hw_register_divider(dev, clk_name,
> -                       parent1, CLK_SET_RATE_PARENT,
> +       analog_postdiv = devm_clk_hw_register_divider_parent_hw(dev, clk_name,
> +                       &pll_28nm->clk_hw, CLK_SET_RATE_PARENT,
>                         pll_28nm->phy->pll_base +
> -                       REG_DSI_28nm_PHY_PLL_POSTDIV1_CFG,
> -                       0, 4, 0, NULL);
> -       if (IS_ERR(hw))
> -               return PTR_ERR(hw);
> +                       REG_DSI_28nm_PHY_PLL_POSTDIV1_CFG, 0, 4, 0, NULL);

The diff is already hard enough to read. Could you please drop
syntax/whitespace/newline changes?

> +       if (IS_ERR(analog_postdiv))
> +               return PTR_ERR(analog_postdiv);
>
>         snprintf(clk_name, 32, "dsi%dindirect_path_div2_clk", pll_28nm->phy->id);
> -       snprintf(parent1, 32, "dsi%danalog_postdiv_clk", pll_28nm->phy->id);
> -       hw = devm_clk_hw_register_fixed_factor(dev, clk_name,
> -                       parent1, CLK_SET_RATE_PARENT,
> -                       1, 2);
> -       if (IS_ERR(hw))
> -               return PTR_ERR(hw);
> +       indirect_path_div2 = devm_clk_hw_register_fixed_factor_parent_hw(dev,
> +                       clk_name, analog_postdiv, CLK_SET_RATE_PARENT, 1, 2);
> +       if (IS_ERR(indirect_path_div2))
> +               return PTR_ERR(indirect_path_div2);
>
>         snprintf(clk_name, 32, "dsi%dpll", pll_28nm->phy->id);
> -       snprintf(parent1, 32, "dsi%dvco_clk", pll_28nm->phy->id);
> -       hw = devm_clk_hw_register_divider(dev, clk_name,
> -                               parent1, 0, pll_28nm->phy->pll_base +
> -                               REG_DSI_28nm_PHY_PLL_POSTDIV3_CFG,
> -                               0, 8, 0, NULL);
> +       hw = devm_clk_hw_register_divider_parent_hw(dev, clk_name,
> +                       &pll_28nm->clk_hw, 0, pll_28nm->phy->pll_base +
> +                       REG_DSI_28nm_PHY_PLL_POSTDIV3_CFG, 0, 8, 0, NULL);
>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);
>         provided_clocks[DSI_PIXEL_PLL_CLK] = hw;
>
>         snprintf(clk_name, 32, "dsi%dbyte_mux", pll_28nm->phy->id);
> -       snprintf(parent1, 32, "dsi%dvco_clk", pll_28nm->phy->id);
> -       snprintf(parent2, 32, "dsi%dindirect_path_div2_clk", pll_28nm->phy->id);
> -       hw = devm_clk_hw_register_mux(dev, clk_name,
> -                       ((const char *[]){
> -                               parent1, parent2
> +       byte_mux = devm_clk_hw_register_mux_parent_hws(dev, clk_name,
> +                       ((const struct clk_hw *[]){
> +                               &pll_28nm->clk_hw,
> +                               indirect_path_div2,
>                         }), 2, CLK_SET_RATE_PARENT, pll_28nm->phy->pll_base +
>                         REG_DSI_28nm_PHY_PLL_VREG_CFG, 1, 1, 0, NULL);
> -       if (IS_ERR(hw))
> -               return PTR_ERR(hw);
> +       if (IS_ERR(byte_mux))
> +               return PTR_ERR(byte_mux);
>
>         snprintf(clk_name, 32, "dsi%dpllbyte", pll_28nm->phy->id);
> -       snprintf(parent1, 32, "dsi%dbyte_mux", pll_28nm->phy->id);
> -       hw = devm_clk_hw_register_fixed_factor(dev, clk_name,
> -                               parent1, CLK_SET_RATE_PARENT, 1, 4);
> +       hw = devm_clk_hw_register_fixed_factor_parent_hw(dev, clk_name,
> +                       byte_mux, CLK_SET_RATE_PARENT, 1, 4);
>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);
>         provided_clocks[DSI_BYTE_PLL_CLK] = hw;
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
