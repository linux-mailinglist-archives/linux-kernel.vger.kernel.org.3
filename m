Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B5B4A4C31
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350112AbiAaQdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:33:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380491AbiAaQdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643646796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybmiamaJyQbtkZkDBfGYUzoim24eO3SbNNrD1ZW6zsM=;
        b=HufdRVIMeyoxVgGXGRLJKg02MSsor6adzUdYnC5cYLgtYg9bMoj99k0Sx02ev68joA/+pW
        pru3qWwxsuZTozxkTDLgP8YHDeMCCdixPKetmsL4JcoiFx56AR6LTKYo+flyaQNHxIYRd0
        OPurkKwydnGZj+u1OO5oL43v1Qb9RGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-edoI-CQNOSet1yuZVdhQBA-1; Mon, 31 Jan 2022 11:33:12 -0500
X-MC-Unique: edoI-CQNOSet1yuZVdhQBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E80A7760C1;
        Mon, 31 Jan 2022 16:33:08 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30980798C6;
        Mon, 31 Jan 2022 16:33:03 +0000 (UTC)
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
Subject: [PATCH v3 5/9] mm/huge_memory: streamline COW logic in do_huge_pmd_wp_page()
Date:   Mon, 31 Jan 2022 17:29:35 +0100
Message-Id: <20220131162940.210846-6-david@redhat.com>
In-Reply-To: <20220131162940.210846-1-david@redhat.com>
References: <20220131162940.210846-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

There is no need to try draining the (local) LRU pagevecs in case we would
stumble over a !PageLRU() page: folio_add_lru() and friends will always
flush the affected pagevec after adding a compound page to it
immediately -- pagevec_add_and_need_flush() always returns "true" for them.
Note that the LRU pagevecs will hold a reference on the compound page for
a very short time, between adding the page to the pagevec and draining it
immediately afterwards.

IV. Interaction with speculative/temporary references

Similar to ordinary anon pages, other speculative/temporary references on
the THP, for example, from the pagecache or page migration code, will
disallow exclusive reuse of the page. We'll have to PTE-map the THP.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 406a3c28c026..f34ebc5cb827 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1303,7 +1303,6 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	page = pmd_page(orig_pmd);
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 
-	/* Lock page for reuse_swap_page() */
 	if (!trylock_page(page)) {
 		get_page(page);
 		spin_unlock(vmf->ptl);
@@ -1319,10 +1318,15 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	}
 
 	/*
-	 * We can only reuse the page if nobody else maps the huge page or it's
-	 * part.
+	 * See do_wp_page(): we can only map the page writable if there are
+	 * no additional references. Note that we always drain the LRU
+	 * pagevecs immediately after adding a THP.
 	 */
-	if (reuse_swap_page(page)) {
+	if (page_count(page) > 1 + PageSwapCache(page) * thp_nr_pages(page))
+		goto unlock_fallback;
+	if (PageSwapCache(page))
+		try_to_free_swap(page);
+	if (page_count(page) == 1) {
 		pmd_t entry;
 		entry = pmd_mkyoung(orig_pmd);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
@@ -1333,6 +1337,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 		return VM_FAULT_WRITE;
 	}
 
+unlock_fallback:
 	unlock_page(page);
 	spin_unlock(vmf->ptl);
 fallback:
-- 
2.34.1

