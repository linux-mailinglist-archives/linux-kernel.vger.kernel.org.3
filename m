Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573B9512EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbiD1Ilg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbiD1Iku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B23462EB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651134903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKusX70JiuPlYzcamhxyk77YgVkoB/zECZIBimqek94=;
        b=I5bBZaqhhWdIzsjtphCrBjx/s7AHir8ytbp6jhJOnkmO2SkeiCQ96sMCF+wY66xDyeh3nL
        6U7DkVXJD6SLcIDLBgiQLjMTHAnA7FuCZa23cYlCWcAxU0SmdRmun+JJB8IvH2eX/cD34j
        Z/oeK/HpZ0WI+eH4J2ZOsQ+7VW+WC+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-fh7WDyYiMb-DxCtuxaHKhw-1; Thu, 28 Apr 2022 04:34:59 -0400
X-MC-Unique: fh7WDyYiMb-DxCtuxaHKhw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 639C3801005;
        Thu, 28 Apr 2022 08:34:58 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2576D55BA85;
        Thu, 28 Apr 2022 08:34:53 +0000 (UTC)
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
Subject: [PATCH v4 02/17] mm/hugetlb: take src_mm->write_protect_seq in copy_hugetlb_page_range()
Date:   Thu, 28 Apr 2022 10:34:26 +0200
Message-Id: <20220428083441.37290-3-david@redhat.com>
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

Let's do it just like copy_page_range(), taking the seqlock and making
sure the mmap_lock is held in write mode.

This allows for add a VM_BUG_ON to page_needs_cow_for_dma() and
properly synchronizes concurrent fork() with GUP-fast of hugetlb pages,
which will be relevant for further changes.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 4 ++++
 mm/hugetlb.c       | 8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f44254af8ce..c3c862a2e533 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1576,6 +1576,8 @@ static inline bool page_maybe_dma_pinned(struct page *page)
 /*
  * This should most likely only be called during fork() to see whether we
  * should break the cow immediately for a page on the src mm.
+ *
+ * The caller has to hold the PT lock and the vma->vm_mm->->write_protect_seq.
  */
 static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 					  struct page *page)
@@ -1583,6 +1585,8 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 	if (!is_cow_mapping(vma->vm_flags))
 		return false;
 
+	VM_BUG_ON(!(raw_read_seqcount(&vma->vm_mm->write_protect_seq) & 1));
+
 	if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
 		return false;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3fc721789743..670117bbc9b4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4717,6 +4717,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					vma->vm_start,
 					vma->vm_end);
 		mmu_notifier_invalidate_range_start(&range);
+		mmap_assert_write_locked(src);
+		raw_write_seqcount_begin(&src->write_protect_seq);
 	} else {
 		/*
 		 * For shared mappings i_mmap_rwsem must be held to call
@@ -4849,10 +4851,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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

