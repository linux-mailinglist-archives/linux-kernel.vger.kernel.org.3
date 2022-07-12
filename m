Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A66571030
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiGLC2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiGLC2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:28:17 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05447E016
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:28:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VJ6Ep2a_1657592890;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VJ6Ep2a_1657592890)
          by smtp.aliyun-inc.com;
          Tue, 12 Jul 2022 10:28:11 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz, 42.hyeyoo@gmail.com,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@gentwo.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mm/slub: improve consistency of nr_slabs count
Date:   Tue, 12 Jul 2022 10:28:06 +0800
Message-Id: <20220712022807.44113-2-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220712022807.44113-1-rongwei.wang@linux.alibaba.com>
References: <20220712022807.44113-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
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
index e950d8df8380..587416e39292 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2065,12 +2065,6 @@ static void free_slab(struct kmem_cache *s, struct slab *slab)
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
@@ -2439,6 +2433,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 
 	if (!new.inuse && n->nr_partial >= s->min_partial) {
 		mode = M_FREE;
+		spin_lock_irqsave(&n->list_lock, flags);
 	} else if (new.freelist) {
 		mode = M_PARTIAL;
 		/*
@@ -2463,7 +2458,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
 				"unfreezing slab")) {
-		if (mode == M_PARTIAL || mode == M_FULL)
+		if (mode != M_FULL_NOLIST)
 			spin_unlock_irqrestore(&n->list_lock, flags);
 		goto redo;
 	}
@@ -2475,7 +2470,10 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
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
@@ -2528,6 +2526,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
 		if (unlikely(!new.inuse && n->nr_partial >= s->min_partial)) {
 			slab->next = slab_to_discard;
 			slab_to_discard = slab;
+			dec_slabs_node(s, slab_nid(slab), slab->objects);
 		} else {
 			add_partial(n, slab, DEACTIVATE_TO_TAIL);
 			stat(s, FREE_ADD_PARTIAL);
@@ -2542,7 +2541,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
 		slab_to_discard = slab_to_discard->next;
 
 		stat(s, DEACTIVATE_EMPTY);
-		discard_slab(s, slab);
+		free_slab(s, slab);
 		stat(s, FREE_SLAB);
 	}
 }
@@ -3443,9 +3442,10 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		remove_full(s, n, slab);
 	}
 
+	dec_slabs_node(s, slab_nid(slab), slab->objects);
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	stat(s, FREE_SLAB);
-	discard_slab(s, slab);
+	free_slab(s, slab);
 }
 
 /*
@@ -4302,6 +4302,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 		if (!slab->inuse) {
 			remove_partial(n, slab);
 			list_add(&slab->slab_list, &discard);
+			dec_slabs_node(s, slab_nid(slab), slab->objects);
 		} else {
 			list_slab_objects(s, slab,
 			  "Objects remaining in %s on __kmem_cache_shutdown()");
@@ -4310,7 +4311,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 	spin_unlock_irq(&n->list_lock);
 
 	list_for_each_entry_safe(slab, h, &discard, slab_list)
-		discard_slab(s, slab);
+		free_slab(s, slab);
 }
 
 bool __kmem_cache_empty(struct kmem_cache *s)
@@ -4640,6 +4641,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 			if (free == slab->objects) {
 				list_move(&slab->slab_list, &discard);
 				n->nr_partial--;
+				dec_slabs_node(s, slab_nid(slab), slab->objects);
 			} else if (free <= SHRINK_PROMOTE_MAX)
 				list_move(&slab->slab_list, promote + free - 1);
 		}
@@ -4655,7 +4657,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 
 		/* Release empty slabs */
 		list_for_each_entry_safe(slab, t, &discard, slab_list)
-			discard_slab(s, slab);
+			free_slab(s, slab);
 
 		if (slabs_node(s, node))
 			ret = 1;
-- 
2.27.0

