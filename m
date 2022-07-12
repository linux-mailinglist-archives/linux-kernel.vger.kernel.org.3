Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ACF571033
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiGLC2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiGLC2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:28:17 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6E87358C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:28:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VJ6Ep2C_1657592888;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VJ6Ep2C_1657592888)
          by smtp.aliyun-inc.com;
          Tue, 12 Jul 2022 10:28:10 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz, 42.hyeyoo@gmail.com,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@gentwo.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mm/slub: fix the race between validate_slab and slab_free
Date:   Tue, 12 Jul 2022 10:28:05 +0800
Message-Id: <20220712022807.44113-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In use cases where allocating and freeing slab frequently, some
error messages, such as "Left Redzone overwritten", "First byte
0xbb instead of 0xcc" would be printed when validating slabs.
That's because an object has been filled with SLAB_RED_INACTIVE,
but has not been added to slab's freelist. And between these
two states, the behaviour of validating slab is likely to occur.

Actually, it doesn't mean the slab can not work stably. But, these
confusing messages will disturb slab debugging more or less.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 mm/slub.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b1281b8654bd..e950d8df8380 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1391,18 +1391,16 @@ static noinline int free_debug_processing(
 	void *head, void *tail, int bulk_cnt,
 	unsigned long addr)
 {
-	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
 	void *object = head;
 	int cnt = 0;
-	unsigned long flags, flags2;
+	unsigned long flags;
 	int ret = 0;
 	depot_stack_handle_t handle = 0;
 
 	if (s->flags & SLAB_STORE_USER)
 		handle = set_track_prepare();
 
-	spin_lock_irqsave(&n->list_lock, flags);
-	slab_lock(slab, &flags2);
+	slab_lock(slab, &flags);
 
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!check_slab(s, slab))
@@ -1435,8 +1433,7 @@ static noinline int free_debug_processing(
 		slab_err(s, slab, "Bulk freelist count(%d) invalid(%d)\n",
 			 bulk_cnt, cnt);
 
-	slab_unlock(slab, &flags2);
-	spin_unlock_irqrestore(&n->list_lock, flags);
+	slab_unlock(slab, &flags);
 	if (!ret)
 		slab_fix(s, "Object at 0x%p not freed", object);
 	return ret;
@@ -3330,7 +3327,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 
 {
 	void *prior;
-	int was_frozen;
+	int was_frozen, to_take_off = 0;
 	struct slab new;
 	unsigned long counters;
 	struct kmem_cache_node *n = NULL;
@@ -3341,14 +3338,23 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	if (kfence_free(head))
 		return;
 
-	if (kmem_cache_debug(s) &&
-	    !free_debug_processing(s, slab, head, tail, cnt, addr))
-		return;
+	n = get_node(s, slab_nid(slab));
+	if (kmem_cache_debug(s)) {
+		int ret;
 
-	do {
-		if (unlikely(n)) {
+		spin_lock_irqsave(&n->list_lock, flags);
+		ret = free_debug_processing(s, slab, head, tail, cnt, addr);
+		if (!ret) {
 			spin_unlock_irqrestore(&n->list_lock, flags);
-			n = NULL;
+			return;
+		}
+	}
+
+	do {
+		if (unlikely(to_take_off)) {
+			if (!kmem_cache_debug(s))
+				spin_unlock_irqrestore(&n->list_lock, flags);
+			to_take_off = 0;
 		}
 		prior = slab->freelist;
 		counters = slab->counters;
@@ -3369,8 +3375,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 				new.frozen = 1;
 
 			} else { /* Needs to be taken off a list */
-
-				n = get_node(s, slab_nid(slab));
 				/*
 				 * Speculatively acquire the list_lock.
 				 * If the cmpxchg does not succeed then we may
@@ -3379,8 +3383,10 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 				 * Otherwise the list_lock will synchronize with
 				 * other processors updating the list of slabs.
 				 */
-				spin_lock_irqsave(&n->list_lock, flags);
+				if (!kmem_cache_debug(s))
+					spin_lock_irqsave(&n->list_lock, flags);
 
+				to_take_off = 1;
 			}
 		}
 
@@ -3389,8 +3395,9 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		head, new.counters,
 		"__slab_free"));
 
-	if (likely(!n)) {
-
+	if (likely(!to_take_off)) {
+		if (kmem_cache_debug(s))
+			spin_unlock_irqrestore(&n->list_lock, flags);
 		if (likely(was_frozen)) {
 			/*
 			 * The list lock was not taken therefore no list
-- 
2.27.0

