Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EE258A9DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbiHELDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbiHELDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4EF95A3D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 04:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659697423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLjCECz6VCL5yJ/vjQ3f/7/4x1egiz/aYuOOspPcH4c=;
        b=MYWbVDANpiFq0AKbl7eICjR7SELpeQqSbfKqrMlD83Ub6FBXC4NLq7XzKKYMQa4AN8rm2A
        BBB257a2n0NyVzE0yyBOZsw7K3GWpFNFleqmTVKjbyYcOwZ8rUEayF/C1NoXi2yp2H4vOC
        4e9e+vjvsXS5R2vYUAM3rMSygEsoOtU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-VrrMrNp0MKWXRwx1PZRvKA-1; Fri, 05 Aug 2022 07:03:38 -0400
X-MC-Unique: VrrMrNp0MKWXRwx1PZRvKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76FAB101A54E;
        Fri,  5 Aug 2022 11:03:38 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 965A540C1288;
        Fri,  5 Aug 2022 11:03:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v1 2/2] mm/hugetlb: support write-faults in shared mappings
Date:   Fri,  5 Aug 2022 13:03:29 +0200
Message-Id: <20220805110329.80540-3-david@redhat.com>
In-Reply-To: <20220805110329.80540-1-david@redhat.com>
References: <20220805110329.80540-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add a safety net if we ever get (again) a write-fault on a R/O-mapped
page in a shared mapping, in which case we simply have to map the
page writable.

VM_MAYSHARE handling in hugetlb_fault() for FAULT_FLAG_WRITE
indicates that this was at least envisioned, but could never have worked
as expected. This theoretically paves the way for softdirty tracking
support in hugetlb.

Tested without the fix for softdirty tracking.

Note that there is no need to do any kind of reservation in hugetlb_fault()
in this case ... because we already have a hugetlb page mapped R/O
that we will simply map writable and we are not dealing with COW/unsharing.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a18c071c294e..bbab7aa9d8f8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5233,6 +5233,16 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	VM_BUG_ON(unshare && (flags & FOLL_WRITE));
 	VM_BUG_ON(!unshare && !(flags & FOLL_WRITE));
 
+	/* Let's take out shared mappings first, this should be a rare event. */
+	if (unlikely(vma->vm_flags & VM_MAYSHARE)) {
+		if (unshare)
+			return 0;
+		if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
+			return VM_FAULT_SIGSEGV;
+		set_huge_ptep_writable(vma, haddr, ptep);
+		return 0;
+	}
+
 	pte = huge_ptep_get(ptep);
 	old_page = pte_page(pte);
 
@@ -5767,12 +5777,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * If we are going to COW/unshare the mapping later, we examine the
 	 * pending reservations for this page now. This will ensure that any
 	 * allocations necessary to record that reservation occur outside the
-	 * spinlock. For private mappings, we also lookup the pagecache
-	 * page now as it is used to determine if a reservation has been
-	 * consumed.
+	 * spinlock. Also lookup the pagecache page now as it is used to
+	 * determine if a reservation has been consumed.
 	 */
 	if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
-	    !huge_pte_write(entry)) {
+	    !(vma->vm_flags & VM_MAYSHARE) && !huge_pte_write(entry)) {
 		if (vma_needs_reservation(h, vma, haddr) < 0) {
 			ret = VM_FAULT_OOM;
 			goto out_mutex;
@@ -5780,9 +5789,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		if (!(vma->vm_flags & VM_MAYSHARE))
-			pagecache_page = hugetlbfs_pagecache_page(h,
-								vma, haddr);
+		pagecache_page = hugetlbfs_pagecache_page(h, vma, haddr);
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
-- 
2.35.3

