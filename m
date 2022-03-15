Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F384D99A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345482AbiCOKxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348060AbiCOKxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B1B452B36
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647341508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xX03abwP6p05ul7U7rmi9tu2NJ1Nwhvv/GQYUfQySBs=;
        b=SMlQtQXLdwR+dSMkppNCw6w8qQKjcs12uNb/18wvF8F8O2MOAYk6WsgpmNfKJe8jH8FsQo
        sOtxYYNPosqid/lFw4hewsLlVossat5DjD3w0BVuWQRPZxSpkFiZWzQ5MOcHB5DlS7y0Ts
        pv2Sw9+SN0oWLyi7HOxlkP+DvS044sk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-ggj7dAOHOVuNpnF3W0Wg3w-1; Tue, 15 Mar 2022 06:51:45 -0400
X-MC-Unique: ggj7dAOHOVuNpnF3W0Wg3w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C50A1C01502;
        Tue, 15 Mar 2022 10:51:44 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BC2F2D465;
        Tue, 15 Mar 2022 10:51:17 +0000 (UTC)
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
Subject: [PATCH v2 08/15] mm/rmap: drop "compound" parameter from page_add_new_anon_rmap()
Date:   Tue, 15 Mar 2022 11:47:34 +0100
Message-Id: <20220315104741.63071-9-david@redhat.com>
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

New anonymous pages are always mapped natively: only THP/khugepagd code
maps a new compound anonymous page and passes "true". Otherwise, we're
just dealing with simple, non-compound pages.

Let's give the interface clearer semantics and document these.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h    |  2 +-
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  2 +-
 mm/khugepaged.c         |  2 +-
 mm/memory.c             | 10 +++++-----
 mm/migrate.c            |  2 +-
 mm/rmap.c               |  9 ++++++---
 mm/swapfile.c           |  2 +-
 mm/userfaultfd.c        |  2 +-
 9 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 94ee38829c63..51953bace0a3 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -183,7 +183,7 @@ void page_move_anon_rmap(struct page *, struct vm_area_struct *);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long, rmap_t);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long, bool);
+		unsigned long);
 void page_add_file_rmap(struct page *, bool);
 void page_remove_rmap(struct page *, bool);
 
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6357c3580d07..b6fdb23fb3ea 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -184,7 +184,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	if (new_page) {
 		get_page(new_page);
-		page_add_new_anon_rmap(new_page, vma, addr, false);
+		page_add_new_anon_rmap(new_page, vma, addr);
 		lru_cache_add_inactive_or_unevictable(new_page, vma);
 	} else
 		/* no new page, just dec_mm_counter for old_page */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2ca137e01e84..c1f7eaba23ff 100644
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
index a325a646be33..96cc903c4788 100644
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
index e2d8e55c55c0..00c45b3a9576 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -896,7 +896,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	*prealloc = NULL;
 	copy_user_highpage(new_page, page, addr, src_vma);
 	__SetPageUptodate(new_page);
-	page_add_new_anon_rmap(new_page, dst_vma, addr, false);
+	page_add_new_anon_rmap(new_page, dst_vma, addr);
 	lru_cache_add_inactive_or_unevictable(new_page, dst_vma);
 	rss[mm_counter(new_page)]++;
 
@@ -3052,7 +3052,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * some TLBs while the old PTE remains in others.
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
-		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
+		page_add_new_anon_rmap(new_page, vma, vmf->address);
 		lru_cache_add_inactive_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
@@ -3706,7 +3706,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	/* ksm created a completely new copy */
 	if (unlikely(page != swapcache && swapcache)) {
-		page_add_new_anon_rmap(page, vma, vmf->address, false);
+		page_add_new_anon_rmap(page, vma, vmf->address);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		page_add_anon_rmap(page, vma, vmf->address, rmap_flags);
@@ -3856,7 +3856,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, vmf->address, false);
+	page_add_new_anon_rmap(page, vma, vmf->address);
 	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
@@ -4033,7 +4033,7 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-		page_add_new_anon_rmap(page, vma, addr, false);
+		page_add_new_anon_rmap(page, vma, addr);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
diff --git a/mm/migrate.c b/mm/migrate.c
index e6b3cb3d148b..fd9eba33b34a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2725,7 +2725,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto unlock_abort;
 
 	inc_mm_counter(mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, addr, false);
+	page_add_new_anon_rmap(page, vma, addr);
 	if (!is_zone_device_page(page))
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	get_page(page);
diff --git a/mm/rmap.c b/mm/rmap.c
index 7162689203fc..ebe7140c4493 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1184,19 +1184,22 @@ void page_add_anon_rmap(struct page *page,
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
index 41ba8238d16b..7edc8e099b22 100644
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
index 0780c2a57ff1..4ca854ce14f0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -98,7 +98,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	if (page_in_cache)
 		page_add_file_rmap(page, false);
 	else
-		page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
+		page_add_new_anon_rmap(page, dst_vma, dst_addr);
 
 	/*
 	 * Must happen after rmap, as mm_counter() checks mapping (via
-- 
2.35.1

