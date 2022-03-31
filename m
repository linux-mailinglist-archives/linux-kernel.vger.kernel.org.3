Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787514ED702
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiCaJeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiCaJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:34:15 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE68D1BD994
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:32:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V8iK6V7_1648719143;
Received: from 30.32.67.149(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V8iK6V7_1648719143)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Mar 2022 17:32:24 +0800
Message-ID: <ef5ab5e9-e503-771f-a141-dffcef886256@linux.alibaba.com>
Date:   Thu, 31 Mar 2022 17:33:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
To:     "Huang, Ying" <ying.huang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, Fan Du <fan.du@intel.com>
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
 <87pmm4c4ys.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87lewrxsv1.fsf@linux.ibm.com>
 <878rsrc672.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87ilruy5zt.fsf@linux.ibm.com>
 <87h77ebn6j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87fsmyy1a0.fsf@linux.ibm.com>
 <8735iybisn.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <8735iybisn.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2022 4:58 PM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> "Huang, Ying" <ying.huang@intel.com> writes:
>>
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>
>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>
>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>
>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>
>>>>>>> Hi, Jagdish,
>>>>>>>
>>>>>>> Jagdish Gediya <jvgediya@linux.ibm.com> writes:
>>>>>>>
>>>>>>
>>>>>> ...
>>>>>>
>>>>>>>> e.g. with below NUMA topology, where node 0 & 1 are
>>>>>>>> cpu + dram nodes, node 2 & 3 are equally slower memory
>>>>>>>> only nodes, and node 4 is slowest memory only node,
>>>>>>>>
>>>>>>>> available: 5 nodes (0-4)
>>>>>>>> node 0 cpus: 0 1
>>>>>>>> node 0 size: n MB
>>>>>>>> node 0 free: n MB
>>>>>>>> node 1 cpus: 2 3
>>>>>>>> node 1 size: n MB
>>>>>>>> node 1 free: n MB
>>>>>>>> node 2 cpus:
>>>>>>>> node 2 size: n MB
>>>>>>>> node 2 free: n MB
>>>>>>>> node 3 cpus:
>>>>>>>> node 3 size: n MB
>>>>>>>> node 3 free: n MB
>>>>>>>> node 4 cpus:
>>>>>>>> node 4 size: n MB
>>>>>>>> node 4 free: n MB
>>>>>>>> node distances:
>>>>>>>> node   0   1   2   3   4
>>>>>>>>    0:  10  20  40  40  80
>>>>>>>>    1:  20  10  40  40  80
>>>>>>>>    2:  40  40  10  40  80
>>>>>>>>    3:  40  40  40  10  80
>>>>>>>>    4:  80  80  80  80  10
>>>>>>>>
>>>>>>>> The existing implementation gives below demotion targets,
>>>>>>>>
>>>>>>>> node    demotion_target
>>>>>>>>   0              3, 2
>>>>>>>>   1              4
>>>>>>>>   2              X
>>>>>>>>   3              X
>>>>>>>>   4		X
>>>>>>>>
>>>>>>>> With this patch applied, below are the demotion targets,
>>>>>>>>
>>>>>>>> node    demotion_target
>>>>>>>>   0              3, 2
>>>>>>>>   1              3, 2
>>>>>>>>   2              3
>>>>>>>>   3              4
>>>>>>>>   4		X
>>>>>>>
>>>>>>> For such machine, I think the perfect demotion order is,
>>>>>>>
>>>>>>> node    demotion_target
>>>>>>>   0              2, 3
>>>>>>>   1              2, 3
>>>>>>>   2              4
>>>>>>>   3              4
>>>>>>>   4              X
>>>>>>
>>>>>> I guess the "equally slow nodes" is a confusing definition here. Now if the
>>>>>> system consists of 2 1GB equally slow memory and the firmware doesn't want to
>>>>>> differentiate between them, firmware can present a single NUMA node
>>>>>> with 2GB capacity? The fact that we are finding two NUMA nodes is a hint
>>>>>> that there is some difference between these two memory devices. This is
>>>>>> also captured by the fact that the distance between 2 and 3 is 40 and not 10.
>>>>>
>>>>> Do you have more information about this?
>>>>
>>>> Not sure I follow the question there. I was checking shouldn't firmware
>>>> do a single NUMA node if two memory devices are of the same type? How will
>>>> optane present such a config? Both the DIMMs will have the same
>>>> proximity domain value and hence dax kmem will add them to the same NUMA
>>>> node?
>>>
>>> Sorry for confusing.  I just wanted to check whether you have more
>>> information about the machine configuration above.  The machines in my
>>> hand have no complex NUMA topology as in the patch description.
>>
>>
>> Even with simple topologies like below
>>
>> available: 3 nodes (0-2)
>> node 0 cpus: 0 1
>> node 0 size: 4046 MB
>> node 0 free: 3478 MB
>> node 1 cpus: 2 3
>> node 1 size: 4090 MB
>> node 1 free: 3430 MB
>> node 2 cpus:
>> node 2 size: 4074 MB
>> node 2 free: 4037 MB
>> node distances:
>> node   0   1   2
>>    0:  10  20  40
>>    1:  20  10  40
>>    2:  40  40  10
>>
>> With current code we get demotion targets assigned as below
>>
>> [    0.337307] Demotion nodes for Node 0: 2
>> [    0.337351] Demotion nodes for Node 1:
>> [    0.337380] Demotion nodes for Node 2:
>>
>> I guess we should fix that to be below?
>>
>> [    0.344554] Demotion nodes for Node 0: 2
>> [    0.344605] Demotion nodes for Node 1: 2
>> [    0.344638] Demotion nodes for Node 2:
> 
> If the cross-socket link has enough bandwidth to accommodate the PMEM
> throughput, the new one is better.  If it hasn't, the old one may be
> better.  So, I think we need some kind of user space overridden support
> here.  Right?
> 
>> Most of the tests we are doing are using Qemu to simulate this. We
>> started looking at this to avoid using demotion completely when slow
>> memory is not present. ie, we should have a different way to identify
>> demotion targets other than node_states[N_MEMORY]. Virtualized platforms
>> can have configs with memory only NUMA nodes with DRAM and we don't
>> want to consider those as demotion targets.
> 
> Even if the demotion targets are set for some node, the demotion will
> not work before enabling demotion via sysfs
> (/sys/kernel/mm/numa/demotion_enabled).  So for system without slow
> memory, just don't enable demotion.
> 
>> While we are at it can you let us know how topology will look on a
>> system with two optane DIMMs? Do both appear with the same
>> target_node?
> 
> In my test system, multiple optane DIMMs in one socket will be
> represented as one NUMA node.
> 
> I remember Baolin has different configuration.
> 
> Hi, Baolin,  Can you provide some information about this?

Sure. We have real machines with 2 optane DIMMs, and they are 
represented as 2 numa nodes. So we want to support the target demotion 
nodes can be multiple.

available: 3 nodes (0-2)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
node 0 size: 62153 MB
node 0 free: 447 MB
node 1 cpus:
node 1 size: 126969 MB
node 1 free: 84099 MB
node 2 cpus:
node 2 size: 127006 MB
node 2 free: 126925 MB
node distances:
node   0   1   2
   0:  10  20  20
   1:  20  10  20
   2:  20  20  10

