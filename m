Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F35597293
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbiHQPK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbiHQPKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:10:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF079D8E6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:10:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso844378pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=j78vdg8xgNfoG7QvW2IsxnVq78K9RSnqqHctxfSu6vc=;
        b=t8vV2yqsj+Cn/p6Sh/K0ZgeZFRx8iHG4HaihPYOvAmdv4K1dVSZBvkr8tkAst8T4ER
         njHqaeS4hrrhv2ves74vuzLhq00OP+5QPI9LRmCichJWE/9YE4RgjD03SQj8AAoYOzFz
         KaD4lucUvVJRKJCOSZXEDqfi8c8kFvxvzMVUmBojQn9AP5GmAYubIRgBAv1O7Xa0ABLq
         SNgeGVanwdTDK3/yEq3+jeEPYL8o9iHS6a8mBm8Bc5dSkPFHCLAJyiR6FRzV1beHN74J
         NoD++WnelqNrLSktp/84lR3fdDLdVbNmE9DrimKTgOx3JMx/+vn64gRbkExVwzUpUZzW
         MyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=j78vdg8xgNfoG7QvW2IsxnVq78K9RSnqqHctxfSu6vc=;
        b=lYM9NOr2N4GbNMiTmTFfmX8JDFH0fYDSKmiwm+Abqe4JAmXK52kyDgQZrthFSmremK
         mDUYthYfE/KYcDyeFFqAFZfZD3NoGMFqYyEieV4EdAFBSPHxAi4ziCkv7S7mKBnF7oRe
         6ADvRSDSd0d8SbpdCBJkWwB5amI90La7yi+JKRKdvNKug7D9CHDQXygUO/lmsU09Jg6i
         CLJhPuvzFnxGa2XJHr5dweIc2fk91KnWTqtoFRwEIHL9O6gkBzEgr3l6bMrD26CzOt/z
         tOi2aEnGKVBtph2TH/GT/4z3wWo/QYUEc50DZbNxmHJJsD3iTBZ6sMoAXcyabf4Z7Wrw
         WAOw==
X-Gm-Message-State: ACgBeo2Z65RKHVzo/mzF4Kw2CNfSXYsSrTEZIg0Bd8LYCvHsk96oHPjk
        fBUI1M1UJVuaTxyup0uxuGThVg==
X-Google-Smtp-Source: AA6agR4BxmdmUHGdsX6AzRTcDopQNbmmqijfXFnoA0O6DPIAeh+LT+QdOhBqn+vR8tN6/N2FhAftsg==
X-Received: by 2002:a17:902:694a:b0:16e:e270:1f84 with SMTP id k10-20020a170902694a00b0016ee2701f84mr26740013plt.89.1660749042710;
        Wed, 17 Aug 2022 08:10:42 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e63:2e90:498e:2d75:1610:f371? ([2409:8a28:e63:2e90:498e:2d75:1610:f371])
        by smtp.gmail.com with ESMTPSA id 193-20020a6214ca000000b0052d98fbf8f3sm10562461pfu.56.2022.08.17.08.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 08:10:42 -0700 (PDT)
Message-ID: <43a53d86-0a8c-6736-424a-a45dc014e8c4@bytedance.com>
Date:   Wed, 17 Aug 2022 23:10:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v4 6/9] sched/fair: fix another detach on unattached task
 corner case
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220808125745.22566-1-zhouchengming@bytedance.com>
 <20220808125745.22566-7-zhouchengming@bytedance.com>
 <CAKfTPtBbKoJ0r=tE+9E9KxHkCy1ucev_DxLRqeQrx39ZzizqGA@mail.gmail.com>
 <fa2e11fc-5a49-b88a-1daa-ad6e5f5dea51@bytedance.com>
 <CAKfTPtC=zfd6SekH--_jrZQg-YPkCD4-W0S2WgVTZ_RqY_NdGw@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKfTPtC=zfd6SekH--_jrZQg-YPkCD4-W0S2WgVTZ_RqY_NdGw@mail.gmail.com>
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

On 2022/8/17 23:08, Vincent Guittot wrote:
> On Wed, 17 Aug 2022 at 17:04, Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2022/8/17 23:01, Vincent Guittot wrote:
>>> On Mon, 8 Aug 2022 at 14:58, Chengming Zhou <zhouchengming@bytedance.com> wrote:
>>>>
>>>> commit 7dc603c9028e ("sched/fair: Fix PELT integrity for new tasks")
>>>> fixed two load tracking problems for new task, including detach on
>>>> unattached new task problem.
>>>>
>>>> There still left another detach on unattached task problem for the task
>>>> which has been woken up by try_to_wake_up() and waiting for actually
>>>> being woken up by sched_ttwu_pending().
>>>>
>>>> try_to_wake_up(p)
>>>>   cpu = select_task_rq(p)
>>>>   if (task_cpu(p) != cpu)
>>>>     set_task_cpu(p, cpu)
>>>>       migrate_task_rq_fair()
>>>>         remove_entity_load_avg()       --> unattached
>>>>         se->avg.last_update_time = 0;
>>>>       __set_task_cpu()
>>>>   ttwu_queue(p, cpu)
>>>>     ttwu_queue_wakelist()
>>>>       __ttwu_queue_wakelist()
>>>>
>>>> task_change_group_fair()
>>>>   detach_task_cfs_rq()
>>>>     detach_entity_cfs_rq()
>>>>       detach_entity_load_avg()   --> detach on unattached task
>>>>   set_task_rq()
>>>>   attach_task_cfs_rq()
>>>>     attach_entity_cfs_rq()
>>>>       attach_entity_load_avg()
>>>>
>>>> The reason of this problem is similar, we should check in detach_entity_cfs_rq()
>>>> that se->avg.last_update_time != 0, before do detach_entity_load_avg().
>>>>
>>>> This patch move detach/attach_entity_cfs_rq() functions up to be together
>>>> with other load tracking functions to avoid to use another #ifdef CONFIG_SMP.
>>>>
>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>> ---
>>>>  kernel/sched/fair.c | 132 +++++++++++++++++++++++---------------------
>>>>  1 file changed, 68 insertions(+), 64 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index f52e7dc7f22d..4bc76d95a99d 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -874,9 +874,6 @@ void init_entity_runnable_average(struct sched_entity *se)
>>>>  void post_init_entity_util_avg(struct task_struct *p)
>>>>  {
>>>>  }
>>>> -static void update_tg_load_avg(struct cfs_rq *cfs_rq)
>>>> -{
>>>> -}
>>>>  #endif /* CONFIG_SMP */
>>>>
>>>>  /*
>>>> @@ -3176,6 +3173,7 @@ void reweight_task(struct task_struct *p, int prio)
>>>>         load->inv_weight = sched_prio_to_wmult[prio];
>>>>  }
>>>>
>>>> +static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
>>>>  static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
>>>>
>>>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>>>> @@ -4086,6 +4084,71 @@ static void remove_entity_load_avg(struct sched_entity *se)
>>>>         raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
>>>>  }
>>>>
>>>> +#ifdef CONFIG_FAIR_GROUP_SCHED
>>>> +/*
>>>> + * Propagate the changes of the sched_entity across the tg tree to make it
>>>> + * visible to the root
>>>> + */
>>>> +static void propagate_entity_cfs_rq(struct sched_entity *se)
>>>> +{
>>>> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>> +
>>>> +       if (cfs_rq_throttled(cfs_rq))
>>>> +               return;
>>>> +
>>>> +       if (!throttled_hierarchy(cfs_rq))
>>>> +               list_add_leaf_cfs_rq(cfs_rq);
>>>> +
>>>> +       /* Start to propagate at parent */
>>>> +       se = se->parent;
>>>> +
>>>> +       for_each_sched_entity(se) {
>>>> +               cfs_rq = cfs_rq_of(se);
>>>> +
>>>> +               update_load_avg(cfs_rq, se, UPDATE_TG);
>>>> +
>>>> +               if (cfs_rq_throttled(cfs_rq))
>>>> +                       break;
>>>> +
>>>> +               if (!throttled_hierarchy(cfs_rq))
>>>> +                       list_add_leaf_cfs_rq(cfs_rq);
>>>> +       }
>>>> +}
>>>> +#else
>>>> +static void propagate_entity_cfs_rq(struct sched_entity *se) { }
>>>> +#endif
>>>> +
>>>> +static void detach_entity_cfs_rq(struct sched_entity *se)
>>>> +{
>>>> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>> +
>>>> +       /*
>>>> +        * In case the task sched_avg hasn't been attached:
>>>> +        * - A forked task which hasn't been woken up by wake_up_new_task().
>>>> +        * - A task which has been woken up by try_to_wake_up() but is
>>>> +        *   waiting for actually being woken up by sched_ttwu_pending().
>>>> +        */
>>>> +       if (!se->avg.last_update_time)
>>>> +               return;
>>>
>>> The 2 lines above and the associated comment are the only relevant
>>> part of the patch, aren't they ?
>>> Is everything else just code moving from one place to another one
>>> without change ?
>>
>> Yes, everything else is just code movement.
> 
> Could you remove such code movement ? It doesn't add any value to the
> patch, does it ? But It makes the patch quite difficult to review and
> I wasted a lot of time looking for what really changed in the code
> 

Sorry about that. No problem, I will remove it.

Thanks!


> Thanks
> 
>>
>> Thanks!
>>
>>>
>>>> +
>>>> +       /* Catch up with the cfs_rq and remove our load when we leave */
>>>> +       update_load_avg(cfs_rq, se, 0);
>>>> +       detach_entity_load_avg(cfs_rq, se);
>>>> +       update_tg_load_avg(cfs_rq);
>>>> +       propagate_entity_cfs_rq(se);
>>>> +}
>>>> +
>>>> +static void attach_entity_cfs_rq(struct sched_entity *se)
>>>> +{
>>>> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>> +
>>>> +       /* Synchronize entity with its cfs_rq */
>>>> +       update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
>>>> +       attach_entity_load_avg(cfs_rq, se);
>>>> +       update_tg_load_avg(cfs_rq);
>>>> +       propagate_entity_cfs_rq(se);
>>>> +}
>>>> +
>>>>  static inline unsigned long cfs_rq_runnable_avg(struct cfs_rq *cfs_rq)
>>>>  {
>>>>         return cfs_rq->avg.runnable_avg;
>>>> @@ -4308,11 +4371,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>>>>  }
>>>>
>>>>  static inline void remove_entity_load_avg(struct sched_entity *se) {}
>>>> -
>>>> -static inline void
>>>> -attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
>>>> -static inline void
>>>> -detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
>>>> +static inline void detach_entity_cfs_rq(struct sched_entity *se) {}
>>>> +static inline void attach_entity_cfs_rq(struct sched_entity *se) {}
>>>>
>>>>  static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
>>>>  {
>>>> @@ -11519,62 +11579,6 @@ static inline bool vruntime_normalized(struct task_struct *p)
>>>>         return false;
>>>>  }
>>>>
>>>> -#ifdef CONFIG_FAIR_GROUP_SCHED
>>>> -/*
>>>> - * Propagate the changes of the sched_entity across the tg tree to make it
>>>> - * visible to the root
>>>> - */
>>>> -static void propagate_entity_cfs_rq(struct sched_entity *se)
>>>> -{
>>>> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>> -
>>>> -       if (cfs_rq_throttled(cfs_rq))
>>>> -               return;
>>>> -
>>>> -       if (!throttled_hierarchy(cfs_rq))
>>>> -               list_add_leaf_cfs_rq(cfs_rq);
>>>> -
>>>> -       /* Start to propagate at parent */
>>>> -       se = se->parent;
>>>> -
>>>> -       for_each_sched_entity(se) {
>>>> -               cfs_rq = cfs_rq_of(se);
>>>> -
>>>> -               update_load_avg(cfs_rq, se, UPDATE_TG);
>>>> -
>>>> -               if (cfs_rq_throttled(cfs_rq))
>>>> -                       break;
>>>> -
>>>> -               if (!throttled_hierarchy(cfs_rq))
>>>> -                       list_add_leaf_cfs_rq(cfs_rq);
>>>> -       }
>>>> -}
>>>> -#else
>>>> -static void propagate_entity_cfs_rq(struct sched_entity *se) { }
>>>> -#endif
>>>> -
>>>> -static void detach_entity_cfs_rq(struct sched_entity *se)
>>>> -{
>>>> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>> -
>>>> -       /* Catch up with the cfs_rq and remove our load when we leave */
>>>> -       update_load_avg(cfs_rq, se, 0);
>>>> -       detach_entity_load_avg(cfs_rq, se);
>>>> -       update_tg_load_avg(cfs_rq);
>>>> -       propagate_entity_cfs_rq(se);
>>>> -}
>>>> -
>>>> -static void attach_entity_cfs_rq(struct sched_entity *se)
>>>> -{
>>>> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>> -
>>>> -       /* Synchronize entity with its cfs_rq */
>>>> -       update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
>>>> -       attach_entity_load_avg(cfs_rq, se);
>>>> -       update_tg_load_avg(cfs_rq);
>>>> -       propagate_entity_cfs_rq(se);
>>>> -}
>>>> -
>>>>  static void detach_task_cfs_rq(struct task_struct *p)
>>>>  {
>>>>         struct sched_entity *se = &p->se;
>>>> --
>>>> 2.36.1
>>>>
