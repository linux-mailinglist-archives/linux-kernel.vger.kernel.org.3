Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B455A3E8F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 18:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiH1Q2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 12:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiH1Q0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 12:26:22 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEB213F7B
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 09:26:21 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r22so5704622pgm.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=8C0bJbQzCEFFcfsrWxI0t7BFjtp2DVljC6JXCFj30lQ=;
        b=U9g+XjwM+sAxmgza1T6GKPoRuaTAvqS8wBPXhhhDl1bqMJbhfvvywWM8Nh6xRPi1av
         c8opNN+Vah09BMgYNQ/nunnyCqOMyXAx94RdXOQ0PTXzsdEVTWSpM/+VEQQINbhgRijL
         2qU8G3VCIB7Fgi2nsQqOTHsozTsGKslKBrPt9y3Fwr1vY6bK4kHbVIBm7z6YHouMZZuc
         dCNxLfbq30C/6Own/t7W4we/tyxdo+l7QSfOrgbO0AYYaHFEjJolHdDc8OoT/DDrFNOR
         BRU/z6V/TbiVSXK15o9KtgWCNN2TpEHWl+bLO8EwWDVAvf2nVTaKVas69mZI9YGyXvpu
         H74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=8C0bJbQzCEFFcfsrWxI0t7BFjtp2DVljC6JXCFj30lQ=;
        b=1yucxVlwr4Cd+KtCF1wLtfIXtoipsnLOrgR8/YxQAuAqHZbMH8PgNNtKzVUyRMnqsS
         ntYHrtfoMUnj0eAkh+jCcz+CBb2CCxELrWRYnt4RFRRdKrOU3ZzjulxKBLq4hXBkUr/p
         BaH+AwLkGAyyeeHTuSXVnetT2BpcCdaundXJSREfuyiA7qUkR/mxwT95ZvDaiRyw++T6
         f6Btc9ubUKHtr8G07VXZG2RUgS0ski6DC0nIiHBTUkb77WRdZSE1TM+fe+49Z4J1JAYh
         QOgeI/q7mKJ9mJA8sraDcLiIrnxkd1XAMKIA5hNyih6jt4/aNEfKrdlYA/sQCoDWWwvn
         EeuA==
X-Gm-Message-State: ACgBeo3Cns16XA+XBPHni4/NDOiPmReAy8lUqmJO2NMkhGg5bU/ZITIN
        qlkcIHwIpDNBoBdYIAbW3waaLtzuNmfq6BFi
X-Google-Smtp-Source: AA6agR7rYAuDcg29gLiNycxpFXqp0FffhM2jislbW58raWnHf+EyySRqCvJHySmdx3H9sJWNnIEqMA==
X-Received: by 2002:a63:1018:0:b0:42c:2e12:e79d with SMTP id f24-20020a631018000000b0042c2e12e79dmr322683pgl.508.1661703980773;
        Sun, 28 Aug 2022 09:26:20 -0700 (PDT)
Received: from ArchLinux ([60.177.34.208])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b00174c1855cd9sm695799plh.267.2022.08.28.09.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 09:26:20 -0700 (PDT)
References: <20220713134823.95141-1-schspa@gmail.com>
 <20220713134823.95141-2-schspa@gmail.com>
 <aad1078b-2620-3122-7796-24e2451d36d6@arm.com>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] sched/rt: Trying to push current task when
 target disable migrating
Date:   Sun, 28 Aug 2022 23:54:39 +0800
In-reply-to: <aad1078b-2620-3122-7796-24e2451d36d6@arm.com>
Message-ID: <m2sflgl4gt.fsf@gmail.com>
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

> On 13/07/2022 15:48, Schspa Shi wrote:
>> When the task to push disable migration, retry to push the current
>> running task on this CPU away, instead doing nothing for this migrate
>> disabled task.
>> 
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>
> Unfortunately, I can't recreate this issue on my Arm64 6 CPUs system on
> mainline or PREEMPT_RT (linux-5.19.y-rt and v5.10.59-rt52) (the one you
> mentioned in v6.)
>
> With an rt-app rt workload of 12-18 periodic rt-tasks (4/16ms) all with
> different priorities I never ran into a `is_migration_disabled(task)`
> situation. I only ever get `task_rq(task) != rq` or `task_running(rq,
> task)` under the `if (double_lock_balance(rq, lowest_rq))` condition in
> find_lock_lowest_rq().
>

I think we need to write a kernel module to add more hard irq context to
increase the probability of recurrence.

I never recreate this issue with my test case too. But our test team can
reproduce the problem, they have more machines to reproduce the problem,
and the problem is easier to reproduce when the CPU is hotplugging.


> [...]
>
>>  	// XXX validate p is still the highest prio task
>>  	if (task_rq(p) == rq) {
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index cb3b886a081c..21af20445e7f 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2335,6 +2335,15 @@ static int push_dl_task(struct rq *rq)
>>  		 */
>>  		task = pick_next_pushable_dl_task(rq);
>>  		if (task == next_task) {
>> +			/*
>> +			 * If next task has now disabled migrating, see if we
>> +			 * can push the current task.
>> +			 */
>> +			if (unlikely(is_migration_disabled(task))) {
>> +				put_task_struct(next_task);
>> +				goto retry;
>> +			}
>> +
>
> Looks like for DL this makes no sense since we're not pushing rq->curr
> in `retry:` like for RT in case `is_migration_disabled(next_task)`.
>

It seems we have the opportunity to execute resched_curr, which will
have a similar effect. I should change the comments for this for next
patch version.

> [...]
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

-- 
BRs
Schspa Shi
