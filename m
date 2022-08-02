Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1758755E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiHBB7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiHBB71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:59:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C130113EA9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659405522; x=1690941522;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=N6ddLI1FzmQXAr3nPznxZnrgs8Fz5EdUEt75OuJpNl0=;
  b=miP1aPxBnERQ3NnPpC2MeV1wi1aR2bvBZoHl3IMZbkIK9mtEprS5bR1V
   Xh4+9Kfa3IWW5QcJihoeklSynYw2mchGLz8p1/W1s8eb7LQbIKIiJh3Eq
   J8/KnQYxthWKuh+DwTnA/8mUrAIBUz/pD/UI/DcBCJSYC8wzlLbnhL9ic
   N59/9vZgg4sIXDp0FvIUepHnqxYaU+9SkGifGS/R64hv1sIclX1rifSeB
   22DPqQxAjtWw2eRl7Pq9QiSOxNqUFYW1r/tfUAVM81n6BWuzxh12AGwZn
   J4dj5zNDvUVaVbDygbpKbtxBJeRY4y4GS7pzyf3ZUmlSxGjgVOYpEufaL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="351006348"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="351006348"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 18:58:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="578017779"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 18:58:31 -0700
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v11 4/8] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_ADISTANCE_PMEM
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
        <20220728190436.858458-5-aneesh.kumar@linux.ibm.com>
        <875yjgmocg.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87bkt8s7w9.fsf@linux.ibm.com>
        <87k07slnt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <e5545c90-9595-d08c-8a1c-1c15e3b94999@linux.ibm.com>
        <87tu6wk0q5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <826fbdbc-219f-8f4a-7373-41c718287533@linux.ibm.com>
        <87les8jwpu.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <1aba0c44-b096-8c75-8086-62d3cffc08b3@linux.ibm.com>
        <87h72wjv27.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <394c0599-2dc0-0303-cd86-bdd2d265d1ee@linux.ibm.com>
Date:   Tue, 02 Aug 2022 09:58:28 +0800
In-Reply-To: <394c0599-2dc0-0303-cd86-bdd2d265d1ee@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Mon, 1 Aug 2022 13:11:11 +0530")
Message-ID: <878ro7jtiz.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 8/1/22 12:43 PM, Huang, Ying wrote:
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> On 8/1/22 12:07 PM, Huang, Ying wrote:
>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>
>>>>> On 8/1/22 10:40 AM, Huang, Ying wrote:
>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>
>>>>>>> On 8/1/22 7:36 AM, Huang, Ying wrote:
>>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>
>>>>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>>>>
>>>>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>
>>> ....
>>>
>>>>>>>
>>>>>>> With the module unload, it is kind of force removing the usage of the specific memtype.
>>>>>>> Considering module unload will remove the usage of specific memtype from other parts
>>>>>>> of the kernel and we already do all the required reset in memory hot unplug, do we
>>>>>>> need to do the clear_node_memory_type above? 
>>>>>>
>>>>>> Per my understanding, we need to call clear_node_memory_type() in
>>>>>> dev_dax_kmem_remove().  After that, we have nothing to do in
>>>>>> dax_kmem_exit().
>>>>>>
>>>>>
>>>>> Ok, I guess you are suggesting to do the clear_node_memory_type even if we fail the memory remove. 
>>>>
>>>> Can we use node_memory_types[] to indicate whether a node is managed by
>>>> a driver?
>>>>
>>>> Regardless being succeeded or failed, dev_dax_kmem_remove() will set
>>>> node_memory_types[] = NULL.  But until node is offlined, we will still
>>>> keep the node in the memory_dev_type (dax_pmem_type).
>>>>
>>>> And we will prevent dax/kmem from unloading via try_module_get() and add
>>>> "struct module *" to struct memory_dev_type.
>>>>
>>>
>>> Current dax/kmem driver is not holding any module reference and allows the module to be unloaded
>>> anytime. Even if the memory onlined by the driver fails to be unplugged. Addition of memory_dev_type
>>> as suggested by you will be different than that. Page demotion can continue to work without the
>>> support of dax_pmem_type as long as we keep the older demotion order. Any new demotion order
>>> rebuild will remove the the memory node which was not hotunplugged  from the demotion order. Isn't that
>>> a much simpler implementation? 
>> 
>> Per my understanding, unbinding/binding the dax/kmem driver means
>> changing the memory type of a memory device.  For example, unbinding
>> dax/kmem driver may mean changing the memory type from dax_pmem_type to
>> default_memory_type (or default_dram_type).  That appears strange.  But
>> if we force the NUMA node to be offlined for unbinding, we can avoid to
>> change the memory type to default_memory_type.
>> 
>
> If we are able to unplug all the memory, we do remove the node from N_MEMORY.
> If we fail to unplug the memory, we have two options. 
>
> 1) Keep the same demotion order
> 2) Rebuild the demotion order which results in memory NUMA node not participating
>    in demotion. 
>
> I agree with you that we should not switch to default memory type. 
>
> The below code demonstrate how it can be done. If we want to keep
> the same demotion order, we can remove establish_demotion_target() from
> the below code. 
>
> void clear_node_memory_type(int node, struct memory_dev_type *memtype)
> {
> 	struct memory_tier *memtier;
> 	pg_data_t *pgdat = NODE_DATA(node);
>
> 	mutex_lock(&memory_tier_lock);
> 	/*
> 	 * Even if we fail to unplug memory, clear the association of
> 	 * this node to this specific memory type.
> 	 */
> 	if (node_isset(node, memtype->nodes) && node_memory_types[node] == memtype) {
>
> 		memtier = __node_get_memory_tier(node);
> 		if (memtier) {
> 			rcu_assign_pointer(pgdat->memtier, NULL);
> 			synchronize_rcu();
> 		}
> 		node_clear(node, memtype->nodes);
> 		if (nodes_empty(memtype->nodes)) {
> 			list_del(&memtype->tier_sibiling);
> 			memtype->memtier = NULL;
> 			if (memtier && list_empty(&memtier->memory_types))
> 				destroy_memory_tier(memtier);
>
> 		}
> 		establish_demotion_targets();
> 	}
> 	node_memory_types[node] = NULL;
> 	mutex_unlock(&memory_tier_lock);
> }
>
>
> If we agree that we want to keep the current behavior (that is to allow kmem driver unload
> even on memory unplug failure) we can go with the above change. If we are suggesting we
> should prevent a driver unload, then IMHO it should be independent of memory_dev_type
> (or this patch series). We should make sure we take a module reference on successful
> memory online and drop it only on successful offline. 

I suggest to keep a NUMA node in the memory_dev_type (dax_pmem_type)
until the node is offlined.

Yes.  The dax/kmem driver may be unbound to the dax device even if
memory offlining fails.  But we can still find someway to keep
the memory_dev_type of the NUMA node unchanged.

Solution 1 is to prevent dax/kmem driver from unloading via module
reference.  I think we do that in this series.

Solution 2 is to allocate dax_pmem_type dynamically, and manage it like
"kmem_name".  We may need some kind of reference counting to manage it.

Best Regards,
Huang, Ying

