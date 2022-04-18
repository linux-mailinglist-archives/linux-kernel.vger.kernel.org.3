Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF23B505AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245610AbiDRPMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345088AbiDRPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:12:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC4E2D1DB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CA016091C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DA8C385A1;
        Mon, 18 Apr 2022 14:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650290757;
        bh=34sD4bgS06Iqy4yKouOdNtIFIcIPJgM4Z0rV9XB45Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQU3yAEow0XVlsb50UHYKnX4GYd9wejHj2rUXt+kSdJAi5LtdqRgroIsWRVaPI6eL
         YVbHl/z0iua/W5tT0f9Y2qUUPdKHYewv9AvSALjURDVu/fYvt1J1EUb02tzMpEqeUF
         QV5pZvlOkdcVRYnEYcngXrC7KpVeBOq6df1XySoGo1eJvHM/7MvcnbkKkr970nV3M1
         AhqUMSUc3UjW16KqQ+KdvPGdUpgHrQcRZ6gaR7QYXzD+duQ7MNsaRrKxrHD0G6eQam
         kk2PXmIl0GZkndz33cDBX3W1Q+SvonT0jqxQYFcpoqyyZqP2KBi89ITNT7mjezX1XK
         jp5lk8JBDoxkg==
Date:   Mon, 18 Apr 2022 17:05:47 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Donghyeok Kim <dthex5d@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/mmzone: Introduce a new macro
 for_each_node_zonelist()
Message-ID: <Yl1wO/cqNJYf0H7Y@kernel.org>
References: <20220416132037.6395-1-dthex5d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416132037.6395-1-dthex5d@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2022 at 10:20:35PM +0900, Donghyeok Kim wrote:
> There are some codes using for_each_zone_zonelist() even when only
> iterating each node is needed. This commit introduces a new macro
> for_each_node_zonelist() which iterates through valid nodes in the
> zonelist.
> 
> By using this new macro, code can be written in a much simpler form.
> Also, slab/slub can now skip trying to allocate from the node which was
> previously tried and failed.
> 
> Co-developed-by: Ohhoon Kwon <ohkwon1043@gmail.com>
> Signed-off-by: Ohhoon Kwon <ohkwon1043@gmail.com>
> Signed-off-by: Donghyeok Kim <dthex5d@gmail.com>
> ---
> V1 -> V2: Fix a compile error
> 
>  include/linux/mmzone.h | 36 ++++++++++++++++++++++++++++++++++++
>  mm/hugetlb.c           | 17 +++++++----------
>  mm/mmzone.c            | 17 +++++++++++++++++
>  mm/slab.c              |  7 ++-----
>  mm/slub.c              |  8 ++++----
>  mm/vmscan.c            | 16 ++++++----------
>  6 files changed, 72 insertions(+), 29 deletions(-)

Even counting the comments this does not look like a great simplification.

> 
...

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index daa4bdd6c26c..283f28f1aca8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1157,7 +1157,6 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
>  {
>  	unsigned int cpuset_mems_cookie;
>  	struct zonelist *zonelist;
> -	struct zone *zone;
>  	struct zoneref *z;
>  	int node = NUMA_NO_NODE;
>  
> @@ -1165,18 +1164,16 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
>  
>  retry_cpuset:
>  	cpuset_mems_cookie = read_mems_allowed_begin();
> -	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
> +
> +	/*
> +	 * no need to ask again on the same node. Pool is node rather than
> +	 * zone aware
> +	 */
> +	for_each_node_zonelist_nodemask(node, z, zonelist, gfp_zone(gfp_mask), nmask) {
>  		struct page *page;
>  
> -		if (!cpuset_zone_allowed(zone, gfp_mask))
> -			continue;
> -		/*
> -		 * no need to ask again on the same node. Pool is node rather than
> -		 * zone aware
> -		 */
> -		if (zone_to_nid(zone) == node)
> +		if (!cpuset_node_allowed(node, gfp_mask))
>  			continue;
> -		node = zone_to_nid(zone);

The actual change here seems to be the deletion of the node assignment. I'd
say it's not worth the churn.

>  
>  		page = dequeue_huge_page_node_exact(h, node);
>  		if (page)

...

> diff --git a/mm/slab.c b/mm/slab.c
> index a301f266efd1..b374fb88f80e 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3077,7 +3077,6 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
>  {
>  	struct zonelist *zonelist;
>  	struct zoneref *z;
> -	struct zone *zone;
>  	enum zone_type highest_zoneidx = gfp_zone(flags);
>  	void *obj = NULL;
>  	struct slab *slab;
> @@ -3096,10 +3095,8 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
>  	 * Look through allowed nodes for objects available
>  	 * from existing per node queues.
>  	 */
> -	for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
> -		nid = zone_to_nid(zone);
> -
> -		if (cpuset_zone_allowed(zone, flags) &&
> +	for_each_node_zonelist(nid, z, zonelist, highest_zoneidx) {
> +		if (cpuset_node_allowed(nid, flags) &&

Same here.

>  			get_node(cache, nid) &&
>  			get_node(cache, nid)->free_objects) {
>  				obj = ____cache_alloc_node(cache,
> diff --git a/mm/slub.c b/mm/slub.c
> index 6dc703488d30..3e8b4aa98b84 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2192,7 +2192,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
>  #ifdef CONFIG_NUMA
>  	struct zonelist *zonelist;
>  	struct zoneref *z;
> -	struct zone *zone;
> +	int nid;
>  	enum zone_type highest_zoneidx = gfp_zone(flags);
>  	void *object;
>  	unsigned int cpuset_mems_cookie;
> @@ -2222,12 +2222,12 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
>  	do {
>  		cpuset_mems_cookie = read_mems_allowed_begin();
>  		zonelist = node_zonelist(mempolicy_slab_node(), flags);
> -		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
> +		for_each_node_zonelist(nid, z, zonelist, highest_zoneidx) {
>  			struct kmem_cache_node *n;
>  
> -			n = get_node(s, zone_to_nid(zone));
> +			n = get_node(s, nid);
>  
> -			if (n && cpuset_zone_allowed(zone, flags) &&
> +			if (n && cpuset_node_allowed(nid, flags) &&
>  					n->nr_partial > s->min_partial) {

And the changes here look rather like using different iterator variable.

>  				object = get_partial_node(s, n, ret_slab, flags);
>  				if (object) {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d4a7d2bd276d..342874d54c45 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6176,9 +6176,9 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>  					  struct scan_control *sc)
>  {
>  	int initial_priority = sc->priority;
> -	pg_data_t *last_pgdat;
> +	pg_data_t *pgdat;
>  	struct zoneref *z;
> -	struct zone *zone;
> +	int nid;
>  retry:
>  	delayacct_freepages_start();
>  
> @@ -6205,20 +6205,16 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>  			sc->may_writepage = 1;
>  	} while (--sc->priority >= 0);
>  
> -	last_pgdat = NULL;
> -	for_each_zone_zonelist_nodemask(zone, z, zonelist, sc->reclaim_idx,
> +	for_each_node_zonelist_nodemask(nid, z, zonelist, sc->reclaim_idx,
>  					sc->nodemask) {
> -		if (zone->zone_pgdat == last_pgdat)
> -			continue;
> -		last_pgdat = zone->zone_pgdat;
> +		pgdat = NODE_DATA(nid);

I don't think this simplification is compelling enough to justify all the
changes.

>  
> -		snapshot_refaults(sc->target_mem_cgroup, zone->zone_pgdat);
> +		snapshot_refaults(sc->target_mem_cgroup, pgdat);
>  
>  		if (cgroup_reclaim(sc)) {
>  			struct lruvec *lruvec;
>  
> -			lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup,
> -						   zone->zone_pgdat);
> +			lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
>  			clear_bit(LRUVEC_CONGESTED, &lruvec->flags);
>  		}
>  	}
> -- 
> 2.17.1
> 
> 

-- 
Sincerely yours,
Mike.
