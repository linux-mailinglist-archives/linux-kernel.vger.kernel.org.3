Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07774CD46E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiCDMqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiCDMqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:46:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540DB1A9492
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:45:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 05F281F384;
        Fri,  4 Mar 2022 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646397917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZYPJrcaqOXDz/VpGYnhoLHXX9rrhF9I8siw09y0Bi4=;
        b=CnERUz/QCVywcbm20lQhidrM9z7/XyY4vBGfq3Prcaly+BsYs26cTL3l1lMXKZs0c9CgwB
        TH8Fi80YtLqbsBtPizZaS0WqGzJP83XiU98wJY2MEuS+nwz/Ev/mqt0uNx1S9kjD3u8PhR
        CEwjyU0jj8yUBP0SvIHDDMHHN9+iFDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646397917;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZYPJrcaqOXDz/VpGYnhoLHXX9rrhF9I8siw09y0Bi4=;
        b=1sCsUwoSRCvh2DTmAWVn3YuTBd8VzW9VR1WJGLK9aY82tEBUudGpxvYehFSW6jynHmiBuw
        YRWzukoHMhQEjkCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF67913CC8;
        Fri,  4 Mar 2022 12:45:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lLfQMdwJImIrYAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 04 Mar 2022 12:45:16 +0000
Message-ID: <213a7412-5439-2e8a-986f-6836f3976432@suse.cz>
Date:   Fri, 4 Mar 2022 13:45:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
 <20220304063427.372145-2-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 1/5] mm/slab: kmalloc: pass requests larger than
 order-1 page to page allocator
In-Reply-To: <20220304063427.372145-2-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 07:34, Hyeonggon Yoo wrote:
> There is not much benefit for serving large objects in kmalloc().
> Let's pass large requests to page allocator like SLUB for better
> maintenance of common code.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Looks like it's on the right path! Some suggestions follow.

> ---
>  include/linux/slab.h | 35 ++++++++++++++++-------------------
>  mm/slab.c            | 31 +++++++++++++++++++++++++++----
>  mm/slab.h            | 19 +++++++++++++++++++
>  mm/slub.c            | 19 -------------------
>  4 files changed, 62 insertions(+), 42 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 37bde99b74af..e7b3330db4f3 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -224,29 +224,19 @@ void kmem_dump_obj(void *object);
>   * Kmalloc array related definitions
>   */
>  
> -#ifdef CONFIG_SLAB
>  /*
> - * The largest kmalloc size supported by the SLAB allocators is
> - * 32 megabyte (2^25) or the maximum allocatable page order if that is
> - * less than 32 MB.
> - *
> - * WARNING: Its not easy to increase this value since the allocators have
> - * to do various tricks to work around compiler limitations in order to
> - * ensure proper constant folding.
> + * SLAB and SLUB directly allocates requests fitting in to an order-1 page
> + * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
>   */
> -#define KMALLOC_SHIFT_HIGH	((MAX_ORDER + PAGE_SHIFT - 1) <= 25 ? \
> -				(MAX_ORDER + PAGE_SHIFT - 1) : 25)
> -#define KMALLOC_SHIFT_MAX	KMALLOC_SHIFT_HIGH
> +#ifdef CONFIG_SLAB
> +#define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> +#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)

I think we should be able to also remove the larger sizes from
__kmalloc_index() later in this file.

>  #ifndef KMALLOC_SHIFT_LOW
>  #define KMALLOC_SHIFT_LOW	5
>  #endif
>  #endif
>  
>  #ifdef CONFIG_SLUB
> -/*
> - * SLUB directly allocates requests fitting in to an order-1 page
> - * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
> - */
>  #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
>  #define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
>  #ifndef KMALLOC_SHIFT_LOW
> @@ -564,15 +554,15 @@ static __always_inline __alloc_size(1) void *kmalloc_large(size_t size, gfp_t fl
>   *	Try really hard to succeed the allocation but fail
>   *	eventually.
>   */
> +#ifndef CONFIG_SLOB
>  static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  {
>  	if (__builtin_constant_p(size)) {
> -#ifndef CONFIG_SLOB
>  		unsigned int index;
> -#endif
> +
>  		if (size > KMALLOC_MAX_CACHE_SIZE)
>  			return kmalloc_large(size, flags);
> -#ifndef CONFIG_SLOB
> +
>  		index = kmalloc_index(size);
>  
>  		if (!index)
> @@ -581,10 +571,17 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  		return kmem_cache_alloc_trace(
>  				kmalloc_caches[kmalloc_type(flags)][index],
>  				flags, size);
> -#endif
>  	}
>  	return __kmalloc(size, flags);
>  }
> +#else
> +static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
> +{
> +	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> +		return kmalloc_large(size, flags);
> +	return __kmalloc(size, flags);
> +}
> +#endif
>  
>  static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
>  {
> diff --git a/mm/slab.c b/mm/slab.c
> index ddf5737c63d9..570af6dc3478 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3624,7 +3624,8 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
>  	void *ret;
>  
>  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> -		return NULL;
> +		return kmalloc_large(size, flags);

This loses the node information and NUMA locality. It would be better to
generalize kmalloc_large_node() from mm/slub.c instead.

> +
>  	cachep = kmalloc_slab(size, flags);
>  	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
>  		return cachep;
> @@ -3685,7 +3686,8 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
>  	void *ret;
>  
>  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> -		return NULL;
> +		return kmalloc_large(size, flags);
> +
>  	cachep = kmalloc_slab(size, flags);
>  	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
>  		return cachep;
> @@ -3739,14 +3741,21 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
>  {
>  	struct kmem_cache *s;
>  	size_t i;
> +	struct folio *folio;
>  
>  	local_irq_disable();
>  	for (i = 0; i < size; i++) {
>  		void *objp = p[i];
>  
> -		if (!orig_s) /* called via kfree_bulk */
> +		if (!orig_s) {
> +			/* called via kfree_bulk */
> +			folio = virt_to_folio(objp);
> +			if (unlikely(!folio_test_slab(folio))) {
> +				free_large_kmalloc(folio, objp);

Hmm I'm not sure it's a good idea to call this and the page allocator with
disabled irq's. Maybe simply re-enable around it?

> +				continue;
> +			}
>  			s = virt_to_cache(objp);

Since we already have the folio, we shoold instead use folio_slab and
slab->slab_cache (see how mm/slub.c does it).
The same applies to functions below as well.

> -		else
> +		} else
>  			s = cache_from_obj(orig_s, objp);
>  		if (!s)
>  			continue;
> @@ -3776,11 +3785,20 @@ void kfree(const void *objp)
>  {
>  	struct kmem_cache *c;
>  	unsigned long flags;
> +	struct folio *folio;
> +	void *object = (void *) objp;
>  
>  	trace_kfree(_RET_IP_, objp);
>  
>  	if (unlikely(ZERO_OR_NULL_PTR(objp)))
>  		return;
> +
> +	folio = virt_to_folio(objp);
> +	if (unlikely(!folio_test_slab(folio))) {
> +		free_large_kmalloc(folio, object);
> +		return;
> +	}
> +
>  	local_irq_save(flags);
>  	kfree_debugcheck(objp);
>  	c = virt_to_cache(objp);
> @@ -4211,12 +4229,17 @@ void __check_heap_object(const void *ptr, unsigned long n,
>  size_t __ksize(const void *objp)
>  {
>  	struct kmem_cache *c;
> +	struct folio *folio;
>  	size_t size;
>  
>  	BUG_ON(!objp);
>  	if (unlikely(objp == ZERO_SIZE_PTR))
>  		return 0;
>  
> +	folio = virt_to_folio(objp);
> +	if (!folio_test_slab(folio))
> +		return folio_size(folio);
> +
>  	c = virt_to_cache(objp);
>  	size = c ? c->object_size : 0;
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index c7f2abc2b154..31e98beb47a3 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -664,6 +664,25 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>  		print_tracking(cachep, x);
>  	return cachep;
>  }
> +
> +static __always_inline void kfree_hook(void *x)
> +{
> +	kmemleak_free(x);
> +	kasan_kfree_large(x);

Looks like there's only one caller of kfree_hook() so we could do that
directly there.

> +}
> +
> +static inline void free_large_kmalloc(struct folio *folio, void *object)
> +{
> +	unsigned int order = folio_order(folio);
> +
> +	if (WARN_ON_ONCE(order == 0))
> +		pr_warn_once("object pointer: 0x%p\n", object);
> +
> +	kfree_hook(object);
> +	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
> +			      -(PAGE_SIZE << order));
> +	__free_pages(folio_page(folio, 0), order);
> +}
>  #endif /* CONFIG_SLOB */
>  
>  static inline size_t slab_ksize(const struct kmem_cache *s)
> diff --git a/mm/slub.c b/mm/slub.c
> index 261474092e43..04fd084f4709 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1686,12 +1686,6 @@ static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
>  	return ptr;
>  }
>  
> -static __always_inline void kfree_hook(void *x)
> -{
> -	kmemleak_free(x);
> -	kasan_kfree_large(x);
> -}
> -
>  static __always_inline bool slab_free_hook(struct kmem_cache *s,
>  						void *x, bool init)
>  {
> @@ -3535,19 +3529,6 @@ struct detached_freelist {
>  	struct kmem_cache *s;
>  };
>  
> -static inline void free_large_kmalloc(struct folio *folio, void *object)
> -{
> -	unsigned int order = folio_order(folio);
> -
> -	if (WARN_ON_ONCE(order == 0))
> -		pr_warn_once("object pointer: 0x%p\n", object);
> -
> -	kfree_hook(object);
> -	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
> -			      -(PAGE_SIZE << order));
> -	__free_pages(folio_page(folio, 0), order);
> -}
> -
>  /*
>   * This function progressively scans the array with free objects (with
>   * a limited look ahead) and extract objects belonging to the same

