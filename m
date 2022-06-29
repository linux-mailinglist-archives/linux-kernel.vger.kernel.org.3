Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C531655F2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiF2BiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiF2BiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:38:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B50C25C7C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:38:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d129so13839739pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B/rmAtCN4xhbTruy/kKzU4deS9vyR1apssQp48swO/Y=;
        b=F4AZdi3dufqhHtQjbsJ5UQrxRzPn3OOEbVc6Pg6yoKHZpURIcImvG+ZzmA8gkeJSBd
         FvncbqzlLAmer5vo/FWVthpOJ2il60DlLJq8ruVneUSkEkiN42CosPh8fnMIumxYEqUy
         BZheZ0JDvffliA3ORDaIE2poYmLQQmEvLyrnAHnzpaBUogVvZatGacEPLeQ4ZDyegyCU
         JnoYhB2DSa1tsES8S5NotwVaiL+hTIXu4VRq4i2Rac5EgJjzPbKa0KX6ZHfrau3mb8Hb
         h5cCVIgOHZlSQRx9IRF+yFZ7FzMdIHmkZe1BGCUq9Tc2mYdc+rNQzK+OCFmpfAsLKk7I
         IW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B/rmAtCN4xhbTruy/kKzU4deS9vyR1apssQp48swO/Y=;
        b=kReHT4OU0eO1Bf2BoiHQqXF/hPHuaOOPFdt3kPMzmQFo9qEu49yU8ki1qS1GObUlrJ
         zjTf2jwpmX9Six8kuV4RO8vePDXdNJD6Q0KX2tTZOmK1E7Wp3P+pL9LtyS+DYxOARzT8
         yMCx4KcQV7fJT1HjkzDZTa+b3GhTzS5f55lKi59S7FytECfvLrHiS/LuzMJTPLTNzdCP
         y4xSBBKmGXtYuATY7E3xHrIl2cP1sBtJ2WBTJBYkIc021tvbWN62AyH+8sro3u3/TFhH
         bopcfKIKhw1cKybuS0CS9vTS+R7DCQA+4+usjFiXoamgNkKrzmZSRduCx7dkY1Ybh5N+
         YOzQ==
X-Gm-Message-State: AJIora+iJpunlQ3r7dkffbSu94bsZ5PiIwj8MiimQNpZmvw8WwdePly7
        weRVNAPJK+P9HMfin4kvVrk3pMu7e2HA7biy
X-Google-Smtp-Source: AGRyM1t3bagrQ1MWzv+FaiEOYOQSnQwYY8FXj9+z+0EJgaseNI/LAMhT3HsxtFxRK5YemPbYejQUXQ==
X-Received: by 2002:a63:2a4f:0:b0:40d:997:557f with SMTP id q76-20020a632a4f000000b0040d0997557fmr815282pgq.42.1656466679422;
        Tue, 28 Jun 2022 18:37:59 -0700 (PDT)
Received: from [10.70.253.98] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b00525161431f5sm10080427pfg.36.2022.06.28.18.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 18:37:59 -0700 (PDT)
Message-ID: <3c0a8ef1-6450-4eb0-edb4-c7cd31790a85@bytedance.com>
Date:   Wed, 29 Jun 2022 09:37:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [External] Re: [PATCH v4] sched/fair: combine detach into dequeue
 when migrating task
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        bsegall@google.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220620133608.78498-1-zhouchengming@bytedance.com>
 <CAKfTPtAUrR97jmifveYCUxmaKJ_95v+N_3DDPVdMnBwrgFdRCw@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKfTPtAUrR97jmifveYCUxmaKJ_95v+N_3DDPVdMnBwrgFdRCw@mail.gmail.com>
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

Hi, thanks for your review.

On 2022/6/28 23:26, Vincent Guittot wrote:
> On Mon, 20 Jun 2022 at 15:36, Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> When we are migrating task out of the CPU, we can combine detach and
>> propagation into dequeue_entity() to save the detach_entity_cfs_rq()
>> -> propagate_entity_cfs_rq() call in detach_entity_cfs_rq() in
>> migrate_task_rq_fair().
>>
>> This optimization is like combining DO_ATTACH in the enqueue_entity()
>> when migrating task to the CPU.
>> -> propagate_entity_cfs_rq() call in detach_entity_cfs_rq() in
>> migrate_task_rq_fair().
>>
>>
>> So we don't have to traverse the CFS tree extra time to do the
>> detach_entity_cfs_rq() -> propagate_entity_cfs_rq() call, which
>> wouldn't be called anymore with this patch's change.
>>
>> Copied from Dietmar's much clearer comment:
> 
> Although It's nice to keep the author of a comment, it should not be
> part of the commit message.

Ok, I will delete this.

> 
>> detach_task()
>>   deactivate_task()
>>     dequeue_task_fair()
>>       for_each_sched_entity(se)
>>         dequeue_entity()
>>           update_load_avg()   /* (1) */
>               detach_entity_load_avg()
> 
>> set_task_cpu()
>>  migrate_task_rq_fair()
>>    detach_entity_cfs_rq() /* (2) */
>        update_load_avg();
>        detach_entity_load_avg();
>        propagate_entity_cfs_rq();
>          for_each_sched_entity()
>            update_load_avg()
> 
> Could you add the full call stack so we can see more easily the extra
> loop that is saved

Good advice, I will add it.

Thanks.

>>
>> This patch save the propagate_entity_cfs_rq(&p->se) call from (2)
>> by doing the detach_entity_load_avg(), update_tg_load_avg() for
>> a migrating task inside (1) (the task being the first se in the loop)
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Apart the small nit above:
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
>> ---
>> v4:
>>  - change the commit message a little.
>>  - remove the forward declaration of detach_entity_cfs_rq()
>>  - remove verbose comments in code.
>>
>> v3:
>>  - change to use task_on_rq_migrating() and put Dietmar's much clearer
>>    description in the commit message. Thanks!
>>
>> v2:
>>  - fix !CONFIG_SMP build error
>> ---
>>  kernel/sched/fair.c | 30 +++++++++++++++++-------------
>>  1 file changed, 17 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 8bed75757e65..31d53c11e244 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3931,6 +3931,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>>  #define UPDATE_TG      0x1
>>  #define SKIP_AGE_LOAD  0x2
>>  #define DO_ATTACH      0x4
>> +#define DO_DETACH      0x8
>>
>>  /* Update task and its cfs_rq load average */
>>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>> @@ -3948,7 +3949,14 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>>         decayed  = update_cfs_rq_load_avg(now, cfs_rq);
>>         decayed |= propagate_entity_load_avg(se);
>>
>> -       if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
>> +       if (flags & DO_DETACH) {
>> +               /*
>> +                * DO_DETACH means we're here from dequeue_entity()
>> +                * and we are migrating task out of the CPU.
>> +                */
>> +               detach_entity_load_avg(cfs_rq, se);
>> +               update_tg_load_avg(cfs_rq);
>> +       } else if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
>>
>>                 /*
>>                  * DO_ATTACH means we're here from enqueue_entity().
>> @@ -4241,6 +4249,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>>  #define UPDATE_TG      0x0
>>  #define SKIP_AGE_LOAD  0x0
>>  #define DO_ATTACH      0x0
>> +#define DO_DETACH      0x0
>>
>>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
>>  {
>> @@ -4460,6 +4469,11 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>>  static void
>>  dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>  {
>> +       int action = UPDATE_TG;
>> +
>> +       if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
>> +               action |= DO_DETACH;
>> +
>>         /*
>>          * Update run-time statistics of the 'current'.
>>          */
>> @@ -4473,7 +4487,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>          *   - For group entity, update its weight to reflect the new share
>>          *     of its group cfs_rq.
>>          */
>> -       update_load_avg(cfs_rq, se, UPDATE_TG);
>> +       update_load_avg(cfs_rq, se, action);
>>         se_update_runnable(se);
>>
>>         update_stats_dequeue_fair(cfs_rq, se, flags);
>> @@ -6938,8 +6952,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>>         return new_cpu;
>>  }
>>
>> -static void detach_entity_cfs_rq(struct sched_entity *se);
>> -
>>  /*
>>   * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
>>   * cfs_rq_of(p) references at time of call are still valid and identify the
>> @@ -6973,15 +6985,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>>                 se->vruntime -= min_vruntime;
>>         }
>>
>> -       if (p->on_rq == TASK_ON_RQ_MIGRATING) {
>> -               /*
>> -                * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
>> -                * rq->lock and can modify state directly.
>> -                */
>> -               lockdep_assert_rq_held(task_rq(p));
>> -               detach_entity_cfs_rq(&p->se);
>> -
>> -       } else {
>> +       if (!task_on_rq_migrating(p)) {
>>                 /*
>>                  * We are supposed to update the task to "current" time, then
>>                  * its up to date and ready to go to new CPU/cfs_rq. But we
>> --
>> 2.36.1
>>
