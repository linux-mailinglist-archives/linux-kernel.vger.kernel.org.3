Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5D65717BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiGLK5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiGLK47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:56:59 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29599AE569
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:56:58 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 64so13257497ybt.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0r2PI8npTldXrYm5swcIQqgUeGURrNMGas5C2c9JaIE=;
        b=gbnll282XWEa2Cv3XRfHOwWx1luDO4K0j9d69VE9kZrmUW9ZdJJDn/at4nhkuNNWYl
         vl0lkRCHaSoFrmJtg7Wj6nesryEg+H7O56iRPCUcTKPSE2JAAxNjFnMI3V+XanDTxApY
         hcl+Rd6vZUdoxjVSlBePicxzqsr6aHc7g+568=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0r2PI8npTldXrYm5swcIQqgUeGURrNMGas5C2c9JaIE=;
        b=7yXCy6HJ6P84qc1mpScQ3rF1cbO62vZPFh3PeLG2PhBvEgy94zfZe46NtS+IlQLBAc
         d3O/4iRV/0P0j7ZprwsiKd/FCXmdaV664WtWlFIqrwJQmG9O02atD+xa4qE6Khzr/DFh
         n9drne6qxDjSmuOdvFNHttrHYYDkISyz5FLX8WZgRG3i6y1yEi9HSPV7lwNVHB+9HFZ1
         SDwhs8tthqpF89mjxi3zB56xWFN75K+wTCdh67cnyHnA+HSiY2LYGXshO6JGlioMQ9Gz
         N7DqbvcYBG0GFmfklAxwUkR0sDZAH5ZerqoIZoomdvkxbfy5OFjKdjMWej00K4R8bhMz
         sQwA==
X-Gm-Message-State: AJIora/ubB6iq2D9+HzqTPio5izi6BSy0CgH8ftfgv9m/Xsmg4ZUl+am
        8WAuoFT3/36Ir5tF7Tq/pGtj3u+NogyJJQNztBxZ6A==
X-Google-Smtp-Source: AGRyM1tMdKQc/VxwTJCPAq0g/uLp2gj0u9dLb81EOH7w4A6FiGUYX83Iy1Tv2VtLUBxwtW/sCiBHolOxnWHtS82nzEo=
X-Received: by 2002:a25:d852:0:b0:66f:259c:17b6 with SMTP id
 p79-20020a25d852000000b0066f259c17b6mr11036883ybg.438.1657623417430; Tue, 12
 Jul 2022 03:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220711205733.203963-1-nfraprado@collabora.com>
 <CAGXv+5Enkz20o8BLXmnCUBmB930sH+20U=XvTWA82neaiqqc2A@mail.gmail.com> <473aa749-fcfe-bd38-0d83-95375aeef8a3@collabora.com>
In-Reply-To: <473aa749-fcfe-bd38-0d83-95375aeef8a3@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 12 Jul 2022 18:56:46 +0800
Message-ID: <CAGXv+5E+HVi2kxkRrwhWhq2XgbmfCxj+ZywPT4orBXTxtJ7X1Q@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: Don't check HW status for mt8192/5's
 imp_iic_wrap clocks
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Stephen Boyd <sboyd@kernel.org>,
        kernel@collabora.com, Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ran Jianping <ran.jianping@zte.com.cn>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 6:55 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 12/07/22 12:44, Chen-Yu Tsai ha scritto:
> > Hi,
> >
> > On Tue, Jul 12, 2022 at 4:57 AM N=C3=ADcolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> >>
> >> The imp_iic_wrap clocks on mt8192/mt8195 require that the i2c_sel pare=
nt
> >> clock be enabled before their hardware status can be checked. Since th=
is
> >> wasn't taken into account, reading from the clk_summary debugfs file
> >> would cause the system to completely freeze.
> >>
> >> Assuming that this clock is managed only by the kernel, and not by any
> >> firmware, simply drop the is_enabled() optional callback and instead
> >> rely on the enable count for the imp_iic_wrap clocks.
> >
> > That's the wrong way to go about it.
> >
> > The I2C clocks already have the CLK_OPS_PARENT_ENABLE flag set. So the
> > issue is that somewhere in the clk core, a piece of code is not honorin=
g
> > that flag.
> >
> > And it seems that's in more than one place.
> >
>
> Uhm, you're right. I gave my Tested-by, but not a Reviewed-by because I
> wasn't really convinced about this solution being the best.
>
> Now that I think of it, the solution may be as simple as:
>
> clk.c
>
> static bool clk_core_is_enabled(struct clk_core *core)
> {
>         bool ret =3D false;
>
>         /*
>          * If this clock needs parent enabled, but its parent is
>          * off, we directly return false for two reasons:
>          * 1. This clock being enabled would be impossible
>          * 2. The platform may crash for unclocked access while
>          *    reading the status of this clock (where a .is_enabled
>          *    callback is provided).
>          */
>         if (core->flags & CLK_OPS_PARENT_ENABLE &&
>             !clk_core_is_enabled(core->parent))
>                 return false;
>
>         ... etc etc etc ...
> }
>
> N=C3=ADcolas, did you try this approach?

I have a patch ready, but I got distracted by other stuff today.

ChenYu

> > Regards
> > ChenYu
> >
> >> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> >>
> >> ---
> >>
> >>   drivers/clk/mediatek/clk-gate.c                | 6 ++++++
> >>   drivers/clk/mediatek/clk-gate.h                | 1 +
> >>   drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c | 2 +-
> >>   drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 2 +-
> >>   4 files changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/cl=
k-gate.c
> >> index 421806236228..8e7c719a69b3 100644
> >> --- a/drivers/clk/mediatek/clk-gate.c
> >> +++ b/drivers/clk/mediatek/clk-gate.c
> >> @@ -124,6 +124,12 @@ static void mtk_cg_disable_inv_no_setclr(struct c=
lk_hw *hw)
> >>          mtk_cg_clr_bit_no_setclr(hw);
> >>   }
> >>
> >> +const struct clk_ops mtk_clk_gate_ops_setclr_counted =3D {
> >> +       .enable         =3D mtk_cg_enable,
> >> +       .disable        =3D mtk_cg_disable,
> >> +};
> >> +EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_setclr_counted);
> >> +
> >>   const struct clk_ops mtk_clk_gate_ops_setclr =3D {
> >>          .is_enabled     =3D mtk_cg_bit_is_cleared,
> >>          .enable         =3D mtk_cg_enable,
> >> diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/cl=
k-gate.h
> >> index d9897ef53528..b5502b2911f5 100644
> >> --- a/drivers/clk/mediatek/clk-gate.h
> >> +++ b/drivers/clk/mediatek/clk-gate.h
> >> @@ -19,6 +19,7 @@ extern const struct clk_ops mtk_clk_gate_ops_setclr;
> >>   extern const struct clk_ops mtk_clk_gate_ops_setclr_inv;
> >>   extern const struct clk_ops mtk_clk_gate_ops_no_setclr;
> >>   extern const struct clk_ops mtk_clk_gate_ops_no_setclr_inv;
> >> +extern const struct clk_ops mtk_clk_gate_ops_setclr_counted;
> >>
> >>   struct mtk_gate_regs {
> >>          u32 sta_ofs;
> >> diff --git a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c b/drivers/=
clk/mediatek/clk-mt8192-imp_iic_wrap.c
> >> index 700356ac6a58..900ee601169c 100644
> >> --- a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
> >> +++ b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
> >> @@ -20,7 +20,7 @@ static const struct mtk_gate_regs imp_iic_wrap_cg_re=
gs =3D {
> >>
> >>   #define GATE_IMP_IIC_WRAP(_id, _name, _parent, _shift)              =
   \
> >>          GATE_MTK_FLAGS(_id, _name, _parent, &imp_iic_wrap_cg_regs, _s=
hift,      \
> >> -               &mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
> >> +               &mtk_clk_gate_ops_setclr_counted, CLK_OPS_PARENT_ENABL=
E)
> >>
> >>   static const struct mtk_gate imp_iic_wrap_c_clks[] =3D {
> >>          GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_C_I2C10, "imp_iic_wrap_c_i=
2c10", "infra_i2c0", 0),
> >> diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/=
clk/mediatek/clk-mt8195-imp_iic_wrap.c
> >> index fbc809d05072..e50a77b844f4 100644
> >> --- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
> >> +++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
> >> @@ -18,7 +18,7 @@ static const struct mtk_gate_regs imp_iic_wrap_cg_re=
gs =3D {
> >>
> >>   #define GATE_IMP_IIC_WRAP(_id, _name, _parent, _shift)              =
           \
> >>          GATE_MTK_FLAGS(_id, _name, _parent, &imp_iic_wrap_cg_regs, _s=
hift,      \
> >> -               &mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
> >> +               &mtk_clk_gate_ops_setclr_counted, CLK_OPS_PARENT_ENABL=
E)
> >>
> >>   static const struct mtk_gate imp_iic_wrap_s_clks[] =3D {
> >>          GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_S_I2C5, "imp_iic_wrap_s_i2=
c5", "top_i2c", 0),
> >> --
> >> 2.37.0
> >>
>
>
