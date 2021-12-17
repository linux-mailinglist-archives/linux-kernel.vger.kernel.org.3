Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F64781FF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhLQBQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhLQBQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:16:50 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489C4C061574;
        Thu, 16 Dec 2021 17:16:49 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id g17so1779069ybe.13;
        Thu, 16 Dec 2021 17:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CxroxGpED4ebB7+ml5TK6/oHJjco3q8gRiWmo9QG7KA=;
        b=GikRGHKvM48x348muCoHHjZE+J2Ho76W8ZGYgKq5Px0yDgaII/6byXEpe7T9mI5oux
         Io2C/9zZ4Wl2CVDv6Hd4SxyaKGpCf1tYOXMhVVF7gXU1JGpll2e9yWlKXigogEF8mKeP
         5rdye4tyujsx7McW9oXjlel2pAQZ57Bj6eDQbvR+SpelIOWckKqk+HVC4h0fFBVFDxcR
         Q0Hy7yQITyf9uZOMnP7ClYNd13GBqevVMdANSwoBHX3zm1JsFT0ycSVaXvAze1xyDrlX
         awBBkHQZ+m1io6Xts2PfzgB14KmDu3DWtoKLA/W2x3M5zUQgpVVUmTJmqErSs2RuqLEh
         IzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CxroxGpED4ebB7+ml5TK6/oHJjco3q8gRiWmo9QG7KA=;
        b=r6+HcwbK2kzN+vxMEfVqPVCLnGlOZN6ImpDx86tB6e0llAigVXrFRtzl/lWSP9chR0
         zSWayQPf3TgORpPaKuFf/XbjtXaE+DB8D/mIfs3QMAU58/HImJFwxwGknHwK/6JCkG01
         6yp/rgl8SBDdftZiGoSLC09tXQSEkdcNDgUF1qL9uiW2tkl+4O4eAsJZ6PM8I1ui7c/m
         HXwwLuGGFmr67xaa9a5nWjFgQAeBMlwdpDQDgWZzv53ifHCGx+m5KxpZJ/PhcJhlAI6w
         7kWmTLLY1DwmPjQ5w4DilsZdVZphMgfjcZ45fLWpN3JLxfa34OQgNEO3Ux0lEoyXrnAF
         ZRIw==
X-Gm-Message-State: AOAM5306xQGzbWDPqyY/vHSv8O9bEuxgeQHinMX2UwJixOI8NV/LYS5D
        r6HlIEb6YOhQT3bt/vQkr+Jey+XGx84nLBFr1O/IUVWok8lmKQ==
X-Google-Smtp-Source: ABdhPJwRNPsT87LmhYEe2k4TjApsmTNJZSqksXUBA3DXWm69lqwyLpmMBd9YbNv3o3oyBbjr8rCKsxCYLwTN1uAM/a8=
X-Received: by 2002:a25:148a:: with SMTP id 132mr1052771ybu.251.1639703808506;
 Thu, 16 Dec 2021 17:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20211217001238.16298-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <d25d6c6f-098a-1dbc-0c85-00f97f491e99@opensource.wdc.com>
In-Reply-To: <d25d6c6f-098a-1dbc-0c85-00f97f491e99@opensource.wdc.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 17 Dec 2021 01:16:22 +0000
Message-ID: <CA+V-a8s=WhzjX-Cw5xXJ5Y1uADx42tHMWYuVruSPt87T9BNUeg@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_of_platform: Use of_irq_to_resource() to
 populate IRQ resource
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

Thank you for the review.

On Fri, Dec 17, 2021 at 12:23 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 12/17/21 09:12, Lad Prabhakar wrote:
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypassed the hierarchical setup and messed up the
>
> s/bypassed/bypasses
> s/messed/messes
>
Ok will update this.

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
> >       struct device_node *dn = ofdev->dev.of_node;
> >       struct resource io_res;
> >       struct resource ctl_res;
> > -     struct resource *irq_res;
> > +     struct resource irq_res;
> >       unsigned int reg_shift = 0;
> >       int pio_mode = 0;
> >       int pio_mask;
> >       bool use16bit;
> > +     int irq;
> >
> >       ret = of_address_to_resource(dn, 0, &io_res);
> >       if (ret) {
> > @@ -45,7 +47,9 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
> >               return -EINVAL;
> >       }
> >
> > -     irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
> > +     irq = of_irq_to_resource(dn, 0, &irq_res);
> > +     if (irq <= 0 && irq != -ENXIO)
> > +             return irq ? irq : -ENXIO;
>
> Why are you making an exception for ENXIO ? I suspect this is to cover
> the case "there is no IRQ for this node", but then how does this
> differentiate from a real error case ?
>
-ENXIO to handle no interrupt case. In case of actual error case we
fallback to polling mode..

> >
> >       of_property_read_u32(dn, "reg-shift", &reg_shift);
> >
> > @@ -63,7 +67,8 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
> >       pio_mask = 1 << pio_mode;
> >       pio_mask |= (1 << pio_mode) - 1;
> >
> > -     return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq_res,
> > +     return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res,
> > +                                  irq > 0 ? &irq_res : NULL,
.. here is check for irq number again.

Cheers,
Prabhakar
> >                                    reg_shift, pio_mask, &pata_platform_sht,
> >                                    use16bit);
> >  }
> >
>
>
> --
> Damien Le Moal
> Western Digital Research
