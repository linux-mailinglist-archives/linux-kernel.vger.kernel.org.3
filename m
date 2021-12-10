Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F5247029F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbhLJOXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:23:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43002 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhLJOXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:23:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCE1FB8281A;
        Fri, 10 Dec 2021 14:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A69CC00446;
        Fri, 10 Dec 2021 14:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639146015;
        bh=OfD1bwhUCRhdGG4qwjkqG1Z4nuGfYEuNGjW+M53Aq2o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S87YIK4gn3loT9LgN9GoEZnbH/gV2l5Nno7kMs3MSMcjvlMqe0BjqQsgP7cjA1mwQ
         CU7AY4EUd5DEwfVITdXZNE0/UfWFulNhbfR7QQhrsKJxaob3DXOpDAOY+F5tCyVo1z
         6PrlrL0jH+TCN+ElrokfPrkbbUbCYKy35HOaBHZC4hDbXg2bfQfItsmQboJ4W1vF+a
         5gbn53DVQvKeyJF26U0C2IDGHAUPbQ45iWBLc2BNYeX5w0a+JUblwOL3VgA1gVaPjb
         fBZ/r5+dsAVXqX2+XCkcAJpRNcRXdNjxNiV1T0c8aE+wzhWQ9mHZTVRhBdTupRaZEA
         cPJpuZuvJ3lQA==
Received: by mail-ed1-f50.google.com with SMTP id r11so29953103edd.9;
        Fri, 10 Dec 2021 06:20:15 -0800 (PST)
X-Gm-Message-State: AOAM532tyZvNl4H6Uz61O4JK4+AA/aoYtW08+1bKTsQp417lr0BwBjxB
        7j78NSDFHACX6o1Z0Cm0WvEZPro6utlUNUWZZw==
X-Google-Smtp-Source: ABdhPJwlX3Y0JajtJITVeG8yQcVy5/Ih1tDAFptuNFnlrG9NxFmfWWCyqf8KrMFgKkEjVaCJ4q9nYjRbaJZ+3MIn8uE=
X-Received: by 2002:a17:906:fcbb:: with SMTP id qw27mr23796249ejb.320.1639146010345;
 Fri, 10 Dec 2021 06:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <d290850bf95f4bdf0c329f278db458c7@kernel.org> <CA+V-a8vUCXQa38NmYu9znakcq4A=Uedyn8w5+hXQ_WKf58oHRQ@mail.gmail.com>
 <875yry1316.wl-maz@kernel.org> <CA+V-a8vNUhVBFNf-M6s1BmXbdCpdyJOx2g=t=QJf1jQzUA3xow@mail.gmail.com>
 <CAL_Jsq+H54oX8GCHcwPVaUC3brjJa+5+OTU21D-3d7QUqM+jcg@mail.gmail.com> <CA+V-a8sifb8zpMB=VwBn6qXob=3JRQdMTh1PWD-M7SquP9S9+g@mail.gmail.com>
In-Reply-To: <CA+V-a8sifb8zpMB=VwBn6qXob=3JRQdMTh1PWD-M7SquP9S9+g@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 10 Dec 2021 08:19:58 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+jyqbhA1jpgZ+yTwWGvCMRu9VmgoDq8MDM9SMqJ-XSBw@mail.gmail.com>
Message-ID: <CAL_Jsq+jyqbhA1jpgZ+yTwWGvCMRu9VmgoDq8MDM9SMqJ-XSBw@mail.gmail.com>
Subject: Re: [RFC PATCH] of: platform: Skip mapping of interrupts in of_device_alloc()
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 7:16 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> On Thu, Dec 9, 2021 at 8:34 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Thu, Dec 9, 2021 at 5:35 AM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > >
> > > Hi Rob and Marc,
> > >
> > > On Thu, Dec 9, 2021 at 10:33 AM Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > On Thu, 09 Dec 2021 10:00:44 +0000,
> > > > "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> > > > >
> > > > > > The root of the issue is that all the resource allocation is done
> > > > > > upfront, way before we even have a driver that could potentially
> > > > > > deal with this device. This is a potential waste of resource, and
> > > > > > it triggers the issue you noticed.
> > > > > >
> > > > > > If you delay the resource allocation until there is an actual
> > > > > > match with a driver, you could have a per-driver flag telling you
> > > > > > whether the IRQ allocation should be performed before the probe()
> > > > > > function is called.
> > > > > >
> > > > > As suggested by Rob, if we switch the drivers to use
> > > > > platform_get_resource(pdev, IORESOURCE_IRQ, n) call with
> > > > > platform_get_irq() this code should go away and with this switch the
> > > > > resource allocation will happen demand. Is this approach OK?
> > > >
> > > > If you get rid of of_irq_to_resource_table() altogether, then yes,
> > > > this has a fighting chance to work.
> > > >
> > > Yes, switching to platform_get_irq() will eventually cause
> > > of_irq_to_resource_table() to go away.
> > >
> > > On second thought, instead of touching all the drivers, if we update
> > > platform_get_resource/platform_get_resource_byname to internally call
> > > platform_get_irq() internally if it's a IORESOURCE_IRQ resource. Does
> > > that sound good or should I just get on changing all the drivers to
> > > use platform_get_irq() instead?
> >
> > Except that platform_get_irq() already internally calls
> > platform_get_resource()... I think changing the drivers is the right
> > way. Happy to do some if you want to divide it up.
> >
> Thank you, I think I'll manage.
>
> > Using coccigrep, I think I've found all the places using
> > platform_device.resource directly. A large swath are Sparc drivers
> > which don't matter. The few that do matter I've prepared patches for
> > here[1]. Most of what I found were DT based drivers that copy
> > resources to a child platform device. That case will not work with
> > platform_get_irq() callers either unless the child device has it's DT
> > node set to the parent node which is the change I made.
> >
> Thank you for getting this done. Do you want me to include those along
> with my conversion patches?

No, I'll send them out.

> Any reason why we dont care for Sparc drivers?

Sparc does its own thing and doesn't use drivers/of/platform.c to
create devices. I'm sure we could modernize a bunch of them, but
that's not a blocker.

Rob
