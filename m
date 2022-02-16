Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C5B4B8317
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiBPIbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:31:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBPIbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:31:00 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB821E31
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:30:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V4cXjyl_1645000245;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V4cXjyl_1645000245)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 16:30:46 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, rongwei.wang@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V1 2/5] mm/damon: Add 'damon_region' NUMA fault simulation support
Date:   Wed, 16 Feb 2022 16:30:38 +0800
Message-Id: <35c8c45267c6f2f5b6ec3559592342685106d39e.1645024354.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1645024354.git.xhao@linux.alibaba.com>
References: <cover.1645024354.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These codes development here refers to NUMA balance code,
it will cause a page_fault, in do_numa_page(), we will count
'damon_region' NUMA local and remote values.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 mm/damon/paddr.c        | 23 +++++++++++++++++----
 mm/damon/prmtv-common.c | 44 +++++++++++++++++++++++++++++++++++++++++
 mm/damon/prmtv-common.h |  3 +++
 mm/damon/vaddr.c        | 32 +++++++++++++++++++++---------
 4 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5e8244f65a1a..b8feacf15592 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -16,9 +16,10 @@
 #include "../internal.h"
 #include "prmtv-common.h"
 
-static bool __damon_pa_mkold(struct page *page, struct vm_area_struct *vma,
+static bool __damon_pa_mk_set(struct page *page, struct vm_area_struct *vma,
 		unsigned long addr, void *arg)
 {
+	bool result = false;
 	struct page_vma_mapped_walk pvmw = {
 		.page = page,
 		.vma = vma,
@@ -27,10 +28,24 @@ static bool __damon_pa_mkold(struct page *page, struct vm_area_struct *vma,
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
-		if (pvmw.pte)
+		if (pvmw.pte) {
 			damon_ptep_mkold(pvmw.pte, vma->vm_mm, addr);
-		else
+			if (nr_online_nodes > 1) {
+				result = damon_ptep_mknone(pvmw.pte, vma, addr);
+				if (result)
+					flush_tlb_page(vma, addr);
+			}
+		} else {
 			damon_pmdp_mkold(pvmw.pmd, vma->vm_mm, addr);
+			if (nr_online_nodes > 1) {
+				result = damon_pmdp_mknone(pvmw.pmd, vma, addr);
+				if (result) {
+					unsigned long haddr = addr & HPAGE_PMD_MASK;
+
+					flush_tlb_range(vma, haddr, haddr + HPAGE_PMD_SIZE);
+				}
+			}
+		}
 	}
 	return true;
 }
@@ -39,7 +54,7 @@ static void damon_pa_mkold(unsigned long paddr)
 {
 	struct page *page = damon_get_page(PHYS_PFN(paddr));
 	struct rmap_walk_control rwc = {
-		.rmap_one = __damon_pa_mkold,
+		.rmap_one = __damon_pa_mk_set,
 		.anon_lock = page_lock_anon_vma_read,
 	};
 	bool need_lock;
diff --git a/mm/damon/prmtv-common.c b/mm/damon/prmtv-common.c
index 92a04f5831d6..35ac50fdf7b6 100644
--- a/mm/damon/prmtv-common.c
+++ b/mm/damon/prmtv-common.c
@@ -12,6 +12,50 @@
 
 #include "prmtv-common.h"
 
+bool damon_ptep_mknone(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
+{
+	pte_t oldpte, ptent;
+	bool preserve_write;
+
+	oldpte = *pte;
+	if (pte_protnone(oldpte))
+		return false;
+
+	if (pte_present(oldpte)) {
+		preserve_write = pte_write(oldpte);
+		oldpte = ptep_modify_prot_start(vma, addr, pte);
+		ptent = pte_modify(oldpte, PAGE_NONE);
+
+		if (preserve_write)
+			ptent = pte_mk_savedwrite(ptent);
+
+		ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
+		return true;
+	}
+	return false;
+}
+
+bool damon_pmdp_mknone(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
+{
+	bool preserve_write;
+	pmd_t entry = *pmd;
+
+	if (is_huge_zero_pmd(entry) || pmd_protnone(entry))
+		return false;
+
+	if (pmd_present(entry)) {
+		preserve_write = pmd_write(entry);
+		entry = pmdp_invalidate(vma, addr, pmd);
+		entry = pmd_modify(entry, PAGE_NONE);
+		if (preserve_write)
+			entry = pmd_mk_savedwrite(entry);
+
+		set_pmd_at(vma->vm_mm, addr, pmd, entry);
+		return true;
+	}
+	return false;
+}
+
 /*
  * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
  * NULL.
diff --git a/mm/damon/prmtv-common.h b/mm/damon/prmtv-common.h
index e790cb5f8fe0..002a308facd0 100644
--- a/mm/damon/prmtv-common.h
+++ b/mm/damon/prmtv-common.h
@@ -7,6 +7,9 @@
 
 #include <linux/damon.h>
 
+bool damon_ptep_mknone(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
+bool damon_pmdp_mknone(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
+
 struct page *damon_get_page(unsigned long pfn);
 
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 89b6468da2b9..732b41ed134c 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -367,9 +367,10 @@ static void damon_va_update(struct damon_ctx *ctx)
 	}
 }
 
-static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
+static int damon_va_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
+	bool result = false;
 	pte_t *pte;
 	spinlock_t *ptl;
 
@@ -377,7 +378,14 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		ptl = pmd_lock(walk->mm, pmd);
 		if (pmd_huge(*pmd)) {
 			damon_pmdp_mkold(pmd, walk->mm, addr);
+			if (nr_online_nodes > 1)
+				result = damon_pmdp_mknone(pmd, walk->vma, addr);
 			spin_unlock(ptl);
+			if (result) {
+				unsigned long haddr = addr & HPAGE_PMD_MASK;
+
+				flush_tlb_range(walk->vma, haddr, haddr + HPAGE_PMD_SIZE);
+			}
 			return 0;
 		}
 		spin_unlock(ptl);
@@ -386,11 +394,17 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
 		return 0;
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-	if (!pte_present(*pte))
-		goto out;
+	if (!pte_present(*pte)) {
+		pte_unmap_unlock(pte, ptl);
+		return 0;
+	}
 	damon_ptep_mkold(pte, walk->mm, addr);
-out:
+	if (nr_online_nodes > 1)
+		result = damon_ptep_mknone(pte, walk->vma, addr);
 	pte_unmap_unlock(pte, ptl);
+	if (result)
+		flush_tlb_page(walk->vma, addr);
+
 	return 0;
 }
 
@@ -450,15 +464,15 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 #define damon_mkold_hugetlb_entry NULL
 #endif /* CONFIG_HUGETLB_PAGE */
 
-static const struct mm_walk_ops damon_mkold_ops = {
-	.pmd_entry = damon_mkold_pmd_entry,
+static const struct mm_walk_ops damon_va_ops = {
+	.pmd_entry = damon_va_pmd_entry,
 	.hugetlb_entry = damon_mkold_hugetlb_entry,
 };
 
-static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
+static void damon_va_check(struct mm_struct *mm, unsigned long addr)
 {
 	mmap_read_lock(mm);
-	walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
+	walk_page_range(mm, addr, addr + 1, &damon_va_ops, NULL);
 	mmap_read_unlock(mm);
 }
 
@@ -471,7 +485,7 @@ static void __damon_va_prepare_access_check(struct damon_ctx *ctx,
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
-	damon_va_mkold(mm, r->sampling_addr);
+	damon_va_check(mm, r->sampling_addr);
 }
 
 static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
-- 
2.27.0

