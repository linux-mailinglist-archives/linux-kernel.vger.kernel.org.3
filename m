Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5D349C700
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiAZKBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:01:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233121AbiAZKBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643191271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KaiTUjRYTOXVgHeAUn6VE+wj9NpgU3CxyxXikV/W8rE=;
        b=UnSn/G1JB5WpDhxS1MoUOlOGP2wY/C+JGqT4xAvXs0yO8j72cejYU+mJjYLPi7Ffdd36fQ
        VkwWgBKf4tCdbWxCRavTK0fVbv0cXFMxBP2hy7suGs/X64zRRyEkpKSw5K7M9CJui6153j
        EcfeqSpjCR5vuG9FH9Y8ZofKZ8cF9hU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-uqqGwpPKPKy7Aa-6tyVRdw-1; Wed, 26 Jan 2022 05:00:59 -0500
X-MC-Unique: uqqGwpPKPKy7Aa-6tyVRdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB08D51090;
        Wed, 26 Jan 2022 10:00:56 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B4391F2F8;
        Wed, 26 Jan 2022 10:00:49 +0000 (UTC)
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
Subject: [PATCH RFC v2 7/9] mm/swapfile: remove reuse_swap_page()
Date:   Wed, 26 Jan 2022 10:55:55 +0100
Message-Id: <20220126095557.32392-8-david@redhat.com>
In-Reply-To: <20220126095557.32392-1-david@redhat.com>
References: <20220126095557.32392-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users are gone, let's remove it. We'll let SWP_STABLE_WRITES stick
around for now, as it might come in handy in the near future.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/swap.h |   4 --
 mm/swapfile.c        | 104 -------------------------------------------
 2 files changed, 108 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1d38d9475c4d..b546e4bd5c5a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -514,7 +514,6 @@ extern int __swp_swapcount(swp_entry_t entry);
 extern int swp_swapcount(swp_entry_t entry);
 extern struct swap_info_struct *page_swap_info(struct page *);
 extern struct swap_info_struct *swp_swap_info(swp_entry_t entry);
-extern bool reuse_swap_page(struct page *);
 extern int try_to_free_swap(struct page *);
 struct backing_dev_info;
 extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
@@ -680,9 +679,6 @@ static inline int swp_swapcount(swp_entry_t entry)
 	return 0;
 }
 
-#define reuse_swap_page(page) \
-	(page_trans_huge_mapcount(page) == 1)
-
 static inline int try_to_free_swap(struct page *page)
 {
 	return 0;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index bf0df7aa7158..a5183315dc58 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1167,16 +1167,6 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 	return NULL;
 }
 
-static struct swap_info_struct *swap_info_get(swp_entry_t entry)
-{
-	struct swap_info_struct *p;
-
-	p = _swap_info_get(entry);
-	if (p)
-		spin_lock(&p->lock);
-	return p;
-}
-
 static struct swap_info_struct *swap_info_get_cont(swp_entry_t entry,
 					struct swap_info_struct *q)
 {
@@ -1601,100 +1591,6 @@ static bool page_swapped(struct page *page)
 	return false;
 }
 
-static int page_trans_huge_map_swapcount(struct page *page,
-					 int *total_swapcount)
-{
-	int i, map_swapcount, _total_swapcount;
-	unsigned long offset = 0;
-	struct swap_info_struct *si;
-	struct swap_cluster_info *ci = NULL;
-	unsigned char *map = NULL;
-	int swapcount = 0;
-
-	/* hugetlbfs shouldn't call it */
-	VM_BUG_ON_PAGE(PageHuge(page), page);
-
-	if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!PageTransCompound(page))) {
-		if (PageSwapCache(page))
-			swapcount = page_swapcount(page);
-		if (total_swapcount)
-			*total_swapcount = swapcount;
-		return swapcount + page_trans_huge_mapcount(page);
-	}
-
-	page = compound_head(page);
-
-	_total_swapcount = map_swapcount = 0;
-	if (PageSwapCache(page)) {
-		swp_entry_t entry;
-
-		entry.val = page_private(page);
-		si = _swap_info_get(entry);
-		if (si) {
-			map = si->swap_map;
-			offset = swp_offset(entry);
-		}
-	}
-	if (map)
-		ci = lock_cluster(si, offset);
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
-		int mapcount = atomic_read(&page[i]._mapcount) + 1;
-		if (map) {
-			swapcount = swap_count(map[offset + i]);
-			_total_swapcount += swapcount;
-		}
-		map_swapcount = max(map_swapcount, mapcount + swapcount);
-	}
-	unlock_cluster(ci);
-
-	if (PageDoubleMap(page))
-		map_swapcount -= 1;
-
-	if (total_swapcount)
-		*total_swapcount = _total_swapcount;
-
-	return map_swapcount + compound_mapcount(page);
-}
-
-/*
- * We can write to an anon page without COW if there are no other references
- * to it.  And as a side-effect, free up its swap: because the old content
- * on disk will never be read, and seeking back there to write new content
- * later would only waste time away from clustering.
- */
-bool reuse_swap_page(struct page *page)
-{
-	int count, total_swapcount;
-
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	if (unlikely(PageKsm(page)))
-		return false;
-	count = page_trans_huge_map_swapcount(page, &total_swapcount);
-	if (count == 1 && PageSwapCache(page) &&
-	    (likely(!PageTransCompound(page)) ||
-	     /* The remaining swap count will be freed soon */
-	     total_swapcount == page_swapcount(page))) {
-		if (!PageWriteback(page)) {
-			page = compound_head(page);
-			delete_from_swap_cache(page);
-			SetPageDirty(page);
-		} else {
-			swp_entry_t entry;
-			struct swap_info_struct *p;
-
-			entry.val = page_private(page);
-			p = swap_info_get(entry);
-			if (p->flags & SWP_STABLE_WRITES) {
-				spin_unlock(&p->lock);
-				return false;
-			}
-			spin_unlock(&p->lock);
-		}
-	}
-
-	return count <= 1;
-}
-
 /*
  * If swap is getting full, or if there are no more mappings of this page,
  * then try_to_free_swap is called to free its swap space.
-- 
2.34.1

