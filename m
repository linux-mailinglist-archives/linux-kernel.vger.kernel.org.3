Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3729D571FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiGLPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbiGLPpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:45:19 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEE1C54A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:45:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 23so7915844pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=Uc+l9tM6hbEPDzcRxC6UuPVBheYJOzJN3XVlj75XLZA=;
        b=cPtOReVUVdckHNBuAXlYNpYT1qwViNexVZVPkxY1VKRovdISgNHTbwL3ZH+kdaKhIY
         1o5nr6qHYfsRVfJSl3P77gLRtYTwiXGjPauF5j5xvH84+v4i9v0WqrkBjOyS0FISt2dU
         lUXbEeAYTYJd6M8cxl8A+H0JFDWw0K6VYM0iC9dx6KU6A3Pjc82oP2xjTd3Ko4IddE+z
         4fM4rVpFY/TmZ48BlYh8xhT/iVuLOM266G6hEPPKVyc/Mjtblvojc6PCeJAtmmDAczyi
         RrqWD6Seb3D158LWUSUEO8JDwAyYMxmOcNP70nCRT607JcFhzwenGQ3ih2M/ZvAoHy7v
         RgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=Uc+l9tM6hbEPDzcRxC6UuPVBheYJOzJN3XVlj75XLZA=;
        b=54Bpahf8RXmUqP+SZq7G1DMkBUSJaLvGjNa291MasIIEFAowO634Bc4VFdmFkgGtaJ
         TSJuO0EiOBPm/1tqHDrHmCPcTdrlk+oo+tr4G+h55RzjLCdpefuP55FqtWUJJeNOw1cQ
         lpauJFvsditvtB4r5+wvZGIwIl4UPKThKXwWYbxdlVJepGCIkhEBTsow+f0pOGsnZNTc
         2kRGkcDfxGUu1zJx1NOAQmQfESjH78jCUYA1sxmMO0fmskQSSIyWHX5ZEuL5OS28TbUC
         AqxV3Z89mvOznUD4By9UA5pbHGbqMID8hLyIdZYU1UCmjVf30WUnkQaX5peawUhqQsqV
         Rp5w==
X-Gm-Message-State: AJIora9ilEBwpNtlGyIbgBdVF1MNG7Mox+FUHYq6ld5I1YtRgfi+/qHC
        KlVmBBjYA7qK9nHmkP1uEmzE9ix6QClPTQ==
X-Google-Smtp-Source: AGRyM1tmfClVnvtlV/aInS3vWZofD7iET8SSTz1PDASxiCC2cO/KHWcH/3PQfPZs57bn8KfSr3FQvA==
X-Received: by 2002:aa7:8014:0:b0:528:177a:f74a with SMTP id j20-20020aa78014000000b00528177af74amr24480103pfi.1.1657640717472;
        Tue, 12 Jul 2022 08:45:17 -0700 (PDT)
Received: from ArchLinux (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id c204-20020a624ed5000000b00528c4c770c5sm6945170pfb.77.2022.07.12.08.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:45:16 -0700 (PDT)
References: <20220712150506.632304-1-schspa@gmail.com>
 <c1db7f31-82e1-eac4-bd49-212859727cb2@arm.com>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] sched/rt: fix bad task migration for rt tasks
Date:   Tue, 12 Jul 2022 23:35:00 +0800
In-reply-to: <c1db7f31-82e1-eac4-bd49-212859727cb2@arm.com>
Message-ID: <m2h73me3nk.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dietmar Eggemann <dietmar.eggemann@arm.com> writes:

> On 12/07/2022 17:05, Schspa Shi wrote:
>> Commit 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")
>> allow find_lock_lowest_rq to pick a task with migration disabled.
>> This commit is intended to push the current running task on this CPU
>> away.
>> 
>> There is a race scenarios, which allows a migration disabled task to
>> be migrated to another CPU.
>> 
>> When there is a RT task with higher priority, rt sched class was
>> intended to migrate higher priority task to lowest rq via push_rt_tasks,
>> this BUG will happen here.
>> 
>> With the system running on PREEMPT_RT, rt_spin_lock will disable
>> migration, this will make the problem easier to reproduce.
>> 
>> I have seen this crash on PREEMPT_RT, from the logs, there is a race
>> when trying to migrate higher priority tasks to the lowest rq.
>> 
>> Please refer to the following scenarios.
>> 
>>            CPU0                                  CPU1
>> ------------------------------------------------------------------
>> push_rt_task
>>   check is_migration_disabled(next_task)
>>                                         task not running and
>>                                         migration_disabled == 0
>>   find_lock_lowest_rq(next_task, rq);
>>     _double_lock_balance(this_rq, busiest);
>>       raw_spin_rq_unlock(this_rq);
>>       double_rq_lock(this_rq, busiest);
>>         <<wait for busiest rq>>
>>                                             <wakeup>
>>                                         task become running
>>                                         migrate_disable();
>>                                           <context out>
>>   deactivate_task(rq, next_task, 0);
>>   set_task_cpu(next_task, lowest_rq->cpu);
>>     WARN_ON_ONCE(is_migration_disabled(p));
>>       ---------OOPS-------------
>> 
>> Crash logs as fellowing:
>> [123671.996430] WARNING: CPU: 2 PID: 13470 at kernel/sched/core.c:2485
>
> What code-base is this?

This is the logs from 5.10.59-rt
Link: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
v5.10.59-rt52 (9007b684f615750b0ee4ec57b5e547a4bf4a223e).

>
> IMHO, currently this `WARN_ON_ONCE(is_migration_disabled(p))` in
> set_task_cpu() is at > line 3000.
>

But the master code have this BUG too.

>> set_task_cpu+0x8c/0x108
>> [123671.996800] pstate: 20400009 (nzCv daif +PAN -UAO -TCO BTYPE=--)
>> [123671.996811] pc : set_task_cpu+0x8c/0x108
>> [123671.996820] lr : set_task_cpu+0x7c/0x108
>> [123671.996828] sp : ffff80001268bd30
>> [123671.996832] pmr_save: 00000060
>> [123671.996835] x29: ffff80001268bd30 x28: ffff0001a3d68e80
>> [123671.996844] x27: ffff80001225f4a8 x26: ffff800010ab62cb
>> [123671.996854] x25: ffff80026d95e000 x24: 0000000000000005
>> [123671.996864] x23: ffff00019746c1b0 x22: 0000000000000000
>> [123671.996873] x21: ffff00027ee33a80 x20: 0000000000000000
>> [123671.996882] x19: ffff00019746ba00 x18: 0000000000000000
>> [123671.996890] x17: 0000000000000000 x16: 0000000000000000
>> [123671.996899] x15: 000000000000000a x14: 000000000000349e
>> [123671.996908] x13: ffff800012f4503d x12: 0000000000000001
>> [123671.996916] x11: 0000000000000000 x10: 0000000000000000
>> [123671.996925] x9 : 00000000000c0000 x8 : ffff00027ee58700
>> [123671.996933] x7 : ffff00027ee8da80 x6 : ffff00027ee8e580
>> [123671.996942] x5 : ffff00027ee8dcc0 x4 : 0000000000000005
>> [123671.996951] x3 : ffff00027ee8e338 x2 : 0000000000000000
>> [123671.996959] x1 : 00000000000000ff x0 : 0000000000000002
>> [123671.996969] Call trace:
>> [123671.996975]  set_task_cpu+0x8c/0x108
>> [123671.996984]  push_rt_task.part.0+0x144/0x184
>> [123671.996995]  push_rt_tasks+0x28/0x3c
>> [123671.997002]  task_woken_rt+0x58/0x68
>> [123671.997009]  ttwu_do_wakeup+0x5c/0xd0
>> [123671.997019]  ttwu_do_activate+0xc0/0xd4
>> [123671.997028]  try_to_wake_up+0x244/0x288
>> [123671.997036]  wake_up_process+0x18/0x24
>> [123671.997045]  __irq_wake_thread+0x64/0x80
>> [123671.997056]  __handle_irq_event_percpu+0x110/0x124
>> [123671.997064]  handle_irq_event_percpu+0x50/0xac
>> [123671.997072]  handle_irq_event+0x84/0xfc
>> 
>
> [...]
>
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 8c9ed96648409..7bd3e6ecbe45e 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -1998,11 +1998,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>>  			 * the mean time, task could have
>>  			 * migrated already or had its affinity changed.
>>  			 * Also make sure that it wasn't scheduled on its rq.
>> +			 * It is possible the task was scheduled, set
>> +			 * "migrate_disabled" and then got preempted, so we must
>> +			 * check the task migration disable flag here too.
>>  			 */
>>  			if (unlikely(task_rq(task) != rq ||
>>  				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
>>  				     task_running(rq, task) ||
>>  				     !rt_task(task) ||
>> +				     is_migration_disabled(task) ||
>
> I wonder why this isn't covered by `task_rq(task) != rq` in this condition?
>

It's because thie task is not migrated, it just get scheduled and
calling migrate_disable(); and then got preempted by it's CPU core
before enable migrate_enable(). the task_rq not changed in this
scenarios.

> [...]

-- 
BRs
Schspa Shi
