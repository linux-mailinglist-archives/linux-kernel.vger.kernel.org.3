Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5173050F987
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244793AbiDZKDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348217AbiDZKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:02:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6D3D52
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:22:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so1760347pjq.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hm7oVQYxO3fd7GmOYa3nQxaKA+j6AphhVucQJAo8raM=;
        b=RWKAQwY4UDrTWZLD/+P838WrR+CWL1pNp1RmIJIc6JhZUQylqKIR4U2tlRMSD9NFIS
         OU+xuywiwQb30UFy2Orbp7Ne0MuJFWJVTkl2M2MIcR5tJtyTLvkhmBn7UfmGJj+CDBZr
         zeSmY2zKngln+81AzlKaaoOQNQdQJ7YBhTPP5uNpPW6cCQNf+mF9NWOUyAIvt7ISDZUz
         LCbRuoesa+G6DqwKPj1rI+SBeAE47Eyox3SFlwBtS1mYvYcTCGpGlYAMm2fO60mXBhOG
         oSHCdxjxiLfZP0o9fCmbBhrAYijXxcHEIYEvPHWwX3YnwgSk5AvPm5RfF7ZQlWSR1o97
         5tXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hm7oVQYxO3fd7GmOYa3nQxaKA+j6AphhVucQJAo8raM=;
        b=u3zcY0SyprtYl59Uc9HFjimRTNlEsDgKojI67yE1mXISqecJZ9neHd0vIDv6JQn2sQ
         Dj4Ybo8QmiEPWxNlKqHVFHIkWpPpdNqeOtCrKAHXrFuvvDlOLIV7HrAzxy62n7+i9RWF
         vWdKOApEuSoMVKKya6adi9ej2byZ+WcqkdWEuMgY/QMYXGH4/ML5bygDr4dXq02RAFHh
         uVBhLKX1/GxN/m7XW92tU0TgsKaTyuKUnst1xJecY0z/8fznUSjE4N1QhHHzBX9JGO1Q
         GnASq02uymLkRUPXNTQoZUjP6iPaCiEEKnpmuUh/TwqAwOb9JAu3082ihqffCGwgaoAp
         YGGw==
X-Gm-Message-State: AOAM533Jlhe4gBUsEyBAZw3Cvq3xOO5CZKY6BVs/xQFWucKROov5h4Ys
        5trA9UjewNMjFS2u5VtYY6yW0w==
X-Google-Smtp-Source: ABdhPJzvlD7LemNHd9iqVpvw7dNlPBeLyVkT6XHit1dQfAOcw/3Mn8/a8tY+gQbzx8tSBx2vHB4LsQ==
X-Received: by 2002:a17:90a:6501:b0:1ca:a7df:695c with SMTP id i1-20020a17090a650100b001caa7df695cmr26008722pjj.152.1650964943815;
        Tue, 26 Apr 2022 02:22:23 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm14377175pfb.185.2022.04.26.02.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 02:22:23 -0700 (PDT)
Date:   Tue, 26 Apr 2022 17:22:20 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>, rientjes@google.com
Cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, smuchun@gmail.com
Subject: Re: [PATCH] mm: slab: optimize memcg_slab_free_hook()
Message-ID: <Yme5zE8ZU/FN63Av@FVFYT0MHHV2J.usts.net>
References: <20220425035406.9337-1-songmuchun@bytedance.com>
 <YmdYhs4nPrlNqB/Z@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmdYhs4nPrlNqB/Z@carbon>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 07:27:18PM -0700, Roman Gushchin wrote:
> On Mon, Apr 25, 2022 at 11:54:06AM +0800, Muchun Song wrote:
> > Most callers of memcg_slab_free_hook() already know the slab,  which could
> > be passed to memcg_slab_free_hook() directly to reduce the overhead of an
> > another call of virt_to_slab().  For bulk freeing of objects, the call of
> > slab_objcgs() in the loop in memcg_slab_free_hook() is redundant as well.
> > Rework memcg_slab_free_hook() and build_detached_freelist() to reduce
> > those unnecessary overhead and make memcg_slab_free_hook() can handle bulk
> > freeing in slab_free().
> > 
> > Move the calling site of memcg_slab_free_hook() from do_slab_free() to
> > slab_free() for slub to make the code clearer since the logic is weird
> > (e.g. the caller need to judge whether it needs to call
> > memcg_slab_free_hook()). It is easy to make mistakes like missing calling
> > of memcg_slab_free_hook() like fixes of:
> > 
> >   commit d1b2cf6cb84a ("mm: memcg/slab: uncharge during kmem_cache_free_bulk()")
> >   commit ae085d7f9365 ("mm: kfence: fix missing objcg housekeeping for SLAB")
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/slab.c |  4 ++--
> >  mm/slab.h | 30 ++++++++---------------------
> >  mm/slub.c | 66 +++++++++++++++++++++------------------------------------------
> >  3 files changed, 32 insertions(+), 68 deletions(-)
> 
> Overall it looks like a really nice cleanup!
> 
> One nit below.
> 
> > 
> > diff --git a/mm/slab.c b/mm/slab.c
> > index a301f266efd1..e868b4af4346 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3407,9 +3407,10 @@ static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
> >  {
> >  	bool init;
> >  
> > +	memcg_slab_free_hook(cachep, virt_to_slab(objp), &objp, 1);
> > +
> >  	if (is_kfence_address(objp)) {
> >  		kmemleak_free_recursive(objp, cachep->flags);
> > -		memcg_slab_free_hook(cachep, &objp, 1);
> >  		__kfence_free(objp);
> >  		return;
> >  	}
> > @@ -3442,7 +3443,6 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
> >  	check_irq_off();
> >  	kmemleak_free_recursive(objp, cachep->flags);
> >  	objp = cache_free_debugcheck(cachep, objp, caller);
> > -	memcg_slab_free_hook(cachep, &objp, 1);
> >  
> >  	/*
> >  	 * Skip calling cache_free_alien() when the platform is not numa.
> > diff --git a/mm/slab.h b/mm/slab.h
> > index db9fb5c8dae7..a8d5eb1c323f 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -547,36 +547,22 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> >  	obj_cgroup_put(objcg);
> >  }
> >  
> > -static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
> > +static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> >  					void **p, int objects)
> >  {
> > -	struct kmem_cache *s;
> >  	struct obj_cgroup **objcgs;
> > -	struct obj_cgroup *objcg;
> > -	struct slab *slab;
> > -	unsigned int off;
> >  	int i;
> >  
> >  	if (!memcg_kmem_enabled())
> >  		return;
> >  
> > -	for (i = 0; i < objects; i++) {
> > -		if (unlikely(!p[i]))
> > -			continue;
> > -
> > -		slab = virt_to_slab(p[i]);
> > -		/* we could be given a kmalloc_large() object, skip those */
> > -		if (!slab)
> > -			continue;
> > -
> > -		objcgs = slab_objcgs(slab);
> > -		if (!objcgs)
> > -			continue;
> > +	objcgs = slab_objcgs(slab);
> > +	if (!objcgs)
> > +		return;
> >  
> > -		if (!s_orig)
> > -			s = slab->slab_cache;
> > -		else
> > -			s = s_orig;
> > +	for (i = 0; i < objects; i++) {
> > +		struct obj_cgroup *objcg;
> > +		unsigned int off;
> >  
> >  		off = obj_to_index(s, slab, p[i]);
> >  		objcg = objcgs[off];
> > @@ -628,7 +614,7 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> >  {
> >  }
> >  
> > -static inline void memcg_slab_free_hook(struct kmem_cache *s,
> > +static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> >  					void **p, int objects)
> >  {
> >  }
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 6dc703488d30..86c50eb6c670 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3437,9 +3437,6 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
> >  	struct kmem_cache_cpu *c;
> >  	unsigned long tid;
> >  
> > -	/* memcg_slab_free_hook() is already called for bulk free. */
> > -	if (!tail)
> > -		memcg_slab_free_hook(s, &head, 1);
> >  redo:
> >  	/*
> >  	 * Determine the currently cpus per cpu slab.
> > @@ -3499,9 +3496,10 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
> >  }
> >  
> >  static __always_inline void slab_free(struct kmem_cache *s, struct slab *slab,
> > -				      void *head, void *tail, int cnt,
> > +				      void *head, void *tail, void **p, int cnt,
> >  				      unsigned long addr)
> >  {
> > +	memcg_slab_free_hook(s, slab, p, cnt);
> >  	/*
> >  	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
> >  	 * to remove objects, whose reuse must be delayed.
> > @@ -3523,7 +3521,7 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
> >  	if (!s)
> >  		return;
> >  	trace_kmem_cache_free(_RET_IP_, x, s->name);
> > -	slab_free(s, virt_to_slab(x), x, NULL, 1, _RET_IP_);
> > +	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, _RET_IP_);
> >  }
> >  EXPORT_SYMBOL(kmem_cache_free);
> >  
> > @@ -3564,79 +3562,59 @@ static inline
> >  int build_detached_freelist(struct kmem_cache *s, size_t size,
> >  			    void **p, struct detached_freelist *df)
> >  {
> > -	size_t first_skipped_index = 0;
> >  	int lookahead = 3;
> >  	void *object;
> >  	struct folio *folio;
> > -	struct slab *slab;
> > -
> > -	/* Always re-init detached_freelist */
> > -	df->slab = NULL;
> > -
> > -	do {
> > -		object = p[--size];
> > -		/* Do we need !ZERO_OR_NULL_PTR(object) here? (for kfree) */
> > -	} while (!object && size);
> > -
> > -	if (!object)
> > -		return 0;
> > +	size_t same;
> >  
> > +	object = p[--size];
> >  	folio = virt_to_folio(object);
> >  	if (!s) {
> >  		/* Handle kalloc'ed objects */
> >  		if (unlikely(!folio_test_slab(folio))) {
> >  			free_large_kmalloc(folio, object);
> > -			p[size] = NULL; /* mark object processed */
> > +			df->slab = NULL;
> >  			return size;
> >  		}
> >  		/* Derive kmem_cache from object */
> > -		slab = folio_slab(folio);
> > -		df->s = slab->slab_cache;
> > +		df->slab = folio_slab(folio);
> > +		df->s = df->slab->slab_cache;
> >  	} else {
> > -		slab = folio_slab(folio);
> > +		df->slab = folio_slab(folio);
> >  		df->s = cache_from_obj(s, object); /* Support for memcg */
> >  	}
> >  
> > -	if (is_kfence_address(object)) {
> > -		slab_free_hook(df->s, object, false);
> > -		__kfence_free(object);
> > -		p[size] = NULL; /* mark object processed */
> > -		return size;
> > -	}
> > -
> >  	/* Start new detached freelist */
> > -	df->slab = slab;
> > -	set_freepointer(df->s, object, NULL);
> >  	df->tail = object;
> >  	df->freelist = object;
> > -	p[size] = NULL; /* mark object processed */
> >  	df->cnt = 1;
> >  
> > +	if (is_kfence_address(object))
> > +		return size;
> > +
> > +	set_freepointer(df->s, object, NULL);
> > +
> > +	same = size;
> >  	while (size) {
> >  		object = p[--size];
> > -		if (!object)
> > -			continue; /* Skip processed objects */
> > -
> >  		/* df->slab is always set at this point */
> >  		if (df->slab == virt_to_slab(object)) {
> >  			/* Opportunity build freelist */
> >  			set_freepointer(df->s, object, df->freelist);
> >  			df->freelist = object;
> >  			df->cnt++;
> > -			p[size] = NULL; /* mark object processed */
> > -
> > +			same--;
> > +			if (size != same)
> > +				swap(p[size], p[same]);
> >  			continue;
> >  		}
> >  
> >  		/* Limit look ahead search */
> >  		if (!--lookahead)
> >  			break;
> > -
> > -		if (!first_skipped_index)
> > -			first_skipped_index = size + 1;
> >  	}
> >  
> > -	return first_skipped_index;
> > +	return same;
> >  }
> >  
> >  /* Note that interrupts must be enabled when calling this function. */
> > @@ -3645,7 +3623,6 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
> >  	if (WARN_ON(!size))
> >  		return;
> >  
> > -	memcg_slab_free_hook(s, p, size);
> >  	do {
> >  		struct detached_freelist df;
> >  
> > @@ -3653,7 +3630,8 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
> >  		if (!df.slab)
> >  			continue;
> >  
> > -		slab_free(df.s, df.slab, df.freelist, df.tail, df.cnt, _RET_IP_);
> > +		slab_free(df.s, df.slab, df.freelist, df.tail, &p[size], df.cnt,
> > +			  _RET_IP_);
> >  	} while (likely(size));
> 
> As I understand, it might result in more memcg_slab_free_hook() calls, right?

Partially correct. After this change, there is only one caller of
memcg_slab_free_hook(). So it will be inlined by compiler, the function
call overhead may not be a issue. 

> I guess you might want to include some benchmark results, which actually
> might look very good because of optimizations above.
>

Hi Roman and David,

Yep. The optimization is mainly for bulk freeing. I have did a test
for the overhead of kmem_cache_free_bulk(). The code snippet is like
follows.

  /* Allocate 16 objects and free them. */
  kmem_cache_alloc_bulk(); 
  kmem_cache_free_bulk();

Before patch:
  kmem_cache_free_bulk: ~430 ns

After patch:
  kmem_cache_free_bulk: ~400 ns

The overhead is reduced by about 7% for 16-object freeing.

Thanks
