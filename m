Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2258E24E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiHIWB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiHIWBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A538E16
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660082471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1RwmKRYJuvTG/btGRX62JpRnXDc5C3jxVCpX+grs9Ro=;
        b=KIPM2jJQZaYSTPaCLsWHotXRAjDekjJACRB/oocteg3EL9KBUgHICq1VZOOji2MeVsumSC
        EA+LjnuEYbvhLlXO8TZkcOxrkUC2FHZE6q6Ah5dF3atTJ8rYGVKCD6QmVv7NPS+mb4alot
        T7QCEI7B4I8jbMqPRj0//fjUwRngrJ4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-jexWONQNOLK_NBMpslu0PA-1; Tue, 09 Aug 2022 18:01:10 -0400
X-MC-Unique: jexWONQNOLK_NBMpslu0PA-1
Received: by mail-qv1-f70.google.com with SMTP id f10-20020a05621400ca00b0047752ce4c5cso6885066qvs.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1RwmKRYJuvTG/btGRX62JpRnXDc5C3jxVCpX+grs9Ro=;
        b=RCuah3f+SRlUAYQFkjNtKO8ljoRC2BoPDHcrUVxt+qSMuYpcjZ7DVPFAJyP3x5RheU
         UWNPRxci3i1fT84foXjd6py+debpBGmvI0MUNoAIOGxZM97tQLEub93Ll2APqX9R8Fpp
         LK/gKqY1J3hHcf130u+fCjc9BvRtmz5ktua38Z3NUNTXZWGHoYnWKqPOgEq7o/ou/1OC
         8BVxq19By8LTs4+SgOocOEpWT+kizSmmdPxmiAgnfU4e7ggXw77LeZum5RsCxltnifuR
         BxbjzQx8neKFrtJKMQxhj0SSbqsL5ahJNdn5UB1xa83LOtBv9QBlRz23LuUyWDPeU/CD
         OVbQ==
X-Gm-Message-State: ACgBeo1XACkARgvy4CBW9fYERLQlf6MnAs1y8QSZywL/ebsOX8dqPe9p
        Oj7VzZ+4ZjxfExNDRRKH+5s6rIMXEjjhF2RyXjd69e6bsBHcpKaHjUEuhqxtZ4szplnzeyOAd9J
        wlRsRC2XZseZlpQF36bHV1qqJ
X-Received: by 2002:ac8:5a51:0:b0:342:e917:f25b with SMTP id o17-20020ac85a51000000b00342e917f25bmr16799574qta.284.1660082470077;
        Tue, 09 Aug 2022 15:01:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7F8awg0xQpCbkyT+nfZ6Y4i6eUOSmTv7BxMbnhF6Tnq2rHRG8SF8KC3nPcS8vkXeC9hjxxmA==
X-Received: by 2002:ac8:5a51:0:b0:342:e917:f25b with SMTP id o17-20020ac85a51000000b00342e917f25bmr16799543qta.284.1660082469795;
        Tue, 09 Aug 2022 15:01:09 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id b16-20020a05622a021000b0031eddc83560sm10563383qtx.90.2022.08.09.15.01.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Aug 2022 15:01:09 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 5/7] mm: Remember young/dirty bit for page migrations
Date:   Tue,  9 Aug 2022 18:00:58 -0400
Message-Id: <20220809220100.20033-6-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220809220100.20033-1-peterx@redhat.com>
References: <20220809220100.20033-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page migration happens, we always ignore the young/dirty bit settings
in the old pgtable, and marking the page as old in the new page table using
either pte_mkold() or pmd_mkold(), and keeping the pte clean.

That's fine from functional-wise, but that's not friendly to page reclaim
because the moving page can be actively accessed within the procedure.  Not
to mention hardware setting the young bit can bring quite some overhead on
some systems, e.g. x86_64 needs a few hundreds nanoseconds to set the bit.
The same slowdown problem to dirty bits when the memory is first written
after page migration happened.

Actually we can easily remember the A/D bit configuration and recover the
information after the page is migrated.  To achieve it, define a new set of
bits in the migration swap offset field to cache the A/D bits for old pte.
Then when removing/recovering the migration entry, we can recover the A/D
bits even if the page changed.

One thing to mention is that here we used max_swapfile_size() to detect how
many swp offset bits we have, and we'll only enable this feature if we know
the swp offset can be big enough to store both the PFN value and the young
bit.  Otherwise the A/D bits are dropped like before.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h | 99 +++++++++++++++++++++++++++++++++++++++++
 mm/huge_memory.c        | 18 +++++++-
 mm/migrate.c            |  6 ++-
 mm/migrate_device.c     |  4 ++
 mm/rmap.c               |  5 ++-
 5 files changed, 128 insertions(+), 4 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index e1accbcd1136..0e9579b90659 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -8,6 +8,10 @@
 
 #ifdef CONFIG_MMU
 
+#ifdef CONFIG_SWAP
+#include <linux/swapfile.h>
+#endif	/* CONFIG_SWAP */
+
 /*
  * swapcache pages are stored in the swapper_space radix tree.  We want to
  * get good packing density in that tree, so the index should be dense in
@@ -35,6 +39,31 @@
 #endif	/* MAX_PHYSMEM_BITS */
 #define SWP_PFN_MASK			((1UL << SWP_PFN_BITS) - 1)
 
+/**
+ * Migration swap entry specific bitfield definitions.  Layout:
+ *
+ *   |----------+--------------------|
+ *   | swp_type | swp_offset         |
+ *   |----------+--------+-+-+-------|
+ *   |          | resv   |D|A|  PFN  |
+ *   |----------+--------+-+-+-------|
+ *
+ * @SWP_MIG_YOUNG_BIT: Whether the page used to have young bit set (bit A)
+ * @SWP_MIG_DIRTY_BIT: Whether the page used to have dirty bit set (bit D)
+ *
+ * Note: A/D bits will be stored in migration entries iff there're enough
+ * free bits in arch specific swp offset.  By default we'll ignore A/D bits
+ * when migrating a page.  Please refer to migration_entry_supports_ad()
+ * for more information.  If there're more bits besides PFN and A/D bits,
+ * they should be reserved and always be zeros.
+ */
+#define SWP_MIG_YOUNG_BIT		(SWP_PFN_BITS)
+#define SWP_MIG_DIRTY_BIT		(SWP_PFN_BITS + 1)
+#define SWP_MIG_TOTAL_BITS		(SWP_PFN_BITS + 2)
+
+#define SWP_MIG_YOUNG			BIT(SWP_MIG_YOUNG_BIT)
+#define SWP_MIG_DIRTY			BIT(SWP_MIG_DIRTY_BIT)
+
 static inline bool is_pfn_swap_entry(swp_entry_t entry);
 
 /* Clear all flags but only keep swp_entry_t related information */
@@ -265,6 +294,57 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
 	return swp_entry(SWP_MIGRATION_WRITE, offset);
 }
 
+/*
+ * Returns whether the host has large enough swap offset field to support
+ * carrying over pgtable A/D bits for page migrations.  The result is
+ * pretty much arch specific.
+ */
+static inline bool migration_entry_supports_ad(void)
+{
+	/*
+	 * max_swapfile_size() returns the max supported swp-offset plus 1.
+	 * We can support the migration A/D bits iff the pfn swap entry has
+	 * the offset large enough to cover all of them (PFN, A & D bits).
+	 */
+#ifdef CONFIG_SWAP
+	return max_swapfile_size() >= (1UL << SWP_MIG_TOTAL_BITS);
+#else  /* CONFIG_SWAP */
+	return false;
+#endif	/* CONFIG_SWAP */
+}
+
+static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
+{
+	if (migration_entry_supports_ad())
+		return swp_entry(swp_type(entry),
+				 swp_offset(entry) | SWP_MIG_YOUNG);
+	return entry;
+}
+
+static inline bool is_migration_entry_young(swp_entry_t entry)
+{
+	if (migration_entry_supports_ad())
+		return swp_offset(entry) & SWP_MIG_YOUNG;
+	/* Keep the old behavior of aging page after migration */
+	return false;
+}
+
+static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
+{
+	if (migration_entry_supports_ad())
+		return swp_entry(swp_type(entry),
+				 swp_offset(entry) | SWP_MIG_DIRTY);
+	return entry;
+}
+
+static inline bool is_migration_entry_dirty(swp_entry_t entry)
+{
+	if (migration_entry_supports_ad())
+		return swp_offset(entry) & SWP_MIG_DIRTY;
+	/* Keep the old behavior of clean page after migration */
+	return false;
+}
+
 extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 					spinlock_t *ptl);
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
@@ -311,6 +391,25 @@ static inline int is_readable_migration_entry(swp_entry_t entry)
 	return 0;
 }
 
+static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
+{
+	return entry;
+}
+
+static inline bool is_migration_entry_young(swp_entry_t entry)
+{
+	return false;
+}
+
+static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
+{
+	return entry;
+}
+
+static inline bool is_migration_entry_dirty(swp_entry_t entry)
+{
+	return false;
+}
 #endif	/* CONFIG_MIGRATION */
 
 typedef unsigned long pte_marker;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e8e78d1bac5f..1644e9f59d73 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2089,7 +2089,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		write = is_writable_migration_entry(entry);
 		if (PageAnon(page))
 			anon_exclusive = is_readable_exclusive_migration_entry(entry);
-		young = false;
+		young = is_migration_entry_young(entry);
+		dirty = is_migration_entry_dirty(entry);
 		soft_dirty = pmd_swp_soft_dirty(old_pmd);
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 	} else {
@@ -2148,6 +2149,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			else
 				swp_entry = make_readable_migration_entry(
 							page_to_pfn(page + i));
+			if (young)
+				swp_entry = make_migration_entry_young(swp_entry);
+			if (dirty)
+				swp_entry = make_migration_entry_dirty(swp_entry);
 			entry = swp_entry_to_pte(swp_entry);
 			if (soft_dirty)
 				entry = pte_swp_mksoft_dirty(entry);
@@ -3157,6 +3162,10 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		entry = make_readable_exclusive_migration_entry(page_to_pfn(page));
 	else
 		entry = make_readable_migration_entry(page_to_pfn(page));
+	if (pmd_young(pmdval))
+		entry = make_migration_entry_young(entry);
+	if (pmd_dirty(pmdval))
+		entry = make_migration_entry_dirty(entry);
 	pmdswp = swp_entry_to_pmd(entry);
 	if (pmd_soft_dirty(pmdval))
 		pmdswp = pmd_swp_mksoft_dirty(pmdswp);
@@ -3182,13 +3191,18 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
 	entry = pmd_to_swp_entry(*pvmw->pmd);
 	get_page(new);
-	pmde = pmd_mkold(mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot)));
+	pmde = mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot));
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
 	if (is_writable_migration_entry(entry))
 		pmde = maybe_pmd_mkwrite(pmde, vma);
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
 		pmde = pmd_wrprotect(pmd_mkuffd_wp(pmde));
+	if (!is_migration_entry_young(entry))
+		pmde = pmd_mkold(pmde);
+	/* NOTE: this may contain setting soft-dirty on some archs */
+	if (PageDirty(new) && is_migration_entry_dirty(entry))
+		pmde = pmd_mkdirty(pmde);
 
 	if (PageAnon(new)) {
 		rmap_t rmap_flags = RMAP_COMPOUND;
diff --git a/mm/migrate.c b/mm/migrate.c
index 6a1597c92261..0433a71d2bee 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -198,7 +198,7 @@ static bool remove_migration_pte(struct folio *folio,
 #endif
 
 		folio_get(folio);
-		pte = pte_mkold(mk_pte(new, READ_ONCE(vma->vm_page_prot)));
+		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
 		if (pte_swp_soft_dirty(*pvmw.pte))
 			pte = pte_mksoft_dirty(pte);
 
@@ -206,6 +206,10 @@ static bool remove_migration_pte(struct folio *folio,
 		 * Recheck VMA as permissions can change since migration started
 		 */
 		entry = pte_to_swp_entry(*pvmw.pte);
+		if (!is_migration_entry_young(entry))
+			pte = pte_mkold(pte);
+		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
+			pte = pte_mkdirty(pte);
 		if (is_writable_migration_entry(entry))
 			pte = maybe_mkwrite(pte, vma);
 		else if (pte_swp_uffd_wp(*pvmw.pte))
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 27fb37d65476..699f821b8443 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -221,6 +221,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			else
 				entry = make_readable_migration_entry(
 							page_to_pfn(page));
+			if (pte_young(pte))
+				entry = make_migration_entry_young(entry);
+			if (pte_dirty(pte))
+				entry = make_migration_entry_dirty(entry);
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_present(pte)) {
 				if (pte_soft_dirty(pte))
diff --git a/mm/rmap.c b/mm/rmap.c
index af775855e58f..28aef434ea41 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2065,7 +2065,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			else
 				entry = make_readable_migration_entry(
 							page_to_pfn(subpage));
-
+			if (pte_young(pteval))
+				entry = make_migration_entry_young(entry);
+			if (pte_dirty(pteval))
+				entry = make_migration_entry_dirty(entry);
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_soft_dirty(pteval))
 				swp_pte = pte_swp_mksoft_dirty(swp_pte);
-- 
2.32.0

