Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435E8599A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348416AbiHSKyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348389AbiHSKyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:54:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DB23DF24
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:54:09 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M8JRk1fnNzXdj6;
        Fri, 19 Aug 2022 18:49:54 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 18:54:07 +0800
Received: from [10.174.178.93] (10.174.178.93) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 18:54:07 +0800
Message-ID: <798411ac-6edb-d22c-5378-297268e77b1a@huawei.com>
Date:   Fri, 19 Aug 2022 18:54:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] sched/fair: Introduce priority load balance to reduce
 interference from IDLE tasks
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Abel Wu <wuyun.abel@bytedance.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
References: <20220810015636.3865248-1-zhangsong34@huawei.com>
 <b62804cb-2b60-a534-5096-56785a1940bd@bytedance.com>
 <e2c9eccc-dd86-16e9-c43e-8415f99f413e@huawei.com>
 <13a7a412-5e2e-6ef8-acd6-a761aad66c3a@bytedance.com>
 <6ae319c0-e6ed-4aad-64b8-d3f6cbea688d@huawei.com>
 <CAKfTPtAcEstoqC+9-y9ubaXDSGbfLdMhFboMPn433QNPD114dQ@mail.gmail.com>
 <9a63b371-9940-caee-7fa1-2c230bec0bd1@bytedance.com>
 <20220818083133.GA536@vingu-book>
From:   "zhangsong (J)" <zhangsong34@huawei.com>
In-Reply-To: <20220818083133.GA536@vingu-book>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.93]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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


On 2022/8/18 16:31, Vincent Guittot wrote:
> Le jeudi 18 août 2022 à 10:46:55 (+0800), Abel Wu a écrit :
>> On 8/17/22 8:58 PM, Vincent Guittot Wrote:
>>> On Tue, 16 Aug 2022 at 04:53, zhangsong (J) <zhangsong34@huawei.com> wrote:
>>>>
> ...
>
>>>> Yes, this is usually a corner case, but suppose that some non-idle tasks bounds to CPU 1-2
>>>>
>>>> and idle tasks bounds to CPU 0-1, so CPU 1 may has many idle tasks and some non-idle
>>>>
>>>> tasks while idle tasks on CPU 1 can not be pulled to CPU 2, when trigger load balance if
>>>>
>>>> CPU 2 should pull some tasks from CPU 1, the bad result is idle tasks of CPU 1 cannot be
>>>>
>>>> migrated and non-idle tasks also cannot be migrated in case of env->loop_max constraint.
>>> env->loop_max adds a break but load_balance will continue with next
>>> tasks so it also tries to pull your non idle task at the end after
>>> several breaks.
>> Loop will be terminated without LBF_NEED_BREAK if exceeds loop_max :)
> Argh yes, my brain is not yet back from vacation
> I have been confused by loop_max and loop_break being set to the same value 32
>
> Zhang Song, Could you try the patch below ? If it works, I will prepare a
> clean patch with all tags
>
>
>
> sched/fair: make sure to try to detach at least one movable task
>
> During load balance we try at most env->loop_max time to move a task. But
> it can happen that the LRU tasks (ie tail of the cfs_tasks list) can't
> be moved to dst_cpu because of affinity. In this case, loop in the list
> until we found at least one.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/fair.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index da388657d5ac..02b7b808e186 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8052,8 +8052,12 @@ static int detach_tasks(struct lb_env *env)
>   		p = list_last_entry(tasks, struct task_struct, se.group_node);
>
>   		env->loop++;
> -		/* We've more or less seen every task there is, call it quits */
> -		if (env->loop > env->loop_max)
> +		/*
> +		 * We've more or less seen every task there is, call it quits
> +		 * unless we haven't found any movable task yet.
> +		 */
> +		if (env->loop > env->loop_max &&
> +		    !(env->flags & LBF_ALL_PINNED))
>   			break;
>
>   		/* take a breather every nr_migrate tasks */
> @@ -10182,7 +10186,9 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>
>   		if (env.flags & LBF_NEED_BREAK) {
>   			env.flags &= ~LBF_NEED_BREAK;
> -			goto more_balance;
> +			/* Stop if we tried all running tasks */
> +			if (env.loop < busiest->nr_running)
> +				goto more_balance;
>   		}
>
>   		/*
> --
> 2.17.1

Thanks for your reply.
I have tried your patch and run test compared with it, it seems that the 
patch you provide makes no sense.
The test result is below(1000 idle tasks bounds to CPU 0-1 and 10 normal 
tasks bounds to CPU 1-2):

=================================================================

Without patch:


           6,777.37 msec cpu-clock                 #    1.355 CPUs utilized
             20,812      context-switches          #    0.003 M/sec
                  0      cpu-migrations            #    0.000 K/sec
                  0      page-faults               #    0.000 K/sec
     13,333,983,148      cycles                    #    1.967 GHz
      6,457,930,305      instructions              #    0.48  insn per cycle
      2,125,644,649      branches                  #  313.639 M/sec
          1,690,587      branch-misses             #    0.08% of all 
branches
       5.001931983 seconds time elapsed

With your patch:


           6,791.46 msec cpu-clock                 #    1.358 CPUs utilized
             20,996      context-switches          #    0.003 M/sec
                  0      cpu-migrations            #    0.000 K/sec
                  0      page-faults               #    0.000 K/sec
     13,467,573,052      cycles                    #    1.983 GHz
      6,516,989,062      instructions              #    0.48  insn per cycle
      2,145,139,220      branches                  #  315.858 M/sec
          1,751,454      branch-misses             #    0.08% of all 
branches

        5.002274267 seconds time elapsed

With my patch:


           7,495.14 msec cpu-clock                 #    1.499 CPUs utilized
             23,176      context-switches          #    0.003 M/sec
                309      cpu-migrations            #    0.041 K/sec
                  0      page-faults               #    0.000 K/sec
     14,849,083,489      cycles                    #    1.981 GHz
      7,180,832,268      instructions              #    0.48  insn per cycle
      2,363,300,644      branches                  #  315.311 M/sec
          1,964,169      branch-misses             #    0.08% of all 
branches

        5.001713352 seconds time elapsed
===============================================================

Obviously,  when your patch is applied, the cpu-migrations of normal 
tasks is still 0 and the
CPU ulization of normal tasks have no improvement compared with no patch 
applied.
When apply my patch, the cpu-migrations and CPU ulization of normal 
tasks can both improve.
I cannot explain the result with your patch, you also can test it by 
yourself.

Best,
Zhang Song

>
>>>> This will cause non-idle  tasks cannot achieve  more CPU utilization.
>>> Your problem is not linked to IDLE vs NORMAL tasks but to the large
>>> number of pinned tasks that can't migrate on CPU2. You can end with
>>> the same behavior without using IDLE tasks but only NORMAL tasks.
>> I feel the same thing.
>>
>> Best,
>> Abel
> .
