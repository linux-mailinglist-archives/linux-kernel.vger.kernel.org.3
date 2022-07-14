Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11DD574F79
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbiGNNnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbiGNNnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:43:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954C06113E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:43:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q5so446070plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l94nKR6tSBLp0ho7DFh344H0EUXKGg0rDvSMIqmKMQk=;
        b=3eEwFZXec5Q3LwPrr+7lNJhZFPUXg1Gz6hzpeAAqR88eoiFLuZKSjNd1ttxg6Ic9Rk
         h+9zi6+9KIFr0NOIvq3Rfxk/tT0gfAyMm3VXjbQE00q8hQktXe6SJYy62PR46tMTv4Ju
         pxPVwwmz+AhIjVEHBqFMKTrWdFi26Td+qseAxaZOF4+TXf36M3MEigmfcjhsTSvusG5U
         cm0XM9PQavZXaxwsS0l25tNeEZ3RDp1eIEe3IksruaBH/4LDElcIATpttSj+7DyL2XMA
         1yIv5wb66ImlJn52wSjpJlBHXjFk6aOch9/kNgeAGUtip4/MtYmpDeWIWnhtvGRK9hZA
         5hrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l94nKR6tSBLp0ho7DFh344H0EUXKGg0rDvSMIqmKMQk=;
        b=zfXnvhbjsYPXPsAtTCQ8elcfKzAeNIpXI0x/xudwCBr06KoTwCGB47WdB+U3AngpzI
         qpuWbp6WFK24A5uaYnKbuTC4S6v90sWKLS+ZCoGili0kpPMk+SNPdlVw2klwRiGJ5unx
         Hi4d0gjAMsGQwG1uxiNyeNPEPRUgckLEq7nYrns/c9vnVxLga15koMy9NRTGEvjpvMD/
         LZATnIFbxrre39ghc/czbLdPdYiMi/XE993wqZni/AyI0HuBd7ek26TkcXT9hyUPX0+J
         NcaN3p7u5MOEiy9GL1VWF3w1TOKW18D8AqaRHvKFsB7kDyK8LL+hpxgwgtvhwsjtTUCy
         5YhQ==
X-Gm-Message-State: AJIora/EzMgNjx8Zsq7IKbDkLAhlQRgDhWT7SBjdbVYW6OpA/N7cowrO
        l+IMGfJwmjlwqpmjOTsaSeB1gQ==
X-Google-Smtp-Source: AGRyM1sjzdPsGBkJricCtr4IbqzTgn/KHGzyVxtVNORZ9L8uLT1ENNZIZH0EC3iAAXFcBmNrSDFAFw==
X-Received: by 2002:a17:902:a418:b0:16c:9ee2:8a02 with SMTP id p24-20020a170902a41800b0016c9ee28a02mr5398240plq.46.1657806199026;
        Thu, 14 Jul 2022 06:43:19 -0700 (PDT)
Received: from [10.255.242.206] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id 186-20020a6214c3000000b0052ae3bcb807sm1653717pfu.188.2022.07.14.06.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 06:43:18 -0700 (PDT)
Message-ID: <fe40bae5-7ec4-d5d2-ffb8-1387300dbbaf@bytedance.com>
Date:   Thu, 14 Jul 2022 21:43:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [External] Re: [PATCH v2 09/10] sched/fair: stop load tracking
 when task switched_from_fair()
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-10-zhouchengming@bytedance.com>
 <27f0675e-8ac3-2200-749f-7290a256e3d9@arm.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <27f0675e-8ac3-2200-749f-7290a256e3d9@arm.com>
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

On 2022/7/14 20:33, Dietmar Eggemann wrote:
> On 13/07/2022 06:04, Chengming Zhou wrote:
>> The same reason as the previous commit, if we don't reset the
>> sched_avg last_update_time to 0, after a while in switched_to_fair():
>>
>> switched_to_fair
>>   attach_task_cfs_rq
>>     attach_entity_cfs_rq
>>       update_load_avg
>>         __update_load_avg_se(now, cfs_rq, se)
>>
>> The delta (now - sa->last_update_time) will wrongly contribute/decay
>> sched_avg depends on the task running/runnable status at that time.
> 
> IMHO, a queued !fair task when switching back to fair will already be
> enqueued (attached) as a fair task in __sched_setscheduler() prior to
> the check_class_changed() call.

Right, this is true for a queued !fair task, it will enqueued (attached) before
check_class_changed().

enqueue_task_fair()
  enqueue_entity()
    update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH)
      if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))  --> true
        __update_load_avg_se(now, cfs_rq, se)  --> (1)
check_class_changed()
  switched_to_fair()
    attach_task_cfs_rq()
      attach_entity_cfs_rq()
        update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD)
          if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))  --> true
            __update_load_avg_se(now, cfs_rq, se)  --> (2)


1. for queued !fair: (1) delta = (now - last_update_time), last_update_time is the time
   when switched_from_fair().

2. for !queued !fair: (2) delta = (now - last_update_time), last_update_time is the time
   when switched_from_fair().

The scenario in the commit message only cover !queued !fair case, I forget the queued !fair
case, their problem is the same.


> 
> I can't see how this will work with your proposed change in using
> last_update_time=0 for fair->!fair->fair class changes?
If we reset last_update_time=0 for !fair task, then:

1. for queued !fair: will not do (1) since the if condition is false.

2. for !queued !fair: will not do (2) since the if condition is false.

Thanks.

> 
>> This patch reset it's sched_avg last_update_time to 0, stop load
>> tracking for !fair task, later in switched_to_fair() ->
>> update_load_avg(), we can use its saved sched_avg.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  kernel/sched/fair.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 50f65a2ede32..576028f5a09e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11552,6 +11552,11 @@ static void attach_task_cfs_rq(struct task_struct *p)
>>  static void switched_from_fair(struct rq *rq, struct task_struct *p)
>>  {
>>  	detach_task_cfs_rq(p);
>> +
>> +#ifdef CONFIG_SMP
>> +	/* Stop load tracking for !fair task */
>> +	p->se.avg.last_update_time = 0;
>> +#endif
>>  }
>>  
>>  static void switched_to_fair(struct rq *rq, struct task_struct *p)
> 
