Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1A0530D19
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiEWKVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiEWKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:21:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DD5C30
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:20:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i40so18474976eda.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVZuqJKxfK/LKRySxF+QMkbTfearZe0k0KO+kDBVY5o=;
        b=VKpvgn4WCt46NyC6Afa1B13yW2JftlOPDLNcTegz/NYS+RNaSOeNz0zuyoicV5TJor
         T3waBzR/q32WtORp9+t0DVglZCVQx/aTqUCoO7HiovOq3K+HxtvezFtLpz5wBf7OMSjn
         MbrpNZ6f/cvDkURYavv/cNIiy/3YXg5+bLXDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVZuqJKxfK/LKRySxF+QMkbTfearZe0k0KO+kDBVY5o=;
        b=PppoGl/3ZTpNfdQ/O02TlJgZf4p/PbCzZcGjgLy1N9sid7tGU82kt9IzlAnylF2GJS
         qWCIJL8BQ2lVsYCCrfnGwXQ3bsxvb+KNeqHAibZab7HmlwX5THXevU4KsulSzhkYHq1C
         6IJ3WFvp11SqvyrHSKDoCYEKDKUINRgbyQsFeEvsBcWGxnb9PFo9kbob1xKIfHUOkHHw
         bHmzpeKhaSsIA/J1ywqBFOiRcrEAVABYPlF6ZbiXvAxgLVvO8HYT8y5nqSDAPf9x9hWg
         IQ+f4vAiKNlN4hYkVYpCbk9084M7Loo/MapdsRMv9p80047zcE2P/FxsgJDZFT+Yufhn
         xGVQ==
X-Gm-Message-State: AOAM533R4Ny9LM2tMI/Hr875XaXUge1BXHVP2RJm0qCPfBQ3rmvR/FId
        6oAwcYoyWpX7RscrzzjAHuEWfTqQWzthG3UDNDJPUw==
X-Google-Smtp-Source: ABdhPJwyPxH505ssPSiwcnGCp/gh53GQfd3OdkSl+YIKxP5ZwvhsNKaopABMSpb5F/H5ljruU7uWoZ/2wSR6xBTVs1s=
X-Received: by 2002:a05:6402:1704:b0:42a:c480:dcc8 with SMTP id
 y4-20020a056402170400b0042ac480dcc8mr23397872edu.59.1653301256295; Mon, 23
 May 2022 03:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220523085923.1430470-1-wenst@chromium.org> <20220523085923.1430470-4-wenst@chromium.org>
 <f6cd735b-2ba4-7456-684d-b20f0b46effe@collabora.com>
In-Reply-To: <f6cd735b-2ba4-7456-684d-b20f0b46effe@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 23 May 2022 18:20:45 +0800
Message-ID: <CAGXv+5EO+JFr0xrh5JhoLSL7uuEbwHc9xEtY9HFsao2nTzMNvQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] clk: mediatek: mux: add clk notifier functions
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 6:04 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 23/05/22 10:59, Chen-Yu Tsai ha scritto:
> > With device frequency scaling, the mux clock that (indirectly) feeds the
> > device selects between a dedicated PLL, and some other stable clocks.
> >
> > When a clk rate change is requested, the (normally) upstream PLL is
> > reconfigured. It's possible for the clock output of the PLL to become
> > unstable during this process.
> >
> > To avoid causing the device to glitch, the mux should temporarily be
> > switched over to another "stable" clock during the PLL rate change.
> > This is done with clk notifiers.
> >
> > This patch adds common functions for notifiers to temporarily and
> > transparently reparent mux clocks.
> >
> > This was loosely based on commit 8adfb08605a9 ("clk: sunxi-ng: mux: Add
> > clk notifier functions").
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   drivers/clk/mediatek/clk-mux.c | 42 ++++++++++++++++++++++++++++++++++
> >   drivers/clk/mediatek/clk-mux.h | 15 ++++++++++++
> >   2 files changed, 57 insertions(+)
> >
> > diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> > index cd5f9fd8cb98..f84a5a753c09 100644
> > --- a/drivers/clk/mediatek/clk-mux.c
> > +++ b/drivers/clk/mediatek/clk-mux.c
> > @@ -4,6 +4,7 @@
> >    * Author: Owen Chen <owen.chen@mediatek.com>
> >    */
> >
> > +#include <linux/clk.h>
> >   #include <linux/clk-provider.h>
> >   #include <linux/compiler_types.h>
> >   #include <linux/container_of.h>
> > @@ -259,4 +260,45 @@ void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
> >   }
> >   EXPORT_SYMBOL_GPL(mtk_clk_unregister_muxes);
> >
> > +/*
> > + * This clock notifier is called when the frequency of the of the parent
> > + * PLL clock is to be changed. The idea is to switch the parent to a
> > + * stable clock, such as the main oscillator, while the PLL frequency
> > + * stabilizes.
> > + */
> > +static int mtk_clk_mux_notifier_cb(struct notifier_block *nb,
> > +                                unsigned long event, void *_data)
> > +{
> > +     struct clk_notifier_data *data = _data;
> > +     struct mtk_mux_nb *mux_nb = to_mtk_mux_nb(nb);
> > +     const struct mtk_mux *mux = mux_nb->mux;
> > +     struct clk_hw *hw;
> > +     int ret = 0;
> > +
> > +     hw = __clk_get_hw(data->clk);
> > +
> > +     switch (event) {
> > +     case PRE_RATE_CHANGE:
> > +             mux_nb->original_index = mux->ops->get_parent(hw);
> > +             ret = mux->ops->set_parent(hw, mux_nb->bypass_index);
> > +             break;
> > +
> > +     case POST_RATE_CHANGE:
> > +     case ABORT_RATE_CHANGE:
>
> I agree with this change, entirely - but there's an issue here.
> If we enter ABORT_RATE_CHANGE, this means that "something has failed": now,
> what if the failure point was the PLL being unable to lock?

I think this is a valid concern. But the MediaTek clk driver library doesn't
actually check if the PLL locked or not. It simply sets it and returns.

Also, if the notifier weren't there, there'd be no transparent muxing
either, and the GPU would always be clocked from the PLL, locked or
not.

Considering that muxing away is temporary and transparent, muxing back
simply restores the system to the way the CCF thinks it is. If the PLL
fails to lock, we need other fixes or constraints.

> In that case, we would switch the parent back to a PLL that's not outputting
> any clock, crashing the GPU, or a bogus rate, potentially undervolting the GPU.

For MT8183, there is no other "safe" PLL. The stable ones run faster than
the lowest OPP.

> I think that the best idea here would be to do something like..
>
>         switch (event) {
>         case PRE_RATE_CHANGE:
>                 mux_nb->old_parent_idx = mux->ops->get_parent(hw);
>                 ret = mux->ops->set_parent(hw, mux_nb->safe_parent_idx);
>                 break;
>         case POST_RATE_CHANGE:
>                 ret = mux->ops->set_parent(hw, mux_nb->old_parent_idx);
>                 break;
>         case ABORT_RATE_CHANGE:
>                 ret = -EINVAL; /* or -ECANCELED, whatever... */
>                 break;
>         }
>
> > +             ret = mux->ops->set_parent(hw, mux_nb->original_index);
> > +             break;
> > +     }
> > +
> > +     return notifier_from_errno(ret);
> > +}
> > +
> > +int devm_mtk_clk_mux_notifier_register(struct device *dev, struct clk *clk,
> > +                                    struct mtk_mux_nb *mux_nb)
> > +{
> > +     mux_nb->nb.notifier_call = mtk_clk_mux_notifier_cb;
> > +
> > +     return devm_clk_notifier_register(dev, clk, &mux_nb->nb);
> > +}
> > +EXPORT_SYMBOL_GPL(devm_mtk_clk_mux_notifier_register);
> > +
> >   MODULE_LICENSE("GPL");
> > diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
> > index 6539c58f5d7d..506e91125a3d 100644
> > --- a/drivers/clk/mediatek/clk-mux.h
> > +++ b/drivers/clk/mediatek/clk-mux.h
> > @@ -7,12 +7,14 @@
> >   #ifndef __DRV_CLK_MTK_MUX_H
> >   #define __DRV_CLK_MTK_MUX_H
> >
> > +#include <linux/notifier.h>
> >   #include <linux/spinlock.h>
> >   #include <linux/types.h>
> >
> >   struct clk;
> >   struct clk_hw_onecell_data;
> >   struct clk_ops;
> > +struct device;
> >   struct device_node;
> >
> >   struct mtk_mux {
> > @@ -89,4 +91,17 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
> >   void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
> >                             struct clk_hw_onecell_data *clk_data);
> >
> > +struct mtk_mux_nb {
> > +     struct notifier_block   nb;
> > +     const struct mtk_mux    *mux;
> > +
> > +     u8      bypass_index;   /* Which parent to temporarily use */
> > +     u8      original_index; /* Set by notifier callback */
>
> I think that the following names are more explanatory:
>
>         u8      safe_parent_idx;
>         u8      old_parent_idx;
>
> ...because I see this as a mechanism to switch the mux to a "safe" clock output
> and then back to the PLL (like it's done on some qcom clocks as well).

The names were taken from the sunxi-ng driver, which always muxed to a
crystal clock, so in a way was bypassing the PLL.

ChenYu

> You're free to ignore this comment, as this is, of course, just a personal opinion.
>
> Cheers,
> Angelo
>
>
