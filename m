Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08B64D1A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347408AbiCHOTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347419AbiCHOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:19:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E75564B41F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646749106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUQHnq0nQgM03gzqUN8vM54K9CtgbtsheEj4rsF/jjo=;
        b=By8yp3Eqym1NQMkAVyvYaTn7CCe2KDkh+WxQB9HuO1fJXWHJZNmfg15wVOqHG9fBv4uTuD
        4rcdrJW5BXkOwVis4Nn4ov/iGm22OadqSCsnhIqAC4dYNeKa31Dz1XirzvB0bZk2kBwEPV
        Jh+xRCtuTToFf6NvJ6vMQebYl+6gepQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-UihOJiA-PI6qoc6i5a26RQ-1; Tue, 08 Mar 2022 09:18:22 -0500
X-MC-Unique: UihOJiA-PI6qoc6i5a26RQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D16F801AEB;
        Tue,  8 Mar 2022 14:18:19 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CADF7886E;
        Tue,  8 Mar 2022 14:18:12 +0000 (UTC)
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
Subject: [PATCH v1 10/15] mm/page-flags: reuse PG_slab as PG_anon_exclusive for PageAnon() pages
Date:   Tue,  8 Mar 2022 15:14:32 +0100
Message-Id: <20220308141437.144919-11-david@redhat.com>
In-Reply-To: <20220308141437.144919-1-david@redhat.com>
References: <20220308141437.144919-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The basic question we would like to have a reliable and efficient answer
to is: is this anonymous page exclusive to a single process or might it
be shared?

In an ideal world, we'd have a spare pageflag. Unfortunately, pageflags
don't grow on trees, so we have to get a little creative for the time
being.

Introduce a way to mark an anonymous page as exclusive, with the
ultimate goal of teaching our COW logic to not do "wrong COWs", whereby
GUP pins lose consistency with the pages mapped into the page table,
resulting in reported memory corruptions.

Most pageflags already have semantics for anonymous pages, so we're left
with reusing PG_slab for our purpose: for PageAnon() pages PG_slab now
translates to PG_anon_exclusive, teach some in-kernel code that manually
handles PG_slab about that.

Add a spoiler on the semantics of PG_anon_exclusive as documentation. More
documentation will be contained in the code that actually makes use of
PG_anon_exclusive.

We won't be clearing PG_anon_exclusive on destructive unmapping (i.e.,
zapping) of page table entries, page freeing code will handle that when
also invalidate page->mapping to not indicate PageAnon() anymore.
Letting information about exclusivity stick around will be an important
property when adding sanity checks to unpinning code.

RFC notes: in-tree tools/cgroup/memcg_slabinfo.py looks like it might need
	   some care. We'd have to lookup the head page and check if
	   PageAnon() is set. Similarly, tools living outside the kernel
	   repository like crash and makedumpfile might need adaptions.

Cc: Roman Gushchin <guro@fb.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/page.c                 |   3 +-
 include/linux/page-flags.h     | 124 ++++++++++++++++++++++++++++++++-
 include/trace/events/mmflags.h |   2 +-
 mm/hugetlb.c                   |   4 ++
 mm/memory-failure.c            |  24 +++++--
 mm/memremap.c                  |  11 +++
 mm/page_alloc.c                |  13 ++++
 7 files changed, 170 insertions(+), 11 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 9f1077d94cde..61187568e5f7 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -182,8 +182,7 @@ u64 stable_page_flags(struct page *page)
 
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
 
-	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
-	if (PageTail(page) && PageSlab(compound_head(page)))
+	if (PageSlab(page) || PageSlab(compound_head(page)))
 		u |= 1 << KPF_SLAB;
 
 	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1c3b6e5c8bfd..b3c2cf71467e 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -107,7 +107,7 @@ enum pageflags {
 	PG_workingset,
 	PG_waiters,		/* Page has waiters, check its waitqueue. Must be bit #7 and in the same byte as "PG_locked" */
 	PG_error,
-	PG_slab,
+	PG_slab,		/* Slab page if !PageAnon() */
 	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use*/
 	PG_arch_1,
 	PG_reserved,
@@ -142,6 +142,63 @@ enum pageflags {
 
 	PG_readahead = PG_reclaim,
 
+	/*
+	 * Depending on the way an anonymous folio can be mapped into a page
+	 * table (e.g., single PMD/PUD/CONT of the head page vs. PTE-mapped
+	 * THP), PG_anon_exclusive may be set only for the head page or for
+	 * subpages of an anonymous folio.
+	 *
+	 * PG_anon_exclusive is *usually* only expressive in combination with a
+	 * page table entry. Depending on the page table entry type it might
+	 * store the following information:
+	 *
+	 *	Is what's mapped via this page table entry exclusive to the
+	 *	single process and can be mapped writable without further
+	 *	checks? If not, it might be shared and we might have to COW.
+	 *
+	 * For now, we only expect PTE-mapped THPs to make use of
+	 * PG_anon_exclusive in subpages. For other anonymous compound
+	 * folios (i.e., hugetlb), only the head page is logically mapped and
+	 * holds this information.
+	 *
+	 * For example, an exclusive, PMD-mapped THP only has PG_anon_exclusive
+	 * set on the head page. When replacing the PMD by a page table full
+	 * of PTEs, PG_anon_exclusive, if set on the head page, will be set on
+	 * all tail pages accordingly. Note that converting from a PTE-mapping
+	 * to a PMD mapping using the same compound page is currently not
+	 * possible and consequently doesn't require care.
+	 *
+	 * If GUP wants to take a reliable pin (FOLL_PIN) on an anonymous page,
+	 * it should only pin if the relevant PG_anon_bit is set. In that case,
+	 * the pin will be fully reliable and stay consistent with the pages
+	 * mapped into the page table, as the bit cannot get cleared (e.g., by
+	 * fork(), KSM) while the page is pinned. For anonymous pages that
+	 * are mapped R/W, PG_anon_exclusive can be assumed to always be set
+	 * because such pages cannot possibly be shared.
+	 *
+	 * The page table lock protecting the page table entry is the primary
+	 * synchronization mechanism for PG_anon_exclusive; GUP-fast that does
+	 * not take the PT lock needs special care when trying to clear the
+	 * flag.
+	 *
+	 * Page table entry types and PG_anon_exclusive:
+	 * * Present: PG_anon_exclusive applies.
+	 * * Swap: the information is lost. PG_anon_exclusive was cleared.
+	 * * Migration: the entry holds this information instead.
+	 *		PG_anon_exclusive was cleared.
+	 * * Device private: PG_anon_exclusive applies.
+	 * * Device exclusive: PG_anon_exclusive applies.
+	 * * HW Poison: PG_anon_exclusive is stale and not changed.
+	 *
+	 * If the page may be pinned (FOLL_PIN), clearing PG_anon_exclusive is
+	 * not allowed and the flag will stick around until the page is freed
+	 * and folio->mapping is cleared.
+	 *
+	 * Before clearing folio->mapping, PG_anon_exclusive has to be cleared
+	 * to not result in PageSlab() false positives.
+	 */
+	PG_anon_exclusive = PG_slab,
+
 	/* Filesystems */
 	PG_checked = PG_owner_priv_1,
 
@@ -425,7 +482,6 @@ PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
 	TESTCLEARFLAG(Active, active, PF_HEAD)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
 	TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
-__PAGEFLAG(Slab, slab, PF_NO_TAIL)
 __PAGEFLAG(SlobFree, slob_free, PF_NO_TAIL)
 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)	   /* Used by some filesystems */
 
@@ -920,6 +976,70 @@ extern bool is_free_buddy_page(struct page *page);
 
 __PAGEFLAG(Isolated, isolated, PF_ANY);
 
+static __always_inline bool folio_test_slab(struct folio *folio)
+{
+	return !folio_test_anon(folio) &&
+	       test_bit(PG_slab, folio_flags(folio, FOLIO_PF_NO_TAIL));
+}
+
+static __always_inline int PageSlab(struct page *page)
+{
+	return !PageAnon(page) &&
+		test_bit(PG_slab, &PF_NO_TAIL(page, 0)->flags);
+}
+
+static __always_inline void __folio_set_slab(struct folio *folio)
+{
+	VM_BUG_ON(folio_test_anon(folio));
+	__set_bit(PG_slab, folio_flags(folio, FOLIO_PF_NO_TAIL));
+}
+
+static __always_inline void __SetPageSlab(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageAnon(page), page);
+	__set_bit(PG_slab, &PF_NO_TAIL(page, 1)->flags);
+}
+
+static __always_inline void __folio_clear_slab(struct folio *folio)
+{
+	VM_BUG_ON(folio_test_anon(folio));
+	__clear_bit(PG_slab, folio_flags(folio, FOLIO_PF_NO_TAIL));
+}
+
+static __always_inline void __ClearPageSlab(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageAnon(page), page);
+	__clear_bit(PG_slab, &PF_NO_TAIL(page, 1)->flags);
+}
+
+static __always_inline int PageAnonExclusive(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
+	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
+	return test_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
+}
+
+static __always_inline void SetPageAnonExclusive(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(!PageAnon(page) || PageKsm(page), page);
+	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
+	set_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
+}
+
+static __always_inline void ClearPageAnonExclusive(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(!PageAnon(page) || PageKsm(page), page);
+	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
+	clear_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
+}
+
+static __always_inline void __ClearPageAnonExclusive(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
+	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
+	__clear_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
+}
+
 #ifdef CONFIG_MMU
 #define __PG_MLOCKED		(1UL << PG_mlocked)
 #else
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 116ed4d5d0f8..5662f74e027f 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -103,7 +103,7 @@
 	{1UL << PG_lru,			"lru"		},		\
 	{1UL << PG_active,		"active"	},		\
 	{1UL << PG_workingset,		"workingset"	},		\
-	{1UL << PG_slab,		"slab"		},		\
+	{1UL << PG_slab,		"slab/anon_exclusive" },	\
 	{1UL << PG_owner_priv_1,	"owner_priv_1"	},		\
 	{1UL << PG_arch_1,		"arch_1"	},		\
 	{1UL << PG_reserved,		"reserved"	},		\
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9fb990d95dab..bf5ce91c623c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1669,6 +1669,10 @@ void free_huge_page(struct page *page)
 	VM_BUG_ON_PAGE(page_mapcount(page), page);
 
 	hugetlb_set_page_subpool(page, NULL);
+	if (PageAnon(page)) {
+		__ClearPageAnonExclusive(page);
+		wmb(); /* avoid PageSlab() false positives */
+	}
 	page->mapping = NULL;
 	restore_reserve = HPageRestoreReserve(page);
 	ClearHPageRestoreReserve(page);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 97a9ed8f87a9..176fa2fbd699 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1470,17 +1470,29 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 	 * The first check uses the current page flags which may not have any
 	 * relevant information. The second check with the saved page flags is
 	 * carried out only if the first check can't determine the page status.
+	 *
+	 * Note that PG_slab is also used as PG_anon_exclusive for PageAnon()
+	 * pages. Most of these pages should have been handled previously,
+	 * however, let's play safe and verify via PageAnon().
 	 */
-	for (ps = error_states;; ps++)
-		if ((p->flags & ps->mask) == ps->res)
-			break;
+	for (ps = error_states;; ps++) {
+		if ((p->flags & ps->mask) != ps->res)
+			continue;
+		if ((ps->type == MF_MSG_SLAB) && PageAnon(p))
+			continue;
+		break;
+	}
 
 	page_flags |= (p->flags & (1UL << PG_dirty));
 
 	if (!ps->mask)
-		for (ps = error_states;; ps++)
-			if ((page_flags & ps->mask) == ps->res)
-				break;
+		for (ps = error_states;; ps++) {
+			if ((page_flags & ps->mask) != ps->res)
+				continue;
+			if ((ps->type == MF_MSG_SLAB) && PageAnon(p))
+				continue;
+			break;
+		}
 	return page_action(ps, p, pfn);
 }
 
diff --git a/mm/memremap.c b/mm/memremap.c
index 6aa5f0c2d11f..a6b82ae8b3e6 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -478,6 +478,17 @@ void free_devmap_managed_page(struct page *page)
 
 	mem_cgroup_uncharge(page_folio(page));
 
+	/*
+	 * Note: we don't expect anonymous compound pages yet. Once supported
+	 * and we could PTE-map them similar to THP, we'd have to clear
+	 * PG_anon_exclusive on all tail pages.
+	 */
+	VM_BUG_ON_PAGE(PageAnon(page) && PageCompound(page), page);
+	if (PageAnon(page)) {
+		__ClearPageAnonExclusive(page);
+		wmb(); /* avoid PageSlab() false positives */
+	}
+
 	/*
 	 * When a device_private page is freed, the page->mapping field
 	 * may still contain a (stale) mapping value. For example, the
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..e59e68a61d1a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1297,6 +1297,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 {
 	int bad = 0;
 	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
+	const bool anon = PageAnon(page);
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
@@ -1329,6 +1330,14 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			ClearPageHasHWPoisoned(page);
 		}
 		for (i = 1; i < (1 << order); i++) {
+			/*
+			 * Freeing a previously PTE-mapped THP can have
+			 * PG_anon_exclusive set on tail pages. Clear it
+			 * manually as it's overloaded with PG_slab that we
+			 * want to catch in check_free_page().
+			 */
+			if (anon)
+				__ClearPageAnonExclusive(page + i);
 			if (compound)
 				bad += free_tail_pages_check(page, page + i);
 			if (unlikely(check_free_page(page + i))) {
@@ -1338,6 +1347,10 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 		}
 	}
+	if (anon) {
+		__ClearPageAnonExclusive(page);
+		wmb(); /* avoid PageSlab() false positives */
+	}
 	if (PageMappingFlags(page))
 		page->mapping = NULL;
 	if (memcg_kmem_enabled() && PageMemcgKmem(page))
-- 
2.35.1

