Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0716A58C55F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242284AbiHHJQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242249AbiHHJQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:16:30 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C753F591
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:16:28 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 129so8194077vsq.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pVNlseyL7MIacDBBSW8JnWAP1QTyQz+R1GjPvPmG8Bw=;
        b=YIXYJCJMwuU+4vsbJmfAaSj88sdp8YjyaZSak599F+GyyQbhkJ2ZvsXU/qoOc0DEVJ
         /PQFVLbyPB/IdCF68/XCHpyEs9qlO/FfL33C1tA0PQJ0KeRiwhLdYdtedNpWu9I306Uz
         tRatyBhEx2GN8YngVH/bs9fKNmRjrx2zF9Yx+rq4PBo2dzhtbExJsGnQ9pdnngk2uI83
         VSGn3oj7ATuTiKXL5xSHTIE2eTHoUxFdl92kiPIJYvYU1nBQUK+P+uQUS9AHXfU7XWNe
         XVGdt9K1WzA+jelz9sH+1jULfLxjGXBtulblNPqgI0IathIxYnT3lI70xx1nYg8bDauu
         bhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pVNlseyL7MIacDBBSW8JnWAP1QTyQz+R1GjPvPmG8Bw=;
        b=bJxCN2m2G4qXW2YLKnWNYMYmy8PVq49xo/Vo4ECSZYcyD7QAJoqnIZw7TJHA3T8V2c
         6tLq7MDbJIp/ZSb9mwJMpoEcUgAcwNraPYSEHRnT5SQsYitgVVNuK7JssO0Ec+obKjaL
         n8eZHN2t571G5qbpkDqwg8/dYXaQy6kGQvwxYADbRe8NfGliaUgiOLfLty5WMoZ+E5B3
         RrACheqKPgZDEURVdmWs/I3pp/Frr7ekaVEBd3mv8t3b0/kkH7FKv91N9FLNyDRtq/SR
         9mWR3/77yhVR1GRSCJm/vyNm3Nm+eN+PHtlnkVukkyafPFAyDFZg12/vHpnV+xHupBoo
         3bOg==
X-Gm-Message-State: ACgBeo2GJWc5ElcUiuM+tXrRuUAcA5Usy1UdyWaVVt4bna4wQJybugEp
        iL2nYA+GD7s7M0QvO40X4dlGzQybTDbACvCdklS63N+8Dx84nQ==
X-Google-Smtp-Source: AA6agR42DN6xTbW3KHlNtPkw/s40Y9swtTBffE8ev10F1noVMVv7NSce5+uCbTtho0gGCau8nLjMWuRQ+NOkfLUOc+o=
X-Received: by 2002:a67:e288:0:b0:388:b41d:1654 with SMTP id
 g8-20020a67e288000000b00388b41d1654mr1425130vsf.70.1659950187247; Mon, 08 Aug
 2022 02:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220808085359.3351574-1-chenhuacai@loongson.cn> <61d4525e971206082096fd86525f1fcc@kernel.org>
In-Reply-To: <61d4525e971206082096fd86525f1fcc@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 8 Aug 2022 17:16:16 +0800
Message-ID: <CAAhV-H7Vu8j0U05ZJBzVQ3PnRd6Rpyt7Nbt-6_f4iCj=zNymnw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongson-pch-pic: Move find_pch_pic() into CONFIG_ACPI
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kernel test robot <lkp@intel.com>
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

Hi, Marc,

On Mon, Aug 8, 2022 at 5:05 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-08-08 09:53, Huacai Chen wrote:
> > MIPS doesn't declare find_pch_pic(), which makes a build warning:
> >
> >>> drivers/irqchip/irq-loongson-pch-pic.c:51:5: warning: no previous
> >>> prototype for function 'find_pch_pic' [-Wmissing-prototypes]
> >    int find_pch_pic(u32 gsi)
> >        ^
> >    drivers/irqchip/irq-loongson-pch-pic.c:51:1: note: declare 'static'
> > if the function is not intended to be used outside of this translation
> > unit
> >    int find_pch_pic(u32 gsi)
> >    ^
> >    static
> >    1 warning generated.
> >
> > Move find_pch_pic() into CONFIG_ACPI which only used by LoongArch to
> > fix
> > the warning.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/irq-loongson-pch-pic.c | 38 +++++++++++++-------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-loongson-pch-pic.c
> > b/drivers/irqchip/irq-loongson-pch-pic.c
> > index b6f1392964b1..b987b6517d59 100644
> > --- a/drivers/irqchip/irq-loongson-pch-pic.c
> > +++ b/drivers/irqchip/irq-loongson-pch-pic.c
> > @@ -48,25 +48,6 @@ static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
> >
> >  struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
> >
> > -int find_pch_pic(u32 gsi)
> > -{
> > -     int i;
> > -
> > -     /* Find the PCH_PIC that manages this GSI. */
> > -     for (i = 0; i < MAX_IO_PICS; i++) {
> > -             struct pch_pic *priv = pch_pic_priv[i];
> > -
> > -             if (!priv)
> > -                     return -1;
> > -
> > -             if (gsi >= priv->gsi_base && gsi < (priv->gsi_base +
> > priv->vec_count))
> > -                     return i;
> > -     }
> > -
> > -     pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
> > -     return -1;
> > -}
> > -
> >  static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
> >  {
> >       u32 reg;
> > @@ -325,6 +306,25 @@ IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0",
> > pch_pic_of_init);
> >  #endif
> >
> >  #ifdef CONFIG_ACPI
> > +int find_pch_pic(u32 gsi)
> > +{
> > +     int i;
> > +
> > +     /* Find the PCH_PIC that manages this GSI. */
> > +     for (i = 0; i < MAX_IO_PICS; i++) {
> > +             struct pch_pic *priv = pch_pic_priv[i];
> > +
> > +             if (!priv)
> > +                     return -1;
> > +
> > +             if (gsi >= priv->gsi_base && gsi < (priv->gsi_base +
> > priv->vec_count))
> > +                     return i;
> > +     }
> > +
> > +     pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
> > +     return -1;
> > +}
> > +
> >  static int __init
> >  pch_lpc_parse_madt(union acpi_subtable_headers *header,
> >                      const unsigned long end)
>
> While you're fixing this, can you also please fix this:
>
> $ git grep find_pch_pic
> arch/loongarch/include/asm/irq.h:extern int find_pch_pic(u32 gsi);
> arch/loongarch/include/asm/irq.h:int find_pch_pic(u32 gsi);
OK, I will send V2 for that, thanks.

Huacai
>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...
