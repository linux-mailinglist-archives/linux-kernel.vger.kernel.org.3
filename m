Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF91949C6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbiAZJ5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:57:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239492AbiAZJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643191065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAAIIFATEqd80W11R9L9MXwM4GCrPUNUZiPXyoAGr5M=;
        b=jMKqRpRmJE0M0ohH7TnybmXwLZcmtoGC/wCpoIK4wczvUXFsRXTbz4VMUTuuDLM7XzIyAd
        S2b4ZmR+J/1MhypSmVKL8nLjes0JMciMmc1uj9VYsgqz9cbS1WyUHiv+XHxL7dmNac1mcw
        C+2D06Ki61gO3jPv+2+hG4wBCsUtFA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-B2JjIRltNDiDbXZcfa4JDQ-1; Wed, 26 Jan 2022 04:57:42 -0500
X-MC-Unique: B2JjIRltNDiDbXZcfa4JDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5DE2100C62A;
        Wed, 26 Jan 2022 09:57:39 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3BA21F2FB;
        Wed, 26 Jan 2022 09:56:57 +0000 (UTC)
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
        Liang Zhang <zhangliang5@huawei.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH RFC v2 1/9] mm: optimize do_wp_page() for exclusive pages in the swapcache
Date:   Wed, 26 Jan 2022 10:55:49 +0100
Message-Id: <20220126095557.32392-2-david@redhat.com>
In-Reply-To: <20220126095557.32392-1-david@redhat.com>
References: <20220126095557.32392-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liang Zhang reported [1] that the current COW logic in do_wp_page() is
sub-optimal when it comes to swap+read fault+write fault of anonymous
pages that have a single user, visible via a performance degradation in
the redis benchmark. Something similar was previously reported [2] by
Nadav with a simple reproducer.

Let's optimize for pages that have been added to the swapcache but only
have an exclusive owner. Try removing the swapcache reference if there is
hope that we're the exclusive user.

We will fail removing the swapcache reference in two scenarios:
(1) There are additional swap entries referencing the page: copying
    instead of reusing is the right thing to do.
(2) The page is under writeback: theoretically we might be able to reuse
    in some cases, however, we cannot remove the additional reference
    and will have to copy.

Further, we might have additional references from the LRU pagevecs,
which will force us to copy instead of being able to reuse. We'll try
handling such references for some scenarios next. Concurrent writeback
cannot be handled easily and we'll always have to copy.

While at it, remove the superfluous page_mapcount() check: it's
implicitly covered by the page_count() for ordinary anon pages.

[1] https://lkml.kernel.org/r/20220113140318.11117-1-zhangliang5@huawei.com
[2] https://lkml.kernel.org/r/0480D692-D9B2-429A-9A88-9BBA1331AC3A@gmail.com

Reported-by: Liang Zhang <zhangliang5@huawei.com>
Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..bcd3b7c50891 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3291,19 +3291,27 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	if (PageAnon(vmf->page)) {
 		struct page *page = vmf->page;
 
-		/* PageKsm() doesn't necessarily raise the page refcount */
-		if (PageKsm(page) || page_count(page) != 1)
+		/*
+		 * We have to verify under page lock: these early checks are
+		 * just an optimization to avoid locking the page and freeing
+		 * the swapcache if there is little hope that we can reuse.
+		 *
+		 * PageKsm() doesn't necessarily raise the page refcount.
+		 */
+		if (PageKsm(page) || page_count(page) > 1 + PageSwapCache(page))
 			goto copy;
 		if (!trylock_page(page))
 			goto copy;
-		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
+		if (PageSwapCache(page))
+			try_to_free_swap(page);
+		if (PageKsm(page) || page_count(page) != 1) {
 			unlock_page(page);
 			goto copy;
 		}
 		/*
-		 * Ok, we've got the only map reference, and the only
-		 * page count reference, and the page is locked,
-		 * it's dark out, and we're wearing sunglasses. Hit it.
+		 * Ok, we've got the only page reference from our mapping
+		 * and the page is locked, it's dark out, and we're wearing
+		 * sunglasses. Hit it.
 		 */
 		unlock_page(page);
 		wp_page_reuse(vmf);
-- 
2.34.1

