Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861CA5A3E7B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 17:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiH1PwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 11:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiH1PwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 11:52:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278ED33A19
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:52:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l5so1937220pjy.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=fyrhEX2c+2yKdkwylVgFaW99TKMlRY3otAv+qisW+uM=;
        b=J5yJfQJdK4a2oc6f205FKqczIVaAjSeMOq8dyBaJ1ucmL+2UbdeeW+f6X22YySEDgh
         4tJ7ejmZDyoAhZ/v+CEsiVYK035Erf9zBDJqb6DFPDon9Tl1QMPLMr97dQkPjg7EYVxo
         O6kQhO1Vvc0WUpUSLZokzkW/o7OFwwUGFinkBkm+BTZm/+SwUiIufpqrbChyGILZIkh0
         N/FqegDQLVg61LAMltwjhkd6ATPIY0t/O3IkeWR2LXJq2ixYHXDhWpiD/uytdaWjRlaO
         g1aRmsZ8DYs7ydtXji93NwCy6Dbgp9qXJSZ6k/GkH/JZXAOnya5NVOK85um940q9+jlO
         2NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=fyrhEX2c+2yKdkwylVgFaW99TKMlRY3otAv+qisW+uM=;
        b=f14gEVFqJlHKAnhpKJgGuHRZCinpVCMLHP2VsC7TYeWR8D21kws90JBKyGauCEqO88
         s9AxkpWegO5xMggtA9s8Dfyvm74Kub0GJJFjHFHtDzeObdXpQQa8EM2lk3b4JBWURLPE
         zQH3iKh6ioRz5Fg9iIOy4Sq7Q6N6+6MWAAQkwhyywvnNA00kTF3gCP2bg2CbZqcmcPvn
         LttZLF5SZ8AuyQNJ7ugz5nqRHi+fsQSa4wExUTpDGXiSIo5eEJGh7xJS31158YaK6DCs
         FhRw9UhQDPSRr1h8uTX7475oXc+l5oyqVboTfOtA3p8RhElrRVAdOMVv0zj/I3oH9X2B
         IUsg==
X-Gm-Message-State: ACgBeo1EvPTMNO5MHzM+LrnupL5r2YiaMVIcRc/+naycitZ3GGN+vm9G
        1o+ggJ+sSZyhHlccVIedYjI2iBhLwDBdDrQu
X-Google-Smtp-Source: AA6agR5KEW09gHHZD01gGt1Cryz2kyUWO4ANK42zDAZVd28xyUKcSafbXmlTRQinWOyVWIvKuOqmLQ==
X-Received: by 2002:a17:902:d58b:b0:174:b336:bf0c with SMTP id k11-20020a170902d58b00b00174b336bf0cmr2032551plh.29.1661701927346;
        Sun, 28 Aug 2022 08:52:07 -0700 (PDT)
Received: from ArchLinux ([60.177.34.208])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a348700b001f260b1954bsm4996191pjb.13.2022.08.28.08.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 08:52:06 -0700 (PDT)
References: <20220713134823.95141-1-schspa@gmail.com>
 <43de1f15-42cf-45ea-db5c-30de976a6828@arm.com>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] sched/rt: fix bad task migration for rt tasks
Date:   Sun, 28 Aug 2022 23:45:38 +0800
In-reply-to: <43de1f15-42cf-45ea-db5c-30de976a6828@arm.com>
Message-ID: <m24jxwnz6u.fsf@gmail.com>
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
>> Commit 95158a89dd50 ("sched,rt: Use the full cpumask for balancing")
>> allow find_lock_lowest_rq to pick a task with migration disabled.
>> This commit is intended to push the current running task on this CPU
>> away.
>> 
>> There is a race scenario, which allows a migration disabled task to
>> be migrated to another CPU.
>> 
>> When there is a RT task with higher priority, rt sched class was
>> intended to migrate higher priority task to lowest rq via push_rt_tasks,
>> this BUG will happen here.
>        ^^^
>
> You mean the warning in set_task_cpu()?
>

Yes, this is the warning in set_task_cpu()?

void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
{
#ifdef CONFIG_SCHED_DEBUG
	...
	WARN_ON_ONCE(is_migration_disabled(p));
#endif
	...
}

>> With the system running on PREEMPT_RT, rt_spin_lock will disable
>> migration, this will make the problem easier to reproduce.
>> 
>> I have seen this crash on PREEMPT_RT, from the logs, there is a race
>                    ^^^^^
>                      ?
>
> We still talking about the set_task_cpu() warning, right?
>

Yes.

> [...]
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> You should carry the Reviewed-by:'s you got in previous versions.

Thanks for the reminder, I'll pay attention to this next time.

I will upload a new patch version to carry it. and change the BUG in
comment message to WARN.

-- 
BRs
Schspa Shi
