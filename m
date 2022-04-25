Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF7850E9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245002AbiDYTpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242459AbiDYTpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:45:33 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24EFBDD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:42:26 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id z21so6565013pgj.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ZSqG4AOptEuLcNL+PifeB7mlSMLZMEleeax2kERgk4A=;
        b=JxyB5xTsyq9zpLac++AlDpnc7GaboFL2Vf2HSZ/O/tCzCNp5s9h/8zYui9xkEK8xTz
         M/FvPLR1+ProfsDNfVoQhPzssAlN3H6JPJHO3bli1xvLInDqzZOA6GQDWIJNkDAJntJ2
         3bMv2Ak0kLr/PfRwTUHu48Sv0cRCgTqeHIC4xNaSJDdiZE0xIJ99WbdeYTDNBCmm3IPW
         W7T0oI8ZqkfYMHBYkjPUfx20YdsVtRvGgtetu0dsfA5CewULWd170kcPkHVkAj2ovSDE
         nCe18br9fHDVBIee1f0zkxPOv0MBwPSJuibYHSbjvNtxw87SOWbzMA0seHkXGz+h4Lsu
         InoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ZSqG4AOptEuLcNL+PifeB7mlSMLZMEleeax2kERgk4A=;
        b=a1zkXzC1CjahCF+yDToYwdew6KUXzNQUKY7+aC1PBvUGG+c0bWuWxobvBEMEB5oo/d
         t37PX9HYtQ/QgxeLOfAn02bqvjFhQEM8ADaIVeRv3wDQRJyNpaNub9gR5/xfSVWhKyC9
         kIq9awuopQpN/ZAu9EyqktZamAUZQuZXvV5F7jQMHAML8qGp2RN+p6gWhR7jMqESk/53
         YQKhIPvInc7+mENdM1wFwPhOuQ/DMU4acd/pvxuzE8lZrbh3atzkGeHAW/C5nW9N5j3Z
         kXdsNEHjq4NX92IUahVd662I+zo4sjjENsHRBt/cNk8VR/1LFYtXsVeqHDgR9LAAI8ls
         /0Xw==
X-Gm-Message-State: AOAM530++fAdh+6OZL4tT5ir64iJDXjcwKCHAjY7cjUtK2IBnEAy/YuV
        LgV0F4AN6UXcxQd3d1c5ohXkiA==
X-Google-Smtp-Source: ABdhPJzsZUFRsjkWv5iWoiiGJXv826Xajm5tPJMM1QHrzY+PWchgU8Ij+hgjJliumYdh1VJRxnvc9w==
X-Received: by 2002:a63:b542:0:b0:399:40fd:3ac3 with SMTP id u2-20020a63b542000000b0039940fd3ac3mr16290762pgo.564.1650915744465;
        Mon, 25 Apr 2022 12:42:24 -0700 (PDT)
Received: from [2620:15c:29:204:185b:8dcc:84d4:fb71] ([2620:15c:29:204:185b:8dcc:84d4:fb71])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090aa38200b001cb6527ca39sm168560pjp.0.2022.04.25.12.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 12:42:24 -0700 (PDT)
Date:   Mon, 25 Apr 2022 12:42:23 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Muchun Song <songmuchun@bytedance.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, smuchun@gmail.com
Subject: Re: [PATCH] mm: slab: optimize memcg_slab_free_hook()
In-Reply-To: <20220425035406.9337-1-songmuchun@bytedance.com>
Message-ID: <74f6b949-f9f-deb1-2786-47c92a619fd8@google.com>
References: <20220425035406.9337-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022, Muchun Song wrote:

> Most callers of memcg_slab_free_hook() already know the slab,  which could
> be passed to memcg_slab_free_hook() directly to reduce the overhead of an
> another call of virt_to_slab().  For bulk freeing of objects, the call of
> slab_objcgs() in the loop in memcg_slab_free_hook() is redundant as well.
> Rework memcg_slab_free_hook() and build_detached_freelist() to reduce
> those unnecessary overhead and make memcg_slab_free_hook() can handle bulk
> freeing in slab_free().
> 

I agree that for the SLUB case the code flows better after this, but I'm 
wondering if you have any numbers to share on how much better this is once 
we've avoided the virt_to_slab() calls?

IOW, I'm struggling to figure out if this is code cleanup or a performance 
optimization.

> Move the calling site of memcg_slab_free_hook() from do_slab_free() to
> slab_free() for slub to make the code clearer since the logic is weird
> (e.g. the caller need to judge whether it needs to call
> memcg_slab_free_hook()). It is easy to make mistakes like missing calling
> of memcg_slab_free_hook() like fixes of:
> 
>   commit d1b2cf6cb84a ("mm: memcg/slab: uncharge during kmem_cache_free_bulk()")
>   commit ae085d7f9365 ("mm: kfence: fix missing objcg housekeeping for SLAB")
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/slab.c |  4 ++--
>  mm/slab.h | 30 ++++++++---------------------
>  mm/slub.c | 66 +++++++++++++++++++++------------------------------------------
>  3 files changed, 32 insertions(+), 68 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index a301f266efd1..e868b4af4346 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3407,9 +3407,10 @@ static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
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
> @@ -3442,7 +3443,6 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
>  	check_irq_off();
>  	kmemleak_free_recursive(objp, cachep->flags);
>  	objp = cache_free_debugcheck(cachep, objp, caller);
> -	memcg_slab_free_hook(cachep, &objp, 1);
>  
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
> -		objcgs = slab_objcgs(slab);
> -		if (!objcgs)
> -			continue;
> +	objcgs = slab_objcgs(slab);
> +	if (!objcgs)
> +		return;
>  
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
> index 6dc703488d30..86c50eb6c670 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3437,9 +3437,6 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  	struct kmem_cache_cpu *c;
>  	unsigned long tid;
>  
> -	/* memcg_slab_free_hook() is already called for bulk free. */
> -	if (!tail)
> -		memcg_slab_free_hook(s, &head, 1);
>  redo:
>  	/*
>  	 * Determine the currently cpus per cpu slab.
> @@ -3499,9 +3496,10 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
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
> @@ -3523,7 +3521,7 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
>  	if (!s)
>  		return;
>  	trace_kmem_cache_free(_RET_IP_, x, s->name);
> -	slab_free(s, virt_to_slab(x), x, NULL, 1, _RET_IP_);
> +	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, _RET_IP_);
>  }
>  EXPORT_SYMBOL(kmem_cache_free);
>  
> @@ -3564,79 +3562,59 @@ static inline
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
>  
>  /* Note that interrupts must be enabled when calling this function. */
> @@ -3645,7 +3623,6 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
>  	if (WARN_ON(!size))
>  		return;
>  
> -	memcg_slab_free_hook(s, p, size);
>  	do {
>  		struct detached_freelist df;
>  
> @@ -3653,7 +3630,8 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
>  		if (!df.slab)
>  			continue;
>  
> -		slab_free(df.s, df.slab, df.freelist, df.tail, df.cnt, _RET_IP_);
> +		slab_free(df.s, df.slab, df.freelist, df.tail, &p[size], df.cnt,
> +			  _RET_IP_);
>  	} while (likely(size));
>  }
>  EXPORT_SYMBOL(kmem_cache_free_bulk);
> @@ -4556,7 +4534,7 @@ void kfree(const void *x)
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
