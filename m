Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213EC5820C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiG0HLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiG0HKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:10:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F943CBF1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658905850; x=1690441850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U2DUaLw+/DEgR8kITGEVz4V5R9QpdataO3f86cOl0eM=;
  b=D0OKeBL8OuUQCR9V1lE1u9lPs/5+BTKQRbGnfoEurmpnS0dXfraUWNDs
   edUJuBQ880158gaFH5wmfQygdKfN9lt+3nYWz9ymRQ6niZ+8kXUPEYN34
   PrK0SGaNKeOXZsi4JtlsSfFuIZXekgDK4fNz73NUh45oby5OBaDtfu7WX
   Gk03JsWjxzjzSg84WNYlR/vFgznlnKsasNKx2sgkwwV4HrzDNlI68daf2
   zMaDagpwVClQa3ARzyKhVy6wFi0mftmw25UG5JwHhV9ZS/6QOQZCQFkqi
   mLm48tFrebWxLIMTGGRc6qpfy0kzb+a/AprwP0BYlzzw3M/sI2i19enVd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="267931733"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="267931733"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 00:10:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="550737956"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
  by orsmga003.jf.intel.com with ESMTP; 27 Jul 2022 00:10:46 -0700
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
Subject: [PATCH v3 3/3] mm/slub: extend redzone check to cover extra allocated kmalloc space than requested
Date:   Wed, 27 Jul 2022 15:10:42 +0800
Message-Id: <20220727071042.8796-4-feng.tang@intel.com>
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

kmalloc will round up the request size to a fixed size (mostly power
of 2), so there could be a extra space than what is requested, whose
size is the actual buffer size minus original request size.

To better detect out of bound access or abuse of this space, add
redzone sanity check for it.

And in current kernel, some kmalloc user already knows the existence
of the space and utilizes it after calling 'ksize()' to know the real
size of the allocated buffer. So we skip the sanity check for objects
which have been called with ksize(), as treating them as legitimate
users.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slub.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 946919066a4b..added2653bb0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -836,6 +836,11 @@ static inline void set_orig_size(struct kmem_cache *s,
 	*(unsigned int *)p = orig_size;
 }
 
+static inline void skip_orig_size_check(struct kmem_cache *s, const void *object)
+{
+	set_orig_size(s, (void *)object, s->object_size);
+}
+
 static unsigned int get_orig_size(struct kmem_cache *s, void *object)
 {
 	void *p = kasan_reset_tag(object);
@@ -967,13 +972,35 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
 static void init_object(struct kmem_cache *s, void *object, u8 val)
 {
 	u8 *p = kasan_reset_tag(object);
+	unsigned int orig_size = s->object_size;
 
-	if (s->flags & SLAB_RED_ZONE)
+	if (s->flags & SLAB_RED_ZONE) {
 		memset(p - s->red_left_pad, val, s->red_left_pad);
 
+		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
+			unsigned int zone_start;
+
+			orig_size = get_orig_size(s, object);
+			zone_start = orig_size;
+
+			if (!freeptr_outside_object(s))
+				zone_start = max_t(unsigned int, orig_size,
+						s->offset + sizeof(void *));
+
+			/*
+			 * Redzone the extra allocated space by kmalloc
+			 * than requested.
+			 */
+			if (zone_start < s->object_size)
+				memset(p + zone_start, val,
+					s->object_size - zone_start);
+		}
+
+	}
+
 	if (s->flags & __OBJECT_POISON) {
-		memset(p, POISON_FREE, s->object_size - 1);
-		p[s->object_size - 1] = POISON_END;
+		memset(p, POISON_FREE, orig_size - 1);
+		p[orig_size - 1] = POISON_END;
 	}
 
 	if (s->flags & SLAB_RED_ZONE)
@@ -1120,6 +1147,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 {
 	u8 *p = object;
 	u8 *endobject = object + s->object_size;
+	unsigned int orig_size;
 
 	if (s->flags & SLAB_RED_ZONE) {
 		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
@@ -1129,6 +1157,20 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
 			endobject, val, s->inuse - s->object_size))
 			return 0;
+
+		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
+			orig_size = get_orig_size(s, object);
+
+			if (!freeptr_outside_object(s))
+				orig_size = max_t(unsigned int, orig_size,
+						s->offset + sizeof(void *));
+			if (s->object_size > orig_size  &&
+				!check_bytes_and_report(s, slab, object,
+					"kmalloc Redzone", p + orig_size,
+					val, s->object_size - orig_size)) {
+				return 0;
+			}
+		}
 	} else {
 		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
 			check_bytes_and_report(s, slab, p, "Alignment padding",
@@ -4588,6 +4630,10 @@ size_t __ksize(const void *object)
 	if (unlikely(!folio_test_slab(folio)))
 		return folio_size(folio);
 
+#ifdef CONFIG_SLUB_DEBUG
+	skip_orig_size_check(folio_slab(folio)->slab_cache, object);
+#endif
+
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
 EXPORT_SYMBOL(__ksize);
-- 
2.27.0

