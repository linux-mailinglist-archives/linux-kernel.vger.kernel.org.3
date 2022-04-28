Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64154512BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244133AbiD1GjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244211AbiD1GjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:39:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EEF2AE2C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:35:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fv2so3433627pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=je+NIN2tqYCJVyGuE6IZ8E75zX+G/y6Jcrh/L/hmAO4=;
        b=WcW3l8sNZlr4GeSgE/0AsPX5QCUuFAeIWVTPz6Wvf7L/gk2NtcG2lBzDzWZzN0auvS
         fBOWczjbJbb8Xj9Mwn3sLjkUziNyKPwaUplBWC9Yux3giayuW1GTTXzXKc63fpoplGbx
         +xgMjyRssxbSaNStiMx1/5l67+cxNGdcbxmM7dQX+M7TZ17xE3RVmMOnlJxdZdm/NBU2
         +uxrglX5dKNBNThKRhHXHiTvomYUGKHLJyaURzkXmn13zYsJtM6Qh8RbCHG9RaVcjuEO
         rThauw3+5miHZae8St/Wkxk5ukqxkwzDaxyCE8oJ6nvIQJXUISU93WTOv/osLiZhEe1z
         y7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=je+NIN2tqYCJVyGuE6IZ8E75zX+G/y6Jcrh/L/hmAO4=;
        b=bEiXSMb+CuwdR1IWh619jiS4MPymM3StWrpl5WKyKo++qZ8UT7hxEWUknq5tirrLt+
         ZNfGDiuIrVWLJwdxx2LDyMUVpugWkqLZ4JlnkJUWtkptGODTDnDDBrJoxYFdad3VUXUo
         YMjR61XSoZHBBcY1xwDIj56ZE0B08TWvBbGF1vQF9JGn2Aw+ns7Hz2wQPuldpVAZIyyL
         awV0er75/XYMzAC1XoKmnycdUarXFBhbrOUyeauJ1IzGTGtV2jwM0kjF2YVz7eCPkX2N
         0xN1R9biV5X8B1FOBKsAS21PyCqoSiaFA9ZERBBfsoC6VZ7BQZkfB9XJPEzQaOembu2q
         10bw==
X-Gm-Message-State: AOAM532THlRDR13AjR9RgTmCzLXsiNfbIAZpukNKaFj6cTvI+xeRWgnx
        syQlMC2KqY3OyNCiHfA6bQgm4e1XZFU=
X-Google-Smtp-Source: ABdhPJwA7IN09vN19LfhACsDYw/Fap9B8MfDsbk6ipd8F2IYm5dLm9ybHm1UIDR0xfNEJe5evKb26A==
X-Received: by 2002:a17:90b:3b82:b0:1da:49fe:d057 with SMTP id pc2-20020a17090b3b8200b001da49fed057mr6059314pjb.32.1651127749204;
        Wed, 27 Apr 2022 23:35:49 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id t29-20020a62d15d000000b0050d42864753sm12485670pfl.49.2022.04.27.23.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 23:35:48 -0700 (PDT)
Date:   Thu, 28 Apr 2022 15:35:42 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/23] mm/slab_common: make kmalloc_large_node()
 consistent with kmalloc_large()
Message-ID: <Ymo1vi0JrGVxaQB1@hyeyoo>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-9-42.hyeyoo@gmail.com>
 <37811df5-b0f5-355b-41cf-2e491fb3cd6c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37811df5-b0f5-355b-41cf-2e491fb3cd6c@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 07:15:06PM +0200, Vlastimil Babka wrote:
> On 4/14/22 10:57, Hyeonggon Yoo wrote:
> > Move tracepoints into kmalloc_large_node() and add missing flag fix code.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 

Hello Vlastimil, thanks for review! ;-)

> Hm so there's a problem with the tracepoint's caller.
> 
> kmalloc_large() is only called from kmalloc() which is an inline  thus the
> callsite of kmalloc() calls directly kmalloc_large().
> So when kmalloc_large() does "trace_kmalloc(_RET_IP_, ...)" the _RET_IP_ is the
> callsite of kmalloc(), which is what we want.

kmalloc_large() had the exact problem before my series when called from __kmalloc().

On top of current slab/for-next:
  [000] .....    43.172574: kmalloc: call_site=__kmalloc+0x2aa/0x300 ptr=ffff88e2183a0000 bytes_req=12368 bytes_alloc=16384 gfp_flags=GFP_KERNEL

Considering different usecases of kmalloc_large_node() (called from kmalloc_node() or __kmalloc_node()),
I think we need trace/notrace version of kmalloc_large_node().

> 
> But with kmalloc_large_node()...
> 
> > ---
> >  mm/slab_common.c |  6 ++++++
> >  mm/slub.c        | 22 ++++------------------
> >  2 files changed, 10 insertions(+), 18 deletions(-)
> > 
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index e72089515030..cf17be8cd9ad 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -955,6 +955,9 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
> >  	void *ptr = NULL;
> >  	unsigned int order = get_order(size);
> >  
> > +	if (unlikely(flags & GFP_SLAB_BUG_MASK))
> > +		flags = kmalloc_fix_flags(flags);
> > +
> >  	flags |= __GFP_COMP;
> >  	page = alloc_pages_node(node, flags, order);
> >  	if (page) {
> > @@ -966,6 +969,9 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
> >  	ptr = kasan_kmalloc_large(ptr, size, flags);
> >  	/* As ptr might get tagged, call kmemleak hook after KASAN. */
> >  	kmemleak_alloc(ptr, size, 1, flags);
> > +	trace_kmalloc_node(_RET_IP_, ptr,
> > +			   size, PAGE_SIZE << order,
> > +			   flags, node);
> 
> ... the _RET_IP_ here would be __kmalloc_node() which is not useful.
> 
> >  	return ptr;
> >  }
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 640712706f2b..f10a892f1772 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4396,15 +4396,8 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
> >  	struct kmem_cache *s;
> >  	void *ret;
> >  
> > -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> > -		ret = kmalloc_large_node(size, flags, node);
> > -
> > -		trace_kmalloc_node(_RET_IP_, ret,
> > -				   size, PAGE_SIZE << get_order(size),
> > -				   flags, node);
> 
> Here it was OK because __kmalloc_node is expanded from something inline
> coming from slab.h.
> 
> > -
> > -		return ret;
> > -	}
> > +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> > +		return kmalloc_large_node(size, flags, node);
> >  
> >  	s = kmalloc_slab(size, flags);
> >  
> > @@ -4861,15 +4854,8 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
> >  	struct kmem_cache *s;
> >  	void *ret;
> >  
> > -	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
> > -		ret = kmalloc_large_node(size, gfpflags, node);
> > -
> > -		trace_kmalloc_node(caller, ret,
> > -				   size, PAGE_SIZE << get_order(size),
> > -				   gfpflags, node);
> > -
> > -		return ret;
> > -	}
> > +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> > +		return kmalloc_large_node(size, gfpflags, node);
> 
> And here it even forgets the 'caller'.
>

Thanks for catching this.
I think notrace version + tracepoint would fit here.

> >  
> >  	s = kmalloc_slab(size, gfpflags);
> >  
> 

-- 
Thanks,
Hyeonggon
