Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFC253704D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiE2IPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 04:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiE2IPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 04:15:43 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250814B42F
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 01:15:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VEe4qN3_1653812135;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VEe4qN3_1653812135)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 29 May 2022 16:15:37 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/slub: fix the race between validate_slab and slab_free
Date:   Sun, 29 May 2022 16:15:33 +0800
Message-Id: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
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
 mm/slub.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ed5c2c03a47a..310e56d99116 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1374,15 +1374,12 @@ static noinline int free_debug_processing(
 	void *head, void *tail, int bulk_cnt,
 	unsigned long addr)
 {
-	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
 	void *object = head;
 	int cnt = 0;
-	unsigned long flags, flags2;
+	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&n->list_lock, flags);
-	slab_lock(slab, &flags2);
-
+	slab_lock(slab, &flags);
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!check_slab(s, slab))
 			goto out;
@@ -1414,8 +1411,7 @@ static noinline int free_debug_processing(
 		slab_err(s, slab, "Bulk freelist count(%d) invalid(%d)\n",
 			 bulk_cnt, cnt);
 
-	slab_unlock(slab, &flags2);
-	spin_unlock_irqrestore(&n->list_lock, flags);
+	slab_unlock(slab, &flags);
 	if (!ret)
 		slab_fix(s, "Object at 0x%p not freed", object);
 	return ret;
@@ -3304,7 +3300,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 
 {
 	void *prior;
-	int was_frozen;
+	int was_frozen, to_take_off = 0;
 	struct slab new;
 	unsigned long counters;
 	struct kmem_cache_node *n = NULL;
@@ -3315,15 +3311,19 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	if (kfence_free(head))
 		return;
 
+	n = get_node(s, slab_nid(slab));
+	spin_lock_irqsave(&n->list_lock, flags);
+
 	if (kmem_cache_debug(s) &&
-	    !free_debug_processing(s, slab, head, tail, cnt, addr))
+	    !free_debug_processing(s, slab, head, tail, cnt, addr)) {
+
+		spin_unlock_irqrestore(&n->list_lock, flags);
 		return;
+	}
 
 	do {
-		if (unlikely(n)) {
-			spin_unlock_irqrestore(&n->list_lock, flags);
-			n = NULL;
-		}
+		if (unlikely(to_take_off))
+			to_take_off = 0;
 		prior = slab->freelist;
 		counters = slab->counters;
 		set_freepointer(s, tail, prior);
@@ -3343,18 +3343,11 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 				new.frozen = 1;
 
 			} else { /* Needs to be taken off a list */
-
-				n = get_node(s, slab_nid(slab));
 				/*
-				 * Speculatively acquire the list_lock.
 				 * If the cmpxchg does not succeed then we may
-				 * drop the list_lock without any processing.
-				 *
-				 * Otherwise the list_lock will synchronize with
-				 * other processors updating the list of slabs.
+				 * drop this behavior without any processing.
 				 */
-				spin_lock_irqsave(&n->list_lock, flags);
-
+				to_take_off = 1;
 			}
 		}
 
@@ -3363,8 +3356,9 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		head, new.counters,
 		"__slab_free"));
 
-	if (likely(!n)) {
+	if (likely(!to_take_off)) {
 
+		spin_unlock_irqrestore(&n->list_lock, flags);
 		if (likely(was_frozen)) {
 			/*
 			 * The list lock was not taken therefore no list
-- 
2.27.0

