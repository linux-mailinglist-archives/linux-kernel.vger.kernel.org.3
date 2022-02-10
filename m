Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0B4B14E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbiBJSEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:04:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245472AbiBJSEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:04:23 -0500
X-Greylist: delayed 5975 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 10:04:23 PST
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E022B100A;
        Thu, 10 Feb 2022 10:04:23 -0800 (PST)
Date:   Thu, 10 Feb 2022 19:04:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644516261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0wxMDmMyxL17wjeOYSooOciALzgNfAa7MCixAamkeY=;
        b=gW3bCZksqzrMGBN/ii6E2YX/6r1rur56DYJ1OaolYQmSYFVubsnWW0erBMmQ+laUJFLUmr
        IHMwmsZr90TzVeLOeA2qmNR2U2xSD2X2g6djKsZCUwEPSjzT9tqnyaOhlRdjpBR2MijmTk
        izz147aOtCisMFxfltjdWaIG++xnQho55ZqxjhmOGkxve5biE3R8gXJEn5kd/cPQ+ri5GH
        Ki3KwMca69jhGRdi/S0Iq1OwJYzi7S9WDcLB/4WP8yD7a/YQfgPgcLl2KNBsMlObXoOI2B
        qwgj+KodTcPEOCbRgcTrM2Xj34Hlb6laIAK7CYpzbCegwMacK8XvtYgvyvXQ7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644516261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0wxMDmMyxL17wjeOYSooOciALzgNfAa7MCixAamkeY=;
        b=fRNC9ew52gchYcanfTNu8VeReTjwndEhYEEpxOAIhZKBttTBDpguYvpl1hjFdMGRp+PmqJ
        P1+jUjCfKDJU8uDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v4 2/2] random: defer fast pool mixing to worker
Message-ID: <YgVTpI/sYLecyWa3@linutronix.de>
References: <20220209125644.533876-1-Jason@zx2c4.com>
 <20220209125644.533876-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220209125644.533876-3-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-09 13:56:44 [+0100], Jason A. Donenfeld wrote:
> +static void mix_interrupt_randomness(struct work_struct *work)
> +{
> +	struct fast_pool *fast_pool =3D container_of(work, struct fast_pool, mi=
x);
> +	u8 pool[sizeof(fast_pool->pool)];

So.
- CPU1 schedules a worker
- CPU1 goes offline before the gets on the CPU.
- The worker runs CPU2
- CPU2 is back online
- and now
   CPU1						CPU2
   new_count =3D ++fast_pool->count;
    reg =3D fast_pool->count (FAST_POOL_MIX_INFLIGHT | 64)
    incl reg (FAST_POOL_MIX_INFLIGHT | 65)
    						WRITE_ONCE(fast_pool->count, 0);
    fast_pool->count =3D reg ((FAST_POOL_MIX_INFLIGHT | 65)

So we lost the WRITE_ONCE(, 0), FAST_POOL_MIX_INFLIGHT is still set and
worker is not scheduled. Not easy to trigger, not by an ordinary user.
Just wanted to mention=E2=80=A6

=E2=80=A6
> @@ -999,9 +1016,10 @@ void add_interrupt_randomness(int irq)
> =20
>  	fast_mix(fast_pool);
>  	add_interrupt_bench(cycles);
> +	new_count =3D ++fast_pool->count;
> =20
>  	if (unlikely(crng_init =3D=3D 0)) {
> -		if ((fast_pool->count >=3D 64) &&
> +		if (new_count >=3D 64 &&
>  		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0=
) {

crng_fast_load() does spin_trylock_irqsave() in hardirq context. It does
not produce any warning on RT but is still wrong IMHO:
- lockdep will see a random task and I remember in the past it produced
  strange lock chains based on this.

- Should another task attempt to acquire this lock then it will PI-boost the
  wrong task.

If we just could move this, too.

I don't know how timing critical this is but the first backtrace from
crng_fast_load() came (to my surprise) from hwrng_fillfn() (a kthread)
and added 64bytes in one go.

I did move that crng_fast_load() into the worker and did made some
numbers:
           <idle>-0       [000] d..h1..     2.069924: add_interrupt_randomn=
ess: Tick

first interrupt
=E2=80=A6
        swapper/0-1       [000] d..h.11     2.341938: add_interrupt_randomn=
ess: Tick
        swapper/0-1       [000] d..h.11     2.341938: add_interrupt_randomn=
ess: work

the 64th interrupt, scheduling the worker.

        swapper/0-1       [000] d..h.11     2.345937: add_interrupt_randomn=
ess: Tick
        swapper/0-1       [000] d..h111     2.349938: add_interrupt_randomn=
ess: Tick
        swapper/0-1       [000] d..h.11     2.353939: add_interrupt_randomn=
ess: Tick
        swapper/0-1       [000] d..h.11     2.357940: add_interrupt_randomn=
ess: Tick
        swapper/0-1       [000] d..h111     2.361939: add_interrupt_randomn=
ess: Tick
        swapper/0-1       [000] d..h111     2.365939: add_interrupt_randomn=
ess: Tick
        swapper/0-1       [000] d..h.11     2.369941: add_interrupt_randomn=
ess: Tick
     kworker/0:0H-6       [000] .......     2.384714: mix_interrupt_randomn=
ess: load
     kworker/0:0H-6       [000] .......     2.384715: crng_fast_load: 16
           <idle>-0       [001] dn.h1..     3.205766: add_interrupt_randomn=
ess: Tick
           <idle>-0       [019] dn.h1..     6.771047: add_interrupt_randomn=
ess: Tick

7 interrupts got lost before the worker could run & load first 16 bytes.
The workqueue core gets initialized at that point and spawns first
worker. After that the interrupts took a break.
And then the work-to-load delay was quite low:

           <idle>-0       [019] dn.h1..     7.586234: add_interrupt_randomn=
ess: Tick
           <idle>-0       [019] dn.h1..     7.586234: add_interrupt_randomn=
ess: work
    kworker/19:0H-175     [019] .......     7.586504: mix_interrupt_randomn=
ess: load
    kworker/19:0H-175     [019] .......     7.586507: crng_fast_load: 16
           <idle>-0       [020] dn.h1..     7.614649: add_interrupt_randomn=
ess: Tick
           <idle>-0       [020] dn.h1..     7.614651: add_interrupt_randomn=
ess: work
           <idle>-0       [020] dn.h1..     7.614736: add_interrupt_randomn=
ess: Tick
    kworker/20:0H-183     [020] dn.h...     7.614859: add_interrupt_randomn=
ess: Tick
    kworker/20:0H-183     [020] .......     7.614871: mix_interrupt_randomn=
ess: load
    kworker/20:0H-183     [020] .......     7.614872: crng_fast_load: 16
           <idle>-0       [018] dn.h1..     8.352423: add_interrupt_randomn=
ess: Tick
           <idle>-0       [018] dn.h1..     8.352423: add_interrupt_randomn=
ess: work
    kworker/18:0H-167     [018] dn.h1..     8.352438: add_interrupt_randomn=
ess: Tick
    kworker/18:0H-167     [018] dn.h1..     8.352448: add_interrupt_randomn=
ess: Tick
    kworker/18:0H-167     [018] dn.h1..     8.352459: add_interrupt_randomn=
ess: Tick
    kworker/18:0H-167     [018] dn.h1..     8.352491: add_interrupt_randomn=
ess: Tick
    kworker/18:0H-167     [018] .......     8.352505: mix_interrupt_randomn=
ess: load
    kworker/18:0H-167     [018] .......     8.352506: crng_fast_load: 16

In total we lost 13 ticks.
I did the same test on PREEMPT_VOLUNTARY and lost 2 ticks only.

Sebastian
