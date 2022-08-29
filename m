Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD635A54A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiH2TpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH2TpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:45:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1861DF33
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:45:13 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:45:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661802311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r/j7KNO+7MM3mzFiJUvn7EIiQIDtTMugi0upufP9SQ0=;
        b=x8mofQf4AidRk7AcPvqO1vUKJifpGlYKjoIT4GIHplgQfClRTp+ZhgMNQYJW+KzGReUWyz
        GxTXtdNImh1NmUXESToA6RyKDpdnqGo4NZ91YqICw4XChOiVF3+/YtMel7c9IDQKJc79Kx
        ItjnOBHIO+hZZ7y/Wax/sm9Nb7jnnyqY++LNXJK+R6HDebT8acLdXZqGbWpmwC1o/nUz77
        rMkZJUu9NywlLdgR+rGfyAaQV8fx+DXqp2sSwI+3kn5ll9ujslA/ErsKOCA9FCuKDNcJQP
        o/be+N1QXaJR5FKzGilurO5aUCSJJaC8OLyN5JXS5G0E3rEWKP0UncMtY5y0gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661802311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r/j7KNO+7MM3mzFiJUvn7EIiQIDtTMugi0upufP9SQ0=;
        b=hOtq073o5K6sicAm/uddiGxVSAkZst8NxCW06aIqp4LMHGMin7MjDkBwZCJIqsDwIt9kud
        wiQZIZf1Gj6AOnDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] random: use raw spinlocks for use on RT
Message-ID: <Yw0XRtgh2dmSM+T1@linutronix.de>
References: <20220801142530.133007-1-Jason@zx2c4.com>
 <YufkZU9kGkHHUhAK@linutronix.de>
 <YvRKm/IpbUID18FK@zx2c4.com>
 <YvSsf5uds7zGgWPX@linutronix.de>
 <YvUQJTDREXSAA9J6@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YvUQJTDREXSAA9J6@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-11 16:20:21 [+0200], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> By grouping everything into "the rework of get_random_*()", you miss
> important subtleties, as I mentioned before. Importantly, in this case,
> the issue we're facing has absolutely nothing at all to do with that,
> but is rather entirely the result of removing the async notifier
> mechanism in favor of doing things more directly, more straight
> forwardly. So let's not muddle what we're discussing here.

I meant the number of fallouts I saw on RT's side. The removal of the
async notifier is a different story and no complains on my side.

> But more generally, the RNG is supposed to be usable from any context.
> And adding wild workarounds, or worse, adding back complex async
> notifier stuff, seems bad. So far your proposals for the printk issue
> haven't been acceptable at all.

The printk issue a two way story:
- I tried to avoid the print out to the console because the code is not
  available yet and the recent reverts of already available code moved
  the missing bits further away. Linus wasn't happy with this, it wasn't
  merged so we have to wait for the code for the complete code.

- The vsnprintf issue I try to solve. This needs to work in any context
  due printk. printk needs to work in any context (incl. preempt-off)
  and it evaluates its format string upon invocation.

The second point needs to solved even after the first one has been
solved.

> So why don't we actually fix this, so we don't have to keep coming up
> with hacks? The question is: does using raw spinlocks over this code
> result in any real issue for RT latency? If so, I'd like to know where,
> and maybe I can do something about that (or maybe I can't). If not, then
> this is a non problem and I'll apply this patch with your blessing.

It depends on what you do define as hacks. I suggested an explicit init
during boot for everyone. The only "hacky" thing might be the reschedule
of the worker every two secs in case random-core isn't ready yet.

RNG may be used from any context but I doubt if this also includes any
context on RT. (Side note: it does not include NMI but in general any
context, yes.)
The work in hardirq context is limited on RT and therefore I doubt that
there is any need to request random numbers (from hardirq, preempt or
IRQ disabled context) on PREEMPT RT on a regular basis. We had (have)
requests where this is needed but we managed to avoid it.
Another example: While kmalloc() can be invoked from any context, it
still must not be used on PREEMPT_RT from hardirq context and or
preempt-disabled regions.

> If you don't want to spend time doing latency measurements, could you
> instead share a document or similar to the type of methodology you
> usually use for that, so I can do the same? And at the very least, I am
> simply curious and want to know more about the RT world.

Latency. If you check "now" and "patched" and look at the difference in
max. latency then this a good indication as a first step if you don't
see a difference. The next step is to hammer on the exposed API ensure
that it does not lead to any changes. If it does lead to changes then it
needs to be considered if the change is worth it or not.
A global raw_spinlock_t, which can be heavy contended, will be visible if
it is acquired from multiple CPUs at the same time (especially on a NUMA
box with 16+ CPUs).
A list which can is iterated under a lock and can be filled with many
items will be visible. Therefore swake_up_all() must not be invoked with
disabled interrupts and the function itself drops all locks after one
loop, simply not to block for too long.
In general, if it can be avoided to use raw_spinlock_t and does not hurt
performance too much then why not.

In order to do this (create a test and hammer on the exposed API), I
applied your patch and looked at the result from get_random_bytes()
perspective as in "can we do this?":

get_random_bytes()
-> _get_random_bytes()
  -> crng_make_state()
    -> local_lock_irqsave(&crngs.lock, flags);

So that local_lock_t is still breaking things since it can not be
acquired from blocking context. So in order to continue this needs to be
replaced somehow and checked again=E2=80=A6
Assuming this has been done, round #2:

get_random_bytes()
-> _get_random_bytes()
  -> crng_make_state()
    -> crng_reseed()
      -> extract_entropy()
        -> blake2s_final()
	  -> blake2s_compress()
	    -> kernel_fpu_begin()=E2=80=A6

This blake2s_compress() can be called again within this callchain (via
blake2s()). The problem here is that kernel_fpu_begin() disables
preemption and the following SIMD operation can be expensive (not to
mention the onetime register store) and so it is attempted to have a
scheduling point on a regular basis.
Invoking this call chain from an already preempt-disabled section would
not allow any scheduling at this point (and so build up the max. latency
worst case).

After looking at this after a break, while writing this and paging
everything in, I still think that initialising the random number at boot
up for vsprintf's sake is the easiest thing. One init for RT and non-RT
=66rom an initcall. No hack, just one plain and simple init with no need
to perform anything later on demand.=20

> Jason

Sebastian
