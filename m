Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2841E57FA37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiGYH1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGYH1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:27:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5921ADFE7;
        Mon, 25 Jul 2022 00:27:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0906F1FFA6;
        Mon, 25 Jul 2022 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658734036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Y+sEDpJHfgzaT1rJ4g9/9EdcSgAX5NvWiyDCohpfQQ=;
        b=EDBHCXvGACXpIpPqs+0ORp+6Zk/2GaIk1Z//U/hgaM0c285U1ObKp26QUTP5pGfyng/u62
        18wlvr3ft9FZHDVw4se0erYPcgwIc6NhixpsbWH9dLXxr/pkg1N45nDJdV6uwgLPyhm/23
        UCTX4nyQ+iYXkau0Dhn10Oo+v7Mg+Zc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D90EF13A8D;
        Mon, 25 Jul 2022 07:27:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aQCtMtNF3mI5VAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 25 Jul 2022 07:27:15 +0000
Date:   Mon, 25 Jul 2022 09:27:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5] mm: vmpressure: don't count proactive reclaim in
 vmpressure
Message-ID: <Yt5F03q/fb3hHuMV@dhcp22.suse.cz>
References: <20220721173015.2643248-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721173015.2643248-1-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-07-22 17:30:15, Yosry Ahmed wrote:
> memory.reclaim is a cgroup v2 interface that allows users to
> proactively reclaim memory from a memcg, without real memory pressure.
> Reclaim operations invoke vmpressure, which is used:
> (a) To notify userspace of reclaim efficiency in cgroup v1, and
> (b) As a signal for a memcg being under memory pressure for networking
> (see mem_cgroup_under_socket_pressure()).
> 
> For (a), vmpressure notifications in v1 are not affected by this change
> since memory.reclaim is a v2 feature.
> 
> For (b), the effects of the vmpressure signal (according to Shakeel [1])
> are as follows:
> 1. Reducing send and receive buffers of the current socket.
> 2. May drop packets on the rx path.
> 3. May throttle current thread on the tx path.
> 
> Since proactive reclaim is invoked directly by userspace, not by
> memory pressure, it makes sense not to throttle networking. Hence,
> this change makes sure that proactive reclaim caused by memory.reclaim
> does not trigger vmpressure.
> 
> [1] https://lore.kernel.org/lkml/CALvZod68WdrXEmBpOkadhB5GPYmCXaDZzXH=yyGOCAjFRn4NDQ@mail.gmail.com/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks a lot!

> ---
>  Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
>  include/linux/swap.h                    |  5 ++++-
>  mm/memcontrol.c                         | 24 +++++++++++++---------
>  mm/vmscan.c                             | 27 ++++++++++++++++---------
>  4 files changed, 42 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 176298f2f4de..72847462c66d 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1229,6 +1229,13 @@ PAGE_SIZE multiple when read back.
>  	the target cgroup. If less bytes are reclaimed than the
>  	specified amount, -EAGAIN is returned.
>  
> +	Please note that the proactive reclaim (triggered by this
> +	interface) is not meant to indicate memory pressure on the
> +	memory cgroup. Therefore socket memory balancing triggered by
> +	the memory reclaim normally is not exercised in this case.
> +	This means that the networking layer will not adapt based on
> +	reclaim induced by memory.reclaim.
> +
>    memory.peak
>  	A read-only single value file which exists on non-root
>  	cgroups.
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 0c0fed1b348f..f6e9eaa2339f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -411,10 +411,13 @@ extern void lru_cache_add_inactive_or_unevictable(struct page *page,
>  extern unsigned long zone_reclaimable_pages(struct zone *zone);
>  extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>  					gfp_t gfp_mask, nodemask_t *mask);
> +
> +#define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
> +#define MEMCG_RECLAIM_PROACTIVE (1 << 2)
>  extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  						  unsigned long nr_pages,
>  						  gfp_t gfp_mask,
> -						  bool may_swap);
> +						  unsigned int reclaim_options);
>  extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
>  						gfp_t gfp_mask, bool noswap,
>  						pg_data_t *pgdat,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a550042d88c3..b668224142c7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2331,7 +2331,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
>  
>  		psi_memstall_enter(&pflags);
>  		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
> -							     gfp_mask, true);
> +							gfp_mask,
> +							MEMCG_RECLAIM_MAY_SWAP);
>  		psi_memstall_leave(&pflags);
>  	} while ((memcg = parent_mem_cgroup(memcg)) &&
>  		 !mem_cgroup_is_root(memcg));
> @@ -2576,7 +2577,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	struct page_counter *counter;
>  	unsigned long nr_reclaimed;
>  	bool passed_oom = false;
> -	bool may_swap = true;
> +	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
>  	bool drained = false;
>  	unsigned long pflags;
>  
> @@ -2593,7 +2594,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		mem_over_limit = mem_cgroup_from_counter(counter, memory);
>  	} else {
>  		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
> -		may_swap = false;
> +		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
>  	}
>  
>  	if (batch > nr_pages) {
> @@ -2620,7 +2621,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  
>  	psi_memstall_enter(&pflags);
>  	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
> -						    gfp_mask, may_swap);
> +						    gfp_mask, reclaim_options);
>  	psi_memstall_leave(&pflags);
>  
>  	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
> @@ -3402,8 +3403,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
>  			continue;
>  		}
>  
> -		if (!try_to_free_mem_cgroup_pages(memcg, 1,
> -					GFP_KERNEL, !memsw)) {
> +		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> +					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
>  			ret = -EBUSY;
>  			break;
>  		}
> @@ -3513,7 +3514,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
>  		if (signal_pending(current))
>  			return -EINTR;
>  
> -		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL, true))
> +		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> +						  MEMCG_RECLAIM_MAY_SWAP))
>  			nr_retries--;
>  	}
>  
> @@ -6248,7 +6250,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  		}
>  
>  		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> -							 GFP_KERNEL, true);
> +					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP);
>  
>  		if (!reclaimed && !nr_retries--)
>  			break;
> @@ -6297,7 +6299,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>  
>  		if (nr_reclaims) {
>  			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
> -							  GFP_KERNEL, true))
> +					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP))
>  				nr_reclaims--;
>  			continue;
>  		}
> @@ -6426,6 +6428,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
>  	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
>  	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> +	unsigned int reclaim_options;
>  	int err;
>  
>  	buf = strstrip(buf);
> @@ -6433,6 +6436,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  	if (err)
>  		return err;
>  
> +	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
>  	while (nr_reclaimed < nr_to_reclaim) {
>  		unsigned long reclaimed;
>  
> @@ -6449,7 +6453,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  
>  		reclaimed = try_to_free_mem_cgroup_pages(memcg,
>  						nr_to_reclaim - nr_reclaimed,
> -						GFP_KERNEL, true);
> +						GFP_KERNEL, reclaim_options);
>  
>  		if (!reclaimed && !nr_retries--)
>  			return -EAGAIN;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f7d9a683e3a7..0969e6408a53 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -102,6 +102,9 @@ struct scan_control {
>  	/* Can pages be swapped as part of reclaim? */
>  	unsigned int may_swap:1;
>  
> +	/* Proactive reclaim invoked by userspace through memory.reclaim */
> +	unsigned int proactive:1;
> +
>  	/*
>  	 * Cgroup memory below memory.low is protected as long as we
>  	 * don't threaten to OOM. If any cgroup is reclaimed at
> @@ -3125,9 +3128,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  			    sc->priority);
>  
>  		/* Record the group's reclaim efficiency */
> -		vmpressure(sc->gfp_mask, memcg, false,
> -			   sc->nr_scanned - scanned,
> -			   sc->nr_reclaimed - reclaimed);
> +		if (!sc->proactive)
> +			vmpressure(sc->gfp_mask, memcg, false,
> +				   sc->nr_scanned - scanned,
> +				   sc->nr_reclaimed - reclaimed);
>  
>  	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
>  }
> @@ -3250,9 +3254,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	}
>  
>  	/* Record the subtree's reclaim efficiency */
> -	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> -		   sc->nr_scanned - nr_scanned,
> -		   sc->nr_reclaimed - nr_reclaimed);
> +	if (!sc->proactive)
> +		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> +			   sc->nr_scanned - nr_scanned,
> +			   sc->nr_reclaimed - nr_reclaimed);
>  
>  	if (sc->nr_reclaimed - nr_reclaimed)
>  		reclaimable = true;
> @@ -3534,8 +3539,9 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>  		__count_zid_vm_events(ALLOCSTALL, sc->reclaim_idx, 1);
>  
>  	do {
> -		vmpressure_prio(sc->gfp_mask, sc->target_mem_cgroup,
> -				sc->priority);
> +		if (!sc->proactive)
> +			vmpressure_prio(sc->gfp_mask, sc->target_mem_cgroup,
> +					sc->priority);
>  		sc->nr_scanned = 0;
>  		shrink_zones(zonelist, sc);
>  
> @@ -3825,7 +3831,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>  unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  					   unsigned long nr_pages,
>  					   gfp_t gfp_mask,
> -					   bool may_swap)
> +					   unsigned int reclaim_options)
>  {
>  	unsigned long nr_reclaimed;
>  	unsigned int noreclaim_flag;
> @@ -3838,7 +3844,8 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  		.priority = DEF_PRIORITY,
>  		.may_writepage = !laptop_mode,
>  		.may_unmap = 1,
> -		.may_swap = may_swap,
> +		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
> +		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
>  	};
>  	/*
>  	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
> -- 
> 2.37.1.359.gd136c6c3e2-goog

-- 
Michal Hocko
SUSE Labs
