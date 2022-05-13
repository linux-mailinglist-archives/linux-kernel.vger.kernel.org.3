Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3B4526351
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiEMN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiEMN4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:56:03 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5876D1B6;
        Fri, 13 May 2022 06:55:59 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2f7ca2ce255so90754937b3.7;
        Fri, 13 May 2022 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwGMEX+LLiB9b+ZhvUVydg+wQ+ydVFJ9ivTIS4GDaQc=;
        b=aFFAhjrmYwX0BHkHmDOSob6mPl6ylcUVF32TIIPhMd9X1CTrSufrdORnHo4jWQaFca
         DZpl9csBw8K39RuAfJVpWXCKf8wxClGUgHXJKu9Q7/I5E/mJ3mUydQ9z9qAyIX1l7zrE
         +X3M4HBbFPlOaEd8pI2zOXxpHcGv2r2p9DD2L3R8crgxHViQnOVcZZCvQy3hnMgjgLHx
         XaXXnHgN/5uRc/bhny4z+l8WRYx25SjdfQ2rFif+UPhA8mOH4+PUrXSAuqFxtIFTyXDB
         o2ZxsSZ9bpsd//VXjyS4WQCQX8ER+J7rmsm4AzcWg8u4Ca8XGwR6YsKQhyB/pWjSfWdt
         YUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwGMEX+LLiB9b+ZhvUVydg+wQ+ydVFJ9ivTIS4GDaQc=;
        b=5rGCunzVi6LBEh1FuqwHGiD1dq3QXipk44ECl3WnKpvsISvl032hP3CQHKxjqU7c2Y
         jIydup5ouEP8BRRoG0wIoouj3gnVM070PtzOEy86gEvEc6FYc3VsoDMP0ANoELe6l3Az
         LMZFtUXV4eQwj+TJf6CYbkiRjV2IQAFm/jNYG6w1ANlE5bQieXKXrhM43T5eqyyvSY68
         FlBdyOBTn4RqaX0Jg8Kuq2GvLrBx+gqoHLnCyAvdpGutK/Vi0xYlmI7qKB8yEBDMJTzK
         W6VwL1ah+Z8hbFbx3528hqOq1J8mDCYLb4LSZcyBl2JTuoideYLNMV1j7eM9SXcxhJU+
         ydQA==
X-Gm-Message-State: AOAM532pkutK6qi/MlWN9AfgiiO92vDdXwE51CREXVaeJuzYKIp2r84v
        kznX0kVXBHSyu5f1Hnoc1hd5yXvdcF9CMuiEL0M=
X-Google-Smtp-Source: ABdhPJyMIIa3Obtr9B6TBmgjzw+5+eAyJ7ll824clYlfbDJ2B+phe1qXLp0Up43Q0X/Y6lSzi1rcR1CUiayZ5eIz8dg=
X-Received: by 2002:a81:8cf:0:b0:2f4:da59:9eef with SMTP id
 198-20020a8108cf000000b002f4da599eefmr5964922ywi.78.1652450158875; Fri, 13
 May 2022 06:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXDQ+eECWwvAGOb-MaN16H17qm_v_1baZ7PdT8qx9McSw@mail.gmail.com>
 <CA+V-a8tNrJQtAQYoUKVwH9w4QOyA9JUWNjiYDPUPsj6UuJ4vaA@mail.gmail.com> <CAMuHMdVazy9y_U6Nva+B-3vuX1Ersq+QirXDDgSh28pj8s=EJA@mail.gmail.com>
In-Reply-To: <CAMuHMdVazy9y_U6Nva+B-3vuX1Ersq+QirXDDgSh28pj8s=EJA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 13 May 2022 14:55:32 +0100
Message-ID: <CA+V-a8s2Gf22MPLoZMJS_5uDwzOboJ2i8rZ3KdRFy7a7wv8pGg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, May 13, 2022 at 7:53 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, May 12, 2022 at 7:36 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, May 12, 2022 at 8:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > Add IRQ domian to RZ/G2L pinctrl driver to handle GPIO interrupt.
> > > > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be
> > > > used as IRQ lines at given time. Selection of pins as IRQ lines
> > > > is handled by IA55 (which is the IRQC block) which sits in between the
> > > > GPIO and GIC.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > >
> > > >  static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> > > >  {
> > > >         struct device_node *np = pctrl->dev->of_node;
> > > >         struct gpio_chip *chip = &pctrl->gpio_chip;
> > > >         const char *name = dev_name(pctrl->dev);
> > > > +       struct irq_domain *parent_domain;
> > > >         struct of_phandle_args of_args;
> > > > +       struct device_node *parent_np;
> > > > +       struct gpio_irq_chip *girq;
> > > >         int ret;
> > > >
> > > > +       parent_np = of_irq_find_parent(np);
> > > > +       if (!parent_np)
> > > > +               return -ENXIO;
> > > > +
> > > > +       parent_domain = irq_find_host(parent_np);
> > > > +       of_node_put(parent_np);
> > > > +       if (!parent_domain)
> > > > +               return -EPROBE_DEFER;
> > > > +
> > > >         ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &of_args);
> > > >         if (ret) {
> > > >                 dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
> > > > @@ -1138,6 +1330,15 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> > > >         chip->base = -1;
> > > >         chip->ngpio = of_args.args[2];
> > > >
> > > > +       girq = &chip->irq;
> > > > +       girq->chip = &rzg2l_gpio_irqchip;
> > > > +       girq->fwnode = of_node_to_fwnode(np);
> > > > +       girq->parent_domain = parent_domain;
> > > > +       girq->child_to_parent_hwirq = rzg2l_gpio_child_to_parent_hwirq;
> > > > +       girq->populate_parent_alloc_arg = rzg2l_gpio_populate_parent_fwspec;
> > > > +       girq->child_irq_domain_ops.free = rzg2l_gpio_irq_domain_free;
> > > > +       girq->ngirq = RZG2L_TINT_MAX_INTERRUPT;
> > > > +
> > >
> > > I think you need to provide a .init_valid_mask() callback, as
> > > gpiochip_irqchip_remove() relies on that for destroying interrupts.
> > Are you suggesting  the callback to avoid looping through all the GPIO pins?
>
> gpiochip_irqchip_remove() does:
>
>         /* Remove all IRQ mappings and delete the domain */
>         if (gc->irq.domain) {
>                 unsigned int irq;
>
>                 for (offset = 0; offset < gc->ngpio; offset++) {
>                        if (!gpiochip_irqchip_irq_valid(gc, offset))
>                                 continue;
>
>                         irq = irq_find_mapping(gc->irq.domain, offset);
>                         irq_dispose_mapping(irq);
>                 }
>
>                 irq_domain_remove(gc->irq.domain);
>
>         }
>
> The main thing is not about avoiding to loop through all GPIO pins,
> but to avoid irq_{find,dispose}_mapping() doing the wrong thing.
So in our case if we don't implement valid masks, that would mean all
the pins are valid. irq_find_mapping() would return 0 if no mapping is
found to the corresponding offset and irq_dispose_mapping() would
simply return back without doing anything if virq == 0.(In this patch
rzg2l_gpio_free() does call irq_{find,dispose}_mapping())


> The loop is over all GPIO offsets, while not all of them are mapped
> to valid interrupts. Does the above work correctly?
>
I haven't tested unloading the pinctrl driver which should call
gpiochip_irqchip_remove() (we don't have remove call back for pinctrl
driver)

> > > However, the mask will need to be dynamic, as GPIO interrupts can be
> > > mapped and unmapped to one of the 32 available interrupts dynamically,
> > > right?
> > Yep that's correct.
> >
> > > I'm not sure if that can be done easily: if gpiochip_irqchip_irq_valid()
> > > is ever called too early, before the mapping is done, it would fail.
> > >
> > The mask initialization is a one time process and that is during
> > adding the GPIO chip. At this stage we won't be knowing what will be
> > the valid GPIO pins used as interrupts. Maybe the core needs to
> > implement a callback which lands in the GPIO controller driver to tell
> > if the gpio irq line is valid. This way we can handle dynamic
> > interrupts.
>
> Upon closer look, I think the mask is a red herring, and we don't
> need it.
Agreed.

> But we do need to handle the (possible) mismatch between GPIO
> offset (index) and IRQ offset in the above code.
>
Agreed, do you see any possibility of the mismatch I have missed?

Cheers,
Prabhakar
