Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E54485088
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiAEKAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbiAEKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:00:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE8AC061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 02:00:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u25so38375677edf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 02:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNydPz1IxvNxphxokHRSmnmLZ2VU4WjKSbkhvJgrWYQ=;
        b=COBqBNbo4mky1+c64WzCxk9Ne4eeJPSXtDFJBoMFfWDOeFkGgImqFw4CZ2kOhc/Lel
         taaY8M9VedUuQdp0gPkU90HnzSHXJbvnRROPQzq8CVFto92VopEenBADa21fuRPWA9qf
         6dbxRF4pdjMmXeRSOy5iaiyxkdrV0cBd7dO036NmD6K12HqlOuZnh3JLhe9a5fGpNNkh
         p5T2vpi3ogOdS1+5Y2xZNgLnYl6FAyyY979fm0Y/ZBOvXbqABr6t4TXf78PZ8f/hLzjy
         QPWYR/dNqmLrwsEY45V91Vd8GLxbn70XDzuyaMzAo6uvAJjhb+6bXbg0kbTUlsir1eBI
         /dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNydPz1IxvNxphxokHRSmnmLZ2VU4WjKSbkhvJgrWYQ=;
        b=ZZ9KSYoKOLIjIppMrpxRJaxexhauj19mbFOi8JXyTi6dvL76BM/hZBOoEr14vhHgLN
         syc4Bil0AMQSb88FWGx00MWMqA0xLP7EKtHUIEIT5VI5b9pHEmXA7S29xvxUiTEGtK+0
         EaljZPHUKUFdfVjL6z7v6QUXOMbRxfIANry1ZxPjlv6x0GSsZHS4qOgHDrG/Z2fOmgid
         OCumXi/TSAnWIb9RBTdDzKk0NS8CuysMOrhWoH+BC94rZxwVH0HVXxaGAUJB70GvG8Lc
         n6/gROFsDK0GooMkNCYqs67X6/a2vYTnyzLrCXHe/nzmFlRL8X4DZs/xzkDR08n/JDBQ
         ziLg==
X-Gm-Message-State: AOAM532HuFY/6OS5eRt8yCfbh3Oj/RrMV98TxhqIwYmjHEu4VOQPlBWS
        VRRInu271an8tcOJLKmZucJMbHNPtvgknRQagmb9DLIHDSM=
X-Google-Smtp-Source: ABdhPJwmCRlEdq0snmY3CNWZECHuU+3l9aqQ6biKLFbC80Ukp8dOyJNgMgBM1c2kHg0dQnhDl/cDUj/WHceDvBz87mw=
X-Received: by 2002:a05:6402:795:: with SMTP id d21mr17493442edy.270.1641376813656;
 Wed, 05 Jan 2022 02:00:13 -0800 (PST)
MIME-Version: 1.0
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru> <87pmp7volh.wl-maz@kernel.org>
 <CAMuHMdWjGUHZQhKDPASfpfNOiUg9HP2f3DsUsmJoijap29xpyQ@mail.gmail.com>
 <87mtkbvktb.wl-maz@kernel.org> <CAMuHMdUdU82Kes87zq-15buRTLv44k8XQJmmw3QoBq_rZmvGKw@mail.gmail.com>
In-Reply-To: <CAMuHMdUdU82Kes87zq-15buRTLv44k8XQJmmw3QoBq_rZmvGKw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jan 2022 11:59:37 +0200
Message-ID: <CAHp75Vf3EgE7uaJLXiYn5ESOrQ3af9KmoLhWdJc4yZPK9Dx38A@mail.gmail.com>
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq() and
 its ilk
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marc Zyngier <maz@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 3:14 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Marc,
>
> On Tue, Jan 4, 2022 at 11:48 AM Marc Zyngier <maz@kernel.org> wrote:
> > On Tue, 04 Jan 2022 09:47:21 +0000,
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Jan 4, 2022 at 10:26 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > [Adding Geert]
> > > >
> > > > On Sat, 06 Nov 2021 20:26:47 +0000,
> > > > Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> > > > > The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
> > > > > invalid") only calls WARN() when IRQ0 is about to be returned, however
> > > > > using IRQ0 is considered invalid (according to Linus) outside the arch/
> > > > > code where it's used by the i8253 drivers. Many driver subsystems treat
> > > > > 0 specially (e.g. as an indication of the polling mode by libata), so
> > > > > the users of platform_get_irq[_byname]() in them would have to filter
> > > > > out IRQ0 explicitly and this (quite obviously) doesn't scale...
> > > > > Let's finally get this straight and return -EINVAL instead of IRQ0!
> > > > >
> > > > > Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> > > > > Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > >
> > > > > --- driver-core.orig/drivers/base/platform.c
> > > > > +++ driver-core/drivers/base/platform.c
> > > > > @@ -231,7 +231,8 @@ int platform_get_irq_optional(struct pla
> > > > >  out_not_found:
> > > > >       ret = -ENXIO;
> > > > >  out:
> > > > > -     WARN(ret == 0, "0 is an invalid IRQ number\n");
> > > > > +     if (WARN(!ret, "0 is an invalid IRQ number\n"))
> > > > > +             return -EINVAL;
> > > > >       return ret;
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(platform_get_irq_optional);
> > > > > @@ -445,7 +446,8 @@ static int __platform_get_irq_byname(str
> > > > >
> > > > >       r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
> > > > >       if (r) {
> > > > > -             WARN(r->start == 0, "0 is an invalid IRQ number\n");
> > > > > +             if (WARN(!r->start, "0 is an invalid IRQ number\n"))
> > > > > +                     return -EINVAL;
> > > > >               return r->start;
> > > > >       }
> > > >
> > > > Geert recently mentioned that a few architectures (such as sh?) still
> > > > use IRQ0 as something valid in limited cases.
> > >
> > > https://lore.kernel.org/all/CAMuHMdUg3=q7gyaVHP0XcYUOo3PQUUv8Hc8wp5faVQ+bTBpg4A@mail.gmail.com
> > >
> > > TL;DR: Probably only smsc911x Ethernet on the AP-SH4A-3A and
> > > AP-SH4AD-0A boards, which should trigger the warning since v5.8.
> > >
> > > > From my PoV, this patch is fine, but please be prepared to fix things
> > > > in a couple of years when someone decides to boot a recent kernel on
> > > > their pet dinosaur. With that in mind:
> > > >
> > > > Acked-by: Marc Zyngier <maz@kernel.org>
> > >
> > > TBH, I don't see much point in this patch, as the WARN() has been
> > > there since a while, and the end goal is to return zero instead of
> > > -ENXIO for no interrupt, right?
> >
> > I think the end-goal is to never return 0. Either we return a valid
> > interrupt number, or we return an error. It should be the
> > responsibility of the caller to decide what they want to do in the
> > error case.
>
> This is platform_get_irq_optional(). All other *_optional() APIs
> return 0 (or NULL[1]) in case the optional resource is not available.

+1 to Geert's p.o.v. here. The platform_get_irq() and (non-optional)
Co should never return 0, while _optional variants as Geert explained.

> [1] Most (all?) return pointers, NULL, or a negative error code.



-- 
With Best Regards,
Andy Shevchenko
