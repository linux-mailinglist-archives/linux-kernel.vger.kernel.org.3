Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60605843CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiG1QKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiG1QKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:10:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21074DFB9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:10:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1A094352D7;
        Thu, 28 Jul 2022 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659024568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ygSXEF9hwfxYtW/G9SDRcd+vvcRVRtOgi6bho0plc6g=;
        b=feu+DtnIvmaEpbbA70GLP2v0B/NY91ns+b5GlGMmonLkG4q/bOuDYIi+Mk9aMZr6iiBI4I
        bF+TpMsHkf1L8g86aEA9Iiix2s5SXQWKgDB7SpxDPJYdav6ybAeVk9S/dN++8WKFx9Z+62
        aJYylQH9VnIaicPTVFo7o3Vw5ZWEOaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659024568;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ygSXEF9hwfxYtW/G9SDRcd+vvcRVRtOgi6bho0plc6g=;
        b=YvU5jRxhAjQbDLTuZtwuxFCWUOdevnGVWYAIWFvccZbX/KWukTXLRXwZYfRxXK9wlXI+qT
        qQAENNSVB4OHIkCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC29713427;
        Thu, 28 Jul 2022 16:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RW/nNLe04mLkDAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 28 Jul 2022 16:09:27 +0000
Message-ID: <a26f9cb0-7781-3bdc-4536-0ac06f2483b1@suse.cz>
Date:   Thu, 28 Jul 2022 18:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 08/15] mm/slab_common: kmalloc_node: pass large
 requests to page allocator
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-9-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220712133946.307181-9-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 15:39, Hyeonggon Yoo wrote:
> Now that kmalloc_large_node() is in common code, pass large requests
> to page allocator in kmalloc_node() using kmalloc_large_node().
> 
> One problem is that currently there is no tracepoint in
> kmalloc_large_node(). Instead of simply putting tracepoint in it,
> use kmalloc_large_node{,_notrace} depending on its caller to show
> useful address for both inlined kmalloc_node() and
> __kmalloc_node_track_caller() when large objects are allocated.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> ---
>  v3:
> 	This patch is new in v3 and this avoids
> 	missing caller in __kmalloc_large_node_track_caller()
> 	when kmalloc_large_node() is called.
> 
>  include/linux/slab.h | 26 +++++++++++++++++++-------
>  mm/slab.h            |  2 ++
>  mm/slab_common.c     | 17 ++++++++++++++++-
>  mm/slub.c            |  2 +-
>  4 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 082499306098..fd2e129fc813 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -571,23 +571,35 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  	return __kmalloc(size, flags);
>  }
>  
> +#ifndef CONFIG_SLOB
>  static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
>  {
> -#ifndef CONFIG_SLOB
> -	if (__builtin_constant_p(size) &&
> -		size <= KMALLOC_MAX_CACHE_SIZE) {
> -		unsigned int i = kmalloc_index(size);
> +	if (__builtin_constant_p(size)) {
> +		unsigned int index;
>  
> -		if (!i)
> +		if (size > KMALLOC_MAX_CACHE_SIZE)
> +			return kmalloc_large_node(size, flags, node);
> +
> +		index = kmalloc_index(size);
> +
> +		if (!index)
>  			return ZERO_SIZE_PTR;
>  
>  		return kmem_cache_alloc_node_trace(
> -				kmalloc_caches[kmalloc_type(flags)][i],
> +				kmalloc_caches[kmalloc_type(flags)][index],
>  						flags, node, size);
>  	}
> -#endif
>  	return __kmalloc_node(size, flags, node);
>  }
> +#else
> +static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> +{
> +	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> +		return kmalloc_large_node(size, flags, node);
> +
> +	return __kmalloc_node(size, flags, node);
> +}
> +#endif
>  
>  /**
>   * kmalloc_array - allocate memory for an array.
> diff --git a/mm/slab.h b/mm/slab.h
> index a8d5eb1c323f..7cb51ff44f0c 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -273,6 +273,8 @@ void create_kmalloc_caches(slab_flags_t);
>  
>  /* Find the kmalloc slab corresponding for a certain size */
>  struct kmem_cache *kmalloc_slab(size_t, gfp_t);
> +
> +void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node);
>  #endif
>  
>  gfp_t kmalloc_fix_flags(gfp_t flags);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 6f855587b635..dc872e0ef0fc 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -956,7 +956,8 @@ void *kmalloc_large(size_t size, gfp_t flags)
>  }
>  EXPORT_SYMBOL(kmalloc_large);
>  
> -void *kmalloc_large_node(size_t size, gfp_t flags, int node)
> +static __always_inline

I don't think we need to inline, compiler should be able to make
kmalloc_large_node(_notrace) quite efficient anyway.

> +void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
>  {
>  	struct page *page;
>  	void *ptr = NULL;
> @@ -976,6 +977,20 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
>  
>  	return ptr;
>  }
> +
> +void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
> +{
> +	return __kmalloc_large_node_notrace(size, flags, node);
> +}
> +
> +void *kmalloc_large_node(size_t size, gfp_t flags, int node)
> +{
> +	void *ret = __kmalloc_large_node_notrace(size, flags, node);
> +
> +	trace_kmalloc_node(_RET_IP_, ret, NULL, size,
> +			   PAGE_SIZE << get_order(size), flags, node);
> +	return ret;
> +}
>  EXPORT_SYMBOL(kmalloc_large_node);
>  
>  #ifdef CONFIG_SLAB_FREELIST_RANDOM
> diff --git a/mm/slub.c b/mm/slub.c
> index f22a84dd27de..3d02cf44adf7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4401,7 +4401,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
>  	void *ret;
>  
>  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> -		ret = kmalloc_large_node(size, flags, node);
> +		ret = kmalloc_large_node_notrace(size, flags, node);
>  
>  		trace_kmalloc_node(caller, ret, NULL,
>  				   size, PAGE_SIZE << get_order(size),

