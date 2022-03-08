Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10E54D0D91
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbiCHBhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbiCHBhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:37:51 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C82F001
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:36:55 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id f23so7325913uam.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 17:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgpZa0cZflTnt72QAWQNhc3a+nrolIrcUDpXWM3FtTQ=;
        b=ToK0i6Ci5UXE334EI/74FHp31LrkJHHrlKsiEyKZreBORsqup2j4gTIaH8Rg1LUZ/s
         qwyEWk6fmVnEGv+OeZrsIBiJ9Ad2yRt4uE2z32DvlQsnerzNRVhnnhfp+bN4PI64j1dy
         OtLPzcazePJtnCdbnSOM3gk83JwHUcc2TanR2zPWZwIs5iJe15GNd5pHIwhWhreYnJQ9
         4MimznIMXck5G8nJNgYFm8fsQBiyJcaitvGayF/8DYarKcj77W1k3LRw1Kv2/T4JXsZj
         c7066LzTIC8z95FoXDh1Dr+BX93nKh1WVu2v5kMXMdlNeTkbjR35y5YXYw2HbREdM2Ei
         jKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgpZa0cZflTnt72QAWQNhc3a+nrolIrcUDpXWM3FtTQ=;
        b=jl3WLg8YTmCsn4dd48aHby2P5pYtWhSdKEGhfCOQ+TCcHGrxG8y81IRCPGqExHM6PU
         3hF45H6zUe6mtzgpSSE7b8JfTHyvV632S2rVU4kXuStaUh6kCus5qH3BazijGKjfLPA5
         eGXmsZRCIC6/b24lVQYCtmxfJJ6YcawxZWoSX6VaxsSn5suwDmS+6VTsoDqa+xqs2HMj
         PbOzoUd/Sb0xf5LA238F+gDSXrfGAK0/tpwIlDltpnLK59xPLie5JzqRd9I1MUit57Y7
         UmOz2eSy3yzTbSi3GMfaTotrVuHLywAEKCA2IQIkEbyEAf63ITjspPnPpsl1wRA5ooEZ
         4JQg==
X-Gm-Message-State: AOAM530ASavGO/7q9yBuHshXhQPPElS7DiGXZn8Mz7gZkGwMA1g2rCe/
        iq1U4qmqx/KnEkU5V+ifV0sZUxjQAoSpkCMA1woVQg==
X-Google-Smtp-Source: ABdhPJzH8ziPcKpXQxBuI4WzHA0+nIRBRTRxPHRDiIq9sLT+I7EQOcjGIMZ5FPM45OHOdGL0pUBPs62tJhBxUFgEp4k=
X-Received: by 2002:ab0:6011:0:b0:34b:bd7c:ecb9 with SMTP id
 j17-20020ab06011000000b0034bbd7cecb9mr3207684ual.83.1646703414684; Mon, 07
 Mar 2022 17:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20220304195238.1141725-1-decot+git@google.com> <87bkyktzeh.wl-maz@kernel.org>
In-Reply-To: <87bkyktzeh.wl-maz@kernel.org>
From:   David Decotigny <decot@google.com>
Date:   Mon, 7 Mar 2022 17:36:18 -0800
Message-ID: <CAG88wWYB_XEaqcMdDfDZuPwWi7wvW3ebrjT4nVuHV0EQbmJQCA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] irqchip/gic-v3-its: fixup IRQ affinities to
 account for online CPUs
To:     Marc Zyngier <maz@kernel.org>
Cc:     David Decotigny <decot+git@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--
David Decotigny -- Platforms, US SVL MAT3

On Sat, Mar 5, 2022 at 3:24 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 04 Mar 2022 19:52:38 +0000,
> David Decotigny <decot+git@google.com> wrote:
> >
> > From: David Decotigny <ddecotig@google.com>
> >
> > In some cases (eg. when booting with maxcpus=X), it is possible that
> > the preset IRQ affinity masks don't intersect with the set of online
> > CPUs. This patch extends the fallback strategy implemented when
> > IRQD_AFFINITY_MANAGED is not set to all cases. This is logged the
> > first time that happens.
> >
> > Fixes: c5d6082d35e0 ("irqchip/gic-v3-its: Balance initial LPI affinity across CPUs")
> >
>
> Missing SoB?
>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index cd772973114a..de862fd9ad73 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -1618,11 +1618,6 @@ static int its_select_cpu(struct irq_data *d,
> >               /* Try the intersection of the affinity and online masks */
> >               cpumask_and(tmpmask, aff_mask, cpu_online_mask);
> >
> > -             /* If that doesn't fly, the online mask is the last resort */
> > -             if (cpumask_empty(tmpmask))
> > -                     cpumask_copy(tmpmask, cpu_online_mask);
> > -
> > -             cpu = cpumask_pick_least_loaded(d, tmpmask);
> >       } else {
> >               cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
> >
> > @@ -1630,9 +1625,13 @@ static int its_select_cpu(struct irq_data *d,
> >               if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
> >                   node != NUMA_NO_NODE)
> >                       cpumask_and(tmpmask, tmpmask, cpumask_of_node(node));
> > -
> > -             cpu = cpumask_pick_least_loaded(d, tmpmask);
> >       }
> > +
> > +     /* If that doesn't fly, the online mask is the last resort */
> > +     if (WARN_ON_ONCE(cpumask_empty(tmpmask)))
> > +             cpumask_copy(tmpmask, cpu_online_mask);
> > +
> > +     cpu = cpumask_pick_least_loaded(d, tmpmask);
> >  out:
> >       free_cpumask_var(tmpmask);
> >
>
> Known issue, see [1] and [2].
>
> I don't think the above is the right approach. For managed interrupts,
> we shouldn't try and enable these interrupts until the CPUs are up,
> and activating them on *another* CPU breaks the abstraction entirely.
>
> The right way to do it would be to not activate them (marking them as
> shutdown) until the CPUs are up and running, similarly to what x86
> does (but we obviously can't reuse the matrix allocator for that).
> Looking into this is on my TODO list, just didn't get the time to work
> on it.

Indeed: thanks for
https://lore.kernel.org/lkml/20220307190625.254426-1-maz@kernel.org/ ,
worked for us !

... And then please ignore my patch.

>
>         M.
>
> [1] https://lore.kernel.org/r/78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com
> [2] https://lore.kernel.org/r/20220124073440.88598-1-wangxiongfeng2@huawei.com
>
> --
> Without deviation from the norm, progress is not possible.
