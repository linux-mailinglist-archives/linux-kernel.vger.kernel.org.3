Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EF6583901
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiG1Gvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiG1Gvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:51:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BB951A09
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658991103; x=1690527103;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Wj7zPRz9hbcwp/KopmE11CExQ4AFDuVqU4Mck3ExkwU=;
  b=hh2+iBF+6dL0R6RcgSB73kpxxulT9VgGZo2FNCljUIJIfRDGqEJ13+gn
   2EAlMTGgOMbrrjBNwXmOQHH0lB/s3xv9Re5M6jU5v3y307vCH0Pimr4qS
   T1a27ZnU0TKij81bcV7CcP/FaADlSBkB5caoA+15dBrXZspTdkwv359Ub
   S4krdYPv/yGmCZwDUrQrQcdrDB2JGH42ohC+7e2QvrRV14466m/FcV6Kf
   KumbKytGC3UpkAhk6T7i0EFmUnLSJQ1porQhi4dBtnafP02k/RA5YdNpu
   QOD1DKaNxEh7rfo9b4djGU6CCgAR+dEIQrNGJ2M8c3RYKUGGiWRZsBJq8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="271477914"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="271477914"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 23:51:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="576326899"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 23:51:38 -0700
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
        <87k07zrx3t.fsf@linux.ibm.com>
Date:   Thu, 28 Jul 2022 14:51:34 +0800
In-Reply-To: <87k07zrx3t.fsf@linux.ibm.com> (Aneesh Kumar K. V.'s message of
        "Wed, 27 Jul 2022 10:05:50 +0530")
Message-ID: <87y1wdn30p.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
>>>> 
>
> ....
>
>>>> + */
>>>>> +int next_demotion_node(int node)
>>>>> +{
>>>>> +	struct demotion_nodes *nd;
>>>>> +	int target;
>>>>> +
>>>>> +	if (!node_demotion)
>>>>> +		return NUMA_NO_NODE;
>>>>> +
>>>>> +	nd = &node_demotion[node];
>>>>> +
>>>>> +	/*
>>>>> +	 * node_demotion[] is updated without excluding this
>>>>> +	 * function from running.
>>>>> +	 *
>>>>> +	 * Make sure to use RCU over entire code blocks if
>>>>> +	 * node_demotion[] reads need to be consistent.
>>>>> +	 */
>>>>> +	rcu_read_lock();
>>>>> +	/*
>>>>> +	 * If there are multiple target nodes, just select one
>>>>> +	 * target node randomly.
>>>>> +	 *
>>>>> +	 * In addition, we can also use round-robin to select
>>>>> +	 * target node, but we should introduce another variable
>>>>> +	 * for node_demotion[] to record last selected target node,
>>>>> +	 * that may cause cache ping-pong due to the changing of
>>>>> +	 * last target node. Or introducing per-cpu data to avoid
>>>>> +	 * caching issue, which seems more complicated. So selecting
>>>>> +	 * target node randomly seems better until now.
>>>>> +	 */
>>>>> +	target = node_random(&nd->preferred);
>>>> 
>>>> In one of the most common cases, nodes_weight(&nd->preferred) == 1.
>>>> Where, get_random_int() in node_random() just wastes CPU cycles and
>>>> random entropy.  So the original struct demotion_nodes implementation
>>>> appears better.
>>>> 
>>>>   struct demotion_nodes {
>>>>          unsigned short nr;
>>>>          short nodes[DEMOTION_TARGET_NODES];
>>>>   };
>>>> 
>>>
>>>
>>> Is that measurable difference? using nodemask_t makes it much easier with respect to
>>> implementation. IMHO if we observe the usage of node_random() to have performance impact
>>> with nodes_weight() == 1 we should fix node_random() to handle that? If you strongly
>>> feel we should fix this, i can opencode node_random to special case node_weight() == 1?
>>
>> If there's no much difference, why not just use the existing code?
>> IMHO, it's your responsibility to prove your new implementation is
>> better via numbers, for example, reduced code lines, with better or same
>> performance.
>>
>> Another policy is just to use the existing code in the first version.
>> Then change it based on measurement.
>
> One of the reason I switched to nodemask_t is to make code simpler.
> demotion target is essentially a node mask. 
>
>>
>> In general, I care more about the most common cases, that is, 0 or 1
>> demotion target.
>
> How about I switch to the below opencoded version. That should take care
> of the above concern. 

Per my estimation, the performance for 0 or 1 demotion target should be
OK.

And I think that you can change node_random() implementation directly.
Because it will not hurt other users too.

Best Regards,
Huang, Ying

>>
>>> -	target = node_random(&nd->preferred);
>>> +	node_weight = nodes_weight(nd->preferred);
>>> +	switch (node_weight) {
>>> +	case 0:
>>> +		target = NUMA_NO_NODE;
>>> +		break;
>>> +	case 1:
>>> +		target = first_node(nd->preferred);
>>> +		break;
>>> +	default:
>>> +		target = bitmap_ord_to_pos(nd->preferred.bits,
>>> +					   get_random_int() % node_weight, MAX_NUMNODES);
>>> +		break;
>>> +	}
>>>  
>>>
