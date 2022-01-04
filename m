Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BAE4840B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiADLYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:24:47 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:35835 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiADLYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:24:46 -0500
Received: by mail-vk1-f173.google.com with SMTP id c10so20287208vkn.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 03:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXhqr9jwDQI3ARvEqLlZLvz2Y/xfNtJartfIabDWO6U=;
        b=PxnADfivPeaV810BJDc2MBIUDDiMfS7Xc9Mp43UqMK9piBmDuRAlBRqvY7xF/lJRQM
         uowStpfYxUiflVmk0GI/t7p5I80YTLXIoXaJvxRopmp+Ae+iCVwN3JIjxUehJNUtUrn8
         G1t36CQYXfLyP7xXTmSntPBAYRCB7rIUQ7qpGi6J1XCDh/SUCYdIT03ha6o4SJVIHPUh
         YYj2UJG6RoAPmjRd7x9oS5VuGR9XOcLhq5bCVU84LejmX7/XFildd+cRQURMq1PC04AY
         hiYpxt4lhPtt8WpV19n5Wf/j+G4E9VxurVRHro0c81RtWZS/8l1j+BlXRrQdAZhmsurY
         NESA==
X-Gm-Message-State: AOAM530ukpEUOKLz4uB9Oks6udWlbzlW9ZfdSqAgLFYYpM9C/55StVDY
        C6tHxdvigwkPdNAwCBN8M6k8c5wn+XsozQ==
X-Google-Smtp-Source: ABdhPJwlcg9d0AR1TThhpU0RM9OXCJkdwpNJCHU8eqcIcAT3WWExbQYvFmN340ke0u9l7zKQrqigrg==
X-Received: by 2002:a1f:ea02:: with SMTP id i2mr9018170vkh.39.1641295485398;
        Tue, 04 Jan 2022 03:24:45 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id u137sm3463145vku.42.2022.01.04.03.24.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 03:24:44 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id h67so20560792vkh.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 03:24:44 -0800 (PST)
X-Received: by 2002:a1f:2196:: with SMTP id h144mr16522529vkh.7.1641295484397;
 Tue, 04 Jan 2022 03:24:44 -0800 (PST)
MIME-Version: 1.0
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru> <87pmp7volh.wl-maz@kernel.org>
 <CAMuHMdWjGUHZQhKDPASfpfNOiUg9HP2f3DsUsmJoijap29xpyQ@mail.gmail.com> <87mtkbvktb.wl-maz@kernel.org>
In-Reply-To: <87mtkbvktb.wl-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jan 2022 12:24:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUdU82Kes87zq-15buRTLv44k8XQJmmw3QoBq_rZmvGKw@mail.gmail.com>
Message-ID: <CAMuHMdUdU82Kes87zq-15buRTLv44k8XQJmmw3QoBq_rZmvGKw@mail.gmail.com>
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

Hi Marc,

On Tue, Jan 4, 2022 at 11:48 AM Marc Zyngier <maz@kernel.org> wrote:
> On Tue, 04 Jan 2022 09:47:21 +0000,
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Jan 4, 2022 at 10:26 AM Marc Zyngier <maz@kernel.org> wrote:
> > > [Adding Geert]
> > >
> > > On Sat, 06 Nov 2021 20:26:47 +0000,
> > > Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> > > > The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
> > > > invalid") only calls WARN() when IRQ0 is about to be returned, however
> > > > using IRQ0 is considered invalid (according to Linus) outside the arch/
> > > > code where it's used by the i8253 drivers. Many driver subsystems treat
> > > > 0 specially (e.g. as an indication of the polling mode by libata), so
> > > > the users of platform_get_irq[_byname]() in them would have to filter
> > > > out IRQ0 explicitly and this (quite obviously) doesn't scale...
> > > > Let's finally get this straight and return -EINVAL instead of IRQ0!
> > > >
> > > > Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> > > > Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> >
> > > > --- driver-core.orig/drivers/base/platform.c
> > > > +++ driver-core/drivers/base/platform.c
> > > > @@ -231,7 +231,8 @@ int platform_get_irq_optional(struct pla
> > > >  out_not_found:
> > > >       ret = -ENXIO;
> > > >  out:
> > > > -     WARN(ret == 0, "0 is an invalid IRQ number\n");
> > > > +     if (WARN(!ret, "0 is an invalid IRQ number\n"))
> > > > +             return -EINVAL;
> > > >       return ret;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(platform_get_irq_optional);
> > > > @@ -445,7 +446,8 @@ static int __platform_get_irq_byname(str
> > > >
> > > >       r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
> > > >       if (r) {
> > > > -             WARN(r->start == 0, "0 is an invalid IRQ number\n");
> > > > +             if (WARN(!r->start, "0 is an invalid IRQ number\n"))
> > > > +                     return -EINVAL;
> > > >               return r->start;
> > > >       }
> > >
> > > Geert recently mentioned that a few architectures (such as sh?) still
> > > use IRQ0 as something valid in limited cases.
> >
> > https://lore.kernel.org/all/CAMuHMdUg3=q7gyaVHP0XcYUOo3PQUUv8Hc8wp5faVQ+bTBpg4A@mail.gmail.com
> >
> > TL;DR: Probably only smsc911x Ethernet on the AP-SH4A-3A and
> > AP-SH4AD-0A boards, which should trigger the warning since v5.8.
> >
> > > From my PoV, this patch is fine, but please be prepared to fix things
> > > in a couple of years when someone decides to boot a recent kernel on
> > > their pet dinosaur. With that in mind:
> > >
> > > Acked-by: Marc Zyngier <maz@kernel.org>
> >
> > TBH, I don't see much point in this patch, as the WARN() has been
> > there since a while, and the end goal is to return zero instead of
> > -ENXIO for no interrupt, right?
>
> I think the end-goal is to never return 0. Either we return a valid
> interrupt number, or we return an error. It should be the
> responsibility of the caller to decide what they want to do in the
> error case.

This is platform_get_irq_optional(). All other *_optional() APIs
return 0 (or NULL[1]) in case the optional resource is not available.

[1] Most (all?) return pointers, NULL, or a negative error code.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
