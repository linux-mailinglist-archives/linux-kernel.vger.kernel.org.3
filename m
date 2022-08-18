Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E335981A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbiHRKst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbiHRKsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:48:46 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE187C1C1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:48:45 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 12so1014832pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=UNP6qpNdQsZRLeNzE7376DQlpkdebC2s72vK1V3HknI=;
        b=f+LpZScrSfCNtgyglIYZDBho9yBitI6JQ4TJSm9zFdbt9wrXVhUpuGFHhHVo/EXV2y
         t0yjRID+4BYUBAv/pG0vcs9Q0LaYlZg7tk7Y0fbV5TqIFUpb+TGezoM9+iVbUWZEU7i8
         dCdK17/4Qcd7R3wxxD9zoNwQen+hZhc12g+nzwkOqNrtn3xnvyEJHheNkAnO/T/oPVKY
         5iIgWqPTj//FxnD/Frbe0Aa4wh4HxCYUYjdVDWPJzKDkZGPM+WBtesCbHTKX6i6nSRu9
         BGN2g8C6jb/D9HQjpKEGo9ay+gcSzkhKTKzOMLdCe+lNgu2+hNKZ3t/7BsbI1XcJxe7P
         +XIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=UNP6qpNdQsZRLeNzE7376DQlpkdebC2s72vK1V3HknI=;
        b=U8yA6TTw6kwz05dqLamwE+oyYp9vnDCXVePEqCG5cEZBx7/VGfpc2OaEoGISijFP+A
         NVABHLmbtgPAH4EGVG4gHLjaTFiWAAaxwEyLUbnMke0KY+GXiO8VRlDiM/LUnMcWBU6G
         +Tlypgd+vzoRUS/85UsTfYDHr09RYDwveDyP/NOHuUOMkjp3tHiXRKIdwe4tRcNQQ1wE
         Qx6Y/EPwXfR1l89UN455gx2m2/yFtKZZcs42+sqKZrSOgC3jSPuLijBklGmjxNU9QDTH
         T2/55HJK09/A+i98qrc0Qt8bznwf1k1nAUJKxkBhgeXZ/5JH7gezLax5XE6jB9sphIcG
         w6YA==
X-Gm-Message-State: ACgBeo1ziMoyYqHNqBwm5bBpybBnmH/IQuIZH2XsURej3wawSYqpmmEO
        BXP7k5Qc5JGwsbI4F5XIK/oFLg==
X-Google-Smtp-Source: AA6agR6KS7MnAr6fLbC0w2abq0b2/mN7cJUC1eWVYd5Z53fS1v98N+OnAOIMKgGYC+eTq1RlbhY72g==
X-Received: by 2002:aa7:9390:0:b0:52d:8816:a906 with SMTP id t16-20020aa79390000000b0052d8816a906mr2424742pfe.63.1660819724610;
        Thu, 18 Aug 2022 03:48:44 -0700 (PDT)
Received: from [10.70.253.98] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709027fcf00b0016d5428f041sm1076189plb.199.2022.08.18.03.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 03:48:44 -0700 (PDT)
Message-ID: <6eefe729-2323-d9a1-9903-547e2fc63ab8@bytedance.com>
Date:   Thu, 18 Aug 2022 18:48:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v5 7/9] sched/fair: allow changing cgroup of new forked
 task
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org, tj@kernel.org
References: <20220818034343.87625-1-zhouchengming@bytedance.com>
 <20220818034343.87625-8-zhouchengming@bytedance.com>
 <Yv4WJQAGw0zgU3nH@worktop.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Yv4WJQAGw0zgU3nH@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/18 18:36, Peter Zijlstra wrote:
> On Thu, Aug 18, 2022 at 11:43:41AM +0800, Chengming Zhou wrote:
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 8e3f1c3f0b2c..157f7461a08a 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4550,11 +4550,11 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>>  {
>>  	__sched_fork(clone_flags, p);
>>  	/*
>> -	 * We mark the process as NEW here. This guarantees that
>> +	 * We mark the process as running here. This guarantees that
>>  	 * nobody will actually run it, and a signal or other external
>>  	 * event cannot wake it up and insert it on the runqueue either.
>>  	 */
>> -	p->__state = TASK_NEW;
>> +	p->__state = TASK_RUNNING;
>>  
>>  	/*
>>  	 * Make sure we do not leak PI boosting priority to the child.
>> @@ -4672,7 +4672,6 @@ void wake_up_new_task(struct task_struct *p)
>>  	struct rq *rq;
>>  
>>  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>> -	WRITE_ONCE(p->__state, TASK_RUNNING);
>>  #ifdef CONFIG_SMP
>>  	/*
>>  	 * Fork balancing, do it here and not earlier because:
>> @@ -10290,36 +10289,19 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
>>  	sched_unregister_group(tg);
>>  }
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index eba8a64f905a..e0d34ecdabae 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11840,6 +11840,13 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>>  static void task_change_group_fair(struct task_struct *p)
>>  {
>> +	/*
>> +	 * We couldn't detach or attach a forked task which
>> +	 * hasn't been woken up by wake_up_new_task().
>> +	 */
>> +	if (!p->on_rq && !p->se.sum_exec_runtime)
>> +		return;
>> +
>>  	detach_task_cfs_rq(p);
> 
> Wouldn't that be much clearer when expressed in TASK_NEW ?

Ah, I was stupid, will change to use TASK_NEW.

Thanks for your suggestion!

