Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A505112DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359079AbiD0HxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355362AbiD0HxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:53:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E144B1AE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:50:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 776451F388;
        Wed, 27 Apr 2022 07:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651045807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kxxxl2TtXOCLuSXvdWAbnDA2qxppOwNOidqVh0cnl+o=;
        b=QmEJI6UfoXI6u4hyUgkydkyLKv/vRxCkhgqHV+ipfuYwPlWVtpp5sk5ZuKZEeI17waX5sJ
        RsKGrsRJwNXnxpVckfXjy71RtNrjj1nzUTd0M8sQcWBDP7iNH0r6dz+TsA8ovrGfQS92ct
        YB+vrGS+o3j7OtN94YrLs/NLNQ1rjlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651045807;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kxxxl2TtXOCLuSXvdWAbnDA2qxppOwNOidqVh0cnl+o=;
        b=rrvC7IZVjcIEjIq8lI/XJM9Np8JSWNkJcLEug4ygmLiGdwCYHQp8m630PgDbSKMB3Sz1tm
        n8pV3XFLAvy6qaBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45AEA13A39;
        Wed, 27 Apr 2022 07:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9bkxEK/1aGLrMgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 27 Apr 2022 07:50:07 +0000
Message-ID: <29e86c84-c0c2-e846-acb3-5cf8bd703885@suse.cz>
Date:   Wed, 27 Apr 2022 09:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 12/23] mm/slab_common: cleanup kmalloc()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-13-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220414085727.643099-13-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 10:57, Hyeonggon Yoo wrote:
> Now that kmalloc() and kmalloc_node() do same job, make kmalloc()
> wrapper of kmalloc_node().
> 
> Remove kmem_cache_alloc_trace() that is now unused.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

From correctness point of view:

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

But yeah, impact of requiring NUMA_NO_NODE parameter should be evaluated. If
it's significant I believe we should be still able to implement the common
kmalloc, but keep separate kmalloc and kmalloc_node entry points.

> ---
>  include/linux/slab.h | 93 +++++++++++++++-----------------------------
>  mm/slab.c            | 16 --------
>  mm/slub.c            | 12 ------
>  3 files changed, 32 insertions(+), 89 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index eb457f20f415..ea168f8a248d 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -497,23 +497,10 @@ static __always_inline void kfree_bulk(size_t size, void **p)
>  }
>  
>  #ifdef CONFIG_TRACING
> -extern void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
> -				   __assume_slab_alignment __alloc_size(3);
> -
>  extern void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
>  					 int node, size_t size) __assume_slab_alignment
>  								__alloc_size(4);
> -
>  #else /* CONFIG_TRACING */
> -static __always_inline __alloc_size(3) void *kmem_cache_alloc_trace(struct kmem_cache *s,
> -								    gfp_t flags, size_t size)
> -{
> -	void *ret = kmem_cache_alloc(s, flags);
> -
> -	ret = kasan_kmalloc(s, ret, size, flags);
> -	return ret;
> -}
> -
>  static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
>  							 int node, size_t size)
>  {
> @@ -532,6 +519,37 @@ static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
>  	return kmalloc_large_node(size, flags, NUMA_NO_NODE);
>  }
>  
> +#ifndef CONFIG_SLOB
> +static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> +{
> +	if (__builtin_constant_p(size)) {
> +		unsigned int index;
> +
> +		if (size > KMALLOC_MAX_CACHE_SIZE)
> +			return kmalloc_large_node(size, flags, node);
> +
> +		index = kmalloc_index(size);
> +
> +		if (!index)
> +			return ZERO_SIZE_PTR;
> +
> +		return kmem_cache_alloc_node_trace(
> +				kmalloc_caches[kmalloc_type(flags)][index],
> +						flags, node, size);
> +	}
> +	return __kmalloc_node(size, flags, node);
> +}
> +#else
> +static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> +{
> +	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> +		return kmalloc_large_node(size, flags, node);
> +
> +	return __kmalloc_node(size, flags, node);
> +}
> +#endif
> +
> +
>  /**
>   * kmalloc - allocate memory
>   * @size: how many bytes of memory are required.
> @@ -588,55 +606,8 @@ static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
>   */
>  static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  {
> -	if (__builtin_constant_p(size)) {
> -#ifndef CONFIG_SLOB
> -		unsigned int index;
> -#endif
> -		if (size > KMALLOC_MAX_CACHE_SIZE)
> -			return kmalloc_large(size, flags);
> -#ifndef CONFIG_SLOB
> -		index = kmalloc_index(size);
> -
> -		if (!index)
> -			return ZERO_SIZE_PTR;
> -
> -		return kmem_cache_alloc_trace(
> -				kmalloc_caches[kmalloc_type(flags)][index],
> -				flags, size);
> -#endif
> -	}
> -	return __kmalloc(size, flags);
> -}
> -
> -#ifndef CONFIG_SLOB
> -static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> -{
> -	if (__builtin_constant_p(size)) {
> -		unsigned int index;
> -
> -		if (size > KMALLOC_MAX_CACHE_SIZE)
> -			return kmalloc_large_node(size, flags, node);
> -
> -		index = kmalloc_index(size);
> -
> -		if (!index)
> -			return ZERO_SIZE_PTR;
> -
> -		return kmem_cache_alloc_node_trace(
> -				kmalloc_caches[kmalloc_type(flags)][index],
> -						flags, node, size);
> -	}
> -	return __kmalloc_node(size, flags, node);
> -}
> -#else
> -static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> -{
> -	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> -		return kmalloc_large_node(size, flags, node);
> -
> -	return __kmalloc_node(size, flags, node);
> +	return kmalloc_node(size, flags, NUMA_NO_NODE);
>  }
> -#endif
>  
>  /**
>   * kmalloc_array - allocate memory for an array.
> diff --git a/mm/slab.c b/mm/slab.c
> index c5ffe54c207a..b0aaca017f42 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3507,22 +3507,6 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_bulk);
>  
> -#ifdef CONFIG_TRACING
> -void *
> -kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
> -{
> -	void *ret;
> -
> -	ret = slab_alloc(cachep, NULL, flags, size, _RET_IP_);
> -
> -	ret = kasan_kmalloc(cachep, ret, size, flags);
> -	trace_kmalloc(_RET_IP_, ret,
> -		      size, cachep->size, flags);
> -	return ret;
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc_trace);
> -#endif
> -
>  #ifdef CONFIG_TRACING
>  void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
>  				  gfp_t flags,
> diff --git a/mm/slub.c b/mm/slub.c
> index 2a2be2a8a5d0..892988990da7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3216,18 +3216,6 @@ static __always_inline void *slab_alloc(struct kmem_cache *s, struct list_lru *l
>  	return slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, addr, orig_size);
>  }
>  
> -
> -#ifdef CONFIG_TRACING
> -void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
> -{
> -	void *ret = slab_alloc(s, NULL, gfpflags, _RET_IP_, size);
> -	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags);
> -	ret = kasan_kmalloc(s, ret, size, gfpflags);
> -	return ret;
> -}
> -EXPORT_SYMBOL(kmem_cache_alloc_trace);
> -#endif
> -
>  void *__kmem_cache_alloc_node(struct kmem_cache *s, struct list_lru *lru, gfp_t gfpflags,
>  			      int node, unsigned long caller __maybe_unused)
>  {

