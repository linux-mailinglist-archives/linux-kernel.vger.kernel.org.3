Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C7C5A7464
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiHaDVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiHaDUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:20:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7262F2FFF6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h11-20020a17090a470b00b001fbc5ba5224so13764731pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=f6rQgw8USChv8oA+nAwqR6F2V5pWKOCQTtX51ximUyU=;
        b=Jt71XTo0ZlGofe5ovfd68QMBd8ExztA/4UOo5WwvaEOU3Xtd6o0Wqm3KZVUreaULEG
         9koGq03fI74L6+20WWygZRZW2FdIiFGHzLKDTfoQt/4jVIN8F+2kwbg/b7ABHu1ZkBJ7
         b94igBpmmBWhETJ+R/F3xWei+whbuH8YRwJIpk/CMKNmo9vAsWOtrT4ZBTw/KfUbvN2l
         /b+zrOJhHtUInoou0qtMurMleEg7e820kLYYpxjQ7ThCOPxtzzIZ384SPOKM/Lk9mU9l
         BFy6wOTGf1RrSkFizHBKQwPdQZG5ZpInfgx2QuhlYrkWYVExcT0DbZUNjZXXr8oTUVsb
         fTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=f6rQgw8USChv8oA+nAwqR6F2V5pWKOCQTtX51ximUyU=;
        b=hUklynubwq21VkzPGPWfYQxHnuVvGqF4TeEKzqviLKEHtBN8/X9g4u1Kcxr6baUgKr
         jV1CFCRJ3F/EV4ItnUthj92790fSKmPIqkpD2MJwwpqpINS5gkRGa0jKFwKAA6O9nzq4
         XBYPYSMlZq1fM8Lu9y6xxIwDasbrlHfo/o3u531jL7UhzXnzBF5K1lA1ZuxohS0aOFVi
         Zmfe0spHNrBMndtg9GQJ0+Ft87PBroPS/ss1yU6LlTl5+KOOBG1Og44GQlolglCQo7zh
         PhfeFHTyh8+SV34e4z/nKnrlZfk6geBsTMWCkoAjL8/yf/VhQmWmwgzhfvJQjJPzrO9a
         p9BQ==
X-Gm-Message-State: ACgBeo02KlH89bjlEFBxd/vL7+uyKaiDpajML94Hzq2WI8LSy7piyrgX
        7ZQvs8fLX7yom3BgRqKn76CVCg==
X-Google-Smtp-Source: AA6agR5bHfmikkHIIhDlWRWZ0Q14KKxmcCqsG3gc8oih9F6xWSMI7e2q6hWo4RFi7gmkBImue6w5ZA==
X-Received: by 2002:a17:90b:38cf:b0:1fb:783c:e0f with SMTP id nn15-20020a17090b38cf00b001fb783c0e0fmr1193594pjb.204.1661916018725;
        Tue, 30 Aug 2022 20:20:18 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b0015e8d4eb1d5sm8633535pla.31.2022.08.30.20.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:20:18 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, vbabka@suse.cz, hannes@cmpxchg.org,
        minchan@kernel.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 2/7] mm: thp: convert to use common struct mm_slot
Date:   Wed, 31 Aug 2022 11:19:46 +0800
Message-Id: <20220831031951.43152-3-zhengqi.arch@bytedance.com>
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

Rename private struct mm_slot to struct khugepaged_mm_slot and
convert to use common struct mm_slot with no functional change.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/khugepaged.c | 121 ++++++++++++++++++++----------------------------
 1 file changed, 51 insertions(+), 70 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d8e388106322..2d74cf01f694 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -23,6 +23,7 @@
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
 #include "internal.h"
+#include "mm_slot.h"
 
 enum scan_result {
 	SCAN_FAIL,
@@ -104,17 +105,13 @@ struct collapse_control {
 };
 
 /**
- * struct mm_slot - hash lookup from mm to mm_slot
- * @hash: hash collision list
- * @mm_node: khugepaged scan list headed in khugepaged_scan.mm_head
- * @mm: the mm that this information is valid for
+ * struct khugepaged_mm_slot - khugepaged information per mm that is being scanned
+ * @slot: hash lookup from mm to mm_slot
  * @nr_pte_mapped_thp: number of pte mapped THP
  * @pte_mapped_thp: address array corresponding pte mapped THP
  */
-struct mm_slot {
-	struct hlist_node hash;
-	struct list_head mm_node;
-	struct mm_struct *mm;
+struct khugepaged_mm_slot {
+	struct mm_slot slot;
 
 	/* pte-mapped THP in this mm */
 	int nr_pte_mapped_thp;
@@ -131,7 +128,7 @@ struct mm_slot {
  */
 struct khugepaged_scan {
 	struct list_head mm_head;
-	struct mm_slot *mm_slot;
+	struct khugepaged_mm_slot *mm_slot;
 	unsigned long address;
 };
 
@@ -395,8 +392,9 @@ int hugepage_madvise(struct vm_area_struct *vma,
 int __init khugepaged_init(void)
 {
 	mm_slot_cache = kmem_cache_create("khugepaged_mm_slot",
-					  sizeof(struct mm_slot),
-					  __alignof__(struct mm_slot), 0, NULL);
+					  sizeof(struct khugepaged_mm_slot),
+					  __alignof__(struct khugepaged_mm_slot),
+					  0, NULL);
 	if (!mm_slot_cache)
 		return -ENOMEM;
 
@@ -413,36 +411,6 @@ void __init khugepaged_destroy(void)
 	kmem_cache_destroy(mm_slot_cache);
 }
 
-static inline struct mm_slot *alloc_mm_slot(void)
-{
-	if (!mm_slot_cache)	/* initialization failed */
-		return NULL;
-	return kmem_cache_zalloc(mm_slot_cache, GFP_KERNEL);
-}
-
-static inline void free_mm_slot(struct mm_slot *mm_slot)
-{
-	kmem_cache_free(mm_slot_cache, mm_slot);
-}
-
-static struct mm_slot *get_mm_slot(struct mm_struct *mm)
-{
-	struct mm_slot *mm_slot;
-
-	hash_for_each_possible(mm_slots_hash, mm_slot, hash, (unsigned long)mm)
-		if (mm == mm_slot->mm)
-			return mm_slot;
-
-	return NULL;
-}
-
-static void insert_to_mm_slots_hash(struct mm_struct *mm,
-				    struct mm_slot *mm_slot)
-{
-	mm_slot->mm = mm;
-	hash_add(mm_slots_hash, &mm_slot->hash, (long)mm);
-}
-
 static inline int hpage_collapse_test_exit(struct mm_struct *mm)
 {
 	return atomic_read(&mm->mm_users) == 0;
@@ -450,28 +418,31 @@ static inline int hpage_collapse_test_exit(struct mm_struct *mm)
 
 void __khugepaged_enter(struct mm_struct *mm)
 {
-	struct mm_slot *mm_slot;
+	struct khugepaged_mm_slot *mm_slot;
+	struct mm_slot *slot;
 	int wakeup;
 
-	mm_slot = alloc_mm_slot();
+	mm_slot = mm_slot_alloc(mm_slot_cache);
 	if (!mm_slot)
 		return;
 
+	slot = &mm_slot->slot;
+
 	/* __khugepaged_exit() must not run from under us */
 	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
 	if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags))) {
-		free_mm_slot(mm_slot);
+		mm_slot_free(mm_slot_cache, mm_slot);
 		return;
 	}
 
 	spin_lock(&khugepaged_mm_lock);
-	insert_to_mm_slots_hash(mm, mm_slot);
+	mm_slot_insert(mm_slots_hash, mm, slot);
 	/*
 	 * Insert just behind the scanning cursor, to let the area settle
 	 * down a little.
 	 */
 	wakeup = list_empty(&khugepaged_scan.mm_head);
-	list_add_tail(&mm_slot->mm_node, &khugepaged_scan.mm_head);
+	list_add_tail(&slot->mm_node, &khugepaged_scan.mm_head);
 	spin_unlock(&khugepaged_mm_lock);
 
 	mmgrab(mm);
@@ -491,21 +462,23 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 
 void __khugepaged_exit(struct mm_struct *mm)
 {
-	struct mm_slot *mm_slot;
+	struct khugepaged_mm_slot *mm_slot;
+	struct mm_slot *slot;
 	int free = 0;
 
 	spin_lock(&khugepaged_mm_lock);
-	mm_slot = get_mm_slot(mm);
+	slot = mm_slot_lookup(mm_slots_hash, mm);
+	mm_slot = mm_slot_entry(slot, struct khugepaged_mm_slot, slot);
 	if (mm_slot && khugepaged_scan.mm_slot != mm_slot) {
-		hash_del(&mm_slot->hash);
-		list_del(&mm_slot->mm_node);
+		hash_del(&slot->hash);
+		list_del(&slot->mm_node);
 		free = 1;
 	}
 	spin_unlock(&khugepaged_mm_lock);
 
 	if (free) {
 		clear_bit(MMF_VM_HUGEPAGE, &mm->flags);
-		free_mm_slot(mm_slot);
+		mm_slot_free(mm_slot_cache, mm_slot);
 		mmdrop(mm);
 	} else if (mm_slot) {
 		/*
@@ -1321,16 +1294,17 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	return result;
 }
 
-static void collect_mm_slot(struct mm_slot *mm_slot)
+static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
 {
-	struct mm_struct *mm = mm_slot->mm;
+	struct mm_slot *slot = &mm_slot->slot;
+	struct mm_struct *mm = slot->mm;
 
 	lockdep_assert_held(&khugepaged_mm_lock);
 
 	if (hpage_collapse_test_exit(mm)) {
 		/* free mm_slot */
-		hash_del(&mm_slot->hash);
-		list_del(&mm_slot->mm_node);
+		hash_del(&slot->hash);
+		list_del(&slot->mm_node);
 
 		/*
 		 * Not strictly needed because the mm exited already.
@@ -1339,7 +1313,7 @@ static void collect_mm_slot(struct mm_slot *mm_slot)
 		 */
 
 		/* khugepaged_mm_lock actually not necessary for the below */
-		free_mm_slot(mm_slot);
+		mm_slot_free(mm_slot_cache, mm_slot);
 		mmdrop(mm);
 	}
 }
@@ -1352,12 +1326,14 @@ static void collect_mm_slot(struct mm_slot *mm_slot)
 static void khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
 					  unsigned long addr)
 {
-	struct mm_slot *mm_slot;
+	struct khugepaged_mm_slot *mm_slot;
+	struct mm_slot *slot;
 
 	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
 
 	spin_lock(&khugepaged_mm_lock);
-	mm_slot = get_mm_slot(mm);
+	slot = mm_slot_lookup(mm_slots_hash, mm);
+	mm_slot = mm_slot_entry(slot, struct khugepaged_mm_slot, slot);
 	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP))
 		mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] = addr;
 	spin_unlock(&khugepaged_mm_lock);
@@ -1489,9 +1465,10 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	goto drop_hpage;
 }
 
-static void khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
+static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
 {
-	struct mm_struct *mm = mm_slot->mm;
+	struct mm_slot *slot = &mm_slot->slot;
+	struct mm_struct *mm = slot->mm;
 	int i;
 
 	if (likely(mm_slot->nr_pte_mapped_thp == 0))
@@ -2054,7 +2031,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 	__acquires(&khugepaged_mm_lock)
 {
 	struct vma_iterator vmi;
-	struct mm_slot *mm_slot;
+	struct khugepaged_mm_slot *mm_slot;
+	struct mm_slot *slot;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int progress = 0;
@@ -2064,18 +2042,20 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 	lockdep_assert_held(&khugepaged_mm_lock);
 	*result = SCAN_FAIL;
 
-	if (khugepaged_scan.mm_slot)
+	if (khugepaged_scan.mm_slot) {
 		mm_slot = khugepaged_scan.mm_slot;
-	else {
-		mm_slot = list_entry(khugepaged_scan.mm_head.next,
+		slot = &mm_slot->slot;
+	} else {
+		slot = list_entry(khugepaged_scan.mm_head.next,
 				     struct mm_slot, mm_node);
+		mm_slot = mm_slot_entry(slot, struct khugepaged_mm_slot, slot);
 		khugepaged_scan.address = 0;
 		khugepaged_scan.mm_slot = mm_slot;
 	}
 	spin_unlock(&khugepaged_mm_lock);
 	khugepaged_collapse_pte_mapped_thps(mm_slot);
 
-	mm = mm_slot->mm;
+	mm = slot->mm;
 	/*
 	 * Don't wait for semaphore (to avoid long wait times).  Just move to
 	 * the next mm on the list.
@@ -2171,10 +2151,11 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 		 * khugepaged runs here, khugepaged_exit will find
 		 * mm_slot not pointing to the exiting mm.
 		 */
-		if (mm_slot->mm_node.next != &khugepaged_scan.mm_head) {
-			khugepaged_scan.mm_slot = list_entry(
-				mm_slot->mm_node.next,
-				struct mm_slot, mm_node);
+		if (slot->mm_node.next != &khugepaged_scan.mm_head) {
+			slot = list_entry(slot->mm_node.next,
+					  struct mm_slot, mm_node);
+			khugepaged_scan.mm_slot =
+				mm_slot_entry(slot, struct khugepaged_mm_slot, slot);
 			khugepaged_scan.address = 0;
 		} else {
 			khugepaged_scan.mm_slot = NULL;
@@ -2269,7 +2250,7 @@ static void khugepaged_wait_work(void)
 
 static int khugepaged(void *none)
 {
-	struct mm_slot *mm_slot;
+	struct khugepaged_mm_slot *mm_slot;
 
 	set_freezable();
 	set_user_nice(current, MAX_NICE);
-- 
2.20.1

