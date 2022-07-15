Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AF1576532
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiGOQV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGOQVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:21:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB4E6EEAA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:21:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o15so6092668pjh.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6GrLS/v/mfBqbOvGDktGZkoGmn9hNwjxPNaIK3oKp8A=;
        b=4g+Uiw6VuhSzOvC0y2K3h8Q+YnMl3dB1+Rpt7zfLKr+TWdz/X0mJKlVjUID/cdHKdI
         BuPVTobzgZGHbLvu3wWx5Sx+0W9mLI0pkK8oj7WMcsAqC0RTMl5QNHdOYfppScY6StGZ
         dg0+GBLE5KcobBk+oCu370Ue5mW2HS3CXs7VG3FC8xKFjjeML9v7VevJ6uGO4ydAyGqZ
         Ozjy4v/qEwfoE7xph9piyelUNf7ZuUwOj1XeLVD4MqB/JwMauEbgJWY9kQlOYj2btTwB
         rPuZ3Yz6KUPVe7SvNTicWDu5JCVPQBAEhPTMnXzLg4gjtpVP7VlIEz9gzU/ZvwXPb/vq
         qCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6GrLS/v/mfBqbOvGDktGZkoGmn9hNwjxPNaIK3oKp8A=;
        b=2mzdsAXlVz/kWvDjsy4e70spv7lMzrfPviTrFL+tyYmo3hw/pT6QubTFGo4lWUpENO
         X9yMZC3wDxmdFuNAwrRCFQ8GOYxbdOZfrK0Gjz9YwH0DzXQ75MV09VxDzsras8wTSxjQ
         uFE0tO87BQmyThD8dboHWNbw2YPuLnNZLQLE0MwWzowRBpU0/RHJjxDZmFa2xC8EHMeo
         W926BkaZ+IHpXGsvEgE/jctPHb6tIOP8papcMwSZrbmP1SLj8UZjA3OuILLjB8q94wXr
         uAkPLwqS9q3j9MuRwxSWS9+1/T90lex1H5ffEHbydu6Trlnh0plj/8liDjDk9yF/gGP7
         4dSw==
X-Gm-Message-State: AJIora+ESzYLOkGL2hxoefGQ6LqPmpt+9nR4nVAQJ5NUzjLTV5Zpiv/l
        7Ul3paNBc01XhmErZiIcC4Zas/qBZeTrKjhf
X-Google-Smtp-Source: AGRyM1t+ku27pWB2PMTzHHmQazYUeerAutMF3sBGOExhghCXEjfLZAWeL+znUfymYkKFKQpgCbJGkg==
X-Received: by 2002:a17:90b:1c0b:b0:1f0:23df:5406 with SMTP id oc11-20020a17090b1c0b00b001f023df5406mr16907593pjb.157.1657902111778;
        Fri, 15 Jul 2022 09:21:51 -0700 (PDT)
Received: from [10.255.246.141] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id o90-20020a17090a0a6300b001f0cece9285sm3399995pjo.18.2022.07.15.09.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 09:21:51 -0700 (PDT)
Message-ID: <88062fb6-e2fe-cf4e-10b5-7694c4d30941@bytedance.com>
Date:   Sat, 16 Jul 2022 00:21:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [External] Re: [PATCH v2 07/10] sched/fair: use update_load_avg()
 to attach/detach entity load_avg
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-8-zhouchengming@bytedance.com>
 <e838ac28-f68e-2282-94d5-616ea3bdf8d0@arm.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <e838ac28-f68e-2282-94d5-616ea3bdf8d0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/15 19:18, Dietmar Eggemann wrote:
> On 13/07/2022 06:04, Chengming Zhou wrote:
>> Since update_load_avg() support DO_ATTACH and DO_DETACH now, we can
>> use update_load_avg() to implement attach/detach entity load_avg.
>>
>> Another advantage of using update_load_avg() is that it will check
>> last_update_time before attach or detach, instead of unconditional
>> attach/detach in the current code.
>>
>> This way can avoid some corner problematic cases of load tracking,
>> like twice attach problem, detach unattached NEW task problem.
> 
> This explanation is somewhat hard to follow for me. Since both issues
> have been fixed already (you mention this further below) you're saying
> that with you change you don't reintroduce them?

Sorry for this not very clear explanation.

Yes, both issues have been fixed already, what I want to say is that bugfix
brings its own problem and limitation mentioned below.

So I want to use another way to solve these problems better.

> 
>> 1. switch to fair class (twice attach problem)
>>
>> p->sched_class = fair_class;  --> p.se->avg.last_update_time = 0
>> if (queued)
>>   enqueue_task(p);
>>     ...
>>       enqueue_entity()
>>         update_load_avg(UPDATE_TG | DO_ATTACH)
>>           if (!se->avg.last_update_time && (flags & DO_ATTACH))  --> true
>>             attach_entity_load_avg()  --> attached, will set last_update_time
>> check_class_changed()
>>   switched_from() (!fair)
>>   switched_to()   (fair)
>>     switched_to_fair()
>>       attach_entity_load_avg()  --> unconditional attach again!
>>
>> 2. change cgroup of NEW task (detach unattached task problem)
>>
>> sched_move_group(p)
>>   if (queued)
>>     dequeue_task()
>>   task_move_group_fair()
>>     detach_task_cfs_rq()
>>       detach_entity_load_avg()  --> detach unattached NEW task
>>     set_task_rq()
>>     attach_task_cfs_rq()
>>       attach_entity_load_avg()
>>   if (queued)
>>     enqueue_task()
>>
>> These problems have been fixed in commit 7dc603c9028e
>> ("sched/fair: Fix PELT integrity for new tasks"), which also
>> bring its own problems.
>>
>> First, it add a new task state TASK_NEW and an unnessary limitation
>> that we would fail when change the cgroup of TASK_NEW tasks.

This is the limitation that bugfix has brought.

We can't change cgroup or switch to fair for task with last_update_time=0
if we don't have conditional detach/attach.

So we have to:

1. !fair task also need to set last_update_time.
2. cpu_cgroup_can_attach() have to wait for TASK_NEW to fully attached.

>>
>> Second, it attach entity load_avg in post_init_entity_util_avg(),
>> in which we only set sched_avg last_update_time for !fair tasks,
>> will cause PELT integrity problem when switched_to_fair().
> 
> I guess those PELT integrity problems are less severe since we have the
> enqueue_task_fair() before the switched_to_fair() for enqueued tasks. So
> we always decay the time the task spend outside fair.

enqueue_task_fair()
  enqueue_entity()
    update_load_avg()
      if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))  --> true
        __update_load_avg_se(now, cfs_rq, se);  --> (1)

We can see above, for queued !fair task, (1) will deay the delta time
(now - se.avg.last_update_time) even for a NEW !fair task.

> 
> Looks to me that you want to replace this by your `freeze PELT when
> outside fair` model.

Yes, want to freeze PELT for two !fair cases:

1. !fair task hasn't been fair before: will still have its init load_avg
   when switch to fair.

2. !fair task has been switched_from_fair(): will still keep its lastest
   load_avg when switch to fair.

> 
>> This patch make update_load_avg() the only location of attach/detach,
>> and can handle these corner cases like change cgroup of NEW tasks,
>> by checking last_update_time before attach/detach.
> 
> [...]
> 
>> @@ -11527,9 +11522,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
>>  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>  
>>  	/* Catch up with the cfs_rq and remove our load when we leave */
>> -	update_load_avg(cfs_rq, se, 0);
>> -	detach_entity_load_avg(cfs_rq, se);
>> -	update_tg_load_avg(cfs_rq);
>> +	update_load_avg(cfs_rq, se, UPDATE_TG | DO_DETACH);
> 
> IMHO, the DO_[DE|AT]TACH comments in update_load_avg() would have to be
> updated in this case.

Correct, will do.

Thanks.

> 
> [...]
