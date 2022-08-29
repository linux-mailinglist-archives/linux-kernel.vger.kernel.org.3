Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2465A4F56
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiH2Oc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiH2Ocm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:32:42 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9929593238
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:32:36 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 145so7996637pfw.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Al2MAS+95n2CdX2+DzZ9586scn02KUFSxAEU+wkQoAw=;
        b=zJ+WkTEw5T7kLlCpDfJxak9jUJkFXoBvWK5j5/jlQYN6uH1WdcOhN1Nlqg1qKCKxmH
         SfRyRZqZxAGobuXACaRF9H0k4t/ySb17PxBsX/Swi0QfDAO4C6okRPNJJK8qPQ7VXadJ
         Y1inRNK0oRY17BKmLqg/pjPfvfpl5z3LigO7GtNEr5m/hvjk8dZIXKM5JmpViFFisNSA
         cLHUt9Lr1HEbyT4HjWE+zQGzs1EPoPb5ML0HLbyJHDhccKs5mpHzF9BBHLTWHPK0Kn7R
         Dz+D7F4vpMyVXjhuh8QXl28r9WyHjLHb9yjR39oeY1rwWAL5zQmat4MnqH4nfO1/fzJ5
         ZB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Al2MAS+95n2CdX2+DzZ9586scn02KUFSxAEU+wkQoAw=;
        b=OGndhH1poT7Xua0Z426YNiweekfLse7bxGxDJZr0Ju7ls1YCbZKE7+ZV6NpgxdvB55
         G+sWV9UDhxcF2rhNgMvBjkNLAuHHYAnS/b0d5u3k1O44/Fv+Kr4gEiAnGLlJ9XB9RFbY
         +JiGKwqmapSYxMtFJBrT6SyB0fJF2e4hxPC/7xCd88HLJF9QxK9pHEcPo5u4WhYD5ETL
         JqDMQ+FrTaDfN7ey1vqOmtLMkaSnepWxWLRYWeax8muAbNQLFYsHucGOLMVxFWkDDBMG
         ajguhvwYj6znSKqZwj/Lt3Ml/17OsUE/3jY2WSeTqZgKEp8CpAzL7j2U1YzLTeQt48jg
         +z4Q==
X-Gm-Message-State: ACgBeo37REDZoYqvGniRX1ipEluKB4r38Rpvrhl079+jvkS9md/MblUN
        bMoQiGIqAv3JZ9qicDfcQLheiw==
X-Google-Smtp-Source: AA6agR6enaQIpg1cfNwmQIexnrDT7xtacCPJiHAYbrU9RstdIo3faPfkcAg08PEC4oyvK+Rk+S7uGA==
X-Received: by 2002:a62:1910:0:b0:537:d68e:3a27 with SMTP id 16-20020a621910000000b00537d68e3a27mr14488781pfz.71.1661783555500;
        Mon, 29 Aug 2022 07:32:35 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id x128-20020a626386000000b0052d200c8040sm7259327pfb.211.2022.08.29.07.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 07:32:35 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        hannes@cmpxchg.org, minchan@kernel.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 6/7] ksm: convert ksm_mm_slot.link to ksm_mm_slot.hash
Date:   Mon, 29 Aug 2022 22:30:54 +0800
Message-Id: <20220829143055.41201-7-zhengqi.arch@bytedance.com>
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

