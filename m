Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3833248D2B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiAMHSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:18:08 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:40483 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229670AbiAMHSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:18:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0V1ixl6i_1642058281;
Received: from 30.21.164.206(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0V1ixl6i_1642058281)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jan 2022 15:18:02 +0800
Message-ID: <11d4c86a-40ef-6ce5-6d08-e9d0bc9b512a@linux.alibaba.com>
Date:   Thu, 13 Jan 2022 15:18:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH] sched: introduce group balancer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        Vipin Sharma <vipinsh@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Cruz Zhao <cruzzhao@linux.alibaba.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
References: <98f41efd-74b2-198a-839c-51b785b748a6@linux.alibaba.com>
 <Yd6Xlw1qvEbWFSwU@hirez.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <Yd6Xlw1qvEbWFSwU@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/1/12 下午4:55, Peter Zijlstra 写道:
[snip]
>> The CPU_X is totally wasted in exclusive mode, the resource
>> efficiency are really poor.
>>
>> Thus what we need, is a way to ease confliction in share mode,
>> make groups as exclusive as possible, to gain both performance
>> and resource efficiency.
>>
>> The main idea of group balancer is to fulfill this requirement
>> by balancing groups of tasks among groups of CPUs, consider this
>> as a dynamic demi-exclusive mode.
> 
> Also look at the oracle soft affinity patches

Thanks for point out :-) we've checked the RFC in:
   https://lkml.org/lkml/2019/6/26/1044

which is the latest version we found by google search.

Very interesting fact is, we used to have the similar approach called
'soft bind', which was introduced as cpuset-cgroup's interface, to help
control the affinity just in that way.

However, we finally realize this is not very practical... end user have
no idea on how to config the stuff to achieve better performance, since
improve affinity not always helpful, sometime it harms.

We have dig a bit into the harmful cases, the reason is that this kind
of benchmark don't gain benefit from hot cache, but prefer low latency,
while the soft affinity limits the searching range of idle CPUs, which 
increasing the possibility that multiple task picking the same idle CPU
concurrently on wakeup process.

Besides, we found it's actually not necessary to limit the search range
to achieve affinity, when there are enough idle CPUs, wakeup process 
prefer prev or current cpu as long as they are idle, so find a proper 
CPU to migrate will leave the task there for long time.

And when there are not enough idle CPUs, swap two task prefer each
other's CPU would achieve the similar long effect, since wakeup process
can rarely find idle CPU now, task is likely to stay on prev cpu in this
secenry.

In conclusion, wakeup selecting process better keep it's purpose to
locate idlest CPU (only wake affine need to know which start point
could be better), and GB just catch the good chance to improve the
affinity as much as possible.

> 
>> Just like balance the task among CPUs, now with GB a user can
>> put CPU X,Y,Z into three partitions, and balance group A,B,C
>> into these partition, to make them as exclusive as possible.
>>
>> The design is very likely to the numa balancing, task trigger
>> work to settle it's group into a proper partition (minimum
>> predicted load), then try migrate itself into it. To gradually
>> settle groups into the most exclusively partition.
> 
> No words on the interaction between this and numa balancing. Numa
> balancing is already a bit tricky because it and the regular load
> balancer will have conflicting goals, some of that is mitigated by
> teaching the regular balancing about some of that.
> 
> I can't help but feel you're making the whole thing look like a 3 body
> problem. Also, regular balancing in the face of affinities is already
> somewhat dicy. All that needs exploring.

My bad to missing this part, here is the thinking behind.

The load balance focus on the balancing of load hierachically, NUMA
balancing focus on the NUMA efficiency, both of them are based on real
fact which are correct on their point of view. However, conflict still 
happen when NUMA efficiency and load balancing are opposite in one
migrate decision.

IMHO, load balance is the basic policy and numa balancing is the
optimize policy based on the basic one, so the weight of decision on
basic policy should always higher than the optimize policy, and optimize
policy should do migration based on the fact that basic policy are not 
broken (too much).

Now to answer the question, group balancer is just another kind of
optimize policy, but asked by end user, so it should obey the basic
policy (load balance), but peer to the another optimize policy (numa 
balancing) on migration decisions.

The current design is that when NUMA Balancing want to migrate task to
node, search only the CPUs GB assigned belong to that node and migrate
to it.

If GB was enabled before task forked, since it's run on these CPUs much
more and allocate memory there, NUMA Balancing have nothing to help,
every thing already localized.

If GB was enabled after task forked, since it's run on these CPUs much
more, NUMA Balancing will migrate memory to there (if possible) and
every thing again localized.

In real production, the first case are much more general, usually the
workload will start after every thing configured.

> 
>>
>> How To Use:
>>
>> To create partition, for example run:
>>    echo disable > /proc/gb_ctrl
>>    echo "0-15;16-31;32-47;48-63;" > /proc/gb_ctrl
>>    echo enable > /proc/gb_ctrl
> 
> That's just never going to happen; please look at the cpuset partition
> stuff.

Could you please give more details in here?

We actually looking forward a way to config several cpuset partition
together, like here 4 cpuset partitions 0-15, 16-31, 32-47 and 48-63,
but can't find any existing approach...

> 
>>
>> this will create 4 partitions contain CPUs 0-15,16-31,32-47 and
>> 48-63 separately.
>>
>> Then enable GB for your cgroup, run
>>    $CPU_CGROUP_PATH/cpu.gb_period_ms
>>
>> And you can check:
>>    $CPU_CGROUP_PATH/cpu.gb_stat
>>
>> which give output as:
>>    PART-0 0-15 1008 1086  *
>>    PART-1 16-31 0 2
>>    PART-2 32-47 0 0
>>    PART-3 48-63 0 1024
>>
>> The partition ID followed by it's CPUs range, load of group, load
>> of partition and a star mark as preferred.
>>
>> Testing Results:
>>    In order to enlarge the differences, we do testing on ARM platform
>>    with 128 CPUs, create 8 partition according to cluster info.
>>
>>    Since we pick benchmark which can gain benefit from exclusive mode,
>>    this is more like a functional testing rather than performance, to
>>    show that GB help winback the performance.
>>
>>    Create 8 cgroup each running 'sysbench memory --threads=16 run',
>>    the output of share mode is:
>>      events/s (eps):                      4181233.4646
>>      events/s (eps):                      3548328.2346
>>      events/s (eps):                      4578816.2412
>>      events/s (eps):                      4761797.3932
>>      events/s (eps):                      3486703.0455
>>      events/s (eps):                      3474920.9803
>>      events/s (eps):                      3604632.7799
>>      events/s (eps):                      3149506.7001
>>    the output of gb mode is:
>>      events/s (eps):                      5472334.9313
>>      events/s (eps):                      4085399.1606
>>      events/s (eps):                      4398122.2170
>>      events/s (eps):                      6180233.6766
>>      events/s (eps):                      4299784.2742
>>      events/s (eps):                      4914813.6847
>>      events/s (eps):                      3675395.1191
>>      events/s (eps):                      6767666.6229
>>
>>    Create 4 cgroup each running redis-server with 16 io threads,
>>    4 redis-benchmark per each server show average rps as:
>>
>>                      share mode       gb mode
>>
>>    PING_INLINE     : 41154.84         42229.27               2.61%
>>    PING_MBULK      : 43042.07         44907.10               4.33%
>>    SET             : 34502.00         37374.58               8.33%
>>    GET             : 41713.47         45257.68               8.50%
>>    INCR            : 41533.26         44259.31               6.56%
>>    LPUSH           : 36541.23         39417.84               7.87%
>>    RPUSH           : 39059.26         42075.32               7.72%
>>    LPOP            : 36978.73         39903.15               7.91%
>>    RPOP            : 39553.32         42071.53               6.37%
>>    SADD            : 40614.30         44693.33              10.04%
>>    HSET            : 39101.93         42401.16               8.44%
>>    SPOP            : 42838.90         46560.46               8.69%
>>    ZADD            : 38346.80         41685.46               8.71%
>>    ZPOPMIN         : 41952.26         46138.14               9.98%
>>    LRANGE_100      : 19364.66         20251.56               4.58%
>>    LRANGE_300      : 9699.57          9935.86                2.44%
>>    LRANGE_500      : 6291.76          6512.48                3.51%
>>    LRANGE_600      : 5619.13          5658.31                0.70%
>>    MSET            : 24432.78         26517.63               8.53%
>>
>> Signed-off-by: Cruz Zhao <cruzzhao@linux.alibaba.com>
>> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> 
> Invalid SoB chain.

We rechecked the doc and confirmed it's invalid, author was supposed to
be the first line, but seems like co-developer stuff is more suitable
here, will fix in next version.

> 
> 
> I'll not really have much time at the moment to look at the code.
> Hopefully in a few weeks, but I first need to recover from a 2 week
> break and then finish the umcg bits I was working on before that.

It's totally fine :-) We will try to improve the description based on
your questions and fix issues firstly.

BTW, we are also trying to help on UMCG stuff, got a simple app
now based on the v0.9 from the author, I saw you're working on new
implementation, maybe we can help on testing when see these patches.

Regards,
Michael Wang
