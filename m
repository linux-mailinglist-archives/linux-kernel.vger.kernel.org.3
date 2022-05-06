Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAFE51D714
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbiEFL4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343504AbiEFL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:56:48 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90FA63BDB;
        Fri,  6 May 2022 04:53:05 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so12478285ybu.0;
        Fri, 06 May 2022 04:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPgMA3WCStWAWJWUSdZPWRhC0nD8pMwxTkxPlXqlu8I=;
        b=cI9P6Ta0XIuA1BM/RMxSk3BsAW03ht8Gi7j6ygUm5BIiHipjCzOunNnkX271vTHLbg
         Dz4djvJtRqdV5p3oky21RFrqOGEkE2UMlI75zNNvL3hfBZeNBQSk2fhCpQnMPlMSof7u
         +2ucmo8+6zKscVdQkbeFyZ8GMfuEkImNSC2AVNTqfKAtdTJ14JaJL/vcxAc28zy26EAQ
         B6ovj5t/xBwwN8TE8m6wGNDzhx1GXa+Eb+ORQt7j27ZhpVbOZvubODTxyfo+ZQ0atrCS
         VH2pKYVOvyecomv4R4LkPGPrWx9+bCRpyT4sxXgp7aIIbiPhZOs8eWiwtc5nOXC4BzvU
         XF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPgMA3WCStWAWJWUSdZPWRhC0nD8pMwxTkxPlXqlu8I=;
        b=q7pfXdj3i/MwCqDmJC2SEoITV3cxy9wwT92q8aXrpFnpxyRNC18+wS41caLvQPDdCU
         DmecVj+9Q0QtK6oV6x2pma83/6fy5g+ETS/GgCWzbHTNqSFsgc4SB+6InWx6xbwMV0i9
         WBaOpbtcJMYl4idiPd67gk+jNDYUSOgN2O9snZS+L0IkgOdjAzzHRqLq9/DzHQgzeXOg
         ou+EjLGdoW+A4d7+18NItQGYgE3c0Vdy+ZcZmhHvhTq1nECZVpJsrr9OnvDbtLRVoRuA
         8uMn/LviEWW4yVhXXm52EASz2Oi9+xezK8oTaAD4QiCwqUuQ+L/luWalPUpIrgkE6Mpo
         mp6g==
X-Gm-Message-State: AOAM531p9PqJwvPoW0IRFtUrnMYPxzbWWwa3+JPsNyObMoN3gDywO1B6
        eV3dLdYDEQtwWsaPrvi7D8NXClSjSMU5HcIs12Y=
X-Google-Smtp-Source: ABdhPJwNL5gEfw/MQlOCmsPu4lFxV5G4VgbyFk7s6eMqUPRy+V/SW+UB8XlpkF1wwlmzmlCWGQRQPT+k+cOz1iuPzZI=
X-Received: by 2002:a25:8812:0:b0:633:7bd8:16ff with SMTP id
 c18-20020a258812000000b006337bd816ffmr1970396ybl.645.1651837985039; Fri, 06
 May 2022 04:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220505193143.31826-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB592225B5A5E1BA7D250C466786C29@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592225B5A5E1BA7D250C466786C29@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 6 May 2022 12:52:38 +0100
Message-ID: <CA+V-a8shz+Wbj84vjaw=_Sys1TW45HC2RMy4fy_5QBR-hvNGFg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack the
 resets instead of indexing
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

Thank you for the review.

On Thu, May 5, 2022 at 8:48 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Lad Prabhakar,
>
> Thanks for the patch.
>
> > Subject: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack the
> > resets instead of indexing
> >
> > Instead of indexing the resets, stack them and instead create an id member
> > in struct rzg2l_reset to store the index. With this approach for every id
> > we will have to loop through the resets array to match the id.
> >
> > This in preparation to add support for Renesas RZ/Five CPG in r9a07g043-
> > cpg.c file where the resets array will be split up into three i.e. common
> > and two SoC specific.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/clk/renesas/rzg2l-cpg.c | 76 ++++++++++++++++++++++++++-------
> > drivers/clk/renesas/rzg2l-cpg.h |  4 +-
> >  2 files changed, 63 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-
> > cpg.c index 1ce35f65682b..94fe307ec4c5 100644
> > --- a/drivers/clk/renesas/rzg2l-cpg.c
> > +++ b/drivers/clk/renesas/rzg2l-cpg.c
> > @@ -681,14 +681,37 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk
> > *mod,
> >
> >  #define rcdev_to_priv(x)     container_of(x, struct rzg2l_cpg_priv,
> > rcdev)
> >
> > +static const struct rzg2l_reset
> > +*rzg2l_get_reset_ptr(struct rzg2l_cpg_priv *priv,
> > +                  unsigned long id)
> > +
> > +{
> > +     const struct rzg2l_cpg_info *info = priv->info;
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < priv->num_resets; i++) {
> > +             if (info->resets[i].id == id)
> > +                     return &info->resets[i];
> > +     }
>
> Is it not possible to use shared reset like RZ/G2L and RZ/V2L?, which
> has optimal memory and performance wise we can avoid bigger loop.
>
> Like adding Last index of RZ/Five as last reset index and
> Handle RZ/G2UL specific as invalid reset index in xlate??
>
So we will have to maintain an array id's which are invalid to RZ/Five
SoC. For this too we will have to loop at runtime itself. The array
for invalid index will be big too.

>
> > +
> > +     return NULL;
> > +}
> > +
> >  static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
> >                          unsigned long id)
> >  {
> >       struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
> > -     const struct rzg2l_cpg_info *info = priv->info;
> > -     unsigned int reg = info->resets[id].off;
> > -     u32 dis = BIT(info->resets[id].bit);
> > -     u32 we = dis << 16;
> > +     const struct rzg2l_reset *reset;
> > +     unsigned int reg;
> > +     u32 dis, we;
> > +
> > +     reset = rzg2l_get_reset_ptr(priv, id);
> > +     if (!reset)
> > +             return -EINVAL;
> > +
> > +     reg = reset->off;
> > +     dis = BIT(reset->bit);
> > +     we = dis << 16;
> >
> >       dev_dbg(rcdev->dev, "reset id:%ld offset:0x%x\n", id,
> > CLK_RST_R(reg));
> >
> > @@ -708,9 +731,16 @@ static int rzg2l_cpg_assert(struct
> > reset_controller_dev *rcdev,
> >                           unsigned long id)
> >  {
> >       struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
> > -     const struct rzg2l_cpg_info *info = priv->info;
> > -     unsigned int reg = info->resets[id].off;
> > -     u32 value = BIT(info->resets[id].bit) << 16;
> > +     const struct rzg2l_reset *reset;
> > +     unsigned int reg;
> > +     u32 value;
> > +
> > +     reset = rzg2l_get_reset_ptr(priv, id);
> > +     if (!reset)
> > +             return -EINVAL;
> > +
> > +     reg = reset->off;
> > +     value = BIT(reset->bit) << 16;
> >
> >       dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id,
> > CLK_RST_R(reg));
> >
> > @@ -722,11 +752,17 @@ static int rzg2l_cpg_deassert(struct
> > reset_controller_dev *rcdev,
> >                             unsigned long id)
> >  {
> >       struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
> > -     const struct rzg2l_cpg_info *info = priv->info;
> > -     unsigned int reg = info->resets[id].off;
> > -     u32 dis = BIT(info->resets[id].bit);
> > -     u32 value = (dis << 16) | dis;
> > +     const struct rzg2l_reset *reset;
> > +     unsigned int reg;
> > +     u32 dis, value;
> > +
> > +     reset = rzg2l_get_reset_ptr(priv, id);
> > +     if (!reset)
> > +             return -EINVAL;
> >
> > +     reg = reset->off;
> > +     dis = BIT(reset->bit);
> > +     value = (dis << 16) | dis;
> >       dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id,
> >               CLK_RST_R(reg));
> >
> > @@ -738,9 +774,16 @@ static int rzg2l_cpg_status(struct
> > reset_controller_dev *rcdev,
> >                           unsigned long id)
> >  {
> >       struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
> > -     const struct rzg2l_cpg_info *info = priv->info;
> > -     unsigned int reg = info->resets[id].off;
> > -     u32 bitmask = BIT(info->resets[id].bit);
> > +     const struct rzg2l_reset *reset;
> > +     unsigned int reg;
> > +     u32 bitmask;
> > +
> > +     reset = rzg2l_get_reset_ptr(priv, id);
> > +     if (!reset)
> > +             return -EINVAL;
> > +
> > +     reg = reset->off;
> > +     bitmask = BIT(reset->bit);
> >
> >       return !(readl(priv->base + CLK_MRST_R(reg)) & bitmask);  } @@ -
> > 756,10 +799,11 @@ static int rzg2l_cpg_reset_xlate(struct
> > reset_controller_dev *rcdev,
> >                                const struct of_phandle_args *reset_spec)  {
> >       struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
> > -     const struct rzg2l_cpg_info *info = priv->info;
> >       unsigned int id = reset_spec->args[0];
> > +     const struct rzg2l_reset *reset;
> >
> > -     if (id >= rcdev->nr_resets || !info->resets[id].off) {
> > +     reset = rzg2l_get_reset_ptr(priv, id);
> > +     if (!reset) {
> >               dev_err(rcdev->dev, "Invalid reset index %u\n", id);
> >               return -EINVAL;
> >       }
> > diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-
> > cpg.h index 92c88f42ca7f..a99f2ba7868f 100644
> > --- a/drivers/clk/renesas/rzg2l-cpg.h
> > +++ b/drivers/clk/renesas/rzg2l-cpg.h
> > @@ -152,12 +152,14 @@ struct rzg2l_mod_clk {
> >   * @bit: reset bit
> >   */
> >  struct rzg2l_reset {
> > +     unsigned int id;
>
> Now you are adding 4 bytes to each reset entry in the LUT.
>
Agreed, on the other hand we are saving space on the entries (for
example not all the reset entries are listed in the array and the
array length will always be equal to last index)

Cheers,
Prabhakar

> Cheers,
> Biju
>
> >       u16 off;
> >       u8 bit;
> >  };
>
> >
> >  #define DEF_RST(_id, _off, _bit)     \
> > -     [_id] = { \
> > +     { \
> > +             .id = (_id), \
> >               .off = (_off), \
> >               .bit = (_bit) \
> >       }
> > --
> > 2.25.1
>
