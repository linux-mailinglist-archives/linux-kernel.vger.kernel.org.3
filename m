Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14524CCCEB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiCDFTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbiCDFTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:19:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A2C7A94CE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1n551s1g6Vv5nncVOaasRljGy2eKMZ3v3Uj1KhN2rf0=;
        b=fbGMxW8+6krHsDzGXXd3WKlWlY33GitFA0YVt/tQKg+Jj7W0kSY6FHznPdzJM0vEnfwiJB
        gXqiMLCKoAI+aUb3Qihg6mSAGultsdfkhXHQqmpbQM5Z7A7Pl0FTpmC0FJn2khIR1/dNI7
        vrXtkVIn6To7KAvrZrIujgdOtOSRtjU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-WQneyNI5M4OPZyUzEPG8fw-1; Fri, 04 Mar 2022 00:18:21 -0500
X-MC-Unique: WQneyNI5M4OPZyUzEPG8fw-1
Received: by mail-pj1-f72.google.com with SMTP id m14-20020a17090a4d8e00b001bf2d4926c5so65704pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1n551s1g6Vv5nncVOaasRljGy2eKMZ3v3Uj1KhN2rf0=;
        b=FJ3QpLB5V4z7kiUkwhv+rE6Im2Dq1kZsq27QRWuOc/DG2Wq1l2pn5grJy42Bk+hdEX
         3GrNBqweT2u6f69Paj/FIpTh9o8hKF4R4OKJqCR/7o+/eUVZUdn1XiTGwvalse70DEbg
         jbc/BZhrGHDqj4XVk99c2AMn84BTJkGjoCfRUT6yxDiGpCVjPPB+DTSXw6kgdR/LvY27
         oQPsp7B1X4SmFqLS5g3No6xZyooYXh9qqHPRp1e8xrLnEjDwwkJI4UBjytkmgS6aLZRg
         waYncQSm64GWWv11D62UCoZkNusTRloNi/FjBIDVpAbNnvqOyOasivQ1ZNDAa4TYdu09
         4AtQ==
X-Gm-Message-State: AOAM5313I8VNSKPTSAoOnUmL9TTdgWq7AkkvO2vkUxikTraR+WNvpob/
        4BzW3SqH3sF7aJWpT09lv5eXOzMvn+zAPcSlUJ7h+eI+dPhbZTSDG47FOujVIasf5gRhvRg1/Iv
        yj/4nBXYXCloovaBkU1TXF4Lv
X-Received: by 2002:a17:902:7c13:b0:151:a784:34c7 with SMTP id x19-20020a1709027c1300b00151a78434c7mr7469091pll.174.1646371099464;
        Thu, 03 Mar 2022 21:18:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0fLWHy2rctiM2ENjL5ljsJ4tYkRpfVBiuZmQMy/vB+djlUOenh/QkOWrinBqK7A5FOggeSw==
X-Received: by 2002:a17:902:7c13:b0:151:a784:34c7 with SMTP id x19-20020a1709027c1300b00151a78434c7mr7469075pll.174.1646371099075;
        Thu, 03 Mar 2022 21:18:19 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.18.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:18:18 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 07/23] mm/shmem: Persist uffd-wp bit across zapping for file-backed
Date:   Fri,  4 Mar 2022 13:16:52 +0800
Message-Id: <20220304051708.86193-8-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304051708.86193-1-peterx@redhat.com>
References: <20220304051708.86193-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File-backed memory is prone to being unmapped at any time.  It means all
information in the pte will be dropped, including the uffd-wp flag.

To persist the uffd-wp flag, we'll use the pte markers.  This patch teaches the
zap code to understand uffd-wp and know when to keep or drop the uffd-wp bit.

Add a new flag ZAP_FLAG_DROP_MARKER and set it in zap_details when we don't
want to persist such an information, for example, when destroying the whole
vma, or punching a hole in a shmem file.  For the rest cases we should never
drop the uffd-wp bit, or the wr-protect information will get lost.

The new ZAP_FLAG_DROP_MARKER needs to be put into mm.h rather than memory.c
because it'll be further referenced in hugetlb files later.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h        | 10 ++++++++
 include/linux/mm_inline.h | 43 ++++++++++++++++++++++++++++++++++
 mm/memory.c               | 49 ++++++++++++++++++++++++++++++++++++---
 mm/rmap.c                 |  8 +++++++
 4 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0b9a0334d0f8..cdefbb078a73 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3385,4 +3385,14 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 }
 #endif
 
+typedef unsigned int __bitwise zap_flags_t;
+
+/*
+ * Whether to drop the pte markers, for example, the uffd-wp information for
+ * file-backed memory.  This should only be specified when we will completely
+ * drop the page in the mm, either by truncation or unmapping of the vma.  By
+ * default, the flag is not set.
+ */
+#define  ZAP_FLAG_DROP_MARKER        ((__force zap_flags_t) BIT(0))
+
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index ac32125745ab..70e72ce85b25 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -6,6 +6,8 @@
 #include <linux/huge_mm.h>
 #include <linux/swap.h>
 #include <linux/string.h>
+#include <linux/userfaultfd_k.h>
+#include <linux/swapops.h>
 
 /**
  * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
@@ -316,5 +318,46 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
 	return atomic_read(&mm->tlb_flush_pending) > 1;
 }
 
+/*
+ * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
+ * replace a none pte.  NOTE!  This should only be called when *pte is already
+ * cleared so we will never accidentally replace something valuable.  Meanwhile
+ * none pte also means we are not demoting the pte so tlb flushed is not needed.
+ * E.g., when pte cleared the caller should have taken care of the tlb flush.
+ *
+ * Must be called with pgtable lock held so that no thread will see the none
+ * pte, and if they see it, they'll fault and serialize at the pgtable lock.
+ *
+ * This function is a no-op if PTE_MARKER_UFFD_WP is not enabled.
+ */
+static inline void
+pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
+			      pte_t *pte, pte_t pteval)
+{
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
+	bool arm_uffd_pte = false;
+
+	/* The current status of the pte should be "cleared" before calling */
+	WARN_ON_ONCE(!pte_none(*pte));
+
+	if (vma_is_anonymous(vma))
+		return;
+
+	/* A uffd-wp wr-protected normal pte */
+	if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
+		arm_uffd_pte = true;
+
+	/*
+	 * A uffd-wp wr-protected swap pte.  Note: this should even cover an
+	 * existing pte marker with uffd-wp bit set.
+	 */
+	if (unlikely(pte_swp_uffd_wp_any(pteval)))
+		arm_uffd_pte = true;
+
+	if (unlikely(arm_uffd_pte))
+		set_pte_at(vma->vm_mm, addr, pte,
+			   make_pte_marker(PTE_MARKER_UFFD_WP));
+#endif
+}
 
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index f509ddf2ad39..e3e67e32eb8a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -74,6 +74,7 @@
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
+#include <linux/mm_inline.h>
 
 #include <trace/events/kmem.h>
 
@@ -1310,6 +1311,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 struct zap_details {
 	struct folio *single_folio;	/* Locked folio to be unmapped */
 	bool even_cows;			/* Zap COWed private pages too? */
+	zap_flags_t zap_flags;		/* Extra flags for zapping */
 };
 
 /* Whether we should zap all COWed (private) pages too */
@@ -1338,6 +1340,29 @@ static inline bool should_zap_page(struct zap_details *details, struct page *pag
 	return !PageAnon(page);
 }
 
+static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
+{
+	if (!details)
+		return false;
+
+	return details->zap_flags & ZAP_FLAG_DROP_MARKER;
+}
+
+/*
+ * This function makes sure that we'll replace the none pte with an uffd-wp
+ * swap special pte marker when necessary. Must be with the pgtable lock held.
+ */
+static inline void
+zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
+			      unsigned long addr, pte_t *pte,
+			      struct zap_details *details, pte_t pteval)
+{
+	if (zap_drop_file_uffd_wp(details))
+		return;
+
+	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -1375,6 +1400,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
+			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
+						      ptent);
 			if (unlikely(!page))
 				continue;
 
@@ -1405,6 +1432,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			page = pfn_swap_entry_to_page(entry);
 			if (unlikely(!should_zap_page(details, page)))
 				continue;
+			/*
+			 * Both device private/exclusive mappings should only
+			 * work with anonymous page so far, so we don't need to
+			 * consider uffd-wp bit when zap. For more information,
+			 * see zap_install_uffd_wp_if_needed().
+			 */
+			WARN_ON_ONCE(!vma_is_anonymous(vma));
 			rss[mm_counter(page)]--;
 			if (is_device_private_entry(entry))
 				page_remove_rmap(page, vma, false);
@@ -1421,8 +1455,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (!should_zap_page(details, page))
 				continue;
 			rss[mm_counter(page)]--;
-		} else if (is_pte_marker_entry(entry)) {
-			/* By default, simply drop all pte markers when zap */
+		} else if (pte_marker_entry_uffd_wp(entry)) {
+			/* Only drop the uffd-wp marker if explicitly requested */
+			if (!zap_drop_file_uffd_wp(details))
+				continue;
 		} else if (is_hwpoison_entry(entry)) {
 			if (!should_zap_cows(details))
 				continue;
@@ -1431,6 +1467,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			WARN_ON_ONCE(1);
 		}
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
 	add_mm_rss_vec(mm, rss);
@@ -1641,12 +1678,17 @@ void unmap_vmas(struct mmu_gather *tlb,
 		unsigned long end_addr)
 {
 	struct mmu_notifier_range range;
+	struct zap_details details = {
+		.zap_flags = ZAP_FLAG_DROP_MARKER,
+		/* Careful - we need to zap private pages too! */
+		.even_cows = true,
+	};
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
 	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
-		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
+		unmap_single_vma(tlb, vma, start_addr, end_addr, &details);
 	mmu_notifier_invalidate_range_end(&range);
 }
 
@@ -3391,6 +3433,7 @@ void unmap_mapping_folio(struct folio *folio)
 
 	details.even_cows = false;
 	details.single_folio = folio;
+	details.zap_flags = ZAP_FLAG_DROP_MARKER;
 
 	i_mmap_lock_write(mapping);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
diff --git a/mm/rmap.c b/mm/rmap.c
index 3d288a7c8c32..f83d812d0a5e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -73,6 +73,7 @@
 #include <linux/page_idle.h>
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/mm_inline.h>
 
 #include <asm/tlbflush.h>
 
@@ -1526,6 +1527,13 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			pteval = ptep_clear_flush(vma, address, pvmw.pte);
 		}
 
+		/*
+		 * Now the pte is cleared.  If this is uffd-wp armed pte, we
+		 * may want to replace a none pte with a marker pte if it's
+		 * file-backed, so we don't lose the tracking information.
+		 */
+		pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
+
 		/* Set the dirty flag on the folio now the pte is gone. */
 		if (pte_dirty(pteval))
 			folio_mark_dirty(folio);
-- 
2.32.0

