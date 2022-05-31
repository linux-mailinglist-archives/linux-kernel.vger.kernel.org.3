Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53BD538BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244465AbiEaHUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiEaHUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:20:49 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092FF8BD01
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:20:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VEu.I5r_1653981640;
Received: from 30.39.201.51(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VEu.I5r_1653981640)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 May 2022 15:20:42 +0800
Message-ID: <1d0eb8f4-e474-86a9-751a-7c2e1788df85@linux.alibaba.com>
Date:   Tue, 31 May 2022 15:20:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2] sched: Queue task on wakelist in the same llc if the
 wakee cpu is idle
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220527090544.527411-1-dtcccc@linux.alibaba.com>
 <xhsmhleuj7zve.mognet@vschneid.remote.csb>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <xhsmhleuj7zve.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/31 00:24, Valentin Schneider wrote:
> On 27/05/22 17:05, Tianchen Ding wrote:
>> The main idea of wakelist is to avoid cache bouncing. However,
>> commit 518cd6234178 ("sched: Only queue remote wakeups when
>> crossing cache boundaries") disabled queuing tasks on wakelist when
>> the cpus share llc. This is because, at that time, the scheduler must
>> send IPIs to do ttwu_queue_wakelist. Nowadays, ttwu_queue_wakelist also
>> supports TIF_POLLING, so this is not a problem now when the wakee cpu is
>> in idle polling.
> 
> [...]
> 
>> Our patch has improvement on schbench, hackbench
>> and Pipe-based Context Switching of unixbench
>> when there exists idle cpus,
>> and no obvious regression on other tests of unixbench.
>> This can help improve rt in scenes where wakeup happens frequently.
>>
>> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> 
> This feels a bit like a generalization of
> 
>    2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
> 
> Given rq->curr is updated before prev->on_cpu is cleared, the waker
> executing ttwu_queue_cond() can observe:
> 
>    p->on_rq=0
>    p->on_cpu=1
>    rq->curr=swapper/x (aka idle task)
> 
> So your addition of available_idle_cpu() in ttwu_queue_cond() (sort of)
> matches that when invoked via:
> 
>          if (smp_load_acquire(&p->on_cpu) &&
>              ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
>                  goto unlock;
> 
> but it also affects
> 
>          ttwu_queue(p, cpu, wake_flags);
> 
> at the tail end of try_to_wake_up().

Yes. This part is what we mainly want to affect. The above WF_ON_CPU is 
not our point.

> 
> With all that in mind, I'm curious whether your patch is functionaly close
> to the below.
> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 66c4e5922fe1..ffd43264722a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3836,7 +3836,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>   	 * the soon-to-be-idle CPU as the current CPU is likely busy.
>   	 * nr_running is checked to avoid unnecessary task stacking.
>   	 */
> -	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
> +	if (cpu_rq(cpu)->nr_running <= 1)
>   		return true;
>   
>   	return false;

It's a little different. This may bring extra IPIs when nr_running == 1 
and the current task on wakee cpu is not the target wakeup task (i.e., 
rq->curr == another_task && rq->curr != p). Then this another_task may 
be disturbed by IPI which is not expected. So IMO the promise by 
WF_ON_CPU is necessary.
