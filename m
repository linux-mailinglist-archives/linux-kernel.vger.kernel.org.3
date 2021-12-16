Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20E1477461
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbhLPOXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLPOXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:23:12 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFA2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 06:23:12 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id d10so65173975ybn.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 06:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHL1K44KMc/qUJAl2YugnbtkHg0Sxi3iUnJF4847EGI=;
        b=glAP9/MfVtvxWlaoENZsT1s0m/aZ6Qa6JN0IodYlOkWOk+gIsr8bJ94dr457LqwEgR
         JDqTBfwT2wVEMjWqxawA1RSeW1gG6oHbfe+B1g6NXr2n1QRdTJf8cLQl+WFtT6/U4fem
         zxv2m+u3IlJf2OoxokBP/1+cgTubv83HCVHj2Z17V4tSYqxuNqfspIsgRWFdhIIa8Zgk
         M5CMNlVO4vWWBMuUEpe85pjOrCMrERkvqNC5newhdTYmpOPcIpUvJdTA4hLhlleWIoc9
         nwo93fFkS2OLz/23zXSU6XL1AgjwvgBKwQa/m4SJR9Gt9UC4eMMtvJn8+tOxMoAIEKXc
         XKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHL1K44KMc/qUJAl2YugnbtkHg0Sxi3iUnJF4847EGI=;
        b=LUEMvCm0Oo42DaDT7Npe2e3EZ5X7dGQYKFutLYA2B7dit6EhVBSTXB9UKbqpBJusWP
         9dxknW1PX53LH2rE7bhqe/ARgsMJx+i0exVzUBlPgkfSEIq7dIgc8xunhKr/v2yhtgtC
         NJtVVqkAWU3j32jswNC7SvRkXc+Alp4oA7WlHmx/dD+h6AOMjjocEYKU0G6OMLycRByI
         Go/FZPe+vFehr7e6RQI9QF44wK1XZ1vvv95+urbmg3t5PUWCCdLW5W14fIMNUx2luNU0
         zG0H5ObTYlQgLSC7h4TTO/+/j8l8VUN/ExuITGi671nV5LmXkVyBoFYLu0pACAK7mtZO
         3BLw==
X-Gm-Message-State: AOAM530cXhOksYoTI0fFWwbvU2ZC5iL1USa8KjV4wMpRDX5skJQavU+d
        LCanlVrLOaSsUt9gTNmX/Kx4VU+FQWyTIgYiNWA=
X-Google-Smtp-Source: ABdhPJx2ss1NK+Zh/JDdxG62jfQM8rj3t8MoqRS2Zzyk390AuBohfRTz7UySDYRGKEp3vQ4RiHDYF4nnGgdFKs2wGvw=
X-Received: by 2002:a25:bc44:: with SMTP id d4mr13511558ybk.613.1639664591356;
 Thu, 16 Dec 2021 06:23:11 -0800 (PST)
MIME-Version: 1.0
References: <20211215234448.5631-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXObL9brpFQL87qe79HcxXjjMqQ_oKdEwcRyH0CW1mJeg@mail.gmail.com>
In-Reply-To: <CAMuHMdXObL9brpFQL87qe79HcxXjjMqQ_oKdEwcRyH0CW1mJeg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 16 Dec 2021 14:22:45 +0000
Message-ID: <CA+V-a8vs1qVKXDwnw9ZK3=N3JsrdnmH+WZ265gzUeg_AmmcfDg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-intc-irqpin: Use platform_get_irq_optional()
 to get the interrupt
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Thu, Dec 16, 2021 at 8:45 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Dec 16, 2021 at 12:45 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypassed the hierarchical setup and messed up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq_optional().
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > --- a/drivers/irqchip/irq-renesas-intc-irqpin.c
> > +++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
>
> > @@ -418,12 +417,14 @@ static int intc_irqpin_probe(struct platform_device *pdev)
> >
> >         /* allow any number of IRQs between 1 and INTC_IRQPIN_MAX */
> >         for (k = 0; k < INTC_IRQPIN_MAX; k++) {
> > -               irq = platform_get_resource(pdev, IORESOURCE_IRQ, k);
> > -               if (!irq)
> > +               ret = platform_get_irq_optional(pdev, k);
> > +               if (ret == -EPROBE_DEFER)
> > +                       goto err0;
> > +               if (ret < 0)
> >                         break;
>
> Shouldn't all errors be considered fatal, except for -ENXIO (no
> interrupt)?
>
Initial behavior of this driver was even if one
platform_get_resource() succeeded the probe continued further, this is
the same behavior which I wanted to keep with this code while using
platform_get_irq_optional(). But as you pointed out I'll change it to below:

+               ret = platform_get_irq(pdev, k);
+               if (ret < 0)
+                       goto err0;

We bail out any error case and will also drop the check for (nirqs < 1).

Cheers,
Prabhakar
> >
> >                 p->irq[k].p = p;
> > -               p->irq[k].requested_irq = irq->start;
> > +               p->irq[k].requested_irq = ret;
> >         }
> >
> >         nirqs = k;
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
