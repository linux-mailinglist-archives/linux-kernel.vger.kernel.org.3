Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDC6514AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359864AbiD2Nk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359840AbiD2Nkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:40:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D27ECB03D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n14so282194plf.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vfiCmddC+7ZKj47uoVoXhmc2OB+ra/xXEY2BBYUTQ0I=;
        b=N8g8Y0NlYBcVwLLMJUrGJv7JOI9uCFz5c4LZHV8Ana9n4lqzBs5+xsmPmVEYIbfKsg
         odMCYNM1+2iRANbOVyDsE4CxFIDC6tfN5Q4KRP+UGYgc76Av12gM0j7qlThiAfAuXs3h
         /VAXQKUdsKtp70HAo+Dtez0N9tQfzuOKJM24kBsHm3sFWq42S4JPVlh0rLXuWPylEvW4
         ZcJ8Qm3Rj10ZVraesw1ftsomuWK7lNtzefDcu8/9mp82Y3WihTOadO9/7h8Zf7lNnun/
         /XVssHvGBkLS5je51Whqn3VO6awKzUQbPc9s9/5Mjp//R1lTImRXCyRGVWRCQ1a1s3qH
         Zk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfiCmddC+7ZKj47uoVoXhmc2OB+ra/xXEY2BBYUTQ0I=;
        b=HfoUclSnTJdMgs2S7JWc7cbIK/Uwqurm58Fl8wYpM8la0qUV3i0pcWs3tdNiwzUtTg
         Wmkm2D/Cy638FztpPTZeZTaEMPP8XK2OGr5Z4eVOQ12lnu3+Gr3NbJ+95L26t06crVX4
         646Rxm82gOv62LslaQCAnUrhxD7yO/CAJf3XB/KZ/l/JmBKbtCpR8yP7nXk2i115/458
         tfpI/7n6QB0A0TTlbtwVPwXYKyEMnIz2+EAbYWFK2sZQ4k0tPYlpvHtAifUqST+SQnrq
         qriMMHj60S3F7PJKOJsCJ8vv7d7ouX4ZulUGsTa2gi5l31ak1VNDW7Al7/OSRYRqaKzu
         xGyg==
X-Gm-Message-State: AOAM531Jq3pb+nqziNYxsb/RErwaz+sI9XPFoiErhYrCwwaqd3kYR4K/
        YTvQLQoiWvW6LAPV70KXw+bwqQ==
X-Google-Smtp-Source: ABdhPJxU50DpM9zXS10Ztlg3jVeqDyyHMnBwcSuzKIki0feYMT5Nf8Fd0pD18GCFTDesQcItxVzKcA==
X-Received: by 2002:a17:902:e5cd:b0:15d:57c7:b9fb with SMTP id u13-20020a170902e5cd00b0015d57c7b9fbmr12006973plf.101.1651239440662;
        Fri, 29 Apr 2022 06:37:20 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:37:20 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 11/18] mm: convert to use pte_tryget_map_lock()
Date:   Fri, 29 Apr 2022 21:35:45 +0800
Message-Id: <20220429133552.33768-12-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pte_tryget_map_lock() to help us to try to get the
refcount of the PTE page table page we want to access,
which can prevents the page from being freed during access.

For the following cases, the PTE page table page is stable:

 - got the refcount of PTE page table page already
 - has no concurrent threads(e.g. the write lock of mmap_lock
			     is acquired)
 - the PTE page table page is not yet visible
 - turn off the local cpu interrupt or hold the rcu lock
   (e.g. GUP fast path)
 - the PTE page table page is kernel PTE page table page

So we still keep using pte_offset_map_lock() and replace
pte_unmap_unlock() with __pte_unmap_unlock() which doesn't
reduce the refcount.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/proc/task_mmu.c    |  16 ++++--
 include/linux/mm.h    |   2 +-
 mm/damon/vaddr.c      |  30 ++++++----
 mm/debug_vm_pgtable.c |   2 +-
 mm/filemap.c          |   4 +-
 mm/gup.c              |   4 +-
 mm/khugepaged.c       |  10 +++-
 mm/ksm.c              |   4 +-
 mm/madvise.c          |  30 +++++++---
 mm/memcontrol.c       |   8 ++-
 mm/memory-failure.c   |   4 +-
 mm/memory.c           | 125 +++++++++++++++++++++++++++++-------------
 mm/mempolicy.c        |   4 +-
 mm/migrate_device.c   |  22 +++++---
 mm/mincore.c          |   5 +-
 mm/mlock.c            |   5 +-
 mm/mprotect.c         |   4 +-
 mm/mremap.c           |   5 +-
 mm/pagewalk.c         |   4 +-
 mm/swapfile.c         |  13 +++--
 mm/userfaultfd.c      |  11 +++-
 21 files changed, 219 insertions(+), 93 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f46060eb91b5..5fff96659e4f 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -625,7 +625,9 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	 * keeps khugepaged out of here and from collapsing things
 	 * in here.
 	 */
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte)
+		goto out;
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		smaps_pte_entry(pte, addr, walk);
 	pte_unmap_unlock(pte - 1, ptl);
@@ -1178,7 +1180,9 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		ptent = *pte;
 
@@ -1515,7 +1519,9 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	 * We can assume that @vma always points to a valid one and @end never
 	 * goes beyond vma->vm_end.
 	 */
-	orig_pte = pte = pte_offset_map_lock(walk->mm, pmdp, addr, &ptl);
+	orig_pte = pte = pte_tryget_map_lock(walk->mm, pmdp, addr, &ptl);
+	if (!pte)
+		return 0;
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
 		pagemap_entry_t pme;
 
@@ -1849,7 +1855,9 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 #endif
-	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	orig_pte = pte = pte_tryget_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 	do {
 		struct page *page = can_gather_numa_stats(*pte, vma, addr);
 		if (!page)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1a6bc79c351b..04f7a6c36dc7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2288,7 +2288,7 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 
 #define pte_alloc_map_lock(mm, pmd, address, ptlp)	\
 	(pte_alloc(mm, pmd) ?			\
-		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
+		 NULL : pte_tryget_map_lock(mm, pmd, address, ptlp))
 
 #define pte_alloc_kernel(pmd, address)			\
 	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b2ec0aa1ff45..4aa9e252c081 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -372,10 +372,13 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 {
 	pte_t *pte;
 	spinlock_t *ptl;
+	pmd_t pmdval;
 
-	if (pmd_huge(*pmd)) {
+retry:
+	pmdval = READ_ONCE(*pmd);
+	if (pmd_huge(pmdval)) {
 		ptl = pmd_lock(walk->mm, pmd);
-		if (pmd_huge(*pmd)) {
+		if (pmd_huge(pmdval)) {
 			damon_pmdp_mkold(pmd, walk->mm, addr);
 			spin_unlock(ptl);
 			return 0;
@@ -383,9 +386,11 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		spin_unlock(ptl);
 	}
 
-	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+	if (pmd_none(pmdval) || unlikely(pmd_bad(pmdval)))
 		return 0;
-	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte)
+		goto retry;
 	if (!pte_present(*pte))
 		goto out;
 	damon_ptep_mkold(pte, walk->mm, addr);
@@ -499,18 +504,21 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	spinlock_t *ptl;
 	struct page *page;
 	struct damon_young_walk_private *priv = walk->private;
+	pmd_t pmdval;
 
+retry:
+	pmdval = READ_ONCE(*pmd);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pmd_huge(*pmd)) {
+	if (pmd_huge(pmdval)) {
 		ptl = pmd_lock(walk->mm, pmd);
-		if (!pmd_huge(*pmd)) {
+		if (!pmd_huge(pmdval)) {
 			spin_unlock(ptl);
 			goto regular_page;
 		}
-		page = damon_get_page(pmd_pfn(*pmd));
+		page = damon_get_page(pmd_pfn(pmdval));
 		if (!page)
 			goto huge_out;
-		if (pmd_young(*pmd) || !page_is_idle(page) ||
+		if (pmd_young(pmdval) || !page_is_idle(page) ||
 					mmu_notifier_test_young(walk->mm,
 						addr)) {
 			*priv->page_sz = ((1UL) << HPAGE_PMD_SHIFT);
@@ -525,9 +533,11 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 regular_page:
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
 
-	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+	if (pmd_none(pmdval) || unlikely(pmd_bad(pmdval)))
 		return -EINVAL;
-	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte)
+		goto retry;
 	if (!pte_present(*pte))
 		goto out;
 	page = damon_get_page(pte_pfn(*pte));
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index db2abd9e415b..91c4400ca13c 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1303,7 +1303,7 @@ static int __init debug_vm_pgtable(void)
 	 * proper page table lock.
 	 */
 
-	args.ptep = pte_offset_map_lock(args.mm, args.pmdp, args.vaddr, &ptl);
+	args.ptep = pte_tryget_map_lock(args.mm, args.pmdp, args.vaddr, &ptl);
 	pte_clear_tests(&args);
 	pte_advanced_tests(&args);
 	pte_unmap_unlock(args.ptep, ptl);
diff --git a/mm/filemap.c b/mm/filemap.c
index 3a5ffb5587cd..fc156922147b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3368,7 +3368,9 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	}
 
 	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
+	vmf->pte = pte_tryget_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
+	if (!vmf->pte)
+		goto out;
 	do {
 again:
 		page = folio_file_page(folio, xas.xa_index);
diff --git a/mm/gup.c b/mm/gup.c
index f598a037eb04..d2c24181fb04 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -451,7 +451,9 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	if (unlikely(pmd_bad(*pmd)))
 		return no_page_table(vma, flags);
 
-	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
+	ptep = pte_tryget_map_lock(mm, pmd, address, &ptl);
+	if (!ptep)
+		return no_page_table(vma, flags);
 	pte = *ptep;
 	if (!pte_present(pte)) {
 		swp_entry_t entry;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a4e5eaf3eb01..3776cc315294 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1227,7 +1227,11 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	}
 
 	memset(khugepaged_node_load, 0, sizeof(khugepaged_node_load));
-	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
+	pte = pte_tryget_map_lock(mm, pmd, address, &ptl);
+	if (!pte) {
+		result = SCAN_PMD_NULL;
+		goto out;
+	}
 	for (_address = address, _pte = pte; _pte < pte+HPAGE_PMD_NR;
 	     _pte++, _address += PAGE_SIZE) {
 		pte_t pteval = *_pte;
@@ -1505,7 +1509,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 		page_remove_rmap(page, vma, false);
 	}
 
-	pte_unmap_unlock(start_pte, ptl);
+	__pte_unmap_unlock(start_pte, ptl);
 
 	/* step 3: set proper refcount and mm_counters. */
 	if (count) {
@@ -1521,7 +1525,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	return;
 
 abort:
-	pte_unmap_unlock(start_pte, ptl);
+	__pte_unmap_unlock(start_pte, ptl);
 	goto drop_hpage;
 }
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 063a48eeb5ee..64a5f965cfc5 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1138,7 +1138,9 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 				addr + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 
-	ptep = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	ptep = pte_tryget_map_lock(mm, pmd, addr, &ptl);
+	if (!ptep)
+		goto out_mn;
 	if (!pte_same(*ptep, orig_pte)) {
 		pte_unmap_unlock(ptep, ptl);
 		goto out_mn;
diff --git a/mm/madvise.c b/mm/madvise.c
index 1873616a37d2..8123397f14c8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -207,7 +207,9 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		struct page *page;
 		spinlock_t *ptl;
 
-		orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
+		orig_pte = pte_tryget_map_lock(vma->vm_mm, pmd, start, &ptl);
+		if (!orig_pte)
+			break;
 		pte = *(orig_pte + ((index - start) / PAGE_SIZE));
 		pte_unmap_unlock(orig_pte, ptl);
 
@@ -400,7 +402,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		return 0;
 #endif
 	tlb_change_page_size(tlb, PAGE_SIZE);
-	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	orig_pte = pte = pte_tryget_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!orig_pte)
+		return 0;
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
@@ -432,12 +436,14 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			if (split_huge_page(page)) {
 				unlock_page(page);
 				put_page(page);
-				pte_offset_map_lock(mm, pmd, addr, &ptl);
+				orig_pte = pte = pte_tryget_map_lock(mm, pmd, addr, &ptl);
 				break;
 			}
 			unlock_page(page);
 			put_page(page);
-			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			orig_pte = pte = pte_tryget_map_lock(mm, pmd, addr, &ptl);
+			if (!pte)
+				break;
 			pte--;
 			addr -= PAGE_SIZE;
 			continue;
@@ -477,7 +483,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	}
 
 	arch_leave_lazy_mmu_mode();
-	pte_unmap_unlock(orig_pte, ptl);
+	if (orig_pte)
+		pte_unmap_unlock(orig_pte, ptl);
 	if (pageout)
 		reclaim_pages(&page_list);
 	cond_resched();
@@ -602,7 +609,9 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
-	orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	orig_pte = pte = pte_tryget_map_lock(mm, pmd, addr, &ptl);
+	if (!orig_pte)
+		return 0;
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
@@ -648,12 +657,14 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			if (split_huge_page(page)) {
 				unlock_page(page);
 				put_page(page);
-				pte_offset_map_lock(mm, pmd, addr, &ptl);
+				orig_pte = pte = pte_tryget_map_lock(mm, pmd, addr, &ptl);
 				goto out;
 			}
 			unlock_page(page);
 			put_page(page);
-			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			orig_pte = pte = pte_tryget_map_lock(mm, pmd, addr, &ptl);
+			if (!pte)
+				goto out;
 			pte--;
 			addr -= PAGE_SIZE;
 			continue;
@@ -707,7 +718,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
 	}
 	arch_leave_lazy_mmu_mode();
-	pte_unmap_unlock(orig_pte, ptl);
+	if (orig_pte)
+		pte_unmap_unlock(orig_pte, ptl);
 	cond_resched();
 next:
 	return 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 725f76723220..ad51ec9043b7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5736,7 +5736,9 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 
 	if (pmd_trans_unstable(pmd))
 		return 0;
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 	for (; addr != end; pte++, addr += PAGE_SIZE)
 		if (get_mctgt_type(vma, addr, *pte, NULL))
 			mc.precharge++;	/* increment precharge temporarily */
@@ -5955,7 +5957,9 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 retry:
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 	for (; addr != end; addr += PAGE_SIZE) {
 		pte_t ptent = *(pte++);
 		bool device = false;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index dcb6bb9cf731..5247932df3fa 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -637,8 +637,10 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 	if (pmd_trans_unstable(pmdp))
 		goto out;
 
-	mapped_pte = ptep = pte_offset_map_lock(walk->vma->vm_mm, pmdp,
+	mapped_pte = ptep = pte_tryget_map_lock(walk->vma->vm_mm, pmdp,
 						addr, &ptl);
+	if (!mapped_pte)
+		goto out;
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
 		ret = check_hwpoisoned_entry(*ptep, addr, PAGE_SHIFT,
 					     hwp->pfn, &hwp->tk);
diff --git a/mm/memory.c b/mm/memory.c
index 76e3af9639d9..ca03006b32cb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1352,7 +1352,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	tlb_change_page_size(tlb, PAGE_SIZE);
 again:
 	init_rss_vec(rss);
-	start_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	start_pte = pte_tryget_map_lock(mm, pmd, addr, &ptl);
+	if (!start_pte)
+		return end;
 	pte = start_pte;
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
@@ -1846,7 +1848,9 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 		int pte_idx = 0;
 		const int batch_size = min_t(int, pages_to_write_in_pmd, 8);
 
-		start_pte = pte_offset_map_lock(mm, pmd, addr, &pte_lock);
+		start_pte = pte_tryget_map_lock(mm, pmd, addr, &pte_lock);
+		if (!start_pte)
+			break;
 		for (pte = start_pte; pte_idx < batch_size; ++pte, ++pte_idx) {
 			int err = insert_page_in_batch_locked(vma, pte,
 				addr, pages[curr_page_idx], prot);
@@ -2532,9 +2536,13 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 		if (!pte)
 			return -ENOMEM;
 	} else {
-		mapped_pte = pte = (mm == &init_mm) ?
-			pte_offset_kernel(pmd, addr) :
-			pte_offset_map_lock(mm, pmd, addr, &ptl);
+		if (mm == &init_mm) {
+			mapped_pte = pte = pte_offset_kernel(pmd, addr);
+		} else {
+			mapped_pte = pte = pte_tryget_map_lock(mm, pmd, addr, &ptl);
+			if (!mapped_pte)
+				return err;
+		}
 	}
 
 	BUG_ON(pmd_huge(*pmd));
@@ -2787,7 +2795,11 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 	if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
 		pte_t entry;
 
-		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
+		vmf->pte = pte_tryget_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
+		if (!vmf->pte) {
+			ret = false;
+			goto pte_unlock;
+		}
 		locked = true;
 		if (!likely(pte_same(*vmf->pte, vmf->orig_pte))) {
 			/*
@@ -2815,7 +2827,11 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 			goto warn;
 
 		/* Re-validate under PTL if the page is still mapped */
-		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
+		vmf->pte = pte_tryget_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
+		if (!vmf->pte) {
+			ret = false;
+			goto pte_unlock;
+		}
 		locked = true;
 		if (!likely(pte_same(*vmf->pte, vmf->orig_pte))) {
 			/* The PTE changed under us, update local tlb */
@@ -3005,6 +3021,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	pte_t entry;
 	int page_copied = 0;
 	struct mmu_notifier_range range;
+	vm_fault_t ret = VM_FAULT_OOM;
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
@@ -3048,7 +3065,12 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
-	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
+	vmf->pte = pte_tryget_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
+	if (!vmf->pte) {
+		mmu_notifier_invalidate_range_only_end(&range);
+		ret = VM_FAULT_RETRY;
+		goto uncharge;
+	}
 	if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
 		if (old_page) {
 			if (!PageAnon(old_page)) {
@@ -3129,12 +3151,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		put_page(old_page);
 	}
 	return page_copied ? VM_FAULT_WRITE : 0;
+uncharge:
+	mem_cgroup_uncharge(page_folio(new_page));
 oom_free_new:
 	put_page(new_page);
 oom:
 	if (old_page)
 		put_page(old_page);
-	return VM_FAULT_OOM;
+	return ret;
 }
 
 /**
@@ -3156,8 +3180,10 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf)
 {
 	WARN_ON_ONCE(!(vmf->vma->vm_flags & VM_SHARED));
-	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address,
+	vmf->pte = pte_tryget_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address,
 				       &vmf->ptl);
+	if (!vmf->pte)
+		return VM_FAULT_NOPAGE;
 	/*
 	 * We might have raced with another page fault while we released the
 	 * pte_offset_map_lock.
@@ -3469,6 +3495,7 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	struct vm_area_struct *vma = vmf->vma;
 	struct mmu_notifier_range range;
+	vm_fault_t ret = 0;
 
 	if (!lock_page_or_retry(page, vma->vm_mm, vmf->flags))
 		return VM_FAULT_RETRY;
@@ -3477,16 +3504,21 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 				(vmf->address & PAGE_MASK) + PAGE_SIZE, NULL);
 	mmu_notifier_invalidate_range_start(&range);
 
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
+	vmf->pte = pte_tryget_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 				&vmf->ptl);
+	if (!vmf->pte) {
+		ret = VM_FAULT_RETRY;
+		goto out;
+	}
 	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
 		restore_exclusive_pte(vma, page, vmf->address, vmf->pte);
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+out:
 	unlock_page(page);
 
 	mmu_notifier_invalidate_range_end(&range);
-	return 0;
+	return ret;
 }
 
 static inline bool should_try_to_free_swap(struct page *page,
@@ -3599,8 +3631,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 * Back out if somebody else faulted in this pte
 			 * while we released the pte lock.
 			 */
-			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+			vmf->pte = pte_tryget_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
+			if (!vmf->pte) {
+				ret = VM_FAULT_OOM;
+				goto out;
+			}
 			if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
 				ret = VM_FAULT_OOM;
 			goto unlock;
@@ -3666,8 +3702,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	/*
 	 * Back out if somebody else already faulted in this pte.
 	 */
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
+	vmf->pte = pte_tryget_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
+	if (!vmf->pte)
+		goto out_page;
 	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
 		goto out_nomap;
 
@@ -3781,6 +3819,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (vma->vm_flags & VM_SHARED)
 		return VM_FAULT_SIGBUS;
 
+retry:
 	/*
 	 * Use pte_alloc() instead of pte_alloc_map().  We can't run
 	 * pte_offset_map() on pmds where a huge pmd might be created
@@ -3803,8 +3842,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 			!mm_forbids_zeropage(vma->vm_mm)) {
 		entry = pte_mkspecial(pfn_pte(my_zero_pfn(vmf->address),
 						vma->vm_page_prot));
-		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+		vmf->pte = pte_tryget_map_lock(vma->vm_mm, vmf->pmd,
 				vmf->address, &vmf->ptl);
+		if (!vmf->pte)
+			goto retry;
 		if (!pte_none(*vmf->pte)) {
 			update_mmu_tlb(vma, vmf->address, vmf->pte);
 			goto unlock;
@@ -3843,8 +3884,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry));
 
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
+	vmf->pte = pte_tryget_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
+	if (!vmf->pte)
+		goto uncharge;
 	if (!pte_none(*vmf->pte)) {
 		update_mmu_cache(vma, vmf->address, vmf->pte);
 		goto release;
@@ -3875,6 +3918,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 release:
 	put_page(page);
 	goto unlock;
+uncharge:
+	mem_cgroup_uncharge(page_folio(page));
 oom_free_page:
 	put_page(page);
 oom:
@@ -4112,8 +4157,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	if (pmd_devmap_trans_unstable(vmf->pmd))
 		return 0;
 
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+	vmf->pte = pte_tryget_map_lock(vma->vm_mm, vmf->pmd,
 				      vmf->address, &vmf->ptl);
+	if (!vmf->pte)
+		return 0;
 	ret = 0;
 	/* Re-check under ptl */
 	if (likely(pte_none(*vmf->pte)))
@@ -4340,31 +4387,27 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
 	 */
 	if (!vma->vm_ops->fault) {
-		/*
-		 * If we find a migration pmd entry or a none pmd entry, which
-		 * should never happen, return SIGBUS
-		 */
-		if (unlikely(!pmd_present(*vmf->pmd)))
-			ret = VM_FAULT_SIGBUS;
-		else {
-			vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm,
+		vmf->pte = pte_tryget_map_lock(vmf->vma->vm_mm,
 						       vmf->pmd,
 						       vmf->address,
 						       &vmf->ptl);
-			/*
-			 * Make sure this is not a temporary clearing of pte
-			 * by holding ptl and checking again. A R/M/W update
-			 * of pte involves: take ptl, clearing the pte so that
-			 * we don't have concurrent modification by hardware
-			 * followed by an update.
-			 */
-			if (unlikely(pte_none(*vmf->pte)))
-				ret = VM_FAULT_SIGBUS;
-			else
-				ret = VM_FAULT_NOPAGE;
-
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
+		if (!vmf->pte) {
+			ret = VM_FAULT_RETRY;
+			goto out;
 		}
+		/*
+			* Make sure this is not a temporary clearing of pte
+			* by holding ptl and checking again. A R/M/W update
+			* of pte involves: take ptl, clearing the pte so that
+			* we don't have concurrent modification by hardware
+			* followed by an update.
+			*/
+		if (unlikely(pte_none(*vmf->pte)))
+			ret = VM_FAULT_SIGBUS;
+		else
+			ret = VM_FAULT_NOPAGE;
+
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
 	} else if (!(vmf->flags & FAULT_FLAG_WRITE))
 		ret = do_read_fault(vmf);
 	else if (!(vma->vm_flags & VM_SHARED))
@@ -4372,6 +4415,7 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	else
 		ret = do_shared_fault(vmf);
 
+out:
 	/* preallocated pagetable is unused: free it */
 	if (vmf->prealloc_pte) {
 		pte_free(vm_mm, vmf->prealloc_pte);
@@ -5003,13 +5047,16 @@ int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
 					(address & PAGE_MASK) + PAGE_SIZE);
 		mmu_notifier_invalidate_range_start(range);
 	}
-	ptep = pte_offset_map_lock(mm, pmd, address, ptlp);
+	ptep = pte_tryget_map_lock(mm, pmd, address, ptlp);
+	if (!ptep)
+		goto invalid;
 	if (!pte_present(*ptep))
 		goto unlock;
 	*ptepp = ptep;
 	return 0;
 unlock:
 	pte_unmap_unlock(ptep, *ptlp);
+invalid:
 	if (range)
 		mmu_notifier_invalidate_range_end(range);
 out:
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 8c74107a2b15..a846666c64c3 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -523,7 +523,9 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
-	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	mapped_pte = pte = pte_tryget_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!mapped_pte)
+		return 0;
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		if (!pte_present(*pte))
 			continue;
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 70c7dc05bbfc..260471f37470 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -64,21 +64,23 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	unsigned long addr = start, unmapped = 0;
 	spinlock_t *ptl;
 	pte_t *ptep;
+	pmd_t pmdval;
 
 again:
-	if (pmd_none(*pmdp))
+	pmdval = READ_ONCE(*pmdp);
+	if (pmd_none(pmdval))
 		return migrate_vma_collect_hole(start, end, -1, walk);
 
-	if (pmd_trans_huge(*pmdp)) {
+	if (pmd_trans_huge(pmdval)) {
 		struct page *page;
 
 		ptl = pmd_lock(mm, pmdp);
-		if (unlikely(!pmd_trans_huge(*pmdp))) {
+		if (unlikely(!pmd_trans_huge(pmdval))) {
 			spin_unlock(ptl);
 			goto again;
 		}
 
-		page = pmd_page(*pmdp);
+		page = pmd_page(pmdval);
 		if (is_huge_zero_page(page)) {
 			spin_unlock(ptl);
 			split_huge_pmd(vma, pmdp, addr);
@@ -99,16 +101,18 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			if (ret)
 				return migrate_vma_collect_skip(start, end,
 								walk);
-			if (pmd_none(*pmdp))
+			if (pmd_none(pmdval))
 				return migrate_vma_collect_hole(start, end, -1,
 								walk);
 		}
 	}
 
-	if (unlikely(pmd_bad(*pmdp)))
+	if (unlikely(pmd_bad(pmdval)))
 		return migrate_vma_collect_skip(start, end, walk);
 
-	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	ptep = pte_tryget_map_lock(mm, pmdp, addr, &ptl);
+	if (!ptep)
+		goto again;
 	arch_enter_lazy_mmu_mode();
 
 	for (; addr < end; addr += PAGE_SIZE, ptep++) {
@@ -588,7 +592,9 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 			entry = pte_mkwrite(pte_mkdirty(entry));
 	}
 
-	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	ptep = pte_tryget_map_lock(mm, pmdp, addr, &ptl);
+	if (!ptep)
+		goto abort;
 
 	if (check_stable_address_space(mm))
 		goto unlock_abort;
diff --git a/mm/mincore.c b/mm/mincore.c
index 9122676b54d6..337f8a45ded0 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -105,6 +105,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	unsigned char *vec = walk->private;
 	int nr = (end - addr) >> PAGE_SHIFT;
 
+again:
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
 		memset(vec, 1, nr);
@@ -117,7 +118,9 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	ptep = pte_tryget_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!ptep)
+		goto again;
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
 		pte_t pte = *ptep;
 
diff --git a/mm/mlock.c b/mm/mlock.c
index 716caf851043..89f7de636efc 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -314,6 +314,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_t *start_pte, *pte;
 	struct page *page;
 
+again:
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
 		if (!pmd_present(*pmd))
@@ -328,7 +329,9 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		goto out;
 	}
 
-	start_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	start_pte = pte_tryget_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!start_pte)
+		goto again;
 	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
 		if (!pte_present(*pte))
 			continue;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b69ce7a7b2b7..aa09cd34ea30 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -63,7 +63,9 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	 * from under us even if the mmap_lock is only hold for
 	 * reading.
 	 */
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte)
+		return 0;
 
 	/* Get target node for single threaded private VMAs */
 	if (prot_numa && !(vma->vm_flags & VM_SHARED) &&
diff --git a/mm/mremap.c b/mm/mremap.c
index 303d3290b938..d5ea5ce8a22a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -167,7 +167,9 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	 * We don't have to worry about the ordering of src and dst
 	 * pte locks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_pte = pte_offset_map_lock(mm, old_pmd, old_addr, &old_ptl);
+	old_pte = pte_tryget_map_lock(mm, old_pmd, old_addr, &old_ptl);
+	if (!old_pte)
+		goto drop_lock;
 	new_pte = pte_offset_map(new_pmd, new_addr);
 	new_ptl = pte_lockptr(mm, new_pmd);
 	if (new_ptl != old_ptl)
@@ -206,6 +208,7 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		spin_unlock(new_ptl);
 	pte_unmap(new_pte - 1);
 	pte_unmap_unlock(old_pte - 1, old_ptl);
+drop_lock:
 	if (need_rmap_locks)
 		drop_rmap_locks(vma);
 }
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..264b717e24ef 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -50,7 +50,9 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		err = walk_pte_range_inner(pte, addr, end, walk);
 		pte_unmap(pte);
 	} else {
-		pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+		pte = pte_tryget_map_lock(walk->mm, pmd, addr, &ptl);
+		if (!pte)
+			return end;
 		err = walk_pte_range_inner(pte, addr, end, walk);
 		pte_unmap_unlock(pte, ptl);
 	}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 63c61f8b2611..710fbeec9e58 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1790,10 +1790,14 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	if (unlikely(!page))
 		return -ENOMEM;
 
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	pte = pte_tryget_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!pte) {
+		ret = -EAGAIN;
+		goto out;
+	}
 	if (unlikely(!pte_same_as_swp(*pte, swp_entry_to_pte(entry)))) {
 		ret = 0;
-		goto out;
+		goto unlock;
 	}
 
 	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
@@ -1808,8 +1812,9 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	set_pte_at(vma->vm_mm, addr, pte,
 		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	swap_free(entry);
-out:
+unlock:
 	pte_unmap_unlock(pte, ptl);
+out:
 	if (page != swapcache) {
 		unlock_page(page);
 		put_page(page);
@@ -1897,7 +1902,7 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 			continue;
 		ret = unuse_pte_range(vma, pmd, addr, next, type);
-		if (ret)
+		if (ret && ret != -EAGAIN)
 			return ret;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0cb8e5ef1713..c1bce9cf5657 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -79,7 +79,9 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 			_dst_pte = pte_mkwrite(_dst_pte);
 	}
 
-	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+	dst_pte = pte_tryget_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+	if (!dst_pte)
+		return -EAGAIN;
 
 	if (vma_is_shmem(dst_vma)) {
 		/* serialize against truncate with the page table lock */
@@ -194,7 +196,9 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
 
 	_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
 					 dst_vma->vm_page_prot));
-	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+	dst_pte = pte_tryget_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+	if (!dst_pte)
+		return -EAGAIN;
 	if (dst_vma->vm_file) {
 		/* the shmem MAP_PRIVATE case requires checking the i_size */
 		inode = dst_vma->vm_file->f_inode;
@@ -587,6 +591,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 			break;
 		}
 
+again:
 		dst_pmdval = pmd_read_atomic(dst_pmd);
 		/*
 		 * If the dst_pmd is mapped as THP don't
@@ -612,6 +617,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 
 		err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
 				       src_addr, &page, mcopy_mode, wp_copy);
+		if (err == -EAGAIN)
+			goto again;
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
-- 
2.20.1

