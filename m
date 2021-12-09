Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E423346F504
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhLIUi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:38:29 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:33836 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhLIUi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:38:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D600FCE25DC;
        Thu,  9 Dec 2021 20:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0671FC341C7;
        Thu,  9 Dec 2021 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639082092;
        bh=8OIODPu60ojwJLuPAooGJ33W0G3lVL6ddOC3nAtXdcY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=anYTLate8ia7xVbzhhv7Gb24kTiUz12Mzmz/6Y1GG5G5AfbaVXVTCPiVN7s6bRhLM
         MaWuyF2HWmYX86sMVu1brYdp2PWaKC4w4kQQGDX7nJfmJAWiVdjq/fbRIbNUp0KWEw
         S3JAttR17lxhr+ckMTLScuGIEalH98V1XM6gsGuEkad4GuuxXFngl7GKJlbds4xaGj
         u6fM2PHjp4RHypTKaQRZmjXpMHr8lBWiHx5lv1/QaW4YFEAtfQ9HH4LBxxpkos2TwG
         o0Gb1ehjjDDSYf/ZBoS3KoJ5xZ8as/G2Q1gbQndz0rCCXmHXqTy7wTR6J6fgLtJ3dd
         aFcxCF4Um9i9A==
Received: by mail-ed1-f52.google.com with SMTP id x10so6143339edd.5;
        Thu, 09 Dec 2021 12:34:51 -0800 (PST)
X-Gm-Message-State: AOAM531X9tBcs2r80JgrmGksHXJruCfPW9spL6vE8LDHN8Zb6yhj2JUu
        K0R71SZ4A1leRXLesPagOAbsz+ZnDZzpFDqmGQ==
X-Google-Smtp-Source: ABdhPJxabk3IUkwoF8SyW/p7rw1cBHsKcMY0eJTM6vMEIFjCFicfsbuIVXNI72XoPrtQ3AEtms/uq8ddZt7bcqMYUaI=
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr31830041edx.306.1639082090290;
 Thu, 09 Dec 2021 12:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <d290850bf95f4bdf0c329f278db458c7@kernel.org> <CA+V-a8vUCXQa38NmYu9znakcq4A=Uedyn8w5+hXQ_WKf58oHRQ@mail.gmail.com>
 <875yry1316.wl-maz@kernel.org> <CA+V-a8vNUhVBFNf-M6s1BmXbdCpdyJOx2g=t=QJf1jQzUA3xow@mail.gmail.com>
In-Reply-To: <CA+V-a8vNUhVBFNf-M6s1BmXbdCpdyJOx2g=t=QJf1jQzUA3xow@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 9 Dec 2021 14:34:38 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+H54oX8GCHcwPVaUC3brjJa+5+OTU21D-3d7QUqM+jcg@mail.gmail.com>
Message-ID: <CAL_Jsq+H54oX8GCHcwPVaUC3brjJa+5+OTU21D-3d7QUqM+jcg@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 5:35 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Rob and Marc,
>
> On Thu, Dec 9, 2021 at 10:33 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Thu, 09 Dec 2021 10:00:44 +0000,
> > "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> > >
> > > > The root of the issue is that all the resource allocation is done
> > > > upfront, way before we even have a driver that could potentially
> > > > deal with this device. This is a potential waste of resource, and
> > > > it triggers the issue you noticed.
> > > >
> > > > If you delay the resource allocation until there is an actual
> > > > match with a driver, you could have a per-driver flag telling you
> > > > whether the IRQ allocation should be performed before the probe()
> > > > function is called.
> > > >
> > > As suggested by Rob, if we switch the drivers to use
> > > platform_get_resource(pdev, IORESOURCE_IRQ, n) call with
> > > platform_get_irq() this code should go away and with this switch the
> > > resource allocation will happen demand. Is this approach OK?
> >
> > If you get rid of of_irq_to_resource_table() altogether, then yes,
> > this has a fighting chance to work.
> >
> Yes, switching to platform_get_irq() will eventually cause
> of_irq_to_resource_table() to go away.
>
> On second thought, instead of touching all the drivers, if we update
> platform_get_resource/platform_get_resource_byname to internally call
> platform_get_irq() internally if it's a IORESOURCE_IRQ resource. Does
> that sound good or should I just get on changing all the drivers to
> use platform_get_irq() instead?

Except that platform_get_irq() already internally calls
platform_get_resource()... I think changing the drivers is the right
way. Happy to do some if you want to divide it up.

Using coccigrep, I think I've found all the places using
platform_device.resource directly. A large swath are Sparc drivers
which don't matter. The few that do matter I've prepared patches for
here[1]. Most of what I found were DT based drivers that copy
resources to a child platform device. That case will not work with
platform_get_irq() callers either unless the child device has it's DT
node set to the parent node which is the change I made.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-kernelci
