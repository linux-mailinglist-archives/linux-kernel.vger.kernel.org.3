Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10635AEAEE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbiIFNwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239582AbiIFNth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:49:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0002E9F0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:39:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 73so10699470pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ELnFZ093Jt8a9F8ubwxNseh5G1zdBMWLaLtcD4FqOZE=;
        b=OuSYJdIuEX5whZd9SA3DSBwHK8x34qKwbq0nOoZlJGCHJ1GESAUvXRz8ZB+LfPMrhP
         f98H0sCXQaL9bgJMRFL9JPHRPuH3r+/g8Ru6RSrB6qRdHBviTEEHjayvXHg+rhJ4sYGs
         /N4doEfM7+Ry8XcX/QCvNz48IYcaoUiMh+IlQWwgWLqfsDYHY2gNuYModPm4Egz20TIm
         2Kw1Qx4V+MzYo46yrnX/iCXNFSrA2TI7YN2GtwBl5kyb0Yg7oY2be2Nntcg3eQwotyaS
         wXTFcu9S96rBGyQwUwDIL4MwFphygBCw2no7O99nWJBSQ72slo9f1gYRT1vBo8bIVr6o
         p0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ELnFZ093Jt8a9F8ubwxNseh5G1zdBMWLaLtcD4FqOZE=;
        b=otcVjQGa+SAK8pzTz5vyj7lPv5DKKyg5/MHDBpL8zm1zKpOwqgCrQJ5m1+inU6Ud+v
         GCndi+I+XPpxyxpe461I/9bsZjzlhi6owrAts0VJnqcEmeyjtvZod/yB1srfLIXNvyeN
         laG2igDTd20iGhxkk+WdiVCR7qLbN3MHE4ib7NFS1ntuk//OFg+cuQVDdsdKGMZUkIWS
         FM1DI25Ase1xSWefkFe8Ev0mr9p2adRMPKMt1lxQ7x0yOfnQ4SCImLvTn/Xyymg0hdLi
         iPTjGSSOJKCSNlhBXZOGJEYmuJggNPKzgNlTBgG/jW/8RT4VCd0l3fj4mnJTBh1Y2ubT
         rxuw==
X-Gm-Message-State: ACgBeo0QU61H7G18IHvU8iklAFZKvfgD+6p/Bn4CIWiEElSVlT9MudfG
        yiukLqPZ+cTpk2l6cAVwhmU=
X-Google-Smtp-Source: AA6agR4tUlXyL8oUwLgGVvyxDTE5fbbjRA02wDD/zxu+KXrP25F7GIT/yUnGMEPufJoUfcnByvcahA==
X-Received: by 2002:a63:4d5b:0:b0:42c:299e:eecc with SMTP id n27-20020a634d5b000000b0042c299eeeccmr35534099pgl.41.1662471591352;
        Tue, 06 Sep 2022 06:39:51 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709029a0600b00176a47e5840sm5276189plp.298.2022.09.06.06.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:39:50 -0700 (PDT)
Date:   Tue, 6 Sep 2022 22:39:44 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <YxdNoGsEbW9x3L2A@hyeyoo>
References: <YxC7Kda5g/aEqarm@hyeyoo>
 <YxGfkdvJcNJma/88@feng-clx>
 <YxRp5uz9KSY0S9id@hyeyoo>
 <YxRzCX8WqOv3KESJ@feng-clx>
 <YxSE6XmHl3itv4JY@hyeyoo>
 <YxVlB/YRj7SNLqml@feng-clx>
 <8ff805f4-76ae-fc0f-424f-4d230c08285e@suse.cz>
 <YxWgEZTxyI/4ISHa@feng-clx>
 <f5057559-d4a7-552d-c5e8-1f1cd133a7f1@suse.cz>
 <YxW1MUIKJ8B17xl1@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxW1MUIKJ8B17xl1@feng-clx>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 04:37:05PM +0800, Feng Tang wrote:
> On Mon, Sep 05, 2022 at 03:33:14PM +0800, Vlastimil Babka wrote:
> > On 9/5/22 09:06, Feng Tang wrote:
> > > On Mon, Sep 05, 2022 at 02:29:51PM +0800, Vlastimil Babka wrote:
> > >> 
> > >> How about get_partial() instantiates an on-stack structure that contains
> > >> gfpflags, ret_slab, orig_size and passes pointer to that to all the nested
> > >> functions.
> > >> 
> > >> Would be similar to "struct alloc_context" in page allocation.
> > >> Something like "struct partial_context pc"?
> > > 
> > > Yep! This would make the parameters passing much tidier. Will try
> > > this way. 
> > > 
> > > More aggressively is to also embed the 'kmem_cache' parameter into
> > > it, but this may make the code look ambiguous.
> > 
> > That one is used a lot everywhere, so it would be tedious to dereference it
> > from a struct, and also might be a bit better code if it's in a register.
> 
> Got it. Following is the incremental patch for 1/4, which uses the
> 'partial_context' to pass parameters. And actually the 4/4 patch will
> benefit more from this refactoring, as the object initialization doesn't
> need to be separated and has race issue.
> 
> Thanks,
> Feng

Looks fine to me.
will review when next version arrives :)

> ---
> diff --git a/mm/slub.c b/mm/slub.c
> index 82e7bd3a3966..7497fb6ca8e2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -194,6 +194,12 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
>  #endif
>  #endif		/* CONFIG_SLUB_DEBUG */
>  
> +struct partial_context {
> +	struct slab **slab;
> +	gfp_t flags;
> +	int orig_size;
> +};
> +
>  static inline bool kmem_cache_debug(struct kmem_cache *s)
>  {
>  	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
> @@ -1333,7 +1339,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
>  }
>  
>  static noinline int alloc_debug_processing(struct kmem_cache *s,
> -					struct slab *slab, void *object)
> +			struct slab *slab, void *object, int orig_size)
>  {
>  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
>  		if (!alloc_consistency_checks(s, slab, object))
> @@ -1342,6 +1348,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
>  
>  	/* Success. Perform special debug activities for allocs */
>  	trace(s, slab, object, 1);
> +	set_orig_size(s, object, orig_size);
>  	init_object(s, object, SLUB_RED_ACTIVE);
>  	return 1;
>  
> @@ -1610,7 +1617,7 @@ static inline
>  void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
>  
>  static inline int alloc_debug_processing(struct kmem_cache *s,
> -	struct slab *slab, void *object) { return 0; }
> +	struct slab *slab, void *object, int orig_size) { return 0; }
>  
>  static inline void set_orig_size(struct kmem_cache *s,
>  	void *object, unsigned int orig_size) {}
> @@ -2042,7 +2049,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
>   * it to full list if it was the last free object.
>   */
>  static void *alloc_single_from_partial(struct kmem_cache *s,
> -		struct kmem_cache_node *n, struct slab *slab)
> +		struct kmem_cache_node *n, struct slab *slab, int orig_size)
>  {
>  	void *object;
>  
> @@ -2052,7 +2059,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
>  	slab->freelist = get_freepointer(s, object);
>  	slab->inuse++;
>  
> -	if (!alloc_debug_processing(s, slab, object)) {
> +	if (!alloc_debug_processing(s, slab, object, orig_size)) {
>  		remove_partial(n, slab);
>  		return NULL;
>  	}
> @@ -2071,7 +2078,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
>   * and put the slab to the partial (or full) list.
>   */
>  static void *alloc_single_from_new_slab(struct kmem_cache *s,
> -					struct slab *slab)
> +					struct slab *slab, int orig_size)
>  {
>  	int nid = slab_nid(slab);
>  	struct kmem_cache_node *n = get_node(s, nid);
> @@ -2083,7 +2090,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
>  	slab->freelist = get_freepointer(s, object);
>  	slab->inuse = 1;
>  
> -	if (!alloc_debug_processing(s, slab, object))
> +	if (!alloc_debug_processing(s, slab, object, orig_size))
>  		/*
>  		 * It's not really expected that this would fail on a
>  		 * freshly allocated slab, but a concurrent memory
> @@ -2161,7 +2168,7 @@ static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
>   * Try to allocate a partial slab from a specific node.
>   */
>  static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
> -			      struct slab **ret_slab, gfp_t gfpflags)
> +			      struct partial_context *pc)
>  {
>  	struct slab *slab, *slab2;
>  	void *object = NULL;
> @@ -2181,11 +2188,11 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
>  	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
>  		void *t;
>  
> -		if (!pfmemalloc_match(slab, gfpflags))
> +		if (!pfmemalloc_match(slab, pc->flags))
>  			continue;
>  
>  		if (kmem_cache_debug(s)) {
> -			object = alloc_single_from_partial(s, n, slab);
> +			object = alloc_single_from_partial(s, n, slab, pc->orig_size);
>  			if (object)
>  				break;
>  			continue;
> @@ -2196,7 +2203,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
>  			break;
>  
>  		if (!object) {
> -			*ret_slab = slab;
> +			*pc->slab = slab;
>  			stat(s, ALLOC_FROM_PARTIAL);
>  			object = t;
>  		} else {
> @@ -2220,14 +2227,13 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
>  /*
>   * Get a slab from somewhere. Search in increasing NUMA distances.
>   */
> -static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
> -			     struct slab **ret_slab)
> +static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
>  {
>  #ifdef CONFIG_NUMA
>  	struct zonelist *zonelist;
>  	struct zoneref *z;
>  	struct zone *zone;
> -	enum zone_type highest_zoneidx = gfp_zone(flags);
> +	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
>  	void *object;
>  	unsigned int cpuset_mems_cookie;
>  
> @@ -2255,15 +2261,15 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
>  
>  	do {
>  		cpuset_mems_cookie = read_mems_allowed_begin();
> -		zonelist = node_zonelist(mempolicy_slab_node(), flags);
> +		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
>  		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
>  			struct kmem_cache_node *n;
>  
>  			n = get_node(s, zone_to_nid(zone));
>  
> -			if (n && cpuset_zone_allowed(zone, flags) &&
> +			if (n && cpuset_zone_allowed(zone, pc->flags) &&
>  					n->nr_partial > s->min_partial) {
> -				object = get_partial_node(s, n, ret_slab, flags);
> +				object = get_partial_node(s, n, pc);
>  				if (object) {
>  					/*
>  					 * Don't check read_mems_allowed_retry()
> @@ -2284,8 +2290,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
>  /*
>   * Get a partial slab, lock it and return it.
>   */
> -static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
> -			 struct slab **ret_slab)
> +static void *get_partial(struct kmem_cache *s, int node, struct partial_context *pc)
>  {
>  	void *object;
>  	int searchnode = node;
> @@ -2293,11 +2298,11 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
>  	if (node == NUMA_NO_NODE)
>  		searchnode = numa_mem_id();
>  
> -	object = get_partial_node(s, get_node(s, searchnode), ret_slab, flags);
> +	object = get_partial_node(s, get_node(s, searchnode), pc);
>  	if (object || node != NUMA_NO_NODE)
>  		return object;
>  
> -	return get_any_partial(s, flags, ret_slab);
> +	return get_any_partial(s, pc);
>  }
>  
>  #ifdef CONFIG_PREEMPTION
> @@ -3022,6 +3027,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	void *freelist;
>  	struct slab *slab;
>  	unsigned long flags;
> +	struct partial_context pc;
>  
>  	stat(s, ALLOC_SLOWPATH);
>  
> @@ -3135,7 +3141,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  new_objects:
>  
> -	freelist = get_partial(s, gfpflags, node, &slab);
> +	pc.flags = gfpflags;
> +	pc.slab = &slab;
> +	pc.orig_size = orig_size;
> +	freelist = get_partial(s, node, &pc);
>  	if (freelist)
>  		goto check_new_slab;
>  
> @@ -3151,14 +3160,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	stat(s, ALLOC_SLAB);
>  
>  	if (kmem_cache_debug(s)) {
> -		freelist = alloc_single_from_new_slab(s, slab);
> +		freelist = alloc_single_from_new_slab(s, slab, orig_size);
>  
>  		if (unlikely(!freelist))
>  			goto new_objects;
>  
>  		if (s->flags & SLAB_STORE_USER)
>  			set_track(s, freelist, TRACK_ALLOC, addr);
> -		set_orig_size(s, freelist, orig_size);
>  
>  		return freelist;
>  	}
> @@ -3184,7 +3192,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		 */
>  		if (s->flags & SLAB_STORE_USER)
>  			set_track(s, freelist, TRACK_ALLOC, addr);
> -		set_orig_size(s, freelist, orig_size);
>  
>  		return freelist;
>  	}

-- 
Thanks,
Hyeonggon
