Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85C6474DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbhLNWFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbhLNWEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14963C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:04:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92FF461773
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED49C004DD;
        Tue, 14 Dec 2021 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519482;
        bh=vNeKSLn4o3y/1sYJiczd9woV5aKJnJUJLzoNeRByzJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYKDFmh4M6fDFNBL9dA7uL+dwcbe8cYzkEjxLlRvseA6Dl2+fCfijxUKcm4ghvGXq
         yPvnrUKlmNPtI2pQyNWM5/4DoffC5VrdnbgSQmOxbEy9oM1rwVUypkrhmrxhUTdtzZ
         PCzKouIBxAPge564Vvux2eY4t/BZSD9OT88+jD0cqq+zBlqIAa5ajlTkytPhaJn2pr
         LxJyjdHmWqA808QpmK3KSFcYXUebsywJ/JFTm//eDipfFIxo3VbrLyRZEIX5WP7umU
         HzouYfkcuixkhybQAZeseP2W3zNP7Hy0ZXtEeci8XOBVwFs3JBmWdFzm0DTnWf/L7P
         89yfBQrkPmykw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8C0185C2699; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 26/29] kcsan: Make barrier tests compatible with lockdep
Date:   Tue, 14 Dec 2021 14:04:36 -0800
Message-Id: <20211214220439.2236564-26-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

The barrier tests in selftest and the kcsan_test module only need the
spinlock and mutex to test correct barrier instrumentation. Therefore,
these were initially placed on the stack.

However, lockdep asserts that locks are in static storage, and will
generate this warning:

 | INFO: trying to register non-static key.
 | The code is fine but needs lockdep annotation, or maybe
 | you didn't initialize this object before use?
 | turning off the locking correctness validator.
 | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc1+ #3208
 | Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
 | Call Trace:
 |  <TASK>
 |  dump_stack_lvl+0x88/0xd8
 |  dump_stack+0x15/0x1b
 |  register_lock_class+0x6b3/0x840
 |  ...
 |  test_barrier+0x490/0x14c7
 |  kcsan_selftest+0x47/0xa0
 |  ...

To fix, move the test locks into static storage.

Fixing the above also revealed that lock operations are strengthened on
first use with lockdep enabled, due to lockdep calling out into
non-instrumented files (recall that kernel/locking/lockdep.c is not
instrumented with KCSAN).

Only kcsan_test checks for over-instrumentation of *_lock() operations,
where we can simply "warm up" the test locks to avoid the test case
failing with lockdep.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan_test.c | 37 +++++++++++++++++++++++--------------
 kernel/kcsan/selftest.c   | 14 +++++++-------
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 5bf94550bcdf6..2bad0820f73ad 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -300,6 +300,8 @@ static struct {
 	long val[8];
 } test_struct;
 static DEFINE_SEQLOCK(test_seqlock);
+static DEFINE_SPINLOCK(test_spinlock);
+static DEFINE_MUTEX(test_mutex);
 
 /*
  * Helper to avoid compiler optimizing out reads, and to generate source values
@@ -523,8 +525,6 @@ static void test_barrier_nothreads(struct kunit *test)
 	struct kcsan_scoped_access *reorder_access = NULL;
 #endif
 	arch_spinlock_t arch_spinlock = __ARCH_SPIN_LOCK_UNLOCKED;
-	DEFINE_SPINLOCK(spinlock);
-	DEFINE_MUTEX(mutex);
 	atomic_t dummy;
 
 	KCSAN_TEST_REQUIRES(test, reorder_access != NULL);
@@ -543,6 +543,15 @@ static void test_barrier_nothreads(struct kunit *test)
 #define KCSAN_EXPECT_WRITE_BARRIER(b, o) __KCSAN_EXPECT_BARRIER(KCSAN_ACCESS_WRITE, b, o, #b)
 #define KCSAN_EXPECT_RW_BARRIER(b, o)    __KCSAN_EXPECT_BARRIER(KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE, b, o, #b)
 
+	/*
+	 * Lockdep initialization can strengthen certain locking operations due
+	 * to calling into instrumented files; "warm up" our locks.
+	 */
+	spin_lock(&test_spinlock);
+	spin_unlock(&test_spinlock);
+	mutex_lock(&test_mutex);
+	mutex_unlock(&test_mutex);
+
 	/* Force creating a valid entry in reorder_access first. */
 	test_var = 0;
 	while (test_var++ < 1000000 && reorder_access->size != sizeof(test_var))
@@ -592,10 +601,10 @@ static void test_barrier_nothreads(struct kunit *test)
 	KCSAN_EXPECT_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
 	KCSAN_EXPECT_READ_BARRIER(arch_spin_lock(&arch_spinlock), false);
 	KCSAN_EXPECT_READ_BARRIER(arch_spin_unlock(&arch_spinlock), true);
-	KCSAN_EXPECT_READ_BARRIER(spin_lock(&spinlock), false);
-	KCSAN_EXPECT_READ_BARRIER(spin_unlock(&spinlock), true);
-	KCSAN_EXPECT_READ_BARRIER(mutex_lock(&mutex), false);
-	KCSAN_EXPECT_READ_BARRIER(mutex_unlock(&mutex), true);
+	KCSAN_EXPECT_READ_BARRIER(spin_lock(&test_spinlock), false);
+	KCSAN_EXPECT_READ_BARRIER(spin_unlock(&test_spinlock), true);
+	KCSAN_EXPECT_READ_BARRIER(mutex_lock(&test_mutex), false);
+	KCSAN_EXPECT_READ_BARRIER(mutex_unlock(&test_mutex), true);
 
 	KCSAN_EXPECT_WRITE_BARRIER(mb(), true);
 	KCSAN_EXPECT_WRITE_BARRIER(wmb(), true);
@@ -638,10 +647,10 @@ static void test_barrier_nothreads(struct kunit *test)
 	KCSAN_EXPECT_WRITE_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
 	KCSAN_EXPECT_WRITE_BARRIER(arch_spin_lock(&arch_spinlock), false);
 	KCSAN_EXPECT_WRITE_BARRIER(arch_spin_unlock(&arch_spinlock), true);
-	KCSAN_EXPECT_WRITE_BARRIER(spin_lock(&spinlock), false);
-	KCSAN_EXPECT_WRITE_BARRIER(spin_unlock(&spinlock), true);
-	KCSAN_EXPECT_WRITE_BARRIER(mutex_lock(&mutex), false);
-	KCSAN_EXPECT_WRITE_BARRIER(mutex_unlock(&mutex), true);
+	KCSAN_EXPECT_WRITE_BARRIER(spin_lock(&test_spinlock), false);
+	KCSAN_EXPECT_WRITE_BARRIER(spin_unlock(&test_spinlock), true);
+	KCSAN_EXPECT_WRITE_BARRIER(mutex_lock(&test_mutex), false);
+	KCSAN_EXPECT_WRITE_BARRIER(mutex_unlock(&test_mutex), true);
 
 	KCSAN_EXPECT_RW_BARRIER(mb(), true);
 	KCSAN_EXPECT_RW_BARRIER(wmb(), true);
@@ -684,10 +693,10 @@ static void test_barrier_nothreads(struct kunit *test)
 	KCSAN_EXPECT_RW_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
 	KCSAN_EXPECT_RW_BARRIER(arch_spin_lock(&arch_spinlock), false);
 	KCSAN_EXPECT_RW_BARRIER(arch_spin_unlock(&arch_spinlock), true);
-	KCSAN_EXPECT_RW_BARRIER(spin_lock(&spinlock), false);
-	KCSAN_EXPECT_RW_BARRIER(spin_unlock(&spinlock), true);
-	KCSAN_EXPECT_RW_BARRIER(mutex_lock(&mutex), false);
-	KCSAN_EXPECT_RW_BARRIER(mutex_unlock(&mutex), true);
+	KCSAN_EXPECT_RW_BARRIER(spin_lock(&test_spinlock), false);
+	KCSAN_EXPECT_RW_BARRIER(spin_unlock(&test_spinlock), true);
+	KCSAN_EXPECT_RW_BARRIER(mutex_lock(&test_mutex), false);
+	KCSAN_EXPECT_RW_BARRIER(mutex_unlock(&test_mutex), true);
 
 	kcsan_nestable_atomic_end();
 }
diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index 08c6b84b9ebed..b6d4da07d80a1 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -113,6 +113,7 @@ static bool __init test_matching_access(void)
  * positives: simple test to check at boot certain barriers are always properly
  * instrumented. See kcsan_test for a more complete test.
  */
+static DEFINE_SPINLOCK(test_spinlock);
 static bool __init test_barrier(void)
 {
 #ifdef CONFIG_KCSAN_WEAK_MEMORY
@@ -122,7 +123,6 @@ static bool __init test_barrier(void)
 #endif
 	bool ret = true;
 	arch_spinlock_t arch_spinlock = __ARCH_SPIN_LOCK_UNLOCKED;
-	DEFINE_SPINLOCK(spinlock);
 	atomic_t dummy;
 	long test_var;
 
@@ -172,8 +172,8 @@ static bool __init test_barrier(void)
 	KCSAN_CHECK_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
 	arch_spin_lock(&arch_spinlock);
 	KCSAN_CHECK_READ_BARRIER(arch_spin_unlock(&arch_spinlock));
-	spin_lock(&spinlock);
-	KCSAN_CHECK_READ_BARRIER(spin_unlock(&spinlock));
+	spin_lock(&test_spinlock);
+	KCSAN_CHECK_READ_BARRIER(spin_unlock(&test_spinlock));
 
 	KCSAN_CHECK_WRITE_BARRIER(mb());
 	KCSAN_CHECK_WRITE_BARRIER(wmb());
@@ -202,8 +202,8 @@ static bool __init test_barrier(void)
 	KCSAN_CHECK_WRITE_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
 	arch_spin_lock(&arch_spinlock);
 	KCSAN_CHECK_WRITE_BARRIER(arch_spin_unlock(&arch_spinlock));
-	spin_lock(&spinlock);
-	KCSAN_CHECK_WRITE_BARRIER(spin_unlock(&spinlock));
+	spin_lock(&test_spinlock);
+	KCSAN_CHECK_WRITE_BARRIER(spin_unlock(&test_spinlock));
 
 	KCSAN_CHECK_RW_BARRIER(mb());
 	KCSAN_CHECK_RW_BARRIER(wmb());
@@ -235,8 +235,8 @@ static bool __init test_barrier(void)
 	KCSAN_CHECK_RW_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
 	arch_spin_lock(&arch_spinlock);
 	KCSAN_CHECK_RW_BARRIER(arch_spin_unlock(&arch_spinlock));
-	spin_lock(&spinlock);
-	KCSAN_CHECK_RW_BARRIER(spin_unlock(&spinlock));
+	spin_lock(&test_spinlock);
+	KCSAN_CHECK_RW_BARRIER(spin_unlock(&test_spinlock));
 
 	kcsan_nestable_atomic_end();
 
-- 
2.31.1.189.g2e36527f23

