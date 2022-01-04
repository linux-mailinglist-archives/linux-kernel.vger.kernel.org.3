Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0F483F59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiADJrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:47:35 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:36489 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiADJre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:47:34 -0500
Received: by mail-ua1-f46.google.com with SMTP id r15so62290603uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 01:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MWw3FGcbHF2JBy0PY4zr25hJLdwJXKqDqOgxgbN5EO0=;
        b=To1853H/5/eQzqrFpPFnhAWb6rC8wzDe2xxsyPbO6XlEDxQph3mqfh4HDtatAOLEg2
         D0Cx/1/5GGmoHlvVZb5iVI0JMDxRXSPdr7obFh04oYaU0kKsax3FXvzaUBedySdkFNyU
         SrHC2q7pfxRF1ZyeubjW+/5zX7uFL6lN9gK6du5l7yQlUi8ybMV5N2ltrk0wzbhOLCJK
         j/lVur7qokWuvQaLp03IVFR+w5jShkG7LyE1NkOQ4l7GS4O54fElsRi5YSy8m/8zac8V
         H5uTjUwN2xRTkQiEniWiWqtN78ds98dQ3GfP/i0aLJX7ukCUmsPtpvRqR8SJuEhyuO0W
         QKqw==
X-Gm-Message-State: AOAM530FaxwYRfWpN+sdUw0v+7RnTarmqXqmt0bk8+JEqDTizeRsMrK2
        /f55yGRCOr54pgaplaBv5etWDCFDWvDw9w==
X-Google-Smtp-Source: ABdhPJwPftdnI23JA3nLjXmxKy6DWQ835++43t5JzmkhiNW04bFQVpnSh3e9kYWzlpN3S/5sY39kug==
X-Received: by 2002:a05:6102:31ad:: with SMTP id d13mr14685291vsh.55.1641289653215;
        Tue, 04 Jan 2022 01:47:33 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id b8sm7580411vsl.19.2022.01.04.01.47.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 01:47:33 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id s72so4643405vks.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 01:47:32 -0800 (PST)
X-Received: by 2002:a05:6122:21a6:: with SMTP id j38mr16397803vkd.39.1641289652631;
 Tue, 04 Jan 2022 01:47:32 -0800 (PST)
MIME-Version: 1.0
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru> <87pmp7volh.wl-maz@kernel.org>
In-Reply-To: <87pmp7volh.wl-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jan 2022 10:47:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWjGUHZQhKDPASfpfNOiUg9HP2f3DsUsmJoijap29xpyQ@mail.gmail.com>
Message-ID: <CAMuHMdWjGUHZQhKDPASfpfNOiUg9HP2f3DsUsmJoijap29xpyQ@mail.gmail.com>
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq() and
 its ilk
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 10:26 AM Marc Zyngier <maz@kernel.org> wrote:
> [Adding Geert]
>
> On Sat, 06 Nov 2021 20:26:47 +0000,
> Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> > The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
> > invalid") only calls WARN() when IRQ0 is about to be returned, however
> > using IRQ0 is considered invalid (according to Linus) outside the arch/
> > code where it's used by the i8253 drivers. Many driver subsystems treat
> > 0 specially (e.g. as an indication of the polling mode by libata), so
> > the users of platform_get_irq[_byname]() in them would have to filter
> > out IRQ0 explicitly and this (quite obviously) doesn't scale...
> > Let's finally get this straight and return -EINVAL instead of IRQ0!
> >
> > Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> > Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

> > --- driver-core.orig/drivers/base/platform.c
> > +++ driver-core/drivers/base/platform.c
> > @@ -231,7 +231,8 @@ int platform_get_irq_optional(struct pla
> >  out_not_found:
> >       ret = -ENXIO;
> >  out:
> > -     WARN(ret == 0, "0 is an invalid IRQ number\n");
> > +     if (WARN(!ret, "0 is an invalid IRQ number\n"))
> > +             return -EINVAL;
> >       return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(platform_get_irq_optional);
> > @@ -445,7 +446,8 @@ static int __platform_get_irq_byname(str
> >
> >       r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
> >       if (r) {
> > -             WARN(r->start == 0, "0 is an invalid IRQ number\n");
> > +             if (WARN(!r->start, "0 is an invalid IRQ number\n"))
> > +                     return -EINVAL;
> >               return r->start;
> >       }
>
> Geert recently mentioned that a few architectures (such as sh?) still
> use IRQ0 as something valid in limited cases.

https://lore.kernel.org/all/CAMuHMdUg3=q7gyaVHP0XcYUOo3PQUUv8Hc8wp5faVQ+bTBpg4A@mail.gmail.com

TL;DR: Probably only smsc911x Ethernet on the AP-SH4A-3A and
AP-SH4AD-0A boards, which should trigger the warning since v5.8.

> From my PoV, this patch is fine, but please be prepared to fix things
> in a couple of years when someone decides to boot a recent kernel on
> their pet dinosaur. With that in mind:
>
> Acked-by: Marc Zyngier <maz@kernel.org>

TBH, I don't see much point in this patch, as the WARN() has been
there since a while, and the end goal is to return zero instead of
-ENXIO for no interrupt, right?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
