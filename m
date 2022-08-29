Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECD25A4448
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiH2H4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiH2H4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:56:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6209828737
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661759758; x=1693295758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yiiKiHFW1n9E7Th9pCd+R7oBSWy8ZV+t/bo5jll4JtA=;
  b=HEzIsxpkSstILAru1ixeIR0u3jNymcuIVmo9ymYSmdHQrP6l/+68VNKD
   F+l555AjblM+h6jbh48YYbKKP9N3SkSd4fI36BaV+CPVCZvpl6MQe9wlL
   OH5qMJ9acV/S+WEBaCma6piQZfL1c1Pif5N4z/mw6rG+zlcfFXyBqnam3
   Lcn94Ri6j+rA+2ZHpxtmSKBsqjBtpaOR3a3A3I4Rv9pJqNpVyg8qyO5hc
   ABKQkMufC/E/D9OlF+/b5kNOJBRZnAHY0YNrsxkrjwbqACUY0O+t7kHsj
   aDfppm3nMgIR+qIMeqzgslYKNEqWU7+69UtcUpwkkLCmJRWItEnikbbiD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="381140135"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="381140135"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:55:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="672283594"
Received: from shbuild999.sh.intel.com ([10.239.147.181])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2022 00:55:55 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>
Subject: [PATCH v4 4/4] mm/slub: extend redzone check to cover extra allocated kmalloc space than requested
Date:   Mon, 29 Aug 2022 15:56:18 +0800
Message-Id: <20220829075618.69069-5-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220829075618.69069-1-feng.tang@intel.com>
References: <20220829075618.69069-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
size of the allocated buffer. So we skip the redzone sanity check and
kmalloc wastage debug for objects which have been called with ksize(),
as treating them as legitimate users of the extra space.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slab.h        |  4 ++
 mm/slab_common.c |  4 ++
 mm/slub.c        | 95 +++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 93 insertions(+), 10 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 1c773195cfcd..e296191b9453 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -875,4 +875,8 @@ void __check_heap_object(const void *ptr, unsigned long n,
 }
 #endif
 
+#ifdef CONFIG_SLUB_DEBUG
+extern void skip_orig_size_check(struct kmem_cache *s, const void *object);
+#endif
+
 #endif /* MM_SLAB_H */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8e13e3aac53f..5106667d6adb 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1001,6 +1001,10 @@ size_t __ksize(const void *object)
 		return folio_size(folio);
 	}
 
+#ifdef CONFIG_SLUB_DEBUG
+	skip_orig_size_check(folio_slab(folio)->slab_cache, object);
+#endif
+
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index 936b7be0642a..4348e0dbf8ee 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -791,18 +791,37 @@ static void print_slab_info(const struct slab *slab)
 	       folio_flags(folio, 0));
 }
 
-static inline void set_orig_size(struct kmem_cache *s,
+
+/*
+ * Return true if the saved orig_size is different from object size,
+ * and the return value can be used to judge whether redzone is needed.
+ */
+static inline bool set_orig_size(struct kmem_cache *s,
 					void *object, unsigned int orig_size)
 {
 	void *p = kasan_reset_tag(object);
 
-	if (!slub_debug_orig_size(s))
-		return;
+#ifdef CONFIG_KASAN_GENERIC
+	/*
+	 * KASAN could save its free meta data in the start part of
+	 * object area, so skip the redzone check if kasan's meta data
+	 * size is bigger enough to possibly overlap kmalloc redzone.
+	 */
+	if (s->kasan_info.free_meta_size_in_object * 2 >= s->object_size)
+		orig_size = s->object_size;
+#endif
 
 	p += get_info_end(s);
 	p += sizeof(struct track) * 2;
-
 	*(unsigned int *)p = orig_size;
+
+	return (orig_size != s->object_size);
+}
+
+void skip_orig_size_check(struct kmem_cache *s, const void *object)
+{
+	if (slub_debug_orig_size(s))
+		set_orig_size(s, (void *)object, s->object_size);
 }
 
 static unsigned int get_orig_size(struct kmem_cache *s, void *object)
@@ -949,6 +968,45 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 		memset(p + s->object_size, val, s->inuse - s->object_size);
 }
 
+/*
+ * For kmalloced objects, its allocated area could be larger than
+ * what was requested, save the original request size and extend
+ * the redzone check into this extra erea, if related debug flags
+ * are enabled
+ */
+static void init_kmalloc_object(struct kmem_cache *s, void *object, int orig_size)
+{
+	unsigned int redzone_start;
+	u8 *p = kasan_reset_tag(object);
+
+	if (!slub_debug_orig_size(s) || !set_orig_size(s, object, orig_size))
+		return;
+
+	/* Skip the redzone part if the flag is not enabled */
+	if (!(s->flags & SLAB_RED_ZONE))
+		return;
+
+	/*
+	 * init_object() has been called earlier in alloc_debug_processing(),
+	 * here only the object's data area is touched.
+	 */
+	redzone_start = orig_size;
+
+	if (!freeptr_outside_object(s))
+		redzone_start = max_t(unsigned int, orig_size,
+					s->offset + sizeof(void *));
+
+	if (redzone_start >= s->object_size)
+		return;
+
+	memset(p + redzone_start, SLUB_RED_ACTIVE,
+			s->object_size - redzone_start);
+
+	/* Poison area also need be shrunk */
+	if (s->flags & __OBJECT_POISON)
+		p[orig_size - 1] = POISON_END;
+}
+
 static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 						void *from, void *to)
 {
@@ -1089,6 +1147,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 {
 	u8 *p = object;
 	u8 *endobject = object + s->object_size;
+	unsigned int orig_size;
 
 	if (s->flags & SLAB_RED_ZONE) {
 		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
@@ -1098,6 +1157,20 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
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
@@ -1612,9 +1685,11 @@ void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 static inline int alloc_debug_processing(struct kmem_cache *s,
 	struct slab *slab, void *object) { return 0; }
 
-static inline void set_orig_size(struct kmem_cache *s,
-	void *object, unsigned int orig_size) {}
+static inline bool set_orig_size(struct kmem_cache *s,
+	void *object, unsigned int orig_size) { return false; }
 
+static inline void init_kmalloc_object(struct kmem_cache *s,
+	void *object, int orig_size) {}
 static inline void free_debug_processing(
 	struct kmem_cache *s, struct slab *slab,
 	void *head, void *tail, int bulk_cnt,
@@ -2071,7 +2146,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
  * and put the slab to the partial (or full) list.
  */
 static void *alloc_single_from_new_slab(struct kmem_cache *s,
-					struct slab *slab)
+					struct slab *slab, int orig_size)
 {
 	int nid = slab_nid(slab);
 	struct kmem_cache_node *n = get_node(s, nid);
@@ -3151,14 +3226,14 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	stat(s, ALLOC_SLAB);
 
 	if (kmem_cache_debug(s)) {
-		freelist = alloc_single_from_new_slab(s, slab);
+		freelist = alloc_single_from_new_slab(s, slab, orig_size);
 
 		if (unlikely(!freelist))
 			goto new_objects;
 
 		if (s->flags & SLAB_STORE_USER)
 			set_track(s, freelist, TRACK_ALLOC, addr);
-		set_orig_size(s, freelist, orig_size);
+		init_kmalloc_object(s, freelist, orig_size);
 
 		return freelist;
 	}
@@ -3184,7 +3259,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		if (s->flags & SLAB_STORE_USER)
 			set_track(s, freelist, TRACK_ALLOC, addr);
-		set_orig_size(s, freelist, orig_size);
+		init_kmalloc_object(s, freelist, orig_size);
 
 		return freelist;
 	}
-- 
2.34.1

