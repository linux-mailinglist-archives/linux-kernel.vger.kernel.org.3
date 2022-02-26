Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4BC4C5529
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 11:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiBZKYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 05:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiBZKYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 05:24:45 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBF914CC9E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 02:24:09 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o26so6317938pgb.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 02:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1tUcyDDhO7TsJN572xciTjJpmJqLjSCl0Q4jXHMQxY=;
        b=A7XVJnaEfFE1ilSLd3mQKUwDvG96UMN2GsrFWPcP1yPbuLyX8zHpYlq68udWrIvjtl
         10r6VQG8Y+E4jcCBikj7p/wicdYXt63aNg4G4g7+vW1vpkB5zSk5gWaSvUDchLrGmg0o
         DhT132/SHM171ISaHrbpjo2SiSoyvUm0KmeWbAqPxFDrGcoefFvcGbBXQSqje8VE1PQ+
         ZeLzzi8NITQEg2G70SwxEW8H7tW3rqpibQAKKspstxT+KJCZk+W2PARZO6GHAJPJi9UE
         ikJtjmyffZp17qtKG9yOLAeyzn+fqYjo+/9I0TpHmdsyO5ljW9QjGEw33/Accb42ve/q
         0sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1tUcyDDhO7TsJN572xciTjJpmJqLjSCl0Q4jXHMQxY=;
        b=EUVC0MttdoX5RDEQ7fSxXT2O1eLUV8tn2dp7s+adnl3p2okyRymniyhvQwSQsPNIZ0
         qCCNPD42M8oqT5+v81XYDQEAUVxcliFvcpBCzmA2qTY9l7HySNmfYw56n6WI8PFw7aRw
         NeDECgb1jnAQ0aj7BJw+wMgykg1q6gmMqEWuXu1NLqUou4gkJ3n7IANZ93L3W7DkuS2j
         jw9eeIXd1eEKVDYDPpJAtRCScE7j65Kalm63KjAMRCXY0xZgupkqIlLJpVMpNnLrUiAR
         raGGMDNPzdVra8lnP5apyEpVk8utINhVoedTAQ9e2GsHi+9/0dzb7kqgKbo9A4qf5VWJ
         fkOA==
X-Gm-Message-State: AOAM530YMX/5vFR6/PnoIkySwBXvZWwLL6U66wUESuioG6xAbdUDAzQ8
        xa2kyxgx7mXcaSHbzcgvuUk=
X-Google-Smtp-Source: ABdhPJxfMbVN/28mvOXZygKzkItfxpNDvnSN8MJJm12qmT1c6xJM9oz2jPNcU3bep25w+xbYG4Gs3Q==
X-Received: by 2002:a63:1455:0:b0:370:289c:1404 with SMTP id 21-20020a631455000000b00370289c1404mr9689621pgu.244.1645871048827;
        Sat, 26 Feb 2022 02:24:08 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id l71-20020a63914a000000b0036c4233875dsm5102192pge.64.2022.02.26.02.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 02:24:08 -0800 (PST)
Date:   Sat, 26 Feb 2022 10:24:03 +0000
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
        Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: Re: [PATCH 2/5] mm/slub: use stackdepot to save stack trace in
 objects
Message-ID: <Yhn/w6FI+qZrFlK1@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <20220225180318.20594-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225180318.20594-3-vbabka@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 07:03:15PM +0100, Vlastimil Babka wrote:
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
>  init/Kconfig |  1 +
>  mm/slub.c    | 88 +++++++++++++++++++++++++++++-----------------------
>  2 files changed, 50 insertions(+), 39 deletions(-)
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
> diff --git a/mm/slub.c b/mm/slub.c
> index 1fc451f4fe62..3140f763e819 100644
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
> @@ -724,22 +725,20 @@ static struct track *get_track(struct kmem_cache *s, void *object,
>  	return kasan_reset_tag(p + alloc);
>  }
>  
> -static void set_track(struct kmem_cache *s, void *object,
> -			enum track_item alloc, unsigned long addr)
> +static noinline void
> +set_track(struct kmem_cache *s, void *object, enum track_item alloc,
> +	  unsigned long addr, gfp_t flags)
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
> +	p->handle = stack_depot_save(entries, nr_entries, flags);
>  #endif
> +
>  	p->addr = addr;
>  	p->cpu = smp_processor_id();
>  	p->pid = current->pid;
> @@ -759,20 +758,19 @@ static void init_tracking(struct kmem_cache *s, void *object)
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
> @@ -1304,9 +1302,9 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
>  	return 1;
>  }
>  
> -static noinline int alloc_debug_processing(struct kmem_cache *s,
> -					struct slab *slab,
> -					void *object, unsigned long addr)
> +static noinline int
> +alloc_debug_processing(struct kmem_cache *s, struct slab *slab, void *object,
> +		       unsigned long addr, gfp_t flags)
>  {
>  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
>  		if (!alloc_consistency_checks(s, slab, object))
> @@ -1315,7 +1313,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
>  
>  	/* Success perform special debug activities for allocs */
>  	if (s->flags & SLAB_STORE_USER)
> -		set_track(s, object, TRACK_ALLOC, addr);
> +		set_track(s, object, TRACK_ALLOC, addr, flags);

I see warning because of this.
We should not reuse flags here because alloc_debug_processing() can be
called with preemption disabled, and caller specified GFP_KERNEL.

[    2.015902] BUG: sleeping function called from invalid context at mm/page_alloc.c:5164
[    2.022052] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
[    2.028357] preempt_count: 1, expected: 0
[    2.031508] RCU nest depth: 0, expected: 0
[    2.034722] 1 lock held by swapper/0/1:
[    2.037905]  #0: ffff00000488f4d0 (&sb->s_type->i_mutex_key#5){+.+.}-{4:4}, at: start_creating+0x58/0x130
[    2.045393] Preemption disabled at:
[    2.045400] [<ffff8000083bd008>] __slab_alloc.constprop.0+0x38/0xc0
[    2.053039] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.17.0-rc5+ #105
[    2.059365] Hardware name: linux,dummy-virt (DT)
[    2.063160] Call trace:
[    2.065217]  dump_backtrace+0xf8/0x130
[    2.068350]  show_stack+0x24/0x80
[    2.071104]  dump_stack_lvl+0x9c/0xd8
[    2.074140]  dump_stack+0x18/0x34
[    2.076894]  __might_resched+0x1a0/0x280
[    2.080146]  __might_sleep+0x58/0x90
[    2.083108]  prepare_alloc_pages.constprop.0+0x1b4/0x1f0
[    2.087468]  __alloc_pages+0x88/0x1e0
[    2.090502]  alloc_page_interleave+0x24/0xb4
[    2.094021]  alloc_pages+0x10c/0x170
[    2.096984]  __stack_depot_save+0x3e0/0x4e0
[    2.100446]  stack_depot_save+0x14/0x20
[    2.103617]  set_track.isra.0+0x64/0xa4
[    2.106787]  alloc_debug_processing+0x11c/0x1e0
[    2.110532]  ___slab_alloc+0x3e8/0x750
[    2.113643]  __slab_alloc.constprop.0+0x64/0xc0
[    2.117391]  kmem_cache_alloc+0x304/0x350
[    2.120702]  security_inode_alloc+0x38/0xa4
[    2.124169]  inode_init_always+0xd0/0x264
[    2.127501]  alloc_inode+0x44/0xec
[    2.130325]  new_inode+0x28/0xc0
[    2.133011]  tracefs_create_file+0x74/0x1e0
[    2.136459]  init_tracer_tracefs+0x248/0x644
[    2.140030]  tracer_init_tracefs+0x9c/0x34c
[    2.143483]  do_one_initcall+0x44/0x170
[    2.146654]  do_initcalls+0x104/0x144
[    2.149704]  kernel_init_freeable+0x130/0x178

[...]

>  	trace(s, slab, object, 1);
>  	init_object(s, object, SLUB_RED_ACTIVE);
>  	return 1;
> @@ -1395,7 +1393,7 @@ static noinline int free_debug_processing(
>  	}
>  
>  	if (s->flags & SLAB_STORE_USER)
> -		set_track(s, object, TRACK_FREE, addr);
> +		set_track(s, object, TRACK_FREE, addr, GFP_NOWAIT);
>  	trace(s, slab, object, 0);
>  	/* Freepointer not overwritten by init_object(), SLAB_POISON moved it */
>  	init_object(s, object, SLUB_RED_INACTIVE);
> @@ -1632,7 +1630,8 @@ static inline
>  void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
>  
>  static inline int alloc_debug_processing(struct kmem_cache *s,
> -	struct slab *slab, void *object, unsigned long addr) { return 0; }
> +	struct slab *slab, void *object, unsigned long addr,
> +	gfp_t flags) { return 0; }
>  
>  static inline int free_debug_processing(
>  	struct kmem_cache *s, struct slab *slab,
> @@ -3033,7 +3032,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  check_new_slab:
>  
>  	if (kmem_cache_debug(s)) {
> -		if (!alloc_debug_processing(s, slab, freelist, addr)) {
> +		if (!alloc_debug_processing(s, slab, freelist, addr, gfpflags)) {
>  			/* Slab failed checks. Next slab needed */
>  			goto new_slab;
>  		} else {
> @@ -4221,6 +4220,9 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  	s->remote_node_defrag_ratio = 1000;
>  #endif
>  
> +	if (s->flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
> +		stack_depot_init();
> +

As mentioned in my report, it can crash system when creating boot caches
with debugging enabled.

The rest looks fine!

>  	/* Initialize the pre-computed randomized freelist if slab is up */
>  	if (slab_state >= UP) {
>  		if (init_cache_random_seq(s))
> @@ -4352,18 +4354,26 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
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

-- 
Thank you, You are awesome!
Hyeonggon :-)
