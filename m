Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F32A59727F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbiHQPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240531AbiHQPEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:04:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E167E9E13D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:04:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d71so12175459pgc.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=pwlVeg8zW+J5NtyQQoDHksUt4fzr1niQVyxzPtsCf6A=;
        b=lBoR9/Gi31SBBYUzdCXJM6FifLv9kKtPfKFKu/YOWdDJjlriSGKV3VIzbQfn1UeiVs
         hJub+wbcMe00sajN/ojOzkBT7ja4rVQU9Z+r8TdOxNPi1UpGjw5O6RkpIn7LvP9g3Gcx
         LErzoVexlH6YxeyVKaFuVs+DRHrXzPvpckMvS7ZuvSHfUEP1PPVinkGTB9cpCifqM4Dl
         UWypEBxrrGOY8BnjbIukjsfZS3CZaqo9RaZlY7WCJpjQ06Nw3JvI4nwfUfIIYYCx9+x8
         wSUXUCYSMEToiC1fqbfXpbG8y3aW+Y1LioYYvFcODg3lIwosbjL438zjl2gb2v6ObMJK
         M+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=pwlVeg8zW+J5NtyQQoDHksUt4fzr1niQVyxzPtsCf6A=;
        b=6vSJe4O7na9+Kjo0cCjWW6A974wGMLw4ptgQgcvimA3FWwT/9hSnEtXxPcqYRBkumM
         pG4Xyuq4wLxzc7XAmisG9bav0hsDbJtX+RmJ3OzZ8hYH8c4nhCzYFW6PVqW/mp4fRs+8
         HEnK1uPr0ERijU5xjw+rTCCXIGxTrK90/u5Te8IYHu6UpJQyZYVV6vq3nVcAkNfxx3pX
         YoW0yxWU7UTOzcqk03uxv5MSs8vED+Vt7CL5O1ysi3ylWW7tgnCHPhPJTm2XnQXDDheT
         DNssX2T8U3ulX4s5+yj4FPl9+D2WubxTEQgI2xzRVVI9AOvHox0TYo5NBbG1LifY0weD
         Q+BA==
X-Gm-Message-State: ACgBeo0dG2RY1nYx/IOJM0bYw11BOaAox7Wq+jEhz3/9L2fW5+xaKghF
        bKsIuHyOd8+Q1Pzw9iwbQmz7Kg==
X-Google-Smtp-Source: AA6agR6bxD5aUF0sBz6BJIZhLvA1BsCWHFc0WVW85vnNL6FU7I5Dmnh/loi51o+QTQzRpWcHdAR7Dw==
X-Received: by 2002:a63:8442:0:b0:429:85db:b351 with SMTP id k63-20020a638442000000b0042985dbb351mr9505361pgd.430.1660748659070;
        Wed, 17 Aug 2022 08:04:19 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e63:2e90:498e:2d75:1610:f371? ([2409:8a28:e63:2e90:498e:2d75:1610:f371])
        by smtp.gmail.com with ESMTPSA id r22-20020a635156000000b0040c40b022fbsm9446809pgl.94.2022.08.17.08.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 08:04:18 -0700 (PDT)
Message-ID: <fa2e11fc-5a49-b88a-1daa-ad6e5f5dea51@bytedance.com>
Date:   Wed, 17 Aug 2022 23:04:09 +0800
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
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKfTPtBbKoJ0r=tE+9E9KxHkCy1ucev_DxLRqeQrx39ZzizqGA@mail.gmail.com>
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

On 2022/8/17 23:01, Vincent Guittot wrote:
> On Mon, 8 Aug 2022 at 14:58, Chengming Zhou <zhouchengming@bytedance.com> wrote:
>>
>> commit 7dc603c9028e ("sched/fair: Fix PELT integrity for new tasks")
>> fixed two load tracking problems for new task, including detach on
>> unattached new task problem.
>>
>> There still left another detach on unattached task problem for the task
>> which has been woken up by try_to_wake_up() and waiting for actually
>> being woken up by sched_ttwu_pending().
>>
>> try_to_wake_up(p)
>>   cpu = select_task_rq(p)
>>   if (task_cpu(p) != cpu)
>>     set_task_cpu(p, cpu)
>>       migrate_task_rq_fair()
>>         remove_entity_load_avg()       --> unattached
>>         se->avg.last_update_time = 0;
>>       __set_task_cpu()
>>   ttwu_queue(p, cpu)
>>     ttwu_queue_wakelist()
>>       __ttwu_queue_wakelist()
>>
>> task_change_group_fair()
>>   detach_task_cfs_rq()
>>     detach_entity_cfs_rq()
>>       detach_entity_load_avg()   --> detach on unattached task
>>   set_task_rq()
>>   attach_task_cfs_rq()
>>     attach_entity_cfs_rq()
>>       attach_entity_load_avg()
>>
>> The reason of this problem is similar, we should check in detach_entity_cfs_rq()
>> that se->avg.last_update_time != 0, before do detach_entity_load_avg().
>>
>> This patch move detach/attach_entity_cfs_rq() functions up to be together
>> with other load tracking functions to avoid to use another #ifdef CONFIG_SMP.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  kernel/sched/fair.c | 132 +++++++++++++++++++++++---------------------
>>  1 file changed, 68 insertions(+), 64 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index f52e7dc7f22d..4bc76d95a99d 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -874,9 +874,6 @@ void init_entity_runnable_average(struct sched_entity *se)
>>  void post_init_entity_util_avg(struct task_struct *p)
>>  {
>>  }
>> -static void update_tg_load_avg(struct cfs_rq *cfs_rq)
>> -{
>> -}
>>  #endif /* CONFIG_SMP */
>>
>>  /*
>> @@ -3176,6 +3173,7 @@ void reweight_task(struct task_struct *p, int prio)
>>         load->inv_weight = sched_prio_to_wmult[prio];
>>  }
>>
>> +static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
>>  static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
>>
>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>> @@ -4086,6 +4084,71 @@ static void remove_entity_load_avg(struct sched_entity *se)
>>         raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
>>  }
>>
>> +#ifdef CONFIG_FAIR_GROUP_SCHED
>> +/*
>> + * Propagate the changes of the sched_entity across the tg tree to make it
>> + * visible to the root
>> + */
>> +static void propagate_entity_cfs_rq(struct sched_entity *se)
>> +{
>> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>> +
>> +       if (cfs_rq_throttled(cfs_rq))
>> +               return;
>> +
>> +       if (!throttled_hierarchy(cfs_rq))
>> +               list_add_leaf_cfs_rq(cfs_rq);
>> +
>> +       /* Start to propagate at parent */
>> +       se = se->parent;
>> +
>> +       for_each_sched_entity(se) {
>> +               cfs_rq = cfs_rq_of(se);
>> +
>> +               update_load_avg(cfs_rq, se, UPDATE_TG);
>> +
>> +               if (cfs_rq_throttled(cfs_rq))
>> +                       break;
>> +
>> +               if (!throttled_hierarchy(cfs_rq))
>> +                       list_add_leaf_cfs_rq(cfs_rq);
>> +       }
>> +}
>> +#else
>> +static void propagate_entity_cfs_rq(struct sched_entity *se) { }
>> +#endif
>> +
>> +static void detach_entity_cfs_rq(struct sched_entity *se)
>> +{
>> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>> +
>> +       /*
>> +        * In case the task sched_avg hasn't been attached:
>> +        * - A forked task which hasn't been woken up by wake_up_new_task().
>> +        * - A task which has been woken up by try_to_wake_up() but is
>> +        *   waiting for actually being woken up by sched_ttwu_pending().
>> +        */
>> +       if (!se->avg.last_update_time)
>> +               return;
> 
> The 2 lines above and the associated comment are the only relevant
> part of the patch, aren't they ?
> Is everything else just code moving from one place to another one
> without change ?

Yes, everything else is just code movement.

Thanks!

> 
>> +
>> +       /* Catch up with the cfs_rq and remove our load when we leave */
>> +       update_load_avg(cfs_rq, se, 0);
>> +       detach_entity_load_avg(cfs_rq, se);
>> +       update_tg_load_avg(cfs_rq);
>> +       propagate_entity_cfs_rq(se);
>> +}
>> +
>> +static void attach_entity_cfs_rq(struct sched_entity *se)
>> +{
>> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>> +
>> +       /* Synchronize entity with its cfs_rq */
>> +       update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
>> +       attach_entity_load_avg(cfs_rq, se);
>> +       update_tg_load_avg(cfs_rq);
>> +       propagate_entity_cfs_rq(se);
>> +}
>> +
>>  static inline unsigned long cfs_rq_runnable_avg(struct cfs_rq *cfs_rq)
>>  {
>>         return cfs_rq->avg.runnable_avg;
>> @@ -4308,11 +4371,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>>  }
>>
>>  static inline void remove_entity_load_avg(struct sched_entity *se) {}
>> -
>> -static inline void
>> -attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
>> -static inline void
>> -detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
>> +static inline void detach_entity_cfs_rq(struct sched_entity *se) {}
>> +static inline void attach_entity_cfs_rq(struct sched_entity *se) {}
>>
>>  static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
>>  {
>> @@ -11519,62 +11579,6 @@ static inline bool vruntime_normalized(struct task_struct *p)
>>         return false;
>>  }
>>
>> -#ifdef CONFIG_FAIR_GROUP_SCHED
>> -/*
>> - * Propagate the changes of the sched_entity across the tg tree to make it
>> - * visible to the root
>> - */
>> -static void propagate_entity_cfs_rq(struct sched_entity *se)
>> -{
>> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>> -
>> -       if (cfs_rq_throttled(cfs_rq))
>> -               return;
>> -
>> -       if (!throttled_hierarchy(cfs_rq))
>> -               list_add_leaf_cfs_rq(cfs_rq);
>> -
>> -       /* Start to propagate at parent */
>> -       se = se->parent;
>> -
>> -       for_each_sched_entity(se) {
>> -               cfs_rq = cfs_rq_of(se);
>> -
>> -               update_load_avg(cfs_rq, se, UPDATE_TG);
>> -
>> -               if (cfs_rq_throttled(cfs_rq))
>> -                       break;
>> -
>> -               if (!throttled_hierarchy(cfs_rq))
>> -                       list_add_leaf_cfs_rq(cfs_rq);
>> -       }
>> -}
>> -#else
>> -static void propagate_entity_cfs_rq(struct sched_entity *se) { }
>> -#endif
>> -
>> -static void detach_entity_cfs_rq(struct sched_entity *se)
>> -{
>> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>> -
>> -       /* Catch up with the cfs_rq and remove our load when we leave */
>> -       update_load_avg(cfs_rq, se, 0);
>> -       detach_entity_load_avg(cfs_rq, se);
>> -       update_tg_load_avg(cfs_rq);
>> -       propagate_entity_cfs_rq(se);
>> -}
>> -
>> -static void attach_entity_cfs_rq(struct sched_entity *se)
>> -{
>> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>> -
>> -       /* Synchronize entity with its cfs_rq */
>> -       update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
>> -       attach_entity_load_avg(cfs_rq, se);
>> -       update_tg_load_avg(cfs_rq);
>> -       propagate_entity_cfs_rq(se);
>> -}
>> -
>>  static void detach_task_cfs_rq(struct task_struct *p)
>>  {
>>         struct sched_entity *se = &p->se;
>> --
>> 2.36.1
>>
