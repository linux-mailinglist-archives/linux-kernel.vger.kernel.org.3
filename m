Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87A5525BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377455AbiEMGyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377471AbiEMGx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:53:56 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423E6266E25;
        Thu, 12 May 2022 23:53:52 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id u35so6167199qtc.13;
        Thu, 12 May 2022 23:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlyaiZrjtX5woP3pqoSBYqz9u7xvXibpoxkFFDDRP/k=;
        b=e8/RL3tw31RmCecjC4uPP4vO6GUXIih3uvIkmOXGLVLi9DTfn0U4axeGnjgVj6BhnI
         JG1AaQ/BvRTyXW9+w6gi8/Yi2EIz0edSxc7hCbRk0SvhkQLB897rcjm8z5afwBptxpuo
         cV12c2VP2gecbzRI/A/fY3Ahdq2PSeqPHbu4cWYb2wN0QMZznbxboP+2vxq77AW93YPo
         /TJCUVNLsRuXJ9zF3j9dwF4z1JzG33p9hHQLbBe5Iekw1+UMZnn6dsV15AUbkJV5eNn1
         LKfjvvJJnYXvqyOMqHtfvMwil9Y2MOE0FTaZN1b9KDMEe+xfrRkUXidhxCdObgd2+TIw
         hE4w==
X-Gm-Message-State: AOAM531/qWf4Jm1h48L1lGmuHOYdgn2LMfZGgXVTWf+G3D+ZmsCdf8iT
        VpaUeHShTK3eANygz1qpYrdMzvhzKY16NA==
X-Google-Smtp-Source: ABdhPJyqhWdRQre2BaNapLXLjctRaTWudI/neUHhq1/S0XIlBo4S7/d3HBg9KP8jtZy/bMupmleG1A==
X-Received: by 2002:a05:622a:8d:b0:2f3:ba67:a0ba with SMTP id o13-20020a05622a008d00b002f3ba67a0bamr3191852qtw.129.1652424831242;
        Thu, 12 May 2022 23:53:51 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id i19-20020ac84f53000000b002f3ca56e6edsm1078611qtw.8.2022.05.12.23.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 23:53:50 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id x74so1068432ybe.4;
        Thu, 12 May 2022 23:53:49 -0700 (PDT)
X-Received: by 2002:a25:c0d5:0:b0:64a:c6dd:1a00 with SMTP id
 c204-20020a25c0d5000000b0064ac6dd1a00mr3118805ybf.365.1652424829627; Thu, 12
 May 2022 23:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXDQ+eECWwvAGOb-MaN16H17qm_v_1baZ7PdT8qx9McSw@mail.gmail.com> <CA+V-a8tNrJQtAQYoUKVwH9w4QOyA9JUWNjiYDPUPsj6UuJ4vaA@mail.gmail.com>
In-Reply-To: <CA+V-a8tNrJQtAQYoUKVwH9w4QOyA9JUWNjiYDPUPsj6UuJ4vaA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 May 2022 08:53:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVazy9y_U6Nva+B-3vuX1Ersq+QirXDDgSh28pj8s=EJA@mail.gmail.com>
Message-ID: <CAMuHMdVazy9y_U6Nva+B-3vuX1Ersq+QirXDDgSh28pj8s=EJA@mail.gmail.com>
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

On Thu, May 12, 2022 at 7:36 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, May 12, 2022 at 8:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > Add IRQ domian to RZ/G2L pinctrl driver to handle GPIO interrupt.
> > > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be
> > > used as IRQ lines at given time. Selection of pins as IRQ lines
> > > is handled by IA55 (which is the IRQC block) which sits in between the
> > > GPIO and GIC.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> >
> > >  static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> > >  {
> > >         struct device_node *np = pctrl->dev->of_node;
> > >         struct gpio_chip *chip = &pctrl->gpio_chip;
> > >         const char *name = dev_name(pctrl->dev);
> > > +       struct irq_domain *parent_domain;
> > >         struct of_phandle_args of_args;
> > > +       struct device_node *parent_np;
> > > +       struct gpio_irq_chip *girq;
> > >         int ret;
> > >
> > > +       parent_np = of_irq_find_parent(np);
> > > +       if (!parent_np)
> > > +               return -ENXIO;
> > > +
> > > +       parent_domain = irq_find_host(parent_np);
> > > +       of_node_put(parent_np);
> > > +       if (!parent_domain)
> > > +               return -EPROBE_DEFER;
> > > +
> > >         ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &of_args);
> > >         if (ret) {
> > >                 dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
> > > @@ -1138,6 +1330,15 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> > >         chip->base = -1;
> > >         chip->ngpio = of_args.args[2];
> > >
> > > +       girq = &chip->irq;
> > > +       girq->chip = &rzg2l_gpio_irqchip;
> > > +       girq->fwnode = of_node_to_fwnode(np);
> > > +       girq->parent_domain = parent_domain;
> > > +       girq->child_to_parent_hwirq = rzg2l_gpio_child_to_parent_hwirq;
> > > +       girq->populate_parent_alloc_arg = rzg2l_gpio_populate_parent_fwspec;
> > > +       girq->child_irq_domain_ops.free = rzg2l_gpio_irq_domain_free;
> > > +       girq->ngirq = RZG2L_TINT_MAX_INTERRUPT;
> > > +
> >
> > I think you need to provide a .init_valid_mask() callback, as
> > gpiochip_irqchip_remove() relies on that for destroying interrupts.
> Are you suggesting  the callback to avoid looping through all the GPIO pins?

gpiochip_irqchip_remove() does:

        /* Remove all IRQ mappings and delete the domain */
        if (gc->irq.domain) {
                unsigned int irq;

                for (offset = 0; offset < gc->ngpio; offset++) {
                       if (!gpiochip_irqchip_irq_valid(gc, offset))
                                continue;

                        irq = irq_find_mapping(gc->irq.domain, offset);
                        irq_dispose_mapping(irq);
                }

                irq_domain_remove(gc->irq.domain);

        }

The main thing is not about avoiding to loop through all GPIO pins,
but to avoid irq_{find,dispose}_mapping() doing the wrong thing.
The loop is over all GPIO offsets, while not all of them are mapped
to valid interrupts. Does the above work correctly?

> > However, the mask will need to be dynamic, as GPIO interrupts can be
> > mapped and unmapped to one of the 32 available interrupts dynamically,
> > right?
> Yep that's correct.
>
> > I'm not sure if that can be done easily: if gpiochip_irqchip_irq_valid()
> > is ever called too early, before the mapping is done, it would fail.
> >
> The mask initialization is a one time process and that is during
> adding the GPIO chip. At this stage we won't be knowing what will be
> the valid GPIO pins used as interrupts. Maybe the core needs to
> implement a callback which lands in the GPIO controller driver to tell
> if the gpio irq line is valid. This way we can handle dynamic
> interrupts.

Upon closer look, I think the mask is a red herring, and we don't
need it.
But we do need to handle the (possible) mismatch between GPIO
offset (index) and IRQ offset in the above code.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
