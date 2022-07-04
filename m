Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F655651B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiGDKFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiGDKFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:05:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CD330B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:05:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ju17so3737577pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 03:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x0Lndh9S07lR5McueCUvv/COWsfBw/+Zg5G32HVPdiI=;
        b=CaDbi1ka+qGH/GL/TGhKOL2i5mqIQelXgaPhBStW2glMWGTSplREOXFq0GNs4Hv3Ug
         nxM5tlOnVEiIXQ5Lllr7uj7ETmngrwzjwwfOrmfiZISZQrXWtvQSE/dGY8NV5p+4p/zO
         meaAWwrCS9+dn2I5yiS+wb2hV12CxBounv3APsgmLSl7dI/5NiPOI0o6aRdnRQ2Q5kA2
         kiHnWzhyVBpCTwiArH/6ZaYcoM3KMNtdpd5nUf3eISIEtyq4GB96ZZSGPBBT+bRwPDb+
         AgDtQL5NkEASf4pz3a1yrlMo7FAwOSZIgF4fDZBBpOFnMAaXpMnyZEcXUiEO+IDc3pgX
         7Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x0Lndh9S07lR5McueCUvv/COWsfBw/+Zg5G32HVPdiI=;
        b=3J6WpohKcWVui2C0uNoqza2a5dnrV1i2yOFszPQQIq1ZgX59F6ZdX3YcR0F+e31tN2
         oZShzJ3cMeNbDlfIfTB0k0Pkx3ITaT11CEOFXcGue4RpBpGERoKY/t+WaIrR9rDsrIC1
         18YH5HQKCb0Tu5dfvm8L0TogzmigiT3ECpBtXtFvTTCu9NvnJOzXyiA9aCD+412V36Vr
         fCfWx2nDCSjzweYIzh58vVY94BJDnrGPLv87XzGywVhDRhFrxuEhNu55vtd+Tdq12saF
         8A3e67PRn9SGhS7/QPZAE+JQRso2Q+10bofm1VV0GkN1w8EMMd9S5cchtw1DH4YKJscm
         XoSw==
X-Gm-Message-State: AJIora/ig14QSAg7LwTsZTBi/rb3achr2qjA1yCBkhVJNAZ49Y0t3N6d
        vKg5jlGtD5kmQJ5HF98PwsE=
X-Google-Smtp-Source: AGRyM1sCNw4NLb+EkDtvgg4l81yCcrjA6uGnigcUHqHFt9GY2GLBwlP+ChAx2JX726EI7KZKb1nIAA==
X-Received: by 2002:a17:90a:c907:b0:1ef:7655:98d7 with SMTP id v7-20020a17090ac90700b001ef765598d7mr13482803pjt.117.1656929135145;
        Mon, 04 Jul 2022 03:05:35 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-78-214-16.ap-northeast-1.compute.amazonaws.com. [35.78.214.16])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e80f00b0015e8d4eb2e3sm2927725plg.301.2022.07.04.03.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 03:05:34 -0700 (PDT)
Date:   Mon, 4 Jul 2022 10:05:29 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Christoph Lameter <cl@gentwo.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v1] mm/slub: enable debugging memory wasting of kmalloc
Message-ID: <YsK7aUtPvX8fCWFJ@ip-172-31-24-42.ap-northeast-1.compute.internal>
References: <20220701135954.45045-1-feng.tang@intel.com>
 <alpine.DEB.2.22.394.2207011635040.588600@gentwo.de>
 <20220701150451.GA62281@shbuild999.sh.intel.com>
 <YsGlAYujuJSTBLLf@ip-172-31-24-42.ap-northeast-1.compute.internal>
 <20220704055600.GD62281@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704055600.GD62281@shbuild999.sh.intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 01:56:00PM +0800, Feng Tang wrote:
> On Sun, Jul 03, 2022 at 02:17:37PM +0000, Hyeonggon Yoo wrote:
> > On Fri, Jul 01, 2022 at 11:04:51PM +0800, Feng Tang wrote:
> > > Hi Christoph,
> > > 
> > > On Fri, Jul 01, 2022 at 04:37:00PM +0200, Christoph Lameter wrote:
> > > > On Fri, 1 Jul 2022, Feng Tang wrote:
> > > > 
> > > > >  static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > > > > -			  unsigned long addr, struct kmem_cache_cpu *c)
> > > > > +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> > > > >  {
> > > > 
> > > > It would be good to avoid expanding the basic slab handling functions for
> > > > kmalloc. Can we restrict the mods to the kmalloc related functions?
> > > 
> > > Yes, this is the part that concerned me. I tried but haven't figured
> > > a way.
> > > 
> > > I started implemting it several month ago, and stuck with several
> > > kmalloc APIs in a hacky way like dump_stack() when there is a waste
> > > over 1/4 of the object_size of the kmalloc_caches[][].
> > > 
> > > Then I found one central API which has all the needed info (object_size &
> > > orig_size) that we can yell about the waste :
> > > 
> > > static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
> > >                 gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
> > > 
> > > which I thought could be still hacky, as the existing 'alloc_traces'
> > > can't be resued which already has the count/call-stack info. Current
> > > solution leverage it at the cost of adding 'orig_size' parameters, but
> > > I don't know how to pass the 'waste' info through as track/location is
> > > in the lowest level.
> > 
> > If adding cost of orig_size parameter for non-debugging case is concern,
> > what about doing this in userspace script that makes use of kmalloc
> > tracepoints?
> > 
> > 	kmalloc: call_site=tty_buffer_alloc+0x43/0x90 ptr=00000000b78761e1
> > 	bytes_req=1056 bytes_alloc=2048 gfp_flags=GFP_ATOMIC|__GFP_NOWARN
> > 	accounted=false
> > 
> > calculating sum of (bytes_alloc - bytes_req) for each call_site
> > may be an alternative solution.
> 
> Yes, this is doable, and it will met some of the problems I met before,
> one is there are currently 2 alloc path: kmalloc and kmalloc_node, also
> we need to consider the free problem to calculate the real waste, and
> the free trace point doesn't have size info (Yes, we could compare
> the pointer with alloc path, and the user script may need to be more
> complexer). That's why I love the current 'alloc_traces' interface,
> which has the count (slove the free counting problem) and full call
> stack info.

Understood.

> And for the extra parameter cost issue, I rethink about it, and we
> can leverage the 'slab_alloc_node()' to solve it, and the patch is 
> much simpler now without adding a new parameter:
> 
> ---
> diff --git a/mm/slub.c b/mm/slub.c
> index b1281b8654bd3..ce4568dbb0f2d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -271,6 +271,7 @@ struct track {
>  #endif
>  	int cpu;		/* Was running on cpu */
>  	int pid;		/* Pid context */
> +	unsigned long waste;	/* memory waste for a kmalloc-ed object */
>  	unsigned long when;	/* When did the operation occur */
>  };
>  
> @@ -3240,6 +3241,16 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
>  	init = slab_want_init_on_alloc(gfpflags, s);
>  
>  out:
> +
> +#ifdef CONFIG_SLUB_DEBUG
> +	if (object && s->object_size != orig_size) {
> +		struct track *track;
> +
> +		track = get_track(s, object, TRACK_ALLOC);
> +		track->waste = s->object_size - orig_size;
> +	}
> +#endif
> +

This scares me. It does not check if the cache has
SLAB_STORE_USER flag.

Also CONFIG_SLUB_DEBUG is enabled by default, which means that
it is still against not affecting non-debugging case.

I like v1 more than modified version.

Thanks,
Hyeonggon

>  	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
>  
>  	return object;
> @@ -5092,6 +5103,7 @@ struct location {
>  	depot_stack_handle_t handle;
>  	unsigned long count;
>  	unsigned long addr;
> +	unsigned long waste;
>  	long long sum_time;
>  	long min_time;
>  	long max_time;
> @@ -5142,7 +5154,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>  {
>  	long start, end, pos;
>  	struct location *l;
> -	unsigned long caddr, chandle;
> +	unsigned long caddr, chandle, cwaste;
>  	unsigned long age = jiffies - track->when;
>  	depot_stack_handle_t handle = 0;
>  
> @@ -5162,11 +5174,13 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>  		if (pos == end)
>  			break;
>  
> -		caddr = t->loc[pos].addr;
> -		chandle = t->loc[pos].handle;
> -		if ((track->addr == caddr) && (handle == chandle)) {
> +		l = &t->loc[pos];
> +		caddr = l->addr;
> +		chandle = l->handle;
> +		cwaste = l->waste;
> +		if ((track->addr == caddr) && (handle == chandle) &&
> +			(track->waste == cwaste)) {
>  
> -			l = &t->loc[pos];
>  			l->count++;
>  			if (track->when) {
>  				l->sum_time += age;
> @@ -5191,6 +5205,9 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>  			end = pos;
>  		else if (track->addr == caddr && handle < chandle)
>  			end = pos;
> +		else if (track->addr == caddr && handle == chandle &&
> +				track->waste < cwaste)
> +			end = pos;
>  		else
>  			start = pos;
>  	}
> @@ -5214,6 +5231,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>  	l->min_pid = track->pid;
>  	l->max_pid = track->pid;
>  	l->handle = handle;
> +	l->waste = track->waste;
>  	cpumask_clear(to_cpumask(l->cpus));
>  	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
>  	nodes_clear(l->nodes);
> @@ -6102,6 +6120,10 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
>  		else
>  			seq_puts(seq, "<not-available>");
>  
> +		if (l->waste)
> +			seq_printf(seq, " waste=%lu/%lu",
> +				l->count * l->waste, l->waste);
> +
>  		if (l->sum_time != l->min_time) {
>  			seq_printf(seq, " age=%ld/%llu/%ld",
>  				l->min_time, div_u64(l->sum_time, l->count),
> 
> Thanks,
> Feng
> 
> > Thanks,
> > Hyeonggon
> > 
> > > Thanks,
> > > Feng
> > > 
> > > 
> > > 
