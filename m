Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0440D4C2BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiBXMaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiBXMaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:30:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6DF3264983
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645705778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAdSwEvV+Vd6qcTOzU2MRWGrb9N7T7CfRa1GQWshOa0=;
        b=ee8qG8BOAwnHc8FqWsiGclNZ5tUFePzOetYjXc6vACr7tspizZFskAGVLMOYoE5HKl3lY/
        eeCEVdDU+YnuBEXdqs8jVFSf+wMdf/j6ztl8MSOhkDwWwuT53rnwJyHPyHO8fk1gGU3M+P
        F8mxQ/Uy2CEsQbGh76TY94wwGvnKzOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-0S8wfMKZPYe3EOPTIEkwmA-1; Thu, 24 Feb 2022 07:29:35 -0500
X-MC-Unique: 0S8wfMKZPYe3EOPTIEkwmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 957C5804310;
        Thu, 24 Feb 2022 12:29:32 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B79E426576;
        Thu, 24 Feb 2022 12:28:49 +0000 (UTC)
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
Subject: [PATCH RFC 05/13] mm/rmap: remove do_page_add_anon_rmap()
Date:   Thu, 24 Feb 2022 13:26:06 +0100
Message-Id: <20220224122614.94921-6-david@redhat.com>
In-Reply-To: <20220224122614.94921-1-david@redhat.com>
References: <20220224122614.94921-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |  4 +---
 mm/huge_memory.c     |  2 +-
 mm/ksm.c             |  2 +-
 mm/memory.c          |  2 +-
 mm/migrate.c         |  2 +-
 mm/rmap.c            | 17 +++--------------
 mm/swapfile.c        |  2 +-
 7 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 92c3585b8c6a..f230e86b4587 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -167,9 +167,7 @@ struct anon_vma *page_get_anon_vma(struct page *page);
  */
 void page_move_anon_rmap(struct page *, struct vm_area_struct *);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long, bool);
-void do_page_add_anon_rmap(struct page *, struct vm_area_struct *,
-			   unsigned long, int);
+		unsigned long, int);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long, bool);
 void page_add_file_rmap(struct page *, bool);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c126d728b8de..2ca137e01e84 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3115,7 +3115,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
 	flush_cache_range(vma, mmun_start, mmun_start + HPAGE_PMD_SIZE);
 	if (PageAnon(new))
-		page_add_anon_rmap(new, vma, mmun_start, true);
+		page_add_anon_rmap(new, vma, mmun_start, RMAP_COMPOUND);
 	else
 		page_add_file_rmap(new, true);
 	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
diff --git a/mm/ksm.c b/mm/ksm.c
index c20bd4d9a0d9..e897577c54c5 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1153,7 +1153,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	 */
 	if (!is_zero_pfn(page_to_pfn(kpage))) {
 		get_page(kpage);
-		page_add_anon_rmap(kpage, vma, addr, false);
+		page_add_anon_rmap(kpage, vma, addr, 0);
 		newpte = mk_pte(kpage, vma->vm_page_prot);
 	} else {
 		newpte = pte_mkspecial(pfn_pte(page_to_pfn(kpage),
diff --git a/mm/memory.c b/mm/memory.c
index b9602d41d907..c2f1c2428303 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3709,7 +3709,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
-		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
+		page_add_anon_rmap(page, vma, vmf->address, exclusive);
 	}
 
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
diff --git a/mm/migrate.c b/mm/migrate.c
index 524c2648ab36..d4d72a15224c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -246,7 +246,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 #endif
 		{
 			if (PageAnon(new))
-				page_add_anon_rmap(new, vma, pvmw.address, false);
+				page_add_anon_rmap(new, vma, pvmw.address, 0);
 			else
 				page_add_file_rmap(new, false);
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
diff --git a/mm/rmap.c b/mm/rmap.c
index f825aeef61ca..902ebf99d147 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1129,26 +1129,15 @@ static void __page_check_anon_rmap(struct page *page,
  * @page:	the page to add the mapping to
  * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
- * @compound:	charge the page as compound or small page
+ * @flags:	the rmap flags
  *
  * The caller needs to hold the pte lock, and the page must be locked in
  * the anon_vma case: to serialize mapping,index checking after setting,
  * and to ensure that PageAnon is not being upgraded racily to PageKsm
  * (but PageKsm is never downgraded to PageAnon).
  */
-void page_add_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, bool compound)
-{
-	do_page_add_anon_rmap(page, vma, address, compound ? RMAP_COMPOUND : 0);
-}
-
-/*
- * Special version of the above for do_swap_page, which often runs
- * into pages that are exclusively owned by the current process.
- * Everybody else should continue to use page_add_anon_rmap above.
- */
-void do_page_add_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, int flags)
+void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
+			unsigned long address, int flags)
 {
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a5183315dc58..eacda7ca7ac9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1800,7 +1800,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
 	get_page(page);
 	if (page == swapcache) {
-		page_add_anon_rmap(page, vma, addr, false);
+		page_add_anon_rmap(page, vma, addr, 0);
 	} else { /* ksm created a completely new copy */
 		page_add_new_anon_rmap(page, vma, addr, false);
 		lru_cache_add_inactive_or_unevictable(page, vma);
-- 
2.35.1

