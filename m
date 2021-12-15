Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA85475BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbhLOPXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:23:38 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39747 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231971AbhLOPXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:23:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V-jeqjH_1639581812;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V-jeqjH_1639581812)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Dec 2021 23:23:33 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: Add access checking for hugetlb pages
Date:   Wed, 15 Dec 2021 23:23:25 +0800
Message-Id: <8ce19b8e22e24aa93e24bf89cd723d2e1a3250c9.1639581537.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The process's VMAs can be mapped by hugetlb page, but now the DAMON
did not implement the access checking for hugetlb pte, so we can not
get the actual access count like below if a process VMAs were mapped
by hugetlb.

damon_aggregated: target_id=18446614368406014464
nr_regions=12 4194304-5476352: 0 545
damon_aggregated: target_id=18446614368406014464
nr_regions=12 140662370467840-140662372970496: 0 545
damon_aggregated: target_id=18446614368406014464
nr_regions=12 140662372970496-140662375460864: 0 545
damon_aggregated: target_id=18446614368406014464
nr_regions=12 140662375460864-140662377951232: 0 545
damon_aggregated: target_id=18446614368406014464
nr_regions=12 140662377951232-140662380449792: 0 545
damon_aggregated: target_id=18446614368406014464
nr_regions=12 140662380449792-140662382944256: 0 545
......

Thus this patch adds hugetlb access checking support, with this patch
we can see below VMA mapped by hugetlb access count.

damon_aggregated: target_id=18446613056935405824
nr_regions=12 140296486649856-140296489914368: 1 3
damon_aggregated: target_id=18446613056935405824
nr_regions=12 140296489914368-140296492978176: 1 3
damon_aggregated: target_id=18446613056935405824
nr_regions=12 140296492978176-140296495439872: 1 3
damon_aggregated: target_id=18446613056935405824
nr_regions=12 140296495439872-140296498311168: 1 3
damon_aggregated: target_id=18446613056935405824
nr_regions=12 140296498311168-140296501198848: 1 3
damon_aggregated: target_id=18446613056935405824
nr_regions=12 140296501198848-140296504320000: 1 3
damon_aggregated: target_id=18446613056935405824
nr_regions=12 140296504320000-140296507568128: 1 2
......

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/damon/prmtv-common.c | 37 ++++++++++++++++++++++++++++
 mm/damon/prmtv-common.h | 11 +++++++++
 mm/damon/vaddr.c        | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/mm/damon/prmtv-common.c b/mm/damon/prmtv-common.c
index 92a04f5..155afb8 100644
--- a/mm/damon/prmtv-common.c
+++ b/mm/damon/prmtv-common.c
@@ -9,6 +9,7 @@
 #include <linux/page_idle.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
+#include <linux/hugetlb.h>
 
 #include "prmtv-common.h"
 
@@ -86,6 +87,42 @@ void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
+			 struct vm_area_struct *vma, unsigned long addr)
+{
+	bool referenced = false;
+	struct hstate *h = hstate_vma(vma);
+	pte_t entry;
+	struct page *page;
+
+	entry = huge_ptep_get(pte);
+	page = pte_page(entry);
+	if (!page)
+		return;
+
+	get_page(page);
+
+	if (pte_young(entry)) {
+		referenced = true;
+		entry = pte_mkold(entry);
+		huge_ptep_set_access_flags(vma, addr, pte, entry,
+					   vma->vm_flags & VM_WRITE);
+	}
+
+#ifdef CONFIG_MMU_NOTIFIER
+	if (mmu_notifier_clear_young(mm, addr, addr + huge_page_size(h)))
+		referenced = true;
+#endif /* CONFIG_MMU_NOTIFIER */
+
+	if (referenced)
+		set_page_young(page);
+
+	set_page_idle(page);
+	put_page(page);
+}
+#endif
+
 #define DAMON_MAX_SUBSCORE	(100)
 #define DAMON_MAX_AGE_IN_LOG	(32)
 
diff --git a/mm/damon/prmtv-common.h b/mm/damon/prmtv-common.h
index e790cb5..65efcb7 100644
--- a/mm/damon/prmtv-common.h
+++ b/mm/damon/prmtv-common.h
@@ -12,5 +12,16 @@
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
 
+#ifdef CONFIG_HUGETLB_PAGE
+void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
+			 struct vm_area_struct *vma, unsigned long addr);
+#else
+static inline void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
+				       struct vm_area_struct *vma,
+				       unsigned long addr)
+{
+}
+#endif
+
 int damon_pageout_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 78ff2bc..ee116e5 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -14,6 +14,7 @@
 #include <linux/page_idle.h>
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
+#include <linux/hugetlb.h>
 
 #include "prmtv-common.h"
 
@@ -386,8 +387,33 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
+				     unsigned long addr, unsigned long end,
+				     struct mm_walk *walk)
+{
+	struct hstate *h = hstate_vma(walk->vma);
+	spinlock_t *ptl;
+	pte_t entry;
+
+	ptl = huge_pte_lock(h, walk->mm, pte);
+	entry = huge_ptep_get(pte);
+	if (!pte_present(entry))
+		goto out;
+
+	damon_hugetlb_mkold(pte, walk->mm, walk->vma, addr);
+
+out:
+	spin_unlock(ptl);
+	return 0;
+}
+#else
+#define damon_mkold_hugetlb_entry NULL
+#endif
+
 static const struct mm_walk_ops damon_mkold_ops = {
 	.pmd_entry = damon_mkold_pmd_entry,
+	.hugetlb_entry = damon_mkold_hugetlb_entry,
 };
 
 static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
@@ -482,8 +508,47 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
+				     unsigned long addr, unsigned long end,
+				     struct mm_walk *walk)
+{
+	struct damon_young_walk_private *priv = walk->private;
+	struct hstate *h = hstate_vma(walk->vma);
+	struct page *page;
+	spinlock_t *ptl;
+	pte_t entry;
+
+	ptl = huge_pte_lock(h, walk->mm, pte);
+	entry = huge_ptep_get(pte);
+	if (!pte_present(entry))
+		goto out;
+
+	page = pte_page(entry);
+	if (!page)
+		goto out;
+
+	get_page(page);
+
+	if (pte_young(entry) || !page_is_idle(page) ||
+	    mmu_notifier_test_young(walk->mm, addr)) {
+		*priv->page_sz = huge_page_size(h);
+		priv->young = true;
+	}
+
+	put_page(page);
+
+out:
+	spin_unlock(ptl);
+	return 0;
+}
+#else
+#define damon_young_hugetlb_entry NULL
+#endif
+
 static const struct mm_walk_ops damon_young_ops = {
 	.pmd_entry = damon_young_pmd_entry,
+	.hugetlb_entry = damon_young_hugetlb_entry,
 };
 
 static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
-- 
1.8.3.1

