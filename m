Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4168951EBF3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 07:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiEHGCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 02:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiEHGC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 02:02:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DDC38BF
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 22:58:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso10215119pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 22:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k8gwVOtYdMrfQXErl2as3N/VGH9lS+z0WJbqTg/uq8E=;
        b=oMdTvzqRrXTWQqD6xU4QKdtjXAy8RLZbExOTV4/Gx3p6bq21iWUqXpTeg1CNAo/Bby
         45m7PKGAhDTtKOJi1MDW7o5+unzYNwvAMtsZSnIiisq/otK8cXKlXBh4INLXzN/kGOwW
         VMEcnP4fvWdotvuODS7zBQ1pR1XEM6Fgp6SFykT9cvdAHZWFnujWpl6fxXdJ4aP16Jk2
         6z2MCcbPjx+hUboXe4pfcLje/hWpTPIXGo7rmzxo/UajU6P0nQWt3VDt+xILVEzHbcns
         gbZMYaIoM+FISMs14xF6tcLDYzt0kuUCX6uAXXyY2cUgrLXOxVaJadPNFdFfo2I9hIby
         1Ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k8gwVOtYdMrfQXErl2as3N/VGH9lS+z0WJbqTg/uq8E=;
        b=tU2adBzeKmps9EodixP0qBIX6pVJs094d+zvUsPF2QBccR3lHyvZ2nUa25k4o8ycN5
         vajOfEsQPPVGhpU5WL55Ze2erCAvfv2SAisWZ95HzyrNSatWyTn7NE0tNSJQJAeEv/9J
         fTF53mgCz9P4h+PskcK4IBG/XOPdFlGBJpMCi6HLrA15c6gxc6TFWAX00zShqzvESTXO
         KeRmkxtOdKEhtgNF6Fk1RT8Su+wzlRFIFWEv7P/y6FD2KiV1YWSviTla4e81NyFS8P5u
         yrmqSuddMMrnJRBJJsaEG8pbOt5NCBbx6rhV5kY0BIb45Nf4cCoum4xm7hAxD7G38p3k
         K5Jg==
X-Gm-Message-State: AOAM531Wuj7iXMTm9VArdIHZnkRRVEXhj9nbVNnRT34QG5r7SD384oE1
        XVWPk6awahHVOHfOJAfT5u0=
X-Google-Smtp-Source: ABdhPJzJCmoOvYwnJl+zM0zQzL1p+AGUllpm9Y3GkaWAZ9BZuaGUdlpIU2EXO5vmqi59LMy8SB0t5Q==
X-Received: by 2002:a17:90b:4cc7:b0:1dc:18c5:adb2 with SMTP id nd7-20020a17090b4cc700b001dc18c5adb2mr11763195pjb.121.1651989518006;
        Sat, 07 May 2022 22:58:38 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id a29-20020a056a001d1d00b0050dc7628158sm5979919pfx.50.2022.05.07.22.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 22:58:37 -0700 (PDT)
Date:   Sun, 8 May 2022 14:58:30 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, smuchun@gmail.com
Subject: Re: [PATCH v2] mm: slab: optimize memcg_slab_free_hook()
Message-ID: <YndcBgfAjG7lcUHr@hyeyoo>
References: <20220429123044.37885-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429123044.37885-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 08:30:44PM +0800, Muchun Song wrote:
> Most callers of memcg_slab_free_hook() already know the slab,  which could
> be passed to memcg_slab_free_hook() directly to reduce the overhead of an
> another call of virt_to_slab().  For bulk freeing of objects, the call of
> slab_objcgs() in the loop in memcg_slab_free_hook() is redundant as well.
> Rework memcg_slab_free_hook() and build_detached_freelist() to reduce
> those unnecessary overhead and make memcg_slab_free_hook() can handle bulk
> freeing in slab_free().
> 
> Move the calling site of memcg_slab_free_hook() from do_slab_free() to
> slab_free() for slub to make the code clearer since the logic is weird
> (e.g. the caller need to judge whether it needs to call
> memcg_slab_free_hook()). It is easy to make mistakes like missing calling
> of memcg_slab_free_hook() like fixes of:
> 
>   commit d1b2cf6cb84a ("mm: memcg/slab: uncharge during kmem_cache_free_bulk()")
>   commit ae085d7f9365 ("mm: kfence: fix missing objcg housekeeping for SLAB")
> 
> This optimization is mainly for bulk objects freeing.  The following numbers
> is shown for 16-object freeing.
> 
>                            before      after
>   kmem_cache_free_bulk:   ~430 ns     ~400 ns
> 
> The overhead is reduced by about 7% for 16-object freeing.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v2:
>  - Add numbers to commit log.
> 
>  mm/slab.c |  4 ++--
>  mm/slab.h | 30 ++++++++---------------------
>  mm/slub.c | 66 +++++++++++++++++++++------------------------------------------
>  3 files changed, 32 insertions(+), 68 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index f8cd00f4ba13..2174962055ae 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3406,9 +3406,10 @@ static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
>  {
>  	bool init;
>  
> +	memcg_slab_free_hook(cachep, virt_to_slab(objp), &objp, 1);
> +
>  	if (is_kfence_address(objp)) {
>  		kmemleak_free_recursive(objp, cachep->flags);
> -		memcg_slab_free_hook(cachep, &objp, 1);
>  		__kfence_free(objp);
>  		return;
>  	}
> @@ -3441,7 +3442,6 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
>  	check_irq_off();
>  	kmemleak_free_recursive(objp, cachep->flags);
>  	objp = cache_free_debugcheck(cachep, objp, caller);
> -	memcg_slab_free_hook(cachep, &objp, 1);
>

SLAB part just looks fine.

>  	/*
>  	 * Skip calling cache_free_alien() when the platform is not numa.
> diff --git a/mm/slab.h b/mm/slab.h
> index db9fb5c8dae7..a8d5eb1c323f 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -547,36 +547,22 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  	obj_cgroup_put(objcg);
>  }
>  
> -static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
> +static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>  					void **p, int objects)
>  {
> -	struct kmem_cache *s;
>  	struct obj_cgroup **objcgs;
> -	struct obj_cgroup *objcg;
> -	struct slab *slab;
> -	unsigned int off;
>  	int i;
>  
>  	if (!memcg_kmem_enabled())
>  		return;
>  
> -	for (i = 0; i < objects; i++) {
> -		if (unlikely(!p[i]))
> -			continue;
> -
> -		slab = virt_to_slab(p[i]);
> -		/* we could be given a kmalloc_large() object, skip those */
> -		if (!slab)
> -			continue;
> -

Oh, memcg_slab_free_hook() no longer takes kmalloc_large() object becuase
such objects does not have corresponding slab.

> -		objcgs = slab_objcgs(slab);
> -		if (!objcgs)
> -			continue;
> +	objcgs = slab_objcgs(slab);
> +	if (!objcgs)
> +		return;

Now all objects in void **p should be in same slab,
so that we can remove some redundant part of loops that finds slab.
(virt_to_slab() and slab_objcgs())

> -		if (!s_orig)
> -			s = slab->slab_cache;
> -		else
> -			s = s_orig;
> +	for (i = 0; i < objects; i++) {
> +		struct obj_cgroup *objcg;
> +		unsigned int off;
>  
>  		off = obj_to_index(s, slab, p[i]);
>  		objcg = objcgs[off];
> @@ -628,7 +614,7 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  {
>  }
>  
> -static inline void memcg_slab_free_hook(struct kmem_cache *s,
> +static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>  					void **p, int objects)
>  {
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index 1f699ddfff7f..3794afe32b5f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3435,9 +3435,6 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  	struct kmem_cache_cpu *c;
>  	unsigned long tid;
>  
> -	/* memcg_slab_free_hook() is already called for bulk free. */
> -	if (!tail)
> -		memcg_slab_free_hook(s, &head, 1);
>  redo:
>  	/*
>  	 * Determine the currently cpus per cpu slab.
> @@ -3497,9 +3494,10 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  }
>  
>  static __always_inline void slab_free(struct kmem_cache *s, struct slab *slab,
> -				      void *head, void *tail, int cnt,
> +				      void *head, void *tail, void **p, int cnt,
>  				      unsigned long addr)
>  {
> +	memcg_slab_free_hook(s, slab, p, cnt);
>  	/*
>  	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
>  	 * to remove objects, whose reuse must be delayed.
> @@ -3521,7 +3519,7 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
>  	if (!s)
>  		return;
>  	trace_kmem_cache_free(_RET_IP_, x, s->name);
> -	slab_free(s, virt_to_slab(x), x, NULL, 1, _RET_IP_);
> +	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, _RET_IP_);
>  }

memcg slab free hook is moved from do_slab_free() to slab_free().

>  EXPORT_SYMBOL(kmem_cache_free);
>  
> @@ -3562,79 +3560,59 @@ static inline
>  int build_detached_freelist(struct kmem_cache *s, size_t size,
>  			    void **p, struct detached_freelist *df)
>  {
> -	size_t first_skipped_index = 0;
>  	int lookahead = 3;
>  	void *object;
>  	struct folio *folio;
> -	struct slab *slab;
> -
> -	/* Always re-init detached_freelist */
> -	df->slab = NULL;
> -
> -	do {
> -		object = p[--size];
> -		/* Do we need !ZERO_OR_NULL_PTR(object) here? (for kfree) */
> -	} while (!object && size);
> -
> -	if (!object)
> -		return 0;


Now it does not mark p[size] = NULL as processed

> +	size_t same;
>  
> +	object = p[--size];
>  	folio = virt_to_folio(object);
>  	if (!s) {
>  		/* Handle kalloc'ed objects */
>  		if (unlikely(!folio_test_slab(folio))) {
>  			free_large_kmalloc(folio, object);
> -			p[size] = NULL; /* mark object processed */
> +			df->slab = NULL;
>  			return size;

This part looks good too as kmem_cache_free_bulk() just skips if
df->slab == NULL.

>  		}
>  		/* Derive kmem_cache from object */
> -		slab = folio_slab(folio);
> -		df->s = slab->slab_cache;
> +		df->slab = folio_slab(folio);
> +		df->s = df->slab->slab_cache;
>  	} else {
> -		slab = folio_slab(folio);
> +		df->slab = folio_slab(folio);
>  		df->s = cache_from_obj(s, object); /* Support for memcg */
>  	}
>  
> -	if (is_kfence_address(object)) {
> -		slab_free_hook(df->s, object, false);
> -		__kfence_free(object);
> -		p[size] = NULL; /* mark object processed */
> -		return size;
> -	}
> -
>  	/* Start new detached freelist */
> -	df->slab = slab;
> -	set_freepointer(df->s, object, NULL);
>  	df->tail = object;
>  	df->freelist = object;
> -	p[size] = NULL; /* mark object processed */
>  	df->cnt = 1;
>  
> +	if (is_kfence_address(object))
> +		return size;
> +

and kfence too is freed in slab_free() using detached freelist after
this patch.

> +	set_freepointer(df->s, object, NULL);
> +
> +	same = size;
>  	while (size) {
>  		object = p[--size];
> -		if (!object)
> -			continue; /* Skip processed objects */
> -
>  		/* df->slab is always set at this point */
>  		if (df->slab == virt_to_slab(object)) {
>  			/* Opportunity build freelist */
>  			set_freepointer(df->s, object, df->freelist);
>  			df->freelist = object;
>  			df->cnt++;
> -			p[size] = NULL; /* mark object processed */
> -
> +			same--;
> +			if (size != same)
> +				swap(p[size], p[same]);
>  			continue;

Now that SLUB does not mark processed objects as p[size] = NULL,
SLUB should put objects in same slab together, so swap() to put them
together.

>  		}
>  
>  		/* Limit look ahead search */
>  		if (!--lookahead)
>  			break;
> -
> -		if (!first_skipped_index)
> -			first_skipped_index = size + 1;
>  	}
>  
> -	return first_skipped_index;
> +	return same;
>  }

same is last index of freed object in previous step,
so that should not be problem if next step treat that
as 'size' of array.

>  
>  /* Note that interrupts must be enabled when calling this function. */
> @@ -3643,7 +3621,6 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
>  	if (WARN_ON(!size))
>  		return;
>  
> -	memcg_slab_free_hook(s, p, size);
>  	do {
>  		struct detached_freelist df;
>  
> @@ -3651,7 +3628,8 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
>  		if (!df.slab)
>  			continue;
>  
> -		slab_free(df.s, df.slab, df.freelist, df.tail, df.cnt, _RET_IP_);
> +		slab_free(df.s, df.slab, df.freelist, df.tail, &p[size], df.cnt,
> +			  _RET_IP_);
>  	} while (likely(size));
>  }
>  EXPORT_SYMBOL(kmem_cache_free_bulk);
> @@ -4554,7 +4532,7 @@ void kfree(const void *x)
>  		return;
>  	}
>  	slab = folio_slab(folio);
> -	slab_free(slab->slab_cache, slab, object, NULL, 1, _RET_IP_);
> +	slab_free(slab->slab_cache, slab, object, NULL, &object, 1, _RET_IP_);
>  }
>  EXPORT_SYMBOL(kfree);
>  
> -- 
> 2.11.0
> 
> 

Nice improvements,
Looks good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
