Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBA352C3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbiERUEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiERUEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:04:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7240A1EE0BE
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07CB261993;
        Wed, 18 May 2022 20:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E0CC385A5;
        Wed, 18 May 2022 20:04:48 +0000 (UTC)
Date:   Wed, 18 May 2022 16:04:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     YoPOhRctb8wwbmY5@carbon, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3] tracing: add 'accounted' entry into output of
 allocation tracepoints
Message-ID: <20220518160447.20a7b96f@gandalf.local.home>
In-Reply-To: <f6625cd8-90f9-6d48-50f6-7bb052bf479f@openvz.org>
References: <f6625cd8-90f9-6d48-50f6-7bb052bf479f@openvz.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 09:24:51 +0300
Vasily Averin <vvs@openvz.org> wrote:

FYI, the subject should be something like: mm/tracing:

Because "tracing:" is reserved for tracing infrastructure updates.

> Slab caches marked with SLAB_ACCOUNT force accounting for every
> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> Unfortunately, at the moment this flag is not visible in ftrace output,
> and this makes it difficult to analyze the accounted allocations.
> 
> This patch adds boolean "allocated" entry into trace output,
> and set it to 'true' for calls used __GFP_ACCOUNT flag and
> for allocations from caches marked with SLAB_ACCOUNT.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---
> v3:
>  1) rework kmem_cache_alloc* tracepoints once again,
>     added struct kmem_cache argument into existing templates,
> 	thanks to Matthew Wilcox
>  2) updated the corresponding ding trace_* calls
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
> Now kmem tracing output looks like this:
> 
> kmem_cache_alloc:     (getname_flags.part.0+0x2c) call_site=getname_flags.part.0+0x2c ptr=0xffff8fff022e9000 bytes_req=4096 bytes_alloc=4096 gfp_flags=GFP_KERNEL accounted=false
> kmalloc:              (alloc_bprm+0x32) call_site=alloc_bprm+0x32 ptr=0xffff8fff2b408a00 bytes_req=416 bytes_alloc=512 gfp_flags=GFP_KERNEL|__GFP_ZERO accounted=false
> kmem_cache_alloc:     (mm_alloc+0x16) call_site=mm_alloc+0x16 ptr=0xffff8fff0894d500 bytes_req=1048 bytes_alloc=1088 gfp_flags=GFP_KERNEL accounted=true
> mm_page_alloc:        page=0xffffffffa4ab8d42 pfn=0x12ad72 order=1 migratetype=0 gfp_flags=GFP_USER|__GFP_ZERO|__GFP_ACCOUNT
> kmem_cache_alloc:     (vm_area_alloc+0x1a) call_site=vm_area_alloc+0x1a ptr=0xffff8fff2af27000 bytes_req=200 bytes_alloc=200 gfp_flags=GFP_KERNEL accounted=true
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
> +					  (s && s->flags & SLAB_ACCOUNT);

Now you could make this even faster in the fast path and save just the
s->flags.

	__entry->sflags = s ? s->flags : 0;

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

And then have: "accounted=%s":

		(__entry->gfp_flags & __GFP_ACCOUNT) ||
		(__entry->sflags & SLAB_ACCOUNT) ? "true" : "false"


-- Steve

>  );
>  
