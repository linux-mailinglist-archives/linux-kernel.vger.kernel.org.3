Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9D152138E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbiEJLYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240911AbiEJLY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:24:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2232A9764;
        Tue, 10 May 2022 04:20:26 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KyFp51ccmz6H7gL;
        Tue, 10 May 2022 19:15:41 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 13:20:24 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 12:20:22 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 1/2] sbitmap: Make sbitmap.map a double pointer
Date:   Tue, 10 May 2022 19:14:33 +0800
Message-ID: <1652181274-136198-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1652181274-136198-1-git-send-email-john.garry@huawei.com>
References: <1652181274-136198-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently sbitmap.map points to a single array of sbitmap words.

To allow each word to be allocated individually, make it a double pointer.

This will mean that to access to a word will require an extra load.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/linux/sbitmap.h | 11 ++++++-----
 lib/sbitmap.c           | 34 ++++++++++++++++++++++++----------
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 8f5a86e210b9..46268f391e32 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -68,7 +68,7 @@ struct sbitmap {
 	/**
 	 * @map: Allocated bitmap.
 	 */
-	struct sbitmap_word *map;
+	struct sbitmap_word **map;
 
 	/*
 	 * @alloc_hint: Cache of last successfully allocated or freed bit.
@@ -256,9 +256,10 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
 		unsigned int depth = min_t(unsigned int,
 					   __map_depth(sb, index) - nr,
 					   sb->depth - scanned);
-
+		struct sbitmap_word *map = sb->map[index];
 		scanned += depth;
-		word = sb->map[index].word & ~sb->map[index].cleared;
+
+		word = map->word & ~map->cleared;
 		if (!word)
 			goto next;
 
@@ -299,7 +300,7 @@ static inline void sbitmap_for_each_set(struct sbitmap *sb, sb_for_each_fn fn,
 static inline unsigned long *__sbitmap_word(struct sbitmap *sb,
 					    unsigned int bitnr)
 {
-	return &sb->map[SB_NR_TO_INDEX(sb, bitnr)].word;
+	return &sb->map[SB_NR_TO_INDEX(sb, bitnr)]->word;
 }
 
 /* Helpers equivalent to the operations in asm/bitops.h and linux/bitmap.h */
@@ -322,7 +323,7 @@ static inline void sbitmap_clear_bit(struct sbitmap *sb, unsigned int bitnr)
  */
 static inline void sbitmap_deferred_clear_bit(struct sbitmap *sb, unsigned int bitnr)
 {
-	unsigned long *addr = &sb->map[SB_NR_TO_INDEX(sb, bitnr)].cleared;
+	unsigned long *addr = &sb->map[SB_NR_TO_INDEX(sb, bitnr)]->cleared;
 
 	set_bit(SB_NR_TO_BIT(sb, bitnr), addr);
 }
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index ae4fd4de9ebe..64fb9800ed8c 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -85,6 +85,8 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      bool alloc_hint)
 {
 	unsigned int bits_per_word;
+	struct sbitmap_word *map;
+	int index;
 
 	if (shift < 0)
 		shift = sbitmap_calculate_shift(depth);
@@ -116,6 +118,17 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		return -ENOMEM;
 	}
 
+	map = kvzalloc_node(sb->map_nr * sizeof(**sb->map), flags, node);
+	if (!map)
+		return -ENOMEM;
+
+	for (index = 0; index < sb->map_nr; index++, map++) {
+		struct sbitmap_word **_map;
+
+		_map = &sb->map[index];
+		*_map = map;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sbitmap_init_node);
@@ -126,7 +139,7 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 	unsigned int i;
 
 	for (i = 0; i < sb->map_nr; i++)
-		sbitmap_deferred_clear(&sb->map[i]);
+		sbitmap_deferred_clear(sb->map[i]);
 
 	sb->depth = depth;
 	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
@@ -170,7 +183,7 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
 				     unsigned int alloc_hint)
 {
-	struct sbitmap_word *map = &sb->map[index];
+	struct sbitmap_word *map = sb->map[index];
 	int nr;
 
 	do {
@@ -246,7 +259,7 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 
 	for (i = 0; i < sb->map_nr; i++) {
 again:
-		nr = __sbitmap_get_word(&sb->map[index].word,
+		nr = __sbitmap_get_word(&sb->map[index]->word,
 					min_t(unsigned int,
 					      __map_depth(sb, index),
 					      shallow_depth),
@@ -256,7 +269,7 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 			break;
 		}
 
-		if (sbitmap_deferred_clear(&sb->map[index]))
+		if (sbitmap_deferred_clear(sb->map[index]))
 			goto again;
 
 		/* Jump to next index. */
@@ -294,7 +307,7 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb)
 	unsigned int i;
 
 	for (i = 0; i < sb->map_nr; i++) {
-		if (sb->map[i].word & ~sb->map[i].cleared)
+		if (sb->map[i]->word & ~sb->map[i]->cleared)
 			return true;
 	}
 	return false;
@@ -306,7 +319,7 @@ static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
 	unsigned int i, weight = 0;
 
 	for (i = 0; i < sb->map_nr; i++) {
-		const struct sbitmap_word *word = &sb->map[i];
+		const struct sbitmap_word *word = sb->map[i];
 		unsigned int word_depth = __map_depth(sb, i);
 
 		if (set)
@@ -358,8 +371,9 @@ void sbitmap_bitmap_show(struct sbitmap *sb, struct seq_file *m)
 	int i;
 
 	for (i = 0; i < sb->map_nr; i++) {
-		unsigned long word = READ_ONCE(sb->map[i].word);
-		unsigned long cleared = READ_ONCE(sb->map[i].cleared);
+		struct sbitmap_word *map = READ_ONCE(sb->map[i]);
+		unsigned long word = READ_ONCE(map->word);
+		unsigned long cleared = READ_ONCE(map->cleared);
 		unsigned int word_bits = __map_depth(sb, i);
 
 		word &= ~cleared;
@@ -522,7 +536,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 	index = SB_NR_TO_INDEX(sb, hint);
 
 	for (i = 0; i < sb->map_nr; i++) {
-		struct sbitmap_word *map = &sb->map[index];
+		struct sbitmap_word *map = sb->map[index];
 		unsigned long get_mask;
 		unsigned int map_depth = __map_depth(sb, index);
 
@@ -665,7 +679,7 @@ void sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, int offset,
 		unsigned long *this_addr;
 
 		/* since we're clearing a batch, skip the deferred map */
-		this_addr = &sb->map[SB_NR_TO_INDEX(sb, tag)].word;
+		this_addr = &sb->map[SB_NR_TO_INDEX(sb, tag)]->word;
 		if (!addr) {
 			addr = this_addr;
 		} else if (addr != this_addr) {
-- 
2.26.2

