Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13786586CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiHAOhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiHAOhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:37:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4ED33A1C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:37:49 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 206so6360957pgb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4La+/TTqE7pmoTbyCn6Aak17r/OUWM6KiH/lhDYcZds=;
        b=UK3zY+SWxC3NVdhU/RyG7uoqtQEcFWVSKlN/ILHs2hpAcXCIu6KsnOe0fU2RPKKgbQ
         a164rGtltIJmtuHZ7aMkALsu4ZALa8ibcbyCLi8kXX1FvHSbffxAgjGGKOp2WCU9tzK6
         xawkHda9pxd8+xRxGQzWwNuJxhCLIul7WJFwQumqTBeeCBxfQTWhE0mjogg9hyPx1daF
         X1PDNCCAbEXN69u0HGdnquCpibNSLnNzX9cNSQDPnNqM7Tp42fZIHwGdB9KoLhdwEAxC
         mEG2n1Rt1ZZGjOivISWk3HvwzFlv7B00thDs2bgR5AOOA5q56+I0eMEhn8BwNXGsMtdd
         kcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4La+/TTqE7pmoTbyCn6Aak17r/OUWM6KiH/lhDYcZds=;
        b=7dc8EIndA/i4qBR+4hoAlkwdf+nh4W5SvuYG0IIb2Pm62E5O6iftMfgDz4q+arB+RN
         0unt1Bm13aQ+J648MH6rx4tl887k6qfoAc6BoJRycF9Ks759B/CFykCAVQFAyjXxZBzZ
         MU2igDPzy0BRt1cjZI5iTCkfAoBHZ431jLrf7Fuew2/wm5wQNQ2T+Y+ubMaPX92Wuyh+
         873vZLwloIioJO52jfTqHzWschwePHvfaMlqKV5l0lktlPgDdugk5ODbLqEpN+0BkApw
         FN/mRO+BG8B6O/fkAAGAeQebIoSHhzha/On+Pqnb/G9r2WCtcVKVexWUvf1O+1A2jGCQ
         sCqQ==
X-Gm-Message-State: AJIora/Pukzcx8ZMV1AT7OQJexfE7zuLu+4b+YIyLsX/lMdyVNWdg01N
        hXWZF4dt/nDMtnDSARxWC+4=
X-Google-Smtp-Source: AGRyM1sJFoxULt0qX+w1Z+xBlsAYIQQgLwcQ2Pbr5wjpQVXw0VRgWBUlQbmmACH8lew5/5Vkq9o4gw==
X-Received: by 2002:a05:6a00:a8b:b0:4e1:52db:9e5c with SMTP id b11-20020a056a000a8b00b004e152db9e5cmr16391691pfl.38.1659364668567;
        Mon, 01 Aug 2022 07:37:48 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902ce0500b0016bc947c5b7sm9707228plg.38.2022.08.01.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 07:37:47 -0700 (PDT)
Date:   Mon, 1 Aug 2022 23:37:41 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 08/15] mm/slab_common: kmalloc_node: pass large
 requests to page allocator
Message-ID: <YuflNcUsyfQjculC@hyeyoo>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-9-42.hyeyoo@gmail.com>
 <a26f9cb0-7781-3bdc-4536-0ac06f2483b1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a26f9cb0-7781-3bdc-4536-0ac06f2483b1@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 06:09:27PM +0200, Vlastimil Babka wrote:
> On 7/12/22 15:39, Hyeonggon Yoo wrote:
> > Now that kmalloc_large_node() is in common code, pass large requests
> > to page allocator in kmalloc_node() using kmalloc_large_node().
> > 
> > One problem is that currently there is no tracepoint in
> > kmalloc_large_node(). Instead of simply putting tracepoint in it,
> > use kmalloc_large_node{,_notrace} depending on its caller to show
> > useful address for both inlined kmalloc_node() and
> > __kmalloc_node_track_caller() when large objects are allocated.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks!

> Nit below:
> 
> > ---
> >  v3:
> > 	This patch is new in v3 and this avoids
> > 	missing caller in __kmalloc_large_node_track_caller()
> > 	when kmalloc_large_node() is called.
> > 
> >  include/linux/slab.h | 26 +++++++++++++++++++-------
> >  mm/slab.h            |  2 ++
> >  mm/slab_common.c     | 17 ++++++++++++++++-
> >  mm/slub.c            |  2 +-
> >  4 files changed, 38 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 082499306098..fd2e129fc813 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -571,23 +571,35 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
> >  	return __kmalloc(size, flags);
> >  }
> >  
> > +#ifndef CONFIG_SLOB
> >  static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> >  {
> > -#ifndef CONFIG_SLOB
> > -	if (__builtin_constant_p(size) &&
> > -		size <= KMALLOC_MAX_CACHE_SIZE) {
> > -		unsigned int i = kmalloc_index(size);
> > +	if (__builtin_constant_p(size)) {
> > +		unsigned int index;
> >  
> > -		if (!i)
> > +		if (size > KMALLOC_MAX_CACHE_SIZE)
> > +			return kmalloc_large_node(size, flags, node);
> > +
> > +		index = kmalloc_index(size);
> > +
> > +		if (!index)
> >  			return ZERO_SIZE_PTR;
> >  
> >  		return kmem_cache_alloc_node_trace(
> > -				kmalloc_caches[kmalloc_type(flags)][i],
> > +				kmalloc_caches[kmalloc_type(flags)][index],
> >  						flags, node, size);
> >  	}
> > -#endif
> >  	return __kmalloc_node(size, flags, node);
> >  }
> > +#else
> > +static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> > +{
> > +	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> > +		return kmalloc_large_node(size, flags, node);
> > +
> > +	return __kmalloc_node(size, flags, node);
> > +}
> > +#endif
> >  
> >  /**
> >   * kmalloc_array - allocate memory for an array.
> > diff --git a/mm/slab.h b/mm/slab.h
> > index a8d5eb1c323f..7cb51ff44f0c 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -273,6 +273,8 @@ void create_kmalloc_caches(slab_flags_t);
> >  
> >  /* Find the kmalloc slab corresponding for a certain size */
> >  struct kmem_cache *kmalloc_slab(size_t, gfp_t);
> > +
> > +void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node);
> >  #endif
> >  
> >  gfp_t kmalloc_fix_flags(gfp_t flags);
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 6f855587b635..dc872e0ef0fc 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -956,7 +956,8 @@ void *kmalloc_large(size_t size, gfp_t flags)
> >  }
> >  EXPORT_SYMBOL(kmalloc_large);
> >  
> > -void *kmalloc_large_node(size_t size, gfp_t flags, int node)
> > +static __always_inline
> 
> I don't think we need to inline, compiler should be able to make
> kmalloc_large_node(_notrace) quite efficient anyway.

You mean s/static __always_inline/static/g, or like this?

kmalloc_large_node_notrace():
	fold __kmalloc_large_node_notrace() into here

kmalloc_large_node():
	kmalloc_large_node_notrace()
	trace_kmalloc()

I have no strong opinion.

IMO It's unlikely that there would be workloads that are
meaningfully affected by inlining or not inlining __kmalloc_large_node_notrace().
Just wanted to avoid adding even tiny of overhead by this series.

> 
> > +void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
> >  {
> >  	struct page *page;
> >  	void *ptr = NULL;
> > @@ -976,6 +977,20 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
> >  
> >  	return ptr;
> >  }
> > +
> > +void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
> > +{
> > +	return __kmalloc_large_node_notrace(size, flags, node);
> > +}
> > +
> > +void *kmalloc_large_node(size_t size, gfp_t flags, int node)
> > +{
> > +	void *ret = __kmalloc_large_node_notrace(size, flags, node);
> > +
> > +	trace_kmalloc_node(_RET_IP_, ret, NULL, size,
> > +			   PAGE_SIZE << get_order(size), flags, node);
> > +	return ret;
> > +}
> >  EXPORT_SYMBOL(kmalloc_large_node);
> >  
> >  #ifdef CONFIG_SLAB_FREELIST_RANDOM
> > diff --git a/mm/slub.c b/mm/slub.c
> > index f22a84dd27de..3d02cf44adf7 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4401,7 +4401,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
> >  	void *ret;
> >  
> >  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> > -		ret = kmalloc_large_node(size, flags, node);
> > +		ret = kmalloc_large_node_notrace(size, flags, node);
> >  
> >  		trace_kmalloc_node(caller, ret, NULL,
> >  				   size, PAGE_SIZE << get_order(size),
> 

-- 
Thanks,
Hyeonggon
