Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65C577E07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiGRIzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiGRIzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:55:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9DF26C9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658134544; x=1689670544;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Ucf6RGF4kkfg9paC6Z2vnUGhxY1a1SfILXXdFVsOPp4=;
  b=lpG0ln5j42AEiopl9eX0UmJR+4G1tdwErqS1kOPAd4scy8009a8FfO5r
   8nG3JhJ6ESQLxvO8lbLsrS0MIqx4qpPwY0tOFQKkHpOA4PrPvPuFXpv0x
   3uy4fxtonDbbXUft2PGebKMaRbKc+nRFFWIDZp9ZwXJFdzL3mFCy/4gOG
   2nWk/zztIFgUaKGGyP+0uDIm+w7AgZgtCRcCudBgUL2Z41hdSOvvfM39I
   jr4b4pmrMNW29Ng5uF8GATw+UXnSUr7tYQ+W7rCuy6Q10uurQ8J4H4Bg3
   lewOqobJFtFqOqteqaILy7MR9tHcLJlaeZr2vnIEARzGOlYI4KGVdc+S6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="350133644"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="350133644"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 01:55:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="924264809"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 01:55:40 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH v9 1/8] mm/demotion: Add support for explicit memory tiers
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
        <20220714045351.434957-2-aneesh.kumar@linux.ibm.com>
        <87bktq4xs7.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <3659f1bb-a82e-1aad-f297-808a2c17687d@linux.ibm.com>
        <87tu7e3o2h.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <cf68344f-9d6c-66c0-b8d5-e95ae3c01eb6@linux.ibm.com>
Date:   Mon, 18 Jul 2022 16:55:36 +0800
In-Reply-To: <cf68344f-9d6c-66c0-b8d5-e95ae3c01eb6@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Mon, 18 Jul 2022 13:30:55 +0530")
Message-ID: <87r12i3ilz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 7/18/22 12:27 PM, Huang, Ying wrote:
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> On 7/15/22 1:23 PM, Huang, Ying wrote:
>> 
>> [snip]
>> 
>>>>
>>>> You dropped the original sysfs interface patches from the series, but
>>>> the kernel internal implementation is still for the original sysfs
>>>> interface.  For example, memory tier ID is for the original sysfs
>>>> interface, not for the new proposed sysfs interface.  So I suggest you
>>>> to implement with the new interface in mind.  What do you think about
>>>> the following design?
>>>>
>>>
>>> Sorry I am not able to follow you here. This patchset completely drops
>>> exposing memory tiers to userspace via sysfs. Instead it allow
>>> creation of memory tiers with specific tierID from within the kernel/device driver.
>>> Default tierID is 200 and dax kmem creates memory tier with tierID 100. 
>>>
>>>
>>>> - Each NUMA node belongs to a memory type, and each memory type
>>>>   corresponds to a "abstract distance", so each NUMA node corresonds to
>>>>   a "distance".  For simplicity, we can start with static distances, for
>>>>   example, DRAM (default): 150, PMEM: 250.  The distance of each NUMA
>>>>   node can be recorded in a global array,
>>>>
>>>>     int node_distances[MAX_NUMNODES];
>>>>
>>>>   or, just
>>>>
>>>>     pgdat->distance
>>>>
>>>
>>> I don't follow this. I guess you are trying to have a different design.
>>> Would it be much easier if you can write this in the form of a patch? 
>> 
>> Written some pseudo code as follow to show my basic idea.
>> 
>> #define MEMORY_TIER_ADISTANCE_DRAM	150
>> #define MEMORY_TIER_ADISTANCE_PMEM	250
>> 
>> struct memory_tier {
>> 	/* abstract distance range covered by the memory tier */
>> 	int adistance_start;
>> 	int adistance_len;
>> 	struct list_head list;
>> 	nodemask_t nodemask;
>> };
>> 
>> /* RCU list of memory tiers */
>> static LIST_HEAD(memory_tiers);
>> 
>> /* abstract distance of each NUMA node */
>> int node_adistances[MAX_NUMNODES];
>> 
>> struct memory_tier *find_create_memory_tier(int adistance)
>> {
>> 	struct memory_tier *tier;
>> 
>> 	list_for_each_entry(tier, &memory_tiers, list) {
>> 		if (adistance >= tier->adistance_start &&
>> 		    adistance < tier->adistance_start + tier->adistance_len)
>> 			return tier;
>> 	}
>> 	/* allocate a new memory tier and return */
>> }
>> 
>> void memory_tier_add_node(int nid)
>> {
>> 	int adistance;
>> 	struct memory_tier *tier;
>> 
>> 	adistance = node_adistances[nid] || MEMORY_TIER_ADISTANCE_DRAM;
>> 	tier = find_create_memory_tier(adistance);
>> 	node_set(nid, &tier->nodemask);
>> 	/* setup demotion data structure, etc */
>> }
>> 
>> static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>> 						 unsigned long action, void *_arg)
>> {
>> 	struct memory_notify *arg = _arg;
>> 	int nid;
>> 
>> 	nid = arg->status_change_nid;
>> 	if (nid < 0)
>> 		return notifier_from_errno(0);
>> 
>> 	switch (action) {
>> 	case MEM_ONLINE:
>> 		memory_tier_add_node(nid);
>> 		break;
>> 	}
>> 
>> 	return notifier_from_errno(0);
>> }
>> 
>> /* kmem.c */
>> static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>> {
>> 	node_adistances[dev_dax->target_node] = MEMORY_TIER_ADISTANCE_PMEM;
>> 	/* add_memory_driver_managed() */
>> }
>> 
>> [snip]
>> 
>> Best Regards,
>> Huang, Ying
>
>
> Implementing that I ended up with the below. The difference is adistance_len is not a memory tier property
> instead it is a kernel parameter like memory_tier_chunk_size which can
> be tuned to create more memory tiers.

It's not determined how to represent the range of abstract distance of
memory tier.  perf_level_chunk_size or perf_level_granularity is another
possible solution.  But I don't think it should be a kernel parameter
for the fist step.

> How about this? Not yet tested.
>
> struct memory_tier {
> 	struct list_head list;
> 	int id;

We don't need "id" for now in fact.  So I suggest to remove it.  We can
add it when we really need it.

> 	int perf_level;
> 	nodemask_t nodelist;
> };
>
> static LIST_HEAD(memory_tiers);
> static DEFINE_MUTEX(memory_tier_lock);
> static unsigned int default_memtier_perf_level = DEFAULT_MEMORY_TYPE_PERF;
> core_param(default_memory_tier_perf_level, default_memtier_perf_level, uint, 0644);
> static unsigned int memtier_perf_chunk_size = 150;
> core_param(memory_tier_perf_chunk, memtier_perf_chunk_size, uint, 0644);
>
> /*
>  * performance levels are grouped into memtiers each of chunk size
>  * memtier_perf_chunk
>  */
> static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
> {
> 	bool found_slot = false;
> 	struct list_head *ent;
> 	struct memory_tier *memtier, *new_memtier;
> 	static int next_memtier_id = 0;
> 	/*
> 	 * zero is special in that it indicates uninitialized
> 	 * perf level by respective driver. Pick default memory
> 	 * tier perf level for that.
> 	 */
> 	if (!perf_level)
> 		perf_level = default_memtier_perf_level;
>
> 	lockdep_assert_held_once(&memory_tier_lock);
>
> 	list_for_each(ent, &memory_tiers) {
> 		memtier = list_entry(ent, struct memory_tier, list);
> 		if (perf_level >= memtier->perf_level &&
> 		    perf_level < memtier->perf_level + memtier_perf_chunk_size)
> 			return memtier;
> 		else if (perf_level < memtier->perf_level) {
> 			found_slot = true;
> 			break;
> 		}
> 	}
>
> 	new_memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
> 	if (!new_memtier)
> 		return ERR_PTR(-ENOMEM);
>
> 	new_memtier->id = next_memtier_id++;
> 	new_memtier->perf_level = ALIGN_DOWN(perf_level, memtier_perf_chunk_size);
> 	if (found_slot)
> 		list_add_tail(&new_memtier->list, ent);
> 	else
> 		list_add_tail(&new_memtier->list, &memory_tiers);
> 	return new_memtier;
> }
>
> static int __init memory_tier_init(void)
> {
> 	int node;
> 	struct memory_tier *memtier;
>
> 	/*
> 	 * Since this is early during  boot, we could avoid
> 	 * holding memtory_tier_lock. But keep it simple by
> 	 * holding locks. So we can add lock held debug checks
> 	 * in other functions.
> 	 */
> 	mutex_lock(&memory_tier_lock);
> 	memtier = find_create_memory_tier(default_memtier_perf_level);
> 	if (IS_ERR(memtier))
> 		panic("%s() failed to register memory tier: %ld\n",
> 		      __func__, PTR_ERR(memtier));
>
> 	/* CPU only nodes are not part of memory tiers. */
> 	memtier->nodelist = node_states[N_MEMORY];
>
> 	/*
> 	 * nodes that are already online and that doesn't
> 	 * have perf level assigned is assigned a default perf
> 	 * level.
> 	 */
> 	for_each_node_state(node, N_MEMORY) {
> 		struct node *node_property = node_devices[node];
>
> 		if (!node_property->perf_level)
> 			node_property->perf_level = default_memtier_perf_level;
> 	}
> 	mutex_unlock(&memory_tier_lock);
> 	return 0;
> }
> subsys_initcall(memory_tier_init);

I think that this can be a starting point of our future discussion and
review.  Thanks!

Best Regards,
Huang, Ying
