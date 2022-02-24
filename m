Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E864C2BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiBXM2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiBXM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:28:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22A70175860
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645705678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXAvt29aks092V89TFuSrIQhc1KpFNVRX0HPI0UZk40=;
        b=L7ZOEFCGhNmnwstDHcZSuV/62aOUVpzvyqT5iYfzbhGFvJ2SxehwiWClxiZUlEHtfwIfcI
        UBT0BHAUwJyLSctQmYjiKYdf9YbOVQpsh94VOH2rqC/BZZqJjkdVXQXj1fOI83qaVN1m7v
        LGFOG1CwH01pvg7QZVEJ2So6kwNheq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-PCUaTtRzMeag2gOqQMBV7w-1; Thu, 24 Feb 2022 07:27:55 -0500
X-MC-Unique: PCUaTtRzMeag2gOqQMBV7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E12221006AA6;
        Thu, 24 Feb 2022 12:27:51 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF4552634C;
        Thu, 24 Feb 2022 12:27:28 +0000 (UTC)
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
Subject: [PATCH RFC 02/13] mm/hugetlb: take src_mm->write_protect_seq in copy_hugetlb_page_range()
Date:   Thu, 24 Feb 2022 13:26:03 +0100
Message-Id: <20220224122614.94921-3-david@redhat.com>
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

Let's do it just like copy_page_range(), taking the seqlock and making
sure the mmap_lock is held in write mode.

This allows for add a VM_BUG_ON to page_needs_cow_for_dma() and
properly synchronizes cocnurrent fork() with GUP-fast of hugetlb pages,
which will be relevant for further changes.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 4 ++++
 mm/hugetlb.c       | 8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a12291cfe5dd..b29cb8bacd59 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1323,6 +1323,8 @@ static inline bool is_cow_mapping(vm_flags_t flags)
 /*
  * This should most likely only be called during fork() to see whether we
  * should break the cow immediately for a page on the src mm.
+ *
+ * The caller has to hold the PT lock and the vma->vm_mm->->write_protect_seq.
  */
 static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 					  struct page *page)
@@ -1330,6 +1332,8 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 	if (!is_cow_mapping(vma->vm_flags))
 		return false;
 
+	VM_BUG_ON(!(raw_read_seqcount(&vma->vm_mm->write_protect_seq) & 1));
+
 	if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
 		return false;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 61895cc01d09..e2e2d0f3f259 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4710,6 +4710,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					vma->vm_start,
 					vma->vm_end);
 		mmu_notifier_invalidate_range_start(&range);
+		mmap_assert_write_locked(src);
+		raw_write_seqcount_begin(&src->write_protect_seq);
 	} else {
 		/*
 		 * For shared mappings i_mmap_rwsem must be held to call
@@ -4842,10 +4844,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		spin_unlock(dst_ptl);
 	}
 
-	if (cow)
+	if (cow) {
+		raw_write_seqcount_end(&src->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
-	else
+	} else {
 		i_mmap_unlock_read(mapping);
+	}
 
 	return ret;
 }
-- 
2.35.1

