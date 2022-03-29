Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240304EA44C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 02:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiC2ApL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 20:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiC2ApJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 20:45:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BEE5FA6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648514607; x=1680050607;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=/SIBH5oWohQy65qzFL+jDrUGSvvNfU7eDJd+7md+aW4=;
  b=f2Jw/Y3uag79atP+vFKkB9Gbmax7BSsyaj/gQ56PoLmaxS1RSvBW3Gme
   EFwLIQX5MOewxvumtf2+QsjnQnk6AQNjMfdtgh4w9P9GnqoSRA4UU7RjJ
   oiMnCMwWOjz4KIKaBfOqSaq3dJmsWCjdl455qfr0BHAprd9MGszv+eTvj
   cmB+t/VsI2bx4JZJHWTKfouhYDFDe9LR137merI1V/GghK6OEp7VXC2DC
   28toSc56d07EF+bxxhmioQthjaSSxDjbKEhUCCvHRqCLJ4di4rZ3imwxZ
   HxbFHW6PZaodh85HZn/rTvBlWRVEZrqfedy1YPZV8SFZQhqJZ1ck0KNbT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239727309"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="239727309"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 17:43:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="564145770"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 17:43:25 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net
Subject: Re: [PATCH 2/2] mm/vmscan: make sure wakeup_kswapd with managed zone
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
        <20220327024101.10378-2-richard.weiyang@gmail.com>
        <8735j2opd9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20220329004146.2xdswvrm2qu7f47x@master>
Date:   Tue, 29 Mar 2022 08:43:23 +0800
In-Reply-To: <20220329004146.2xdswvrm2qu7f47x@master> (Wei Yang's message of
        "Tue, 29 Mar 2022 00:41:46 +0000")
Message-ID: <875ynxh9lg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richard.weiyang@gmail.com> writes:

> On Mon, Mar 28, 2022 at 09:08:34AM +0800, Huang, Ying wrote:
>>Hi, Wei,
>>
>>Wei Yang <richard.weiyang@gmail.com> writes:
>>
>>> wakeup_kswapd() only wake up kswapd when the zone is managed.
>>>
>>> For two callers of wakeup_kswapd(), they are node perspective.
>>>
>>>   * wake_all_kswapds
>>>   * numamigrate_isolate_page
>>>
>>> If we picked up a !managed zone, this is not we expected.
>>>
>>> This patch makes sure we pick up a managed zone for wakeup_kswapd().
>>>
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> ---
>>>  mm/migrate.c    | 2 +-
>>>  mm/page_alloc.c | 2 ++
>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 3d60823afd2d..c4b654c0bdf0 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -2046,7 +2046,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>>  		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
>>>  			return 0;
>>>  		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
>>> -			if (populated_zone(pgdat->node_zones + z))
>>> +			if (managed_zone(pgdat->node_zones + z))
>>
>>This looks good to me!  Thanks!  It seems that we can replace
>>populated_zone() in migrate_balanced_pgdat() too.  Right?
>>
>
> Yes, you are right. I didn't spot this.
>
> While this patch comes from the clue of wakeup_kswapd(), I am not sure it is
> nice to put it in this patch together.
>
> Which way you prefer to include this: merge the change into this one, or a
> separate one?

Either is OK for me.

Best Regards,
Huang, Ying
