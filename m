Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BB5485921
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbiAETZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243475AbiAETZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:25:52 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FFFC061245;
        Wed,  5 Jan 2022 11:25:52 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id w184so836480ybg.5;
        Wed, 05 Jan 2022 11:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ScRpF0L3adtid+3RTX6vgdBF1ypyGcU5Kx8L1Ltr5uA=;
        b=Jdf35w27ET/Fc/B01HXTHowcQYrKvVz67xg60p2fo5c8ovGFyEz0HcTvw3cx0wvZ+C
         oQmWnMZD/Tiwdes8o9OLPivHNBFixh5G5oTeDmjxWtHc4HS5s30zrN6lctFOZMvJjG6G
         S7YO6BGCTcKJawUgjPjb0mIHkticyfitd1wDSA2ib07xcJVqbdfEBHzCvKYa0h1kCVmS
         qdKt0mLIGg8+IoMU8MMYJORWX6EmBGZv8TyVoPWgJhJhsgoxlIZ935KeE6e19/IUeTLT
         +AxMwstkkAOVvhP9IfDwtGe6PTaXZLF/VLY+CrHosX1pLo81m6xujvc3XJ3QFnMI6XUt
         yFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ScRpF0L3adtid+3RTX6vgdBF1ypyGcU5Kx8L1Ltr5uA=;
        b=fF2876ROBhW6KOz1iPXm4p8PU89VI3Qhol4kB5lyjBm8denMBOPwBpJuOvkRJ9pW1p
         BmLveKmEIlFK4v036oUnsSyEqpQ2qUMk5uCmSk8DONS54D1C2eLzUD1Cl7kLh45/X+Bm
         /GZOw56TqjBk1r31CK7l6SUmE8vITEONbJ/CQ8PECA+DQfC1vU2BlzytSaPosR80BsWZ
         ww6z7z9dyBVvy1Ax/oUrmux8U0Fdo6t8yTkDYhz2ZpLkSMXRLSSuu0XqDag6aoSNn1tN
         WF/1F5uasUm8qiFEvXaU1Thggjysh+N/MtPAlXrZXRis4qCoUBFFYqvBR+e9P44c/5GK
         4Slw==
X-Gm-Message-State: AOAM532O1ayZIyzVQWLisL54AnisEJPsMACdAsndogadMZ+qeC+oA/W+
        sr9pPYaqjfe5pRbN8M9o+eufLsorknghmIVHFyc=
X-Google-Smtp-Source: ABdhPJwnF6pYIFI0WAD7k8piW0tCxrml4cTJRyqBlXnFuWqIFryGX2Sl67k0oiTKAcy4sUK4n96sTq4JDEIC07sBE4E=
X-Received: by 2002:a5b:281:: with SMTP id x1mr23440853ybl.41.1641410751548;
 Wed, 05 Jan 2022 11:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20220104145212.4608-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <YdXt2mDjZ0zikbt6@oden.dyn.berto.se>
In-Reply-To: <YdXt2mDjZ0zikbt6@oden.dyn.berto.se>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 5 Jan 2022 19:25:25 +0000
Message-ID: <CA+V-a8sGh0bCiDu_Eiz3EFgaDPmr-qyz95=dExwf+UvuyA21Cg@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: rcar_thermal: Use platform_get_irq_optional()
 to get the interrupt
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

Thank you for the review.

On Wed, Jan 5, 2022 at 7:13 PM Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
>
> Hi Lad,
>
> Thanks for your work.
>
> On 2022-01-04 14:52:11 +0000, Lad Prabhakar wrote:
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
> > v2-v3:
> > * Fixed review comment pointed by Andy
> >
> > v1->v2
> > * Simplified checking error code
> > * Break loop earlier if no interrupts are seen
> >
> > v1: https://lkml.org/lkml/2021/12/18/163
> > ---
> >  drivers/thermal/rcar_thermal.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_ther=
mal.c
> > index b49f04daaf47..e480f7290ccf 100644
> > --- a/drivers/thermal/rcar_thermal.c
> > +++ b/drivers/thermal/rcar_thermal.c
> > @@ -445,7 +445,7 @@ static int rcar_thermal_probe(struct platform_devic=
e *pdev)
> >       struct rcar_thermal_common *common;
> >       struct rcar_thermal_priv *priv;
> >       struct device *dev =3D &pdev->dev;
> > -     struct resource *res, *irq;
> > +     struct resource *res;
> >       const struct rcar_thermal_chip *chip =3D of_device_get_match_data=
(dev);
> >       int mres =3D 0;
> >       int i;
> > @@ -467,9 +467,16 @@ static int rcar_thermal_probe(struct platform_devi=
ce *pdev)
> >       pm_runtime_get_sync(dev);
> >
> >       for (i =3D 0; i < chip->nirqs; i++) {
> > -             irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, i);
> > -             if (!irq)
> > -                     continue;
> > +             int irq;
> > +
> > +             irq =3D platform_get_irq_optional(pdev, i);
> > +             if (irq < 0 && irq !=3D -ENXIO) {
> > +                     ret =3D irq;
> > +                     goto error_unregister;
> > +             }
> > +             if (!irq || irq =3D=3D -ENXIO)
> > +                     break;
>
> This do not look correct and differs form v1.
>
> In the old code if we can't get an IRQ the loop is continued. This is
> used to detect if interrupts are supported or not on the platform.  This
> change will fail on all systems that don't describes interrupts in DT
> while the driver can function without interrupts.
>
There are no non-DT users for this driver. Do you see this driver
being used in a non-DT environment in near future?

> Is there a reason you wish to do this change in addition to the switch
> to platform_get_irq_optional()? If so I think that should be done in a
> separate patch.
>
No other reason, It was suggested by Gerrt too to use a break instead
of continue in v1.

Cheers,
Prabhakar
