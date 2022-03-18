Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3294DDC9B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbiCRPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbiCRPRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:17:30 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0253D494;
        Fri, 18 Mar 2022 08:16:11 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id t33so8786094ybt.12;
        Fri, 18 Mar 2022 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7nTlpYa/I83xP+Stl6OjCxXKL7eS12QD0mo9SCq80Y=;
        b=ou7Ya+Xj7TjLlCrlKkf3IPBywBvRPaOhRklCh3JoU/vaxf7ZUmUSEezXROjzWvWUJg
         sBN00Po+jpzdZfnEr9tpaQh5GV5za+LNySiW0AiLqLNNxCKKfC+TRVZv/i8I2JcBuugP
         Qbo7fpyC7K+dKEaDFZrg775asI15VLKp4thUVWNktijyehclRNP3Nq6yLkrSXRteYx1Y
         hytYPOFS8amQe6p1S36M8J7dSynNu0F/IWWkLN8D3fv3c8WwG83UXxFc/6DEMWqh61CZ
         2MUTXFZ/V2wr92D2auQXWWpqd7uQvffBQApDkooRRkE3ZyZaYJV435AXev1KZr6ROy6g
         OS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7nTlpYa/I83xP+Stl6OjCxXKL7eS12QD0mo9SCq80Y=;
        b=t4PkjOVLzzKHeiWdVVu+hXt8bVe4r1Ob4RSTg5Y1M2LpMENWny0UWyY3BF/T2WSBrl
         aEfFoX87pa/OXrNbeKp9VYumJjj+9mx1eBhO9i1tkUT4TBXFpQcnSGdpAqpMDxHa4wh+
         TLTwffQSN0nWnC9Ntx0XbfDATOjNBgv8jHeJyefH41ln/rcF9Idaal4epchIuXN6BV5B
         6x1iIwAJmVA8HC5TmGzpm0WLHy0m9Nnr65kxjNQGlZpCPal6I5pFhh/J59z8eMExcoqu
         vj/ocvT5ofpgBCd4C0JRpqJlegUNj3kAphhylrhr9CsFlj783fv+0GNpEOck0WmWQbIg
         nNCw==
X-Gm-Message-State: AOAM530lv2bElhncBMCyzCemD8o9dokXP38D56p8VfRrfWVrr+iuU7Ap
        yK3EaC0OIw8OwR4eeusctYd3fqvz3FcIgeplG2k=
X-Google-Smtp-Source: ABdhPJx8+OpNK1Acqr4z0QdPBHbq8pZ3F43JT+ore+pRi0yUyWniMQWBCJMH79m2IwL1cV3OCVCjPIIxN5Owo+wugyk=
X-Received: by 2002:a25:8812:0:b0:633:7bd8:16ff with SMTP id
 c18-20020a258812000000b006337bd816ffmr10358271ybl.645.1647616570656; Fri, 18
 Mar 2022 08:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220317012404.8069-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220317012404.8069-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220317012404.8069-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 18 Mar 2022 15:15:44 +0000
Message-ID: <CA+V-a8ue5UKcXfNH0HDHvpDt=dc1UB1tT74yPeBgkFkQxx9mTA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/5] gpio: gpiolib: Allow free() callback to be overridden
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

Hi Linus,

On Thu, Mar 17, 2022 at 1:24 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Allow free() callback to be overridden from irq_domain_ops for
> hierarchical chips.
>
> This allows drivers to free any resources which are allocated during
> populate_parent_alloc_arg().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/gpio/gpiolib.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
Sorry to ping early, this patch and 4/5 hasn't been reviewed at all in
previous versions. So I wanted to get your feedback before I post an
non -RFC version of the series.

Cheers,
Prabhakar

> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index defb7c464b87..aede442f610d 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1187,15 +1187,18 @@ static void gpiochip_hierarchy_setup_domain_ops(struct irq_domain_ops *ops)
>         ops->activate = gpiochip_irq_domain_activate;
>         ops->deactivate = gpiochip_irq_domain_deactivate;
>         ops->alloc = gpiochip_hierarchy_irq_domain_alloc;
> -       ops->free = irq_domain_free_irqs_common;
>
>         /*
> -        * We only allow overriding the translate() function for
> +        * We only allow overriding the translate() and free() function for
>          * hierarchical chips, and this should only be done if the user
> -        * really need something other than 1:1 translation.
> +        * really need something other than 1:1 translation for translate()
> +        * callback and free if user wants to free up any resources which
> +        * were allocated during callbacks for example populate_parent_alloc_arg.
>          */
>         if (!ops->translate)
>                 ops->translate = gpiochip_hierarchy_irq_domain_translate;
> +       if (!ops->free)
> +               ops->free = irq_domain_free_irqs_common;
>  }
>
>  static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
> --
> 2.17.1
>
