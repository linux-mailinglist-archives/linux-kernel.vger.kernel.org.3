Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D9A4B284C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351044AbiBKOv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:51:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350681AbiBKOvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:51:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E33F131;
        Fri, 11 Feb 2022 06:51:24 -0800 (PST)
Date:   Fri, 11 Feb 2022 15:51:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644591082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ac7ZwgM4AtZeIrPaveXmqY4D56LobAIwVWh5i89DXn0=;
        b=k84cVdzxftjPWC+QaeNlnQi7Em/E0QyFDldFbEOEXZmAzOw/9NtoeErHVtbu7AOH5sDSaJ
        iX00naiJRFFuoUicaXhOiBMd8Tp/xrVIEynRCQ/3D/DVEEDURaYUQzcuYjrZsbkxa859ed
        sZ3RNOVi+eUBOTFN3Hrd7VN3EW0fQlLSpsewOJF+Eaolhqw522Gwmy4yWvI2PGTZkL4wxw
        I+eckik6vO8oCK2Ib8gspsQ+1ka7cRES5qxMuni6lIEksRlIBdzK7GSrfYLV9MiWMZ0JeX
        +fYMlB4L+m1I1WtyxNBpQW2euMatGLs3YZW8xEXlJU8+0oKpq8P60Xsugzidjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644591082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ac7ZwgM4AtZeIrPaveXmqY4D56LobAIwVWh5i89DXn0=;
        b=tPcZs6D7tde5Q/oKvpzytA3Kp0ugR/Lfkarh17LpvrHpfKvxkluMVTb4ldLwhhGPvJdkNh
        D/leSVGrW3lrM3Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH] random: ensure mix_interrupt_randomness() is consistent
Message-ID: <YgZ36ShvikQhcQYl@linutronix.de>
References: <CAHmME9pGwyZKu=9yCben-V30hR+zEjb9iZGWr5_RAE-uXt_Ofw@mail.gmail.com>
 <20220211011446.392673-1-Jason@zx2c4.com>
 <YgYbRa+5cC0ivWrK@linutronix.de>
 <CAHmME9oBCt=bvjQLwmppr29W9FdJ612+d1a8gUExyWZuZHVWZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9oBCt=bvjQLwmppr29W9FdJ612+d1a8gUExyWZuZHVWZw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 11:48:15 [+0100], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi,

> On Fri, Feb 11, 2022 at 9:16 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > But I'm trying to avoid the migrate_disable(), so:
> > To close the racy with losing the workqueue bit, wouldn't it be
> > sufficient to set it to zero via atomic_cmpxchg()? Also if the counter
> > before the memcpy() and after (at cmpxchg time) didn't change then the
> > pool wasn't modified. So basically
> >
> >  do {
> >         counter = atomic_read(&fast_pool->count); // no need to cast
> >         memcpy(pool, fast_pool->pool_long, ARRAY_SIZE(pool));
> >     } while (atomic_cmpxchg(&fast_pool->count, counter, 0) != counter);
> >
> >
> > then it also shouldn't matter if we are _accidentally_ on the wrong CPU.
> 
> This won't work. If we're executing on a different CPU, the CPU
> mutating the pool won't necessarily update the count at the right
> time. This isn't actually a seqlock or something like that. Rather, it

But it is atomic, isn't it?

> depends on running on the same CPU, where the interrupting irq handler
> runs in full before giving control back, so that count and pool are
> either both updated or not at all. Making this work across CPUs makes
> things a lot more complicated and I'd rather not do that.

but this isn't the rule, is it? It runs on the same CPU so we should
observe the update in IRQ context and the worker should observe the
counter _and_ pool update.

And cross CPU isn't the rule. We only re-do the loop if
- an interrupt came in on the local-CPU between atomic_read() and
  atomic_cmpxchg().

- the worker was migrated due CPU hotplug and we managed properly reset
  counter back to 0.

> Actually, though, a nicer fix would be to just disable local
> interrupts for that *2 word copy*. That's a tiny period of time. If
> you permit me, that seems nicer. But if you don't like that, I'll keep
> that loop.

Here, I don't mind but I don't think it is needed.

> Unfortunately, though, I think disabling migration is required. Sultan
> (CC'd) found that these workqueues can migrate even midway through
> running. And generally the whole idea is to keep this on the *same*
> CPU so that we don't have to introduce locks and synchronization.

They can't. Your workqueue is not unbound _and_ you specify a specific
CPU instead of WORK_CPU_UNBOUND (or an offlined CPU).
The only way it can migrate is if the CPU goes down while the worker is
running (or before it had a chance I think) which forces the scheduler
to break its (worker's) CPU affinity and move it to another CPU.

> I'll add comments around the acquire/release. The remaining question
> I believe is: would you prefer disabing irqs during the 2 word memcpy,
> or this counter double read loop?

I would prefer the cmpxchg in case it highly unlikely gets moved to
another CPU and we may lose that SCHED bit. That is why we switched to
atomics I think. Otherwise if the updates are only local can disable
interrupts during the update.
But I don't mind disabling interrupts for that copy.

> Jason

Sebastian
