Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1EE573320
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiGMJoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiGMJoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:44:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7163F22B2C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:44:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87BA91424;
        Wed, 13 Jul 2022 02:44:08 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AB1F3F792;
        Wed, 13 Jul 2022 02:44:06 -0700 (PDT)
Message-ID: <76169a43-cda0-177a-2b1f-7dcdad900935@arm.com>
Date:   Wed, 13 Jul 2022 11:43:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 1/2] sched/rt: fix bad task migration for rt tasks
Content-Language: en-US
To:     Schspa Shi <schspa@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220712150506.632304-1-schspa@gmail.com>
 <c1db7f31-82e1-eac4-bd49-212859727cb2@arm.com> <m2h73me3nk.fsf@gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <m2h73me3nk.fsf@gmail.com>
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

On 12/07/2022 17:35, Schspa Shi wrote:
> 
> Dietmar Eggemann <dietmar.eggemann@arm.com> writes:
> 
>> On 12/07/2022 17:05, Schspa Shi wrote:

[...]

>> What code-base is this?
> 
> This is the logs from 5.10.59-rt
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> v5.10.59-rt52 (9007b684f615750b0ee4ec57b5e547a4bf4a223e).

Thanks.

>> IMHO, currently this `WARN_ON_ONCE(is_migration_disabled(p))` in
>> set_task_cpu() is at > line 3000.
>>
> 
> But the master code have this BUG too.

I see. It's just that need_to_push in task_woken_rt() triggers
push_rt_tasks() much more often on preempt-rt.

[...]

>>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>>> index 8c9ed96648409..7bd3e6ecbe45e 100644
>>> --- a/kernel/sched/rt.c
>>> +++ b/kernel/sched/rt.c
>>> @@ -1998,11 +1998,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>>>  			 * the mean time, task could have
>>>  			 * migrated already or had its affinity changed.
>>>  			 * Also make sure that it wasn't scheduled on its rq.
>>> +			 * It is possible the task was scheduled, set
>>> +			 * "migrate_disabled" and then got preempted, so we must
>>> +			 * check the task migration disable flag here too.
>>>  			 */
>>>  			if (unlikely(task_rq(task) != rq ||
>>>  				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
>>>  				     task_running(rq, task) ||
>>>  				     !rt_task(task) ||
>>> +				     is_migration_disabled(task) ||
>>
>> I wonder why this isn't covered by `task_rq(task) != rq` in this condition?
>>
> 
> It's because thie task is not migrated, it just get scheduled and
> calling migrate_disable(); and then got preempted by it's CPU core
> before enable migrate_enable(). the task_rq not changed in this
> scenarios.

Yes, get it now. Essentially we need `current CPU (CPU0) != rq->cpu
(CPU1)`. Now I see that you had the discussion with Steven already on v3 ;-)
