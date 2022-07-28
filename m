Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F3584213
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiG1OpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiG1OpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:45:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B4562D4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:45:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4CAE234A17;
        Thu, 28 Jul 2022 14:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659019504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KY9DxC1wYlMgzPMN5b8JyjCQ0UbOlFS6w/HjZwJbNSY=;
        b=frHDh4+kbvFHq6PYrGvFrkmhBgq5zRVCYBNCLVfQR8p2FzcQPlUrvgGdPVTyTPztiGmcN+
        ayGcXpE5+eM+J/WZnD5E9nIZ9ZYpwlb/Gj8D/NT1Nlcdb/VxSHP/sfLzhDGJZEWrGtZlVA
        spdR5tIgyiXQwdIjXnLoSP72NMVitIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659019504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KY9DxC1wYlMgzPMN5b8JyjCQ0UbOlFS6w/HjZwJbNSY=;
        b=/newD5UcADk7RWWfbOKX7rDKQeAzkijqbAj+YK+Ns4UQ6n+00kO+uX1Ll0IdBzJayyAOlh
        nDOvAcDZxpBt5xAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E09813A7E;
        Thu, 28 Jul 2022 14:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yb2vBvCg4mJnZwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 28 Jul 2022 14:45:04 +0000
Message-ID: <4fcd01a6-4a52-3389-3cd5-be8a17448892@suse.cz>
Date:   Thu, 28 Jul 2022 16:45:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 05/15] mm/sl[au]b: factor out __do_kmalloc_node()
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
 <20220712133946.307181-6-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220712133946.307181-6-42.hyeyoo@gmail.com>
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
> __kmalloc(), __kmalloc_node(), __kmalloc_node_track_caller()
> mostly do same job. Factor out common code into __do_kmalloc_node().
> 
> Note that this patch also fixes missing kasan_kmalloc() in SLUB's
> __kmalloc_node_track_caller().
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slab.c | 30 +----------------------
>  mm/slub.c | 71 +++++++++++++++----------------------------------------
>  2 files changed, 20 insertions(+), 81 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index da2f6a5dd8fa..ab34727d61b2 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3631,37 +3631,9 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  }
>  #endif
>  
> -/**
> - * __do_kmalloc - allocate memory
> - * @size: how many bytes of memory are required.
> - * @flags: the type of memory to allocate (see kmalloc).
> - * @caller: function caller for debug tracking of the caller
> - *
> - * Return: pointer to the allocated memory or %NULL in case of error
> - */
> -static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
> -					  unsigned long caller)
> -{
> -	struct kmem_cache *cachep;
> -	void *ret;
> -
> -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> -		return NULL;
> -	cachep = kmalloc_slab(size, flags);
> -	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
> -		return cachep;
> -	ret = slab_alloc(cachep, NULL, flags, size, caller);
> -
> -	ret = kasan_kmalloc(cachep, ret, size, flags);
> -	trace_kmalloc(caller, ret, cachep,
> -		      size, cachep->size, flags);
> -
> -	return ret;
> -}
> -
>  void *__kmalloc(size_t size, gfp_t flags)
>  {
> -	return __do_kmalloc(size, flags, _RET_IP_);
> +	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__kmalloc);
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index 7c284535a62b..2ccc473e0ae7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4402,29 +4402,6 @@ static int __init setup_slub_min_objects(char *str)
>  
>  __setup("slub_min_objects=", setup_slub_min_objects);
>  
> -void *__kmalloc(size_t size, gfp_t flags)
> -{
> -	struct kmem_cache *s;
> -	void *ret;
> -
> -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> -		return kmalloc_large(size, flags);
> -
> -	s = kmalloc_slab(size, flags);
> -
> -	if (unlikely(ZERO_OR_NULL_PTR(s)))
> -		return s;
> -
> -	ret = slab_alloc(s, NULL, flags, _RET_IP_, size);
> -
> -	trace_kmalloc(_RET_IP_, ret, s, size, s->size, flags);
> -
> -	ret = kasan_kmalloc(s, ret, size, flags);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL(__kmalloc);
> -
>  static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
>  {
>  	struct page *page;
> @@ -4442,7 +4419,8 @@ static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
>  	return kmalloc_large_node_hook(ptr, size, flags);
>  }
>  
> -void *__kmalloc_node(size_t size, gfp_t flags, int node)
> +static __always_inline
> +void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
>  {
>  	struct kmem_cache *s;
>  	void *ret;
> @@ -4450,7 +4428,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
>  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
>  		ret = kmalloc_large_node(size, flags, node);
>  
> -		trace_kmalloc_node(_RET_IP_, ret, NULL,
> +		trace_kmalloc_node(caller, ret, NULL,
>  				   size, PAGE_SIZE << get_order(size),
>  				   flags, node);
>  
> @@ -4462,16 +4440,28 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
>  	if (unlikely(ZERO_OR_NULL_PTR(s)))
>  		return s;
>  
> -	ret = slab_alloc_node(s, NULL, flags, node, _RET_IP_, size);
> +	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
>  
> -	trace_kmalloc_node(_RET_IP_, ret, s, size, s->size, flags, node);
> +	trace_kmalloc_node(caller, ret, s, size, s->size, flags, node);
>  
>  	ret = kasan_kmalloc(s, ret, size, flags);
>  
>  	return ret;
>  }
> +
> +void *__kmalloc_node(size_t size, gfp_t flags, int node)
> +{
> +	return __do_kmalloc_node(size, flags, node, _RET_IP_);
> +}
>  EXPORT_SYMBOL(__kmalloc_node);
>  
> +void *__kmalloc(size_t size, gfp_t flags)
> +{
> +	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
> +}
> +EXPORT_SYMBOL(__kmalloc);
> +
> +
>  #ifdef CONFIG_HARDENED_USERCOPY
>  /*
>   * Rejects incorrectly sized objects and objects that are to be copied
> @@ -4905,32 +4895,9 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
>  }
>  
>  void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
> -					int node, unsigned long caller)
> +				  int node, unsigned long caller)
>  {
> -	struct kmem_cache *s;
> -	void *ret;
> -
> -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> -		ret = kmalloc_large_node(size, gfpflags, node);
> -
> -		trace_kmalloc_node(caller, ret, NULL,
> -				   size, PAGE_SIZE << get_order(size),
> -				   gfpflags, node);
> -
> -		return ret;
> -	}
> -
> -	s = kmalloc_slab(size, gfpflags);
> -
> -	if (unlikely(ZERO_OR_NULL_PTR(s)))
> -		return s;
> -
> -	ret = slab_alloc_node(s, NULL, gfpflags, node, caller, size);
> -
> -	/* Honor the call site pointer we received. */
> -	trace_kmalloc_node(caller, ret, s, size, s->size, gfpflags, node);
> -
> -	return ret;
> +	return __do_kmalloc_node(size, gfpflags, node, caller);
>  }
>  EXPORT_SYMBOL(__kmalloc_node_track_caller);
>  

