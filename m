Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF3C4C212F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiBXBnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiBXBnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:43:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C50574A4;
        Wed, 23 Feb 2022 17:42:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C830B82334;
        Thu, 24 Feb 2022 01:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD05C340E7;
        Thu, 24 Feb 2022 01:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645665419;
        bh=vNEbvywmyUr4OP031dUp7aKTPfYS8dSy6+FIPFhmc/8=;
        h=From:To:Cc:Subject:Date:From;
        b=pYTcjxH4oc/8QnPy2E8blXq7rVjRxsCT5wct71mKQj9iTZAltPIAtSpLHZQVOVA8G
         PbeJlxMJYtnAuVzkg/r2xIeK0sHQ/cKrvxTmcOQbqIYeTJeXNbg7lFDCkurxfd07LC
         GyluwP3DTDBMyw2vv3k6l8k6pwTyuXsmbOC1/+a5eDQdJPX1xVOBt5tw9arcdQF6EJ
         sl6tcRc6VAU6PU/61pxzv8HDreNB9yNKNHl2wzkL3v6wxNjQz1wyq7ST1zVpVaiDLj
         nOFVbRwJPpGHQ8scaFgZ7jOXwRnOc07d9JXEQYQTHJ2Y3YeVSV/E3uqzqF4jW8o5NL
         SGGV06C2DGHAg==
From:   broonie@kernel.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the maple tree
Date:   Thu, 24 Feb 2022 01:16:53 +0000
Message-Id: <20220224011653.1380557-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  mm/mmap.c

between commit:

  f0b1293f7ebbb ("mm/mmap: Reorganize munmap to use maple states")

from the maple tree and commit:

  a213e5cf71cbc ("mm/munlock: delete munlock_vma_pages_all(), allow oomreap")

from the folio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

I have absolutely no confindence in this resolution.

diff --cc mm/mmap.c
index 1b3600152f6f5,64b5985b5295c..0000000000000
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@@ -2286,32 -2780,38 +2286,37 @@@ int split_vma(struct mm_struct *mm, str
  	return __split_vma(mm, vma, addr, new_below);
  }
  
 -/* Munmap is split into 2 main parts -- this part which finds
 +/*
 + * do_mas_align_munmap() - munmap the aligned region from @start to @end.
 + * @mas: The maple_state, ideally set up to alter the correct tree location.
 + * @vma: The starting vm_area_struct
 + * @mm: The mm_struct
 + * @start: The aligned start address to munmap.
 + * @end: The aligned end address to munmap.
 + * @uf: The userfaultfd list_head
 + * @downgrade: Set to true to attempt a write downgrade of the mmap_sem
 + *
 + * If @downgrade is true, check return code for potential release of the lock.
++ *
++ * Munmap is split into 2 main parts -- this part which finds
+  * what needs doing, and the areas themselves, which do the
+  * work.  This now handles partial unmappings.
+  * Jeremy Fitzhardinge <jeremy@goop.org>
   */
 -int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 -		struct list_head *uf, bool downgrade)
 -{
 -	unsigned long end;
 -	struct vm_area_struct *vma, *prev, *last;
 -
 -	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
 -		return -EINVAL;
 -
 -	len = PAGE_ALIGN(len);
 -	end = start + len;
 -	if (len == 0)
 -		return -EINVAL;
 -
 -	/*
 -	 * arch_unmap() might do unmaps itself.  It must be called
 -	 * and finish any rbtree manipulation before this code
 -	 * runs and also starts to manipulate the rbtree.
 -	 */
 -	arch_unmap(mm, start, end);
 -
 -	/* Find the first overlapping VMA where start < vma->vm_end */
 -	vma = find_vma_intersection(mm, start, end);
 -	if (!vma)
 -		return 0;
 -	prev = vma->vm_prev;
 -
 +static int
 +do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 +		    struct mm_struct *mm, unsigned long start,
 +		    unsigned long end, struct list_head *uf, bool downgrade)
 +{
 +	struct vm_area_struct *prev, *next;
 +	struct maple_tree mt_detach;
 +	int count = 0;
 +	MA_STATE(mas_detach, &mt_detach, start, end - 1);
 +	mt_init_flags(&mt_detach, MM_MT_FLAGS);
 +	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
 +
 +	mas->last = end - 1;
 +	prev = next = NULL;
  	/*
  	 * If we need to split any vma, do it now to save pain later.
  	 *
@@@ -3107,13 -3127,8 +3112,12 @@@ void exit_mmap(struct mm_struct *mm
  		 * Nothing can be holding mm->mmap_lock here and the above call
  		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
  		 * __oom_reap_task_mm() will not block.
 +		 *
 +		 * This needs to be done before unlocking the VMAs in the loop
 +		 * below which clears VM_LOCKED, otherwise the oom reaper cannot
 +		 * reliably test it.
  		 */
  		(void)__oom_reap_task_mm(mm);
- 
  		set_bit(MMF_OOM_SKIP, &mm->flags);
  	}

diff --git a/mm/mmap.c b/mm/mmap.c
index 2ddf1caf90488..d469555df0a21 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2373,10 +2373,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 		BUG_ON(next->vm_start > end);
 #endif
 		vma_mas_store(next, &mas_detach);
-		if (next->vm_flags & VM_LOCKED) {
+		if (next->vm_flags & VM_LOCKED)
 			mm->locked_vm -= vma_pages(next);
-			munlock_vma_pages_all(next);
-		}
 	}
 
 	next = mas_find(mas, ULONG_MAX);
@@ -2906,10 +2904,8 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	}
 
 	unmap_pages = vma_pages(&unmap);
-	if (vma->vm_flags & VM_LOCKED) {
+	if (vma->vm_flags & VM_LOCKED)
 		mm->locked_vm -= unmap_pages;
-		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
-	}
 
 	next = mas_next(mas, ULONG_MAX);
 	mmap_write_downgrade(mm);
@@ -3130,10 +3126,8 @@ void exit_mmap(struct mm_struct *mm)
 	rwsem_acquire(&mm->mmap_lock.dep_map, 0, 0, _THIS_IP_);
 	if (mm->locked_vm) {
 		mas_for_each(&mas, vma, ULONG_MAX) {
-			if (vma->vm_flags & VM_LOCKED) {
+			if (vma->vm_flags & VM_LOCKED)
 				mm->locked_vm -= vma_pages(vma);
-				munlock_vma_pages_all(vma);
-			}
 		}
 		mas_set(&mas, 0);
 	}

diff --git a/mm/mmap.c b/mm/mmap.c
index 2ddf1caf90488..d469555df0a21 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2373,10 +2373,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 		BUG_ON(next->vm_start > end);
 #endif
 		vma_mas_store(next, &mas_detach);
-		if (next->vm_flags & VM_LOCKED) {
+		if (next->vm_flags & VM_LOCKED)
 			mm->locked_vm -= vma_pages(next);
-			munlock_vma_pages_all(next);
-		}
 	}
 
 	next = mas_find(mas, ULONG_MAX);
@@ -2906,10 +2904,8 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	}
 
 	unmap_pages = vma_pages(&unmap);
-	if (vma->vm_flags & VM_LOCKED) {
+	if (vma->vm_flags & VM_LOCKED)
 		mm->locked_vm -= unmap_pages;
-		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
-	}
 
 	next = mas_next(mas, ULONG_MAX);
 	mmap_write_downgrade(mm);
@@ -3130,10 +3126,8 @@ void exit_mmap(struct mm_struct *mm)
 	rwsem_acquire(&mm->mmap_lock.dep_map, 0, 0, _THIS_IP_);
 	if (mm->locked_vm) {
 		mas_for_each(&mas, vma, ULONG_MAX) {
-			if (vma->vm_flags & VM_LOCKED) {
+			if (vma->vm_flags & VM_LOCKED)
 				mm->locked_vm -= vma_pages(vma);
-				munlock_vma_pages_all(vma);
-			}
 		}
 		mas_set(&mas, 0);
 	}
