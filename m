Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3303C50B576
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446820AbiDVKqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349975AbiDVKqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:46:06 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBF4BF3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:43:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q1so8801096plx.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PwjyuhBBzo6UT5Lred+US79kmO0Pe9efH/HNboc3Hdw=;
        b=CueUH3OOot8AF32j5BECrYNIAqKpODeznipw7H4iyOuFOjrDkDhWbj1uEln70UZKI9
         JKq1xltiLvRCtjXFzqKCx/kCfHIEl29/wm4VSfG1Qw/TjgFsS9tC94wG+JmzQ2Pr8KvI
         i9mjchpi0kgLAZVbLz2T+XWc2Dg+GS2zhrBKBZb3EhwAs7zA8EoTgZ0wOkeSadwwXKGJ
         Nc4DQlBOaG6KQRTKWHFUyx4yCmm/IQnND79tsm5HjQ+WPIT1YXpLv284sG6VtI/gMWO5
         qa6muYXNzKT/qbJ236n4hkK5OVHi3/5L1zEllbw58orJ+E4m7I9KJMzc7Au+hjX550c8
         DdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PwjyuhBBzo6UT5Lred+US79kmO0Pe9efH/HNboc3Hdw=;
        b=g8nkX1O6UD8Dfq99ur87WYwG6locIgDq++aqrFbxSQRlS7iqLxnfNcYQ6eHpVy9vzf
         yfyBii3HUv8Q8KhOfRQEn5IBSA97Y8jznPGbkB7WCjk58ZUjxhwbGR+kfSEGbV4xuXxq
         Szwg3ZijkP0VdjQE0JsRKLwJEQtXqVJn7b7aUw9B2NSNMS2r2ijDKYL2JXYY18biI6RX
         8yiAtzabAZALkYU7iRz3jUjnQEtLP1HDW/lV2aWvuYEH7gSTK29wN0DdZ+6mBE3XrU6z
         y2c9f6O5fTAc+hjD1LbXE2/E9PrMp9fkDvpEjPpIDZnuTCaJ0qDvxEGqhUBweb24Z44r
         ke1w==
X-Gm-Message-State: AOAM531Ht+ikF9ZuSgHz/9QZdYX/4ig+sX9tsjBF3lpDrS9tF2s96CQ/
        1PwgDvDQuc0VIyX55A4K5A==
X-Google-Smtp-Source: ABdhPJyLHP+6ZZ57Czt7FGumA5gixAyMavZrloHv3BybrstHXNagscnfm+7CneYBaGgb8wd+tDVJCQ==
X-Received: by 2002:a17:90b:1b01:b0:1d2:ef4a:98e1 with SMTP id nu1-20020a17090b1b0100b001d2ef4a98e1mr4590141pjb.163.1650624193062;
        Fri, 22 Apr 2022 03:43:13 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f187-20020a6251c4000000b005058e59604csm2148448pfb.217.2022.04.22.03.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 03:43:12 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:43:07 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/9] pm/irq: make for_each_irq_desc() safe of irq_desc
 release
Message-ID: <YmKGuwX3o7dETlKl@piliu.users.ipa.redhat.com>
References: <20220420140521.45361-1-kernelfans@gmail.com>
 <20220420140521.45361-7-kernelfans@gmail.com>
 <CAJZ5v0h2SWN-=-5=OsMGm1amMJrYELqM6BC+J=98EAxSUmxMqg@mail.gmail.com>
 <YmDP93yLJw5gsjtQ@piliu.users.ipa.redhat.com>
 <CAJZ5v0g9DZax-U4WnVcUCc0zAD0uwZZ7E6wsGXmVCB6MeebWxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g9DZax-U4WnVcUCc0zAD0uwZZ7E6wsGXmVCB6MeebWxw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 12:57:28PM +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 21, 2022 at 5:31 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Wed, Apr 20, 2022 at 06:23:48PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Apr 20, 2022 at 4:06 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> > > >
> > > > The invloved context is no a RCU read section. Furthermore there may be
> > > > more than one task at this point. Hence it demands a measure to prevent
> > > > irq_desc from freeing. Use irq_lock_sparse to serve the protection
> > > > purpose.
> > >
> > > Can you please describe an example scenario in which the added locking
> > > will prevent a failure from occurring?
> > >
> >
> > Sorry to forget mentioning that this is based on the code analysis.
> >
> > Suppose the following scenario:
> > Two threads invloved
> >   threadA "hibernate" runs suspend_device_irqs()
> >   threadB "rcu_cpu_kthread" runs rcu_core()->rcu_do_batch(), which releases
> >   object, let's say irq_desc
> >
> > Zoom in:
> >   threadA                                               threadB
> >   for_each_irq_desc(irq, desc) {
> >       get irq_descA which is under freeing
> >                                                     --->preempted by rcu_core()->rcu_do_batch()  which releases irq_descA
> >       raw_spin_lock_irqsave(&desc->lock, flags);
> >       //Oops
> >
> > And since in the involved code piece, threadA runs in a preemptible
> > context, and there may be more than one thread at this stage. So the
> > preempted can happen.
> 
> Well, I'm still not sure that this can ever trigger in practice, but I

Yes, I also think it hardly happen. I had gone through all
accesses to irq_desc in kernel, and just want to make anything
completely obey the rule.
> guess the locking can be added for extra safety.
> 
> Anyway, the above information should go into the changelog IMO.
> 

OK, I will update it in V2.
> That said ->
> 
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > To: linux-kernel@vger.kernel.org
> > > > ---
> > > >  kernel/irq/pm.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> > > > index ca71123a6130..4b67a4c7de3c 100644
> > > > --- a/kernel/irq/pm.c
> > > > +++ b/kernel/irq/pm.c
> > > > @@ -133,6 +133,7 @@ void suspend_device_irqs(void)
> > > >         struct irq_desc *desc;
> > > >         int irq;
> > > >
> > > > +       irq_lock_sparse();
> > > >         for_each_irq_desc(irq, desc) {
> > > >                 unsigned long flags;
> > > >                 bool sync;
> > > > @@ -146,6 +147,7 @@ void suspend_device_irqs(void)
> > > >                 if (sync)
> > > >                         synchronize_irq(irq);
> 
> -> is it entirely safe to call synchronize_irq() under irq_lock_sparse?

synchronize_irq - wait for pending IRQ handlers (on other CPUs). It
only holds irq_desc->lock and has no connections with irq sparse tree or
bitmap. I can not see any deadlock issue or miss something?

Thanks for your time.

Regards,

	Pingfan
> 
> > > >         }
> > > > +       irq_unlock_sparse();
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(suspend_device_irqs);
> > > >
> > > > @@ -186,6 +188,7 @@ static void resume_irqs(bool want_early)
> > > >         struct irq_desc *desc;
> > > >         int irq;
> > > >
> > > > +       /* The early resume stage is free of irq_desc release */
> > > >         for_each_irq_desc(irq, desc) {
> > > >                 unsigned long flags;
> > > >                 bool is_early = desc->action &&
> > > > --
> > > > 2.31.1
> > > >
