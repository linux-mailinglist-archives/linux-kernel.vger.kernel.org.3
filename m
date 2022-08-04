Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADB55896DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbiHDET4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238379AbiHDETy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:19:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70A24D81A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 21:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659586791; x=1691122791;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=KHVAisvlsLMn2oCveG7/DD5TwcCi7B3kpKuDrB4r4NI=;
  b=a4Jvs5/rhzskescbN9JgxXT6MGf23cyuKd1h2xF0kJoX5WeJDcj7erdN
   6YwdAUOjjo9zCyfsKmzBtSMxHiudCBT0IGSe0jC3+ko97dSuP5nb+f7HC
   BY64N2C/fR+WK+ZDityOKDoIjVT5UUR2INj19PpT+9FmhKNFChH4m1U+E
   hy/L+UFkd4NpR2iRaX4XS7azcc5dUXbbnidKJH3reTJTN1EhBSvRsI8Gm
   kJIAtPgs6AF1T6+16DcMSqo7Z3MUk+JTpZdGD4rZUr+Px9SIdgr1D+ans
   YHY62QE94bA+q43fKEsyob8OnNLOpoRTPXYizhNxfZ0+t8FMfg16v3/So
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="291052911"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="291052911"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 21:19:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="578911559"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 21:19:47 -0700
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
Subject: Re: [PATCH v10 5/8] mm/demotion: Build demotion targets based on
 explicit memory tiers
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
        <20220720025920.1373558-6-aneesh.kumar@linux.ibm.com>
        <871qu8wc6c.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <9f14814c-cb08-8032-caff-edcd0594ad41@linux.ibm.com>
        <87h733uyc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <878ro6rp50.fsf@linux.ibm.com>
Date:   Thu, 04 Aug 2022 12:19:32 +0800
In-Reply-To: <878ro6rp50.fsf@linux.ibm.com> (Aneesh Kumar K. V.'s message of
        "Wed, 03 Aug 2022 08:48:19 +0530")
Message-ID: <87mtckiqsr.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

 > "Huang, Ying" <ying.huang@intel.com> writes:
>
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>
>>> On 7/26/22 1:14 PM, Huang, Ying wrote:
>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
> ....
>
>>>> +
>>>>>  static void init_node_memory_tier(int node)
>>>>>  {
>>>>>  	int perf_level;
>>>>> @@ -84,11 +285,19 @@ static void init_node_memory_tier(int node)
>>>>>  	mutex_lock(&memory_tier_lock);
>>>>>  
>>>>>  	memtier = __node_get_memory_tier(node);
>>>>> +	/*
>>>>> +	 * if node is already part of the tier proceed with the
>>>>> +	 * current tier value, because we might want to establish
>>>>> +	 * new migration paths now. The node might be added to a tier
>>>>> +	 * before it was made part of N_MEMORY, hence estabilish_migration_targets
>>>>> +	 * will have skipped this node.
>>>>> +	 */
>>>>>  	if (!memtier) {
>>>>>  		perf_level = node_devices[node]->perf_level;
>>>>>  		memtier = find_create_memory_tier(perf_level);
>>>>>  		node_set(node, memtier->nodelist);
>>>>>  	}
>>>>> +	establish_migration_targets();
>>>> 
>>>> Why combines memory tiers establishing with demotion targets building?
>>>> I think that it's better to separate them.   For example, if we move a
>>>> set of NUMA node from one memory tier to another memory tier, we only
>>>> need to run establish_migration_targets() once after moving all nodes.
>>>> 
>>>
>>> Yes agree. I am not sure I followed your comment here. 
>>>
>>> Demotion target rebuilding is a separate helper. Any update to memory tiers needs rebuilding
>>> of demotion targets. Also any change in node mask of memory tier needs
>>> demotion target rebuild. Can you clarify the code change you are suggesting here?
>>
>> I think we should call establish_migration_targets() in
>> migrate_on_reclaim_callback() directly.  As the example I mentioned
>> above, sometimes, we don't need to call establish_migration_targets()
>> for each node changing.
>>
>
> We need to hold memory_tier_lock while updating node's memory tier and
> rebuilding demotion targets. All of that is done in the same function
> here. An update node memory tier that allow for updating multiple node's
> memory tier together would do what you mentioned above under
> memory_tier_lock ie, update all the nodes memory tier and then call
> establish_migration_targets() once.

I don't think it's good to duplicate code unnecessarily.  Managing
memory tiers and estabilishing demotion target are two separate stuff.
We shouldn't combined them.  If memory_tier_lock needs to be held, just
enclosing estabilish_migration_targets() with it.

Best Regards,
Huang, Ying

