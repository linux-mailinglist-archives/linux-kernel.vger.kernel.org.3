Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7094559FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbiFXRjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiFXRhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:48 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8445869FA5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:38 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id j15-20020ab0644f000000b00368bac468ceso1007918uap.17
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eidAN3wZMLr6mteQRN/ZtvQWu3ENTPRsJrFQKIye6Xw=;
        b=ifSq4WGIJ2MCNV5i5c6CLm1k1Z7n2P0GnMgBr+kmdUIdSKCtXRvtwj81oWCo0YoMrQ
         IcDr8n7yQfUrrSxAkN1YXwEqM5IfWAKR1PNsnVeRNVm2rrNwgsnyKXFCZPsKFz18eJJi
         AjC4fr/5aG8LaYEcmLNbETyNpFrp12C+EhOfYQCwYxaqx8OG+RRnBg3h+rYInBsaXiGS
         KRXgjFMiQk5PwqNRHbBuU728wz+WYRDzZh3FNG4M1JnAhfkHDi44T6MgrmY0SGp9Cbs2
         7hO2DcqZyx877IoqKOW+5z0GVcwNVXUbeq0rR28lZa597DKuk/BcTnZ/dqDW4zwXaf5J
         ajig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eidAN3wZMLr6mteQRN/ZtvQWu3ENTPRsJrFQKIye6Xw=;
        b=ESkuC3L3Uyaz2YVYZczuDq5ZkTxXVEMK+AhpzX+W3zUSwfg964vnasycVdliqsLP6o
         YWvvC3AHe5zsKS64ge75Cqra7Zoi+I0OaixNtKJSbauxi1Q7UDrXd1fNTApKF2ZAl4nf
         H6NW7ZcD4rSCy3pM6nEaU5T0O19yLdHOL+bovl7J/Nn40d3MP73IaC/Ss+kKM1rxV+KU
         Ri1jT7Ekl1hbeiyOXPGtSkQM9wQ2Uo0BTtcdZxoK4j4rUkjZNzQcDfAOUysZ3KpqmcXh
         fabRy/IUw4PNSjRz6zqZMCJKi8vrLP+cRLj71/tb7f/QVXW2ZFTVE6Omt4Sj4Gqxx/Rw
         pPeA==
X-Gm-Message-State: AJIora8jIq9+FQu+ZbqzHUCNYUdpRNpD7XLAfxzt3eKxl7zz6c/WrkTU
        FN1kBmLnzxOY2KE/ztwX5yi9PEZidimLMxbY
X-Google-Smtp-Source: AGRyM1vWVTZJ5pVWjn7x2PEWVIBLimy1j0CTpYliO/gy+6d80cSvRPXbRG7kYQht6u2HA8oY0zQFqOyEJ9POXahm
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a67:5c41:0:b0:356:20ab:2f29 with SMTP
 id q62-20020a675c41000000b0035620ab2f29mr1454923vsb.63.1656092257795; Fri, 24
 Jun 2022 10:37:37 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:50 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-21-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 20/26] hugetlb: add support for high-granularity UFFDIO_CONTINUE
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The changes here are very similar to the changes made to
hugetlb_no_page, where we do a high-granularity page table walk and
do accounting slightly differently because we are mapping only a piece
of a page.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/userfaultfd.c        |  3 +++
 include/linux/hugetlb.h |  6 +++--
 mm/hugetlb.c            | 54 +++++++++++++++++++++-----------------
 mm/userfaultfd.c        | 57 +++++++++++++++++++++++++++++++----------
 4 files changed, 82 insertions(+), 38 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e943370107d0..77c1b8a7d0b9 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -245,6 +245,9 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	if (!ptep)
 		goto out;
 
+	if (hugetlb_hgm_enabled(vma))
+		goto out;
+
 	ret = false;
 	pte = huge_ptep_get(ptep);
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ac4ac8fbd901..c207b1ac6195 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -221,13 +221,15 @@ unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
 #ifdef CONFIG_USERFAULTFD
-int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
+int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
+				struct hugetlb_pte *dst_hpte,
 				struct vm_area_struct *dst_vma,
 				unsigned long dst_addr,
 				unsigned long src_addr,
 				enum mcopy_atomic_mode mode,
 				struct page **pagep,
-				bool wp_copy);
+				bool wp_copy,
+				bool new_mapping);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0ec2f231524e..09fa57599233 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5808,6 +5808,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		vma_end_reservation(h, vma, haddr);
 	}
 
+	/* This lock will get pretty expensive at 4K. */
 	ptl = hugetlb_pte_lock(mm, hpte);
 	ret = 0;
 	/* If pte changed from under us, retry */
@@ -6098,24 +6099,26 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
  * modifications for huge pages.
  */
 int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
-			    pte_t *dst_pte,
+			    struct hugetlb_pte *dst_hpte,
 			    struct vm_area_struct *dst_vma,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
 			    enum mcopy_atomic_mode mode,
 			    struct page **pagep,
-			    bool wp_copy)
+			    bool wp_copy,
+			    bool new_mapping)
 {
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct hstate *h = hstate_vma(dst_vma);
 	struct address_space *mapping = dst_vma->vm_file->f_mapping;
+	unsigned long haddr = dst_addr & huge_page_mask(h);
 	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
 	unsigned long size;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	pte_t _dst_pte;
 	spinlock_t *ptl;
 	int ret = -ENOMEM;
-	struct page *page;
+	struct page *page, *subpage;
 	int writable;
 	bool page_in_pagecache = false;
 
@@ -6130,12 +6133,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		 * a non-missing case. Return -EEXIST.
 		 */
 		if (vm_shared &&
-		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
+		    hugetlbfs_pagecache_present(h, dst_vma, haddr)) {
 			ret = -EEXIST;
 			goto out;
 		}
 
-		page = alloc_huge_page(dst_vma, dst_addr, 0);
+		page = alloc_huge_page(dst_vma, haddr, 0);
 		if (IS_ERR(page)) {
 			ret = -ENOMEM;
 			goto out;
@@ -6151,13 +6154,13 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			/* Free the allocated page which may have
 			 * consumed a reservation.
 			 */
-			restore_reserve_on_error(h, dst_vma, dst_addr, page);
+			restore_reserve_on_error(h, dst_vma, haddr, page);
 			put_page(page);
 
 			/* Allocate a temporary page to hold the copied
 			 * contents.
 			 */
-			page = alloc_huge_page_vma(h, dst_vma, dst_addr);
+			page = alloc_huge_page_vma(h, dst_vma, haddr);
 			if (!page) {
 				ret = -ENOMEM;
 				goto out;
@@ -6171,14 +6174,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		}
 	} else {
 		if (vm_shared &&
-		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
+		    hugetlbfs_pagecache_present(h, dst_vma, haddr)) {
 			put_page(*pagep);
 			ret = -EEXIST;
 			*pagep = NULL;
 			goto out;
 		}
 
-		page = alloc_huge_page(dst_vma, dst_addr, 0);
+		page = alloc_huge_page(dst_vma, haddr, 0);
 		if (IS_ERR(page)) {
 			ret = -ENOMEM;
 			*pagep = NULL;
@@ -6216,8 +6219,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		page_in_pagecache = true;
 	}
 
-	ptl = huge_pte_lockptr(huge_page_shift(h), dst_mm, dst_pte);
-	spin_lock(ptl);
+	ptl = hugetlb_pte_lock(dst_mm, dst_hpte);
 
 	/*
 	 * Recheck the i_size after holding PT lock to make sure not
@@ -6239,14 +6241,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	 * registered, we firstly wr-protect a none pte which has no page cache
 	 * page backing it, then access the page.
 	 */
-	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
+	if (!hugetlb_pte_none_mostly(dst_hpte))
 		goto out_release_unlock;
 
-	if (vm_shared) {
-		page_dup_file_rmap(page, true);
-	} else {
-		ClearHPageRestoreReserve(page);
-		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
+	if (new_mapping) {
+		if (vm_shared) {
+			page_dup_file_rmap(page, true);
+		} else {
+			ClearHPageRestoreReserve(page);
+			hugepage_add_new_anon_rmap(page, dst_vma, haddr);
+		}
 	}
 
 	/*
@@ -6258,7 +6262,11 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	else
 		writable = dst_vma->vm_flags & VM_WRITE;
 
-	_dst_pte = make_huge_pte(dst_vma, page, writable);
+	subpage = hugetlb_find_subpage(h, page, dst_addr);
+	if (subpage != page)
+		BUG_ON(!hugetlb_hgm_enabled(dst_vma));
+
+	_dst_pte = make_huge_pte(dst_vma, subpage, writable);
 	/*
 	 * Always mark UFFDIO_COPY page dirty; note that this may not be
 	 * extremely important for hugetlbfs for now since swapping is not
@@ -6271,14 +6279,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (wp_copy)
 		_dst_pte = huge_pte_mkuffd_wp(_dst_pte);
 
-	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	set_huge_pte_at(dst_mm, dst_addr, dst_hpte->ptep, _dst_pte);
 
-	(void)huge_ptep_set_access_flags(dst_vma, dst_addr, dst_pte, _dst_pte,
-					dst_vma->vm_flags & VM_WRITE);
-	hugetlb_count_add(pages_per_huge_page(h), dst_mm);
+	(void)huge_ptep_set_access_flags(dst_vma, dst_addr, dst_hpte->ptep,
+			_dst_pte, dst_vma->vm_flags & VM_WRITE);
+	hugetlb_count_add(hugetlb_pte_size(dst_hpte) / PAGE_SIZE, dst_mm);
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(dst_vma, dst_addr, dst_pte);
+	update_mmu_cache(dst_vma, dst_addr, dst_hpte->ptep);
 
 	spin_unlock(ptl);
 	if (!is_continue)
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4f4892a5f767..ee40d98068bf 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -310,14 +310,16 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 {
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	ssize_t err;
-	pte_t *dst_pte;
 	unsigned long src_addr, dst_addr;
 	long copied;
 	struct page *page;
-	unsigned long vma_hpagesize;
+	unsigned long vma_hpagesize, vma_altpagesize;
 	pgoff_t idx;
 	u32 hash;
 	struct address_space *mapping;
+	bool use_hgm = hugetlb_hgm_enabled(dst_vma) &&
+		mode == MCOPY_ATOMIC_CONTINUE;
+	struct hstate *h = hstate_vma(dst_vma);
 
 	/*
 	 * There is no default zero huge page for all huge page sizes as
@@ -335,12 +337,16 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	copied = 0;
 	page = NULL;
 	vma_hpagesize = vma_kernel_pagesize(dst_vma);
+	if (use_hgm)
+		vma_altpagesize = PAGE_SIZE;
+	else
+		vma_altpagesize = vma_hpagesize;
 
 	/*
 	 * Validate alignment based on huge page size
 	 */
 	err = -EINVAL;
-	if (dst_start & (vma_hpagesize - 1) || len & (vma_hpagesize - 1))
+	if (dst_start & (vma_altpagesize - 1) || len & (vma_altpagesize - 1))
 		goto out_unlock;
 
 retry:
@@ -361,6 +367,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		vm_shared = dst_vma->vm_flags & VM_SHARED;
 	}
 
+	BUG_ON(!vm_shared && use_hgm);
+
 	/*
 	 * If not shared, ensure the dst_vma has a anon_vma.
 	 */
@@ -371,11 +379,13 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	}
 
 	while (src_addr < src_start + len) {
+		struct hugetlb_pte hpte;
+		bool new_mapping;
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
 		 * Serialize via i_mmap_rwsem and hugetlb_fault_mutex.
-		 * i_mmap_rwsem ensures the dst_pte remains valid even
+		 * i_mmap_rwsem ensures the hpte.ptep remains valid even
 		 * in the case of shared pmds.  fault mutex prevents
 		 * races with other faulting threads.
 		 */
@@ -383,27 +393,47 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		i_mmap_lock_read(mapping);
 		idx = linear_page_index(dst_vma, dst_addr);
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
+		/* This lock will get expensive at 4K. */
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
-		err = -ENOMEM;
-		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
-		if (!dst_pte) {
+		err = 0;
+
+		pte_t *ptep = huge_pte_alloc(dst_mm, dst_vma, dst_addr,
+					     vma_hpagesize);
+		if (!ptep)
+			err = -ENOMEM;
+		else {
+			hugetlb_pte_populate(&hpte, ptep,
+					huge_page_shift(h));
+			/*
+			 * If the hstate-level PTE is not none, then a mapping
+			 * was previously established.
+			 * The per-hpage mutex prevents double-counting.
+			 */
+			new_mapping = hugetlb_pte_none(&hpte);
+			if (use_hgm)
+				err = hugetlb_alloc_largest_pte(&hpte, dst_mm, dst_vma,
+								dst_addr,
+								dst_start + len);
+		}
+
+		if (err) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
 		if (mode != MCOPY_ATOMIC_CONTINUE &&
-		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
+		    !hugetlb_pte_none_mostly(&hpte)) {
 			err = -EEXIST;
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
-		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
+		err = hugetlb_mcopy_atomic_pte(dst_mm, &hpte, dst_vma,
 					       dst_addr, src_addr, mode, &page,
-					       wp_copy);
+					       wp_copy, new_mapping);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		i_mmap_unlock_read(mapping);
@@ -413,6 +443,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		if (unlikely(err == -ENOENT)) {
 			mmap_read_unlock(dst_mm);
 			BUG_ON(!page);
+			BUG_ON(hpte.shift != huge_page_shift(h));
 
 			err = copy_huge_page_from_user(page,
 						(const void __user *)src_addr,
@@ -430,9 +461,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 			BUG_ON(page);
 
 		if (!err) {
-			dst_addr += vma_hpagesize;
-			src_addr += vma_hpagesize;
-			copied += vma_hpagesize;
+			dst_addr += hugetlb_pte_size(&hpte);
+			src_addr += hugetlb_pte_size(&hpte);
+			copied += hugetlb_pte_size(&hpte);
 
 			if (fatal_signal_pending(current))
 				err = -EINTR;
-- 
2.37.0.rc0.161.g10f37bed90-goog

