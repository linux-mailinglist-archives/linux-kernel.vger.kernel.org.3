Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E05863B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 07:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbiHAFKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 01:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiHAFKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 01:10:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DF012D3E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659330650; x=1690866650;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=sXlUNBQU0YAqd7QbFGF/4F/JI9f2vYUenSiG17xay1s=;
  b=N9u/6YJ43jvxhgl6tjqtwkDQKILmtytHlQFIkEVqYcBFc8NihQEm1dRJ
   CJQUzUijC9do+pPkBMFbA0ZbeCDp8AUGX9NbkXBZ7eOOn1d7EPhcglAZb
   Nte/UznQ1/dMwbxQANOxuEhGSBPvXBYysNoDwiStM8iI5sqJUkABZSfXH
   erWi0P/suApH34P10ofAgvpeXNmCDHNlAAuECSQ7lSOUx14VcA3lg33an
   ixFq3DSfELNf3rDLshrnm97GoCEcyCKiCvelial9L7QEksGCSczUkmDg7
   /bh8t8unoIITqLdHu98/ODXDByY8FYyj/SEfTT8lJDcUEIfmpjzXYoqfc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="289835387"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="289835387"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 22:10:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="577651319"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 22:10:46 -0700
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
Date:   Mon, 01 Aug 2022 13:10:42 +0800
In-Reply-To: <e5545c90-9595-d08c-8a1c-1c15e3b94999@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Mon, 1 Aug 2022 10:10:39 +0530")
Message-ID: <87tu6wk0q5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 8/1/22 7:36 AM, Huang, Ying wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>
>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>
>>>>> By default, all nodes are assigned to the default memory tier which
>>>>> is the memory tier designated for nodes with DRAM
>>>>>
>>>>> Set dax kmem device node's tier to slower memory tier by assigning
>>>>> abstract distance to MEMTIER_ADISTANCE_PMEM. PMEM tier
>>>>> appears below the default memory tier in demotion order.
>>>>>
>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>> ---
>>>>>  drivers/dax/kmem.c           |  9 +++++++++
>>>>>  include/linux/memory-tiers.h | 19 ++++++++++++++++++-
>>>>>  mm/memory-tiers.c            | 28 ++++++++++++++++------------
>>>>>  3 files changed, 43 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>>>> index a37622060fff..6b0d5de9a3e9 100644
>>>>> --- a/drivers/dax/kmem.c
>>>>> +++ b/drivers/dax/kmem.c
>>>>> @@ -11,6 +11,7 @@
>>>>>  #include <linux/fs.h>
>>>>>  #include <linux/mm.h>
>>>>>  #include <linux/mman.h>
>>>>> +#include <linux/memory-tiers.h>
>>>>>  #include "dax-private.h"
>>>>>  #include "bus.h"
>>>>>  
>>>>> @@ -41,6 +42,12 @@ struct dax_kmem_data {
>>>>>  	struct resource *res[];
>>>>>  };
>>>>>  
>>>>> +static struct memory_dev_type default_pmem_type  = {
>>>>
>>>> Why is this named as default_pmem_type?  We will not change the memory
>>>> type of a node usually.
>>>>
>>>
>>> Any other suggestion? pmem_dev_type? 
>> 
>> Or dax_pmem_type?
>> 
>> DAX is used to enumerate the memory device.
>> 
>>>
>>>>> +	.adistance = MEMTIER_ADISTANCE_PMEM,
>>>>> +	.tier_sibiling = LIST_HEAD_INIT(default_pmem_type.tier_sibiling),
>>>>> +	.nodes  = NODE_MASK_NONE,
>>>>> +};
>>>>> +
>>>>>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>  {
>>>>>  	struct device *dev = &dev_dax->dev;
>>>>> @@ -62,6 +69,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>  		return -EINVAL;
>>>>>  	}
>>>>>  
>>>>> +	init_node_memory_type(numa_node, &default_pmem_type);
>>>>> +
>>>>
>>>> The memory hot-add below may fail.  So the error handling needs to be
>>>> added.
>>>>
>>>> And, it appears that the memory type and memory tier of a node may be
>>>> fully initialized here before NUMA hot-adding started.  So I suggest to
>>>> set node_memory_types[] here only.  And set memory_dev_type->nodes in
>>>> node hot-add callback.  I think there is the proper place to complete
>>>> the initialization.
>>>>
>>>> And, in theory dax/kmem.c can be unloaded.  So we need to clear
>>>> node_memory_types[] for nodes somewhere.
>>>>
>>>
>>> I guess by module exit we can be sure that all the memory managed
>>> by dax/kmem is hotplugged out. How about something like below?
>> 
>> Because we set node_memorty_types[] in dev_dax_kmem_probe(), it's
>> natural to clear it in dev_dax_kmem_remove().
>> 
>
> Most of required reset/clear is done as part of memory hotunplug. So
> if we did manage to successfully unplug the memory, everything except
> node_memory_types[node] should be reset. That makes the clear_node_memory_type
> the below. 
>
> void clear_node_memory_type(int node, struct memory_dev_type *memtype)
> {
>
> 	mutex_lock(&memory_tier_lock);
> 	/*
> 	 * memory unplug did clear the node from the memtype and
> 	 * dax/kem did initialize this node's memory type.
> 	 */
> 	if (!node_isset(node, memtype->nodes) && node_memory_types[node]  == memtype){
> 		node_memory_types[node] = NULL;
> 	}
> 	mutex_unlock(&memory_tier_lock);
> }
>
> With the module unload, it is kind of force removing the usage of the specific memtype.
> Considering module unload will remove the usage of specific memtype from other parts
> of the kernel and we already do all the required reset in memory hot unplug, do we
> need to do the clear_node_memory_type above? 

Per my understanding, we need to call clear_node_memory_type() in
dev_dax_kmem_remove().  After that, we have nothing to do in
dax_kmem_exit().

Best Regards,
Huang, Ying

