Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CDC59999A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347856AbiHSKNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346395AbiHSKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:13:17 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA971D9D62
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:13:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMfbQOi_1660903986;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMfbQOi_1660903986)
          by smtp.aliyun-inc.com;
          Fri, 19 Aug 2022 18:13:06 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm/hugetlb: fix races when looking up a CONT-PMD size hugetlb page
Date:   Fri, 19 Aug 2022 18:12:57 +0800
Message-Id: <673a1f7c1ae994fa6bdcbcf5db54afa0d7184f70.1660902741.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
References: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
References: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
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
hugetlb, which means it can support not only PMD/PUD size hugetlb:
2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page size
specified.

When looking up a CONT-PMD size hugetlb page by follow_page(), it will
always use the pmd lock to protect the pmd entry in follow_huge_pmd().
However this is not the correct lock for CONT-PMD size hugetlb, instead
we should use mm->page_table_lock for the CONT-PMD size hugetlb to make
sure the pmd entry is stable.

Thus changing to use huge_pte_lock() to get the correct pmd entry lock
for CONT-PMD size hugetlb to fix the potential race.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/hugetlb.h | 4 ++--
 mm/gup.c                | 2 +-
 mm/hugetlb.c            | 7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3ec981a..dbc2773 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -207,7 +207,7 @@ struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
 struct page *follow_huge_pd(struct vm_area_struct *vma,
 			    unsigned long address, hugepd_t hpd,
 			    int flags, int pdshift);
-struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
+struct page *follow_huge_pmd(struct vm_area_struct *vma, unsigned long address,
 				pmd_t *pmd, int flags);
 struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
 				pud_t *pud, int flags);
@@ -312,7 +312,7 @@ static inline struct page *follow_huge_pd(struct vm_area_struct *vma,
 	return NULL;
 }
 
-static inline struct page *follow_huge_pmd(struct mm_struct *mm,
+static inline struct page *follow_huge_pmd(struct vm_area_struct *vma,
 				unsigned long address, pmd_t *pmd, int flags)
 {
 	return NULL;
diff --git a/mm/gup.c b/mm/gup.c
index 3b2fa86..0856964 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -680,7 +680,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	if (pmd_none(pmdval))
 		return no_page_table(vma, flags);
 	if (pmd_huge(pmdval) && is_vm_hugetlb_page(vma)) {
-		page = follow_huge_pmd(mm, address, pmd, flags);
+		page = follow_huge_pmd(vma, address, pmd, flags);
 		if (page)
 			return page;
 		return no_page_table(vma, flags);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ea1c7bf..efb53ba 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6960,9 +6960,11 @@ struct page * __weak
 }
 
 struct page * __weak
-follow_huge_pmd(struct mm_struct *mm, unsigned long address,
+follow_huge_pmd(struct vm_area_struct *vma, unsigned long address,
 		pmd_t *pmd, int flags)
 {
+	struct mm_struct *mm = vma->vm_mm;
+	struct hstate *hstate = hstate_vma(vma);
 	struct page *page = NULL;
 	spinlock_t *ptl;
 	pte_t pte;
@@ -6975,8 +6977,7 @@ struct page * __weak
 		return NULL;
 
 retry:
-	ptl = pmd_lockptr(mm, pmd);
-	spin_lock(ptl);
+	ptl = huge_pte_lock(hstate, mm, (pte_t *)pmd);
 	/*
 	 * make sure that the address range covered by this pmd is not
 	 * unmapped from other threads.
-- 
1.8.3.1

