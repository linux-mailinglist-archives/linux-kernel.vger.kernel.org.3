Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E524A66C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiBAVAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:00:55 -0500
Received: from mail.efficios.com ([167.114.26.124]:56718 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbiBAVAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:00:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4AF50348674;
        Tue,  1 Feb 2022 16:00:53 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NDJj4GGdF_09; Tue,  1 Feb 2022 16:00:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D2E3B348AA3;
        Tue,  1 Feb 2022 16:00:52 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D2E3B348AA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643749252;
        bh=D6F7I14e09DLJ7OBXCoOb2aDWOL6Vpkl8xCgOrXzLZI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=TOcOopo+zfIkJM1NpeSeho3ukIFoN0UcRhzMIbE4NvvWutErZvd76IW4HkG4bUZP8
         Byksk4cy6M+6xk21dCLF3UspToZcfzLAxJJn5rTcShRA+xRNuqN5WJiPnwbBh2WE6g
         +sIBKJHQ6ls80uRC1XCH5dHT69KL1DeTk8T7QVXacZm7l4r8l1CY1s6okmlAjQwLsh
         i1KIaNUsgCt9LUxSkNdAy/5VLzKkbYiIgnctTk6qkrrWSRvlLpP4yqqVpT6LnogFH4
         tP5GJWNjCvnU3dR+Xy2ZKsovVtaz5fcnBY/DdRTrbTpx3+xvSTA2JB8jdkqoppmd2q
         Tr3e8sLzfir5w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QS4bqrwocbFV; Tue,  1 Feb 2022 16:00:52 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BDAF7348766;
        Tue,  1 Feb 2022 16:00:52 -0500 (EST)
Date:   Tue, 1 Feb 2022 16:00:52 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@aculab.com>,
        carlos <carlos@redhat.com>, Chris Kennelly <ckennelly@google.com>
Message-ID: <2083444900.25808.1643749252639.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFTs51XYWqN6bPbVYh8a9ta+VxS4iBbiWWNO7n1t-4_VLpKGXQ@mail.gmail.com>
References: <20220201192540.10439-1-mathieu.desnoyers@efficios.com> <CAFTs51XYWqN6bPbVYh8a9ta+VxS4iBbiWWNO7n1t-4_VLpKGXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] Introduce per thread group current virtual cpu
 id
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: Introduce per thread group current virtual cpu id
Thread-Index: WUJXhv7+C6tZP3wo1UvlQkFhhpClMA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 1, 2022, at 2:49 PM, Peter Oskolkov posk@posk.io wrote:

> On Tue, Feb 1, 2022 at 11:26 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> This feature allows the scheduler to expose a current virtual cpu id
>> to user-space. This virtual cpu id is within the possible cpus range,
>> and is temporarily (and uniquely) assigned while threads are actively
>> running within a thread group. If a thread group has fewer threads than
>> cores, or is limited to run on few cores concurrently through sched
>> affinity or cgroup cpusets, the virtual cpu ids will be values close
>> to 0, thus allowing efficient use of user-space memory for per-cpu
>> data structures.
> 
> Why per thread group and not per mm? The main use case is for
> per-(v)cpu memory allocation logic, so it seems having this feature
> per mm is more appropriate?

Good point, yes, per-mm would be more appropriate.

So I guess that from a userspace perspective, the rseq field could become
"__u32 vm_vcpu; /* Current vcpu within memory space. */"

[...]

>> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
>> index b6ecb9fc4cd2..c87e7ad5a1ea 100644
>> --- a/include/linux/sched/signal.h
>> +++ b/include/linux/sched/signal.h
>> @@ -244,6 +244,12 @@ struct signal_struct {
>>                                                  * and may have inconsistent
>>                                                  * permissions.
>>                                                  */
>> +#ifdef CONFIG_SCHED_THREAD_GROUP_VCPU
>> +       /*
>> +        * Mask of allocated vcpu ids within the thread group.
>> +        */
>> +       cpumask_t                       vcpu_mask;
> 
> We use a pointer for the mask (in struct mm). Adds complexity around
> alloc/free, though. Just FYI.

It does make sense if this is opt-in.

[...]

>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 2e4ae00e52d1..2690e80977b1 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4795,6 +4795,8 @@ prepare_task_switch(struct rq *rq, struct task_struct
>> *prev,
>>         sched_info_switch(rq, prev, next);
>>         perf_event_task_sched_out(prev, next);
>>         rseq_preempt(prev);
>> +       tg_vcpu_put(prev);
>> +       tg_vcpu_get(next);
> 
> Doing this for all tasks on all context switches will most likely be
> too expensive. We do it only for tasks that explicitly asked for this
> feature during their rseq registration, and still the tight loop in
> our equivalent of tg_vcpu_get() is occasionally noticeable (lots of
> short wakeups can lead to the loop thrashing around).
> 
> Again, our approach is more complicated as a result.

I suspect that the overhead of tg_vcpu_get is quite small for processes
which work on only few cores, but becomes noticeable when processes have
many threads and are massively parallel (not affined to only a few cores).

When the feature is disabled, we can always fall-back on the value returned
by raw_smp_processor_id() and use that as a "vm-vcpu-id" value.

Whether the vm-vcpu-id or the processor id is used needs to be a consensus
across all threads from all processes using a mm at a given time.

There appears to be a tradeoff here, and I wonder how this should be presented
to users. A few possible options:

- vm-vcpu feature is opt-in (default off) or opt-out (default on),
- whether vm-vcpu is enabled for a process could be selected at runtime by the
  process, either at process initialization (single thread, single mm user)
  and/or while the process is multi-threaded (requires more synchronization),
- if we find a way to move automatically between vm-vcpu-id and processor id as
  information source for all threads tied to a mm when we reach a number of parallel
  threads threshold, then I suspect we could have best of both worlds. But it's not
  clear to me how to achieve this.

Thoughts ?

Thanks,

Mathieu


> 
>>         fire_sched_out_preempt_notifiers(prev, next);
>>         kmap_local_sched_out();
>>         prepare_task(next);
>> --
>> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
