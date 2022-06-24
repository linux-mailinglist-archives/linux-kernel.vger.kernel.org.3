Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E632E55A045
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiFXRin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiFXRhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92055DF25
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-317bfb7aaacso27132397b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LoJsmKx0RIJYFCgh3RUmS9FnkZR9nxjSRnqvv6TZGjM=;
        b=IZS4DM3M3K6LoUVsC8Bl04dfOKEEAWyhZp/PaBKn0d92TIDnzwMDFN7wLf3gZK8KXk
         Hqp1S+enLGzviCJsO6DpNpGzxKEp+T0yzrdIwA4S415ZdLqTsoPiTRgFb6aOA0kKPBAY
         zyheLmcN2aPMf7MJVwN4znu5j9nveQnM+HbQGBNnfXtj5p0uhIS5X82WJqumvoFeu78Z
         kexFoLJRgVhL59k8quEJaOagGrrlQ0qdHEHVyls+GVapUIwLCmrA+dHzKoYHQOi/e8xv
         vUWXfvm60zyRjMUV+v9MtvRAUv6UlhcNITygQafNxgge+q1x6oNJBsUIR4wKbgjkQNng
         /GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LoJsmKx0RIJYFCgh3RUmS9FnkZR9nxjSRnqvv6TZGjM=;
        b=qhJaJYFMdgMXch3NHyQbh2BWhh79AeaKbusfwGTc3gYPNmUNXo12QnXnc03E9BFO2M
         FxG1bauGMQOE360jE9iRTQOuXqwInl7tF6hPDoCODVTZvHA6tICerruHOoyMatsQWRNp
         16LCIE9d7yeBeFEsz4pBzWHejp7U1XBJKlJIRurrcE3wmzASEbMpxY4/njaXim32IUn9
         plnlYc0GmrqrKadVuAr/1FRhVTqwCCTHQGac0I+n6M8+XAJxqLrcHBtyk/mNK20ljBQC
         fuzH+BQyMaW5A9t+hw+oAEvG+BHHtgGdDwShiCk8z2G/plXf7zh5cjSExgMiEf1nPwFz
         A63w==
X-Gm-Message-State: AJIora8WKIvIYBI0GQdzUxqdtQKysUk7jBSrpBQn9S0BdPl5CIax/qX3
        Q6LKW8f2xJTnRx+jKQCddUwF2SNuxVZGXJ+4
X-Google-Smtp-Source: AGRyM1se79AgT0Cox1n1PfeD3monM06aR7cLfdIp8zaSZ2VT02A9SECnyrpKDnZIvwtzr+hFf9tsMPJX4L1dTD28
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:7801:0:b0:669:b51b:10d0 with SMTP
 id t1-20020a257801000000b00669b51b10d0mr331321ybc.204.1656092251057; Fri, 24
 Jun 2022 10:37:31 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:45 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-16-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 15/26] hugetlb: make unmapping compatible with
 high-granularity mappings
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enlightens __unmap_hugepage_range to deal with high-granularity
mappings. This doesn't change its API; it still must be called with
hugepage alignment, but it will correctly unmap hugepages that have been
mapped at high granularity.

Analogous to the mapcount rules introduced by hugetlb_no_page, we only
drop mapcount in this case if we are unmapping an entire hugepage in one
operation. This is the case when a VMA is destroyed.

Eventually, functionality here can be expanded to allow users to call
MADV_DONTNEED on PAGE_SIZE-aligned sections of a hugepage, but that is
not done here.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/asm-generic/tlb.h |  6 +--
 mm/hugetlb.c              | 85 ++++++++++++++++++++++++++-------------
 2 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index ff3e82553a76..8daa3ae460d9 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -562,9 +562,9 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 		__tlb_remove_tlb_entry(tlb, ptep, address);	\
 	} while (0)
 
-#define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
+#define tlb_remove_huge_tlb_entry(tlb, hpte, address)	\
 	do {							\
-		unsigned long _sz = huge_page_size(h);		\
+		unsigned long _sz = hugetlb_pte_size(&hpte);	\
 		if (_sz >= P4D_SIZE)				\
 			tlb_flush_p4d_range(tlb, address, _sz);	\
 		else if (_sz >= PUD_SIZE)			\
@@ -573,7 +573,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 			tlb_flush_pmd_range(tlb, address, _sz);	\
 		else						\
 			tlb_flush_pte_range(tlb, address, _sz);	\
-		__tlb_remove_tlb_entry(tlb, ptep, address);	\
+		__tlb_remove_tlb_entry(tlb, hpte.ptep, address);\
 	} while (0)
 
 /**
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index da30621656b8..51fc1d3f122f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5120,24 +5120,20 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
-	pte_t *ptep;
+	struct hugetlb_pte hpte;
 	pte_t pte;
 	spinlock_t *ptl;
-	struct page *page;
+	struct page *hpage, *subpage;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
 	struct mmu_notifier_range range;
 	bool force_flush = false;
+	bool hgm_enabled = hugetlb_hgm_enabled(vma);
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON(start & ~huge_page_mask(h));
 	BUG_ON(end & ~huge_page_mask(h));
 
-	/*
-	 * This is a hugetlb vma, all the pte entries should point
-	 * to huge page.
-	 */
-	tlb_change_page_size(tlb, sz);
 	tlb_start_vma(tlb, vma);
 
 	/*
@@ -5148,25 +5144,43 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
 	mmu_notifier_invalidate_range_start(&range);
 	address = start;
-	for (; address < end; address += sz) {
-		ptep = huge_pte_offset(mm, address, sz);
-		if (!ptep)
+
+	while (address < end) {
+		pte_t *ptep = huge_pte_offset(mm, address, sz);
+
+		if (!ptep) {
+			address += sz;
 			continue;
+		}
+		hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h));
+		if (hgm_enabled) {
+			int ret = huge_pte_alloc_high_granularity(
+					&hpte, mm, vma, address, PAGE_SHIFT,
+					HUGETLB_SPLIT_NEVER,
+					/*write_locked=*/true);
+			/*
+			 * We will never split anything, so this should always
+			 * succeed.
+			 */
+			BUG_ON(ret);
+		}
 
-		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
+		ptl = hugetlb_pte_lock(mm, &hpte);
+		if (!hgm_enabled && huge_pmd_unshare(
+					mm, vma, &address, hpte.ptep)) {
 			spin_unlock(ptl);
 			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
 			force_flush = true;
-			continue;
+			goto next_hpte;
 		}
 
-		pte = huge_ptep_get(ptep);
-		if (huge_pte_none(pte)) {
+		if (hugetlb_pte_none(&hpte)) {
 			spin_unlock(ptl);
-			continue;
+			goto next_hpte;
 		}
 
+		pte = hugetlb_ptep_get(&hpte);
+
 		/*
 		 * Migrating hugepage or HWPoisoned hugepage is already
 		 * unmapped and its refcount is dropped, so just clear pte here.
@@ -5180,24 +5194,27 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 			 */
 			if (pte_swp_uffd_wp_any(pte) &&
 			    !(zap_flags & ZAP_FLAG_DROP_MARKER))
-				set_huge_pte_at(mm, address, ptep,
+				set_huge_pte_at(mm, address, hpte.ptep,
 						make_pte_marker(PTE_MARKER_UFFD_WP));
 			else
-				huge_pte_clear(mm, address, ptep, sz);
+				huge_pte_clear(mm, address, hpte.ptep,
+						hugetlb_pte_size(&hpte));
 			spin_unlock(ptl);
-			continue;
+			goto next_hpte;
 		}
 
-		page = pte_page(pte);
+		subpage = pte_page(pte);
+		BUG_ON(!subpage);
+		hpage = compound_head(subpage);
 		/*
 		 * If a reference page is supplied, it is because a specific
 		 * page is being unmapped, not a range. Ensure the page we
 		 * are about to unmap is the actual page of interest.
 		 */
 		if (ref_page) {
-			if (page != ref_page) {
+			if (hpage != ref_page) {
 				spin_unlock(ptl);
-				continue;
+				goto next_hpte;
 			}
 			/*
 			 * Mark the VMA as having unmapped its page so that
@@ -5207,25 +5224,35 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
 		}
 
-		pte = huge_ptep_get_and_clear(mm, address, ptep);
-		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
+		pte = huge_ptep_get_and_clear(mm, address, hpte.ptep);
+		tlb_change_page_size(tlb, hugetlb_pte_size(&hpte));
+		tlb_remove_huge_tlb_entry(tlb, hpte, address);
 		if (huge_pte_dirty(pte))
-			set_page_dirty(page);
+			set_page_dirty(hpage);
 		/* Leave a uffd-wp pte marker if needed */
 		if (huge_pte_uffd_wp(pte) &&
 		    !(zap_flags & ZAP_FLAG_DROP_MARKER))
-			set_huge_pte_at(mm, address, ptep,
+			set_huge_pte_at(mm, address, hpte.ptep,
 					make_pte_marker(PTE_MARKER_UFFD_WP));
-		hugetlb_count_sub(pages_per_huge_page(h), mm);
-		page_remove_rmap(page, vma, true);
+
+		hugetlb_count_sub(hugetlb_pte_size(&hpte)/PAGE_SIZE, mm);
+
+		/*
+		 * If we are unmapping the entire page, remove it from the
+		 * rmap.
+		 */
+		if (IS_ALIGNED(address, sz) && address + sz <= end)
+			page_remove_rmap(hpage, vma, true);
 
 		spin_unlock(ptl);
-		tlb_remove_page_size(tlb, page, huge_page_size(h));
+		tlb_remove_page_size(tlb, subpage, hugetlb_pte_size(&hpte));
 		/*
 		 * Bail out after unmapping reference page if supplied
 		 */
 		if (ref_page)
 			break;
+next_hpte:
+		address += hugetlb_pte_size(&hpte);
 	}
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_end_vma(tlb, vma);
-- 
2.37.0.rc0.161.g10f37bed90-goog

