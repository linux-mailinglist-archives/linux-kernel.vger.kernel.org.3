Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620DE581D59
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbiG0BxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiG0BxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:53:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B4527CCD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658886790; x=1690422790;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=d+eyjwKRKtr2OzmTv9uExOvL3SJhLVSG/OVMV6nZByk=;
  b=aOazSj6FuVk65nUcH6dMRP5xubJMw/i4fMF+5FCc6/sFQxERYm8WM1ma
   ivcp+coEiyiomTHCu3ulE4uIEbirlAQBiSUK9gRHPTwp1vt2EZqRjDBFY
   UcPDsJicerhavFnE5VKFvBYfWztM1pKlXGu1dmihqG6SHqf8RBY/Q/wNy
   5sB0j+7unt50yiAHEsFC74wQXIxHiAQy8PW5S0DA263bFEZgw8+nhx3+h
   29QAV5Z+v2fCqm0REuJBFOhuN1qo+bjgUtd7PMJZRZMxZLC4JtV8zhNw9
   +aMVpBC/jOTe3L/dWKhbicMCi4EaZzbwWI/3HJT4CwmBUhzFp/iSIZSYO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="268506068"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="268506068"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 18:53:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="927598707"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 18:53:06 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v10 3/8] mm/demotion: Add hotplug callbacks to handle
 new numa node onlined
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
        <20220720025920.1373558-4-aneesh.kumar@linux.ibm.com>
        <87fsiowmdt.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <28582201-b438-9ac9-ca6b-1ee6e5794dd2@linux.ibm.com>
Date:   Wed, 27 Jul 2022 09:53:03 +0800
In-Reply-To: <28582201-b438-9ac9-ca6b-1ee6e5794dd2@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Tue, 26 Jul 2022 17:33:37 +0530")
Message-ID: <87czdruxs0.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 7/26/22 9:33 AM, Huang, Ying wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> If the new NUMA node onlined doesn't have a performance level assigned,
>>> the kernel adds the NUMA node to default memory tier.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>  include/linux/memory-tiers.h |  1 +
>>>  mm/memory-tiers.c            | 75 ++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 76 insertions(+)
>>>
>>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>>> index ef380a39db3a..3d5f14d57ae6 100644
>>> --- a/include/linux/memory-tiers.h
>>> +++ b/include/linux/memory-tiers.h
>>> @@ -14,6 +14,7 @@
>>>  #define MEMTIER_PERF_LEVEL_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
>>>  /* leave one tier below this slow pmem */
>>>  #define MEMTIER_PERF_LEVEL_PMEM	(1 << MEMTIER_CHUNK_BITS)
>>> +#define MEMTIER_HOTPLUG_PRIO	100
>>>  
>>>  extern bool numa_demotion_enabled;
>>>  
>>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>>> index 41a21cc5ae55..cc3a47ec18e4 100644
>>> --- a/mm/memory-tiers.c
>>> +++ b/mm/memory-tiers.c
>>> @@ -5,6 +5,7 @@
>>>  #include <linux/lockdep.h>
>>>  #include <linux/moduleparam.h>
>>>  #include <linux/node.h>
>>> +#include <linux/memory.h>
>>>  #include <linux/memory-tiers.h>
>>>  
>>>  struct memory_tier {
>>> @@ -64,6 +65,78 @@ static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
>>>  	return new_memtier;
>>>  }
>>>  
>>> +static struct memory_tier *__node_get_memory_tier(int node)
>>> +{
>>> +	struct memory_tier *memtier;
>>> +
>>> +	list_for_each_entry(memtier, &memory_tiers, list) {
>>> +		if (node_isset(node, memtier->nodelist))
>>> +			return memtier;
>>> +	}
>>> +	return NULL;
>>> +}
>>> +
>>> +static void init_node_memory_tier(int node)
>> 
>> set_node_memory_tier()?
>
> That was done based on feedback from Alistair 
>
> https://lore.kernel.org/linux-mm/87h73iapg1.fsf@nvdebian.thelocal
>
>> 
>>> +{
>>> +	int perf_level;
>>> +	struct memory_tier *memtier;
>>> +
>>> +	mutex_lock(&memory_tier_lock);
>>> +
>>> +	memtier = __node_get_memory_tier(node);
>>> +	if (!memtier) {
>>> +		perf_level = node_devices[node]->perf_level;
>>> +		memtier = find_create_memory_tier(perf_level);
>>> +		node_set(node, memtier->nodelist);
>>> +	}

It's related to Alistair's comments too.  When will memtier != NULL
here?  We may need just VM_WARN_ON() here?

>>> +	mutex_unlock(&memory_tier_lock);
>>> +}
>>> +
>>> +static void clear_node_memory_tier(int node)
>>> +{
>>> +	struct memory_tier *memtier;
>>> +
>>> +	mutex_lock(&memory_tier_lock);
>>> +	memtier = __node_get_memory_tier(node);
>>> +	if (memtier)
>>> +		node_clear(node, memtier->nodelist);
>> 
>> When memtier->nodelist becomes empty, we need to free memtier?
>> 
>>> +	mutex_unlock(&memory_tier_lock);
>>> +}
>>> +
>>> +/*
>>> + * This runs whether reclaim-based migration is enabled or not,
>>> + * which ensures that the user can turn reclaim-based migration
>>> + * at any time without needing to recalculate migration targets.
>>> + */
>> 
>> The comments doesn't apply here.
>> 
>>> +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>>> +						 unsigned long action, void *_arg)
>> 
>> Now we are building memory tiers instead of working on demotion.  So I
>> think we should rename the function to memtier_hotplug_callback().
>> 
>>> +{
>>> +	struct memory_notify *arg = _arg;
>>> +
>>> +	/*
>>> +	 * Only update the node migration order when a node is
>>> +	 * changing status, like online->offline.
>>> +	 */
>>> +	if (arg->status_change_nid < 0)
>>> +		return notifier_from_errno(0);
>>> +
>>> +	switch (action) {
>>> +	case MEM_OFFLINE:
>>> +		clear_node_memory_tier(arg->status_change_nid);
>>> +		break;
>>> +	case MEM_ONLINE:
>>> +		init_node_memory_tier(arg->status_change_nid);
>>> +		break;
>>> +	}
>>> +
>>> +	return notifier_from_errno(0);
>>> +}
>>> +
>>> +static void __init migrate_on_reclaim_init(void)
>>> +{
>>> +	hotplug_memory_notifier(migrate_on_reclaim_callback, MEMTIER_HOTPLUG_PRIO);
>>> +}
>> 
>> I suggest to call hotplug_memory_notifier() in memory_tier_init()
>> directly.  We are not working on demotion here.
>> 
>>> +
>>>  static int __init memory_tier_init(void)
>>>  {
>>>  	int node;
>>> @@ -96,6 +169,8 @@ static int __init memory_tier_init(void)
>>>  			node_property->perf_level = default_memtier_perf_level;
>>>  	}
>>>  	mutex_unlock(&memory_tier_lock);
>>> +
>>> +	migrate_on_reclaim_init();
>>>  	return 0;
>>>  }
>>>  subsys_initcall(memory_tier_init);
>> 
>> Best Regards,
>> Huang, Ying
>
>
> Will update the patch in next iteration to take care of other feedback.

Thanks!

Best Regards,
Huang, Ying
