Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F83E577C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiGRG6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiGRG5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:57:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D059E165B4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658127470; x=1689663470;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=kP3TMLhOBN0SOfYIAaFFq2xdvS0WfG2ZEeJ6EaXyvT0=;
  b=c1+P4MufSBGQoO+sPBy9Q5Ezyj4JXJbFV1EAbBv8zmqRm7+v2PDgikL6
   VwBG3VuaazET0UybOfJG2r5ECxaSnEkXBN4Qr7NJHc2jLTwClRcemrNC3
   /jZV9vCFHQ++ZaZqOXZdAYFa/2vZ0mvWL9YhzN9v4SSWD23MPnu/97DC5
   A0zeCsqvxiJ2j2cqJbVYCh/bNKuwvKG5LI0u5xccNy0E21W0JDqK96Pgq
   okpJdnrk2Ab3/FgOY9lEB9AxlBJbk3AdQmewSu2yXSCOOILEJk3qHDSsW
   aK/wdBLeG7OmOGvM1T90BeSWhPCfHys/pdl+WUk3f6qMwVppJ58xsnJ2o
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="286169616"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="286169616"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 23:57:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="572284966"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 23:57:46 -0700
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
Date:   Mon, 18 Jul 2022 14:57:42 +0800
In-Reply-To: <3659f1bb-a82e-1aad-f297-808a2c17687d@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 15 Jul 2022 14:38:43 +0530")
Message-ID: <87tu7e3o2h.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 7/15/22 1:23 PM, Huang, Ying wrote:

[snip]

>> 
>> You dropped the original sysfs interface patches from the series, but
>> the kernel internal implementation is still for the original sysfs
>> interface.  For example, memory tier ID is for the original sysfs
>> interface, not for the new proposed sysfs interface.  So I suggest you
>> to implement with the new interface in mind.  What do you think about
>> the following design?
>> 
>
> Sorry I am not able to follow you here. This patchset completely drops
> exposing memory tiers to userspace via sysfs. Instead it allow
> creation of memory tiers with specific tierID from within the kernel/device driver.
> Default tierID is 200 and dax kmem creates memory tier with tierID 100. 
>
>
>> - Each NUMA node belongs to a memory type, and each memory type
>>   corresponds to a "abstract distance", so each NUMA node corresonds to
>>   a "distance".  For simplicity, we can start with static distances, for
>>   example, DRAM (default): 150, PMEM: 250.  The distance of each NUMA
>>   node can be recorded in a global array,
>> 
>>     int node_distances[MAX_NUMNODES];
>> 
>>   or, just
>> 
>>     pgdat->distance
>> 
>
> I don't follow this. I guess you are trying to have a different design.
> Would it be much easier if you can write this in the form of a patch? 

Written some pseudo code as follow to show my basic idea.

#define MEMORY_TIER_ADISTANCE_DRAM	150
#define MEMORY_TIER_ADISTANCE_PMEM	250

struct memory_tier {
	/* abstract distance range covered by the memory tier */
	int adistance_start;
	int adistance_len;
	struct list_head list;
	nodemask_t nodemask;
};

/* RCU list of memory tiers */
static LIST_HEAD(memory_tiers);

/* abstract distance of each NUMA node */
int node_adistances[MAX_NUMNODES];

struct memory_tier *find_create_memory_tier(int adistance)
{
	struct memory_tier *tier;

	list_for_each_entry(tier, &memory_tiers, list) {
		if (adistance >= tier->adistance_start &&
		    adistance < tier->adistance_start + tier->adistance_len)
			return tier;
	}
	/* allocate a new memory tier and return */
}

void memory_tier_add_node(int nid)
{
	int adistance;
	struct memory_tier *tier;

	adistance = node_adistances[nid] || MEMORY_TIER_ADISTANCE_DRAM;
	tier = find_create_memory_tier(adistance);
	node_set(nid, &tier->nodemask);
	/* setup demotion data structure, etc */
}

static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
						 unsigned long action, void *_arg)
{
	struct memory_notify *arg = _arg;
	int nid;

	nid = arg->status_change_nid;
	if (nid < 0)
		return notifier_from_errno(0);

	switch (action) {
	case MEM_ONLINE:
		memory_tier_add_node(nid);
		break;
	}

	return notifier_from_errno(0);
}

/* kmem.c */
static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
{
	node_adistances[dev_dax->target_node] = MEMORY_TIER_ADISTANCE_PMEM;
	/* add_memory_driver_managed() */
}

[snip]

Best Regards,
Huang, Ying
