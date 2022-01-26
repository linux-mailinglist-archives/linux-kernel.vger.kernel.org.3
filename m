Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423DC49C6F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiAZKAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:00:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239497AbiAZKAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643191205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8lZCUoGF7vMZxd2uBv8vuAjoIcLxZX5AOgXwi6hd1oU=;
        b=GMm8vbJC0EmQPTqdRU4trHaxAYPXV2x+8ToJFMVIm7QnmPEbdDga321YDc7g/2q6VEXskT
        /eAl8P6BE+slS/o5FYXhFjcAsZC82HKeuJEazjV5JFb14DxJiYj3DIoAWe81c2HtRQcfSf
        vqn6d8Qz35diB0CkUVk8Xoh8R5a/Cxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-LrhBAHJkN12DwCXYCzWIZA-1; Wed, 26 Jan 2022 05:00:03 -0500
X-MC-Unique: LrhBAHJkN12DwCXYCzWIZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B88B286A061;
        Wed, 26 Jan 2022 10:00:00 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E0E31F2E8;
        Wed, 26 Jan 2022 09:59:03 +0000 (UTC)
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
Subject: [PATCH RFC v2 4/9] mm: streamline COW logic in do_swap_page()
Date:   Wed, 26 Jan 2022 10:55:52 +0100
Message-Id: <20220126095557.32392-5-david@redhat.com>
In-Reply-To: <20220126095557.32392-1-david@redhat.com>
References: <20220126095557.32392-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have a different COW logic when:
* triggering a read-fault to swapin first and then trigger a write-fault
  -> do_swap_page() + do_wp_page()
* triggering a write-fault to swapin
  -> do_swap_page() + do_wp_page() only if we fail reuse in do_swap_page()

The COW logic in do_swap_page() is different than our reuse logic in
do_wp_page(). The COW logic in do_wp_page() -- page_count() == 1 --  makes
currently sure that we certainly don't have a remaining reference, e.g.,
via GUP, on the target page we want to reuse: if there is any unexpected
reference, we have to copy to avoid information leaks.

As do_swap_page() behaves differently, in environments with swap enabled we
can currently have an unintended information leak from the parent to the
child, similar as known from CVE-2020-29374:

	1. Parent writes to anonymous page
	-> Page is mapped writable and modified
	2. Page is swapped out
	-> Page is unmapped and replaced by swap entry
	3. fork()
	-> Swap entries are copied to child
	4. Child pins page R/O
	-> Page is mapped R/O into child
	5. Child unmaps page
	-> Child still holds GUP reference
	6. Parent writes to page
	-> Page is reused in do_swap_page()
	-> Child can observe changes

Exchanging 2. and 3. should have the same effect.

Let's apply the same COW logic as in do_wp_page(), conditionally trying to
remove the page from the swapcache after freeing the swap entry, however,
before actually mapping our page. We can change the order now that
we use try_to_free_swap(), which doesn't care about the mapcount,
instead of reuse_swap_page().

To handle references from the LRU pagevecs, conditionally drain the local
LRU pagevecs when required, however, don't consider the page_count() when
deciding whether to drain to keep it simple for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 55 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ab3153252cfe..ba23d13b8410 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3499,6 +3499,25 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	return 0;
 }
 
+static inline bool should_try_to_free_swap(struct page *page,
+					   struct vm_area_struct *vma,
+					   unsigned int fault_flags)
+{
+	if (!PageSwapCache(page))
+		return false;
+	if (mem_cgroup_swap_full(page) || (vma->vm_flags & VM_LOCKED) ||
+	    PageMlocked(page))
+		return true;
+	/*
+	 * If we want to map a page that's in the swapcache writable, we
+	 * have to detect via the refcount if we're really the exclusive
+	 * owner. Try freeing the swapcache to get rid of the swapcache
+	 * reference in case it's likely that we will succeed.
+	 */
+	return (fault_flags & FAULT_FLAG_WRITE) && !PageKsm(page) &&
+		page_count(page) == 2;
+}
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -3640,6 +3659,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			page = swapcache;
 			goto out_page;
 		}
+
+		/*
+		 * If we want to map a page that's in the swapcache writable, we
+		 * have to detect via the refcount if we're really the exclusive
+		 * owner. Try removing the extra reference from the local LRU
+		 * pagevecs if required.
+		 */
+		if ((vmf->flags & FAULT_FLAG_WRITE) && page == swapcache &&
+		    !PageKsm(page) && !PageLRU(page))
+			lru_add_drain();
 	}
 
 	cgroup_throttle_swaprate(page, GFP_KERNEL);
@@ -3658,19 +3687,25 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	/*
-	 * The page isn't present yet, go ahead with the fault.
-	 *
-	 * Be careful about the sequence of operations here.
-	 * To get its accounting right, reuse_swap_page() must be called
-	 * while the page is counted on swap but not yet in mapcount i.e.
-	 * before page_add_anon_rmap() and swap_free(); try_to_free_swap()
-	 * must be called after the swap_free(), or it will never succeed.
+	 * Remove the swap entry and conditionally try to free up the swapcache.
+	 * We're already holding a reference on the page but haven't mapped it
+	 * yet.
 	 */
+	swap_free(entry);
+	if (should_try_to_free_swap(page, vma, vmf->flags))
+		try_to_free_swap(page);
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
 	pte = mk_pte(page, vma->vm_page_prot);
-	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page)) {
+
+	/*
+	 * Same logic as in do_wp_page(); however, optimize for fresh pages
+	 * that are certainly not shared because we just allocated them without
+	 * exposing them to the swapcache.
+	 */
+	if ((vmf->flags & FAULT_FLAG_WRITE) && !PageKsm(page) &&
+	    (page != swapcache || page_count(page) == 1)) {
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 		vmf->flags &= ~FAULT_FLAG_WRITE;
 		ret |= VM_FAULT_WRITE;
@@ -3696,10 +3731,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
 	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
 
-	swap_free(entry);
-	if (mem_cgroup_swap_full(page) ||
-	    (vma->vm_flags & VM_LOCKED) || PageMlocked(page))
-		try_to_free_swap(page);
 	unlock_page(page);
 	if (page != swapcache && swapcache) {
 		/*
-- 
2.34.1

