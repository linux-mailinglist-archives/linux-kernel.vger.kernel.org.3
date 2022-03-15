Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C134D99B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347521AbiCOKyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347217AbiCOKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B930D36E13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647341564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oR6qVhjpjO5KL2hp5vGkeEVO7I21fiQlMy2idQsQ8nQ=;
        b=eVAGwqDSXNFYrzo/PT4R8E6iHg7uwrPGeEaahaNnR+LQ4hVEUYiCP6cpPuCVApcfcfZly6
        zXfbbGtROIZ0Q3j3QZr78CA+Kss3IxOp2r+/udhVbl6bXyK3xmxGXKaFJp3xSVAhcNNq/F
        7XpCpww5iieXtsAj6XMKmAnN8Ewmuus=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-Relg6sVwP6q5aadu3ogmUA-1; Tue, 15 Mar 2022 06:52:41 -0400
X-MC-Unique: Relg6sVwP6q5aadu3ogmUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A2DE801E8D;
        Tue, 15 Mar 2022 10:52:40 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7EE39E94;
        Tue, 15 Mar 2022 10:52:21 +0000 (UTC)
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
Subject: [PATCH v2 10/15] mm/page-flags: reuse PG_mappedtodisk as PG_anon_exclusive for PageAnon() pages
Date:   Tue, 15 Mar 2022 11:47:36 +0100
Message-Id: <20220315104741.63071-11-david@redhat.com>
In-Reply-To: <20220315104741.63071-1-david@redhat.com>
References: <20220315104741.63071-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The basic question we would like to have a reliable and efficient answer
to is: is this anonymous page exclusive to a single process or might it
be shared? We need that information for ordinary/single pages, hugetlb
pages, and possibly each subpage of a THP.

Introduce a way to mark an anonymous page as exclusive, with the
ultimate goal of teaching our COW logic to not do "wrong COWs", whereby
GUP pins lose consistency with the pages mapped into the page table,
resulting in reported memory corruptions.

Most pageflags already have semantics for anonymous pages, however,
PG_mappedtodisk should never apply to pages in the swapcache, so let's
reuse that flag.

As PG_has_hwpoisoned also uses that flag on the second tail page of a
compound page, convert it to PG_error instead, which is marked as
PF_NO_TAIL, so never used for tail pages.

Use custom page flag modification functions such that we can do
additional sanity checks. The semantics we'll put into some kernel doc
in the future are:

"
  PG_anon_exclusive is *usually* only expressive in combination with a
  page table entry. Depending on the page table entry type it might
  store the following information:

       Is what's mapped via this page table entry exclusive to the
       single process and can be mapped writable without further
       checks? If not, it might be shared and we might have to COW.

  For now, we only expect PTE-mapped THPs to make use of
  PG_anon_exclusive in subpages. For other anonymous compound
  folios (i.e., hugetlb), only the head page is logically mapped and
  holds this information.

  For example, an exclusive, PMD-mapped THP only has PG_anon_exclusive
  set on the head page. When replacing the PMD by a page table full
  of PTEs, PG_anon_exclusive, if set on the head page, will be set on
  all tail pages accordingly. Note that converting from a PTE-mapping
  to a PMD mapping using the same compound page is currently not
  possible and consequently doesn't require care.

  If GUP wants to take a reliable pin (FOLL_PIN) on an anonymous page,
  it should only pin if the relevant PG_anon_bit is set. In that case,
  the pin will be fully reliable and stay consistent with the pages
  mapped into the page table, as the bit cannot get cleared (e.g., by
  fork(), KSM) while the page is pinned. For anonymous pages that
  are mapped R/W, PG_anon_exclusive can be assumed to always be set
  because such pages cannot possibly be shared.

  The page table lock protecting the page table entry is the primary
  synchronization mechanism for PG_anon_exclusive; GUP-fast that does
  not take the PT lock needs special care when trying to clear the
  flag.

  Page table entry types and PG_anon_exclusive:
  * Present: PG_anon_exclusive applies.
  * Swap: the information is lost. PG_anon_exclusive was cleared.
  * Migration: the entry holds this information instead.
               PG_anon_exclusive was cleared.
  * Device private: PG_anon_exclusive applies.
  * Device exclusive: PG_anon_exclusive applies.
  * HW Poison: PG_anon_exclusive is stale and not changed.

  If the page may be pinned (FOLL_PIN), clearing PG_anon_exclusive is
  not allowed and the flag will stick around until the page is freed
  and folio->mapping is cleared.
"

We won't be clearing PG_anon_exclusive on destructive unmapping (i.e.,
zapping) of page table entries, page freeing code will handle that when
also invalidate page->mapping to not indicate PageAnon() anymore.
Letting information about exclusivity stick around will be an important
property when adding sanity checks to unpinning code.

Note that we properly clear the flag in free_pages_prepare() via
PAGE_FLAGS_CHECK_AT_PREP for each individual subpage of a compound page,
so there is no need to manually clear the flag.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 39 +++++++++++++++++++++++++++++++++++++-
 mm/hugetlb.c               |  2 ++
 mm/memory.c                | 11 +++++++++++
 mm/memremap.c              |  9 +++++++++
 mm/swapfile.c              |  4 ++++
 tools/vm/page-types.c      |  8 +++++++-
 6 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1c3b6e5c8bfd..e905247dd984 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -142,6 +142,15 @@ enum pageflags {
 
 	PG_readahead = PG_reclaim,
 
+	/*
+	 * Depending on the way an anonymous folio can be mapped into a page
+	 * table (e.g., single PMD/PUD/CONT of the head page vs. PTE-mapped
+	 * THP), PG_anon_exclusive may be set only for the head page or for
+	 * tail pages of an anonymous folio. For now, we only expect it to be
+	 * set on tail pages for PTE-mapped THP.
+	 */
+	PG_anon_exclusive = PG_mappedtodisk,
+
 	/* Filesystems */
 	PG_checked = PG_owner_priv_1,
 
@@ -176,7 +185,7 @@ enum pageflags {
 	 * Indicates that at least one subpage is hwpoisoned in the
 	 * THP.
 	 */
-	PG_has_hwpoisoned = PG_mappedtodisk,
+	PG_has_hwpoisoned = PG_error,
 #endif
 
 	/* non-lru isolated movable page */
@@ -920,6 +929,34 @@ extern bool is_free_buddy_page(struct page *page);
 
 __PAGEFLAG(Isolated, isolated, PF_ANY);
 
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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9fb990d95dab..1ff0b9e1e28e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1669,6 +1669,8 @@ void free_huge_page(struct page *page)
 	VM_BUG_ON_PAGE(page_mapcount(page), page);
 
 	hugetlb_set_page_subpool(page, NULL);
+	if (PageAnon(page))
+		__ClearPageAnonExclusive(page);
 	page->mapping = NULL;
 	restore_reserve = HPageRestoreReserve(page);
 	ClearHPageRestoreReserve(page);
diff --git a/mm/memory.c b/mm/memory.c
index 7b32f422798d..d01fab481134 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3671,6 +3671,17 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_nomap;
 	}
 
+	/*
+	 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
+	 * must never point at an anonymous page in the swapcache that is
+	 * PG_anon_exclusive. Sanity check that this holds and especially, that
+	 * no filesystem set PG_mappedtodisk on a page in the swapcache. Sanity
+	 * check after taking the PT lock and making sure that nobody
+	 * concurrently faulted in this page and set PG_anon_exclusive.
+	 */
+	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
+	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
+
 	/*
 	 * Remove the swap entry and conditionally try to free up the swapcache.
 	 * We're already holding a reference on the page but haven't mapped it
diff --git a/mm/memremap.c b/mm/memremap.c
index 6aa5f0c2d11f..160ea92e4e17 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -478,6 +478,15 @@ void free_devmap_managed_page(struct page *page)
 
 	mem_cgroup_uncharge(page_folio(page));
 
+	/*
+	 * Note: we don't expect anonymous compound pages yet. Once supported
+	 * and we could PTE-map them similar to THP, we'd have to clear
+	 * PG_anon_exclusive on all tail pages.
+	 */
+	VM_BUG_ON_PAGE(PageAnon(page) && PageCompound(page), page);
+	if (PageAnon(page))
+		__ClearPageAnonExclusive(page);
+
 	/*
 	 * When a device_private page is freed, the page->mapping field
 	 * may still contain a (stale) mapping value. For example, the
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7edc8e099b22..493acb967b7a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1796,6 +1796,10 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		goto out;
 	}
 
+	/* See do_swap_page() */
+	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
+	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
+
 	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
 	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
 	get_page(page);
diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index b1ed76d9a979..381dcc00cb62 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -80,9 +80,10 @@
 #define KPF_SOFTDIRTY		40
 #define KPF_ARCH_2		41
 
-/* [48-] take some arbitrary free slots for expanding overloaded flags
+/* [47-] take some arbitrary free slots for expanding overloaded flags
  * not part of kernel API
  */
+#define KPF_ANON_EXCLUSIVE	47
 #define KPF_READAHEAD		48
 #define KPF_SLOB_FREE		49
 #define KPF_SLUB_FROZEN		50
@@ -138,6 +139,7 @@ static const char * const page_flag_names[] = {
 	[KPF_SOFTDIRTY]		= "f:softdirty",
 	[KPF_ARCH_2]		= "H:arch_2",
 
+	[KPF_ANON_EXCLUSIVE]	= "d:anon_exclusive",
 	[KPF_READAHEAD]		= "I:readahead",
 	[KPF_SLOB_FREE]		= "P:slob_free",
 	[KPF_SLUB_FROZEN]	= "A:slub_frozen",
@@ -472,6 +474,10 @@ static int bit_mask_ok(uint64_t flags)
 
 static uint64_t expand_overloaded_flags(uint64_t flags, uint64_t pme)
 {
+	/* Anonymous pages overload PG_mappedtodisk */
+	if ((flags & BIT(ANON)) && (flags & BIT(MAPPEDTODISK)))
+		flags ^= BIT(MAPPEDTODISK) | BIT(ANON_EXCLUSIVE);
+
 	/* SLOB/SLUB overload several page flags */
 	if (flags & BIT(SLAB)) {
 		if (flags & BIT(PRIVATE))
-- 
2.35.1

