Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEA45A437F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiH2HDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2HDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:03:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E9047BA1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:03:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E114B336B9;
        Mon, 29 Aug 2022 07:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661756590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oKH/Ge6O2qRb5q8TxgDDtNLRLk8f+2i7dxo+XcGP9Ok=;
        b=I/3GIFWYU8G/k9MgIQedY5C58cf0hr8vO9pYnlakVsGms3ziHDIHhSkihZelgwoP1CjTbd
        IoOgWyLXsMPQHmnCV9NTNd1VVIIqAsKAmr6NiCmNqr/EyBj5LXujKzNJsewWZzC9PCwY/F
        woxAjpfjHKdUaxAdNPQXV4sTWFeC38o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFD21133A6;
        Mon, 29 Aug 2022 07:03:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id noEbLK5kDGPZYgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 29 Aug 2022 07:03:10 +0000
Date:   Mon, 29 Aug 2022 09:03:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: deduplicate cacheline padding code
Message-ID: <Ywxkrsy+u8LMTXI1@dhcp22.suse.cz>
References: <20220826230642.566725-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826230642.566725-1-shakeelb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-08-22 23:06:42, Shakeel Butt wrote:
> There are three users (mmzone.h, memcontrol.h, page_counter.h) using
> similar code for forcing cacheline padding between fields of different
> structures. Dedup that code.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Suggested-by: Feng Tang <feng.tang@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
> Changes since v1:
> - add semicolons in mmzone.h
> 
>  include/linux/cache.h        | 13 +++++++++++++
>  include/linux/memcontrol.h   | 13 ++-----------
>  include/linux/mmzone.h       | 24 +++++-------------------
>  include/linux/page_counter.h | 13 ++-----------
>  4 files changed, 22 insertions(+), 41 deletions(-)
> 
> diff --git a/include/linux/cache.h b/include/linux/cache.h
> index d742c57eaee5..5da1bbd96154 100644
> --- a/include/linux/cache.h
> +++ b/include/linux/cache.h
> @@ -85,4 +85,17 @@
>  #define cache_line_size()	L1_CACHE_BYTES
>  #endif
>  
> +/*
> + * Helper to add padding within a struct to ensure data fall into separate
> + * cachelines.
> + */
> +#if defined(CONFIG_SMP)
> +struct cacheline_padding {
> +	char x[0];
> +} ____cacheline_internodealigned_in_smp;
> +#define CACHELINE_PADDING(name)		struct cacheline_padding name
> +#else
> +#define CACHELINE_PADDING(name)
> +#endif
> +
>  #endif /* __LINUX_CACHE_H */
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 344022f102c2..60545e4a1c03 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -185,15 +185,6 @@ struct mem_cgroup_thresholds {
>  	struct mem_cgroup_threshold_ary *spare;
>  };
>  
> -#if defined(CONFIG_SMP)
> -struct memcg_padding {
> -	char x[0];
> -} ____cacheline_internodealigned_in_smp;
> -#define MEMCG_PADDING(name)      struct memcg_padding name
> -#else
> -#define MEMCG_PADDING(name)
> -#endif
> -
>  /*
>   * Remember four most recent foreign writebacks with dirty pages in this
>   * cgroup.  Inode sharing is expected to be uncommon and, even if we miss
> @@ -304,7 +295,7 @@ struct mem_cgroup {
>  	spinlock_t		move_lock;
>  	unsigned long		move_lock_flags;
>  
> -	MEMCG_PADDING(_pad1_);
> +	CACHELINE_PADDING(_pad1_);
>  
>  	/* memory.stat */
>  	struct memcg_vmstats	vmstats;
> @@ -326,7 +317,7 @@ struct mem_cgroup {
>  	struct list_head objcg_list;
>  #endif
>  
> -	MEMCG_PADDING(_pad2_);
> +	CACHELINE_PADDING(_pad2_);
>  
>  	/*
>  	 * set > 0 if pages under this cgroup are moving to other cgroup.
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 14919b2fb5f5..b30f5f0dd13f 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -121,20 +121,6 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
>  
>  struct pglist_data;
>  
> -/*
> - * Add a wild amount of padding here to ensure data fall into separate
> - * cachelines.  There are very few zone structures in the machine, so space
> - * consumption is not a concern here.
> - */
> -#if defined(CONFIG_SMP)
> -struct zone_padding {
> -	char x[0];
> -} ____cacheline_internodealigned_in_smp;
> -#define ZONE_PADDING(name)	struct zone_padding name;
> -#else
> -#define ZONE_PADDING(name)
> -#endif
> -
>  #ifdef CONFIG_NUMA
>  enum numa_stat_item {
>  	NUMA_HIT,		/* allocated in intended node */
> @@ -837,7 +823,7 @@ struct zone {
>  	int initialized;
>  
>  	/* Write-intensive fields used from the page allocator */
> -	ZONE_PADDING(_pad1_)
> +	CACHELINE_PADDING(_pad1_);
>  
>  	/* free areas of different sizes */
>  	struct free_area	free_area[MAX_ORDER];
> @@ -849,7 +835,7 @@ struct zone {
>  	spinlock_t		lock;
>  
>  	/* Write-intensive fields used by compaction and vmstats. */
> -	ZONE_PADDING(_pad2_)
> +	CACHELINE_PADDING(_pad2_);
>  
>  	/*
>  	 * When free pages are below this point, additional steps are taken
> @@ -886,7 +872,7 @@ struct zone {
>  
>  	bool			contiguous;
>  
> -	ZONE_PADDING(_pad3_)
> +	CACHELINE_PADDING(_pad3_);
>  	/* Zone statistics */
>  	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
>  	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
> @@ -1194,7 +1180,7 @@ typedef struct pglist_data {
>  #endif /* CONFIG_NUMA */
>  
>  	/* Write-intensive fields used by page reclaim */
> -	ZONE_PADDING(_pad1_)
> +	CACHELINE_PADDING(_pad1_);
>  
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  	/*
> @@ -1239,7 +1225,7 @@ typedef struct pglist_data {
>  	struct lru_gen_mm_walk	mm_walk;
>  #endif
>  
> -	ZONE_PADDING(_pad2_)
> +	CACHELINE_PADDING(_pad2_);
>  
>  	/* Per-node vmstats */
>  	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index 78a1c934e416..c141ea9a95ef 100644
> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
> @@ -7,22 +7,13 @@
>  #include <linux/kernel.h>
>  #include <asm/page.h>
>  
> -#if defined(CONFIG_SMP)
> -struct pc_padding {
> -	char x[0];
> -} ____cacheline_internodealigned_in_smp;
> -#define PC_PADDING(name)	struct pc_padding name
> -#else
> -#define PC_PADDING(name)
> -#endif
> -
>  struct page_counter {
>  	/*
>  	 * Make sure 'usage' does not share cacheline with any other field. The
>  	 * memcg->memory.usage is a hot member of struct mem_cgroup.
>  	 */
>  	atomic_long_t usage;
> -	PC_PADDING(_pad1_);
> +	CACHELINE_PADDING(_pad1_);
>  
>  	/* effective memory.min and memory.min usage tracking */
>  	unsigned long emin;
> @@ -38,7 +29,7 @@ struct page_counter {
>  	unsigned long failcnt;
>  
>  	/* Keep all the read most fields in a separete cacheline. */
> -	PC_PADDING(_pad2_);
> +	CACHELINE_PADDING(_pad2_);
>  
>  	unsigned long min;
>  	unsigned long low;
> -- 
> 2.37.2.672.g94769d06f0-goog

-- 
Michal Hocko
SUSE Labs
