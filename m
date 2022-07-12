Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A7571CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiGLOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiGLOgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:36:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1E3BA384
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:35:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b2so7409275plx.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=GeUfY6Tn/Q9ioj3wHa1IQnm+34PkJWvBAjhW7FXaij8=;
        b=FFQ3ZoI38S7htoLyXPyrs8plraXqTTr8yHOFDxdU1PsAkwG0XPngF9GF1Tlfqttg2P
         ziAgp5Pz/14MkxsLy8N4uxnR43jNUHndWEuYY93g77XUSGXNs6XbSpEbtMb8eXhjZdzB
         0n3SA8nqrbl5Do5PJsLHI2hkToFAK8s2ZVxiGR1Yfr5xNYQkSV+mJPfZcoPeL17Z6l8D
         iFueEOHC67SJKFNfs1o+sOQsxaiSllwJRMQmmnbFrNFg1/npr4D3nb/hriKURG6xeVPJ
         xNFETLZNqFxxGGEU1++4arL5s1FdE1YlrBFMEsoWMRueYTGjO5RN2t+7two8YBDXw9Yv
         wnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=GeUfY6Tn/Q9ioj3wHa1IQnm+34PkJWvBAjhW7FXaij8=;
        b=F5a5OPXqYHs7Ol0Fkk+fZvFhWXT+ehWzEvE8mlWD1UxDT4Ch9AOluSxBH1is6SkQoU
         i1GxrRUs3cKBo0pZItXxhu0sEBoVC8ECZkDA+0Gux2F8PaT9LTgYkon0TVKoF/x2hQks
         ylPAGvMwzOuGMv+6MyME7lV5R4RnCzC3IHH9hpLgJSe1u+LUCruvgi7w3HNfA6z91I66
         EQSHKvRZTPljoh4hDwRM/oZSuhqUSvetMTC6z4ZJi4H/spP1Q+yb0HdunwlhmohgneB0
         pMev8UA3ZPPDs9ZPbqIzDznq+7NLcy3Ps2QJ5GRNIQk+BWO3pQaHq7kmy4bFrFJX+obG
         i+Zg==
X-Gm-Message-State: AJIora8I1Y5Y+ERA5qGGQhe8K3gKMGbCLeBCxKor0rsaHiKbgtAr31Cp
        R1OL2XXsVjmQ9OQSmTCbo2wAXaECARLymA==
X-Google-Smtp-Source: AGRyM1ujG6w5ps9GriP+SnnUbvp+k2fcL96y5EjeY3XqpOFzffJQt14d+s4va4cHCFiFduFwFdYjpg==
X-Received: by 2002:a17:90b:1c12:b0:1f0:2836:7799 with SMTP id oc18-20020a17090b1c1200b001f028367799mr4821591pjb.139.1657636558973;
        Tue, 12 Jul 2022 07:35:58 -0700 (PDT)
Received: from ArchLinux (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id b13-20020a621b0d000000b005252ab25363sm6878600pfb.206.2022.07.12.07.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:35:58 -0700 (PDT)
References: <20220712013125.623338-1-schspa@gmail.com>
 <20220712013125.623338-2-schspa@gmail.com>
 <20220712102953.02d4a3bd@gandalf.local.home>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] sched/rt: Trying to push current task when
 target disable migrating
Date:   Tue, 12 Jul 2022 22:34:40 +0800
In-reply-to: <20220712102953.02d4a3bd@gandalf.local.home>
Message-ID: <m2fsj6flfk.fsf@gmail.com>
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


Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 12 Jul 2022 09:31:25 +0800
> Schspa Shi <schspa@gmail.com> wrote:
>
>> When the task to push disable migration, retry to push the current
>> running task on this CPU away, instead doing nothing for this migrate
>> disabled task.
>> 
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>> ---
>>  kernel/sched/core.c | 6 +++++-
>>  kernel/sched/rt.c   | 6 ++++++
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index da0bf6fe9ecdc..0b1fefd97d874 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2509,8 +2509,12 @@ int push_cpu_stop(void *arg)
>>  	if (p->sched_class->find_lock_rq)
>>  		lowest_rq = p->sched_class->find_lock_rq(p, rq);
>>  
>> -	if (!lowest_rq)
>> +	if (!lowest_rq) {
>
> Probably should add a comment reminding us that the find_lock() function
> above could have released the rq lock and allow p to schedule and be
> preempted again, and that lowest_rq could be NULL because p now has the
> migrate_disable flag set and not because it could not find the lowest rq.
>

OK, it will be better.

Let me upload a v6 patch for that.

> -- Steve
>
>
>> +		if (unlikely(is_migration_disabled(p)))
>> +			p->migration_flags |= MDF_PUSH;
>> +
>>  		goto out_unlock;
>> +	}
>>  
>>  	// XXX validate p is still the highest prio task
>>  	if (task_rq(p) == rq) {
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 7c32ba51b6d85..877380e465b7a 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -2136,6 +2136,12 @@ static int push_rt_task(struct rq *rq, bool pull)
>>  		 */
>>  		task = pick_next_pushable_task(rq);
>>  		if (task == next_task) {
>> +			/*
>> +			 * If next task has now disabled migrating, see if we
>> +			 * can push the current task.
>> +			 */
>> +			if (unlikely(is_migration_disabled(task)))
>> +				goto retry;
>>  			/*
>>  			 * The task hasn't migrated, and is still the next
>>  			 * eligible task, but we failed to find a run-queue


-- 
BRs
Schspa Shi
