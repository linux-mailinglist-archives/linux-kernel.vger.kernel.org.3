Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313DF49C701
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbiAZKBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233121AbiAZKBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643191273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtFF3IJUOAziUOkk7Dy8cWYxEVf/NaN8ObVsm7wL2Kc=;
        b=Wu3+V49BpiFo2g1/HJ2b9jY3yVuLp46afO2I6qb0jkvNXilQMBaKbbsSG5j4bNv0uJ4Djs
        aPFyO+rUBhR0G60JYedE5o4IbOrIhbit4xs7xaY+2eBApZfuZz6KRX3IhPqC4q7kPPi+Yv
        V+K/CC0sI8Kj0bY3sYlashv7Rvk1K8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-DT7c-FHEOW-IwDRh5--odA-1; Wed, 26 Jan 2022 05:01:07 -0500
X-MC-Unique: DT7c-FHEOW-IwDRh5--odA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F173190B2A0;
        Wed, 26 Jan 2022 10:01:04 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00BCCE2CF;
        Wed, 26 Jan 2022 10:00:56 +0000 (UTC)
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
Subject: [PATCH RFC v2 8/9] mm/huge_memory: remove stale page_trans_huge_mapcount()
Date:   Wed, 26 Jan 2022 10:55:56 +0100
Message-Id: <20220126095557.32392-9-david@redhat.com>
In-Reply-To: <20220126095557.32392-1-david@redhat.com>
References: <20220126095557.32392-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users are gone, let's remove it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  5 -----
 mm/huge_memory.c   | 48 ----------------------------------------------
 2 files changed, 53 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e1a84b1e6787..df6b34d66a9b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -820,16 +820,11 @@ static inline int page_mapcount(struct page *page)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int total_mapcount(struct page *page);
-int page_trans_huge_mapcount(struct page *page);
 #else
 static inline int total_mapcount(struct page *page)
 {
 	return page_mapcount(page);
 }
-static inline int page_trans_huge_mapcount(struct page *page)
-{
-	return page_mapcount(page);
-}
 #endif
 
 static inline struct page *virt_to_head_page(const void *x)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b6ba88a98266..863c933b3b1e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2529,54 +2529,6 @@ int total_mapcount(struct page *page)
 	return ret;
 }
 
-/*
- * This calculates accurately how many mappings a transparent hugepage
- * has (unlike page_mapcount() which isn't fully accurate). This full
- * accuracy is primarily needed to know if copy-on-write faults can
- * reuse the page and change the mapping to read-write instead of
- * copying them. At the same time this returns the total_mapcount too.
- *
- * The function returns the highest mapcount any one of the subpages
- * has. If the return value is one, even if different processes are
- * mapping different subpages of the transparent hugepage, they can
- * all reuse it, because each process is reusing a different subpage.
- *
- * The total_mapcount is instead counting all virtual mappings of the
- * subpages. If the total_mapcount is equal to "one", it tells the
- * caller all mappings belong to the same "mm" and in turn the
- * anon_vma of the transparent hugepage can become the vma->anon_vma
- * local one as no other process may be mapping any of the subpages.
- *
- * It would be more accurate to replace page_mapcount() with
- * page_trans_huge_mapcount(), however we only use
- * page_trans_huge_mapcount() in the copy-on-write faults where we
- * need full accuracy to avoid breaking page pinning, because
- * page_trans_huge_mapcount() is slower than page_mapcount().
- */
-int page_trans_huge_mapcount(struct page *page)
-{
-	int i, ret;
-
-	/* hugetlbfs shouldn't call it */
-	VM_BUG_ON_PAGE(PageHuge(page), page);
-
-	if (likely(!PageTransCompound(page)))
-		return atomic_read(&page->_mapcount) + 1;
-
-	page = compound_head(page);
-
-	ret = 0;
-	for (i = 0; i < thp_nr_pages(page); i++) {
-		int mapcount = atomic_read(&page[i]._mapcount) + 1;
-		ret = max(ret, mapcount);
-	}
-
-	if (PageDoubleMap(page))
-		ret -= 1;
-
-	return ret + compound_mapcount(page);
-}
-
 /* Racy check whether the huge page can be split */
 bool can_split_huge_page(struct page *page, int *pextra_pins)
 {
-- 
2.34.1

