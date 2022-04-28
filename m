Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55166512EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344089AbiD1Imr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiD1Iln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3232D34B99
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651134988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSiRaw/QfRytOKTnTzvY9sqF5YM85yMEE/UtjWA5SFw=;
        b=SF0Xx6pj+VgoOtVozfYhnb3EXe/fBvTjEOHmHSNnp9rh0EEZap+DDazwdRotsXGb56lVsL
        kPyY6TFIJ+X8WXzz152N2GbjaUakaYBxWT1NsC5e9J0Db4J5JOea6+76wm92U6jCBqOyld
        DaTlc1WYu+CeGBmdd8d7t0Iwv09XRIU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-clFzKb41ONC_EFnaw2g4ZA-1; Thu, 28 Apr 2022 04:36:26 -0400
X-MC-Unique: clFzKb41ONC_EFnaw2g4ZA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AFFC296A606;
        Thu, 28 Apr 2022 08:36:25 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D56B566A40;
        Thu, 28 Apr 2022 08:36:19 +0000 (UTC)
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
Subject: [PATCH v4 16/17] mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared anonymous page
Date:   Thu, 28 Apr 2022 10:34:40 +0200
Message-Id: <20220428083441.37290-17-david@redhat.com>
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

Let's implement 3) because it provides the clearest semantics and
allows for checking in unpin_user_pages() and friends for possible BUGs:
when trying to unpin a page that's no longer exclusive, clearly
something went very wrong and might result in memory corruptions that
might be hard to debug. So we better have a nice way to spot such
issues.

This change implies that whenever user space *wrote* to a private
mapping (IOW, we have an anonymous page mapped), that GUP pins will
always remain consistent: reliable R/O GUP pins of anonymous pages.

As a side note, this commit fixes the COW security issue for hugetlb with
FOLL_PIN as documented in:
  https://lore.kernel.org/r/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com
The vmsplice reproducer still applies, because vmsplice uses FOLL_GET
instead of FOLL_PIN.

Note that follow_huge_pmd() doesn't apply because we cannot end up in
there with FOLL_PIN.

This commit is heavily based on prototype patches by Andrea.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Co-developed-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 39 +++++++++++++++++++++++++++++++++++++++
 mm/gup.c           | 42 +++++++++++++++++++++++++++++++++++++++---
 mm/huge_memory.c   |  3 +++
 mm/hugetlb.c       | 27 ++++++++++++++++++++++++---
 4 files changed, 105 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c7b82d078969..4f5fb75aa221 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3005,6 +3005,45 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
 	return 0;
 }
 
+/*
+ * Indicates for which pages that are write-protected in the page table,
+ * whether GUP has to trigger unsharing via FAULT_FLAG_UNSHARE such that the
+ * GUP pin will remain consistent with the pages mapped into the page tables
+ * of the MM.
+ *
+ * Temporary unmapping of PageAnonExclusive() pages or clearing of
+ * PageAnonExclusive() has to protect against concurrent GUP:
+ * * Ordinary GUP: Using the PT lock
+ * * GUP-fast and fork(): mm->write_protect_seq
+ * * GUP-fast and KSM or temporary unmapping (swap, migration):
+ *   clear/invalidate+flush of the page table entry
+ *
+ * Must be called with the (sub)page that's actually referenced via the
+ * page table entry, which might not necessarily be the head page for a
+ * PTE-mapped THP.
+ */
+static inline bool gup_must_unshare(unsigned int flags, struct page *page)
+{
+	/*
+	 * FOLL_WRITE is implicitly handled correctly as the page table entry
+	 * has to be writable -- and if it references (part of) an anonymous
+	 * folio, that part is required to be marked exclusive.
+	 */
+	if ((flags & (FOLL_WRITE | FOLL_PIN)) != FOLL_PIN)
+		return false;
+	/*
+	 * Note: PageAnon(page) is stable until the page is actually getting
+	 * freed.
+	 */
+	if (!PageAnon(page))
+		return false;
+	/*
+	 * Note that PageKsm() pages cannot be exclusive, and consequently,
+	 * cannot get pinned.
+	 */
+	return !PageAnonExclusive(page);
+}
+
 typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
 extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
 			       unsigned long size, pte_fn_t fn, void *data);
diff --git a/mm/gup.c b/mm/gup.c
index f424abf5e792..4d089d467e58 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -506,6 +506,10 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		}
 	}
 
+	if (!pte_write(pte) && gup_must_unshare(flags, page)) {
+		page = ERR_PTR(-EMLINK);
+		goto out;
+	}
 	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
 	if (unlikely(!try_grab_page(page, flags))) {
 		page = ERR_PTR(-ENOMEM);
@@ -732,6 +736,11 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
  * When getting pages from ZONE_DEVICE memory, the @ctx->pgmap caches
  * the device's dev_pagemap metadata to avoid repeating expensive lookups.
  *
+ * When getting an anonymous page and the caller has to trigger unsharing
+ * of a shared anonymous page first, -EMLINK is returned. The caller should
+ * trigger a fault with FAULT_FLAG_UNSHARE set. Note that unsharing is only
+ * relevant with FOLL_PIN and !FOLL_WRITE.
+ *
  * On output, the @ctx->page_mask is set according to the size of the page.
  *
  * Return: the mapped (struct page *), %NULL if no mapping exists, or
@@ -855,7 +864,8 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
  * is, *@locked will be set to 0 and -EBUSY returned.
  */
 static int faultin_page(struct vm_area_struct *vma,
-		unsigned long address, unsigned int *flags, int *locked)
+		unsigned long address, unsigned int *flags, bool unshare,
+		int *locked)
 {
 	unsigned int fault_flags = 0;
 	vm_fault_t ret;
@@ -877,6 +887,11 @@ static int faultin_page(struct vm_area_struct *vma,
 		 */
 		fault_flags |= FAULT_FLAG_TRIED;
 	}
+	if (unshare) {
+		fault_flags |= FAULT_FLAG_UNSHARE;
+		/* FAULT_FLAG_WRITE and FAULT_FLAG_UNSHARE are incompatible */
+		VM_BUG_ON(fault_flags & FAULT_FLAG_WRITE);
+	}
 
 	ret = handle_mm_fault(vma, address, fault_flags, NULL);
 	if (ret & VM_FAULT_ERROR) {
@@ -1098,8 +1113,9 @@ static long __get_user_pages(struct mm_struct *mm,
 		cond_resched();
 
 		page = follow_page_mask(vma, start, foll_flags, &ctx);
-		if (!page) {
-			ret = faultin_page(vma, start, &foll_flags, locked);
+		if (!page || PTR_ERR(page) == -EMLINK) {
+			ret = faultin_page(vma, start, &foll_flags,
+					   PTR_ERR(page) == -EMLINK, locked);
 			switch (ret) {
 			case 0:
 				goto retry;
@@ -2201,6 +2217,11 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			goto pte_unmap;
 		}
 
+		if (!pte_write(pte) && gup_must_unshare(flags, page)) {
+			gup_put_folio(folio, 1, flags);
+			goto pte_unmap;
+		}
+
 		/*
 		 * We need to make the page accessible if and only if we are
 		 * going to access its content (the FOLL_PIN case).  Please
@@ -2381,6 +2402,11 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		return 0;
 	}
 
+	if (!pte_write(pte) && gup_must_unshare(flags, &folio->page)) {
+		gup_put_folio(folio, refs, flags);
+		return 0;
+	}
+
 	*nr += refs;
 	folio_set_referenced(folio);
 	return 1;
@@ -2442,6 +2468,11 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		return 0;
 	}
 
+	if (!pmd_write(orig) && gup_must_unshare(flags, &folio->page)) {
+		gup_put_folio(folio, refs, flags);
+		return 0;
+	}
+
 	*nr += refs;
 	folio_set_referenced(folio);
 	return 1;
@@ -2477,6 +2508,11 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 		return 0;
 	}
 
+	if (!pud_write(orig) && gup_must_unshare(flags, &folio->page)) {
+		gup_put_folio(folio, refs, flags);
+		return 0;
+	}
+
 	*nr += refs;
 	folio_set_referenced(folio);
 	return 1;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 17ec6c939e7f..4414111998df 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1389,6 +1389,9 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	page = pmd_page(*pmd);
 	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
 
+	if (!pmd_write(*pmd) && gup_must_unshare(flags, page))
+		return ERR_PTR(-EMLINK);
+
 	if (!try_grab_page(page, flags))
 		return ERR_PTR(-ENOMEM);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b8898c38f2ce..bbf0ce8cd33d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5964,6 +5964,25 @@ static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 	}
 }
 
+static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
+					       bool *unshare)
+{
+	pte_t pteval = huge_ptep_get(pte);
+
+	*unshare = false;
+	if (is_swap_pte(pteval))
+		return true;
+	if (huge_pte_write(pteval))
+		return false;
+	if (flags & FOLL_WRITE)
+		return true;
+	if (gup_must_unshare(flags, pte_page(pteval))) {
+		*unshare = true;
+		return true;
+	}
+	return false;
+}
+
 long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page **pages, struct vm_area_struct **vmas,
 			 unsigned long *position, unsigned long *nr_pages,
@@ -5978,6 +5997,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	while (vaddr < vma->vm_end && remainder) {
 		pte_t *pte;
 		spinlock_t *ptl = NULL;
+		bool unshare = false;
 		int absent;
 		struct page *page;
 
@@ -6028,9 +6048,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * both cases, and because we can't follow correct pages
 		 * directly from any kind of swap entries.
 		 */
-		if (absent || is_swap_pte(huge_ptep_get(pte)) ||
-		    ((flags & FOLL_WRITE) &&
-		      !huge_pte_write(huge_ptep_get(pte)))) {
+		if (absent ||
+		    __follow_hugetlb_must_fault(flags, pte, &unshare)) {
 			vm_fault_t ret;
 			unsigned int fault_flags = 0;
 
@@ -6038,6 +6057,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				spin_unlock(ptl);
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
+			else if (unshare)
+				fault_flags |= FAULT_FLAG_UNSHARE;
 			if (locked)
 				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
 					FAULT_FLAG_KILLABLE;
-- 
2.35.1

