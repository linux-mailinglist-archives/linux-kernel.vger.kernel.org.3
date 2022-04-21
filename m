Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4337509E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388609AbiDULAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiDULA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:00:29 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A20F2A72A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:57:40 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id i20so8035352ybj.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WaU28uoBYkLX26Ko4EQyVaVQ6hf9KwSDqrKkB30ZWx0=;
        b=Vg7jjtzfb6/aWLtkbVfHT+Cqr+JwxIqpUzwqO3TTVFtIQVoKUh66fMs3/OPzbkVIdk
         BQ/+7v0w9BNBKE/cQBJMHPqfWYVH2/Xf1cCXIe6iulCFEJjzK4rkiVz0A+XioBOlqjjX
         evbszGZIYKm20kWQFDPT7En1alPeaajUxyfgJJ7ZzjvmUoJ5jCKZ8A2QKuIkNxZBrTtp
         NCePS+S2Se1lRXg6MIQWYqLqJKm2QMKUo9V1Sd14mmm/CLucfRM5uWWR2WbbcixAAt2w
         13G5+f28FmOzrh7/t+0I/U56foklWCzj0U5BJBVLchkf/GVrzwikiFZoijIdJRQnNf40
         vjOg==
X-Gm-Message-State: AOAM533WzhqSaWj2Ceoojmuno/ZU3Rtnp7OLwT7pneka3MYDBB1GWGbS
        XOnGqVsmFmtLtkwDbLYFw1/GkA8x12EPrmu97gybAtq42kU=
X-Google-Smtp-Source: ABdhPJz/XEH7QiNLiwzqXD8HBZ53MKUxByaoFTTi2ZRB+SyIfAkNJY69K2Rn0p0mGOi8QfvOxl1ZqMr0EV6nSuVwkpU=
X-Received: by 2002:a25:230d:0:b0:641:375c:b5ad with SMTP id
 j13-20020a25230d000000b00641375cb5admr23835503ybj.137.1650538659505; Thu, 21
 Apr 2022 03:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220420140521.45361-1-kernelfans@gmail.com> <20220420140521.45361-7-kernelfans@gmail.com>
 <CAJZ5v0h2SWN-=-5=OsMGm1amMJrYELqM6BC+J=98EAxSUmxMqg@mail.gmail.com> <YmDP93yLJw5gsjtQ@piliu.users.ipa.redhat.com>
In-Reply-To: <YmDP93yLJw5gsjtQ@piliu.users.ipa.redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Apr 2022 12:57:28 +0200
Message-ID: <CAJZ5v0g9DZax-U4WnVcUCc0zAD0uwZZ7E6wsGXmVCB6MeebWxw@mail.gmail.com>
Subject: Re: [PATCH 6/9] pm/irq: make for_each_irq_desc() safe of irq_desc release
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 5:31 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Wed, Apr 20, 2022 at 06:23:48PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Apr 20, 2022 at 4:06 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> > >
> > > The invloved context is no a RCU read section. Furthermore there may be
> > > more than one task at this point. Hence it demands a measure to prevent
> > > irq_desc from freeing. Use irq_lock_sparse to serve the protection
> > > purpose.
> >
> > Can you please describe an example scenario in which the added locking
> > will prevent a failure from occurring?
> >
>
> Sorry to forget mentioning that this is based on the code analysis.
>
> Suppose the following scenario:
> Two threads invloved
>   threadA "hibernate" runs suspend_device_irqs()
>   threadB "rcu_cpu_kthread" runs rcu_core()->rcu_do_batch(), which releases
>   object, let's say irq_desc
>
> Zoom in:
>   threadA                                               threadB
>   for_each_irq_desc(irq, desc) {
>       get irq_descA which is under freeing
>                                                     --->preempted by rcu_core()->rcu_do_batch()  which releases irq_descA
>       raw_spin_lock_irqsave(&desc->lock, flags);
>       //Oops
>
> And since in the involved code piece, threadA runs in a preemptible
> context, and there may be more than one thread at this stage. So the
> preempted can happen.

Well, I'm still not sure that this can ever trigger in practice, but I
guess the locking can be added for extra safety.

Anyway, the above information should go into the changelog IMO.

That said ->

> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > To: linux-kernel@vger.kernel.org
> > > ---
> > >  kernel/irq/pm.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> > > index ca71123a6130..4b67a4c7de3c 100644
> > > --- a/kernel/irq/pm.c
> > > +++ b/kernel/irq/pm.c
> > > @@ -133,6 +133,7 @@ void suspend_device_irqs(void)
> > >         struct irq_desc *desc;
> > >         int irq;
> > >
> > > +       irq_lock_sparse();
> > >         for_each_irq_desc(irq, desc) {
> > >                 unsigned long flags;
> > >                 bool sync;
> > > @@ -146,6 +147,7 @@ void suspend_device_irqs(void)
> > >                 if (sync)
> > >                         synchronize_irq(irq);

-> is it entirely safe to call synchronize_irq() under irq_lock_sparse?

> > >         }
> > > +       irq_unlock_sparse();
> > >  }
> > >  EXPORT_SYMBOL_GPL(suspend_device_irqs);
> > >
> > > @@ -186,6 +188,7 @@ static void resume_irqs(bool want_early)
> > >         struct irq_desc *desc;
> > >         int irq;
> > >
> > > +       /* The early resume stage is free of irq_desc release */
> > >         for_each_irq_desc(irq, desc) {
> > >                 unsigned long flags;
> > >                 bool is_early = desc->action &&
> > > --
> > > 2.31.1
> > >
