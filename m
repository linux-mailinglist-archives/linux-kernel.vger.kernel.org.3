Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFCF4EB14B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbiC2QHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239228AbiC2QHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7ACCC5B3D2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648569920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZctUr4A2tm5tAWNN7Hz7RXRASYqCbSemtzV/Omej/Tw=;
        b=RtiJFEVyGxEjJsV3wnQSvAigoBr3NSq4gc0SFizJYlyVL3iM1XNZWVfw/itBPwipxgn1sN
        L15L/l759tKLMIZqH118LZOdYe7f24soU/K6Yv8gTnZmbiQv3n+kpwnhkWlcbeaA/vVzN6
        E2PrmRCGnKi21qgozCOnGPpcra+rTcQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-rWNDZ0oQPTaF1dDagHrjgg-1; Tue, 29 Mar 2022 12:05:18 -0400
X-MC-Unique: rWNDZ0oQPTaF1dDagHrjgg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CFA390F928;
        Tue, 29 Mar 2022 16:05:17 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCD56401E2A;
        Tue, 29 Mar 2022 16:05:11 +0000 (UTC)
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
Subject: [PATCH v3 05/16] mm/rmap: convert RMAP flags to a proper distinct rmap_t type
Date:   Tue, 29 Mar 2022 18:04:29 +0200
Message-Id: <20220329160440.193848-6-david@redhat.com>
In-Reply-To: <20220329160440.193848-1-david@redhat.com>
References: <20220329160440.193848-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to pass the flags to more than one anon rmap function, getting
rid of special "do_page_add_anon_rmap()". So let's pass around a distinct
__bitwise type and refine documentation.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 22 ++++++++++++++++++----
 mm/memory.c          |  6 +++---
 mm/rmap.c            |  7 ++++---
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 9d602fc34063..2d0f12119a13 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -160,9 +160,23 @@ static inline void anon_vma_merge(struct vm_area_struct *vma,
 
 struct anon_vma *page_get_anon_vma(struct page *page);
 
-/* bitflags for do_page_add_anon_rmap() */
-#define RMAP_EXCLUSIVE 0x01
-#define RMAP_COMPOUND 0x02
+/* RMAP flags, currently only relevant for some anon rmap operations. */
+typedef int __bitwise rmap_t;
+
+/*
+ * No special request: if the page is a subpage of a compound page, it is
+ * mapped via a PTE. The mapped (sub)page is possibly shared between processes.
+ */
+#define RMAP_NONE		((__force rmap_t)0)
+
+/* The (sub)page is exclusive to a single process. */
+#define RMAP_EXCLUSIVE		((__force rmap_t)BIT(0))
+
+/*
+ * The compound page is not mapped via PTEs, but instead via a single PMD and
+ * should be accounted accordingly.
+ */
+#define RMAP_COMPOUND		((__force rmap_t)BIT(1))
 
 /*
  * rmap interfaces called when adding or removing pte of page
@@ -171,7 +185,7 @@ void page_move_anon_rmap(struct page *, struct vm_area_struct *);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, bool compound);
 void do_page_add_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long address, int flags);
+		unsigned long address, rmap_t flags);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, bool compound);
 void page_add_file_rmap(struct page *, struct vm_area_struct *,
diff --git a/mm/memory.c b/mm/memory.c
index 2baa2fed1319..f0fd63a7f652 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3507,10 +3507,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = NULL, *swapcache;
 	struct swap_info_struct *si = NULL;
+	rmap_t rmap_flags = RMAP_NONE;
 	swp_entry_t entry;
 	pte_t pte;
 	int locked;
-	int exclusive = 0;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
@@ -3685,7 +3685,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 		vmf->flags &= ~FAULT_FLAG_WRITE;
 		ret |= VM_FAULT_WRITE;
-		exclusive = RMAP_EXCLUSIVE;
+		rmap_flags |= RMAP_EXCLUSIVE;
 	}
 	flush_icache_page(vma, page);
 	if (pte_swp_soft_dirty(vmf->orig_pte))
@@ -3701,7 +3701,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
-		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
+		do_page_add_anon_rmap(page, vma, vmf->address, rmap_flags);
 	}
 
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
diff --git a/mm/rmap.c b/mm/rmap.c
index 07f59bc6ffc1..3623d16ae11b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1137,7 +1137,8 @@ static void __page_check_anon_rmap(struct page *page,
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address, bool compound)
 {
-	do_page_add_anon_rmap(page, vma, address, compound ? RMAP_COMPOUND : 0);
+	do_page_add_anon_rmap(page, vma, address,
+			      compound ? RMAP_COMPOUND : RMAP_NONE);
 }
 
 /*
@@ -1146,7 +1147,7 @@ void page_add_anon_rmap(struct page *page,
  * Everybody else should continue to use page_add_anon_rmap above.
  */
 void do_page_add_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, int flags)
+	struct vm_area_struct *vma, unsigned long address, rmap_t flags)
 {
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
@@ -1185,7 +1186,7 @@ void do_page_add_anon_rmap(struct page *page,
 	/* address might be in next vma when migration races vma_adjust */
 	else if (first)
 		__page_set_anon_rmap(page, vma, address,
-				flags & RMAP_EXCLUSIVE);
+				     !!(flags & RMAP_EXCLUSIVE));
 	else
 		__page_check_anon_rmap(page, vma, address);
 
-- 
2.35.1

