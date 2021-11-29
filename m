Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E7461D08
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbhK2Rxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:53:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55122 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242373AbhK2Rvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:51:47 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638208108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aD5tNwOzjlRa7vHPxJ8kq9equXtZi3bRfTG+iHTXwXw=;
        b=UWlLh9lud5niaaJgDGxY+NKzYznAennCcYI0GO9Sib8sTvkrGUiP6Fp3QxLS7trqzuK+6a
        ez9INcT5E/UR4Ppa5djd1xgdtgf8KNXA1LD1djEM4OE6gXlhnpZLqZkSYMUKoXLZ54CiqW
        TLJZ591tbcXtqEFaU1VqOGcYPOPMYQ4o8ZJuFHcAiZEWVMHYEL/GXHTleyxXmE2n3IsyUP
        mVZFeH6VW6Qo+oO3a7U72qKuS1xXD33kO3rNs97G4GhOx311o5CopZ0t7B9np4dk7J1q3m
        wWA5PsNkNFehaR7PxcAe944/g9hFoY6ZX1QTKVdEi9jDILOy2yep8Vuh+F9vLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638208108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aD5tNwOzjlRa7vHPxJ8kq9equXtZi3bRfTG+iHTXwXw=;
        b=hZO/tcm32r0MCD5Fd+vFPnGt/xaDo3LjNAX5EkBGXZ72+Lt0ETs0MaFeVf7vNKN28c3pR4
        PrygM+LyCVANVNAg==
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
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 06/11] lockdep/selftests: Avoid using local_lock_{acquire|release}().
Date:   Mon, 29 Nov 2021 18:46:49 +0100
Message-Id: <20211129174654.668506-7-bigeasy@linutronix.de>
In-Reply-To: <20211129174654.668506-1-bigeasy@linutronix.de>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local_lock related functions
  local_lock_acquire()
  local_lock_release()

are part of the internal implementation and should be avoided.
Define the lock as DEFINE_PER_CPU so the normal local_lock() function
can be used.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/locking-selftest.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 71652e1c397cf..4d614c74e6ec5 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -139,7 +139,7 @@ static DEFINE_RT_MUTEX(rtmutex_Z2);
=20
 #endif
=20
-static local_lock_t local_A =3D INIT_LOCAL_LOCK(local_A);
+static DEFINE_PER_CPU(local_lock_t, local_A);
=20
 /*
  * non-inlined runtime initializers, to let separate locks share
@@ -1320,7 +1320,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_so=
ft_wlock)
 # define I_MUTEX(x)	lockdep_reset_lock(&mutex_##x.dep_map)
 # define I_RWSEM(x)	lockdep_reset_lock(&rwsem_##x.dep_map)
 # define I_WW(x)	lockdep_reset_lock(&x.dep_map)
-# define I_LOCAL_LOCK(x) lockdep_reset_lock(&local_##x.dep_map)
+# define I_LOCAL_LOCK(x) lockdep_reset_lock(this_cpu_ptr(&local_##x.dep_ma=
p))
 #ifdef CONFIG_RT_MUTEXES
 # define I_RTMUTEX(x)	lockdep_reset_lock(&rtmutex_##x.dep_map)
 #endif
@@ -1380,7 +1380,7 @@ static void reset_locks(void)
 	init_shared_classes();
 	raw_spin_lock_init(&raw_lock_A);
 	raw_spin_lock_init(&raw_lock_B);
-	local_lock_init(&local_A);
+	local_lock_init(this_cpu_ptr(&local_A));
=20
 	ww_mutex_init(&o, &ww_lockdep); ww_mutex_init(&o2, &ww_lockdep); ww_mutex=
_init(&o3, &ww_lockdep);
 	memset(&t, 0, sizeof(t)); memset(&t2, 0, sizeof(t2));
@@ -2646,8 +2646,8 @@ static void wait_context_tests(void)
=20
 static void local_lock_2(void)
 {
-	local_lock_acquire(&local_A);	/* IRQ-ON */
-	local_lock_release(&local_A);
+	local_lock(&local_A);	/* IRQ-ON */
+	local_unlock(&local_A);
=20
 	HARDIRQ_ENTER();
 	spin_lock(&lock_A);		/* IN-IRQ */
@@ -2656,18 +2656,18 @@ static void local_lock_2(void)
=20
 	HARDIRQ_DISABLE();
 	spin_lock(&lock_A);
-	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle, false */
-	local_lock_release(&local_A);
+	local_lock(&local_A);	/* IN-IRQ <-> IRQ-ON cycle, false */
+	local_unlock(&local_A);
 	spin_unlock(&lock_A);
 	HARDIRQ_ENABLE();
 }
=20
 static void local_lock_3A(void)
 {
-	local_lock_acquire(&local_A);	/* IRQ-ON */
+	local_lock(&local_A);	/* IRQ-ON */
 	spin_lock(&lock_B);		/* IRQ-ON */
 	spin_unlock(&lock_B);
-	local_lock_release(&local_A);
+	local_unlock(&local_A);
=20
 	HARDIRQ_ENTER();
 	spin_lock(&lock_A);		/* IN-IRQ */
@@ -2676,18 +2676,18 @@ static void local_lock_3A(void)
=20
 	HARDIRQ_DISABLE();
 	spin_lock(&lock_A);
-	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count=
 local_lock(), false */
-	local_lock_release(&local_A);
+	local_lock(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_l=
ock(), false */
+	local_unlock(&local_A);
 	spin_unlock(&lock_A);
 	HARDIRQ_ENABLE();
 }
=20
 static void local_lock_3B(void)
 {
-	local_lock_acquire(&local_A);	/* IRQ-ON */
+	local_lock(&local_A);	/* IRQ-ON */
 	spin_lock(&lock_B);		/* IRQ-ON */
 	spin_unlock(&lock_B);
-	local_lock_release(&local_A);
+	local_unlock(&local_A);
=20
 	HARDIRQ_ENTER();
 	spin_lock(&lock_A);		/* IN-IRQ */
@@ -2696,8 +2696,8 @@ static void local_lock_3B(void)
=20
 	HARDIRQ_DISABLE();
 	spin_lock(&lock_A);
-	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count=
 local_lock(), false */
-	local_lock_release(&local_A);
+	local_lock(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_l=
ock(), false */
+	local_unlock(&local_A);
 	spin_unlock(&lock_A);
 	HARDIRQ_ENABLE();
=20
@@ -2812,7 +2812,7 @@ void locking_selftest(void)
 	printk("------------------------\n");
 	printk("| Locking API testsuite:\n");
 	printk("-----------------------------------------------------------------=
-----------\n");
-	printk("                                 | spin |wlock |rlock |mutex | ws=
em | rsem |\n");
+	printk("                                 | spin |wlock |rlock |mutex | ws=
em | rsem |rtmutex\n");
 	printk("  ---------------------------------------------------------------=
-----------\n");
=20
 	init_shared_classes();
--=20
2.34.0

