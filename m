Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEFF469D80
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350963AbhLFP37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:29:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42978 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244690AbhLFPTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:19:18 -0500
Date:   Mon, 06 Dec 2021 15:15:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638803747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tY/3BcngD87GBfij22uw4zmg58s1oiPnQ3wUX4epSuk=;
        b=e/v1SVZ08YYj26hVYkqHWf8NFuViuCX1iNHgMF/h6iUMgL90xVeMWKWag80PhVBZwuCGRZ
        as16S93465CPvuLRcTHzndQvJX/QPsYKg31mBL7dVLOf27nh+N0wAWpSfnoB+bB2Ap16ip
        ZfVQ+7k7bo8ZGmvZmZ84g3tRVxIRZHEPkhs7b34wI63cNgOqryBWqEWFSWGy/Oe30rrDl6
        acccqDRZZl2tyXD62tehGvZAAW5fhvVKr7FkKvR6tmbh25phsLw0qo2PwGgYJzhcgOF7CX
        5Jr0+L1OnC9Du8NJFM6pqUdg2zu42Z7XeQb3rorBP5hkPL/3+P6RPa1A3WiHRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638803747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tY/3BcngD87GBfij22uw4zmg58s1oiPnQ3wUX4epSuk=;
        b=d7wOuD07A85Pw/rGhxsAB7cOn16tXwKtIQhV05PohP6FguLkqdCYBIBgKUjYVeyWbyKTZy
        TC5DC2fPmy5jk3BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Remove softirq accounting on PREEMPT_RT.
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129174654.668506-6-bigeasy@linutronix.de>
References: <20211129174654.668506-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163880374685.11128.16947312483583939101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0c1d7a2c2d32fac7ff4a644724b2d52a64184645
Gitweb:        https://git.kernel.org/tip/0c1d7a2c2d32fac7ff4a644724b2d52a64184645
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 29 Nov 2021 18:46:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:23 +01:00

lockdep: Remove softirq accounting on PREEMPT_RT.

There is not really a softirq context on PREEMPT_RT.  Softirqs on
PREEMPT_RT are always invoked within the context of a threaded
interrupt handler or within ksoftirqd. The "in-softirq" context is
preemptible and is protected by a per-CPU lock to ensure mutual
exclusion.

There is no difference on PREEMPT_RT between spin_lock_irq() and
spin_lock() because the former does not disable interrupts. Therefore
if a lock is used in_softirq() and locked once with spin_lock_irq()
then lockdep will report this with "inconsistent {SOFTIRQ-ON-W} ->
{IN-SOFTIRQ-W} usage".

Teach lockdep that we don't really do softirqs on -RT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211129174654.668506-6-bigeasy@linutronix.de
---
 include/linux/irqflags.h | 23 +++++++++++++++--------
 kernel/locking/lockdep.c |  2 ++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 600c10d..4b14093 100644
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
 
 # define lockdep_hrtimer_enter(__hrtimer)		\
 ({							\
@@ -140,6 +132,21 @@ do {						\
 # define lockdep_irq_work_exit(__work)		do { } while (0)
 #endif
 
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
index 2270ec6..4a882f8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5485,6 +5485,7 @@ static noinstr void check_flags(unsigned long flags)
 		}
 	}
 
+#ifndef CONFIG_PREEMPT_RT
 	/*
 	 * We dont accurately track softirq state in e.g.
 	 * hardirq contexts (such as on 4KSTACKS), so only
@@ -5499,6 +5500,7 @@ static noinstr void check_flags(unsigned long flags)
 			DEBUG_LOCKS_WARN_ON(!current->softirqs_enabled);
 		}
 	}
+#endif
 
 	if (!debug_locks)
 		print_irqtrace_events(current);
