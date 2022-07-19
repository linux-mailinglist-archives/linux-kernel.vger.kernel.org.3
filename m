Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F5257A102
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbiGSOP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbiGSOPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:15:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E07264
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658238303; x=1689774303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qK5y0D0KpTkzm25IMexWQ0WperUrAguGmOpw+uIjEJM=;
  b=E/VtvHtNbHQcinJXNOl4/Nbil5+i1GXzjYqkiAM7YA+QwAR1/21/P+qs
   ClpFK6sBhtJ4Nnn9K6rpFc6JWLnOw+dpwXQ3liFTBsW512ifCD0vCiZYg
   39Cq7C/C+axmImjxZEVFTG2qlByOD6tFwPBxRHtuceh2CGqPPvaEsOZQi
   ME07u5FfRXb/cxov2Nis8FuGq9kIMALTZrGXltnawj/Yyn6sYDtHkxRFB
   JS2Vf946Ks2Fv8P4s5oj7Xrb6IOSjJw4RjUCQrvavhTzoukaiI3CUDGtB
   J4BaMEwaDc8kb7HEDCQmIo/Qmdg1jzwWTAEVfYOMX7BeSFp6ZF+cNfGO9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="287643795"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="287643795"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 06:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="655766731"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jul 2022 06:44:59 -0700
Date:   Tue, 19 Jul 2022 21:45:03 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v1] mm/slub: enable debugging memory wasting of kmalloc
Message-ID: <20220719134503.GA56558@shbuild999.sh.intel.com>
References: <20220701135954.45045-1-feng.tang@intel.com>
 <41763154-f923-ae99-55c0-0f3717636779@suse.cz>
 <20220713073642.GA69088@shbuild999.sh.intel.com>
 <45906408-34ce-4b79-fbe4-768335ffbf96@suse.cz>
 <20220715082922.GA88035@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715082922.GA88035@shbuild999.sh.intel.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil,

On Fri, Jul 15, 2022 at 04:29:22PM +0800, Tang, Feng wrote:
[...]
> > >> - the knowledge of actual size could be used to improve poisoning checks as
> > >> well, detect cases when there's buffer overrun over the orig_size but not
> > >> cache's size. e.g. if you kmalloc(48) and overrun up to 64 we won't detect
> > >> it now, but with orig_size stored we could?
> > > 
> > > The above patch doesn't touch this. As I have a question, for the
> > > [orib_size, object_size) area, shall we fill it with POISON_XXX no matter
> > > REDZONE flag is set or not?
> > 
> > Ah, looks like we use redzoning, not poisoning, for padding from
> > s->object_size to word boundary. So it would be more consistent to use the
> > redzone pattern (RED_ACTIVE) and check with the dynamic orig_size. Probably
> > no change for RED_INACTIVE handling is needed though.
> 
> Thanks for clarifying, will go this way and do more test. Also I'd 
> make it a separate patch, as it is logically different from the space
> wastage.

I made a draft to redzone the wasted space, which basically works (patch
pasted at the end of the mail) as detecting corruption of below test code:
	
	size = 256;
	buf = kmalloc(size + 8, GFP_KERNEL);
	memset(buf + size + size/2, 0xff, size/4);
	print_section(KERN_ERR, "Corruptted-kmalloc-space", buf, size * 2);
	kfree(buf);

However when it is enabled globally, there are many places reporting
corruption. I debugged one case, and found that the network(skb_buff)
code already knows this "wasted" kmalloc space and utilize it which is
detected by my patch.

The allocation stack is:

[    0.933675] BUG kmalloc-2k (Not tainted): kmalloc unused part overwritten
[    0.933675] -----------------------------------------------------------------------------
[    0.933675]
[    0.933675] 0xffff888237d026c0-0xffff888237d026e3 @offset=9920. First byte 0x0 instead of 0xcc
[    0.933675] Allocated in __alloc_skb+0x8e/0x1d0 age=5 cpu=0 pid=1
[    0.933675]  __slab_alloc.constprop.0+0x52/0x90
[    0.933675]  __kmalloc_node_track_caller+0x129/0x380
[    0.933675]  kmalloc_reserve+0x2a/0x70
[    0.933675]  __alloc_skb+0x8e/0x1d0
[    0.933675]  audit_buffer_alloc+0x3a/0xc0
[    0.933675]  audit_log_start.part.0+0xa3/0x300
[    0.933675]  audit_log+0x62/0xc0
[    0.933675]  audit_init+0x15c/0x16f

And the networking code which touches the [orig_size, object_size) area
is in __build_skb_around(), which put a 'struct skb_shared_info' at the
end of this area:

	static void __build_skb_around(struct sk_buff *skb, void *data,
				       unsigned int frag_size)
	{
		struct skb_shared_info *shinfo;
		unsigned int size = frag_size ? : ksize(data);

		size -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
		-----> XXX carve the space  <-----

		...
		skb_set_end_offset(skb, size);
		...

		shinfo = skb_shinfo(skb);
		memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
		atomic_set(&shinfo->dataref, 1);

		-----> upper 2 lines changes the memory <-----
		...
	}

Then we end up seeing the corruption report: 

[    0.933675] Object   ffff888237d026c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.933675] Object   ffff888237d026d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.933675] Object   ffff888237d026e0: 01 00 00 00 cc cc cc cc cc cc cc cc cc cc cc cc  ................

I haven't got time to chase other cases, and would update these first.

Following is the draft (not cleaned patch) patch to redzone the
[orig_size, object_size) space.

Thanks,
Feng

---
diff --git a/mm/slab.c b/mm/slab.c
index 6474c515a664..2f1110b16463 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3229,7 +3229,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
 	init = slab_want_init_on_alloc(flags, cachep);
 
 out_hooks:
-	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init);
+	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init, 0);
 	return ptr;
 }
 
@@ -3291,7 +3291,7 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
 	init = slab_want_init_on_alloc(flags, cachep);
 
 out:
-	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
+	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init, 0);
 	return objp;
 }
 
@@ -3536,13 +3536,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
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
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
diff --git a/mm/slab.h b/mm/slab.h
index a8d5eb1c323f..938ec6454dbc 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -719,12 +719,17 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 
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
@@ -735,7 +740,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 	for (i = 0; i < size; i++) {
 		p[i] = kasan_slab_alloc(s, p[i], flags, init);
 		if (p[i] && init && !kasan_has_integrated_init())
-			memset(p[i], 0, s->object_size);
+			memset(p[i], 0, orig_size);
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, flags);
 	}
diff --git a/mm/slub.c b/mm/slub.c
index 1a806912b1a3..014513e0658f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -45,6 +45,21 @@
 
 #include "internal.h"
 
+static inline void dump_slub(struct kmem_cache *s)
+{
+	printk("Dump slab[%s] info:\n", s->name);
+	printk("flags=0x%lx, size=%d, obj_size=%d, offset=%d\n"
+		"oo=0x%x, inuse=%d, align=%d, red_left_pad=%d\n",
+		s->flags, s->size, s->object_size, s->offset,
+		s->oo.x, s->inuse, s->align, s->red_left_pad
+		);
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+	printk("cpu_partial=%d, cpu_partial_slabs=%d\n",
+		s->cpu_partial, s->cpu_partial_slabs);
+#endif
+	printk("\n");
+}
+
 /*
  * Lock order:
  *   1. slab_mutex (Global Mutex)
@@ -191,6 +206,12 @@ static inline bool kmem_cache_debug(struct kmem_cache *s)
 	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
 }
 
+static inline bool kmem_cache_debug_orig_size(struct kmem_cache *s)
+{
+	return (s->flags & SLAB_KMALLOC &&
+			s->flags & (SLAB_RED_ZONE | SLAB_STORE_USER));
+}
+
 void *fixup_red_left(struct kmem_cache *s, void *p)
 {
 	if (kmem_cache_debug_flags(s, SLAB_RED_ZONE))
@@ -833,7 +854,7 @@ static unsigned int get_orig_size(struct kmem_cache *s, void *object)
 {
 	void *p = kasan_reset_tag(object);
 
-	if (!(s->flags & SLAB_KMALLOC))
+	if (!kmem_cache_debug_orig_size(s))
 		return s->object_size;
 
 	p = object + get_info_end(s);
@@ -902,6 +923,9 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 	if (s->flags & SLAB_STORE_USER)
 		off += 2 * sizeof(struct track);
 
+	if (kmem_cache_debug_orig_size(s))
+		off += sizeof(unsigned int);
+
 	off += kasan_metadata_size(s);
 
 	if (off != size_from_object(s))
@@ -958,13 +982,21 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
 static void init_object(struct kmem_cache *s, void *object, u8 val)
 {
 	u8 *p = kasan_reset_tag(object);
+	unsigned int orig_size = s->object_size;
 
 	if (s->flags & SLAB_RED_ZONE)
 		memset(p - s->red_left_pad, val, s->red_left_pad);
 
+	if (kmem_cache_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
+		/* Redzone the allocated by kmalloc but unused space */
+		orig_size = get_orig_size(s, object);
+		if (orig_size < s->object_size)
+			memset(p + orig_size, val, s->object_size - orig_size);
+	}
+
 	if (s->flags & __OBJECT_POISON) {
-		memset(p, POISON_FREE, s->object_size - 1);
-		p[s->object_size - 1] = POISON_END;
+		memset(p, POISON_FREE, orig_size - 1);
+		p[orig_size - 1] = POISON_END;
 	}
 
 	if (s->flags & SLAB_RED_ZONE)
@@ -1057,7 +1089,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 		/* We also have user information there */
 		off += 2 * sizeof(struct track);
 
-	if (s->flags & SLAB_KMALLOC)
+	if (kmem_cache_debug_orig_size(s))
 		off += sizeof(unsigned int);
 
 	off += kasan_metadata_size(s);
@@ -1110,6 +1142,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 {
 	u8 *p = object;
 	u8 *endobject = object + s->object_size;
+	unsigned int orig_size;
 
 	if (s->flags & SLAB_RED_ZONE) {
 		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
@@ -1119,6 +1152,8 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
 			endobject, val, s->inuse - s->object_size))
 			return 0;
+
+
 	} else {
 		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
 			check_bytes_and_report(s, slab, p, "Alignment padding",
@@ -1127,7 +1162,23 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		}
 	}
 
+	#if 1
+	if (kmem_cache_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
+
+		orig_size = get_orig_size(s, object); 
+
+		if (s->object_size != orig_size  &&  
+			!check_bytes_and_report(s, slab, object, "kmalloc unused part",
+				p + orig_size, val, s->object_size - orig_size)) {
+			dump_slub(s);
+//			while (1);
+			return 0;
+		}
+	}
+	#endif
+
 	if (s->flags & SLAB_POISON) {
+
 		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON) &&
 			(!check_bytes_and_report(s, slab, p, "Poison", p,
 					POISON_FREE, s->object_size - 1) ||
@@ -1367,7 +1418,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 	if (s->flags & SLAB_STORE_USER)
 		set_track(s, object, TRACK_ALLOC, addr);
 
-	if (s->flags & SLAB_KMALLOC)
+	if (kmem_cache_debug_orig_size(s))
 		set_orig_size(s, object, orig_size);
 
 	trace(s, slab, object, 1);
@@ -3276,7 +3327,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 	init = slab_want_init_on_alloc(gfpflags, s);
 
 out:
-	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
+	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
 
 	return object;
 }
@@ -3769,11 +3820,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
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
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
@@ -4155,12 +4206,12 @@ static int calculate_sizes(struct kmem_cache *s)
 		 */
 		size += 2 * sizeof(struct track);
 
-	/* Save the original requsted kmalloc size */
-	if (flags & SLAB_KMALLOC)
+	/* Save the original kmalloc request size */
+	if (kmem_cache_debug_orig_size(s))
 		size += sizeof(unsigned int);
 #endif
-
 	kasan_cache_create(s, &size, &s->flags);
+
 #ifdef CONFIG_SLUB_DEBUG
 	if (flags & SLAB_RED_ZONE) {
 		/*


