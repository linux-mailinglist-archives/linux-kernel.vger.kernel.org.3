Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015FD59C076
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiHVNYK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Aug 2022 09:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiHVNYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:24:03 -0400
X-Greylist: delayed 1163 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 06:24:01 PDT
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B72627CED
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:24:01 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 3BB495FB1D;
        Mon, 22 Aug 2022 15:04:37 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] mm: pagewalk: move variables to more local scope, tweak loops
Date:   Mon, 22 Aug 2022 15:04:12 +0200
Message-ID: <8155217.NyiUUSuA9g@devpool047>
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

Move some variables to more local scopes to make it obvious that they don't
carry state. Put the end additions into the for loop instructions to make
them easier to read.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 mm/pagewalk.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index f816f86588be..d8be8a30b272 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -25,14 +25,12 @@ static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
 {
 	const struct mm_walk_ops *ops = walk->ops;
 
-	for (;;) {
+	for (;; addr += PAGE_SIZE, pte++) {
 		int err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
 		if (err)
 			return err;
 		if (addr >= end - PAGE_SIZE)
 			break;
-		addr += PAGE_SIZE;
-		pte++;
 	}
 	return 0;
 }
@@ -42,13 +40,14 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 {
 	pte_t *pte;
 	int err;
-	spinlock_t *ptl;
 
 	if (walk->no_vma) {
 		pte = pte_offset_map(pmd, addr);
 		err = walk_pte_range_inner(pte, addr, end, walk);
 		pte_unmap(pte);
 	} else {
+		spinlock_t *ptl;
+
 		pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 		err = walk_pte_range_inner(pte, addr, end, walk);
 		pte_unmap_unlock(pte, ptl);
@@ -71,7 +70,7 @@ static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
 	if (addr & (page_size - 1))
 		return 0;
 
-	for (;;) {
+	for (;; addr += page_size) {
 		pte_t *pte;
 		int err;
 
@@ -84,7 +83,6 @@ static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
 			return err;
 		if (addr >= end - page_size)
 			break;
-		addr += page_size;
 	}
 	return 0;
 }
@@ -307,14 +305,13 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	unsigned long next;
 	unsigned long hmask = huge_page_mask(h);
 	unsigned long sz = huge_page_size(h);
-	pte_t *pte;
 	const struct mm_walk_ops *ops = walk->ops;
 
-	do {
+	for (; addr < end; addr = next) {
 		int err;
+		pte_t *pte = huge_pte_offset(walk->mm, addr & hmask, sz);
 
 		next = hugetlb_entry_end(h, addr, end);
-		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
 
 		if (pte)
 			err = ops->hugetlb_entry(pte, hmask, addr, next, walk);
@@ -323,7 +320,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 
 		if (err)
 			return err;
-	} while (addr = next, addr != end);
+	}
 
 	return 0;
 }
@@ -461,14 +458,13 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	do {
 		int err;
 
+		walk.vma = vma;
 		if (!vma) { /* after the last vma */
-			walk.vma = NULL;
 			next = end;
 		} else if (start < vma->vm_start) { /* outside vma */
 			walk.vma = NULL;
 			next = min(end, vma->vm_start);
 		} else { /* inside vma */
-			walk.vma = vma;
 			next = min(end, vma->vm_end);
 			vma = vma->vm_next;
 
@@ -595,11 +591,11 @@ int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
 	};
 	struct vm_area_struct *vma;
 	pgoff_t vba, vea, cba, cea;
-	unsigned long start_addr, end_addr;
 
 	lockdep_assert_held(&mapping->i_mmap_rwsem);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
 				  first_index + nr - 1) {
+		unsigned long start_addr, end_addr;
 		int err;
 
 		/* Clip to the vma */
-- 
2.37.2

-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



