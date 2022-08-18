Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF3F5982F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244567AbiHRMLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiHRMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:11:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE85AB2487
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:11:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so4526190pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kzmvoNQgiIWRnwZzMzobp1tHGFtTH4CV2xEta49XeYU=;
        b=x0wtd4OTLP4uK+TV5m0GPokcSGzSGnEtekDvuFyIT8wm5jUsYMrI618YI1gVX8SJrS
         wWuH4X/aTuSc52yVTpk4HagMsKkACzv9TAesbQXEziFxjSTfxNBSKLMpdk9mPAXT0NZe
         2XILROK+tpHSUNcJqZ7ok/vqtfqyqlNXwO8cN3yAHLJ22ssNLGPc++53UM6MPUgUwaKs
         Cql9YYFp9ffFHfoxWfU08tYoT0i9RSf7iGugJZEZX6MRGh7lmdJzIXMZfVvwTezNlUU1
         7mfSEezelGrhlSmyEcy9Y0S17lYJIZTDEIbo2AoO/Gzuy68KgBLMpGOAVApQI55sMBjI
         PY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kzmvoNQgiIWRnwZzMzobp1tHGFtTH4CV2xEta49XeYU=;
        b=lLCZBf8m67r9PPFoPiEWAhhy+nZ9p+65Ou0TOLPPFoYjCVfMbCbki/bYM7rOe/tOgb
         s5xl6JXzgMz8hRkGVPqYrYIlKY30iE8bv713MFzIPq4C1G3o57FFqie4z3jwdUIh4/BA
         KG0WUDrlWQYKX+zucZK+lFx/YkdZrJikF2hJLA7Phn1F9fM9aINDQ4SJBGY6zBo87vT3
         lkrszYg8utkS5NhwxXe8adDx6d86XLLzCC6Sr2WmLCtqx0xxBsSNuxzlH+/7Ln546jqk
         n13u2PyTXyTayaHLSq6zEEPO/UZ0wqhUdjnSHvoXcoMVWaAaK+tjNOWtLqYVIJVGwQTi
         hfHg==
X-Gm-Message-State: ACgBeo28l9QVKYTxwR8aYqZhJo7V64RhFgYuWVRieTpuZXArD6ZXsBtP
        FsKMIbZSWH2z/XuJipKMkhjYXw==
X-Google-Smtp-Source: AA6agR5kPbhz/wiQPh+Tc/oNj9yVoOLYtyFoQFKUJSbPlz/ERBQ85bHs4LQruTfe+WpU5RFoq82Osg==
X-Received: by 2002:a17:90a:4d8d:b0:1fa:9cc6:3408 with SMTP id m13-20020a17090a4d8d00b001fa9cc63408mr2703531pjh.245.1660824697180;
        Thu, 18 Aug 2022 05:11:37 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id h22-20020a17090a051600b001f246f2a423sm1337192pjh.17.2022.08.18.05.11.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Aug 2022 05:11:35 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        "zhangpeng.00" <zhangpeng.00@bytedance.com>
Subject: [PATCH] optimize iommu allocate iova
Date:   Thu, 18 Aug 2022 20:11:14 +0800
Message-Id: <20220818121114.20862-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "zhangpeng.00" <zhangpeng.00@bytedance.com>

Signed-off-by: zhangpeng.00 <zhangpeng.00@bytedance.com>
---
 drivers/iommu/iova.c | 411 ++++++++++++++++++++++++++++++-------------
 include/linux/iova.h |   8 +-
 2 files changed, 297 insertions(+), 122 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index db77aa675145..58e500e316d6 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -43,6 +43,166 @@ static struct iova *to_iova(struct rb_node *node)
 	return rb_entry(node, struct iova, node);
 }
 
+/*
+* gap_flag is a bits map.
+* We can allocate 2^order size area without any fragmentation
+* in range [low, high) if the corresponding bit was set.
+*
+* This function computes gap_flag for a given range [low, high)
+* in time complexity log(n).
+*/
+static unsigned long __compute_gap_flag(unsigned long low, unsigned long high)
+{
+	unsigned long gap_flag = 0;
+
+	while (low < high) {
+		int order = __ffs64(high);
+		unsigned long delta;
+
+		if (low > high - (1UL << order))
+			order = fls_long(high -low) -1;
+		delta = 1UL << order;
+		gap_flag |= delta;
+		high -= delta;
+	}
+	return gap_flag;
+}
+
+/*
+* This function return a start adress within [low, high) which is 
+* 2^split_order aligned and can be used to allocate the maximum 
+* 2^split_order size area.
+*
+* The time complexity of this function is log(n).
+*/
+static
+unsigned long split(unsigned long low, unsigned long high, int split_order)
+{
+	unsigned long best_low = ~0UL;
+	int best_order = 128;
+
+	while (low < high) {
+		int order = __ffs64(high);
+		unsigned long delta;
+
+		if (low > high - (1UL << order))
+			order = fls_long(high -low) - 1;
+		delta = 1UL << order;
+		if (order < best_order && order >= split_order) {
+			best_low = high - (1UL << split_order);
+			if(order == split_order)
+				break;
+			best_order = order;
+		}
+		high -= delta;
+	}
+	return best_low;
+}
+
+static inline unsigned long prev_iova_high(struct iova *iova)
+{
+	return iova->prev_iova ? iova->prev_iova->pfn_hi + 1 : 0;
+}
+
+static inline unsigned long iova_compute_gap_flag(struct iova *iova)
+{
+	return __compute_gap_flag(prev_iova_high(iova), iova->pfn_lo);
+}
+
+/*
+* Called by rbtree_augmented to maintain subtree_gap_flag.
+*
+* iova->subtree_gap_flag =
+* rb_entry(iova->node.rb_left) ->subtree_gap_flag |
+* rb_entry(iova->node.rb_right)->subtree_gap_flag |
+* ioa->gap_flag
+*/
+static inline bool iova_gap_callbacks_compute_or(struct iova *iova, bool exit)
+{
+	struct iova *child;
+	unsigned long subtree_gap_flag = iova->gap_flag;
+
+	if (iova->node.rb_left) {
+		child = rb_entry(iova->node.rb_left, struct iova, node);
+		subtree_gap_flag |= child->subtree_gap_flag;
+	}
+	if (iova->node.rb_right) {
+		child = rb_entry(iova->node.rb_right, struct iova, node);
+		subtree_gap_flag |= child->subtree_gap_flag;
+	}
+	if (exit && iova->subtree_gap_flag == subtree_gap_flag)
+		return true;
+	iova->subtree_gap_flag = subtree_gap_flag;
+	return false;
+}
+
+RB_DECLARE_CALLBACKS(static, iova_gap_callbacks, struct iova, node,
+			subtree_gap_flag,
+			iova_gap_callbacks_compute_or)
+
+/*
+* If a iova's gap_flag has been chanegd, we shoud call this function to maintain
+* the subtree_gap_flag in rbtree.
+*
+* The time complexity of this function is log(n).
+*/
+static inline void iova_subtree_gap_flag_update(struct iova *iova)
+{
+	iova_gap_callbacks_propagate(&iova->node, NULL);
+}
+
+static inline int __better_gap_flag(unsigned long first_flag, 
+					unsigned long second_flag)
+{
+	return __ffs64(second_flag) < __ffs64(first_flag) ? 2 : 1;
+}
+
+/*
+* Compare two gap_flag to choose the more appropriate gap_flag to allocate.
+* return 1: first_flag
+* return 2: second_second
+* return 0: they are all not satisfied
+*/
+static int better_gap_flag(unsigned long first_flag, 
+				unsigned long second_flag, int order)
+{
+	first_flag >>= order;
+	second_flag >>= order;
+
+	if (first_flag) {
+		if(second_flag)
+			return __better_gap_flag(first_flag, second_flag);
+		return 1;
+	}
+	return second_flag ? 2 : 0;
+}
+
+static inline void choose_better_gap(struct iova *iova,
+				struct iova **best_iova,
+				unsigned long *best_gap_flag,
+				bool *check_subtree,
+				unsigned long order)
+{
+	if (better_gap_flag(*best_gap_flag, iova->gap_flag, order) == 2) {
+		*best_iova = iova;
+		*best_gap_flag = iova->gap_flag;
+		*check_subtree = false;
+	}
+}
+
+static inline void choose_better_gap_subtree(struct iova *iova,
+				struct iova **best_iova,
+				unsigned long *best_gap_flag,
+				bool *check_subtree,
+				unsigned long order)
+{
+	if (better_gap_flag(*best_gap_flag, iova->subtree_gap_flag, order) == 2) {
+		*best_iova = iova;
+		*best_gap_flag = iova->subtree_gap_flag;
+		*check_subtree = true;
+	}
+}
+
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn)
@@ -56,90 +216,37 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 
 	spin_lock_init(&iovad->iova_rbtree_lock);
 	iovad->rbroot = RB_ROOT;
-	iovad->cached_node = &iovad->anchor.node;
-	iovad->cached32_node = &iovad->anchor.node;
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
-	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
+
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
+	iovad->anchor.prev_iova = NULL;
+	iovad->anchor.gap_flag = __compute_gap_flag(0, IOVA_ANCHOR);
+	iovad->anchor.subtree_gap_flag = iovad->anchor.gap_flag;
+
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
 	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
-}
-EXPORT_SYMBOL_GPL(init_iova_domain);
-
-static struct rb_node *
-__get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
-{
-	if (limit_pfn <= iovad->dma_32bit_pfn)
-		return iovad->cached32_node;
 
-	return iovad->cached_node;
-}
-
-static void
-__cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
-{
-	if (new->pfn_hi < iovad->dma_32bit_pfn)
-		iovad->cached32_node = &new->node;
-	else
-		iovad->cached_node = &new->node;
-}
-
-static void
-__cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
-{
-	struct iova *cached_iova;
-
-	cached_iova = to_iova(iovad->cached32_node);
-	if (free == cached_iova ||
-	    (free->pfn_hi < iovad->dma_32bit_pfn &&
-	     free->pfn_lo >= cached_iova->pfn_lo))
-		iovad->cached32_node = rb_next(&free->node);
-
-	if (free->pfn_lo < iovad->dma_32bit_pfn)
-		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
-
-	cached_iova = to_iova(iovad->cached_node);
-	if (free->pfn_lo >= cached_iova->pfn_lo)
-		iovad->cached_node = rb_next(&free->node);
+	if(start_pfn)
+		reserve_iova(iovad, 0, start_pfn - 1);
 }
+EXPORT_SYMBOL_GPL(init_iova_domain);
 
-static struct rb_node *iova_find_limit(struct iova_domain *iovad, unsigned long limit_pfn)
+static struct rb_node *iova_find_limit(struct iova_domain *iovad,
+						unsigned long limit_pfn)
 {
-	struct rb_node *node, *next;
-	/*
-	 * Ideally what we'd like to judge here is whether limit_pfn is close
-	 * enough to the highest-allocated IOVA that starting the allocation
-	 * walk from the anchor node will be quicker than this initial work to
-	 * find an exact starting point (especially if that ends up being the
-	 * anchor node anyway). This is an incredibly crude approximation which
-	 * only really helps the most likely case, but is at least trivially easy.
-	 */
-	if (limit_pfn > iovad->dma_32bit_pfn)
-		return &iovad->anchor.node;
-
-	node = iovad->rbroot.rb_node;
-	while (to_iova(node)->pfn_hi < limit_pfn)
-		node = node->rb_right;
-
-search_left:
-	while (node->rb_left && to_iova(node->rb_left)->pfn_lo >= limit_pfn)
-		node = node->rb_left;
-
-	if (!node->rb_left)
-		return node;
-
-	next = node->rb_left;
-	while (next->rb_right) {
-		next = next->rb_right;
-		if (to_iova(next)->pfn_lo >= limit_pfn) {
-			node = next;
-			goto search_left;
-		}
+	struct rb_node *curr = iovad->rbroot.rb_node;
+	while (curr) {
+		struct iova *iova = to_iova(curr);
+		if (limit_pfn - 1 > iova->pfn_hi)
+			curr = curr->rb_right;
+		else if (limit_pfn > prev_iova_high(iova))
+			break;
+		else 
+			curr = curr->rb_left;
 	}
-
-	return node;
+	return curr;
 }
 
 /* Insert the iova into domain rbtree by holding writer lock */
@@ -148,6 +255,7 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
 		   struct rb_node *start)
 {
 	struct rb_node **new, *parent = NULL;
+	struct iova *next_iova;
 
 	new = (start) ? &start : &(root->rb_node);
 	/* Figure out where to put new node */
@@ -166,69 +274,129 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
 		}
 	}
 	/* Add new node and rebalance tree. */
+
 	rb_link_node(&iova->node, parent, new);
-	rb_insert_color(&iova->node, root);
+
+	next_iova = to_iova(rb_next(&iova->node));
+	iova->prev_iova = next_iova->prev_iova;
+	next_iova->prev_iova = iova;
+
+	iova->gap_flag = iova_compute_gap_flag(iova);
+	next_iova->gap_flag = iova_compute_gap_flag(next_iova);
+
+	iova_subtree_gap_flag_update(iova);
+	iova_subtree_gap_flag_update(next_iova);
+
+	rb_insert_augmented(&iova->node, root, &iova_gap_callbacks);
 }
 
+
 static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		unsigned long size, unsigned long limit_pfn,
 			struct iova *new, bool size_aligned)
 {
-	struct rb_node *curr, *prev;
-	struct iova *curr_iova;
+	int order = fls_long(size - 1);
 	unsigned long flags;
-	unsigned long new_pfn, retry_pfn;
-	unsigned long align_mask = ~0UL;
-	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
+	struct rb_node *curr;
+	struct rb_node *parent;
+	struct iova *curr_iova;
+	unsigned long start_pfn;
+	bool ignore = false;
+	struct iova *best_iova  = NULL;
+	unsigned long best_gap_flag;
+	bool check_subtree;
 
-	if (size_aligned)
-		align_mask <<= fls_long(size - 1);
+	BUG_ON(limit_pfn == 0);
 
-	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	if (limit_pfn <= iovad->dma_32bit_pfn &&
-			size >= iovad->max32_alloc_size)
-		goto iova32_full;
+	curr = iova_find_limit(iovad, limit_pfn);
 
-	curr = __get_cached_rbnode(iovad, limit_pfn);
 	curr_iova = to_iova(curr);
-	retry_pfn = curr_iova->pfn_hi + 1;
+	best_gap_flag = __compute_gap_flag(prev_iova_high(curr_iova), 
+					min(limit_pfn , curr_iova->pfn_lo));
 
-retry:
-	do {
-		high_pfn = min(high_pfn, curr_iova->pfn_lo);
-		new_pfn = (high_pfn - size) & align_mask;
-		prev = curr;
-		curr = rb_prev(curr);
-		curr_iova = to_iova(curr);
-	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
-
-	if (high_pfn < size || new_pfn < low_pfn) {
-		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
-			high_pfn = limit_pfn;
-			low_pfn = retry_pfn;
-			curr = iova_find_limit(iovad, limit_pfn);
+	/*
+	* Check limit_iova whether it can allocate from
+	* the gap between it and it's previous iova.
+	*/
+	if (better_gap_flag(0, best_gap_flag, order) == 2) {
+		best_iova = curr_iova;
+		check_subtree = false;
+	}
+
+	while (true) {
+		/*
+		* Check the left sub_tree whether it has a better gap.
+		*/
+		if (!ignore && curr->rb_left) {
+			curr_iova = to_iova(curr->rb_left);
+			choose_better_gap_subtree(curr_iova, &best_iova, 
+				&best_gap_flag, &check_subtree, order);
+		}
+
+		parent = rb_parent(curr);
+		if (parent == NULL)
+			break;
+		/*
+		* If current node is the left child of it parent,
+		* the parent node and the parent's right sub_tree should not 
+		* to be checked because they exceed the limit_pfn.
+		*/
+		ignore = parent->rb_left == curr;
+		curr = parent;
+
+		/*
+		* Check the current rbtree_node whether it is better.
+		*/ 
+		if (!ignore) {
 			curr_iova = to_iova(curr);
-			goto retry;
+			choose_better_gap(curr_iova, &best_iova, 
+					&best_gap_flag, &check_subtree, order);
 		}
-		iovad->max32_alloc_size = size;
-		goto iova32_full;
 	}
 
-	/* pfn_lo will point to size aligned address if size_aligned is set */
-	new->pfn_lo = new_pfn;
-	new->pfn_hi = new->pfn_lo + size - 1;
+	if (!best_iova) {
+		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+		return -ENOMEM;
+	}
 
-	/* If we have 'prev', it's a valid place to start the insertion. */
-	iova_insert_rbtree(&iovad->rbroot, new, prev);
-	__cached_rbnode_insert_update(iovad, new);
+	/*
+	* If best_gap is in a sub_tree, we should find where it is.
+	*/
+	if (check_subtree) {
+		int best_order = __ffs(best_gap_flag & (~0UL << order));
+
+		curr = &best_iova->node;
+		while (true) {
+			if(curr->rb_right && 
+				to_iova(curr->rb_right)->subtree_gap_flag & 
+					(1UL << best_order)) {
+				curr = curr->rb_right;
+				continue;
+			}
 
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-	return 0;
+			if (to_iova(curr)->gap_flag & (1UL << best_order))
+				break;
 
-iova32_full:
+			curr = curr->rb_left;
+			/*
+			* Due to the subtree_gap_flag, curr is NULL should be 
+			* impossible. We must find the best appropriate gap 
+			* to allocate.
+			*/
+			BUG_ON(!curr);		
+		}
+		best_iova = to_iova(curr);	
+	}
+
+	start_pfn = split(prev_iova_high(best_iova),
+				min(best_iova->pfn_lo, limit_pfn), order);
+
+	new->pfn_lo = start_pfn;
+	new->pfn_hi = start_pfn + size - 1;
+	iova_insert_rbtree(&iovad->rbroot, new, &best_iova->node);
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-	return -ENOMEM;
+	return 0;
 }
 
 static struct kmem_cache *iova_cache;
@@ -324,7 +492,6 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 		free_iova_mem(new_iova);
 		return NULL;
 	}
-
 	return new_iova;
 }
 EXPORT_SYMBOL_GPL(alloc_iova);
@@ -352,9 +519,14 @@ private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 
 static void remove_iova(struct iova_domain *iovad, struct iova *iova)
 {
+	struct iova *next_iova;
 	assert_spin_locked(&iovad->iova_rbtree_lock);
-	__cached_rbnode_delete_update(iovad, iova);
-	rb_erase(&iova->node, &iovad->rbroot);
+	
+	next_iova = to_iova(rb_next(&iova->node));
+	next_iova->prev_iova = iova->prev_iova;
+	next_iova->gap_flag = iova_compute_gap_flag(next_iova);
+	iova_subtree_gap_flag_update(next_iova);
+	rb_erase_augmented(&iova->node, &iovad->rbroot, &iova_gap_callbacks);
 }
 
 /**
@@ -554,8 +726,11 @@ static void
 __adjust_overlap_range(struct iova *iova,
 	unsigned long *pfn_lo, unsigned long *pfn_hi)
 {
-	if (*pfn_lo < iova->pfn_lo)
+	if (*pfn_lo < iova->pfn_lo) {
 		iova->pfn_lo = *pfn_lo;
+		iova->gap_flag = iova_compute_gap_flag(iova);
+		iova_subtree_gap_flag_update(iova);
+	}
 	if (*pfn_hi > iova->pfn_hi)
 		*pfn_lo = iova->pfn_hi + 1;
 }
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 320a70e40233..95cf1793cd0b 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -11,7 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_augmented.h>
 #include <linux/dma-mapping.h>
 
 /* iova structure */
@@ -19,6 +19,9 @@ struct iova {
 	struct rb_node	node;
 	unsigned long	pfn_hi; /* Highest allocated pfn */
 	unsigned long	pfn_lo; /* Lowest allocated pfn */
+	struct iova	*prev_iova;
+	unsigned long 	gap_flag;
+	unsigned long	subtree_gap_flag;
 };
 
 
@@ -28,12 +31,9 @@ struct iova_rcache;
 struct iova_domain {
 	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree */
 	struct rb_root	rbroot;		/* iova domain rbtree root */
-	struct rb_node	*cached_node;	/* Save last alloced node */
-	struct rb_node	*cached32_node; /* Save last 32-bit alloced node */
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
-	unsigned long	max32_alloc_size; /* Size of last failed allocation */
 	struct iova	anchor;		/* rbtree lookup anchor */
 
 	struct iova_rcache	*rcaches;
-- 
2.20.1

