Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47421514AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359861AbiD2NlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376282AbiD2Nks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:40:48 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D880CC516
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:27 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id z21so6563451pgj.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRcr9R3ZgGJ3jIPCrJCelPkeBao75RZpxc/JH0Fqwmk=;
        b=On/bg069CRwx7Wor8888fyLbdp/Gc2rCyWaQOJucO5HhZjg4SG7Y7E+0wvaS2KVGCr
         rYVMsY9Pcx4ZkQBTX5xuyYpXhUf4C6OuINok1WrDesCw8g1UcjrCtHFP9Uc4bVMEZxjt
         OIcwN7j795Kjz5t35Z0xUEpDbRAji8lwd5XFDeha1a52CKhYwwVvCiV/cG99uz9myna2
         P7rQ2e+2Kp2FbsCe8MmnE/QTIhVGwjnukQzyLdsopG1ty8vFAwWvsuTtbmFag60JVvpG
         kVfMWnwMlMZZEg4iQa0V1QUkR1j9mj3tvwjXdAGJmtu46/ZcKjb8ktKLMIi02Z/qhfWt
         /19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRcr9R3ZgGJ3jIPCrJCelPkeBao75RZpxc/JH0Fqwmk=;
        b=6elX+4XUgzoRQ4ENx/I6S4pM6uVx16aToao3B7lCdPZoUUnaZtn6ugQGGz8AIvh0oo
         yZ71oyJYZSX4RfK0ZGQP15F3OTaaSC271vYUL8WL0FxjYuFD/tJRP0wf7mXkxru5DUJi
         xzIZvTX95GKvpAddQCZOMmrHuCwFJAAk5Dyjw++PTqHmJjsCnbTccGt4duujgQ7yjZyt
         81+ReWFRHFcodDhhGjXF1oixxtO3FhGX6lu4Aq2tTVRdpCpdkOvjNynPvvA38whUkStV
         tPa6O5ADQ3rw05H0/VxmnnsnYtvNvcTgTLDBRn2zUAXIMcE5E9ZSbC1oK3nOUPFRwRWU
         sNCg==
X-Gm-Message-State: AOAM531PhQlkymXPwww4yT6sSWjSD1KAqLAVfJG4g1TnYJVlvq5+7we7
        vNVH+xDF03XNi3AtdRKiYD7ipcjms/jJGg==
X-Google-Smtp-Source: ABdhPJyRLve9t7CiZZ1B6242P2dY8VW+CeFhX8q+DbR17XJUJmfD+8d8bMjGyknZbnYW2wjWl9d0Kw==
X-Received: by 2002:a05:6a00:140c:b0:4e1:530c:edc0 with SMTP id l12-20020a056a00140c00b004e1530cedc0mr39851295pfu.18.1651239446323;
        Fri, 29 Apr 2022 06:37:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:37:25 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 12/18] mm: convert to use pte_tryget_map()
Date:   Fri, 29 Apr 2022 21:35:46 +0800
Message-Id: <20220429133552.33768-13-zhengqi.arch@bytedance.com>
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

Use pte_tryget_map() to help us to try to get the
refcount of the PTE page table page we want to access,
which can prevents the page from being freed during access.

For unuse_pte_range(), there are multiple locations where
pte_offset_map() is called, and it is inconvenient to handle
error conditions, so we perform pte_tryget() in advance in
unuse_pmd_range().

For the following cases, the PTE page table page is stable:

 - got the refcount of PTE page table page already
 - has no concurrent threads(e.g. the write lock of mmap_lock
			     is acquired)
 - the PTE page table page is not yet visible
 - turn off the local cpu interrupt or hold the rcu lock
   (e.g. GUP fast path)
 - the PTE page table page is kernel PTE page table page

So we still keep using pte_offset_map() and replace pte_unmap()
with __pte_unmap() which doesn't reduce the refcount.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/mm/mem_encrypt_identity.c | 11 ++++++++---
 fs/userfaultfd.c                   | 10 +++++++---
 include/linux/mm.h                 |  2 +-
 include/linux/swapops.h            |  4 ++--
 kernel/events/core.c               |  5 ++++-
 mm/gup.c                           | 16 +++++++++++-----
 mm/hmm.c                           |  9 +++++++--
 mm/huge_memory.c                   |  4 ++--
 mm/khugepaged.c                    |  8 +++++---
 mm/memory-failure.c                | 11 ++++++++---
 mm/memory.c                        | 19 +++++++++++++------
 mm/migrate.c                       |  8 ++++++--
 mm/mremap.c                        |  5 ++++-
 mm/page_table_check.c              |  2 +-
 mm/page_vma_mapped.c               | 13 ++++++++++---
 mm/pagewalk.c                      |  2 +-
 mm/swap_state.c                    |  4 ++--
 mm/swapfile.c                      |  9 ++++++---
 mm/vmalloc.c                       |  2 +-
 19 files changed, 99 insertions(+), 45 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 6d323230320a..37a3f4da7bd2 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -171,26 +171,31 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	pmd_t pmdval;
 
 	pud = sme_prepare_pgd(ppd);
 	if (!pud)
 		return;
 
 	pmd = pmd_offset(pud, ppd->vaddr);
-	if (pmd_none(*pmd)) {
+retry:
+	pmdval = READ_ONCE(*pmd);
+	if (pmd_none(pmdval)) {
 		pte = ppd->pgtable_area;
 		memset(pte, 0, sizeof(*pte) * PTRS_PER_PTE);
 		ppd->pgtable_area += sizeof(*pte) * PTRS_PER_PTE;
 		set_pmd(pmd, __pmd(PMD_FLAGS | __pa(pte)));
 	}
 
-	if (pmd_large(*pmd))
+	if (pmd_large(pmdval))
 		return;
 
 	pte = pte_offset_map(pmd, ppd->vaddr);
+	if (!pte)
+		goto retry;
 	if (pte_none(*pte))
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
-	pte_unmap(pte);
+	__pte_unmap(pte);
 }
 
 static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index aa0c47cb0d16..c83fc73f29c0 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -309,6 +309,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	 * This is to deal with the instability (as in
 	 * pmd_trans_unstable) of the pmd.
 	 */
+retry:
 	_pmd = READ_ONCE(*pmd);
 	if (pmd_none(_pmd))
 		goto out;
@@ -324,10 +325,13 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	}
 
 	/*
-	 * the pmd is stable (as in !pmd_trans_unstable) so we can re-read it
-	 * and use the standard pte_offset_map() instead of parsing _pmd.
+	 * After we tryget successfully, the pmd is stable (as in
+	 * !pmd_trans_unstable) so we can re-read it and use the standard
+	 * pte_offset_map() instead of parsing _pmd.
 	 */
-	pte = pte_offset_map(pmd, address);
+	pte = pte_tryget_map(mm, pmd, address);
+	if (!pte)
+		goto retry;
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
 	 * changes under us.
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 04f7a6c36dc7..cc8fb009bab7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2284,7 +2284,7 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 #define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
 
 #define pte_alloc_map(mm, pmd, address)			\
-	(pte_alloc(mm, pmd) ? NULL : pte_offset_map(pmd, address))
+	(pte_alloc(mm, pmd) ? NULL : pte_tryget_map(mm, pmd, address))
 
 #define pte_alloc_map_lock(mm, pmd, address, ptlp)	\
 	(pte_alloc(mm, pmd) ?			\
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index d356ab4047f7..b671ecd6b5e7 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -214,7 +214,7 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
 
 extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 					spinlock_t *ptl);
-extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
+extern bool migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
 extern void migration_entry_wait_huge(struct vm_area_struct *vma,
 		struct mm_struct *mm, pte_t *pte);
@@ -236,7 +236,7 @@ static inline int is_migration_entry(swp_entry_t swp)
 
 static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 					spinlock_t *ptl) { }
-static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
+static inline bool migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					 unsigned long address) { }
 static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
 		struct mm_struct *mm, pte_t *pte) { }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 23bb19716ad3..443b0af075e6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7215,6 +7215,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pud_leaf_size(pud);
 
 	pmdp = pmd_offset_lockless(pudp, pud, addr);
+retry:
 	pmd = READ_ONCE(*pmdp);
 	if (!pmd_present(pmd))
 		return 0;
@@ -7222,7 +7223,9 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 	if (pmd_leaf(pmd))
 		return pmd_leaf_size(pmd);
 
-	ptep = pte_offset_map(&pmd, addr);
+	ptep = pte_tryget_map(mm, &pmd, addr);
+	if (!ptep)
+		goto retry;
 	pte = ptep_get_lockless(ptep);
 	if (pte_present(pte))
 		size = pte_leaf_size(pte);
diff --git a/mm/gup.c b/mm/gup.c
index d2c24181fb04..114a7e7f871b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -470,7 +470,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		if (!is_migration_entry(entry))
 			goto no_page;
 		pte_unmap_unlock(ptep, ptl);
-		migration_entry_wait(mm, pmd, address);
+		if (!migration_entry_wait(mm, pmd, address))
+			return no_page_table(vma, flags);
 		goto retry;
 	}
 	if ((flags & FOLL_NUMA) && pte_protnone(pte))
@@ -805,6 +806,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 	pmd_t *pmd;
 	pte_t *pte;
 	int ret = -EFAULT;
+	pmd_t pmdval;
 
 	/* user gate pages are read-only */
 	if (gup_flags & FOLL_WRITE)
@@ -822,10 +824,14 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 	if (pud_none(*pud))
 		return -EFAULT;
 	pmd = pmd_offset(pud, address);
-	if (!pmd_present(*pmd))
+retry:
+	pmdval = READ_ONCE(*pmd);
+	if (!pmd_present(pmdval))
 		return -EFAULT;
-	VM_BUG_ON(pmd_trans_huge(*pmd));
-	pte = pte_offset_map(pmd, address);
+	VM_BUG_ON(pmd_trans_huge(pmdval));
+	pte = pte_tryget_map(mm, pmd, address);
+	if (!pte)
+		goto retry;
 	if (pte_none(*pte))
 		goto unmap;
 	*vma = get_gate_vma(mm);
@@ -2223,7 +2229,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 pte_unmap:
 	if (pgmap)
 		put_dev_pagemap(pgmap);
-	pte_unmap(ptem);
+	__pte_unmap(ptem);
 	return ret;
 }
 #else
diff --git a/mm/hmm.c b/mm/hmm.c
index af71aac3140e..0cf45092efca 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -279,7 +279,8 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		if (is_migration_entry(entry)) {
 			pte_unmap(ptep);
 			hmm_vma_walk->last = addr;
-			migration_entry_wait(walk->mm, pmdp, addr);
+			if (!migration_entry_wait(walk->mm, pmdp, addr))
+				return -EAGAIN;
 			return -EBUSY;
 		}
 
@@ -384,12 +385,16 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
 
-	ptep = pte_offset_map(pmdp, addr);
+	ptep = pte_tryget_map(walk->mm, pmdp, addr);
+	if (!ptep)
+		goto again;
 	for (; addr < end; addr += PAGE_SIZE, ptep++, hmm_pfns++) {
 		int r;
 
 		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, hmm_pfns);
 		if (r) {
+			if (r == -EAGAIN)
+				goto again;
 			/* hmm_vma_handle_pte() did pte_unmap() */
 			return r;
 		}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c468fee595ff..73ac2e9c9193 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1932,7 +1932,7 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 		pte = pte_offset_map(&_pmd, haddr);
 		VM_BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, haddr, pte, entry);
-		pte_unmap(pte);
+		__pte_unmap(pte);
 	}
 	smp_wmb(); /* make pte visible before pmd */
 	pmd_populate(mm, pmd, pgtable);
@@ -2086,7 +2086,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		set_pte_at(mm, addr, pte, entry);
 		if (!pmd_migration)
 			atomic_inc(&page[i]._mapcount);
-		pte_unmap(pte);
+		__pte_unmap(pte);
 	}
 
 	if (!pmd_migration) {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 3776cc315294..f540d7983b2d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1003,7 +1003,9 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 			.pmd = pmd,
 		};
 
-		vmf.pte = pte_offset_map(pmd, address);
+		vmf.pte = pte_tryget_map(mm, pmd, address);
+		if (!vmf.pte)
+			return false;
 		vmf.orig_pte = *vmf.pte;
 		if (!is_swap_pte(vmf.orig_pte)) {
 			pte_unmap(vmf.pte);
@@ -1145,7 +1147,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	spin_unlock(pte_ptl);
 
 	if (unlikely(!isolated)) {
-		pte_unmap(pte);
+		__pte_unmap(pte);
 		spin_lock(pmd_ptl);
 		BUG_ON(!pmd_none(*pmd));
 		/*
@@ -1168,7 +1170,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 
 	__collapse_huge_page_copy(pte, new_page, vma, address, pte_ptl,
 			&compound_pagelist);
-	pte_unmap(pte);
+	__pte_unmap(pte);
 	/*
 	 * spin_lock() below is not the equivalent of smp_wmb(), but
 	 * the smp_wmb() inside __SetPageUptodate() can be reused to
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5247932df3fa..2a840ddfc34e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -304,6 +304,7 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	pmd_t pmdval;
 
 	VM_BUG_ON_VMA(address == -EFAULT, vma);
 	pgd = pgd_offset(vma->vm_mm, address);
@@ -318,11 +319,15 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
 	if (pud_devmap(*pud))
 		return PUD_SHIFT;
 	pmd = pmd_offset(pud, address);
-	if (!pmd_present(*pmd))
+retry:
+	pmdval = READ_ONCE(*pmd);
+	if (!pmd_present(pmdval))
 		return 0;
-	if (pmd_devmap(*pmd))
+	if (pmd_devmap(pmdval))
 		return PMD_SHIFT;
-	pte = pte_offset_map(pmd, address);
+	pte = pte_tryget_map(vma->vm_mm, pmd, address);
+	if (!pte)
+		goto retry;
 	if (pte_present(*pte) && pte_devmap(*pte))
 		ret = PAGE_SHIFT;
 	pte_unmap(pte);
diff --git a/mm/memory.c b/mm/memory.c
index ca03006b32cb..aa2bac561d5e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1091,7 +1091,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 
 	arch_leave_lazy_mmu_mode();
 	spin_unlock(src_ptl);
-	pte_unmap(orig_src_pte);
+	__pte_unmap(orig_src_pte);
 	add_mm_rss_vec(dst_mm, rss);
 	pte_unmap_unlock(orig_dst_pte, dst_ptl);
 	cond_resched();
@@ -3566,8 +3566,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
-			migration_entry_wait(vma->vm_mm, vmf->pmd,
-					     vmf->address);
+			if (!migration_entry_wait(vma->vm_mm, vmf->pmd,
+					     vmf->address))
+				ret = VM_FAULT_RETRY;
 		} else if (is_device_exclusive_entry(entry)) {
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
@@ -4507,7 +4508,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		flags |= TNF_MIGRATED;
 	} else {
 		flags |= TNF_MIGRATE_FAIL;
-		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
+		vmf->pte = pte_tryget_map(vma->vm_mm, vmf->pmd, vmf->address);
+		if (!vmf->pte)
+			return VM_FAULT_RETRY;
 		spin_lock(vmf->ptl);
 		if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -4617,7 +4620,8 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
 	pte_t entry;
 
-	if (unlikely(pmd_none(*vmf->pmd))) {
+retry:
+	if (unlikely(pmd_none(READ_ONCE(*vmf->pmd)))) {
 		/*
 		 * Leave __pte_alloc() until later: because vm_ops->fault may
 		 * want to allocate huge page, and if we expose page table
@@ -4646,7 +4650,10 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 * mmap_lock read mode and khugepaged takes it in write mode.
 		 * So now it's safe to run pte_offset_map().
 		 */
-		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
+		vmf->pte = pte_tryget_map(vmf->vma->vm_mm, vmf->pmd,
+					  vmf->address);
+		if (!vmf->pte)
+			goto retry;
 		vmf->orig_pte = *vmf->pte;
 
 		/*
diff --git a/mm/migrate.c b/mm/migrate.c
index 6c31ee1e1c9b..125fbe300df2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -301,12 +301,16 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 	pte_unmap_unlock(ptep, ptl);
 }
 
-void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
+bool migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long address)
 {
 	spinlock_t *ptl = pte_lockptr(mm, pmd);
-	pte_t *ptep = pte_offset_map(pmd, address);
+	pte_t *ptep = pte_tryget_map(mm, pmd, address);
+	if (!ptep)
+		return false;
 	__migration_entry_wait(mm, ptep, ptl);
+
+	return true;
 }
 
 void migration_entry_wait_huge(struct vm_area_struct *vma,
diff --git a/mm/mremap.c b/mm/mremap.c
index d5ea5ce8a22a..71022d42f577 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -170,7 +170,9 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	old_pte = pte_tryget_map_lock(mm, old_pmd, old_addr, &old_ptl);
 	if (!old_pte)
 		goto drop_lock;
-	new_pte = pte_offset_map(new_pmd, new_addr);
+	new_pte = pte_tryget_map(mm, new_pmd, new_addr);
+	if (!new_pte)
+		goto unmap_drop_lock;
 	new_ptl = pte_lockptr(mm, new_pmd);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -207,6 +209,7 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	pte_unmap(new_pte - 1);
+unmap_drop_lock:
 	pte_unmap_unlock(old_pte - 1, old_ptl);
 drop_lock:
 	if (need_rmap_locks)
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 2458281bff89..185e84f22c6c 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -251,7 +251,7 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
 		pte_t *ptep = pte_offset_map(&pmd, addr);
 		unsigned long i;
 
-		pte_unmap(ptep);
+		__pte_unmap(ptep);
 		for (i = 0; i < PTRS_PER_PTE; i++) {
 			__page_table_check_pte_clear(mm, addr, *ptep);
 			addr += PAGE_SIZE;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 14a5cda73dee..8ecf8fd7cf5e 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -15,7 +15,9 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 
 static bool map_pte(struct page_vma_mapped_walk *pvmw)
 {
-	pvmw->pte = pte_offset_map(pvmw->pmd, pvmw->address);
+	pvmw->pte = pte_tryget_map(pvmw->vma->vm_mm, pvmw->pmd, pvmw->address);
+	if (!pvmw->pte)
+		return false;
 	if (!(pvmw->flags & PVMW_SYNC)) {
 		if (pvmw->flags & PVMW_MIGRATION) {
 			if (!is_swap_pte(*pvmw->pte))
@@ -203,6 +205,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		}
 
 		pvmw->pmd = pmd_offset(pud, pvmw->address);
+retry:
 		/*
 		 * Make sure the pmd value isn't cached in a register by the
 		 * compiler and used as a stale value after we've observed a
@@ -251,8 +254,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
-		if (!map_pte(pvmw))
-			goto next_pte;
+		if (!map_pte(pvmw)) {
+			if (!pvmw->pte)
+				goto retry;
+			else
+				goto next_pte;
+		}
 this_pte:
 		if (check_pte(pvmw))
 			return true;
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 264b717e24ef..adb5dacbd537 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -48,7 +48,7 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	if (walk->no_vma) {
 		pte = pte_offset_map(pmd, addr);
 		err = walk_pte_range_inner(pte, addr, end, walk);
-		pte_unmap(pte);
+		__pte_unmap(pte);
 	} else {
 		pte = pte_tryget_map_lock(walk->mm, pmd, addr, &ptl);
 		if (!pte)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 013856004825..5b70c2c815ef 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -743,7 +743,7 @@ static void swap_ra_info(struct vm_fault *vmf,
 			SWAP_RA_VAL(faddr, win, 0));
 
 	if (win == 1) {
-		pte_unmap(orig_pte);
+		__pte_unmap(orig_pte);
 		return;
 	}
 
@@ -768,7 +768,7 @@ static void swap_ra_info(struct vm_fault *vmf,
 	for (pfn = start; pfn != end; pfn++)
 		*tpte++ = *pte++;
 #endif
-	pte_unmap(orig_pte);
+	__pte_unmap(orig_pte);
 }
 
 /**
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 710fbeec9e58..f1c64fc15e24 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1845,7 +1845,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			continue;
 
 		offset = swp_offset(entry);
-		pte_unmap(pte);
+		__pte_unmap(pte);
 		swap_map = &si->swap_map[offset];
 		page = lookup_swap_cache(entry, vma, addr);
 		if (!page) {
@@ -1880,7 +1880,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 try_next:
 		pte = pte_offset_map(pmd, addr);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
-	pte_unmap(pte - 1);
+	__pte_unmap(pte - 1);
 
 	ret = 0;
 out:
@@ -1901,8 +1901,11 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 			continue;
+		if (!pte_tryget(vma->vm_mm, pmd, addr))
+			continue;
 		ret = unuse_pte_range(vma, pmd, addr, next, type);
-		if (ret && ret != -EAGAIN)
+		__pte_put(pmd_pgtable(*pmd));
+		if (ret)
 			return ret;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e163372d3967..080aa78bdaff 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -694,7 +694,7 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 	pte = *ptep;
 	if (pte_present(pte))
 		page = pte_page(pte);
-	pte_unmap(ptep);
+	__pte_unmap(ptep);
 
 	return page;
 }
-- 
2.20.1

