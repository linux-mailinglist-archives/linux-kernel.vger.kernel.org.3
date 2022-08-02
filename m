Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C77658797E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiHBJAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbiHBJAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:00:05 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FBB4F64B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:00:04 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id i71so6288816pge.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 02:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=clo3lVc+/OybcMVQuCbqMH68kmcuMBMmgei9oMXWinM=;
        b=MaAGhykihG2/erIn9PcZ84fm3ckrTPDUbfYqIigBhMCvgeyx1bwmDMqZv+1x4yWjL1
         UE98HvzaF/UMnIrNwWfoHlsILZqa1fdQwot/51W9Uumh3QWZ1MHWzf6jd4UGixPg7UES
         8AJts8+jV479TujK+l5r6FUadi1BV/8W+VOGLYr/ZrFvEz565v6i1Rk2vIgZ24wpQu6h
         06ag1xkJqE2nvgIyGxWJ+fFndPt9B+oPE1LIb/kZvteh8z7RYMDOpY9dt1b9/KmhQo12
         L+HOlB1i2cjcpdlEMLbTG5XR6P+JgxNhrgVAa89Hq6J1vN0+ZyMomMLXNSMNctr0ItJ8
         T0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=clo3lVc+/OybcMVQuCbqMH68kmcuMBMmgei9oMXWinM=;
        b=OGKwpjn3NoV50sD702NJ3NEVDcwJSYmf11yTZfjmNB07g19LNyCEMPkJOtUuHV7W8V
         TySWOIrLfBTWJ7MVqilsQajHNUoPXAaj21o9Mj1Go5gBdhFo+feCYI92UXk+dDYdXXlE
         rF2BXP3LNgVE5ieJ7qZpU+FTfsMEp5fkWjt3xq6Db72smUyoRDVb4Tohq0Jpf3VrfdF8
         ZhsJIqyBHX6vTqpDPHGsJO+rpDgmwoPRXU+8osM1Jv2P1qrhSm8uyMgw2OiC1r9QNF9o
         zSfT+3kmOn7R/Yj2YMjrAf0gxyI7a61xWXp0fdXGh9WoP8pldEVqa9OicmFBvX1db4P3
         r+TQ==
X-Gm-Message-State: AJIora9q8jIq8buNOZojILvZP8MFHyTgpsiPH4rm88OQKHTb4vJjYBHW
        scVylfLjcMnEMWFiZ1wXxo8=
X-Google-Smtp-Source: AGRyM1vziBUompymaVO6a5kkc+YJ9o/O/IDArDVEjAllMccxQ1mxUWW5v9QJbtvH66Ms2iniOdIDmw==
X-Received: by 2002:a63:4a41:0:b0:41a:a605:f07b with SMTP id j1-20020a634a41000000b0041aa605f07bmr16551492pgl.279.1659430803336;
        Tue, 02 Aug 2022 02:00:03 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b0016d987d7f76sm11370298plg.11.2022.08.02.01.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 02:00:02 -0700 (PDT)
Date:   Tue, 2 Aug 2022 17:59:54 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 08/15] mm/slab_common: kmalloc_node: pass large
 requests to page allocator
Message-ID: <Yujnihj5YVPP2LjA@hyeyoo>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-9-42.hyeyoo@gmail.com>
 <a26f9cb0-7781-3bdc-4536-0ac06f2483b1@suse.cz>
 <YuflNcUsyfQjculC@hyeyoo>
 <caca2088-957d-70d3-0548-7fae810ae5b5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caca2088-957d-70d3-0548-7fae810ae5b5@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 04:44:22PM +0200, Vlastimil Babka wrote:
> 
> On 8/1/22 16:37, Hyeonggon Yoo wrote:
> > On Thu, Jul 28, 2022 at 06:09:27PM +0200, Vlastimil Babka wrote:
> >> On 7/12/22 15:39, Hyeonggon Yoo wrote:
> >> > Now that kmalloc_large_node() is in common code, pass large requests
> >> > to page allocator in kmalloc_node() using kmalloc_large_node().
> >> > 
> >> > One problem is that currently there is no tracepoint in
> >> > kmalloc_large_node(). Instead of simply putting tracepoint in it,
> >> > use kmalloc_large_node{,_notrace} depending on its caller to show
> >> > useful address for both inlined kmalloc_node() and
> >> > __kmalloc_node_track_caller() when large objects are allocated.
> >> > 
> >> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> >> 
> >> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >>
> > 
> > Thanks!
> > 
> >> Nit below:
> >> 
> >> > ---
> >> >  v3:
> >> > 	This patch is new in v3 and this avoids
> >> > 	missing caller in __kmalloc_large_node_track_caller()
> >> > 	when kmalloc_large_node() is called.
> >> > 
> >> >  include/linux/slab.h | 26 +++++++++++++++++++-------
> >> >  mm/slab.h            |  2 ++
> >> >  mm/slab_common.c     | 17 ++++++++++++++++-
> >> >  mm/slub.c            |  2 +-
> >> >  4 files changed, 38 insertions(+), 9 deletions(-)
> >> > 
> >> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> >> > index 082499306098..fd2e129fc813 100644
> >> > --- a/include/linux/slab.h
> >> > +++ b/include/linux/slab.h
> >> > @@ -571,23 +571,35 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
> >> >  	return __kmalloc(size, flags);
> >> >  }
> >> >  
> >> > +#ifndef CONFIG_SLOB
> >> >  static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> >> >  {
> >> > -#ifndef CONFIG_SLOB
> >> > -	if (__builtin_constant_p(size) &&
> >> > -		size <= KMALLOC_MAX_CACHE_SIZE) {
> >> > -		unsigned int i = kmalloc_index(size);
> >> > +	if (__builtin_constant_p(size)) {
> >> > +		unsigned int index;
> >> >  
> >> > -		if (!i)
> >> > +		if (size > KMALLOC_MAX_CACHE_SIZE)
> >> > +			return kmalloc_large_node(size, flags, node);
> >> > +
> >> > +		index = kmalloc_index(size);
> >> > +
> >> > +		if (!index)
> >> >  			return ZERO_SIZE_PTR;
> >> >  
> >> >  		return kmem_cache_alloc_node_trace(
> >> > -				kmalloc_caches[kmalloc_type(flags)][i],
> >> > +				kmalloc_caches[kmalloc_type(flags)][index],
> >> >  						flags, node, size);
> >> >  	}
> >> > -#endif
> >> >  	return __kmalloc_node(size, flags, node);
> >> >  }
> >> > +#else
> >> > +static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> >> > +{
> >> > +	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> >> > +		return kmalloc_large_node(size, flags, node);
> >> > +
> >> > +	return __kmalloc_node(size, flags, node);
> >> > +}
> >> > +#endif
> >> >  
> >> >  /**
> >> >   * kmalloc_array - allocate memory for an array.
> >> > diff --git a/mm/slab.h b/mm/slab.h
> >> > index a8d5eb1c323f..7cb51ff44f0c 100644
> >> > --- a/mm/slab.h
> >> > +++ b/mm/slab.h
> >> > @@ -273,6 +273,8 @@ void create_kmalloc_caches(slab_flags_t);
> >> >  
> >> >  /* Find the kmalloc slab corresponding for a certain size */
> >> >  struct kmem_cache *kmalloc_slab(size_t, gfp_t);
> >> > +
> >> > +void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node);
> >> >  #endif
> >> >  
> >> >  gfp_t kmalloc_fix_flags(gfp_t flags);
> >> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> > index 6f855587b635..dc872e0ef0fc 100644
> >> > --- a/mm/slab_common.c
> >> > +++ b/mm/slab_common.c
> >> > @@ -956,7 +956,8 @@ void *kmalloc_large(size_t size, gfp_t flags)
> >> >  }
> >> >  EXPORT_SYMBOL(kmalloc_large);
> >> >  
> >> > -void *kmalloc_large_node(size_t size, gfp_t flags, int node)
> >> > +static __always_inline
> >> 
> >> I don't think we need to inline, compiler should be able to make
> >> kmalloc_large_node(_notrace) quite efficient anyway.
> > 
> > You mean s/static __always_inline/static/g, or like this?
> > 
> > kmalloc_large_node_notrace():
> > 	fold __kmalloc_large_node_notrace() into here
> > 
> > kmalloc_large_node():
> > 	kmalloc_large_node_notrace()
> > 	trace_kmalloc()
> > 
> > I have no strong opinion.
> > 
> > IMO It's unlikely that there would be workloads that are
> > meaningfully affected by inlining or not inlining __kmalloc_large_node_notrace().
> > Just wanted to avoid adding even tiny of overhead by this series.
> 
> I tried the following quick change on top of your series and got (with
> CONFIG_SLUB):
> 
> add/remove: 2/4 grow/shrink: 0/2 up/down: 208/-588 (-380)
> Function                                     old     new   delta
> __kmalloc_large_node                           -     186    +186
> __kmalloc_large_node.cold                      -      22     +22
> kmalloc_large_node.cold                       15       -     -15
> kmalloc_large.cold                            15       -     -15
> kmalloc_large_node_notrace.cold               22       -     -22
> kmalloc_large                                252      87    -165
> kmalloc_large_node                           271      86    -185
> kmalloc_large_node_notrace                   186       -    -186
> Total: Before=49398081, After=49397701, chg -0.00%
> 

Yeah, uninlining __kmalloc_large_node saves hundreds of bytes.
And the diff below looks good to me.

By The Way, do you have opinions on inlining slab_alloc_node()?
(Looks like similar topic?)

AFAIK slab_alloc_node() is inlined in:
        kmem_cache_alloc()
        kmem_cache_alloc_node()
        kmem_cache_alloc_lru()
        kmem_cache_alloc_trace()
        kmem_cache_alloc_node_trace()
        __kmem_cache_alloc_node()

This is what I get after simply dropping __always_inline in slab_alloc_node:

add/remove: 1/1 grow/shrink: 3/6 up/down: 1911/-5275 (-3364)
Function                                     old     new   delta
slab_alloc_node                                -    1356   +1356
sysfs_slab_alias                             134     327    +193
slab_memory_callback                         528     717    +189
__kmem_cache_create                         1325    1498    +173
__slab_alloc.constprop                       135       -    -135
kmem_cache_alloc_trace                       909     196    -713
kmem_cache_alloc                             937     191    -746
kmem_cache_alloc_node_trace                 1020     200    -820
__kmem_cache_alloc_node                      862      19    -843
kmem_cache_alloc_node                       1046     189    -857
kmem_cache_alloc_lru                        1348     187   -1161
Total: Before=32011183, After=32007819, chg -0.01%

So 3.28kB is cost of eliminating function call overhead in the 
fastpath.

This is tradeoff between function call overhead and
instruction cache usage...

> 
> diff --git a/mm/slab.h b/mm/slab.h
> index ad634e02b3cb..7b8963394144 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -274,7 +274,6 @@ void create_kmalloc_caches(slab_flags_t);
>  /* Find the kmalloc slab corresponding for a certain size */
>  struct kmem_cache *kmalloc_slab(size_t, gfp_t);
>  
> -void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node);
>  void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
>  			      int node, size_t orig_size,
>  			      unsigned long caller);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 0d6cbe9d7ad0..07a6bf1cff36 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -925,6 +925,7 @@ void free_large_kmalloc(struct folio *folio, void *object)
>  	__free_pages(folio_page(folio, 0), order);
>  }
>  
> +static void *__kmalloc_large_node(size_t size, gfp_t flags, int node);
>  static __always_inline
>  void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
>  {
> @@ -932,7 +933,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
>  	void *ret;
>  
>  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> -		ret = kmalloc_large_node_notrace(size, flags, node);
> +		ret = __kmalloc_large_node(size, flags, node);
>  		trace_kmalloc(_RET_IP_, ret,
>  			      size, PAGE_SIZE << get_order(size),
>  			      flags, node);
> @@ -1042,8 +1043,7 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
>   * know the allocation order to free the pages properly in kfree.
>   */
>  
> -static __always_inline
> -void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
> +static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
>  {
>  	struct page *page;
>  	void *ptr = NULL;
> @@ -1069,7 +1069,7 @@ void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
>  
>  void *kmalloc_large(size_t size, gfp_t flags)
>  {
> -	void *ret = __kmalloc_large_node_notrace(size, flags, NUMA_NO_NODE);
> +	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
>  
>  	trace_kmalloc(_RET_IP_, ret,
>  		      size, PAGE_SIZE << get_order(size),
> @@ -1078,14 +1078,9 @@ void *kmalloc_large(size_t size, gfp_t flags)
>  }
>  EXPORT_SYMBOL(kmalloc_large);
>  
> -void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
> -{
> -	return __kmalloc_large_node_notrace(size, flags, node);
> -}
> -
>  void *kmalloc_large_node(size_t size, gfp_t flags, int node)
>  {
> -	void *ret = __kmalloc_large_node_notrace(size, flags, node);
> +	void *ret = __kmalloc_large_node(size, flags, node);
>  
>  	trace_kmalloc(_RET_IP_, ret,
>  		      size, PAGE_SIZE << get_order(size),

-- 
Thanks,
Hyeonggon
