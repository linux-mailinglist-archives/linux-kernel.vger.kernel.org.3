Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB0B4CD365
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbiCDL0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiCDL0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:26:45 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDC3191424
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 03:25:58 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t5so7385300pfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 03:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=281TGgqrLjuqlTdI5OOZoDm0rpBJfazyycXRl7/B5Uo=;
        b=FZonbEUPAULHwIm2l81m8MQvTF4MyPgZkIgPIHQ0fVFW32ENNJpq8+6OgDh2WL/8Ni
         Bo6s1zM3ylnxt9Tll+sL9/VcNqPPZUFiH5dAYzUT6XZL7TKQG4lGXsMTJJPap2I6suFP
         KfQlY6ASkL4rc+Ri0/pC9pjJkoHSLs3R0oNOqmLGfezKh/6JHwe5JUwq4RdPBDBlbsh8
         fRVhPOIm5L0Qy4DziBttrlBGLsu2dMQD4JWI9duBZnERZkuMz8XdsCGHHkc23Wck1fPp
         6kArlStYlrtErc57pIuF1id8jR3z3llXHReJSiuUIkfVa6/apNN9PKYZCDIgILafVn2J
         u5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=281TGgqrLjuqlTdI5OOZoDm0rpBJfazyycXRl7/B5Uo=;
        b=7ZZmyC0g7BCHXQ3h4ha/DLVNlk044nL+sRtR+FdJJ+S+tp4btG0ZSnrQAFfkQEJ0qe
         C/aM0/Od72MBImgXHNzom3z3g4PQlDFh84sgP/yyWps/9qI/5Atbfe94LHuaUvvi18l3
         DvYpFtMe0fpQfmhIidfx5kmjUK9zVS8IRoqjf2g3Q53m6iJ3jyPuh8XdGjpdEUqQKZgk
         ERDeJ0Dmrce/GmuOHopAX2AXcDBN6A2hS2R6MkZqdZ1LuNWOjWtlH71qeBOJXl4Jo5gh
         OfFievIaWyE7uZbj/ZTYxAoXmZQN3MEnojsQ3pvwdju+rk4ZJM3pcxLlhDZ1Z8u4wn+6
         AnGw==
X-Gm-Message-State: AOAM530d0vVRZlT/Qwb65bZwuB7VQaoOWMbUVB2Zi1dxeX4iOLg5wZCi
        k6dxNSJmmoK1z2ZU/8dFpug=
X-Google-Smtp-Source: ABdhPJzXrRDTGunsPzPS+jkmi7DlQNbGDn16xurqNqE6vC+z/bvbtKcy07VMhPK9m08SjIsoE9R26g==
X-Received: by 2002:a63:2004:0:b0:375:ed63:ab4c with SMTP id g4-20020a632004000000b00375ed63ab4cmr32417660pgg.255.1646393157775;
        Fri, 04 Mar 2022 03:25:57 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id ep5-20020a17090ae64500b001bc56af507dsm10312327pjb.47.2022.03.04.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 03:25:57 -0800 (PST)
Date:   Fri, 4 Mar 2022 11:25:52 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Imran Khan <imran.f.khan@oracle.com>
Subject: Re: [PATCH v2 3/6] mm/slub: use stackdepot to save stack trace in
 objects
Message-ID: <YiH3QAsrnBFc1Nrj@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220302173122.11939-1-vbabka@suse.cz>
 <20220302173122.11939-4-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302173122.11939-4-vbabka@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 06:31:19PM +0100, Vlastimil Babka wrote:
> From: Oliver Glitta <glittao@gmail.com>
> 
> Many stack traces are similar so there are many similar arrays.
> Stackdepot saves each unique stack only once.
> 
> Replace field addrs in struct track with depot_stack_handle_t handle.  Use
> stackdepot to save stack trace.
> 
> The benefits are smaller memory overhead and possibility to aggregate
> per-cache statistics in the following patch using the stackdepot handle
> instead of matching stacks manually.
> 
> [ vbabka@suse.cz: rebase to 5.17-rc1 and adjust accordingly ]
> 
> This was initially merged as commit 788691464c29 and reverted by commit
> ae14c63a9f20 due to several issues, that should now be fixed.
> The problem of unconditional memory overhead by stackdepot has been
> addressed by commit 2dba5eb1c73b ("lib/stackdepot: allow optional init
> and stack_table allocation by kvmalloc()"), so the dependency on
> stackdepot will result in extra memory usage only when a slab cache
> tracking is actually enabled, and not for all CONFIG_SLUB_DEBUG builds.
> The build failures on some architectures were also addressed, and the
> reported issue with xfs/433 test did not reproduce on 5.17-rc1 with this
> patch.
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  init/Kconfig     |  1 +
>  mm/slab_common.c |  5 ++++
>  mm/slub.c        | 71 +++++++++++++++++++++++++++---------------------
>  3 files changed, 46 insertions(+), 31 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index e9119bf54b1f..b21dd3a4a106 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1871,6 +1871,7 @@ config SLUB_DEBUG
>  	default y
>  	bool "Enable SLUB debugging support" if EXPERT
>  	depends on SLUB && SYSFS
> +	select STACKDEPOT if STACKTRACE_SUPPORT
>  	help
>  	  SLUB has extensive debug support features. Disabling these can
>  	  result in significant savings in code size. This also disables
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 23f2ab0713b7..e51d50d03000 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -24,6 +24,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/page.h>
>  #include <linux/memcontrol.h>
> +#include <linux/stackdepot.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/kmem.h>
> @@ -314,9 +315,13 @@ kmem_cache_create_usercopy(const char *name,
>  	 * If no slub_debug was enabled globally, the static key is not yet
>  	 * enabled by setup_slub_debug(). Enable it if the cache is being
>  	 * created with any of the debugging flags passed explicitly.
> +	 * It's also possible that this is the first cache created with
> +	 * SLAB_STORE_USER and we should init stack_depot for it.
>  	 */
>  	if (flags & SLAB_DEBUG_FLAGS)
>  		static_branch_enable(&slub_debug_enabled);
> +	if (flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
> +		stack_depot_init();
>  #endif

Is this comment and code still valid in v3?

>  	mutex_lock(&slab_mutex);
> diff --git a/mm/slub.c b/mm/slub.c
> index 1fc451f4fe62..42cb79af70a0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -26,6 +26,7 @@
>  #include <linux/cpuset.h>
>  #include <linux/mempolicy.h>
>  #include <linux/ctype.h>
> +#include <linux/stackdepot.h>
>  #include <linux/debugobjects.h>
>  #include <linux/kallsyms.h>
>  #include <linux/kfence.h>
> @@ -264,8 +265,8 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
>  #define TRACK_ADDRS_COUNT 16
>  struct track {
>  	unsigned long addr;	/* Called from address */
> -#ifdef CONFIG_STACKTRACE
> -	unsigned long addrs[TRACK_ADDRS_COUNT];	/* Called from address */
> +#ifdef CONFIG_STACKDEPOT
> +	depot_stack_handle_t handle;
>  #endif
>  	int cpu;		/* Was running on cpu */
>  	int pid;		/* Pid context */
> @@ -724,22 +725,19 @@ static struct track *get_track(struct kmem_cache *s, void *object,
>  	return kasan_reset_tag(p + alloc);
>  }
>  
> -static void set_track(struct kmem_cache *s, void *object,
> +static void noinline set_track(struct kmem_cache *s, void *object,
>  			enum track_item alloc, unsigned long addr)
>  {

noinline for debugging purpose?
I think it's okay. just a question.

>  	struct track *p = get_track(s, object, alloc);
>  
> -#ifdef CONFIG_STACKTRACE
> +#ifdef CONFIG_STACKDEPOT
> +	unsigned long entries[TRACK_ADDRS_COUNT];
>  	unsigned int nr_entries;
>  
> -	metadata_access_enable();
> -	nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
> -				      TRACK_ADDRS_COUNT, 3);
> -	metadata_access_disable();
> -
> -	if (nr_entries < TRACK_ADDRS_COUNT)
> -		p->addrs[nr_entries] = 0;
> +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
> +	p->handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
>  #endif
> +
>  	p->addr = addr;
>  	p->cpu = smp_processor_id();
>  	p->pid = current->pid;
> @@ -759,20 +757,19 @@ static void init_tracking(struct kmem_cache *s, void *object)
>  
>  static void print_track(const char *s, struct track *t, unsigned long pr_time)
>  {
> +	depot_stack_handle_t handle __maybe_unused;
> +
>  	if (!t->addr)
>  		return;
>  
>  	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
>  	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
> -#ifdef CONFIG_STACKTRACE
> -	{
> -		int i;
> -		for (i = 0; i < TRACK_ADDRS_COUNT; i++)
> -			if (t->addrs[i])
> -				pr_err("\t%pS\n", (void *)t->addrs[i]);
> -			else
> -				break;
> -	}
> +#ifdef CONFIG_STACKDEPOT
> +	handle = READ_ONCE(t->handle);
> +	if (handle)
> +		stack_depot_print(handle);
> +	else
> +		pr_err("object allocation/free stack trace missing\n");
>  #endif
>  }
>  
> @@ -1532,6 +1529,8 @@ static int __init setup_slub_debug(char *str)
>  			global_slub_debug_changed = true;
>  		} else {
>  			slab_list_specified = true;
> +			if (flags & SLAB_STORE_USER)
> +				stack_depot_want_early_init = true;

This is updated to stack_depot_want_early_init() in v3.

>  		}
>  	}
>  
> @@ -1549,6 +1548,8 @@ static int __init setup_slub_debug(char *str)
>  	}
>  out:
>  	slub_debug = global_flags;
> +	if (slub_debug & SLAB_STORE_USER)
> +		stack_depot_want_early_init = true;

This too.

>  	if (slub_debug != 0 || slub_debug_string)
>  		static_branch_enable(&slub_debug_enabled);
>  	else
> @@ -4352,18 +4353,26 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>  	objp = fixup_red_left(s, objp);
>  	trackp = get_track(s, objp, TRACK_ALLOC);
>  	kpp->kp_ret = (void *)trackp->addr;
> -#ifdef CONFIG_STACKTRACE
> -	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
> -		kpp->kp_stack[i] = (void *)trackp->addrs[i];
> -		if (!kpp->kp_stack[i])
> -			break;
> -	}
> +#ifdef CONFIG_STACKDEPOT
> +	{
> +		depot_stack_handle_t handle;
> +		unsigned long *entries;
> +		unsigned int nr_entries;
> +
> +		handle = READ_ONCE(trackp->handle);
> +		if (handle) {
> +			nr_entries = stack_depot_fetch(handle, &entries);
> +			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
> +				kpp->kp_stack[i] = (void *)entries[i];
> +		}
>  
> -	trackp = get_track(s, objp, TRACK_FREE);
> -	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
> -		kpp->kp_free_stack[i] = (void *)trackp->addrs[i];
> -		if (!kpp->kp_free_stack[i])
> -			break;
> +		trackp = get_track(s, objp, TRACK_FREE);
> +		handle = READ_ONCE(trackp->handle);
> +		if (handle) {
> +			nr_entries = stack_depot_fetch(handle, &entries);
> +			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
> +				kpp->kp_free_stack[i] = (void *)entries[i];
> +		}
>  	}
>  #endif
>  #endif
> -- 
> 2.35.1

Otherwise looks good.
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

kmem_dump_obj() and slab error report functionality works fine.
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thank you, You are awesome!
Hyeonggon :-)
