Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FA559B9CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiHVGt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiHVGtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:49:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429B419C37
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:49:19 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MB2w40Ld9znTh8;
        Mon, 22 Aug 2022 14:47:00 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 14:49:16 +0800
Received: from [10.174.178.93] (10.174.178.93) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 14:49:16 +0800
Message-ID: <919c20ad-6785-59e4-e39a-a345346fb550@huawei.com>
Date:   Mon, 22 Aug 2022 14:49:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] sched/fair: Introduce priority load balance to reduce
 interference from IDLE tasks
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Abel Wu <wuyun.abel@bytedance.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20220810015636.3865248-1-zhangsong34@huawei.com>
 <b62804cb-2b60-a534-5096-56785a1940bd@bytedance.com>
 <e2c9eccc-dd86-16e9-c43e-8415f99f413e@huawei.com>
 <13a7a412-5e2e-6ef8-acd6-a761aad66c3a@bytedance.com>
 <6ae319c0-e6ed-4aad-64b8-d3f6cbea688d@huawei.com>
 <CAKfTPtAcEstoqC+9-y9ubaXDSGbfLdMhFboMPn433QNPD114dQ@mail.gmail.com>
 <9a63b371-9940-caee-7fa1-2c230bec0bd1@bytedance.com>
 <20220818083133.GA536@vingu-book>
 <798411ac-6edb-d22c-5378-297268e77b1a@huawei.com>
 <CAKfTPtBcJhC4qPQuK9g4bL0sgtmqkA3JZmnGJz7DaejsUPkOeg@mail.gmail.com>
 <CAKfTPtBEaaLUdapJRvPFX3UZrkynRUfdDg6dAZ_vm2OK9eN0Fg@mail.gmail.com>
From:   "zhangsong (J)" <zhangsong34@huawei.com>
In-Reply-To: <CAKfTPtBEaaLUdapJRvPFX3UZrkynRUfdDg6dAZ_vm2OK9eN0Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.93]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vincent,

On 2022/8/20 0:04, Vincent Guittot wrote:
> On Fri, 19 Aug 2022 at 14:35, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>>
>> Hi Zhang,
>>
>> On Fri, 19 Aug 2022 at 12:54, zhangsong (J) <zhangsong34@huawei.com> wrote:
>>>
>>>
>>> On 2022/8/18 16:31, Vincent Guittot wrote:
>>>> Le jeudi 18 août 2022 à 10:46:55 (+0800), Abel Wu a écrit :
>>>>> On 8/17/22 8:58 PM, Vincent Guittot Wrote:
>>>>>> On Tue, 16 Aug 2022 at 04:53, zhangsong (J) <zhangsong34@huawei.com> wrote:
>>>>>>>
>>>> ...
>>>>
>>>>>>> Yes, this is usually a corner case, but suppose that some non-idle tasks bounds to CPU 1-2
>>>>>>>
>>>>>>> and idle tasks bounds to CPU 0-1, so CPU 1 may has many idle tasks and some non-idle
>>>>>>>
>>>>>>> tasks while idle tasks on CPU 1 can not be pulled to CPU 2, when trigger load balance if
>>>>>>>
>>>>>>> CPU 2 should pull some tasks from CPU 1, the bad result is idle tasks of CPU 1 cannot be
>>>>>>>
>>>>>>> migrated and non-idle tasks also cannot be migrated in case of env->loop_max constraint.
>>>>>> env->loop_max adds a break but load_balance will continue with next
>>>>>> tasks so it also tries to pull your non idle task at the end after
>>>>>> several breaks.
>>>>> Loop will be terminated without LBF_NEED_BREAK if exceeds loop_max :)
>>>> Argh yes, my brain is not yet back from vacation
>>>> I have been confused by loop_max and loop_break being set to the same value 32
>>>>
>>>> Zhang Song, Could you try the patch below ? If it works, I will prepare a
>>>> clean patch with all tags
>>>>
>>>>
>>>>
>>>> sched/fair: make sure to try to detach at least one movable task
>>>>
>>>> During load balance we try at most env->loop_max time to move a task. But
>>>> it can happen that the LRU tasks (ie tail of the cfs_tasks list) can't
>>>> be moved to dst_cpu because of affinity. In this case, loop in the list
>>>> until we found at least one.
>>>>
>>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>>> ---
>>>>    kernel/sched/fair.c | 12 +++++++++---
>>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index da388657d5ac..02b7b808e186 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -8052,8 +8052,12 @@ static int detach_tasks(struct lb_env *env)
>>>>                p = list_last_entry(tasks, struct task_struct, se.group_node);
>>>>
>>>>                env->loop++;
>>>> -             /* We've more or less seen every task there is, call it quits */
>>>> -             if (env->loop > env->loop_max)
>>>> +             /*
>>>> +              * We've more or less seen every task there is, call it quits
>>>> +              * unless we haven't found any movable task yet.
>>>> +              */
>>>> +             if (env->loop > env->loop_max &&
>>>> +                 !(env->flags & LBF_ALL_PINNED))
>>>>                        break;
>>>>
>>>>                /* take a breather every nr_migrate tasks */
>>>> @@ -10182,7 +10186,9 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>>>
>>>>                if (env.flags & LBF_NEED_BREAK) {
>>>>                        env.flags &= ~LBF_NEED_BREAK;
>>>> -                     goto more_balance;
>>>> +                     /* Stop if we tried all running tasks */
>>>> +                     if (env.loop < busiest->nr_running)
>>>> +                             goto more_balance;
>>>>                }
>>>>
>>>>                /*
>>>> --
>>>> 2.17.1
>>>
>>> Thanks for your reply.
>>> I have tried your patch and run test compared with it, it seems that the
>>> patch you provide makes no sense.
>>> The test result is below(1000 idle tasks bounds to CPU 0-1 and 10 normal
>>> tasks bounds to CPU 1-2):
>>>
>>> =================================================================
>>>
>>> Without patch:
>>>
>>>
>>>             6,777.37 msec cpu-clock                 #    1.355 CPUs utilized
>>>               20,812      context-switches          #    0.003 M/sec
>>>                    0      cpu-migrations            #    0.000 K/sec
>>>                    0      page-faults               #    0.000 K/sec
>>>       13,333,983,148      cycles                    #    1.967 GHz
>>>        6,457,930,305      instructions              #    0.48  insn per cycle
>>>        2,125,644,649      branches                  #  313.639 M/sec
>>>            1,690,587      branch-misses             #    0.08% of all
>>> branches
>>>         5.001931983 seconds time elapsed
>>>
>>> With your patch:
>>>
>>>
>>>             6,791.46 msec cpu-clock                 #    1.358 CPUs utilized
>>>               20,996      context-switches          #    0.003 M/sec
>>>                    0      cpu-migrations            #    0.000 K/sec
>>>                    0      page-faults               #    0.000 K/sec
>>>       13,467,573,052      cycles                    #    1.983 GHz
>>>        6,516,989,062      instructions              #    0.48  insn per cycle
>>>        2,145,139,220      branches                  #  315.858 M/sec
>>>            1,751,454      branch-misses             #    0.08% of all
>>> branches
>>>
>>>          5.002274267 seconds time elapsed
>>>
>>> With my patch:
>>>
>>>
>>>             7,495.14 msec cpu-clock                 #    1.499 CPUs utilized
>>>               23,176      context-switches          #    0.003 M/sec
>>>                  309      cpu-migrations            #    0.041 K/sec
>>>                    0      page-faults               #    0.000 K/sec
>>>       14,849,083,489      cycles                    #    1.981 GHz
>>>        7,180,832,268      instructions              #    0.48  insn per cycle
>>>        2,363,300,644      branches                  #  315.311 M/sec
>>>            1,964,169      branch-misses             #    0.08% of all
>>> branches
>>>
>>>          5.001713352 seconds time elapsed
>>> ===============================================================
>>>
>>> Obviously,  when your patch is applied, the cpu-migrations of normal
>>> tasks is still 0 and the
>>> CPU ulization of normal tasks have no improvement compared with no patch
>>> applied.
>>> When apply my patch, the cpu-migrations and CPU ulization of normal
>>> tasks can both improve.
>>> I cannot explain the result with your patch, you also can test it by
>>> yourself.
>>
>> Do you have more details about the test that your are running ?
>>
>> Do cpu0-2 share their cache ?
>> Which kingd of task are the normal and idle tasks ? always running tasks ?
>>
>> I'm going to try to reproduce your problem locally
> 
> Some details of your UC are missing. I have tried to reproduce your
> example above:
>      1000 idle tasks bounds to CPU 0-1 and 10 normal tasks bounds to CPU 1-2
> 
> Let assume that for any reason, the 10 normal tasks wake up on CPU 1.
> Then, the thousand of idle tasks are moved to CPU0 by load balance and
> only normal tasks stay on CPU1. Then load balance will move some
> normal tasks to CPU2.
> 
> My only way to reproduce something similar to your example, is to pin
> the 1000 idle tasks on CPU1 so they can't move to CPU0. Then I can see
> that load balance reaches loop_max limit and gets hard time moving
> normal tasks on CPU2. But in this later case, my patch helps to move
> normal tasks on CPU2. Something is missing in the description of your
> UC.
> 
> Sidenote, I have the same kind of problem with 1000 normal task with
> low priority so it's not a matter of idle vs normal tasks
> 
> Regards,
> Vincent
> 

Sorry for my slow reply.

I have found a test case which can more illustrate this problem 
accurately. The test case is below.

1. a dead foreach loop process run as normal or idle task
$ cat test.c
int main(int argc, char **argv)
{
         int i = 0;
         int duration = atoi(argv[1]);

         while(1) {
                 usleep(duration);
                 for(i = 0; i < 100000; i++) {}
         }
}
$ gcc -o test test.c

2. firstly spawn 500 idle tasks which bounds to CPU 0-2
3. secondly spawn 10 normal tasks which also bounds to CPU 0-2
4. lastly spawn 500 idle tasks which bounds to CPU 0 only
5. perf stat normal tasks and get CPU utilization and cpu-migrations


Below is the whole test script.
$ cat test.sh
#!/bin/bash

# create normal and idle cgroup path
mkdir /sys/fs/cgroup/cpu/normal/
mkdir /sys/fs/cgroup/cpu/idle/

# spawn 500 idle tasks and bind tasks to CPU 0-2
for ((i = 0; i < 500; i++))
do
		taskset -c 0-2 ./test 200 &
		pid=$!
		# change to SCHED_IDLE policy
		chrt -i -p 0 $pid
		echo $pid > /sys/fs/cgroup/cpu/idle/tasks
done

# spawn 10 normal tasks and bind tasks to CPU 0-2
normal_tasks=
for ((i = 0; i < 10; i++))
do
		taskset -c 0-2 ./test 500 &
		pid=$!
		normal_tasks+=$pid,
		echo $pid > /sys/fs/cgroup/cpu/normal/tasks
done

# spawn 500 idle tasks and bind tasks to CPU 0 only
for ((i = 0; i < 500; i++))
do
		taskset -c 0 ./test 200 &
		pid=$!
		# change to SCHED_IDLE policy
		chrt -i -p 0 $pid
		echo $pid > /sys/fs/cgroup/cpu/idle/tasks
done

# perf stat normal tasks
perf stat -a -p $normal_tasks sleep 5
pkill -f test


You can try the above case and test it with your patch.

Regards,
Zhang Song
