Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DE54AB410
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiBGFtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbiBGD33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 22:29:29 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B207C061A73;
        Sun,  6 Feb 2022 19:29:27 -0800 (PST)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JsWjl51mXzZfM0;
        Mon,  7 Feb 2022 11:25:15 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500011.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 11:29:25 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 11:29:24 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <glider@google.com>, <elver@google.com>, <dvyukov@google.com>,
        <corbet@lwn.net>, <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
        <linux-mm@kvack.org>, <liupeng256@huawei.com>
Subject: [PATCH v3] kfence: Make test case compatible with run time set sample interval
Date:   Mon, 7 Feb 2022 03:44:32 +0000
Message-ID: <20220207034432.185532-1-liupeng256@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter kfence_sample_interval can be set via boot parameter
and late shell command, which is convenient for automated tests and
KFENCE parameter optimization. However, KFENCE test case just uses
compile-time CONFIG_KFENCE_SAMPLE_INTERVAL, which will make KFENCE
test case not run as users desired. Export kfence_sample_interval,
so that KFENCE test case can use run-time-set sample interval.

Signed-off-by: Peng Liu <liupeng256@huawei.com>
---
v2->v3:
- Revise change log description
v1->v2:
- Use EXPORT_SYMBOL_GPL replace EXPORT_SYMBOL

 include/linux/kfence.h  | 2 ++
 mm/kfence/core.c        | 3 ++-
 mm/kfence/kfence_test.c | 8 ++++----
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 4b5e3679a72c..f49e64222628 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -17,6 +17,8 @@
 #include <linux/atomic.h>
 #include <linux/static_key.h>
 
+extern unsigned long kfence_sample_interval;
+
 /*
  * We allocate an even number of pages, as it simplifies calculations to map
  * address to metadata indices; effectively, the very first page serves as an
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 5ad40e3add45..13128fa13062 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -47,7 +47,8 @@
 
 static bool kfence_enabled __read_mostly;
 
-static unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE_INTERVAL;
+unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE_INTERVAL;
+EXPORT_SYMBOL_GPL(kfence_sample_interval); /* Export for test modules. */
 
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index a22b1af85577..50dbb815a2a8 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -268,13 +268,13 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
 	 * 100x the sample interval should be more than enough to ensure we get
 	 * a KFENCE allocation eventually.
 	 */
-	timeout = jiffies + msecs_to_jiffies(100 * CONFIG_KFENCE_SAMPLE_INTERVAL);
+	timeout = jiffies + msecs_to_jiffies(100 * kfence_sample_interval);
 	/*
 	 * Especially for non-preemption kernels, ensure the allocation-gate
 	 * timer can catch up: after @resched_after, every failed allocation
 	 * attempt yields, to ensure the allocation-gate timer is scheduled.
 	 */
-	resched_after = jiffies + msecs_to_jiffies(CONFIG_KFENCE_SAMPLE_INTERVAL);
+	resched_after = jiffies + msecs_to_jiffies(kfence_sample_interval);
 	do {
 		if (test_cache)
 			alloc = kmem_cache_alloc(test_cache, gfp);
@@ -608,7 +608,7 @@ static void test_gfpzero(struct kunit *test)
 	int i;
 
 	/* Skip if we think it'd take too long. */
-	KFENCE_TEST_REQUIRES(test, CONFIG_KFENCE_SAMPLE_INTERVAL <= 100);
+	KFENCE_TEST_REQUIRES(test, kfence_sample_interval <= 100);
 
 	setup_test_cache(test, size, 0, NULL);
 	buf1 = test_alloc(test, size, GFP_KERNEL, ALLOCATE_ANY);
@@ -739,7 +739,7 @@ static void test_memcache_alloc_bulk(struct kunit *test)
 	 * 100x the sample interval should be more than enough to ensure we get
 	 * a KFENCE allocation eventually.
 	 */
-	timeout = jiffies + msecs_to_jiffies(100 * CONFIG_KFENCE_SAMPLE_INTERVAL);
+	timeout = jiffies + msecs_to_jiffies(100 * kfence_sample_interval);
 	do {
 		void *objects[100];
 		int i, num = kmem_cache_alloc_bulk(test_cache, GFP_ATOMIC, ARRAY_SIZE(objects),
-- 
2.18.0.huawei.25

