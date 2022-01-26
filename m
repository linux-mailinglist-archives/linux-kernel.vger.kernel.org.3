Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6750949C6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiAZKA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:00:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233121AbiAZKA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643191256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uz7WrEefhkRzVFGmcsfP6Zp/Ap9shXYEfGhZft5IAs0=;
        b=YqvlLzUfQHsqzFehari2wAbKLXh9PLhDQPwTNpJ6ZQTdMhYcVPBUiAy4ek+qYzE33mdBZJ
        PjjeXqtAhUjcp9Lsb0TT57ICNWxf7O0dg1wQhlERCx6LtZKzNvrFY4daqSVKk2hnhw38Wm
        DtaEoJf1OoCyuTvBKkvSP8WC7K9WHTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-Z5P5QTJXMmC-UmZSLEVHQg-1; Wed, 26 Jan 2022 05:00:52 -0500
X-MC-Unique: Z5P5QTJXMmC-UmZSLEVHQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 914831006AA6;
        Wed, 26 Jan 2022 10:00:49 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 199521F2F3;
        Wed, 26 Jan 2022 10:00:42 +0000 (UTC)
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
Subject: [PATCH RFC v2 6/9] mm/khugepaged: remove reuse_swap_page() usage
Date:   Wed, 26 Jan 2022 10:55:54 +0100
Message-Id: <20220126095557.32392-7-david@redhat.com>
In-Reply-To: <20220126095557.32392-1-david@redhat.com>
References: <20220126095557.32392-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reuse_swap_page() currently indicates if we can write to an anon page
without COW. A COW is required if the page is shared by multiple
processes (either already mapped or via swap entries) or if there is
concurrent writeback that cannot tolerate concurrent page modifications.

reuse_swap_page() doesn't check for pending references from other
processes that already unmapped the page, however,
is_refcount_suitable() essentially does the same thing in the context of
khugepaged. khugepaged is the last remaining user of reuse_swap_page() and
we want to remove that function.

In the context of khugepaged, we are not actually going to write to the
page and we don't really care about other processes mapping the page:
for example, without swap, we don't care about shared pages at all.

The current logic seems to be:
* Writable: -> Not shared, but might be in the swapcache. Nobody can
  fault it in from the swapcache as there are no other swap entries.
* Readable and not in the swapcache: Might be shared (but nobody can
  fault it in from the swapcache).
* Readable and in the swapcache: Might be shared and someone might be
  able to fault it in from the swapcache. Make sure we're the exclusive
  owner via reuse_swap_page().

Having to guess due to lack of comments and documentation, the current
logic really only wants to make sure that a page that might be shared
cannot be faulted in from the swapcache while khugepaged is active.
It's hard to guess why that is that case and if it's really still required,
but let's try keeping that logic unmodified.

Instead of relying on reuse_swap_page(), let's unconditionally
try_to_free_swap(), special casing PageKsm(). try_to_free_swap() will fail
if there are still swap entries targeting the page or if the page is under
writeback.

After a successful try_to_free_swap() that page cannot be readded to the
swapcache because we're keeping the page locked and removed from the LRU
until we actually perform the copy. So once we succeeded removing a page
from the swapcache, it cannot be re-added until we're done copying. Add a
comment stating that.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/khugepaged.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 35f14d0a00a6..bc0ff598e98f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -683,10 +683,10 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 		if (!pte_write(pteval) && PageSwapCache(page) &&
-				!reuse_swap_page(page)) {
+		    (PageKsm(page) || !try_to_free_swap(page))) {
 			/*
-			 * Page is in the swap cache and cannot be re-used.
-			 * It cannot be collapsed into a THP.
+			 * Possibly shared page cannot be removed from the
+			 * swapache. It cannot be collapsed into a THP.
 			 */
 			unlock_page(page);
 			result = SCAN_SWAP_CACHE_PAGE;
@@ -702,6 +702,16 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			result = SCAN_DEL_PAGE_LRU;
 			goto out;
 		}
+
+		/*
+		 * We're holding the page lock and removed the page from the
+		 * LRU. Once done copying, we'll unlock and readd to the
+		 * LRU via release_pte_page(). If the page is still in the
+		 * swapcache, we're the exclusive owner. Due to the page lock
+		 * the page cannot be added to the swapcache until we're done
+		 * and consequently it cannot be faulted in from the swapcache
+		 * into another process.
+		 */
 		mod_node_page_state(page_pgdat(page),
 				NR_ISOLATED_ANON + page_is_file_lru(page),
 				compound_nr(page));
-- 
2.34.1

