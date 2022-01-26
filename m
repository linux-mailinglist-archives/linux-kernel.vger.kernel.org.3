Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF56849C6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbiAZKAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:00:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233121AbiAZKAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643191249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZADr9hVxfhKENIr/VRsnRFwtDwaPlig2N4uKOY4hLWc=;
        b=Ao5saezab47NldOsG1OkzQ9dQzNbdlM4Y6LFfWGKE96ZuG39cuOCMS7UOMUrNg1OpKxzaS
        4+x+1Spn7ZRGBoj33XRDx3ASRE6K8e8PqZ6hrJUWwrrTxZb5GmSgzFVkeYq+XmVfmzQXdk
        waoUtxaunqLu1MnYta5oM0hRRlfyjcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-doMA_xzJMmKguE09hrMqCQ-1; Wed, 26 Jan 2022 05:00:45 -0500
X-MC-Unique: doMA_xzJMmKguE09hrMqCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B87486A060;
        Wed, 26 Jan 2022 10:00:42 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5324D1F2E8;
        Wed, 26 Jan 2022 10:00:01 +0000 (UTC)
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
Subject: [PATCH RFC v2 5/9] mm/huge_memory: streamline COW logic in do_huge_pmd_wp_page()
Date:   Wed, 26 Jan 2022 10:55:53 +0100
Message-Id: <20220126095557.32392-6-david@redhat.com>
In-Reply-To: <20220126095557.32392-1-david@redhat.com>
References: <20220126095557.32392-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have a different COW logic for anon THP than we have for
ordinary anon pages in do_wp_page(): the effect is that the issue reported
in CVE-2020-29374 is currently still possible for anon THP: an unintended
information leak from the parent to the child.

Let's apply the same logic (page_count() == 1), with similar
optimizations to remove additional references first as we really want to
avoid PTE-mapping the THP and copying individual pages best we can.

If we end up with a page that has page_count() != 1, we'll have to PTE-map
the THP and fallback to do_wp_page(), which will always copy the page.

Note that KSM does not apply to THP.

I. Interaction with the swapcache and writeback

While a THP is in the swapcache, the swapcache holds one reference on each
subpage of the THP. So with PageSwapCache() set, we expect as many
additional references as we have subpages. If we manage to remove the
THP from the swapcache, all these references will be gone.

Usually, a THP is not split when entered into the swapcache and stays a
compound page. However, try_to_unmap() will PTE-map the THP and use PTE
swap entries. There are no PMD swap entries for that purpose, consequently,
we always only swapin subpages into PTEs.

Removing a page from the swapcache can fail either when there are remaining
swap entries (in which case COW is the right thing to do) or if the page is
currently under writeback.

Having a locked, R/O PMD-mapped THP that is in the swapcache seems to be
possible only in corner cases, for example, if try_to_unmap() failed
after adding the page to the swapcache. However, it's comparatively easy to
handle.

As we have to fully unmap a THP before starting writeback, and swapin is
always done on the PTE level, we shouldn't find a R/O PMD-mapped THP in the
swapcache that is under writeback. This should at least leave writeback
out of the picture.

II. Interaction with GUP references

Having a R/O PMD-mapped THP with GUP references (i.e., R/O references)
will result in PTE-mapping the THP on a write fault. Similar to ordinary
anon pages, do_wp_page() will have to copy sub-pages and result in a
disconnect between the GUP references and the pages actually mapped into
the page tables. To improve the situation in the future, we'll need
additional handling to mark anonymous pages as definitely exclusive to a
single process, only allow GUP pins on exclusive anon pages, and
disallow sharing of exclusive anon pages with GUP pins e.g., during
fork().

III. Interaction with references from LRU pagevecs

Similar to ordinary anon pages, we can have LRU pagevecs referencing our
THP. Reliably removing such references requires draining LRU pagevecs on
all CPUs -- lru_add_drain_all() -- a possibly expensive operation that can
sleep. For now, similar do do_wp_page(), let's conditionally drain the
local LRU pagevecs only if we detect !PageLRU().

IV. Interaction with speculative/temporary references

Similar to ordinary anon pages, other speculative/temporary references on
the THP, for example, from the pagecache or page migration code, will
disallow exclusive reuse of the page. We'll have to PTE-map the THP.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 406a3c28c026..b6ba88a98266 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1286,6 +1286,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	pmd_t orig_pmd = vmf->orig_pmd;
+	int swapcache_refs = 0;
 
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
@@ -1303,7 +1304,6 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	page = pmd_page(orig_pmd);
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 
-	/* Lock page for reuse_swap_page() */
 	if (!trylock_page(page)) {
 		get_page(page);
 		spin_unlock(vmf->ptl);
@@ -1319,10 +1319,20 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	}
 
 	/*
-	 * We can only reuse the page if nobody else maps the huge page or it's
-	 * part.
+	 * See do_wp_page(): we can only map the page writable if there are
+	 * no additional references.
 	 */
-	if (reuse_swap_page(page)) {
+	if (PageSwapCache(page))
+		swapcache_refs = thp_nr_pages(page);
+	if (page_count(page) > 1 + swapcache_refs + !PageLRU(page))
+		goto unlock_fallback;
+	if (!PageLRU(page))
+		lru_add_drain();
+	if (page_count(page) > 1 + swapcache_refs)
+		goto unlock_fallback;
+	if (swapcache_refs)
+		try_to_free_swap(page);
+	if (page_count(page) == 1) {
 		pmd_t entry;
 		entry = pmd_mkyoung(orig_pmd);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
@@ -1333,6 +1343,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 		return VM_FAULT_WRITE;
 	}
 
+unlock_fallback:
 	unlock_page(page);
 	spin_unlock(vmf->ptl);
 fallback:
-- 
2.34.1

