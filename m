Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02395339CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiEYJQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbiEYJQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:16:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CA67CB0E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:15:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o9-20020a17090a0a0900b001df3fc52ea7so1136600pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vDwUZxnj8AQ9QSKm/q97PsOT1KackUyYytM69+h1p+I=;
        b=extoHP7vbrXYGIpJ5uPMfbSgJlCYhBwDU4LH345YP6DZzKlepP1G+l+xXiGXWzsLvl
         I8hR/w3O+fpT3RVf771BMd8sAS/l7vvrBKdjmuNK1JjJ3lTX37zwm4o3G8UfKNkLKLh4
         SKuKU7wV87CiFxMlfXUcieIRHYJpy7EQwN1p3ezSyhU58XChIy7p9eMEnA063P2Brh7e
         rUDWvEz1Ju4obuRq3H3SbqqCB0ZAC49+u7hdc+VTx8HH8MtskKuzIOQ22AtOB10kW5xk
         uajXaC3NMtz8vGBWw2Smk760cWjrZjMfM8aSacjl0gewQ+/ilkYg+9kQ33LnhUprPoO3
         FElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vDwUZxnj8AQ9QSKm/q97PsOT1KackUyYytM69+h1p+I=;
        b=Uul1nBZdiClK2vhTeWs8GQiJBlKq4ghxhEXLk8tqGb7+/dbDHxg25yA2fYQ8eVLYy5
         OfTKKDIN/qIjf9pEkhE75IqSy2XVJkwIyVGZ+ZGy2pbPgo8qZ4Ug16zgGB/DeKfqXkvo
         4nfiwrDm+5cfFVmicQxI3Ecg32KVgO3dtVtKRBqzgM3ULdKqoV6m7cOju3i9Szr14XBb
         KaQIWV27cjCGKu/T7NB339o6bB2UvgX1ssP5Z760jK/T2nOj4LerOXMMrDke82Hc2n6R
         LEfIGxP+CD0IBRQTNfyghNo2FaYyIDaQoM83HIErKca0kpJZKr5Aujq+NHXFl1xAQJKP
         YtAA==
X-Gm-Message-State: AOAM530oLb8FJdXPfHegjfaHwSgeaRW/baTdz4yKHf+5XFwQmN6JnMJX
        /53PXrdPAO4C62/h+boFm4XeWQ==
X-Google-Smtp-Source: ABdhPJysy35ku+w3eTBiykyyPIg9R9y96lhhxFYA0s5U9IYP63EbFDNJcWU4yOjX50EH9JfNL+1oDw==
X-Received: by 2002:a17:90b:48d1:b0:1df:4fc8:c2d7 with SMTP id li17-20020a17090b48d100b001df4fc8c2d7mr9232258pjb.45.1653470109880;
        Wed, 25 May 2022 02:15:09 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id x3-20020a654143000000b003c14af50610sm7876215pgp.40.2022.05.25.02.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 02:15:09 -0700 (PDT)
Date:   Wed, 25 May 2022 17:15:05 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, smuchun@gmail.com
Subject: Re: [PATCH v2] mm: slab: optimize memcg_slab_free_hook()
Message-ID: <Yo3zmQLzHqdeyr3V@FVFYT0MHHV2J.googleapis.com>
References: <20220429123044.37885-1-songmuchun@bytedance.com>
 <86fdbde5-a010-9473-2f5d-807c86620509@suse.cz>
 <Yo2R3VA1LIwx10FM@FVFYT0MHHV2J.googleapis.com>
 <b34a75ac-389a-3965-9c56-0b18adc8440d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b34a75ac-389a-3965-9c56-0b18adc8440d@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 09:34:58AM +0200, Vlastimil Babka wrote:
> On 5/25/22 04:18, Muchun Song wrote:
> > On Tue, May 24, 2022 at 07:05:31PM +0200, Vlastimil Babka wrote:
> >> On 4/29/22 14:30, Muchun Song wrote:
> >> > Most callers of memcg_slab_free_hook() already know the slab,  which could
> >> > be passed to memcg_slab_free_hook() directly to reduce the overhead of an
> >> > another call of virt_to_slab().  For bulk freeing of objects, the call of
> >> > slab_objcgs() in the loop in memcg_slab_free_hook() is redundant as well.
> >> > Rework memcg_slab_free_hook() and build_detached_freelist() to reduce
> >> > those unnecessary overhead and make memcg_slab_free_hook() can handle bulk
> >> > freeing in slab_free().
> >> > 
> >> > Move the calling site of memcg_slab_free_hook() from do_slab_free() to
> >> > slab_free() for slub to make the code clearer since the logic is weird
> >> > (e.g. the caller need to judge whether it needs to call
> >> > memcg_slab_free_hook()). It is easy to make mistakes like missing calling
> >> > of memcg_slab_free_hook() like fixes of:
> >> > 
> >> >   commit d1b2cf6cb84a ("mm: memcg/slab: uncharge during kmem_cache_free_bulk()")
> >> >   commit ae085d7f9365 ("mm: kfence: fix missing objcg housekeeping for SLAB")
> >> 
> >> Hm is this commit also fixing such bug? in mm/slab.c __cache_free():
> >>

Sorry, I think I have misread it and misled you here.  I mean commit
ae085d7f9365 ("mm: kfence: fix missing objcg housekeeping for SLAB")
is a bug fix, this commit does not fix any issue since __cache_free()
will be called from qlink_free() and __cache_free() will call
memcg_slab_free_hook(), so there is no issues.  This commit is totally
an improvements for memcg_slab_free_hook().

> > 
> > Right.
> >  
> >> /* KASAN might put objp into memory quarantine, delaying its reuse. */
> >> if (kasan_slab_free(cachep, objp, init))
> >>         return;
> >> 
> >> before this patch we do not reach memcg_slab_free_hook() if
> >> kasan_slab_free() retuns true, after this patch we do. AFAICS SLUB always
> >> did memcg_slab_free_hook() in case of kasan_slab_free() so it's the correct
> >> thing to do?
> >>
> > 
> > I don't think it is an issue since memcg_slab_free_hook()
> > mainly does memory accounting housekeeping.  Doing it in
> > advance is not an issue.  Actually, we already have done
> > this since
> 
> Yes, it's not an issue. What is likely an issue is skipping the memcg hook
> it as the accounting will become wrong.
> 
> >   commit d1b2cf6cb84a ("mm: memcg/slab: uncharge during kmem_cache_free_bulk()")
> > 
> > From this commit, the object freed via kmem_cache_free_bulk()
> > in mm/slub.c have called memcg_slab_free_hook() even if
> > kasan_slab_free() retuns true.  Right?
> 
> Yeah, so that means SLAB will indeed be fixed by this patch.

When I reached here, I realized I may have misled you in the previous thread.
This commit does not fix any bugs.  Sorry for the confusing.

> We should mention it in the changelog then. I wouldn't cc stable though, as

So I think we do not need to mention it in the chagelog.

Thanks.

> it's quite a corner case and your patch is not trivial, backports might
> conflict and/or miss some prerequisity etc. If we cared a lot, a preceding
> small patch fixing just the SLAB case would be safer.
> 
> >> > This optimization is mainly for bulk objects freeing.  The following numbers
> >> > is shown for 16-object freeing.
> >> > 
> >> >                            before      after
> >> >   kmem_cache_free_bulk:   ~430 ns     ~400 ns
> >> > 
> >> > The overhead is reduced by about 7% for 16-object freeing.
> >> > 
> >> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> 
> >> Otherwise looks good, will add to slab tree for 5.20, thanks.
> >> 
> >> > ---
> >> > v2:
> >> >  - Add numbers to commit log.
> >> > 
> >> >  mm/slab.c |  4 ++--
> >> >  mm/slab.h | 30 ++++++++---------------------
> >> >  mm/slub.c | 66 +++++++++++++++++++++------------------------------------------
> >> >  3 files changed, 32 insertions(+), 68 deletions(-)
> >> > 
> >> > diff --git a/mm/slab.c b/mm/slab.c
> >> > index f8cd00f4ba13..2174962055ae 100644
> >> > --- a/mm/slab.c
> >> > +++ b/mm/slab.c
> >> > @@ -3406,9 +3406,10 @@ static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
> >> >  {
> >> >  	bool init;
> >> >  
> >> > +	memcg_slab_free_hook(cachep, virt_to_slab(objp), &objp, 1);
> >> > +
> >> >  	if (is_kfence_address(objp)) {
> >> >  		kmemleak_free_recursive(objp, cachep->flags);
> >> > -		memcg_slab_free_hook(cachep, &objp, 1);
> >> >  		__kfence_free(objp);
> >> >  		return;
> >> >  	}
> >> > @@ -3441,7 +3442,6 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
> >> >  	check_irq_off();
> >> >  	kmemleak_free_recursive(objp, cachep->flags);
> >> >  	objp = cache_free_debugcheck(cachep, objp, caller);
> >> > -	memcg_slab_free_hook(cachep, &objp, 1);
> >> >  
> >> >  	/*
> >> >  	 * Skip calling cache_free_alien() when the platform is not numa.
> >> > diff --git a/mm/slab.h b/mm/slab.h
> >> > index db9fb5c8dae7..a8d5eb1c323f 100644
> >> > --- a/mm/slab.h
> >> > +++ b/mm/slab.h
> >> > @@ -547,36 +547,22 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> >> >  	obj_cgroup_put(objcg);
> >> >  }
> >> >  
> >> > -static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
> >> > +static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> >> >  					void **p, int objects)
> >> >  {
> >> > -	struct kmem_cache *s;
> >> >  	struct obj_cgroup **objcgs;
> >> > -	struct obj_cgroup *objcg;
> >> > -	struct slab *slab;
> >> > -	unsigned int off;
> >> >  	int i;
> >> >  
> >> >  	if (!memcg_kmem_enabled())
> >> >  		return;
> >> >  
> >> > -	for (i = 0; i < objects; i++) {
> >> > -		if (unlikely(!p[i]))
> >> > -			continue;
> >> > -
> >> > -		slab = virt_to_slab(p[i]);
> >> > -		/* we could be given a kmalloc_large() object, skip those */
> >> > -		if (!slab)
> >> > -			continue;
> >> > -
> >> > -		objcgs = slab_objcgs(slab);
> >> > -		if (!objcgs)
> >> > -			continue;
> >> > +	objcgs = slab_objcgs(slab);
> >> > +	if (!objcgs)
> >> > +		return;
> >> >  
> >> > -		if (!s_orig)
> >> > -			s = slab->slab_cache;
> >> > -		else
> >> > -			s = s_orig;
> >> > +	for (i = 0; i < objects; i++) {
> >> > +		struct obj_cgroup *objcg;
> >> > +		unsigned int off;
> >> >  
> >> >  		off = obj_to_index(s, slab, p[i]);
> >> >  		objcg = objcgs[off];
> >> > @@ -628,7 +614,7 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> >> >  {
> >> >  }
> >> >  
> >> > -static inline void memcg_slab_free_hook(struct kmem_cache *s,
> >> > +static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> >> >  					void **p, int objects)
> >> >  {
> >> >  }
> >> > diff --git a/mm/slub.c b/mm/slub.c
> >> > index 1f699ddfff7f..3794afe32b5f 100644
> >> > --- a/mm/slub.c
> >> > +++ b/mm/slub.c
> >> > @@ -3435,9 +3435,6 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
> >> >  	struct kmem_cache_cpu *c;
> >> >  	unsigned long tid;
> >> >  
> >> > -	/* memcg_slab_free_hook() is already called for bulk free. */
> >> > -	if (!tail)
> >> > -		memcg_slab_free_hook(s, &head, 1);
> >> >  redo:
> >> >  	/*
> >> >  	 * Determine the currently cpus per cpu slab.
> >> > @@ -3497,9 +3494,10 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
> >> >  }
> >> >  
> >> >  static __always_inline void slab_free(struct kmem_cache *s, struct slab *slab,
> >> > -				      void *head, void *tail, int cnt,
> >> > +				      void *head, void *tail, void **p, int cnt,
> >> >  				      unsigned long addr)
> >> >  {
> >> > +	memcg_slab_free_hook(s, slab, p, cnt);
> >> >  	/*
> >> >  	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
> >> >  	 * to remove objects, whose reuse must be delayed.
> >> > @@ -3521,7 +3519,7 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
> >> >  	if (!s)
> >> >  		return;
> >> >  	trace_kmem_cache_free(_RET_IP_, x, s->name);
> >> > -	slab_free(s, virt_to_slab(x), x, NULL, 1, _RET_IP_);
> >> > +	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, _RET_IP_);
> >> >  }
> >> >  EXPORT_SYMBOL(kmem_cache_free);
> >> >  
> >> > @@ -3562,79 +3560,59 @@ static inline
> >> >  int build_detached_freelist(struct kmem_cache *s, size_t size,
> >> >  			    void **p, struct detached_freelist *df)
> >> >  {
> >> > -	size_t first_skipped_index = 0;
> >> >  	int lookahead = 3;
> >> >  	void *object;
> >> >  	struct folio *folio;
> >> > -	struct slab *slab;
> >> > -
> >> > -	/* Always re-init detached_freelist */
> >> > -	df->slab = NULL;
> >> > -
> >> > -	do {
> >> > -		object = p[--size];
> >> > -		/* Do we need !ZERO_OR_NULL_PTR(object) here? (for kfree) */
> >> > -	} while (!object && size);
> >> > -
> >> > -	if (!object)
> >> > -		return 0;
> >> > +	size_t same;
> >> >  
> >> > +	object = p[--size];
> >> >  	folio = virt_to_folio(object);
> >> >  	if (!s) {
> >> >  		/* Handle kalloc'ed objects */
> >> >  		if (unlikely(!folio_test_slab(folio))) {
> >> >  			free_large_kmalloc(folio, object);
> >> > -			p[size] = NULL; /* mark object processed */
> >> > +			df->slab = NULL;
> >> >  			return size;
> >> >  		}
> >> >  		/* Derive kmem_cache from object */
> >> > -		slab = folio_slab(folio);
> >> > -		df->s = slab->slab_cache;
> >> > +		df->slab = folio_slab(folio);
> >> > +		df->s = df->slab->slab_cache;
> >> >  	} else {
> >> > -		slab = folio_slab(folio);
> >> > +		df->slab = folio_slab(folio);
> >> >  		df->s = cache_from_obj(s, object); /* Support for memcg */
> >> >  	}
> >> >  
> >> > -	if (is_kfence_address(object)) {
> >> > -		slab_free_hook(df->s, object, false);
> >> > -		__kfence_free(object);
> >> > -		p[size] = NULL; /* mark object processed */
> >> > -		return size;
> >> > -	}
> >> > -
> >> >  	/* Start new detached freelist */
> >> > -	df->slab = slab;
> >> > -	set_freepointer(df->s, object, NULL);
> >> >  	df->tail = object;
> >> >  	df->freelist = object;
> >> > -	p[size] = NULL; /* mark object processed */
> >> >  	df->cnt = 1;
> >> >  
> >> > +	if (is_kfence_address(object))
> >> > +		return size;
> >> > +
> >> > +	set_freepointer(df->s, object, NULL);
> >> > +
> >> > +	same = size;
> >> >  	while (size) {
> >> >  		object = p[--size];
> >> > -		if (!object)
> >> > -			continue; /* Skip processed objects */
> >> > -
> >> >  		/* df->slab is always set at this point */
> >> >  		if (df->slab == virt_to_slab(object)) {
> >> >  			/* Opportunity build freelist */
> >> >  			set_freepointer(df->s, object, df->freelist);
> >> >  			df->freelist = object;
> >> >  			df->cnt++;
> >> > -			p[size] = NULL; /* mark object processed */
> >> > -
> >> > +			same--;
> >> > +			if (size != same)
> >> > +				swap(p[size], p[same]);
> >> >  			continue;
> >> >  		}
> >> >  
> >> >  		/* Limit look ahead search */
> >> >  		if (!--lookahead)
> >> >  			break;
> >> > -
> >> > -		if (!first_skipped_index)
> >> > -			first_skipped_index = size + 1;
> >> >  	}
> >> >  
> >> > -	return first_skipped_index;
> >> > +	return same;
> >> >  }
> >> >  
> >> >  /* Note that interrupts must be enabled when calling this function. */
> >> > @@ -3643,7 +3621,6 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
> >> >  	if (WARN_ON(!size))
> >> >  		return;
> >> >  
> >> > -	memcg_slab_free_hook(s, p, size);
> >> >  	do {
> >> >  		struct detached_freelist df;
> >> >  
> >> > @@ -3651,7 +3628,8 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
> >> >  		if (!df.slab)
> >> >  			continue;
> >> >  
> >> > -		slab_free(df.s, df.slab, df.freelist, df.tail, df.cnt, _RET_IP_);
> >> > +		slab_free(df.s, df.slab, df.freelist, df.tail, &p[size], df.cnt,
> >> > +			  _RET_IP_);
> >> >  	} while (likely(size));
> >> >  }
> >> >  EXPORT_SYMBOL(kmem_cache_free_bulk);
> >> > @@ -4554,7 +4532,7 @@ void kfree(const void *x)
> >> >  		return;
> >> >  	}
> >> >  	slab = folio_slab(folio);
> >> > -	slab_free(slab->slab_cache, slab, object, NULL, 1, _RET_IP_);
> >> > +	slab_free(slab->slab_cache, slab, object, NULL, &object, 1, _RET_IP_);
> >> >  }
> >> >  EXPORT_SYMBOL(kfree);
> >> >  
> >> 
> >> 
> 
> 
