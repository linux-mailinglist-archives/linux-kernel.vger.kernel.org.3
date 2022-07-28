Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0617584418
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiG1QZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiG1QZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:25:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640BB41D35
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:25:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D3B191FCE8;
        Thu, 28 Jul 2022 16:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659025532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+yDvkvO1LrhCtlYn0Us2/OKAazCdAc1K8vfL7W0P8c=;
        b=bk3bCaroVFfJRl/E0lvzeWzSqSILQw1RLgKEGy4LZozJ7MHtbqHpdOXg1F8z6SB8DRJHfT
        3qfTxbTkZz5x2KJvPqZZs5dUX7wSSC2To9mytMYpoMX3E9RsooeFoPpvG2Fi9Bg2UV4Ek6
        LOqj6rTqU2urzxqOKgdZHtuDWmNV2js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659025532;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+yDvkvO1LrhCtlYn0Us2/OKAazCdAc1K8vfL7W0P8c=;
        b=cMPpOIRcRK9UzsbBE9dQJKKCgw3HbXNbqCWeTW/MWxm6ehS1Q/w6rYPrQ9kfLj+rUJ4QtU
        Yuaf3nVD3FcxAVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A33F813427;
        Thu, 28 Jul 2022 16:25:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hwItJ3y44mJLEwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 28 Jul 2022 16:25:32 +0000
Message-ID: <aaa690d3-2de8-e95e-59a0-8aa5431b1965@suse.cz>
Date:   Thu, 28 Jul 2022 18:25:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 10/15] mm/slab: kmalloc: pass requests larger than
 order-1 page to page allocator
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
 <20220712133946.307181-11-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220712133946.307181-11-42.hyeyoo@gmail.com>
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
> There is not much benefit for serving large objects in kmalloc().
> Let's pass large requests to page allocator like SLUB for better
> maintenance of common code.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> v2->v3: 
> 	This patch is basically same but it now depends on
> 	kmalloc_large_node_notrace().
> 
>  include/linux/slab.h | 23 ++++-------------
>  mm/slab.c            | 60 +++++++++++++++++++++++++++++++-------------
>  mm/slab.h            |  3 +++
>  mm/slab_common.c     | 25 ++++++++++++------
>  mm/slub.c            | 19 --------------
>  5 files changed, 68 insertions(+), 62 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index fd2e129fc813..4ee5b2fed164 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -243,27 +243,17 @@ static inline unsigned int arch_slab_minalign(void)
>  
>  #ifdef CONFIG_SLAB
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
> +#define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> +#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
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
> @@ -415,10 +405,6 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>  	if (size <= 512 * 1024) return 19;
>  	if (size <= 1024 * 1024) return 20;
>  	if (size <=  2 * 1024 * 1024) return 21;
> -	if (size <=  4 * 1024 * 1024) return 22;
> -	if (size <=  8 * 1024 * 1024) return 23;
> -	if (size <=  16 * 1024 * 1024) return 24;
> -	if (size <=  32 * 1024 * 1024) return 25;
>  
>  	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
>  		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> @@ -428,6 +414,7 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>  	/* Will never be reached. Needed because the compiler may complain */
>  	return -1;
>  }
> +static_assert(PAGE_SHIFT <= 20);
>  #define kmalloc_index(s) __kmalloc_index(s, true)
>  #endif /* !CONFIG_SLOB */
>  
> diff --git a/mm/slab.c b/mm/slab.c
> index ab34727d61b2..a2f43425a0ae 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3585,11 +3585,19 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
>  	struct kmem_cache *cachep;
>  	void *ret;
>  
> -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> -		return NULL;
> +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> +		ret = kmalloc_large_node_notrace(size, flags, node);
> +
> +		trace_kmalloc_node(caller, ret, NULL, size,
> +				   PAGE_SIZE << get_order(size),
> +				   flags, node);
> +		return ret;
> +	}
> +
>  	cachep = kmalloc_slab(size, flags);
>  	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
>  		return cachep;
> +
>  	ret = kmem_cache_alloc_node_trace(cachep, flags, node, size);
>  	ret = kasan_kmalloc(cachep, ret, size, flags);
>  
> @@ -3664,17 +3672,27 @@ EXPORT_SYMBOL(kmem_cache_free);
>  
>  void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
>  {
> -	struct kmem_cache *s;
> -	size_t i;
>  
>  	local_irq_disable();
> -	for (i = 0; i < size; i++) {
> +	for (int i = 0; i < size; i++) {
>  		void *objp = p[i];
> +		struct kmem_cache *s;
>  
> -		if (!orig_s) /* called via kfree_bulk */
> -			s = virt_to_cache(objp);
> -		else
> +		if (!orig_s) {
> +			struct folio *folio = virt_to_folio(objp);
> +
> +			/* called via kfree_bulk */
> +			if (!folio_test_slab(folio)) {
> +				local_irq_enable();
> +				free_large_kmalloc(folio, objp);
> +				local_irq_disable();
> +				continue;
> +			}
> +			s = folio_slab(folio)->slab_cache;
> +		} else {
>  			s = cache_from_obj(orig_s, objp);
> +		}
> +
>  		if (!s)
>  			continue;
>  
> @@ -3703,20 +3721,24 @@ void kfree(const void *objp)
>  {
>  	struct kmem_cache *c;
>  	unsigned long flags;
> +	struct folio *folio;
>  
>  	trace_kfree(_RET_IP_, objp);
>  
>  	if (unlikely(ZERO_OR_NULL_PTR(objp)))
>  		return;
> -	local_irq_save(flags);
> -	kfree_debugcheck(objp);
> -	c = virt_to_cache(objp);
> -	if (!c) {
> -		local_irq_restore(flags);
> +
> +	folio = virt_to_folio(objp);
> +	if (!folio_test_slab(folio)) {
> +		free_large_kmalloc(folio, (void *)objp);
>  		return;
>  	}
> -	debug_check_no_locks_freed(objp, c->object_size);
>  
> +	c = folio_slab(folio)->slab_cache;
> +
> +	local_irq_save(flags);
> +	kfree_debugcheck(objp);
> +	debug_check_no_locks_freed(objp, c->object_size);
>  	debug_check_no_obj_freed(objp, c->object_size);
>  	__cache_free(c, (void *)objp, _RET_IP_);
>  	local_irq_restore(flags);
> @@ -4138,15 +4160,17 @@ void __check_heap_object(const void *ptr, unsigned long n,
>  size_t __ksize(const void *objp)
>  {
>  	struct kmem_cache *c;
> -	size_t size;
> +	struct folio *folio;
>  
>  	BUG_ON(!objp);
>  	if (unlikely(objp == ZERO_SIZE_PTR))
>  		return 0;
>  
> -	c = virt_to_cache(objp);
> -	size = c ? c->object_size : 0;
> +	folio = virt_to_folio(objp);
> +	if (!folio_test_slab(folio))
> +		return folio_size(folio);
>  
> -	return size;
> +	c = folio_slab(folio)->slab_cache;
> +	return c->object_size;
>  }
>  EXPORT_SYMBOL(__ksize);
> diff --git a/mm/slab.h b/mm/slab.h
> index 7cb51ff44f0c..c81c92d421f1 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -669,6 +669,9 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>  		print_tracking(cachep, x);
>  	return cachep;
>  }
> +
> +void free_large_kmalloc(struct folio *folio, void *object);
> +
>  #endif /* CONFIG_SLOB */
>  
>  static inline size_t slab_ksize(const struct kmem_cache *s)
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 9c46e2f9589f..0dff46fb7193 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -771,8 +771,8 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
>  
>  /*
>   * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
> - * kmalloc_index() supports up to 2^25=32MB, so the final entry of the table is
> - * kmalloc-32M.
> + * kmalloc_index() supports up to 2^21=2MB, so the final entry of the table is
> + * kmalloc-2M.
>   */
>  const struct kmalloc_info_struct kmalloc_info[] __initconst = {
>  	INIT_KMALLOC_INFO(0, 0),
> @@ -796,11 +796,7 @@ const struct kmalloc_info_struct kmalloc_info[] __initconst = {
>  	INIT_KMALLOC_INFO(262144, 256k),
>  	INIT_KMALLOC_INFO(524288, 512k),
>  	INIT_KMALLOC_INFO(1048576, 1M),
> -	INIT_KMALLOC_INFO(2097152, 2M),
> -	INIT_KMALLOC_INFO(4194304, 4M),
> -	INIT_KMALLOC_INFO(8388608, 8M),
> -	INIT_KMALLOC_INFO(16777216, 16M),
> -	INIT_KMALLOC_INFO(33554432, 32M)
> +	INIT_KMALLOC_INFO(2097152, 2M)
>  };
>  
>  /*
> @@ -913,6 +909,21 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  	/* Kmalloc array is now usable */
>  	slab_state = UP;
>  }
> +
> +void free_large_kmalloc(struct folio *folio, void *object)
> +{
> +	unsigned int order = folio_order(folio);
> +
> +	if (WARN_ON_ONCE(order == 0))
> +		pr_warn_once("object pointer: 0x%p\n", object);
> +
> +	kmemleak_free(object);
> +	kasan_kfree_large(object);
> +
> +	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
> +			      -(PAGE_SIZE << order));
> +	__free_pages(folio_page(folio, 0), order);
> +}
>  #endif /* !CONFIG_SLOB */
>  
>  gfp_t kmalloc_fix_flags(gfp_t flags)
> diff --git a/mm/slub.c b/mm/slub.c
> index 3d02cf44adf7..6cb7ca27f3b7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1704,12 +1704,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
>   * Hooks for other subsystems that check memory allocations. In a typical
>   * production configuration these hooks all should produce no code at all.
>   */
> -static __always_inline void kfree_hook(void *x)
> -{
> -	kmemleak_free(x);
> -	kasan_kfree_large(x);
> -}
> -
>  static __always_inline bool slab_free_hook(struct kmem_cache *s,
>  						void *x, bool init)
>  {
> @@ -3550,19 +3544,6 @@ struct detached_freelist {
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

