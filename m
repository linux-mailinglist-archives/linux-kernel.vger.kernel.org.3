Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E66D47AAA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhLTNtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:49:10 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:41590 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbhLTNst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:48:49 -0500
Received: by mail-ua1-f41.google.com with SMTP id p37so17760636uae.8;
        Mon, 20 Dec 2021 05:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4DF9LjH4hQKuWdOXF8V94wRpu2w4JP6fMl2d9enn9Ys=;
        b=YFECEEl5yyGl1CTYb1e21ZkQKbdvqm4c9+wdw8LjLTHBgcQzVhs14ii3vSYz5hj5pp
         dP7+Z2Lx9DXHaCV9Cw+CUS9tc9+VQXcfiH3hORcay3nD0yWpbuGK1xs8zrUuM9cnwd5h
         DP5d0gTrrw/J7GYS5SRAwvdlF71N1fmzB45MDoRYClEdO6Yob1wSm5/A+JFqZes7vLBk
         K4UypYocJ9Zz+JtLnP/H+GuZyFqfZ0CuxrBZgJFrzL6dAtz87By6b7AoFQ/mYoo+EASz
         jijBzKcs6FOcaPrSyB0DSH3gQe/nRuyypLEInfFgqwBIyPXKdHXnssxH4uvkPpSrlIoM
         Bs1Q==
X-Gm-Message-State: AOAM532dRwIdWqgZn+02oSVPtyqzqlIn2v2MV9eDiNhS/347lCbrxbEe
        Q/GcoGJvEhiFd7aCCFSZOfz6ohKpE25jng==
X-Google-Smtp-Source: ABdhPJzcL4x4VBzkzjYw2+cWz8H7lhxYIgTDOv53F7NZ1Lo1P3st16Knih/A+/AS3NaeIiEkH/D/Vg==
X-Received: by 2002:a9f:2e17:: with SMTP id t23mr5035855uaj.68.1640008128095;
        Mon, 20 Dec 2021 05:48:48 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id t3sm659319vsl.25.2021.12.20.05.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 05:48:47 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id u40so17783923uad.1;
        Mon, 20 Dec 2021 05:48:47 -0800 (PST)
X-Received: by 2002:a05:6102:e10:: with SMTP id o16mr5097612vst.5.1640008127108;
 Mon, 20 Dec 2021 05:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20211218144136.6663-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <5f8e2432-1214-3435-fb62-2f407ced0472@linaro.org>
In-Reply-To: <5f8e2432-1214-3435-fb62-2f407ced0472@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Dec 2021 14:48:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgRzM4+OjR0or0aTk-ogPcAYajaVALsLF6E=MxEzeRQg@mail.gmail.com>
Message-ID: <CAMuHMdXgRzM4+OjR0or0aTk-ogPcAYajaVALsLF6E=MxEzeRQg@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_thermal: Use platform_get_irq_optional() to
 get the interrupt
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 1:29 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 18/12/2021 15:41, Lad Prabhakar wrote:
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
> > Hi,
> >
> > Dropping usage of platform_get_resource() was agreed based on
> > the discussion [0].
> >
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> > patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
> > Cheers,
> > Prabhakar
> > ---
> >  drivers/thermal/rcar_thermal.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> > index b49f04daaf47..e4c7bc1bf7ef 100644
> > --- a/drivers/thermal/rcar_thermal.c
> > +++ b/drivers/thermal/rcar_thermal.c
> > @@ -445,7 +445,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
> >       struct rcar_thermal_common *common;
> >       struct rcar_thermal_priv *priv;
> >       struct device *dev = &pdev->dev;
> > -     struct resource *res, *irq;
> > +     struct resource *res;
> >       const struct rcar_thermal_chip *chip = of_device_get_match_data(dev);
> >       int mres = 0;
> >       int i;
> > @@ -467,9 +467,16 @@ static int rcar_thermal_probe(struct platform_device *pdev)
> >       pm_runtime_get_sync(dev);
> >
> >       for (i = 0; i < chip->nirqs; i++) {
> > -             irq = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> > -             if (!irq)
> > +             int irq;
> > +
> > +             irq = platform_get_irq_optional(pdev, i);
> > +             if (irq <= 0 && irq != -ENXIO) {
> > +                     ret = irq ? irq : -ENXIO;
> > +                     goto error_unregister;
> > +             }
> > +             if (irq == -ENXIO)
> >                       continue;
>
> Why not invert the conditions?
>
>                 if (irq == -ENXIO)
>                         continue;

And this can be break.

>
>                 if (irq <= 0) {
>                         ret = irq ? irq : -ENXIO;

irq == 0 cannot happen.

>                         goto out_unregister;
>                 }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
