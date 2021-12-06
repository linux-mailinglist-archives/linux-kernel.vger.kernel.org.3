Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFA7469DA0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387540AbhLFPb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:31:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42974 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357849AbhLFPTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:19:17 -0500
Date:   Mon, 06 Dec 2021 15:15:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638803747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+uW1Cga0RiD6Y1VOJLmIas/qAaIB454K+5a7GdGvFk=;
        b=sGGVAJIglGn7RN/HGnJuFKyW3xmNLek29eRXmH+YXFA8lnO/XNbTBUkiM5Q0K0WKxVasn9
        d1L5Ef/XNAHR/FQZnvog+BeqkDIEevlnuOcFptITtmAFSBjYSxF0KiCzscOY495PFgH0H/
        eYg+Uy/u37cG58oeR1rtL7uXvzjxKZBu7v/yvx1wyP/PSaRBg7BSqmjYbMwGEERckouVgP
        ag2jzuxW5UJDPGWAv2aTwe6iE5hQ81mnxdbaVrviRRW15EHLWgVRnN2JTb7NQumNEJU6e4
        F8a+02+ur0zgO4C2CR1aH5rHxLagwsh+Lf3knJfIKnVCtTkq+MQrSagT0yh/MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638803747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+uW1Cga0RiD6Y1VOJLmIas/qAaIB454K+5a7GdGvFk=;
        b=gWVpxDfJvMQZHCsgG40ClSEC6YgMRB5F28lGJyCpoiLiEtJBpDHLta6UETqsYbPO9KM+Xk
        014ADx79P40veDBQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftests: Avoid using
 local_lock_{acquire|release}().
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129174654.668506-7-bigeasy@linutronix.de>
References: <20211129174654.668506-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163880374530.11128.14099889591098475504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fc78dd08e64011865799764d5b641bf823f84c66
Gitweb:        https://git.kernel.org/tip/fc78dd08e64011865799764d5b641bf823f84c66
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 29 Nov 2021 18:46:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:24 +01:00

lockdep/selftests: Avoid using local_lock_{acquire|release}().

The local_lock related functions
  local_lock_acquire()
  local_lock_release()

are part of the internal implementation and should be avoided.
Define the lock as DEFINE_PER_CPU so the normal local_lock() function
can be used.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211129174654.668506-7-bigeasy@linutronix.de
---
 lib/locking-selftest.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 71652e1..4d614c7 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -139,7 +139,7 @@ static DEFINE_RT_MUTEX(rtmutex_Z2);
 
 #endif
 
-static local_lock_t local_A = INIT_LOCAL_LOCK(local_A);
+static DEFINE_PER_CPU(local_lock_t, local_A);
 
 /*
  * non-inlined runtime initializers, to let separate locks share
@@ -1320,7 +1320,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
 # define I_MUTEX(x)	lockdep_reset_lock(&mutex_##x.dep_map)
 # define I_RWSEM(x)	lockdep_reset_lock(&rwsem_##x.dep_map)
 # define I_WW(x)	lockdep_reset_lock(&x.dep_map)
-# define I_LOCAL_LOCK(x) lockdep_reset_lock(&local_##x.dep_map)
+# define I_LOCAL_LOCK(x) lockdep_reset_lock(this_cpu_ptr(&local_##x.dep_map))
 #ifdef CONFIG_RT_MUTEXES
 # define I_RTMUTEX(x)	lockdep_reset_lock(&rtmutex_##x.dep_map)
 #endif
@@ -1380,7 +1380,7 @@ static void reset_locks(void)
 	init_shared_classes();
 	raw_spin_lock_init(&raw_lock_A);
 	raw_spin_lock_init(&raw_lock_B);
-	local_lock_init(&local_A);
+	local_lock_init(this_cpu_ptr(&local_A));
 
 	ww_mutex_init(&o, &ww_lockdep); ww_mutex_init(&o2, &ww_lockdep); ww_mutex_init(&o3, &ww_lockdep);
 	memset(&t, 0, sizeof(t)); memset(&t2, 0, sizeof(t2));
@@ -2646,8 +2646,8 @@ static void wait_context_tests(void)
 
 static void local_lock_2(void)
 {
-	local_lock_acquire(&local_A);	/* IRQ-ON */
-	local_lock_release(&local_A);
+	local_lock(&local_A);	/* IRQ-ON */
+	local_unlock(&local_A);
 
 	HARDIRQ_ENTER();
 	spin_lock(&lock_A);		/* IN-IRQ */
@@ -2656,18 +2656,18 @@ static void local_lock_2(void)
 
 	HARDIRQ_DISABLE();
 	spin_lock(&lock_A);
-	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle, false */
-	local_lock_release(&local_A);
+	local_lock(&local_A);	/* IN-IRQ <-> IRQ-ON cycle, false */
+	local_unlock(&local_A);
 	spin_unlock(&lock_A);
 	HARDIRQ_ENABLE();
 }
 
 static void local_lock_3A(void)
 {
-	local_lock_acquire(&local_A);	/* IRQ-ON */
+	local_lock(&local_A);	/* IRQ-ON */
 	spin_lock(&lock_B);		/* IRQ-ON */
 	spin_unlock(&lock_B);
-	local_lock_release(&local_A);
+	local_unlock(&local_A);
 
 	HARDIRQ_ENTER();
 	spin_lock(&lock_A);		/* IN-IRQ */
@@ -2676,18 +2676,18 @@ static void local_lock_3A(void)
 
 	HARDIRQ_DISABLE();
 	spin_lock(&lock_A);
-	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_lock(), false */
-	local_lock_release(&local_A);
+	local_lock(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_lock(), false */
+	local_unlock(&local_A);
 	spin_unlock(&lock_A);
 	HARDIRQ_ENABLE();
 }
 
 static void local_lock_3B(void)
 {
-	local_lock_acquire(&local_A);	/* IRQ-ON */
+	local_lock(&local_A);	/* IRQ-ON */
 	spin_lock(&lock_B);		/* IRQ-ON */
 	spin_unlock(&lock_B);
-	local_lock_release(&local_A);
+	local_unlock(&local_A);
 
 	HARDIRQ_ENTER();
 	spin_lock(&lock_A);		/* IN-IRQ */
@@ -2696,8 +2696,8 @@ static void local_lock_3B(void)
 
 	HARDIRQ_DISABLE();
 	spin_lock(&lock_A);
-	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_lock(), false */
-	local_lock_release(&local_A);
+	local_lock(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_lock(), false */
+	local_unlock(&local_A);
 	spin_unlock(&lock_A);
 	HARDIRQ_ENABLE();
 
@@ -2812,7 +2812,7 @@ void locking_selftest(void)
 	printk("------------------------\n");
 	printk("| Locking API testsuite:\n");
 	printk("----------------------------------------------------------------------------\n");
-	printk("                                 | spin |wlock |rlock |mutex | wsem | rsem |\n");
+	printk("                                 | spin |wlock |rlock |mutex | wsem | rsem |rtmutex\n");
 	printk("  --------------------------------------------------------------------------\n");
 
 	init_shared_classes();
