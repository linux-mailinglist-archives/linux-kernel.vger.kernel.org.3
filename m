Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B623571781
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiGLKoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiGLKoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:44:37 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACC18C76E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:44:35 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2ef5380669cso76421077b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vmQPMJ1DiJROJe1lhE0z8FSNyRXm8EQ9gl74gm1Aw14=;
        b=CLQ8d2KWcE8rsdb+f8e62PbO1v5gBKB9dlN9JbRFCdzixpfdHDWJUbMl7Bv2RAfjMw
         sm7aGDGQZoVgAi49/7imM0aISJuLGTVf9CwrAJfGRpAm2GixL1XxEv+8xXikiy1oP083
         ogigiGQlHK/2dIhq+gTU1/UYH4RKT+LFSXvNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vmQPMJ1DiJROJe1lhE0z8FSNyRXm8EQ9gl74gm1Aw14=;
        b=t79eZe6QT2WHBIUgBj4wZHowbzXjfrTdo2TqTcGITlBHEPBzvQ3/c6xpaMa/fdcF30
         wp/YsJ/Ulne7MUfpRQ6gSucOJf9mruv2GDzFFBt1fTLHj4qsDKzNkxhRkxWbpTNqwqbS
         XBNVKccep/qpDpFBORAiTLZhDkNlsRRi4mE069ySK8142ZlagseGWu2zM+p2PXAV6+Ts
         WjiGEzjJY2vwTh4l2zevE48TYQGUSaT3yR0rHwPEF1fQaARsQCz0P4yX565k0YPnTIfz
         eWjXXBU6n3fcMddhNuLlkec5H3ggS2CY3va9KsLftJPI4MTFC/oNStiuBEtX6tuVqYX9
         msuA==
X-Gm-Message-State: AJIora9+QlcRd1Mc64jiWLIravxFyeJCF6sBToAm1wQ9+A6kJ0wqHCj7
        NMeA5/zaz8Ip0x0AVb40TSTPAz+TYCHyYha9pjh6fw==
X-Google-Smtp-Source: AGRyM1s5MHY5VheSrcFt+WwyHBLQCd/kxgtkS6UNU6SUcXuOaVFJms5TS1N+k641yMJKjDqYpOj0LJj/Rn2PsodYkVc=
X-Received: by 2002:a81:5909:0:b0:31c:864f:9464 with SMTP id
 n9-20020a815909000000b0031c864f9464mr24246994ywb.165.1657622675241; Tue, 12
 Jul 2022 03:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220711205733.203963-1-nfraprado@collabora.com>
In-Reply-To: <20220711205733.203963-1-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 12 Jul 2022 18:44:24 +0800
Message-ID: <CAGXv+5Enkz20o8BLXmnCUBmB930sH+20U=XvTWA82neaiqqc2A@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: Don't check HW status for mt8192/5's
 imp_iic_wrap clocks
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
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

Hi,

On Tue, Jul 12, 2022 at 4:57 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> The imp_iic_wrap clocks on mt8192/mt8195 require that the i2c_sel parent
> clock be enabled before their hardware status can be checked. Since this
> wasn't taken into account, reading from the clk_summary debugfs file
> would cause the system to completely freeze.
>
> Assuming that this clock is managed only by the kernel, and not by any
> firmware, simply drop the is_enabled() optional callback and instead
> rely on the enable count for the imp_iic_wrap clocks.

That's the wrong way to go about it.

The I2C clocks already have the CLK_OPS_PARENT_ENABLE flag set. So the
issue is that somewhere in the clk core, a piece of code is not honoring
that flag.

And it seems that's in more than one place.

Regards
ChenYu

> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> ---
>
>  drivers/clk/mediatek/clk-gate.c                | 6 ++++++
>  drivers/clk/mediatek/clk-gate.h                | 1 +
>  drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c | 2 +-
>  drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 2 +-
>  4 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-g=
ate.c
> index 421806236228..8e7c719a69b3 100644
> --- a/drivers/clk/mediatek/clk-gate.c
> +++ b/drivers/clk/mediatek/clk-gate.c
> @@ -124,6 +124,12 @@ static void mtk_cg_disable_inv_no_setclr(struct clk_=
hw *hw)
>         mtk_cg_clr_bit_no_setclr(hw);
>  }
>
> +const struct clk_ops mtk_clk_gate_ops_setclr_counted =3D {
> +       .enable         =3D mtk_cg_enable,
> +       .disable        =3D mtk_cg_disable,
> +};
> +EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_setclr_counted);
> +
>  const struct clk_ops mtk_clk_gate_ops_setclr =3D {
>         .is_enabled     =3D mtk_cg_bit_is_cleared,
>         .enable         =3D mtk_cg_enable,
> diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-g=
ate.h
> index d9897ef53528..b5502b2911f5 100644
> --- a/drivers/clk/mediatek/clk-gate.h
> +++ b/drivers/clk/mediatek/clk-gate.h
> @@ -19,6 +19,7 @@ extern const struct clk_ops mtk_clk_gate_ops_setclr;
>  extern const struct clk_ops mtk_clk_gate_ops_setclr_inv;
>  extern const struct clk_ops mtk_clk_gate_ops_no_setclr;
>  extern const struct clk_ops mtk_clk_gate_ops_no_setclr_inv;
> +extern const struct clk_ops mtk_clk_gate_ops_setclr_counted;
>
>  struct mtk_gate_regs {
>         u32 sta_ofs;
> diff --git a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c b/drivers/clk=
/mediatek/clk-mt8192-imp_iic_wrap.c
> index 700356ac6a58..900ee601169c 100644
> --- a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
> +++ b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
> @@ -20,7 +20,7 @@ static const struct mtk_gate_regs imp_iic_wrap_cg_regs =
=3D {
>
>  #define GATE_IMP_IIC_WRAP(_id, _name, _parent, _shift)                 \
>         GATE_MTK_FLAGS(_id, _name, _parent, &imp_iic_wrap_cg_regs, _shift=
,      \
> -               &mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
> +               &mtk_clk_gate_ops_setclr_counted, CLK_OPS_PARENT_ENABLE)
>
>  static const struct mtk_gate imp_iic_wrap_c_clks[] =3D {
>         GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_C_I2C10, "imp_iic_wrap_c_i2c10=
", "infra_i2c0", 0),
> diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk=
/mediatek/clk-mt8195-imp_iic_wrap.c
> index fbc809d05072..e50a77b844f4 100644
> --- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
> +++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
> @@ -18,7 +18,7 @@ static const struct mtk_gate_regs imp_iic_wrap_cg_regs =
=3D {
>
>  #define GATE_IMP_IIC_WRAP(_id, _name, _parent, _shift)                  =
       \
>         GATE_MTK_FLAGS(_id, _name, _parent, &imp_iic_wrap_cg_regs, _shift=
,      \
> -               &mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
> +               &mtk_clk_gate_ops_setclr_counted, CLK_OPS_PARENT_ENABLE)
>
>  static const struct mtk_gate imp_iic_wrap_s_clks[] =3D {
>         GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_S_I2C5, "imp_iic_wrap_s_i2c5",=
 "top_i2c", 0),
> --
> 2.37.0
>
