Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8455B5838F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiG1Gmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiG1Gmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:42:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0105073E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658990571; x=1690526571;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=oxenFSWl0b21ZqPIX8MvBCx5pTHlfIRH+XxI/P8UVmw=;
  b=RKl+gIzkI0AzssJH+SWobBQx6G7hc/LEgSXA1nxLedL6iBWt8In1YLRh
   GyLksZ5kGJ8O+JM2CbVfO7N3a/xxi39mFQ0golFignPBafaAPP/+Y0wZv
   f6aRuXBwslDfGgtN4h5TdeDt/qBH39Ue9tMYIZWcPggsBiWnUA89hm+BS
   4H971X54lKbbgvqjXIZdQN5a+4HiyHNDMPE7YuRpYpyzk7tgZaKOrk76B
   UgJDckPt/Fep/VRwwgypZrUmtUQpp6qq/nbIBkc2zslgG7nFZu8JyYi03
   g3jxslhd1wQiMnEO3n0/ujd3WsbkJsA7JYpChPRsMynhzynKcRycATixx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="314222608"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="314222608"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 23:42:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="633534477"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 23:42:44 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>,
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
        <87czdruxs0.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87h733rwzr.fsf@linux.ibm.com>
Date:   Thu, 28 Jul 2022 14:42:40 +0800
In-Reply-To: <87h733rwzr.fsf@linux.ibm.com> (Aneesh Kumar K. V.'s message of
        "Wed, 27 Jul 2022 10:08:16 +0530")
Message-ID: <8735elohzz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>
>>> On 7/26/22 9:33 AM, Huang, Ying wrote:
>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

[snip]

>>>>>  
>>>>> +static struct memory_tier *__node_get_memory_tier(int node)
>>>>> +{
>>>>> +	struct memory_tier *memtier;
>>>>> +
>>>>> +	list_for_each_entry(memtier, &memory_tiers, list) {
>>>>> +		if (node_isset(node, memtier->nodelist))
>>>>> +			return memtier;
>>>>> +	}
>>>>> +	return NULL;
>>>>> +}
>>>>> +
>>>>> +static void init_node_memory_tier(int node)
>>>> 
>>>> set_node_memory_tier()?
>>>
>>> That was done based on feedback from Alistair 
>>>
>>> https://lore.kernel.org/linux-mm/87h73iapg1.fsf@nvdebian.thelocal
>>>
>>>> 
>>>>> +{
>>>>> +	int perf_level;
>>>>> +	struct memory_tier *memtier;
>>>>> +
>>>>> +	mutex_lock(&memory_tier_lock);
>>>>> +
>>>>> +	memtier = __node_get_memory_tier(node);
>>>>> +	if (!memtier) {
>>>>> +		perf_level = node_devices[node]->perf_level;
>>>>> +		memtier = find_create_memory_tier(perf_level);
>>>>> +		node_set(node, memtier->nodelist);
>>>>> +	}
>>
>> It's related to Alistair's comments too.  When will memtier != NULL
>> here?  We may need just VM_WARN_ON() here?
>
> When the platform driver sets memory tier directly. With the old code
> it can happen when dax/kmem register a node to a memory tier. With
> memory_type proposal this can happen if the node is part of memory
> type that is already added to a memory tier. 

Let's look at what it looks like with memory_type in place.

Best Regards,
Huang, Ying

>>
>>>>> +	mutex_unlock(&memory_tier_lock);
>>>>> +}
>>>>> +

[snip]
