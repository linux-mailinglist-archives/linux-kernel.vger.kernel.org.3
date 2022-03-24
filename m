Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF64E6860
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352497AbiCXSKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbiCXSKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:10:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCE437BFF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:08:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 058241F745;
        Thu, 24 Mar 2022 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648145308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHYK+pNJTiWDjab7ocwLP7vS44gNediJ4h4wuLcBQNg=;
        b=BH+EoBcr8aq9OnDo0PNGKsBQoNs23EI7G0EjFyufOk6bA6SXSp6zspjwMYIXcUZQDBEqHd
        QYhoED7QiADbMhlHseFqUZGguvgL+DL9922pj2tCHoQj9zngFBBUeT0MYAZOry8FgcR2bp
        YmvcioAyVwQvPOwW7PS6io7VWcuboX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648145308;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHYK+pNJTiWDjab7ocwLP7vS44gNediJ4h4wuLcBQNg=;
        b=E66XVVwvYPi8Kv8bW8uI/z8VWDTDnu3UJxD/K0GyzpsNyvU0+Og/6Z2fEORWJrtWP2/rsi
        rdMX3AuDAX9l6HCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC23113A7F;
        Thu, 24 Mar 2022 18:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /dj6MJuzPGKeagAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Mar 2022 18:08:27 +0000
Message-ID: <9b808582-3a64-b626-14a4-55e7d9040261@suse.cz>
Date:   Thu, 24 Mar 2022 19:08:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
 <20220308114142.1744229-10-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH v1 09/15] mm/slab: kmalloc: pass requests larger than
 order-1 page to page allocator
In-Reply-To: <20220308114142.1744229-10-42.hyeyoo@gmail.com>
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

On 3/8/22 12:41, Hyeonggon Yoo wrote:
> There is not much benefit for serving large objects in kmalloc().
> Let's pass large requests to page allocator like SLUB for better
> maintenance of common code.
> 
> [ vbabka@suse.cz: Enable and disable irq around free_large_kmalloc().
>   Do not lose NUMA locality in __do_kmalloc_node().
>   Use folio_slab(folio)->slab_cache instead of virt_to_cache().
>   Remove large sizes in __kmalloc_index(). ]

Thanks for the mention but that's generally only done like this if I took
your patch and made those changes myself. But I just suggested them. Small
suggested changes like this are usually just mentioned in e.g. v1->v2
changelogs.

> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  include/linux/slab.h | 23 +++++-----------------
>  mm/slab.c            | 45 ++++++++++++++++++++++++++++++--------------
>  mm/slab.h            |  3 +++
>  mm/slab_common.c     | 25 +++++++++++++++++-------
>  mm/slub.c            | 19 -------------------
>  5 files changed, 57 insertions(+), 58 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index dfcc8301d969..9ced225a3ea3 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -226,27 +226,17 @@ void kmem_dump_obj(void *object);
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
> @@ -398,10 +388,6 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
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
> @@ -411,6 +397,7 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>  	/* Will never be reached. Needed because the compiler may complain */
>  	return -1;
>  }
> +static_assert(PAGE_SHIFT <= 20);
>  #define kmalloc_index(s) __kmalloc_index(s, true)
>  #endif /* !CONFIG_SLOB */
>  
> diff --git a/mm/slab.c b/mm/slab.c
> index 6ebf509bf2de..f0041f0125ba 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3568,7 +3568,7 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
>  	void *ret;
>  
>  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> -		return NULL;
> +		return kmalloc_large_node(size, flags, node);

Similar issue with caller not traced.

>  	cachep = kmalloc_slab(size, flags);
>  	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
>  		return cachep;
> @@ -3642,15 +3642,25 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
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
> -			s = virt_to_cache(objp);
> -		else
> +		if (!orig_s) {
> +			folio = virt_to_folio(objp);
> +			/* called via kfree_bulk */
> +			if (!folio_test_slab(folio)) {
> +				local_irq_enable();
> +				free_large_kmalloc(folio, objp);
> +				local_irq_disable();
> +				continue;
> +			}
> +			s = folio_slab(folio)->slab_cache;
> +		} else
>  			s = cache_from_obj(orig_s, objp);
> +
>  		if (!s)
>  			continue;
>  
> @@ -3679,20 +3689,25 @@ void kfree(const void *objp)
>  {
>  	struct kmem_cache *c;
>  	unsigned long flags;
> +	struct folio *folio;
> +	void *x = (void *) objp;

I think you don't need to add 'x', just do the cast while calling
free_large_kmalloc(), same as done for __cache_free().

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
> +		free_large_kmalloc(folio, x);
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
