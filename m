Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E13F590450
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiHKQme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbiHKQlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BA09A5C6D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660234424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcBPlgoBrj0uOf3oLcjW7xdC8Px/qOVmL+drDcWQ9zU=;
        b=ac8Gq8eGLD70CwFRaAEckItyLGHvfAz82ZcxywSOoZdsaqu7ZxHfGM/Oj3mV9p65Ow79lm
        Jf4arGEX/ZfXa2vFdRPZ3sWg2sKOcQ6seNeuofPzg/ZrsYDiyfB2ZDxp4m+TCIKaugVdVZ
        fWItRg8Ty3UzKG0j8Pgp4IOk634Fdfc=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-445-beIqJO_QNNGC9Z3eo-WMvQ-1; Thu, 11 Aug 2022 12:13:43 -0400
X-MC-Unique: beIqJO_QNNGC9Z3eo-WMvQ-1
Received: by mail-il1-f198.google.com with SMTP id d6-20020a056e020c0600b002deca741bc2so12840771ile.18
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wcBPlgoBrj0uOf3oLcjW7xdC8Px/qOVmL+drDcWQ9zU=;
        b=EMyUZxJbHgyruDWOJGD5uEXLojvjpRcX2BoBuoVdWMJ/L+4B19jWeHZLTJ6JmM57+7
         UqKQaolVB83xvXLJwTZChBvRyL6Ur9dwMkDbi8sf1S19VvAdfLNM+TPevHQva/rkQLNX
         gpFI+6jgK8cSDcD8TKwk2KzdDmYSh3XpYpeWq1mBof89SfEqSp7b+loBGwnBgHgjWHct
         q1UAsnENaLpQr9/vK+IOTeG1cQ0/Zxl/3GQLnXvrmKbnnOc5DdSWY/I/V9MvAOIHlm1Y
         sapYJju3iqouZIq/f6QV4VIz4hr8CTt89np1k2jbhjhG5txCRm03hECPvOKDswpN6B5O
         qnmQ==
X-Gm-Message-State: ACgBeo0tFhiDuiYPUMnD1Lmz7OrTVa7wkM9ezVuq4MTDFjxB9EaqyYaF
        v+a9UcnV7v1JS1NR2aO6mOugCk5GDtV1DQCNi5eYPkDrkq0Wb/u8JnXKnloDvF/T7gaoCQtPAfF
        6/2MLQDKBU+csLSSRsFss6O+S
X-Received: by 2002:a05:6602:3c8:b0:672:4e60:7294 with SMTP id g8-20020a05660203c800b006724e607294mr19032iov.17.1660234422697;
        Thu, 11 Aug 2022 09:13:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4a4wc03JiaOd+Wy1g/LSTkpve80CiM3YnLVxORIPuirDVkEdT56xr6TTENWxL/H/ODMSTXkQ==
X-Received: by 2002:a05:6602:3c8:b0:672:4e60:7294 with SMTP id g8-20020a05660203c800b006724e607294mr19017iov.17.1660234422392;
        Thu, 11 Aug 2022 09:13:42 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id t1-20020a92ca81000000b002dd1c3c5c46sm3415429ilo.73.2022.08.11.09.13.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Aug 2022 09:13:41 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 5/7] mm: Remember young/dirty bit for page migrations
Date:   Thu, 11 Aug 2022 12:13:29 -0400
Message-Id: <20220811161331.37055-6-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220811161331.37055-1-peterx@redhat.com>
References: <20220811161331.37055-1-peterx@redhat.com>
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
the swp offset is big enough to store both the PFN value and the A/D bits.
Otherwise the A/D bits are dropped like before.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h | 99 +++++++++++++++++++++++++++++++++++++++++
 mm/huge_memory.c        | 18 +++++++-
 mm/migrate.c            |  6 ++-
 mm/migrate_device.c     |  6 +++
 mm/rmap.c               |  5 ++-
 5 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index bd4c6f0c2103..36e462e116af 100644
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
 #define SWP_PFN_MASK			(BIT(SWP_PFN_BITS) - 1)
 
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
index 2f68e034ddec..ac858fd9c1f1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2111,7 +2111,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		write = is_writable_migration_entry(entry);
 		if (PageAnon(page))
 			anon_exclusive = is_readable_exclusive_migration_entry(entry);
-		young = false;
+		young = is_migration_entry_young(entry);
+		dirty = is_migration_entry_dirty(entry);
 		soft_dirty = pmd_swp_soft_dirty(old_pmd);
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 	} else {
@@ -2171,6 +2172,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
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
@@ -3180,6 +3185,10 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
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
@@ -3205,13 +3214,18 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
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
index 27fb37d65476..e450b318b01b 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -221,6 +221,12 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			else
 				entry = make_readable_migration_entry(
 							page_to_pfn(page));
+			if (pte_present(pte)) {
+				if (pte_young(pte))
+					entry = make_migration_entry_young(entry);
+				if (pte_dirty(pte))
+					entry = make_migration_entry_dirty(entry);
+			}
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

