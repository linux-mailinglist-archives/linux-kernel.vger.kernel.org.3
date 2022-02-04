Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD4A4AA170
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbiBDUxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiBDUxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:53:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAD2C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:53:13 -0800 (PST)
Date:   Fri, 4 Feb 2022 21:53:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644007992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hDCDwd0y2NgSOR54H9+IbLHkGAL+jpOQY8wyAtyMNj4=;
        b=C6gRMjuzFom8pMLjwzorR1XCA+N9MoJHuvsUtNGiWAbj5Wl5bCgrQ7bwWQp7eU7ryCnj3/
        e6o2U+Dh/qoqFgtO6D2JMsLfeQMwm9fR+MEmBy8MtouTawh5cuOysZe7hrwlyJZVBGCTbN
        zsvht9Imt4Ox4+g50E0b09Kon5qX+DB6YDgcGbBfs49oBE7eaUq/1wVEVqSv1xWCskQE8f
        QgKneQ662a+dZ7c0f6J3qhdlwndWHwpgAHj40MtfsL9/DyyGUZGHh/FUKqXSViBEFObZy9
        5VOVg2viC09SeeOJ9Lb/6bdnMjXx7tVjp+cyU5/RthDbwEivlQrqCopZ7ey4Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644007992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hDCDwd0y2NgSOR54H9+IbLHkGAL+jpOQY8wyAtyMNj4=;
        b=I7W8pJUIcCPYYzOBZc3GAc5J1KSZX0VrHDEEjpHXiI7/CZfLhanFSQ5A9q+39X8rwxLsKJ
        vlfgevCC97jIRzBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH RFC v1] random: do not take spinlocks in irq handler
Message-ID: <Yf2SNpi5847c7ceK@linutronix.de>
References: <YfgPWatDzkn2ozhm@linutronix.de>
 <20220204153149.51428-1-Jason@zx2c4.com>
 <CAHmME9pucLWXDofvOgHEau3y-7RmdtU91_jQHSt7psuR22eXBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9pucLWXDofvOgHEau3y-7RmdtU91_jQHSt7psuR22eXBg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-04 16:58:58 [+0100], Jason A. Donenfeld wrote:
> FWIW, the biggest issue with this
> 
> On Fri, Feb 4, 2022 at 4:32 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > +static void mix_interrupt_randomness(struct work_struct *work)
> > +{
> [...]
> > +       if (unlikely(crng_init == 0)) {
> > +               if (crng_fast_load((u8 *)&fast_pool->pool, sizeof(fast_pool->pool)) > 0)
> > +                       atomic_set(&fast_pool->count, 0);
> > +               else
> > +                       atomic_and(~FAST_POOL_MIX_INFLIGHT, &fast_pool->count);
> > +               return;
> > +       }
> [...]
> >  void add_interrupt_randomness(int irq)
> > -       if (unlikely(crng_init == 0)) {
> > -               if ((fast_pool->count >= 64) &&
> > -                   crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
> > -                       fast_pool->count = 0;
> > -                       fast_pool->last = now;
> > -               }
> > -               return;
> 
> The point of crng_fast_load is to shuffle bytes into the crng as fast
> as possible for very early boot usage. Deferring that to a workqueue
> seems problematic. So I think at the very least _that_ part will have
> to stay in the IRQ handler. That means we've still got a spinlock. But
> at least it's a less problematic one than the input pool spinlock, and
> perhaps we can deal with that some other way than this patch's
> approach.

RT wise we _could_ acquire that spinlock_t in IRQ context early during
boot as long as system_state < SYSTEM_SCHEDULING. After that, we could
dead lock.

> In other words, this approach for the calls to mix_pool_bytes, and a
> different approach for that call to crng_fast_load.
> 
> Jason

Sebastian
