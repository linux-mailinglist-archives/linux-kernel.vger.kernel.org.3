Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6787584F81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiG2LXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiG2LXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:23:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E472181B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:23:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1294B20D9A;
        Fri, 29 Jul 2022 11:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659093819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7mYg8s2ljTAisX7r4qpAGjXTWjAO7TsOyM5P3i2EQU=;
        b=G7F0txVRAFpR26VJbZu0RDkP+yigpbnuVa9dqe6N3qFtFfAcdlaz2BIXwV0NdLYCVoiQSH
        EZRDcnYu3XqrYxa5wKeE1p3rl1Oips58p7oCfP9oNT2jcAtPrtMIt9ZQRbMH4PdiMP8meN
        MAJEYyF00CBGkaJ6bnrN7xm+H+yNHsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659093819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7mYg8s2ljTAisX7r4qpAGjXTWjAO7TsOyM5P3i2EQU=;
        b=7RcFovqcE80eOfqKDOm7E/jMfjecEk/Qn3/MzGSpqM5lh3GN2gYz3UTN16UeqYe1Is5Mg5
        jdXWG4RaxqC3IVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB61B13A1B;
        Fri, 29 Jul 2022 11:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RxvJNDrD42LCFgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Jul 2022 11:23:38 +0000
Message-ID: <ec5dc308-e75f-eb4e-3837-a7221506f773@suse.cz>
Date:   Fri, 29 Jul 2022 13:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 14/16] mm/slab_common: drop kmem_alloc & avoid
 dereferencing fields when not using
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
 <20220712133946.307181-15-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220712133946.307181-15-42.hyeyoo@gmail.com>
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
> Drop kmem_alloc event class, and define kmalloc and kmem_cache_alloc
> using TRACE_EVENT() macro.
> 
> And then this patch does:
>    - Do not pass pointer to struct kmem_cache to trace_kmalloc.
>      gfp flag is enough to know if it's accounted or not.
>    - Avoid dereferencing s->object_size and s->size when not using kmem_cache_alloc event.
>    - Avoid dereferencing s->name in when not using kmem_cache_free event.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

With some comments:

> ---
>  include/trace/events/kmem.h | 64 +++++++++++++++++++++++++------------
>  mm/slab.c                   | 16 ++++------
>  mm/slab_common.c            | 17 ++++++----
>  mm/slob.c                   | 16 +++-------
>  mm/slub.c                   | 13 +++-----
>  5 files changed, 70 insertions(+), 56 deletions(-)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index e078ebcdc4b1..0ded2c351062 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -9,17 +9,15 @@
>  #include <linux/tracepoint.h>
>  #include <trace/events/mmflags.h>
>  
> -DECLARE_EVENT_CLASS(kmem_alloc,
> +TRACE_EVENT(kmem_cache_alloc,
>  
>  	TP_PROTO(unsigned long call_site,
>  		 const void *ptr,
>  		 struct kmem_cache *s,
> -		 size_t bytes_req,
> -		 size_t bytes_alloc,
>  		 gfp_t gfp_flags,
>  		 int node),
>  
> -	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node),
> +	TP_ARGS(call_site, ptr, s, gfp_flags, node),
>  
>  	TP_STRUCT__entry(
>  		__field(	unsigned long,	call_site	)
> @@ -34,8 +32,8 @@ DECLARE_EVENT_CLASS(kmem_alloc,
>  	TP_fast_assign(
>  		__entry->call_site	= call_site;
>  		__entry->ptr		= ptr;
> -		__entry->bytes_req	= bytes_req;
> -		__entry->bytes_alloc	= bytes_alloc;
> +		__entry->bytes_req	= s->object_size;
> +		__entry->bytes_alloc	= s->size;
>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
>  		__entry->node		= node;
>  		__entry->accounted	= IS_ENABLED(CONFIG_MEMCG_KMEM) ?

This assignment continues by ...
	(s && s->flags & SLAB_ACCOUNT)) : false;

We could now remove the "s &&" as we assume it's non-NULL anyway.

> @@ -53,22 +51,46 @@ DECLARE_EVENT_CLASS(kmem_alloc,
>  		__entry->accounted ? "true" : "false")
>  );
>  
> -DEFINE_EVENT(kmem_alloc, kmalloc,
> +TRACE_EVENT(kmalloc,
>  
> -	TP_PROTO(unsigned long call_site, const void *ptr,
> -		 struct kmem_cache *s, size_t bytes_req, size_t bytes_alloc,
> -		 gfp_t gfp_flags, int node),
> +	TP_PROTO(unsigned long call_site,
> +		 const void *ptr,
> +		 size_t bytes_req,
> +		 size_t bytes_alloc,
> +		 gfp_t gfp_flags,
> +		 int node),
>  
> -	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node)
> -);
> +	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node),
>  
> -DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
> +	TP_STRUCT__entry(
> +		__field(	unsigned long,	call_site	)
> +		__field(	const void *,	ptr		)
> +		__field(	size_t,		bytes_req	)
> +		__field(	size_t,		bytes_alloc	)
> +		__field(	unsigned long,	gfp_flags	)
> +		__field(	int,		node		)
> +		__field(	bool,		accounted	)
> +	),
>  
> -	TP_PROTO(unsigned long call_site, const void *ptr,
> -		 struct kmem_cache *s, size_t bytes_req, size_t bytes_alloc,
> -		 gfp_t gfp_flags, int node),
> +	TP_fast_assign(
> +		__entry->call_site	= call_site;
> +		__entry->ptr		= ptr;
> +		__entry->bytes_req	= bytes_req;
> +		__entry->bytes_alloc	= bytes_alloc;
> +		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
> +		__entry->node		= node;
> +		__entry->accounted	= IS_ENABLED(CONFIG_MEMCG_KMEM) ?
> +					  (gfp_flags & __GFP_ACCOUNT) : false;

This test could be perhaps moved to TP_printk and the accounted field
removed completely, but we need to make sure trace-cmd (which reads the
binary entries and does the printk in userspace) can interpret the tests
properly, including the IS_ENABLED(CONFIG_MEMCG_KMEM) part.

> +	),
>  
> -	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node)
> +	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
> +		(void *)__entry->call_site,
> +		__entry->ptr,
> +		__entry->bytes_req,
> +		__entry->bytes_alloc,
> +		show_gfp_flags(__entry->gfp_flags),
> +		__entry->node,
> +		__entry->accounted ? "true" : "false")
>  );
>  
>  TRACE_EVENT(kfree,
> @@ -93,20 +115,20 @@ TRACE_EVENT(kfree,
>  
>  TRACE_EVENT(kmem_cache_free,
>  
> -	TP_PROTO(unsigned long call_site, const void *ptr, const char *name),
> +	TP_PROTO(unsigned long call_site, const void *ptr, const struct kmem_cache *s),
>  
> -	TP_ARGS(call_site, ptr, name),
> +	TP_ARGS(call_site, ptr, s),
>  
>  	TP_STRUCT__entry(
>  		__field(	unsigned long,	call_site	)
>  		__field(	const void *,	ptr		)
> -		__string(	name,	name	)
> +		__string(	name,		s->name		)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->call_site	= call_site;
>  		__entry->ptr		= ptr;
> -		__assign_str(name, name);
> +		__assign_str(name, s->name);
>  	),
>  
>  	TP_printk("call_site=%pS ptr=%p name=%s",
> diff --git a/mm/slab.c b/mm/slab.c
> index f9b74831e3f4..1685e5507a59 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3447,8 +3447,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
>  {
>  	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
>  
> -	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, cachep->object_size,
> -			       cachep->size, flags, NUMA_NO_NODE);
> +	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, flags, NUMA_NO_NODE);
>  
>  	return ret;
>  }
> @@ -3537,8 +3536,9 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
>  	ret = slab_alloc(cachep, NULL, flags, size, _RET_IP_);
>  
>  	ret = kasan_kmalloc(cachep, ret, size, flags);
> -	trace_kmalloc(_RET_IP_, ret, cachep,
> -		      size, cachep->size, flags, NUMA_NO_NODE);
> +	trace_kmalloc(_RET_IP_, ret,
> +		      size, cachep->size,
> +		      flags, NUMA_NO_NODE);

This could now fit on 2, maybe even 1 line?
Other trace_* calls could be perhaps also reduced, please check.

>  	return ret;
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_trace);
> @@ -3561,9 +3561,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
>  {
>  	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
>  
> -	trace_kmem_cache_alloc(_RET_IP_, ret, cachep,
> -			       cachep->object_size, cachep->size,
> -			       flags, nodeid);
> +	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, flags, nodeid);
>  
>  	return ret;
>  }
> @@ -3588,7 +3586,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
>  	ret = slab_alloc_node(cachep, NULL, flags, nodeid, size, _RET_IP_);
>  
>  	ret = kasan_kmalloc(cachep, ret, size, flags);
> -	trace_kmalloc(_RET_IP_, ret, cachep,
> +	trace_kmalloc(_RET_IP_, ret,
>  		      size, cachep->size,
>  		      flags, nodeid);
>  	return ret;
> @@ -3652,7 +3650,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *objp)
>  	if (!cachep)
>  		return;
>  
> -	trace_kmem_cache_free(_RET_IP_, objp, cachep->name);
> +	trace_kmem_cache_free(_RET_IP_, objp, cachep);
>  	__do_kmem_cache_free(cachep, objp, _RET_IP_);
>  }
>  EXPORT_SYMBOL(kmem_cache_free);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 0e66b4911ebf..c01c6b8f0d34 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -933,7 +933,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
>  
>  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
>  		ret = kmalloc_large_node_notrace(size, flags, node);
> -		trace_kmalloc(_RET_IP_, ret, NULL,
> +		trace_kmalloc(_RET_IP_, ret,
>  			      size, PAGE_SIZE << get_order(size),
>  			      flags, node);
>  		return ret;
> @@ -946,8 +946,9 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
>  
>  	ret = __kmem_cache_alloc_node(s, flags, node, size, caller);
>  	ret = kasan_kmalloc(s, ret, size, flags);
> -	trace_kmalloc(_RET_IP_, ret, s, size,
> -		      s->size, flags, node);
> +	trace_kmalloc(_RET_IP_, ret,
> +		      size, s->size,
> +		      flags, node);
>  	return ret;
>  }
>  
> @@ -1075,8 +1076,9 @@ void *kmalloc_large(size_t size, gfp_t flags)
>  {
>  	void *ret = __kmalloc_large_node_notrace(size, flags, NUMA_NO_NODE);
>  
> -	trace_kmalloc(_RET_IP_, ret, NULL, size,
> -		      PAGE_SIZE << get_order(size), flags, NUMA_NO_NODE);
> +	trace_kmalloc(_RET_IP_, ret,
> +		      size, PAGE_SIZE << get_order(size),
> +		      flags, NUMA_NO_NODE);
>  	return ret;
>  }
>  EXPORT_SYMBOL(kmalloc_large);
> @@ -1090,8 +1092,9 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
>  {
>  	void *ret = __kmalloc_large_node_notrace(size, flags, node);
>  
> -	trace_kmalloc(_RET_IP_, ret, NULL, size,
> -		      PAGE_SIZE << get_order(size), flags, node);
> +	trace_kmalloc(_RET_IP_, ret,
> +		      size, PAGE_SIZE << get_order(size),
> +		      flags, node);
>  	return ret;
>  }
>  EXPORT_SYMBOL(kmalloc_large_node);
> diff --git a/mm/slob.c b/mm/slob.c
> index a4d50d957c25..97a4d2407f96 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -507,8 +507,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
>  		*m = size;
>  		ret = (void *)m + minalign;
>  
> -		trace_kmalloc(caller, ret, NULL,
> -			      size, size + minalign, gfp, node);
> +		trace_kmalloc(caller, ret, size, size + minalign, gfp, node);
>  	} else {
>  		unsigned int order = get_order(size);
>  
> @@ -516,8 +515,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
>  			gfp |= __GFP_COMP;
>  		ret = slob_new_pages(gfp, order, node);
>  
> -		trace_kmalloc(caller, ret, NULL,
> -			      size, PAGE_SIZE << order, gfp, node);
> +		trace_kmalloc(caller, ret, size, PAGE_SIZE << order, gfp, node);
>  	}
>  
>  	kmemleak_alloc(ret, size, 1, gfp);
> @@ -608,14 +606,10 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
>  
>  	if (c->size < PAGE_SIZE) {
>  		b = slob_alloc(c->size, flags, c->align, node, 0);
> -		trace_kmem_cache_alloc(_RET_IP_, b, NULL, c->object_size,
> -				       SLOB_UNITS(c->size) * SLOB_UNIT,

Hm we lose the SLOB_UNITS() adjustment here. Maybe we don't care that much,
maybe simply c->size could be already stored with SLOB_UNITS() (but didn't
check if other stuff breaks with that).

Thanks!

> -				       flags, node);
> +		trace_kmem_cache_alloc(_RET_IP_, b, c, flags, node);
>  	} else {
>  		b = slob_new_pages(flags, get_order(c->size), node);
> -		trace_kmem_cache_alloc(_RET_IP_, b, NULL, c->object_size,
> -				       PAGE_SIZE << get_order(c->size),
> -				       flags, node);
> +		trace_kmem_cache_alloc(_RET_IP_, b, c, flags, node);
>  	}
>  
>  	if (b && c->ctor) {
> @@ -671,7 +665,7 @@ static void kmem_rcu_free(struct rcu_head *head)
>  void kmem_cache_free(struct kmem_cache *c, void *b)
>  {
>  	kmemleak_free_recursive(b, c->flags);
> -	trace_kmem_cache_free(_RET_IP_, b, c->name);
> +	trace_kmem_cache_free(_RET_IP_, b, c);
>  	if (unlikely(c->flags & SLAB_TYPESAFE_BY_RCU)) {
>  		struct slob_rcu *slob_rcu;
>  		slob_rcu = b + (c->size - sizeof(struct slob_rcu));
> diff --git a/mm/slub.c b/mm/slub.c
> index f1aa51480dc4..a49c69469c64 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3243,8 +3243,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  {
>  	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
>  
> -	trace_kmem_cache_alloc(_RET_IP_, ret, s, s->object_size,
> -				s->size, gfpflags, NUMA_NO_NODE);
> +	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
>  
>  	return ret;
>  }
> @@ -3274,7 +3273,7 @@ void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
>  void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
>  {
>  	void *ret = slab_alloc(s, NULL, gfpflags, _RET_IP_, size);
> -	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags, NUMA_NO_NODE);
> +	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
>  	ret = kasan_kmalloc(s, ret, size, gfpflags);
>  	return ret;
>  }
> @@ -3285,8 +3284,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
>  {
>  	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
>  
> -	trace_kmem_cache_alloc(_RET_IP_, ret, s,
> -			       s->object_size, s->size, gfpflags, node);
> +	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, node);
>  
>  	return ret;
>  }
> @@ -3299,8 +3297,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
>  {
>  	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
>  
> -	trace_kmalloc(_RET_IP_, ret, s,
> -		      size, s->size, gfpflags, node);
> +	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, node);
>  
>  	ret = kasan_kmalloc(s, ret, size, gfpflags);
>  	return ret;
> @@ -3544,7 +3541,7 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
>  	s = cache_from_obj(s, x);
>  	if (!s)
>  		return;
> -	trace_kmem_cache_free(_RET_IP_, x, s->name);
> +	trace_kmem_cache_free(_RET_IP_, x, s);
>  	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, _RET_IP_);
>  }
>  EXPORT_SYMBOL(kmem_cache_free);

