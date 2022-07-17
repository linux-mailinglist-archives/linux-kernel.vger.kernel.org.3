Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A05773FC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 06:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiGQEU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 00:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQEU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 00:20:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB9A20187
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 21:20:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8683CE0950
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 04:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AFFC3411E;
        Sun, 17 Jul 2022 04:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658031651;
        bh=vb0WyxDtqEevXx+uxAGj8I4wUqjkFr/6rgvI9PkP3EA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EPtpYhmeH6O+Ju1wS1c4z5e+8IE3NA9b2sQZ/7ln+elFRQSNYgLW/+k9o0xIBbkMv
         u4geDuuoCzZlsa0iPZ3jkqramfjxFL3d4GfWGUWPDeO6SckAY7YoJACHlZ5MeHPf+C
         D4oWQjo1idGs5Z0B5yg6ERYPyICH+IYeTQhABL+s=
Date:   Sat, 16 Jul 2022 21:20:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v11 00/69] Introducing the Maple Tree
Message-Id: <20220716212050.562604df2a48683dfbcc7e57@linux-foundation.org>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2022 02:46:32 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> This is the v10 + fixes and a few clean ups.

I'm seeing quite a lot of differences between this and what we had in
mm-unstable.  A surprising amount.

Please check it all?


--- include/linux/maple_tree.h	2022-07-16 21:05:04.697041964 -0700
+++ ../25-pre-maple/include/linux/maple_tree.h	2022-07-16 21:05:34.509477799 -0700
@@ -225,9 +225,9 @@
  * @flags: The maple tree flags
  *
  */
-#define MTREE_INIT(name, __flags) {					\
-	.ma_lock = __SPIN_LOCK_UNLOCKED((name).ma_lock),		\
-	.ma_flags = __flags,						\
+#define MTREE_INIT(name, flags) {					\
+	.ma_lock = __SPIN_LOCK_UNLOCKED(name.ma_lock),			\
+	.ma_flags = flags,						\
 	.ma_root = NULL,						\
 }
 
@@ -238,13 +238,13 @@
  * @lock: The external lock
  */
 #ifdef CONFIG_LOCKDEP
-#define MTREE_INIT_EXT(name, __flags, __lock) {				\
-	.ma_external_lock = &(__lock).dep_map,				\
-	.ma_flags = (__flags),						\
+#define MTREE_INIT_EXT(name, flags, lock) {				\
+	.ma_external_lock = &(lock).dep_map,				\
+	.ma_flags = flags,						\
 	.ma_root = NULL,						\
 }
 #else
-#define MTREE_INIT_EXT(name, __flags, __lock)	MTREE_INIT(name, __flags)
+#define MTREE_INIT_EXT(name, flags, lock)	MTREE_INIT(name, flags)
 #endif
 
 #define DEFINE_MTREE(name)						\
@@ -520,8 +520,8 @@
  * Note: may return the zero entry.
  *
  */
-#define mas_for_each(__mas, __entry, __max) \
-	while (((__entry) = mas_find((__mas), (__max))) != NULL)
+#define mas_for_each(mas, entry, max) \
+	while (((entry) = mas_find((mas), (max))) != NULL)
 
 
 /**
@@ -654,9 +654,9 @@
  *
  * Note: Will not return the zero entry.
  */
-#define mt_for_each(__tree, __entry, __index, __max) \
-	for (__entry = mt_find(__tree, &(__index), __max); \
-		__entry; __entry = mt_find_after(__tree, &(__index), __max))
+#define mt_for_each(tree, entry, index, max) \
+	for (entry = mt_find(tree, &(index), max); \
+		entry; entry = mt_find_after(tree, &(index), max))
 
 
 #ifdef CONFIG_DEBUG_MAPLE_TREE
@@ -665,12 +665,12 @@
 
 void mt_dump(const struct maple_tree *mt);
 void mt_validate(struct maple_tree *mt);
-#define MT_BUG_ON(__tree, __x) do {					\
+#define MT_BUG_ON(tree, x) do {						\
 	atomic_inc(&maple_tree_tests_run);				\
-	if (__x) {							\
+	if (x) {							\
 		pr_info("BUG at %s:%d (%u)\n",				\
-		__func__, __LINE__, __x);				\
-		mt_dump(__tree);					\
+		__func__, __LINE__, x);					\
+		mt_dump(tree);						\
 		pr_info("Pass: %u Run:%u\n",				\
 			atomic_read(&maple_tree_tests_passed),		\
 			atomic_read(&maple_tree_tests_run));		\
@@ -680,7 +680,7 @@
 	}								\
 } while (0)
 #else
-#define MT_BUG_ON(__tree, __x) BUG_ON(__x)
+#define MT_BUG_ON(tree, x) BUG_ON(x)
 #endif /* CONFIG_DEBUG_MAPLE_TREE */
 
 #endif /*_LINUX_MAPLE_TREE_H */
--- include/linux/mm.h	2022-07-16 21:05:07.625084770 -0700
+++ ../25-pre-maple/include/linux/mm.h	2022-07-16 21:05:37.847526599 -0700
@@ -683,12 +683,11 @@
 	return vmi->mas.index;
 }
 
-#define for_each_vma(__vmi, __vma)					\
-	while (((__vma) = vma_next(&(__vmi))) != NULL)
+#define for_each_vma(vmi, vma)		while ((vma = vma_next(&(vmi))) != NULL)
 
 /* The MM code likes to work with exclusive end addresses */
-#define for_each_vma_range(__vmi, __vma, __end)				\
-	while (((__vma) = vma_find(&(__vmi), (__end) - 1)) != NULL)
+#define for_each_vma_range(vmi, vma, end)				\
+	while ((vma = vma_find(&(vmi), (end) - 1)) != NULL)
 
 #ifdef CONFIG_SHMEM
 /*
--- include/linux/mm_types.h	2022-07-16 21:05:07.625084770 -0700
+++ ../25-pre-maple/include/linux/mm_types.h	2022-07-16 21:05:37.848526614 -0700
@@ -681,11 +681,11 @@
 	struct ma_state mas;
 };
 
-#define VMA_ITERATOR(name, __mm, __addr)				\
+#define VMA_ITERATOR(name, mm, addr) 					\
 	struct vma_iterator name = {					\
 		.mas = {						\
-			.tree = &(__mm)->mm_mt,				\
-			.index = __addr,				\
+			.tree = &mm->mm_mt,				\
+			.index = addr,					\
 			.node = MAS_START,				\
 		},							\
 	}




--- mm/memory.c	2022-07-16 21:05:07.627084799 -0700
+++ ../25-pre-maple/mm/memory.c	2022-07-16 21:05:37.980528543 -0700
@@ -1699,6 +1699,7 @@
 /**
  * unmap_vmas - unmap a range of memory covered by a list of vma's
  * @tlb: address of the caller's struct mmu_gather
+ * @mt: The maple tree pointer for the VMAs
  * @vma: the starting vma
  * @start_addr: virtual address at which to start unmapping
  * @end_addr: virtual address at which to end unmapping
--- mm/mmap.c	2022-07-16 21:05:07.716086100 -0700
+++ ../25-pre-maple/mm/mmap.c	2022-07-16 21:05:38.104530356 -0700
@@ -341,27 +341,28 @@
 	MA_STATE(mas, mt, 0, 0);
 
 	mt_validate(&mm->mm_mt);
+
 	mas_for_each(&mas, vma_mt, ULONG_MAX) {
 		if ((vma_mt->vm_start != mas.index) ||
 		    (vma_mt->vm_end - 1 != mas.last)) {
 			pr_emerg("issue in %s\n", current->comm);
 			dump_stack();
 			dump_vma(vma_mt);
-			pr_emerg("mt piv: %p %lu - %lu\n", vma_mt,
+			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
 				 mas.index, mas.last);
-			pr_emerg("mt vma: %p %lu - %lu\n", vma_mt,
+			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
 				 vma_mt->vm_start, vma_mt->vm_end);
 
 			mt_dump(mas.tree);
 			if (vma_mt->vm_end != mas.last + 1) {
-				pr_err("vma: %p vma_mt %lu-%lu\tmt %lu-%lu\n",
+				pr_err("vma: %px vma_mt %lu-%lu\tmt %lu-%lu\n",
 						mm, vma_mt->vm_start, vma_mt->vm_end,
 						mas.index, mas.last);
 				mt_dump(mas.tree);
 			}
 			VM_BUG_ON_MM(vma_mt->vm_end != mas.last + 1, mm);
 			if (vma_mt->vm_start != mas.index) {
-				pr_err("vma: %p vma_mt %p %lu - %lu doesn't match\n",
+				pr_err("vma: %px vma_mt %px %lu - %lu doesn't match\n",
 						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
 				mt_dump(mas.tree);
 			}
@@ -448,7 +449,7 @@
 		unsigned long vm_start = max(addr, vma->vm_start);
 		unsigned long vm_end = min(end, vma->vm_end);
 
-		nr_pages += PHYS_PFN(vm_end - vm_start);
+		nr_pages += (vm_end - vm_start) / PAGE_SIZE;
 	}
 
 	return nr_pages;
@@ -710,11 +711,11 @@
 				 * remove_next == 1 is case 1 or 7.
 				 */
 				remove_next = 1 + (end > next->vm_end);
-				if (remove_next == 2)
-					next_next = find_vma(mm, next->vm_end);
-
+				next_next = find_vma(mm, next->vm_end);
 				VM_WARN_ON(remove_next == 2 &&
 					   end != next_next->vm_end);
+				/* trim end to next, for case 6 first pass */
+				end = next->vm_end;
 			}
 
 			exporter = next;
@@ -725,7 +726,7 @@
 			 * next, if the vma overlaps with it.
 			 */
 			if (remove_next == 2 && !next->anon_vma)
-				exporter = next_next;
+				exporter = find_vma(mm, next->vm_end);
 
 		} else if (end > next->vm_start) {
 			/*
@@ -762,6 +763,7 @@
 				return error;
 		}
 	}
+again:
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
 
 	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
@@ -852,8 +854,6 @@
 
 	if (remove_next && file) {
 		__remove_shared_vm_struct(next, file, mapping);
-		if (remove_next == 2)
-			__remove_shared_vm_struct(next_next, file, mapping);
 	} else if (insert) {
 		/*
 		 * split_vma has split insert from vma, and needs
@@ -881,7 +881,6 @@
 	}
 
 	if (remove_next) {
-again:
 		if (file) {
 			uprobe_munmap(next, next->vm_start, next->vm_end);
 			fput(file);
@@ -890,22 +889,45 @@
 			anon_vma_merge(vma, next);
 		mm->map_count--;
 		mpol_put(vma_policy(next));
-		if (remove_next != 2)
-			BUG_ON(vma->vm_end < next->vm_end);
+		BUG_ON(vma->vm_end < next->vm_end);
 		vm_area_free(next);
 
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we must remove next_next too.
+		 * we must remove another next too. It would clutter
+		 * up the code too much to do both in one go.
 		 */
+		if (remove_next != 3) {
+			/*
+			 * If "next" was removed and vma->vm_end was
+			 * expanded (up) over it, in turn
+			 * "next->prev->vm_end" changed and the
+			 * "vma->next" gap must be updated.
+			 */
+			next = next_next;
+		} else {
+			/*
+			 * For the scope of the comment "next" and
+			 * "vma" considered pre-swap(): if "vma" was
+			 * removed, next->vm_start was expanded (down)
+			 * over it and the "next" gap must be updated.
+			 * Because of the swap() the post-swap() "vma"
+			 * actually points to pre-swap() "next"
+			 * (post-swap() "next" as opposed is now a
+			 * dangling pointer).
+			 */
+			next = vma;
+		}
 		if (remove_next == 2) {
+			mas_reset(&mas);
 			remove_next = 1;
-			next = next_next;
+			end = next->vm_end;
 			goto again;
 		}
 	}
-	if (insert && file)
+	if (insert && file) {
 		uprobe_mmap(insert);
+	}
 
 	mas_destroy(&mas);
 	validate_mm(mm);
@@ -1613,8 +1635,8 @@
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
 }
 
-/**
- * unmapped_area() - Find an area between the low_limit and the high_limit with
+/*
+ * unmapped_area() Find an area between the low_limit and the high_limit with
  * the correct alignment and offset, all from @info. Note: current->mm is used
  * for the search.
  *
@@ -1640,15 +1662,12 @@
 
 	gap = mas.index;
 	gap += (info->align_offset - gap) & info->align_mask;
-	VM_BUG_ON(gap + info->length > info->high_limit);
-	VM_BUG_ON(gap + info->length > mas.last);
 	return gap;
 }
 
-/**
- * unmapped_area_topdown() - Find an area between the low_limit and the
+/* unmapped_area_topdown() Find an area between the low_limit and the
  * high_limit with * the correct alignment and offset at the highest available
- * address, all from @info. Note: current->mm is used for the search.
+ * address, all from * @info. Note: current->mm is used for the search.
  *
  * @info: The unmapped area information including the range (low_limit -
  * hight_limit), the alignment offset and mask.
@@ -1671,8 +1690,6 @@
 
 	gap = mas.last + 1 - info->length;
 	gap -= (gap - info->align_offset) & info->align_mask;
-	VM_BUG_ON(gap < info->low_limit);
-	VM_BUG_ON(gap < mas.index);
 	return gap;
 }
 
@@ -1884,12 +1901,12 @@
 EXPORT_SYMBOL(find_vma_intersection);
 
 /**
- * find_vma() - Find the VMA for a given address, or the next VMA.
+ * find_vma() - Find the VMA for a given address, or the next vma.
  * @mm: The mm_struct to check
  * @addr: The address
  *
- * Returns: The VMA associated with addr, or the next VMA.
- * May return %NULL in the case of no VMA at addr or above.
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
@@ -2642,7 +2659,7 @@
 	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
 				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
 		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				       NULL_VM_UFFD_CTX, NULL))) {
+				       NULL_VM_UFFD_CTX , NULL))) {
 		merge_start = prev->vm_start;
 		vma = prev;
 		vm_pgoff = prev->vm_pgoff;
@@ -3036,7 +3053,6 @@
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
-
 	validate_mm_mt(mm);
 
 	/*
@@ -3092,7 +3108,7 @@
 	vma->vm_flags = flags;
 	vma->vm_page_prot = vm_get_page_prot(flags);
 	mas_set_range(mas, vma->vm_start, addr + len - 1);
-	if (mas_store_gfp(mas, vma, GFP_KERNEL))
+	if ( mas_store_gfp(mas, vma, GFP_KERNEL))
 		goto mas_store_fail;
 
 	mm->map_count++;
@@ -3155,7 +3171,7 @@
 	vma = mas_prev(&mas, 0);
 	if (!vma || vma->vm_end != addr || vma_policy(vma) ||
 	    !can_vma_merge_after(vma, flags, NULL, NULL,
-				 addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL))
+				 addr >> PAGE_SHIFT,NULL_VM_UFFD_CTX, NULL))
 		vma = NULL;
 
 	ret = do_brk_flags(&mas, vma, addr, len, flags);

