Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF3C512EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbiD1Il6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344486AbiD1IlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCA6C2E9DB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651134942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yga6Wtu7g8708vup2NftPxZiXC5z1mDMmMCM8B/bizc=;
        b=P6p9V9PbXEaSuCbcoEa6IA0teuG6vlVs2npPqLJjGHmcOQSTdYL4KXx7VQJ7g8pVkMEorI
        rJ4jkzOVSD1a0TrfaUZtuxhJQVxMiY4yRErP7rZTNbaJ2lTZVoIS6Q9u+d5ydbpjyeg1YN
        gwLvchwG/kfX8D/AATSc1oHMca3yzyU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-3MhLPfS9O-yRhgmKERQ2MQ-1; Thu, 28 Apr 2022 04:35:36 -0400
X-MC-Unique: 3MhLPfS9O-yRhgmKERQ2MQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E861289C7E0;
        Thu, 28 Apr 2022 08:35:34 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38B0B566A29;
        Thu, 28 Apr 2022 08:35:29 +0000 (UTC)
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
Subject: [PATCH v4 08/17] mm/rmap: drop "compound" parameter from page_add_new_anon_rmap()
Date:   Thu, 28 Apr 2022 10:34:32 +0200
Message-Id: <20220428083441.37290-9-david@redhat.com>
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

New anonymous pages are always mapped natively: only THP/khugepaged code
maps a new compound anonymous page and passes "true". Otherwise, we're
just dealing with simple, non-compound pages.

Let's give the interface clearer semantics and document these. Remove
the PageTransCompound() sanity check from page_add_new_anon_rmap().

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h    |  3 ++-
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  2 +-
 mm/khugepaged.c         |  2 +-
 mm/memory.c             | 10 +++++-----
 mm/migrate_device.c     |  2 +-
 mm/rmap.c               | 11 ++++++-----
 mm/swapfile.c           |  2 +-
 mm/userfaultfd.c        |  2 +-
 9 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index f47bc937c383..9c120e1b1bc7 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -185,11 +185,12 @@ void page_move_anon_rmap(struct page *, struct vm_area_struct *);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long address, bool compound);
+		unsigned long address);
 void page_add_file_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
 void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
+
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
 void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6418083901d4..4ef5385815d3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -180,7 +180,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	if (new_page) {
 		get_page(new_page);
-		page_add_new_anon_rmap(new_page, vma, addr, false);
+		page_add_new_anon_rmap(new_page, vma, addr);
 		lru_cache_add_inactive_or_unevictable(new_page, vma);
 	} else
 		/* no new page, just dec_mm_counter for old_page */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6232b6817fab..c0365280b481 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -647,7 +647,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-		page_add_new_anon_rmap(page, vma, haddr, true);
+		page_add_new_anon_rmap(page, vma, haddr);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a4e5eaf3eb01..9bb32fb7ec74 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1183,7 +1183,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
-	page_add_new_anon_rmap(new_page, vma, address, true);
+	page_add_new_anon_rmap(new_page, vma, address);
 	lru_cache_add_inactive_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, address, pmd, _pmd);
diff --git a/mm/memory.c b/mm/memory.c
index f46504191571..22e732c266dd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -893,7 +893,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	*prealloc = NULL;
 	copy_user_highpage(new_page, page, addr, src_vma);
 	__SetPageUptodate(new_page);
-	page_add_new_anon_rmap(new_page, dst_vma, addr, false);
+	page_add_new_anon_rmap(new_page, dst_vma, addr);
 	lru_cache_add_inactive_or_unevictable(new_page, dst_vma);
 	rss[mm_counter(new_page)]++;
 
@@ -3058,7 +3058,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * some TLBs while the old PTE remains in others.
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
-		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
+		page_add_new_anon_rmap(new_page, vma, vmf->address);
 		lru_cache_add_inactive_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
@@ -3698,7 +3698,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	/* ksm created a completely new copy */
 	if (unlikely(page != swapcache && swapcache)) {
-		page_add_new_anon_rmap(page, vma, vmf->address, false);
+		page_add_new_anon_rmap(page, vma, vmf->address);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		page_add_anon_rmap(page, vma, vmf->address, rmap_flags);
@@ -3848,7 +3848,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, vmf->address, false);
+	page_add_new_anon_rmap(page, vma, vmf->address);
 	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
@@ -4035,7 +4035,7 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-		page_add_new_anon_rmap(page, vma, addr, false);
+		page_add_new_anon_rmap(page, vma, addr);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 70c7dc05bbfc..fb6d7d5499f5 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -610,7 +610,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto unlock_abort;
 
 	inc_mm_counter(mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, addr, false);
+	page_add_new_anon_rmap(page, vma, addr);
 	if (!is_zone_device_page(page))
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	get_page(page);
diff --git a/mm/rmap.c b/mm/rmap.c
index 065501642401..d98011ad05ca 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1182,19 +1182,22 @@ void page_add_anon_rmap(struct page *page,
 }
 
 /**
- * page_add_new_anon_rmap - add pte mapping to a new anonymous page
+ * page_add_new_anon_rmap - add mapping to a new anonymous page
  * @page:	the page to add the mapping to
  * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
- * @compound:	charge the page as compound or small page
+ *
+ * If it's a compound page, it is accounted as a compound page. As the page
+ * is new, it's assume to get mapped exclusively by a single process.
  *
  * Same as page_add_anon_rmap but must only be called on *new* pages.
  * This means the inc-and-test can be bypassed.
  * Page does not have to be locked.
  */
 void page_add_new_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, bool compound)
+	struct vm_area_struct *vma, unsigned long address)
 {
+	const bool compound = PageCompound(page);
 	int nr = compound ? thp_nr_pages(page) : 1;
 
 	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
@@ -1207,8 +1210,6 @@ void page_add_new_anon_rmap(struct page *page,
 
 		__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
 	} else {
-		/* Anon THP always mapped first with PMD */
-		VM_BUG_ON_PAGE(PageTransCompound(page), page);
 		/* increment count (starts at -1) */
 		atomic_set(&page->_mapcount, 0);
 	}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1ba525a2179d..0ad7ed7ded21 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1802,7 +1802,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	if (page == swapcache) {
 		page_add_anon_rmap(page, vma, addr, RMAP_NONE);
 	} else { /* ksm created a completely new copy */
-		page_add_new_anon_rmap(page, vma, addr, false);
+		page_add_new_anon_rmap(page, vma, addr);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	}
 	set_pte_at(vma->vm_mm, addr, pte,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e9bb6db002aa..dae25d985d15 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -104,7 +104,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 			lru_cache_add(page);
 		page_add_file_rmap(page, dst_vma, false);
 	} else {
-		page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
+		page_add_new_anon_rmap(page, dst_vma, dst_addr);
 		lru_cache_add_inactive_or_unevictable(page, dst_vma);
 	}
 
-- 
2.35.1

