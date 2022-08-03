Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C228588559
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiHCBWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHCBWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAEFB558CB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 18:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659489725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dwFW3K3FIJLlM5PL8SE9IfeEGlQLs9/vUgiVy5snic8=;
        b=jVmjF/EXuYsv7G2ctkbcqIGWY4dSqnPSFGlodC92TvqATK3l0xOTsCDyYSZcwvBtb3Qg2x
        LiJa1QEk67b1DERcLACoNmNuCqO8COz6l9lFRTwDdaTQMpbVH39J1HCKqgAcSn+36rYTIH
        wCJ88g/c3P6Pz6F+zDiBNGAiShi9adk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-FVHlSvC_McyqEqD_44B-vw-1; Tue, 02 Aug 2022 21:22:04 -0400
X-MC-Unique: FVHlSvC_McyqEqD_44B-vw-1
Received: by mail-qt1-f200.google.com with SMTP id h21-20020ac87775000000b0031f1f223ccaso10178130qtu.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 18:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwFW3K3FIJLlM5PL8SE9IfeEGlQLs9/vUgiVy5snic8=;
        b=niB5/UCHMDmo0k4DvkrXEGEWY8i6E/fEMDQudef/mrXtwPJCtFimkzyuOQ6/5UrBL9
         eTTiHflGs7RLsvqxs4XEOHz2MFsJV6XVzEwmsbL9GqdKjXPzSX2vOkpO75Rc4vYZRsaT
         +f7BGGcF7FUHn+fjq4v09kGBX9tRGHd8pVzbdaFe008Nx83O7+S74eJi3dUZYqdogJse
         1Gu9N5ry/RCjHxIaNppFlXPIYrlX399UTEmllhXIYoTYihkqFhnJk4uFodyqua9L/K0L
         Ev7Xk2iWNuaWOVLhsyfkYkxs4qH4r0a/G6VtObnv+pbfe6m3KBe5jQkRQ0OWsWxyfSyV
         XY9g==
X-Gm-Message-State: AJIora8mguKqQVElX9b5NzL9nMA2oS01Ew/vzNHga2L4HfTNWA6ExHi2
        sy/jEa+TRPzu6FU554Y/YiL5esu0vrgT0jl0VTo+9YOV6N0teBmkN+GAhHlM+I3qBKEy8y58mI/
        lwE2FUVeRIpqhoSFbi1WRfxd88EkiPbx1Jdqt7W9jQfamt7qo2I+5u5CVPO6Esn8PLIlZv0E0Ig
        ==
X-Received: by 2002:ac8:7c44:0:b0:31f:3dc4:25db with SMTP id o4-20020ac87c44000000b0031f3dc425dbmr19999734qtv.612.1659489724001;
        Tue, 02 Aug 2022 18:22:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vcCeyVFHNZ4J0x6f6CT837Cgo29iD5JJtGhHFxRi5vGQQcZIMOdr25aBzXu4mipHkZozTZMg==
X-Received: by 2002:ac8:7c44:0:b0:31f:3dc4:25db with SMTP id o4-20020ac87c44000000b0031f3dc425dbmr19999717qtv.612.1659489723682;
        Tue, 02 Aug 2022 18:22:03 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id s16-20020a05622a1a9000b0031ecce4077fsm10188675qtc.31.2022.08.02.18.22.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Aug 2022 18:22:03 -0700 (PDT)
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
Subject: [PATCH 1/2] mm/swap: Add swp_offset_pfn() to fetch PFN from swap entry
Date:   Tue,  2 Aug 2022 21:21:58 -0400
Message-Id: <20220803012159.36551-2-peterx@redhat.com>
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

We've got a bunch of special swap entries that stores PFN inside the swap
offset fields.  To fetch the PFN, normally the user just calls swp_offset()
assuming that'll be the PFN.

Add a helper swp_offset_pfn() to fetch the PFN instead, fetching only the
max possible length of a PFN on the host, meanwhile doing proper check with
MAX_PHYSMEM_BITS to make sure the swap offsets can actually store the PFNs
properly always using the BUILD_BUG_ON() in is_pfn_swap_entry().

One reason to do so is we never tried to sanitize whether swap offset can
really fit for storing PFN.  At the meantime, this patch also prepares us
with the future possibility to store more information inside the swp offset
field, so assuming "swp_offset(entry)" to be the PFN will not stand any
more very soon.

Replace many of the swp_offset() callers to use swp_offset_pfn() where
proper.  Note that many of the existing users are not candidates for the
replacement, e.g.:

  (1) When the swap entry is not a pfn swap entry at all, or,
  (2) when we wanna keep the whole swp_offset but only change the swp type.

For the latter, it can happen when fork() triggered on a write-migration
swap entry pte, we may want to only change the migration type from
write->read but keep the rest, so it's not "fetching PFN" but "changing
swap type only".  They're left aside so that when there're more information
within the swp offset they'll be carried over naturally in those cases.

Since at it, dropping hwpoison_entry_to_pfn() because that's exactly what
the new swp_offset_pfn() is about.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/hugetlbpage.c |  2 +-
 include/linux/swapops.h     | 35 +++++++++++++++++++++++++++++------
 mm/hmm.c                    |  2 +-
 mm/memory-failure.c         |  2 +-
 mm/page_vma_mapped.c        |  6 +++---
 5 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 7430060cb0d6..f897d40821dd 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -242,7 +242,7 @@ static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
 {
 	VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
 
-	return page_folio(pfn_to_page(swp_offset(entry)));
+	return page_folio(pfn_to_page(swp_offset_pfn(entry)));
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index a3d435bf9f97..1d17e4bb3d2f 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -23,6 +23,20 @@
 #define SWP_TYPE_SHIFT	(BITS_PER_XA_VALUE - MAX_SWAPFILES_SHIFT)
 #define SWP_OFFSET_MASK	((1UL << SWP_TYPE_SHIFT) - 1)
 
+/*
+ * Definitions only for PFN swap entries (see is_pfn_swap_entry()).  To
+ * store PFN, we only need SWP_PFN_BITS bits.  Each of the pfn swap entries
+ * can use the extra bits to store other information besides PFN.
+ */
+#ifdef MAX_PHYSMEM_BITS
+#define SWP_PFN_BITS			(MAX_PHYSMEM_BITS - PAGE_SHIFT)
+#else
+#define SWP_PFN_BITS			(BITS_PER_LONG - PAGE_SHIFT)
+#endif
+#define SWP_PFN_MASK			((1UL << SWP_PFN_BITS) - 1)
+
+static inline bool is_pfn_swap_entry(swp_entry_t entry);
+
 /* Clear all flags but only keep swp_entry_t related information */
 static inline pte_t pte_swp_clear_flags(pte_t pte)
 {
@@ -64,6 +78,17 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
 	return entry.val & SWP_OFFSET_MASK;
 }
 
+/*
+ * This should only be called upon a pfn swap entry to get the PFN stored
+ * in the swap entry.  Please refers to is_pfn_swap_entry() for definition
+ * of pfn swap entry.
+ */
+static inline unsigned long swp_offset_pfn(swp_entry_t entry)
+{
+	VM_BUG_ON(!is_pfn_swap_entry(entry));
+	return swp_offset(entry) & SWP_PFN_MASK;
+}
+
 /* check whether a pte points to a swap entry */
 static inline int is_swap_pte(pte_t pte)
 {
@@ -369,7 +394,7 @@ static inline int pte_none_mostly(pte_t pte)
 
 static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 {
-	struct page *p = pfn_to_page(swp_offset(entry));
+	struct page *p = pfn_to_page(swp_offset_pfn(entry));
 
 	/*
 	 * Any use of migration entries may only occur while the
@@ -387,6 +412,9 @@ static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
  */
 static inline bool is_pfn_swap_entry(swp_entry_t entry)
 {
+	/* Make sure the swp offset can always store the needed fields */
+	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
+
 	return is_migration_entry(entry) || is_device_private_entry(entry) ||
 	       is_device_exclusive_entry(entry);
 }
@@ -475,11 +503,6 @@ static inline int is_hwpoison_entry(swp_entry_t entry)
 	return swp_type(entry) == SWP_HWPOISON;
 }
 
-static inline unsigned long hwpoison_entry_to_pfn(swp_entry_t entry)
-{
-	return swp_offset(entry);
-}
-
 static inline void num_poisoned_pages_inc(void)
 {
 	atomic_long_inc(&num_poisoned_pages);
diff --git a/mm/hmm.c b/mm/hmm.c
index f2aa63b94d9b..3850fb625dda 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -253,7 +253,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			cpu_flags = HMM_PFN_VALID;
 			if (is_writable_device_private_entry(entry))
 				cpu_flags |= HMM_PFN_WRITE;
-			*hmm_pfn = swp_offset(entry) | cpu_flags;
+			*hmm_pfn = swp_offset_pfn(entry) | cpu_flags;
 			return 0;
 		}
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index cc6fc9be8d22..e451219124dd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -632,7 +632,7 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 		swp_entry_t swp = pte_to_swp_entry(pte);
 
 		if (is_hwpoison_entry(swp))
-			pfn = hwpoison_entry_to_pfn(swp);
+			pfn = swp_offset_pfn(swp);
 	}
 
 	if (!pfn || pfn != poisoned_pfn)
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 8e9e574d535a..93e13fc17d3c 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -86,7 +86,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 		    !is_device_exclusive_entry(entry))
 			return false;
 
-		pfn = swp_offset(entry);
+		pfn = swp_offset_pfn(entry);
 	} else if (is_swap_pte(*pvmw->pte)) {
 		swp_entry_t entry;
 
@@ -96,7 +96,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 		    !is_device_exclusive_entry(entry))
 			return false;
 
-		pfn = swp_offset(entry);
+		pfn = swp_offset_pfn(entry);
 	} else {
 		if (!pte_present(*pvmw->pte))
 			return false;
@@ -221,7 +221,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				entry = pmd_to_swp_entry(pmde);
 				if (!is_migration_entry(entry) ||
-				    !check_pmd(swp_offset(entry), pvmw))
+				    !check_pmd(swp_offset_pfn(entry), pvmw))
 					return not_found(pvmw);
 				return true;
 			}
-- 
2.32.0

