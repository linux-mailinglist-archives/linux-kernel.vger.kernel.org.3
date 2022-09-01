Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD515A94E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiIAKmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiIAKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:41:44 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBA012FDE4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:41:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VO.fSTD_1662028897;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VO.fSTD_1662028897)
          by smtp.aliyun-inc.com;
          Thu, 01 Sep 2022 18:41:38 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     songmuchun@bytedance.com, david@redhat.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/hugetlb: fix races when looking up a CONT-PTE/PMD size hugetlb page
Date:   Thu,  1 Sep 2022 18:41:31 +0800
Message-Id: <635f43bdd85ac2615a58405da82b4d33c6e5eb05.1662017562.git.baolin.wang@linux.alibaba.com>
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

On some architectures (like ARM64), it can support CONT-PTE/PMD size
hugetlb, which means it can support not only PMD/PUD size hugetlb
(2M and 1G), but also CONT-PTE/PMD size(64K and 32M) if a 4K page size
specified.

So when looking up a CONT-PTE size hugetlb page by follow_page(), it
will use pte_offset_map_lock() to get the pte entry lock for the CONT-PTE
size hugetlb in follow_page_pte(). However this pte entry lock is incorrect
for the CONT-PTE size hugetlb, since we should use huge_pte_lock() to
get the correct lock, which is mm->page_table_lock.

That means the pte entry of the CONT-PTE size hugetlb under current
pte lock is unstable in follow_page_pte(), we can continue to migrate
or poison the pte entry of the CONT-PTE size hugetlb, which can cause
some potential race issues, even though they are under the 'pte lock'.

For example, suppose thread A is trying to look up a CONT-PTE size
hugetlb page by move_pages() syscall under the lock, however antoher
thread B can migrate the CONT-PTE hugetlb page at the same time, which
will cause thread A to get an incorrect page, if thread A also wants to
do page migration, then data inconsistency error occurs.

Moreover we have the same issue for CONT-PMD size hugetlb in
follow_huge_pmd().

To fix above issues, rename the follow_huge_pmd() as follow_huge_pmd_pte()
to handle PMD and PTE level size hugetlb, which uses huge_pte_lock() to
get the correct pte entry lock to make the pte entry stable.

Cc: <stable@vger.kernel.org>
Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v2:
 - Combine PMD and PTE level hugetlb handling into one function.
 - Drop unnecessary patches.
 - Update the commit message.

Mike, please fold this patch into your series. Thanks.
---
 include/linux/hugetlb.h |  8 ++++----
 mm/gup.c                | 14 +++++++++++++-
 mm/hugetlb.c            | 27 +++++++++++++--------------
 3 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 852f911..fe4944f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -207,8 +207,8 @@ struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
 struct page *follow_huge_pd(struct vm_area_struct *vma,
 			    unsigned long address, hugepd_t hpd,
 			    int flags, int pdshift);
-struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-				pmd_t *pmd, int flags);
+struct page *follow_huge_pmd_pte(struct vm_area_struct *vma, unsigned long address,
+				 int flags);
 struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
 				pud_t *pud, int flags);
 struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
@@ -319,8 +319,8 @@ static inline struct page *follow_huge_pd(struct vm_area_struct *vma,
 	return NULL;
 }
 
-static inline struct page *follow_huge_pmd(struct mm_struct *mm,
-				unsigned long address, pmd_t *pmd, int flags)
+static inline struct page *follow_huge_pmd_pte(struct vm_area_struct *vma,
+				unsigned long address, int flags)
 {
 	return NULL;
 }
diff --git a/mm/gup.c b/mm/gup.c
index 66d8619e..1e74fc0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -530,6 +530,18 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
 			 (FOLL_PIN | FOLL_GET)))
 		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Considering PTE level hugetlb, like continuous-PTE hugetlb on
+	 * ARM64 architecture.
+	 */
+	if (is_vm_hugetlb_page(vma)) {
+		page = follow_huge_pmd_pte(vma, address, flags);
+		if (page)
+			return page;
+		return no_page_table(vma, flags);
+	}
+
 retry:
 	if (unlikely(pmd_bad(*pmd)))
 		return no_page_table(vma, flags);
@@ -662,7 +674,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	if (pmd_none(pmdval))
 		return no_page_table(vma, flags);
 	if (pmd_huge(pmdval) && is_vm_hugetlb_page(vma)) {
-		page = follow_huge_pmd(mm, address, pmd, flags);
+		page = follow_huge_pmd_pte(vma, address, flags);
 		if (page)
 			return page;
 		return no_page_table(vma, flags);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d0617d6..c613d3c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7156,12 +7156,13 @@ struct page * __weak
 }
 
 struct page * __weak
-follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-		pmd_t *pmd, int flags)
+follow_huge_pmd_pte(struct vm_area_struct *vma, unsigned long address, int flags)
 {
+	struct hstate *h = hstate_vma(vma);
+	struct mm_struct *mm = vma->vm_mm;
 	struct page *page = NULL;
 	spinlock_t *ptl;
-	pte_t pte;
+	pte_t *ptep, pte;
 
 	/*
 	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
@@ -7171,17 +7172,15 @@ struct page * __weak
 		return NULL;
 
 retry:
-	ptl = pmd_lockptr(mm, pmd);
-	spin_lock(ptl);
-	/*
-	 * make sure that the address range covered by this pmd is not
-	 * unmapped from other threads.
-	 */
-	if (!pmd_huge(*pmd))
-		goto out;
-	pte = huge_ptep_get((pte_t *)pmd);
+	ptep = huge_pte_offset(mm, address, huge_page_size(h));
+	if (!ptep)
+		return NULL;
+
+	ptl = huge_pte_lock(h, mm, ptep);
+	pte = huge_ptep_get(ptep);
 	if (pte_present(pte)) {
-		page = pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
+		page = pte_page(pte) +
+			((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
 		/*
 		 * try_grab_page() should always succeed here, because: a) we
 		 * hold the pmd (ptl) lock, and b) we've just checked that the
@@ -7197,7 +7196,7 @@ struct page * __weak
 	} else {
 		if (is_hugetlb_entry_migration(pte)) {
 			spin_unlock(ptl);
-			__migration_entry_wait_huge((pte_t *)pmd, ptl);
+			__migration_entry_wait_huge(ptep, ptl);
 			goto retry;
 		}
 		/*
-- 
1.8.3.1

