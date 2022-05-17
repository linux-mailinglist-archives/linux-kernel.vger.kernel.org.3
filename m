Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45B952A7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350939AbiEQQeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350921AbiEQQeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:34:24 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE084ECC1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:34:21 -0700 (PDT)
Date:   Tue, 17 May 2022 09:34:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652805259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i+1owZFK8nU0fwHBj/A4cUjEeBNGR4oV2Kr1hZIIDMM=;
        b=P9cHZGK6MAYhSL1AJypHi6j/SMLqs54Mbv1wNua/gCwihjvji3D2Q1A5gApoiUP4OVsA3+
        erf3CLdA4SqVfOzdJlYoEwfPiF/2jK0t3WxqrlrMfaSlkY1pjViuFFQJrClXp0DUpG9Udz
        WL18SNqzDto73cbQTdDKN6ExUyiobas=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     YoMccU66auLAPEHa@casper.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Shakeel Butt <shakeelb@google.com>,
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
Message-ID: <YoPOhRctb8wwbmY5@carbon>
References: <8ef9de6a-7497-07f7-852c-befcc3843771@openvz.org>
 <YoOOI1Gw2mX9c8qZ@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoOOI1Gw2mX9c8qZ@hyeyoo>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Alternatively we can add an explicit "accounted" boolean entry,
which will be set to true if the SLAB_ACCOUNT slab cache flag or
the __GFP_ACCOUNT gfp flag is present.
