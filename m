Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC5C59F51C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiHXIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbiHXIXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:23:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059A793507
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:23:14 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MCJt54nflzkWf4;
        Wed, 24 Aug 2022 16:19:41 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 16:22:57 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 16:22:56 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <willy@infradead.org>, <akpm@linux-foundation.org>,
        <Liam.Howlett@Oracle.com>, <vbabka@suse.cz>
Subject: [PATCH -next] Maple Tree: remove not used entry in mas_preallocate()
Date:   Wed, 24 Aug 2022 16:30:44 +0800
Message-ID: <20220824083044.3236796-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'entry' is not used in mas_preallocate(), so remove it.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 include/linux/maple_tree.h |  2 +-
 lib/maple_tree.c           |  3 +--
 lib/test_maple_tree.c      | 32 ++++++++++++++++----------------
 mm/mmap.c                  | 14 +++++++-------
 mm/nommu.c                 |  8 ++++----
 5 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index a30e03b06bed..61871480d125 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -456,7 +456,7 @@ int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp);
 void mas_store_prealloc(struct ma_state *mas, void *entry);
 void *mas_find(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
-int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp);
+int mas_preallocate(struct ma_state *mas, gfp_t gfp);
 bool mas_is_err(struct ma_state *mas);
 
 bool mas_nomem(struct ma_state *mas, gfp_t gfp);
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e1743803c851..2adc12a83caf 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5707,12 +5707,11 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 /**
  * mas_preallocate() - Preallocate enough nodes for a store operation
  * @mas: The maple state
- * @entry: The entry that will be stored
  * @gfp: The GFP_FLAGS to use for allocations.
  *
  * Return: 0 on success, -ENOMEM if memory could not be allocated.
  */
-int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
+int mas_preallocate(struct ma_state *mas, gfp_t gfp)
 {
 	int ret;
 
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 4f69e009a015..80d1754de23e 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -35549,7 +35549,7 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	for (i = 0; i <= max; i++)
 		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35558,18 +35558,18 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35577,25 +35577,25 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	ma_free_rcu(mn);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 	ma_free_rcu(mn);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35604,12 +35604,12 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	mas_push_node(&mas, mn);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35617,21 +35617,21 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35639,14 +35639,14 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 	mas_destroy(&mas);
 
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35654,7 +35654,7 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated != 0);
diff --git a/mm/mmap.c b/mm/mmap.c
index 6445fd386f04..63a03ce1d0bb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -473,7 +473,7 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct address_space *mapping = NULL;
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(&mas, GFP_KERNEL))
 		return -ENOMEM;
 
 	if (vma->vm_file) {
@@ -539,7 +539,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 	/* Only handles expanding */
 	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
 
-	if (mas_preallocate(mas, vma, GFP_KERNEL))
+	if (mas_preallocate(mas, GFP_KERNEL))
 		goto nomem;
 
 	vma_adjust_trans_huge(vma, start, end, 0);
@@ -712,7 +712,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		}
 	}
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(&mas, GFP_KERNEL))
 		return -ENOMEM;
 
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
@@ -1937,7 +1937,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		/* Check that both stack segments have the same anon_vma? */
 	}
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(&mas, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* We must make sure the anon_vma is allocated. */
@@ -2018,7 +2018,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 			return -ENOMEM;
 	}
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(&mas, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* We must make sure the anon_vma is allocated. */
@@ -2310,7 +2310,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
 
-	if (mas_preallocate(mas, vma, GFP_KERNEL))
+	if (mas_preallocate(mas, GFP_KERNEL))
 		return -ENOMEM;
 
 	mas->last = end - 1;
@@ -2678,7 +2678,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			goto free_vma;
 	}
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (mas_preallocate(&mas, GFP_KERNEL)) {
 		error = -ENOMEM;
 		if (file)
 			goto unmap_and_free_vma;
diff --git a/mm/nommu.c b/mm/nommu.c
index 214c70e1d059..0befa4060aea 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -602,7 +602,7 @@ static int add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (mas_preallocate(&mas, GFP_KERNEL)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 		       current->pid);
 		return -ENOMEM;
@@ -633,7 +633,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
 {
 	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (mas_preallocate(&mas, GFP_KERNEL)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 		       current->pid);
 		return -ENOMEM;
@@ -1081,7 +1081,7 @@ unsigned long do_mmap(struct file *file,
 	if (!vma)
 		goto error_getting_vma;
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(&mas, GFP_KERNEL))
 		goto error_maple_preallocate;
 
 	region->vm_usage = 1;
@@ -1358,7 +1358,7 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (!new)
 		goto err_vma_dup;
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (mas_preallocate(&mas, GFP_KERNEL)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 			current->pid);
 		goto err_mas_preallocate;
-- 
2.25.1

