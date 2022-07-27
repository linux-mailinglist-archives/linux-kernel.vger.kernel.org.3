Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8855820C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiG0HLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiG0HKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:10:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B333C959E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658905846; x=1690441846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=69y2qTj7SDB6fNmDi4fGWqVS2niql+kdyFzN631S5jw=;
  b=l+01Y9kbpyALxanCK6mpUa0UV6plGHa002KRrInBP0xI/WEmNSsgn6v4
   pvcobjhxY28S7P/78ArCSSOglWXyttmBLfuXfd60QXpQvwQ3qOLnsF/fw
   O2ixOr0BhKX0FET1N3LA/VpvZW1iI+N+syV4MtYiWjU59EOfo+zbIopKA
   JRxRCRsXg8t0eF2Hwbc8PTzruEdhg5mLhI92jf0tJX2kPNNDBMdbyb1Qw
   7IjnSkdOdgZOqUCu+t2s05X8R8DfF4CetiINWo6OAjAdNPvcS9DVRj8Jj
   iLcv6kuqBIs0g78rKcqYFd0mobPx9o0OeHqRzXxTNwJx5ojddoURu5hJp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="267931714"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="267931714"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 00:10:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="550737930"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
  by orsmga003.jf.intel.com with ESMTP; 27 Jul 2022 00:10:42 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 2/3] mm/slub: only zero the requested size of buffer for kzalloc
Date:   Wed, 27 Jul 2022 15:10:41 +0800
Message-Id: <20220727071042.8796-3-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220727071042.8796-1-feng.tang@intel.com>
References: <20220727071042.8796-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc/kmalloc will round up the request size to a fixed size
(mostly power of 2), so the allocated memory could be more than
requested. Currently kzalloc family APIs will zero all the
allocated memory.

To detect out-of-bound usage of the extra allocated memory, only
zero the requested part, so that sanity check could be added to
the extra space later.

For kzalloc users who will call ksize() later and utilize this
extra space, please be aware that the space is not zeroed any
more.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slab.c | 8 ++++----
 mm/slab.h | 9 +++++++--
 mm/slub.c | 6 +++---
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 5e73e2d80222..771f7c57d3ef 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3236,7 +3236,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
 	init = slab_want_init_on_alloc(flags, cachep);
 
 out_hooks:
-	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init);
+	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init, 0);
 	return ptr;
 }
 
@@ -3299,7 +3299,7 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
 	init = slab_want_init_on_alloc(flags, cachep);
 
 out:
-	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
+	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init, 0);
 	return objp;
 }
 
@@ -3546,13 +3546,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	 * Done outside of the IRQ disabled section.
 	 */
 	slab_post_alloc_hook(s, objcg, flags, size, p,
-				slab_want_init_on_alloc(flags, s));
+				slab_want_init_on_alloc(flags, s), 0);
 	/* FIXME: Trace call missing. Christoph would like a bulk variant */
 	return size;
 error:
 	local_irq_enable();
 	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
-	slab_post_alloc_hook(s, objcg, flags, i, p, false);
+	slab_post_alloc_hook(s, objcg, flags, i, p, false, 0);
 	kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
diff --git a/mm/slab.h b/mm/slab.h
index 4ec82bec15ec..7b53868efe6d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -710,12 +710,17 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 
 static inline void slab_post_alloc_hook(struct kmem_cache *s,
 					struct obj_cgroup *objcg, gfp_t flags,
-					size_t size, void **p, bool init)
+					size_t size, void **p, bool init,
+					unsigned int orig_size)
 {
 	size_t i;
 
 	flags &= gfp_allowed_mask;
 
+	/* If original request size(kmalloc) is not set, use object_size */
+	if (!orig_size)
+		orig_size = s->object_size;
+
 	/*
 	 * As memory initialization might be integrated into KASAN,
 	 * kasan_slab_alloc and initialization memset must be
@@ -726,7 +731,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 	for (i = 0; i < size; i++) {
 		p[i] = kasan_slab_alloc(s, p[i], flags, init);
 		if (p[i] && init && !kasan_has_integrated_init())
-			memset(p[i], 0, s->object_size);
+			memset(p[i], 0, orig_size);
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, flags);
 	}
diff --git a/mm/slub.c b/mm/slub.c
index 2e046cc10b84..946919066a4b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3285,7 +3285,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 	init = slab_want_init_on_alloc(gfpflags, s);
 
 out:
-	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
+	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
 
 	return object;
 }
@@ -3778,11 +3778,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	 * Done outside of the IRQ disabled fastpath loop.
 	 */
 	slab_post_alloc_hook(s, objcg, flags, size, p,
-				slab_want_init_on_alloc(flags, s));
+				slab_want_init_on_alloc(flags, s), 0);
 	return i;
 error:
 	slub_put_cpu_ptr(s->cpu_slab);
-	slab_post_alloc_hook(s, objcg, flags, i, p, false);
+	slab_post_alloc_hook(s, objcg, flags, i, p, false, 0);
 	kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
-- 
2.27.0

