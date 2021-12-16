Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B974774AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhLPObg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:31:36 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:43715 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbhLPObe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:31:34 -0500
Received: by mail-ua1-f41.google.com with SMTP id 107so7084430uaj.10;
        Thu, 16 Dec 2021 06:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZzFcJcyDZTzUlGBAIsiB3bxkd0MlD0nqjJYkx+amq8=;
        b=ot3vkzZ6UDo1qpG5z/LSO9fKWbABBn7+jraLSaR0Y8zBV7pD2k7xUGP2ZDn3sV/rKl
         s6sGcuOX3pc7HWLgRE/ELt1GUcOh+zYlUU3K0MK3KlAAA27zYhqq66TaHQmIQ3kg3Ofs
         S8SwArP/Nf9bykCcyOKYAkSCGR8RXJcbxqOSkO2kPfRWUASAIXsi8IkabmcuKz78De2z
         rhnLwSJTspdc3J0b1pNyaAhviCWP0JBj/lD26rhJtM1Wxq+H0ZjyyF+7heUsDoB98z0J
         2gI+ttLjHgse7WmJ8TEE/601ZYhlEZMT5PFzhN7eHHslvJkyl07e2Vx23nrM9hGWi0Sf
         0EmA==
X-Gm-Message-State: AOAM531thtzB24f1Xpxce3KqlZWGSlrTJ9Y9MjylGM1cWPNCenDmlUO3
        c77wq4dU1F9BG4uEFKk93G66eCZr6thmyQ==
X-Google-Smtp-Source: ABdhPJyCkSh79EyAhaOJ7qpO3Fqny0nucnDcNxD4X7gNp9Ofgyn0x+0NjUCJzPfJw58b5ayyJTtDSw==
X-Received: by 2002:a67:2fc5:: with SMTP id v188mr607533vsv.12.1639665093359;
        Thu, 16 Dec 2021 06:31:33 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id t138sm86858vkb.35.2021.12.16.06.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 06:31:33 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id i6so47448755uae.6;
        Thu, 16 Dec 2021 06:31:32 -0800 (PST)
X-Received: by 2002:a05:6102:3232:: with SMTP id x18mr5512662vsf.38.1639665092488;
 Thu, 16 Dec 2021 06:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20211215234448.5631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXObL9brpFQL87qe79HcxXjjMqQ_oKdEwcRyH0CW1mJeg@mail.gmail.com> <CA+V-a8vs1qVKXDwnw9ZK3=N3JsrdnmH+WZ265gzUeg_AmmcfDg@mail.gmail.com>
In-Reply-To: <CA+V-a8vs1qVKXDwnw9ZK3=N3JsrdnmH+WZ265gzUeg_AmmcfDg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Dec 2021 15:31:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX6uC2siQ6+g4RTPk4vvxi4y17WCdU6GhQf6j5fuo34nw@mail.gmail.com>
Message-ID: <CAMuHMdX6uC2siQ6+g4RTPk4vvxi4y17WCdU6GhQf6j5fuo34nw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-intc-irqpin: Use platform_get_irq_optional()
 to get the interrupt
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Dec 16, 2021 at 3:23 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Dec 16, 2021 at 8:45 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Dec 16, 2021 at 12:45 AM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > > allocation of IRQ resources in DT core code, this causes an issue
> > > when using hierarchical interrupt domains using "interrupts" property
> > > in the node as this bypassed the hierarchical setup and messed up the
> > > irq chaining.
> > >
> > > In preparation for removal of static setup of IRQ resource from DT core
> > > code use platform_get_irq_optional().
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > > --- a/drivers/irqchip/irq-renesas-intc-irqpin.c
> > > +++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
> >
> > > @@ -418,12 +417,14 @@ static int intc_irqpin_probe(struct platform_device *pdev)
> > >
> > >         /* allow any number of IRQs between 1 and INTC_IRQPIN_MAX */
> > >         for (k = 0; k < INTC_IRQPIN_MAX; k++) {
> > > -               irq = platform_get_resource(pdev, IORESOURCE_IRQ, k);
> > > -               if (!irq)
> > > +               ret = platform_get_irq_optional(pdev, k);
> > > +               if (ret == -EPROBE_DEFER)
> > > +                       goto err0;
> > > +               if (ret < 0)
> > >                         break;
> >
> > Shouldn't all errors be considered fatal, except for -ENXIO (no
> > interrupt)?
> >
> Initial behavior of this driver was even if one
> platform_get_resource() succeeded the probe continued further, this is

Indeed, the loop obtained all interrupts present, until no more are to found.
In the old logic, it would return a NULL resource for the first
non-existing one.
In the new logic, it would return -ENXIO.
Hence you need to check for -ENXIO in the loop, to distinguish "no more
interrupts" from actual errors.

> the same behavior which I wanted to keep with this code while using
> platform_get_irq_optional(). But as you pointed out I'll change it to below:
>
> +               ret = platform_get_irq(pdev, k);
> +               if (ret < 0)
> +                       goto err0;
>
> We bail out any error case and will also drop the check for (nirqs < 1).

I think that check should stay: there should be at least one interrupt.

> > >                 p->irq[k].p = p;
> > > -               p->irq[k].requested_irq = irq->start;
> > > +               p->irq[k].requested_irq = ret;
> > >         }
> > >
> > >         nirqs = k;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
