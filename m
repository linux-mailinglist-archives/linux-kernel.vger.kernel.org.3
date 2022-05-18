Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD6852B6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiERJid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiERJiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:38:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D431238AF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:38:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q18so1239163pln.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s5ocU6sZ59/8dYavSeNm47P+W9gYWl3NcTuJSVhqmts=;
        b=LapNiWLpFboVMUEpHLPuY8Apyk1JZh6YqIl6W3AQV5DRaBcrsKSzx6KZi50sa0pl02
         E02XCW/XMMLEtO6yzKe75b3DbXP9VWRI0/IhiDinUVm9kaQ5oSUSpEnUqpOcoNaY8hGk
         O4fLzYEcHbsbNkXmtriJuBXRP+/jHB0a+06DoWyrkpfHPq9s9hgHgr3LWApp9V4JFaBe
         S/bZiWeqGauY7pACsuJr0/Tei20A1ybesaquZSv7KtU0/DWtJI52iCfPqp7G/1dxtCLb
         XNq8jMGKEwDX7NZOBM1fZ22OIHuOWdLFt8UyxzvwpI8iELumo1qUe8FPFzr/7l3rF0hs
         5UuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s5ocU6sZ59/8dYavSeNm47P+W9gYWl3NcTuJSVhqmts=;
        b=qsQwI9dhxk2mIPQFYvpOzA9h86PVZH3hVMXxEeA/QisECnYUDc6saKBuvHHu/5LlYJ
         emrMe6FL7mijgWisO7syN1YNbWJuB6wXRBTPihLYWKG9aOCTk1Un48pHnYvKwevaxnjP
         tKvetkfPZZ/cEP0frT2vMFJ4u9tKG1OY8LbY6qZ1V1rqAypeVrADeiAPbqpXgvglg3Sw
         MNykYocDNKBdt82tLBhD81wWHWP1pnYadezjh7WX6F9wHxbNBtfk+YHL1Vm1/5pTTZvJ
         xb9gbGMVL2JLVNwHMzEEAdAtqPBueg0YnD3iMXwV7choLymcPc6+gdqt02lv+P4zrKAM
         G6Mw==
X-Gm-Message-State: AOAM5337VE312xGFazJZ0C8iN9yc2zA8Uag0jAA3vgTP8eeUz7PsP2dt
        jYT7wYm9iEFa+Vfb5BL4K6k=
X-Google-Smtp-Source: ABdhPJw6V3vMehx2F89UM8zUOAvrs1ngHnXhuJ6OvAgXGqgAOSiKoAL5nCvilouq02QXy7OJRpMemA==
X-Received: by 2002:a17:902:f809:b0:161:44a5:3349 with SMTP id ix9-20020a170902f80900b0016144a53349mr21134746plb.140.1652866683373;
        Wed, 18 May 2022 02:38:03 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id b1-20020a62a101000000b0050dc7628196sm1393215pff.112.2022.05.18.02.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 02:38:02 -0700 (PDT)
Date:   Wed, 18 May 2022 18:37:54 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Muchun Song <songmuchun@bytedance.com>
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
Message-ID: <YoS+cjzcReZK47sn@hyeyoo>
References: <8ef9de6a-7497-07f7-852c-befcc3843771@openvz.org>
 <YoOOI1Gw2mX9c8qZ@hyeyoo>
 <YoOjHYWwN38qWjVI@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoOjHYWwN38qWjVI@FVFYT0MHHV2J.usts.net>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 09:29:01PM +0800, Muchun Song wrote:
> On Tue, May 17, 2022 at 08:59:31PM +0900, Hyeonggon Yoo wrote:
> > On Tue, May 17, 2022 at 12:44:14PM +0300, Vasily Averin wrote:
> > > dSlab caches marked with SLAB_ACCOUNT force accounting for every
> > > allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> > > Unfortunately, at the moment this flag is not visible in ftrace output,
> > > and this makes it difficult to analyze the accounted allocations.
> > > 
> > > This patch adds the __GFP_ACCOUNT flag for allocations from slab caches
> > > marked with SLAB_ACCOUNT to the ftrace output
> > > ---
> > > v2:
> > >  1) handle kmem_cache_alloc_node() too, thanks to Shakeel
> > >  2) rework kmem_cache_alloc* tracepoints to use cachep instead
> > >     of current cachep->*size parameters. Now kmalloc[_node] and
> > >     kmem_cache_alloc[_node] tracepoints do not use common template
> > > 
> > > NB: kmem_cache_alloc_node tracepoint in SLOB cannot be switched to cachep,
> > >     therefore it was replaced by kmalloc_node tracepoint.
> > > ---
> > > VvS: is this acceptable? Maybe I should split this patch?
> > > 
> > > Signed-off-by: Vasily Averin <vvs@openvz.org>
> > > ---
> > >  include/trace/events/kmem.h | 82 +++++++++++++++++++++++++++----------
> > >  mm/slab.c                   |  7 +---
> > >  mm/slab_common.c            |  7 ++--
> > >  mm/slob.c                   | 10 ++---
> > >  mm/slub.c                   |  6 +--
> > >  5 files changed, 71 insertions(+), 41 deletions(-)
> > > 
> > > diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> > > index 71c141804222..3b4f96e4a607 100644
> > > --- a/include/trace/events/kmem.h
> > > +++ b/include/trace/events/kmem.h
> > > @@ -9,7 +9,7 @@
> > >  #include <linux/tracepoint.h>
> > >  #include <trace/events/mmflags.h>
> > >  
> > > -DECLARE_EVENT_CLASS(kmem_alloc,
> > > +TRACE_EVENT(kmalloc,
> > >  
> > >  	TP_PROTO(unsigned long call_site,
> > >  		 const void *ptr,
> > > @@ -43,23 +43,41 @@ DECLARE_EVENT_CLASS(kmem_alloc,
> > >  		show_gfp_flags(__entry->gfp_flags))
> > >  );
> > >  
> > > -DEFINE_EVENT(kmem_alloc, kmalloc,
> > > +TRACE_EVENT(kmem_cache_alloc,
> > >  
> > > -	TP_PROTO(unsigned long call_site, const void *ptr,
> > > -		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
> > > +	TP_PROTO(unsigned long call_site,
> > > +		 const void *ptr,
> > > +		 struct kmem_cache *s,
> > > +		 gfp_t gfp_flags),
> > >  
> > > -	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
> > > -);
> > > +	TP_ARGS(call_site, ptr, s, gfp_flags),
> > >  
> > > -DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
> > > +	TP_STRUCT__entry(
> > > +		__field(	unsigned long,	call_site	)
> > > +		__field(	const void *,	ptr		)
> > > +		__field(	size_t,		bytes_req	)
> > > +		__field(	size_t,		bytes_alloc	)
> > > +		__field(	unsigned long,	gfp_flags	)
> > > +	),
> > >  
> > > -	TP_PROTO(unsigned long call_site, const void *ptr,
> > > -		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
> > > +	TP_fast_assign(
> > > +		__entry->call_site	= call_site;
> > > +		__entry->ptr		= ptr;
> > > +		__entry->bytes_req	= s->object_size;
> > > +		__entry->bytes_alloc	= s->size;
> > > +		__entry->gfp_flags	= (__force unsigned long)gfp_flags |
> > > +				(s->flags & SLAB_ACCOUNT ? __GFP_ACCOUNT : 0);
> > > +	),
> > 
> > This is a bit of lie. SLAB_ACCOUNT is not a gfp flag.
> >
> 
> Maybe it is not a problem since the functionalities of SLAB_ACCOUNT and
> __GFP_ACCOUNT are similar.
>
> > IMO the problem here is that we don't know which cache kernel is allocating
> > from. What about just printing name of cache and remove bytes_req,
> > bytes_alloc?
> 
> Is it a problem? 

I thought so because SLAB_ACCOUNT is a characteristic of cache, not allocations
unlike GFP_KERNEL/GFP_ATOMIC.

There is more SLAB_* flags and I think it's better not to print
all of them in tracepoints. What if someone wants to track allocations
that are reclaimable?

> Because we have changed the behavior to users. Should
> we treat the tracepoint as a stable API to users? If so, I think we
> should not change the parameter of this tracepoint.  Maybe I am wrong,
> just some thoughts from me.

Hmm, yeah it may break userspace tools. but even changing name of functions
can break such tools... I too wonder we consider them as stable API.
Is there general agreement for this?

And If we cannot change tracepoint (toward breaking existing tools)
after release, We should think more about adding 'accounted' in tracepoints.

Apart from that - even if we're not going to remove bytes_req/bytes_alloc,
I think distinguishing caches is worth than adding something like 'accounted'.

> Thanks.
> 
> > 
> > And then you can check if the cache uses SLAB_ACCOUNT or not.
> > 

-- 
Thanks,
Hyeonggon
