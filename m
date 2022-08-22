Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610A359C0B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiHVNjP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Aug 2022 09:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiHVNjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:39:11 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E357B4B6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:39:09 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id CA8BC60256;
        Mon, 22 Aug 2022 15:04:37 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] mm: pagewalk: make error checks more obvious
Date:   Mon, 22 Aug 2022 15:00:05 +0200
Message-ID: <2203731.iZASKD2KPV@devpool047>
Organization: emlix GmbH
In-Reply-To: <3200642.44csPzL39Z@devpool047>
References: <3200642.44csPzL39Z@devpool047>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The err variable only needs to be checked when it was assigned directly
before, it is not carried on to any later checks. Move the checks into the
same "if" conditions where they are assigned. Also just return the error at
the relevant places. While at it move these err variables to a more local
scope at some places.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 mm/pagewalk.c | 140 +++++++++++++++++++++++++++-----------------------
 1 file changed, 77 insertions(+), 63 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..c67b2532db8f 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -24,25 +24,24 @@ static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 {
 	const struct mm_walk_ops *ops = walk->ops;
-	int err = 0;
 
 	for (;;) {
-		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
+		int err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
 		if (err)
-		       break;
+			return err;
 		if (addr >= end - PAGE_SIZE)
 			break;
 		addr += PAGE_SIZE;
 		pte++;
 	}
-	return err;
+	return 0;
 }
 
 static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			  struct mm_walk *walk)
 {
 	pte_t *pte;
-	int err = 0;
+	int err;
 	spinlock_t *ptl;
 
 	if (walk->no_vma) {
@@ -62,7 +61,6 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
 			     unsigned long end, struct mm_walk *walk, int pdshift)
 {
-	int err = 0;
 	const struct mm_walk_ops *ops = walk->ops;
 	int shift = hugepd_shift(*phpd);
 	int page_size = 1 << shift;
@@ -75,6 +73,7 @@ static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
 
 	for (;;) {
 		pte_t *pte;
+		int err;
 
 		spin_lock(&walk->mm->page_table_lock);
 		pte = hugepte_offset(*phpd, addr, pdshift);
@@ -82,12 +81,12 @@ static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
 		spin_unlock(&walk->mm->page_table_lock);
 
 		if (err)
-			break;
+			return err;
 		if (addr >= end - page_size)
 			break;
 		addr += page_size;
 	}
-	return err;
+	return 0;
 }
 #else
 static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
@@ -103,18 +102,20 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	pmd_t *pmd;
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
-	int err = 0;
 	int depth = real_depth(3);
 
 	pmd = pmd_offset(pud, addr);
 	do {
-again:
+		int err;
+
+ again:
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(*pmd) || (!walk->vma && !walk->no_vma)) {
-			if (ops->pte_hole)
+			if (ops->pte_hole) {
 				err = ops->pte_hole(addr, next, depth, walk);
-			if (err)
-				break;
+				if (err)
+					return err;
+			}
 			continue;
 		}
 
@@ -124,10 +125,11 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		 * This implies that each ->pmd_entry() handler
 		 * needs to know about pmd_trans_huge() pmds
 		 */
-		if (ops->pmd_entry)
+		if (ops->pmd_entry) {
 			err = ops->pmd_entry(pmd, addr, next, walk);
-		if (err)
-			break;
+			if (err)
+				return err;
+		}
 
 		if (walk->action == ACTION_AGAIN)
 			goto again;
@@ -152,10 +154,10 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		else
 			err = walk_pte_range(pmd, addr, next, walk);
 		if (err)
-			break;
+			return err;
 	} while (pmd++, addr = next, addr != end);
 
-	return err;
+	return 0;
 }
 
 static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
@@ -164,27 +166,30 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 	pud_t *pud;
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
-	int err = 0;
 	int depth = real_depth(2);
 
 	pud = pud_offset(p4d, addr);
 	do {
+		int err;
+
  again:
 		next = pud_addr_end(addr, end);
 		if (pud_none(*pud) || (!walk->vma && !walk->no_vma)) {
-			if (ops->pte_hole)
+			if (ops->pte_hole) {
 				err = ops->pte_hole(addr, next, depth, walk);
-			if (err)
-				break;
+				if (err)
+					return err;
+			}
 			continue;
 		}
 
 		walk->action = ACTION_SUBTREE;
 
-		if (ops->pud_entry)
+		if (ops->pud_entry) {
 			err = ops->pud_entry(pud, addr, next, walk);
-		if (err)
-			break;
+			if (err)
+				return err;
+		}
 
 		if (walk->action == ACTION_AGAIN)
 			goto again;
@@ -204,10 +209,10 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		else
 			err = walk_pmd_range(pud, addr, next, walk);
 		if (err)
-			break;
+			return err;
 	} while (pud++, addr = next, addr != end);
 
-	return err;
+	return 0;
 }
 
 static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
@@ -216,33 +221,35 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	p4d_t *p4d;
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
-	int err = 0;
 	int depth = real_depth(1);
 
 	p4d = p4d_offset(pgd, addr);
 	do {
+		int err;
+
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d)) {
-			if (ops->pte_hole)
+			if (ops->pte_hole) {
 				err = ops->pte_hole(addr, next, depth, walk);
-			if (err)
-				break;
+				if (err)
+					return err;
+			}
 			continue;
 		}
 		if (ops->p4d_entry) {
 			err = ops->p4d_entry(p4d, addr, next, walk);
 			if (err)
-				break;
+				return err;
 		}
 		if (is_hugepd(__hugepd(p4d_val(*p4d))))
 			err = walk_hugepd_range((hugepd_t *)p4d, addr, next, walk, P4D_SHIFT);
 		else if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
 			err = walk_pud_range(p4d, addr, next, walk);
 		if (err)
-			break;
+			return err;
 	} while (p4d++, addr = next, addr != end);
 
-	return err;
+	return 0;
 }
 
 static int walk_pgd_range(unsigned long addr, unsigned long end,
@@ -251,35 +258,37 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 	pgd_t *pgd;
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
-	int err = 0;
 
 	if (walk->pgd)
 		pgd = walk->pgd + pgd_index(addr);
 	else
 		pgd = pgd_offset(walk->mm, addr);
 	do {
+		int err;
+
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd)) {
-			if (ops->pte_hole)
+			if (ops->pte_hole) {
 				err = ops->pte_hole(addr, next, 0, walk);
-			if (err)
-				break;
+				if (err)
+					return err;
+			}
 			continue;
 		}
 		if (ops->pgd_entry) {
 			err = ops->pgd_entry(pgd, addr, next, walk);
 			if (err)
-				break;
+				return err;
 		}
 		if (is_hugepd(__hugepd(pgd_val(*pgd))))
 			err = walk_hugepd_range((hugepd_t *)pgd, addr, next, walk, PGDIR_SHIFT);
 		else if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry || ops->pte_entry)
 			err = walk_p4d_range(pgd, addr, next, walk);
 		if (err)
-			break;
+			return err;
 	} while (pgd++, addr = next, addr != end);
 
-	return err;
+	return 0;
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -300,9 +309,10 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	unsigned long sz = huge_page_size(h);
 	pte_t *pte;
 	const struct mm_walk_ops *ops = walk->ops;
-	int err = 0;
 
 	do {
+		int err;
+
 		next = hugetlb_entry_end(h, addr, end);
 		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
 
@@ -312,10 +322,10 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 			err = ops->pte_hole(addr, next, -1, walk);
 
 		if (err)
-			break;
+			return err;
 	} while (addr = next, addr != end);
 
-	return err;
+	return 0;
 }
 
 #else /* CONFIG_HUGETLB_PAGE */
@@ -351,10 +361,13 @@ static int walk_page_test(unsigned long start, unsigned long end,
 	 * vma(VM_PFNMAP).
 	 */
 	if (vma->vm_flags & VM_PFNMAP) {
-		int err = 1;
-		if (ops->pte_hole)
-			err = ops->pte_hole(start, end, -1, walk);
-		return err ? err : 1;
+		if (ops->pte_hole) {
+			int err = ops->pte_hole(start, end, -1, walk);
+
+			return err ? err : 1;
+		}
+
+		return 1;
 	}
 	return 0;
 }
@@ -428,7 +441,6 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private)
 {
-	int err = 0;
 	unsigned long next;
 	struct vm_area_struct *vma;
 	struct mm_walk walk = {
@@ -447,6 +459,8 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 
 	vma = find_vma(walk.mm, start);
 	do {
+		int err;
+
 		if (!vma) { /* after the last vma */
 			walk.vma = NULL;
 			next = end;
@@ -465,18 +479,18 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 				 * controlling the pagewalk, so should never
 				 * be passed to the callers.
 				 */
-				err = 0;
 				continue;
 			}
 			if (err < 0)
-				break;
+				return err;
 		}
-		if (walk.vma || walk.ops->pte_hole)
+		if (walk.vma || walk.ops->pte_hole) {
 			err = __walk_page_range(start, next, &walk);
-		if (err)
-			break;
+			if (err)
+				return err;
+		}
 	} while (start = next, start < end);
-	return err;
+	return 0;
 }
 
 /*
@@ -571,11 +585,12 @@ int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
 	struct vm_area_struct *vma;
 	pgoff_t vba, vea, cba, cea;
 	unsigned long start_addr, end_addr;
-	int err = 0;
 
 	lockdep_assert_held(&mapping->i_mmap_rwsem);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
 				  first_index + nr - 1) {
+		int err;
+
 		/* Clip to the vma */
 		vba = vma->vm_pgoff;
 		vea = vba + vma_pages(vma);
@@ -593,16 +608,15 @@ int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
 		walk.mm = vma->vm_mm;
 
 		err = walk_page_test(vma->vm_start, vma->vm_end, &walk);
-		if (err > 0) {
-			err = 0;
-			break;
-		} else if (err < 0)
-			break;
+		if (err > 0)
+			return 0;
+		else if (err < 0)
+			return err;
 
 		err = __walk_page_range(start_addr, end_addr, &walk);
 		if (err)
-			break;
+			return err;
 	}
 
-	return err;
+	return 0;
 }
-- 
2.37.2



-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



