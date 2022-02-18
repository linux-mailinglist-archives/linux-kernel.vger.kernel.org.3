Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332064BAF8A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiBRCVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:21:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiBRCVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:21:48 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E9D85674
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 18:21:31 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4nBQe7_1645150887;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V4nBQe7_1645150887)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Feb 2022 10:21:28 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [RFC PATCH V1 0/5] mm/damon: Add NUMA access statistics function
 support
To:     SeongJae Park <sj@kernel.org>
Cc:     rongwei.wang@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rientjes@google.com, linux-damon@amazon.com
References: <20220217082939.2850-1-sj@kernel.org>
Message-ID: <503fa0b1-be20-a17e-72f0-14b38c0dc719@linux.alibaba.com>
Date:   Fri, 18 Feb 2022 10:21:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220217082939.2850-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SeongJae:

On 2/17/22 4:29 PM, SeongJae Park wrote:
> + David Rientjes, who has shown interest[1] in this topic.
>
> [1] https://lore.kernel.org/linux-mm/bcc8d9a0-81d-5f34-5e4-fcc28eb7ce@google.com/
>
> ---
>
> Hi Xin,
>
>
> Thank you always for great patches!
>
> On Wed, 16 Feb 2022 16:30:36 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> On today's cloud computing service scenario, NUMA (non uniform memory access)
>> architecture server has been applied on a large scale. Using Damon function,
>> it can easily and lightweight identify hot and cold memory, but it can not
>> display the situation of locale and remote NUMA memory access.
>>
>> The purpose of these serie patches is to identify the situation of NUMA access
>> in combination with DAMON, especially for remote NUMA access in hot memory.
>> We hope to detect this situation in the data center and use page migration or
>> multi backup page technology to optimize the behavior of memory access.
>>
>> So next, we will further improve Damon NUMA function:
>> 1. Support hugtlbfs NUMA access statistics.
>> 2. Add the DAMO tool to parse NUMA local & remote in "damon_region" support.
>> 3. For hot memory remote NUMA access, support page migration or multi backup page.
>>
>> About DAMON correctness of numa access statistics
>> We wrote a test case, allocate about 1G memory, and use numa_alloc(), set 512M in
>> NUMA node0 and 512M in NUMA node1, and The test case alternately accesses the 1G of memory.
>>
>> We used "perf record -e damon:damon_aggregated" and "perf script"
>> cmd to obtain data, like this:
>> kdamond.0  target_id=0 nr_regions=10 281473056325632-281473127964672:: 12 0 5243 5513
>> kdamond.0  target_id=0 nr_regions=10 281473127964672-281473238028288: 8 1 5427  5399
>> ...
>> kdamond.0   target_id=0 nr_regions=10 281473056325632-281473127964672: 9 3 7669 7632
>> kdamond.0   target_id=0  nr_regions=10 281473127964672-281473238028288: 7 2 7913 7892
>>
>> And compared with numastat like this:
>> Per-node process memory usage (in MBs) for PID 111676 (lt-numademo)
>>                             Node 0          Node 1          Node 2
>>                    --------------- --------------- ---------------
>> Huge                         0.00            0.00            0.00
>> Heap                         0.02            0.00            0.00
>> Stack                        0.01            0.00            0.00
>> Private                    565.24          564.00            0.00
>> ----------------  --------------- --------------- ---------------
>> Total                      565.27          564.00            0.00
>> This comparison can determine the accuracy of Damon NUMA memory access statistics.
>>
>> About the impact of DAMON NUMA access on Performance
>> During the  benchmakr test, we found that the MBW benchmark memcpy test item
>> will cause about 3% performance degradation, and there is no performance degradation
>> in other benchmarks.
>> So we added "numa_stat" switch in DAMON dbgfs interface, turn on this switch when NUMA access
>> statistics is required.
>>
>>
>> Xin Hao (5):
>>    mm/damon: Add NUMA local and remote variables in 'damon_region'
>>    mm/damon: Add 'damon_region' NUMA fault simulation support
>>    mm/damon: Add 'damon_region' NUMA access statistics core
>>      implementation
>>    mm/damon/dbgfs: Add numa simulate switch
>>    mm/damon/tracepoint: Add 'damon_region' NUMA access statistics support
>>
>>   include/linux/damon.h        | 25 ++++++++++
>>   include/trace/events/damon.h |  9 +++-
>>   mm/damon/core.c              | 94 +++++++++++++++++++++++++++++++++++-
>>   mm/damon/dbgfs.c             | 70 ++++++++++++++++++++++++---
>>   mm/damon/paddr.c             | 25 ++++++++--
>>   mm/damon/prmtv-common.c      | 44 +++++++++++++++++
>>   mm/damon/prmtv-common.h      |  3 ++
>>   mm/damon/vaddr.c             | 45 ++++++++++-------
>>   mm/huge_memory.c             |  5 ++
>>   mm/memory.c                  |  5 ++
>>   10 files changed, 292 insertions(+), 33 deletions(-)
> I'd like to comment on the high level design at the moment.  To my
> understanding, this patchset extends DAMON core and monitoring operations for
> virtual address spaces (vaddr) and the physical address space (paddr) to
> monitor NUMA-local/remote accesses via PROT_NONE and page faults mechanism.
>
> The underlying mechanism for NUMA-local/remote accesses (PROT_NONE and page
> fault) looks ok to me.  But, changes to the core and vaddr/paddr operations
> looks unnecessary, to me.  That's also not for general use cases.
You are right, adding NUMA access statistics does make the PA & VA codes 
look confusing。
>
> I think it would be simpler to implment more monitoring operations for NUMA
> monitoring use case (one for NUMA-local accesses accounting and another one for
> NUMA-remote accesses accounting), alongside vaddr and paddr.  Then, users could
> configure DAMON to have three monitoring contexts (one with vaddr ops, second
> one with numa-local ops, and third one with numa-remote ops), run those
> concurrently, then show the three results and make some decisions like
> migrations.

Thanks for your advice, I will implement these in the next version, But 
from my understanding or maybe

I didn't get what you were thinking, I think only one monitor context is 
needed for NUMA Local & Remote,

Do not need a separate implementation like "numa_local_ops" and 
"numa_remote_ops", just set "numa_access_ops" is ok.

>
> One additional advantage of this approach is that the accuracy for
> NUMA-local/remote accessed could be better, because the contexts configured to
> use NUMA-local/remote monitoring ops will do the regions adjustment with
> NUMA-local/remote accesses (to my understanding, this patchset let regions have
> NUMA-local/remote accesses counter in addition to the total one, but still use
> only the total one for the regions adjustment).
>
> If I'm missing something, please let me know.
>
>
> Thanks,
> SJ
>
>> --
>> 2.27.0

-- 
Best Regards!
Xin Hao

