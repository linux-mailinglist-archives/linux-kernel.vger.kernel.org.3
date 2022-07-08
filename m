Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B1956B21C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbiGHFFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiGHFFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:05:00 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A778675AA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 22:04:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y9so8390940pff.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 22:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=zIEl5tMY+9vBsh6WFIJ3m1tpOczyfy8m3a0O0+lcfTs=;
        b=PyfAo3s3EsSZYj4QyvoZaTv3sL8JV0QnFICCqe5AQUAWpJ6ddroW9pc8GJw9tC4Fhm
         dKAGznSzVnwEuwVE2a1my38PC8B9q31YVnB7YxX3TSkc5IT70/3/vmlu1wPeBdF5GyAs
         To5WsmV1LBk+G7DI9esgU9sMpqw3jzxOAJ68SNVse8bJSiC9/kRS9C7zmlLGh2W0VYbt
         JoZKESulrrhjht7CFfNV7iT7//JpPKx0qMg+GZ4CfJJf1BsQnp1n5oahQwnwnaoQY3Jl
         D75BIx8V3jcIksMyYyGGHPbGnbKqfFVHAQ7cFXrOkoFNnCc7SUi8Ve1WF7W3QsavWQly
         zaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=zIEl5tMY+9vBsh6WFIJ3m1tpOczyfy8m3a0O0+lcfTs=;
        b=uYhtIGIVaiWgKvdXCM9fFChLsaEoP+OsSUucURJDaNZuaf3l57PAesPN1Ql5yh4eKe
         etm/5+4YJYL4J+/pGKnb4QcTY1DG6onSDTpQ3gVjHt6nJ0Zf4c5JG7M+ZL6sNfHrK9GD
         1jaD0jYY0Oyk28X/cKC5CSBrybwsuVDOIELDcdcaMuBhGuqlk3UtNL52W7tKXNdf4BgL
         9gp1d/DXsFpu18iLAo/5xegdx6qCcr7fZB/WaJBIfT4fz3r/WGGbCV+mY5RWTvKNsjWR
         dzto+CXDQ20/MiwimcuCqrQlfKKWQuv08LcJ/wSz1fwWh6XWs0rgxQtF3cBb2bmMBQ+Y
         WmPA==
X-Gm-Message-State: AJIora/AzPIdmCoDTx7Muc1+3AuD2lLrI2sMbt9JB6P5oVMTsaMsZfwm
        nZmV/bRvXmmA+LBu2NYt72vx0aqylDPqIQ==
X-Google-Smtp-Source: AGRyM1tCPPrTG9HBvwURrlzqB1NujM4ycF44x72nAoLRZNMmNKIWG3ay3HG1ncxKVShDuJunDpHGZQ==
X-Received: by 2002:a05:6a00:2181:b0:51b:560b:dd30 with SMTP id h1-20020a056a00218100b0051b560bdd30mr2076024pfi.44.1657256698591;
        Thu, 07 Jul 2022 22:04:58 -0700 (PDT)
Received: from MBP ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id oa15-20020a17090b1bcf00b001ef8bf3c29fsm504726pjb.57.2022.07.07.22.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 22:04:57 -0700 (PDT)
References: <20220707165014.77127-1-schspa@gmail.com>
 <20220707135329.08cf74b0@gandalf.local.home>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Schspa Shi <schspa@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: fix bad task migration for rt tasks
Date:   Fri, 08 Jul 2022 12:51:14 +0800
In-reply-to: <20220707135329.08cf74b0@gandalf.local.home>
Message-ID: <m2h73snqja.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
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

> On Fri,  8 Jul 2022 00:50:14 +0800
> Schspa Shi <schspa@gmail.com> wrote:
>
>> Please refer to the following scenarios.
>
> I'm not sure this is what is happening. Do you have a trace to 
> back this up?
>

I don't have a trace. This is inferred from the exception log.

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
>
> Here's the problem I have. next_task is queued on CPU0, 
> (otherwise CPU0
> would not be pushing it). As CPU0 is currently running 
> push_rt_task, how
> did next_task start running to set its migrate_disable flag?

THe next_task wasn't queued on CPU0, it's queued on CPU1 in this
scenarios.

And it's because when task wakup, the rq argument is not the
current running CPU rq, it's next_task's rq
(i.e. CPU1's rq in this sample scenarios).

And you can check this with the Call trace from the crash log.

    [123671.996969] Call trace:
    [123671.996975]  set_task_cpu+0x8c/0x108
    [123671.996984]  push_rt_task.part.0+0x144/0x184
    [123671.996995]  push_rt_tasks+0x28/0x3c
    [123671.997002]  task_woken_rt+0x58/0x68
    [123671.997009]  ttwu_do_wakeup+0x5c/0xd0
    [123671.997019]  ttwu_do_activate+0xc0/0xd4
    [123671.997028]  try_to_wake_up+0x244/0x288
    [123671.997036]  wake_up_process+0x18/0x24
    [123671.997045]  __irq_wake_thread+0x64/0x80
    [123671.997056]  __handle_irq_event_percpu+0x110/0x124

Function ttwu_do_wakeup will lock the task's rq, not current 
running
cpu rq.

>
> Even if it was woken up on another CPU and ran there, by setting
> migrate_disable, it would not be put back to CPU0, because its
> migrate_disable flag is set (if it is, then there's the bug).
>

It no needs to put it back to CPU0 for this issue, it's still on 
CPU1.

> After releasing the rq lock and retaking it, we check that the 
> next_task is
> still the next task on CPU0 to push.
>
>
>>                                         task become running
>>                                         migrate_disable();
>>                                           <context out>
>>   deactivate_task(rq, next_task, 0);
>>   set_task_cpu(next_task, lowest_rq->cpu);
>>     WARN_ON_ONCE(is_migration_disabled(p));
>>       ---------OOPS-------------
>
> I don't see how this can happen.
>
> -- Steve

-- 
BRs
Schspa Shi
