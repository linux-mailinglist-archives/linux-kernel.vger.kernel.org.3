Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AD353704C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiE2IPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 04:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiE2IPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 04:15:43 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4CF4B433
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 01:15:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VEe4qOA_1653812137;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VEe4qOA_1653812137)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 29 May 2022 16:15:38 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm/slub: improve consistency of nr_slabs count
Date:   Sun, 29 May 2022 16:15:34 +0800
Message-Id: <20220529081535.69275-2-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
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

Currently, discard_slab() can change nr_slabs count
without holding node's list_lock. This will lead some
error messages print when scanning node's partial or
full list, e.g. validate all slabs. Literally, it
affects the consistency of nr_slabs count.

Here, discard_slab() is abandoned, And dec_slabs_node()
is called before releasing node's list_lock.
dec_slabs_nodes() and free_slab() can be called separately
to ensure consistency of nr_slabs count.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 mm/slub.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 310e56d99116..bffb95bbb0ee 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2039,12 +2039,6 @@ static void free_slab(struct kmem_cache *s, struct slab *slab)
 		__free_slab(s, slab);
 }
 
-static void discard_slab(struct kmem_cache *s, struct slab *slab)
-{
-	dec_slabs_node(s, slab_nid(slab), slab->objects);
-	free_slab(s, slab);
-}
-
 /*
  * Management of partially allocated slabs.
  */
@@ -2413,6 +2407,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 
 	if (!new.inuse && n->nr_partial >= s->min_partial) {
 		mode = M_FREE;
+		spin_lock_irqsave(&n->list_lock, flags);
 	} else if (new.freelist) {
 		mode = M_PARTIAL;
 		/*
@@ -2437,7 +2432,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
 				"unfreezing slab")) {
-		if (mode == M_PARTIAL || mode == M_FULL)
+		if (mode != M_FULL_NOLIST)
 			spin_unlock_irqrestore(&n->list_lock, flags);
 		goto redo;
 	}
@@ -2449,7 +2444,10 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 		stat(s, tail);
 	} else if (mode == M_FREE) {
 		stat(s, DEACTIVATE_EMPTY);
-		discard_slab(s, slab);
+		dec_slabs_node(s, slab_nid(slab), slab->objects);
+		spin_unlock_irqrestore(&n->list_lock, flags);
+
+		free_slab(s, slab);
 		stat(s, FREE_SLAB);
 	} else if (mode == M_FULL) {
 		add_full(s, n, slab);
@@ -2502,6 +2500,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
 		if (unlikely(!new.inuse && n->nr_partial >= s->min_partial)) {
 			slab->next = slab_to_discard;
 			slab_to_discard = slab;
+			dec_slabs_node(s, slab_nid(slab), slab->objects);
 		} else {
 			add_partial(n, slab, DEACTIVATE_TO_TAIL);
 			stat(s, FREE_ADD_PARTIAL);
@@ -2516,7 +2515,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
 		slab_to_discard = slab_to_discard->next;
 
 		stat(s, DEACTIVATE_EMPTY);
-		discard_slab(s, slab);
+		free_slab(s, slab);
 		stat(s, FREE_SLAB);
 	}
 }
@@ -3404,9 +3403,10 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		remove_full(s, n, slab);
 	}
 
+	dec_slabs_node(s, slab_nid(slab), slab->objects);
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	stat(s, FREE_SLAB);
-	discard_slab(s, slab);
+	free_slab(s, slab);
 }
 
 /*
@@ -4265,6 +4265,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 		if (!slab->inuse) {
 			remove_partial(n, slab);
 			list_add(&slab->slab_list, &discard);
+			dec_slabs_node(s, slab_nid(slab), slab->objects);
 		} else {
 			list_slab_objects(s, slab,
 			  "Objects remaining in %s on __kmem_cache_shutdown()");
@@ -4273,7 +4274,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 	spin_unlock_irq(&n->list_lock);
 
 	list_for_each_entry_safe(slab, h, &discard, slab_list)
-		discard_slab(s, slab);
+		free_slab(s, slab);
 }
 
 bool __kmem_cache_empty(struct kmem_cache *s)
@@ -4595,6 +4596,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 			if (free == slab->objects) {
 				list_move(&slab->slab_list, &discard);
 				n->nr_partial--;
+				dec_slabs_node(s, slab_nid(slab), slab->objects);
 			} else if (free <= SHRINK_PROMOTE_MAX)
 				list_move(&slab->slab_list, promote + free - 1);
 		}
@@ -4610,7 +4612,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 
 		/* Release empty slabs */
 		list_for_each_entry_safe(slab, t, &discard, slab_list)
-			discard_slab(s, slab);
+			free_slab(s, slab);
 
 		if (slabs_node(s, node))
 			ret = 1;
-- 
2.27.0

