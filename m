Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B213453006E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 05:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiEVDwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 23:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiEVDwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 23:52:04 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096A128732
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 20:52:03 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id d198so7276630iof.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 20:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XFGJ8+ZOGoCCjRptDXLTDFctW5H69oldfJjY0FV894E=;
        b=kBJZlZYW/LQD+FYiH97fwr6vhunsWoUA6DUG81WNSsxaYw+eISzlcFUJM7GEvr8jxR
         vkJ3vB/47Smqx2E6fgBuc1xp9Pt1m9mjah5tbqbsNfyTfb6/crf01d5sCnR1wn4jlJNp
         ZDisKg4kRvD58eyymroR9QuG2LGnuq0dnEY9ryToItUmglka4UyK2hrV5yqjn0tpNhCn
         Vj2jpkuEAsYrd2XRsrqjmnttNVPEtP3HYEYfP+zURgQM2V2nH13R+iOKK/j6r0qhmgnR
         LRDwcn1h3vTdpC+Z5KPhKlXbxit1zlPYnvENElkt2F4GQLePb6XDyT424Tmaiwsv/EmJ
         fiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XFGJ8+ZOGoCCjRptDXLTDFctW5H69oldfJjY0FV894E=;
        b=UhESdZAz0tKFeqjXyFMByrfLlFoa8S25ZxwnOgoD8naC/YY3lcRjlKufj2J/kokP9x
         wcnPHyZfs7FXvSZt5XkMlG2yU1aP0vQiHYGw0kQoi3Mxl6odngTuF0IFfIcwrw4HpKkb
         Hd889sM+DnoZZv4dWKDtzrt2o4hhJZ0SM8Z+etLyvyhyWp1ku0sIpGThT8Go/RAe5+ZS
         ypxAAB00k0pgThlAd9YdAf7/FZAkpdrKc19CU4yv630Nbumh4/BsHBBohRoIcrz5frT6
         aVDfpwkrBKvhHgksi/GJScQOM774miI4S1T1hmB5/NzXtaXwX19OL2NnrEpTyo5TDyqb
         lDbg==
X-Gm-Message-State: AOAM5329g5Tkk1sMNLKRBfwdacm6EgqDqvBMOhlTM7Kk0Iyu+luhSaVn
        m/zU8gd8L1MEnY5U/YZbu+Q=
X-Google-Smtp-Source: ABdhPJz963nsdnT903eRYTKP4mPtt2uCg4VzYemmE11wf0NHijrj80XQhxL3Cc3zbN6gfZGHBWZZBA==
X-Received: by 2002:a05:6602:2d52:b0:65a:dc1f:932c with SMTP id d18-20020a0566022d5200b0065adc1f932cmr7421762iow.3.1653191522260;
        Sat, 21 May 2022 20:52:02 -0700 (PDT)
Received: from n2.us-central1-a.c.spheric-algebra-350919.internal (151.16.70.34.bc.googleusercontent.com. [34.70.16.151])
        by smtp.gmail.com with ESMTPSA id q46-20020a027b2e000000b0032e43cb7344sm1808364jac.146.2022.05.21.20.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 20:52:01 -0700 (PDT)
Date:   Sun, 22 May 2022 03:51:59 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v4] tracing: add 'accounted' entry into output of
 allocation tracepoints
Message-ID: <YomzXwN9rvCGAZJ0@n2.us-central1-a.c.spheric-algebra-350919.internal>
References: <0c73ce5c-3625-6187-820e-1277e168b3bc@openvz.org>
 <a1e54672-d824-3ee1-cb68-9ceaa46fc70f@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e54672-d824-3ee1-cb68-9ceaa46fc70f@openvz.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 09:36:54PM +0300, Vasily Averin wrote:
> Slab caches marked with SLAB_ACCOUNT force accounting for every
> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> Unfortunately, at the moment this flag is not visible in ftrace output,
> and this makes it difficult to analyze the accounted allocations.
> 
> This patch adds boolean "accounted" entry into trace output,
> and set it to 'true' for calls used __GFP_ACCOUNT flag and
> for allocations from caches marked with SLAB_ACCOUNT.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> Acked-by: Shakeel Butt <shakeelb@google.com>

May I ask what information do you want to collect
using this patch?

I pointed it in another thread but I'm not sure
printing SLAB_* flags in these tracepoint is good :(

If we decide to do that, it would be better to print
something like:
slab_flags=SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT|SLAB_STORE_USER
instead of just printing 'accounted=true/false'. This patch is too
specific to SLAB_ACCOUNT.

And if what you want to know is just total slab memory that is accounted,
what about adding something like  SlabAccounted in /proc/meminfo?

Thanks.

> ---
> v4:
>  1) replaced in patch descripion: "accounted" instead of "allocated"
>  2) added "Acked-by" from Shakeel,
>  3) re-addressed to akpm@
> 
> v3:
>  1) rework kmem_cache_alloc* tracepoints once again,
>     added struct kmem_cache argument into existing templates,
> 	thanks to Matthew Wilcox
>  2) updated according trace_* calls
>  3) added boolean "allocated" entry into trace output,
> 	thanks to Roman
>  4) updated patch subject and description
> 
> v2:
>  1) handle kmem_cache_alloc_node(), thanks to Shakeel
>  2) rework kmem_cache_alloc* tracepoints to use cachep instead
>     of current cachep->*size parameters.
>     NB: kmem_cache_alloc_node tracepoint in SLOB cannot use cachep,
>         and therefore it was replaced by kmalloc_node.
> ---
>  include/trace/events/kmem.h | 38 +++++++++++++++++++++++--------------
>  mm/slab.c                   | 10 +++++-----
>  mm/slab_common.c            |  9 ++++-----
>  mm/slob.c                   |  8 ++++----
>  mm/slub.c                   | 20 +++++++++----------
>  5 files changed, 47 insertions(+), 38 deletions(-)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index 71c141804222..5bfeb6f276f1 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -13,11 +13,12 @@ DECLARE_EVENT_CLASS(kmem_alloc,
>  
>  	TP_PROTO(unsigned long call_site,
>  		 const void *ptr,
> +		 struct kmem_cache *s,
>  		 size_t bytes_req,
>  		 size_t bytes_alloc,
>  		 gfp_t gfp_flags),
>  
> -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags),
> +	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags),
>  
>  	TP_STRUCT__entry(
>  		__field(	unsigned long,	call_site	)
> @@ -25,6 +26,7 @@ DECLARE_EVENT_CLASS(kmem_alloc,
>  		__field(	size_t,		bytes_req	)
>  		__field(	size_t,		bytes_alloc	)
>  		__field(	unsigned long,	gfp_flags	)
> +		__field(	bool,		accounted	)
>  	),
>  
>  	TP_fast_assign(
> @@ -33,42 +35,46 @@ DECLARE_EVENT_CLASS(kmem_alloc,
>  		__entry->bytes_req	= bytes_req;
>  		__entry->bytes_alloc	= bytes_alloc;
>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
> +		__entry->accounted	= (gfp_flags & __GFP_ACCOUNT) ||

I doubt someone will pass __GFP_ACCOUNT in gfpflags
when calling kmem_cache_alloc*().


> +					  (s && s->flags & SLAB_ACCOUNT);
>  	),
>  
> -	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
> +	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s accounted=%s",
>  		(void *)__entry->call_site,
>  		__entry->ptr,
>  		__entry->bytes_req,
>  		__entry->bytes_alloc,
> -		show_gfp_flags(__entry->gfp_flags))
> +		show_gfp_flags(__entry->gfp_flags),
> +		__entry->accounted ? "true" : "false")
>  );
>  
>  DEFINE_EVENT(kmem_alloc, kmalloc,
>  
> -	TP_PROTO(unsigned long call_site, const void *ptr,
> +	TP_PROTO(unsigned long call_site, const void *ptr, struct kmem_cache *s,
>  		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
>  
> -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
> +	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags)
>  );
>  
>  DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
>  
> -	TP_PROTO(unsigned long call_site, const void *ptr,
> +	TP_PROTO(unsigned long call_site, const void *ptr, struct kmem_cache *s,
>  		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
>  
> -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
> +	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags)
>  );
>  
>  DECLARE_EVENT_CLASS(kmem_alloc_node,
>  
>  	TP_PROTO(unsigned long call_site,
>  		 const void *ptr,
> +		 struct kmem_cache *s,
>  		 size_t bytes_req,
>  		 size_t bytes_alloc,
>  		 gfp_t gfp_flags,
>  		 int node),
>  
> -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node),
> +	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node),
>  
>  	TP_STRUCT__entry(
>  		__field(	unsigned long,	call_site	)
> @@ -77,6 +83,7 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
>  		__field(	size_t,		bytes_alloc	)
>  		__field(	unsigned long,	gfp_flags	)
>  		__field(	int,		node		)
> +		__field(	bool,		accounted	)
>  	),
>  
>  	TP_fast_assign(
> @@ -86,33 +93,36 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
>  		__entry->bytes_alloc	= bytes_alloc;
>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
>  		__entry->node		= node;
> +		__entry->accounted	= (gfp_flags & __GFP_ACCOUNT) ||
> +					  (s && s->flags & SLAB_ACCOUNT);
>  	),
>  
> -	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
> +	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
>  		(void *)__entry->call_site,
>  		__entry->ptr,
>  		__entry->bytes_req,
>  		__entry->bytes_alloc,
>  		show_gfp_flags(__entry->gfp_flags),
> -		__entry->node)
> +		__entry->node,
> +		__entry->accounted ? "true" : "false")
>  );
>  
>  DEFINE_EVENT(kmem_alloc_node, kmalloc_node,
>  
>  	TP_PROTO(unsigned long call_site, const void *ptr,
> -		 size_t bytes_req, size_t bytes_alloc,
> +		 struct kmem_cache *s, size_t bytes_req, size_t bytes_alloc,
>  		 gfp_t gfp_flags, int node),
>  
> -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
> +	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node)
>  );
>  
>  DEFINE_EVENT(kmem_alloc_node, kmem_cache_alloc_node,
>  
>  	TP_PROTO(unsigned long call_site, const void *ptr,
> -		 size_t bytes_req, size_t bytes_alloc,
> +		 struct kmem_cache *s, size_t bytes_req, size_t bytes_alloc,
>  		 gfp_t gfp_flags, int node),
>  
> -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
> +	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node)
>  );
>  
>  TRACE_EVENT(kfree,
> diff --git a/mm/slab.c b/mm/slab.c
> index 0edb474edef1..e5802445c7d6 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3492,7 +3492,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
>  {
>  	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
>  
> -	trace_kmem_cache_alloc(_RET_IP_, ret,
> +	trace_kmem_cache_alloc(_RET_IP_, ret, cachep,
>  			       cachep->object_size, cachep->size, flags);
>  
>  	return ret;
> @@ -3581,7 +3581,7 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
>  	ret = slab_alloc(cachep, NULL, flags, size, _RET_IP_);
>  
>  	ret = kasan_kmalloc(cachep, ret, size, flags);
> -	trace_kmalloc(_RET_IP_, ret,
> +	trace_kmalloc(_RET_IP_, ret, cachep,
>  		      size, cachep->size, flags);
>  	return ret;
>  }
> @@ -3606,7 +3606,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
>  {
>  	void *ret = slab_alloc_node(cachep, flags, nodeid, cachep->object_size, _RET_IP_);
>  
> -	trace_kmem_cache_alloc_node(_RET_IP_, ret,
> +	trace_kmem_cache_alloc_node(_RET_IP_, ret, cachep,
>  				    cachep->object_size, cachep->size,
>  				    flags, nodeid);
>  
> @@ -3625,7 +3625,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
>  	ret = slab_alloc_node(cachep, flags, nodeid, size, _RET_IP_);
>  
>  	ret = kasan_kmalloc(cachep, ret, size, flags);
> -	trace_kmalloc_node(_RET_IP_, ret,
> +	trace_kmalloc_node(_RET_IP_, ret, cachep,
>  			   size, cachep->size,
>  			   flags, nodeid);
>  	return ret;
> @@ -3708,7 +3708,7 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
>  	ret = slab_alloc(cachep, NULL, flags, size, caller);
>  
>  	ret = kasan_kmalloc(cachep, ret, size, flags);
> -	trace_kmalloc(caller, ret,
> +	trace_kmalloc(caller, ret, cachep,
>  		      size, cachep->size, flags);
>  
>  	return ret;
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 2b3206a2c3b5..a345e8600e00 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -25,13 +25,12 @@
>  #include <asm/page.h>
>  #include <linux/memcontrol.h>
>  
> -#define CREATE_TRACE_POINTS
> -#include <trace/events/kmem.h>
> -
>  #include "internal.h"
> -
>  #include "slab.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/kmem.h>
> +
>  enum slab_state slab_state;
>  LIST_HEAD(slab_caches);
>  DEFINE_MUTEX(slab_mutex);
> @@ -967,7 +966,7 @@ EXPORT_SYMBOL(kmalloc_order);
>  void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
>  {
>  	void *ret = kmalloc_order(size, flags, order);
> -	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
> +	trace_kmalloc(_RET_IP_, ret, NULL, size, PAGE_SIZE << order, flags);
>  	return ret;
>  }
>  EXPORT_SYMBOL(kmalloc_order_trace);
> diff --git a/mm/slob.c b/mm/slob.c
> index 40ea6e2d4ccd..dbefa0da0dfc 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -505,7 +505,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
>  		*m = size;
>  		ret = (void *)m + minalign;
>  
> -		trace_kmalloc_node(caller, ret,
> +		trace_kmalloc_node(caller, ret, NULL,
>  				   size, size + minalign, gfp, node);
>  	} else {
>  		unsigned int order = get_order(size);
> @@ -514,7 +514,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
>  			gfp |= __GFP_COMP;
>  		ret = slob_new_pages(gfp, order, node);
>  
> -		trace_kmalloc_node(caller, ret,
> +		trace_kmalloc_node(caller, ret, NULL,
>  				   size, PAGE_SIZE << order, gfp, node);
>  	}
>  
> @@ -610,12 +610,12 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
>  
>  	if (c->size < PAGE_SIZE) {
>  		b = slob_alloc(c->size, flags, c->align, node, 0);
> -		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
> +		trace_kmem_cache_alloc_node(_RET_IP_, b, NULL, c->object_size,
>  					    SLOB_UNITS(c->size) * SLOB_UNIT,
>  					    flags, node);
>  	} else {
>  		b = slob_new_pages(flags, get_order(c->size), node);
> -		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
> +		trace_kmem_cache_alloc_node(_RET_IP_, b, NULL, c->object_size,
>  					    PAGE_SIZE << get_order(c->size),
>  					    flags, node);
>  	}
> diff --git a/mm/slub.c b/mm/slub.c
> index ed5c2c03a47a..9b10591646dd 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3231,7 +3231,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  {
>  	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
>  
> -	trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
> +	trace_kmem_cache_alloc(_RET_IP_, ret, s, s->object_size,
>  				s->size, gfpflags);
>  
>  	return ret;
> @@ -3254,7 +3254,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_lru);
>  void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
>  {
>  	void *ret = slab_alloc(s, NULL, gfpflags, _RET_IP_, size);
> -	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags);
> +	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags);
>  	ret = kasan_kmalloc(s, ret, size, gfpflags);
>  	return ret;
>  }
> @@ -3266,7 +3266,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
>  {
>  	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
>  
> -	trace_kmem_cache_alloc_node(_RET_IP_, ret,
> +	trace_kmem_cache_alloc_node(_RET_IP_, ret, s,
>  				    s->object_size, s->size, gfpflags, node);
>  
>  	return ret;
> @@ -3280,7 +3280,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
>  {
>  	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
>  
> -	trace_kmalloc_node(_RET_IP_, ret,
> +	trace_kmalloc_node(_RET_IP_, ret, s,
>  			   size, s->size, gfpflags, node);
>  
>  	ret = kasan_kmalloc(s, ret, size, gfpflags);
> @@ -4409,7 +4409,7 @@ void *__kmalloc(size_t size, gfp_t flags)
>  
>  	ret = slab_alloc(s, NULL, flags, _RET_IP_, size);
>  
> -	trace_kmalloc(_RET_IP_, ret, size, s->size, flags);
> +	trace_kmalloc(_RET_IP_, ret, s, size, s->size, flags);
>  
>  	ret = kasan_kmalloc(s, ret, size, flags);
>  
> @@ -4443,7 +4443,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
>  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
>  		ret = kmalloc_large_node(size, flags, node);
>  
> -		trace_kmalloc_node(_RET_IP_, ret,
> +		trace_kmalloc_node(_RET_IP_, ret, NULL,
>  				   size, PAGE_SIZE << get_order(size),
>  				   flags, node);
>  
> @@ -4457,7 +4457,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
>  
>  	ret = slab_alloc_node(s, NULL, flags, node, _RET_IP_, size);
>  
> -	trace_kmalloc_node(_RET_IP_, ret, size, s->size, flags, node);
> +	trace_kmalloc_node(_RET_IP_, ret, s, size, s->size, flags, node);
>  
>  	ret = kasan_kmalloc(s, ret, size, flags);
>  
> @@ -4916,7 +4916,7 @@ void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
>  	ret = slab_alloc(s, NULL, gfpflags, caller, size);
>  
>  	/* Honor the call site pointer we received. */
> -	trace_kmalloc(caller, ret, size, s->size, gfpflags);
> +	trace_kmalloc(caller, ret, s, size, s->size, gfpflags);
>  
>  	return ret;
>  }
> @@ -4932,7 +4932,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
>  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
>  		ret = kmalloc_large_node(size, gfpflags, node);
>  
> -		trace_kmalloc_node(caller, ret,
> +		trace_kmalloc_node(caller, ret, NULL,
>  				   size, PAGE_SIZE << get_order(size),
>  				   gfpflags, node);
>  
> @@ -4947,7 +4947,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
>  	ret = slab_alloc_node(s, NULL, gfpflags, node, caller, size);
>  
>  	/* Honor the call site pointer we received. */
> -	trace_kmalloc_node(caller, ret, size, s->size, gfpflags, node);
> +	trace_kmalloc_node(caller, ret, s, size, s->size, gfpflags, node);
>  
>  	return ret;
>  }
> -- 
> 2.31.1
> 
