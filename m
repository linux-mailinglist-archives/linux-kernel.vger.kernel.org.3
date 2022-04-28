Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F125C512EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbiD1Ime (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344173AbiD1Ilm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32B1834B84
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651134987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MiOpeCRL50AAHFNs2EndESfLl5IGZTVbwQnjvbkI4+8=;
        b=Glgs56k9f25RFQ2qgSYSEdvPE4iCH7nwyuCqUVbP8ZHj0F3OC7guoAkIJhS6wvfk730h+M
        iV8HlnsBD4pGH8dC8cQB7pNmhlNn352DiQ90fTCpBqq7HpPpCgXL4cY9TcxxXO4ao4firV
        xRB/5hvIgiHa9ubKCsJSJ/ed6Tr/pjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-1IdBNXFeNp-YzbuYciLLRA-1; Thu, 28 Apr 2022 04:36:21 -0400
X-MC-Unique: 1IdBNXFeNp-YzbuYciLLRA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42648196EF81;
        Thu, 28 Apr 2022 08:36:19 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7B5B566A34;
        Thu, 28 Apr 2022 08:36:12 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 15/17] mm: support GUP-triggered unsharing of anonymous pages
Date:   Thu, 28 Apr 2022 10:34:39 +0200
Message-Id: <20220428083441.37290-16-david@redhat.com>
In-Reply-To: <20220428083441.37290-1-david@redhat.com>
References: <20220428083441.37290-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever GUP currently ends up taking a R/O pin on an anonymous page that
might be shared -- mapped R/O and !PageAnonExclusive() -- any write fault
on the page table entry will end up replacing the mapped anonymous page
due to COW, resulting in the GUP pin no longer being consistent with the
page actually mapped into the page table.

The possible ways to deal with this situation are:
 (1) Ignore and pin -- what we do right now.
 (2) Fail to pin -- which would be rather surprising to callers and
     could break user space.
 (3) Trigger unsharing and pin the now exclusive page -- reliable R/O
     pins.

We want to implement 3) because it provides the clearest semantics and
allows for checking in unpin_user_pages() and friends for possible BUGs:
when trying to unpin a page that's no longer exclusive, clearly
something went very wrong and might result in memory corruptions that
might be hard to debug. So we better have a nice way to spot such
issues.

To implement 3), we need a way for GUP to trigger unsharing:
FAULT_FLAG_UNSHARE. FAULT_FLAG_UNSHARE is only applicable to R/O mapped
anonymous pages and resembles COW logic during a write fault. However, in
contrast to a write fault, GUP-triggered unsharing will, for example, still
maintain the write protection.

Let's implement FAULT_FLAG_UNSHARE by hooking into the existing write fault
handlers for all applicable anonymous page types: ordinary pages, THP and
hugetlb.

* If FAULT_FLAG_UNSHARE finds a R/O-mapped anonymous page that has been
  marked exclusive in the meantime by someone else, there is nothing to do.
* If FAULT_FLAG_UNSHARE finds a R/O-mapped anonymous page that's not
  marked exclusive, it will try detecting if the process is the exclusive
  owner. If exclusive, it can be set exclusive similar to reuse logic
  during write faults via page_move_anon_rmap() and there is nothing
  else to do; otherwise, we either have to copy and map a fresh,
  anonymous exclusive page R/O (ordinary pages, hugetlb), or split the
  THP.

This commit is heavily based on patches by Andrea.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Co-developed-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h |   8 +++
 mm/huge_memory.c         |  10 +++-
 mm/hugetlb.c             |  56 ++++++++++++--------
 mm/memory.c              | 107 +++++++++++++++++++++++++++------------
 4 files changed, 126 insertions(+), 55 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8834e38c06a4..02019bc8f30e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -812,6 +812,9 @@ typedef struct {
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_UNSHARE: The fault is an unsharing request to unshare (and mark
+ *                      exclusive) a possibly shared anonymous page that is
+ *                      mapped R/O.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -831,6 +834,10 @@ typedef struct {
  * continuous faults with flags (b).  We should always try to detect pending
  * signals before a retry to make sure the continuous page faults can still be
  * interrupted if necessary.
+ *
+ * The combination FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE is illegal.
+ * FAULT_FLAG_UNSHARE is ignored and treated like an ordinary read fault when
+ * no existing R/O-mapped anonymous page is encountered.
  */
 enum fault_flag {
 	FAULT_FLAG_WRITE =		1 << 0,
@@ -843,6 +850,7 @@ enum fault_flag {
 	FAULT_FLAG_REMOTE =		1 << 7,
 	FAULT_FLAG_INSTRUCTION =	1 << 8,
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
+	FAULT_FLAG_UNSHARE =		1 << 10,
 };
 
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 14d7fa6dc793..17ec6c939e7f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1271,6 +1271,7 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
 
 vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 {
+	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
@@ -1279,6 +1280,9 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
 
+	VM_BUG_ON(unshare && (vmf->flags & FAULT_FLAG_WRITE));
+	VM_BUG_ON(!unshare && !(vmf->flags & FAULT_FLAG_WRITE));
+
 	if (is_huge_zero_pmd(orig_pmd))
 		goto fallback;
 
@@ -1317,7 +1321,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	}
 
 	/*
-	 * See do_wp_page(): we can only map the page writable if there are
+	 * See do_wp_page(): we can only reuse the page exclusively if there are
 	 * no additional references. Note that we always drain the LRU
 	 * pagevecs immediately after adding a THP.
 	 */
@@ -1331,6 +1335,10 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 		page_move_anon_rmap(page, vma);
 		unlock_page(page);
 reuse:
+		if (unlikely(unshare)) {
+			spin_unlock(vmf->ptl);
+			return 0;
+		}
 		entry = pmd_mkyoung(orig_pmd);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e4143eee7a3a..b8898c38f2ce 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5144,15 +5144,16 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 /*
- * Hugetlb_cow() should be called with page lock of the original hugepage held.
+ * hugetlb_wp() should be called with page lock of the original hugepage held.
  * Called with hugetlb_fault_mutex_table held and pte_page locked so we
  * cannot race with other handlers or page migration.
  * Keep the pte_same checks anyway to make transition from the mutex easier.
  */
-static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
-		       unsigned long address, pte_t *ptep,
+static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
+		       unsigned long address, pte_t *ptep, unsigned int flags,
 		       struct page *pagecache_page, spinlock_t *ptl)
 {
+	const bool unshare = flags & FAULT_FLAG_UNSHARE;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
 	struct page *old_page, *new_page;
@@ -5161,15 +5162,22 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	unsigned long haddr = address & huge_page_mask(h);
 	struct mmu_notifier_range range;
 
+	VM_BUG_ON(unshare && (flags & FOLL_WRITE));
+	VM_BUG_ON(!unshare && !(flags & FOLL_WRITE));
+
 	pte = huge_ptep_get(ptep);
 	old_page = pte_page(pte);
 
 retry_avoidcopy:
-	/* If no-one else is actually using this page, avoid the copy
-	 * and just make the page writable */
+	/*
+	 * If no-one else is actually using this page, we're the exclusive
+	 * owner and can reuse this page.
+	 */
 	if (page_mapcount(old_page) == 1 && PageAnon(old_page)) {
-		page_move_anon_rmap(old_page, vma);
-		set_huge_ptep_writable(vma, haddr, ptep);
+		if (!PageAnonExclusive(old_page))
+			page_move_anon_rmap(old_page, vma);
+		if (likely(!unshare))
+			set_huge_ptep_writable(vma, haddr, ptep);
 		return 0;
 	}
 	VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page),
@@ -5272,13 +5280,13 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
 		ClearHPageRestoreReserve(new_page);
 
-		/* Break COW */
+		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
 		mmu_notifier_invalidate_range(mm, range.start, range.end);
 		page_remove_rmap(old_page, vma, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
 		set_huge_pte_at(mm, haddr, ptep,
-				make_huge_pte(vma, new_page, 1));
+				make_huge_pte(vma, new_page, !unshare));
 		SetHPageMigratable(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
@@ -5286,7 +5294,10 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_unlock(ptl);
 	mmu_notifier_invalidate_range_end(&range);
 out_release_all:
-	/* No restore in case of successful pagetable update (Break COW) */
+	/*
+	 * No restore in case of successful pagetable update (Break COW or
+	 * unshare)
+	 */
 	if (new_page != old_page)
 		restore_reserve_on_error(h, vma, haddr, new_page);
 	put_page(new_page);
@@ -5411,7 +5422,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	/*
 	 * Currently, we are forced to kill the process in the event the
 	 * original mapper has unmapped pages from the child due to a failed
-	 * COW. Warn that such a situation has occurred as it may not be obvious
+	 * COW/unsharing. Warn that such a situation has occurred as it may not
+	 * be obvious.
 	 */
 	if (is_vma_resv_set(vma, HPAGE_RESV_UNMAPPED)) {
 		pr_warn_ratelimited("PID %d killed due to inadequate hugepage pool\n",
@@ -5537,7 +5549,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_cow(mm, vma, address, ptep, page, ptl);
+		ret = hugetlb_wp(mm, vma, address, ptep, flags, page, ptl);
 	}
 
 	spin_unlock(ptl);
@@ -5667,14 +5679,15 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_mutex;
 
 	/*
-	 * If we are going to COW the mapping later, we examine the pending
-	 * reservations for this page now. This will ensure that any
+	 * If we are going to COW/unshare the mapping later, we examine the
+	 * pending reservations for this page now. This will ensure that any
 	 * allocations necessary to record that reservation occur outside the
 	 * spinlock. For private mappings, we also lookup the pagecache
 	 * page now as it is used to determine if a reservation has been
 	 * consumed.
 	 */
-	if ((flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
+	if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
+	    !huge_pte_write(entry)) {
 		if (vma_needs_reservation(h, vma, haddr) < 0) {
 			ret = VM_FAULT_OOM;
 			goto out_mutex;
@@ -5689,12 +5702,12 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 
-	/* Check for a racing update before calling hugetlb_cow */
+	/* Check for a racing update before calling hugetlb_wp() */
 	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
 		goto out_ptl;
 
 	/*
-	 * hugetlb_cow() requires page locks of pte_page(entry) and
+	 * hugetlb_wp() requires page locks of pte_page(entry) and
 	 * pagecache_page, so here we need take the former one
 	 * when page != pagecache_page or !pagecache_page.
 	 */
@@ -5707,13 +5720,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	get_page(page);
 
-	if (flags & FAULT_FLAG_WRITE) {
+	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(entry)) {
-			ret = hugetlb_cow(mm, vma, address, ptep,
-					  pagecache_page, ptl);
+			ret = hugetlb_wp(mm, vma, address, ptep, flags,
+					 pagecache_page, ptl);
 			goto out_put_page;
+		} else if (likely(flags & FAULT_FLAG_WRITE)) {
+			entry = huge_pte_mkdirty(entry);
 		}
-		entry = huge_pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
 	if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
diff --git a/mm/memory.c b/mm/memory.c
index 2c237e7a76ce..1a25d28ee5d9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2745,8 +2745,8 @@ static inline int pte_unmap_same(struct vm_fault *vmf)
 	return same;
 }
 
-static inline bool cow_user_page(struct page *dst, struct page *src,
-				 struct vm_fault *vmf)
+static inline bool __wp_page_copy_user(struct page *dst, struct page *src,
+				       struct vm_fault *vmf)
 {
 	bool ret;
 	void *kaddr;
@@ -2954,6 +2954,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	pte_t entry;
 
+	VM_BUG_ON(!(vmf->flags & FAULT_FLAG_WRITE));
 	VM_BUG_ON(PageAnon(page) && !PageAnonExclusive(page));
 
 	/*
@@ -2974,7 +2975,8 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 }
 
 /*
- * Handle the case of a page which we actually need to copy to a new page.
+ * Handle the case of a page which we actually need to copy to a new page,
+ * either due to COW or unsharing.
  *
  * Called with mmap_lock locked and the old page referenced, but
  * without the ptl held.
@@ -2991,6 +2993,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
  */
 static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 {
+	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	struct vm_area_struct *vma = vmf->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	struct page *old_page = vmf->page;
@@ -3013,7 +3016,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		if (!new_page)
 			goto oom;
 
-		if (!cow_user_page(new_page, old_page, vmf)) {
+		if (!__wp_page_copy_user(new_page, old_page, vmf)) {
 			/*
 			 * COW failed, if the fault was solved by other,
 			 * it's fine. If not, userspace would re-fault on
@@ -3055,7 +3058,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		entry = pte_sw_mkyoung(entry);
-		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		if (unlikely(unshare)) {
+			if (pte_soft_dirty(vmf->orig_pte))
+				entry = pte_mksoft_dirty(entry);
+			if (pte_uffd_wp(vmf->orig_pte))
+				entry = pte_mkuffd_wp(entry);
+		} else {
+			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		}
 
 		/*
 		 * Clear the pte entry and flush it first, before updating the
@@ -3072,6 +3082,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * mmu page tables (such as kvm shadow page tables), we want the
 		 * new page to be mapped directly into the secondary page table.
 		 */
+		BUG_ON(unshare && pte_write(entry));
 		set_pte_at_notify(mm, vmf->address, vmf->pte, entry);
 		update_mmu_cache(vma, vmf->address, vmf->pte);
 		if (old_page) {
@@ -3121,7 +3132,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			free_swap_cache(old_page);
 		put_page(old_page);
 	}
-	return page_copied ? VM_FAULT_WRITE : 0;
+	return (page_copied && !unshare) ? VM_FAULT_WRITE : 0;
 oom_free_new:
 	put_page(new_page);
 oom:
@@ -3221,18 +3232,22 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 }
 
 /*
- * This routine handles present pages, when users try to write
- * to a shared page. It is done by copying the page to a new address
- * and decrementing the shared-page counter for the old page.
+ * This routine handles present pages, when
+ * * users try to write to a shared page (FAULT_FLAG_WRITE)
+ * * GUP wants to take a R/O pin on a possibly shared anonymous page
+ *   (FAULT_FLAG_UNSHARE)
+ *
+ * It is done by copying the page to a new address and decrementing the
+ * shared-page counter for the old page.
  *
  * Note that this routine assumes that the protection checks have been
  * done by the caller (the low-level page fault routine in most cases).
- * Thus we can safely just mark it writable once we've done any necessary
- * COW.
+ * Thus, with FAULT_FLAG_WRITE, we can safely just mark it writable once we've
+ * done any necessary COW.
  *
- * We also mark the page dirty at this point even though the page will
- * change only once the write actually happens. This avoids a few races,
- * and potentially makes it more efficient.
+ * In case of FAULT_FLAG_WRITE, we also mark the page dirty at this point even
+ * though the page will change only once the write actually happens. This
+ * avoids a few races, and potentially makes it more efficient.
  *
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), with pte both mapped and locked.
@@ -3241,23 +3256,35 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	__releases(vmf->ptl)
 {
+	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	struct vm_area_struct *vma = vmf->vma;
 
-	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return handle_userfault(vmf, VM_UFFD_WP);
-	}
+	VM_BUG_ON(unshare && (vmf->flags & FAULT_FLAG_WRITE));
+	VM_BUG_ON(!unshare && !(vmf->flags & FAULT_FLAG_WRITE));
 
-	/*
-	 * Userfaultfd write-protect can defer flushes. Ensure the TLB
-	 * is flushed in this case before copying.
-	 */
-	if (unlikely(userfaultfd_wp(vmf->vma) &&
-		     mm_tlb_flush_pending(vmf->vma->vm_mm)))
-		flush_tlb_page(vmf->vma, vmf->address);
+	if (likely(!unshare)) {
+		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
+			pte_unmap_unlock(vmf->pte, vmf->ptl);
+			return handle_userfault(vmf, VM_UFFD_WP);
+		}
+
+		/*
+		 * Userfaultfd write-protect can defer flushes. Ensure the TLB
+		 * is flushed in this case before copying.
+		 */
+		if (unlikely(userfaultfd_wp(vmf->vma) &&
+			     mm_tlb_flush_pending(vmf->vma->vm_mm)))
+			flush_tlb_page(vmf->vma, vmf->address);
+	}
 
 	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
 	if (!vmf->page) {
+		if (unlikely(unshare)) {
+			/* No anonymous page -> nothing to do. */
+			pte_unmap_unlock(vmf->pte, vmf->ptl);
+			return 0;
+		}
+
 		/*
 		 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
 		 * VM_PFNMAP VMA.
@@ -3320,8 +3347,16 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		page_move_anon_rmap(page, vma);
 		unlock_page(page);
 reuse:
+		if (unlikely(unshare)) {
+			pte_unmap_unlock(vmf->pte, vmf->ptl);
+			return 0;
+		}
 		wp_page_reuse(vmf);
 		return VM_FAULT_WRITE;
+	} else if (unshare) {
+		/* No anonymous page -> nothing to do. */
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return 0;
 	} else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
 					(VM_WRITE|VM_SHARED))) {
 		return wp_page_shared(vmf);
@@ -4519,8 +4554,11 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 /* `inline' is required to avoid gcc 4.1.2 build error */
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 {
+	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
+
 	if (vma_is_anonymous(vmf->vma)) {
-		if (userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
+		if (likely(!unshare) &&
+		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
 			return handle_userfault(vmf, VM_UFFD_WP);
 		return do_huge_pmd_wp_page(vmf);
 	}
@@ -4655,10 +4693,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
 		goto unlock;
 	}
-	if (vmf->flags & FAULT_FLAG_WRITE) {
+	if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!pte_write(entry))
 			return do_wp_page(vmf);
-		entry = pte_mkdirty(entry);
+		else if (likely(vmf->flags & FAULT_FLAG_WRITE))
+			entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
 	if (ptep_set_access_flags(vmf->vma, vmf->address, vmf->pte, entry,
@@ -4699,7 +4738,6 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		.pgoff = linear_page_index(vma, address),
 		.gfp_mask = __get_fault_gfp_mask(vma),
 	};
-	unsigned int dirty = flags & FAULT_FLAG_WRITE;
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -4724,9 +4762,11 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		barrier();
 		if (pud_trans_huge(orig_pud) || pud_devmap(orig_pud)) {
 
-			/* NUMA case for anonymous PUDs would go here */
-
-			if (dirty && !pud_write(orig_pud)) {
+			/*
+			 * TODO once we support anonymous PUDs: NUMA case and
+			 * FAULT_FLAG_UNSHARE handling.
+			 */
+			if ((flags & FAULT_FLAG_WRITE) && !pud_write(orig_pud)) {
 				ret = wp_huge_pud(&vmf, orig_pud);
 				if (!(ret & VM_FAULT_FALLBACK))
 					return ret;
@@ -4764,7 +4804,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
 				return do_huge_pmd_numa_page(&vmf);
 
-			if (dirty && !pmd_write(vmf.orig_pmd)) {
+			if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
+			    !pmd_write(vmf.orig_pmd)) {
 				ret = wp_huge_pmd(&vmf);
 				if (!(ret & VM_FAULT_FALLBACK))
 					return ret;
-- 
2.35.1

