Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F9E50B7C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442186AbiDVNA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355833AbiDVNAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:00:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6EA57B22
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:57:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d15so10658968pll.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xvy3Mrm8TlK/qcnyKtf14/2GDsiW87ANNkzN56hxHbU=;
        b=cqMdRE+m7aJFoTWUiIeOdukn0cO1cKCcXAvV2mAv5Sbj9y6P/q/gKRlwesa1WDAoo3
         qvdYcVxYamr6G3JiK5OvhS9R1522swyC0fiazlaJF4HBA3KjCdz3JvULIZVV7Un70aVU
         qbl31XH3wi2eAcQPllXSbVRbObRJ1YHoj8OQDI6jpxN1lpy8PS6/YFlXqeHC0UbN9sPW
         vbIkGy3lpsXJOS7YiPM2Qqrjr3GbmLaSyh+y2FhCvb30U37gHqU4q4JG27M9ZvdK1I7i
         C0M4jtneS/KGy95IRO0goUfczlrw79OoCrcyWMBkCva97bntad4p7TUbiY4ePetw3ivZ
         LFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xvy3Mrm8TlK/qcnyKtf14/2GDsiW87ANNkzN56hxHbU=;
        b=SVqbxIn3GPtiQDSiRI33gZzVBih5ZdnZFQdecwZru6X4dWmSBjVW/L+GJE2yrqDIgD
         oXttPhFIC80fBoCfcMAbOktLkfnBq3YPziJdZU8IJGNOEOP69qjLCUWuYk6LnczljgbM
         NM+VCZA7TR43SGXDkwxh7Oz4+icPpYHN78BLs77IfFceqpottqXwShy1Iy6j+1oJ01Ga
         JJj6ae0UJ/zcTrMEgClDQpFs4WvhGZSHo2wNJ9VfhwOMwyUOzwPG/v0sS1lZehVCM3nk
         GnScKw6D0pqf9yU/+63uEwjGdz14UFtWR/nAgKZc/s3FWqpfJ8urCmvvE6TbRPkl0Ay9
         c9Og==
X-Gm-Message-State: AOAM530Y90xnvfadszGG+PHwQMTCCKOn3w7CmoeLaRMjtDRWCvn7VG/4
        Kf5k+R3YH2gm3G1ru3Z4Uo8=
X-Google-Smtp-Source: ABdhPJyAA+3TvESGEGUfUvDyR7jJs62eXThjqIF1RVwOKJ6ZwJSDjfqopkDZEnbtcDTh1plTHtnsPg==
X-Received: by 2002:a17:903:22c5:b0:15a:869c:605c with SMTP id y5-20020a17090322c500b0015a869c605cmr4292168plg.113.1650632249040;
        Fri, 22 Apr 2022 05:57:29 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id y26-20020a056a00181a00b004fe3a6f02cesm2574267pfa.85.2022.04.22.05.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:57:27 -0700 (PDT)
Date:   Fri, 22 Apr 2022 21:57:20 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 11/15] mm/sl[auo]b: use same tracepoint in kmalloc
 and normal caches
Message-ID: <YmKmME7Nb1SnmjFm@hyeyoo>
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
 <20220308114142.1744229-12-42.hyeyoo@gmail.com>
 <b400a901-9997-4fdc-6b09-9e25f08e654e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b400a901-9997-4fdc-6b09-9e25f08e654e@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 06:13:04PM +0100, Vlastimil Babka wrote:
> On 3/8/22 12:41, Hyeonggon Yoo wrote:
> > Now that tracepoints print cache names, we can distinguish kmalloc and
> > normal cache allocations.
> > 
> > Use same tracepoint in kmalloc and normal caches. After this patch,
> > there is only two tracepoints in slab allocators: kmem_cache_alloc_node
> > and kmem_cache_free.
> 
> Haven't made up my mind yet about whether the extra overhead of cache names
> is worth it. But at least the unification of _node and non_node versions
> make sense.

How much do you expect the overhead of printing cache names?
If the overhead is the problem I think it's just okay not to print its
name.

even before this series we were not able to distinguish allocation
between caches. we could just distinguish them by checking
the tracepoint is kmem_cache_alloc or kmalloc.

> I would however use the tracepoint names without "_node" in them

But anyway the suggestion makes sense and I renamed it in v2. thanks!

> > Remove all unused tracepoints.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> >  include/trace/events/kmem.h | 79 -------------------------------------
> >  mm/slab.c                   |  8 ++--
> >  mm/slab_common.c            |  5 ++-
> >  mm/slob.c                   | 14 ++++---
> >  mm/slub.c                   | 19 +++++----
> >  5 files changed, 27 insertions(+), 98 deletions(-)
> > 
> > diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> > index 35e6887c6101..ca67ba5fd76a 100644
> > --- a/include/trace/events/kmem.h
> > +++ b/include/trace/events/kmem.h
> > @@ -9,56 +9,6 @@
> >  #include <linux/tracepoint.h>
> >  #include <trace/events/mmflags.h>
> >  
> > -DECLARE_EVENT_CLASS(kmem_alloc,
> > -
> > -	TP_PROTO(unsigned long call_site,
> > -		 const void *ptr,
> > -		 size_t bytes_req,
> > -		 size_t bytes_alloc,
> > -		 gfp_t gfp_flags),
> > -
> > -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags),
> > -
> > -	TP_STRUCT__entry(
> > -		__field(	unsigned long,	call_site	)
> > -		__field(	const void *,	ptr		)
> > -		__field(	size_t,		bytes_req	)
> > -		__field(	size_t,		bytes_alloc	)
> > -		__field(	gfp_t,		gfp_flags	)
> > -	),
> > -
> > -	TP_fast_assign(
> > -		__entry->call_site	= call_site;
> > -		__entry->ptr		= ptr;
> > -		__entry->bytes_req	= bytes_req;
> > -		__entry->bytes_alloc	= bytes_alloc;
> > -		__entry->gfp_flags	= gfp_flags;
> > -	),
> > -
> > -	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
> > -		(void *)__entry->call_site,
> > -		__entry->ptr,
> > -		__entry->bytes_req,
> > -		__entry->bytes_alloc,
> > -		show_gfp_flags(__entry->gfp_flags))
> > -);
> > -
> > -DEFINE_EVENT(kmem_alloc, kmalloc,
> > -
> > -	TP_PROTO(unsigned long call_site, const void *ptr,
> > -		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
> > -
> > -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
> > -);
> > -
> > -DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
> > -
> > -	TP_PROTO(unsigned long call_site, const void *ptr,
> > -		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
> > -
> > -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
> > -);
> > -
> >  DECLARE_EVENT_CLASS(kmem_alloc_node,
> >  
> >  	TP_PROTO(const char *name,
> > @@ -101,15 +51,6 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
> >  		__entry->node)
> >  );
> >  
> > -DEFINE_EVENT(kmem_alloc_node, kmalloc_node,
> > -
> > -	TP_PROTO(const char *name, unsigned long call_site,
> > -		 const void *ptr, size_t bytes_req, size_t bytes_alloc,
> > -		 gfp_t gfp_flags, int node),
> > -
> > -	TP_ARGS(name, call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
> > -);
> > -
> >  DEFINE_EVENT(kmem_alloc_node, kmem_cache_alloc_node,
> >  
> >  	TP_PROTO(const char *name, unsigned long call_site,
> > @@ -119,26 +60,6 @@ DEFINE_EVENT(kmem_alloc_node, kmem_cache_alloc_node,
> >  	TP_ARGS(name, call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
> >  );
> >  
> > -TRACE_EVENT(kfree,
> > -
> > -	TP_PROTO(unsigned long call_site, const void *ptr),
> > -
> > -	TP_ARGS(call_site, ptr),
> > -
> > -	TP_STRUCT__entry(
> > -		__field(	unsigned long,	call_site	)
> > -		__field(	const void *,	ptr		)
> > -	),
> > -
> > -	TP_fast_assign(
> > -		__entry->call_site	= call_site;
> > -		__entry->ptr		= ptr;
> > -	),
> > -
> > -	TP_printk("call_site=%pS ptr=%p",
> > -		  (void *)__entry->call_site, __entry->ptr)
> > -);
> > -
> >  TRACE_EVENT(kmem_cache_free,
> >  
> >  	TP_PROTO(const char *name, unsigned long call_site, const void *ptr),
> > diff --git a/mm/slab.c b/mm/slab.c
> > index e451f8136066..702a78f64b44 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3554,9 +3554,9 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
> >  	ret = slab_alloc_node(cachep, flags, nodeid, size, _RET_IP_);
> >  
> >  	ret = kasan_kmalloc(cachep, ret, size, flags);
> > -	trace_kmalloc_node(cachep->name, _RET_IP_, ret,
> > -			   size, cachep->size,
> > -			   flags, nodeid);
> > +	trace_kmem_cache_alloc_node(cachep->name, _RET_IP_, ret,
> > +				    size, cachep->size,
> > +				    flags, nodeid);
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
> > @@ -3692,7 +3692,6 @@ void kfree(const void *objp)
> >  	struct folio *folio;
> >  	void *x = (void *) objp;
> >  
> > -	trace_kfree(_RET_IP_, objp);
> >  
> >  	if (unlikely(ZERO_OR_NULL_PTR(objp)))
> >  		return;
> > @@ -3704,6 +3703,7 @@ void kfree(const void *objp)
> >  	}
> >  
> >  	c = folio_slab(folio)->slab_cache;
> > +	trace_kmem_cache_free(c->name, _RET_IP_, objp);
> >  
> >  	local_irq_save(flags);
> >  	kfree_debugcheck(objp);
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 03949445c5fc..8a8330a777f5 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -917,6 +917,7 @@ void free_large_kmalloc(struct folio *folio, void *object)
> >  	if (WARN_ON_ONCE(order == 0))
> >  		pr_warn_once("object pointer: 0x%p\n", object);
> >  
> > +	trace_kmem_cache_free(KMALLOC_LARGE_NAME, _RET_IP_, object);
> >  	kmemleak_free(object);
> >  	kasan_kfree_large(object);
> >  
> > @@ -962,8 +963,8 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
> >  	ptr = kasan_kmalloc_large(ptr, size, flags);
> >  	/* As ptr might get tagged, call kmemleak hook after KASAN. */
> >  	kmemleak_alloc(ptr, size, 1, flags);
> > -	trace_kmalloc_node(KMALLOC_LARGE_NAME, _RET_IP_, ptr, size,
> > -			   PAGE_SIZE << order, flags, node);
> > +	trace_kmem_cache_alloc_node(KMALLOC_LARGE_NAME, _RET_IP_, ptr, size,
> > +				    PAGE_SIZE << order, flags, node);
> >  	return ptr;
> >  
> >  }
> > diff --git a/mm/slob.c b/mm/slob.c
> > index d60175c9bb1b..3726b77a066b 100644
> > --- a/mm/slob.c
> > +++ b/mm/slob.c
> > @@ -505,8 +505,8 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
> >  		*m = size;
> >  		ret = (void *)m + minalign;
> >  
> > -		trace_kmalloc_node(KMALLOC_NAME, caller, ret,
> > -				   size, size + minalign, gfp, node);
> > +		trace_kmem_cache_alloc_node(KMALLOC_NAME, caller, ret,
> > +					    size, size + minalign, gfp, node);
> >  	} else {
> >  		unsigned int order = get_order(size);
> >  
> > @@ -514,8 +514,9 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
> >  			gfp |= __GFP_COMP;
> >  		ret = slob_new_pages(gfp, order, node);
> >  
> > -		trace_kmalloc_node(KMALLOC_LARGE_NAME, caller, ret,
> > -				   size, PAGE_SIZE << order, gfp, node);
> > +		trace_kmem_cache_alloc_node(KMALLOC_LARGE_NAME, caller,
> > +					    ret, size, PAGE_SIZE << order,
> > +					    gfp, node);
> >  	}
> >  
> >  	kmemleak_alloc(ret, size, 1, gfp);
> > @@ -533,8 +534,6 @@ void kfree(const void *block)
> >  {
> >  	struct folio *sp;
> >  
> > -	trace_kfree(_RET_IP_, block);
> > -
> >  	if (unlikely(ZERO_OR_NULL_PTR(block)))
> >  		return;
> >  	kmemleak_free(block);
> > @@ -543,10 +542,13 @@ void kfree(const void *block)
> >  	if (folio_test_slab(sp)) {
> >  		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
> >  		unsigned int *m = (unsigned int *)(block - align);
> > +
> > +		trace_kmem_cache_free(KMALLOC_LARGE_NAME, _RET_IP_, block);
> >  		slob_free(m, *m + align);
> >  	} else {
> >  		unsigned int order = folio_order(sp);
> >  
> > +		trace_kmem_cache_free(KMALLOC_NAME, _RET_IP_, block);
> >  		mod_node_page_state(folio_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
> >  				    -(PAGE_SIZE << order));
> >  		__free_pages(folio_page(sp, 0), order);
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 8a23d1f9507d..c2e713bdb26c 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3241,8 +3241,8 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
> >  {
> >  	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, size);
> >  
> > -	trace_kmalloc_node(s->name, _RET_IP_, ret,
> > -			   size, s->size, gfpflags, node);
> > +	trace_kmem_cache_alloc_node(s->name, _RET_IP_, ret,
> > +				    size, s->size, gfpflags, node);
> >  
> >  	ret = kasan_kmalloc(s, ret, size, gfpflags);
> >  	return ret;
> > @@ -4366,7 +4366,8 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
> >  
> >  	ret = slab_alloc_node(s, flags, node, _RET_IP_, size);
> >  
> > -	trace_kmalloc_node(s->name, _RET_IP_, ret, size, s->size, flags, node);
> > +	trace_kmem_cache_alloc_node(s->name, _RET_IP_, ret, size,
> > +				    s->size, flags, node);
> >  
> >  	ret = kasan_kmalloc(s, ret, size, flags);
> >  
> > @@ -4445,8 +4446,7 @@ void kfree(const void *x)
> >  	struct folio *folio;
> >  	struct slab *slab;
> >  	void *object = (void *)x;
> > -
> > -	trace_kfree(_RET_IP_, x);
> > +	struct kmem_cache *s;
> >  
> >  	if (unlikely(ZERO_OR_NULL_PTR(x)))
> >  		return;
> > @@ -4456,8 +4456,12 @@ void kfree(const void *x)
> >  		free_large_kmalloc(folio, object);
> >  		return;
> >  	}
> > +
> >  	slab = folio_slab(folio);
> > -	slab_free(slab->slab_cache, slab, object, NULL, 1, _RET_IP_);
> > +	s = slab->slab_cache;
> > +
> > +	trace_kmem_cache_free(s->name, _RET_IP_, x);
> > +	slab_free(s, slab, object, NULL, 1, _RET_IP_);
> >  }
> >  EXPORT_SYMBOL(kfree);
> >  
> > @@ -4825,7 +4829,8 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
> >  	ret = slab_alloc_node(s, gfpflags, node, caller, size);
> >  
> >  	/* Honor the call site pointer we received. */
> > -	trace_kmalloc_node(s->name, caller, ret, size, s->size, gfpflags, node);
> > +	trace_kmem_cache_alloc_node(s->name, caller, ret, size,
> > +				    s->size, gfpflags, node);
> >  
> >  	return ret;
> >  }
> 

-- 
Thanks,
Hyeonggon
