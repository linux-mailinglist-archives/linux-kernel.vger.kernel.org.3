Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB95517BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241007AbiFTLr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbiFTLr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:47:28 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2AEA47A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:47:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VGxGypi_1655725642;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VGxGypi_1655725642)
          by smtp.aliyun-inc.com;
          Mon, 20 Jun 2022 19:47:23 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: rmap: Simplify the hugetlb handling when unmapping or migration
Date:   Mon, 20 Jun 2022 19:47:15 +0800
Message-Id: <28414b1b96f095e838c1e548074f8e0fc70d78cf.1655724713.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to previous discussion [1], there are so many levels of indenting
to handle the hugetlb case when unmapping or migration. We can combine
folio_test_anon() and huge_pmd_unshare() to save one level of indenting,
by adding a local variable and moving the VM_BUG_ON() a little forward.

No intended functional changes in this patch.

[1] https://lore.kernel.org/all/0b986dc4-5843-3e2d-c2df-5a2e9f13e6ab@oracle.com/

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/rmap.c | 90 +++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 44 insertions(+), 46 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 04fac1a..2f48a54 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1537,6 +1537,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 PageAnonExclusive(subpage);
 
 		if (folio_test_hugetlb(folio)) {
+			bool anon = folio_test_anon(folio);
+
 			/*
 			 * The try_to_unmap() is only passed a hugetlb page
 			 * in the case where the hugetlb page is poisoned.
@@ -1551,31 +1553,28 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			flush_cache_range(vma, range.start, range.end);
 
-			if (!folio_test_anon(folio)) {
+			/*
+			 * To call huge_pmd_unshare, i_mmap_rwsem must be
+			 * held in write mode.  Caller needs to explicitly
+			 * do this outside rmap routines.
+			 */
+			VM_BUG_ON(!anon && !(flags & TTU_RMAP_LOCKED));
+			if (!anon && huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
+				flush_tlb_range(vma, range.start, range.end);
+				mmu_notifier_invalidate_range(mm, range.start,
+							      range.end);
+
 				/*
-				 * To call huge_pmd_unshare, i_mmap_rwsem must be
-				 * held in write mode.  Caller needs to explicitly
-				 * do this outside rmap routines.
+				 * The ref count of the PMD page was dropped
+				 * which is part of the way map counting
+				 * is done for shared PMDs.  Return 'true'
+				 * here.  When there is no other sharing,
+				 * huge_pmd_unshare returns false and we will
+				 * unmap the actual page and drop map count
+				 * to zero.
 				 */
-				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
-
-				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
-					flush_tlb_range(vma, range.start, range.end);
-					mmu_notifier_invalidate_range(mm, range.start,
-								      range.end);
-
-					/*
-					 * The ref count of the PMD page was dropped
-					 * which is part of the way map counting
-					 * is done for shared PMDs.  Return 'true'
-					 * here.  When there is no other sharing,
-					 * huge_pmd_unshare returns false and we will
-					 * unmap the actual page and drop map count
-					 * to zero.
-					 */
-					page_vma_mapped_walk_done(&pvmw);
-					break;
-				}
+				page_vma_mapped_walk_done(&pvmw);
+				break;
 			}
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
 		} else {
@@ -1906,6 +1905,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				 PageAnonExclusive(subpage);
 
 		if (folio_test_hugetlb(folio)) {
+			bool anon = folio_test_anon(folio);
+
 			/*
 			 * huge_pmd_unshare may unmap an entire PMD page.
 			 * There is no way of knowing exactly which PMDs may
@@ -1915,31 +1916,28 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			flush_cache_range(vma, range.start, range.end);
 
-			if (!folio_test_anon(folio)) {
+			/*
+			 * To call huge_pmd_unshare, i_mmap_rwsem must be
+			 * held in write mode.  Caller needs to explicitly
+			 * do this outside rmap routines.
+			 */
+			VM_BUG_ON(!anon && !(flags & TTU_RMAP_LOCKED));
+			if (!anon && huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
+				flush_tlb_range(vma, range.start, range.end);
+				mmu_notifier_invalidate_range(mm, range.start,
+							      range.end);
+
 				/*
-				 * To call huge_pmd_unshare, i_mmap_rwsem must be
-				 * held in write mode.  Caller needs to explicitly
-				 * do this outside rmap routines.
+				 * The ref count of the PMD page was dropped
+				 * which is part of the way map counting
+				 * is done for shared PMDs.  Return 'true'
+				 * here.  When there is no other sharing,
+				 * huge_pmd_unshare returns false and we will
+				 * unmap the actual page and drop map count
+				 * to zero.
 				 */
-				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
-
-				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
-					flush_tlb_range(vma, range.start, range.end);
-					mmu_notifier_invalidate_range(mm, range.start,
-								      range.end);
-
-					/*
-					 * The ref count of the PMD page was dropped
-					 * which is part of the way map counting
-					 * is done for shared PMDs.  Return 'true'
-					 * here.  When there is no other sharing,
-					 * huge_pmd_unshare returns false and we will
-					 * unmap the actual page and drop map count
-					 * to zero.
-					 */
-					page_vma_mapped_walk_done(&pvmw);
-					break;
-				}
+				page_vma_mapped_walk_done(&pvmw);
+				break;
 			}
 
 			/* Nuke the hugetlb page table entry */
-- 
1.8.3.1

