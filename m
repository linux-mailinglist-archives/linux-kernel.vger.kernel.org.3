Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101DC4E8B75
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiC1BKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiC1BKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:10:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E408E4EF47
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648429718; x=1679965718;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=c8/MgHXx3maUUUtV6Fsyj+VWOWpDvpWGJo7i6X8QRnk=;
  b=e0jo8SA9kgk3tjwDt0OWv2pDEmK4rmsYvLpCROa47Lv7Dmt7Wo0yi67D
   OBkjc14pL0JH+qFER6ntCBw0T0cCmbv4fd2IbzwqWMasUByIyoX7FnyH/
   FeL9Iun0GFBgKBEFXiEUCLjSi2giDQMPudCsoJxTGSSwL5RBEdpl/Mf2I
   T8Ux4t/IOjLHjwwOtxo41xEurBS87ghx1N0FCs47gQoYe1Gls3wC04VB+
   tFbDv7mkgxhMuRfivDUXqq6aUVw9FoHPpr7KcPgyb5MnLPVWOMBKMmq2Q
   wzuaiH+alntnRzygbsOjFxkE0+LfPYLQzUB/d308h9DlhwPyp/Cmgg+++
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="283773627"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="283773627"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 18:08:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="545755351"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 18:08:36 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net
Subject: Re: [PATCH 2/2] mm/vmscan: make sure wakeup_kswapd with managed zone
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
        <20220327024101.10378-2-richard.weiyang@gmail.com>
Date:   Mon, 28 Mar 2022 09:08:34 +0800
In-Reply-To: <20220327024101.10378-2-richard.weiyang@gmail.com> (Wei Yang's
        message of "Sun, 27 Mar 2022 02:41:01 +0000")
Message-ID: <8735j2opd9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wei,

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
> This patch makes sure we pick up a managed zone for wakeup_kswapd().
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  mm/migrate.c    | 2 +-
>  mm/page_alloc.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 3d60823afd2d..c4b654c0bdf0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2046,7 +2046,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
>  			return 0;
>  		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
> -			if (populated_zone(pgdat->node_zones + z))
> +			if (managed_zone(pgdat->node_zones + z))

This looks good to me!  Thanks!  It seems that we can replace
populated_zone() in migrate_balanced_pgdat() too.  Right?

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

Best Regards,
Huang, Ying
