Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFA457B79E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiGTNlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiGTNlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:41:05 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B8B49B71
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:41:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e132so16427406pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qKe9h167RYgDmgLdVVflY53zcuYISuUI/T7O6NAAcQo=;
        b=fEpNyoOJmqPx+KdDKO0aU8SwtybOSy1CQFXNp5twY5elBZZGTGRF9PMWOhqBF2p3ST
         J5xqW+ZEPA+ivJ2Hf6FMMfEmf8S7LdAGn0qmDWs/xxDxoniBbfsfav0xkLizqrkLV1kt
         UX/qaR/y1jPdPPFptdL2ivJa2wXNasOmXyR14T3WZ641sgLlep2kINNCOkD+cnWAsxu/
         pnlMQIMxUkkj/VXwKv2aAUyrDeotFYoTSPwj7hsreshZ8IKXzrEO83HchgYkaewLzB36
         0dzu4ci1qFleOZNNneA8N+2yh/Y3XscPXWFeX3gZZBOSw7RsJRj0ZeoAbBOBXkk+Shj0
         pblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qKe9h167RYgDmgLdVVflY53zcuYISuUI/T7O6NAAcQo=;
        b=DFR3abuolq2ECQlePhfA2qEpH0uVixE2rsO1cB9jRGM2A8rQr6fV+KdfrrFK7LFpXb
         VlGxZu0rR5Z1uSVkaI5w3r1kA9umZ5Y83AVK/FEQjkhXhoouD3rh89r7bssAobmJetVp
         yuG1Qkdzg41mxlrqnxssDHildRHX8IjQgNgc0Upg4zjQHds3qzBh+4OdpePbE1W8qeCt
         2ycXOpbkDeYyWExOwD5vYEGMKK+A0YyP7bF36NTjq/hhgmqNk/oMKCAaWwHA6L18EtoY
         CpSdjrGKZ+Kdfe5XFWDaXxWuih2CxuFjIiJSKrjwtVt0DaxtIMF0Xyytsx/sOiOhpA14
         +E2A==
X-Gm-Message-State: AJIora8qBZDHAyTq+kXivbyXQgBFfGUvMfiKWingdyeasF3t/AriKfTs
        ZQ+IOeoB5yDc/Uyd6ccznVUmWg==
X-Google-Smtp-Source: AGRyM1tUi6jETJCs6pHwnH/XK6Avxt+a6VkWA0CZgkMs3kUa5aR5NFJ2OnvKb2oLVbvOnpf9CK5TNQ==
X-Received: by 2002:a05:6a00:16c7:b0:520:6ede:2539 with SMTP id l7-20020a056a0016c700b005206ede2539mr38729118pfc.46.1658324462145;
        Wed, 20 Jul 2022 06:41:02 -0700 (PDT)
Received: from [10.4.100.137] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id w63-20020a623042000000b0052ab8646500sm13605434pfw.56.2022.07.20.06.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 06:41:01 -0700 (PDT)
Message-ID: <107763fc-7eab-a807-fa15-024178bdf57e@bytedance.com>
Date:   Wed, 20 Jul 2022 21:40:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [External] Re: [PATCH v2 07/10] sched/fair: use update_load_avg()
 to attach/detach entity load_avg
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-8-zhouchengming@bytedance.com>
 <e838ac28-f68e-2282-94d5-616ea3bdf8d0@arm.com>
 <88062fb6-e2fe-cf4e-10b5-7694c4d30941@bytedance.com>
 <CAKfTPtCsd2RkOZoa10SSwKhm0NRzmOphAVNW7_JykqzxqfkSXg@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKfTPtCsd2RkOZoa10SSwKhm0NRzmOphAVNW7_JykqzxqfkSXg@mail.gmail.com>
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

On 2022/7/19 18:29, Vincent Guittot wrote:
> On Fri, 15 Jul 2022 at 18:21, Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2022/7/15 19:18, Dietmar Eggemann wrote:
>>> On 13/07/2022 06:04, Chengming Zhou wrote:
>>>> Since update_load_avg() support DO_ATTACH and DO_DETACH now, we can
>>>> use update_load_avg() to implement attach/detach entity load_avg.
>>>>
>>>> Another advantage of using update_load_avg() is that it will check
>>>> last_update_time before attach or detach, instead of unconditional
>>>> attach/detach in the current code.
>>>>
>>>> This way can avoid some corner problematic cases of load tracking,
>>>> like twice attach problem, detach unattached NEW task problem.
>>>
>>> This explanation is somewhat hard to follow for me. Since both issues
>>> have been fixed already (you mention this further below) you're saying
>>> that with you change you don't reintroduce them?
>>
>> Sorry for this not very clear explanation.
>>
>> Yes, both issues have been fixed already, what I want to say is that bugfix
>> brings its own problem and limitation mentioned below.
> 
> As Dietmar said, the commit message is misleading because someone can
> think you fix these bugs whereas it's not the case

Hi Vincent, thanks for your review! I will refactor the commit message to avoid
this misleading, sorry for my bad English expression.

> 
>>
>> So I want to use another way to solve these problems better.
>>
>>>
>>>> 1. switch to fair class (twice attach problem)
>>>>
>>>> p->sched_class = fair_class;  --> p.se->avg.last_update_time = 0
>>>> if (queued)
>>>>   enqueue_task(p);
>>>>     ...
>>>>       enqueue_entity()
>>>>         update_load_avg(UPDATE_TG | DO_ATTACH)
>>>>           if (!se->avg.last_update_time && (flags & DO_ATTACH))  --> true
>>>>             attach_entity_load_avg()  --> attached, will set last_update_time
>>>> check_class_changed()
>>>>   switched_from() (!fair)
>>>>   switched_to()   (fair)
>>>>     switched_to_fair()
>>>>       attach_entity_load_avg()  --> unconditional attach again!
>>>>
>>>> 2. change cgroup of NEW task (detach unattached task problem)
>>>>
>>>> sched_move_group(p)
>>>>   if (queued)
>>>>     dequeue_task()
>>>>   task_move_group_fair()
>>>>     detach_task_cfs_rq()
>>>>       detach_entity_load_avg()  --> detach unattached NEW task
>>>>     set_task_rq()
>>>>     attach_task_cfs_rq()
>>>>       attach_entity_load_avg()
>>>>   if (queued)
>>>>     enqueue_task()
>>>>
>>>> These problems have been fixed in commit 7dc603c9028e
>>>> ("sched/fair: Fix PELT integrity for new tasks"), which also
>>>> bring its own problems.
>>>>
>>>> First, it add a new task state TASK_NEW and an unnessary limitation
>>>> that we would fail when change the cgroup of TASK_NEW tasks.
>>
>> This is the limitation that bugfix has brought.
>>
>> We can't change cgroup or switch to fair for task with last_update_time=0
>> if we don't have conditional detach/attach.
>>
>> So we have to:
>>
>> 1. !fair task also need to set last_update_time.
>> 2. cpu_cgroup_can_attach() have to wait for TASK_NEW to fully attached.
>>
>>>>
>>>> Second, it attach entity load_avg in post_init_entity_util_avg(),
>>>> in which we only set sched_avg last_update_time for !fair tasks,
>>>> will cause PELT integrity problem when switched_to_fair().
>>>
>>> I guess those PELT integrity problems are less severe since we have the
>>> enqueue_task_fair() before the switched_to_fair() for enqueued tasks. So
>>> we always decay the time the task spend outside fair.
>>
>> enqueue_task_fair()
>>   enqueue_entity()
>>     update_load_avg()
>>       if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))  --> true
>>         __update_load_avg_se(now, cfs_rq, se);  --> (1)
>>
>> We can see above, for queued !fair task, (1) will deay the delta time
>> (now - se.avg.last_update_time) even for a NEW !fair task.
>>
>>>
>>> Looks to me that you want to replace this by your `freeze PELT when
>>> outside fair` model.
>>
>> Yes, want to freeze PELT for two !fair cases:
>>
>> 1. !fair task hasn't been fair before: will still have its init load_avg
>>    when switch to fair.
> 
> But I'm not sure it makes sense to keep these init values. As an
> example, the util_avg is set according to the cpu utilization at the
> time of the task creation. I would tend to decay them as these init
> values become less and less relevant.
> 
> so we should return early in post_init_entity_util_avg() and don't set
> util_avg if sched class is not cfs

Yes, this indeed is a problem if we attach this init sched_avg of !fair task.
I'm also not sure whether it make sense to keep them to 0 ? Will it cause
unfairness problem between cfs_rqs?

> 
>>
>> 2. !fair task has been switched_from_fair(): will still keep its lastest
>>    load_avg when switch to fair.
>>
>>>
>>>> This patch make update_load_avg() the only location of attach/detach,
>>>> and can handle these corner cases like change cgroup of NEW tasks,
>>>> by checking last_update_time before attach/detach.
>>>
>>> [...]
>>>
>>>> @@ -11527,9 +11522,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
>>>>      struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>>
>>>>      /* Catch up with the cfs_rq and remove our load when we leave */
>>>> -    update_load_avg(cfs_rq, se, 0);
>>>> -    detach_entity_load_avg(cfs_rq, se);
>>>> -    update_tg_load_avg(cfs_rq);
>>>> +    update_load_avg(cfs_rq, se, UPDATE_TG | DO_DETACH);
>>>
>>> IMHO, the DO_[DE|AT]TACH comments in update_load_avg() would have to be
>>> updated in this case.
>>
>> Correct, will do.
>>
>> Thanks.
>>
>>>
>>> [...]
