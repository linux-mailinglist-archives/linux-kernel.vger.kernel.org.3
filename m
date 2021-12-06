Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57D9469247
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbhLFJ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:26:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53032 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240578AbhLFJ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:26:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B692F2113D;
        Mon,  6 Dec 2021 09:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638782580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6SL+dw8xiegZOEy7ixRAKzns/BNFz2NcDmIP6EtRCdI=;
        b=iDKPE5O+zutlyBdP+d56Rfo7fDfdsYBYuZR6xgc19olM4xlbpKFBTx7tXnHJNHPgJvbKYn
        cwBnH/ATFHn6XMcWFCoUWDDr6ETQbDVrSLSm/Ud00gnhD7ARXasDPNzpkopRebpZiJU8Fk
        s2ugW3ffuh7GMiCCG0pL8JJ7A0Q5Z2U=
Received: from suse.cz (unknown [10.163.30.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 888F2A3B81;
        Mon,  6 Dec 2021 09:23:00 +0000 (UTC)
Date:   Mon, 6 Dec 2021 10:22:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206033338.743270-3-npache@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 05-12-21 22:33:38, Nico Pache wrote:
> We have run into a panic caused by a shrinker allocation being attempted
> on an offlined node.
> 
> Our crash analysis has determined that the issue originates from trying
> to allocate pages on an offlined node in expand_one_shrinker_info. This
> function makes the incorrect assumption that we can allocate on any node.
> To correct this we make sure we only itterate over online nodes.
> 
> This assumption can lead to an incorrect address being assigned to ac->zonelist
> in the following callchain:
> 	__alloc_pages
> 	-> prepare_alloc_pages
> 	 -> node_zonelist
> 
> static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> {
>         return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> }
> if the node is not online the return of node_zonelist will evaluate to a
> invalid pointer of 0x00000 + offset_of(node_zonelists) + (1|0)
> 
> This address is then dereferenced further down the callchain in:
> 	prepare_alloc_pages
> 	-> first_zones_zonelist
>   	 -> next_zones_zonelist
> 	  -> zonelist_zone_idx
> 
> static inline int zonelist_zone_idx(struct zoneref *zoneref)
> {
>         return zoneref->zone_idx;
> }
> 
> Leading the system to panic.

Thanks for the analysis! Please also add an oops report so that this is
easier to search for. It would be also interesting to see specifics
about the issue. Why was the specific node !online in the first place?
What architecture was this on?

> We also correct this behavior in alloc_shrinker_info, free_shrinker_info,
> and reparent_shrinker_deferred.
> 
> Fixes: 2bfd36374edd ("mm: vmscan: consolidate shrinker_maps handling code")
> Fixes: 0a4465d34028 ("mm, memcg: assign memcg-aware shrinkers bitmap to memcg")

Normally I would split the fix as it is fixing two issues one introduced
in 4.19 the other in 5.13.

> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/vmscan.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fb9584641ac7..731564b61e3f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -221,7 +221,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  	int nid;
>  	int size = map_size + defer_size;
>  
> -	for_each_node(nid) {
> +	for_each_online_node(nid) {
>  		pn = memcg->nodeinfo[nid];
>  		old = shrinker_info_protected(memcg, nid);
>  		/* Not yet online memcg */
> @@ -256,7 +256,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
>  	struct shrinker_info *info;
>  	int nid;
>  
> -	for_each_node(nid) {
> +	for_each_online_node(nid) {
>  		pn = memcg->nodeinfo[nid];
>  		info = rcu_dereference_protected(pn->shrinker_info, true);
>  		kvfree(info);
> @@ -274,7 +274,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  	map_size = shrinker_map_size(shrinker_nr_max);
>  	defer_size = shrinker_defer_size(shrinker_nr_max);
>  	size = map_size + defer_size;
> -	for_each_node(nid) {
> +	for_each_online_node(nid) {
>  		info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
>  		if (!info) {
>  			free_shrinker_info(memcg);
> @@ -417,7 +417,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  
>  	/* Prevent from concurrent shrinker_info expand */
>  	down_read(&shrinker_rwsem);
> -	for_each_node(nid) {
> +	for_each_online_node(nid) {
>  		child_info = shrinker_info_protected(memcg, nid);
>  		parent_info = shrinker_info_protected(parent, nid);
>  		for (i = 0; i < shrinker_nr_max; i++) {
> -- 
> 2.33.1

This doesn't seen complete. Slab shrinkers are used in the reclaim
context. Previously offline nodes could be onlined later and this would
lead to NULL ptr because there is no hook to allocate new shrinker
infos. This would be also really impractical because this would have to
update all existing memcgs...

To be completely honest I am not really sure this is a practical problem
because some architectures allocate (aka make online) all possible nodes
reported by the platform. There are major inconsistencies there. Maybe
that should be unified, so that problems like this one do not really
have to add a complexity to the code.

-- 
Michal Hocko
SUSE Labs
