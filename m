Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A7E4CE558
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 15:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiCEOuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 09:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiCEOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:50:03 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E1D43ADF
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 06:49:12 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V6HF7j0_1646491749;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6HF7j0_1646491749)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 05 Mar 2022 22:49:09 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] kfence: Alloc kfence_pool after system startup
Date:   Sat,  5 Mar 2022 22:48:58 +0800
Message-Id: <20220305144858.17040-3-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220305144858.17040-1-dtcccc@linux.alibaba.com>
References: <20220305144858.17040-1-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow enabling KFENCE after system startup by allocating its pool via the
page allocator. This provides the flexibility to enable KFENCE even if it
wasn't enabled at boot time.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 mm/kfence/core.c | 99 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 21 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index caa4e84c8b79..f46d63dd7676 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -96,7 +96,7 @@ static unsigned long kfence_skip_covered_thresh __read_mostly = 75;
 module_param_named(skip_covered_thresh, kfence_skip_covered_thresh, ulong, 0644);
 
 /* The pool of pages used for guard pages and objects. */
-char *__kfence_pool __ro_after_init;
+char *__kfence_pool __read_mostly;
 EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
 
 /*
@@ -537,17 +537,19 @@ static void rcu_guarded_free(struct rcu_head *h)
 	kfence_guarded_free((void *)meta->addr, meta, false);
 }
 
-static bool __init kfence_init_pool(void)
+/*
+ * Initialization of the KFENCE pool after its allocation.
+ * Returns 0 on success; otherwise returns the address up to
+ * which partial initialization succeeded.
+ */
+static unsigned long kfence_init_pool(void)
 {
 	unsigned long addr = (unsigned long)__kfence_pool;
 	struct page *pages;
 	int i;
 
-	if (!__kfence_pool)
-		return false;
-
 	if (!arch_kfence_init_pool())
-		goto err;
+		return addr;
 
 	pages = virt_to_page(addr);
 
@@ -565,7 +567,7 @@ static bool __init kfence_init_pool(void)
 
 		/* Verify we do not have a compound head page. */
 		if (WARN_ON(compound_head(&pages[i]) != &pages[i]))
-			goto err;
+			return addr;
 
 		__SetPageSlab(&pages[i]);
 	}
@@ -578,7 +580,7 @@ static bool __init kfence_init_pool(void)
 	 */
 	for (i = 0; i < 2; i++) {
 		if (unlikely(!kfence_protect(addr)))
-			goto err;
+			return addr;
 
 		addr += PAGE_SIZE;
 	}
@@ -595,7 +597,7 @@ static bool __init kfence_init_pool(void)
 
 		/* Protect the right redzone. */
 		if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
-			goto err;
+			return addr;
 
 		addr += 2 * PAGE_SIZE;
 	}
@@ -608,9 +610,21 @@ static bool __init kfence_init_pool(void)
 	 */
 	kmemleak_free(__kfence_pool);
 
-	return true;
+	return 0;
+}
+
+static bool __init kfence_init_pool_early(void)
+{
+	unsigned long addr;
+
+	if (!__kfence_pool)
+		return false;
+
+	addr = kfence_init_pool();
+
+	if (!addr)
+		return true;
 
-err:
 	/*
 	 * Only release unprotected pages, and do not try to go back and change
 	 * page attributes due to risk of failing to do so as well. If changing
@@ -623,6 +637,22 @@ static bool __init kfence_init_pool(void)
 	return false;
 }
 
+static bool kfence_init_pool_late(void)
+{
+	unsigned long addr, free_pages;
+
+	addr = kfence_init_pool();
+
+	if (!addr)
+		return true;
+
+	/* Same as above. */
+	free_pages = (KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool)) / PAGE_SIZE;
+	free_contig_range(page_to_pfn(virt_to_page(addr)), free_pages);
+	__kfence_pool = NULL;
+	return false;
+}
+
 /* === DebugFS Interface ==================================================== */
 
 static int stats_show(struct seq_file *seq, void *v)
@@ -771,31 +801,58 @@ void __init kfence_alloc_pool(void)
 		pr_err("failed to allocate pool\n");
 }
 
+static void kfence_init_enable(void)
+{
+	if (!IS_ENABLED(CONFIG_KFENCE_STATIC_KEYS))
+		static_branch_enable(&kfence_allocation_key);
+	WRITE_ONCE(kfence_enabled, true);
+	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
+	pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
+		CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
+		(void *)(__kfence_pool + KFENCE_POOL_SIZE));
+}
+
 void __init kfence_init(void)
 {
+	stack_hash_seed = (u32)random_get_entropy();
+
 	/* Setting kfence_sample_interval to 0 on boot disables KFENCE. */
 	if (!kfence_sample_interval)
 		return;
 
-	stack_hash_seed = (u32)random_get_entropy();
-	if (!kfence_init_pool()) {
+	if (!kfence_init_pool_early()) {
 		pr_err("%s failed\n", __func__);
 		return;
 	}
 
-	if (!IS_ENABLED(CONFIG_KFENCE_STATIC_KEYS))
-		static_branch_enable(&kfence_allocation_key);
-	WRITE_ONCE(kfence_enabled, true);
-	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
-	pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
-		CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
-		(void *)(__kfence_pool + KFENCE_POOL_SIZE));
+	kfence_init_enable();
+}
+
+static int kfence_init_late(void)
+{
+	const unsigned long nr_pages = KFENCE_POOL_SIZE / PAGE_SIZE;
+	struct page *pages;
+
+	pages = alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_node, NULL);
+
+	if (!pages)
+		return -ENOMEM;
+
+	__kfence_pool = page_to_virt(pages);
+
+	if (!kfence_init_pool_late()) {
+		pr_err("%s failed\n", __func__);
+		return -EBUSY;
+	}
+
+	kfence_init_enable();
+	return 0;
 }
 
 static int kfence_enable_late(void)
 {
 	if (!__kfence_pool)
-		return -EINVAL;
+		return kfence_init_late();
 
 	WRITE_ONCE(kfence_enabled, true);
 	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
-- 
2.27.0

