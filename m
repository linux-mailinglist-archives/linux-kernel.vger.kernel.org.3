Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC91467C8C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358925AbhLCRct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:32:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34826 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245736AbhLCRcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:32:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 799B5B828D2;
        Fri,  3 Dec 2021 17:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C31C53FAD;
        Fri,  3 Dec 2021 17:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638552562;
        bh=D8ZroLyF6v++5dN5/58x6gU+Ph0k2r9VGIcntedqquc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bVzkbo/JF+/BtenKBLfvVjq1AAL6FInK0ibmDrC6yWVGzsBh+WanCukSZ/CIOFi+H
         1UP/BBfYLg8dll1HMrlHkID2SHdw8RwSL6nf2UUv7sZWV82u48JGqulJY1O4yGsd0s
         Uo3KIt/OPvxBmLloMSkOMrGd5hyb9btoVX6ymWZCcV4JMQCuaOvnX8T3sDtRCw/hUJ
         Z0LBCOokGtGN4UqgRUyhSEVXWqC42LvuO5tP727oZPKUMXiSpIzGu2pBvmi9DjMd9+
         RJNKwU7s1EObIvOswGKYyFXMkiwrhv94Z83rLE6fIrK6CBubq3qZDJuTkxD1tXfsph
         209S4rfv7yx8g==
Received: by mail-qk1-f169.google.com with SMTP id 193so4142807qkh.10;
        Fri, 03 Dec 2021 09:29:22 -0800 (PST)
X-Gm-Message-State: AOAM532ZQ8BS/RlkCQbuG6Yv9FHK038kcphB9Np/h2ZPO5URj/E5tTZE
        BUFnyNr/w/VtS43TyG8/eUKM1TJ6zV9sNNp6Sg==
X-Google-Smtp-Source: ABdhPJwCYD+6VYZnbuhBe56bBOERc/ZR0BgQVZOCCO83ZBv7ygbd7R9GCzWKWqFozC0fEdhWn8IOr/HYxcZiLyD357k=
X-Received: by 2002:a05:620a:4547:: with SMTP id u7mr19083165qkp.643.1638552561177;
 Fri, 03 Dec 2021 09:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20211201114102.13446-1-maz@kernel.org> <CAMuHMdXM34nNz1nfowNqDvdsdg+d69Bo3_ufs6fbcq65iYd5-A@mail.gmail.com>
 <YapRL+2gQBjNyK4p@robh.at.kernel.org>
In-Reply-To: <YapRL+2gQBjNyK4p@robh.at.kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 3 Dec 2021 11:29:10 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+VUeV737HCTY4Zjwxm8FX7oAr5oExm8miTDY2+dWrvSQ@mail.gmail.com>
Message-ID: <CAL_Jsq+VUeV737HCTY4Zjwxm8FX7oAr5oExm8miTDY2+dWrvSQ@mail.gmail.com>
Subject: Re: [PATCH v2] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        John Crispin <john@phrozen.org>, Biwen Li <biwen.li@nxp.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sander Vanheule <sander@svanheule.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 11:17 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Dec 02, 2021 at 04:06:21PM +0100, Geert Uytterhoeven wrote:
> > Hi Marc,
> >
> > On Wed, Dec 1, 2021 at 12:41 PM Marc Zyngier <maz@kernel.org> wrote:
> > > Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
> > > to an interrupt controller"), a handful of interrupt controllers have
> > > stopped working correctly. This is due to the DT exposing a non-sensical
> > > interrupt-map property, and their drivers relying on the kernel ignoring
> > > this property.
> > >
> > > Since we cannot realistically fix this terrible behaviour, add a quirk
> > > for the limited set of devices that have implemented this monster,
> > > and document that this is a pretty bad practice.
> > >
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: John Crispin <john@phrozen.org>
> > > Cc: Biwen Li <biwen.li@nxp.com>
> > > Cc: Chris Brandt <chris.brandt@renesas.com>
> > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Cc: Sander Vanheule <sander@svanheule.net>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >
> > > Notes:
> > >     v2: Switched over to of_device_compatible_match() as per Rob's
> > >         request.
> >
> > Thanks for the update!
> >
> > > --- a/drivers/of/irq.c
> > > +++ b/drivers/of/irq.c
> >
> > > @@ -159,12 +179,16 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
> > >                 /*
> > >                  * Now check if cursor is an interrupt-controller and
> > >                  * if it is then we are done, unless there is an
> > > -                * interrupt-map which takes precedence.
> > > +                * interrupt-map which takes precedence if we're not
> > > +                * in presence of once of these broken platform that
> >
> > one
>
> and 'platforms'. Will fixup.
>
> >
> > > +                * want to parse interrupt-map themselves for $reason.
> > >                  */
> > >                 bool intc = of_property_read_bool(ipar, "interrupt-controller");
> > > +               bool imap_abuse;
> > >
> > >                 imap = of_get_property(ipar, "interrupt-map", &imaplen);
> > > -               if (imap == NULL && intc) {
> > > +               imap_abuse = imap && of_device_compatible_match(ipar, of_irq_imap_abusers);
> >
> > ... = intc && imap && of_device_compatible_match(...)
>
> Why? Then we are comparing intc twice because we still need it for the
> intc && !imap case.

I ended up rewriting it like this:

-               if (imap == NULL && intc) {
+               if (intc &&
+                   (!imap || of_device_compatible_match(ipar,
of_irq_imap_abusers))) {

Rob
