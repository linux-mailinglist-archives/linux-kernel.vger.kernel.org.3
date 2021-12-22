Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7885247D09A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244475AbhLVLO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:14:57 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:56361 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244463AbhLVLOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:14:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V.QKPu1_1640171691;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V.QKPu1_1640171691)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 19:14:52 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     ying.huang@intel.com, dave.hansen@linux.intel.com, ziy@nvidia.com,
        shy828301@gmail.com, zhongjiang-ali@linux.alibaba.com,
        xlpang@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/damon: Add a new scheme to support demotion on tiered memory system
Date:   Wed, 22 Dec 2021 19:14:41 +0800
Message-Id: <281085c714a4bda62d7b1efb3355fe3a45085225.1640171137.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
References: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
References: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On tiered memory system, the reclaim path in shrink_page_list() already
support demoting pages to slow memory node instead of discarding the
pages. However, at that time the fast memory node memory wartermark is
already tense, which will increase the memory allocation latency during
page demotion.

We can rely on the DAMON in user space to help to monitor the cold
memory on fast memory node, and demote the cold pages to slow memory
node proactively to keep the fast memory node in a healthy state.
Thus this patch introduces a new scheme named DAMOS_DEMOTE to support
this feature.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/damon.h |   3 ++
 mm/damon/dbgfs.c      |   1 +
 mm/damon/vaddr.c      | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index af64838..ec46c7a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -87,6 +87,8 @@ struct damon_target {
  * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
  * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
+ * @DAMOS_DEMOTE:	Migrate cold pages from fast memory node (DRAM) to slow
+ *			memory node (persistent memory).
  * @DAMOS_STAT:		Do nothing but count the stat.
  */
 enum damos_action {
@@ -96,6 +98,7 @@ enum damos_action {
 	DAMOS_HUGEPAGE,
 	DAMOS_NOHUGEPAGE,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
+	DAMOS_DEMOTE,
 };
 
 /**
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 58dbb96..3bd0b0e 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -169,6 +169,7 @@ static bool damos_action_valid(int action)
 	case DAMOS_HUGEPAGE:
 	case DAMOS_NOHUGEPAGE:
 	case DAMOS_STAT:
+	case DAMOS_DEMOTE:
 		return true;
 	default:
 		return false;
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 9e213a1..bcdc602 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -14,6 +14,10 @@
 #include <linux/page_idle.h>
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
+#include <linux/migrate.h>
+#include <linux/mm_inline.h>
+#include <linux/swapops.h>
+#include "../internal.h"
 
 #include "prmtv-common.h"
 
@@ -693,6 +697,147 @@ static unsigned long damos_madvise(struct damon_target *target,
 }
 #endif	/* CONFIG_ADVISE_SYSCALLS */
 
+static void damos_isolate_page(struct page *page, struct list_head *demote_list)
+{
+	struct page *head = compound_head(page);
+
+	/* Do not interfere with other mappings of this page */
+	if (page_mapcount(head) != 1)
+		return;
+
+	/* No need migration if the target demotion node is empty. */
+	if (next_demotion_node(page_to_nid(head)) == NUMA_NO_NODE)
+		return;
+
+	if (isolate_lru_page(head))
+		return;
+
+	list_add_tail(&head->lru, demote_list);
+	mod_node_page_state(page_pgdat(head),
+			    NR_ISOLATED_ANON + page_is_file_lru(head),
+			    thp_nr_pages(head));
+}
+
+static int damos_isolate_pmd_entry(pmd_t *pmd, unsigned long addr,
+				   unsigned long end, struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+	struct list_head *demote_list = walk->private;
+	spinlock_t *ptl;
+	struct page *page;
+	pte_t *pte, *mapped_pte;
+
+	if (!vma_migratable(vma))
+		return -EFAULT;
+
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (ptl) {
+		/* Bail out if THP migration is not supported. */
+		if (!thp_migration_supported())
+			goto thp_out;
+
+		/* If the THP pte is under migration, do not bother it. */
+		if (unlikely(is_pmd_migration_entry(*pmd)))
+			goto thp_out;
+
+		page = damon_get_page(pmd_pfn(*pmd));
+		if (!page)
+			goto thp_out;
+
+		damos_isolate_page(page, demote_list);
+
+		put_page(page);
+thp_out:
+		spin_unlock(ptl);
+		return 0;
+	}
+
+	/* regular page handling */
+	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+		return -EINVAL;
+
+	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	for (; addr != end; pte++, addr += PAGE_SIZE) {
+		if (pte_none(*pte) || !pte_present(*pte))
+			continue;
+
+		page = damon_get_page(pte_pfn(*pte));
+		if (!page)
+			continue;
+
+		damos_isolate_page(page, demote_list);
+		put_page(page);
+	}
+	pte_unmap_unlock(mapped_pte, ptl);
+	cond_resched();
+
+	return 0;
+}
+
+static const struct mm_walk_ops damos_isolate_pages_walk_ops = {
+	.pmd_entry              = damos_isolate_pmd_entry,
+};
+
+/*
+ * damos_demote() - demote cold pages from fast memory to slow memory
+ * @target:    the given target
+ * @r:         region of the target
+ *
+ * On tiered memory system, if DAMON monitored cold pages on fast memory
+ * node (DRAM), we can demote them to slow memory node proactively in case
+ * accumulating much more cold memory on fast memory node (DRAM) to reclaim.
+ *
+ * Return the bytes of the region that the DAMOS_DEMOTE action is successfully
+ * applied.
+ */
+static unsigned long damos_demote(struct damon_target *target,
+				  struct damon_region *r)
+{
+	struct mm_struct *mm;
+	LIST_HEAD(demote_pages);
+	LIST_HEAD(pagelist);
+	unsigned int nr_succeeded, demoted_pages = 0;
+	struct page *page, *next;
+
+	/* Validate if allowing to do page demotion */
+	if (!numa_demotion_enabled)
+		return 0;
+
+	mm = damon_get_mm(target);
+	if (!mm)
+		return 0;
+
+	mmap_read_lock(mm);
+	walk_page_range(mm, r->ar.start, r->ar.end,
+			&damos_isolate_pages_walk_ops, &demote_pages);
+	mmap_read_unlock(mm);
+
+	mmput(mm);
+	if (list_empty(&demote_pages))
+		return 0;
+
+	list_for_each_entry_safe(page, next, &demote_pages, lru) {
+		list_add(&page->lru, &pagelist);
+
+		nr_succeeded = demote_page_list(&pagelist, page_pgdat(page));
+		if (!nr_succeeded) {
+			if (!list_empty(&pagelist)) {
+				list_del(&page->lru);
+				mod_node_page_state(page_pgdat(page),
+						    NR_ISOLATED_ANON + page_is_file_lru(page),
+						    -thp_nr_pages(page));
+				putback_lru_page(page);
+			}
+		} else {
+			demoted_pages += nr_succeeded;
+		}
+
+		cond_resched();
+	}
+
+	return demoted_pages * PAGE_SIZE;
+}
+
 static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme)
@@ -717,6 +862,8 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 		break;
 	case DAMOS_STAT:
 		return 0;
+	case DAMOS_DEMOTE:
+		return damos_demote(t, r);
 	default:
 		return 0;
 	}
-- 
1.8.3.1

