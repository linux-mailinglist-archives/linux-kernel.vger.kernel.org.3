Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32114D99AD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347509AbiCOKyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347648AbiCOKwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC37A546BB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647341417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OWzs4sG0SiWNWykUUbbAklNtfZXxlzccnLSNQoWeiBw=;
        b=hK7l3xZ/0SymenKt0lEn9d2SvOK/RTujjWudsCvpJOdYsjGIKXdhGkIMeDiyDefDhO0ICk
        MYfNDgPNt19NhnLXSAJx75X981VrgShdbIPlI4WuXHSl4iSD63BHw8d57icICMyc3zUsHb
        VBnqX6LNDS6Jcgo4sQxq83imfhI/g80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-0Tr2zwswOo2hwej3m6OKQg-1; Tue, 15 Mar 2022 06:50:14 -0400
X-MC-Unique: 0Tr2zwswOo2hwej3m6OKQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42E33108C1C4;
        Tue, 15 Mar 2022 10:50:13 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37B179E94;
        Tue, 15 Mar 2022 10:49:43 +0000 (UTC)
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
Subject: [PATCH v2 04/15] mm/rmap: split page_dup_rmap() into page_dup_file_rmap() and page_try_dup_anon_rmap()
Date:   Tue, 15 Mar 2022 11:47:30 +0100
Message-Id: <20220315104741.63071-5-david@redhat.com>
In-Reply-To: <20220315104741.63071-1-david@redhat.com>
References: <20220315104741.63071-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... and move the special check for pinned pages into
page_try_dup_anon_rmap() to prepare for tracking exclusive anonymous
pages via a new pageflag, clearing it only after making sure that there
are no GUP pins on the anonymous page.

We really only care about pins on anonymous pages, because they are
prone to getting replaced in the COW handler once mapped R/O. For !anon
pages in cow-mappings (!VM_SHARED && VM_MAYWRITE) we shouldn't really
care about that, at least not that I could come up with an example.

Let's drop the is_cow_mapping() check from page_needs_cow_for_dma(), as we
know we're dealing with anonymous pages. Also, drop the handling of
pinned pages from copy_huge_pud() and add a comment if ever supporting
anonymous pages on the PUD level.

This is a preparation for tracking exclusivity of anonymous pages in
the rmap code, and disallowing marking a page shared (-> failing to
duplicate) if there are GUP pins on a page.

RFC notes: if I'm missing something important for !anon pages, we could
           similarly handle it via page_try_dup_file_rmap().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h   |  5 +----
 include/linux/rmap.h | 48 +++++++++++++++++++++++++++++++++++++++++++-
 mm/huge_memory.c     | 27 ++++++++-----------------
 mm/hugetlb.c         | 16 ++++++++-------
 mm/memory.c          | 17 +++++++++++-----
 mm/migrate.c         |  2 +-
 6 files changed, 78 insertions(+), 37 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 391b950e919d..63ee06001189 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1322,16 +1322,13 @@ static inline bool is_cow_mapping(vm_flags_t flags)
 
 /*
  * This should most likely only be called during fork() to see whether we
- * should break the cow immediately for a page on the src mm.
+ * should break the cow immediately for an anon page on the src mm.
  *
  * The caller has to hold the PT lock and the vma->vm_mm->->write_protect_seq.
  */
 static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 					  struct page *page)
 {
-	if (!is_cow_mapping(vma->vm_flags))
-		return false;
-
 	VM_BUG_ON(!(raw_read_seqcount(&vma->vm_mm->write_protect_seq) & 1));
 
 	if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e704b1a4c06c..92c3585b8c6a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -180,11 +180,57 @@ void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
 void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 				unsigned long);
 
-static inline void page_dup_rmap(struct page *page, bool compound)
+static inline void __page_dup_rmap(struct page *page, bool compound)
 {
 	atomic_inc(compound ? compound_mapcount_ptr(page) : &page->_mapcount);
 }
 
+static inline void page_dup_file_rmap(struct page *page, bool compound)
+{
+	__page_dup_rmap(page, compound);
+}
+
+/**
+ * page_try_dup_anon_rmap - try duplicating a mapping of an already mapped
+ *			    anonymous page
+ * @page: the page to duplicate the mapping for
+ * @compound: the page is mapped as compound or as a small page
+ * @vma: the source vma
+ *
+ * The caller needs to hold the PT lock and the vma->vma_mm->write_protect_seq.
+ *
+ * Duplicating the mapping can only fail if the page may be pinned; device
+ * private pages cannot get pinned and consequently this function cannot fail.
+ *
+ * If duplicating the mapping succeeds, the page has to be mapped R/O into
+ * the parent and the child. It must *not* get mapped writable after this call.
+ *
+ * Returns 0 if duplicating the mapping succeeded. Returns -EBUSY otherwise.
+ */
+static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
+					 struct vm_area_struct *vma)
+{
+	VM_BUG_ON_PAGE(!PageAnon(page), page);
+
+	/*
+	 * If this page may have been pinned by the parent process,
+	 * don't allow to duplicate the mapping but instead require to e.g.,
+	 * copy the page immediately for the child so that we'll always
+	 * guarantee the pinned page won't be randomly replaced in the
+	 * future on write faults.
+	 */
+	if (likely(!is_device_private_page(page) &&
+	    unlikely(page_needs_cow_for_dma(vma, page))))
+		return -EBUSY;
+
+	/*
+	 * It's okay to share the anon page between both processes, mapping
+	 * the page R/O into both processes.
+	 */
+	__page_dup_rmap(page, compound);
+	return 0;
+}
+
 /*
  * Called from mm/vmscan.c to handle paging out
  */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cda88d8ac1bd..c126d728b8de 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1097,23 +1097,16 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	src_page = pmd_page(pmd);
 	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
 
-	/*
-	 * If this page is a potentially pinned page, split and retry the fault
-	 * with smaller page size.  Normally this should not happen because the
-	 * userspace should use MADV_DONTFORK upon pinned regions.  This is a
-	 * best effort that the pinned pages won't be replaced by another
-	 * random page during the coming copy-on-write.
-	 */
-	if (unlikely(page_needs_cow_for_dma(src_vma, src_page))) {
+	get_page(src_page);
+	if (unlikely(page_try_dup_anon_rmap(src_page, true, src_vma))) {
+		/* Page maybe pinned: split and retry the fault on PTEs. */
+		put_page(src_page);
 		pte_free(dst_mm, pgtable);
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
 		__split_huge_pmd(src_vma, src_pmd, addr, false, NULL);
 		return -EAGAIN;
 	}
-
-	get_page(src_page);
-	page_dup_rmap(src_page, true);
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 out_zero_page:
 	mm_inc_nr_ptes(dst_mm);
@@ -1217,14 +1210,10 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		/* No huge zero pud yet */
 	}
 
-	/* Please refer to comments in copy_huge_pmd() */
-	if (unlikely(page_needs_cow_for_dma(vma, pud_page(pud)))) {
-		spin_unlock(src_ptl);
-		spin_unlock(dst_ptl);
-		__split_huge_pud(vma, src_pud, addr);
-		return -EAGAIN;
-	}
-
+	/*
+	 * TODO: once we support anonymous pages, use page_try_dup_anon_rmap()
+	 * and split if duplicating fails.
+	 */
 	pudp_set_wrprotect(src_mm, addr, src_pud);
 	pud = pud_mkold(pud_wrprotect(pud));
 	set_pud_at(dst_mm, addr, dst_pud, pud);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d3ce89697855..9fb990d95dab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4781,15 +4781,18 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			get_page(ptepage);
 
 			/*
-			 * This is a rare case where we see pinned hugetlb
-			 * pages while they're prone to COW.  We need to do the
-			 * COW earlier during fork.
+			 * Failing to duplicate the anon rmap is a rare case
+			 * where we see pinned hugetlb pages while they're
+			 * prone to COW. We need to do the COW earlier during
+			 * fork.
 			 *
 			 * When pre-allocating the page or copying data, we
 			 * need to be without the pgtable locks since we could
 			 * sleep during the process.
 			 */
-			if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
+			if (!PageAnon(ptepage)) {
+				page_dup_file_rmap(ptepage, true);
+			} else if (page_try_dup_anon_rmap(ptepage, true, vma)) {
 				pte_t src_pte_old = entry;
 				struct page *new;
 
@@ -4836,7 +4839,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = huge_pte_wrprotect(entry);
 			}
 
-			page_dup_rmap(ptepage, true);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 			hugetlb_count_add(npages, dst);
 		}
@@ -5514,7 +5516,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		ClearHPageRestoreReserve(page);
 		hugepage_add_new_anon_rmap(page, vma, haddr);
 	} else
-		page_dup_rmap(page, true);
+		page_dup_file_rmap(page, true);
 	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
 	set_huge_pte_at(mm, haddr, ptep, new_pte);
@@ -5874,7 +5876,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_unlock;
 
 	if (vm_shared) {
-		page_dup_rmap(page, true);
+		page_dup_file_rmap(page, true);
 	} else {
 		ClearHPageRestoreReserve(page);
 		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
diff --git a/mm/memory.c b/mm/memory.c
index accb72a3343d..b9602d41d907 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -828,7 +828,8 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 */
 		get_page(page);
 		rss[mm_counter(page)]++;
-		page_dup_rmap(page, false);
+		/* Cannot fail as these pages cannot get pinned. */
+		BUG_ON(page_try_dup_anon_rmap(page, false, src_vma));
 
 		/*
 		 * We do not preserve soft-dirty information, because so
@@ -924,18 +925,24 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	struct page *page;
 
 	page = vm_normal_page(src_vma, addr, pte);
-	if (page && unlikely(page_needs_cow_for_dma(src_vma, page))) {
+	if (page && PageAnon(page)) {
 		/*
 		 * If this page may have been pinned by the parent process,
 		 * copy the page immediately for the child so that we'll always
 		 * guarantee the pinned page won't be randomly replaced in the
 		 * future.
 		 */
-		return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
-					 addr, rss, prealloc, page);
+		get_page(page);
+		if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
+			/* Page maybe pinned, we have to copy. */
+			put_page(page);
+			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
+						 addr, rss, prealloc, page);
+		}
+		rss[mm_counter(page)]++;
 	} else if (page) {
 		get_page(page);
-		page_dup_rmap(page, false);
+		page_dup_file_rmap(page, false);
 		rss[mm_counter(page)]++;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..524c2648ab36 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -240,7 +240,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 			if (PageAnon(new))
 				hugepage_add_anon_rmap(new, vma, pvmw.address);
 			else
-				page_dup_rmap(new, true);
+				page_dup_file_rmap(new, true);
 			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		} else
 #endif
-- 
2.35.1

