Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461BA5A7466
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiHaDVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiHaDUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:20:47 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2C512AC1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:41 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 73so4050315pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EoGywsqR3Qxm0ioJNhxU6FuWToutHdJdhmaSFzdi9gE=;
        b=Ry5R5htbwYmzwnCheXUOYlUheFCUpd3DWn23SISDbh5FFFrNnYShP3CiKtubfjtsJA
         B2hlp4lxkrtzVD563WhGafC8HqfLzFH7LLQD4DE/DuYnizcNR1ESt7nAe+p5+XEV4GbE
         KfyDitLGDQCVgBm7xcxi6N9NPZrjLMI2tDYaXxsB8eqjeh1n9X7Cr7eUNjMNsjaN5VvK
         jMX1d1i8wFYZc8U2535wScxoBWqj0zkDn2bK+uVj3FVPn6m3DDJfJDnPbzwdDmFmOIXO
         h7E0F1hoV0kAVrGoZQ5NGNJ+lpYM55XtZ0qdQ4aPjJpO49f1xSCFKJtjamhBqoyDuaen
         0zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EoGywsqR3Qxm0ioJNhxU6FuWToutHdJdhmaSFzdi9gE=;
        b=QFR0Fh+j/YXJt9SfCLV/E+gVe12WOSnRTU1zn4HTbRoo/Emt6jG/r9MlvD0Ph3YCAD
         yo7/2ekJuM+Iqljjs0awZMf/op5iB4ZVQjVL/Dit2gplWKI5mBqxculx9jeqhLm/shKp
         KxYsLIkimb+oVEkm/BdIw3vtTgtw1OqEr8yJuMXP7W6AHxaFBA1tBN+mQX36yqIeEa6o
         xmxAT8YQS4IG+xgNSEr0KmgpCwYiJbAPdCSDmRLJRY6xmtpwAPy/4EoBsn4Gp4H7EYcw
         GW2hGUP9/BjsjpeBibnCnuLDV3bHVYme9OOmtRs9Ww/iE/0IvM0LD5W2J8z39NPPGZ6v
         9TTg==
X-Gm-Message-State: ACgBeo1XuF6WP+iqVI0Wu4/PZ/BJWIrK36WewO308vJmTzWp2Nso4v+u
        9oWnhUMD7pkdOXPIJ0wrdomauA==
X-Google-Smtp-Source: AA6agR6B5Vc7odb1gh/RNIZE9Im56O0C4zoTP80UqYg7hw2yZis5IUBGN/AQraK+lkJgxuwAmdftbA==
X-Received: by 2002:a63:2a49:0:b0:41d:95d8:3d3d with SMTP id q70-20020a632a49000000b0041d95d83d3dmr20305943pgq.43.1661916041243;
        Tue, 30 Aug 2022 20:20:41 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b0015e8d4eb1d5sm8633535pla.31.2022.08.30.20.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:20:40 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, vbabka@suse.cz, hannes@cmpxchg.org,
        minchan@kernel.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 7/7] ksm: convert to use common struct mm_slot
Date:   Wed, 31 Aug 2022 11:19:51 +0800
Message-Id: <20220831031951.43152-8-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220831031951.43152-1-zhengqi.arch@bytedance.com>
References: <20220831031951.43152-1-zhengqi.arch@bytedance.com>
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

Convert to use common struct mm_slot, no functional change.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/ksm.c | 132 +++++++++++++++++++++++--------------------------------
 1 file changed, 56 insertions(+), 76 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 667efca75b0d..d8c4819d81eb 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -42,6 +42,7 @@
 
 #include <asm/tlbflush.h>
 #include "internal.h"
+#include "mm_slot.h"
 
 #ifdef CONFIG_NUMA
 #define NUMA(x)		(x)
@@ -113,16 +114,12 @@
 
 /**
  * struct ksm_mm_slot - ksm information per mm that is being scanned
- * @hash: link to the mm_slots hash list
- * @mm_node: link into the mm_slots list, rooted in ksm_mm_head
+ * @slot: hash lookup from mm to mm_slot
  * @rmap_list: head for this mm_slot's singly-linked list of rmap_items
- * @mm: the mm that this information is valid for
  */
 struct ksm_mm_slot {
-	struct hlist_node hash;
-	struct list_head mm_node;
+	struct mm_slot slot;
 	struct ksm_rmap_item *rmap_list;
-	struct mm_struct *mm;
 };
 
 /**
@@ -231,7 +228,7 @@ static LIST_HEAD(migrate_nodes);
 static DEFINE_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 
 static struct ksm_mm_slot ksm_mm_head = {
-	.mm_node = LIST_HEAD_INIT(ksm_mm_head.mm_node),
+	.slot.mm_node = LIST_HEAD_INIT(ksm_mm_head.slot.mm_node),
 };
 static struct ksm_scan ksm_scan = {
 	.mm_slot = &ksm_mm_head,
@@ -408,36 +405,6 @@ static inline void free_stable_node(struct ksm_stable_node *stable_node)
 	kmem_cache_free(stable_node_cache, stable_node);
 }
 
-static inline struct ksm_mm_slot *alloc_mm_slot(void)
-{
-	if (!mm_slot_cache)	/* initialization failed */
-		return NULL;
-	return kmem_cache_zalloc(mm_slot_cache, GFP_KERNEL);
-}
-
-static inline void free_mm_slot(struct ksm_mm_slot *mm_slot)
-{
-	kmem_cache_free(mm_slot_cache, mm_slot);
-}
-
-static struct ksm_mm_slot *get_mm_slot(struct mm_struct *mm)
-{
-	struct ksm_mm_slot *slot;
-
-	hash_for_each_possible(mm_slots_hash, slot, hash, (unsigned long)mm)
-		if (slot->mm == mm)
-			return slot;
-
-	return NULL;
-}
-
-static void insert_to_mm_slots_hash(struct mm_struct *mm,
-				    struct ksm_mm_slot *mm_slot)
-{
-	mm_slot->mm = mm;
-	hash_add(mm_slots_hash, &mm_slot->hash, (unsigned long)mm);
-}
-
 /*
  * ksmd, and unmerge_and_remove_all_rmap_items(), must not touch an mm's
  * page tables after it has passed through ksm_exit() - which, if necessary,
@@ -975,20 +942,22 @@ static int remove_all_stable_nodes(void)
 static int unmerge_and_remove_all_rmap_items(void)
 {
 	struct ksm_mm_slot *mm_slot;
+	struct mm_slot *slot;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int err = 0;
 
 	spin_lock(&ksm_mmlist_lock);
-	ksm_scan.mm_slot = list_entry(ksm_mm_head.mm_node.next,
-						struct ksm_mm_slot, mm_node);
+	slot = list_entry(ksm_mm_head.slot.mm_node.next,
+			  struct mm_slot, mm_node);
+	ksm_scan.mm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
 	spin_unlock(&ksm_mmlist_lock);
 
 	for (mm_slot = ksm_scan.mm_slot; mm_slot != &ksm_mm_head;
 	     mm_slot = ksm_scan.mm_slot) {
-		VMA_ITERATOR(vmi, mm_slot->mm, 0);
+		VMA_ITERATOR(vmi, mm_slot->slot.mm, 0);
 
-		mm = mm_slot->mm;
+		mm = mm_slot->slot.mm;
 		mmap_read_lock(mm);
 		for_each_vma(vmi, vma) {
 			if (ksm_test_exit(mm))
@@ -1005,14 +974,15 @@ static int unmerge_and_remove_all_rmap_items(void)
 		mmap_read_unlock(mm);
 
 		spin_lock(&ksm_mmlist_lock);
-		ksm_scan.mm_slot = list_entry(mm_slot->mm_node.next,
-						struct ksm_mm_slot, mm_node);
+		slot = list_entry(mm_slot->slot.mm_node.next,
+				  struct mm_slot, mm_node);
+		ksm_scan.mm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
 		if (ksm_test_exit(mm)) {
-			hash_del(&mm_slot->hash);
-			list_del(&mm_slot->mm_node);
+			hash_del(&mm_slot->slot.hash);
+			list_del(&mm_slot->slot.mm_node);
 			spin_unlock(&ksm_mmlist_lock);
 
-			free_mm_slot(mm_slot);
+			mm_slot_free(mm_slot_cache, mm_slot);
 			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
 			mmdrop(mm);
 		} else
@@ -2233,7 +2203,7 @@ static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
 	rmap_item = alloc_rmap_item();
 	if (rmap_item) {
 		/* It has already been zeroed */
-		rmap_item->mm = mm_slot->mm;
+		rmap_item->mm = mm_slot->slot.mm;
 		rmap_item->address = addr;
 		rmap_item->rmap_list = *rmap_list;
 		*rmap_list = rmap_item;
@@ -2244,17 +2214,18 @@ static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
 static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 {
 	struct mm_struct *mm;
-	struct ksm_mm_slot *slot;
+	struct ksm_mm_slot *mm_slot;
+	struct mm_slot *slot;
 	struct vm_area_struct *vma;
 	struct ksm_rmap_item *rmap_item;
 	struct vma_iterator vmi;
 	int nid;
 
-	if (list_empty(&ksm_mm_head.mm_node))
+	if (list_empty(&ksm_mm_head.slot.mm_node))
 		return NULL;
 
-	slot = ksm_scan.mm_slot;
-	if (slot == &ksm_mm_head) {
+	mm_slot = ksm_scan.mm_slot;
+	if (mm_slot == &ksm_mm_head) {
 		/*
 		 * A number of pages can hang around indefinitely on per-cpu
 		 * pagevecs, raised page count preventing write_protect_page
@@ -2291,20 +2262,23 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			root_unstable_tree[nid] = RB_ROOT;
 
 		spin_lock(&ksm_mmlist_lock);
-		slot = list_entry(slot->mm_node.next, struct ksm_mm_slot, mm_node);
-		ksm_scan.mm_slot = slot;
+		slot = list_entry(mm_slot->slot.mm_node.next,
+				  struct mm_slot, mm_node);
+		mm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
+		ksm_scan.mm_slot = mm_slot;
 		spin_unlock(&ksm_mmlist_lock);
 		/*
 		 * Although we tested list_empty() above, a racing __ksm_exit
 		 * of the last mm on the list may have removed it since then.
 		 */
-		if (slot == &ksm_mm_head)
+		if (mm_slot == &ksm_mm_head)
 			return NULL;
 next_mm:
 		ksm_scan.address = 0;
-		ksm_scan.rmap_list = &slot->rmap_list;
+		ksm_scan.rmap_list = &mm_slot->rmap_list;
 	}
 
+	slot = &mm_slot->slot;
 	mm = slot->mm;
 	vma_iter_init(&vmi, mm, ksm_scan.address);
 
@@ -2334,7 +2308,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			if (PageAnon(*page)) {
 				flush_anon_page(vma, *page, ksm_scan.address);
 				flush_dcache_page(*page);
-				rmap_item = get_next_rmap_item(slot,
+				rmap_item = get_next_rmap_item(mm_slot,
 					ksm_scan.rmap_list, ksm_scan.address);
 				if (rmap_item) {
 					ksm_scan.rmap_list =
@@ -2355,7 +2329,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 	if (ksm_test_exit(mm)) {
 no_vmas:
 		ksm_scan.address = 0;
-		ksm_scan.rmap_list = &slot->rmap_list;
+		ksm_scan.rmap_list = &mm_slot->rmap_list;
 	}
 	/*
 	 * Nuke all the rmap_items that are above this current rmap:
@@ -2364,8 +2338,9 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 	remove_trailing_rmap_items(ksm_scan.rmap_list);
 
 	spin_lock(&ksm_mmlist_lock);
-	ksm_scan.mm_slot = list_entry(slot->mm_node.next,
-						struct ksm_mm_slot, mm_node);
+	slot = list_entry(mm_slot->slot.mm_node.next,
+			  struct mm_slot, mm_node);
+	ksm_scan.mm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
 	if (ksm_scan.address == 0) {
 		/*
 		 * We've completed a full scan of all vmas, holding mmap_lock
@@ -2376,11 +2351,11 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		 * or when all VM_MERGEABLE areas have been unmapped (and
 		 * mmap_lock then protects against race with MADV_MERGEABLE).
 		 */
-		hash_del(&slot->hash);
-		list_del(&slot->mm_node);
+		hash_del(&mm_slot->slot.hash);
+		list_del(&mm_slot->slot.mm_node);
 		spin_unlock(&ksm_mmlist_lock);
 
-		free_mm_slot(slot);
+		mm_slot_free(mm_slot_cache, mm_slot);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
 		mmap_read_unlock(mm);
 		mmdrop(mm);
@@ -2397,8 +2372,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 	}
 
 	/* Repeat until we've completed scanning the whole list */
-	slot = ksm_scan.mm_slot;
-	if (slot != &ksm_mm_head)
+	mm_slot = ksm_scan.mm_slot;
+	if (mm_slot != &ksm_mm_head)
 		goto next_mm;
 
 	ksm_scan.seqnr++;
@@ -2426,7 +2401,7 @@ static void ksm_do_scan(unsigned int scan_npages)
 
 static int ksmd_should_run(void)
 {
-	return (ksm_run & KSM_RUN_MERGE) && !list_empty(&ksm_mm_head.mm_node);
+	return (ksm_run & KSM_RUN_MERGE) && !list_empty(&ksm_mm_head.slot.mm_node);
 }
 
 static int ksm_scan_thread(void *nothing)
@@ -2516,17 +2491,20 @@ EXPORT_SYMBOL_GPL(ksm_madvise);
 int __ksm_enter(struct mm_struct *mm)
 {
 	struct ksm_mm_slot *mm_slot;
+	struct mm_slot *slot;
 	int needs_wakeup;
 
-	mm_slot = alloc_mm_slot();
+	mm_slot = mm_slot_alloc(mm_slot_cache);
 	if (!mm_slot)
 		return -ENOMEM;
 
+	slot = &mm_slot->slot;
+
 	/* Check ksm_run too?  Would need tighter locking */
-	needs_wakeup = list_empty(&ksm_mm_head.mm_node);
+	needs_wakeup = list_empty(&ksm_mm_head.slot.mm_node);
 
 	spin_lock(&ksm_mmlist_lock);
-	insert_to_mm_slots_hash(mm, mm_slot);
+	mm_slot_insert(mm_slots_hash, mm, slot);
 	/*
 	 * When KSM_RUN_MERGE (or KSM_RUN_STOP),
 	 * insert just behind the scanning cursor, to let the area settle
@@ -2538,9 +2516,9 @@ int __ksm_enter(struct mm_struct *mm)
 	 * missed: then we might as well insert at the end of the list.
 	 */
 	if (ksm_run & KSM_RUN_UNMERGE)
-		list_add_tail(&mm_slot->mm_node, &ksm_mm_head.mm_node);
+		list_add_tail(&slot->mm_node, &ksm_mm_head.slot.mm_node);
 	else
-		list_add_tail(&mm_slot->mm_node, &ksm_scan.mm_slot->mm_node);
+		list_add_tail(&slot->mm_node, &ksm_scan.mm_slot->slot.mm_node);
 	spin_unlock(&ksm_mmlist_lock);
 
 	set_bit(MMF_VM_MERGEABLE, &mm->flags);
@@ -2555,6 +2533,7 @@ int __ksm_enter(struct mm_struct *mm)
 void __ksm_exit(struct mm_struct *mm)
 {
 	struct ksm_mm_slot *mm_slot;
+	struct mm_slot *slot;
 	int easy_to_free = 0;
 
 	/*
@@ -2567,21 +2546,22 @@ void __ksm_exit(struct mm_struct *mm)
 	 */
 
 	spin_lock(&ksm_mmlist_lock);
-	mm_slot = get_mm_slot(mm);
+	slot = mm_slot_lookup(mm_slots_hash, mm);
+	mm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
 	if (mm_slot && ksm_scan.mm_slot != mm_slot) {
 		if (!mm_slot->rmap_list) {
-			hash_del(&mm_slot->hash);
-			list_del(&mm_slot->mm_node);
+			hash_del(&slot->hash);
+			list_del(&slot->mm_node);
 			easy_to_free = 1;
 		} else {
-			list_move(&mm_slot->mm_node,
-				  &ksm_scan.mm_slot->mm_node);
+			list_move(&slot->mm_node,
+				  &ksm_scan.mm_slot->slot.mm_node);
 		}
 	}
 	spin_unlock(&ksm_mmlist_lock);
 
 	if (easy_to_free) {
-		free_mm_slot(mm_slot);
+		mm_slot_free(mm_slot_cache, mm_slot);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
 		mmdrop(mm);
 	} else if (mm_slot) {
-- 
2.20.1

