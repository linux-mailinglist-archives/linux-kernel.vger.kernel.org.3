Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF13E46E5EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhLIJwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhLIJwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:52:54 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20CEC061746;
        Thu,  9 Dec 2021 01:49:21 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id x32so12254680ybi.12;
        Thu, 09 Dec 2021 01:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQpKpHEkZnskW/9rn7pkazm2zuLSSCZbHGXMjb0S1Wk=;
        b=XBnCHNEgWLjtlTJj5RH4gDr/J4mLQ3IMBPl5zArkIT3jGgHg8Vz1VPkef3Ubsghmrx
         ytbn6u2DzlwZvvlj6hj75kvYnOBSbRUJZqdkYebWpFfnl80ybMNcAfbBueTUjK4Av40m
         mKcWUnevstM6SvuU6c/ME+KvHEg6NHAZrc+zgaxNA2MQ2C7uqe/40yRRXZ/IJGSNXnDv
         GPv+MkdG+89uuAiuGlmA72SJNeigaeM+youZDh5GWC4UE3q+C9mX6v+865Vd2ZnIvtYj
         mOY8DA34y4IhukbxEEA5mnDWFQ8bwGXKfkKfttvNiVt9YY0TezVPbS6X7m3pLj+8fKqE
         DWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQpKpHEkZnskW/9rn7pkazm2zuLSSCZbHGXMjb0S1Wk=;
        b=P54CHF/nEG50ADm+z36ko1XXVdDAb8zD7Cv3pZZ4EIMAeb8pweqKn+9Tz069k/TvVL
         8FuBF/5r8F7XfNHh8PrT/sijYNfbxk3LwEPwNh995H/E+QLMeKKla+Olz1fAbQnuXwUQ
         WUQePOhK3ngvrjQvZqGuJr6TKtJFYXLwzyKTlQEjRBr+dP88oVpX1pRqze+ne6bxpuUg
         atqbZ9Mb6RrA+kF/wLxzTuqJVqHLtV0/5cIj21/nNebOytQerQaL2F4py/hcoQnRtlRd
         8iSRfnVhHYN+7SxZPbwoQt6o2y/mt7ZT/whMU2DSdXuwXEpIooLNkJWeR5b3cFGg/CIC
         9kcg==
X-Gm-Message-State: AOAM531kAeek6Yq/c7IM1dbRx+vYi44wvDopDy0kZHCZ4GmRge1SbFtU
        sc9IxpRSf9AnvlcKQvI2+78zuzdnLLX06O0eEsE=
X-Google-Smtp-Source: ABdhPJwJrt1HtCmQ3QFj4TeC573hRGf90SYf4SX6X0oN2z2dXeh9DDAsPpP7YPGoHlBVqv63FWeLsm+YoCTLwhp6toU=
X-Received: by 2002:a25:4213:: with SMTP id p19mr5032651yba.41.1639043360866;
 Thu, 09 Dec 2021 01:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAL_JsqJUS0-ZNus__7nJJ-BaJBqQcS0NZ8a4o5QheLt4g8oK+Q@mail.gmail.com>
In-Reply-To: <CAL_JsqJUS0-ZNus__7nJJ-BaJBqQcS0NZ8a4o5QheLt4g8oK+Q@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 9 Dec 2021 09:48:54 +0000
Message-ID: <CA+V-a8s5TpsXCFLFxzzsWj0ho3Hu+pS93mqXdHsCCh2LdzSQuQ@mail.gmail.com>
Subject: Re: [RFC PATCH] of: platform: Skip mapping of interrupts in of_device_alloc()
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the review.

On Thu, Dec 9, 2021 at 3:08 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Dec 8, 2021 at 6:11 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > of_device_alloc() in early boot stage creates a interrupt mapping if
> > there exists a "interrupts" property in the node.
> >
> > For hierarchical interrupt domains using "interrupts" property in the node
> > bypassed the hierarchical setup and messed up the irq setup.
> >
> > This patch adds a check in of_device_alloc() to skip interrupt mapping if
> > "not-interrupt-producer" property is present in the node. This allows
> > nodes to describe the interrupts using "interrupts" property.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Hi All,
> >
> > Spawning from discussion [1], here is simple patch (not the ideal probably
> > welcome for suggestions) from stopping the OF code from creating a map for
> > the interrupts when using "interrupts" property.
> >
> > [1] https://lore.kernel.org/lkml/87pmqrck2m.wl-maz@kernel.org/
> >     T/#mbd1e47c1981082aded4b32a52e2c04291e515508
> >
> > Cheers,
> > Prabhakar
> > ---
> >  drivers/of/platform.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index b3faf89744aa..629776ca1721 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -114,7 +114,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
> >                                   struct device *parent)
> >  {
> >         struct platform_device *dev;
> > -       int rc, i, num_reg = 0, num_irq;
> > +       int rc, i, num_reg = 0, num_irq = 0;
> >         struct resource *res, temp_res;
> >
> >         dev = platform_device_alloc("", PLATFORM_DEVID_NONE);
> > @@ -124,7 +124,14 @@ struct platform_device *of_device_alloc(struct device_node *np,
> >         /* count the io and irq resources */
> >         while (of_address_to_resource(np, num_reg, &temp_res) == 0)
> >                 num_reg++;
> > -       num_irq = of_irq_count(np);
> > +
> > +       /*
> > +        * we don't want to map the interrupts of hierarchical interrupt domain
> > +        * into the parent domain yet. This will be the job of the hierarchical
> > +        * interrupt driver code to map the interrupts as and when needed.
> > +        */
> > +       if (!of_property_read_bool(np, "not-interrupt-producer"))
> > +               num_irq = of_irq_count(np);
>
> The property won't fly for sure. A compatible match table could work
> here, but I don't really want another temporary solution.
>
Agreed.

> >         /* Populate the resource table */
> >         if (num_irq || num_reg) {
> > @@ -140,7 +147,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
> >                         rc = of_address_to_resource(np, i, res);
> >                         WARN_ON(rc);
> >                 }
> > -               if (of_irq_to_resource_table(np, res, num_irq) != num_irq)
> > +               if (num_irq && of_irq_to_resource_table(np, res, num_irq) != num_irq)
>
> You might want to look at commit 9ec36cafe43b ("of/irq: do irq
> resolution in platform_get_irq"). The intent was to remove this code,
> but looks like the cleanup has a ways to go 7 years on. Primarily,
> it's convert any platform_get_resource(pdev, IORESOURCE_IRQ, n) call
> to platform_get_irq(). There's ~169 of those.
>
That's a good point converting all the drivers to use
platform_get_irq() so that the resource allocation happens on demand,
and the above code can be dropped.

> There are probably some open coded accesses to pdev->resources too,
> but I didn't spot any.
>
I'll have a closer look.

Cheers,
Prabhakar

> Rob
