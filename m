Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E977559FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiFXRir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiFXRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA6968024
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31859b57239so27211297b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ndW8f2/FMhLCn5Y2u5fQS3kI5t4rS7D1K1+5Zv5C8rs=;
        b=czqXqvIE/8k7tydJPozB7auTFGn2IWAhFN0QqqSLWSloUnswocGDGgUeo23aTjkMei
         kJVRiKE5/tiYCuHldEVJHKMPdnIu1VB4kfdTvkuHI+ANDJBJq4WBaukBrLfqF7kOY/tK
         MT6za/4MfqzLFtBFRgSQ5jACJHp8mD5dBxqaUXvHHjfCB4WTLOVkleis0beQo12/qieV
         0OirUq/zaPSgClUBBFEAredAa0pJS7lZV3B53aynse7fEXzlquNVE8V9XBV/gY5amf1H
         Zy8GYpedNEgd7iU2Q+yG3Q5EJxgpMOpVeMlp5AHPW2AVdClXpdfObc+IfRZlB5gzBNda
         kxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ndW8f2/FMhLCn5Y2u5fQS3kI5t4rS7D1K1+5Zv5C8rs=;
        b=YxLe2vLRfV+29HquSTz7n/MTPPAn6jsVEbivQGifBO2VpEs4TLbOStyxgkiEskQfzG
         byFYjtI4qRzmbHXDktW3efc96XUE0voXmRF5TjA3Gbp1Oj0q535dBMdy+SwaaqH3nvcL
         SYicltwGiT/66JhRU2UOa6CHLMDPHGOzSYW3H7uZHfPC9NxOwuQ9vre1zA1M0piUyUlA
         gRvLxBQn1IqR4Nopy8dozB6paaxc7nbNeyu/oe6vdhHyGvHKagaJm5P+7ZZ4PF5cVUva
         RKwGb3eVZKcX9hOEQEJsGARhSX3FSyKf5loZ93/Ekq69mhK9nKp6jHokvyp2SlhF0eYQ
         L7NQ==
X-Gm-Message-State: AJIora/ShY6t3Z7Lsvw05A0T8qkArSh+ntw2M2NnB/ytgtspFXKdm3pb
        bIDyZjnPy+1sGqf+mXgxjyneSN3rwC+T2/gN
X-Google-Smtp-Source: AGRyM1vf9VAPWkUYJ/WFD/esjoiahsG2GN/fHJroFrmfPTAWRMvqzCQsNWId7C9YuKC2vmXazC7krxj0p+91Xop2
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:f30f:0:b0:664:af3b:f83f with SMTP
 id c15-20020a25f30f000000b00664af3bf83fmr292571ybs.516.1656092252403; Fri, 24
 Jun 2022 10:37:32 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:46 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-17-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 16/26] hugetlb: make hugetlb_change_protection compatible
 with HGM
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

HugeTLB is now able to change the protection of hugepages that are
mapped at high granularity.

I need to add more of the HugeTLB PTE wrapper functions to clean up this
patch. I'll do this in the next version.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 91 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 29 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 51fc1d3f122f..f9c7daa6c090 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6476,14 +6476,15 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long start = address;
-	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0, psize = huge_page_size(h);
+	unsigned long base_pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
+	struct hugetlb_pte hpte;
+	bool hgm_enabled = hugetlb_hgm_enabled(vma);
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -6499,28 +6500,38 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 	mmu_notifier_invalidate_range_start(&range);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
-	for (; address < end; address += psize) {
+	while (address < end) {
 		spinlock_t *ptl;
-		ptep = huge_pte_offset(mm, address, psize);
-		if (!ptep)
+		pte_t *ptep = huge_pte_offset(mm, address, huge_page_size(h));
+
+		if (!ptep) {
+			address += huge_page_size(h);
 			continue;
-		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
+		}
+		hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h));
+		if (hgm_enabled) {
+			int ret = hugetlb_walk_to(mm, &hpte, address, PAGE_SIZE,
+						  /*stop_at_none=*/true);
+			BUG_ON(ret);
+		}
+
+		ptl = hugetlb_pte_lock(mm, &hpte);
+		if (huge_pmd_unshare(mm, vma, &address, hpte.ptep)) {
 			/*
 			 * When uffd-wp is enabled on the vma, unshare
 			 * shouldn't happen at all.  Warn about it if it
 			 * happened due to some reason.
 			 */
 			WARN_ON_ONCE(uffd_wp || uffd_wp_resolve);
-			pages++;
+			base_pages += hugetlb_pte_size(&hpte) / PAGE_SIZE;
 			spin_unlock(ptl);
 			shared_pmd = true;
-			continue;
+			goto next_hpte;
 		}
-		pte = huge_ptep_get(ptep);
+		pte = hugetlb_ptep_get(&hpte);
 		if (unlikely(is_hugetlb_entry_hwpoisoned(pte))) {
 			spin_unlock(ptl);
-			continue;
+			goto next_hpte;
 		}
 		if (unlikely(is_hugetlb_entry_migration(pte))) {
 			swp_entry_t entry = pte_to_swp_entry(pte);
@@ -6540,12 +6551,13 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 					newpte = pte_swp_mkuffd_wp(newpte);
 				else if (uffd_wp_resolve)
 					newpte = pte_swp_clear_uffd_wp(newpte);
-				set_huge_swap_pte_at(mm, address, ptep,
-						     newpte, psize);
-				pages++;
+				set_huge_swap_pte_at(mm, address, hpte.ptep,
+						     newpte,
+						     hugetlb_pte_size(&hpte));
+				base_pages += hugetlb_pte_size(&hpte) / PAGE_SIZE;
 			}
 			spin_unlock(ptl);
-			continue;
+			goto next_hpte;
 		}
 		if (unlikely(pte_marker_uffd_wp(pte))) {
 			/*
@@ -6553,21 +6565,40 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			 * no need for huge_ptep_modify_prot_start/commit().
 			 */
 			if (uffd_wp_resolve)
-				huge_pte_clear(mm, address, ptep, psize);
+				huge_pte_clear(mm, address, hpte.ptep, psize);
 		}
-		if (!huge_pte_none(pte)) {
+		if (!hugetlb_pte_none(&hpte)) {
 			pte_t old_pte;
-			unsigned int shift = huge_page_shift(hstate_vma(vma));
-
-			old_pte = huge_ptep_modify_prot_start(vma, address, ptep);
-			pte = huge_pte_modify(old_pte, newprot);
-			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
-			if (uffd_wp)
-				pte = huge_pte_mkuffd_wp(huge_pte_wrprotect(pte));
-			else if (uffd_wp_resolve)
-				pte = huge_pte_clear_uffd_wp(pte);
-			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
-			pages++;
+			unsigned int shift = hpte.shift;
+			/*
+			 * This is ugly. This will be cleaned up in a future
+			 * version of this series.
+			 */
+			if (shift > PAGE_SHIFT) {
+				old_pte = huge_ptep_modify_prot_start(
+						vma, address, hpte.ptep);
+				pte = huge_pte_modify(old_pte, newprot);
+				pte = arch_make_huge_pte(
+						pte, shift, vma->vm_flags);
+				if (uffd_wp)
+					pte = huge_pte_mkuffd_wp(huge_pte_wrprotect(pte));
+				else if (uffd_wp_resolve)
+					pte = huge_pte_clear_uffd_wp(pte);
+				huge_ptep_modify_prot_commit(
+						vma, address, hpte.ptep,
+						old_pte, pte);
+			} else {
+				old_pte = ptep_modify_prot_start(
+						vma, address, hpte.ptep);
+				pte = pte_modify(old_pte, newprot);
+				if (uffd_wp)
+					pte = pte_mkuffd_wp(pte_wrprotect(pte));
+				else if (uffd_wp_resolve)
+					pte = pte_clear_uffd_wp(pte);
+				ptep_modify_prot_commit(
+						vma, address, hpte.ptep, old_pte, pte);
+			}
+			base_pages += hugetlb_pte_size(&hpte) / PAGE_SIZE;
 		} else {
 			/* None pte */
 			if (unlikely(uffd_wp))
@@ -6576,6 +6607,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 						make_pte_marker(PTE_MARKER_UFFD_WP));
 		}
 		spin_unlock(ptl);
+next_hpte:
+		address += hugetlb_pte_size(&hpte);
 	}
 	/*
 	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare
@@ -6597,7 +6630,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
 	mmu_notifier_invalidate_range_end(&range);
 
-	return pages << h->order;
+	return base_pages;
 }
 
 /* Return true if reservation was successful, false otherwise.  */
-- 
2.37.0.rc0.161.g10f37bed90-goog

