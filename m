Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B014D1A37
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347403AbiCHOTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347407AbiCHOTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:19:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF55445504
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646749083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5T/gajJPLUPxxjK76Rre/bUejADjCOPKBewGDRTcSM=;
        b=gpAcoYWCqvnvfhIhmG0C0/ok7jyOaFRk5IsiPd91ww9cZ7cLZCMTR5Ncde5pKfs6re4NqS
        Cj2RBm1SvPt4vMy0vYrPEC1wbUxvuShjWXmqDgRXiO07NhIcMy4DVjbE5mJZLtXyZX/25T
        oK+GISRdIAyxGJw2FPYXXjEAczuMlc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-tOPWGGQMPT6dAIXIpcPdwA-1; Tue, 08 Mar 2022 09:18:02 -0500
X-MC-Unique: tOPWGGQMPT6dAIXIpcPdwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27173835DE2;
        Tue,  8 Mar 2022 14:17:58 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A2B678874;
        Tue,  8 Mar 2022 14:17:51 +0000 (UTC)
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
Subject: [PATCH v1 07/15] mm/rmap: pass rmap flags to hugepage_add_anon_rmap()
Date:   Tue,  8 Mar 2022 15:14:29 +0100
Message-Id: <20220308141437.144919-8-david@redhat.com>
In-Reply-To: <20220308141437.144919-1-david@redhat.com>
References: <20220308141437.144919-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 mm/migrate.c         | 3 ++-
 mm/rmap.c            | 9 ++++++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index a269f80fbeef..94ee38829c63 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -188,7 +188,7 @@ void page_add_file_rmap(struct page *, bool);
 void page_remove_rmap(struct page *, bool);
 
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
-			    unsigned long);
+			    unsigned long, rmap_t);
 void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 				unsigned long);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 907052b72581..e6b3cb3d148b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -238,7 +238,8 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 			pte = pte_mkhuge(pte);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (PageAnon(new))
-				hugepage_add_anon_rmap(new, vma, pvmw.address);
+				hugepage_add_anon_rmap(new, vma, pvmw.address,
+						       RMAP_NONE);
 			else
 				page_dup_file_rmap(new, true);
 			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
diff --git a/mm/rmap.c b/mm/rmap.c
index 97bcc50c3489..7162689203fc 100644
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
+			    unsigned long address, rmap_t flags)
 {
 	struct anon_vma *anon_vma = vma->anon_vma;
 	int first;
@@ -2421,7 +2423,8 @@ void hugepage_add_anon_rmap(struct page *page,
 	/* address might be in next vma when migration races vma_adjust */
 	first = atomic_inc_and_test(compound_mapcount_ptr(page));
 	if (first)
-		__page_set_anon_rmap(page, vma, address, 0);
+		__page_set_anon_rmap(page, vma, address,
+				     flags & RMAP_EXCLUSIVE);
 }
 
 void hugepage_add_new_anon_rmap(struct page *page,
-- 
2.35.1

