Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E23469D9A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387401AbhLFPbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:31:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42972 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356400AbhLFPTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:19:15 -0500
Date:   Mon, 06 Dec 2021 15:15:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638803745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XiPdxskC41Qn5OTvyupEvpjSycavsgfwXJ56NTxJfu8=;
        b=ejFAWDbphT412YfCJZuy/tTddD5wY4lV0Fh1xgLcfV1lCjNZ0GX5iX6PBxiA0yIvu9taP+
        82imHEP1roxiQZEKenoB80ZV6tbEFtOUTyOGLzO9cy7XSr8XP92H+Fg7MQfLddbFEplzOH
        Vf6ok3HaCydhTGmAATgrmfy0ARFR3OYIIpG+fdsyH2fjAFdbBoDXzo3SH180gAYKzvJmjm
        CuAQ4X4ZkSa1Ov9xAKTHGkVYNRCDf6Rwg8x3q7f47CSborZOEiNdjKd681d0UioCnsXpPG
        JTO+GlEn5sndJAmB58n8XEPcb6jZRcyHslKgngxOAIRgqz+UQDoexHOhuvyf9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638803745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XiPdxskC41Qn5OTvyupEvpjSycavsgfwXJ56NTxJfu8=;
        b=RYkXWurT5z9qafIWOFn2aG2rNNEFTQtz5ea2srdR+/lmUvd5E8bDN7KYoSW5uwLZV5ld9L
        7ACvf1gd76GG9CBA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftests: Unbalanced migrate_disable() &
 rcu_read_lock().
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129174654.668506-8-bigeasy@linutronix.de>
References: <20211129174654.668506-8-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163880374446.11128.9971042846476247131.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     512bf713cb4c8a42ae76e5ba1a78e70a768af301
Gitweb:        https://git.kernel.org/tip/512bf713cb4c8a42ae76e5ba1a78e70a768af301
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 29 Nov 2021 18:46:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:24 +01:00

lockdep/selftests: Unbalanced migrate_disable() & rcu_read_lock().

The tests with unbalanced lock() + unlock() operation leave a modified
preemption counter behind which is then reset to its original value
after the test.

The spin_lock() function on PREEMPT_RT does not include a
preempt_disable() statement but migrate_disable() and read_rcu_lock().
As a consequence both counter never get back to their original value
and the system explodes later after the selftest.  In the
double-unlock case on PREEMPT_RT, the migrate_disable() and RCU code
will trigger a warning which should be avoided. These counter should
not be decremented below their initial value.

Save both counters and bring them back to their original value after
the test.  In the double-unlock case, increment both counter in
advance to they become balanced after the double unlock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211129174654.668506-8-bigeasy@linutronix.de
---
 lib/locking-selftest.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 4d614c7..417056b 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -712,12 +712,18 @@ GENERATE_TESTCASE(ABCDBCDA_rtmutex);
 
 #undef E
 
+#ifdef CONFIG_PREEMPT_RT
+# define RT_PREPARE_DBL_UNLOCK()	{ migrate_disable(); rcu_read_lock(); }
+#else
+# define RT_PREPARE_DBL_UNLOCK()
+#endif
 /*
  * Double unlock:
  */
 #define E()					\
 						\
 	LOCK(A);				\
+	RT_PREPARE_DBL_UNLOCK();		\
 	UNLOCK(A);				\
 	UNLOCK(A); /* fail */
 
@@ -1398,7 +1404,13 @@ static int unexpected_testcase_failures;
 
 static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 {
-	unsigned long saved_preempt_count = preempt_count();
+	int saved_preempt_count = preempt_count();
+#ifdef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SMP
+	int saved_mgd_count = current->migration_disabled;
+#endif
+	int saved_rcu_count = current->rcu_read_lock_nesting;
+#endif
 
 	WARN_ON(irqs_disabled());
 
@@ -1432,6 +1444,18 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 	 * count, so restore it:
 	 */
 	preempt_count_set(saved_preempt_count);
+
+#ifdef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SMP
+	while (current->migration_disabled > saved_mgd_count)
+		migrate_enable();
+#endif
+
+	while (current->rcu_read_lock_nesting > saved_rcu_count)
+		rcu_read_unlock();
+	WARN_ON_ONCE(current->rcu_read_lock_nesting < saved_rcu_count);
+#endif
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 	if (softirq_count())
 		current->softirqs_enabled = 0;
