Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4215457A291
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiGSPCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiGSPCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:02:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F5CA4D15D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:02:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7409D13D5;
        Tue, 19 Jul 2022 08:02:33 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B14283F70D;
        Tue, 19 Jul 2022 08:02:31 -0700 (PDT)
Message-ID: <17c9af40-bf53-be3c-c678-159a8ab8964a@arm.com>
Date:   Tue, 19 Jul 2022 17:02:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [External] Re: [PATCH v2 07/10] sched/fair: use update_load_avg()
 to attach/detach entity load_avg
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-8-zhouchengming@bytedance.com>
 <e838ac28-f68e-2282-94d5-616ea3bdf8d0@arm.com>
 <88062fb6-e2fe-cf4e-10b5-7694c4d30941@bytedance.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <88062fb6-e2fe-cf4e-10b5-7694c4d30941@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2022 18:21, Chengming Zhou wrote:
> On 2022/7/15 19:18, Dietmar Eggemann wrote:
>> On 13/07/2022 06:04, Chengming Zhou wrote:
>>> Since update_load_avg() support DO_ATTACH and DO_DETACH now, we can
>>> use update_load_avg() to implement attach/detach entity load_avg.
>>>
>>> Another advantage of using update_load_avg() is that it will check
>>> last_update_time before attach or detach, instead of unconditional
>>> attach/detach in the current code.
>>>
>>> This way can avoid some corner problematic cases of load tracking,
>>> like twice attach problem, detach unattached NEW task problem.
>>
>> This explanation is somewhat hard to follow for me. Since both issues
>> have been fixed already (you mention this further below) you're saying
>> that with you change you don't reintroduce them?
> 
> Sorry for this not very clear explanation.
> 
> Yes, both issues have been fixed already, what I want to say is that bugfix
> brings its own problem and limitation mentioned below.
> 
> So I want to use another way to solve these problems better.

[...]

>>> These problems have been fixed in commit 7dc603c9028e
>>> ("sched/fair: Fix PELT integrity for new tasks"), which also
>>> bring its own problems.
>>>
>>> First, it add a new task state TASK_NEW and an unnessary limitation
>>> that we would fail when change the cgroup of TASK_NEW tasks.
> 
> This is the limitation that bugfix has brought.
> 
> We can't change cgroup or switch to fair for task with last_update_time=0
> if we don't have conditional detach/attach.
> 
> So we have to:
> 
> 1. !fair task also need to set last_update_time.
> 2. cpu_cgroup_can_attach() have to wait for TASK_NEW to fully attached.

I see.

`cgroup_migrate_execute() -> cpu_cgroup_[can|]_attach()` has to wait for
`wake_up_new_task() -> WRITE_ONCE(p->__state, TASK_RUNNING)`.

Just to understand this change better: IMHO, this is still the case for
fair tasks, right?

`wake_up_new_task() -> post_init_entity_util_avg() ->
attach_entity_cfs_rq()` has to happen before the fair task can move
between taskgroups in `cgroup_migrate_execute() -> cpu_cgroup_attach()
-> sched_move_task() -> sched_change_group() -> task_change_group_fair()`.

[...]
