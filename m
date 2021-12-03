Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C7C4680B3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354222AbhLCXly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354205AbhLCXlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:41:53 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80434C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 15:38:28 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id j193-20020a1c23ca000000b003306ae8bfb7so2274902wmj.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 15:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xmREXnUvl8E4KQZMwmE4VO+WOMe+bIkkKyKZ1+a5fBU=;
        b=pay3ge79EMWU6N1ZAacynMBEkySGk8UMvPIsRjMw+KmLJ8q8lB0bO9FHIddOPwQtEQ
         JJ7jnL+4q+V94vnN3GyHo54dkG/Zzm6dRPf80XoPdQmZqXyO/uubTvYih98W7ImISNMs
         bDkV8qZ5k8ls9X/AyzVtKtVByg1bUqfgm5uLhgnYrfl4Xs3mG8Cadl73Rt7SRKCmnxBA
         x4fhUPLiuElSSg7flGIGwxhMlTXfD+xbTCJt5L+H5dsw3KZaSwFspSMZ3FH7zueqm3zV
         BSPvtEf61gxHXSZDmd69UldePI2AofNwhtpSTuCG/cSflPxumyoSGn9n4+mZd49ycwHJ
         5duA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xmREXnUvl8E4KQZMwmE4VO+WOMe+bIkkKyKZ1+a5fBU=;
        b=wcnJT+Qj+ESmO9OsGJrLbxF+Uydv/2qc55lK4cIMG5f/UhQEMUFIb3dejw6Xi1zoEs
         2uA40sfmZuzdcTwaEb75+eICi/23UEpSL+BqLBJzmfY8VhBgJSmvOmIMkYMmbarbRuEO
         L3xYmt0G/PNCo8GzcVZ6f045fMNcns5fIm6a8SpmUUtSTZNuMLqXIg24TYetQ7q/OM1J
         ze/SOTwtJDXAfZPO4VSbhvNKedcgE2Gz4HOUYryIzIjlp6EoBraRWC2EI/n7a4bMdT8v
         pGojwgsAJ6+BanyU7w8I9U1p3+vl/zqlgsLTG0hNPHoxWHAuGruz00rVaVprkXxRenaP
         GfHQ==
X-Gm-Message-State: AOAM532012Ic+fuzArvwzmJxDF8d3iya9uEumG+vOVpheLct5uivpOMc
        K/bdhpa15+dU0xgZM9Ns70Rp6Ism6w==
X-Google-Smtp-Source: ABdhPJwiILOpTmGn4Y5cMeXnkVbxBPo5Cg7B97CUG21nN1oVaAXo5lZikNXGVJ/6bBtX+FjjdwOKP8j/hw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:565a:3964:11db:fb41])
 (user=elver job=sendgmr) by 2002:a5d:6691:: with SMTP id l17mr24686079wru.227.1638574706604;
 Fri, 03 Dec 2021 15:38:26 -0800 (PST)
Date:   Sat,  4 Dec 2021 00:38:17 +0100
Message-Id: <20211203233817.2815340-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH -rcu] kcsan: Make barrier tests compatible with lockdep
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/kcsan/kcsan_test.c | 37 +++++++++++++++++++++++--------------
 kernel/kcsan/selftest.c   | 14 +++++++-------
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 5bf94550bcdf..2bad0820f73a 100644
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
index 08c6b84b9ebe..b6d4da07d80a 100644
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
2.34.1.400.ga245620fadb-goog

