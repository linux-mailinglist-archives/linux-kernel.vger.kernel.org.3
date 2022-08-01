Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD1586BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiHAN0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHAN0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:26:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56792C132
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:26:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b4so490022pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pUtXn4Srqiw98c6ZMfop0pBP7n47z1GuwAi8jghCZ+s=;
        b=nssGIGZzaChy7gP3PfoTd0xKjIuhzB+EN89wB23nWZKgpFHs8X4ZYyZMT2A4Dably7
         K0m3rkRyhLPmzsbIAEa5dNlOoOKcDAu3abQDIpGO88sSiPlknQ8lUAM9fMbIkbdQLCxo
         DIfkQzOonSJl/nx3G5ktS1Y8/nO5sr/FE/bWpdlONqICKh2Bd0j4/v4JEJq5Gp/I+3J7
         ULAhimTAlK6h5TuSmZaNN5OALJkHQZWF6rFMeaSUu133a8AapB7pIWcTz7bWkrqYYyVn
         iicZd5LNfkNW+CQR37jSKBPwvjPvUBwQl64LUtTqNaI5nREpirkXUKGRvB9OLKhhflPF
         bddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pUtXn4Srqiw98c6ZMfop0pBP7n47z1GuwAi8jghCZ+s=;
        b=Fczm3/mgl2vmA/YIbVo7drtMsxlByxiEUWiXNM/fJXSvtpB60tqMLLLnu95llLuJRA
         TvukeVtyoltzIQeluFpkDzPHdzcd/mDl7lSpPRzgzz0WrHCVWi93aieMBx2889MVwCfv
         VL6Uy0y6kJryxHcL6aOJTAUH4ivy3E5XVNlBS3c3DtIYlW8L+afD5R7paUIxOBMoDdJE
         nfoFQipMEUsnRpookCxE7T1kG8hgD61I3RyP/tLSMbJcPMbtpg9UXygJGZLYPDH0W8u1
         3pbk+Z3UX2EGgENwhlHvcF2hN2WxrJeZNM+x1aQxYleVfbTDVAXKg4kgAoRx31cyFg3I
         FvBg==
X-Gm-Message-State: ACgBeo2FBKDGmqfVAhBMHzaIZ3nKqT8c9cfhLtPh6elMg0ASvSQMxTtw
        XTu569mBt+lVJZTMnIPImiPPWLE2rbU=
X-Google-Smtp-Source: AA6agR7UbWrfPscOda8d2YX/X0p2+YAfWSSfxporgvGpT/DyslGeD5zt05U/LKt0ZZj/wqamXvWjhA==
X-Received: by 2002:a17:902:f549:b0:16c:483f:3a9f with SMTP id h9-20020a170902f54900b0016c483f3a9fmr16623571plf.134.1659360392234;
        Mon, 01 Aug 2022 06:26:32 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id n12-20020a170903110c00b0016c1b178628sm9651426plh.269.2022.08.01.06.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:26:31 -0700 (PDT)
Date:   Mon, 1 Aug 2022 22:26:24 +0900
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
Subject: Re: [PATCH v3 06/15] mm/slab_common: fold kmalloc_order_trace() into
 kmalloc_large()
Message-ID: <YufUgFX2shlG5FoR@hyeyoo>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-7-42.hyeyoo@gmail.com>
 <2e252179-0ffe-0d9c-9340-77e46f6ffdfd@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e252179-0ffe-0d9c-9340-77e46f6ffdfd@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 05:23:29PM +0200, Vlastimil Babka wrote:
> On 7/12/22 15:39, Hyeonggon Yoo wrote:
> > There is no caller of kmalloc_order_trace() except kmalloc_large().
> > Fold it into kmalloc_large() and remove kmalloc_order{,_trace}().
> > 
> > Also add tracepoint in kmalloc_large() that was previously
> > in kmalloc_order_trace().
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 

Thank you for review.

> Hmm noticed a small change in how we call trace_kmalloc() which will now
> include the __GFP_COMP.

Good catch.

> I think we could just call alloc_pages() from
> kmalloc_large() with flags | __GFP_COMP instead of doing flags |=
> __GFP_COMP; first.

I'll consider that in next version.

> AFAICS both kasan_kmalloc_large() and kmemleak_alloc()
> will filter it out anyway.

AFAIK not passing __GFP_COMP to both kasan_kmalloc_large()
and kmemleak_alloc() will affect their behavior.

- kasan_kmalloc_large() only checks if flag has __GFP_DIRECT_RECLAIM,
- kmemleak_alloc() only use it to allocate kmemleak_object from
  slab/pool, which does not require __GFP_COMP.

simply calling
	alloc_pages() with flags | GFP_COMP
	kasan_kmalloc_large() with flags
	kmemleak_alloc() with flags
	trace_kmalloc() with flags
will be okay.

BTW this is fixed after patch 9.

> > ---
> >  include/linux/slab.h | 22 ++--------------------
> >  mm/slab_common.c     | 14 +++-----------
> >  2 files changed, 5 insertions(+), 31 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index a0e57df3d5a4..15a4c59da59e 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -489,26 +489,8 @@ static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, g
> >  }
> >  #endif /* CONFIG_TRACING */
> >  
> > -extern void *kmalloc_order(size_t size, gfp_t flags, unsigned int order) __assume_page_alignment
> > -									 __alloc_size(1);
> > -
> > -#ifdef CONFIG_TRACING
> > -extern void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
> > -				__assume_page_alignment __alloc_size(1);
> > -#else
> > -static __always_inline __alloc_size(1) void *kmalloc_order_trace(size_t size, gfp_t flags,
> > -								 unsigned int order)
> > -{
> > -	return kmalloc_order(size, flags, order);
> > -}
> > -#endif
> > -
> > -static __always_inline __alloc_size(1) void *kmalloc_large(size_t size, gfp_t flags)
> > -{
> > -	unsigned int order = get_order(size);
> > -	return kmalloc_order_trace(size, flags, order);
> > -}
> > -
> > +void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
> > +					      __alloc_size(1);
> >  /**
> >   * kmalloc - allocate memory
> >   * @size: how many bytes of memory are required.
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 6c9aac5d8f4a..1f8af2106df0 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -932,10 +932,11 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
> >   * directly to the page allocator. We use __GFP_COMP, because we will need to
> >   * know the allocation order to free the pages properly in kfree.
> >   */
> > -void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
> > +void *kmalloc_large(size_t size, gfp_t flags)
> >  {
> >  	void *ret = NULL;
> >  	struct page *page;
> > +	unsigned int order = get_order(size);
> >  
> >  	if (unlikely(flags & GFP_SLAB_BUG_MASK))
> >  		flags = kmalloc_fix_flags(flags);
> > @@ -950,19 +951,10 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
> >  	ret = kasan_kmalloc_large(ret, size, flags);
> >  	/* As ret might get tagged, call kmemleak hook after KASAN. */
> >  	kmemleak_alloc(ret, size, 1, flags);
> > -	return ret;
> > -}
> > -EXPORT_SYMBOL(kmalloc_order);
> > -
> > -#ifdef CONFIG_TRACING
> > -void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
> > -{
> > -	void *ret = kmalloc_order(size, flags, order);
> >  	trace_kmalloc(_RET_IP_, ret, NULL, size, PAGE_SIZE << order, flags);
> >  	return ret;
> >  }
> > -EXPORT_SYMBOL(kmalloc_order_trace);
> > -#endif
> > +EXPORT_SYMBOL(kmalloc_large);
> >  
> >  #ifdef CONFIG_SLAB_FREELIST_RANDOM
> >  /* Randomize a generic freelist */
> 

-- 
Thanks,
Hyeonggon
