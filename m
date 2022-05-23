Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C8531EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiEWWo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiEWWoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:44:22 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A701ABF53
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:44:20 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id 11so11379717qtp.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMvYc5cVRi/7P7VqCcz6wkYkjkr+Z5yusPcVVwCNKu8=;
        b=fMix2ntTRVTtJnqBs7qMwFVLcxCsxu9pcBi+MZBc2cOnP1/pNBFG2awmR5pZp1XyR+
         db0opIiyTUz2rCd/AhfWOA7CtwAmfTF4bPG8MmEaymcT3Wtda9M+fYwZ0TpiEtx1OvwC
         YPXa0mWOEjgvZmgIuw4LDBAAUoNg4ADRbCJUBN7fGmDSEkg07UpjuE6Lk85JoR9wmtT1
         o9VFliz9vJ/hdI4LBtRuG0zkIXLI1tPYFXTg6+Ws0ddc2gMa2KRQz8y1ReVk5maCy/Pl
         2hQoPjiQ6y1rQoU7ZyHEFH0lKWNqEkLYlJwIRuV1jpiNiH/yJ2jeKUhizIgqMUFvqmtk
         YB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMvYc5cVRi/7P7VqCcz6wkYkjkr+Z5yusPcVVwCNKu8=;
        b=VAgsjmKAEVWX6syA5slRZc3NSF4NLlHhkZQF3StLapar37OMjz9Pd7oZpw22agODQz
         4VsYqRUSDCpRujKnEpJy7CegtAZ1NQLR0UH79IcMj5F82cLYB0t7U24rKGA65ODAgW/d
         O/WW+sx0JqoJeXIA2iigLC932EFv4QBxRDgTr3VrXWJObtTK6DcIV/Oz1G1Oe4AqEjTi
         lJgtygnsCijYvzUcTiNmf2HTzI4rBRuX2TaaPuSc98qpkPu6aNtM9ozDK6xG9HXp55mU
         eT+9tofwFgM6MqgPhHTm7fKUD1G4D3tizXBtLZFxCZlxEj6lKEJbG1LOVuaa43mhtXvk
         QBmw==
X-Gm-Message-State: AOAM531w+218FG+4MTV/gziWVTRkJN0ykAlZlEsyVzH1P/nPwTjzzwSb
        agYzXdv5WhXtqH2abNA10TL16T2p9ctkyHL6mvz7Ww==
X-Google-Smtp-Source: ABdhPJzFO/4zafP3v1e6529SONTTFHEAZD4hPZ20zILccqfJCGhFe7ekBZASZWLj8O+KiuFhkOaPvlPHIfBEUUO/fS0=
X-Received: by 2002:a05:622a:13c8:b0:2f9:1cb4:9079 with SMTP id
 p8-20020a05622a13c800b002f91cb49079mr13032611qtk.629.1653345859783; Mon, 23
 May 2022 15:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220523213837.1016542-1-marijn.suijten@somainline.org> <20220523213837.1016542-6-marijn.suijten@somainline.org>
In-Reply-To: <20220523213837.1016542-6-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 24 May 2022 01:44:08 +0300
Message-ID: <CAA8EJprN833M+KOZXOyuaL_KqzEV61P69VXw7mfWo5OiXjE2FA@mail.gmail.com>
Subject: Re: [PATCH 5/9] drm/msm/dsi_phy_28nm_8960: Replace parent names with
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

Can you please add a followup patch (or a preface one) removing the
rest of devm_kzalloc()'ed clock names.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor nit below.

>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c    | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
> index fc56cdcc9ad6..943a7e847c90 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
> @@ -383,7 +383,7 @@ static int dsi_28nm_pll_restore_state(struct msm_dsi_phy *phy)
>
>  static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **provided_clocks)
>  {
> -       char *clk_name, *parent_name, *vco_name;
> +       char *clk_name, *vco_name;
>         struct clk_init_data vco_init = {
>                 .parent_data = &(const struct clk_parent_data) {
>                         .fw_name = "ref",
> @@ -408,10 +408,6 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
>         if (!vco_name)
>                 return -ENOMEM;
>
> -       parent_name = devm_kzalloc(dev, 32, GFP_KERNEL);
> -       if (!parent_name)
> -               return -ENOMEM;
> -
>         clk_name = devm_kzalloc(dev, 32, GFP_KERNEL);
>         if (!clk_name)
>                 return -ENOMEM;
> @@ -429,13 +425,14 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
>         bytediv->hw.init = &bytediv_init;
>         bytediv->reg = pll_28nm->phy->pll_base + REG_DSI_28nm_8960_PHY_PLL_CTRL_9;
>
> -       snprintf(parent_name, 32, "dsi%dvco_clk", pll_28nm->phy->id);
>         snprintf(clk_name, 32, "dsi%dpllbyte", pll_28nm->phy->id + 1);
>
>         bytediv_init.name = clk_name;
>         bytediv_init.ops = &clk_bytediv_ops;
>         bytediv_init.flags = CLK_SET_RATE_PARENT;
> -       bytediv_init.parent_names = (const char * const *) &parent_name;
> +       bytediv_init.parent_hws = (const struct clk_hw*[]){
> +               &pll_28nm->clk_hw,
> +       };
>         bytediv_init.num_parents = 1;

I wonder if we can express the bytediv clock with the standard ops.
However it's definitely a separate topic.

>
>         /* DIV2 */
> @@ -446,10 +443,9 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
>
>         snprintf(clk_name, 32, "dsi%dpll", pll_28nm->phy->id + 1);
>         /* DIV3 */
> -       hw = devm_clk_hw_register_divider(dev, clk_name,
> -                               parent_name, 0, pll_28nm->phy->pll_base +
> -                               REG_DSI_28nm_8960_PHY_PLL_CTRL_10,
> -                               0, 8, 0, NULL);
> +       hw = devm_clk_hw_register_divider_parent_hw(dev, clk_name,
> +                       &pll_28nm->clk_hw, 0, pll_28nm->phy->pll_base +
> +                       REG_DSI_28nm_8960_PHY_PLL_CTRL_10, 0, 8, 0, NULL);

Again, could you please keep the linebreak in place?


>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);
>         provided_clocks[DSI_PIXEL_PLL_CLK] = hw;
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
