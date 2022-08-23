Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE19859D2A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbiHWHu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbiHWHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:50:21 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAF065550
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:50:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VN0jAoJ_1661241013;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VN0jAoJ_1661241013)
          by smtp.aliyun-inc.com;
          Tue, 23 Aug 2022 15:50:14 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE size hugetlb page
Date:   Tue, 23 Aug 2022 15:50:01 +0800
Message-Id: <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
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
some potential race issues, and following pte_xxx() validation is also
unstable in follow_page_pte(), even though they are under the 'pte lock'.

Moreover we should use huge_ptep_get() to get the pte entry value of
the CONT-PTE size hugetlb, which already takes into account the subpages'
dirty or young bits in case we missed the dirty or young state of the
CONT-PTE size hugetlb.

To fix above issues, introducing a new helper follow_huge_pte() to look
up a CONT-PTE size hugetlb page, which uses huge_pte_lock() to get the
correct pte entry lock to make the pte entry stable, as well as
supporting non-present pte handling.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/hugetlb.h |  8 ++++++++
 mm/gup.c                | 11 ++++++++++
 mm/hugetlb.c            | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3ec981a..d491138 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -207,6 +207,8 @@ struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
 struct page *follow_huge_pd(struct vm_area_struct *vma,
 			    unsigned long address, hugepd_t hpd,
 			    int flags, int pdshift);
+struct page *follow_huge_pte(struct vm_area_struct *vma, unsigned long address,
+			     pmd_t *pmd, int flags);
 struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 				pmd_t *pmd, int flags);
 struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
@@ -312,6 +314,12 @@ static inline struct page *follow_huge_pd(struct vm_area_struct *vma,
 	return NULL;
 }
 
+static inline struct page *follow_huge_pte(struct vm_area_struct *vma,
+				unsigned long address, pmd_t *pmd, int flags)
+{
+	return NULL;
+}
+
 static inline struct page *follow_huge_pmd(struct mm_struct *mm,
 				unsigned long address, pmd_t *pmd, int flags)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 3b656b7..87a94f5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -534,6 +534,17 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	if (unlikely(pmd_bad(*pmd)))
 		return no_page_table(vma, flags);
 
+	/*
+	 * Considering PTE level hugetlb, like continuous-PTE hugetlb on
+	 * ARM64 architecture.
+	 */
+	if (is_vm_hugetlb_page(vma)) {
+		page = follow_huge_pte(vma, address, pmd, flags);
+		if (page)
+			return page;
+		return no_page_table(vma, flags);
+	}
+
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
 	pte = *ptep;
 	if (!pte_present(pte)) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6c00ba1..cf742d1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6981,6 +6981,59 @@ struct page * __weak
 	return NULL;
 }
 
+/* Support looking up a CONT-PTE size hugetlb page. */
+struct page * __weak
+follow_huge_pte(struct vm_area_struct *vma, unsigned long address,
+		pmd_t *pmd, int flags)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct hstate *hstate = hstate_vma(vma);
+	unsigned long size = huge_page_size(hstate);
+	struct page *page = NULL;
+	spinlock_t *ptl;
+	pte_t *ptep, pte;
+
+	/*
+	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
+	 * follow_hugetlb_page().
+	 */
+	if (WARN_ON_ONCE(flags & FOLL_PIN))
+		return NULL;
+
+	ptep = huge_pte_offset(mm, address, size);
+	if (!ptep)
+		return NULL;
+
+retry:
+	ptl = huge_pte_lock(hstate, mm, ptep);
+	pte = huge_ptep_get(ptep);
+	if (pte_present(pte)) {
+		page = pte_page(pte);
+		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
+			page = NULL;
+			goto out;
+		}
+	} else {
+		if (!(flags & FOLL_MIGRATION)) {
+			page = NULL;
+			goto out;
+		}
+
+		if (is_hugetlb_entry_migration(pte)) {
+			spin_unlock(ptl);
+			__migration_entry_wait_huge(ptep, ptl);
+			goto retry;
+		}
+		/*
+		 * hwpoisoned entry is treated as no_page_table in
+		 * follow_page_mask().
+		 */
+	}
+out:
+	spin_unlock(ptl);
+	return page;
+}
+
 struct page * __weak
 follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 		pmd_t *pmd, int flags)
-- 
1.8.3.1

