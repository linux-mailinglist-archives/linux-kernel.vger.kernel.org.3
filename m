Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164D4474DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbhLNWFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbhLNWEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FD8C061756
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:04:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3B1C5CE1AF8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454C6C34605;
        Tue, 14 Dec 2021 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519482;
        bh=ZcDcjArNCM1Zq31P0Rm5yiXWDHNC3chp8Nh5IPW4cyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmrs7gGXfOW0PJsWlZ0QZOq2GWAVmsuv4qXjhxYSOW3L7+SEm4NFUNSYI7YYaL89Z
         Z9YA/w8Rh9WQLj/3uq82xqCyg44S+GFJN2f7tcCXtf3VQdeWFdN8db9TbEK8U7SXbs
         ghppcxNuv7iukbsV1VHn2jDFCann+ZXf2MWIW9MuShqoLutNSxTrM4ms08c6wHYVux
         d1h2FhYWVdyLSfW03ZaywXOc6KZGap2DR8/Ovp5IFxntVnVyYn+Jgjicq/cEV9nOom
         ORPP8LSMZaCnWxp9dHrW9AI8zFJ2OojLAULoEFCocqjiUGA+bHXWtHlP3ZqN8zk+ok
         9DpG6h9sAVfKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9216B5C2C8E; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        kernel test robot <lkp@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 29/29] kcsan: Only test clear_bit_unlock_is_negative_byte if arch defines it
Date:   Tue, 14 Dec 2021 14:04:39 -0800
Message-Id: <20211214220439.2236564-29-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Some architectures do not define clear_bit_unlock_is_negative_byte().
Only test it when it is actually defined (similar to other usage, such
as in lib/test_kasan.c).

Link: https://lkml.kernel.org/r/202112050757.x67rHnFU-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan_test.c | 8 +++++---
 kernel/kcsan/selftest.c   | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 2bad0820f73ad..a36fca063a73a 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -598,7 +598,6 @@ static void test_barrier_nothreads(struct kunit *test)
 	KCSAN_EXPECT_READ_BARRIER(test_and_change_bit(0, &test_var), true);
 	KCSAN_EXPECT_READ_BARRIER(clear_bit_unlock(0, &test_var), true);
 	KCSAN_EXPECT_READ_BARRIER(__clear_bit_unlock(0, &test_var), true);
-	KCSAN_EXPECT_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
 	KCSAN_EXPECT_READ_BARRIER(arch_spin_lock(&arch_spinlock), false);
 	KCSAN_EXPECT_READ_BARRIER(arch_spin_unlock(&arch_spinlock), true);
 	KCSAN_EXPECT_READ_BARRIER(spin_lock(&test_spinlock), false);
@@ -644,7 +643,6 @@ static void test_barrier_nothreads(struct kunit *test)
 	KCSAN_EXPECT_WRITE_BARRIER(test_and_change_bit(0, &test_var), true);
 	KCSAN_EXPECT_WRITE_BARRIER(clear_bit_unlock(0, &test_var), true);
 	KCSAN_EXPECT_WRITE_BARRIER(__clear_bit_unlock(0, &test_var), true);
-	KCSAN_EXPECT_WRITE_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
 	KCSAN_EXPECT_WRITE_BARRIER(arch_spin_lock(&arch_spinlock), false);
 	KCSAN_EXPECT_WRITE_BARRIER(arch_spin_unlock(&arch_spinlock), true);
 	KCSAN_EXPECT_WRITE_BARRIER(spin_lock(&test_spinlock), false);
@@ -690,7 +688,6 @@ static void test_barrier_nothreads(struct kunit *test)
 	KCSAN_EXPECT_RW_BARRIER(test_and_change_bit(0, &test_var), true);
 	KCSAN_EXPECT_RW_BARRIER(clear_bit_unlock(0, &test_var), true);
 	KCSAN_EXPECT_RW_BARRIER(__clear_bit_unlock(0, &test_var), true);
-	KCSAN_EXPECT_RW_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
 	KCSAN_EXPECT_RW_BARRIER(arch_spin_lock(&arch_spinlock), false);
 	KCSAN_EXPECT_RW_BARRIER(arch_spin_unlock(&arch_spinlock), true);
 	KCSAN_EXPECT_RW_BARRIER(spin_lock(&test_spinlock), false);
@@ -698,6 +695,11 @@ static void test_barrier_nothreads(struct kunit *test)
 	KCSAN_EXPECT_RW_BARRIER(mutex_lock(&test_mutex), false);
 	KCSAN_EXPECT_RW_BARRIER(mutex_unlock(&test_mutex), true);
 
+#ifdef clear_bit_unlock_is_negative_byte
+	KCSAN_EXPECT_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
+	KCSAN_EXPECT_WRITE_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
+	KCSAN_EXPECT_RW_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var), true);
+#endif
 	kcsan_nestable_atomic_end();
 }
 
diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index b6d4da07d80a1..75712959c84e0 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -169,7 +169,6 @@ static bool __init test_barrier(void)
 	KCSAN_CHECK_READ_BARRIER(test_and_change_bit(0, &test_var));
 	KCSAN_CHECK_READ_BARRIER(clear_bit_unlock(0, &test_var));
 	KCSAN_CHECK_READ_BARRIER(__clear_bit_unlock(0, &test_var));
-	KCSAN_CHECK_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
 	arch_spin_lock(&arch_spinlock);
 	KCSAN_CHECK_READ_BARRIER(arch_spin_unlock(&arch_spinlock));
 	spin_lock(&test_spinlock);
@@ -199,7 +198,6 @@ static bool __init test_barrier(void)
 	KCSAN_CHECK_WRITE_BARRIER(test_and_change_bit(0, &test_var));
 	KCSAN_CHECK_WRITE_BARRIER(clear_bit_unlock(0, &test_var));
 	KCSAN_CHECK_WRITE_BARRIER(__clear_bit_unlock(0, &test_var));
-	KCSAN_CHECK_WRITE_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
 	arch_spin_lock(&arch_spinlock);
 	KCSAN_CHECK_WRITE_BARRIER(arch_spin_unlock(&arch_spinlock));
 	spin_lock(&test_spinlock);
@@ -232,12 +230,16 @@ static bool __init test_barrier(void)
 	KCSAN_CHECK_RW_BARRIER(test_and_change_bit(0, &test_var));
 	KCSAN_CHECK_RW_BARRIER(clear_bit_unlock(0, &test_var));
 	KCSAN_CHECK_RW_BARRIER(__clear_bit_unlock(0, &test_var));
-	KCSAN_CHECK_RW_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
 	arch_spin_lock(&arch_spinlock);
 	KCSAN_CHECK_RW_BARRIER(arch_spin_unlock(&arch_spinlock));
 	spin_lock(&test_spinlock);
 	KCSAN_CHECK_RW_BARRIER(spin_unlock(&test_spinlock));
 
+#ifdef clear_bit_unlock_is_negative_byte
+	KCSAN_CHECK_RW_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
+	KCSAN_CHECK_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
+	KCSAN_CHECK_WRITE_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
+#endif
 	kcsan_nestable_atomic_end();
 
 	return ret;
-- 
2.31.1.189.g2e36527f23

