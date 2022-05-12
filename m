Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E26524D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353964AbiELMuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353969AbiELMta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:49:30 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D098C24D5BA;
        Thu, 12 May 2022 05:49:20 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2fb9a85a124so51744587b3.13;
        Thu, 12 May 2022 05:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DrF5cwoQrpy+nOj+sSKtS5rKw6qKbXX4wWCz3z6jZ8=;
        b=XEEm8XV4zWeN1/m4PMvtMtMAdviw5CxhEOzn1ytnh1IM04riYkcoUjE0kvHzeKNeEs
         8Xt+pL1APjslWuydnUY4U00cJgH1WEdhUZriBcwvhgSE+q5IoOq/rfDHoHcaRu8OwsDW
         nmYBTUhIALP0AvZwAfxxqQj7k6aociLx4m2wxBUe7TV7Dn7B4zmpMLgCszXTonyqU0S+
         1EQG5fBNblIoO1soU34JR8jDfLLXUfYyIPWhk6/L6ASUTGRMfoBXGOkIBDB1aNjKLnmc
         XXkDSv3xyjji4R3NkmYZhxQYJ89OVA/ey9SaXgWiPIz94pbBTtqgaqq7xneJPPbsabNs
         eICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DrF5cwoQrpy+nOj+sSKtS5rKw6qKbXX4wWCz3z6jZ8=;
        b=ClQqZ20X47PDhjW9klsIJKEiM5NCxv9wz14mXy8wfXctZoETCEeIxrwmfl7Ovw0uNv
         L2PxcXpJNYzDKai4HcLTTETc9CSBFQ2Pi+lSB0YniJkXuSbTwwRKacgeDZGYy/Fw0540
         luEn68GwZBGbgi7QR8iXyC3+Ha/CB984yLeLhLNR/LgqbPMIqmtVeYXAjV96AlkjI4WQ
         MgQJzGc4/iEF3ByUpQBfzX4c7dDHw51HLhswGcH8Msi8D0z/XBvAqR56/Y7xFYcwf71+
         CfqqpVuv5GVGZVU5bZ+v9XLr5gGjqahd+JqZnUZ94JDgrlIW6YnKz1WsETVNsHxMDkeT
         d+LA==
X-Gm-Message-State: AOAM531e6haQlZRK5njDE1oofzQv3MSstoqAx+ij/SCbobLWC8Z25dPf
        bpS1iyPmlRm+MVbe3V5bsSgO1sDMVsUP4tXeGlQ=
X-Google-Smtp-Source: ABdhPJzSgMI5UURmQJlSkLt97lQZJ7s/A3CPFHlQP8eFxEnwrx5uT1fvSWZ4F2cWet2S4Rs+ffet0qTWPLH7sFVHGT0=
X-Received: by 2002:a0d:d491:0:b0:2ef:5485:fca with SMTP id
 w139-20020a0dd491000000b002ef54850fcamr30261598ywd.16.1652359759761; Thu, 12
 May 2022 05:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <87y1z75770.wl-maz@kernel.org>
In-Reply-To: <87y1z75770.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 12 May 2022 13:48:53 +0100
Message-ID: <CA+V-a8tf1RmT-cX5y807rTAPES2NXLJHp=u1WUG11fLrtt-5Mg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] gpio: gpiolib: Allow free() callback to be overridden
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

Hi Marc,

Thank you for the review.

On Thu, May 12, 2022 at 12:19 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 11 May 2022 19:32:08 +0100,
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Allow free() callback to be overridden from irq_domain_ops for
> > hierarchical chips.
> >
> > This allows drivers to free any resources which are allocated during
> > populate_parent_alloc_arg().
>
> Do you mean more than the fwspec? I don't see this being used.
>
The free callback is used in patch 5/5 where free is overridden by
rzg2l_gpio_irq_domain_free. I just gave an example there as an
populate_parent_alloc_arg()  In actual in the child_to_parent_hwirq
callback I am using a bitmap [0] to get a free tint slot, this bitmap
needs freeing up when the GPIO interrupt is released from the driver
that as when overridden free callback frees the allocated tint slot so
that its available for re-use.

> There is also the question of why we need to have dynamic allocation
> for the fwspec itself. Why isn't that a simple stack allocation in the
> context of gpiochip_hierarchy_irq_domain_alloc()?
>
you mean gpio core itself should handle the fwspec allocation/freeing?

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

>         M.
>
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/gpio/gpiolib.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index b7694171655c..d36c4a965efc 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -1187,15 +1187,18 @@ static void gpiochip_hierarchy_setup_domain_ops(struct irq_domain_ops *ops)
> >       ops->activate = gpiochip_irq_domain_activate;
> >       ops->deactivate = gpiochip_irq_domain_deactivate;
> >       ops->alloc = gpiochip_hierarchy_irq_domain_alloc;
> > -     ops->free = irq_domain_free_irqs_common;
> >
> >       /*
> > -      * We only allow overriding the translate() function for
> > +      * We only allow overriding the translate() and free() functions for
> >        * hierarchical chips, and this should only be done if the user
> > -      * really need something other than 1:1 translation.
> > +      * really need something other than 1:1 translation for translate()
> > +      * callback and free if user wants to free up any resources which
> > +      * were allocated during callbacks, for example populate_parent_alloc_arg.
> >        */
> >       if (!ops->translate)
> >               ops->translate = gpiochip_hierarchy_irq_domain_translate;
> > +     if (!ops->free)
> > +             ops->free = irq_domain_free_irqs_common;
> >  }
> >
> >  static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
> > --
> > 2.25.1
> >
> >
>
> --
> Without deviation from the norm, progress is not possible.
