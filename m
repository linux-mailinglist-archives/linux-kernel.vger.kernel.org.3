Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337DE4D9997
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347239AbiCOKwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345914AbiCOKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BB5853722
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647341387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aj4DcramAuSghxYBNgB7LsYO7zn5E/reH2YN2OU1WzY=;
        b=YGoXbI1NJuXMAPsMHMcu4qceqyotmuVoQJPKl7ApOk098EmCTbpzkGhk7uUSrv2YCi1X1z
        B3h542NjXcHB+muFaUwnZEGnL6e0agwXz022sKW6hNmTQBY787pIfCYSL6A+eDHkAj26jA
        9IERgB4JOK9vwQkhLgM6MUfDLg97qFU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-JYpq47hDNcm8FdJYsze_Sw-1; Tue, 15 Mar 2022 06:49:44 -0400
X-MC-Unique: JYpq47hDNcm8FdJYsze_Sw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC87980088A;
        Tue, 15 Mar 2022 10:49:42 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B49E9E94;
        Tue, 15 Mar 2022 10:49:11 +0000 (UTC)
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
Subject: [PATCH v2 03/15] mm/memory: slightly simplify copy_present_pte()
Date:   Tue, 15 Mar 2022 11:47:29 +0100
Message-Id: <20220315104741.63071-4-david@redhat.com>
In-Reply-To: <20220315104741.63071-1-david@redhat.com>
References: <20220315104741.63071-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move the pinning check into the caller, to simplify return code
logic and prepare for further changes: relocating the
page_needs_cow_for_dma() into rmap handling code.

While at it, remove the unused pte parameter and simplify the comments a
bit.

No functional change intended.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 53 ++++++++++++++++-------------------------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c6177d897964..accb72a3343d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -865,19 +865,11 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 }
 
 /*
- * Copy a present and normal page if necessary.
+ * Copy a present and normal page.
  *
- * NOTE! The usual case is that this doesn't need to do
- * anything, and can just return a positive value. That
- * will let the caller know that it can just increase
- * the page refcount and re-use the pte the traditional
- * way.
- *
- * But _if_ we need to copy it because it needs to be
- * pinned in the parent (and the child should get its own
- * copy rather than just a reference to the same page),
- * we'll do that here and return zero to let the caller
- * know we're done.
+ * NOTE! The usual case is that this isn't required;
+ * instead, the caller can just increase the page refcount
+ * and re-use the pte the traditional way.
  *
  * And if we need a pre-allocated page but don't yet have
  * one, return a negative error to let the preallocation
@@ -887,25 +879,10 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 static inline int
 copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		  pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
-		  struct page **prealloc, pte_t pte, struct page *page)
+		  struct page **prealloc, struct page *page)
 {
 	struct page *new_page;
-
-	/*
-	 * What we want to do is to check whether this page may
-	 * have been pinned by the parent process.  If so,
-	 * instead of wrprotect the pte on both sides, we copy
-	 * the page immediately so that we'll always guarantee
-	 * the pinned page won't be randomly replaced in the
-	 * future.
-	 *
-	 * The page pinning checks are just "has this mm ever
-	 * seen pinning", along with the (inexact) check of
-	 * the page count. That might give false positives for
-	 * for pinning, but it will work correctly.
-	 */
-	if (likely(!page_needs_cow_for_dma(src_vma, page)))
-		return 1;
+	pte_t pte;
 
 	new_page = *prealloc;
 	if (!new_page)
@@ -947,14 +924,16 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	struct page *page;
 
 	page = vm_normal_page(src_vma, addr, pte);
-	if (page) {
-		int retval;
-
-		retval = copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
-					   addr, rss, prealloc, pte, page);
-		if (retval <= 0)
-			return retval;
-
+	if (page && unlikely(page_needs_cow_for_dma(src_vma, page))) {
+		/*
+		 * If this page may have been pinned by the parent process,
+		 * copy the page immediately for the child so that we'll always
+		 * guarantee the pinned page won't be randomly replaced in the
+		 * future.
+		 */
+		return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
+					 addr, rss, prealloc, page);
+	} else if (page) {
 		get_page(page);
 		page_dup_rmap(page, false);
 		rss[mm_counter(page)]++;
-- 
2.35.1

