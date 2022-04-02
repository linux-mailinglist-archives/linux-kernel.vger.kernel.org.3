Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C8B4EFE3A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 05:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352747AbiDBDe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 23:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiDBDe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:34:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B5BF8EDE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 20:33:05 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KVjKQ4M26z1HBQc;
        Sat,  2 Apr 2022 11:32:42 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 2 Apr 2022 11:33:03 +0800
Received: from [10.174.178.93] (10.174.178.93) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Sat, 2 Apr 2022 11:33:02 +0800
Message-ID: <5f60ad7e-6809-e314-53e5-aa081dbffff5@huawei.com>
Date:   Sat, 2 Apr 2022 11:32:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] sched/fair: Allow non-idle task to preempt idle task
 directly
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <linux-kernel@vger.kernel.org>,
        zhangsong <zhangsong34@gmail.com>
References: <20220401091127.3234638-1-zhangsong34@huawei.com>
 <CAKfTPtCNLELdiQXCdbxrXotqCkRV-2mKK7uVXQv---mbnekaUQ@mail.gmail.com>
From:   "zhangsong (J)" <zhangsong34@huawei.com>
In-Reply-To: <CAKfTPtCNLELdiQXCdbxrXotqCkRV-2mKK7uVXQv---mbnekaUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.93]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/1 21:09, Vincent Guittot 写道:
> On Fri, 1 Apr 2022 at 11:13, zhangsong <zhangsong34@huawei.com> wrote:
>> From: zhangsong <zhangsong34@gmail.com>
>>
>> In check_preempt_tick(), the sched idle task may exectue at least
>> `sysctl_sched_min_granularity` time but any other cfs tasks cannot
>> preempt it. So it is nessesary to ignore the `sysctl_sched_min_granularity`
>> resctriction for sched idle task preemption.
> Could you explain why you need to remove this condition for sched_idle ?
> sched_idle tasks are already preempted at wakeup by others. And they
> run while others are runnable only if they has not run for a very long
> time compares to other. The ideal_runtime of a sched_idle task is
> capped to 750us min to ensure a minimum progress. But this will happen
> not more than once  every 256ms and most probably even less often.

Thanks for your reply！I think that sched idle task is treated offline 
task, and sched normal task is treated online task. To reduce latency of 
online tasks and the interference from offline tasks, it is no need to 
let offline task occupy any CPU time.

>
>> Signed-off-by: zhangsong <zhangsong34@gmail.com>
>> ---
>>   kernel/sched/fair.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d4bd299d6..edcb33440 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4477,6 +4477,15 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>          struct sched_entity *se;
>>          s64 delta;
>>
>> +       se = __pick_first_entity(cfs_rq);
>> +
>> +       if ((cfs_rq->last && se_is_idle(cfs_rq->last) - se_is_idle(curr) < 0) ||
>> +           (cfs_rq->next && se_is_idle(cfs_rq->last) - se_is_idle(curr) < 0) ||
>> +           se_is_idle(se) - se_is_idle(curr) < 0) {
>> +               resched_curr(rq_of(cfs_rq));
>> +               return;
> Why all these complex conditions ?
> if (se_is_idle(curr)) should be enough
>
I think that if se/next/last is not idle and curr is idle, current 
cfs_rq should resched and curr can be preempt by others.
>> +       }
>> +
>>          ideal_runtime = sched_slice(cfs_rq, curr);
>>          delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
>>          if (delta_exec > ideal_runtime) {
>> @@ -4497,7 +4506,6 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>          if (delta_exec < sysctl_sched_min_granularity)
>>                  return;
>>
>> -       se = __pick_first_entity(cfs_rq);
>>          delta = curr->vruntime - se->vruntime;
>>
>>          if (delta < 0)
>> --
>> 2.27.0
>>
> .
