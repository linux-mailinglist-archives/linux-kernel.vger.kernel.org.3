Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656DF584960
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiG2Bk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiG2Bku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EDF01B7BA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659058848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Pdq3GP5K2kZBYouzoKDRpFce2r59+NT7hzfgEhUpfY=;
        b=LN4DbB7wFQlmk1Ax2mYy2jguonAZHqeC9umsChtd4Hqi6CrTq+Od2tTmumfcycHpUWBoMv
        XAd9jUp+c72AGFtK7qT7ROLfY98Rfi2mZWm67hir76gpmgC2/iRQGNjaTPK4qMSoDjQqyb
        7thTz7bIdngZb/UwSHsTNvP+QdnllM8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-MdSueNcYPOCQeuklAageSw-1; Thu, 28 Jul 2022 21:40:47 -0400
X-MC-Unique: MdSueNcYPOCQeuklAageSw-1
Received: by mail-qt1-f199.google.com with SMTP id r5-20020ac85c85000000b0031ecf611c64so2094473qta.23
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Pdq3GP5K2kZBYouzoKDRpFce2r59+NT7hzfgEhUpfY=;
        b=fXUlsx6HH1AgjAo+tEEdnU3RmSffGnnSCXdkiXn5oSt5qszzfwOSOA7XANIwQ47gGc
         7nvx8c4JYXScx+Wy/1TH1mMZ/Ui1m4w9RJC4UcJ6rdWvHoGuhLoYgIjSK9RF2tsytlJr
         sChP1yhR1I8MlMuqFoJbfT8JNRxVoeXUYrA9CmcHc/3EaV2m6xKcJLQbElKd0ngpWVAd
         LUHEo0IHdhJK2dM4kTdIiKdvbeisyCk6zA8SwB/xpJaItNgHPwWJcEJ85O2i0mQy/S3v
         IbsKELZHSBfMfEh6CVeGIumAfhHYp9M+YJoBlrbN2NaUi30f+Q02LFu5pYghw5ywu+HD
         vDwg==
X-Gm-Message-State: AJIora//F3EweO2bHAMSCT9wbVRDbWEGU+5K8DFkZD3EfAiB7LfSV2j+
        Bv7DU6jym9tHNsKauLKwkDwYxG5i27Tj+wVUgcSzdrCrBlIl1x+pL8P349xgzXlMiyTWXAca5gx
        D/mSNajn8fzEpB26G/PqncY3S
X-Received: by 2002:a37:3c3:0:b0:6b5:cd61:cef with SMTP id 186-20020a3703c3000000b006b5cd610cefmr1179617qkd.368.1659058846481;
        Thu, 28 Jul 2022 18:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uTTF+MpDAe6hgcAbyvybxSoNRT6Fd6ul/QwMr7NbcBL/2EhxKg35/KJlM9ChukfGVxvuJLdw==
X-Received: by 2002:a37:3c3:0:b0:6b5:cd61:cef with SMTP id 186-20020a3703c3000000b006b5cd610cefmr1179603qkd.368.1659058846218;
        Thu, 28 Jul 2022 18:40:46 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id u9-20020a05620a454900b006b259b5dd12sm1584531qkp.53.2022.07.28.18.40.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Jul 2022 18:40:45 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFC 2/4] mm: Remember young bit for page migrations
Date:   Thu, 28 Jul 2022 21:40:39 -0400
Message-Id: <20220729014041.21292-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220729014041.21292-1-peterx@redhat.com>
References: <20220729014041.21292-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
because the moving page can be actively accessed within the procedure.

Actually we can easily remember the young bit configuration and make that
information recovered when the page is migrated.  To achieve it, define a
new bit in the migration swap offset field to show whether the old pte has
young bit set or not.  Then when removing/recovering the migration entry,
we can recover the young bit even if the page changed.

One thing to mention is that the whole feature is based on an arch specific
macro __ARCH_SWP_OFFSET_BITS that needs to be defined per-arch.  The macro
tells how many bits are available for the arch specific swp offset field.
When that macro is not defined, we'll assume we don't have free bits in the
migration swap entry offset, so we can't persist the young bit.

So until now, there should have no functional change at all with this
patch, since no arch has yet defined __ARCH_SWP_OFFSET_BITS.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h | 57 +++++++++++++++++++++++++++++++++++++++++
 mm/huge_memory.c        | 10 ++++++--
 mm/migrate.c            |  4 ++-
 mm/migrate_device.c     |  2 ++
 mm/rmap.c               |  3 ++-
 5 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 5378f77860fb..3bbb57aa6742 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -31,6 +31,28 @@
 #define SWP_PFN_BITS			(MAX_PHYSMEM_BITS - PAGE_SHIFT)
 #define SWP_PFN_MASK			((1UL << SWP_PFN_BITS) - 1)
 
+#ifdef __ARCH_SWP_OFFSET_BITS
+#define  SWP_PFN_OFFSET_FREE_BITS	(__ARCH_SWP_OFFSET_BITS - SWP_PFN_BITS)
+#else
+/*
+ * If __ARCH_SWP_OFFSET_BITS not defined, assuming we don't have free bits
+ * to be on the safe side.
+ */
+#define  SWP_PFN_OFFSET_FREE_BITS	0
+#endif
+
+/**
+ * Migration swap entry specific bitfield definitions.
+ *
+ * @SWP_MIG_YOUNG_BIT: Whether the page used to have young bit set
+ *
+ * Note: these bits will be used only if there're free bits in arch
+ * specific swp offset field.  Arch needs __ARCH_SWP_OFFSET_BITS defined to
+ * use the bits/features.
+ */
+#define SWP_MIG_YOUNG_BIT		(1UL << SWP_PFN_BITS)
+#define SWP_MIG_OFFSET_BITS		(SWP_PFN_BITS + 1)
+
 /* Clear all flags but only keep swp_entry_t related information */
 static inline pte_t pte_swp_clear_flags(pte_t pte)
 {
@@ -258,6 +280,30 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
 	return swp_entry(SWP_MIGRATION_WRITE, offset);
 }
 
+static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
+{
+	/*
+	 * Due to a limitation on x86_64 we can't use #ifdef, as
+	 * SWP_PFN_OFFSET_FREE_BITS value can be changed dynamically for
+	 * 4/5 level pgtables.  For all the non-x86_64 archs (where the
+	 * macro MAX_PHYSMEM_BITS is constant) this branching should be
+	 * optimized out by the compiler.
+	 */
+	if (SWP_PFN_OFFSET_FREE_BITS)
+		return swp_entry(swp_type(entry),
+				 swp_offset(entry) | SWP_MIG_YOUNG_BIT);
+	return entry;
+}
+
+static inline bool is_migration_entry_young(swp_entry_t entry)
+{
+	/* Please refer to comment in make_migration_entry_young() */
+	if (SWP_PFN_OFFSET_FREE_BITS)
+		return swp_offset(entry) & SWP_MIG_YOUNG_BIT;
+	/* Keep the old behavior of aging page after migration */
+	return false;
+}
+
 extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 					spinlock_t *ptl);
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
@@ -304,6 +350,16 @@ static inline int is_readable_migration_entry(swp_entry_t entry)
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
@@ -407,6 +463,7 @@ static inline bool is_pfn_swap_entry(swp_entry_t entry)
 {
 	/* Make sure the swp offset can always store the needed fields */
 	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
+	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_MIG_OFFSET_BITS);
 
 	return is_migration_entry(entry) || is_device_private_entry(entry) ||
 	       is_device_exclusive_entry(entry);
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

