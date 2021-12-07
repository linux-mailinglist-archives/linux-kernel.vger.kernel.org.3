Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D3146BAED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhLGMVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbhLGMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:21:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F15AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:17:50 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638879468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9mNm77zSE/n6+huHJUi8A5YaRRo2eq42DTfcJaoPEvU=;
        b=T0OlzgV+HePpZUJcafbsNQOCuizOV9gEj5hkERpxDjrsawv5P5GAw3vQ/Lvt2fgwwzO89N
        awowgoe5X2EKJK0RPJHsWfBCaCIJBtYcf0EakzPkaH3PljC37faH64syvgdJlI+y9RR01P
        iR6Th83uWC4ZU5lEY+bwOrOa6/uV9hZqaxztXcoxPot/A6GC/PW7m68KRJiDlyEfvQDxsW
        mER8A6OsZEKeVhtVRwBw4mTJs6OfzdfE8GnWC1BWgrUqGy2f2rcrd9yplmw1tDRz73mCU6
        kihUmOFjdWT0SEGkFOcw7lelyh9QTwFClAB8b22Ao1zSI/bMhvHOGccu8HZs+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638879468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9mNm77zSE/n6+huHJUi8A5YaRRo2eq42DTfcJaoPEvU=;
        b=k6viQkipo/G5J5Fjmc9+xvX3ZKOTwu3hM8wOtjCAgMfN7KkzUyfsjVpcHemsszXPSU3znQ
        o+fpjUEo5mLJU3Aw==
To:     linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/5] random: Defer processing of randomness on PREEMPT_RT.
Date:   Tue,  7 Dec 2021 13:17:37 +0100
Message-Id: <20211207121737.2347312-6-bigeasy@linutronix.de>
In-Reply-To: <20211207121737.2347312-1-bigeasy@linutronix.de>
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On interrupt invocation, add_interrupt_randomness() adds entropy to its
per-CPU state and if it gathered enough of it then it will mix it into a
entropy_store. In order to do so, it needs to lock the pool by acquiring
entropy_store::lock which is a spinlock_t. This lock can not be acquired
on PREEMPT_RT with disabled interrupts because it is a sleeping lock.

This lock could be made a raw_spinlock_t which will then allow to
acquire it with disabled interrupts on PREEMPT_RT. The lock is usually
hold for short amount of cycles while entropy is added to the pool and
the invocation from the IRQ handler has a try-lock which avoids spinning
on the lock if contended. The extraction of entropy (extract_buf())
needs a few cycles more because it performs additionally few
SHA1 transformations. This takes around 5-10us on a testing box (E5-2650
32 Cores, 2way NUMA) and is negligible.

The frequent invocation of the IOCTLs RNDADDTOENTCNT and RNDRESEEDCRNG
on multiple CPUs in parallel leads to filling and depletion of the pool
which in turn results in heavy contention on the lock. The spinning with
disabled interrupts on multiple CPUs leads to latencies of at least
100us on the same machine which is no longer acceptable.

Collect only the IRQ randomness in IRQ-context on PREEMPT_RT.
In threaded-IRQ context, make a copy of the per-CPU state with disabled
interrupts to ensure that it is not modified while duplicated. Pass the
copy to process_interrupt_randomness_pool() and reset the per-CPU
afterwards if needed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/random.c  | 39 ++++++++++++++++++++++++++++++++++++---
 include/linux/random.h |  1 +
 kernel/irq/manage.c    |  3 +++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4bcaa7886201d..725af4bf76c0e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1273,6 +1273,32 @@ static bool process_interrupt_randomness_pool(struct=
 fast_pool *fast_pool)
 	return true;
 }
=20
+#ifdef CONFIG_PREEMPT_RT
+void process_interrupt_randomness(void)
+{
+	struct fast_pool *cpu_pool;
+	struct fast_pool fast_pool;
+
+	lockdep_assert_irqs_enabled();
+
+	migrate_disable();
+	cpu_pool =3D this_cpu_ptr(&irq_randomness);
+
+	local_irq_disable();
+	memcpy(&fast_pool, cpu_pool, sizeof(fast_pool));
+	local_irq_enable();
+
+	if (process_interrupt_randomness_pool(&fast_pool)) {
+		local_irq_disable();
+		cpu_pool->last =3D jiffies;
+		cpu_pool->count =3D 0;
+		local_irq_enable();
+	}
+	memzero_explicit(&fast_pool, sizeof(fast_pool));
+	migrate_enable();
+}
+#endif
+
 void add_interrupt_randomness(int irq)
 {
 	struct fast_pool	*fast_pool =3D this_cpu_ptr(&irq_randomness);
@@ -1296,9 +1322,16 @@ void add_interrupt_randomness(int irq)
 	fast_mix(fast_pool);
 	add_interrupt_bench(cycles);
=20
-	if (process_interrupt_randomness_pool(fast_pool)) {
-		fast_pool->last =3D now;
-		fast_pool->count =3D 0;
+	/*
+	 * On PREEMPT_RT the entropy can not be fed into the input_pool because
+	 * it needs to acquire sleeping locks with disabled interrupts.
+	 * This is deferred to the threaded handler.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		if (process_interrupt_randomness_pool(fast_pool)) {
+			fast_pool->last =3D now;
+			fast_pool->count =3D 0;
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
diff --git a/include/linux/random.h b/include/linux/random.h
index c45b2693e51fb..a02c285a5ee52 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -36,6 +36,7 @@ static inline void add_latent_entropy(void) {}
 extern void add_input_randomness(unsigned int type, unsigned int code,
 				 unsigned int value) __latent_entropy;
 extern void add_interrupt_randomness(int irq) __latent_entropy;
+extern void process_interrupt_randomness(void);
=20
 extern void get_random_bytes(void *buf, int nbytes);
 extern int wait_for_random_bytes(void);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7405e384e5ed0..d641de1f879f4 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1281,6 +1281,9 @@ static int irq_thread(void *data)
 		if (action_ret =3D=3D IRQ_WAKE_THREAD)
 			irq_wake_secondary(desc, action);
=20
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			process_interrupt_randomness();
+
 		wake_threads_waitq(desc);
 	}
=20
--=20
2.34.1

