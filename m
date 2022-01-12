Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F26648CA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344188AbiALRtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:49:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58954 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbiALRtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:49:06 -0500
Date:   Wed, 12 Jan 2022 18:49:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642009744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HKPb/OgUpnzZpZ4ZaPFda8NZxcSKTOmxke8zHueMxac=;
        b=1hQCpQQQ+jHY+D72ntC/E5Js8/B0BNdQPukf/gTE1gtTWD0umpu8zk8kmazRtUhScf/+C4
        H3w+uALRaDkNI2HWGdJ/+yVrV2D54yzOl8DjmlfpvVsP5t8yJcOIhdHeldDcY8Ho4fpAHW
        mvF6JrOBBWUmNz0qslncNKeMrjg6KuwoonPWpzskyfGOv368bLIynnxIa3ducHX0dXoaPj
        5LQ60lUY8JICr0xXvcqBMcyXZTUeGR+Iz/f5Mr4cHvWYo6JK3u/2XQF7U2ip2xP/pqspaP
        bjrVuwexhm0EGiQNDfpF5H7lzJRSQ4nHD5KMdI9XEHjNgmrn0OXYRf+nUeTtmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642009744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HKPb/OgUpnzZpZ4ZaPFda8NZxcSKTOmxke8zHueMxac=;
        b=IV0GB3BaIALcRkDSiM2M6ufawjT2zJkwDW0wms3ZNdsZ2piidnOHqn7fJLsWdOxnc6/NX9
        IF8rBbUmblwOdIAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 5/5] random: Defer processing of randomness on PREEMPT_RT.
Message-ID: <Yd8Ujw4t8DKYuhZK@linutronix.de>
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
 <20211207121737.2347312-6-bigeasy@linutronix.de>
 <CAHmME9q2Yid56ZZ9sBQWjEWEK2B06g3H9KYRwWqExXRoCdbPdA@mail.gmail.com>
 <20211207201037.h46573oa5nfj33xq@linutronix.de>
 <CAHmME9pzdXyD0oRYyCoVUSqqsA9h03-oR7kcNhJuPEcEMTJYgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHmME9pzdXyD0oRYyCoVUSqqsA9h03-oR7kcNhJuPEcEMTJYgw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-20 15:38:58 [+0100], Jason A. Donenfeld wrote:
> Hey Sebastian,
Hi Jason,

> I think I understand the motivation for this patchset, and maybe it'll
> turn out to be the only way of accomplishing what RT needs. But I
> really don't like complicating the irq ingestion flow like that,
> splitting the captured state into two pieces, and having multiple
> entry points. It makes the whole thing more difficult to analyze and
> maintain. Again, maybe we'll *have* to do this ultimately, but I want
> to make sure we at least explore the alternatives fully.

Sure.

> One thing you brought up is that the place where a spinlock becomes
> problematic for RT is if userspace goes completely nuts with
> RNDRESEEDCRNG. If that's really the only place where contention might
> be harmful, can't we employ other techniques there instead? For
> example, just ratelimiting the frequency at which RNDRESEEDCRNG can be
> called _before_ taking that lock, using the usual ratelimit.h
> structure?

ratelimit. Didn't think about it.
There is RNDRESEEDCRNG and RNDADDENTROPY from the user API and lets
ignore the kernel users for the moment.
With the DEFAULT_RATELIMIT_BURST we would allow 10 "concurrent"
operations. This isn't as bad as previously but still not perfect (the
latency number jumped up to 50us in a smoke test).
Also in the !__ratelimit() case we would have to return an error. This
in turn breaks the usecase where one invokes 11 times
ioctl(,RNDADDENTROPY,) with a smaller buffer instead once with a big
buffer. Not sure how bad this is but it creates corner cases=E2=80=A6
We could also sleep & loop until __ratelimit() allows but it looks odd.

>            Or, alternatively, what about a lock that very heavily
> prioritizes acquisitions from the irq path rather than from the
> userspace path? I think Herbert might have had a suggestion there
> related to the net stack's sock lock?

Using a semaphore might work. down_trylock() can be invoked from
hard-irq context while the preemptible context would use down() and
sleep if needed. add_interrupt_randomness() has already a trylock. We
have add_disk_randomness() which is invoked from IRQ-context (on !RT) so
we would have to use trylock there, too (for its mix_pool_bytes()
invocation).
The sock-lock is either always invoked from preemptible context or has a
plan B in the contended case if invoked from atomic context. I'm not
sure what plan B could be here in atomic context. I *think* we need to
do these things and can't delay them.
Now that I think about it, we could add a mutex_t which is acquired
first for the user-API part to ensure that there is only one at a time
(instead of using ratelimit). Assuming that there is nothing else in the
kernel that can hammer on the lock (getrandom() is kind of rate
limited). If we really want to go that road, I would have to retest and
see how long extract_buf() holds the lock acquired.

Either way, we still need to split out the possible crng_reseed()
invocations (if (crng_init < 2)) due to crng_state::lock which must not
be acquired on PREEMPT_RT in hard-irq context
(add_interrupt_randomness() -> credit_entropy_bits()). I *think* the
other places were fine.

> Jason

Sebastian
