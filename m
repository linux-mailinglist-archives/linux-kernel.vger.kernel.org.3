Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF3A478FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhLQPcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:32:03 -0500
Received: from foss.arm.com ([217.140.110.172]:58982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238278AbhLQPbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:31:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81A4C152F;
        Fri, 17 Dec 2021 07:31:18 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31CA23F774;
        Fri, 17 Dec 2021 07:31:17 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, suravee.suthikulpanit@amd.com,
        baolu.lu@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com,
        linux-mm@kvack.org, hch@lst.de
Subject: [PATCH v3 4/9] iommu/amd: Simplify pagetable freeing
Date:   Fri, 17 Dec 2021 15:30:58 +0000
Message-Id: <d3d00c9f3fa0df4756b867072c201e6e82f9ce39.1639753638.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1639753638.git.robin.murphy@arm.com>
References: <cover.1639753638.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For reasons unclear, pagetable freeing is an effectively recursive
method implemented via an elaborate system of templated functions that
turns out to account for 25% of the object file size. Implementing it
using regular straightforward recursion makes the code simpler, and
seems like a good thing to do before we work on it further. As part of
that, also fix the types to avoid all the needless casting back and
forth which just gets in the way.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/io_pgtable.c | 82 ++++++++++++++--------------------
 1 file changed, 34 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 182c93a43efd..4165e1372b6e 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -84,49 +84,45 @@ static void free_page_list(struct page *freelist)
 	}
 }
 
-static struct page *free_pt_page(unsigned long pt, struct page *freelist)
+static struct page *free_pt_page(u64 *pt, struct page *freelist)
 {
-	struct page *p = virt_to_page((void *)pt);
+	struct page *p = virt_to_page(pt);
 
 	p->freelist = freelist;
 
 	return p;
 }
 
-#define DEFINE_FREE_PT_FN(LVL, FN)						\
-static struct page *free_pt_##LVL (unsigned long __pt, struct page *freelist)	\
-{										\
-	unsigned long p;							\
-	u64 *pt;								\
-	int i;									\
-										\
-	pt = (u64 *)__pt;							\
-										\
-	for (i = 0; i < 512; ++i) {						\
-		/* PTE present? */						\
-		if (!IOMMU_PTE_PRESENT(pt[i]))					\
-			continue;						\
-										\
-		/* Large PTE? */						\
-		if (PM_PTE_LEVEL(pt[i]) == 0 ||					\
-		    PM_PTE_LEVEL(pt[i]) == 7)					\
-			continue;						\
-										\
-		p = (unsigned long)IOMMU_PTE_PAGE(pt[i]);			\
-		freelist = FN(p, freelist);					\
-	}									\
-										\
-	return free_pt_page((unsigned long)pt, freelist);			\
+static struct page *free_pt_lvl(u64 *pt, struct page *freelist, int lvl)
+{
+	u64 *p;
+	int i;
+
+	for (i = 0; i < 512; ++i) {
+		/* PTE present? */
+		if (!IOMMU_PTE_PRESENT(pt[i]))
+			continue;
+
+		/* Large PTE? */
+		if (PM_PTE_LEVEL(pt[i]) == 0 ||
+		    PM_PTE_LEVEL(pt[i]) == 7)
+			continue;
+
+		/*
+		 * Free the next level. No need to look at l1 tables here since
+		 * they can only contain leaf PTEs; just free them directly.
+		 */
+		p = IOMMU_PTE_PAGE(pt[i]);
+		if (lvl > 2)
+			freelist = free_pt_lvl(p, freelist, lvl - 1);
+		else
+			freelist = free_pt_page(p, freelist);
+	}
+
+	return free_pt_page(pt, freelist);
 }
 
-DEFINE_FREE_PT_FN(l2, free_pt_page)
-DEFINE_FREE_PT_FN(l3, free_pt_l2)
-DEFINE_FREE_PT_FN(l4, free_pt_l3)
-DEFINE_FREE_PT_FN(l5, free_pt_l4)
-DEFINE_FREE_PT_FN(l6, free_pt_l5)
-
-static struct page *free_sub_pt(unsigned long root, int mode,
-				struct page *freelist)
+static struct page *free_sub_pt(u64 *root, int mode, struct page *freelist)
 {
 	switch (mode) {
 	case PAGE_MODE_NONE:
@@ -136,19 +132,11 @@ static struct page *free_sub_pt(unsigned long root, int mode,
 		freelist = free_pt_page(root, freelist);
 		break;
 	case PAGE_MODE_2_LEVEL:
-		freelist = free_pt_l2(root, freelist);
-		break;
 	case PAGE_MODE_3_LEVEL:
-		freelist = free_pt_l3(root, freelist);
-		break;
 	case PAGE_MODE_4_LEVEL:
-		freelist = free_pt_l4(root, freelist);
-		break;
 	case PAGE_MODE_5_LEVEL:
-		freelist = free_pt_l5(root, freelist);
-		break;
 	case PAGE_MODE_6_LEVEL:
-		freelist = free_pt_l6(root, freelist);
+		free_pt_lvl(root, freelist, mode);
 		break;
 	default:
 		BUG();
@@ -364,7 +352,7 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 
 static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
 {
-	unsigned long pt;
+	u64 *pt;
 	int mode;
 
 	while (cmpxchg64(pte, pteval, 0) != pteval) {
@@ -375,7 +363,7 @@ static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
 	if (!IOMMU_PTE_PRESENT(pteval))
 		return freelist;
 
-	pt   = (unsigned long)IOMMU_PTE_PAGE(pteval);
+	pt   = IOMMU_PTE_PAGE(pteval);
 	mode = IOMMU_PTE_MODE(pteval);
 
 	return free_sub_pt(pt, mode, freelist);
@@ -512,7 +500,6 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, iop);
 	struct protection_domain *dom;
 	struct page *freelist = NULL;
-	unsigned long root;
 
 	if (pgtable->mode == PAGE_MODE_NONE)
 		return;
@@ -529,8 +516,7 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
 	       pgtable->mode > PAGE_MODE_6_LEVEL);
 
-	root = (unsigned long)pgtable->root;
-	freelist = free_sub_pt(root, pgtable->mode, freelist);
+	freelist = free_sub_pt(pgtable->root, pgtable->mode, freelist);
 
 	free_page_list(freelist);
 }
-- 
2.28.0.dirty

