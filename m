Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA82149DC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiA0I20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:28:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44980 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiA0I2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:28:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5C0B021904;
        Thu, 27 Jan 2022 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643272099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKwmHasx6cNIOtEqFZmKX8VIkRB0CJ5THiVwoA6l1Yo=;
        b=L37K3Yi1xWUmPAahnJRKqSepNwFhR0VVQ6OgN7TE06U16NG0rkOsOkvSuVip8k+NuH3yiX
        VXKR64l+Y15lW+8PCoQfffKjRxtBdX0RRse/QNYhRkmhwk/vXzVZ47m9eYNBonaQDT0R62
        Mm/GrnMWevJY2DRCtNHnsdXjy8ElbvM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D11E4A3B8B;
        Thu, 27 Jan 2022 08:28:17 +0000 (UTC)
Date:   Thu, 27 Jan 2022 09:28:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: build zonelist for managed_zone
Message-ID: <YfJXoSVkQ3X5u44F@dhcp22.suse.cz>
References: <20220127012023.18095-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127012023.18095-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-01-22 01:20:23, Wei Yang wrote:
> During memory hotplug, when online/offline a zone, we need to rebuild
> the zonelist for all node. There are two checks to decide whether a zone
> would be added to zonelist:
> 
>   * one in online_pages/offline_pages to decide necessity
>   * one in build_zonerefs_node to do real add
> 
> Currently we use different criteria at these two places, which is
> different from the original behavior.
> 
> Originally during memory hotplug, zonelist is re-built when zone hasn't
> been populated. This in introduced in 'commit 6811378e7d8b ("[PATCH]
> wait_table and zonelist initializing for memory hotadd: update zonelists")'.
> And at that moment, build_zonelists_node() also use populated_zone() to
> decide whether the zone should be added to zonelist.
> 
> While in 'commit 6aa303defb74 ("mm, vmscan: only allocate and reclaim
> from zones with pages managed by the buddy allocator")',
> build_zonelists_node() changed to use managed_zone() to add zonelist.
> But we still use populated_zone() to decide the necessity.
> 
> This patch restore the original behavior by using the same criteria to
> add a zone in zonelist during memory hotplug.

Why?

> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Fixes: 6aa303defb74 ("mm, vmscan: only allocate and reclaim from zones with pages managed by the buddy allocator")
> CC: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/memory_hotplug.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2a9627dc784c..8f1906b33937 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1102,11 +1102,11 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  
>  	/*
> -	 * If this zone is not populated, then it is not in zonelist.
> +	 * If this zone is not managed, then it is not in zonelist.
>  	 * This means the page allocator ignores this zone.
>  	 * So, zonelist must be updated after online.
>  	 */
> -	if (!populated_zone(zone)) {
> +	if (!managed_zone(zone)) {
>  		need_zonelists_rebuild = 1;
>  		setup_zone_pageset(zone);
>  	}
> @@ -1985,7 +1985,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  	/* reinitialise watermarks and update pcp limits */
>  	init_per_zone_wmark_min();
>  
> -	if (!populated_zone(zone)) {
> +	if (!managed_zone(zone)) {
>  		zone_pcp_reset(zone);
>  		build_all_zonelists(NULL);
>  	}
> -- 
> 2.33.1

-- 
Michal Hocko
SUSE Labs
