Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E06512EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344623AbiD1Ilz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344451AbiD1IlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2B4922527
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651134936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qp/GndCvtjLgLDIihe51FDK+iOhlCQ2je7HQCqw8EnM=;
        b=I5jUai1VuSbsxrWrFsTjzfT/LVAtwkuNvY6R6lLdtLdt6LZK8xNZspDgDRb79x+dkP7YAr
        kMl0sAxpt6obawIOMBYbevdZOjWXAhcPqqX/4gwkKtCTER8rhuKfllYXXVpXmGfNW0c+qE
        FQqEH6OtrOjPOnpMYsEcPs2haVPSSCE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-_4Y0UHiYP8q8xmJgfWOXWA-1; Thu, 28 Apr 2022 04:35:31 -0400
X-MC-Unique: _4Y0UHiYP8q8xmJgfWOXWA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA1DE1E17FEA;
        Thu, 28 Apr 2022 08:35:28 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5ABF4566A27;
        Thu, 28 Apr 2022 08:35:23 +0000 (UTC)
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
Subject: [PATCH v4 07/17] mm/rmap: pass rmap flags to hugepage_add_anon_rmap()
Date:   Thu, 28 Apr 2022 10:34:31 +0200
Message-Id: <20220428083441.37290-8-david@redhat.com>
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

Let's prepare for passing RMAP_EXCLUSIVE, similarly as we do for
page_add_anon_rmap() now. RMAP_COMPOUND is implicit for hugetlb
pages and ignored.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 2 +-
 mm/migrate.c         | 3 ++-
 mm/rmap.c            | 9 ++++++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index aa734d2e2b01..f47bc937c383 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -191,7 +191,7 @@ void page_add_file_rmap(struct page *, struct vm_area_struct *,
 void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long address);
+		unsigned long address, rmap_t flags);
 void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 1e1d9519e05c..0167463ea9c5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -232,7 +232,8 @@ static bool remove_migration_pte(struct folio *folio,
 			pte = pte_mkhuge(pte);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (folio_test_anon(folio))
-				hugepage_add_anon_rmap(new, vma, pvmw.address);
+				hugepage_add_anon_rmap(new, vma, pvmw.address,
+						       RMAP_NONE);
 			else
 				page_dup_file_rmap(new, true);
 			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
diff --git a/mm/rmap.c b/mm/rmap.c
index ee349f905da0..065501642401 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2347,9 +2347,11 @@ void rmap_walk_locked(struct folio *folio, const struct rmap_walk_control *rwc)
  * The following two functions are for anonymous (private mapped) hugepages.
  * Unlike common anonymous pages, anonymous hugepages have no accounting code
  * and no lru code, because we handle hugepages differently from common pages.
+ *
+ * RMAP_COMPOUND is ignored.
  */
-void hugepage_add_anon_rmap(struct page *page,
-			    struct vm_area_struct *vma, unsigned long address)
+void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
+			    unsigned long address, rmap_t flags)
 {
 	struct anon_vma *anon_vma = vma->anon_vma;
 	int first;
@@ -2359,7 +2361,8 @@ void hugepage_add_anon_rmap(struct page *page,
 	/* address might be in next vma when migration races vma_adjust */
 	first = atomic_inc_and_test(compound_mapcount_ptr(page));
 	if (first)
-		__page_set_anon_rmap(page, vma, address, 0);
+		__page_set_anon_rmap(page, vma, address,
+				     !!(flags & RMAP_EXCLUSIVE));
 }
 
 void hugepage_add_new_anon_rmap(struct page *page,
-- 
2.35.1

