Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ABE47EFC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 16:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353064AbhLXPKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 10:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbhLXPKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 10:10:09 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D54C061401;
        Fri, 24 Dec 2021 07:10:09 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id j83so5180363ybg.2;
        Fri, 24 Dec 2021 07:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6doRrvb+MW2ZsOVkICav/FngCWORNfpHOqxU12iEIjw=;
        b=Xf2wwCSyrjDia3R2CMEI0FTzBwB5N6jBdhAVXZDe5epUaYFNdqU7zKEPxxZXTmB9qh
         QlP6JkKgJ4cZoBJnBPkOO2k/pOCofjNEGTIumUfMrPf/0mGsvsihprbNFUJ5eGLdLIOP
         9EZydgQdoBpmfaseovbMUN57Efh8krcB5RJthZ5+McWgH6VWvqQhGnK/viG6156fvQ9T
         sCE0ZWlpovtigrCb3dZZVEl2p1HHokawv5rYvvmUKOtju28UeBVnDLAUWw6zU4Ncs5X2
         eqc7FFWWLYEd6u1zU5iTZpCJaU7H47BkbehMlLBkTQpQFyOODNTB6FjtP1YPUpnyxSUM
         qAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6doRrvb+MW2ZsOVkICav/FngCWORNfpHOqxU12iEIjw=;
        b=4JwnuGLcL3k7LOzE+VBpHsQAp2ThIyO0/28nQOZ86AioOBJvLiGTCbsh834qXLp7pV
         r3wdtLf0JDHC3PetwrE00hy6BjO1O7cQdJ3Z7Mr4OKShc96/qHj3C/80QHbUZNFREaR3
         JfskhLDGnrS9kcpzL7sUnpc4rSi/3ODyCoGdm9TPHLLZWUMGFxfKB4f+3DyTFVacQIM7
         qfwq9qCwUpJlnPeR30QhR+b+L0vUyHOc3d3wDc0ABp0jaMia4QyPMA6CzayvO152dZaS
         mioFqnd5xfKwyIXETrAet6HOP61NldLtcqah1/dbu5nqKEMx+4kQmbdVEUcN5WkezBuP
         yNQA==
X-Gm-Message-State: AOAM532G6EqICI+bB7PWY0CuLsQK8L0ce2UIWGAgq9snfN0Yy5MwmH0n
        3nssDVG7rFPBZPW2ZiGUxWnMcLLy9MrRCBoaYm1yIHQnyjAc6w==
X-Google-Smtp-Source: ABdhPJxvuKsql6MSB+L0WeF3XLc7px85LpC0vVSaCjkcH4PdVSon1OvKMaGCDIgjvO0IB0J9oNhlMV92z90+oSqNq2k=
X-Received: by 2002:a25:cb97:: with SMTP id b145mr9038837ybg.186.1640358608228;
 Fri, 24 Dec 2021 07:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20211224145748.18754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224145748.18754-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <YcXhPrvOsBRVAJ8w@piout.net>
In-Reply-To: <YcXhPrvOsBRVAJ8w@piout.net>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 24 Dec 2021 15:09:42 +0000
Message-ID: <CA+V-a8teu=9Eeyjd78Va1hEs7BCD_+zMSS_T_WPz82bXwvcgjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: at91-pio4: Use platform_get_irq_optional()
 to get the interrupt
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Thank you for the review.

On Fri, Dec 24, 2021 at 3:03 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 24/12/2021 14:57:48+0000, Lad Prabhakar wrote:
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq_optional().
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/pinctrl/pinctrl-at91-pio4.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> > index fafd1f55cba7..ebfb106be97d 100644
> > --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> > +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> > @@ -1045,7 +1045,6 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
> >       const char **group_names;
> >       const struct of_device_id *match;
> >       int i, ret;
> > -     struct resource *res;
> >       struct atmel_pioctrl *atmel_pioctrl;
> >       const struct atmel_pioctrl_data *atmel_pioctrl_data;
> >
> > @@ -1164,16 +1163,15 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
> >
> >       /* There is one controller but each bank has its own irq line. */
> >       for (i = 0; i < atmel_pioctrl->nbanks; i++) {
> > -             res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> > -             if (!res) {
> > +             ret = platform_get_irq_optional(pdev, i);
>
> I don't think the irq should be optional here.
>
The only difference between platform_get_irq() and
platform_get_irq_optional() is that platform_get_irq() prints an error
message in case of error. Since we are already printing an sane error
message "missing irq resource for group %c\n" in the driver I've
chosen platform_get_irq_optional() instead platform_get_irq().

Let me know if you want me to drop platform_get_irq_optional() and use
platform_get_irq() instead, in that case I'll also drop the error
message "missing irq resource for group %c\n" from the driver.

Cheers,
Prabhakar

> > +             if (ret < 0) {
> >                       dev_err(dev, "missing irq resource for group %c\n",
> >                               'A' + i);
> > -                     return -EINVAL;
> > +                     return ret;
> >               }
> > -             atmel_pioctrl->irqs[i] = res->start;
> > -             irq_set_chained_handler_and_data(res->start,
> > -                     atmel_gpio_irq_handler, atmel_pioctrl);
> > -             dev_dbg(dev, "bank %i: irq=%pr\n", i, res);
> > +             atmel_pioctrl->irqs[i] = ret;
> > +             irq_set_chained_handler_and_data(ret, atmel_gpio_irq_handler, atmel_pioctrl);
> > +             dev_dbg(dev, "bank %i: irq=%d\n", i, ret);
> >       }
> >
> >       atmel_pioctrl->irq_domain = irq_domain_add_linear(dev->of_node,
> > --
> > 2.17.1
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
