Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F045A46E617
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhLIKEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhLIKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:04:44 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB01C061746;
        Thu,  9 Dec 2021 02:01:11 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 131so12374190ybc.7;
        Thu, 09 Dec 2021 02:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+sMjbqSAt/gq7+I0wM/bKh0O+Cxr7Xc7+5bjGHY2cn0=;
        b=A2CBzi6vl+yTrQp3xgyFDy6w2zVzfeMe9pwcmxAQ7EOeOA4jO/78PNA1XktRQDcTAt
         /9xJ3S4TmtJtzpJzANN5GvaFeesYCq7qFlhelqztnrHNhrt7yI06MVJf5KxgSeWQ6cpe
         4INOtMCmwpVJYYvNTLbz+zbiKph2GYUcyZxde7otdN5I/ODjC8QSpqEWQi5v5US1/UG4
         GXXAJP1iA4062Y46B3sofrpb4SyUfx/cY3dgGCXdkE4O7wfxZxR1D0G7rAiocUrctwjw
         cnFeL1hCadhE0jgqKDPPx09Ag36ZVng8ciohIlhO12MSe4rJTeNeJ0ilQCnca/bZNSJh
         ENkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sMjbqSAt/gq7+I0wM/bKh0O+Cxr7Xc7+5bjGHY2cn0=;
        b=bojCvUqw8uY8pdGob/cqQkztZVlFapULZIE9RqWxN6MishDoT7P9Qm2cvfQ2lrg78m
         Wh6bOclfAoW8rquFQYU94nJHuJmQkxJnWb7ublA004NtF8mjgM9XyM0txYXwcwEqzcoH
         z693B+I4SPZzlErYXiLpPp7msS0VSOUhHG6lFesbVAixOA+tYRPKqC0UNWIyS1y6pz0T
         7tnIIJHncHfg7XIrYy5MIUbiZ06JNsQFp+IAevcQ0np8vn11qTjgf3Y3r01dUxi6zWBj
         1qtNbpMcN445xWZF2pVKdh/2n2pSQv5mJjYN4UPGQAq1cyKgAQ+aFyyV4P5QpzUMPeyk
         fO/A==
X-Gm-Message-State: AOAM531VmjmJQvMcenKcH/sADEf4aD6N7amFdqa9xOtLHYJMc4WhGRpd
        EGzk9HVjOGjCtbZuF1SyGHW0qc9W/KkGPY3BeBA=
X-Google-Smtp-Source: ABdhPJxkqTNzFZZ+Ck7d92ZE1ZAfXj2zcB8ZxPu3bDQaYZ/Mv5OLSdAsJE/gVJ1RtqC4/z619MV2SF8IWLWyqrFK0Bw=
X-Received: by 2002:a25:84c1:: with SMTP id x1mr4984988ybm.690.1639044070671;
 Thu, 09 Dec 2021 02:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <d290850bf95f4bdf0c329f278db458c7@kernel.org>
In-Reply-To: <d290850bf95f4bdf0c329f278db458c7@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 9 Dec 2021 10:00:44 +0000
Message-ID: <CA+V-a8vUCXQa38NmYu9znakcq4A=Uedyn8w5+hXQ_WKf58oHRQ@mail.gmail.com>
Subject: Re: [RFC PATCH] of: platform: Skip mapping of interrupts in of_device_alloc()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Thank you for the review.

On Thu, Dec 9, 2021 at 8:07 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2021-12-09 00:10, Lad Prabhakar wrote:
> > of_device_alloc() in early boot stage creates a interrupt mapping if
> > there exists a "interrupts" property in the node.
> >
> > For hierarchical interrupt domains using "interrupts" property in the
> > node
> > bypassed the hierarchical setup and messed up the irq setup.
> >
> > This patch adds a check in of_device_alloc() to skip interrupt mapping
> > if
> > "not-interrupt-producer" property is present in the node. This allows
> > nodes to describe the interrupts using "interrupts" property.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Hi All,
> >
> > Spawning from discussion [1], here is simple patch (not the ideal
> > probably
> > welcome for suggestions) from stopping the OF code from creating a map
> > for
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
> > @@ -114,7 +114,7 @@ struct platform_device *of_device_alloc(struct
> > device_node *np,
> >                                 struct device *parent)
> >  {
> >       struct platform_device *dev;
> > -     int rc, i, num_reg = 0, num_irq;
> > +     int rc, i, num_reg = 0, num_irq = 0;
> >       struct resource *res, temp_res;
> >
> >       dev = platform_device_alloc("", PLATFORM_DEVID_NONE);
> > @@ -124,7 +124,14 @@ struct platform_device *of_device_alloc(struct
> > device_node *np,
> >       /* count the io and irq resources */
> >       while (of_address_to_resource(np, num_reg, &temp_res) == 0)
> >               num_reg++;
> > -     num_irq = of_irq_count(np);
> > +
> > +     /*
> > +      * we don't want to map the interrupts of hierarchical interrupt
> > domain
> > +      * into the parent domain yet. This will be the job of the
> > hierarchical
> > +      * interrupt driver code to map the interrupts as and when needed.
> > +      */
> > +     if (!of_property_read_bool(np, "not-interrupt-producer"))
>
> I don't think this is right. If anything, the expected behaviour should
> be
> indicated by the driver and not the device node.
>
> > +             num_irq = of_irq_count(np);
> >
> >       /* Populate the resource table */
> >       if (num_irq || num_reg) {
> > @@ -140,7 +147,7 @@ struct platform_device *of_device_alloc(struct
> > device_node *np,
> >                       rc = of_address_to_resource(np, i, res);
> >                       WARN_ON(rc);
> >               }
> > -             if (of_irq_to_resource_table(np, res, num_irq) != num_irq)
> > +             if (num_irq && of_irq_to_resource_table(np, res, num_irq) !=
> > num_irq)
> >                       pr_debug("not all legacy IRQ resources mapped for %pOFn\n",
> >                                np);
> >       }
>
> The root of the issue is that all the resource allocation is done
> upfront,
> way before we even have a driver that could potentially deal with this
> device. This is a potential waste of resource, and it triggers the
> issue you noticed.
>
> If you delay the resource allocation until there is an actual match with
> a
> driver, you could have a per-driver flag telling you whether the IRQ
> allocation should be performed before the probe() function is called.
>
As suggested by Rob, if we switch the drivers to use
platform_get_resource(pdev, IORESOURCE_IRQ, n) call with
platform_get_irq() this code should go away and with this switch the
resource allocation will happen demand. Is this approach OK?

Cheers,
Prabhakar

>          M.
> --
> Jazz is not dead. It just smells funny...
