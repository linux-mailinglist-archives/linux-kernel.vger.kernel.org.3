Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93E357FDC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiGYKoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiGYKoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:44:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61C117AA6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B5A7B80E34
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADE5C341D0;
        Mon, 25 Jul 2022 10:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658745839;
        bh=SIEGUQ5Q04zXsvsc/r0VeRJSZc3lRCx2nAVNGrTCr/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WA+lPvdluY3A+enxSTudJwEsv4MmhaIir5P9OBQi8yeGlDW2SkZJgituhxagUnRmC
         rQiB+TPuDF2P9csKOwXujJiA9O8/BloWyZSKfPVWKValbdUmL+cVB5waW5DYsPSRzQ
         jLfduLm1Bf3WtjPCiw+aCtZ6rrJfXvd9P5+mYe3Xn7CKWz8FCaIsHVLe02w8qdPrR7
         F7yCYGtXQnzbsdpZcbRskXJFBv0q3yjEVpZ/1yp+jpoQ1iSH9lNKnJR7eY96BNkv1K
         DjTPvGz8jYSIEBaTqAdvb0AHjtBGy71LsBs+yffjgmhQYDT8Nb5nWxxUM6nvWtE0+a
         YsvwM0FsA5Dqg==
Date:   Mon, 25 Jul 2022 12:43:56 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@infradead.org>,
        Chris Mason <clm@fb.com>, Eric Dumazet <edumazet@google.com>,
        George Spelvin <linux@sciencehorizons.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Len Brown <lenb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [Question] timers: trigger_dyntick_cpu() vs TIMER_DEFERRABLE
Message-ID: <20220725104356.GA2950296@lothringen>
References: <xhsmhedy9fsg5.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhedy9fsg5.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:32:42AM +0100, Valentin Schneider wrote:
> Hi,
> 
> I've been incidentally staring at some NOHZ bits related to the timer
> wheels, and trigger_dyntick_cpu() confuses me:
> 
>   static void
>   trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
>   {
>           [...]
>           /*
>            * TODO: This wants some optimizing similar to the code below, but we
>            * will do that when we switch from push to pull for deferrable timers.
>            */
>           if ((timer->flags & TIMER_DEFERRABLE)) {
>                   if (tick_nohz_full_cpu(base->cpu))
>                           wake_up_nohz_cpu(base->cpu);
>                   return;
>           }
>           [...]
>   }
> 
> From what I grok out of get_nohz_timer_target(), under
> timers_migration_enabled we should migrate the timer to an non-idle CPU
> (or at the very least a non-isolated CPU) *before* enqueuing the
> timer.

That's not always the case. For example TIMER_PINNED timers might have
to run on a buzy or isolated CPU.

And note that even when (base->cpu == smp_processor_id()) we want to kick
the current CPU with a self-IPI. This way we force, from IRQ-tail, the
tick to recalculate the next deadline to fire, considering the new enqueued
timer callback.

> Without timers_migration_enabled (or if TIMER_PINNED), I don't see
> anything that could migrate the timer elsewhere, so:
> 
> Why bother kicking a NOHZ CPU for a deferrable timer if it is the next
> expiring one? Per the definition:
> 
>  * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
>  * system is busy, but will not cause a CPU to come out of idle just
>  * to service it; instead, the timer will be serviced when the CPU
>  * eventually wakes up with a subsequent non-deferrable timer.
> 
> I tried to find some discussion over this in LKML, but found nothing.
> v3 of the patch did *not* kick a CPU for a deferrable timer, but v4 (the
> one that ended up merged) did (see below). Patch in question is:
> 
>   a683f390b93f ("timers: Forward the wheel clock whenever possible")

Because TIMER_DEFERRABLE timers should only be deferred when the CPU is
in "nohz-idle". If the CPU runs an actual task with the tick shutdown
("nohz-full"), we should execute those deferrable timers.

Now that's the theory. In practice the deferrable timers are ignored by
both nohz-idle and nohz-full when it comes to compute the next nohz delta.
This is a mistake that is there since the introduction of nohz-full but I've
always been scared to break some user setup while fixing it. Anyway things
should look like this (untested):

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index de192dcff828..5f8ef777a785 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -819,7 +819,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 		 * disabled this also looks at the next expiring
 		 * hrtimer.
 		 */
-		next_tick = get_next_timer_interrupt(basejiff, basemono);
+		next_tick = get_next_timer_interrupt(basejiff, basemono, ts->inidle);
 		ts->next_timer = next_tick;
 	}
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 717fcb9fb14a..8279d4e9b7a0 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -574,16 +574,6 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 	if (!is_timers_nohz_active())
 		return;
 
-	/*
-	 * TODO: This wants some optimizing similar to the code below, but we
-	 * will do that when we switch from push to pull for deferrable timers.
-	 */
-	if (timer->flags & TIMER_DEFERRABLE) {
-		if (tick_nohz_full_cpu(base->cpu))
-			wake_up_nohz_cpu(base->cpu);
-		return;
-	}
-
 	/*
 	 * We might have to IPI the remote CPU if the base is idle and the
 	 * timer is not deferrable. If the other CPU is on the way to idle
@@ -1678,17 +1668,9 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
-/**
- * get_next_timer_interrupt - return the time (clock mono) of the next timer
- * @basej:	base time jiffies
- * @basem:	base time clock monotonic
- *
- * Returns the tick aligned clock monotonic time of the next pending
- * timer or KTIME_MAX if no timer is pending.
- */
-u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
+static u64 get_next_base_interrupt(struct timer_base *base,
+				   unsigned long basej, u64 basem)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	u64 expires = KTIME_MAX;
 	unsigned long nextevt;
 
@@ -1734,6 +1716,32 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	}
 	raw_spin_unlock(&base->lock);
 
+	return expires;
+}
+
+/**
+ * get_next_timer_interrupt - return the time (clock mono) of the next timer
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ * @idle:	is the CPU idle?
+ *
+ * Returns the tick aligned clock monotonic time of the next pending
+ * timer or KTIME_MAX if no timer is pending.
+ */
+u64 get_next_timer_interrupt(unsigned long basej, u64 basem, bool idle)
+{
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	u64 expires;
+
+	expires = get_next_base_interrupt(base, basej, basem);
+	if (!idle) {
+		u64 expires_def;
+
+		base = this_cpu_ptr(&timer_bases[BASE_DEF]);
+		expires_def = get_next_base_interrupt(base, basej, basem);
+		expires = min(expires, expires_def);
+	}
+
 	return cmp_next_hrtimer_event(basem, expires);
 }
 
@@ -1744,15 +1752,15 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
  */
 void timer_clear_idle(void)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
-
 	/*
 	 * We do this unlocked. The worst outcome is a remote enqueue sending
 	 * a pointless IPI, but taking the lock would just make the window for
 	 * sending the IPI a few instructions smaller for the cost of taking
 	 * the lock in the exit from idle path.
 	 */
-	base->is_idle = false;
+	__this_cpu_write(timer_bases[BASE_STD].is_idle, false);
+	if (tick_nohz_full_cpu(smp_processor_id()))
+		__this_cpu_write(timer_bases[BASE_DEF].is_idle, false);
 }
 #endif
 
