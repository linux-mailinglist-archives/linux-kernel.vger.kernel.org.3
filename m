Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11723512EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344713AbiD1Imx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344305AbiD1Ilt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFA5D366B4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651134995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIvoNwFsgnLDv8ForvNvi/2NrWA9Bt7wLjc4srMLAbI=;
        b=CUM4Qr2GcIQyf0EUr1Ymka+1gPzROg+H+2AJhnTIftF4xvzFwvUrfIgDbK3E9/WNEHGyPk
        blg6+Z24Cf9bN/s9bBAq5l77O7qYseVjVB3hpkLqf9rWxijLsSRaL+GRbcRPkkxNiEbBF4
        yGfujFFvJ7bibN3eOt8rimihuyIzo7U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-t0I35uw0MPm7ij8sn47SaA-1; Thu, 28 Apr 2022 04:36:32 -0400
X-MC-Unique: t0I35uw0MPm7ij8sn47SaA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3941C8E91EF;
        Thu, 28 Apr 2022 08:36:31 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3429566A32;
        Thu, 28 Apr 2022 08:36:25 +0000 (UTC)
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
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 17/17] mm/gup: sanity-check with CONFIG_DEBUG_VM that anonymous pages are exclusive when (un)pinning
Date:   Thu, 28 Apr 2022 10:34:41 +0200
Message-Id: <20220428083441.37290-18-david@redhat.com>
In-Reply-To: <20220428083441.37290-1-david@redhat.com>
References: <20220428083441.37290-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's verify when (un)pinning anonymous pages that we always deal with
exclusive anonymous pages, which guarantees that we'll have a reliable
PIN, meaning that we cannot end up with the GUP pin being inconsistent
with he pages mapped into the page tables due to a COW triggered
by a write fault.

When pinning pages, after conditionally triggering GUP unsharing of
possibly shared anonymous pages, we should always only see exclusive
anonymous pages. Note that anonymous pages that are mapped writable
must be marked exclusive, otherwise we'd have a BUG.

When pinning during ordinary GUP, simply add a check after our
conditional GUP-triggered unsharing checks. As we know exactly how the
page is mapped, we know exactly in which page we have to check for
PageAnonExclusive().

When pinning via GUP-fast we have to be careful, because we can race with
fork(): verify only after we made sure via the seqcount that we didn't
race with concurrent fork() that we didn't end up pinning a possibly
shared anonymous page.

Similarly, when unpinning, verify that the pages are still marked as
exclusive: otherwise something turned the pages possibly shared, which
can result in random memory corruptions, which we really want to catch.

With only the pinned pages at hand and not the actual page table entries
we have to be a bit careful: hugetlb pages are always mapped via a
single logical page table entry referencing the head page and
PG_anon_exclusive of the head page applies. Anon THP are a bit more
complicated, because we might have obtained the page reference either via
a PMD or a PTE -- depending on the mapping type we either have to check
PageAnonExclusive of the head page (PMD-mapped THP) or the tail page
(PTE-mapped THP) applies: as we don't know and to make our life easier,
check that either is set.

Take care to not verify in case we're unpinning during GUP-fast because
we detected concurrent fork(): we might stumble over an anonymous page
that is now shared.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c         | 61 +++++++++++++++++++++++++++++++++++++++++++++++-
 mm/huge_memory.c |  3 +++
 mm/hugetlb.c     |  3 +++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 4d089d467e58..46ffd8c51c6e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -29,6 +29,39 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
 
+static inline void sanity_check_pinned_pages(struct page **pages,
+					     unsigned long npages)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_VM))
+		return;
+
+	/*
+	 * We only pin anonymous pages if they are exclusive. Once pinned, we
+	 * can no longer turn them possibly shared and PageAnonExclusive() will
+	 * stick around until the page is freed.
+	 *
+	 * We'd like to verify that our pinned anonymous pages are still mapped
+	 * exclusively. The issue with anon THP is that we don't know how
+	 * they are/were mapped when pinning them. However, for anon
+	 * THP we can assume that either the given page (PTE-mapped THP) or
+	 * the head page (PMD-mapped THP) should be PageAnonExclusive(). If
+	 * neither is the case, there is certainly something wrong.
+	 */
+	for (; npages; npages--, pages++) {
+		struct page *page = *pages;
+		struct folio *folio = page_folio(page);
+
+		if (!folio_test_anon(folio))
+			continue;
+		if (!folio_test_large(folio) || folio_test_hugetlb(folio))
+			VM_BUG_ON_PAGE(!PageAnonExclusive(&folio->page), page);
+		else
+			/* Either a PTE-mapped or a PMD-mapped THP. */
+			VM_BUG_ON_PAGE(!PageAnonExclusive(&folio->page) &&
+				       !PageAnonExclusive(page), page);
+	}
+}
+
 /*
  * Return the folio with ref appropriately incremented,
  * or NULL if that failed.
@@ -204,6 +237,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
  */
 void unpin_user_page(struct page *page)
 {
+	sanity_check_pinned_pages(&page, 1);
 	gup_put_folio(page_folio(page), 1, FOLL_PIN);
 }
 EXPORT_SYMBOL(unpin_user_page);
@@ -272,6 +306,7 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 		return;
 	}
 
+	sanity_check_pinned_pages(pages, npages);
 	for (i = 0; i < npages; i += nr) {
 		folio = gup_folio_next(pages, npages, i, &nr);
 		/*
@@ -344,6 +379,23 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 }
 EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);
 
+static void unpin_user_pages_lockless(struct page **pages, unsigned long npages)
+{
+	unsigned long i;
+	struct folio *folio;
+	unsigned int nr;
+
+	/*
+	 * Don't perform any sanity checks because we might have raced with
+	 * fork() and some anonymous pages might now actually be shared --
+	 * which is why we're unpinning after all.
+	 */
+	for (i = 0; i < npages; i += nr) {
+		folio = gup_folio_next(pages, npages, i, &nr);
+		gup_put_folio(folio, nr, FOLL_PIN);
+	}
+}
+
 /**
  * unpin_user_pages() - release an array of gup-pinned pages.
  * @pages:  array of pages to be marked dirty and released.
@@ -367,6 +419,7 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 	if (WARN_ON(IS_ERR_VALUE(npages)))
 		return;
 
+	sanity_check_pinned_pages(pages, npages);
 	for (i = 0; i < npages; i += nr) {
 		folio = gup_folio_next(pages, npages, i, &nr);
 		gup_put_folio(folio, nr, FOLL_PIN);
@@ -510,6 +563,10 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		page = ERR_PTR(-EMLINK);
 		goto out;
 	}
+
+	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
+		       !PageAnonExclusive(page), page);
+
 	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
 	if (unlikely(!try_grab_page(page, flags))) {
 		page = ERR_PTR(-ENOMEM);
@@ -2750,8 +2807,10 @@ static unsigned long lockless_pages_from_mm(unsigned long start,
 	 */
 	if (gup_flags & FOLL_PIN) {
 		if (read_seqcount_retry(&current->mm->write_protect_seq, seq)) {
-			unpin_user_pages(pages, nr_pinned);
+			unpin_user_pages_lockless(pages, nr_pinned);
 			return 0;
+		} else {
+			sanity_check_pinned_pages(pages, nr_pinned);
 		}
 	}
 	return nr_pinned;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4414111998df..a2f44d8d3d47 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1392,6 +1392,9 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	if (!pmd_write(*pmd) && gup_must_unshare(flags, page))
 		return ERR_PTR(-EMLINK);
 
+	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
+			!PageAnonExclusive(page), page);
+
 	if (!try_grab_page(page, flags))
 		return ERR_PTR(-ENOMEM);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bbf0ce8cd33d..534747d661dd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6100,6 +6100,9 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
 		page = pte_page(huge_ptep_get(pte));
 
+		VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
+			       !PageAnonExclusive(page), page);
+
 		/*
 		 * If subpage information not requested, update counters
 		 * and skip the same_page loop below.
-- 
2.35.1

