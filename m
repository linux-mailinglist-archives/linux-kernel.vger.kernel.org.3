Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93B94719CA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 12:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhLLLcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 06:32:15 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:39956 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230165AbhLLLcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 06:32:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V-JhNbu_1639308730;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V-JhNbu_1639308730)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 12 Dec 2021 19:32:11 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com
Cc:     ziy@nvidia.com, shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] mm: Add speculative numa fault support
Date:   Sun, 12 Dec 2021 19:31:57 +0800
Message-Id: <0ec3e9ce4b564bee3883b6141b1f9f2498188002.1639306956.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
References: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
References: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some workloads access a set of data entities will follow the data locality,
also known as locality of reference, which means the probability of accessing
some data soon after some nearby data has been accessed.

On some systems with different memory types, which will rely on the numa
balancing to promote slow hot memory to fast memory to improve performance.
So we can promote several sequential pages on slow memory in advance according
to the data locality for some workloads to improve the performance.

Thus this patch supports speculative numa fault mechanism to help to
migrate suitable pages in advance to improve the performance. And now
the basic concept of the speculative numa fault is that, it will add a
new member for each VMA to record the numa fault window, which will record
the last numa fault address and the pages need to be migrated to the target
node. So when numa fault occurs, we will check the last numa fault window
for current VMA to check if it is a sequential stream accessing, if yes, we
can expand the numa fault window; if not, we can reduce the numa fault
winow or close the speculative numa fault to avoid doing unnecessary
migration.

Testing with mysql can show about 6% performance improved as below.

Machine: 16 CPUs, 64G DRAM, 256G AEP

sysbench /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua
--mysql-user=root --mysql-password=root --oltp-test-mode=complex
--oltp-tables-count=80 --oltp-table-size=5000000 --threads=20 --time=600
--report-interval=10 prepare/run

No speculative numa fault:
    queries performed:
        read:                            33039860
        write:                           9439960
        other:                           4719980
        total:                           47199800
    transactions:                        2359990 (3933.28 per sec.)
    queries:                             47199800 (78665.50 per sec.)

Speculative numa fault:
    queries performed:
        read:                            34896862
        write:                           9970532
        other:                           4985266
        total:                           49852660
    transactions:                        2492633 (4154.35 per sec.)
    queries:                             49852660 (83086.94 per sec.)

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/mm_types.h |   3 +
 mm/memory.c              | 165 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 159 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 449b6eafc695..8d8381e9aec9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -474,6 +474,9 @@ struct vm_area_struct {
 #endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	atomic_long_t numafault_ahead_info;
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 } __randomize_layout;
diff --git a/mm/memory.c b/mm/memory.c
index 2291417783bc..2c9ed63e4e23 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -74,6 +74,8 @@
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
+#include <linux/pagewalk.h>
+#include <linux/page_idle.h>
 
 #include <trace/events/kmem.h>
 
@@ -4315,16 +4317,156 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 	return mpol_misplaced(page, vma, addr);
 }
 
+static bool try_next_numa_page(struct vm_fault *vmf, unsigned int win_pages,
+			       unsigned long *fault_addr)
+{
+	unsigned long next_fault_addr = *fault_addr + PAGE_SIZE;
+	unsigned long numa_fault_end = vmf->address + (win_pages + 1) * PAGE_SIZE;
+
+	if (next_fault_addr > numa_fault_end)
+		return false;
+
+	*fault_addr = next_fault_addr;
+	vmf->pte = pte_offset_map(vmf->pmd, next_fault_addr);
+	vmf->orig_pte = *vmf->pte;
+	if (pte_protnone(vmf->orig_pte))
+		return true;
+
+	return false;
+}
+
+#define NUMA_FAULT_AHEAD_DEFUALT	2
+#define NUMA_FAULT_EXPAND_STEP		1
+#define NUMA_FAULT_REDUCE_STEP		2
+#define GET_NUMA_FAULT_INFO(vma)	\
+	(atomic_long_read(&(vma)->numafault_ahead_info))
+#define NUMA_FAULT_WINDOW_START(v)	((v) & PAGE_MASK)
+#define NUMA_FAULT_WINDOW_SIZE_MASK	((1UL << PAGE_SHIFT) - 1)
+#define NUMA_FAULT_WINDOW_SIZE(v)	((v) & NUMA_FAULT_WINDOW_SIZE_MASK)
+#define NUMA_FAULT_INFO(addr, win)	\
+	(((addr) & PAGE_MASK) |		\
+	((win) & NUMA_FAULT_WINDOW_SIZE_MASK))
+
+static inline unsigned int numa_fault_max_pages(struct vm_area_struct *vma,
+						unsigned long fault_address)
+{
+	unsigned long pmd_end_addr = (fault_address & PMD_MASK) + PMD_SIZE;
+	unsigned long max_fault_addr = min_t(unsigned long, pmd_end_addr,
+					    vma->vm_end);
+
+	return (max_fault_addr - fault_address - 1) >> PAGE_SHIFT;
+}
+
+static unsigned int adjust_numa_fault_window(struct vm_area_struct *vma,
+					     unsigned long fault_address)
+{
+	unsigned long numafault_ahead = GET_NUMA_FAULT_INFO(vma);
+        unsigned long prev_start = NUMA_FAULT_WINDOW_START(numafault_ahead);
+        unsigned int prev_pages = NUMA_FAULT_WINDOW_SIZE(numafault_ahead);
+	unsigned long win_start;
+	unsigned int win_pages, max_fault_pages;
+
+	win_start = fault_address + PAGE_SIZE;
+
+	/*
+	 * Start accessing the VMA, then just open a small window to try.
+	 */
+	if (!numafault_ahead) {
+		win_pages = NUMA_FAULT_AHEAD_DEFUALT;
+		goto out;
+	}
+
+	/*
+	 * If last numa fault window was close, we should check if current fault
+	 * address is continue with previous fault addess before opening the
+	 * new numa fault window.
+	 */
+	if (!prev_pages) {
+		if (fault_address == prev_start ||
+		    fault_address == prev_start + PAGE_SIZE)
+			win_pages = NUMA_FAULT_AHEAD_DEFUALT;
+		else
+			win_pages = 0;
+
+		goto out;
+	}
+
+	/*
+	 * TODO: need check the fault addess is occured before the last numa
+	 * fault window.
+	 */
+	if (fault_address >= prev_start) {
+		unsigned long prev_end = prev_start + prev_pages * PAGE_SIZE;
+
+		/*
+		 * Continue with the previous numa fault window, then assume
+		 * it is a sequential accessing, which need expand the numa fault
+		 * window.
+		 */
+		if (fault_address == prev_end ||
+		    fault_address == prev_end + PAGE_SIZE) {
+			win_pages = prev_pages + NUMA_FAULT_EXPAND_STEP;
+			goto validate_out;
+		} else if (fault_address < prev_end) {
+			/*
+			 * If current fault address is in the range of last numa
+			 * fault window, which means the pages in last numa fault
+			 * window were not all migrated successfully, so just
+			 * keep current size of last numa fault window to try
+			 * again, since last numa fault window speculation may
+			 * be on the correct way.
+			 */
+			win_pages = prev_pages;
+			goto validate_out;
+		}
+	}
+
+	/*
+	 * Until now assume random accessing, reduce the numa fault window
+	 * by step.
+	 */
+	if (prev_pages <= NUMA_FAULT_REDUCE_STEP) {
+		win_pages = 0;
+		goto out;
+	} else {
+		win_pages = prev_pages - NUMA_FAULT_REDUCE_STEP;
+	}
+
+validate_out:
+	/*
+	 * Make sure the size of ahead numa fault address is less than the
+	 * size of current VMA or PMD.
+	 */
+	max_fault_pages = numa_fault_max_pages(vma, fault_address);
+	if (win_pages > max_fault_pages)
+		win_pages = max_fault_pages;
+
+out:
+	atomic_long_set(&vma->numafault_ahead_info,
+			NUMA_FAULT_INFO(win_start, win_pages));
+	return win_pages;
+}
+
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = NULL;
-	int page_nid = NUMA_NO_NODE;
+	int page_nid;
 	int last_cpupid;
 	int target_nid;
 	pte_t pte, old_pte;
-	bool was_writable = pte_savedwrite(vmf->orig_pte);
-	int flags = 0;
+	bool was_writable;
+	int flags;
+	unsigned long fault_address = vmf->address;
+	unsigned int win_pages;
+
+	/*  Try to speculate the numa fault window for current VMA. */
+	win_pages = adjust_numa_fault_window(vma, fault_address);
+
+try_next:
+	was_writable = pte_savedwrite(vmf->orig_pte);
+	flags = 0;
+	page_nid = NUMA_NO_NODE;
 
 	/*
 	 * The "pte" at this point cannot be used safely without
@@ -4342,7 +4484,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	old_pte = ptep_get(vmf->pte);
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 
-	page = vm_normal_page(vma, vmf->address, pte);
+	page = vm_normal_page(vma, fault_address, pte);
 	if (!page)
 		goto out_map;
 
@@ -4378,7 +4520,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
 		last_cpupid = page_cpupid_last(page);
-	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
+	target_nid = numa_migrate_prep(page, vma, fault_address, page_nid,
 			&flags);
 	if (target_nid == NUMA_NO_NODE) {
 		put_page(page);
@@ -4392,7 +4534,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		flags |= TNF_MIGRATED;
 	} else {
 		flags |= TNF_MIGRATE_FAIL;
-		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
+		vmf->pte = pte_offset_map(vmf->pmd, fault_address);
 		spin_lock(vmf->ptl);
 		if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -4404,19 +4546,24 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 out:
 	if (page_nid != NUMA_NO_NODE)
 		task_numa_fault(last_cpupid, page_nid, 1, flags);
+
+	if ((flags & TNF_MIGRATED) && (win_pages > 0) &&
+	    try_next_numa_page(vmf, win_pages, &fault_address))
+		goto try_next;
+
 	return 0;
 out_map:
 	/*
 	 * Make it present again, depending on how arch implements
 	 * non-accessible ptes, some can allow access by kernel mode.
 	 */
-	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
+	old_pte = ptep_modify_prot_start(vma, fault_address, vmf->pte);
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 	pte = pte_mkyoung(pte);
 	if (was_writable)
 		pte = pte_mkwrite(pte);
-	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
-	update_mmu_cache(vma, vmf->address, vmf->pte);
+	ptep_modify_prot_commit(vma, fault_address, vmf->pte, old_pte, pte);
+	update_mmu_cache(vma, fault_address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	goto out;
 }
-- 
2.27.0

