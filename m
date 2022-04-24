Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BF250D148
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbiDXKts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiDXKtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:49:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5520E64BE2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:46:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s14so20774265plk.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=csRs3fmQd457QlO7dqPrYTB82Qqq+2T7nWfwhT2jUys=;
        b=JnZyENfIMFTgAjZsTisusnSldJNsWPKfbAfodB6wITqqukwBtYeH/CZseLbHvzjj46
         cezv48XmVrTg8t4m/ErnTngUa1JfYrH70nRCRkwhwwWZNS3Lo+/LUMCKmYSJdBMnH/NC
         j+J9K9GegkcP+ncEWlWsZ4+EHTP/yNtFJ2seN4lIeCOJKn6t8SFxWo4OTXXiyPZcoBbe
         hDBL7gmntANc8kLKnrPkjoQ2l9JbdC5ycv8ANLouKo/FZmI8SDBgovpEU5AWVv/LJQyt
         iOGM+hV4MpFXWUEbrVCz3hrC/9WFdAXX2uGtEWyn+BOslhkJWGwMVPdyOcYPQoVPOM5X
         nJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=csRs3fmQd457QlO7dqPrYTB82Qqq+2T7nWfwhT2jUys=;
        b=zm9NcFnWSHLbpU0/HapUErDpRdJH4d4FC2MgKquTYIS0efic/vpvyAUHeT1e9+zwfH
         tPLKLPS/AvC6L4OYQJOKc7oJDxYF89XeNfE2+yZpqhWZh54l5FIGFvro43LshmFMfm9y
         DTEjlj5lTcZjVLX3zNkJHSBfOuMpJMQZeMl7WPJ70ony30fLo6G7MVuUJBQF7/mf2WPi
         aU4EeDm8QcqZumxhNe2LiNWzI8D9o3nzE41+n9Qmv1RHZpmxNQpsh6UufZuzbnMqH/p+
         iV22c2UnoTB7PkFL2AIVEg3UyQi+tJx7zmF/Fgu57tvph1tfJUP7XCx9MIB/Gw+kObOE
         RjQw==
X-Gm-Message-State: AOAM530LtOFYQhSAKzppnfNZ0CyRPRirB5xdR+XUhSDFmdGay7LXyqlJ
        3kFkIge2jJAchDWcASEOYbA=
X-Google-Smtp-Source: ABdhPJy2RFCsS7rnnfdgK4l3UeVgVBRZm5/z+rEZP3sjk4ijXiWarFtFM4fpAnc9aVrOLyJYRet0IQ==
X-Received: by 2002:a17:90b:2690:b0:1d9:73e3:af18 with SMTP id pl16-20020a17090b269000b001d973e3af18mr55696pjb.213.1650797160848;
        Sun, 24 Apr 2022 03:46:00 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id z7-20020a056a00240700b004e1cde37bc1sm8305307pfh.84.2022.04.24.03.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 03:45:58 -0700 (PDT)
Date:   Sun, 24 Apr 2022 19:45:50 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v3] mm: make minimum slab alignment a runtime property
Message-ID: <YmUqXi5+53wDifKS@hyeyoo>
References: <20220422201830.288018-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422201830.288018-1-pcc@google.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:18:30PM -0700, Peter Collingbourne wrote:
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
> Before: 169020 kB
> After:  167304 kB
> 
> Link: https://linux-review.googlesource.com/id/I752e725179b43b144153f4b6f584ceb646473ead
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> ---
> v3:
> - go back to ARCH_SLAB_MINALIGN
> - revert changes to fs/binfmt_flat.c
> - update arch_slab_minalign() comment to say that it must be a power of two
> 
> v2:
> - use max instead of max_t in flat_stack_align()
> 
>  arch/arm64/include/asm/cache.h | 17 ++++++++++++-----
>  include/linux/slab.h           | 12 ++++++++++++
>  mm/slab.c                      |  7 +++----
>  mm/slab_common.c               |  3 +--
>  mm/slob.c                      |  6 +++---
>  5 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> index a074459f8f2f..22b22dc1b1b5 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -6,6 +6,7 @@
>  #define __ASM_CACHE_H
>  
>  #include <asm/cputype.h>
> +#include <asm/mte-def.h>
>  
>  #define CTR_L1IP_SHIFT		14
>  #define CTR_L1IP_MASK		3
> @@ -49,16 +50,22 @@
>   */
>  #define ARCH_DMA_MINALIGN	(128)
>  
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/bitops.h>
> +#include <linux/kasan-enabled.h>
> +
>  #ifdef CONFIG_KASAN_SW_TAGS
>  #define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
>  #elif defined(CONFIG_KASAN_HW_TAGS)
> -#define ARCH_SLAB_MINALIGN	MTE_GRANULE_SIZE
> +static inline size_t arch_slab_minalign(void)
> +{
> +	return kasan_hw_tags_enabled() ? MTE_GRANULE_SIZE :
> +					 __alignof__(unsigned long long);
> +}
> +#define arch_slab_minalign() arch_slab_minalign()
>  #endif
>  
> -#ifndef __ASSEMBLY__
> -
> -#include <linux/bitops.h>
> -
>  #define ICACHEF_ALIASING	0
>  #define ICACHEF_VPIPT		1
>  extern unsigned long __icache_flags;
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 373b3ef99f4e..2c7190db4cc0 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -209,6 +209,18 @@ void kmem_dump_obj(void *object);
>  #define ARCH_SLAB_MINALIGN __alignof__(unsigned long long)
>  #endif
>  
> +/*
> + * Arches can define this function if they want to decide the minimum slab
> + * alignment at runtime. The value returned by the function must be a power
> + * of two and >= ARCH_SLAB_MINALIGN.
> + */
> +#ifndef arch_slab_minalign
> +static inline size_t arch_slab_minalign(void)
> +{
> +	return ARCH_SLAB_MINALIGN;
> +}
> +#endif
> +
>  /*
>   * kmalloc and friends return ARCH_KMALLOC_MINALIGN aligned
>   * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MINALIGN
> diff --git a/mm/slab.c b/mm/slab.c
> index 0edb474edef1..97b756976c8b 100644
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
>  
>  	return ALIGN(align, sizeof(void *));
>  }
> diff --git a/mm/slob.c b/mm/slob.c
> index 40ea6e2d4ccd..3bd2669bd690 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -478,7 +478,7 @@ static __always_inline void *
>  __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
>  {
>  	unsigned int *m;
> -	int minalign = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
> +	int minalign = max_t(size_t, ARCH_KMALLOC_MINALIGN, arch_slab_minalign());
>  	void *ret;
>  
>  	gfp &= gfp_allowed_mask;
> @@ -555,7 +555,7 @@ void kfree(const void *block)
>  
>  	sp = virt_to_folio(block);
>  	if (folio_test_slab(sp)) {
> -		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
> +		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, arch_slab_minalign());
>  		unsigned int *m = (unsigned int *)(block - align);
>  		slob_free(m, *m + align);
>  	} else {
> @@ -584,7 +584,7 @@ size_t __ksize(const void *block)
>  	if (unlikely(!folio_test_slab(folio)))
>  		return folio_size(folio);
>  
> -	align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
> +	align = max_t(size_t, ARCH_KMALLOC_MINALIGN, arch_slab_minalign());
>  	m = (unsigned int *)(block - align);
>  	return SLOB_UNITS(*m) * SLOB_UNIT;
>  }
> -- 
> 2.36.0.rc2.479.g8af0fa9b8e-goog
> 

Looks good to me.
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

And work properly on my arm64 machine (no MTE support)
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

-- 
Thanks,
Hyeonggon
