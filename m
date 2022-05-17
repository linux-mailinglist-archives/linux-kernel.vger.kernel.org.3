Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E864652A362
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347785AbiEQN3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347799AbiEQN3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:29:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474774705F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:29:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a11so16901241pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+EPish+mrSvGMlugaYsp/hj+HbUv1tOHcvdoYDFMU50=;
        b=U+ft39WXLfz5BURlNF2xfDGqiD8mKFTLSuSjjVrY8GNFrAqi5aiZmFzWiyJD8jF7Kh
         i8pryLD3i5Ge9ofKiKMwmLEHhBWlPZ10Se/4QibleB3rD6RHVLenBF3DAXzYiRaUn6/c
         86j/iVF2UfZK80TBSsLyjzv3EnRKrlcrTJkSfqQgmUL3A/R08e3kKiGH4uOjWjrgfzA9
         GBogXDfi0Fwj/yQXdjMYj/ss83Pin8XSdgv65RgoWvuYgOq6bHj2ZgwYrSQ8Vrlcy6vi
         ODxTf3OKG6amIPDJeIj7daN7puClDTJkBV91jS9+B+twGmHFlMOyDSnb00a6oOjKXqsL
         OGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+EPish+mrSvGMlugaYsp/hj+HbUv1tOHcvdoYDFMU50=;
        b=piPNh1qv3MNDQlCwe6l8WvpkMAWE6Yhl/ZxF3uomNZ5RALXg44dp2LVH4T2AB0hFJ+
         p/h9kbHWmPNWZK1001+CKN+gtwI+yr2rkGvcPDXX/dFLkjN9uwWxDYeZM5InsxtNPFdr
         KZ0Figs/6hjIPowJmWdAoIADhncxK/F9LhuUnUmeD7MMQRHp/Hww0QgA/631PoEyrGNP
         Fz3KSCehxjglMtuvnMOTpKTBzrEoEtoyQ4969d+6gbVLRJt+dtq3beI2E6+alfL6gmcy
         9STzI6BK06rdQedFUlhGptJZGazMsi98YGsov2rWrUHAQfGNweQmLNT01mno5hQgqOSl
         Of/A==
X-Gm-Message-State: AOAM533WZdHudHkbJ7iUuur10t3IdlayZX1mNsqNLzrqhe0OFPTQvd96
        Fx58rFAf6actkcinlvPrvfdlIw==
X-Google-Smtp-Source: ABdhPJwa40qG9PO39EGGS11h9k4RbrhHjKO6J4GlJn4jQb2sjJ7HymyZpMwfFvgEXqB2i5T8g5JBXw==
X-Received: by 2002:a63:8ac1:0:b0:3db:515d:76d2 with SMTP id y184-20020a638ac1000000b003db515d76d2mr20034744pgd.152.1652794144749;
        Tue, 17 May 2022 06:29:04 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id c2-20020a62f842000000b0050dc762813csm9068864pfm.22.2022.05.17.06.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:29:04 -0700 (PDT)
Date:   Tue, 17 May 2022 21:29:01 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     YoMccU66auLAPEHa@casper.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <YoOjHYWwN38qWjVI@FVFYT0MHHV2J.usts.net>
References: <8ef9de6a-7497-07f7-852c-befcc3843771@openvz.org>
 <YoOOI1Gw2mX9c8qZ@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoOOI1Gw2mX9c8qZ@hyeyoo>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 08:59:31PM +0900, Hyeonggon Yoo wrote:
> On Tue, May 17, 2022 at 12:44:14PM +0300, Vasily Averin wrote:
> > dSlab caches marked with SLAB_ACCOUNT force accounting for every
> > allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> > Unfortunately, at the moment this flag is not visible in ftrace output,
> > and this makes it difficult to analyze the accounted allocations.
> > 
> > This patch adds the __GFP_ACCOUNT flag for allocations from slab caches
> > marked with SLAB_ACCOUNT to the ftrace output
> > ---
> > v2:
> >  1) handle kmem_cache_alloc_node() too, thanks to Shakeel
> >  2) rework kmem_cache_alloc* tracepoints to use cachep instead
> >     of current cachep->*size parameters. Now kmalloc[_node] and
> >     kmem_cache_alloc[_node] tracepoints do not use common template
> > 
> > NB: kmem_cache_alloc_node tracepoint in SLOB cannot be switched to cachep,
> >     therefore it was replaced by kmalloc_node tracepoint.
> > ---
> > VvS: is this acceptable? Maybe I should split this patch?
> > 
> > Signed-off-by: Vasily Averin <vvs@openvz.org>
> > ---
> >  include/trace/events/kmem.h | 82 +++++++++++++++++++++++++++----------
> >  mm/slab.c                   |  7 +---
> >  mm/slab_common.c            |  7 ++--
> >  mm/slob.c                   | 10 ++---
> >  mm/slub.c                   |  6 +--
> >  5 files changed, 71 insertions(+), 41 deletions(-)
> > 
> > diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> > index 71c141804222..3b4f96e4a607 100644
> > --- a/include/trace/events/kmem.h
> > +++ b/include/trace/events/kmem.h
> > @@ -9,7 +9,7 @@
> >  #include <linux/tracepoint.h>
> >  #include <trace/events/mmflags.h>
> >  
> > -DECLARE_EVENT_CLASS(kmem_alloc,
> > +TRACE_EVENT(kmalloc,
> >  
> >  	TP_PROTO(unsigned long call_site,
> >  		 const void *ptr,
> > @@ -43,23 +43,41 @@ DECLARE_EVENT_CLASS(kmem_alloc,
> >  		show_gfp_flags(__entry->gfp_flags))
> >  );
> >  
> > -DEFINE_EVENT(kmem_alloc, kmalloc,
> > +TRACE_EVENT(kmem_cache_alloc,
> >  
> > -	TP_PROTO(unsigned long call_site, const void *ptr,
> > -		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
> > +	TP_PROTO(unsigned long call_site,
> > +		 const void *ptr,
> > +		 struct kmem_cache *s,
> > +		 gfp_t gfp_flags),
> >  
> > -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
> > -);
> > +	TP_ARGS(call_site, ptr, s, gfp_flags),
> >  
> > -DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
> > +	TP_STRUCT__entry(
> > +		__field(	unsigned long,	call_site	)
> > +		__field(	const void *,	ptr		)
> > +		__field(	size_t,		bytes_req	)
> > +		__field(	size_t,		bytes_alloc	)
> > +		__field(	unsigned long,	gfp_flags	)
> > +	),
> >  
> > -	TP_PROTO(unsigned long call_site, const void *ptr,
> > -		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
> > +	TP_fast_assign(
> > +		__entry->call_site	= call_site;
> > +		__entry->ptr		= ptr;
> > +		__entry->bytes_req	= s->object_size;
> > +		__entry->bytes_alloc	= s->size;
> > +		__entry->gfp_flags	= (__force unsigned long)gfp_flags |
> > +				(s->flags & SLAB_ACCOUNT ? __GFP_ACCOUNT : 0);
> > +	),
> 
> This is a bit of lie. SLAB_ACCOUNT is not a gfp flag.
>

Maybe it is not a problem since the functionalities of SLAB_ACCOUNT and
__GFP_ACCOUNT are similar.
 
> IMO the problem here is that we don't know which cache kernel is allocating
> from. What about just printing name of cache and remove bytes_req,
> bytes_alloc?

Is it a problem? Because we have changed the behavior to users. Should
we treat the tracepoint as a stable API to users? If so, I think we
should not change the parameter of this tracepoint.  Maybe I am wrong,
just some thoughts from me.

Thanks.

> 
> And then you can check if the cache uses SLAB_ACCOUNT or not.
> 
