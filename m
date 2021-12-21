Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB4547C777
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbhLUT2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241788AbhLUT2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:28:49 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCF3C061574;
        Tue, 21 Dec 2021 11:28:49 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d10so41883175ybe.3;
        Tue, 21 Dec 2021 11:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AM2Uy8hfCe/i+HeQMjVJEEeI2+nwC5cXwxDoLTyBZRs=;
        b=my7aLWciq01DAjEsUYGZ57DPXLh4HYLwg37ao9AgAKfrV3gx5cf75B5+KPRnYjxHah
         Ypg37fb4iU4SVde75W7aoz2lD7URnKs4fiZmA2eSkCgnSJQDvFurG3nAidA6bE1Vk08V
         RudzIfYTGs8+sbQVBrW0nTOgqCl7A6nx+/hE0dERj3HaJ0drwZE4kof4ocw7u+4i8KdI
         MHSWyoJLbD1FGTYq4zTNoFu2avU5wOArZYAxZDZWFmUKilJUR60jrBVzk049/dJRPQAM
         EqAP+az2OWVcjboCqDlDeNZR9O1zgQA2+SU8qStmKSWB4DRzqjmALgJTnf55FOEjIqNY
         JOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AM2Uy8hfCe/i+HeQMjVJEEeI2+nwC5cXwxDoLTyBZRs=;
        b=F0ZCHwVQNBp2WvTPhSAVj+7jcES+P1Q61hh5ZvenTPnAtQq1ZEF2MiliMqbmvf1/7Z
         3LYcKhnBuuLH3TP9SdbJ9bmTuNvO2TpKD4xLpKAfZdTNKe/8inyLUsN1XUs2GxjyDjDy
         iBGjMBDcSVUljEfySKfccULs1XysM2xrW8bKw+wtAskxyusymqwpKC3PlgQNqEmo9vlm
         CzwRek99GbE1AMM4IXVpI5Nu3NxrobfEkcRGOsNvKWGmuMQgXhfQNCFEr2tgo1wU0rk6
         Kb4DFUY61L1twVxQLVCTHvIdolmwaYyPWobIvSUFvCVWrMJOHrQMQQuLPek2XVqIcWm1
         QZtg==
X-Gm-Message-State: AOAM532kcIAVdl3vC271UiyCGJrtds04bvFQBrphm6AN/5C4hsnfXZNF
        zj7u4QTFeitVLTvsV/iv97YAgoX7dkcllMRk2rtdMnV3kJs=
X-Google-Smtp-Source: ABdhPJw6TLEc+5b2nIlx4c+4oRWUNExrcI82cGFnbKrOgqKo8MgCtrTH+6CMIJCoVSZSFjPRAa4WjarbX9OgtHQrQp4=
X-Received: by 2002:a25:abe3:: with SMTP id v90mr6112157ybi.315.1640114928720;
 Tue, 21 Dec 2021 11:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20211218153943.28014-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211220133145.uiww2nuormjks7gc@unruly>
In-Reply-To: <20211220133145.uiww2nuormjks7gc@unruly>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 21 Dec 2021 19:28:22 +0000
Message-ID: <CA+V-a8unRn=TJSnikVJffB3ebQn7RofoCn2yDLne15gW-ch9Yg@mail.gmail.com>
Subject: Re: [PATCH] soc: ti: smartreflex: Use platform_get_irq_optional() to
 get the interrupt
To:     Nishanth Menon <nm@ti.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        SantoshShilimkarssantosh@kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

Thank you for the review.

On Mon, Dec 20, 2021 at 1:31 PM Nishanth Menon <nm@ti.com> wrote:
>
> On 15:39-20211218, Lad Prabhakar wrote:
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq_optional().
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Hi,
> >
> > Dropping usage of platform_get_resource() was agreed based on
> > the discussion [0].
> >
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> > patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
> > Cheers,
> > Prabhakar
> > ---
> >  drivers/soc/ti/smartreflex.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
> > index b5b2fa538d5c..4f311e00fa46 100644
> > --- a/drivers/soc/ti/smartreflex.c
> > +++ b/drivers/soc/ti/smartreflex.c
> > @@ -819,7 +819,7 @@ static int omap_sr_probe(struct platform_device *pdev)
> >  {
> >       struct omap_sr *sr_info;
> >       struct omap_sr_data *pdata = pdev->dev.platform_data;
> > -     struct resource *mem, *irq;
> > +     struct resource *mem;
> >       struct dentry *nvalue_dir;
> >       int i, ret = 0;
> >
> > @@ -844,7 +844,12 @@ static int omap_sr_probe(struct platform_device *pdev)
> >       if (IS_ERR(sr_info->base))
> >               return PTR_ERR(sr_info->base);
> >
> > -     irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +     ret = platform_get_irq_optional(pdev, 0);
> > +     if (ret <= 0 && ret != -ENXIO)
> > +             return ret ? ret : -ENXIO;
> ^^ minor: This is a better check compared to what existed, might be good
> to add that to commit message, also does this cause the driver to fail
> probe silently?
>
Yes, the probe will fail silently in case of error while getting an
interrupt if it exists in DT. Do you want me to add an error message
in case of an error? I'll be sending v2 anyway dropping the check for
IRQ0.

> > +     if (ret > 0)
> > +             sr_info->irq = ret;
> > +     ret = 0;
> >
> >       sr_info->fck = devm_clk_get(pdev->dev.parent, "fck");
> >       if (IS_ERR(sr_info->fck))
> > @@ -870,9 +875,6 @@ static int omap_sr_probe(struct platform_device *pdev)
> >       sr_info->autocomp_active = false;
> >       sr_info->ip_type = pdata->ip_type;
> >
> > -     if (irq)
> > -             sr_info->irq = irq->start;
> > -
> >       sr_set_clk_length(sr_info);
> >
> >       list_add(&sr_info->node, &sr_list);
> > --
> > 2.17.1
> >
>
> Otherwise, looks fine to me. but it is a little late since I have sent out my
> 5.17 PR. We can try for rc OR 5.18.
>
rc should be OK, as there will be tree wide changes.

Cheers,
Prabhakar
