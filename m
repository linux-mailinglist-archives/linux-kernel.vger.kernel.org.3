Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF8A5B07B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIGO5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiIGO5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:57:46 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3B85927B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:57:41 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h188so13811087pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=dn715j7z9j3EMcSnevzvQwvbS4cOIJSxg6vaem3HAEM=;
        b=kN++HlInDyQauxjeUcoZJN6gZlmoOr5DtjJhrnJGszXBNgFgYEPJgvNC0jykY/67lD
         7sPEC/sJtLzVgFdFc+J9+1TtzmtdLeUyQJQrgymPO/7JoS+aDNYJMg1cUKKTJyLwWtp1
         YI6oN8aFbb+jreKl81LJbmhNl7odjSr2Q5ibodiO7T3MGXUNw88Y8+REdAfrWABMeN0G
         VEn9IjRffs6vmMD3A4f5qj06ws1Y85pGU2daQOYm6JE89S80/PqTaaL614Sx+vwdzMGI
         4L0y8vMaHc0fdRg31SM4JkjfAehrxLaXNKpXgBF3F5RU2pxpiVS57/Pzge63nNESCCS4
         aVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=dn715j7z9j3EMcSnevzvQwvbS4cOIJSxg6vaem3HAEM=;
        b=oJTjAZgJyqcFpjhVj+wQmnjMiGrDBz0gqC3vJ8E+8/11oR0vTdRddjLAwvzLXJWtpf
         I8a9FYCCaEnn4ik9H09FruKKbmC/S8B/lm0VgYr2Ruir9HELUHjMOFFSWx90tEx3ASCM
         RFJussO86wR6L/GBZrQGAw778xK6kOeM4NuV1OJW2uKfAWhE8jGipWIUrkPf+u/uVaRR
         FNQ4mIyfUXVq6ujmycOK2qX1G8CloRxzq44qTS2mqY6ejvritVYANeoYqVgETvZR5kF1
         oYWImGxoxlz9nmVzIRr7S63oNWuQcfT5s5ZrPZ2S8TQK6+iQdKRayrWi7p1crimljjgO
         0EGg==
X-Gm-Message-State: ACgBeo1OlqMbN9jxPKBxHGdUMCw0YBcfMgZICuoSYf80BD3ji4NofIEI
        8gd5Q/UO6qJi/cXmi28c5wM=
X-Google-Smtp-Source: AA6agR6xiYL2bVwIXA8+vc9FXFQszSurEhI0CNWPgL1OKJJA++ooRj6t7xT3qp/IAZc+DvjYZ0qbmA==
X-Received: by 2002:a63:485a:0:b0:41d:ed37:d937 with SMTP id x26-20020a63485a000000b0041ded37d937mr3845615pgk.336.1662562660933;
        Wed, 07 Sep 2022 07:57:40 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id f28-20020a63511c000000b00422c003cf78sm4122866pgb.82.2022.09.07.07.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:57:39 -0700 (PDT)
Date:   Wed, 7 Sep 2022 23:57:34 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 2/4] mm/slub: only zero the requested size of buffer
 for kzalloc
Message-ID: <YxixXhscutM0nw66@hyeyoo>
References: <20220907071023.3838692-1-feng.tang@intel.com>
 <20220907071023.3838692-3-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907071023.3838692-3-feng.tang@intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 03:10:21PM +0800, Feng Tang wrote:
> kzalloc/kmalloc will round up the request size to a fixed size
> (mostly power of 2), so the allocated memory could be more than
> requested. Currently kzalloc family APIs will zero all the
> allocated memory.
> 
> To detect out-of-bound usage of the extra allocated memory, only
> zero the requested part, so that sanity check could be added to
> the extra space later.
> 
> For kzalloc users who will call ksize() later and utilize this
> extra space, please be aware that the space is not zeroed any
> more.

Can this break existing users?
or should we initialize extra bytes to zero when someone called ksize()?

If it is not going to break something - I think we can add a comment of this.
something like "... kzalloc() will initialize to zero only for @size bytes ..."

> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/slab.c | 6 +++---
>  mm/slab.h | 9 +++++++--
>  mm/slub.c | 6 +++---
>  3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index a5486ff8362a..73ecaa7066e1 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3253,7 +3253,7 @@ slab_alloc_node(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
>  	init = slab_want_init_on_alloc(flags, cachep);
>  
>  out:
> -	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
> +	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init, 0);
>  	return objp;
>  }
>  
> @@ -3506,13 +3506,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	 * Done outside of the IRQ disabled section.
>  	 */
>  	slab_post_alloc_hook(s, objcg, flags, size, p,
> -				slab_want_init_on_alloc(flags, s));
> +				slab_want_init_on_alloc(flags, s), 0);
>  	/* FIXME: Trace call missing. Christoph would like a bulk variant */
>  	return size;
>  error:
>  	local_irq_enable();
>  	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
> -	slab_post_alloc_hook(s, objcg, flags, i, p, false);
> +	slab_post_alloc_hook(s, objcg, flags, i, p, false, 0);
>  	kmem_cache_free_bulk(s, i, p);
>  	return 0;
>  }
> diff --git a/mm/slab.h b/mm/slab.h
> index d0ef9dd44b71..20f9e2a9814f 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -730,12 +730,17 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>  
>  static inline void slab_post_alloc_hook(struct kmem_cache *s,
>  					struct obj_cgroup *objcg, gfp_t flags,
> -					size_t size, void **p, bool init)
> +					size_t size, void **p, bool init,
> +					unsigned int orig_size)
>  {
>  	size_t i;
>  
>  	flags &= gfp_allowed_mask;
>  
> +	/* If original request size(kmalloc) is not set, use object_size */
> +	if (!orig_size)
> +		orig_size = s->object_size;

I think it is more readable to pass s->object_size than zero

> +
>  	/*
>  	 * As memory initialization might be integrated into KASAN,
>  	 * kasan_slab_alloc and initialization memset must be
> @@ -746,7 +751,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>  	for (i = 0; i < size; i++) {
>  		p[i] = kasan_slab_alloc(s, p[i], flags, init);
>  		if (p[i] && init && !kasan_has_integrated_init())
> -			memset(p[i], 0, s->object_size);
> +			memset(p[i], 0, orig_size);
>  		kmemleak_alloc_recursive(p[i], s->object_size, 1,
>  					 s->flags, flags);
>  	}
> diff --git a/mm/slub.c b/mm/slub.c
> index effd994438e6..f523601d3fcf 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3376,7 +3376,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
>  	init = slab_want_init_on_alloc(gfpflags, s);
>  
>  out:
> -	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
> +	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
>  
>  	return object;
>  }
> @@ -3833,11 +3833,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	 * Done outside of the IRQ disabled fastpath loop.
>  	 */
>  	slab_post_alloc_hook(s, objcg, flags, size, p,
> -				slab_want_init_on_alloc(flags, s));
> +				slab_want_init_on_alloc(flags, s), 0);
>  	return i;
>  error:
>  	slub_put_cpu_ptr(s->cpu_slab);
> -	slab_post_alloc_hook(s, objcg, flags, i, p, false);
> +	slab_post_alloc_hook(s, objcg, flags, i, p, false, 0);
>  	kmem_cache_free_bulk(s, i, p);

>  	return 0;
>  }
> -- 
> 2.34.1
>

-- 
Thanks,
Hyeonggon
