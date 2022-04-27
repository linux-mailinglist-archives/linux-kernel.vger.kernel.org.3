Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFDB5115C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiD0LFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiD0LDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:03:32 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A6048B885
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:52:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VBTIjXy_1651056735;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VBTIjXy_1651056735)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Apr 2022 18:52:16 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     almasrymina@google.com, songmuchun@bytedance.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] mm: rmap: Use flush_cache_range() to flush cache for hugetlb pages
Date:   Wed, 27 Apr 2022 18:52:07 +0800
Message-Id: <dc903b378d1e2d26bbbe85409ab9d009631f175c.1651056365.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
References: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
References: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we will use flush_cache_page() to flush cache for anonymous hugetlb
pages when unmapping or migrating a hugetlb page mapping, but the
flush_cache_page() only handles a PAGE_SIZE range on some architectures
(like arm32, arc and so on), which will cause potential cache issues.
Thus change to use flush_cache_range() to cover the whole size of a
hugetlb page.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/rmap.c | 90 ++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 4f0d115..6fdd198 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1528,13 +1528,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		anon_exclusive = folio_test_anon(folio) &&
 				 PageAnonExclusive(subpage);
 
-		if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
-			/*
-			 * To call huge_pmd_unshare, i_mmap_rwsem must be
-			 * held in write mode.  Caller needs to explicitly
-			 * do this outside rmap routines.
-			 */
-			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+		if (folio_test_hugetlb(folio)) {
 			/*
 			 * huge_pmd_unshare may unmap an entire PMD page.
 			 * There is no way of knowing exactly which PMDs may
@@ -1544,22 +1538,31 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			flush_cache_range(vma, range.start, range.end);
 
-			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
-				flush_tlb_range(vma, range.start, range.end);
-				mmu_notifier_invalidate_range(mm, range.start,
-							      range.end);
-
+			if (!folio_test_anon(folio)) {
 				/*
-				 * The ref count of the PMD page was dropped
-				 * which is part of the way map counting
-				 * is done for shared PMDs.  Return 'true'
-				 * here.  When there is no other sharing,
-				 * huge_pmd_unshare returns false and we will
-				 * unmap the actual page and drop map count
-				 * to zero.
+				 * To call huge_pmd_unshare, i_mmap_rwsem must be
+				 * held in write mode.  Caller needs to explicitly
+				 * do this outside rmap routines.
 				 */
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+
+				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
+					flush_tlb_range(vma, range.start, range.end);
+					mmu_notifier_invalidate_range(mm, range.start,
+								      range.end);
+
+					/*
+					 * The ref count of the PMD page was dropped
+					 * which is part of the way map counting
+					 * is done for shared PMDs.  Return 'true'
+					 * here.  When there is no other sharing,
+					 * huge_pmd_unshare returns false and we will
+					 * unmap the actual page and drop map count
+					 * to zero.
+					 */
+					page_vma_mapped_walk_done(&pvmw);
+					break;
+				}
 			}
 		} else {
 			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
@@ -1885,13 +1888,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		anon_exclusive = folio_test_anon(folio) &&
 				 PageAnonExclusive(subpage);
 
-		if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
-			/*
-			 * To call huge_pmd_unshare, i_mmap_rwsem must be
-			 * held in write mode.  Caller needs to explicitly
-			 * do this outside rmap routines.
-			 */
-			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+		if (folio_test_hugetlb(folio)) {
 			/*
 			 * huge_pmd_unshare may unmap an entire PMD page.
 			 * There is no way of knowing exactly which PMDs may
@@ -1901,22 +1898,31 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			flush_cache_range(vma, range.start, range.end);
 
-			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
-				flush_tlb_range(vma, range.start, range.end);
-				mmu_notifier_invalidate_range(mm, range.start,
-							      range.end);
-
+			if (!folio_test_anon(folio)) {
 				/*
-				 * The ref count of the PMD page was dropped
-				 * which is part of the way map counting
-				 * is done for shared PMDs.  Return 'true'
-				 * here.  When there is no other sharing,
-				 * huge_pmd_unshare returns false and we will
-				 * unmap the actual page and drop map count
-				 * to zero.
+				 * To call huge_pmd_unshare, i_mmap_rwsem must be
+				 * held in write mode.  Caller needs to explicitly
+				 * do this outside rmap routines.
 				 */
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+
+				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
+					flush_tlb_range(vma, range.start, range.end);
+					mmu_notifier_invalidate_range(mm, range.start,
+								      range.end);
+
+					/*
+					 * The ref count of the PMD page was dropped
+					 * which is part of the way map counting
+					 * is done for shared PMDs.  Return 'true'
+					 * here.  When there is no other sharing,
+					 * huge_pmd_unshare returns false and we will
+					 * unmap the actual page and drop map count
+					 * to zero.
+					 */
+					page_vma_mapped_walk_done(&pvmw);
+					break;
+				}
 			}
 		} else {
 			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
-- 
1.8.3.1

