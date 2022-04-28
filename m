Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B864512EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiD1Ilx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344310AbiD1IlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A2D1B851
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651134925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4/xzV3Fv+2ayFiEsehQFqSYvMzCd79uGGysGX3J4TDg=;
        b=D4r3fMI0Elwg2NdDKyoNHDZdHyB2Ug2zYASjA1SFe2zpRTxesazvO1EIQbPr9t50KRQkoN
        SLA38Y3JTc2cKX7doSMdsacxfHLi3OqHIctmLnAf37N6qZIRQo21qyXt4Cf8rZpt2KP7D7
        dMM9J7ELSHY+kQuM7E0YsU4Srw65epU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-hwie7rCLP06I6VXcjX1ulg-1; Thu, 28 Apr 2022 04:35:24 -0400
X-MC-Unique: hwie7rCLP06I6VXcjX1ulg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E35D83396C;
        Thu, 28 Apr 2022 08:35:23 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AD38566A27;
        Thu, 28 Apr 2022 08:35:17 +0000 (UTC)
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
Subject: [PATCH v4 06/17] mm/rmap: remove do_page_add_anon_rmap()
Date:   Thu, 28 Apr 2022 10:34:30 +0200
Message-Id: <20220428083441.37290-7-david@redhat.com>
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

... and instead convert page_add_anon_rmap() to accept flags.

Passing flags instead of bools is usually nicer either way, and we want
to more often also pass RMAP_EXCLUSIVE in follow up patches when
detecting that an anonymous page is exclusive: for example, when
restoring an anonymous page from a writable migration entry.

This is a preparation for marking an anonymous page inside
page_add_anon_rmap() as exclusive when RMAP_EXCLUSIVE is passed.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |  2 --
 mm/huge_memory.c     |  2 +-
 mm/ksm.c             |  2 +-
 mm/memory.c          |  4 ++--
 mm/migrate.c         |  3 ++-
 mm/rmap.c            | 14 +-------------
 mm/swapfile.c        |  2 +-
 7 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 2d0f12119a13..aa734d2e2b01 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -183,8 +183,6 @@ typedef int __bitwise rmap_t;
  */
 void page_move_anon_rmap(struct page *, struct vm_area_struct *);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long address, bool compound);
-void do_page_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, bool compound);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index baf4ea6d8e1a..6232b6817fab 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3072,7 +3072,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 		pmde = pmd_wrprotect(pmd_mkuffd_wp(pmde));
 
 	if (PageAnon(new))
-		page_add_anon_rmap(new, vma, mmun_start, true);
+		page_add_anon_rmap(new, vma, mmun_start, RMAP_COMPOUND);
 	else
 		page_add_file_rmap(new, vma, true);
 	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
diff --git a/mm/ksm.c b/mm/ksm.c
index 063a48eeb5ee..e0fb748e37b3 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1150,7 +1150,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	 */
 	if (!is_zero_pfn(page_to_pfn(kpage))) {
 		get_page(kpage);
-		page_add_anon_rmap(kpage, vma, addr, false);
+		page_add_anon_rmap(kpage, vma, addr, RMAP_NONE);
 		newpte = mk_pte(kpage, vma->vm_page_prot);
 	} else {
 		newpte = pte_mkspecial(pfn_pte(page_to_pfn(kpage),
diff --git a/mm/memory.c b/mm/memory.c
index 414f4cf4fcf1..f46504191571 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -725,7 +725,7 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 	 * created when the swap entry was made.
 	 */
 	if (PageAnon(page))
-		page_add_anon_rmap(page, vma, address, false);
+		page_add_anon_rmap(page, vma, address, RMAP_NONE);
 	else
 		/*
 		 * Currently device exclusive access only supports anonymous
@@ -3701,7 +3701,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
-		do_page_add_anon_rmap(page, vma, vmf->address, rmap_flags);
+		page_add_anon_rmap(page, vma, vmf->address, rmap_flags);
 	}
 
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
diff --git a/mm/migrate.c b/mm/migrate.c
index dd9ceb778e94..1e1d9519e05c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -240,7 +240,8 @@ static bool remove_migration_pte(struct folio *folio,
 #endif
 		{
 			if (folio_test_anon(folio))
-				page_add_anon_rmap(new, vma, pvmw.address, false);
+				page_add_anon_rmap(new, vma, pvmw.address,
+						   RMAP_NONE);
 			else
 				page_add_file_rmap(new, vma, false);
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
diff --git a/mm/rmap.c b/mm/rmap.c
index 8359aed9255e..ee349f905da0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1127,7 +1127,7 @@ static void __page_check_anon_rmap(struct page *page,
  * @page:	the page to add the mapping to
  * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
- * @compound:	charge the page as compound or small page
+ * @flags:	the rmap flags
  *
  * The caller needs to hold the pte lock, and the page must be locked in
  * the anon_vma case: to serialize mapping,index checking after setting,
@@ -1135,18 +1135,6 @@ static void __page_check_anon_rmap(struct page *page,
  * (but PageKsm is never downgraded to PageAnon).
  */
 void page_add_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, bool compound)
-{
-	do_page_add_anon_rmap(page, vma, address,
-			      compound ? RMAP_COMPOUND : RMAP_NONE);
-}
-
-/*
- * Special version of the above for do_swap_page, which often runs
- * into pages that are exclusively owned by the current process.
- * Everybody else should continue to use page_add_anon_rmap above.
- */
-void do_page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address, rmap_t flags)
 {
 	bool compound = flags & RMAP_COMPOUND;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 63c61f8b2611..1ba525a2179d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1800,7 +1800,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
 	get_page(page);
 	if (page == swapcache) {
-		page_add_anon_rmap(page, vma, addr, false);
+		page_add_anon_rmap(page, vma, addr, RMAP_NONE);
 	} else { /* ksm created a completely new copy */
 		page_add_new_anon_rmap(page, vma, addr, false);
 		lru_cache_add_inactive_or_unevictable(page, vma);
-- 
2.35.1

