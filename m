Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C164A4C32
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380488AbiAaQd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:33:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50339 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350073AbiAaQdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643646801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJs7IHJWJFW3BFUXsLfDUvtzfhZ2GWsqY1Ai0k1O2Gw=;
        b=SdKlk7xd9oEMAQWaqeq5omyhqsfVosuCSVkjYD47Yt04WooGMj6YpUK4g+nVZTxu//xvqd
        A0YiHKIB5szrOoT5pC43Jlr+HifAV9g6MU0kVhF6atgKsh9Jb91boqH+y/7uXzH0gC+yOO
        GY//SiiqBMVuGkmELKLiXOy61jcWA54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-D365DQlVNt-QUhpVEQfznQ-1; Mon, 31 Jan 2022 11:33:17 -0500
X-MC-Unique: D365DQlVNt-QUhpVEQfznQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DE75760C1;
        Mon, 31 Jan 2022 16:33:15 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 720FD798CD;
        Mon, 31 Jan 2022 16:33:09 +0000 (UTC)
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
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 6/9] mm/khugepaged: remove reuse_swap_page() usage
Date:   Mon, 31 Jan 2022 17:29:36 +0100
Message-Id: <20220131162940.210846-7-david@redhat.com>
In-Reply-To: <20220131162940.210846-1-david@redhat.com>
References: <20220131162940.210846-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reuse_swap_page() currently indicates if we can write to an anon page
without COW. A COW is required if the page is shared by multiple
processes (either already mapped or via swap entries) or if there is
concurrent writeback that cannot tolerate concurrent page modifications.

However, in the context of khugepaged we're not actually going to write
to a read-only mapped page, we'll copy the page content to our newly
allocated THP and map that THP writable. All we have to make sure
is that the read-only mapped page we're about to copy won't get reused
by another process sharing the page, otherwise, page content would
get modified. But that is already guaranteed via multiple mechanisms
(e.g., holding a reference, holding the page lock, removing the rmap after
 copying the page).

The swapcache handling was introduced in commit 10359213d05a ("mm:
incorporate read-only pages into transparent huge pages") and it sounds
like it merely wanted to mimic what do_swap_page() would do when trying
to map a page obtained via the swapcache writable.

As that logic is unnecessary, let's just remove it, removing the last
user of reuse_swap_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/trace/events/huge_memory.h |  1 -
 mm/khugepaged.c                    | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 4fdb14a81108..d651f3437367 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -29,7 +29,6 @@
 	EM( SCAN_VMA_NULL,		"vma_null")			\
 	EM( SCAN_VMA_CHECK,		"vma_check_failed")		\
 	EM( SCAN_ADDRESS_RANGE,		"not_suitable_address_range")	\
-	EM( SCAN_SWAP_CACHE_PAGE,	"page_swap_cache")		\
 	EM( SCAN_DEL_PAGE_LRU,		"could_not_delete_page_from_lru")\
 	EM( SCAN_ALLOC_HUGE_PAGE_FAIL,	"alloc_huge_page_failed")	\
 	EM( SCAN_CGROUP_CHARGE_FAIL,	"ccgroup_charge_failed")	\
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 35f14d0a00a6..9da9325ab4d4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -45,7 +45,6 @@ enum scan_result {
 	SCAN_VMA_NULL,
 	SCAN_VMA_CHECK,
 	SCAN_ADDRESS_RANGE,
-	SCAN_SWAP_CACHE_PAGE,
 	SCAN_DEL_PAGE_LRU,
 	SCAN_ALLOC_HUGE_PAGE_FAIL,
 	SCAN_CGROUP_CHARGE_FAIL,
@@ -682,16 +681,6 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			result = SCAN_PAGE_COUNT;
 			goto out;
 		}
-		if (!pte_write(pteval) && PageSwapCache(page) &&
-				!reuse_swap_page(page)) {
-			/*
-			 * Page is in the swap cache and cannot be re-used.
-			 * It cannot be collapsed into a THP.
-			 */
-			unlock_page(page);
-			result = SCAN_SWAP_CACHE_PAGE;
-			goto out;
-		}
 
 		/*
 		 * Isolate the page to avoid collapsing an hugepage
-- 
2.34.1

