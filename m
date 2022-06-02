Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5188F53B641
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiFBJlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiFBJlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:41:19 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B272ACB49
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 02:41:17 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id 2so3032336qtw.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+5xmN8tzm4yfZseavat68OsiHtVqwxHHx8/RWeyc+4=;
        b=g0FMJG+CJWzxQ5nHrXe6/IcFNv1QQs8i2qNUAocTxh5OX58wvzXMJ66dnGMAlRLpB5
         aWjYNri1hmi3o3bj1PgspYA6sDZBS49thfudipYais5J1/tdV/QawL1XzHnxzrQU/M+h
         TgC3OYe9zcocd0Eba6wCl3EIrcfi+ntuiSp8UYKc8QCyalionqGZcQvWwj09RqogwBKM
         QyhVCM4hyDTjmyuFt5eNwPUz96Lqmj+GiWrHT7GTTkL8E+cDPPxCnlVXrkhkkNkM5HiY
         ypkePhGbUzZPn2HeNzdnEu8EvBUv3HVYkqEpSeVcHnqszhF2qKP3wOMSSWSszrJrhnaL
         oCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+5xmN8tzm4yfZseavat68OsiHtVqwxHHx8/RWeyc+4=;
        b=hAfbIunW3hvcDklpKeIhaX0B+pV3T3sLrdoOk1oay+8TGLRrl1HcIEdVCQixmIgQgF
         USGAeq50GnU+US5LEuKkaPN8TFd1VETxfCk1+4DT9QmbmV4z11u2QCE5OelQWjJ1ucBh
         tnN9i9l6LcPK9jTec5gtU0YAzTmHbTFJ45gTeL7CmAr1DbnUbkpVGz/PFpmFHyzJPmJq
         FuOLhNCbZH8BQumeVDiaRrW5J+aNN4pSYeeNpjigU9nPL27WPr1sbYfgPj0bvyIDr4lI
         +py95dJ0QdL0dxiYECZ/XQR84G1jDIIwchmNc1uOQkLDmbObYGGVnHMAHnHkcuofHUxq
         SxpA==
X-Gm-Message-State: AOAM533KYoBRerLPGkR1FleRYPB6b9Y/v0a2b7VMOt0mClEefaRY1IIN
        aoMZKCLtZLFqgQSREd1fZrvbi8DMkhPV8Sgxn0gObQ==
X-Google-Smtp-Source: ABdhPJxyp4E9mIUELRAt3hKeewDZbymPZsMNra1fPCs5mzn7g3YgRgnluzUeI8h1VpPsbMbpq9HzviknH+LI+0U/M3Q=
X-Received: by 2002:ac8:5e54:0:b0:2f3:f4ee:efbd with SMTP id
 i20-20020ac85e54000000b002f3f4eeefbdmr2805119qtx.295.1654162876084; Thu, 02
 Jun 2022 02:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220601220747.1145095-1-marijn.suijten@somainline.org> <20220601220747.1145095-9-marijn.suijten@somainline.org>
In-Reply-To: <20220601220747.1145095-9-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Jun 2022 12:41:04 +0300
Message-ID: <CAA8EJpovxL1sUO9k0K_UzXxKdCBbt5QcRR_9K4H=GBtK4SwdXA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] drm/msm/dsi_phy_28nm: Replace parent names with
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

On Thu, 2 Jun 2022 at 01:08, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> parent_hw pointers are easier to manage and cheaper to use than
> repeatedly formatting the parent name and subsequently leaving the clk
> framework to perform lookups based on that name.
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c | 50 ++++++++++------------
>  1 file changed, 23 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> index 7d3cabeca743..04411fefb808 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
> @@ -519,17 +519,17 @@ static int dsi_28nm_pll_restore_state(struct msm_dsi_phy *phy)
>
>  static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **provided_clocks)
>  {
> -       char clk_name[32], parent1[32], parent2[32], vco_name[32];
> +       char clk_name[32];
>         struct clk_init_data vco_init = {
>                 .parent_data = &(const struct clk_parent_data) {
>                         .fw_name = "ref", .name = "xo",
>                 },
>                 .num_parents = 1,
> -               .name = vco_name,
> +               .name = clk_name,
>                 .flags = CLK_IGNORE_UNUSED,
>         };
>         struct device *dev = &pll_28nm->phy->pdev->dev;
> -       struct clk_hw *hw;
> +       struct clk_hw *hw, *analog_postdiv, *indirect_path_div2, *byte_mux;
>         int ret;
>
>         DBG("%d", pll_28nm->phy->id);
> @@ -539,32 +539,30 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
>         else
>                 vco_init.ops = &clk_ops_dsi_pll_28nm_vco_hpm;
>
> -       snprintf(vco_name, sizeof(vco_name), "dsi%dvco_clk", pll_28nm->phy->id);
> +       snprintf(clk_name, sizeof(clk_name), "dsi%dvco_clk", pll_28nm->phy->id);
>         pll_28nm->clk_hw.init = &vco_init;
>         ret = devm_clk_hw_register(dev, &pll_28nm->clk_hw);
>         if (ret)
>                 return ret;
>
>         snprintf(clk_name, sizeof(clk_name), "dsi%danalog_postdiv_clk", pll_28nm->phy->id);
> -       snprintf(parent1, sizeof(parent1), "dsi%dvco_clk", pll_28nm->phy->id);
> -       hw = devm_clk_hw_register_divider(dev, clk_name, parent1,
> -                       CLK_SET_RATE_PARENT, pll_28nm->phy->pll_base +
> +       analog_postdiv = devm_clk_hw_register_divider_parent_hw(dev, clk_name,
> +                       &pll_28nm->clk_hw, CLK_SET_RATE_PARENT,
> +                       pll_28nm->phy->pll_base +
>                                 REG_DSI_28nm_PHY_PLL_POSTDIV1_CFG,
>                         0, 4, 0, NULL);
> -       if (IS_ERR(hw))
> -               return PTR_ERR(hw);
> +       if (IS_ERR(analog_postdiv))
> +               return PTR_ERR(analog_postdiv);
>
>         snprintf(clk_name, sizeof(clk_name), "dsi%dindirect_path_div2_clk", pll_28nm->phy->id);
> -       snprintf(parent1, sizeof(parent1), "dsi%danalog_postdiv_clk", pll_28nm->phy->id);
> -       hw = devm_clk_hw_register_fixed_factor(dev, clk_name, parent1,
> -                       CLK_SET_RATE_PARENT, 1, 2);
> -       if (IS_ERR(hw))
> -               return PTR_ERR(hw);
> +       indirect_path_div2 = devm_clk_hw_register_fixed_factor_parent_hw(dev,
> +                       clk_name, analog_postdiv, CLK_SET_RATE_PARENT, 1, 2);
> +       if (IS_ERR(indirect_path_div2))
> +               return PTR_ERR(indirect_path_div2);
>
>         snprintf(clk_name, sizeof(clk_name), "dsi%dpll", pll_28nm->phy->id);
> -       snprintf(parent1, sizeof(parent1), "dsi%dvco_clk", pll_28nm->phy->id);
> -       hw = devm_clk_hw_register_divider(dev, clk_name, parent1, 0,
> -                       pll_28nm->phy->pll_base +
> +       hw = devm_clk_hw_register_divider_parent_hw(dev, clk_name,
> +                       &pll_28nm->clk_hw, 0, pll_28nm->phy->pll_base +
>                                 REG_DSI_28nm_PHY_PLL_POSTDIV3_CFG,
>                         0, 8, 0, NULL);
>         if (IS_ERR(hw))
> @@ -572,20 +570,18 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
>         provided_clocks[DSI_PIXEL_PLL_CLK] = hw;
>
>         snprintf(clk_name, sizeof(clk_name), "dsi%dbyte_mux", pll_28nm->phy->id);
> -       snprintf(parent1, sizeof(parent1), "dsi%dvco_clk", pll_28nm->phy->id);
> -       snprintf(parent2, sizeof(parent2), "dsi%dindirect_path_div2_clk", pll_28nm->phy->id);
> -       hw = devm_clk_hw_register_mux(dev, clk_name,
> -                       ((const char *[]){
> -                               parent1, parent2,
> +       byte_mux = devm_clk_hw_register_mux_parent_hws(dev, clk_name,
> +                       ((const struct clk_hw *[]){
> +                               &pll_28nm->clk_hw,
> +                               indirect_path_div2,
>                         }), 2, CLK_SET_RATE_PARENT, pll_28nm->phy->pll_base +
>                                 REG_DSI_28nm_PHY_PLL_VREG_CFG, 1, 1, 0, NULL);
> -       if (IS_ERR(hw))
> -               return PTR_ERR(hw);
> +       if (IS_ERR(byte_mux))
> +               return PTR_ERR(byte_mux);
>
>         snprintf(clk_name, sizeof(clk_name), "dsi%dpllbyte", pll_28nm->phy->id);
> -       snprintf(parent1, sizeof(parent1), "dsi%dbyte_mux", pll_28nm->phy->id);
> -       hw = devm_clk_hw_register_fixed_factor(dev, clk_name, parent1,
> -                       CLK_SET_RATE_PARENT, 1, 4);
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
