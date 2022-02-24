Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501CD4C2BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiBXMaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiBXMag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:30:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EA162649AD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645705806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhqDRec0VOKot1t14KWHy23p5AtjEJVAkoghtw0kzkE=;
        b=Rmwb9dFfH7jYK88ZeAalN3MmvdJloZll1ef3SMxsahyxCN07vqcI277qNK1NpeFD0aKtw0
        /AVVz2eLCiRcQTrAt39sUML1Bs6G5WyPF9nxs2bG7kHqk3blG6IvkiR4jJaO/Mi1Anyear
        DnFb55NTsEB71xwUO0MfzsCExsKMuQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-C2te0jKPMjmNIiCZmNMFvw-1; Thu, 24 Feb 2022 07:30:01 -0500
X-MC-Unique: C2te0jKPMjmNIiCZmNMFvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CC3A80D6AD;
        Thu, 24 Feb 2022 12:29:57 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3218C2634C;
        Thu, 24 Feb 2022 12:29:32 +0000 (UTC)
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
Subject: [PATCH RFC 06/13] mm/rmap: pass rmap flags to hugepage_add_anon_rmap()
Date:   Thu, 24 Feb 2022 13:26:07 +0100
Message-Id: <20220224122614.94921-7-david@redhat.com>
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

Let's prepare for passing RMAP_EXCLUSIVE, similarly as we do for
page_add_anon_rmap() now. RMAP_COMPOUND is implicit for hugetlb
pages and ignored.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 2 +-
 mm/migrate.c         | 2 +-
 mm/rmap.c            | 8 +++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index f230e86b4587..593a4566420f 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -174,7 +174,7 @@ void page_add_file_rmap(struct page *, bool);
 void page_remove_rmap(struct page *, bool);
 
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
-			    unsigned long);
+			    unsigned long, int);
 void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 				unsigned long);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index d4d72a15224c..709cb11d5b81 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -238,7 +238,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 			pte = pte_mkhuge(pte);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (PageAnon(new))
-				hugepage_add_anon_rmap(new, vma, pvmw.address);
+				hugepage_add_anon_rmap(new, vma, pvmw.address, 0);
 			else
 				page_dup_file_rmap(new, true);
 			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
diff --git a/mm/rmap.c b/mm/rmap.c
index 902ebf99d147..bafdb7f70cec 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2409,9 +2409,11 @@ void rmap_walk_locked(struct page *page, struct rmap_walk_control *rwc)
  * The following two functions are for anonymous (private mapped) hugepages.
  * Unlike common anonymous pages, anonymous hugepages have no accounting code
  * and no lru code, because we handle hugepages differently from common pages.
+ *
+ * RMAP_COMPOUND is ignored.
  */
-void hugepage_add_anon_rmap(struct page *page,
-			    struct vm_area_struct *vma, unsigned long address)
+void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
+			    unsigned long address, int flags)
 {
 	struct anon_vma *anon_vma = vma->anon_vma;
 	int first;
@@ -2421,7 +2423,7 @@ void hugepage_add_anon_rmap(struct page *page,
 	/* address might be in next vma when migration races vma_adjust */
 	first = atomic_inc_and_test(compound_mapcount_ptr(page));
 	if (first)
-		__page_set_anon_rmap(page, vma, address, 0);
+		__page_set_anon_rmap(page, vma, address, flags & RMAP_EXCLUSIVE);
 }
 
 void hugepage_add_new_anon_rmap(struct page *page,
-- 
2.35.1

