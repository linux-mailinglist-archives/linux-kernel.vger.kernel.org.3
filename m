Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F24A4C34
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380461AbiAaQdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:33:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60944 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350168AbiAaQdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:33:33 -0500
Date:   Mon, 31 Jan 2022 17:33:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643646810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exI5XAnOP3c+SKAPaEnrOM53ifT6P3/UqF4RqlLtsHo=;
        b=wTex/RCYMinlzrUx+wSeZycFxINruiKY/4y5iOU9OdDqWGF8TeN81vnVSOk5phEQmRN9PU
        fxA0HTlOuJkErfz+avG2m0phmvDPXXfKu/sSbuA9b6G6oMeJ+/LitLlf5eb8a6SpzkgAob
        AG12WRMoxNb1EN/zJRoUofOkJwdAcpCH3+7iHLncnV1AtH8pWwkcyxNARBi6xuLoaPBVIH
        TVQgmdtZTtgnFz1OegMiO44yAYIbcexNd5seP2m822FsVCmLEijeCybtFXh2fFIyAh7stC
        IeF2YQMQjdeXAk/Yg10l7JhgMTbiDwDsTNYy4O8Zi2NREM38FHYPMOSAtmG0sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643646810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exI5XAnOP3c+SKAPaEnrOM53ifT6P3/UqF4RqlLtsHo=;
        b=CK+gvrtfNmEvHZbcwj3ALRQ6KD6Ty1hnPIDMZgjzNBjnhB5/EpF5Dh/duY7/dDEz0EN4Fa
        Q4d/WiylN4bubQDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 5/5] random: Defer processing of randomness on PREEMPT_RT.
Message-ID: <YfgPWatDzkn2ozhm@linutronix.de>
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
 <20211207121737.2347312-6-bigeasy@linutronix.de>
 <CAHmME9q2Yid56ZZ9sBQWjEWEK2B06g3H9KYRwWqExXRoCdbPdA@mail.gmail.com>
 <20211207201037.h46573oa5nfj33xq@linutronix.de>
 <CAHmME9pzdXyD0oRYyCoVUSqqsA9h03-oR7kcNhJuPEcEMTJYgw@mail.gmail.com>
 <Yd8Ujw4t8DKYuhZK@linutronix.de>
 <CAHmME9oXSx4JS0ZJeZTb7VC3gXoackuH389V9FDknHf_-rDJyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHmME9oXSx4JS0ZJeZTb7VC3gXoackuH389V9FDknHf_-rDJyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-30 23:55:09 [+0100], Jason A. Donenfeld wrote:
> Hey Sebastian,
Hi,

> I spent the weekend thinking about this some more. I'm actually
> warming up a bit to the general approach of the original solution
> here, though still have questions. To summarize my understanding of
> where we are:
>=20
> Alternative solution we've been discussing:
> - Replace spinlock_t with raw spinlocks.
> - Ratelimit userspace-triggered latency inducing ioctls with
> ratelimit() and an additional mutex of sorts.
> - Result: pretty much the same structure we have now, but with some
> added protection for PREEMPT_RT.
>=20
> Your original solution:
> - Absorb into the fast pool during the actual IRQ, but never dump it
> into the main pool (nor fast load into the crng directly if
> crng_init=3D=3D0) from the hard irq.
> - Instead, have irq_thread() check to see if the calling CPU's fast
> pool is >=3D 64, and if so, dump it into the main pool (or fast load
> into the crng directly if crng_init=3D=3D0).
>=20
> I have two questions about the implications of your original solution:
>=20
> 1) How often does irq_thread() run? With what we have now, we dump the

Mostly every interrupt gets threaded. After the primary handler (the
in hard irq) was invoked, the threaded handler gets woken up. The
threaded handler runs before the primary can run again.
Not every interrupt gets threaded. For instance interrupts that are not
threaded are marked as TIMER, PER_CPU, ONESHOT and NO_THREAD.
So on a system with 4 CPUs you can move all peripheral interrupts to
CPU0 leaving CPU1-3 with TIMER interrupts only. In that case, there
would be no irq_thread() invocations on CPU1-3.

> fast pool into the main pool at exactly 64 events. With what you're
> proposing, we're now in >=3D 64 territory. How do we conceptualize how
> far beyond 64 it's likely to grow before irq_thread() does something?

in theory on a busy RT system (on the previously mentioned one) you
could process all HW interrupts (on CPU0) and wake interrupt threads but
the threads are blocked by a user task (the user land task has a higher
priority than the interrupt thread). In that time further HW interrupts
can trigger on CPU0 for the non-threaded interrupts like the timer
interrupt.

> Is it easy to make guarantees like, "at most, probably around 17"? Or
> is it potentially unbounded? Growing beyond isn't actually necessarily
> a bad thing, but it could potentially *slow* the collection of
> entropy. That probably matters more in the crng_init=3D=3D0 mode, where
> we're just desperate to get whatever we can as fast as we can. But
> depending on how large that is, it could matter for the main case too.
> Having some handle on the latency added here would be helpful for
> thinking about this.

I have a bigger system which has only network and SATA and here:
PREEMPT, unpatched
[   10.545739] random: crng init done
[   10.549548] random: 7 urandom warning(s) missed due to ratelimiting

PREEMPT_RT, patched
[   11.884035] random: crng init done
[   11.884037] random: 7 urandom warning(s) missed due to ratelimiting

just from two boots, no real testing. I wouldn't even mention this as a
problem during boot-up.

> 2) If we went with this solution, I think I'd prefer to actually do it
> unconditionally, for PREEMPT_RT=3Dy and PREEMPT_RT=3Dn. It's easier to
> track how this thing works if the state machine always works in one
> way instead of two. It also makes thinking about performance margins
> for the various components easier if there's only one way used. Do you
> see any downsides in doing this unconditionally?

On !PREEMPT_RT you need to specify `threadirq` on the kernel command
line to enable threaded interrupts which are otherwise force-enabled on
PREEMPT_RT. To compensate for that, we would need something as backup.
Say a time or so=E2=80=A6

> Regards,
> Jason

Sebastian
