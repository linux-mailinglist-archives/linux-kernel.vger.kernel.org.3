Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7784A58855A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbiHCBWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiHCBWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BF6C4507F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 18:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659489727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSNm0hC0oMVbN7mCZyyiRtCdb6eVWmsQyqPCRK6Htxk=;
        b=FVRg48ooc4bSz1ZlaYNmofmCNxvjMG0mPuy0Ua7p6Y+JGO2W3nUWgQmBvc78MOAnKxjyEB
        F+dCW/tOrIvIHnRX3Cv4T7i7YfzKH3N4CMMcXnSEjNTiOREdoz/GOVWFRSp05AmjXiFtZJ
        p7JPdMZlookn4wmnB1+qIOEbVpRy0JE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-5Dd72OLEPAm7tjzdkrbzOA-1; Tue, 02 Aug 2022 21:22:06 -0400
X-MC-Unique: 5Dd72OLEPAm7tjzdkrbzOA-1
Received: by mail-qk1-f199.google.com with SMTP id bk21-20020a05620a1a1500b006b5c24695a4so12745059qkb.15
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 18:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSNm0hC0oMVbN7mCZyyiRtCdb6eVWmsQyqPCRK6Htxk=;
        b=XF7tkUpy77Fs8JFChliJl+kWpHkMJ3mvV/BsTGzpevlsDgdO00UBG/w1Yyr34ETzlU
         YuAscu/I71COpLF/DPmlzGornrxKxlp1hLrmGf0PVAf0UbMwuDqMIR1DWn8aEy4d50rG
         nKwLceOtQ6Pw2MwtyStMBvNaWsKI48GmK48ziMx/HP3FZlbtpza3no/UYkNu9je/GvsX
         SvVCV3yBRObCUf59ghz+BZhL4G1Mqw/QUhU4Sb0tEZS2KdQ2+MplJ/BnKr3A5pDRzqWa
         n0KU5hrsRSQmrj3AoY2L5MQkvCDM1Zwq9fUhTotS/l7Fj5JhQWxd/aEzsDP6J4+/ZW1f
         Dwog==
X-Gm-Message-State: ACgBeo2tXyxcwj4b+K1g+hEC3eNTtylDqu1KkwfKgvS+6EheS1KwTJdu
        W7UhFNP4Y5wRIfRaPGJf55X3KEecOKKuxPJbtalkmf1c6/gplJWRHMDJ27B9EieNbONCde2xdMA
        wvypEa4lnHmPbGVpbSdAHjF/UKHKiZhERheSghc14wEkyNbLIat/DjsheDo5YBHztfZP+gOGDUw
        ==
X-Received: by 2002:a05:6214:1c88:b0:472:a7e2:bef4 with SMTP id ib8-20020a0562141c8800b00472a7e2bef4mr20152402qvb.32.1659489725675;
        Tue, 02 Aug 2022 18:22:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4UH8F044fQ08lVU/hx51p2rYfphp5Z9tYfImkYnzCIYCnCwy8y/F7hg34O3s3p80m6z+rB/A==
X-Received: by 2002:a05:6214:1c88:b0:472:a7e2:bef4 with SMTP id ib8-20020a0562141c8800b00472a7e2bef4mr20152382qvb.32.1659489725312;
        Tue, 02 Aug 2022 18:22:05 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id s16-20020a05622a1a9000b0031ecce4077fsm10188675qtc.31.2022.08.02.18.22.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Aug 2022 18:22:04 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Huang Ying <ying.huang@intel.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 2/2] mm: Remember young bit for page migrations
Date:   Tue,  2 Aug 2022 21:21:59 -0400
Message-Id: <20220803012159.36551-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220803012159.36551-1-peterx@redhat.com>
References: <20220803012159.36551-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page migration happens, we always ignore the young bit settings in the
old pgtable, and marking the page as old in the new page table using either
pte_mkold() or pmd_mkold().

That's fine from functional-wise, but that's not friendly to page reclaim
because the moving page can be actively accessed within the procedure.  Not
to mention hardware setting the young bit can bring quite some overhead on
some systems, e.g. x86_64 needs a few hundreds nanoseconds to set the bit.

Actually we can easily remember the young bit configuration and recover the
information after the page is migrated.  To achieve it, define a new bit in
the migration swap offset field to show whether the old pte has young bit
set or not.  Then when removing/recovering the migration entry, we can
recover the young bit even if the page changed.

One thing to mention is that here we used max_swapfile_size() to detect how
many swp offset bits we have, and we'll only enable this feature if we know
the swp offset can be big enough to store both the PFN value and the young
bit.  Otherwise the young bit is dropped like before.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h | 49 +++++++++++++++++++++++++++++++++++++++++
 mm/huge_memory.c        | 10 +++++++--
 mm/migrate.c            |  4 +++-
 mm/migrate_device.c     |  2 ++
 mm/rmap.c               |  3 ++-
 5 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 1d17e4bb3d2f..9ddede3790a4 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -8,6 +8,8 @@
 
 #ifdef CONFIG_MMU
 
+#include <linux/swapfile.h>
+
 /*
  * swapcache pages are stored in the swapper_space radix tree.  We want to
  * get good packing density in that tree, so the index should be dense in
@@ -35,6 +37,16 @@
 #endif
 #define SWP_PFN_MASK			((1UL << SWP_PFN_BITS) - 1)
 
+/**
+ * Migration swap entry specific bitfield definitions.
+ *
+ * @SWP_MIG_YOUNG_BIT: Whether the page used to have young bit set
+ *
+ * Note: these bits will be used only if there're free bits in arch
+ * specific swp offset field.
+ */
+#define SWP_MIG_YOUNG_BIT		(1UL << SWP_PFN_BITS)
+
 static inline bool is_pfn_swap_entry(swp_entry_t entry);
 
 /* Clear all flags but only keep swp_entry_t related information */
@@ -265,6 +277,33 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
 	return swp_entry(SWP_MIGRATION_WRITE, offset);
 }
 
+static inline bool migration_entry_supports_young(void)
+{
+	/*
+	 * max_swapfile_size() returns the max supported swp-offset plus 1.
+	 * We can support the migration young bit only if the pfn swap
+	 * entry has the offset larger than storing the PFN value, then it
+	 * means there's extra bit(s) where we can store the young bit.
+	 */
+	return max_swapfile_size() > SWP_MIG_YOUNG_BIT;
+}
+
+static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
+{
+	if (migration_entry_supports_young())
+		return swp_entry(swp_type(entry),
+				 swp_offset(entry) | SWP_MIG_YOUNG_BIT);
+	return entry;
+}
+
+static inline bool is_migration_entry_young(swp_entry_t entry)
+{
+	if (migration_entry_supports_young())
+		return swp_offset(entry) & SWP_MIG_YOUNG_BIT;
+	/* Keep the old behavior of aging page after migration */
+	return false;
+}
+
 extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 					spinlock_t *ptl);
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
@@ -311,6 +350,16 @@ static inline int is_readable_migration_entry(swp_entry_t entry)
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
 #endif
 
 typedef unsigned long pte_marker;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 29e3628687a6..131fe5754d8f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2088,7 +2088,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		write = is_writable_migration_entry(entry);
 		if (PageAnon(page))
 			anon_exclusive = is_readable_exclusive_migration_entry(entry);
-		young = false;
+		young = is_migration_entry_young(entry);
 		soft_dirty = pmd_swp_soft_dirty(old_pmd);
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 	} else {
@@ -2146,6 +2146,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			else
 				swp_entry = make_readable_migration_entry(
 							page_to_pfn(page + i));
+			if (young)
+				swp_entry = make_migration_entry_young(swp_entry);
 			entry = swp_entry_to_pte(swp_entry);
 			if (soft_dirty)
 				entry = pte_swp_mksoft_dirty(entry);
@@ -3148,6 +3150,8 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		entry = make_readable_exclusive_migration_entry(page_to_pfn(page));
 	else
 		entry = make_readable_migration_entry(page_to_pfn(page));
+	if (pmd_young(pmdval))
+		entry = make_migration_entry_young(entry);
 	pmdswp = swp_entry_to_pmd(entry);
 	if (pmd_soft_dirty(pmdval))
 		pmdswp = pmd_swp_mksoft_dirty(pmdswp);
@@ -3173,13 +3177,15 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
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
 
 	if (PageAnon(new)) {
 		rmap_t rmap_flags = RMAP_COMPOUND;
diff --git a/mm/migrate.c b/mm/migrate.c
index 1649270bc1a7..62cb3a9451de 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -199,7 +199,7 @@ static bool remove_migration_pte(struct folio *folio,
 #endif
 
 		folio_get(folio);
-		pte = pte_mkold(mk_pte(new, READ_ONCE(vma->vm_page_prot)));
+		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
 		if (pte_swp_soft_dirty(*pvmw.pte))
 			pte = pte_mksoft_dirty(pte);
 
@@ -207,6 +207,8 @@ static bool remove_migration_pte(struct folio *folio,
 		 * Recheck VMA as permissions can change since migration started
 		 */
 		entry = pte_to_swp_entry(*pvmw.pte);
+		if (!is_migration_entry_young(entry))
+			pte = pte_mkold(pte);
 		if (is_writable_migration_entry(entry))
 			pte = maybe_mkwrite(pte, vma);
 		else if (pte_swp_uffd_wp(*pvmw.pte))
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 7feeb447e3b9..fd8daf45c1a6 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -221,6 +221,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			else
 				entry = make_readable_migration_entry(
 							page_to_pfn(page));
+			if (pte_young(pte))
+				entry = make_migration_entry_young(entry);
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_present(pte)) {
 				if (pte_soft_dirty(pte))
diff --git a/mm/rmap.c b/mm/rmap.c
index af775855e58f..605fb37ae95e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2065,7 +2065,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			else
 				entry = make_readable_migration_entry(
 							page_to_pfn(subpage));
-
+			if (pte_young(pteval))
+				entry = make_migration_entry_young(entry);
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_soft_dirty(pteval))
 				swp_pte = pte_swp_mksoft_dirty(swp_pte);
-- 
2.32.0

