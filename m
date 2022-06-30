Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BF25612E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbiF3HCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiF3HCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:02:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C475B35DED
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:02:14 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LYTjQ5l1CzhYyR;
        Thu, 30 Jun 2022 14:59:54 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 15:02:12 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 15:02:12 +0800
Message-ID: <d0fbe859-249d-d712-3177-e1d6e8743483@huawei.com>
Date:   Thu, 30 Jun 2022 15:02:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: Perf regression from scheduler load_balance rework in 5.5?
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     David Chen <david.chen@nutanix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <BYAPR02MB4488F89EC5DB73D1FEAE9B4594B59@BYAPR02MB4488.namprd02.prod.outlook.com>
 <CAKfTPtA7wJBROfRkSQV7FzWaWqoaQjSO7iyqBt6AgGsv2OsNSw@mail.gmail.com>
 <409fc8d0-119a-3358-0fc5-99a786a9564a@huawei.com>
 <20220627105954.GA7670@vingu-book>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20220627105954.GA7670@vingu-book>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/6/27 18:59, Vincent Guittot 写道:
> Hi,
> 
> Le vendredi 24 juin 2022 à 21:16:05 (+0800), Zhang Qiao a écrit :
>>
>> Hi,
>> 在 2022/6/24 16:22, Vincent Guittot 写道:
>>> On Thu, 23 Jun 2022 at 21:50, David Chen <david.chen@nutanix.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I'm working on upgrading our kernel from 4.14 to 5.10
>>>> However, I'm seeing performance regression when doing rand read from windows client through smbd
>>>> with a well cached file.
>>>>
>>>> One thing I noticed is that on the new kernel, the smbd thread doing socket I/O tends to stay on
>>>> the same cpu core as the net_rx softirq, where as in the old kernel it tends to be moved around
>>>> more randomly. And when they are on the same cpu, it tends to saturate the cpu more and causes
>>>> performance to drop.
>>>>
>>>> For example, here's the duration (ns) the thread spend on each cpu I captured using bpftrace
>>>> On 4.14:
>>>> @cputime[7]: 20741458382
>>>> @cputime[0]: 25219285005
>>>> @cputime[6]: 30892418441
>>>> @cputime[5]: 31032404613
>>>> @cputime[3]: 33511324691
>>>> @cputime[1]: 35564174562
>>>> @cputime[4]: 39313421965
>>>> @cputime[2]: 55779811909 (net_rx cpu)
>>>>
>>>> On 5.10:
>>>> @cputime[3]: 2150554823
>>>> @cputime[5]: 3294276626
>>>> @cputime[7]: 4277890448
>>>> @cputime[4]: 5094586003
>>>> @cputime[1]: 6058168291
>>>> @cputime[0]: 14688093441
>>>> @cputime[6]: 17578229533
>>>> @cputime[2]: 223473400411 (net_rx cpu)
>>>>
>>>> I also tried setting the cpu affinity of the smbd thread away from the net_rx cpu and indeed that
>>>> seems to bring the perf on par with old kernel.
>>
>> I observed the same problem for the past two weeks.
>>
>>>>
>>>> I noticed that there's scheduler load_balance rework in 5.5, so I did the test on 5.4 and 5.5 and
>>>> it did show the behavior changed between 5.4 and 5.5.
>>>
>>> Have you tested v5.18 ? several improvements happened since v5.5
>>>
>>>>
>>>> Anyone know how to work around this?
>>>
>>> Have you enabled IRQ_TIME_ACCOUNTING ?
>>
>>
>> CONFIG_IRQ_TIME_ACCOUNTING=y.
>>
>>>
>>> When the time spent under interrupt becomes significant, scheduler
>>> migrate task on another cpu
>>
>>
>> My board has two cpus, and i used iperf3 to test upload bandwidth，then I saw the same situation，
>> the iperf3 thread run on the same cpu as the NET_RX softirq.
>>
>> After debug in find_busiest_group(), i noticed when the cpu(env->idle is CPU_IDLE or CPU_NEWLY_IDLE) try to pull task,
>> the busiest->group_type == group_fully_busy, busiest->sum_h_nr_running == 1, local->group_type==group_has_spare,
>> and the loadbalance will failed at find_busiest_group(), as follows:
>>
>> find_busiest_group():
>>     ...
>>     if (busiest->group_type != group_overloaded) {
>> 	....
>> 	if (busiest->sum_h_nr_running == 1)
>> 		goto out_balanced;     ----> loadbalance will returned at here.
> 
> Yes, you're right, we filter such case. Could you try the patch below ?
> I use the misfit task state to detect cpu with reduced capacity and migrate_load
> to check if it worth migration the task on the dst cpu. 


Hi,

I tested with this patch, it is ok.

> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6775a117f3c1..013dcd97472b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8757,11 +8757,19 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 if (local_group)
>                         continue;
>  
> -               /* Check for a misfit task on the cpu */
> -               if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> -                   sgs->group_misfit_task_load < rq->misfit_task_load) {
> -                       sgs->group_misfit_task_load = rq->misfit_task_load;
> -                       *sg_status |= SG_OVERLOAD;
> +               if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
> +                       /* Check for a misfit task on the cpu */
> +                       if (sgs->group_misfit_task_load < rq->misfit_task_load) {
> +                               sgs->group_misfit_task_load = rq->misfit_task_load;
> +                               *sg_status |= SG_OVERLOAD;
> +                       }
> +                } else if ((env->idle != CPU_NOT_IDLE) &&
> +                           (group->group_weight == 1) &&
> +                           (rq->cfs.h_nr_running == 1) &&
> +                           check_cpu_capacity(rq, env->sd) &&
> +                           (sgs->group_misfit_task_load < cpu_load(rq))) {
> +                       /* Check for a task running on a CPU with reduced capacity */
> +                       sgs->group_misfit_task_load = cpu_load(rq);
>                 }
>         }
>  
> @@ -8814,7 +8822,8 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>          * CPUs in the group should either be possible to resolve
>          * internally or be covered by avg_load imbalance (eventually).
>          */
> -       if (sgs->group_type == group_misfit_task &&
> +       if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
> +           (sgs->group_type == group_misfit_task) &&
>             (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
>              sds->local_stat.group_type != group_has_spare))
>                 return false;
> @@ -9360,9 +9369,15 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>         busiest = &sds->busiest_stat;
>  
>         if (busiest->group_type == group_misfit_task) {
> -               /* Set imbalance to allow misfit tasks to be balanced. */
> -               env->migration_type = migrate_misfit;
> -               env->imbalance = 1;
> +               if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
> +                       /* Set imbalance to allow misfit tasks to be balanced. */
> +                       env->migration_type = migrate_misfit;
> +                       env->imbalance = 1;
> +               } else {
> +                       /* Set group overloaded as one cpu has reduced capacity */
> +                       env->migration_type = migrate_load;
> +                       env->imbalance = busiest->group_misfit_task_load;
> +               }
>                 return;
>         }
> 
> 
>> ....
>>
>>
>> Thanks,
>> Qiao
>>
>>
>>> Vincent>>
>>>> Thanks,
>>>> David
>>> .
>>>
> .
> 
