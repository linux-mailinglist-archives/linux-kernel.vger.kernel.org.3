Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA8E4ED655
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiCaJAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiCaJAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:00:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553DA53B50
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648717111; x=1680253111;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=yxzYJmtPcg0UU6qCqRqPT7JMOGmN7ucuIzoCz39lvNs=;
  b=IEPKiJr5LV/yNcfzowJjCfQAoMC6yfJUK8bKAUKH7eZT6VnnAMKWU6jD
   b8EsMmQfwfO2vD/NJNmqQf1eAsZB/P36TyWubnMCGnDKck3hiJAFA+1gh
   XV/OKXU1x5LJhxHB2ZUXVLDpf5JkZEqp1NSnKzZcBMnpqJyBwXk5p7WrT
   7S1sWqJJspldGkfzMx7bcoeAJ7dj+BGIKL9hUTr+lyAtfW4YJoCyzvl4f
   BlQOZ0KQdkJOOiLlTi67wbOv8s0McFpJsDV+1kVP/aoUF53jSa8ILZaeM
   Xe0uVAQDMyNJcQsQkm6BzjtCFQJKsNWFBXVIkl2NGl3DiiiNtAOoA0ycp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259950345"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="259950345"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:58:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="566297847"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:58:02 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        baolin.wang@linux.alibaba.com
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, Fan Du <fan.du@intel.com>
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
        <87pmm4c4ys.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87lewrxsv1.fsf@linux.ibm.com>
        <878rsrc672.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87ilruy5zt.fsf@linux.ibm.com>
        <87h77ebn6j.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87fsmyy1a0.fsf@linux.ibm.com>
Date:   Thu, 31 Mar 2022 16:58:00 +0800
In-Reply-To: <87fsmyy1a0.fsf@linux.ibm.com> (Aneesh Kumar K. V.'s message of
        "Thu, 31 Mar 2022 13:57:51 +0530")
Message-ID: <8735iybisn.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>
>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>
>>>>>> Hi, Jagdish,
>>>>>>
>>>>>> Jagdish Gediya <jvgediya@linux.ibm.com> writes:
>>>>>>
>>>>>
>>>>> ...
>>>>>
>>>>>>> e.g. with below NUMA topology, where node 0 & 1 are
>>>>>>> cpu + dram nodes, node 2 & 3 are equally slower memory
>>>>>>> only nodes, and node 4 is slowest memory only node,
>>>>>>>
>>>>>>> available: 5 nodes (0-4)
>>>>>>> node 0 cpus: 0 1
>>>>>>> node 0 size: n MB
>>>>>>> node 0 free: n MB
>>>>>>> node 1 cpus: 2 3
>>>>>>> node 1 size: n MB
>>>>>>> node 1 free: n MB
>>>>>>> node 2 cpus:
>>>>>>> node 2 size: n MB
>>>>>>> node 2 free: n MB
>>>>>>> node 3 cpus:
>>>>>>> node 3 size: n MB
>>>>>>> node 3 free: n MB
>>>>>>> node 4 cpus:
>>>>>>> node 4 size: n MB
>>>>>>> node 4 free: n MB
>>>>>>> node distances:
>>>>>>> node   0   1   2   3   4
>>>>>>>   0:  10  20  40  40  80
>>>>>>>   1:  20  10  40  40  80
>>>>>>>   2:  40  40  10  40  80
>>>>>>>   3:  40  40  40  10  80
>>>>>>>   4:  80  80  80  80  10
>>>>>>>
>>>>>>> The existing implementation gives below demotion targets,
>>>>>>>
>>>>>>> node    demotion_target
>>>>>>>  0              3, 2
>>>>>>>  1              4
>>>>>>>  2              X
>>>>>>>  3              X
>>>>>>>  4		X
>>>>>>>
>>>>>>> With this patch applied, below are the demotion targets,
>>>>>>>
>>>>>>> node    demotion_target
>>>>>>>  0              3, 2
>>>>>>>  1              3, 2
>>>>>>>  2              3
>>>>>>>  3              4
>>>>>>>  4		X
>>>>>>
>>>>>> For such machine, I think the perfect demotion order is,
>>>>>>
>>>>>> node    demotion_target
>>>>>>  0              2, 3
>>>>>>  1              2, 3
>>>>>>  2              4
>>>>>>  3              4
>>>>>>  4              X
>>>>>
>>>>> I guess the "equally slow nodes" is a confusing definition here. Now if the
>>>>> system consists of 2 1GB equally slow memory and the firmware doesn't want to
>>>>> differentiate between them, firmware can present a single NUMA node
>>>>> with 2GB capacity? The fact that we are finding two NUMA nodes is a hint
>>>>> that there is some difference between these two memory devices. This is
>>>>> also captured by the fact that the distance between 2 and 3 is 40 and not 10.
>>>>
>>>> Do you have more information about this?
>>>
>>> Not sure I follow the question there. I was checking shouldn't firmware
>>> do a single NUMA node if two memory devices are of the same type? How will
>>> optane present such a config? Both the DIMMs will have the same
>>> proximity domain value and hence dax kmem will add them to the same NUMA
>>> node?
>>
>> Sorry for confusing.  I just wanted to check whether you have more
>> information about the machine configuration above.  The machines in my
>> hand have no complex NUMA topology as in the patch description.
>
>
> Even with simple topologies like below
>
> available: 3 nodes (0-2)
> node 0 cpus: 0 1
> node 0 size: 4046 MB
> node 0 free: 3478 MB
> node 1 cpus: 2 3
> node 1 size: 4090 MB
> node 1 free: 3430 MB
> node 2 cpus:
> node 2 size: 4074 MB
> node 2 free: 4037 MB
> node distances:
> node   0   1   2 
>   0:  10  20  40 
>   1:  20  10  40 
>   2:  40  40  10 
>
> With current code we get demotion targets assigned as below
>
> [    0.337307] Demotion nodes for Node 0: 2
> [    0.337351] Demotion nodes for Node 1: 
> [    0.337380] Demotion nodes for Node 2: 
>
> I guess we should fix that to be below?
>
> [    0.344554] Demotion nodes for Node 0: 2
> [    0.344605] Demotion nodes for Node 1: 2
> [    0.344638] Demotion nodes for Node 2: 

If the cross-socket link has enough bandwidth to accommodate the PMEM
throughput, the new one is better.  If it hasn't, the old one may be
better.  So, I think we need some kind of user space overridden support
here.  Right?

> Most of the tests we are doing are using Qemu to simulate this. We
> started looking at this to avoid using demotion completely when slow
> memory is not present. ie, we should have a different way to identify
> demotion targets other than node_states[N_MEMORY]. Virtualized platforms
> can have configs with memory only NUMA nodes with DRAM and we don't
> want to consider those as demotion targets. 

Even if the demotion targets are set for some node, the demotion will
not work before enabling demotion via sysfs
(/sys/kernel/mm/numa/demotion_enabled).  So for system without slow
memory, just don't enable demotion.

> While we are at it can you let us know how topology will look on a
> system with two optane DIMMs? Do both appear with the same
> target_node? 

In my test system, multiple optane DIMMs in one socket will be
represented as one NUMA node.

I remember Baolin has different configuration.

Hi, Baolin,  Can you provide some information about this?

>>
>>> If you are suggesting that firmware doesn't do that, then I agree with you
>>> that a demotion target like the below is good. 
>>>
>>>  node    demotion_target
>>>   0              2, 3
>>>   1              2, 3
>>>   2              4
>>>   3              4
>>>   4              X
>>>
>>> We can also achieve that with a smiple change as below.
>>
>> Glad to see the demotion order can be implemented in a simple way.
>>
>> My concern is that is it necessary to do this?  If there are real
>> machines with the NUMA topology, then I think it's good to add the
>> support.  But if not, why do we make the code complex unnecessarily?
>>
>> I don't have these kind of machines, do you have and will have?
>>
>
>
> Based on the above, we still need to get the simpler fix merged right?

Or user overridden support?

Best Regards,
Huang, Ying

[snip]
