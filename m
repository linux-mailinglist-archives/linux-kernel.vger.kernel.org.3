Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE1C584EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiG2KZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiG2KZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:25:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7425382F86
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:25:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C367A20132;
        Fri, 29 Jul 2022 10:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659090302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KTYwBoclDsntTpBY3mpAC97h8nm3hEyYfkY3eKqUms=;
        b=WrPg6fP9BfrTXQ2SrZHBlwK7GkBqe8cjDsuBa6qU89KqcevxL2v7QuPdk+XN1cYrU6g3xk
        bvK8kdpWYi2YVovDdjSkF4Mcyeealu0eGmhoe/EYeWd3SXJRZwf+G9xWek+pJzM2jt2CKI
        06UhWtJx08pVY2dZElXbiNuh5VORVQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659090302;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KTYwBoclDsntTpBY3mpAC97h8nm3hEyYfkY3eKqUms=;
        b=HxqjQaoBCXUtUhteWYjAzbGQXgqpXmthB0h9z3swugdsmv09SY4AdfojWDZ+DNj9+ALhQ4
        S19sND2zo4XduDCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88A3613A8E;
        Fri, 29 Jul 2022 10:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F396IH6142JWfAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Jul 2022 10:25:02 +0000
Message-ID: <790134e2-6e07-61de-a522-96dcf9e2f0f9@suse.cz>
Date:   Fri, 29 Jul 2022 12:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 12/15] mm/sl[au]b: generalize kmalloc subsystem
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
 <20220712133946.307181-13-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220712133946.307181-13-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 15:39, Hyeonggon Yoo wrote:
> Now everything in kmalloc subsystem can be generalized.
> Let's do it!
> 
> Generalize __do_kmalloc_node(), __kmalloc_node_track_caller(),
> kfree(), __ksize(), __kmalloc(), __kmalloc_node() and move them
> to slab_common.c.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slab.c        | 108 -----------------------------------------------
>  mm/slab_common.c | 102 ++++++++++++++++++++++++++++++++++++++++++++
>  mm/slub.c        |  87 --------------------------------------
>  3 files changed, 102 insertions(+), 195 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 375e35c14430..6407dad13d5c 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3587,44 +3587,6 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
>  EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
>  #endif
>  
> -static __always_inline void *
> -__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
> -{
> -	struct kmem_cache *cachep;
> -	void *ret;
> -
> -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> -		ret = kmalloc_large_node_notrace(size, flags, node);
> -
> -		trace_kmalloc_node(caller, ret, NULL, size,
> -				   PAGE_SIZE << get_order(size),
> -				   flags, node);
> -		return ret;
> -	}
> -
> -	cachep = kmalloc_slab(size, flags);
> -	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
> -		return cachep;
> -
> -	ret = kmem_cache_alloc_node_trace(cachep, flags, node, size);
> -	ret = kasan_kmalloc(cachep, ret, size, flags);
> -
> -	return ret;
> -}
> -
> -void *__kmalloc_node(size_t size, gfp_t flags, int node)
> -{
> -	return __do_kmalloc_node(size, flags, node, _RET_IP_);
> -}
> -EXPORT_SYMBOL(__kmalloc_node);
> -
> -void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
> -		int node, unsigned long caller)
> -{
> -	return __do_kmalloc_node(size, flags, node, caller);
> -}
> -EXPORT_SYMBOL(__kmalloc_node_track_caller);
> -
>  #ifdef CONFIG_PRINTK
>  void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  {
> @@ -3647,12 +3609,6 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  }
>  #endif
>  
> -void *__kmalloc(size_t size, gfp_t flags)
> -{
> -	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
> -}
> -EXPORT_SYMBOL(__kmalloc);
> -
>  static __always_inline
>  void __do_kmem_cache_free(struct kmem_cache *cachep, void *objp,
>  			  unsigned long caller)
> @@ -3730,43 +3686,6 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
>  }
>  EXPORT_SYMBOL(kmem_cache_free_bulk);
>  
> -/**
> - * kfree - free previously allocated memory
> - * @objp: pointer returned by kmalloc.
> - *
> - * If @objp is NULL, no operation is performed.
> - *
> - * Don't free memory not originally allocated by kmalloc()
> - * or you will run into trouble.
> - */
> -void kfree(const void *objp)
> -{
> -	struct kmem_cache *c;
> -	unsigned long flags;
> -	struct folio *folio;
> -
> -	trace_kfree(_RET_IP_, objp);
> -
> -	if (unlikely(ZERO_OR_NULL_PTR(objp)))
> -		return;
> -
> -	folio = virt_to_folio(objp);
> -	if (!folio_test_slab(folio)) {
> -		free_large_kmalloc(folio, (void *)objp);
> -		return;
> -	}
> -
> -	c = folio_slab(folio)->slab_cache;
> -
> -	local_irq_save(flags);
> -	kfree_debugcheck(objp);
> -	debug_check_no_locks_freed(objp, c->object_size);
> -	debug_check_no_obj_freed(objp, c->object_size);
> -	__cache_free(c, (void *)objp, _RET_IP_);
> -	local_irq_restore(flags);
> -}
> -EXPORT_SYMBOL(kfree);
> -
>  /*
>   * This initializes kmem_cache_node or resizes various caches for all nodes.
>   */
> @@ -4169,30 +4088,3 @@ void __check_heap_object(const void *ptr, unsigned long n,
>  	usercopy_abort("SLAB object", cachep->name, to_user, offset, n);
>  }
>  #endif /* CONFIG_HARDENED_USERCOPY */
> -
> -/**
> - * __ksize -- Uninstrumented ksize.
> - * @objp: pointer to the object
> - *
> - * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
> - * safety checks as ksize() with KASAN instrumentation enabled.
> - *
> - * Return: size of the actual memory used by @objp in bytes
> - */
> -size_t __ksize(const void *objp)
> -{
> -	struct kmem_cache *c;
> -	struct folio *folio;
> -
> -	BUG_ON(!objp);
> -	if (unlikely(objp == ZERO_SIZE_PTR))
> -		return 0;
> -
> -	folio = virt_to_folio(objp);
> -	if (!folio_test_slab(folio))
> -		return folio_size(folio);
> -
> -	c = folio_slab(folio)->slab_cache;
> -	return c->object_size;
> -}
> -EXPORT_SYMBOL(__ksize);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 0dff46fb7193..1000e05c77df 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -924,6 +924,108 @@ void free_large_kmalloc(struct folio *folio, void *object)
>  			      -(PAGE_SIZE << order));
>  	__free_pages(folio_page(folio, 0), order);
>  }
> +
> +static __always_inline
> +void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
> +{
> +	struct kmem_cache *s;
> +	void *ret;
> +
> +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> +		ret = kmalloc_large_node_notrace(size, flags, node);
> +		trace_kmalloc_node(caller, ret, NULL,
> +				   size, PAGE_SIZE << get_order(size),
> +				   flags, node);
> +		return ret;
> +	}
> +
> +	s = kmalloc_slab(size, flags);
> +
> +	if (unlikely(ZERO_OR_NULL_PTR(s)))
> +		return s;
> +
> +	ret = __kmem_cache_alloc_node(s, flags, node, size, caller);
> +	ret = kasan_kmalloc(s, ret, size, flags);
> +	trace_kmalloc_node(caller, ret, s, size,
> +			   s->size, flags, node);
> +	return ret;
> +}
> +
> +void *__kmalloc_node(size_t size, gfp_t flags, int node)
> +{
> +	return __do_kmalloc_node(size, flags, node, _RET_IP_);
> +}
> +EXPORT_SYMBOL(__kmalloc_node);
> +
> +void *__kmalloc(size_t size, gfp_t flags)
> +{
> +	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
> +}
> +EXPORT_SYMBOL(__kmalloc);
> +
> +void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
> +				  int node, unsigned long caller)
> +{
> +	return __do_kmalloc_node(size, flags, node, caller);
> +}
> +EXPORT_SYMBOL(__kmalloc_node_track_caller);
> +
> +/**
> + * kfree - free previously allocated memory
> + * @objp: pointer returned by kmalloc.
> + *
> + * If @objp is NULL, no operation is performed.
> + *
> + * Don't free memory not originally allocated by kmalloc()
> + * or you will run into trouble.
> + */
> +void kfree(const void *object)
> +{
> +	struct folio *folio;
> +	struct slab *slab;
> +	struct kmem_cache *s;
> +
> +	trace_kfree(_RET_IP_, object);
> +
> +	if (unlikely(ZERO_OR_NULL_PTR(object)))
> +		return;
> +
> +	folio = virt_to_folio(object);
> +	if (unlikely(!folio_test_slab(folio))) {
> +		free_large_kmalloc(folio, (void *)object);
> +		return;
> +	}
> +
> +	slab = folio_slab(folio);
> +	s = slab->slab_cache;
> +	__kmem_cache_free(s, (void *)object, _RET_IP_);
> +}
> +EXPORT_SYMBOL(kfree);
> +
> +/**
> + * __ksize -- Uninstrumented ksize.
> + * @objp: pointer to the object
> + *
> + * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
> + * safety checks as ksize() with KASAN instrumentation enabled.
> + *
> + * Return: size of the actual memory used by @objp in bytes
> + */
> +size_t __ksize(const void *object)
> +{
> +	struct folio *folio;
> +
> +	if (unlikely(object == ZERO_SIZE_PTR))
> +		return 0;
> +
> +	folio = virt_to_folio(object);
> +
> +	if (unlikely(!folio_test_slab(folio)))
> +		return folio_size(folio);
> +
> +	return slab_ksize(folio_slab(folio)->slab_cache);
> +}
> +EXPORT_SYMBOL(__ksize);
>  #endif /* !CONFIG_SLOB */
>  
>  gfp_t kmalloc_fix_flags(gfp_t flags)
> diff --git a/mm/slub.c b/mm/slub.c
> index 74eb78678c98..836292c32e58 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4388,49 +4388,6 @@ static int __init setup_slub_min_objects(char *str)
>  
>  __setup("slub_min_objects=", setup_slub_min_objects);
>  
> -static __always_inline
> -void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
> -{
> -	struct kmem_cache *s;
> -	void *ret;
> -
> -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> -		ret = kmalloc_large_node_notrace(size, flags, node);
> -
> -		trace_kmalloc_node(caller, ret, NULL,
> -				   size, PAGE_SIZE << get_order(size),
> -				   flags, node);
> -
> -		return ret;
> -	}
> -
> -	s = kmalloc_slab(size, flags);
> -
> -	if (unlikely(ZERO_OR_NULL_PTR(s)))
> -		return s;
> -
> -	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
> -
> -	trace_kmalloc_node(caller, ret, s, size, s->size, flags, node);
> -
> -	ret = kasan_kmalloc(s, ret, size, flags);
> -
> -	return ret;
> -}
> -
> -void *__kmalloc_node(size_t size, gfp_t flags, int node)
> -{
> -	return __do_kmalloc_node(size, flags, node, _RET_IP_);
> -}
> -EXPORT_SYMBOL(__kmalloc_node);
> -
> -void *__kmalloc(size_t size, gfp_t flags)
> -{
> -	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
> -}
> -EXPORT_SYMBOL(__kmalloc);
> -
> -
>  #ifdef CONFIG_HARDENED_USERCOPY
>  /*
>   * Rejects incorrectly sized objects and objects that are to be copied
> @@ -4481,43 +4438,6 @@ void __check_heap_object(const void *ptr, unsigned long n,
>  }
>  #endif /* CONFIG_HARDENED_USERCOPY */
>  
> -size_t __ksize(const void *object)
> -{
> -	struct folio *folio;
> -
> -	if (unlikely(object == ZERO_SIZE_PTR))
> -		return 0;
> -
> -	folio = virt_to_folio(object);
> -
> -	if (unlikely(!folio_test_slab(folio)))
> -		return folio_size(folio);
> -
> -	return slab_ksize(folio_slab(folio)->slab_cache);
> -}
> -EXPORT_SYMBOL(__ksize);
> -
> -void kfree(const void *x)
> -{
> -	struct folio *folio;
> -	struct slab *slab;
> -	void *object = (void *)x;
> -
> -	trace_kfree(_RET_IP_, x);
> -
> -	if (unlikely(ZERO_OR_NULL_PTR(x)))
> -		return;
> -
> -	folio = virt_to_folio(x);
> -	if (unlikely(!folio_test_slab(folio))) {
> -		free_large_kmalloc(folio, object);
> -		return;
> -	}
> -	slab = folio_slab(folio);
> -	slab_free(slab->slab_cache, slab, object, NULL, &object, 1, _RET_IP_);
> -}
> -EXPORT_SYMBOL(kfree);
> -
>  #define SHRINK_PROMOTE_MAX 32
>  
>  /*
> @@ -4863,13 +4783,6 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
>  	return 0;
>  }
>  
> -void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
> -				  int node, unsigned long caller)
> -{
> -	return __do_kmalloc_node(size, gfpflags, node, caller);
> -}
> -EXPORT_SYMBOL(__kmalloc_node_track_caller);
> -
>  #ifdef CONFIG_SYSFS
>  static int count_inuse(struct slab *slab)
>  {

