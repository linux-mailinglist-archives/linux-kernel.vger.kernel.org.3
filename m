Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D824D1A38
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347353AbiCHOSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiCHOSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:18:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 613DF1D0C1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646749070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+rDWx2pY/9IgwNkP7rXicVtwflN/Df6Pvu9u43tuUME=;
        b=eEcd49krxQVVTm/5eV1Y4JANf4NV5ddROTqka5lSTjD4mkypT2IrHJveRAuh7FyB8Y5dUI
        GZhE629Xse0EuA1rgN/ydtSMHC09UkBH4x6pK3UrkhaoRxq2jOL3hS8mAQZGoGep/g82U5
        RgUaraMC2zt0NnuOt0RBNMB+N2Rg5p8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-wB2kEmmpOeSlW2BqrCp_eQ-1; Tue, 08 Mar 2022 09:17:47 -0500
X-MC-Unique: wB2kEmmpOeSlW2BqrCp_eQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20CBA835DE0;
        Tue,  8 Mar 2022 14:17:44 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DE817886E;
        Tue,  8 Mar 2022 14:17:37 +0000 (UTC)
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
Subject: [PATCH v1 05/15] mm/rmap: convert RMAP flags to a proper distinct rmap_t type
Date:   Tue,  8 Mar 2022 15:14:27 +0100
Message-Id: <20220308141437.144919-6-david@redhat.com>
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
index 92c3585b8c6a..49f6b208938c 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -158,9 +158,23 @@ static inline void anon_vma_merge(struct vm_area_struct *vma,
 
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
@@ -169,7 +183,7 @@ void page_move_anon_rmap(struct page *, struct vm_area_struct *);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long, bool);
 void do_page_add_anon_rmap(struct page *, struct vm_area_struct *,
-			   unsigned long, int);
+			   unsigned long, rmap_t);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long, bool);
 void page_add_file_rmap(struct page *, bool);
diff --git a/mm/memory.c b/mm/memory.c
index b9602d41d907..bbce3ca72974 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3515,10 +3515,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
 
@@ -3693,7 +3693,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 		vmf->flags &= ~FAULT_FLAG_WRITE;
 		ret |= VM_FAULT_WRITE;
-		exclusive = RMAP_EXCLUSIVE;
+		rmap_flags |= RMAP_EXCLUSIVE;
 	}
 	flush_icache_page(vma, page);
 	if (pte_swp_soft_dirty(vmf->orig_pte))
@@ -3709,7 +3709,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
-		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
+		do_page_add_anon_rmap(page, vma, vmf->address, rmap_flags);
 	}
 
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
diff --git a/mm/rmap.c b/mm/rmap.c
index f825aeef61ca..3d7028d100ea 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1139,7 +1139,8 @@ static void __page_check_anon_rmap(struct page *page,
 void page_add_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address, bool compound)
 {
-	do_page_add_anon_rmap(page, vma, address, compound ? RMAP_COMPOUND : 0);
+	do_page_add_anon_rmap(page, vma, address,
+			      compound ? RMAP_COMPOUND : RMAP_NONE);
 }
 
 /*
@@ -1148,7 +1149,7 @@ void page_add_anon_rmap(struct page *page,
  * Everybody else should continue to use page_add_anon_rmap above.
  */
 void do_page_add_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, int flags)
+	struct vm_area_struct *vma, unsigned long address, rmap_t flags)
 {
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
@@ -1189,7 +1190,7 @@ void do_page_add_anon_rmap(struct page *page,
 	/* address might be in next vma when migration races vma_adjust */
 	if (first)
 		__page_set_anon_rmap(page, vma, address,
-				flags & RMAP_EXCLUSIVE);
+				     !!(flags & RMAP_EXCLUSIVE));
 	else
 		__page_check_anon_rmap(page, vma, address);
 }
-- 
2.35.1

