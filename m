Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70C14EBAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiC3Gip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243333AbiC3Gig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:38:36 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE5657141
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:36:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V8cbA2h_1648622206;
Received: from 30.30.125.253(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V8cbA2h_1648622206)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Mar 2022 14:36:47 +0800
Message-ID: <784aee91-6a01-6e67-389e-1e1883796894@linux.alibaba.com>
Date:   Wed, 30 Mar 2022 14:37:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        dave.hansen@linux.intel.com, ying.huang@intel.com
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
 <b7d1ab3b-e92c-d3aa-72cb-b80cc1a61e85@linux.alibaba.com>
 <YkMR8OY779Bcri3I@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YkMR8OY779Bcri3I@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
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



On 3/29/2022 10:04 PM, Jagdish Gediya wrote:
> On Tue, Mar 29, 2022 at 08:26:05PM +0800, Baolin Wang wrote:
> Hi Baolin,
>> Hi Jagdish,
>>
>> On 3/29/2022 7:52 PM, Jagdish Gediya wrote:
>>> The current implementation to identify the demotion
>>> targets limits some of the opportunities to share
>>> the demotion targets between multiple source nodes.
>>>
>>> Implement a logic to identify the loop in the demotion
>>> targets such that all the possibilities of demotion can
>>> be utilized. Don't share the used targets between all
>>> the nodes, instead create the used targets from scratch
>>> for each individual node based on for what all node this
>>> node is a demotion target. This helps to share the demotion
>>> targets without missing any possible way of demotion.
>>>
>>> e.g. with below NUMA topology, where node 0 & 1 are
>>> cpu + dram nodes, node 2 & 3 are equally slower memory
>>> only nodes, and node 4 is slowest memory only node,
>>>
>>> available: 5 nodes (0-4)
>>> node 0 cpus: 0 1
>>> node 0 size: n MB
>>> node 0 free: n MB
>>> node 1 cpus: 2 3
>>> node 1 size: n MB
>>> node 1 free: n MB
>>> node 2 cpus:
>>> node 2 size: n MB
>>> node 2 free: n MB
>>> node 3 cpus:
>>> node 3 size: n MB
>>> node 3 free: n MB
>>> node 4 cpus:
>>> node 4 size: n MB
>>> node 4 free: n MB
>>> node distances:
>>> node   0   1   2   3   4
>>>     0:  10  20  40  40  80
>>>     1:  20  10  40  40  80
>>>     2:  40  40  10  40  80
>>>     3:  40  40  40  10  80
>>>     4:  80  80  80  80  10
>>>
>>> The existing implementation gives below demotion targets,
>>>
>>> node    demotion_target
>>>    0              3, 2
>>>    1              4
>>>    2              X
>>>    3              X
>>>    4		X
>>>
>>> With this patch applied, below are the demotion targets,
>>>
>>> node    demotion_target
>>>    0              3, 2
>>>    1              3, 2
>>>    2              3
>>>    3              4
>>>    4		X
>>
>> Node 2 and node 3 both are slow memory and have same distance, why node 2
>> should demote cold memory to node 3? They should have the same target
>> demotion node 4, which is the slowest memory node, right?
>>
> Current demotion target finding algorithm works based on best distance, as distance between node 2 & 3 is 40 and distance between node 2 & 4 is 80, node 2 demotes to node 3.

If node 2 can demote to node 3, which means node 3's memory is colder 
than node 2, right? The accessing time of node 3 should be larger than 
node 2, then we can demote colder memory to node 3 from node 2.

But node 2 and node 3 are same memory type and have same distance, the 
accessing time of node 2 and node 3 should be same too, so why add so 
many page migration between node 2 and node 3? I'm still not sure the 
benefits.

Huang Ying and Dave, how do you think about this demotion targets?

>>>
>>> e.g. with below NUMA topology, where node 0, 1 & 2 are
>>> cpu + dram nodes and node 3 is slow memory node,
>>>
>>> available: 4 nodes (0-3)
>>> node 0 cpus: 0 1
>>> node 0 size: n MB
>>> node 0 free: n MB
>>> node 1 cpus: 2 3
>>> node 1 size: n MB
>>> node 1 free: n MB
>>> node 2 cpus: 4 5
>>> node 2 size: n MB
>>> node 2 free: n MB
>>> node 3 cpus:
>>> node 3 size: n MB
>>> node 3 free: n MB
>>> node distances:
>>> node   0   1   2   3
>>>     0:  10  20  20  40
>>>     1:  20  10  20  40
>>>     2:  20  20  10  40
>>>     3:  40  40  40  10
>>>
>>> The existing implementation gives below demotion targets,
>>>
>>> node    demotion_target
>>>    0              3
>>>    1              X
>>>    2              X
>>>    3              X
>>>
>>> With this patch applied, below are the demotion targets,
>>>
>>> node    demotion_target
>>>    0              3
>>>    1              3
>>>    2              3
>>>    3              X
>>
>> Sounds reasonable.
>>
>>>
>>> with below NUMA topology, where node 0 & 2 are cpu + dram
>>> nodes and node 1 & 3 are slow memory nodes,
>>>
>>> available: 4 nodes (0-3)
>>> node 0 cpus: 0 1
>>> node 0 size: n MB
>>> node 0 free: n MB
>>> node 1 cpus:
>>> node 1 size: n MB
>>> node 1 free: n MB
>>> node 2 cpus: 2 3
>>> node 2 size: n MB
>>> node 2 free: n MB
>>> node 3 cpus:
>>> node 3 size: n MB
>>> node 3 free: n MB
>>> node distances:
>>> node   0   1   2   3
>>>     0:  10  40  20  80
>>>     1:  40  10  80  80
>>>     2:  20  80  10  40
>>>     3:  80  80  40  10
>>>
>>> The existing implementation gives below demotion targets,
>>>
>>> node    demotion_target
>>>    0              3
>>>    1              X
>>>    2              3
>>>    3              X
>>
>> If I understand correctly, this is not true. The demotion route should be as
>> below with existing implementation:
>> node 0 ---> node 1
>> node 1 ---> X
>> node 2 ---> node 3
>> node 3 ---> X
>>
> Its typo, It should be 0 -> 1, Will correct it in v2.
>>>
>>> With this patch applied, below are the demotion targets,
>>>
>>> node    demotion_target
>>>    0              1
>>>    1              3
>>>    2              3
>>>    3              X
>>>
>>> As it can be seen above, node 3 can be demotion target for node
>>> 1 but existing implementation doesn't configure it that way. It
>>> is better to move pages from node 1 to node 3 instead of moving
>>> it from node 1 to swap.
>>
>> Which means node 3 is the slowest memory node?
>>
> Node 1 and 3 are equally slower but 1 is near to 0 and 3 is near to 2. Basically you can think of it like node 1 is slow memory logical node near to node 0 and node 3 is slow memory logical node near to node 2.

OK.
