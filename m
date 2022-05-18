Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1277352C275
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbiERSaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241408AbiERSaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:30:30 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A9C2268A7;
        Wed, 18 May 2022 11:30:29 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e78so5114772ybc.12;
        Wed, 18 May 2022 11:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bf0jmikkZt6khZjmZ+vQTYW/X5n5hIhO7K0m1yFYmMA=;
        b=DQrs0jTpZ1vGSeqz7AYb5bKh1GiP4TZvutQH5ZOx/53NncCrtyYXWc9qsPCc+v8nsT
         6lijKkPTj1fMN1w1jnhxD9GkWA6svUP3mn/xt/TKC5fyKafJpL1Q1ESGOElx62VBHo6r
         isYoLighMpLY0WRY46APIdrvR6L/7bE4jDLIAXWiBqCUwt2Iq/9E1+nqEo024ASniG1Q
         uWUJuCccB1qLN+pQj9yBUpSKstdgp7rUxYpS4KwAyMwOy3bjEhE/cncdl9xuNzo8a0Dq
         +Sm0AjiBxpDZAP84N7f2dHEMgXMO7AUkffY2KV5lt63GcJSHM/5L7M4n5pMAiHSfO+kH
         z6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bf0jmikkZt6khZjmZ+vQTYW/X5n5hIhO7K0m1yFYmMA=;
        b=jA2EkbSa4AVoLYuh4Oo/tDg9nCFn9wxEGhGZlsYvOUBCuYktBGnXZR9lHJolIp6NQV
         U89C2S2r1/gHILaTnBzTydBb4RU6ZOrvk+c9i+7mSAZXNgyvuYQAst6R3GWy3C6zBHo2
         XDX77Mvy1le8IeCxpdLZ9Jp+UDZgn3TxNbb5mqvYafrWUrwSQDLazt/+mhaL9f1HzJic
         HflMbazZjx8I0h3FPhLnSujEgnU4qVLX1UlwMtt0TBTHdPbX3C7yqkTFVoh4BYCllFOK
         33lmwdm5ITw+HLscaOZkOc9hKPpS5Mn4enDeO5Vfg/PP53XgIiDwoH8Sa9OOVJ97CiuE
         4enA==
X-Gm-Message-State: AOAM531ANjeGlz5k/D8hdV4WoxDeuAIYMEhe9HK+bCeYoXgLn8J2Qsf9
        skPGMUkQdkPAbdqjbTNaDg4xb/cR/VfVGUguslU=
X-Google-Smtp-Source: ABdhPJwa8QmUvXVgKqdigNG0HwCeALivqCUbq0/SWjT0HH4A9ZF+Ly+39iqLY7/VD2e+bS7AHJBXjdU1WWmvfIWoSn0=
X-Received: by 2002:a5b:246:0:b0:619:5651:3907 with SMTP id
 g6-20020a5b0246000000b0061956513907mr958340ybp.190.1652898628394; Wed, 18 May
 2022 11:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUiq3svPa+OMmG70HP-3h4gKV6puoT8QUm3WgPw+e4i=A@mail.gmail.com>
In-Reply-To: <CAMuHMdUiq3svPa+OMmG70HP-3h4gKV6puoT8QUm3WgPw+e4i=A@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 18 May 2022 19:30:02 +0100
Message-ID: <CA+V-a8uzaHr=gQ+b8JeqdsibKqQtiqGqVaxkeauu+6o-V3ki6g@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] gpio: gpiolib: Add ngirq member to struct gpio_irq_chip
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

Thank you for the review.

On Thu, May 12, 2022 at 8:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Supported GPIO IRQs by the chip is not always equal to the number of GPIO
> > pins. For example on Renesas RZ/G2L SoC where it has GPIO0-122 pins but at
> > a give point a maximum of only 32 GPIO pins can be used as IRQ lines in
> > the IRQC domain.
> >
> > This patch adds ngirq member to struct gpio_irq_chip and passes this as a
> > size to irq_domain_create_hierarchy()/irq_domain_create_simple() if it is
> > being set in the driver otherwise fallbacks to using ngpio.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -1221,7 +1221,7 @@ static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
> >         gc->irq.domain = irq_domain_create_hierarchy(
> >                 gc->irq.parent_domain,
> >                 0,
> > -               gc->ngpio,
> > +               gc->irq.ngirq ?: gc->ngpio,
> >                 gc->irq.fwnode,
> >                 &gc->irq.child_irq_domain_ops,
> >                 gc);
> > @@ -1574,7 +1574,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
> >         } else {
> >                 /* Some drivers provide custom irqdomain ops */
> >                 gc->irq.domain = irq_domain_create_simple(fwnode,
> > -                       gc->ngpio,
> > +                       gc->irq.ngirq ?: gc->ngpio,
> >                         gc->irq.first,
> >                         gc->irq.domain_ops ?: &gpiochip_domain_ops,
> >                         gc);
>
> OK.
>
> gpiochip_irqchip_remove() does:
>
>         /* Remove all IRQ mappings and delete the domain */
>         if (gc->irq.domain) {
>                 unsigned int irq;
>
>                 for (offset = 0; offset < gc->ngpio; offset++) {
>                        if (!gpiochip_irqchip_irq_valid(gc, offset))
>
> Hence it relies on gc->irq.valid_mask, which I think is OK in general.
>
Agreed.

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
> > --- a/include/linux/gpio/driver.h
> > +++ b/include/linux/gpio/driver.h
> > @@ -51,6 +51,14 @@ struct gpio_irq_chip {
> >          */
> >         const struct irq_domain_ops *domain_ops;
> >
> > +       /**
> > +        * @ngirq:
> > +        *
> > +        * The number of GPIO IRQ's handled by this IRQ domain; usually is
> > +        * equal to ngpio.
>
> "If not set, ngpio will be used."
>
sure will update the comment.

Cheers,
Prabhakar

> > +        */
> > +       u16 ngirq;
> > +
> >  #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
> >         /**
> >          * @fwnode:
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
