Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D044D1A41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347425AbiCHOTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347440AbiCHOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:19:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DCD04B853
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646749120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+BoGOzLvJ1HlaqjjZeHh2EKQh1sCLZoTb7n5ogh5fKY=;
        b=gVA7p3YUUL/oOlEPNiJlxQDh9YMWTiQLcCBcLUacuKAynz8Q9Rw16NcDYga1Gx5PB+dtyE
        xTUUcRAM2c+LbwtzjwiC6S19JxxbG27RxNwx85H+QkpBgTi6iHvH0RBes2VKg1lK5dN6sK
        w3d61l+afuhfLLrjShT8q4I9hAAqQBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-qZF5bE1KO-qX71k2fvApJw-1; Tue, 08 Mar 2022 09:18:37 -0500
X-MC-Unique: qZF5bE1KO-qX71k2fvApJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 313D91854E26;
        Tue,  8 Mar 2022 14:18:34 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0132E7886E;
        Tue,  8 Mar 2022 14:18:26 +0000 (UTC)
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
Subject: [PATCH v1 12/15] mm/gup: disallow follow_page(FOLL_PIN)
Date:   Tue,  8 Mar 2022 15:14:34 +0100
Message-Id: <20220308141437.144919-13-david@redhat.com>
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

We want to change the way we handle R/O pins on anonymous pages that
might be shared: if we detect a possibly shared anonymous page --
mapped R/O and not !PageAnonExclusive() -- we want to trigger unsharing
via a page fault, resulting in an exclusive anonymous page that can be
pinned reliably without getting replaced via COW on the next write
fault.

However, the required page fault will be problematic for follow_page():
in contrast to ordinary GUP, follow_page() doesn't trigger faults
internally. So we would have to end up failing a R/O pin via
follow_page(), although there is something mapped R/O into the page
table, which might be rather surprising.

We don't seem to have follow_page(FOLL_PIN) users, and it's a purely
internal MM function. Let's just make our life easier and the semantics of
follow_page() clearer by just disallowing FOLL_PIN for follow_page()
completely.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c     | 3 +++
 mm/hugetlb.c | 8 +++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a9d4d724aef7..7127e789d210 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -875,6 +875,9 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 	if (vma_is_secretmem(vma))
 		return NULL;
 
+	if (foll_flags & FOLL_PIN)
+		return NULL;
+
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
 	if (ctx.pgmap)
 		put_dev_pagemap(ctx.pgmap);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 195a1a5d8b20..e40d6b68e25a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6694,9 +6694,11 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 	spinlock_t *ptl;
 	pte_t pte;
 
-	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
-	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
-			 (FOLL_PIN | FOLL_GET)))
+	/*
+	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
+	 * follow_hugetlb_page().
+	 */
+	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
 retry:
-- 
2.35.1

