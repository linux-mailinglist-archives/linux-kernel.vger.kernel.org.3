Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AED57CCC0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiGUN4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGUN4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:56:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCE418B1A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:56:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d7so1874052plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kAP2SBk42D4uaxvGZu+TFcwqKnU7hQWu1FF7205bWk4=;
        b=Bs1I43g8APEuqfWK3Lt2auFA5pkva6Zc82Je4rpDAjkcUsiPt6amnuT9QT23QrkXhv
         +WsQS6Kde6kOF4SjReZyRpxj3rtqXTvZSaFDj6qS79GLF4Fi1nReYDZEPgIZG96Qvm4L
         ZFjdGLCN/PGIK6ok5WXgWdeW0+TM2286i4F4iTZaYOMAj6B+Ti01v2JkR/VyqhwdFIej
         YDBd7eMABIIZ8GD4q9i60M+RHuN7sqclTlb82vAp4gVdW7MZ1pSfJOpcixKe8qsWWroG
         zX+nzjk7SRK62N2Q/vwwya2FdBZIC4On+83qA3DvIkqid0be6mExM4LIojxFBihe2jAT
         qzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kAP2SBk42D4uaxvGZu+TFcwqKnU7hQWu1FF7205bWk4=;
        b=xk6nouXz4txj42xJb8d91H+DolJlENGRQmfoQpiCS/IXPI5GAJGZ7exvX4hwoxJXGn
         C+yGT/kREWUXGXqDAd1Idyu/EZGVBSrC7PHpVOoc3j0L7Wp95SHHWPpEUphlSQBwPhbw
         drbmqTqLLyCH42i3bAg5oled61GkYCeOdZpq4O6aZUbMxjt4iVrWDAiE0Ar4J450bj01
         laVvZlWAh2ljH2menPFzqXYTJEmvR7sy1hOtaT/mKnrO+kn6Z8K5xoQrfvOycaBi2hgX
         3WSpKaZGF4QeAl8ahoJTef4DAehCTPAcMqzl9jRrHUFAFk5f090bPnopzKBQHfxNpchs
         DAUA==
X-Gm-Message-State: AJIora+Gh7ibtjTGLz4327S/oIyhYI0Va/CKLRjDcGZfEDztIM6XN2Lq
        GcQ1/VGejZoOFH6V/MrtKOCy9Q==
X-Google-Smtp-Source: AGRyM1vFJnVKkmZoFDLh8byAtiK0Kz0JPkFdhRGPioPDqNFYy8KABq/yI1hiqLzenN32g7I1mEy/5A==
X-Received: by 2002:a17:902:760f:b0:16c:ae59:c9b2 with SMTP id k15-20020a170902760f00b0016cae59c9b2mr38346424pll.0.1658411771121;
        Thu, 21 Jul 2022 06:56:11 -0700 (PDT)
Received: from [10.254.44.13] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id g200-20020a6252d1000000b0052521fd273fsm1785908pfb.218.2022.07.21.06.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 06:56:10 -0700 (PDT)
Message-ID: <3cc8def4-54ef-9ca5-7da9-eaa38ad9bd4c@bytedance.com>
Date:   Thu, 21 Jul 2022 21:56:05 +0800
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
 <107763fc-7eab-a807-fa15-024178bdf57e@bytedance.com>
 <CAKfTPtBo9GgkT1VeVA+1CBhiVZ8Vf+kp0XV3PWcBLGuZaz_hKQ@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKfTPtBo9GgkT1VeVA+1CBhiVZ8Vf+kp0XV3PWcBLGuZaz_hKQ@mail.gmail.com>
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

On 2022/7/20 23:34, Vincent Guittot wrote:
> On Wed, 20 Jul 2022 at 15:41, Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2022/7/19 18:29, Vincent Guittot wrote:
>>> On Fri, 15 Jul 2022 at 18:21, Chengming Zhou
>>> <zhouchengming@bytedance.com> wrote:
>>>>
> 
> ...
> 
>>>>
>>>>>
>>>>> Looks to me that you want to replace this by your `freeze PELT when
>>>>> outside fair` model.
>>>>
>>>> Yes, want to freeze PELT for two !fair cases:
>>>>
>>>> 1. !fair task hasn't been fair before: will still have its init load_avg
>>>>    when switch to fair.
>>>
>>> But I'm not sure it makes sense to keep these init values. As an
>>> example, the util_avg is set according to the cpu utilization at the
>>> time of the task creation. I would tend to decay them as these init
>>> values become less and less relevant.
>>>
>>> so we should return early in post_init_entity_util_avg() and don't set
>>> util_avg if sched class is not cfs
>>
>> Yes, this indeed is a problem if we attach this init sched_avg of !fair task.
>> I'm also not sure whether it make sense to keep them to 0 ? Will it cause
>> unfairness problem between cfs_rqs?
> 
> Why should it cause an unfairness problem ? !fair tasks are not
> accounted and their pelt values will be decayed down to 0 after 320ms
> anyway (with the current implementation). So it's just like if you
> started directly after those 320ms

Thanks for your patient explain. IMHO, I am thinking if we have init sched_avg
for new fair task (A), but have 0 for new task switched from !fair (B). Then
what's the point of init sched_avg for the fair task?

The B task will need some time to reach its stable load value, so in this process
its cfs_rq may can't get enough shares? Imaging below scenario, if we have fair
task A and switched from !fair task B at the same time, could cause unfairness
between cfs0 and cfs1 ?

CPU0   tg   CPU1
  |  /    \  |
  | /      \ |
cfs0        cfs1
 (A)         (B)

If runnable_avg and util_avg are 0 when switched from !fair, so we need more time
to do load balance or CPU frequency adjust? I think it's the reason why we have
init sched_avg for new fair task. Should we care about these, or it will be no problem?

I'm not sure, I must have missed something :-)

Thanks!

> 
>>
>>>
>>>>
>>>> 2. !fair task has been switched_from_fair(): will still keep its lastest
>>>>    load_avg when switch to fair.
>>>>
>>>>>
>>>>>> This patch make update_load_avg() the only location of attach/detach,
>>>>>> and can handle these corner cases like change cgroup of NEW tasks,
>>>>>> by checking last_update_time before attach/detach.
>>>>>
>>>>> [...]
>>>>>
>>>>>> @@ -11527,9 +11522,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
>>>>>>      struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>>>>
>>>>>>      /* Catch up with the cfs_rq and remove our load when we leave */
>>>>>> -    update_load_avg(cfs_rq, se, 0);
>>>>>> -    detach_entity_load_avg(cfs_rq, se);
>>>>>> -    update_tg_load_avg(cfs_rq);
>>>>>> +    update_load_avg(cfs_rq, se, UPDATE_TG | DO_DETACH);
>>>>>
>>>>> IMHO, the DO_[DE|AT]TACH comments in update_load_avg() would have to be
>>>>> updated in this case.
>>>>
>>>> Correct, will do.
>>>>
>>>> Thanks.
>>>>
>>>>>
>>>>> [...]
