Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082905264CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381930AbiEMOgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381307AbiEMOea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:34:30 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84D31C194A;
        Fri, 13 May 2022 07:29:55 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id a22so7168519qkl.5;
        Fri, 13 May 2022 07:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCqc8sV483lUEyV7vQbAV+jRc+iGrWAeuA3SV0zpnxo=;
        b=ZBDElzojxrywJOK2wFVK6Z3KpjIePkIp+3HupR5fD2b6CFhCb39uqaI0PXXfj8qs8L
         xSvDDFD7eHIBb6S1AYAt5KFMd1Ncl8KxdFpQELf1/LdExqW/mLR1AB8G9q+rS+E8QsfK
         rzUpEj/7BInGdFukMU4zGOWgyuY6lIuugmdC5TQDzepBI4EpBF7MNAEbm69QcLGLSxhe
         ISOLEuxeNZSlu1fztmdz0e5wcS8J69dAXIiPLvQcslGSrKDvn4Zv6GGQgW1dZABXSc83
         /A5nCKjevRFFN8Th/qJ031SNO2m9Skj4cwe1HJJvRkhIrliN6J9jQOgCY7u9sWpQRbWR
         ttEg==
X-Gm-Message-State: AOAM531Ey0+/8ZOBU/zOHhBYA11+0tRkMMGnsNNtDcDLI8j8tztH8vHV
        +bEjKakNw7kTCH2d2X2x/pwWRRnyVWZ1Wg==
X-Google-Smtp-Source: ABdhPJzswxu/81gxECvhYo3qCOz0H6swOQZwmj1eFMMj6QTQZuHkp3bZKsy+oaZJ4lGmSpDWfSjpAQ==
X-Received: by 2002:a37:f518:0:b0:680:a811:1ef7 with SMTP id l24-20020a37f518000000b00680a8111ef7mr3716825qkk.765.1652452194727;
        Fri, 13 May 2022 07:29:54 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id m6-20020ac86886000000b002f39b99f6bcsm1455857qtq.86.2022.05.13.07.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 07:29:53 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2f16645872fso92004917b3.4;
        Fri, 13 May 2022 07:29:53 -0700 (PDT)
X-Received: by 2002:a81:913:0:b0:2f7:c833:f304 with SMTP id
 19-20020a810913000000b002f7c833f304mr6026190ywj.283.1652452193243; Fri, 13
 May 2022 07:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXDQ+eECWwvAGOb-MaN16H17qm_v_1baZ7PdT8qx9McSw@mail.gmail.com>
 <CA+V-a8tNrJQtAQYoUKVwH9w4QOyA9JUWNjiYDPUPsj6UuJ4vaA@mail.gmail.com>
 <CAMuHMdVazy9y_U6Nva+B-3vuX1Ersq+QirXDDgSh28pj8s=EJA@mail.gmail.com> <CA+V-a8s2Gf22MPLoZMJS_5uDwzOboJ2i8rZ3KdRFy7a7wv8pGg@mail.gmail.com>
In-Reply-To: <CA+V-a8s2Gf22MPLoZMJS_5uDwzOboJ2i8rZ3KdRFy7a7wv8pGg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 May 2022 16:29:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXHJ385isGd-x8u4sFm1w=rxOC89SUryYbSd34bijkb0g@mail.gmail.com>
Message-ID: <CAMuHMdXHJ385isGd-x8u4sFm1w=rxOC89SUryYbSd34bijkb0g@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, May 13, 2022 at 3:56 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Fri, May 13, 2022 at 7:53 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, May 12, 2022 at 7:36 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Thu, May 12, 2022 at 8:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > Add IRQ domian to RZ/G2L pinctrl driver to handle GPIO interrupt.
> > > > > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be
> > > > > used as IRQ lines at given time. Selection of pins as IRQ lines
> > > > > is handled by IA55 (which is the IRQC block) which sits in between the
> > > > > GPIO and GIC.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > >
> > > > >  static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> > > > >  {
> > > > >         struct device_node *np = pctrl->dev->of_node;
> > > > >         struct gpio_chip *chip = &pctrl->gpio_chip;
> > > > >         const char *name = dev_name(pctrl->dev);
> > > > > +       struct irq_domain *parent_domain;
> > > > >         struct of_phandle_args of_args;
> > > > > +       struct device_node *parent_np;
> > > > > +       struct gpio_irq_chip *girq;
> > > > >         int ret;
> > > > >
> > > > > +       parent_np = of_irq_find_parent(np);
> > > > > +       if (!parent_np)
> > > > > +               return -ENXIO;
> > > > > +
> > > > > +       parent_domain = irq_find_host(parent_np);
> > > > > +       of_node_put(parent_np);
> > > > > +       if (!parent_domain)
> > > > > +               return -EPROBE_DEFER;
> > > > > +
> > > > >         ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &of_args);
> > > > >         if (ret) {
> > > > >                 dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
> > > > > @@ -1138,6 +1330,15 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> > > > >         chip->base = -1;
> > > > >         chip->ngpio = of_args.args[2];
> > > > >
> > > > > +       girq = &chip->irq;
> > > > > +       girq->chip = &rzg2l_gpio_irqchip;
> > > > > +       girq->fwnode = of_node_to_fwnode(np);
> > > > > +       girq->parent_domain = parent_domain;
> > > > > +       girq->child_to_parent_hwirq = rzg2l_gpio_child_to_parent_hwirq;
> > > > > +       girq->populate_parent_alloc_arg = rzg2l_gpio_populate_parent_fwspec;
> > > > > +       girq->child_irq_domain_ops.free = rzg2l_gpio_irq_domain_free;
> > > > > +       girq->ngirq = RZG2L_TINT_MAX_INTERRUPT;
> > > > > +
> > > >
> > > > I think you need to provide a .init_valid_mask() callback, as
> > > > gpiochip_irqchip_remove() relies on that for destroying interrupts.
> > > Are you suggesting  the callback to avoid looping through all the GPIO pins?
> >
> > gpiochip_irqchip_remove() does:
> >
> >         /* Remove all IRQ mappings and delete the domain */
> >         if (gc->irq.domain) {
> >                 unsigned int irq;
> >
> >                 for (offset = 0; offset < gc->ngpio; offset++) {
> >                        if (!gpiochip_irqchip_irq_valid(gc, offset))
> >                                 continue;
> >
> >                         irq = irq_find_mapping(gc->irq.domain, offset);
> >                         irq_dispose_mapping(irq);
> >                 }
> >
> >                 irq_domain_remove(gc->irq.domain);
> >
> >         }
> >
> > The main thing is not about avoiding to loop through all GPIO pins,
> > but to avoid irq_{find,dispose}_mapping() doing the wrong thing.
> So in our case if we don't implement valid masks, that would mean all
> the pins are valid. irq_find_mapping() would return 0 if no mapping is
> found to the corresponding offset and irq_dispose_mapping() would
> simply return back without doing anything if virq == 0.(In this patch
> rzg2l_gpio_free() does call irq_{find,dispose}_mapping())

But "offset" is a number from the GPIO offset space (0-122), while
irq_find_mapping() expects a number from the domain's IRQ space,
which is only 0-31?

> > The loop is over all GPIO offsets, while not all of them are mapped
> > to valid interrupts. Does the above work correctly?
> >
> I haven't tested unloading the pinctrl driver which should call
> gpiochip_irqchip_remove() (we don't have remove call back for pinctrl
> driver)
>
> > > > However, the mask will need to be dynamic, as GPIO interrupts can be
> > > > mapped and unmapped to one of the 32 available interrupts dynamically,
> > > > right?
> > > Yep that's correct.
> > >
> > > > I'm not sure if that can be done easily: if gpiochip_irqchip_irq_valid()
> > > > is ever called too early, before the mapping is done, it would fail.
> > > >
> > > The mask initialization is a one time process and that is during
> > > adding the GPIO chip. At this stage we won't be knowing what will be
> > > the valid GPIO pins used as interrupts. Maybe the core needs to
> > > implement a callback which lands in the GPIO controller driver to tell
> > > if the gpio irq line is valid. This way we can handle dynamic
> > > interrupts.
> >
> > Upon closer look, I think the mask is a red herring, and we don't
> > need it.
> Agreed.
>
> > But we do need to handle the (possible) mismatch between GPIO
> > offset (index) and IRQ offset in the above code.
> >
> Agreed, do you see any possibility of the mismatch I have missed?

gpiochip_to_irq():

        if (irq_domain_is_hierarchy(domain)) {
                struct irq_fwspec spec;

                spec.fwnode = domain->fwnode;
                spec.param_count = 2;
                spec.param[0] = gc->irq.child_offset_to_irq(gc, offset);
                spec.param[1] = IRQ_TYPE_NONE;

                return irq_create_fwspec_mapping(&spec);
        }

Same here: in the absence of a child_offset_to_irq() callback,
the default gpiochip_child_offset_to_irq_noop() will be used,
assuming an identity mapping between GPIO numbers and IRQ
numbers.

So perhaps
  1. you need to provide a child_offset_to_irq() callback,
  2. gpiochip_irqchip_remove() needs to apply the child_offset_to_irq()
    mapping too?
  3. you do need the mask, or let child_offset_to_irq() an error code,
     to avoid irq_{find,dispose}_mapping() handling non-existent irqs?

Or am I missing something?

I guess this is easy to verify by adding some debug prints to the code.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
