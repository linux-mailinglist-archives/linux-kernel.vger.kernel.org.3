Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B663952B78D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiERJjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiERJib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:38:31 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9298986E9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:38:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r71so1689494pgr.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iLhbF+efrgTZiHGNlx8ucyplxCC7hAHiuO4dJxu3EBQ=;
        b=mMjGOE14sdNldlmv/5r9sCKhwXj8srVWREHJKNt8rLdaTCta8o6qPqBR6pQblqdvEW
         WribvmFzvTAclCr3jCfvYXg9ZeDcES2h7LHJBcch/cdlsAxH6EMd1qbJpke4vH9j9iKf
         3+opQQ1XwztckjNsjNm7qx/CA6j7K3rkV+tmrxpe6l1rdjNZmsvxuFQRqERm72Fef4ml
         3nyDQZ55Gn3qFtQdAQz7027GbZis5OcQYgpX57EsxXc7B0kOuV0WdHhr/5UMergRloSM
         wc+EXQbjzcRyQJDBBM2CO4D0RTubWr2dJbl/rq3lQXLXM0xKYDm1YIXYeK+bCTVXQA02
         y4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iLhbF+efrgTZiHGNlx8ucyplxCC7hAHiuO4dJxu3EBQ=;
        b=spFl6wqDPZqdp9/OmurYDNOKCRC5I2ulV4QX3jgtfL+VVHM+M22hKMtqrxxBNHR3K4
         nSiTK+5N4Lm684S/egF/i3uoqf609Hox0ekbOz8iqVMqXjX3bqyRjspQ2poN9QWAIpWm
         fKT2+4DEZu0KchBUQx8dFUIDBMFBVLBq7P4eSS76FeNqMMP1ECqY2Po5wHveLXpqBW/0
         CLDCYuMqoAOk3jCG5lGoVp+8m5MqjM9vWN1vEG0IR6H5sLBA3NLa9ZyeyYuoyxrd51L2
         wt0pxB4H/gnJhLqi30UB5JFrA1kXMl2fSnZ4llBX0C7C9F948W78cMSrJwrrCfMaeFrM
         csWA==
X-Gm-Message-State: AOAM531LSZSxxYYgFxfWcWtsdZmf6b0PY0MmyE5hVvZhqpWuUi8w3F3Q
        vmyntz0n1a64xx7G7C3hBEEsmyEKNAg=
X-Google-Smtp-Source: ABdhPJxyMHfoaAJAqXH7xBrBPiVRRQnZMaLapYQ39nTZXZxhPB6gi7p/Nr3FIcx7+mZ+3HlJuRvIZA==
X-Received: by 2002:a63:a23:0:b0:3f5:e1e4:ae3f with SMTP id 35-20020a630a23000000b003f5e1e4ae3fmr4352431pgk.110.1652866709438;
        Wed, 18 May 2022 02:38:29 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id v24-20020a170902e8d800b0015f086e4aa5sm1178794plg.291.2022.05.18.02.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 02:38:28 -0700 (PDT)
Date:   Wed, 18 May 2022 18:38:21 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
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
Message-ID: <YoS+jbEmxFDfMeaz@hyeyoo>
References: <8ef9de6a-7497-07f7-852c-befcc3843771@openvz.org>
 <YoOOI1Gw2mX9c8qZ@hyeyoo>
 <YoPOhRctb8wwbmY5@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoPOhRctb8wwbmY5@carbon>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 09:34:13AM -0700, Roman Gushchin wrote:
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
> 
> Alternatively we can add an explicit "accounted" boolean entry,
> which will be set to true if the SLAB_ACCOUNT slab cache flag or
> the __GFP_ACCOUNT gfp flag is present.

Or what about adding something like SlabAccounted or MemAccounted in
/proc/meminfo if what he want to know is total amount of memory accounted?

-- 
Thanks,
Hyeonggon
