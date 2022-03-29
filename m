Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82284EA494
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiC2B2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiC2B2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:28:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A11665FB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648517224; x=1680053224;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=4Jyho/Vl1IV1Mo+iuygJWy/nrBoTIHIGo7ZFKCoEr2I=;
  b=JWqLJY+hDCyMPIOKIBf2DomuYnkztVcttY0zpf8qgl1sJRQ1NC2Um+74
   3btMOOIp8mS7fApi2Gp9172111DloKZbqH4/NmVFF0VrISfOOUqmiGI2P
   rkLoY02hDKZfw1A9cmlNPW8AX0XbWskKFqHnXKsHl/FMUBWaCf53rDxCO
   VM5dtMZ5PMi5XOmFb/DM3+X4FFyAk8qh6qNw6zoN6iekJpNm3azW5yvGk
   520BGydbOf4pyJCsoj2oCSmWVO505de8n1ORV0dmAFKZnNLGs8Vs9rijB
   UEm/X2TYOj35knxKfZgl6ihM5cx7gbevdZiRRPqdzL7+FSq13nget5rF5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="246626398"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="246626398"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 18:26:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="521237885"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 18:26:49 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [Patch v2 2/2] mm/vmscan: make sure wakeup_kswapd with managed
 zone
References: <20220329010901.1654-1-richard.weiyang@gmail.com>
        <20220329010901.1654-2-richard.weiyang@gmail.com>
Date:   Tue, 29 Mar 2022 09:26:47 +0800
In-Reply-To: <20220329010901.1654-2-richard.weiyang@gmail.com> (Wei Yang's
        message of "Tue, 29 Mar 2022 01:09:01 +0000")
Message-ID: <87czi5ft0o.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richard.weiyang@gmail.com> writes:

> wakeup_kswapd() only wake up kswapd when the zone is managed.
>
> For two callers of wakeup_kswapd(), they are node perspective.
>
>   * wake_all_kswapds
>   * numamigrate_isolate_page
>
> If we picked up a !managed zone, this is not we expected.
>
> This patch makes sure we pick up a managed zone for wakeup_kswapd(). And
> it also use managed_zone in migrate_balanced_pgdat() to get the proper
> zone.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

>
> ---
> v2: adjust the usage in migrate_balanced_pgdat()
>
> ---
>  mm/migrate.c    | 6 +++---
>  mm/page_alloc.c | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 3d60823afd2d..5adc55b5347c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1971,7 +1971,7 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
>  #ifdef CONFIG_NUMA_BALANCING
>  /*
>   * Returns true if this is a safe migration target node for misplaced NUMA
> - * pages. Currently it only checks the watermarks which crude
> + * pages. Currently it only checks the watermarks which is crude.
>   */
>  static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
>  				   unsigned long nr_migrate_pages)
> @@ -1981,7 +1981,7 @@ static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
>  	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
>  		struct zone *zone = pgdat->node_zones + z;
>  
> -		if (!populated_zone(zone))
> +		if (!managed_zone(zone))
>  			continue;
>  
>  		/* Avoid waking kswapd by allocating pages_to_migrate pages. */
> @@ -2046,7 +2046,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
>  			return 0;
>  		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
> -			if (populated_zone(pgdat->node_zones + z))
> +			if (managed_zone(pgdat->node_zones + z))
>  				break;
>  		}
>  		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4c0c4ef94ba0..6656c2d06e01 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4674,6 +4674,8 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
>  
>  	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, highest_zoneidx,
>  					ac->nodemask) {
> +		if (!managed_zone(zone))
> +			continue;
>  		if (last_pgdat != zone->zone_pgdat)
>  			wakeup_kswapd(zone, gfp_mask, order, highest_zoneidx);
>  		last_pgdat = zone->zone_pgdat;
