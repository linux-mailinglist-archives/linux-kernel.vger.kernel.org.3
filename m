Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDF046C43E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbhLGUOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:14:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55164 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhLGUOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:14:12 -0500
Date:   Tue, 7 Dec 2021 21:10:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638907839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gaa9lqUXwmb+EqI6OFUaSx3Utma6GVz0q/+hnXOcFfE=;
        b=CClWwyRpfSpL90SW7wwCsKDFTfVRBvqjdmk5IlWG9WEGVthR5UvZ4MIT/i7R3mWsg2ZMHR
        ytP4efph8cuVRTNjgs9RHFZtL7dHQhtavczoV/TT3Op5PHPfl482pDkwhHfE3ni5dP3cG8
        jlqo2EXMuuuIdB04ri44FtNjgj1C/IpuwFLRzMaguCwB/zBR9GrG3PJVvXodXEU54pvA24
        bIwOKJjnUWk6t3/3iSbF24k4Cf34X8X695iYnvPkjcMceA2S2rkaXa+8bXD95MGbgQ3NoL
        f7VjM9Wx9MAKYVJjLLXkD09xys8tuSRcVVQHAKQZwy/JoKmCJQVXtAeyzIdLZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638907839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gaa9lqUXwmb+EqI6OFUaSx3Utma6GVz0q/+hnXOcFfE=;
        b=BDtfkZzzkSSf8UcX3p3sTy3FlqT6chAjhxYv8lsyNySsI7RwFiizGH5eRPSF6b3ba8dd7n
        0dj2Z0hkQB/X70Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/5] random: Defer processing of randomness on PREEMPT_RT.
Message-ID: <20211207201037.h46573oa5nfj33xq@linutronix.de>
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
 <20211207121737.2347312-6-bigeasy@linutronix.de>
 <CAHmME9q2Yid56ZZ9sBQWjEWEK2B06g3H9KYRwWqExXRoCdbPdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHmME9q2Yid56ZZ9sBQWjEWEK2B06g3H9KYRwWqExXRoCdbPdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-07 19:14:16 [+0100], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -1281,6 +1281,9 @@ static int irq_thread(void *data)
> >                 if (action_ret =3D=3D IRQ_WAKE_THREAD)
> >                         irq_wake_secondary(desc, action);
> >
> > +               if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +                       process_interrupt_randomness();
> > +
>=20
> Adding a path from irq_thread() (and complicating the callgraph)
> strikes me as a rather large hammer to solve this problem with. Maybe
> it's the only way. But I wonder:

Well, on PREEMPT_RT the option `threadirqs' is always on so every
threaded interrupt goes through this. This is ensures that the primary
handler does not contribute to the per-CPU random pool for nothing at
all. The only exception would be a non-threaded interrupt (like a
timer) on a CPU which has no threaded interrupts assigned.

> > on the lock if contended. The extraction of entropy (extract_buf())
> > needs a few cycles more because it performs additionally few
> > SHA1 transformations. This takes around 5-10us on a testing box (E5-2650
> > 32 Cores, 2way NUMA) and is negligible.
> > The frequent invocation of the IOCTLs RNDADDTOENTCNT and RNDRESEEDCRNG
> > on multiple CPUs in parallel leads to filling and depletion of the pool
> > which in turn results in heavy contention on the lock. The spinning with
> > disabled interrupts on multiple CPUs leads to latencies of at least
> > 100us on the same machine which is no longer acceptable.
>=20
> I wonder if this problem would partially go away if, instead, I can
> figure out how to make extract_buf() faster? I'd like to replace sha1
> in there with something else anyway. I'm not sure what sorts of
> speedups I could get, but perhaps something could be eked out. Would
> this be viable? Or do you think that even with various speedups the
> problem would still exist in one way or another?

I don't think that we would gain much in the end. I think the majority
of the problem is that I'm able to trigger lock contention from multiple
CPUs simultaneously. If you want me to, I could replace it with a
busy-loop which takes always 2us-5us or so and see where we get. The
memory access it probably where the jitter is coming from=E2=80=A6

> Alternatively, is there a different locking scheme that would
> prioritize the irq path mostly winning and having the ioctl path
> spinning instead?

Even the IOCTL path must spin with disabled interrupts to avoid dead
locks. Therefore it makes no sense if attempt acquire the lock from
process or IRQ context. Something like
	while (!raw_spin_trylock_irqsave())
		cpu_relax()

might work "better" but then PeterZ will come after me with a torch and
a pitchfork. He might even do so for just mentioning this=E2=80=A6
The raw_spin_lock_irqsave() implementation (on x86) uses a ticket system
which enforces a "fair queue" system so the CPUs wait time is "fair".
This isn't the case with hack above because CPU1 might get the lock
after 3us and then again and again while CPU7 and 9 wait for 60us+ with
no luck. CPU7 and 9 would remain preemptible which is good but then lose
a lot cycles doing nothing which is bad from the performance point of
view.

However, since you mentioned different locking scheme: The spinlock_t on
PREEMPT_RT does more or less this: It is a RT-MUTEX based implementation
which can be compared with the mutex_t. The waiter then sleeps and does
not spin on the lock and therefore I don't see the latency spikes.
However since the waiter sleeps, it can not be acquired from hard-IRQ
context which is where add_interrupt_randomness() is invoked.

> Also, just curious, what is running RNDRESEEDCRNG so much on a
> PREEMPT_RT system and why?

Nothing in particular. After switching the locks (and getting
crng_fast_load() out of the hard-irq context, too) I was looking at the
latency and it didn't look bad. So I started pushing all the buttons in
order to hammer on the locks and utilise the whole potential and see how
bad it can get. The potential worst case here so see if it safe swap the
locks.

> Jason

Sebastian
