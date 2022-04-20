Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA22A508FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381644AbiDTTKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244725AbiDTTKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:10:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4EC403CD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B374FB82158
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 19:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09596C385A0;
        Wed, 20 Apr 2022 19:07:50 +0000 (UTC)
Date:   Wed, 20 Apr 2022 20:07:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YmBaA5O8cnBuoGuG@arm.com>
References: <YlVHSvkyUBXZPUr2@arm.com>
 <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
 <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
 <Ylh61CCMkESmurIp@arm.com>
 <CAHk-=wjwupOLq3xh8z02CpXe8-=Lb_z0kXXQJYQ5YaQPpi3MiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwupOLq3xh8z02CpXe8-=Lb_z0kXXQJYQ5YaQPpi3MiA@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 03:25:59PM -0700, Linus Torvalds wrote:
> On Thu, Apr 14, 2022 at 12:49 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > It's a lot worse, ARCH_KMALLOC_MINALIGN is currently 128 bytes on arm64.
> > I want to at least get it down to 64 with this series while preserving
> > the current kmalloc() semantics.
> 
> So here's a thought - maybe we could do the reverse of GFP_DMA, and
> add a flag to the places that want small allocations and know they
> don't need DMA?

Quick diff below. I'll test it some more with all sl*b and post a proper
patch with description tomorrow. But the basic idea is that
ARCH_KMALLOC_MINALIGN remains the same as ARCH_DMA_MINALIGN so that I
don't have to change existing users. KMALLOC_MIN_SIZE is decoupled from
ARCH_KMALLOC_MINALIGN and now we have caches all the way to kmalloc-8
(with slub). Callers would have to pass __GFP_PACKED to get an object
with alignment below ARCH_KMALLOC_MINALIGN.

Without any kmalloc() callers modified, the kmalloc caches look like
(only booted in a VM, not much activity):

kmalloc-128        12055  12096    128   32
kmalloc-96             0      0     96   42
kmalloc-64             0      0     64   64
kmalloc-32             0      0     32  128
kmalloc-16             0      0     16  256
kmalloc-8              0      0      8  512

With kstrdup() modified to pass __GFP_PACKED (as per the last hunk in
the diff below), I get just after boot:

kmalloc-128         8966   9056    128   32
kmalloc-96             0      0     96   42
kmalloc-64           192    192     64   64
kmalloc-32           768    768     32  128
kmalloc-16          2048   2048     16  256
kmalloc-8           2560   2560      8  512

So that's probably the simplest approach and using the ftrace histogram
we can add the flag to more places.

--------------------8<-----------------------------------------------
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 761f8f1885c7..7c9f47ef3a53 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -63,8 +63,9 @@ struct vm_area_struct;
 #define ___GFP_SKIP_KASAN_UNPOISON	0
 #define ___GFP_SKIP_KASAN_POISON	0
 #endif
+#define ___GFP_PACKED		0x8000000u
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x8000000u
+#define ___GFP_NOLOCKDEP	0x10000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -251,6 +252,10 @@ struct vm_area_struct;
  *
  * %__GFP_SKIP_KASAN_POISON makes KASAN skip poisoning on page deallocation.
  * Typically, used for userspace pages. Only effective in HW_TAGS mode.
+ *
+ * %__GFP_PACKED returns a pointer aligned to the smaller KMALLOC_MIN_SIZE
+ * rather than ARCH_KMALLOC_MINALIGN. Beneficial for small object allocation
+ * on architectures that define ARCH_DMA_MINALIGN.
  */
 #define __GFP_NOWARN	((__force gfp_t)___GFP_NOWARN)
 #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
@@ -259,12 +264,13 @@ struct vm_area_struct;
 #define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
 #define __GFP_SKIP_KASAN_UNPOISON ((__force gfp_t)___GFP_SKIP_KASAN_UNPOISON)
 #define __GFP_SKIP_KASAN_POISON   ((__force gfp_t)___GFP_SKIP_KASAN_POISON)
+#define __GFP_PACKED	((__force gfp_t)___GFP_PACKED)
 
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (28 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 373b3ef99f4e..7bd3a33cdb9d 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -194,8 +194,6 @@ void kmem_dump_obj(void *object);
  */
 #if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
 #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
-#define KMALLOC_MIN_SIZE ARCH_DMA_MINALIGN
-#define KMALLOC_SHIFT_LOW ilog2(ARCH_DMA_MINALIGN)
 #else
 #define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
 #endif
@@ -364,12 +362,14 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
  * Callers where !size_is_constant should only be test modules, where runtime
  * overheads of __kmalloc_index() can be tolerated.  Also see kmalloc_slab().
  */
-static __always_inline unsigned int __kmalloc_index(size_t size,
+static __always_inline unsigned int __kmalloc_index(size_t size, gfp_t flags,
 						    bool size_is_constant)
 {
 	if (!size)
 		return 0;
 
+	if (ARCH_KMALLOC_MINALIGN > KMALLOC_MIN_SIZE && !(flags & __GFP_PACKED))
+		size = ALIGN(size, ARCH_KMALLOC_MINALIGN);
 	if (size <= KMALLOC_MIN_SIZE)
 		return KMALLOC_SHIFT_LOW;
 
@@ -409,7 +409,7 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 	/* Will never be reached. Needed because the compiler may complain */
 	return -1;
 }
-#define kmalloc_index(s) __kmalloc_index(s, true)
+#define kmalloc_index(s, f) __kmalloc_index(s, f, true)
 #endif /* !CONFIG_SLOB */
 
 void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
@@ -573,7 +573,7 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 		if (size > KMALLOC_MAX_CACHE_SIZE)
 			return kmalloc_large(size, flags);
 #ifndef CONFIG_SLOB
-		index = kmalloc_index(size);
+		index = kmalloc_index(size, flags);
 
 		if (!index)
 			return ZERO_SIZE_PTR;
@@ -591,7 +591,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
 #ifndef CONFIG_SLOB
 	if (__builtin_constant_p(size) &&
 		size <= KMALLOC_MAX_CACHE_SIZE) {
-		unsigned int i = kmalloc_index(size);
+		unsigned int i = kmalloc_index(size, flags);
 
 		if (!i)
 			return ZERO_SIZE_PTR;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6ee64d6208b3..d5da402c8aae 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -630,7 +630,7 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
 		unsigned int useroffset, unsigned int usersize)
 {
 	int err;
-	unsigned int align = ARCH_KMALLOC_MINALIGN;
+	unsigned int align = KMALLOC_MIN_SIZE;
 
 	s->name = name;
 	s->size = s->object_size = size;
@@ -722,6 +722,8 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 {
 	unsigned int index;
 
+	if (ARCH_KMALLOC_MINALIGN > KMALLOC_MIN_SIZE && !(flags & __GFP_PACKED))
+		size = ALIGN(size, ARCH_KMALLOC_MINALIGN);
 	if (size <= 192) {
 		if (!size)
 			return ZERO_SIZE_PTR;
diff --git a/mm/util.c b/mm/util.c
index 54e5e761a9a9..27eb1731de27 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -57,7 +57,7 @@ char *kstrdup(const char *s, gfp_t gfp)
 		return NULL;
 
 	len = strlen(s) + 1;
-	buf = kmalloc_track_caller(len, gfp);
+	buf = kmalloc_track_caller(len, gfp | __GFP_PACKED);
 	if (buf)
 		memcpy(buf, s, len);
 	return buf;

-- 
Catalin
