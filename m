Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29F3512EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344644AbiD1ImB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344394AbiD1IlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4998033888
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651134948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLuKinorq4rlkUK0NOgUu05gyraDrJ+IHjcbSgfMRoI=;
        b=ggbZwUGnlV0hfxSpOGOZaoMEqPlMt7xP5dtl4WyxBfV7WVqpcHTwMXuvvO9FTQcK10d8Hw
        020RrHun4i4VZDHflVpZaJ8ePbJptu7EEE8T2798PbJIFTs4o9/Nlj3aMB9rbxDQkJzGFN
        /mIUFomeFeb8EUqju0E+PJR5Pb6MtLM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-VmxHT_nLOiKIKmPa4DnC6Q-1; Thu, 28 Apr 2022 04:35:44 -0400
X-MC-Unique: VmxHT_nLOiKIKmPa4DnC6Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF32C8058F6;
        Thu, 28 Apr 2022 08:35:40 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45114566A27;
        Thu, 28 Apr 2022 08:35:35 +0000 (UTC)
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
Subject: [PATCH v4 09/17] mm/rmap: use page_move_anon_rmap() when reusing a mapped PageAnon() page exclusively
Date:   Thu, 28 Apr 2022 10:34:33 +0200
Message-Id: <20220428083441.37290-10-david@redhat.com>
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

We want to mark anonymous pages exclusive, and when using
page_move_anon_rmap() we know that we are the exclusive user, as
properly documented. This is a preparation for marking anonymous pages
exclusive in page_move_anon_rmap().

In both instances, we're holding page lock and are sure that we're the
exclusive owner (page_count() == 1). hugetlb already properly uses
page_move_anon_rmap() in the write fault handler.

Note that in case of a PTE-mapped THP, we'll only end up calling this
function if the whole THP is only referenced by the single PTE mapping
a single subpage (page_count() == 1); consequently, it's fine to modify
the compound page mapping inside page_move_anon_rmap().

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 2 ++
 mm/memory.c      | 1 +
 2 files changed, 3 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c0365280b481..04c9446b87a8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1317,6 +1317,8 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 		try_to_free_swap(page);
 	if (page_count(page) == 1) {
 		pmd_t entry;
+
+		page_move_anon_rmap(page, vma);
 		entry = pmd_mkyoung(orig_pmd);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
diff --git a/mm/memory.c b/mm/memory.c
index 22e732c266dd..e12f75e8617c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3303,6 +3303,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		 * and the page is locked, it's dark out, and we're wearing
 		 * sunglasses. Hit it.
 		 */
+		page_move_anon_rmap(page, vma);
 		unlock_page(page);
 		wp_page_reuse(vmf);
 		return VM_FAULT_WRITE;
-- 
2.35.1

