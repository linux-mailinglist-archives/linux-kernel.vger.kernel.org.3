Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF57F4EB14E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbiC2QHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbiC2QHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCE5E97BB4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648569960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZO3Kj3xwtMSWsxWPGiebiu52wcuHDjZNRgRRqozubs=;
        b=CfULY53FLzft+C7B61AvRmCahiQpYNOG9iBTUgyjb6e2IL2K5GRbvJGfrWaGPuvPYsmH5F
        e7dh1eZLMeeslDrF2v4ZbuNlt/8JlwStFimgm7lVjxLcQ4nb61/2wSANCrBwolPw2JBoM0
        WmTz1GTOu/oB92nZTHlSb7/Zeuua13s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-wbSqqKpVNJ-0-Y24Kwx09A-1; Tue, 29 Mar 2022 12:05:56 -0400
X-MC-Unique: wbSqqKpVNJ-0-Y24Kwx09A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53E0591BD8C;
        Tue, 29 Mar 2022 16:05:55 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89A8A4021D9;
        Tue, 29 Mar 2022 16:05:39 +0000 (UTC)
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
Subject: [PATCH v3 08/16] mm/rmap: drop "compound" parameter from page_add_new_anon_rmap()
Date:   Tue, 29 Mar 2022 18:04:32 +0200
Message-Id: <20220329160440.193848-9-david@redhat.com>
In-Reply-To: <20220329160440.193848-1-david@redhat.com>
References: <20220329160440.193848-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New anonymous pages are always mapped natively: only THP/khugepagd code
maps a new compound anonymous page and passes "true". Otherwise, we're
just dealing with simple, non-compound pages.

Let's give the interface clearer semantics and document these.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h    |  3 ++-
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  2 +-
 mm/khugepaged.c         |  2 +-
 mm/memory.c             | 10 +++++-----
 mm/migrate_device.c     |  2 +-
 mm/rmap.c               |  9 ++++++---
 mm/swapfile.c           |  2 +-
 mm/userfaultfd.c        |  2 +-
 9 files changed, 19 insertions(+), 15 deletions(-)

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
index d933143ff886..c4526343565a 100644
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
index 60df8a365a72..03e29c9614e0 100644
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
@@ -4031,7 +4031,7 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
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
index b972eb8f351b..517f56edf6ce 100644
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
index 0cb8e5ef1713..f9eb132c3260 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -101,7 +101,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 			lru_cache_add(page);
 		page_add_file_rmap(page, dst_vma, false);
 	} else {
-		page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
+		page_add_new_anon_rmap(page, dst_vma, dst_addr);
 		lru_cache_add_inactive_or_unevictable(page, dst_vma);
 	}
 
-- 
2.35.1

