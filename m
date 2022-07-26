Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7509580A33
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 06:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiGZEEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 00:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbiGZEEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 00:04:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C302E2A27E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 21:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658808246; x=1690344246;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=oVa3FHsyt3TXJj0D7uZDaBI94swmdsKGF+L8lychpBU=;
  b=cqiBVEtrM21gcwPcxhTsz848PuaSWhs94FNGh3Hi0w4WF0jw3MKB6gSl
   4KXoKszKfAGxpGfjqmbARYneV1U4eyfUY69Ek/gm6CPTaJ8VTM/9rZuMS
   78UTsRelDdEBfdyT+wCmhtv6W2ROgoTJ8Rcd/b5Amp/1hkCUg6q8t4o1F
   lfLbXOmDh5PcbGAZhGgvwFtROq96QAA0aYCK0o9FNjGpR4aJBPqiG28lM
   6bX5bALAdHxn8GoQ5qDq45Gxwnzv4SrD5R2xm5JNT/jE/145WUR/xfoPa
   an4+ID6JyxRzei6VnohlMHFzr64fxnXiLPutwgWtAsoZYpnPm1Ks37nwu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="268244298"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="268244298"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 21:04:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="575326791"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 21:04:02 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v10 3/8] mm/demotion: Add hotplug callbacks to handle
 new numa node onlined
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
        <20220720025920.1373558-4-aneesh.kumar@linux.ibm.com>
Date:   Tue, 26 Jul 2022 12:03:58 +0800
In-Reply-To: <20220720025920.1373558-4-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Wed, 20 Jul 2022 08:29:15 +0530")
Message-ID: <87fsiowmdt.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> If the new NUMA node onlined doesn't have a performance level assigned,
> the kernel adds the NUMA node to default memory tier.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/memory-tiers.h |  1 +
>  mm/memory-tiers.c            | 75 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index ef380a39db3a..3d5f14d57ae6 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -14,6 +14,7 @@
>  #define MEMTIER_PERF_LEVEL_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
>  /* leave one tier below this slow pmem */
>  #define MEMTIER_PERF_LEVEL_PMEM	(1 << MEMTIER_CHUNK_BITS)
> +#define MEMTIER_HOTPLUG_PRIO	100
>  
>  extern bool numa_demotion_enabled;
>  
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 41a21cc5ae55..cc3a47ec18e4 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -5,6 +5,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/moduleparam.h>
>  #include <linux/node.h>
> +#include <linux/memory.h>
>  #include <linux/memory-tiers.h>
>  
>  struct memory_tier {
> @@ -64,6 +65,78 @@ static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
>  	return new_memtier;
>  }
>  
> +static struct memory_tier *__node_get_memory_tier(int node)
> +{
> +	struct memory_tier *memtier;
> +
> +	list_for_each_entry(memtier, &memory_tiers, list) {
> +		if (node_isset(node, memtier->nodelist))
> +			return memtier;
> +	}
> +	return NULL;
> +}
> +
> +static void init_node_memory_tier(int node)

set_node_memory_tier()?

> +{
> +	int perf_level;
> +	struct memory_tier *memtier;
> +
> +	mutex_lock(&memory_tier_lock);
> +
> +	memtier = __node_get_memory_tier(node);
> +	if (!memtier) {
> +		perf_level = node_devices[node]->perf_level;
> +		memtier = find_create_memory_tier(perf_level);
> +		node_set(node, memtier->nodelist);
> +	}
> +	mutex_unlock(&memory_tier_lock);
> +}
> +
> +static void clear_node_memory_tier(int node)
> +{
> +	struct memory_tier *memtier;
> +
> +	mutex_lock(&memory_tier_lock);
> +	memtier = __node_get_memory_tier(node);
> +	if (memtier)
> +		node_clear(node, memtier->nodelist);

When memtier->nodelist becomes empty, we need to free memtier?

> +	mutex_unlock(&memory_tier_lock);
> +}
> +
> +/*
> + * This runs whether reclaim-based migration is enabled or not,
> + * which ensures that the user can turn reclaim-based migration
> + * at any time without needing to recalculate migration targets.
> + */

The comments doesn't apply here.

> +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> +						 unsigned long action, void *_arg)

Now we are building memory tiers instead of working on demotion.  So I
think we should rename the function to memtier_hotplug_callback().

> +{
> +	struct memory_notify *arg = _arg;
> +
> +	/*
> +	 * Only update the node migration order when a node is
> +	 * changing status, like online->offline.
> +	 */
> +	if (arg->status_change_nid < 0)
> +		return notifier_from_errno(0);
> +
> +	switch (action) {
> +	case MEM_OFFLINE:
> +		clear_node_memory_tier(arg->status_change_nid);
> +		break;
> +	case MEM_ONLINE:
> +		init_node_memory_tier(arg->status_change_nid);
> +		break;
> +	}
> +
> +	return notifier_from_errno(0);
> +}
> +
> +static void __init migrate_on_reclaim_init(void)
> +{
> +	hotplug_memory_notifier(migrate_on_reclaim_callback, MEMTIER_HOTPLUG_PRIO);
> +}

I suggest to call hotplug_memory_notifier() in memory_tier_init()
directly.  We are not working on demotion here.

> +
>  static int __init memory_tier_init(void)
>  {
>  	int node;
> @@ -96,6 +169,8 @@ static int __init memory_tier_init(void)
>  			node_property->perf_level = default_memtier_perf_level;
>  	}
>  	mutex_unlock(&memory_tier_lock);
> +
> +	migrate_on_reclaim_init();
>  	return 0;
>  }
>  subsys_initcall(memory_tier_init);

Best Regards,
Huang, Ying
