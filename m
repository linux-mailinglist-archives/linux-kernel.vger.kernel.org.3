Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16144B2023
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245105AbiBKIZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:25:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiBKIZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:25:49 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7224E48;
        Fri, 11 Feb 2022 00:25:48 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D58F920141A;
        Fri, 11 Feb 2022 08:25:45 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id DBBE38052E; Fri, 11 Feb 2022 09:25:00 +0100 (CET)
Date:   Fri, 11 Feb 2022 09:25:00 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v4 2/2] random: defer fast pool mixing to worker
Message-ID: <YgYdXLg4bo6E7Bit@owl.dominikbrodowski.net>
References: <20220209125644.533876-1-Jason@zx2c4.com>
 <20220209125644.533876-3-Jason@zx2c4.com>
 <YgVTpI/sYLecyWa3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgVTpI/sYLecyWa3@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Feb 10, 2022 at 07:04:20PM +0100 schrieb Sebastian Andrzej Siewior:
> > @@ -999,9 +1016,10 @@ void add_interrupt_randomness(int irq)
> >  
> >  	fast_mix(fast_pool);
> >  	add_interrupt_bench(cycles);
> > +	new_count = ++fast_pool->count;
> >  
> >  	if (unlikely(crng_init == 0)) {
> > -		if ((fast_pool->count >= 64) &&
> > +		if (new_count >= 64 &&
> >  		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
> 
> crng_fast_load() does spin_trylock_irqsave() in hardirq context. It does
> not produce any warning on RT but is still wrong IMHO:
> - lockdep will see a random task and I remember in the past it produced
>   strange lock chains based on this.
> 
> - Should another task attempt to acquire this lock then it will PI-boost the
>   wrong task.
> 
> If we just could move this, too.
> 
> I don't know how timing critical this is but the first backtrace from
> crng_fast_load() came (to my surprise) from hwrng_fillfn() (a kthread)
> and added 64bytes in one go.

That's a hw rng (such as a tpm chip or the virtio-rng driver) providing some
entropy; if it's 64 bytes of input, crng_init progresses to 1, and
crng_fast_load() should never be called again.[*] I'm a bit suprised that the
hw_rng input occurred so early (it's only at device_initcall() level), and
earlier than 64 interrupts. But that may differ from system to system.

Note that crng_fast_load() will also never be called from
add_interrupt_randomness() if

	EFI, DT or kexec provides bootloader entropy of at least 64 bytes,
	and CONFIG_RANDOM_TRUST_BOOTLOADER is set

and/or	CONFIG_RANDOM_TRUST_CPU is set and the RDRAND/RDSEED instructions do
	not fail.

If neither of these three conditions (hw_rng is run early, bootloader or CPU
randomness) are met, the initial and early seeding of the base_crng depends
on add_interrupt_randomness(), and should happen rather quickly.

> I did move that crng_fast_load() into the worker and did made some
> numbers:
>            <idle>-0       [000] d..h1..     2.069924: add_interrupt_randomness: Tick
> 
> first interrupt
> …
>         swapper/0-1       [000] d..h.11     2.341938: add_interrupt_randomness: Tick
>         swapper/0-1       [000] d..h.11     2.341938: add_interrupt_randomness: work
> 
> the 64th interrupt, scheduling the worker.
> 
>         swapper/0-1       [000] d..h.11     2.345937: add_interrupt_randomness: Tick
>         swapper/0-1       [000] d..h111     2.349938: add_interrupt_randomness: Tick
>         swapper/0-1       [000] d..h.11     2.353939: add_interrupt_randomness: Tick
>         swapper/0-1       [000] d..h.11     2.357940: add_interrupt_randomness: Tick
>         swapper/0-1       [000] d..h111     2.361939: add_interrupt_randomness: Tick
>         swapper/0-1       [000] d..h111     2.365939: add_interrupt_randomness: Tick
>         swapper/0-1       [000] d..h.11     2.369941: add_interrupt_randomness: Tick
>      kworker/0:0H-6       [000] .......     2.384714: mix_interrupt_randomness: load
>      kworker/0:0H-6       [000] .......     2.384715: crng_fast_load: 16
>            <idle>-0       [001] dn.h1..     3.205766: add_interrupt_randomness: Tick
>            <idle>-0       [019] dn.h1..     6.771047: add_interrupt_randomness: Tick
> 
> 7 interrupts got lost before the worker could run & load first 16 bytes.
> The workqueue core gets initialized at that point and spawns first
> worker.

So the reason for the longer delay here is that the workqueue core had not
been initialized beforehand?

> After that the interrupts took a break.
> And then the work-to-load delay was quite low:
> 
>            <idle>-0       [019] dn.h1..     7.586234: add_interrupt_randomness: Tick
>            <idle>-0       [019] dn.h1..     7.586234: add_interrupt_randomness: work
>     kworker/19:0H-175     [019] .......     7.586504: mix_interrupt_randomness: load
>     kworker/19:0H-175     [019] .......     7.586507: crng_fast_load: 16
>            <idle>-0       [020] dn.h1..     7.614649: add_interrupt_randomness: Tick
>            <idle>-0       [020] dn.h1..     7.614651: add_interrupt_randomness: work
>            <idle>-0       [020] dn.h1..     7.614736: add_interrupt_randomness: Tick
>     kworker/20:0H-183     [020] dn.h...     7.614859: add_interrupt_randomness: Tick
>     kworker/20:0H-183     [020] .......     7.614871: mix_interrupt_randomness: load
>     kworker/20:0H-183     [020] .......     7.614872: crng_fast_load: 16
>            <idle>-0       [018] dn.h1..     8.352423: add_interrupt_randomness: Tick
>            <idle>-0       [018] dn.h1..     8.352423: add_interrupt_randomness: work
>     kworker/18:0H-167     [018] dn.h1..     8.352438: add_interrupt_randomness: Tick
>     kworker/18:0H-167     [018] dn.h1..     8.352448: add_interrupt_randomness: Tick
>     kworker/18:0H-167     [018] dn.h1..     8.352459: add_interrupt_randomness: Tick
>     kworker/18:0H-167     [018] dn.h1..     8.352491: add_interrupt_randomness: Tick
>     kworker/18:0H-167     [018] .......     8.352505: mix_interrupt_randomness: load
>     kworker/18:0H-167     [018] .......     8.352506: crng_fast_load: 16
> 
> In total we lost 13 ticks.

Was this still way before the initramfs was up and running?

> I did the same test on PREEMPT_VOLUNTARY and lost 2 ticks only.

Thanks,
	Dominik

[*] Actually, there's some contradiciton going on: If we do not trust the
hw_rng device (that is, its quality setting is 0), crng_fast_load() will be
called nonetheless, and the hw_rng-provided input will be used to increment
crng_init to 1. If !CONFIG_RANDOM_TRUST_BOOTLOADER, only crng_slow_load() is
called, and crng_init will remain at 0. Similar for
!CONFIG_RANDOM_TRUST_CPU.
