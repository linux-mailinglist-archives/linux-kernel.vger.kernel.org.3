Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361CF53268C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiEXJfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbiEXJfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:35:20 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C17D606CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:35:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b135so4223012pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i7mX11paoe8KQiB8/BmKUAf5kIxDrUue15kzrfwRC2k=;
        b=HjHRXQ4BZOv6gVz4QeXlakKL5TVRfpF00e39xfHmX5BjkGm1xZhcdcZBq7wrRFu2zn
         C0PZfP+dUrnoP7eL/Wj2TCrx0Ehb/CtF9F4TDXkAtIJR/Uz4+Z+C0adGimj8s4VeFJAT
         xbK4FuPgCBgMnqhamxRn4X/anCJQBKY0zIEKZnLeTDE9Xut8rXSGN+vHlzrkbKFFQ7pk
         UHE72+/NrhBtI2j586Ru6Z7dXAiPFiXUKFT5a1yAVgxZRx05vu8Alx9nWk73xnpdyKLv
         znbcHCW2hYkYymIGGtPVUVsUqyYkWCYMF9AIY4s0CXmKBJmBkhVSy1kw0D05UlLXvNt9
         52Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i7mX11paoe8KQiB8/BmKUAf5kIxDrUue15kzrfwRC2k=;
        b=03f9jZZPOlB99PGwlBD+g5ftyctNgNcZxix9tWsqwXh+bVf7QeRBP7SyjvKu0CabrU
         CRFxvFrRJvq1CyYbiksg/8ICAQfTb/ibaA0fe3mmenKYJ0vcOp3bALrLpcLZxJIztkdj
         v48Z6cT1NHjy4uJRKi0wrutoVNBFIR6J1W2V8gnCXrbiLPX6tUJYiwlraMJRSjoJXbpH
         dJ9pnRKhV/ZDNjxdu/8wbk2LmHH5FEw8EyMiGx8euiIGa0kjSizw4n3wJ47xtHBJCAvv
         ylSJM4WKUWHZW7DCcuSKzV57BcOFOLNw3Gzd80VTkioMdp3WB7qrLmZoXBEsVfQ2l82L
         ydxw==
X-Gm-Message-State: AOAM530B29isQzced0rbMaHhI0Z5sx1n6ByzmkE9yFpXDdsMMsLI9BWs
        vg4mIHYjqHVz+DmPupAJb34wiA==
X-Google-Smtp-Source: ABdhPJzoZcjXzKQlDFIKTJ0rGKhHBSJ09bp5Mi9i9I0jE8fu7Znwe6MGpSY2SlwrMt/93b3SrClLjg==
X-Received: by 2002:a65:6e42:0:b0:3f2:78fd:da9b with SMTP id be2-20020a656e42000000b003f278fdda9bmr23960196pgb.297.1653384918567;
        Tue, 24 May 2022 02:35:18 -0700 (PDT)
Received: from [10.254.197.224] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090332cd00b0015e8d4eb213sm6909726plr.93.2022.05.24.02.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 02:35:17 -0700 (PDT)
Message-ID: <e601f404-0e9c-92a7-ed8a-8b5114491a1f@bytedance.com>
Date:   Tue, 24 May 2022 17:35:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [External] Re: [PATCH] sched/fair: optimize and simplify rq
 leaf_cfs_rq_list
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        zhengqi.arch@bytedance.com
References: <20220427160544.40309-1-zhouchengming@bytedance.com>
 <CAKfTPtB_Bm=xYdudD6d0PLqm_kZ1bCQ3oQH2NMZ0ZGOqsJ8k9w@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKfTPtB_Bm=xYdudD6d0PLqm_kZ1bCQ3oQH2NMZ0ZGOqsJ8k9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/24 00:23, Vincent Guittot wrote:
> On Wed, 27 Apr 2022 at 18:07, Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
[...]
>>  kernel/sched/fair.c | 72 ++++++++++-----------------------------------
>>  1 file changed, 16 insertions(+), 56 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 1ad18b5cc1b8..083c3d32c899 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -309,6 +309,8 @@ const struct sched_class fair_sched_class;
>>
>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>>
>> +static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
>> +
>>  /* Walk up scheduling entities hierarchy */
>>  #define for_each_sched_entity(se) \
>>                 for (; se; se = se->parent)
>> @@ -331,7 +333,7 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>>         struct rq *rq = rq_of(cfs_rq);
>>         int cpu = cpu_of(rq);
>>
>> -       if (cfs_rq->on_list)
>> +       if (cfs_rq->on_list || throttled_hierarchy(cfs_rq))
> 
> Please move throttled_hierarchy() outside list_add_leaf_cfs_rq()
> because the task will not be added in this case which is quite
> misleading

Ok, will do. I will move throttled_hierarchy() outside.

> 
> I will continue to check the various corner cases but I haven't seen
> problem so far with your method

Thanks!

> 
>>                 return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;
>>
>>         cfs_rq->on_list = 1;
>> @@ -3242,8 +3244,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
>>  }
>>  #endif /* CONFIG_SMP */
>>
>> -static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
>> -
>>  /*
>>   * Recomputes the group entity based on the current state of its group
>>   * runqueue.
>> @@ -4356,16 +4356,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>                 __enqueue_entity(cfs_rq, se);
>>         se->on_rq = 1;
>>
>> -       /*
>> -        * When bandwidth control is enabled, cfs might have been removed
>> -        * because of a parent been throttled but cfs->nr_running > 1. Try to
>> -        * add it unconditionally.
>> -        */
>> -       if (cfs_rq->nr_running == 1 || cfs_bandwidth_used())
>> +       if (cfs_rq->nr_running == 1) {
>>                 list_add_leaf_cfs_rq(cfs_rq);
>> -
>> -       if (cfs_rq->nr_running == 1)
>>                 check_enqueue_throttle(cfs_rq);
>> +       }
>>  }
>>
>>  static void __clear_buddies_last(struct sched_entity *se)
>> @@ -4980,11 +4974,18 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>>         /* update hierarchical throttle state */
>>         walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
>>
>> -       /* Nothing to run but something to decay (on_list)? Complete the branch */
>>         if (!cfs_rq->load.weight) {
>> -               if (cfs_rq->on_list)
>> -                       goto unthrottle_throttle;
>> -               return;
>> +               if (!cfs_rq->on_list)
>> +                       return;
>> +               /*
>> +                * Nothing to run but something to decay (on_list)?
>> +                * Complete the branch.
>> +                */
>> +               for_each_sched_entity(se) {
>> +                       if (list_add_leaf_cfs_rq(cfs_rq_of(se)))
>> +                               break;
>> +               }
>> +               goto unthrottle_throttle;
>>         }
>>
>>         task_delta = cfs_rq->h_nr_running;
>> @@ -5022,31 +5023,12 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>>                 /* end evaluation on encountering a throttled cfs_rq */
>>                 if (cfs_rq_throttled(qcfs_rq))
>>                         goto unthrottle_throttle;
>> -
>> -               /*
>> -                * One parent has been throttled and cfs_rq removed from the
>> -                * list. Add it back to not break the leaf list.
>> -                */
>> -               if (throttled_hierarchy(qcfs_rq))
>> -                       list_add_leaf_cfs_rq(qcfs_rq);
>>         }
>>
>>         /* At this point se is NULL and we are at root level*/
>>         add_nr_running(rq, task_delta);
>>
>>  unthrottle_throttle:
>> -       /*
>> -        * The cfs_rq_throttled() breaks in the above iteration can result in
>> -        * incomplete leaf list maintenance, resulting in triggering the
>> -        * assertion below.
>> -        */
>> -       for_each_sched_entity(se) {
>> -               struct cfs_rq *qcfs_rq = cfs_rq_of(se);
>> -
>> -               if (list_add_leaf_cfs_rq(qcfs_rq))
>> -                       break;
>> -       }
>> -
>>         assert_list_leaf_cfs_rq(rq);
>>
>>         /* Determine whether we need to wake up potentially idle CPU: */
>> @@ -5701,13 +5683,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>                 /* end evaluation on encountering a throttled cfs_rq */
>>                 if (cfs_rq_throttled(cfs_rq))
>>                         goto enqueue_throttle;
>> -
>> -               /*
>> -                * One parent has been throttled and cfs_rq removed from the
>> -                * list. Add it back to not break the leaf list.
>> -                */
>> -               if (throttled_hierarchy(cfs_rq))
>> -                       list_add_leaf_cfs_rq(cfs_rq);
>>         }
>>
>>         /* At this point se is NULL and we are at root level*/
>> @@ -5731,21 +5706,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>                 update_overutilized_status(rq);
>>
>>  enqueue_throttle:
>> -       if (cfs_bandwidth_used()) {
>> -               /*
>> -                * When bandwidth control is enabled; the cfs_rq_throttled()
>> -                * breaks in the above iteration can result in incomplete
>> -                * leaf list maintenance, resulting in triggering the assertion
>> -                * below.
>> -                */
>> -               for_each_sched_entity(se) {
>> -                       cfs_rq = cfs_rq_of(se);
>> -
>> -                       if (list_add_leaf_cfs_rq(cfs_rq))
>> -                               break;
>> -               }
>> -       }
>> -
>>         assert_list_leaf_cfs_rq(rq);
>>
>>         hrtick_update(rq);
>> --
>> 2.35.2
>>
