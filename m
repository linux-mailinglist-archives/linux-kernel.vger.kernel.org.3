Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B03F564FC7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiGDIdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiGDIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:33:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C63CB49A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:33:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3998623A;
        Mon,  4 Jul 2022 01:33:08 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0324D3F792;
        Mon,  4 Jul 2022 01:33:05 -0700 (PDT)
Message-ID: <24c63730-2d6a-de14-57ca-919870b64323@arm.com>
Date:   Mon, 4 Jul 2022 10:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] sched: fix rq lock recursion issue
Content-Language: en-US
To:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220624074240.13108-1-quic_satyap@quicinc.com>
 <20220630215310.wb3kab72tlh5pq2g@airbuntu>
 <Yr6xPWOReXNuDQqh@worktop.programming.kicks-ass.net>
 <20220701114846.42o2tkm5fqt325df@wubuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220701114846.42o2tkm5fqt325df@wubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2022 13:48, Qais Yousef wrote:
> On 07/01/22 10:33, Peter Zijlstra wrote:
>> On Thu, Jun 30, 2022 at 10:53:10PM +0100, Qais Yousef wrote:
>>> Hi Satya
>>>
>>> On 06/24/22 00:42, Satya Durga Srinivasu Prabhala wrote:
>>>> Below recursion is observed in a rare scenario where __schedule()
>>>> takes rq lock, at around same time task's affinity is being changed,
>>>> bpf function for tracing sched_switch calls migrate_enabled(),
>>>> checks for affinity change (cpus_ptr != cpus_mask) lands into
>>>> __set_cpus_allowed_ptr which tries acquire rq lock and causing the
>>>> recursion bug.
>>>>
>>>> Fix the issue by switching to preempt_enable/disable() for non-RT
>>>> Kernels.
>>>
>>> Interesting bug. Thanks for the report. Unfortunately I can't see this being
>>> a fix as it just limits the bug visibility to PREEMPT_RT kernels, but won't fix
>>> anything, no? ie: Kernels compiled with PREEMPT_RT will still hit this failure.
>>
>> Worse, there's !RT stuff that grew to rely on the preemptible migrate
>> disable stuff, so this actively breaks things.
>>
>>> I'm curious how the race with set affinity is happening. I would have thought
>>> user space would get blocked as __schedule() will hold the rq lock.
>>>
>>> Do you have more details on that?
>>
>> Yeah, I'm not seeing how this works either, in order for
>> migrate_enable() to actually call __set_cpus_allowed_ptr(), it needs to
>> have done migrate_disable() *before* schedule, schedule() will then have
>> to call migrate_disable_swich(), and *then* migrate_enable() does this.
>>
>> However, if things are nicely balanced (as they should be), then
>> trace_call_bpf() using migrate_disable()/migrate_enable() should never
>> hit this path.
>>
>> If, OTOH, migrate_disable() was called prior to schedule() and we did do
>> migrate_disable_switch(), then it should be impossible for the
>> tracepoint/bpf stuff to reach p->migration_disabled == 0.
> 
> I think it's worth to confirm which kernel Satya is on too. If it's GKI, then
> worth checking first this is actually reproducible on/applicable to mainline.

Satya, do you still have these lines from your spin_dump() output showing
current, the kernel version and the hardware? Or a way to recreate this?
I couldn't provoke it so far.

...
[  212.196452] BUG: spinlock recursion on CPU#4, bpftrace/1662
                                                 ^^^^^^^^^^^^^       
[  212.196473]  lock: 0xffff00097ef7f500, .magic: dead4ead, .owner: bpftrace/1662, .owner_cpu: 4
[  212.196500] CPU: 4 PID: 1662 Comm: bpftrace Not tainted 5.19.0-rc2-00018-gb7ce5b6b4622-dirty #96
                                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                             
[  212.196513] Hardware name: ARM Juno development board (r0) (DT)
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^
[  212.196520] Call trace:
...
