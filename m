Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2BF549A18
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245347AbiFMRbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240746AbiFMR30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:29:26 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3E762A29
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:49:28 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id d129so5433088pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gPvvSe6FTsRcXPQ951pr09BFrUgePKl3dqQkTDR/CbA=;
        b=aTF9amwoZBKqnS6EeoUA3wklSe4v5hYF/iEedNdET2+BKeTE4Xa4uyyUI74TeuiQca
         iqswv0uIgsfH/umy67XVJvPFP30umF1wj5lqLawZ4VCw14X+bZzaKdVY/JH5tWLqfYx0
         nibRrW9jmT3ywWSNPT2IyGKfUhcuiXnS9JjFqobeeAWi1Y9/NrJj0oaGIObNt3rby4T2
         xHo3sPFV7Jh8G9tkxm5NBqhd1wv56hDkY3c3857jtoSa1p8HrmJq6Q7ks0k3h2Elmytk
         a9HQei/J/DioYv3DGrSPkzCu+UI3DsSNl+J7d4kEUFHe9qCaP+epuUs1dkvTq63gtmBK
         xAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gPvvSe6FTsRcXPQ951pr09BFrUgePKl3dqQkTDR/CbA=;
        b=7OfuU+/aLknvbjWYr9kW0NFEJGK5AcLf9x/6DNXEmcOiNmFyxi4AUgXATe4bgjE5X3
         kzcVMEafq8cBHiOyi12ArGEBldgo/mjPIs2UdsviI/cwZHzKWMExZncxJIhynuGlRNpg
         b54hkSSpffpAkW+mRzDhxX3Mr1B+tLrIEUZV0G+K4AzMB5CwvaB1hrTkqySrqcEUGiWm
         ws77Fde2zaBrLSojNEWULeVKM29b+V1fThieNHDCqG2q+L4wS4UpMc0vqfpX7eJmkVzo
         oVSDBg9gOdNyaXUf+UWpmzyavVIM6Gexit2idoMrjnzGmR32PfzyuQkXE/loUz6qtO1G
         n2hw==
X-Gm-Message-State: AOAM531vqotV4hqNCPo7+nLgagHlIapOxU8ZG7R69WEH65Qd9FID5Atj
        TrdRtbzP4SrfHnCUn4CoIwc=
X-Google-Smtp-Source: ABdhPJxFIOEU7ll2wYEtvRIrzPzwiiuRm8s/BGB/bNT9QaatYBwZXao9gACSHEgYjz3KDf3im/iSJg==
X-Received: by 2002:a63:4a4b:0:b0:408:9a69:3610 with SMTP id j11-20020a634a4b000000b004089a693610mr863285pgl.433.1655124567737;
        Mon, 13 Jun 2022 05:49:27 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id c125-20020a624e83000000b0051850716942sm5457595pfb.140.2022.06.13.05.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:49:26 -0700 (PDT)
Date:   Mon, 13 Jun 2022 21:49:07 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: add missing TID updates on slab deactivation
Message-ID: <YqcyQwCzSuFKkIpr@hyeyoo>
References: <20220608182205.2945720-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608182205.2945720-1-jannh@google.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 08:22:05PM +0200, Jann Horn wrote:
> The fastpath in slab_alloc_node() assumes that c->slab is stable as long as
> the TID stays the same. However, two places in __slab_alloc() currently
> don't update the TID when deactivating the CPU slab.
> 
> If multiple operations race the right way, this could lead to an object
> getting lost; or, in an even more unlikely situation, it could even lead to
> an object being freed onto the wrong slab's freelist, messing up the
> `inuse` counter and eventually causing a page to be freed to the page
> allocator while it still contains slab objects.
> 
> (I haven't actually tested these cases though, this is just based on
> looking at the code. Writing testcases for this stuff seems like it'd be
> a pain...)
> 
> The race leading to state inconsistency is (all operations on the same CPU
> and kmem_cache):
> 
>  - task A: begin do_slab_free():
>     - read TID
>     - read pcpu freelist (==NULL)
>     - check `slab == c->slab` (true)
>  - [PREEMPT A->B]
>  - task B: begin slab_alloc_node():
>     - fastpath fails (`c->freelist` is NULL)
>     - enter __slab_alloc()
>     - slub_get_cpu_ptr() (disables preemption)
>     - enter ___slab_alloc()
>     - take local_lock_irqsave()
>     - read c->freelist as NULL
>     - get_freelist() returns NULL
>     - write `c->slab = NULL`
>     - drop local_unlock_irqrestore()
>     - goto new_slab
>     - slub_percpu_partial() is NULL
>     - get_partial() returns NULL
>     - slub_put_cpu_ptr() (enables preemption)
>  - [PREEMPT B->A]
>  - task A: finish do_slab_free():
>     - this_cpu_cmpxchg_double() succeeds()
>     - [CORRUPT STATE: c->slab==NULL, c->freelist!=NULL]

I can see this happening (!c->slab && c->freelist becoming true)
when I synthetically add scheduling points in the code:

diff --git a/mm/slub.c b/mm/slub.c
index b97fa5e21046..b8012fdf2607 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3001,6 +3001,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto check_new_slab;

 	slub_put_cpu_ptr(s->cpu_slab);
+
+	if (!in_atomic())
+		schedule();
+
 	slab = new_slab(s, gfpflags, node);
 	c = slub_get_cpu_ptr(s->cpu_slab);

@@ -3456,9 +3460,13 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	if (likely(slab == c->slab)) {
 #ifndef CONFIG_PREEMPT_RT
 		void **freelist = READ_ONCE(c->freelist);
+		unsigned long flags;

 		set_freepointer(s, tail_obj, freelist);

+		if (!in_atomic())
+			schedule();
+
 		if (unlikely(!this_cpu_cmpxchg_double(
 				s->cpu_slab->freelist, s->cpu_slab->tid,
 				freelist, tid,
@@ -3467,6 +3475,10 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 			note_cmpxchg_failure("slab_free", s, tid);
 			goto redo;
 		}
+
+		local_irq_save(flags);
+		WARN_ON(!READ_ONCE(c->slab) && READ_ONCE(c->freelist));
+		local_irq_restore(flags);
 #else /* CONFIG_PREEMPT_RT */
 		/*
 		 * We cannot use the lockless fastpath on PREEMPT_RT because if


> From there, the object on c->freelist will get lost if task B is allowed to
> continue from here: It will proceed to the retry_load_slab label,
> set c->slab, then jump to load_freelist, which clobbers c->freelist.
>
> But if we instead continue as follows, we get worse corruption:
> 
>  - task A: run __slab_free() on object from other struct slab:
>     - CPU_PARTIAL_FREE case (slab was on no list, is now on pcpu partial)
>  - task A: run slab_alloc_node() with NUMA node constraint:
>     - fastpath fails (c->slab is NULL)
>     - call __slab_alloc()
>     - slub_get_cpu_ptr() (disables preemption)
>     - enter ___slab_alloc()
>     - c->slab is NULL: goto new_slab
>     - slub_percpu_partial() is non-NULL
>     - set c->slab to slub_percpu_partial(c)
>     - [CORRUPT STATE: c->slab points to slab-1, c->freelist has objects
>       from slab-2]
>     - goto redo
>     - node_match() fails
>     - goto deactivate_slab
>     - existing c->freelist is passed into deactivate_slab()
>     - inuse count of slab-1 is decremented to account for object from
>       slab-2

I didn't try to reproduce this -- but I agree SLUB can be fooled
by the condition (!c->slab && c->freelist).

> At this point, the inuse count of slab-1 is 1 lower than it should be.
> This means that if we free all allocated objects in slab-1 except for one,
> SLUB will think that slab-1 is completely unused, and may free its page,
> leading to use-after-free.
> 
> Fixes: c17dda40a6a4e ("slub: Separate out kmem_cache_cpu processing from deactivate_slab")
> Fixes: 03e404af26dc2 ("slub: fast release on full slab")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  mm/slub.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index e5535020e0fdf..b97fa5e210469 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2936,6 +2936,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  	if (!freelist) {
>  		c->slab = NULL;
> +		c->tid = next_tid(c->tid);
>  		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  		stat(s, DEACTIVATE_BYPASS);
>  		goto new_slab;
> @@ -2968,6 +2969,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	freelist = c->freelist;
>  	c->slab = NULL;
>  	c->freelist = NULL;
> +	c->tid = next_tid(c->tid);
>  	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  	deactivate_slab(s, slab, freelist);
>  
> 
> base-commit: 9886142c7a2226439c1e3f7d9b69f9c7094c3ef6
> -- 
> 2.36.1.476.g0c4daa206d-goog

With this patch I couldn't reproduce it.
This work is really nice. Thanks!

Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

BTW I wonder how much this race will affect machines in the real world.
Maybe just rare and undetectable memory leak?

-- 
Thanks,
Hyeonggon
