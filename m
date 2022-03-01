Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AAC4C7F2E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 01:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiCAA3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 19:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiCAA3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:29:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B95053B70
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:28:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D04B219A5;
        Tue,  1 Mar 2022 00:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646094512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ipnEaaVXGjuPjbjYUko5rS7uGNP4HYCYa0ctgBOY/t0=;
        b=CI80451YJ3vFV81nQZrQtSXk3JDBcHNPYUgd/GcfK/Tc6m/F1WBK72vu6tVTbuis3mIMRg
        osAcsfU18GgV0S81cgmIJXxocy7Kc1h7cqhwf/esP3R+A1WIo4v5wx5x8uT3vn+BQqAD46
        xtnCKclHnfrCXUwlirNspZYryuHCiQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646094512;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ipnEaaVXGjuPjbjYUko5rS7uGNP4HYCYa0ctgBOY/t0=;
        b=qePXbAq5X41KUF0JSLYLQgJjKxepd3IPmR+7c4WH8VqdqJDOORa2/MgJ8rvjHrrXrD2POT
        Dh3O7dPB9KSH8HDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41A20139FF;
        Tue,  1 Mar 2022 00:28:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iPFCD7BoHWIMPQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 01 Mar 2022 00:28:32 +0000
Message-ID: <d1bf599d-d680-192c-e7b8-12af7f4f5430@suse.cz>
Date:   Tue, 1 Mar 2022 01:28:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mm/slub: initialize stack depot in boot process
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, Marco Elver <elver@google.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Zqiang <qiang.zhang@windriver.com>
References: <Yhzlw0GGBeuCALJp@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Yhzlw0GGBeuCALJp@ip-172-31-19-208.ap-northeast-1.compute.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 16:09, Hyeonggon Yoo wrote:
> commit ba10d4b46655 ("mm/slub: use stackdepot to save stack trace in
> objects") initializes stack depot while creating cache if SLAB_STORE_USER
> flag is set.
> 
> This can make kernel crash because a cache can be created in various
> contexts. For example if user sets slub_debug=U, kernel crashes
> because create_boot_cache() calls stack_depot_init(), which tries to
> allocate hash table using memblock_alloc() if slab is not available.
> But memblock is also not available at that time.
> 
> This patch solves the problem by initializing stack depot early
> in boot process if SLAB_STORE_USER debug flag is set globally
> or the flag is set to at least one cache.
> 
> [ elver@google.com: initialize stack depot depending on slub_debug
>   parameter instead of allowing stack_depot_init() can be called
>   in kmem_cache_init() for simplicity. ]
> 
> Link: https://lkml.org/lkml/2022/2/28/238
> Fixes: ba10d4b46655 ("mm/slub: use stackdepot to save stack trace in objects")
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

I think a much easier approach would be to do this checking in
setup_slub_debug(). There we may either detect SLAB_STORE_USER in
global_flags, or check the flags returned by parse_slub_debug_flags() in the
while (str) cycle, in the 'else' case where slab_list is present. Both cases
would just set some variable that stack_depot_early_init() (the
!CONFIG_STACKDEPOT_ALWAYS_INIT version, or a newly consolidated one) would
check. So that would be another way to request the stack_depot_init() at a
well-defined point of boot, similar to CONFIG_STACKDEPOT_ALWAYS_INIT.
Because setup_slub_debug() is called by __setup, which is processed from
start_kernel() -> parse_args() before mm_init() -> stack_depot_early_init().

> ---
>  include/linux/slab.h |  1 +
>  init/main.c          |  1 +
>  mm/slab.c            |  4 ++++
>  mm/slob.c            |  4 ++++
>  mm/slub.c            | 28 +++++++++++++++++++++++++---
>  5 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 37bde99b74af..023f3f71ae35 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -139,6 +139,7 @@ struct mem_cgroup;
>  /*
>   * struct kmem_cache related prototypes
>   */
> +void __init kmem_cache_init_early(void);
>  void __init kmem_cache_init(void);
>  bool slab_is_available(void);
>  
> diff --git a/init/main.c b/init/main.c
> index 65fa2e41a9c0..4fdb7975a085 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -835,6 +835,7 @@ static void __init mm_init(void)
>  	kfence_alloc_pool();
>  	report_meminit();
>  	stack_depot_early_init();
> +	kmem_cache_init_early();
>  	mem_init();
>  	mem_init_print_info();
>  	kmem_cache_init();
> diff --git a/mm/slab.c b/mm/slab.c
> index ddf5737c63d9..80a6d01aab06 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1196,6 +1196,10 @@ static void __init set_up_node(struct kmem_cache *cachep, int index)
>  	}
>  }
>  
> +void __init kmem_cache_init_early(void)
> +{
> +}
> +
>  /*
>   * Initialisation.  Called after the page allocator have been initialised and
>   * before smp_init().
> diff --git a/mm/slob.c b/mm/slob.c
> index 60c5842215f1..00e323af8be4 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -715,6 +715,10 @@ struct kmem_cache kmem_cache_boot = {
>  	.align = ARCH_KMALLOC_MINALIGN,
>  };
>  
> +void __init kmem_cache_init_early(void)
> +{
> +}
> +
>  void __init kmem_cache_init(void)
>  {
>  	kmem_cache = &kmem_cache_boot;
> diff --git a/mm/slub.c b/mm/slub.c
> index a74afe59a403..40bcd18143b6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4221,9 +4221,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  	s->remote_node_defrag_ratio = 1000;
>  #endif
>  
> -	if (s->flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
> -		stack_depot_init();
> -
>  	/* Initialize the pre-computed randomized freelist if slab is up */
>  	if (slab_state >= UP) {
>  		if (init_cache_random_seq(s))
> @@ -4810,6 +4807,31 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
>  	return s;
>  }
>  
> +/* Initialize stack depot if needed */
> +void __init kmem_cache_init_early(void)
> +{
> +#ifdef CONFIG_STACKDEPOT
> +	slab_flags_t block_flags;
> +	char *next_block;
> +	char *slab_list;
> +
> +	if (slub_debug & SLAB_STORE_USER)
> +		goto init_stack_depot;
> +
> +	next_block = slub_debug_string;
> +	while (next_block) {
> +		next_block = parse_slub_debug_flags(next_block, &block_flags, &slab_list, false);
> +		if (block_flags & SLAB_STORE_USER)
> +			goto init_stack_depot;
> +	}
> +
> +	return;
> +
> +init_stack_depot:
> +	stack_depot_init();
> +#endif
> +}
> +
>  void __init kmem_cache_init(void)
>  {
>  	static __initdata struct kmem_cache boot_kmem_cache,

