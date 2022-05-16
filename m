Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5073D527E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbiEPHOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbiEPHOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:14:08 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660A1E00A;
        Mon, 16 May 2022 00:14:07 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id h3so11488619qtn.4;
        Mon, 16 May 2022 00:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qT8j8L7uNx5sDff0l6NOcZAPsZPi+eXxzYca7p6X+Hk=;
        b=EkJITXybDoSzhCxAWvMUnHKHrmCllBRGiMnXubX4gF+mfPODLRGgk+a8uguUVziGAC
         J7ckgXinyy0TuENtf9AZlGk+yZfHOY0ddf2R1uGPBKl4XQ6VxCuRANVeckr21xJtpIJ2
         kuYuXp8ioZy/7ERCR5lqPZeo7lSZllUhM3GbYGrceT3M5brsbXUmhc8KFWx/xCF0t19X
         tJH0f1stidYQ0tylxXx2nZT394+FdOi3oIHRO7VAiYTA2ZP3CYXOPfw7ZfJ+HFC1baoX
         Z771UINJ5OZY20OuvHuY43JHrbr1r9CjuLV26JgSjWlgYSiSJAsAwO5+kBbY9WdxEiB0
         De+w==
X-Gm-Message-State: AOAM532X4oJZzDSRV5Osy1etfoLoWrpwp8GOTUksLjv+HNmu8XbSiR2A
        J3neSHlskatorbzXD+tIsYm+k6S/dgTe6g==
X-Google-Smtp-Source: ABdhPJz3XVVZ8HQqnKduafIN5GuXr/OmWV+IGU3pUsQEIm4hUiU/iBhDCxuaVVXYa4OrcfT3ppN7NQ==
X-Received: by 2002:ac8:5c95:0:b0:2f3:da4c:6ac0 with SMTP id r21-20020ac85c95000000b002f3da4c6ac0mr13831512qta.531.1652685246070;
        Mon, 16 May 2022 00:14:06 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id k5-20020a378805000000b0069fc13ce1ddsm5400430qkd.14.2022.05.16.00.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 00:14:05 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2f83983782fso142702007b3.6;
        Mon, 16 May 2022 00:14:04 -0700 (PDT)
X-Received: by 2002:a81:2143:0:b0:2fb:1274:247e with SMTP id
 h64-20020a812143000000b002fb1274247emr18073703ywh.384.1652685244634; Mon, 16
 May 2022 00:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXDQ+eECWwvAGOb-MaN16H17qm_v_1baZ7PdT8qx9McSw@mail.gmail.com>
 <CA+V-a8tNrJQtAQYoUKVwH9w4QOyA9JUWNjiYDPUPsj6UuJ4vaA@mail.gmail.com>
 <CAMuHMdVazy9y_U6Nva+B-3vuX1Ersq+QirXDDgSh28pj8s=EJA@mail.gmail.com>
 <CA+V-a8s2Gf22MPLoZMJS_5uDwzOboJ2i8rZ3KdRFy7a7wv8pGg@mail.gmail.com>
 <CAMuHMdXHJ385isGd-x8u4sFm1w=rxOC89SUryYbSd34bijkb0g@mail.gmail.com> <CA+V-a8uXakF45TLvpsfeAY_EZKDGHr-wfgqLR_LTz1ZAo8FYmg@mail.gmail.com>
In-Reply-To: <CA+V-a8uXakF45TLvpsfeAY_EZKDGHr-wfgqLR_LTz1ZAo8FYmg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 May 2022 09:13:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVD_f-fZDw=ZhCmR6V3osTooode3exBUwCjJEvY=goS9A@mail.gmail.com>
Message-ID: <CAMuHMdVD_f-fZDw=ZhCmR6V3osTooode3exBUwCjJEvY=goS9A@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, May 13, 2022 at 8:13 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Fri, May 13, 2022 at 3:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, May 13, 2022 at 3:56 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Fri, May 13, 2022 at 7:53 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Thu, May 12, 2022 at 7:36 PM Lad, Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > On Thu, May 12, 2022 at 8:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
> > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > > > Add IRQ domian to RZ/G2L pinctrl driver to handle GPIO interrupt.
> > > > > > > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be
> > > > > > > used as IRQ lines at given time. Selection of pins as IRQ lines
> > > > > > > is handled by IA55 (which is the IRQC block) which sits in between the
> > > > > > > GPIO and GIC.
> > > > > > >
> > > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > Thanks for your patch!
> > > > > >
> > > > > > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > > > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > > >
> > > > > > >  static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> > > > > > >  {
> > > > > > >         struct device_node *np = pctrl->dev->of_node;
> > > > > > >         struct gpio_chip *chip = &pctrl->gpio_chip;
> > > > > > >         const char *name = dev_name(pctrl->dev);
> > > > > > > +       struct irq_domain *parent_domain;
> > > > > > >         struct of_phandle_args of_args;
> > > > > > > +       struct device_node *parent_np;
> > > > > > > +       struct gpio_irq_chip *girq;
> > > > > > >         int ret;
> > > > > > >
> > > > > > > +       parent_np = of_irq_find_parent(np);
> > > > > > > +       if (!parent_np)
> > > > > > > +               return -ENXIO;
> > > > > > > +
> > > > > > > +       parent_domain = irq_find_host(parent_np);
> > > > > > > +       of_node_put(parent_np);
> > > > > > > +       if (!parent_domain)
> > > > > > > +               return -EPROBE_DEFER;
> > > > > > > +
> > > > > > >         ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &of_args);
> > > > > > >         if (ret) {
> > > > > > >                 dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
> > > > > > > @@ -1138,6 +1330,15 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> > > > > > >         chip->base = -1;
> > > > > > >         chip->ngpio = of_args.args[2];
> > > > > > >
> > > > > > > +       girq = &chip->irq;
> > > > > > > +       girq->chip = &rzg2l_gpio_irqchip;
> > > > > > > +       girq->fwnode = of_node_to_fwnode(np);
> > > > > > > +       girq->parent_domain = parent_domain;
> > > > > > > +       girq->child_to_parent_hwirq = rzg2l_gpio_child_to_parent_hwirq;
> > > > > > > +       girq->populate_parent_alloc_arg = rzg2l_gpio_populate_parent_fwspec;
> > > > > > > +       girq->child_irq_domain_ops.free = rzg2l_gpio_irq_domain_free;
> > > > > > > +       girq->ngirq = RZG2L_TINT_MAX_INTERRUPT;
> > > > > > > +
> > > > > >
> > > > > > I think you need to provide a .init_valid_mask() callback, as
> > > > > > gpiochip_irqchip_remove() relies on that for destroying interrupts.
> > > > > Are you suggesting  the callback to avoid looping through all the GPIO pins?
> > > >
> > > > gpiochip_irqchip_remove() does:
> > > >
> > > >         /* Remove all IRQ mappings and delete the domain */
> > > >         if (gc->irq.domain) {
> > > >                 unsigned int irq;
> > > >
> > > >                 for (offset = 0; offset < gc->ngpio; offset++) {
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > >                        if (!gpiochip_irqchip_irq_valid(gc, offset))
> > > >                                 continue;
> > > >
> > > >                         irq = irq_find_mapping(gc->irq.domain, offset);
> > > >                         irq_dispose_mapping(irq);
> > > >                 }
> > > >
> > > >                 irq_domain_remove(gc->irq.domain);
> > > >
> > > >         }
> > > >
> > > > The main thing is not about avoiding to loop through all GPIO pins,
> > > > but to avoid irq_{find,dispose}_mapping() doing the wrong thing.
> > > So in our case if we don't implement valid masks, that would mean all
> > > the pins are valid. irq_find_mapping() would return 0 if no mapping is
> > > found to the corresponding offset and irq_dispose_mapping() would
> > > simply return back without doing anything if virq == 0.(In this patch
> > > rzg2l_gpio_free() does call irq_{find,dispose}_mapping())
> >
> > But "offset" is a number from the GPIO offset space (0-122), while
>
> The "offset" reported by kernel is 120-511:

Offsets 120-511 are global GPIO numbers, i.e. starting from
gpio_chip.base.
The loop in gpiochip_irqchip_remove() uses local GPIO numbers,
starting from zero.
So these offsets are not the same.

Likewise, I believe the "offset" passed to irq_find_mapping() is an
irq number (hwirq) local to the domain, i.e. also starting at 0.
And it must be smaller than the size (32) passed to
irq_domain_create_hierarchy().

When passed a non-zero size, irq_domain_create_hierarchy()
calls into __irq_domain_add(), with size == hwirq_max == 32:

    /**
     * __irq_domain_add() - Allocate a new irq_domain data structure
     * @fwnode: firmware node for the interrupt controller
     * @size: Size of linear map; 0 for radix mapping only
     * @hwirq_max: Maximum number of interrupts supported by controller
     * @direct_max: Maximum value of direct maps; Use ~0 for no limit; 0 for no
     *              direct mapping
     * @ops: domain callbacks
     * @host_data: Controller private data pointer
     *
     * Allocates and initializes an irq_domain structure.
     * Returns pointer to IRQ domain, or NULL on failure.
     */
    struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode,
unsigned int size,
                                        irq_hw_number_t hwirq_max, int
direct_max,
                                        const struct irq_domain_ops *ops,
                                        void *host_data)

> > > > But we do need to handle the (possible) mismatch between GPIO
> > > > offset (index) and IRQ offset in the above code.
> > > >
> > > Agreed, do you see any possibility of the mismatch I have missed?
> >
> > gpiochip_to_irq():
> >
> >         if (irq_domain_is_hierarchy(domain)) {
> >                 struct irq_fwspec spec;
> >
> >                 spec.fwnode = domain->fwnode;
> >                 spec.param_count = 2;
> >                 spec.param[0] = gc->irq.child_offset_to_irq(gc, offset);
> >                 spec.param[1] = IRQ_TYPE_NONE;
> >
> >                 return irq_create_fwspec_mapping(&spec);
> >         }
> >
> > Same here: in the absence of a child_offset_to_irq() callback,
> > the default gpiochip_child_offset_to_irq_noop() will be used,
> > assuming an identity mapping between GPIO numbers and IRQ
> > numbers.
> >
> Agreed, gpiochip_child_offset_to_irq_noop will return the "offset",
> but irq_create_fwspec_mapping() in gpiochip_to_irq() will return the
> virq number which will not be equal to the offset.

Shouldn't spec.param[0] be in the range 0-31, as 32 is the size of
the IRQ domain allocated?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
