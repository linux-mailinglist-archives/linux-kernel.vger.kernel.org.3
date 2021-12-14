Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDD4474D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbhLNWEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:04:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56074 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhLNWEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 553E661763
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E911CC34619;
        Tue, 14 Dec 2021 22:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519482;
        bh=rvcpPuGvug4iAoMMpRovQ8+UxR6qOm6ZP//Ty+4jTUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cHGYq5E6wMwVjYpvIkdB20uCAaFYSNImZ37EI83eoHE+xFR3xrEQ7LvxnEHEtQMJm
         GXQJ6coVXxSS760Nn8ilJqubsknzR0YFifyibkBsIuas39NjzZJzeM+bBkE4ALJzR9
         vEFNnQbBA6drwT7LCHuFjNOhQkl7Kz60kJ+qI93b53LooYcecBzUmacY6CSe+i7IdV
         IiFO5taPar+eIxNX2qs395ZRN6rKg9IjgsLhMNizubLOtqtps3rh15XqwhJ5MtHSgb
         v+IviX8LpWTcc5SagZdDTIqhcslsVjfZggZU4BDJ/jRBl67KpBAUPo+FUyP53h1Upq
         2vMd9XtnaxNCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6EE515C1657; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 11/29] kcsan: test: Add test cases for memory barrier instrumentation
Date:   Tue, 14 Dec 2021 14:04:21 -0800
Message-Id: <20211214220439.2236564-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Adds test cases to check that memory barriers are instrumented
correctly, and detection of missing memory barriers is working as
intended if CONFIG_KCSAN_STRICT=y.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan_test.c | 319 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 319 insertions(+)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index ec054879201b3..5bf94550bcdf6 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -16,9 +16,12 @@
 #define pr_fmt(fmt) "kcsan_test: " fmt
 
 #include <kunit/test.h>
+#include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/jiffies.h>
 #include <linux/kcsan-checks.h>
 #include <linux/kernel.h>
+#include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/seqlock.h>
 #include <linux/spinlock.h>
@@ -305,6 +308,16 @@ static DEFINE_SEQLOCK(test_seqlock);
 __no_kcsan
 static noinline void sink_value(long v) { WRITE_ONCE(test_sink, v); }
 
+/*
+ * Generates a delay and some accesses that enter the runtime but do not produce
+ * data races.
+ */
+static noinline void test_delay(int iter)
+{
+	while (iter--)
+		sink_value(READ_ONCE(test_sink));
+}
+
 static noinline void test_kernel_read(void) { sink_value(test_var); }
 
 static noinline void test_kernel_write(void)
@@ -466,8 +479,219 @@ static noinline void test_kernel_xor_1bit(void)
 	kcsan_nestable_atomic_end();
 }
 
+#define TEST_KERNEL_LOCKED(name, acquire, release)		\
+	static noinline void test_kernel_##name(void)		\
+	{							\
+		long *flag = &test_struct.val[0];		\
+		long v = 0;					\
+		if (!(acquire))					\
+			return;					\
+		while (v++ < 100) {				\
+			test_var++;				\
+			barrier();				\
+		}						\
+		release;					\
+		test_delay(10);					\
+	}
+
+TEST_KERNEL_LOCKED(with_memorder,
+		   cmpxchg_acquire(flag, 0, 1) == 0,
+		   smp_store_release(flag, 0));
+TEST_KERNEL_LOCKED(wrong_memorder,
+		   cmpxchg_relaxed(flag, 0, 1) == 0,
+		   WRITE_ONCE(*flag, 0));
+TEST_KERNEL_LOCKED(atomic_builtin_with_memorder,
+		   __atomic_compare_exchange_n(flag, &v, 1, 0, __ATOMIC_ACQUIRE, __ATOMIC_RELAXED),
+		   __atomic_store_n(flag, 0, __ATOMIC_RELEASE));
+TEST_KERNEL_LOCKED(atomic_builtin_wrong_memorder,
+		   __atomic_compare_exchange_n(flag, &v, 1, 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED),
+		   __atomic_store_n(flag, 0, __ATOMIC_RELAXED));
+
 /* ===== Test cases ===== */
 
+/*
+ * Tests that various barriers have the expected effect on internal state. Not
+ * exhaustive on atomic_t operations. Unlike the selftest, also checks for
+ * too-strict barrier instrumentation; these can be tolerated, because it does
+ * not cause false positives, but at least we should be aware of such cases.
+ */
+static void test_barrier_nothreads(struct kunit *test)
+{
+#ifdef CONFIG_KCSAN_WEAK_MEMORY
+	struct kcsan_scoped_access *reorder_access = &current->kcsan_ctx.reorder_access;
+#else
+	struct kcsan_scoped_access *reorder_access = NULL;
+#endif
+	arch_spinlock_t arch_spinlock = __ARCH_SPIN_LOCK_UNLOCKED;
+	DEFINE_SPINLOCK(spinlock);
+	DEFINE_MUTEX(mutex);
+	atomic_t dummy;
+
+	KCSAN_TEST_REQUIRES(test, reorder_access != NULL);
+	KCSAN_TEST_REQUIRES(test, IS_ENABLED(CONFIG_SMP));
+
+#define __KCSAN_EXPECT_BARRIER(access_type, barrier, order_before, name)			\
+	do {											\
+		reorder_access->type = (access_type) | KCSAN_ACCESS_SCOPED;			\
+		reorder_access->size = sizeof(test_var);					\
+		barrier;									\
+		KUNIT_EXPECT_EQ_MSG(test, reorder_access->size,					\
+				    order_before ? 0 : sizeof(test_var),			\
+				    "improperly instrumented type=(" #access_type "): " name);	\
+	} while (0)
+#define KCSAN_EXPECT_READ_BARRIER(b, o)  __KCSAN_EXPECT_BARRIER(0, b, o, #b)
+#define KCSAN_EXPECT_WRITE_BARRIER(b, o) __KCSAN_EXPECT_BARRIER(KCSAN_ACCESS_WRITE, b, o, #b)
+#define KCSAN_EXPECT_RW_BARRIER(b, o)    __KCSAN_EXPECT_BARRIER(KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE, b, o, #b)
+
+	/* Force creating a valid entry in reorder_access first. */
+	test_var = 0;
+	while (test_var++ < 1000000 && reorder_access->size != sizeof(test_var))
+		__kcsan_check_read(&test_var, sizeof(test_var));
+	KUNIT_ASSERT_EQ(test, reorder_access->size, sizeof(test_var));
+
+	kcsan_nestable_atomic_begin(); /* No watchpoints in called functions. */
+
+	KCSAN_EXPECT_READ_BARRIER(mb(), true);
+	KCSAN_EXPECT_READ_BARRIER(wmb(), false);
+	KCSAN_EXPECT_READ_BARRIER(rmb(), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_mb(), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_wmb(), false);
+	KCSAN_EXPECT_READ_BARRIER(smp_rmb(), true);
+	KCSAN_EXPECT_READ_BARRIER(dma_wmb(), false);
+	KCSAN_EXPECT_READ_BARRIER(dma_rmb(), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_mb__before_atomic(), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_mb__after_atomic(), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_mb__after_spinlock(), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_store_mb(test_var, 0), true);
+	KCSAN_EXPECT_READ_BARRIER(smp_load_acquire(&test_var), false);
+	KCSAN_EXPECT_READ_BARRIER(smp_store_release(&test_var, 0), true);
+	KCSAN_EXPECT_READ_BARRIER(xchg(&test_var, 0), true);
+	KCSAN_EXPECT_READ_BARRIER(xchg_release(&test_var, 0), true);
+	KCSAN_EXPECT_READ_BARRIER(xchg_relaxed(&test_var, 0), false);
+	KCSAN_EXPECT_READ_BARRIER(cmpxchg(&test_var, 0,  0), true);
+	KCSAN_EXPECT_READ_BARRIER(cmpxchg_release(&test_var, 0,  0), true);
+	KCSAN_EXPECT_READ_BARRIER(cmpxchg_relaxed(&test_var, 0,  0), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_read(&dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_read_acquire(&dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_set(&dummy, 0), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_set_release(&dummy, 0), true);
+	KCSAN_EXPECT_READ_BARRIER(atomic_add(1, &dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_add_return(1, &dummy), true);
+	KCSAN_EXPECT_READ_BARRIER(atomic_add_return_acquire(1, &dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_add_return_release(1, &dummy), true);
+	KCSAN_EXPECT_READ_BARRIER(atomic_add_return_relaxed(1, &dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_fetch_add(1, &dummy), true);
+	KCSAN_EXPECT_READ_BARRIER(atomic_fetch_add_acquire(1, &dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(atomic_fetch_add_release(1, &dummy), true);
+	KCSAN_EXPECT_READ_BARRIER(atomic_fetch_add_relaxed(1, &dummy), false);
+	KCSAN_EXPECT_READ_BARRIER(test_and_set_bit(0, &test_var), true);
+	KCSAN_EXPECT_READ_BARRIER(test_and_clear_bit(0, &test_var), true);
+	KCSAN_EXPECT_READ_BARRIER(test_and_change_bit(0, &test_var), true);
+	KCSAN_EXPECT_READ_BARRIER(clear_bit_unlock(0, &test_var), true);
+	KCSAN_EXPECT_READ_BARRIER(__clear_bit_unlock(0, &test_var), true);
+	KCSAN_EXPECT_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
+	KCSAN_EXPECT_READ_BARRIER(arch_spin_lock(&arch_spinlock), false);
+	KCSAN_EXPECT_READ_BARRIER(arch_spin_unlock(&arch_spinlock), true);
+	KCSAN_EXPECT_READ_BARRIER(spin_lock(&spinlock), false);
+	KCSAN_EXPECT_READ_BARRIER(spin_unlock(&spinlock), true);
+	KCSAN_EXPECT_READ_BARRIER(mutex_lock(&mutex), false);
+	KCSAN_EXPECT_READ_BARRIER(mutex_unlock(&mutex), true);
+
+	KCSAN_EXPECT_WRITE_BARRIER(mb(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(wmb(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(rmb(), false);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_mb(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_wmb(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_rmb(), false);
+	KCSAN_EXPECT_WRITE_BARRIER(dma_wmb(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(dma_rmb(), false);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_mb__before_atomic(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_mb__after_atomic(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_mb__after_spinlock(), true);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_store_mb(test_var, 0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_load_acquire(&test_var), false);
+	KCSAN_EXPECT_WRITE_BARRIER(smp_store_release(&test_var, 0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(xchg(&test_var, 0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(xchg_release(&test_var, 0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(xchg_relaxed(&test_var, 0), false);
+	KCSAN_EXPECT_WRITE_BARRIER(cmpxchg(&test_var, 0,  0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(cmpxchg_release(&test_var, 0,  0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(cmpxchg_relaxed(&test_var, 0,  0), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_read(&dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_read_acquire(&dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_set(&dummy, 0), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_set_release(&dummy, 0), true);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_add(1, &dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_add_return(1, &dummy), true);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_add_return_acquire(1, &dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_add_return_release(1, &dummy), true);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_add_return_relaxed(1, &dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_fetch_add(1, &dummy), true);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_fetch_add_acquire(1, &dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_fetch_add_release(1, &dummy), true);
+	KCSAN_EXPECT_WRITE_BARRIER(atomic_fetch_add_relaxed(1, &dummy), false);
+	KCSAN_EXPECT_WRITE_BARRIER(test_and_set_bit(0, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(test_and_clear_bit(0, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(test_and_change_bit(0, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(clear_bit_unlock(0, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(__clear_bit_unlock(0, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(arch_spin_lock(&arch_spinlock), false);
+	KCSAN_EXPECT_WRITE_BARRIER(arch_spin_unlock(&arch_spinlock), true);
+	KCSAN_EXPECT_WRITE_BARRIER(spin_lock(&spinlock), false);
+	KCSAN_EXPECT_WRITE_BARRIER(spin_unlock(&spinlock), true);
+	KCSAN_EXPECT_WRITE_BARRIER(mutex_lock(&mutex), false);
+	KCSAN_EXPECT_WRITE_BARRIER(mutex_unlock(&mutex), true);
+
+	KCSAN_EXPECT_RW_BARRIER(mb(), true);
+	KCSAN_EXPECT_RW_BARRIER(wmb(), true);
+	KCSAN_EXPECT_RW_BARRIER(rmb(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_mb(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_wmb(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_rmb(), true);
+	KCSAN_EXPECT_RW_BARRIER(dma_wmb(), true);
+	KCSAN_EXPECT_RW_BARRIER(dma_rmb(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_mb__before_atomic(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_mb__after_atomic(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_mb__after_spinlock(), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_store_mb(test_var, 0), true);
+	KCSAN_EXPECT_RW_BARRIER(smp_load_acquire(&test_var), false);
+	KCSAN_EXPECT_RW_BARRIER(smp_store_release(&test_var, 0), true);
+	KCSAN_EXPECT_RW_BARRIER(xchg(&test_var, 0), true);
+	KCSAN_EXPECT_RW_BARRIER(xchg_release(&test_var, 0), true);
+	KCSAN_EXPECT_RW_BARRIER(xchg_relaxed(&test_var, 0), false);
+	KCSAN_EXPECT_RW_BARRIER(cmpxchg(&test_var, 0,  0), true);
+	KCSAN_EXPECT_RW_BARRIER(cmpxchg_release(&test_var, 0,  0), true);
+	KCSAN_EXPECT_RW_BARRIER(cmpxchg_relaxed(&test_var, 0,  0), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_read(&dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_read_acquire(&dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_set(&dummy, 0), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_set_release(&dummy, 0), true);
+	KCSAN_EXPECT_RW_BARRIER(atomic_add(1, &dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_add_return(1, &dummy), true);
+	KCSAN_EXPECT_RW_BARRIER(atomic_add_return_acquire(1, &dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_add_return_release(1, &dummy), true);
+	KCSAN_EXPECT_RW_BARRIER(atomic_add_return_relaxed(1, &dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_fetch_add(1, &dummy), true);
+	KCSAN_EXPECT_RW_BARRIER(atomic_fetch_add_acquire(1, &dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(atomic_fetch_add_release(1, &dummy), true);
+	KCSAN_EXPECT_RW_BARRIER(atomic_fetch_add_relaxed(1, &dummy), false);
+	KCSAN_EXPECT_RW_BARRIER(test_and_set_bit(0, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(test_and_clear_bit(0, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(test_and_change_bit(0, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(clear_bit_unlock(0, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(__clear_bit_unlock(0, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(arch_spin_lock(&arch_spinlock), false);
+	KCSAN_EXPECT_RW_BARRIER(arch_spin_unlock(&arch_spinlock), true);
+	KCSAN_EXPECT_RW_BARRIER(spin_lock(&spinlock), false);
+	KCSAN_EXPECT_RW_BARRIER(spin_unlock(&spinlock), true);
+	KCSAN_EXPECT_RW_BARRIER(mutex_lock(&mutex), false);
+	KCSAN_EXPECT_RW_BARRIER(mutex_unlock(&mutex), true);
+
+	kcsan_nestable_atomic_end();
+}
+
 /* Simple test with normal data race. */
 __no_kcsan
 static void test_basic(struct kunit *test)
@@ -1039,6 +1263,90 @@ static void test_1bit_value_change(struct kunit *test)
 		KUNIT_EXPECT_TRUE(test, match);
 }
 
+__no_kcsan
+static void test_correct_barrier(struct kunit *test)
+{
+	struct expect_report expect = {
+		.access = {
+			{ test_kernel_with_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
+			{ test_kernel_with_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(0) },
+		},
+	};
+	bool match_expect = false;
+
+	test_struct.val[0] = 0; /* init unlocked */
+	begin_test_checks(test_kernel_with_memorder, test_kernel_with_memorder);
+	do {
+		match_expect = report_matches_any_reordered(&expect);
+	} while (!end_test_checks(match_expect));
+	KUNIT_EXPECT_FALSE(test, match_expect);
+}
+
+__no_kcsan
+static void test_missing_barrier(struct kunit *test)
+{
+	struct expect_report expect = {
+		.access = {
+			{ test_kernel_wrong_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
+			{ test_kernel_wrong_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(0) },
+		},
+	};
+	bool match_expect = false;
+
+	test_struct.val[0] = 0; /* init unlocked */
+	begin_test_checks(test_kernel_wrong_memorder, test_kernel_wrong_memorder);
+	do {
+		match_expect = report_matches_any_reordered(&expect);
+	} while (!end_test_checks(match_expect));
+	if (IS_ENABLED(CONFIG_KCSAN_WEAK_MEMORY))
+		KUNIT_EXPECT_TRUE(test, match_expect);
+	else
+		KUNIT_EXPECT_FALSE(test, match_expect);
+}
+
+__no_kcsan
+static void test_atomic_builtins_correct_barrier(struct kunit *test)
+{
+	struct expect_report expect = {
+		.access = {
+			{ test_kernel_atomic_builtin_with_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
+			{ test_kernel_atomic_builtin_with_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(0) },
+		},
+	};
+	bool match_expect = false;
+
+	test_struct.val[0] = 0; /* init unlocked */
+	begin_test_checks(test_kernel_atomic_builtin_with_memorder,
+			  test_kernel_atomic_builtin_with_memorder);
+	do {
+		match_expect = report_matches_any_reordered(&expect);
+	} while (!end_test_checks(match_expect));
+	KUNIT_EXPECT_FALSE(test, match_expect);
+}
+
+__no_kcsan
+static void test_atomic_builtins_missing_barrier(struct kunit *test)
+{
+	struct expect_report expect = {
+		.access = {
+			{ test_kernel_atomic_builtin_wrong_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
+			{ test_kernel_atomic_builtin_wrong_memorder, &test_var, sizeof(test_var), __KCSAN_ACCESS_RW(0) },
+		},
+	};
+	bool match_expect = false;
+
+	test_struct.val[0] = 0; /* init unlocked */
+	begin_test_checks(test_kernel_atomic_builtin_wrong_memorder,
+			  test_kernel_atomic_builtin_wrong_memorder);
+	do {
+		match_expect = report_matches_any_reordered(&expect);
+	} while (!end_test_checks(match_expect));
+	if (IS_ENABLED(CONFIG_KCSAN_WEAK_MEMORY))
+		KUNIT_EXPECT_TRUE(test, match_expect);
+	else
+		KUNIT_EXPECT_FALSE(test, match_expect);
+}
+
 /*
  * Generate thread counts for all test cases. Values generated are in interval
  * [2, 5] followed by exponentially increasing thread counts from 8 to 32.
@@ -1088,6 +1396,7 @@ static const void *nthreads_gen_params(const void *prev, char *desc)
 
 #define KCSAN_KUNIT_CASE(test_name) KUNIT_CASE_PARAM(test_name, nthreads_gen_params)
 static struct kunit_case kcsan_test_cases[] = {
+	KUNIT_CASE(test_barrier_nothreads),
 	KCSAN_KUNIT_CASE(test_basic),
 	KCSAN_KUNIT_CASE(test_concurrent_races),
 	KCSAN_KUNIT_CASE(test_novalue_change),
@@ -1112,6 +1421,10 @@ static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_seqlock_noreport),
 	KCSAN_KUNIT_CASE(test_atomic_builtins),
 	KCSAN_KUNIT_CASE(test_1bit_value_change),
+	KCSAN_KUNIT_CASE(test_correct_barrier),
+	KCSAN_KUNIT_CASE(test_missing_barrier),
+	KCSAN_KUNIT_CASE(test_atomic_builtins_correct_barrier),
+	KCSAN_KUNIT_CASE(test_atomic_builtins_missing_barrier),
 	{},
 };
 
@@ -1176,6 +1489,9 @@ static int test_init(struct kunit *test)
 	observed.nlines = 0;
 	spin_unlock_irqrestore(&observed.lock, flags);
 
+	if (strstr(test->name, "nothreads"))
+		return 0;
+
 	if (!torture_init_begin((char *)test->name, 1))
 		return -EBUSY;
 
@@ -1218,6 +1534,9 @@ static void test_exit(struct kunit *test)
 	struct task_struct **stop_thread;
 	int i;
 
+	if (strstr(test->name, "nothreads"))
+		return;
+
 	if (torture_cleanup_begin())
 		return;
 
-- 
2.31.1.189.g2e36527f23

