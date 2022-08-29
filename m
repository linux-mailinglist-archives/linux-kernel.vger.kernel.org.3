Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36B25A4F55
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiH2Ocw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiH2Och (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:32:37 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15A0910A3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:32:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r22so7860268pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lt2/YaYHr5rJLJwkCdxmg5YZwJpd4IJKxnznGjt9X+s=;
        b=e6vOxUS/RpQwzggNCMqkXgUPX7xM3Cr23a7zIf71Z2LqrKHmiDB4Ml2jFxfJ/QwQTa
         fCaAGAjz+MmpKNb9tZtr8H9ZfVe//3A5MzTHuNmrohJNrqLqoCkeATD9JTaoHHcWIoci
         8anxnnPdekUOEPI0yn7g+EfYPfokdoQSGRBTy4i3UyI1uGiWDTcxzOEFumvUqBRNPUfS
         ZwQQXi/1tQCXXq7xl/zt7tEgeFqvyfvKupHYkqphEPU5wPAGsmpHHbEECtBQ2UhuilfS
         WAFSMlb8+T2vb0xBwS+rYx0WGyO1+ez3xsPEvaBSwCVxFlhatyJT66P9mCAOzlLhxjct
         1LfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lt2/YaYHr5rJLJwkCdxmg5YZwJpd4IJKxnznGjt9X+s=;
        b=wAYBse92UXiPtShxZROE4uk4WlvHbpEDBhBhZXDdj8uBplMom2/GgUIGAibTtwrp8n
         AssoDCxv+Tlrkjx1zGGsUltTLMfmPV3Wylt0Z7d6VB5cWaVDnLVo6DottMz9vZwZtmLp
         ili9Lb5uVivBaa/Y3Bm1hhsNKN8F2NzzqN3n74/mMZHBYveiPpW3t/y1Bk6Bb2BMBkUg
         siLlsUSRJhqkwrCHigv+5KMK2PPv2KN9EsiV+5ZuSdE+nU4rKOhn9bUK+JRRP/yuZRIq
         skEflZzxBMfKzMC1X3xahB9kmz3RbvsYJQ5766H3EzwF5sOx6WTRKFF6RbuKprOHCtzS
         F4mg==
X-Gm-Message-State: ACgBeo2dbEOn8zIkQtNyZWcqfPI5zSbJ+piJorp4SkDvLSVimue2bJim
        UmhXlfUeRDf9aeaiw3cG+cUSKA==
X-Google-Smtp-Source: AA6agR7RqHe7DN8gb3qgsh4Om1h1FkyRfxcxU55y7ea6ZRIgi7mIHWH7G1slbZhlf7/uDAMh6TUibQ==
X-Received: by 2002:a05:6a02:4b:b0:42b:d98a:d85b with SMTP id az11-20020a056a02004b00b0042bd98ad85bmr6770751pgb.556.1661783550426;
        Mon, 29 Aug 2022 07:32:30 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id x128-20020a626386000000b0052d200c8040sm7259327pfb.211.2022.08.29.07.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 07:32:29 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        hannes@cmpxchg.org, minchan@kernel.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 5/7] ksm: convert ksm_mm_slot.mm_list to ksm_mm_slot.mm_node
Date:   Mon, 29 Aug 2022 22:30:53 +0800
Message-Id: <20220829143055.41201-6-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220829143055.41201-1-zhengqi.arch@bytedance.com>
References: <20220829143055.41201-1-zhengqi.arch@bytedance.com>
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

In order to use common struct mm_slot, convert ksm_mm_slot.mm_list
to ksm_mm_slot.mm_node in advance, no functional change.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/ksm.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3937111f9ab8..8c52aa7e0a02 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -114,13 +114,13 @@
 /**
  * struct ksm_mm_slot - ksm information per mm that is being scanned
  * @link: link to the mm_slots hash list
- * @mm_list: link into the mm_slots list, rooted in ksm_mm_head
+ * @mm_node: link into the mm_slots list, rooted in ksm_mm_head
  * @rmap_list: head for this mm_slot's singly-linked list of rmap_items
  * @mm: the mm that this information is valid for
  */
 struct ksm_mm_slot {
 	struct hlist_node link;
-	struct list_head mm_list;
+	struct list_head mm_node;
 	struct ksm_rmap_item *rmap_list;
 	struct mm_struct *mm;
 };
@@ -231,7 +231,7 @@ static LIST_HEAD(migrate_nodes);
 static DEFINE_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 
 static struct ksm_mm_slot ksm_mm_head = {
-	.mm_list = LIST_HEAD_INIT(ksm_mm_head.mm_list),
+	.mm_node = LIST_HEAD_INIT(ksm_mm_head.mm_node),
 };
 static struct ksm_scan ksm_scan = {
 	.mm_slot = &ksm_mm_head,
@@ -980,8 +980,8 @@ static int unmerge_and_remove_all_rmap_items(void)
 	int err = 0;
 
 	spin_lock(&ksm_mmlist_lock);
-	ksm_scan.mm_slot = list_entry(ksm_mm_head.mm_list.next,
-						struct ksm_mm_slot, mm_list);
+	ksm_scan.mm_slot = list_entry(ksm_mm_head.mm_node.next,
+						struct ksm_mm_slot, mm_node);
 	spin_unlock(&ksm_mmlist_lock);
 
 	for (mm_slot = ksm_scan.mm_slot; mm_slot != &ksm_mm_head;
@@ -1005,11 +1005,11 @@ static int unmerge_and_remove_all_rmap_items(void)
 		mmap_read_unlock(mm);
 
 		spin_lock(&ksm_mmlist_lock);
-		ksm_scan.mm_slot = list_entry(mm_slot->mm_list.next,
-						struct ksm_mm_slot, mm_list);
+		ksm_scan.mm_slot = list_entry(mm_slot->mm_node.next,
+						struct ksm_mm_slot, mm_node);
 		if (ksm_test_exit(mm)) {
 			hash_del(&mm_slot->link);
-			list_del(&mm_slot->mm_list);
+			list_del(&mm_slot->mm_node);
 			spin_unlock(&ksm_mmlist_lock);
 
 			free_mm_slot(mm_slot);
@@ -2250,7 +2250,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 	struct vma_iterator vmi;
 	int nid;
 
-	if (list_empty(&ksm_mm_head.mm_list))
+	if (list_empty(&ksm_mm_head.mm_node))
 		return NULL;
 
 	slot = ksm_scan.mm_slot;
@@ -2291,7 +2291,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			root_unstable_tree[nid] = RB_ROOT;
 
 		spin_lock(&ksm_mmlist_lock);
-		slot = list_entry(slot->mm_list.next, struct ksm_mm_slot, mm_list);
+		slot = list_entry(slot->mm_node.next, struct ksm_mm_slot, mm_node);
 		ksm_scan.mm_slot = slot;
 		spin_unlock(&ksm_mmlist_lock);
 		/*
@@ -2364,8 +2364,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 	remove_trailing_rmap_items(ksm_scan.rmap_list);
 
 	spin_lock(&ksm_mmlist_lock);
-	ksm_scan.mm_slot = list_entry(slot->mm_list.next,
-						struct ksm_mm_slot, mm_list);
+	ksm_scan.mm_slot = list_entry(slot->mm_node.next,
+						struct ksm_mm_slot, mm_node);
 	if (ksm_scan.address == 0) {
 		/*
 		 * We've completed a full scan of all vmas, holding mmap_lock
@@ -2377,7 +2377,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		 * mmap_lock then protects against race with MADV_MERGEABLE).
 		 */
 		hash_del(&slot->link);
-		list_del(&slot->mm_list);
+		list_del(&slot->mm_node);
 		spin_unlock(&ksm_mmlist_lock);
 
 		free_mm_slot(slot);
@@ -2426,7 +2426,7 @@ static void ksm_do_scan(unsigned int scan_npages)
 
 static int ksmd_should_run(void)
 {
-	return (ksm_run & KSM_RUN_MERGE) && !list_empty(&ksm_mm_head.mm_list);
+	return (ksm_run & KSM_RUN_MERGE) && !list_empty(&ksm_mm_head.mm_node);
 }
 
 static int ksm_scan_thread(void *nothing)
@@ -2523,7 +2523,7 @@ int __ksm_enter(struct mm_struct *mm)
 		return -ENOMEM;
 
 	/* Check ksm_run too?  Would need tighter locking */
-	needs_wakeup = list_empty(&ksm_mm_head.mm_list);
+	needs_wakeup = list_empty(&ksm_mm_head.mm_node);
 
 	spin_lock(&ksm_mmlist_lock);
 	insert_to_mm_slots_hash(mm, mm_slot);
@@ -2538,9 +2538,9 @@ int __ksm_enter(struct mm_struct *mm)
 	 * missed: then we might as well insert at the end of the list.
 	 */
 	if (ksm_run & KSM_RUN_UNMERGE)
-		list_add_tail(&mm_slot->mm_list, &ksm_mm_head.mm_list);
+		list_add_tail(&mm_slot->mm_node, &ksm_mm_head.mm_node);
 	else
-		list_add_tail(&mm_slot->mm_list, &ksm_scan.mm_slot->mm_list);
+		list_add_tail(&mm_slot->mm_node, &ksm_scan.mm_slot->mm_node);
 	spin_unlock(&ksm_mmlist_lock);
 
 	set_bit(MMF_VM_MERGEABLE, &mm->flags);
@@ -2571,11 +2571,11 @@ void __ksm_exit(struct mm_struct *mm)
 	if (mm_slot && ksm_scan.mm_slot != mm_slot) {
 		if (!mm_slot->rmap_list) {
 			hash_del(&mm_slot->link);
-			list_del(&mm_slot->mm_list);
+			list_del(&mm_slot->mm_node);
 			easy_to_free = 1;
 		} else {
-			list_move(&mm_slot->mm_list,
-				  &ksm_scan.mm_slot->mm_list);
+			list_move(&mm_slot->mm_node,
+				  &ksm_scan.mm_slot->mm_node);
 		}
 	}
 	spin_unlock(&ksm_mmlist_lock);
-- 
2.20.1

