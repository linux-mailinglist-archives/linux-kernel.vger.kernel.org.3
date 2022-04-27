Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B3E5123E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiD0Ua6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbiD0Uaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:30:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081CA186D4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B6C7B82AA7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E48C385A7;
        Wed, 27 Apr 2022 20:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651091260;
        bh=PNzTs04YGfVJqUOp9XkMtqOAV64XCLp9v01FsUXZTRU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A+M6kHjNvfai+j0U+w/cLm4+H+4+WKxswbC35c44KSpbf1wFNmYKKCkaGEY/8vBJT
         l8MLLXbGclipdQ+lgAauKOm8C9yM0763CJ5+NTAlJyF30qzKaG0bSNs2li3P+/T6Z5
         1qof2ZIMlqrfQH5wOp4sUXuN68uQeCHpFdtfCsng=
Date:   Wed, 27 Apr 2022 13:27:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vbabka@suse.cz, penberg@kernel.org, roman.gushchin@linux.dev,
        iamjoonsoo.kim@lge.com, rientjes@google.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 2/2] mm: make minimum slab alignment a runtime
 property
Message-Id: <20220427132738.fdca02736b5d067c92185c5b@linux-foundation.org>
In-Reply-To: <20220427195820.1716975-2-pcc@google.com>
References: <20220427195820.1716975-1-pcc@google.com>
        <20220427195820.1716975-2-pcc@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 12:58:20 -0700 Peter Collingbourne <pcc@google.com> wrote:

> When CONFIG_KASAN_HW_TAGS is enabled we currently increase the minimum
> slab alignment to 16. This happens even if MTE is not supported in
> hardware or disabled via kasan=off, which creates an unnecessary
> memory overhead in those cases. Eliminate this overhead by making
> the minimum slab alignment a runtime property and only aligning to
> 16 if KASAN is enabled at runtime.
> 
> On a DragonBoard 845c (non-MTE hardware) with a kernel built with
> CONFIG_KASAN_HW_TAGS, waiting for quiescence after a full Android
> boot I see the following Slab measurements in /proc/meminfo (median
> of 3 reboots):
> 
> ...
>
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3009,10 +3009,9 @@ static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep,
>  	objp += obj_offset(cachep);
>  	if (cachep->ctor && cachep->flags & SLAB_POISON)
>  		cachep->ctor(objp);
> -	if (ARCH_SLAB_MINALIGN &&
> -	    ((unsigned long)objp & (ARCH_SLAB_MINALIGN-1))) {
> -		pr_err("0x%px: not aligned to ARCH_SLAB_MINALIGN=%d\n",
> -		       objp, (int)ARCH_SLAB_MINALIGN);
> +	if ((unsigned long)objp & (arch_slab_minalign() - 1)) {
> +		pr_err("0x%px: not aligned to arch_slab_minalign()=%d\n", objp,
> +		       (int)arch_slab_minalign());

printf/printk know about size_t.  Use %zu, no cast needed.  But...

>  	}
>  	return objp;
>  }
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 2b3206a2c3b5..33cc49810a54 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -154,8 +154,7 @@ static unsigned int calculate_alignment(slab_flags_t flags,
>  		align = max(align, ralign);
>  	}
>  
> -	if (align < ARCH_SLAB_MINALIGN)
> -		align = ARCH_SLAB_MINALIGN;
> +	align = max_t(size_t, align, arch_slab_minalign());

max_t/min_t are nature's way of telling us "you screwed up the types".

So what type _is_ slab alignment?  size_t seems sensible, but the code
prefers unsigned int.  So how about we stick with that?


This compiles.  Still some max_t's in slob.c because I was too lazy to
go fix the type of ARCH_KMALLOC_MINALIGN.

Shrug, I don't know if we can be bothered.   You decide :)


 arch/arm64/include/asm/cache.h |    2 +-
 include/linux/slab.h           |    2 +-
 mm/slab.c                      |    4 ++--
 mm/slab_common.c               |    2 +-
 mm/slob.c                      |   16 +++++++++++-----
 5 files changed, 16 insertions(+), 10 deletions(-)

--- a/arch/arm64/include/asm/cache.h~mm-make-minimum-slab-alignment-a-runtime-property-fix
+++ a/arch/arm64/include/asm/cache.h
@@ -58,7 +58,7 @@
 #ifdef CONFIG_KASAN_SW_TAGS
 #define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
 #elif defined(CONFIG_KASAN_HW_TAGS)
-static inline size_t arch_slab_minalign(void)
+static inline unsigned int arch_slab_minalign(void)
 {
 	return kasan_hw_tags_enabled() ? MTE_GRANULE_SIZE :
 					 __alignof__(unsigned long long);
--- a/include/linux/slab.h~mm-make-minimum-slab-alignment-a-runtime-property-fix
+++ a/include/linux/slab.h
@@ -215,7 +215,7 @@ void kmem_dump_obj(void *object);
  * of two and >= ARCH_SLAB_MINALIGN.
  */
 #ifndef arch_slab_minalign
-static inline size_t arch_slab_minalign(void)
+static inline unsigned int arch_slab_minalign(void)
 {
 	return ARCH_SLAB_MINALIGN;
 }
--- a/mm/slab.c~mm-make-minimum-slab-alignment-a-runtime-property-fix
+++ a/mm/slab.c
@@ -3010,8 +3010,8 @@ static void *cache_alloc_debugcheck_afte
 	if (cachep->ctor && cachep->flags & SLAB_POISON)
 		cachep->ctor(objp);
 	if ((unsigned long)objp & (arch_slab_minalign() - 1)) {
-		pr_err("0x%px: not aligned to arch_slab_minalign()=%d\n", objp,
-		       (int)arch_slab_minalign());
+		pr_err("0x%px: not aligned to arch_slab_minalign()=%u\n", objp,
+		       arch_slab_minalign());
 	}
 	return objp;
 }
--- a/mm/slab_common.c~mm-make-minimum-slab-alignment-a-runtime-property-fix
+++ a/mm/slab_common.c
@@ -154,7 +154,7 @@ static unsigned int calculate_alignment(
 		align = max(align, ralign);
 	}
 
-	align = max_t(size_t, align, arch_slab_minalign());
+	align = max(align, arch_slab_minalign());
 
 	return ALIGN(align, sizeof(void *));
 }
--- a/mm/slob.c~mm-make-minimum-slab-alignment-a-runtime-property-fix
+++ a/mm/slob.c
@@ -478,9 +478,11 @@ static __always_inline void *
 __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 {
 	unsigned int *m;
-	int minalign = max_t(size_t, ARCH_KMALLOC_MINALIGN, arch_slab_minalign());
+	unsigned int minalign;
 	void *ret;
 
+	minalign = max_t(unsigned int, ARCH_KMALLOC_MINALIGN,
+			 arch_slab_minalign());
 	gfp &= gfp_allowed_mask;
 
 	might_alloc(gfp);
@@ -493,7 +495,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp
 		 * kmalloc()'d objects.
 		 */
 		if (is_power_of_2(size))
-			align = max(minalign, (int) size);
+			align = max_t(unsigned int, minalign, size);
 
 		if (!size)
 			return ZERO_SIZE_PTR;
@@ -555,8 +557,11 @@ void kfree(const void *block)
 
 	sp = virt_to_folio(block);
 	if (folio_test_slab(sp)) {
-		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, arch_slab_minalign());
+		unsigned int align = max_t(unsigned int,
+					   ARCH_KMALLOC_MINALIGN,
+					   arch_slab_minalign());
 		unsigned int *m = (unsigned int *)(block - align);
+
 		slob_free(m, *m + align);
 	} else {
 		unsigned int order = folio_order(sp);
@@ -573,7 +578,7 @@ EXPORT_SYMBOL(kfree);
 size_t __ksize(const void *block)
 {
 	struct folio *folio;
-	int align;
+	unsigned int align;
 	unsigned int *m;
 
 	BUG_ON(!block);
@@ -584,7 +589,8 @@ size_t __ksize(const void *block)
 	if (unlikely(!folio_test_slab(folio)))
 		return folio_size(folio);
 
-	align = max_t(size_t, ARCH_KMALLOC_MINALIGN, arch_slab_minalign());
+	align = max_t(unsigned int, ARCH_KMALLOC_MINALIGN,
+		      arch_slab_minalign());
 	m = (unsigned int *)(block - align);
 	return SLOB_UNITS(*m) * SLOB_UNIT;
 }
_

