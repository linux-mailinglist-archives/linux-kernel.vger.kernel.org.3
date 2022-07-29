Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B27584961
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiG2Bkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiG2Bkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 040751AD81
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659058846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ByVAEoHvRqEiYcceU8xxkCrxysohxn623txuIswhCFQ=;
        b=AGnBBDNawTY9n89dkIUkjnn3f1/h4NEr317fX45excq7z8DMljQxZ/Skv0Q64cfGP6zA+m
        MrkNeptRxDkY3rfyRTJ+BTLbWGQ82Ptzt+kZoYcoeuW6uJUPn6xhRKSlRKzOMwogMvbTa9
        kSrNOfguMLmK9PN1gqM7xLHYNLolrrU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-JSecT2YCNHaKi-wn9a09Dw-1; Thu, 28 Jul 2022 21:40:45 -0400
X-MC-Unique: JSecT2YCNHaKi-wn9a09Dw-1
Received: by mail-qv1-f70.google.com with SMTP id ok7-20020a0562143c8700b00472f0b33853so2419261qvb.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ByVAEoHvRqEiYcceU8xxkCrxysohxn623txuIswhCFQ=;
        b=iRpM/eW/YvAceDtJEhmcQ778ohqKs/4Y2lqMl/TPZ3R16SEnA7UHQPumQ4fbCxtzbt
         DMSJtHPyLMrletVtUNYdZpNOTh7K2u4BdUyjYcBPXfpON7jwf62FhxQYlYeQGoPVhJiP
         oFYK5yP85xPZ65O56F6ZqZPTykmiBsr4i7Pe1Sy2wOFFEQV1IZvf6wRYDb3TRDHR1RjR
         PRO3QyqsJL1OMpMcHsSC8mG2zJO5V/ULbq0VfC5/sCjqtUidKj3QJ7hv5AzNWAKRaP5x
         yDocM6gW4iIw7dUZZYfN+44IaW+LRWue6efpU8XJnlQr+ED87/f9F7VU66nqDTXxdpT2
         PutA==
X-Gm-Message-State: AJIora/VGYikd5kln2s/DYZ1UqRaJALfCYGkkcm8kkqFk1YAwTZjmyTv
        H3IE/BnNOSvZr/IynqAOUViWFlHRtXAr+xyhp++kMBXuJOpp0HG5jajMLEFQuEBo7fCZqpA504Y
        W4Gkb1ZrvEAvHdSLOiuAYF9L2
X-Received: by 2002:a05:622a:1a0d:b0:31e:da67:7cb4 with SMTP id f13-20020a05622a1a0d00b0031eda677cb4mr1543902qtb.643.1659058844956;
        Thu, 28 Jul 2022 18:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vm3fD51DEm5b8XSQBVK347L4yufDVjbS4SrwnC/QphKpN4yRq5nbIIELe355N7kwGIcwdXgA==
X-Received: by 2002:a05:622a:1a0d:b0:31e:da67:7cb4 with SMTP id f13-20020a05622a1a0d00b0031eda677cb4mr1543886qtb.643.1659058844712;
        Thu, 28 Jul 2022 18:40:44 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id u9-20020a05620a454900b006b259b5dd12sm1584531qkp.53.2022.07.28.18.40.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Jul 2022 18:40:44 -0700 (PDT)
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
Subject: [PATCH RFC 1/4] mm/swap: Add swp_offset_pfn() to fetch PFN from swap entry
Date:   Thu, 28 Jul 2022 21:40:38 -0400
Message-Id: <20220729014041.21292-2-peterx@redhat.com>
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
 include/linux/swapops.h     | 28 ++++++++++++++++++++++------
 mm/hmm.c                    |  2 +-
 mm/memory-failure.c         |  2 +-
 mm/page_vma_mapped.c        |  6 +++---
 5 files changed, 28 insertions(+), 12 deletions(-)

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
index a3d435bf9f97..5378f77860fb 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -23,6 +23,14 @@
 #define SWP_TYPE_SHIFT	(BITS_PER_XA_VALUE - MAX_SWAPFILES_SHIFT)
 #define SWP_OFFSET_MASK	((1UL << SWP_TYPE_SHIFT) - 1)
 
+/*
+ * Definitions only for PFN swap entries (see is_pfn_swap_entry()).  To
+ * store PFN, we only need SWP_PFN_BITS bits.  Each of the pfn swap entries
+ * can use the extra bits to store other information besides PFN.
+ */
+#define SWP_PFN_BITS			(MAX_PHYSMEM_BITS - PAGE_SHIFT)
+#define SWP_PFN_MASK			((1UL << SWP_PFN_BITS) - 1)
+
 /* Clear all flags but only keep swp_entry_t related information */
 static inline pte_t pte_swp_clear_flags(pte_t pte)
 {
@@ -64,6 +72,16 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
 	return entry.val & SWP_OFFSET_MASK;
 }
 
+/*
+ * This should only be called upon a pfn swap entry to get the PFN stored
+ * in the swap entry.  Please refers to is_pfn_swap_entry() for definition
+ * of pfn swap entry.
+ */
+static inline unsigned long swp_offset_pfn(swp_entry_t entry)
+{
+	return swp_offset(entry) & SWP_PFN_MASK;
+}
+
 /* check whether a pte points to a swap entry */
 static inline int is_swap_pte(pte_t pte)
 {
@@ -369,7 +387,7 @@ static inline int pte_none_mostly(pte_t pte)
 
 static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 {
-	struct page *p = pfn_to_page(swp_offset(entry));
+	struct page *p = pfn_to_page(swp_offset_pfn(entry));
 
 	/*
 	 * Any use of migration entries may only occur while the
@@ -387,6 +405,9 @@ static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
  */
 static inline bool is_pfn_swap_entry(swp_entry_t entry)
 {
+	/* Make sure the swp offset can always store the needed fields */
+	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
+
 	return is_migration_entry(entry) || is_device_private_entry(entry) ||
 	       is_device_exclusive_entry(entry);
 }
@@ -475,11 +496,6 @@ static inline int is_hwpoison_entry(swp_entry_t entry)
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

