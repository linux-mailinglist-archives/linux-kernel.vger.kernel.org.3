Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDEB48402C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiADKxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiADKxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:53:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FE8C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 02:53:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7C966131E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94921C36AEB;
        Tue,  4 Jan 2022 10:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641293617;
        bh=TPrII2QhoHNYu1j9Z9twe5MGMSzZnlH7NytqrtcBi6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cL88TKu2MDWRoYlpyn+vzl/P0ILmARraNVCBRN/XC7b7GHJtv1/O5dZsgFjKOD4Fs
         3QPDBvD/TApLaMWpJDIAp6WZtWzQ4ZgtGUOK8d0BeQl3s65AAEu7avToYRLpd3RrdH
         LVgDIDjXFy/75YfSlzn6qZ8a494WJvdXuu2FpNLM=
Date:   Tue, 4 Jan 2022 11:53:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq()
 and its ilk
Message-ID: <YdQnLuQseVhq40yd@kroah.com>
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru>
 <87pmp7volh.wl-maz@kernel.org>
 <CAMuHMdWjGUHZQhKDPASfpfNOiUg9HP2f3DsUsmJoijap29xpyQ@mail.gmail.com>
 <87mtkbvktb.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtkbvktb.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 10:48:00AM +0000, Marc Zyngier wrote:
> On Tue, 04 Jan 2022 09:47:21 +0000,
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > 
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

As 0 still is a valid irq for some platforms (as mentioned above), then
how is this ever going to be possible?

thanks,

greg k-h
