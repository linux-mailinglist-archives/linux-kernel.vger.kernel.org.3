Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399F44624F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhK2Wd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhK2WdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:33:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09EAC143242;
        Mon, 29 Nov 2021 10:33:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3A43ACE16B8;
        Mon, 29 Nov 2021 18:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E27BC53FCD;
        Mon, 29 Nov 2021 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638210793;
        bh=NiqtQJK2sHeX2lVt677tbzluqXmsp5H2HGPufVwCMc8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hkm0J5Ph16y30WP4a1mX9EuPTdjSmUXqlqekf7IBvZbKcJfKHsINGdBr6OjmhtFfi
         dZ/IHyY/mzYuaQdfL30uV8tJFiastI6rTknXCtBAP1/Q6DVDFYn/GgiSPBD/f8WjdR
         GwAUBUMcxzcG6W5CnGOsvrVVinxngbHJV4wj92IAB/6kGdovFDweGZ7NBaoPJW7W6X
         idamoPI/3N+QMn/h5oU+jf2NbNxl5G16Zr9+K2kpGWzyWp4lGE1SsgTsB4WyKmN46A
         MMZ/Z+Z0YPBsk9RkbVMc6c2U/zBmhGQdEJ5vkXZhKjnJR529Nv5C84qrbPCZ5nJzBM
         UbOo5+MeO6HpQ==
Received: by mail-ed1-f48.google.com with SMTP id y12so75810077eda.12;
        Mon, 29 Nov 2021 10:33:13 -0800 (PST)
X-Gm-Message-State: AOAM531AXYYCIdr3tTxNg/KCnE1cJfxkd8NvfJ96QFMgb8z+R+HLskJQ
        bCcMXyn9+VelUsWLVJjjzgBL6Nsa/+QHQMMDRw==
X-Google-Smtp-Source: ABdhPJwUZPHj6f/VpSA6KGNJB42uc5qu2+wTI2KYNSGCauPuJWl7D7Y4gH5mfRFT0MXZ7P55yltJvJRhp617QgYXvsQ=
X-Received: by 2002:aa7:dc07:: with SMTP id b7mr75860840edu.327.1638210791676;
 Mon, 29 Nov 2021 10:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20211122103032.517923-1-maz@kernel.org> <CAMuHMdX2ZRvDYA3idmw3nBcP6CO=2od6ZU-UeJo9vYsuB=fQNQ@mail.gmail.com>
 <8735no70tt.wl-maz@kernel.org> <CAMuHMdVS67BLP2XEdD6ZvVBVE2x11gKnQa1TqG659HXPM5scqQ@mail.gmail.com>
 <CAMuHMdWJhnXabKGpW7k944dzQHtwQtxw-yb2bRBsoaMw6N6nuA@mail.gmail.com>
 <87tug3clvc.wl-maz@kernel.org> <CAMuHMdWGb2xik+94RVwtq8E6+9eN=HfQLX3a4sTjKQXR96Udkw@mail.gmail.com>
 <87r1b7ck40.wl-maz@kernel.org> <OSZPR01MB7019E7DD7119EFF9C994AA62AA649@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <87tufvmes9.wl-maz@kernel.org> <CA+V-a8siHRjF+bJu88QFwz0a_MZ+kiJEwmER58_feyr8O+WNGA@mail.gmail.com>
In-Reply-To: <CA+V-a8siHRjF+bJu88QFwz0a_MZ+kiJEwmER58_feyr8O+WNGA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Nov 2021 12:33:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+GcnChx3i9fsYnw+FzZgON4PtKB=CzYLUj6sXtxX6fQ@mail.gmail.com>
Message-ID: <CAL_JsqK+GcnChx3i9fsYnw+FzZgON4PtKB=CzYLUj6sXtxX6fQ@mail.gmail.com>
Subject: Re: [PATCH] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        John Crispin <john@phrozen.org>, Biwen Li <biwen.li@nxp.com>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 6:13 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>

I timed my vacation well...

> On Mon, Nov 29, 2021 at 10:34 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Sat, 27 Nov 2021 00:42:49 +0000,
> > Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > >
> > > Hi Marc,
> > >
> > > > -----Original Message-----
> > > > From: Marc Zyngier <maz@kernel.org>
> > > > Sent: 23 November 2021 09:11
> > > > To: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; kernel-team@android.com; Rob Herring
> > > > <robh@kernel.org>; John Crispin <john@phrozen.org>; Biwen Li <biwen.li@nxp.com>; Chris Brandt
> > > > <Chris.Brandt@renesas.com>; linux-renesas-soc@vger.kernel.org; Prabhakar Mahadev Lad
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > Subject: Re: [PATCH] of/irq: Add a quirk for controllers with their own definition of interrupt-map
> > > >
> > > > On Tue, 23 Nov 2021 08:44:19 +0000,
> > > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > >
> > > > > Hi Marc,
> > > > >
> > > > > On Tue, Nov 23, 2021 at 9:33 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > > > On Tue, 23 Nov 2021 07:57:48 +0000,
> > > > > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > Summarized:
> > > > > > >   - Before the bad commit, and after your fix, irqc-rza1 is invoked,
> > > > > > >     and the number of interrupts seen is correct, but input events
> > > > > > >     are doubled.
> > > > > > >   - After the bad commit, irqc-rza1 is not invoked, and there is an
> > > > > > >     interrupt storm, but input events are OK.
> > > > > >
> > > > > > OK, that's reassuring, even if the "twice the events" stuff isn't
> > > > > > what you'd expect. We at least know this is a separate issue, and
> > > > > > that this patch on top of -rc1 brings you back to the 5.15 behaviour.
> > > > > >
> > > > > > I'd expect it to be the case for the other platforms as well.
> > > > >
> > > > > OK.
> > > > >
> > > > > BTW, what would have been the correct way to do this for irqc-rza1?
> > > > > I think we're about to make the same mistake with RZ/G2L IRQC
> > > > > support[1]?
> > > >
> > > > Indeed, and I was about to look into it.
> > > >
> > > > There are multiple ways to skin this cat, including renaming 'interrupt-map' to 'my-own-private-
> > > > interrupt-map'. Or use something akin the new 'msi-range' (which we could call interrupt-range), and
> > > > replace:
> > > >
> > > >   interrupt-map = <0 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> > > >                   <1 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> > > >                   <2 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> > > >                   <3 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > > >                   <4 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> > > >                   <5 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> > > >                   <6 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > > >                   <7 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > > >
> > > > with:
> > > >
> > > >   interrupt-range = <&gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH 0 8>;

interrupts would work just fine here:

interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
  <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
  <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
  <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
  <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
  <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
  <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
  <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;

We don't need a different solution for N:1 interrupts from N:M. Sure,
that could become unweldy if there are a lot of interrupts (just like
interrupt-map), but is that an immediate problem?

> > > >
> > > Just to clarify, do you suggest to add interrupt-range as a generic
> > > DT property or SoC/company specific property?
> >
> > As a generic one. I have no interest in SoC-specific stuff (though you
> > are free to invent your own and run it by Rob).
> >
> OK will go with a generic one.
>
> > > If you meant to add generic property where would you suggest to
> > > document this property?
> >
> > Ideally collocated with the rest of the interrupt properties.
> >
> OK, I will go with interrupts.txt for now. Is that OK with you Rob?

Nope. As the rest of interrupts are documented in DT Spec it goes
there and there needs to be a schema (in dtschema).

> (the reason I ask because interrupt-map/mask haven't been documented).

Yes, they are. Only for the last 20+ years.

Rob
