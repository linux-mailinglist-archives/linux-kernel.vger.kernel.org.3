Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1433152A0F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345707AbiEQMAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242858AbiEQL7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:59:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B6C3D1D5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:59:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so2026285pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gvlUkl/BBW4zkQJjn0ZzRqBgDUiuxYWCFGII7wtj7js=;
        b=BjsGTxfQxlDXAIkaZ2C6dRqJrjOKnwA08Eq+xe8qZ9zis/25sn5lVoZdfNBEHy6byZ
         PUtAQFm9wRrDtQypwPYN/GTZtvmyPJS5NbMHa09z5mQiWvRYs5QE/Tb80pG2xHfcJT8h
         MSfHuowyED/tyt50nMJX/BjLdM7u3uME+FNfAd9CHvuX0u65QF9c0xQcCN8y6RCe4ch3
         VPr5mLochV+2S7nCgR1MoMYbHyuuwsfe1kF9wflLqlMEnnbyap2LeOf+BpU+TJMynnFc
         fYtSzmUTUXKKhRbRIhU6UxTaPKUWgtQitqm1+9cXyPQ7nsY8bWgZ60JXKHt9FKb+uIxt
         XSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gvlUkl/BBW4zkQJjn0ZzRqBgDUiuxYWCFGII7wtj7js=;
        b=bE8UHyBehpD3reBRsYsmx8Xn8vTu6gBvCnp01UO1XrSTr9ADy8FXu2DYthG63a3OI/
         o3+0x+7iDAinJDiBY0Aj3lpScBgP1eX7GtXTJgIaz/0OeV1vDzT7Eyi/ZFW3d20+qMc2
         C0Zh5+mB5PGVY2I6LruYjxuoQo1269AqKyFGU4HpKK7HJA/EVX017ZaXmaeaEgha9mCZ
         NGLaeMq/wRfCcPbW3HJfCjFe4MKPQKzjCIXWQT3HlFPP4H8nvgjB1ZgwOB3VyXw+a/FF
         ZKPOTas1UWEBGnSoBXqSgQkHnwtxch5An0NlbwI1E3TwBOUe9bqR5CYgJY45k++tuXR4
         SgtQ==
X-Gm-Message-State: AOAM532b0cwGJI5Pt2MQQObeiX/hib1vW+nJK4dlsaa+Bu1GPdV2dO0R
        BZ/wuXBrOVm5D8Kcy3iMK5feAVjDGbE=
X-Google-Smtp-Source: ABdhPJyRUdiL2J8yFL4dwY/BPxcFvAeXdRnYk+fOwkDsaDF6+ScQ65TJH+JAG5ivlMAjlCbRJvmI8g==
X-Received: by 2002:a17:90a:7c4c:b0:1dc:26a1:b82f with SMTP id e12-20020a17090a7c4c00b001dc26a1b82fmr24526840pjl.148.1652788778759;
        Tue, 17 May 2022 04:59:38 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id o9-20020a62f909000000b0050dc762813bsm8878337pfh.21.2022.05.17.04.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 04:59:38 -0700 (PDT)
Date:   Tue, 17 May 2022 20:59:31 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     YoMccU66auLAPEHa@casper.infradead.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] tracing: add ACCOUNT flag for allocations from marked
 slab caches
Message-ID: <YoOOI1Gw2mX9c8qZ@hyeyoo>
References: <8ef9de6a-7497-07f7-852c-befcc3843771@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef9de6a-7497-07f7-852c-befcc3843771@openvz.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 12:44:14PM +0300, Vasily Averin wrote:
> dSlab caches marked with SLAB_ACCOUNT force accounting for every
> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> Unfortunately, at the moment this flag is not visible in ftrace output,
> and this makes it difficult to analyze the accounted allocations.
> 
> This patch adds the __GFP_ACCOUNT flag for allocations from slab caches
> marked with SLAB_ACCOUNT to the ftrace output
> ---
> v2:
>  1) handle kmem_cache_alloc_node() too, thanks to Shakeel
>  2) rework kmem_cache_alloc* tracepoints to use cachep instead
>     of current cachep->*size parameters. Now kmalloc[_node] and
>     kmem_cache_alloc[_node] tracepoints do not use common template
> 
> NB: kmem_cache_alloc_node tracepoint in SLOB cannot be switched to cachep,
>     therefore it was replaced by kmalloc_node tracepoint.
> ---
> VvS: is this acceptable? Maybe I should split this patch?
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---
>  include/trace/events/kmem.h | 82 +++++++++++++++++++++++++++----------
>  mm/slab.c                   |  7 +---
>  mm/slab_common.c            |  7 ++--
>  mm/slob.c                   | 10 ++---
>  mm/slub.c                   |  6 +--
>  5 files changed, 71 insertions(+), 41 deletions(-)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index 71c141804222..3b4f96e4a607 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -9,7 +9,7 @@
>  #include <linux/tracepoint.h>
>  #include <trace/events/mmflags.h>
>  
> -DECLARE_EVENT_CLASS(kmem_alloc,
> +TRACE_EVENT(kmalloc,
>  
>  	TP_PROTO(unsigned long call_site,
>  		 const void *ptr,
> @@ -43,23 +43,41 @@ DECLARE_EVENT_CLASS(kmem_alloc,
>  		show_gfp_flags(__entry->gfp_flags))
>  );
>  
> -DEFINE_EVENT(kmem_alloc, kmalloc,
> +TRACE_EVENT(kmem_cache_alloc,
>  
> -	TP_PROTO(unsigned long call_site, const void *ptr,
> -		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
> +	TP_PROTO(unsigned long call_site,
> +		 const void *ptr,
> +		 struct kmem_cache *s,
> +		 gfp_t gfp_flags),
>  
> -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
> -);
> +	TP_ARGS(call_site, ptr, s, gfp_flags),
>  
> -DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
> +	TP_STRUCT__entry(
> +		__field(	unsigned long,	call_site	)
> +		__field(	const void *,	ptr		)
> +		__field(	size_t,		bytes_req	)
> +		__field(	size_t,		bytes_alloc	)
> +		__field(	unsigned long,	gfp_flags	)
> +	),
>  
> -	TP_PROTO(unsigned long call_site, const void *ptr,
> -		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
> +	TP_fast_assign(
> +		__entry->call_site	= call_site;
> +		__entry->ptr		= ptr;
> +		__entry->bytes_req	= s->object_size;
> +		__entry->bytes_alloc	= s->size;
> +		__entry->gfp_flags	= (__force unsigned long)gfp_flags |
> +				(s->flags & SLAB_ACCOUNT ? __GFP_ACCOUNT : 0);
> +	),

This is a bit of lie. SLAB_ACCOUNT is not a gfp flag.

IMO the problem here is that we don't know which cache kernel is allocating
from. What about just printing name of cache and remove bytes_req,
bytes_alloc?

And then you can check if the cache uses SLAB_ACCOUNT or not.

>  
> -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
> +	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
> +		(void *)__entry->call_site,
> +		__entry->ptr,
> +		__entry->bytes_req,
> +		__entry->bytes_alloc,
> +		show_gfp_flags(__entry->gfp_flags))
>  );
>  
> -DECLARE_EVENT_CLASS(kmem_alloc_node,
> +TRACE_EVENT(kmalloc_node,
>  
>  	TP_PROTO(unsigned long call_site,
>  		 const void *ptr,
> @@ -97,22 +115,42 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
>  		__entry->node)
>  );
>  
> -DEFINE_EVENT(kmem_alloc_node, kmalloc_node,
> +TRACE_EVENT(kmem_cache_alloc_node,
>  
> -	TP_PROTO(unsigned long call_site, const void *ptr,
> -		 size_t bytes_req, size_t bytes_alloc,
> -		 gfp_t gfp_flags, int node),
> +	TP_PROTO(unsigned long call_site,
> +		 const void *ptr,
> +		 struct kmem_cache *s,
> +		 gfp_t gfp_flags,
> +		 int node),
>  
> -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
> -);
> +	TP_ARGS(call_site, ptr, s, gfp_flags, node),
>  
> -DEFINE_EVENT(kmem_alloc_node, kmem_cache_alloc_node,
> +	TP_STRUCT__entry(
> +		__field(	unsigned long,	call_site	)
> +		__field(	const void *,	ptr		)
> +		__field(	size_t,		bytes_req	)
> +		__field(	size_t,		bytes_alloc	)
> +		__field(	unsigned long,	gfp_flags	)
> +		__field(	int,		node		)
> +	),
>  
> -	TP_PROTO(unsigned long call_site, const void *ptr,
> -		 size_t bytes_req, size_t bytes_alloc,
> -		 gfp_t gfp_flags, int node),
> +	TP_fast_assign(
> +		__entry->call_site	= call_site;
> +		__entry->ptr		= ptr;
> +		__entry->bytes_req	= s->object_size;
> +		__entry->bytes_alloc	= s->size;
> +		__entry->gfp_flags	= (__force unsigned long)gfp_flags |
> +				(s->flags & SLAB_ACCOUNT ? __GFP_ACCOUNT : 0);
> +		__entry->node		= node;
> +	),
> -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
> +	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
> +		(void *)__entry->call_site,
> +		__entry->ptr,
> +		__entry->bytes_req,
> +		__entry->bytes_alloc,
> +		show_gfp_flags(__entry->gfp_flags),
> +		__entry->node)
>  );
>  
>  TRACE_EVENT(kfree,
> diff --git a/mm/slab.c b/mm/slab.c
> index 0edb474edef1..935b1c90d7f0 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3492,8 +3492,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
>  {
>  	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
>  
> -	trace_kmem_cache_alloc(_RET_IP_, ret,
> -			       cachep->object_size, cachep->size, flags);
> +	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, flags);
>  
>  	return ret;
>  }
> @@ -3606,9 +3605,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
>  {
>  	void *ret = slab_alloc_node(cachep, flags, nodeid, cachep->object_size, _RET_IP_);
>  
> -	trace_kmem_cache_alloc_node(_RET_IP_, ret,
> -				    cachep->object_size, cachep->size,
> -				    flags, nodeid);
> +	trace_kmem_cache_alloc_node(_RET_IP_, ret, cachep, flags, nodeid);
>  
>  	return ret;
>  }
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 2b3206a2c3b5..12299cf450fe 100644
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
> diff --git a/mm/slob.c b/mm/slob.c
> index 40ea6e2d4ccd..69875419769c 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -610,14 +610,12 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
>  
>  	if (c->size < PAGE_SIZE) {
>  		b = slob_alloc(c->size, flags, c->align, node, 0);
> -		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
> -					    SLOB_UNITS(c->size) * SLOB_UNIT,
> -					    flags, node);
> +		trace_kmalloc_node(_RET_IP_, b, c->object_size,
> +				   SLOB_UNITS(c->size) * SLOB_UNIT, flags, node);
>  	} else {
>  		b = slob_new_pages(flags, get_order(c->size), node);
> -		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
> -					    PAGE_SIZE << get_order(c->size),
> -					    flags, node);
> +		trace_kmalloc_node(_RET_IP_, b, c->object_size,
> +				   PAGE_SIZE << get_order(c->size), flags, node);
>  	}
>  
>  	if (b && c->ctor) {
> diff --git a/mm/slub.c b/mm/slub.c
> index ed5c2c03a47a..fc6678269db0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3231,8 +3231,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  {
>  	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
>  
> -	trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
> -				s->size, gfpflags);
> +	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags);
>  
>  	return ret;
>  }
> @@ -3266,8 +3265,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
>  {
>  	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
>  
> -	trace_kmem_cache_alloc_node(_RET_IP_, ret,
> -				    s->object_size, s->size, gfpflags, node);
> +	trace_kmem_cache_alloc_node(_RET_IP_, ret, s, gfpflags, node);
>  
>  	return ret;
>  }
> -- 
> 2.31.1
> 
> 

-- 
Thanks,
Hyeonggon
