Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7C467C55
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353332AbhLCRVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:21:02 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:41594 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbhLCRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:21:01 -0500
Received: by mail-oi1-f182.google.com with SMTP id u74so7021539oie.8;
        Fri, 03 Dec 2021 09:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LopSZZqOHeVvnglHSvjT8qRUzuJA5ym+Hy9RXNIz2lg=;
        b=SxcZPeUyAFwxc7XzON/PCBAJ7oHMt0emw8w5FHLFM59UPs9Hg3RZt4dMf9XdPjc3Nk
         YtuAlVaDkkU1P6x133Ceb6ZJnjcIbX+YrLsHhw2I+QTVn7hYWgspdU2UxuNeBFlubujS
         q36HXGvk8f7hNBmTC9llA5l1lgn/Io6KZxvyMsztcpjhrxZD5uBxCPL67sdEoVeg296d
         NjSHT3/FhKN1URwoJh7L1pXKlGf7ZJ7l8K73rjMEwfhmLS/Nev6O4h8IkFP6zezRA08g
         90UfSTQpUGznMBuMBVOQQYqel8SymuG0g5xutbyjWB54eaOQWPPLSEMiiYpSl2c9rWpV
         sYGQ==
X-Gm-Message-State: AOAM532kmEFd8FylThwW8wxWFZ5q+WaY0lhMT43s9WvFEF3iejR7Hh0P
        vvaTj2kJAWqu811MMMNuZg==
X-Google-Smtp-Source: ABdhPJwVRfH6Htt88NzXlPyv9x8/RqSaP0vo5gsItLyVD0DqmDNN/GKdyqdZ6i0Q3VT3fwWr3BbPbQ==
X-Received: by 2002:aca:ab87:: with SMTP id u129mr10921405oie.42.1638551857024;
        Fri, 03 Dec 2021 09:17:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i16sm800876oig.15.2021.12.03.09.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 09:17:36 -0800 (PST)
Received: (nullmailer pid 231564 invoked by uid 1000);
        Fri, 03 Dec 2021 17:17:35 -0000
Date:   Fri, 3 Dec 2021 11:17:35 -0600
From:   Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH v2] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
Message-ID: <YapRL+2gQBjNyK4p@robh.at.kernel.org>
References: <20211201114102.13446-1-maz@kernel.org>
 <CAMuHMdXM34nNz1nfowNqDvdsdg+d69Bo3_ufs6fbcq65iYd5-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXM34nNz1nfowNqDvdsdg+d69Bo3_ufs6fbcq65iYd5-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:06:21PM +0100, Geert Uytterhoeven wrote:
> Hi Marc,
> 
> On Wed, Dec 1, 2021 at 12:41 PM Marc Zyngier <maz@kernel.org> wrote:
> > Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
> > to an interrupt controller"), a handful of interrupt controllers have
> > stopped working correctly. This is due to the DT exposing a non-sensical
> > interrupt-map property, and their drivers relying on the kernel ignoring
> > this property.
> >
> > Since we cannot realistically fix this terrible behaviour, add a quirk
> > for the limited set of devices that have implemented this monster,
> > and document that this is a pretty bad practice.
> >
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: John Crispin <john@phrozen.org>
> > Cc: Biwen Li <biwen.li@nxp.com>
> > Cc: Chris Brandt <chris.brandt@renesas.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Sander Vanheule <sander@svanheule.net>
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >
> > Notes:
> >     v2: Switched over to of_device_compatible_match() as per Rob's
> >         request.
> 
> Thanks for the update!
> 
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> 
> > @@ -159,12 +179,16 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
> >                 /*
> >                  * Now check if cursor is an interrupt-controller and
> >                  * if it is then we are done, unless there is an
> > -                * interrupt-map which takes precedence.
> > +                * interrupt-map which takes precedence if we're not
> > +                * in presence of once of these broken platform that
> 
> one

and 'platforms'. Will fixup.

> 
> > +                * want to parse interrupt-map themselves for $reason.
> >                  */
> >                 bool intc = of_property_read_bool(ipar, "interrupt-controller");
> > +               bool imap_abuse;
> >
> >                 imap = of_get_property(ipar, "interrupt-map", &imaplen);
> > -               if (imap == NULL && intc) {
> > +               imap_abuse = imap && of_device_compatible_match(ipar, of_irq_imap_abusers);
> 
> ... = intc && imap && of_device_compatible_match(...)

Why? Then we are comparing intc twice because we still need it for the 
intc && !imap case.
> 
> > +               if (intc && (imap == NULL || imap_abuse)) {
> >                         pr_debug(" -> got it !\n");
> >                         return 0;
> >                 }
> 
> Still working fine on RZ/A1, so
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
