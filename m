Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331A74F0C68
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 21:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349900AbiDCTxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 15:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbiDCTxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 15:53:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8840439BBD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 12:51:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649015485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5brMuV3LJJmOT0RQBfECx6oyNlUjF1TBz/ROW1AryfQ=;
        b=UnePd4yyu8/0ppI5Xm9QOJ0WARxcZfyLFZzYII2iPTVav8qNy7I25cskW/4t60v2U9+Jz2
        fq+WVHZtzwo5O1HkkEKXghTC2pIYm9t5Ni3Yr5zwfqNJC/TxPyoT6NqpnSIg6pk9tVFxmZ
        oC9nLH8SkGelOY/Zi1SyhzCZAQYaAyno5TBAKdonO6rR7ADShdMNa0UQjmwph4WjWWMxcw
        P4iRn4oFXb/3l6kaTzys7fpuuW6qmm9dDgXY7x8tTalwQ+sDFukBtdVkjhw5zp6PgvESTk
        xMKw2HsHiwQr4EOPivgw+O2wLz6VvZErwL3v6o79xt2gUyOwOYcoS8H5zgZT/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649015485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5brMuV3LJJmOT0RQBfECx6oyNlUjF1TBz/ROW1AryfQ=;
        b=El3dQX85rrx7Oa/K/MW4kmlhRlka1A8xhCYQTYqWDguvQMB2BZ0mpWnh46R+EiSYgewmPk
        RAKYZK2pWx+dzdAw==
To:     Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: UML time-travel warning from __run_timers
In-Reply-To: <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
References: <20220330110156.GA9250@axis.com>
 <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
 <877d86m978.ffs@tglx>
 <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
Date:   Sun, 03 Apr 2022 21:51:24 +0200
Message-ID: <87pmlykksj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03 2022 at 19:13, Johannes Berg wrote:
> On Sun, 2022-04-03 at 18:18 +0200, Thomas Gleixner wrote:
>> On Sat, Apr 02 2022 at 16:09, Johannes Berg wrote:
> There was no timer. If there's ever a timer on this base (BASE_DEF) then
> this doesn't happen.

You said:

>> > init_timer_cpu(0) base 0 clk=0xffff8ad0, next_expiry=0x13fff8acf
>> > init_timer_cpu(0) base 1 clk=0xffff8ad0, next_expiry=0x13fff8acf

which confused me. It's actually initialized to:

      base->clk + NEXT_TIMER_MAX_DELTA

but that's fine and it is overwritten by every timer which is inserted
to expire before that. So that's not an issue as the prandom timer is
firing and rearmed.

That would not happen if next_expiry would stay at 0x13fff8acf. The
first one in your trace expires at 5339070200, i.e.  0x13e3bbef8, which
is way before that.

So that 0x13fff8acf thing is really a red herring.

> Sure, but since we simulate ~50 days of uptime, that's a massive number
> of events and lots of them are not there:

Thanks for providing that. This does not give much of an hint. jiffies,
base clock and clock monotonic advance as expected. The prandom timer
seems to be the only timer which is armed here, but of course the trace
does not go far enough back to be sure. OTOH, there is no timer canceled
just before that which might trigger this. I suspect that's a base
forward call missing and I have a nagging feeling where, but I'm not
sure.

Can you please apply the debug patch below and run with the same
parameters as before?

Thanks,

        tglx
---
Hint: I tried to figure out how to use that time travel muck, but did
      not get to the point where I bothered to try myself. Might be
      either my incompetence or lack of documentation. Clearly the bug
      report lacks any hint how to reproduce that problem.
---

--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -52,15 +52,19 @@ DEFINE_EVENT(timer_class, timer_init,
 TRACE_EVENT(timer_start,
 
 	TP_PROTO(struct timer_list *timer,
-		unsigned long expires,
-		unsigned int flags),
+		 unsigned long expires,
+		 unsigned long bucket_expiry,
+		 unsigned long next_expiry,
+		 unsigned int flags),
 
-	TP_ARGS(timer, expires, flags),
+	TP_ARGS(timer, expires, bucket_expiry, next_expiry, flags),
 
 	TP_STRUCT__entry(
 		__field( void *,	timer		)
 		__field( void *,	function	)
 		__field( unsigned long,	expires		)
+		__field( unsigned long,	bucket_expiry	)
+		__field( unsigned long,	next_expiry	)
 		__field( unsigned long,	now		)
 		__field( unsigned int,	flags		)
 	),
@@ -69,13 +73,16 @@ TRACE_EVENT(timer_start,
 		__entry->timer		= timer;
 		__entry->function	= timer->function;
 		__entry->expires	= expires;
+		__entry->bucket_expiry	= bucket_expiry;
+		__entry->next_expiry	= next_expiry;
 		__entry->now		= jiffies;
 		__entry->flags		= flags;
 	),
 
-	TP_printk("timer=%p function=%ps expires=%lu [timeout=%ld] cpu=%u idx=%u flags=%s",
+	TP_printk("timer=%p function=%ps expires=%lu [timeout=%ld] bucket_expiry=%lu next_expiry=%lu cpu=%u idx=%u flags=%s",
 		  __entry->timer, __entry->function, __entry->expires,
 		  (long)__entry->expires - __entry->now,
+		  __entry->bucket_expiry, __entry->next_expiry,
 		  __entry->flags & TIMER_CPUMASK,
 		  __entry->flags >> TIMER_ARRAYSHIFT,
 		  decode_timer_flags(__entry->flags & TIMER_TRACE_FLAGMASK))
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -583,8 +583,6 @@ static void enqueue_timer(struct timer_b
 	__set_bit(idx, base->pending_map);
 	timer_set_idx(timer, idx);
 
-	trace_timer_start(timer, timer->expires, timer->flags);
-
 	/*
 	 * Check whether this is the new first expiring timer. The
 	 * effective expiry time of the timer is required here
@@ -600,6 +598,7 @@ static void enqueue_timer(struct timer_b
 		base->next_expiry_recalc = false;
 		trigger_dyntick_cpu(base, timer);
 	}
+	trace_timer_start(timer, timer->expires, bucket_expiry, base->next_expiry, timer->flags);
 }
 
 static void internal_add_timer(struct timer_base *base, struct timer_list *timer)
@@ -893,6 +892,9 @@ static inline void forward_timer_base(st
 {
 	unsigned long jnow = READ_ONCE(jiffies);
 
+	trace_printk("FWD: now=%lu clk=%lu next_expiry=%lu recalc=%d\n",
+		     jnow, base->clk, base->next_expiry,
+		     base->next_expiry_recalc);
 	/*
 	 * No need to forward if we are close enough below jiffies.
 	 * Also while executing timers, base->clk is 1 offset ahead
@@ -1710,6 +1712,7 @@ void timer_clear_idle(void)
 static inline void __run_timers(struct timer_base *base)
 {
 	struct hlist_head heads[LVL_DEPTH];
+	bool confused = false;
 	int levels;
 
 	if (time_before(jiffies, base->next_expiry))
@@ -1718,6 +1721,10 @@ static inline void __run_timers(struct t
 	timer_base_lock_expiry(base);
 	raw_spin_lock_irq(&base->lock);
 
+	trace_printk("RUN: now=%lu clk=%lu next_expiry=%lu recalc=%d\n",
+		     jiffies, base->clk, base->next_expiry,
+		     base->next_expiry_recalc);
+
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
 		levels = collect_expired_timers(base, heads);
@@ -1726,7 +1733,12 @@ static inline void __run_timers(struct t
 		 * timer at this clk is that all matching timers have been
 		 * dequeued.
 		 */
-		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
+		if (!levels && !base->next_expiry_recalc) {
+			trace_printk("WTH: now=%lu clk=%lu next_expiry=%lu recalc=%d\n",
+				     jiffies, base->clk, base->next_expiry,
+				     base->next_expiry_recalc);
+			confused = true;
+		}
 		base->clk++;
 		base->next_expiry = __next_timer_interrupt(base);
 
@@ -1735,6 +1747,9 @@ static inline void __run_timers(struct t
 	}
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
+
+	if (confused)
+		panic("Confused");
 }
 
 /*



