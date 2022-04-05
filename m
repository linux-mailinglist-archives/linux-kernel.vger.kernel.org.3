Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5A54F523D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849781AbiDFCkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575818AbiDEXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:09:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC124E38C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:40:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j20-20020a17090ae61400b001ca9553d073so756709pjy.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=uFEEhi2BINl2XkuJDW73R9CLR4ne8XETRZnn1nmyzxA=;
        b=Sot2K/6pM4dz106o9LGTkElXpd2fwWCwwtWHv7QKYEK9OV6t2oqMz5weDsRqBU+L0D
         XjoYPv4Iuyq+Mw9zcbzBaYD3+AThxYVR9x0yZoTAVvN4ngekXwY3j3XXIf3HlrM+nKjy
         xO69QATXXQCgBvIu056HVeYHzhVraHK9Nc/4N6X0qSBRuoqJqvSw461vjAeZKPaVyo0M
         xxRSVGqfgxYwobufKwDZhdD1mP45Y9UqIbrcGQG0k0j6tyskeVLUB4la0xo3snERbB/4
         jD+y1C8VX0RiU6BEItVuQT3NAMHcsCl2GJEVv8GQP4/qevrnilt1aAlwokRkECcTNBYh
         HcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=uFEEhi2BINl2XkuJDW73R9CLR4ne8XETRZnn1nmyzxA=;
        b=cLzq9fVPfsl8Gjhrfv1ia9jkFlkJy26XbluDPR50vbES9oncXHK+/8U7gn5xxhr4gr
         5QWeORoclsE02KEqrHfPBJq08swsgwbZ4OXu6upcYt3ArDXuxLf6RRMYMZqjykNT+/dg
         9sAT6yu5SOe/uvhI+ziY3WMV09mU0Ajr813UQVIQ+KZ9rBlVtGJv/6C952Z96s0lYzib
         +YrRPUSvoNbupP/bYQ9ZlJ5CUttUviTkcG2xhIST+F6FVsK62Eu8wEzt90dIe1WRdu4j
         Bm2LZ4/N1aXNXR93ptzoHW2DJTlmX0kwxzgMZwairBAFh5L7tSREx5OwmYbAJeKtJ08x
         nOwA==
X-Gm-Message-State: AOAM532PySI7P2gf9gETub8nIDODC9mVhTmCnOvkLsw7lokXHdStgXcX
        JSyibFAW7Mv6Eb2k1C5ITV7FaQ==
X-Google-Smtp-Source: ABdhPJy6p41JuzEMqtw3sIwHpEGcfUeno6ruD35L1g2gt33alVOEmKeqkDBJL+Ia6dv3MJirFBK/Bg==
X-Received: by 2002:a17:90b:3b8c:b0:1c6:eb72:24b4 with SMTP id pc12-20020a17090b3b8c00b001c6eb7224b4mr6290221pjb.171.1649194812948;
        Tue, 05 Apr 2022 14:40:12 -0700 (PDT)
Received: from [2620:15c:29:204:be3e:5e1c:99cc:513f] ([2620:15c:29:204:be3e:5e1c:99cc:513f])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm3126341pjt.11.2022.04.05.14.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:40:12 -0700 (PDT)
Date:   Tue, 5 Apr 2022 14:40:12 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>
Subject: Re: [PATCH v3 3/6] mm/slub: use stackdepot to save stack trace in
 objects
In-Reply-To: <20220404164112.18372-4-vbabka@suse.cz>
Message-ID: <5f7d33ec-1e73-cdfc-54e5-e93d346ac78@google.com>
References: <20220404164112.18372-1-vbabka@suse.cz> <20220404164112.18372-4-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022, Vlastimil Babka wrote:

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
> Reviewed-and-tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  init/Kconfig      |  1 +
>  lib/Kconfig.debug |  1 +
>  mm/slab_common.c  |  5 ++++
>  mm/slub.c         | 71 ++++++++++++++++++++++++++---------------------
>  4 files changed, 47 insertions(+), 31 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index ddcbefe535e9..adc57f989d87 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1875,6 +1875,7 @@ config SLUB_DEBUG
>  	default y
>  	bool "Enable SLUB debugging support" if EXPERT
>  	depends on SLUB && SYSFS
> +	select STACKDEPOT if STACKTRACE_SUPPORT
>  	help
>  	  SLUB has extensive debug support features. Disabling these can
>  	  result in significant savings in code size. This also disables
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 075cd25363ac..78d6139111cd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -709,6 +709,7 @@ config DEBUG_SLAB
>  config SLUB_DEBUG_ON
>  	bool "SLUB debugging on by default"
>  	depends on SLUB && SLUB_DEBUG
> +	select STACKDEPOT_ALWAYS_INIT if STACKTRACE_SUPPORT
>  	default n
>  	help
>  	  Boot with debugging on by default. SLUB boots by default with
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 6ee64d6208b3..73943479a2b7 100644
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
> +	if (flags & SLAB_STORE_USER)
> +		stack_depot_init();
>  #endif
>  
>  	mutex_lock(&slab_mutex);
> diff --git a/mm/slub.c b/mm/slub.c
> index cd4fd0159911..98c1450c23f0 100644
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

I think this should also have __GFP_NOWARN set since this allocation could 
easily fail and it would unnecessarily spam the kernel log unless we 
actually care about the stack trace being printed later (and the patch 
already indicates the allocation failed in print_track() when it matters).

Otherwise:

Acked-by: David Rientjes <rientjes@google.com>

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
> +				stack_depot_want_early_init();
>  		}
>  	}
>  
> @@ -1549,6 +1548,8 @@ static int __init setup_slub_debug(char *str)
>  	}
>  out:
>  	slub_debug = global_flags;
> +	if (slub_debug & SLAB_STORE_USER)
> +		stack_depot_want_early_init();
>  	if (slub_debug != 0 || slub_debug_string)
>  		static_branch_enable(&slub_debug_enabled);
>  	else
> @@ -4342,18 +4343,26 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
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
> 
> 
