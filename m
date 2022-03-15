Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D89F4DA035
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350124AbiCOQic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350115AbiCOQi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:38:28 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C274E25E90
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:37:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V7IiZER_1647362232;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V7IiZER_1647362232)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 00:37:12 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, rongwei.wang@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V1 2/3] mm/damon/paddr: Move "paddr" relative func to ops-common.c file
Date:   Wed, 16 Mar 2022 00:37:06 +0800
Message-Id: <3b0c406efd961762e899e26978c010ed7746817b.1647378112.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1647378112.git.xhao@linux.alibaba.com>
References: <cover.1647378112.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the next patch, I will introduce the CMA monitoring support,
because CMA is also based on physical addresses, so there are many
functions can be shared with "paddr".

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/ops-common.c | 247 ++++++++++++++++++++++++++++++++++++++++++
 mm/damon/ops-common.h |  15 +++
 mm/damon/paddr.c      | 246 -----------------------------------------
 3 files changed, 262 insertions(+), 246 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index fd5e98005358..0e895c0034b1 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -9,8 +9,11 @@
 #include <linux/page_idle.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
+#include <linux/mmu_notifier.h>
+#include <linux/swap.h>
 
 #include "ops-common.h"
+#include "../internal.h"
 
 /*
  * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
@@ -170,3 +173,247 @@ int damon_evenly_split_region(struct damon_target *t,
 
 	return 0;
 }
+
+#ifdef CONFIG_DAMON_PADDR
+
+static bool __damon_pa_mkold(struct page *page, struct vm_area_struct *vma,
+		unsigned long addr, void *arg)
+{
+	struct page_vma_mapped_walk pvmw = {
+		.page = page,
+		.vma = vma,
+		.address = addr,
+	};
+
+	while (page_vma_mapped_walk(&pvmw)) {
+		addr = pvmw.address;
+		if (pvmw.pte)
+			damon_ptep_mkold(pvmw.pte, vma->vm_mm, addr);
+		else
+			damon_pmdp_mkold(pvmw.pmd, vma->vm_mm, addr);
+	}
+	return true;
+}
+
+void damon_pa_mkold(unsigned long paddr)
+{
+	struct page *page = damon_get_page(PHYS_PFN(paddr));
+	struct rmap_walk_control rwc = {
+		.rmap_one = __damon_pa_mkold,
+		.anon_lock = page_lock_anon_vma_read,
+	};
+	bool need_lock;
+
+	if (!page)
+		return;
+
+	if (!page_mapped(page) || !page_rmapping(page)) {
+		set_page_idle(page);
+		goto out;
+	}
+
+	need_lock = !PageAnon(page) || PageKsm(page);
+	if (need_lock && !trylock_page(page))
+		goto out;
+
+	rmap_walk(page, &rwc);
+
+	if (need_lock)
+		unlock_page(page);
+
+out:
+	put_page(page);
+}
+
+static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
+					    struct damon_region *r)
+{
+	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
+
+	damon_pa_mkold(r->sampling_addr);
+}
+
+void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t)
+			__damon_pa_prepare_access_check(ctx, r);
+	}
+}
+
+struct damon_pa_access_chk_result {
+	unsigned long page_sz;
+	bool accessed;
+};
+
+static bool __damon_pa_young(struct page *page, struct vm_area_struct *vma,
+		unsigned long addr, void *arg)
+{
+	struct damon_pa_access_chk_result *result = arg;
+	struct page_vma_mapped_walk pvmw = {
+		.page = page,
+		.vma = vma,
+		.address = addr,
+	};
+
+	result->accessed = false;
+	result->page_sz = PAGE_SIZE;
+	while (page_vma_mapped_walk(&pvmw)) {
+		addr = pvmw.address;
+		if (pvmw.pte) {
+			result->accessed = pte_young(*pvmw.pte) ||
+				!page_is_idle(page) ||
+				mmu_notifier_test_young(vma->vm_mm, addr);
+		} else {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			result->accessed = pmd_young(*pvmw.pmd) ||
+				!page_is_idle(page) ||
+				mmu_notifier_test_young(vma->vm_mm, addr);
+			result->page_sz = ((1UL) << HPAGE_PMD_SHIFT);
+#else
+			WARN_ON_ONCE(1);
+#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
+		}
+		if (result->accessed) {
+			page_vma_mapped_walk_done(&pvmw);
+			break;
+		}
+	}
+
+	/* If accessed, stop walking */
+	return !result->accessed;
+}
+
+bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
+{
+	struct page *page = damon_get_page(PHYS_PFN(paddr));
+	struct damon_pa_access_chk_result result = {
+		.page_sz = PAGE_SIZE,
+		.accessed = false,
+	};
+	struct rmap_walk_control rwc = {
+		.arg = &result,
+		.rmap_one = __damon_pa_young,
+		.anon_lock = page_lock_anon_vma_read,
+	};
+	bool need_lock;
+
+	if (!page)
+		return false;
+
+	if (!page_mapped(page) || !page_rmapping(page)) {
+		if (page_is_idle(page))
+			result.accessed = false;
+		else
+			result.accessed = true;
+		put_page(page);
+		goto out;
+	}
+
+	need_lock = !PageAnon(page) || PageKsm(page);
+	if (need_lock && !trylock_page(page)) {
+		put_page(page);
+		return NULL;
+	}
+
+	rmap_walk(page, &rwc);
+
+	if (need_lock)
+		unlock_page(page);
+	put_page(page);
+
+out:
+	*page_sz = result.page_sz;
+	return result.accessed;
+}
+
+static void __damon_pa_check_access(struct damon_ctx *ctx,
+				    struct damon_region *r)
+{
+	static unsigned long last_addr;
+	static unsigned long last_page_sz = PAGE_SIZE;
+	static bool last_accessed;
+
+	/* If the region is in the last checked page, reuse the result */
+	if (ALIGN_DOWN(last_addr, last_page_sz) ==
+				ALIGN_DOWN(r->sampling_addr, last_page_sz)) {
+		if (last_accessed)
+			r->nr_accesses++;
+		return;
+	}
+
+	last_accessed = damon_pa_young(r->sampling_addr, &last_page_sz);
+	if (last_accessed)
+		r->nr_accesses++;
+
+	last_addr = r->sampling_addr;
+}
+
+unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned int max_nr_accesses = 0;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t) {
+			__damon_pa_check_access(ctx, r);
+			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
+		}
+	}
+
+	return max_nr_accesses;
+}
+
+unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
+		struct damon_target *t, struct damon_region *r,
+		struct damos *scheme)
+{
+	unsigned long addr, applied;
+	LIST_HEAD(page_list);
+
+	if (scheme->action != DAMOS_PAGEOUT)
+		return 0;
+
+	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+		struct page *page = damon_get_page(PHYS_PFN(addr));
+
+		if (!page)
+			continue;
+
+		ClearPageReferenced(page);
+		test_and_clear_page_young(page);
+		if (isolate_lru_page(page)) {
+			put_page(page);
+			continue;
+		}
+		if (PageUnevictable(page)) {
+			putback_lru_page(page);
+		} else {
+			list_add(&page->lru, &page_list);
+			put_page(page);
+		}
+	}
+	applied = reclaim_pages(&page_list);
+	cond_resched();
+	return applied * PAGE_SIZE;
+}
+
+int damon_pa_scheme_score(struct damon_ctx *context,
+		struct damon_target *t, struct damon_region *r,
+		struct damos *scheme)
+{
+	switch (scheme->action) {
+	case DAMOS_PAGEOUT:
+		return damon_pageout_score(context, r, scheme);
+	default:
+		break;
+	}
+
+	return DAMOS_MAX_SCORE;
+}
+
+#endif /* CONFIG_DAMON_PADDR */
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index fd441016a2ae..bb62fd300ea9 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -17,3 +17,18 @@ int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
 
 int damon_evenly_split_region(struct damon_target *t,
 		struct damon_region *r, unsigned int nr_pieces);
+
+#ifdef CONFIG_DAMON_PADDR
+
+void damon_pa_mkold(unsigned long paddr);
+void damon_pa_prepare_access_checks(struct damon_ctx *ctx);
+bool damon_pa_young(unsigned long paddr, unsigned long *page_sz);
+unsigned int damon_pa_check_accesses(struct damon_ctx *ctx);
+unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
+		struct damon_target *t, struct damon_region *r,
+		struct damos *scheme);
+int damon_pa_scheme_score(struct damon_ctx *context,
+		struct damon_target *t, struct damon_region *r,
+		struct damos *scheme);
+
+#endif
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 7c263797a9a9..c0a87c0bde9b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -7,255 +7,9 @@
 
 #define pr_fmt(fmt) "damon-pa: " fmt
 
-#include <linux/mmu_notifier.h>
-#include <linux/page_idle.h>
-#include <linux/pagemap.h>
-#include <linux/rmap.h>
-#include <linux/swap.h>
-
 #include "../internal.h"
 #include "ops-common.h"
 
-static bool __damon_pa_mkold(struct page *page, struct vm_area_struct *vma,
-		unsigned long addr, void *arg)
-{
-	struct page_vma_mapped_walk pvmw = {
-		.page = page,
-		.vma = vma,
-		.address = addr,
-	};
-
-	while (page_vma_mapped_walk(&pvmw)) {
-		addr = pvmw.address;
-		if (pvmw.pte)
-			damon_ptep_mkold(pvmw.pte, vma->vm_mm, addr);
-		else
-			damon_pmdp_mkold(pvmw.pmd, vma->vm_mm, addr);
-	}
-	return true;
-}
-
-static void damon_pa_mkold(unsigned long paddr)
-{
-	struct page *page = damon_get_page(PHYS_PFN(paddr));
-	struct rmap_walk_control rwc = {
-		.rmap_one = __damon_pa_mkold,
-		.anon_lock = page_lock_anon_vma_read,
-	};
-	bool need_lock;
-
-	if (!page)
-		return;
-
-	if (!page_mapped(page) || !page_rmapping(page)) {
-		set_page_idle(page);
-		goto out;
-	}
-
-	need_lock = !PageAnon(page) || PageKsm(page);
-	if (need_lock && !trylock_page(page))
-		goto out;
-
-	rmap_walk(page, &rwc);
-
-	if (need_lock)
-		unlock_page(page);
-
-out:
-	put_page(page);
-}
-
-static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
-					    struct damon_region *r)
-{
-	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
-
-	damon_pa_mkold(r->sampling_addr);
-}
-
-static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
-{
-	struct damon_target *t;
-	struct damon_region *r;
-
-	damon_for_each_target(t, ctx) {
-		damon_for_each_region(r, t)
-			__damon_pa_prepare_access_check(ctx, r);
-	}
-}
-
-struct damon_pa_access_chk_result {
-	unsigned long page_sz;
-	bool accessed;
-};
-
-static bool __damon_pa_young(struct page *page, struct vm_area_struct *vma,
-		unsigned long addr, void *arg)
-{
-	struct damon_pa_access_chk_result *result = arg;
-	struct page_vma_mapped_walk pvmw = {
-		.page = page,
-		.vma = vma,
-		.address = addr,
-	};
-
-	result->accessed = false;
-	result->page_sz = PAGE_SIZE;
-	while (page_vma_mapped_walk(&pvmw)) {
-		addr = pvmw.address;
-		if (pvmw.pte) {
-			result->accessed = pte_young(*pvmw.pte) ||
-				!page_is_idle(page) ||
-				mmu_notifier_test_young(vma->vm_mm, addr);
-		} else {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			result->accessed = pmd_young(*pvmw.pmd) ||
-				!page_is_idle(page) ||
-				mmu_notifier_test_young(vma->vm_mm, addr);
-			result->page_sz = ((1UL) << HPAGE_PMD_SHIFT);
-#else
-			WARN_ON_ONCE(1);
-#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
-		}
-		if (result->accessed) {
-			page_vma_mapped_walk_done(&pvmw);
-			break;
-		}
-	}
-
-	/* If accessed, stop walking */
-	return !result->accessed;
-}
-
-static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
-{
-	struct page *page = damon_get_page(PHYS_PFN(paddr));
-	struct damon_pa_access_chk_result result = {
-		.page_sz = PAGE_SIZE,
-		.accessed = false,
-	};
-	struct rmap_walk_control rwc = {
-		.arg = &result,
-		.rmap_one = __damon_pa_young,
-		.anon_lock = page_lock_anon_vma_read,
-	};
-	bool need_lock;
-
-	if (!page)
-		return false;
-
-	if (!page_mapped(page) || !page_rmapping(page)) {
-		if (page_is_idle(page))
-			result.accessed = false;
-		else
-			result.accessed = true;
-		put_page(page);
-		goto out;
-	}
-
-	need_lock = !PageAnon(page) || PageKsm(page);
-	if (need_lock && !trylock_page(page)) {
-		put_page(page);
-		return NULL;
-	}
-
-	rmap_walk(page, &rwc);
-
-	if (need_lock)
-		unlock_page(page);
-	put_page(page);
-
-out:
-	*page_sz = result.page_sz;
-	return result.accessed;
-}
-
-static void __damon_pa_check_access(struct damon_ctx *ctx,
-				    struct damon_region *r)
-{
-	static unsigned long last_addr;
-	static unsigned long last_page_sz = PAGE_SIZE;
-	static bool last_accessed;
-
-	/* If the region is in the last checked page, reuse the result */
-	if (ALIGN_DOWN(last_addr, last_page_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_page_sz)) {
-		if (last_accessed)
-			r->nr_accesses++;
-		return;
-	}
-
-	last_accessed = damon_pa_young(r->sampling_addr, &last_page_sz);
-	if (last_accessed)
-		r->nr_accesses++;
-
-	last_addr = r->sampling_addr;
-}
-
-static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
-{
-	struct damon_target *t;
-	struct damon_region *r;
-	unsigned int max_nr_accesses = 0;
-
-	damon_for_each_target(t, ctx) {
-		damon_for_each_region(r, t) {
-			__damon_pa_check_access(ctx, r);
-			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
-		}
-	}
-
-	return max_nr_accesses;
-}
-
-static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
-		struct damon_target *t, struct damon_region *r,
-		struct damos *scheme)
-{
-	unsigned long addr, applied;
-	LIST_HEAD(page_list);
-
-	if (scheme->action != DAMOS_PAGEOUT)
-		return 0;
-
-	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
-		struct page *page = damon_get_page(PHYS_PFN(addr));
-
-		if (!page)
-			continue;
-
-		ClearPageReferenced(page);
-		test_and_clear_page_young(page);
-		if (isolate_lru_page(page)) {
-			put_page(page);
-			continue;
-		}
-		if (PageUnevictable(page)) {
-			putback_lru_page(page);
-		} else {
-			list_add(&page->lru, &page_list);
-			put_page(page);
-		}
-	}
-	applied = reclaim_pages(&page_list);
-	cond_resched();
-	return applied * PAGE_SIZE;
-}
-
-static int damon_pa_scheme_score(struct damon_ctx *context,
-		struct damon_target *t, struct damon_region *r,
-		struct damos *scheme)
-{
-	switch (scheme->action) {
-	case DAMOS_PAGEOUT:
-		return damon_pageout_score(context, r, scheme);
-	default:
-		break;
-	}
-
-	return DAMOS_MAX_SCORE;
-}
-
 static int __init damon_pa_initcall(void)
 {
 	struct damon_operations ops = {
-- 
2.27.0

