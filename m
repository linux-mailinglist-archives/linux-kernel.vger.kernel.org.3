Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7E24616A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349590AbhK2Nid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhK2Ng3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:29 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDA9C09B115;
        Mon, 29 Nov 2021 04:13:48 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id e136so41552316ybc.4;
        Mon, 29 Nov 2021 04:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvWgEEmp4P0Dmru5AcXSwTmy3R2DbgQle1dL6KFUV5Q=;
        b=mheknQwzJETTESRyXle/GMJBlalpNtrfwg/kBAz+TsIO3u8AFuxRSgMSCzSZCOiB+X
         8ItucEPwG6AFQvyz6kswJVpMghQUGnPY39IkeD6YQTiFRp67gU4fkRo2fSTpESnyv8Sl
         +HQ54IBVWLctIAdpc1QazKO5mCTixeHcvvOsw2qYP8xwyxt+8y9u7xPwFFPv5dh1/MVp
         hucadXNx3/eXiMomO3xbEGc+icVZcdXemfSsb7fbmIZPYj4AxNxXztjV7srW0jJqyTGd
         ZFlXK6fLpljlrGkRqMM1CroQvu7t1kV93H0hk+JkPAbX+R44b3u0dzwBKo7W7yH6w+oy
         ivAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvWgEEmp4P0Dmru5AcXSwTmy3R2DbgQle1dL6KFUV5Q=;
        b=CJxYKKjNRNW3Ej3UUD0S6C2ebUxG5iz42Nq0kmHwRN8HxDmWoqDqjif5uvuPmdMSi1
         8UwC9psqqkBgceLU8cEUZVrqwfcfQuhqqb9KBrVJlLobJoqku7jdcQGC+2ljWIfEJ+ky
         tv1EnRnCUdDt3U7rwEUNFGjXoq36biclrbKHcPou3/vF0uz8YB7/7nZhL3IXwAg8EiFA
         iTn2zmwxnOuwPrynzBY5eeknX0YtCRG8FPe+2quPTGTXokoQi0A0MV7PPi9npa0IPGsG
         /S0411bwzgc723RLX8rORQdXoChYEfeTvZaSJfz1gecu69210MSGYfUmoXMWiD/0dC4e
         cJCQ==
X-Gm-Message-State: AOAM533a8xDLiC29jwUZYwPNFJdHNXWEUkwHXoQ8Ucy11lZz+Nzma+G2
        0wWcVo3TLgGL8/3kVb78tE9ZObOFZAcwSYfVIVE=
X-Google-Smtp-Source: ABdhPJyW8I0OsQuEsS+iKk63xokUZyRnOL5btP3ZmO51jdgo/krQaQVmuV2borBUdhceQ8WtnHuzSADL2Orr0bxc/YA=
X-Received: by 2002:a25:abe3:: with SMTP id v90mr34471368ybi.315.1638188027913;
 Mon, 29 Nov 2021 04:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20211122103032.517923-1-maz@kernel.org> <CAMuHMdX2ZRvDYA3idmw3nBcP6CO=2od6ZU-UeJo9vYsuB=fQNQ@mail.gmail.com>
 <8735no70tt.wl-maz@kernel.org> <CAMuHMdVS67BLP2XEdD6ZvVBVE2x11gKnQa1TqG659HXPM5scqQ@mail.gmail.com>
 <CAMuHMdWJhnXabKGpW7k944dzQHtwQtxw-yb2bRBsoaMw6N6nuA@mail.gmail.com>
 <87tug3clvc.wl-maz@kernel.org> <CAMuHMdWGb2xik+94RVwtq8E6+9eN=HfQLX3a4sTjKQXR96Udkw@mail.gmail.com>
 <87r1b7ck40.wl-maz@kernel.org> <OSZPR01MB7019E7DD7119EFF9C994AA62AA649@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <87tufvmes9.wl-maz@kernel.org>
In-Reply-To: <87tufvmes9.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 29 Nov 2021 12:13:22 +0000
Message-ID: <CA+V-a8siHRjF+bJu88QFwz0a_MZ+kiJEwmER58_feyr8O+WNGA@mail.gmail.com>
Subject: Re: [PATCH] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>
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

On Mon, Nov 29, 2021 at 10:34 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 27 Nov 2021 00:42:49 +0000,
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Hi Marc,
> >
> > > -----Original Message-----
> > > From: Marc Zyngier <maz@kernel.org>
> > > Sent: 23 November 2021 09:11
> > > To: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; kernel-team@android.com; Rob Herring
> > > <robh@kernel.org>; John Crispin <john@phrozen.org>; Biwen Li <biwen.li@nxp.com>; Chris Brandt
> > > <Chris.Brandt@renesas.com>; linux-renesas-soc@vger.kernel.org; Prabhakar Mahadev Lad
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Subject: Re: [PATCH] of/irq: Add a quirk for controllers with their own definition of interrupt-map
> > >
> > > On Tue, 23 Nov 2021 08:44:19 +0000,
> > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > >
> > > > Hi Marc,
> > > >
> > > > On Tue, Nov 23, 2021 at 9:33 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > > On Tue, 23 Nov 2021 07:57:48 +0000,
> > > > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > Summarized:
> > > > > >   - Before the bad commit, and after your fix, irqc-rza1 is invoked,
> > > > > >     and the number of interrupts seen is correct, but input events
> > > > > >     are doubled.
> > > > > >   - After the bad commit, irqc-rza1 is not invoked, and there is an
> > > > > >     interrupt storm, but input events are OK.
> > > > >
> > > > > OK, that's reassuring, even if the "twice the events" stuff isn't
> > > > > what you'd expect. We at least know this is a separate issue, and
> > > > > that this patch on top of -rc1 brings you back to the 5.15 behaviour.
> > > > >
> > > > > I'd expect it to be the case for the other platforms as well.
> > > >
> > > > OK.
> > > >
> > > > BTW, what would have been the correct way to do this for irqc-rza1?
> > > > I think we're about to make the same mistake with RZ/G2L IRQC
> > > > support[1]?
> > >
> > > Indeed, and I was about to look into it.
> > >
> > > There are multiple ways to skin this cat, including renaming 'interrupt-map' to 'my-own-private-
> > > interrupt-map'. Or use something akin the new 'msi-range' (which we could call interrupt-range), and
> > > replace:
> > >
> > >   interrupt-map = <0 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> > >                   <1 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> > >                   <2 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> > >                   <3 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > >                   <4 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> > >                   <5 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> > >                   <6 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > >                   <7 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > >
> > > with:
> > >
> > >   interrupt-range = <&gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH 0 8>;
> > >
> > Just to clarify, do you suggest to add interrupt-range as a generic
> > DT property or SoC/company specific property?
>
> As a generic one. I have no interest in SoC-specific stuff (though you
> are free to invent your own and run it by Rob).
>
OK will go with a generic one.

> > If you meant to add generic property where would you suggest to
> > document this property?
>
> Ideally collocated with the rest of the interrupt properties.
>
OK, I will go with interrupts.txt for now. Is that OK with you Rob?
(the reason I ask because interrupt-map/mask haven't been documented).

Cheers,
Prabhakar

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
