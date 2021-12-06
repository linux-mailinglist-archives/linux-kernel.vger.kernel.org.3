Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8FC469072
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbhLFGqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbhLFGqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:46:44 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77350C0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 22:43:16 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id j193-20020a1c23ca000000b003306ae8bfb7so5624761wmj.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 22:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j1fyadDoDslylJdYYaDqOZyJVAR4yBe0dIXXRHGm4Os=;
        b=a8sxZOfDGAV9hG1MvfW87Z2/4CfIH+2Kx3KFLTk5gz9B5IVfiv1y09CoTvlEGuRm/N
         fxXZjt4RvD7aB7X7t/e7Y6A0zOjllBTk2wburiWaqfnmhLBj2qOcu1fvAWPDm686m71Z
         0HZg8faKlh5Oz6ncHjROUdUPLOW8YhDFPgprTbLPcnPhjiDaFy1MtmomrBaoZLRhCtuU
         EWKPrD1ZJ+B9ED20D8rkXtJSoJAejsQKlNQApFl2cmaD7mqKpvDgnVcmQoUg1G2a1D5S
         byOn8fZlJDgxJTZwQCQc9A4QhJzUBauI4YeH/hPjSRto16sz3YqyetwbPlCmivay7awl
         ZP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j1fyadDoDslylJdYYaDqOZyJVAR4yBe0dIXXRHGm4Os=;
        b=ojRASJyQ7kCbDqT77o8unfMjpzEkpl0zgpzduOZjBhf4LA7HVvobPy/FxkKiyy0+YW
         sqRWb8wTOPkTKShaWFfD7HviSnkh9/I34jPok9+J7bfpJLLI9m5Va8J5dGAMtftN5PL5
         D105Ne5penxoIxXdV20v9WEq+l5s2DPykRGsCjJhUbIwXDbtH3GdmxQUvHLAPgflCDzT
         Y+cmkNrhXdvlKLjpkt/lf4OXx2KIPN7pRLmpwViqfiQC/M15wRosd61MgCIIL1gLCgj2
         1wLJ3VFBj248741juX9eufQqiat0H+HRQp9FxTgonCnrobEZk77IUspUc60qLOkWZflo
         ILnA==
X-Gm-Message-State: AOAM531HL2fVE3OSUJBVW4ENRlnO5HYRX5Z5CF20ESNAAEdJQfuIRTmu
        p+0sdpkSlfVYrAAyRJv3LJ4icTN3qA==
X-Google-Smtp-Source: ABdhPJw94b3ZzPAWIM53aZDDPtEfJ0tvd2s5GzuDoYT8JyR+URqFuPENrkVrjD0egcEwFP3vmCHdik3N+A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:88f3:db53:e34:7bb0])
 (user=elver job=sendgmr) by 2002:a05:600c:4f0b:: with SMTP id
 l11mr3647218wmq.0.1638772994811; Sun, 05 Dec 2021 22:43:14 -0800 (PST)
Date:   Mon,  6 Dec 2021 07:41:51 +0100
In-Reply-To: <20211206064151.3337384-1-elver@google.com>
Message-Id: <20211206064151.3337384-2-elver@google.com>
Mime-Version: 1.0
References: <20211206064151.3337384-1-elver@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH -rcu 2/2] kcsan: Only test clear_bit_unlock_is_negative_byte
 if arch defines it
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures do not define clear_bit_unlock_is_negative_byte().
Only test it when it is actually defined (similar to other usage, such
as in lib/test_kasan.c).

Link: https://lkml.kernel.org/r/202112050757.x67rHnFU-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan_test.c | 8 +++++---
 kernel/kcsan/selftest.c   | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 2bad0820f73a..a36fca063a73 100644
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
index b6d4da07d80a..75712959c84e 100644
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
2.34.1.400.ga245620fadb-goog

