Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C6490F42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242721AbiAQRSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:18:02 -0500
Received: from foss.arm.com ([217.140.110.172]:33262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243001AbiAQRQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:16:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA7F16D;
        Mon, 17 Jan 2022 09:16:49 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC2943F766;
        Mon, 17 Jan 2022 09:16:48 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yihao Wu <wuyihao@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Shanpei Chen <shanpeic@linux.alibaba.com>,
        =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Again ignore percpu threads for imbalance pulls
In-Reply-To: <5f8497cd-aeaf-906d-a2d8-2e0a752fed4b@linux.alibaba.com>
References: <20211211094808.109295-1-wuyihao@linux.alibaba.com> <87k0g48kyp.mognet@arm.com> <5f8497cd-aeaf-906d-a2d8-2e0a752fed4b@linux.alibaba.com>
Date:   Mon, 17 Jan 2022 17:16:42 +0000
Message-ID: <87ee56705h.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/22 22:50, Yihao Wu wrote:
> Thanks a lot for the help, Valentin and Peter!
>
> On 2021/12/17 2:26am, Valentin Schneider wrote:
>> On 11/12/21 17:48, Yihao Wu wrote:
>>> commit 2f5f4cce496e ("sched/fair: Ignore percpu threads for imbalance
>>> pulls") was meant to fix a performance issue, when load balance tries to
>>> migrate pinned kernel threads at MC domain level. This was destined to
>>> fail.
>> 
>>> After it fails, it further makes wakeup balance at NUMA domain level
>>> messed up. The most severe case that I noticed and frequently occurs:
>>>      |sum_nr_running(node1) - sum_nr_running(node2)| > 100
>>>
>> 
>> Wakeup balance (aka find_idlest_cpu()) is different from periodic load
>> balance (aka load_balance()) and doesn't use can_migrate_task(), so the
>> incriminated commit shouldn't have impacted it (at least not in obvious
>> ways...). Do you have any more details on that issue
>
> The original bugfix concerns only about load balance. While I found wake
> up balance is impacted too, after I observed regression in lmbench3 test
> suite. This is how it's impacted:
>
> - Periodic load balance
> - kthread_is_per_cpu? No
> - env->flags |= LBF_SOME_PINNED
> - sd_parent..imbalance being set to 1 because of LBF_SOME_PINNED
>
> So far exactly the same as what Chandrasekhar describes in 2f5f4cce496e.
> Then imbalance connects periodic and wakeup balance.
>
> - Wakeup balance(find_idlest_group)
> - update_sg_wakeup_stats classifies local_sgs as group_imbalanced
> - find_idlest_group chooses another NUMA node
>
> wakeup balance keeps doing this until another NUMA node becomes so busy.
> And another periodic load balance just shifts it around, makeing the 
> previously overloaded node completely idle now.
>

Oooh, right, I came to the same conclusion when I got that stress-ng
regression report back then:

https://lore.kernel.org/all/871rajkfkn.mognet@arm.com/

I pretty much gave up on that as the regression we caused by removing an
obscure/accidental balance which I couldn't properly codify. I can give it
another shot, but AFAICT that only affects fork/exec heavy workloads (that
-13% was on something doing almost only forks) which is an odd case to
support.

> (Thanks to the great schedviz tool, I observed that all workloads as a 
> whole, is migrated between the two NUMA nodes in a ping-pong pattern, 
> and with a period around 3ms)
>
> The reason wake up balance suffers more is, in fork+exit test case, 
> wakeup balance happens with much higher frequency. It exists in real 
> world applications too I believe.
>
>> 
>>> However the original bugfix failed, because it covers only case 1) below.
>>>    1) Created by create_kthread
>>>    2) Created by kernel_thread
>>> No kthread is assigned to task_struct in case 2 (Please refer to comments
>>> in free_kthread_struct) so it simply won't work.
>>>
>>> The easist way to cover both cases is to check nr_cpus_allowed, just as
>>> discussed in the mailing list of the v1 version of the original fix.
>>>
>>> * lmbench3.lat_proc -P 104 fork (2 NUMA, and 26 cores, 2 threads)
>>>
>> 
>> Reasoning about "proper" pcpu kthreads was simpler since they are static,
>> see 3a7956e25e1d ("kthread: Fix PF_KTHREAD vs to_kthread() race")
>> 
> Get it. Thanks.
>
>>>                           w/out patch                 w/ patch
>>> fork+exit latency            1660 ms                  1520 ms (   8.4%)
>>>
>>> Fixes: 2f5f4cce496e ("sched/fair: Ignore percpu threads for imbalance pulls")
>>> Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
>>> ---
>>>   kernel/kthread.c | 6 +-----
>>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/kthread.c b/kernel/kthread.c
>>> index 4a4d7092a2d8..cb05d3ff2de4 100644
>>> --- a/kernel/kthread.c
>>> +++ b/kernel/kthread.c
>>> @@ -543,11 +543,7 @@ void kthread_set_per_cpu(struct task_struct *k, int cpu)
>>>
>>>   bool kthread_is_per_cpu(struct task_struct *p)
>>>   {
>>> -	struct kthread *kthread = __to_kthread(p);
>>> -	if (!kthread)
>>> -		return false;
>>> -
>>> -	return test_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
>>> +	return (p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1;
>>>   }
>> 
>> As Peter said, this is going to cause issues. If you look at
>> kthread_set_per_cpu(), we also store a CPU value which we expect to be
>> valid when kthread_is_per_cpu(), which that change is breaking.
>> 
>> AIUI what you want to patch is the actual usage in can_migrate_task()
>> 
>
> Get it. Some may want a consistent view of kthread_is_per_cpu, 
> kthread->cpu, and KTHREAD_IS_PER_CPU.
>
> Are you suggesting to patch only can_migrate_task to check 
> nr_cpus_allowed?

Yes

> Wouldn't it be confusing if it uses an alternative way 
> to tell if p is a per-cpu kthread?
>

Well then it wouldn't catch just per-CPU kthreads, but rather any pinned
task (kernel or otherwise). But then you have to check/test if that's a
sane thing to :)

> I haven't a better solution though. :(
>
>
> Thanks,
> Yihao Wu
>
>>>
>>>   /**
>>> --
>>> 2.32.0.604.gb1f3e1269
