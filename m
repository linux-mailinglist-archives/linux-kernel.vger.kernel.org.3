Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02FC4A4C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380035AbiAaQdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:33:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350031AbiAaQc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643646775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7b7no2C9n9H1mR1Q0vPK2/0w0SD0s3OdOkqIUCgpsak=;
        b=Gh226oGe1qi8z2kb4BTne92WKEH/CUH1ldUabG3y2w9oOQjWvSTSs7WdeWeVCC7hVWvZXc
        DKopWtl9oRVVunDRrPBO4dVaVhPW8MF5M8pTDIOmEqJ7Ol4NpzS26QS47cCs5m2DIJ1YGd
        TUCNwAww8112M8/3K4uIK1PUHxJvkAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-VZ4YW5wkPhipVS5zqZLLaA-1; Mon, 31 Jan 2022 11:32:53 -0500
X-MC-Unique: VZ4YW5wkPhipVS5zqZLLaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD08A869ECA;
        Mon, 31 Jan 2022 16:32:49 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 176C2798CF;
        Mon, 31 Jan 2022 16:32:11 +0000 (UTC)
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
Subject: [PATCH v3 2/9] mm: optimize do_wp_page() for fresh pages in local LRU pagevecs
Date:   Mon, 31 Jan 2022 17:29:32 +0100
Message-Id: <20220131162940.210846-3-david@redhat.com>
In-Reply-To: <20220131162940.210846-1-david@redhat.com>
References: <20220131162940.210846-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For example, if a page just got swapped in via a read fault, the LRU
pagevecs might still hold a reference to the page. If we trigger a
write fault on such a page, the additional reference from the LRU
pagevecs will prohibit reusing the page.

Let's conditionally drain the local LRU pagevecs when we stumble over a
!PageLRU() page. We cannot easily drain remote LRU pagevecs and it might
not be desirable performance-wise. Consequently, this will only avoid
copying in some cases.

Add a simple "page_count(page) > 3" check first but keep the
"page_count(page) > 1 + PageSwapCache(page)" check in place, as
we want to minimize cases where we remove a page from the swapcache but
won't be able to reuse it, for example, because another process has it
mapped R/O, to not affect reclaim.

We cannot easily handle the following cases and we will always have to
copy:

(1) The page is referenced in the LRU pagevecs of other CPUs. We really
    would have to drain the LRU pagevecs of all CPUs -- most probably
    copying is much cheaper.

(2) The page is already PageLRU() but is getting moved between LRU
    lists, for example, for activation (e.g., mark_page_accessed()),
    deactivation (MADV_COLD), or lazyfree (MADV_FREE). We'd have to
    drain mostly unconditionally, which might be bad performance-wise.
    Most probably this won't happen too often in practice.

Note that there are other reasons why an anon page might temporarily not
be PageLRU(): for example, compaction and migration have to isolate LRU
pages from the LRU lists first (isolate_lru_page()), moving them to
temporary local lists and clearing PageLRU() and holding an additional
reference on the page. In that case, we'll always copy.

This change seems to be fairly effective with the reproducer [1] shared
by Nadav, as long as writeback is done synchronously, for example, using
zram. However, with asynchronous writeback, we'll usually fail to free the
swapcache because the page is still under writeback: something we cannot
easily optimize for, and maybe it's not really relevant in practice.

[1] https://lkml.kernel.org/r/0480D692-D9B2-429A-9A88-9BBA1331AC3A@gmail.com

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index bcd3b7c50891..923165b4c27e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3298,7 +3298,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		 *
 		 * PageKsm() doesn't necessarily raise the page refcount.
 		 */
-		if (PageKsm(page) || page_count(page) > 1 + PageSwapCache(page))
+		if (PageKsm(page) || page_count(page) > 3)
+			goto copy;
+		if (!PageLRU(page))
+			/*
+			 * Note: We cannot easily detect+handle references from
+			 * remote LRU pagevecs or references to PageLRU() pages.
+			 */
+			lru_add_drain();
+		if (page_count(page) > 1 + PageSwapCache(page))
 			goto copy;
 		if (!trylock_page(page))
 			goto copy;
-- 
2.34.1

