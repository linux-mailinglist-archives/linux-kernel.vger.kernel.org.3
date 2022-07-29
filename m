Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ABB584E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbiG2JtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiG2JtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:49:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5D352DD6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:49:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B6073402E;
        Fri, 29 Jul 2022 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659088151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jQHS9ztplh4Ee/QPpTZd5woby2nOAyOs3B+Gm7PCNnA=;
        b=U+4k02oyX7Q2rlHerS8t13TJaOlns3elgFnaWTAvDVh9oGtAHSW03zGGXeeTekyUaOM68h
        4WvG7H+NFEzyr+NLQMVt0X/t2u4Dnky/PHYebKeviDIoKebXtxoPnVO8m2AqFD7KVT7l8K
        +hzxvy3N2IwoaMU77xpXYvAlPhFZ7FQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659088151;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jQHS9ztplh4Ee/QPpTZd5woby2nOAyOs3B+Gm7PCNnA=;
        b=L9ZJ/9BlgL5aYuxLQa1zhmjd7v50EnfyjYh40aoHv19tPTOOhCS0YaQsXE+dUU7Q8CwIjV
        EhJujbh3NuRZzjDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49B5013A8E;
        Fri, 29 Jul 2022 09:49:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vFtaEBet42IZbQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Jul 2022 09:49:11 +0000
Message-ID: <976e08ef-a73b-1090-d147-e03fc600d149@suse.cz>
Date:   Fri, 29 Jul 2022 11:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 11/15] mm/sl[au]b: introduce common alloc/free
 functions without tracepoint
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
 <20220712133946.307181-12-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220712133946.307181-12-42.hyeyoo@gmail.com>
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
> To unify kmalloc functions in later patch, introduce common alloc/free
> functions that does not have tracepoint.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> 
> v3: 
>    Tried to avoid affecting existing functions.
> 
>  mm/slab.c | 36 +++++++++++++++++++++++++++++-------
>  mm/slab.h |  4 ++++
>  mm/slub.c | 13 +++++++++++++
>  3 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index a2f43425a0ae..375e35c14430 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3560,6 +3560,14 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_node);
>  
> +void *__kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
> +			     int nodeid, size_t orig_size,
> +			     unsigned long caller)
> +{
> +	return slab_alloc_node(cachep, NULL, flags, nodeid,
> +			       orig_size, caller);
> +}
> +
>  #ifdef CONFIG_TRACING
>  void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
>  				  gfp_t flags,
> @@ -3645,6 +3653,26 @@ void *__kmalloc(size_t size, gfp_t flags)
>  }
>  EXPORT_SYMBOL(__kmalloc);
>  
> +static __always_inline
> +void __do_kmem_cache_free(struct kmem_cache *cachep, void *objp,
> +			  unsigned long caller)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	debug_check_no_locks_freed(objp, cachep->object_size);
> +	if (!(cachep->flags & SLAB_DEBUG_OBJECTS))
> +		debug_check_no_obj_freed(objp, cachep->object_size);
> +	__cache_free(cachep, objp, caller);
> +	local_irq_restore(flags);
> +}
> +
> +void __kmem_cache_free(struct kmem_cache *cachep, void *objp,
> +		       unsigned long caller)
> +{
> +	__do_kmem_cache_free(cachep, objp, caller);
> +}
> +
>  /**
>   * kmem_cache_free - Deallocate an object
>   * @cachep: The cache the allocation was from.
> @@ -3655,18 +3683,12 @@ EXPORT_SYMBOL(__kmalloc);
>   */
>  void kmem_cache_free(struct kmem_cache *cachep, void *objp)
>  {
> -	unsigned long flags;
>  	cachep = cache_from_obj(cachep, objp);
>  	if (!cachep)
>  		return;
>  
>  	trace_kmem_cache_free(_RET_IP_, objp, cachep->name);
> -	local_irq_save(flags);
> -	debug_check_no_locks_freed(objp, cachep->object_size);
> -	if (!(cachep->flags & SLAB_DEBUG_OBJECTS))
> -		debug_check_no_obj_freed(objp, cachep->object_size);
> -	__cache_free(cachep, objp, _RET_IP_);
> -	local_irq_restore(flags);
> +	__do_kmem_cache_free(cachep, objp, _RET_IP_);
>  }
>  EXPORT_SYMBOL(kmem_cache_free);
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index c81c92d421f1..9193e9c1f040 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -275,6 +275,10 @@ void create_kmalloc_caches(slab_flags_t);
>  struct kmem_cache *kmalloc_slab(size_t, gfp_t);
>  
>  void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node);
> +void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
> +			      int node, size_t orig_size,
> +			      unsigned long caller);
> +void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller);
>  #endif
>  
>  gfp_t kmalloc_fix_flags(gfp_t flags);
> diff --git a/mm/slub.c b/mm/slub.c
> index 6cb7ca27f3b7..74eb78678c98 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3262,6 +3262,14 @@ void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_lru);
>  
> +void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
> +			      int node, size_t orig_size,
> +			      unsigned long caller)
> +{
> +	return slab_alloc_node(s, NULL, gfpflags, node,
> +			       caller, orig_size);
> +}
> +
>  #ifdef CONFIG_TRACING
>  void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
>  {
> @@ -3526,6 +3534,11 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
>  }
>  #endif
>  
> +void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller)
> +{
> +	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, caller);
> +}
> +
>  void kmem_cache_free(struct kmem_cache *s, void *x)
>  {
>  	s = cache_from_obj(s, x);

