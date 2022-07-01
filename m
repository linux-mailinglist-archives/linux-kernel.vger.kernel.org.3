Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7029B563362
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiGAMSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbiGAMS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:18:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B412774
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:18:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i1so2938962wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 05:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XkBrLdbExkrMK0Kb9rCuJwrg1QdNLAV6sdPgOxnSw4=;
        b=Tmam4JZy3k0yYs6+v2edS2NIZvmEsbA6R/cZ5QIJBDBoqOf+Wjmgl+3UfR1rLYaLdk
         BlG0fln7K03XCuxOSlNQl5RTTiG+bVT2r6nhlPv6tVIEbJy8BsqXN7aPMPP6afToZumx
         9ZdqGCtmd60+xmib814axqXVCRNxOxJyJOeW4AV5AEHhw46kO+i/WXEpNnTOUPdIBXfB
         XEgk4h9M0CZ1w/p/NeY/mAFxqEQGxm6O/Xe6ctLRrjoptLwiETI2v3VAMu/eBRiIvJQw
         tH3Gg5zcy4RCypSaA24bwZsePixzZGMNn1yijFAjwDL+efiaMH8zGsfcSwaTor9znFX2
         T88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XkBrLdbExkrMK0Kb9rCuJwrg1QdNLAV6sdPgOxnSw4=;
        b=6qu1YNRM3MA+b8yLdQsro/2aHtlJqHX87KXAmATvgl7M3KYao0gSRnpGIVhTJlE+CT
         DdcLS/DOqy6yptaso+j/0mdy7GkoKkRqQxJJmDVlwkAGfRHYghkEVtzbEjS7tE0EnceC
         2Y0opJci3JzhmdloW3Ea78fWf+l3Rdf0cXhtZqjb3KAY3msQ3WZd40SKy7B3I5pomiei
         AcTLzZBEzU1GObb3Eexp0XBCkJ5QhZ98AkoWLPdGgrZoRPm0fCXIipDIENzD7EwNfmjE
         ILdwlnJg6YbC48Tb/4Xt8aez+rCVEa5dEFZZeQ+I9Dx5Qn0JAVXaj9EbXgVtWzwL/9tA
         uyEQ==
X-Gm-Message-State: AJIora+yBYsEkd0Ylyls5fffQDKP8hiQyxIbPwSJf+dZ7U3L6K8Tuzu5
        T6Z8iQogsJvckMdBvpPwvQfPlOWWxFbsePeneWI=
X-Google-Smtp-Source: AGRyM1tlT1R6HcGZ4lGt9xawKuyWa11OJqG1FOOkcs7HzMj04PFcZ+5/Psujd0avoVS4s2qw/BZuPqsBis43cpNl8iY=
X-Received: by 2002:a5d:47c8:0:b0:21d:2295:6a05 with SMTP id
 o8-20020a5d47c8000000b0021d22956a05mr13337594wrc.302.1656677901653; Fri, 01
 Jul 2022 05:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220627154051.92599-1-schspa@gmail.com> <xhsmhh7415e12.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhh7415e12.mognet@vschneid.remote.csb>
From:   Schspa Shi <schspa@gmail.com>
Date:   Fri, 1 Jul 2022 20:18:10 +0800
Message-ID: <CAMA88TrZ-o4W81Yfw9Wcs3ghoxwpeAKtFejtMTt78GNB0tKaSA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/rt: fix bad task migration for rt tasks
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Schneider <vschneid@redhat.com> writes:

> On 27/06/22 23:40, Schspa Shi wrote:
>> @@ -2115,6 +2115,15 @@ static int push_rt_task(struct rq *rq, bool pull)
>>       if (WARN_ON(next_task == rq->curr))
>>               return 0;
>>
>> +    /*
>> +     * It is possible the task has running for a while, we need to check
>> +     * task migration disable flag again. If task migration is disabled,
>> +     * the retry code will retry to push the current running task on this
>> +     * CPU away.
>> +     */
>> +    if (unlikely(is_migration_disabled(next_task)))
>> +            goto retry;
>> +
>
> Can we ever hit this? The previous is_migration_disabled() check is in the
> same rq->lock segment.

Ahh, I'm sorry, I add this to the wrong place, It should be in front of
deactivate_task(rq, next_task, 0);
Sorry for this mistake.

>
> AFAIA this doesn't fix the problem v1 was fixing, which is next_task can
> become migrate_disable() after push_rt_task() goes through
> find_lock_lowest_rq().
>

Something in the following should fix it.

                put_task_struct(next_task);
                next_task = task;
                goto retry;
        }

        if (unlikely(is_migration_disabled(next_task))) {
                put_task_struct(next_task);
                goto retry;
        }

        deactivate_task(rq, next_task, 0);

> For the task to still be in the pushable_tasks list after having made
> itself migration disabled, it must no longer be current, which means we
> enqueued a higher priority RT task, in which case we went through
> set_next_task_rt() so we did rt_queue_push_tasks().

The current task may not have a higher priority, maybe a process of
the same priority preempted the migration disabled task.

In this case, we still have the opportunity to make this migration
disabled task execute faster by migrating the higher priority task
to other CPUs. And this is what the commit
   95158a89dd50 ("sched,rt: Use the full cpumask for balancing")
and
   1beec5b55060 ("sched: Fix migrate_disable() vs rt/dl balancing")
doing.

Considering this, the V1 patch is not the best solution, and I send
this V2 patch (although there is a misplaced bug here).

Or can we ignore this small possibility?

>
> So I think what you had in v1 was actually what we needed.
>

Yes, v1 is the patch I have tested for a week, V2 hasn't done this
long time.


>>       /* We might release rq lock */
>>       get_task_struct(next_task);
>>
>> --
>> 2.24.3 (Apple Git-128)

-- 
Schspa Shi
BRs
