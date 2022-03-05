Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE014CE2B8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 06:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiCEFL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 00:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiCEFLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 00:11:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B335972B8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 21:10:31 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mv5-20020a17090b198500b001bf2a039831so2901752pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 21:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O8GRbSjDf/d5wSIYSAl6QKNAQrE6ORfL5rF+oxxc0t8=;
        b=i4Mv4Vf4RqDYJJPnwB3SV+l+aVPG/nq+WuN22xeL/299HVro99aZHJbqwf+Llm2+x4
         Ot/TK4XHtV+hSGjtJ40NBAbC+/SbA6ynCjEyDek4FXfycRW0dLtaU68gBrHHFMkzTQFC
         OHYXXyfvaxHfTfMcdivTOm4cpC1smpSnCq7CtlPHk9w7qPJvtvbDWAwuDU8RGtXPIl1S
         RvkEfs5My3X4DM/MWwNq5vtHT7vNrjG2tvcubRTrIALJJtlV5anI+pd5ktZtOqFZ7OmX
         iutDK5ACP1Ijt48t4vBNuEl8AMocPsUWkkP0Vm9rUsZDfpJO1Q72coOfWnGV+38DjJT4
         Z15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O8GRbSjDf/d5wSIYSAl6QKNAQrE6ORfL5rF+oxxc0t8=;
        b=nTPb+QrNvRN6lJn4PXROElMUH4iNCaJ0X6yVlyOxsz4TyeSBxgqRAmfEbvzz5vNVCI
         ANC/CBfk3omXicaIil6gyxk71X7BT1f4PlkVGqprKfS5ZPOJ3v0ZsE6ljM9td7DdTVrA
         F1m6hyxImCQ/U/lYWB+hGOo51O1DPVaC4azUiOS1Fh6mdg3kIkYKLeTdR65QTblFlDTE
         o++av0HK772nP8qI6s36XOmHXN6w2RcEjJt9IvV1t3DibDnH9jjelL/pe0HMFt2YAekx
         I/IAFZbQLn8cmT0pcGOGJz2EfMbjwcNFoycAespQsPKMRpX/VH7v2ra63Tytyr5q4Qal
         9FRg==
X-Gm-Message-State: AOAM531VYsDWbqSVV8K+qHJcGtj2xAk6a4O9JAm5JOWG2bozI3cW2QPL
        CrFWb/TJSvFlEeO1mxVD8/c=
X-Google-Smtp-Source: ABdhPJx92qDeBW9Gl/Cf1bMeFLMkE6s3mWQAyhyTDmRp7VIFbFlDU7jHLFOnA2D0hs0g9+abOOq/JA==
X-Received: by 2002:a17:90a:10d6:b0:1bc:48ad:c8c8 with SMTP id b22-20020a17090a10d600b001bc48adc8c8mr2135761pje.149.1646457030790;
        Fri, 04 Mar 2022 21:10:30 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id n34-20020a056a000d6200b004e1ba1016absm7604891pfv.31.2022.03.04.21.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 21:10:30 -0800 (PST)
Date:   Sat, 5 Mar 2022 05:10:25 +0000
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
Subject: Re: [PATCH v2 1/5] mm/slab: kmalloc: pass requests larger than
 order-1 page to page allocator
Message-ID: <YiLwwa8YUU6B8ID5@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
 <20220304063427.372145-2-42.hyeyoo@gmail.com>
 <213a7412-5439-2e8a-986f-6836f3976432@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213a7412-5439-2e8a-986f-6836f3976432@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 01:45:16PM +0100, Vlastimil Babka wrote:
> On 3/4/22 07:34, Hyeonggon Yoo wrote:
> > There is not much benefit for serving large objects in kmalloc().
> > Let's pass large requests to page allocator like SLUB for better
> > maintenance of common code.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Looks like it's on the right path! Some suggestions follow.
> 

Thank you for reviewing this!
You have really good eye.

> > ---
> >  include/linux/slab.h | 35 ++++++++++++++++-------------------
> >  mm/slab.c            | 31 +++++++++++++++++++++++++++----
> >  mm/slab.h            | 19 +++++++++++++++++++
> >  mm/slub.c            | 19 -------------------
> >  4 files changed, 62 insertions(+), 42 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 37bde99b74af..e7b3330db4f3 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -224,29 +224,19 @@ void kmem_dump_obj(void *object);
> >   * Kmalloc array related definitions
> >   */
> >  
> > -#ifdef CONFIG_SLAB
> >  /*
> > - * The largest kmalloc size supported by the SLAB allocators is
> > - * 32 megabyte (2^25) or the maximum allocatable page order if that is
> > - * less than 32 MB.
> > - *
> > - * WARNING: Its not easy to increase this value since the allocators have
> > - * to do various tricks to work around compiler limitations in order to
> > - * ensure proper constant folding.
> > + * SLAB and SLUB directly allocates requests fitting in to an order-1 page
> > + * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
> >   */
> > -#define KMALLOC_SHIFT_HIGH	((MAX_ORDER + PAGE_SHIFT - 1) <= 25 ? \
> > -				(MAX_ORDER + PAGE_SHIFT - 1) : 25)
> > -#define KMALLOC_SHIFT_MAX	KMALLOC_SHIFT_HIGH
> > +#ifdef CONFIG_SLAB
> > +#define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> > +#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
> 
> I think we should be able to also remove the larger sizes from
> __kmalloc_index() later in this file.
>

Right. we can remove sizes larger than max(PAGE_SHIFT) + 1.

searching using cscope, maximum PAGE_SHIFT is 20 (1MB) in hexagon.
I think we can remove anything larger than 2MB.

But Hmm, I'll add something like static_assert(PAGE_SHIFT <= 20).
Let's see if any architecture/config complain this.

> >  #ifndef KMALLOC_SHIFT_LOW
> >  #define KMALLOC_SHIFT_LOW	5
> >  #endif
> >  #endif
> >  
> >  #ifdef CONFIG_SLUB
> > -/*
> > - * SLUB directly allocates requests fitting in to an order-1 page
> > - * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
> > - */
> >  #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> >  #define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
> >  #ifndef KMALLOC_SHIFT_LOW
> > @@ -564,15 +554,15 @@ static __always_inline __alloc_size(1) void *kmalloc_large(size_t size, gfp_t fl
> >   *	Try really hard to succeed the allocation but fail
> >   *	eventually.
> >   */
> > +#ifndef CONFIG_SLOB
> >  static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
> >  {
> >  	if (__builtin_constant_p(size)) {
> > -#ifndef CONFIG_SLOB
> >  		unsigned int index;
> > -#endif
> > +
> >  		if (size > KMALLOC_MAX_CACHE_SIZE)
> >  			return kmalloc_large(size, flags);
> > -#ifndef CONFIG_SLOB
> > +
> >  		index = kmalloc_index(size);
> >  
> >  		if (!index)
> > @@ -581,10 +571,17 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
> >  		return kmem_cache_alloc_trace(
> >  				kmalloc_caches[kmalloc_type(flags)][index],
> >  				flags, size);
> > -#endif
> >  	}
> >  	return __kmalloc(size, flags);
> >  }
> > +#else
> > +static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
> > +{
> > +	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> > +		return kmalloc_large(size, flags);
> > +	return __kmalloc(size, flags);
> > +}
> > +#endif
> >  
> >  static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> >  {
> > diff --git a/mm/slab.c b/mm/slab.c
> > index ddf5737c63d9..570af6dc3478 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3624,7 +3624,8 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
> >  	void *ret;
> >  
> >  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> > -		return NULL;
> > +		return kmalloc_large(size, flags);
> 
> This loses the node information and NUMA locality.

Oh, my fault. Thank you for catching this.

> It would be better to generalize kmalloc_large_node() from mm/slub.c instead.

Sounds nice.

> > +
> >  	cachep = kmalloc_slab(size, flags);
> >  	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
> >  		return cachep;
> > @@ -3685,7 +3686,8 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
> >  	void *ret;
> >  
> >  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> > -		return NULL;
> > +		return kmalloc_large(size, flags);
> > +
> >  	cachep = kmalloc_slab(size, flags);
> >  	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
> >  		return cachep;
> > @@ -3739,14 +3741,21 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
> >  {
> >  	struct kmem_cache *s;
> >  	size_t i;
> > +	struct folio *folio;
> >  
> >  	local_irq_disable();
> >  	for (i = 0; i < size; i++) {
> >  		void *objp = p[i];
> >  
> > -		if (!orig_s) /* called via kfree_bulk */
> > +		if (!orig_s) {
> > +			/* called via kfree_bulk */
> > +			folio = virt_to_folio(objp);
> > +			if (unlikely(!folio_test_slab(folio))) {
> > +				free_large_kmalloc(folio, objp);
> 
> Hmm I'm not sure it's a good idea to call this and the page allocator with
> disabled irq's. Maybe simply re-enable around it?

Seems reasonable. re-enabling around here will be sufficient for this
function.

By The Way, it seems SLAB really does not care about disabling irq
even if it's unnecessary.

I would like to try reducing irq-disabled area in SLAB and how it
affects on macro/micro benchmarks after this series is done :)

> > +				continue;
> > +			}
> >  			s = virt_to_cache(objp);
> 
> Since we already have the folio, we shoold instead use folio_slab and
> slab->slab_cache (see how mm/slub.c does it).
> The same applies to functions below as well.

Right. I'll change them in v3.

> > -		else
> > +		} else
> >  			s = cache_from_obj(orig_s, objp);
> >  		if (!s)
> >  			continue;
> > @@ -3776,11 +3785,20 @@ void kfree(const void *objp)
> >  {
> >  	struct kmem_cache *c;
> >  	unsigned long flags;
> > +	struct folio *folio;
> > +	void *object = (void *) objp;
> >  
> >  	trace_kfree(_RET_IP_, objp);
> >  
> >  	if (unlikely(ZERO_OR_NULL_PTR(objp)))
> >  		return;
> > +
> > +	folio = virt_to_folio(objp);
> > +	if (unlikely(!folio_test_slab(folio))) {
> > +		free_large_kmalloc(folio, object);
> > +		return;
> > +	}
> > +
> >  	local_irq_save(flags);
> >  	kfree_debugcheck(objp);
> >  	c = virt_to_cache(objp);
> > @@ -4211,12 +4229,17 @@ void __check_heap_object(const void *ptr, unsigned long n,
> >  size_t __ksize(const void *objp)
> >  {
> >  	struct kmem_cache *c;
> > +	struct folio *folio;
> >  	size_t size;
> >  
> >  	BUG_ON(!objp);
> >  	if (unlikely(objp == ZERO_SIZE_PTR))
> >  		return 0;
> >  
> > +	folio = virt_to_folio(objp);
> > +	if (!folio_test_slab(folio))
> > +		return folio_size(folio);
> > +
> >  	c = virt_to_cache(objp);
> >  	size = c ? c->object_size : 0;
> >  
> > diff --git a/mm/slab.h b/mm/slab.h
> > index c7f2abc2b154..31e98beb47a3 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -664,6 +664,25 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> >  		print_tracking(cachep, x);
> >  	return cachep;
> >  }
> > +
> > +static __always_inline void kfree_hook(void *x)
> > +{
> > +	kmemleak_free(x);
> > +	kasan_kfree_large(x);
> 
> Looks like there's only one caller of kfree_hook() so we could do that
> directly there.
>

Right.

> > +}
> > +
> > +static inline void free_large_kmalloc(struct folio *folio, void *object)
> > +{
> > +	unsigned int order = folio_order(folio);
> > +
> > +	if (WARN_ON_ONCE(order == 0))
> > +		pr_warn_once("object pointer: 0x%p\n", object);
> > +
> > +	kfree_hook(object);
> > +	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
> > +			      -(PAGE_SIZE << order));
> > +	__free_pages(folio_page(folio, 0), order);
> > +}
> >  #endif /* CONFIG_SLOB */
> >  
> >  static inline size_t slab_ksize(const struct kmem_cache *s)
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 261474092e43..04fd084f4709 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1686,12 +1686,6 @@ static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
> >  	return ptr;
> >  }
> >  
> > -static __always_inline void kfree_hook(void *x)
> > -{
> > -	kmemleak_free(x);
> > -	kasan_kfree_large(x);
> > -}
> > -
> >  static __always_inline bool slab_free_hook(struct kmem_cache *s,
> >  						void *x, bool init)
> >  {
> > @@ -3535,19 +3529,6 @@ struct detached_freelist {
> >  	struct kmem_cache *s;
> >  };
> >  
> > -static inline void free_large_kmalloc(struct folio *folio, void *object)
> > -{
> > -	unsigned int order = folio_order(folio);
> > -
> > -	if (WARN_ON_ONCE(order == 0))
> > -		pr_warn_once("object pointer: 0x%p\n", object);
> > -
> > -	kfree_hook(object);
> > -	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
> > -			      -(PAGE_SIZE << order));
> > -	__free_pages(folio_page(folio, 0), order);
> > -}
> > -
> >  /*
> >   * This function progressively scans the array with free objects (with
> >   * a limited look ahead) and extract objects belonging to the same
>

Thank you so much!

-- 
Thank you, You are awesome!
Hyeonggon :-)
