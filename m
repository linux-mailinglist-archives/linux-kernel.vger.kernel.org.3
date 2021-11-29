Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA206462511
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhK2WfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhK2Wey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:34:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897D8C0C2368
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:48:29 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638208108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4POHWttKDLCioDdhd9nXuhpJiEq71/owpp/FCDooROs=;
        b=FWWAdxROtb8WLQ9QbZQNR+fyYDvU7tt8IXttvVA8/MCTkI4tEuqlwtkvq2E2EMAyJikzim
        gUhswMUVJpD4XYOrueOKhTFXyO1VPJlclp1TnObYgm4UIEYT2MTXWT/VF1htQlgDx17sOI
        NksbWGAT2DpeTC+h5gFgljZzkt86LTL0KxegoTUUmSrsxmwk3paRP61N1/PBEjsRQWBCBa
        uSOLp6NX8My0p5cVq1Pnwn7Nh3Z6MWJbguM4JKmse1rIeklJ/y+UQQPz+ImKE5YTGBeca2
        WEqrDz3d20ql7e0d0YKOiUSwwYi+hFVGQR1pYsySWsLSxAj3tmwnaYBCjOctSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638208108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4POHWttKDLCioDdhd9nXuhpJiEq71/owpp/FCDooROs=;
        b=k6tfiuKAxLH7O5tpmqCVFL+qud+SaxzYkKes3o+rvlvIvFRqatzNqtvTaNGq+kvrBPQtC7
        cQZZynPm41KQSiAg==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 05/11] lockdep: Remove softirq accounting on PREEMPT_RT.
Date:   Mon, 29 Nov 2021 18:46:48 +0100
Message-Id: <20211129174654.668506-6-bigeasy@linutronix.de>
In-Reply-To: <20211129174654.668506-1-bigeasy@linutronix.de>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There is not really a softirq context on PREEMPT_RT.
Softirqs on PREEMPT_RT are always invoked within the context of a
threaded interrupt handler or within ksoftirqd. The "in-softirq" context
is preemptible and is protected by a per-CPU lock to ensure mutual
exclusion.

There is no difference on PREEMPT_RT between spin_lock_irq() and
spin_lock() because the former does not disable interrupts. Therefore if
a lock is used in_softirq() and locked once with spin_lock_irq() then
lockdep will report this with "inconsistent {SOFTIRQ-ON-W} ->
{IN-SOFTIRQ-W} usage".

Teach lockdep that we don't really do softirqs on -RT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqflags.h | 23 +++++++++++++++--------
 kernel/locking/lockdep.c |  2 ++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 600c10da321a7..4b140938b03e2 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -71,14 +71,6 @@ do {						\
 do {						\
 	__this_cpu_dec(hardirq_context);	\
 } while (0)
-# define lockdep_softirq_enter()		\
-do {						\
-	current->softirq_context++;		\
-} while (0)
-# define lockdep_softirq_exit()			\
-do {						\
-	current->softirq_context--;		\
-} while (0)
=20
 # define lockdep_hrtimer_enter(__hrtimer)		\
 ({							\
@@ -140,6 +132,21 @@ do {						\
 # define lockdep_irq_work_exit(__work)		do { } while (0)
 #endif
=20
+#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_PREEMPT_RT)
+# define lockdep_softirq_enter()		\
+do {						\
+	current->softirq_context++;		\
+} while (0)
+# define lockdep_softirq_exit()			\
+do {						\
+	current->softirq_context--;		\
+} while (0)
+
+#else
+# define lockdep_softirq_enter()		do { } while (0)
+# define lockdep_softirq_exit()			do { } while (0)
+#endif
+
 #if defined(CONFIG_IRQSOFF_TRACER) || \
 	defined(CONFIG_PREEMPT_TRACER)
  extern void stop_critical_timings(void);
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2270ec68f10a1..4a882f83aeb9d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5485,6 +5485,7 @@ static noinstr void check_flags(unsigned long flags)
 		}
 	}
=20
+#ifndef CONFIG_PREEMPT_RT
 	/*
 	 * We dont accurately track softirq state in e.g.
 	 * hardirq contexts (such as on 4KSTACKS), so only
@@ -5499,6 +5500,7 @@ static noinstr void check_flags(unsigned long flags)
 			DEBUG_LOCKS_WARN_ON(!current->softirqs_enabled);
 		}
 	}
+#endif
=20
 	if (!debug_locks)
 		print_irqtrace_events(current);
--=20
2.34.0

