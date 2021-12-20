Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E611047AB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhLTO07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:26:59 -0500
Received: from mail-vk1-f174.google.com ([209.85.221.174]:44626 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhLTO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:26:57 -0500
Received: by mail-vk1-f174.google.com with SMTP id b77so807650vka.11;
        Mon, 20 Dec 2021 06:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hc6ah2sjA67vOQjn79KVsC8Itbl7aj6m1HNPVHcph28=;
        b=a5iNhQ4Z8dM1r0gTXVr2g2gW/1cLF7dyo0e44yK+d/x0egaDWnMqoDoDKKNBWUGJg2
         YBnGVDN1YZQqKdUmgGDQrLSN3UUWaI4soHF/WT5YhFQ6nQOYQzRX2uHfMu33DZevY0mN
         xvewPkkYk/7OMsSYzQk47iKB0BuUimgBCy0KMhWuP2DHp+lLSMGnU3NEPhSwB9FRmo+A
         R9vrXGurIOixkqrUkDfGUw52cuyQbzmmSkWJq+zC+DhtfuE3fUzJ+Wh3y8RzoBGFpUTJ
         jwnvO8cXzoIGoBjCcdka/PLhk/Bzwwv7AePsnbT/5SDfID5eZmBNRPiY6FSKfXFgvtbR
         oYAg==
X-Gm-Message-State: AOAM532HWwKQrr3dLHGDRsP8cOjyJra3YEbXlgtl3zCqA0UBhFOAPicI
        Lcb66NrFVqtqaLAZy5LrMPrlvGDcLVzDag==
X-Google-Smtp-Source: ABdhPJxVZyRUkxqt4FdkpZbc5QxqmQjkzrRFuf3WOWTiMTZfendCsDjMRLX2M14URahcQbeT/VexaQ==
X-Received: by 2002:a05:6122:168e:: with SMTP id 14mr2213743vkl.12.1640010416694;
        Mon, 20 Dec 2021 06:26:56 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id j145sm3317428vke.47.2021.12.20.06.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 06:26:56 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id t13so17933460uad.9;
        Mon, 20 Dec 2021 06:26:56 -0800 (PST)
X-Received: by 2002:a05:6102:21dc:: with SMTP id r28mr4883309vsg.57.1640010415978;
 Mon, 20 Dec 2021 06:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20211218144136.6663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <5f8e2432-1214-3435-fb62-2f407ced0472@linaro.org> <CAMuHMdXgRzM4+OjR0or0aTk-ogPcAYajaVALsLF6E=MxEzeRQg@mail.gmail.com>
 <bdec1a89-ad1b-1e16-a248-029f7f02ae80@linaro.org>
In-Reply-To: <bdec1a89-ad1b-1e16-a248-029f7f02ae80@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Dec 2021 15:26:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWjUG57trhkOevb0Pju1fFptXZwM+BKKvgnG0+vAM64gA@mail.gmail.com>
Message-ID: <CAMuHMdWjUG57trhkOevb0Pju1fFptXZwM+BKKvgnG0+vAM64gA@mail.gmail.com>
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

Hi Daniel,

On Mon, Dec 20, 2021 at 3:19 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 20/12/2021 14:48, Geert Uytterhoeven wrote:
> > On Mon, Dec 20, 2021 at 1:29 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >> On 18/12/2021 15:41, Lad Prabhakar wrote:
> >>> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> >>> allocation of IRQ resources in DT core code, this causes an issue
> >>> when using hierarchical interrupt domains using "interrupts" property
> >>> in the node as this bypasses the hierarchical setup and messes up the
> >>> irq chaining.
> >>>
> >>> In preparation for removal of static setup of IRQ resource from DT core
> >>> code use platform_get_irq_optional().
> >>>
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> >>> --- a/drivers/thermal/rcar_thermal.c
> >>> +++ b/drivers/thermal/rcar_thermal.c
> >>> @@ -445,7 +445,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
> >>>       struct rcar_thermal_common *common;
> >>>       struct rcar_thermal_priv *priv;
> >>>       struct device *dev = &pdev->dev;
> >>> -     struct resource *res, *irq;
> >>> +     struct resource *res;
> >>>       const struct rcar_thermal_chip *chip = of_device_get_match_data(dev);
> >>>       int mres = 0;
> >>>       int i;
> >>> @@ -467,9 +467,16 @@ static int rcar_thermal_probe(struct platform_device *pdev)
> >>>       pm_runtime_get_sync(dev);
> >>>
> >>>       for (i = 0; i < chip->nirqs; i++) {
> >>> -             irq = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> >>> -             if (!irq)
> >>> +             int irq;
> >>> +
> >>> +             irq = platform_get_irq_optional(pdev, i);
> >>> +             if (irq <= 0 && irq != -ENXIO) {
> >>> +                     ret = irq ? irq : -ENXIO;
> >>> +                     goto error_unregister;
> >>> +             }
> >>> +             if (irq == -ENXIO)
> >>>                       continue;
> >>
> >> Why not invert the conditions?
> >>
> >>                 if (irq == -ENXIO)
> >>                         continue;
> >
> > And this can be break.
> >
> >>
> >>                 if (irq <= 0) {
> >>                         ret = irq ? irq : -ENXIO;
> >
> > irq == 0 cannot happen.
> >
> >>                         goto out_unregister;
> >>                 }
>
> Sorry, I don't get the two comments. May be I missed something but it
> seems for me the results are the same with the inverted conditions or not.
>
> if (irq <= 0 && irq != -ENXIO)
>         goto out;
>
> if (irq == -ENXIO)
>         continue;
>
> Can be changed to:
>
> if (irq != -ENXIO)
>         if (irq <= 0)
>                 goto out;
>
> if (irq == -ENXIO)
>         continue;
>
> Can be changed to:
>
>
> if (irq == -ENXIO)
>         continue;
>
> if (irq != -ENXIO)
>         if (irq <= 0)
>                 goto out;
>
> The second condition is always true because the first condition is the
> opposite of the second condition, if the second condition block is
> reached, that means irq != -ENXIO, so we can remove the second condition
> and that results into:
>
> if (irq == -ENXIO)
>         continue;
>
> if (irq <= 0)
>         goto out;
>
>
> Did I miss your point ?

I think so, as I don't see your point, neither ;-)

I meant (a) there is no need to continue the loop when there are no
more interrupts present, and (b) irq == 0 cannot happen, so the cod
can be simplified to:

    if (irq == -ENXIO)
            break;
    if (irq < 0) {
            ret = irq;
            goto out_unregister;
    }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
