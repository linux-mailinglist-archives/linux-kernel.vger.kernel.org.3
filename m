Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D264352E87A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347633AbiETJNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347583AbiETJNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:13:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1010118030
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:13:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kq17so14466104ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRRyXBAMdaUQcvr7P130WMrTlU9twmxBI/F4JADwZX4=;
        b=GTNJaeW179p1zmS6cE+Rq8JDZaXGEzd1s6G8CvRfw7WyaBFPvXVlhFA5ZzZNu9/Kty
         29hATcLJx5y0J0GEvNM6SPTOzueFpYPpP6w5ncZvR/j+Pjzusy6xlDY7DDPZhqrSwkyu
         K0ha34MMbNpb3QENfHzsWuu5yrCDbL3Qx2wR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRRyXBAMdaUQcvr7P130WMrTlU9twmxBI/F4JADwZX4=;
        b=btXLq4/ajYEkTQV31xh4IYWi8/Tf197P0mt+PXS+bDxADCJ9sx9FVAlKtvXEdAtvrM
         vdbkSEAwp90UCMCLKBq2WHo0DqVK/zkxFdQmXOXznqZRDGUJOcuvVVdlDWzYLY22WU7L
         HhzzcQORIB2k04rD5eQIipGXBYBOVYF//tDnpghMh9oenQ1y0Pcj6/ckHhIKx2AIXAQj
         B0RSvWOAJ8v1klA3MNhWoQfllA2Glb4gCEEY21SO7CIqKVXkjedssoLuZb1NvO6vPc1v
         VGOJiirXDf1PmSA4MKEqIRl0dFuVP4TL5peB8kiEJ9UeLnK1/OsTOSAtHf5a3LrX6O3/
         0Yvg==
X-Gm-Message-State: AOAM53348+uMDHUDKf5G/zNoSZY9vmosNH9o2cgmjZE9S+NVOcYzR7Df
        OWnFZk2YVloN85JCQYYc/0eMJI6G1VyyVSf4b+y6LQ==
X-Google-Smtp-Source: ABdhPJyF3XzL3rcQv+7nwk+LUAnyEDcuvUKsXjTn90VIqxdjucSROEdkQRcR74cEFJ8tWDimKVn3EFHzznO4N5Ec2Bg=
X-Received: by 2002:a17:906:a10e:b0:6f3:e70b:b572 with SMTP id
 t14-20020a170906a10e00b006f3e70bb572mr7587780ejy.546.1653038025359; Fri, 20
 May 2022 02:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220519134728.456643-1-y.oudjana@protonmail.com> <20220519134728.456643-7-y.oudjana@protonmail.com>
In-Reply-To: <20220519134728.456643-7-y.oudjana@protonmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 20 May 2022 17:13:34 +0800
Message-ID: <CAGXv+5Gws-YHkKzUUuQeVdVVtqyCrv1HfS+wdNvwsTGVJaPR+g@mail.gmail.com>
Subject: Re: [PATCH 6/6] clk: mediatek: Add support for other clock types in
 simple probe/remove
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 9:50 PM Yassine Oudjana
<yassine.oudjana@gmail.com> wrote:
>
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> Simple probe/remove functions currently support gates only. Add
> PLLs, fixed clocks, fixed factors and muxes to support most
> clock controllers. struct mtk_clk_desc now takes descriptions
> for all of these clocks, and only the ones set will be registered.
> Most clock controllers will only use a subset of the types
> supported.

I assume this mostly benefits the apmixedsys (PLL) and topckgen
(mix of dividers and muxes and gates) drivers.

I plan on introducing |struct clk_hw *| based clk_parent_data for internal
clock parents. This will require parent clocks be registered before child
clocks. Depending on the hardware, registration of different clock types
would need to be interweaved, and we would end up losing any benefits this
patch brings.

I would hold off on this patch until we have a clearer picture of what
needs to be done. At least two or three clock drivers that can use this
should be introduced or converted

> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Dependencies:
> - clk: mediatek: Move to struct clk_hw provider APIs (series)
>   https://patchwork.kernel.org/project/linux-mediatek/cover/20220510104804.544597-1-wenst@chromium.org/
> - Cleanup MediaTek clk reset drivers and support MT8192/MT8195 (series)
>   https://patchwork.kernel.org/project/linux-mediatek/cover/20220503093856.22250-1-rex-bc.chen@mediatek.com/
> - Export required symbols to compile clk drivers as module (single patch)
>   https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/
>
>  drivers/clk/mediatek/clk-mtk.c | 88 +++++++++++++++++++++++++++++-----
>  drivers/clk/mediatek/clk-mtk.h | 17 ++++++-
>  2 files changed, 92 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index 3382802663f4..df1209d5b6fb 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -15,8 +15,10 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> -#include "clk-mtk.h"
>  #include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-mux.h"
> +#include "clk-pll.h"
>
>  struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
>  {
> @@ -434,20 +436,55 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
>         if (!clk_ctrl)
>                 return -ENOMEM;
>
> -       clk_ctrl->clk_data = mtk_alloc_clk_data(mcd->num_clks);
> +       clk_ctrl->clk_data = mtk_alloc_clk_data(mcd->num_plls
> +                                             + mcd->num_fixed_clks
> +                                             + mcd->num_factors
> +                                             + mcd->num_muxes
> +                                             + mcd->num_gates);

There are also dividers and composite clocks.

ChenYu

>         if (!clk_ctrl->clk_data) {
>                 r = -ENOMEM;
>                 goto free_clk_ctrl;
>         }
>
> -       r = mtk_clk_register_gates_with_dev(node, mcd->clks, mcd->num_clks,
> -                                           clk_ctrl->clk_data, &pdev->dev);
> -       if (r)
> -               goto free_clk_data;
> +       if (mcd->plls) {
> +               r = mtk_clk_register_plls(node, mcd->plls, mcd->num_plls,
> +                                         clk_ctrl->clk_data);
> +               if (r)
> +                       goto free_clk_data;
> +       }
> +
> +       if (mcd->fixed_clks) {
> +               r = mtk_clk_register_fixed_clks(mcd->fixed_clks, mcd->num_fixed_clks,
> +                                               clk_ctrl->clk_data);
> +               if (r)
> +                       goto unregister_plls;
> +       }
> +
> +       if (mcd->factors) {
> +               r = mtk_clk_register_factors(mcd->factors, mcd->num_factors,
> +                                            clk_ctrl->clk_data);
> +               if (r)
> +                       goto unregister_fixed_clks;
> +       }
> +
> +       if (mcd->muxes) {
> +               spin_lock_init(&clk_ctrl->mux_lock);
> +               r = mtk_clk_register_muxes(mcd->muxes, mcd->num_muxes, node,
> +                                          &clk_ctrl->mux_lock, clk_ctrl->clk_data);
> +               if (r)
> +                       goto unregister_factors;
> +       }
> +
> +       if (mcd->gates) {
> +               r = mtk_clk_register_gates_with_dev(node, mcd->gates, mcd->num_gates,
> +                                                   clk_ctrl->clk_data, &pdev->dev);
> +               if (r)
> +                       goto unregister_muxes;
> +       }
>
>         r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_ctrl->clk_data);
>         if (r)
> -               goto unregister_clks;
> +               goto unregister_gates;
>
>         platform_set_drvdata(pdev, clk_ctrl);
>
> @@ -457,14 +494,30 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
>                                                                mcd->rst_desc);
>                 if (IS_ERR(clk_ctrl->rst_data)) {
>                         r = PTR_ERR(clk_ctrl->rst_data);
> -                       goto unregister_clks;
> +                       goto unregister_clk_provider;
>                 }
>         }
>
>         return r;
>
> -unregister_clks:
> -       mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_ctrl->clk_data);
> +unregister_clk_provider:
> +       of_clk_del_provider(node);
> +unregister_gates:
> +       if (mcd->gates)
> +               mtk_clk_unregister_gates(mcd->gates, mcd->num_gates, clk_ctrl->clk_data);
> +unregister_muxes:
> +       if (mcd->muxes)
> +               mtk_clk_unregister_muxes(mcd->muxes, mcd->num_muxes, clk_ctrl->clk_data);
> +unregister_factors:
> +       if (mcd->factors)
> +               mtk_clk_unregister_factors(mcd->factors, mcd->num_factors, clk_ctrl->clk_data);
> +unregister_fixed_clks:
> +       if (mcd->fixed_clks)
> +               mtk_clk_unregister_fixed_clks(mcd->fixed_clks, mcd->num_fixed_clks,
> +                                             clk_ctrl->clk_data);
> +unregister_plls:
> +       if (mcd->plls)
> +               mtk_clk_unregister_plls(mcd->plls, mcd->num_plls, clk_ctrl->clk_data);
>  free_clk_data:
>         mtk_free_clk_data(clk_ctrl->clk_data);
>  free_clk_ctrl:
> @@ -480,9 +533,22 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
>         struct device_node *node = pdev->dev.of_node;
>
>         of_clk_del_provider(node);
> +
>         if (clk_ctrl->rst_data)
>                 mtk_unregister_reset_controller(clk_ctrl->rst_data);
> -       mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_ctrl->clk_data);
> +
> +       if (mcd->gates)
> +               mtk_clk_unregister_gates(mcd->gates, mcd->num_gates, clk_ctrl->clk_data);
> +       if (mcd->muxes)
> +               mtk_clk_unregister_muxes(mcd->muxes, mcd->num_muxes, clk_ctrl->clk_data);
> +       if (mcd->factors)
> +               mtk_clk_unregister_factors(mcd->factors, mcd->num_factors, clk_ctrl->clk_data);
> +       if (mcd->fixed_clks)
> +               mtk_clk_unregister_fixed_clks(mcd->fixed_clks, mcd->num_fixed_clks,
> +                                             clk_ctrl->clk_data);
> +       if (mcd->plls)
> +               mtk_clk_unregister_plls(mcd->plls, mcd->num_plls, clk_ctrl->clk_data);
> +
>         mtk_free_clk_data(clk_ctrl->clk_data);
>         kfree(clk_ctrl);
>
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index fa092bca97c8..23bce98bca20 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -13,6 +13,9 @@
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>
> +#include "clk-gate.h"
> +#include "clk-mux.h"
> +#include "clk-pll.h"
>  #include "reset.h"
>
>  #define MAX_MUX_GATE_BIT       31
> @@ -191,12 +194,22 @@ struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
>
>  struct mtk_simple_clk_controller {
>         struct clk_hw_onecell_data *clk_data;
> +       spinlock_t mux_lock;
>         struct mtk_clk_rst_data *rst_data;
>  };
>
>  struct mtk_clk_desc {
> -       const struct mtk_gate *clks;
> -       size_t num_clks;
> +       const struct mtk_pll_data *plls;
> +       size_t num_plls;
> +       const struct mtk_fixed_clk *fixed_clks;
> +       size_t num_fixed_clks;
> +       const struct mtk_fixed_factor *factors;
> +       size_t num_factors;
> +       const struct mtk_mux *muxes;
> +       size_t num_muxes;
> +       const struct mtk_gate *gates;
> +       size_t num_gates;
> +
>         const struct mtk_clk_rst_desc *rst_desc;
>  };
>
> --
> 2.36.1
>
