Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09385A7465
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiHaDVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiHaDUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:20:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D41E6746B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 145so12854862pfw.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Al2MAS+95n2CdX2+DzZ9586scn02KUFSxAEU+wkQoAw=;
        b=qJOddgBlJ6QYyyCedtrzab/fiepTxwXPZUhHtVCwS12VTaTT2yX+tNuPdYbeQmsqeh
         gw9zRMj5RXYKc9GEb4169ocwRzD/4oUrZhYjmbmTFB82XEmRLmrkBhLTtoTXAyC7lAzg
         yW6Y0fS9iTsdGdRgVBinWppWyPiq2TgP1O4iwdf3OebRHvSD1br7lIl/5NiYzKFGqfih
         GqhLkTPpGQTfogbYCVnYaN6P1YjWP1wHKb0mlleAbFlm0M5c8jIZ0FnokMggWMi3N6BZ
         0t/+cmMwT22FRNiy9Tr6HB81hwBSHa63aUYbE5dXUBcesSQ5KPvH4qDL/rb4VAM4C4Ws
         ER9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Al2MAS+95n2CdX2+DzZ9586scn02KUFSxAEU+wkQoAw=;
        b=eUuTx2mAZjk5re9STpAAXgIqLxcA81HzqPaPiEz+0e2HBZitrm0a+XACMDeugP93JB
         2aOHaTDwdG2KChy+QkVyNflvmeQYMVEfHuvd5mvLV9aW+AL/uHS4zySFtCFBJ6XID0Lu
         a6ru7kQKymMnt1yeYiebqPuYM3h0pDW6WDequnZ2tywmHqRIJfCh6k6mgu2ETJ1DGZg4
         WdyuGfGean9eYZeoOd8F1TTsvo9PxVKb+dm2A2L923mDSNnr5LUh+MXyaBcPUSvqriqL
         J4v2aO6hfa+g/+c8o5OuMvi28W7fQqCZVdnPvb0qpF00RhtliJMdV1DRI6dns6KqWE5h
         P9ww==
X-Gm-Message-State: ACgBeo0jrDvqaB9NpQEE2V6gNTwx9a1HTlr+z4X1eOv/Rcg/n+GRK8tM
        t6dXtiEhEIyKhoVXfvhJ9WjA7Q==
X-Google-Smtp-Source: AA6agR5hQijp1ihYFHuxOS7SKbB6brdOYfWD5KVgxzapCa+48fl3/7b3bZVzq1jr8Gkh0eEBAfDOyA==
X-Received: by 2002:a65:5847:0:b0:42a:df5:1035 with SMTP id s7-20020a655847000000b0042a0df51035mr20339602pgr.248.1661916036655;
        Tue, 30 Aug 2022 20:20:36 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b0015e8d4eb1d5sm8633535pla.31.2022.08.30.20.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:20:36 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, vbabka@suse.cz, hannes@cmpxchg.org,
        minchan@kernel.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 6/7] ksm: convert ksm_mm_slot.link to ksm_mm_slot.hash
Date:   Wed, 31 Aug 2022 11:19:50 +0800
Message-Id: <20220831031951.43152-7-zhengqi.arch@bytedance.com>
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

In order to use common struct mm_slot, convert ksm_mm_slot.link
to ksm_mm_slot.hash in advance, no functional change.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/ksm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 8c52aa7e0a02..667efca75b0d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -113,13 +113,13 @@
 
 /**
  * struct ksm_mm_slot - ksm information per mm that is being scanned
- * @link: link to the mm_slots hash list
+ * @hash: link to the mm_slots hash list
  * @mm_node: link into the mm_slots list, rooted in ksm_mm_head
  * @rmap_list: head for this mm_slot's singly-linked list of rmap_items
  * @mm: the mm that this information is valid for
  */
 struct ksm_mm_slot {
-	struct hlist_node link;
+	struct hlist_node hash;
 	struct list_head mm_node;
 	struct ksm_rmap_item *rmap_list;
 	struct mm_struct *mm;
@@ -424,7 +424,7 @@ static struct ksm_mm_slot *get_mm_slot(struct mm_struct *mm)
 {
 	struct ksm_mm_slot *slot;
 
-	hash_for_each_possible(mm_slots_hash, slot, link, (unsigned long)mm)
+	hash_for_each_possible(mm_slots_hash, slot, hash, (unsigned long)mm)
 		if (slot->mm == mm)
 			return slot;
 
@@ -435,7 +435,7 @@ static void insert_to_mm_slots_hash(struct mm_struct *mm,
 				    struct ksm_mm_slot *mm_slot)
 {
 	mm_slot->mm = mm;
-	hash_add(mm_slots_hash, &mm_slot->link, (unsigned long)mm);
+	hash_add(mm_slots_hash, &mm_slot->hash, (unsigned long)mm);
 }
 
 /*
@@ -1008,7 +1008,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 		ksm_scan.mm_slot = list_entry(mm_slot->mm_node.next,
 						struct ksm_mm_slot, mm_node);
 		if (ksm_test_exit(mm)) {
-			hash_del(&mm_slot->link);
+			hash_del(&mm_slot->hash);
 			list_del(&mm_slot->mm_node);
 			spin_unlock(&ksm_mmlist_lock);
 
@@ -2376,7 +2376,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		 * or when all VM_MERGEABLE areas have been unmapped (and
 		 * mmap_lock then protects against race with MADV_MERGEABLE).
 		 */
-		hash_del(&slot->link);
+		hash_del(&slot->hash);
 		list_del(&slot->mm_node);
 		spin_unlock(&ksm_mmlist_lock);
 
@@ -2570,7 +2570,7 @@ void __ksm_exit(struct mm_struct *mm)
 	mm_slot = get_mm_slot(mm);
 	if (mm_slot && ksm_scan.mm_slot != mm_slot) {
 		if (!mm_slot->rmap_list) {
-			hash_del(&mm_slot->link);
+			hash_del(&mm_slot->hash);
 			list_del(&mm_slot->mm_node);
 			easy_to_free = 1;
 		} else {
-- 
2.20.1

