Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DD04626C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhK2W5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbhK2WzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:55:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618CEC0C236A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:48:30 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638208109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AmohWZGuAOsLtik5LbHwnJPTa7PuekGutr9B/WW3Jlk=;
        b=M+J9/ZJ6mV0r8sf7YB5MHkyXhE496FxzJ7xxf/3eEKSeqK3j9y2xIxUmhuj8i1v4Is/kzj
        wlIMuEAubvxvsvICkyVzv6n/rClbOrCePHrVSkYZaLeQXY5pSUNM+70bQGYTlYYFEnSHqy
        4GEoUkn4PDHI8eULqqm/oS9Td1IXq8QDUYD4m7iJNFT6fsj/qNalyqaGQjniKO/764cghf
        99dBtfaN6M6WozEiQ6s0J9P8qiQaKLJ/eFC/eYA3Lm91xTHNkAuyM/vZQ1pALoEkLWNJsh
        CHYVnPDYGzcia4I9lcp4+zl8coLq2+mnYCVt02JazqVPmcQYuLEJ5ogF3zAMBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638208109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AmohWZGuAOsLtik5LbHwnJPTa7PuekGutr9B/WW3Jlk=;
        b=CSJfCKKfx1Mrv4gPiFJicdLeK8mndU198o33MssuT+HnxG7r+WEL1Sa8dxxQUVqlADEag7
        EFqhrGULhZ3ZfCAg==
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
Subject: [PATCH 07/11] lockdep/selftests: Unbalanced migrate_disable() & rcu_read_lock().
Date:   Mon, 29 Nov 2021 18:46:50 +0100
Message-Id: <20211129174654.668506-8-bigeasy@linutronix.de>
In-Reply-To: <20211129174654.668506-1-bigeasy@linutronix.de>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tests with unbalanced lock() + unlock() operation leave a modified
preemption counter behind which is then reset to its original value
after the test.

The spin_lock() function on PREEMPT_RT does not include a
preempt_disable() statement but migrate_disable() and read_rcu_lock().
As a consequence both counter never get back to their original value and
the system explodes later after the selftest.
In the double-unlock case on PREEMPT_RT, the migrate_disable() and RCU
code will trigger a warning which should be avoided. These counter
should not be decremented below their initial value.

Save both counters and bring them back to their original value after the
test.
In the double-unlock case, increment both counter in advance to they
become balanced after the double unlock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/locking-selftest.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 4d614c74e6ec5..417056ba28e1f 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -712,12 +712,18 @@ GENERATE_TESTCASE(ABCDBCDA_rtmutex);
=20
 #undef E
=20
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
=20
@@ -1398,7 +1404,13 @@ static int unexpected_testcase_failures;
=20
 static void dotest(void (*testcase_fn)(void), int expected, int lockclass_=
mask)
 {
-	unsigned long saved_preempt_count =3D preempt_count();
+	int saved_preempt_count =3D preempt_count();
+#ifdef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SMP
+	int saved_mgd_count =3D current->migration_disabled;
+#endif
+	int saved_rcu_count =3D current->rcu_read_lock_nesting;
+#endif
=20
 	WARN_ON(irqs_disabled());
=20
@@ -1432,6 +1444,18 @@ static void dotest(void (*testcase_fn)(void), int ex=
pected, int lockclass_mask)
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
 		current->softirqs_enabled =3D 0;
--=20
2.34.0

