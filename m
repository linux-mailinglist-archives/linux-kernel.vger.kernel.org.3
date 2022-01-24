Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BEA49777B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbiAXChz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:37:55 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30294 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240797AbiAXChr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:37:47 -0500
Received: from kwepemi100026.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JhvJR4KKjzbk5R;
        Mon, 24 Jan 2022 10:36:55 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100026.china.huawei.com (7.221.188.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 10:37:44 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 10:37:43 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <glider@google.com>, <elver@google.com>, <dvyukov@google.com>,
        <corbet@lwn.net>, <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
        <linux-mm@kvack.org>, <liupeng256@huawei.com>
Subject: [PATCH RFC 3/3] kfence: Make test case compatible with run time set sample interval
Date:   Mon, 24 Jan 2022 02:52:05 +0000
Message-ID: <20220124025205.329752-4-liupeng256@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220124025205.329752-1-liupeng256@huawei.com>
References: <20220124025205.329752-1-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter kfence_sample_interval can be set via boot parameter
and late shell command. However, KFENCE test case just use compile
time CONFIG_KFENCE_SAMPLE_INTERVAL, this will make KFENCE test case
not run as user desired. This patch will make KFENCE test case
compatible with run-time-set sample interval.

Signed-off-by: Peng Liu <liupeng256@huawei.com>
---
 include/linux/kfence.h  | 2 ++
 mm/kfence/core.c        | 3 ++-
 mm/kfence/kfence_test.c | 8 ++++----
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index bf91b76b87ee..0fc913a7f017 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -19,6 +19,8 @@
 
 extern bool kfence_enabled;
 extern unsigned long kfence_num_objects;
+extern unsigned long kfence_sample_interval;
+
 /*
  * We allocate an even number of pages, as it simplifies calculations to map
  * address to metadata indices; effectively, the very first page serves as an
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 2301923182b8..e2fcae34cc84 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -50,7 +50,8 @@
 
 bool kfence_enabled __read_mostly;
 
-static unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE_INTERVAL;
+unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE_INTERVAL;
+EXPORT_SYMBOL(kfence_sample_interval); /* Export for test modules. */
 
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 084e3a55aebb..97ff3a133f11 100644
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

