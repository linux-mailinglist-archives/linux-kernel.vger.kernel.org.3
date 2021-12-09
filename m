Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C8146E7A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbhLILic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbhLILib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:38:31 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5964FC0617A2;
        Thu,  9 Dec 2021 03:34:58 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so12893089ybg.9;
        Thu, 09 Dec 2021 03:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Qzm7wYG9ZciI4zZVR/FeupzR+998EmmJYs04gZjZoA=;
        b=CjvzscSz4UDWQXqAb2EwgOt+lcqBkKYW1sQMhhKk/xc4wCOECW3En24eLcHcDmS2Yv
         U8KbHS8OWR3lWskB92QsZ1kwGmfBh5vEuCcXlO/1g4ilxsAaDFrTz7FBc9nQL6q6+B9m
         cPFRDd5Dv1J/Zogu+hXt9Ci4iC46I/WXRapmJ///L6V971L6bSIrcR+SMfTWghv7kMQ7
         PO2QMKNlb2pckomCNtDApJcy7KvLLQq5rcHQzU/jyBiEMh7PKNC4gl+Pb3zhg3aMUizz
         eznyf418d/pOEFvsf637sOr9rnRJvxcyT9terPGlRK9EFsewbu12yI547zwW6IIEyUAE
         tvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Qzm7wYG9ZciI4zZVR/FeupzR+998EmmJYs04gZjZoA=;
        b=cm59UFDpiHyKU1NcOamEaoKQC1FS0bCx+yI/SLcsrIL5xGPcpf4VDAHrY5yzxq2JBd
         2YCfuj9bOjPPOwJlqwTU2uvn5pv5SdayhzXEPiOtS9BodzkCwyTUe9e0MOlPEtERYok/
         q8Gjn/M/I/K2c/UcrztMFCAxmBTrtvFEXeCQOC9lkbz90+Y1FZyO2pYYqadsYDyJKeah
         Y5xlzkbjawMBF2LeVnuHX00+hMZ4R31VfaaNVj2yzYLHtQvc92oBQj+IGWn5PTx8dGM+
         Avt2YVODrK20BfW4ZsD9P0kIHtw26io1NqEESfT+qGMZ7yYJTUZGdV9n1kICTCQhvqJV
         wM9g==
X-Gm-Message-State: AOAM532MGjjrwU9ZBfw3WCJ1wDnBszkBQDU4+c0E70VQ2sqhoRuNnUs8
        kugkuASBzYHcgWKoQcz8x5PdJqreXRnwNjKnGE0=
X-Google-Smtp-Source: ABdhPJxYGi4Nwb7BPYFDpZXxFLOTJ2Dp1KV+llUINC4s9jk+k/qQIwHYsWiQVwivyTumCfgyYN4XTEtES/E+I1HAr9o=
X-Received: by 2002:a25:348b:: with SMTP id b133mr5360337yba.251.1639049697530;
 Thu, 09 Dec 2021 03:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <d290850bf95f4bdf0c329f278db458c7@kernel.org> <CA+V-a8vUCXQa38NmYu9znakcq4A=Uedyn8w5+hXQ_WKf58oHRQ@mail.gmail.com>
 <875yry1316.wl-maz@kernel.org>
In-Reply-To: <875yry1316.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 9 Dec 2021 11:34:31 +0000
Message-ID: <CA+V-a8vNUhVBFNf-M6s1BmXbdCpdyJOx2g=t=QJf1jQzUA3xow@mail.gmail.com>
Subject: Re: [RFC PATCH] of: platform: Skip mapping of interrupts in of_device_alloc()
To:     Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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

Hi Rob and Marc,

On Thu, Dec 9, 2021 at 10:33 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 09 Dec 2021 10:00:44 +0000,
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> >
> > > The root of the issue is that all the resource allocation is done
> > > upfront, way before we even have a driver that could potentially
> > > deal with this device. This is a potential waste of resource, and
> > > it triggers the issue you noticed.
> > >
> > > If you delay the resource allocation until there is an actual
> > > match with a driver, you could have a per-driver flag telling you
> > > whether the IRQ allocation should be performed before the probe()
> > > function is called.
> > >
> > As suggested by Rob, if we switch the drivers to use
> > platform_get_resource(pdev, IORESOURCE_IRQ, n) call with
> > platform_get_irq() this code should go away and with this switch the
> > resource allocation will happen demand. Is this approach OK?
>
> If you get rid of of_irq_to_resource_table() altogether, then yes,
> this has a fighting chance to work.
>
Yes, switching to platform_get_irq() will eventually cause
of_irq_to_resource_table() to go away.

On second thought, instead of touching all the drivers, if we update
platform_get_resource/platform_get_resource_byname to internally call
platform_get_irq() internally if it's a IORESOURCE_IRQ resource. Does
that sound good or should I just get on changing all the drivers to
use platform_get_irq() instead?

Cheers,
Prabhakar

>         M.
>
>
> --
> Without deviation from the norm, progress is not possible.
