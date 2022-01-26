Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3F849C702
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbiAZKBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:01:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239545AbiAZKBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643191276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDmpWapjP9Wkuqng2NIRJk/6UxFibcIxNF2eScAVq98=;
        b=MBHl5fsjl8hdT8EsqBKz9X0XDBVir4mTVYQbpAXp5u931yyyOVZQSVvgpqkWMC/DgZBwIh
        yvHpYbzBHHjFewFj62OqPyMzetTMNyy7XaM5fjz7VA1osg1tzlP+vG6W6XzaF9uoYKCtTo
        btTZ9mQUJq7UTtbnsqx+oChGs/aPS7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-Vz9PWdCbMzKfu4dycLa_hQ-1; Wed, 26 Jan 2022 05:01:13 -0500
X-MC-Unique: Vz9PWdCbMzKfu4dycLa_hQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A63A9190B2AE;
        Wed, 26 Jan 2022 10:01:10 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BF5D1F2F3;
        Wed, 26 Jan 2022 10:01:04 +0000 (UTC)
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
Subject: [PATCH RFC v2 9/9] mm/huge_memory: remove stale locking logic from __split_huge_pmd()
Date:   Wed, 26 Jan 2022 10:55:57 +0100
Message-Id: <20220126095557.32392-10-david@redhat.com>
In-Reply-To: <20220126095557.32392-1-david@redhat.com>
References: <20220126095557.32392-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's remove the stale logic that was required for reuse_swap_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 863c933b3b1e..5cc438f92548 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2158,8 +2158,6 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 {
 	spinlock_t *ptl;
 	struct mmu_notifier_range range;
-	bool do_unlock_page = false;
-	pmd_t _pmd;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address & HPAGE_PMD_MASK,
@@ -2178,35 +2176,9 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			goto out;
 	}
 
-repeat:
 	if (pmd_trans_huge(*pmd)) {
-		if (!page) {
+		if (!page)
 			page = pmd_page(*pmd);
-			/*
-			 * An anonymous page must be locked, to ensure that a
-			 * concurrent reuse_swap_page() sees stable mapcount;
-			 * but reuse_swap_page() is not used on shmem or file,
-			 * and page lock must not be taken when zap_pmd_range()
-			 * calls __split_huge_pmd() while i_mmap_lock is held.
-			 */
-			if (PageAnon(page)) {
-				if (unlikely(!trylock_page(page))) {
-					get_page(page);
-					_pmd = *pmd;
-					spin_unlock(ptl);
-					lock_page(page);
-					spin_lock(ptl);
-					if (unlikely(!pmd_same(*pmd, _pmd))) {
-						unlock_page(page);
-						put_page(page);
-						page = NULL;
-						goto repeat;
-					}
-					put_page(page);
-				}
-				do_unlock_page = true;
-			}
-		}
 		if (PageMlocked(page))
 			clear_page_mlock(page);
 	} else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
@@ -2214,8 +2186,6 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	__split_huge_pmd_locked(vma, pmd, range.start, freeze);
 out:
 	spin_unlock(ptl);
-	if (do_unlock_page)
-		unlock_page(page);
 	/*
 	 * No need to double call mmu_notifier->invalidate_range() callback.
 	 * They are 3 cases to consider inside __split_huge_pmd_locked():
-- 
2.34.1

