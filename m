Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5317E4620C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377099AbhK2TqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:46:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56208 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345064AbhK2Tn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:43:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F236B815C5;
        Mon, 29 Nov 2021 19:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D9AC53FD0;
        Mon, 29 Nov 2021 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638214836;
        bh=NkihkPIegrUEWF+ZbdPBuf/hxeJFBqSSQf4f4YN6dB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C6Uv0SoY4ngxYWW5ZmEFCALGn08SmJdiTpj7L/7VRvt/Sf1Y9d8UXJZu6pSllY7Ns
         s2D93wf84EnanXC3NT0Ur5cmTXvxfPKgx6yNiGjH4+h2lDHttm6X1/D3ecUzQ8E3zN
         AzaPdoQbntxgvLLRP/u3ljjPWYX3QTW7ZqcHX8q34CN4dVoPm5PXlMmxmBJPUwLllX
         abAdpz1rg7OggRP+/nkv/24T5z1s9YAfUtkFI8JqUW4VmDiGTAWVbalztycgEjyL7p
         JeHYENz8qoHT+hxQ5peEOB3urKWmNA6pVlk9IgiIT3zmsq+c3CK94PUx5ERx32M4I8
         uFJY8dCed0OfA==
Received: by mail-ed1-f42.google.com with SMTP id e3so76685722edu.4;
        Mon, 29 Nov 2021 11:40:35 -0800 (PST)
X-Gm-Message-State: AOAM5328RACv+TGPolx6YI+cFB0zQbYZpC8YgQAXIlGFyEhssuQ5Wn7r
        VD2mkyRP1GKJeSV9mb2Qzv+hFZciXDnNLpbdZg==
X-Google-Smtp-Source: ABdhPJyJChI13L+H74QasKNfqT/PiSewHhcNn29JL6NIkfXCK2rWsnAApBNUygSwwybOqOUX8cC1qt+nSqf4xwSvbbs=
X-Received: by 2002:a17:907:7f25:: with SMTP id qf37mr62164257ejc.147.1638214834013;
 Mon, 29 Nov 2021 11:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20211122103032.517923-1-maz@kernel.org> <CAL_Jsq+kLK-277FOSvOCVDdw8_j-6xL-SnHs15Zj4MddsxZqNw@mail.gmail.com>
 <87mtlmn4gk.wl-maz@kernel.org>
In-Reply-To: <87mtlmn4gk.wl-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Nov 2021 13:40:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJLzwM-k+h3-DpQ5soOU9Anj3C-itnRFU13-TtCvjpn1g@mail.gmail.com>
Message-ID: <CAL_JsqJLzwM-k+h3-DpQ5soOU9Anj3C-itnRFU13-TtCvjpn1g@mail.gmail.com>
Subject: Re: [PATCH] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
To:     Marc Zyngier <maz@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>,
        John Crispin <john@phrozen.org>, Biwen Li <biwen.li@nxp.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 1:31 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 29 Nov 2021 19:15:27 +0000,
> Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Nov 22, 2021 at 4:30 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
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
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  drivers/of/irq.c | 37 +++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 35 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > > index b10f015b2e37..27a5173c813c 100644
> > > --- a/drivers/of/irq.c
> > > +++ b/drivers/of/irq.c
> > > @@ -76,6 +76,36 @@ struct device_node *of_irq_find_parent(struct device_node *child)
> > >  }
> > >  EXPORT_SYMBOL_GPL(of_irq_find_parent);
> > >
> > > +/*
> > > + * These interrupt controllers abuse interrupt-map for unspeakable
> > > + * reasons and rely on the core code to *ignore* it (the drivers do
> > > + * their own parsing of the property).
> > > + *
> > > + * If you think of adding to the list for something *new*, think
> > > + * again. There is a high chance that you will be sent back to the
> > > + * drawing board.
> > > + */
> > > +static const char * const of_irq_imap_abusers[] = {
> > > +       "CBEA,platform-spider-pic",
> > > +       "sti,platform-spider-pic",
> > > +       "realtek,rtl-intc",
> > > +       "fsl,ls1021a-extirq",
> > > +       "fsl,ls1043a-extirq",
> > > +       "fsl,ls1088a-extirq",
> > > +       "renesas,rza1-irqc",
> > > +};
> >
> > I guess this list was obtained by with a: git grep '"interrupt-map"'
>
> Yes. Anyone having its own interrupt-map parser is likely to have the
> same problem.
>
> > I suppose that should be sufficient to find all the cases. I'd like to
> > be able to identify this case just from a DT file, but it's not really
> > clear
>
> Indeed. Not to mention that the PPC stuff doesn't has its DT hidden in
> some firmware.
>
> > Perhaps a simpler solution to all this is only handle interrupt-map
> > with interrupt-controller if it points to its own node. That works for
> > Apple and I don't see a need beyond that case.
>
> The problem is that interrupt-map can point to more than a single
> controller. What if the map points to a both a local interrupt and a a
> remote one?

Seems like a theoretical problem...

> It feels weird to standardise on a behaviour that seems to contradict
> the spec and to single out the one that (IMO) matches the expected
> behaviour. At the end of the day, I'll implement whichever solution
> you prefer.

Let's keep the public shaming list I guess. If it grows I may change my mind...

> > > +static bool of_irq_abuses_interrupt_map(struct device_node *np)
> > > +{
> > > +       int i;
> > > +
> > > +       for (i = 0; i < ARRAY_SIZE(of_irq_imap_abusers); i++)
> > > +               if (of_device_is_compatible(np, of_irq_imap_abusers[i]))
> > > +                       return true;
> > > +
> > > +       return false;
> >
> > With a NULL terminated list, you can use of_device_compatible_match() instead .
>
> Ah, neat.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
