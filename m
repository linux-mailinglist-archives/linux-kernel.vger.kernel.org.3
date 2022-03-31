Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0E54ED4BF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiCaHZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiCaHZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:25:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD206142
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648711417; x=1680247417;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=g1tUG2Q8DPCSkogHEocQF8gq9/NFNRZEipovqQEvc7c=;
  b=J6OcgCnOEqChPElYpAKNDGy20ESv7m6JeCQ0n+HljjULtGRYQb0RrHwj
   ECp+xnmGQ1tMUCmq7mM2IVa64N4Xy2hwywF/iUCSVfP/jcbK5rOYGGJ6k
   bdWi1hWhTFM3OUELetY59dcil2pWwKeTmnxJf2YNDLNC3RPwF0d9QpKh7
   HOf8jDru5kpQ4u/0Ugg6bwCL3S16y8U0K3iYDFQRUrnJjUagEdXjrFXDA
   HjE1tZL9pTtjT+2Znasi3JrhCQwB3r3VdkzevZIiw1a2H9GO3L9CUb0pe
   UeOCTklo5rI9e155Q1DQULAT10y7jBwZ93cDzg0Ixbe/GWcrphx/BoTuk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="322923129"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="322923129"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 00:23:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="566225927"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 00:23:18 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, Fan Du <fan.du@intel.com>
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
        <87pmm4c4ys.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87lewrxsv1.fsf@linux.ibm.com>
        <878rsrc672.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87ilruy5zt.fsf@linux.ibm.com>
Date:   Thu, 31 Mar 2022 15:23:16 +0800
In-Reply-To: <87ilruy5zt.fsf@linux.ibm.com> (Aneesh Kumar K. V.'s message of
        "Thu, 31 Mar 2022 12:15:58 +0530")
Message-ID: <87h77ebn6j.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>
>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>
>>>> Hi, Jagdish,
>>>>
>>>> Jagdish Gediya <jvgediya@linux.ibm.com> writes:
>>>>
>>>
>>> ...
>>>
>>>>> e.g. with below NUMA topology, where node 0 & 1 are
>>>>> cpu + dram nodes, node 2 & 3 are equally slower memory
>>>>> only nodes, and node 4 is slowest memory only node,
>>>>>
>>>>> available: 5 nodes (0-4)
>>>>> node 0 cpus: 0 1
>>>>> node 0 size: n MB
>>>>> node 0 free: n MB
>>>>> node 1 cpus: 2 3
>>>>> node 1 size: n MB
>>>>> node 1 free: n MB
>>>>> node 2 cpus:
>>>>> node 2 size: n MB
>>>>> node 2 free: n MB
>>>>> node 3 cpus:
>>>>> node 3 size: n MB
>>>>> node 3 free: n MB
>>>>> node 4 cpus:
>>>>> node 4 size: n MB
>>>>> node 4 free: n MB
>>>>> node distances:
>>>>> node   0   1   2   3   4
>>>>>   0:  10  20  40  40  80
>>>>>   1:  20  10  40  40  80
>>>>>   2:  40  40  10  40  80
>>>>>   3:  40  40  40  10  80
>>>>>   4:  80  80  80  80  10
>>>>>
>>>>> The existing implementation gives below demotion targets,
>>>>>
>>>>> node    demotion_target
>>>>>  0              3, 2
>>>>>  1              4
>>>>>  2              X
>>>>>  3              X
>>>>>  4		X
>>>>>
>>>>> With this patch applied, below are the demotion targets,
>>>>>
>>>>> node    demotion_target
>>>>>  0              3, 2
>>>>>  1              3, 2
>>>>>  2              3
>>>>>  3              4
>>>>>  4		X
>>>>
>>>> For such machine, I think the perfect demotion order is,
>>>>
>>>> node    demotion_target
>>>>  0              2, 3
>>>>  1              2, 3
>>>>  2              4
>>>>  3              4
>>>>  4              X
>>>
>>> I guess the "equally slow nodes" is a confusing definition here. Now if the
>>> system consists of 2 1GB equally slow memory and the firmware doesn't want to
>>> differentiate between them, firmware can present a single NUMA node
>>> with 2GB capacity? The fact that we are finding two NUMA nodes is a hint
>>> that there is some difference between these two memory devices. This is
>>> also captured by the fact that the distance between 2 and 3 is 40 and not 10.
>>
>> Do you have more information about this?
>
> Not sure I follow the question there. I was checking shouldn't firmware
> do a single NUMA node if two memory devices are of the same type? How will
> optane present such a config? Both the DIMMs will have the same
> proximity domain value and hence dax kmem will add them to the same NUMA
> node?

Sorry for confusing.  I just wanted to check whether you have more
information about the machine configuration above.  The machines in my
hand have no complex NUMA topology as in the patch description.

> If you are suggesting that firmware doesn't do that, then I agree with you
> that a demotion target like the below is good. 
>
>  node    demotion_target
>   0              2, 3
>   1              2, 3
>   2              4
>   3              4
>   4              X
>
> We can also achieve that with a smiple change as below.

Glad to see the demotion order can be implemented in a simple way.

My concern is that is it necessary to do this?  If there are real
machines with the NUMA topology, then I think it's good to add the
support.  But if not, why do we make the code complex unnecessarily?

I don't have these kind of machines, do you have and will have?

> @@ -3120,7 +3120,7 @@ static void __set_migration_target_nodes(void)
>  {
>  	nodemask_t next_pass	= NODE_MASK_NONE;
>  	nodemask_t this_pass	= NODE_MASK_NONE;
> -	nodemask_t used_targets = NODE_MASK_NONE;
> +	nodemask_t this_pass_used_targets = NODE_MASK_NONE;
>  	int node, best_distance;
>  
>  	/*
> @@ -3141,17 +3141,20 @@ static void __set_migration_target_nodes(void)
>  	/*
>  	 * To avoid cycles in the migration "graph", ensure
>  	 * that migration sources are not future targets by
> -	 * setting them in 'used_targets'.  Do this only
> +	 * setting them in 'this_pass_used_targets'.  Do this only
>  	 * once per pass so that multiple source nodes can
>  	 * share a target node.
>  	 *
> -	 * 'used_targets' will become unavailable in future
> +	 * 'this_pass_used_targets' will become unavailable in future
>  	 * passes.  This limits some opportunities for
>  	 * multiple source nodes to share a destination.
>  	 */
> -	nodes_or(used_targets, used_targets, this_pass);
> +	nodes_or(this_pass_used_targets, this_pass_used_targets, this_pass);
>  
>  	for_each_node_mask(node, this_pass) {
> +
> +		nodemask_t used_targets = this_pass_used_targets;
> +
>  		best_distance = -1;
>  
>  		/*

Best Regards,
Huang, Ying
