Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C904781BD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhLQAoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLQAo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:44:29 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A67BC061574;
        Thu, 16 Dec 2021 16:44:29 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id v138so1736045ybb.8;
        Thu, 16 Dec 2021 16:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8N5YWm8aSDhgy9AKrOF74dy/geblKcg/0+SWJP0FHQ=;
        b=XXyg1HZjKtDXIDhV8jIik2W6CB35POqB2DS+29I/BB5ekmqkGO07gJ3BkgwsZCdBlZ
         sZTSN6MAAnboEVJImn5NqznhHV5WkR0XIk69OUW5r699DN5wghw32FCNb3nBtwoijHBp
         vZx8Vrkt0HpbdgqS+b9E6+FqCPv0J1nnVMFN+Iz1J6LJ1dtU53pyws+7s1X71a6khz8I
         oOKeUXAjin3VLUt4/86W83+glOIGPo5hszFwwZ1ICzGV+BzdDH58ymyepybEPIDnVV2A
         zhG8loMZPWaSvsC0eLLpVFlW3LoKPTJlz/S6nudlwfyDAWim8LTbcacYh+9YVxkB+XC5
         8lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8N5YWm8aSDhgy9AKrOF74dy/geblKcg/0+SWJP0FHQ=;
        b=w4PgJzSL22l5n+kA3o4NRAmiDw/4y/UsAj9LrZllRLsplPWF1wTxpQsSU9JLVxVH4l
         IZ0zFqk763++gSTvSGhh35tISjPWV3Fd7rIiShwWHvUoc5gKoXtN6W9991MCmgXkr/+T
         A/zef2T4QP92hLvoNPceYS+Q3h9C34UUlaAJEIhK8skxvjT7PCWSIxbmv+k5LIhWKwy/
         XQgYRjS7uQeaDBTeoMxhXK7GFxDlsGU04c827MtJMGrnUNKPrlpivoHcDZIqeKGpZSvL
         h8xUBWKj2yc4UM+aRmum/fg9XJc7yvT7YMrS40z6uUHt812VcjV2IHd9hCZfB87R+k1I
         URCA==
X-Gm-Message-State: AOAM532hY/QsSF9EZdOT8k2McrD5drPvygNUHvWhjhzkeqkUFatSwWfF
        DXZI/xgG9h/+rMAdXo0Rs0KWXMbC3mY9u77QTtWgsuugZtvBJQ==
X-Google-Smtp-Source: ABdhPJyYge/oiav7HODf7mH/bUOc1h5pPCVxhshLnxFlR74X+c9SBZDWXC2o/Z/rK/jlPDw2idbEXUjhNY44A/aKWvs=
X-Received: by 2002:a25:4213:: with SMTP id p19mr913080yba.41.1639701868840;
 Thu, 16 Dec 2021 16:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20211217001238.16298-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAL_JsqLf0FHYt-+4hEG3FkecrBJOwd=ub_yeEKWZ1DKPUycgkQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLf0FHYt-+4hEG3FkecrBJOwd=ub_yeEKWZ1DKPUycgkQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 17 Dec 2021 00:44:02 +0000
Message-ID: <CA+V-a8tX-OW6B8tScdvnRNmTha+zFNDWzyd98qHSN186B32PzQ@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_of_platform: Use of_irq_to_resource() to
 populate IRQ resource
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Dec 17, 2021 at 12:39 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Dec 16, 2021 at 6:12 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypassed the hierarchical setup and messed up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use of_irq_to_resource().
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
> >  drivers/ata/pata_of_platform.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> > index 35aa158fc976..557f349eb533 100644
> > --- a/drivers/ata/pata_of_platform.c
> > +++ b/drivers/ata/pata_of_platform.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/ata_platform.h>
> >  #include <linux/libata.h>
> > @@ -25,11 +26,12 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
> >         struct device_node *dn = ofdev->dev.of_node;
> >         struct resource io_res;
> >         struct resource ctl_res;
> > -       struct resource *irq_res;
> > +       struct resource irq_res;
> >         unsigned int reg_shift = 0;
> >         int pio_mode = 0;
> >         int pio_mask;
> >         bool use16bit;
> > +       int irq;
> >
> >         ret = of_address_to_resource(dn, 0, &io_res);
> >         if (ret) {
> > @@ -45,7 +47,9 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
> >                 return -EINVAL;
> >         }
> >
> > -       irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
> > +       irq = of_irq_to_resource(dn, 0, &irq_res);
>
> No, platform_get_irq() please. I really want to get rid of the 4 users
> of of_irq_to_resource() in the tree, not add more.
>
Ouch I wasn't aware of it.

> Yeah, that means __pata_platform_probe() needs to change, but it's all
> of 2 callers. Really, I think pata_platform.c and pata_of_platform.c
> should be merged. I'm guessing the separation traces back to DT using
> a different bus type.
>
Or we could fill in the IRQ resource by using platform_get_irq()
without touching __pata_platform_probe()?

Cheers,
Prabhakar

> Rob
