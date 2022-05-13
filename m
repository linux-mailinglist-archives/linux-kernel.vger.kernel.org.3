Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F52525AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376980AbiEMEcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiEMEcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:32:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBF41D89F9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:32:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a11so6682953pff.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HShJID9SqbORjKsKMFhNTMZdx7Euq0wSFpHbpoh/p8E=;
        b=pyflYZLnJd+TZS8OrfmBaXS9hI/hX+d9y64Q082UwkUp882amhwooOOKljd6H5VGCF
         IeHqqezKJW45s+vdIQCzquZ/pvh/ctrxpsVoKo4QCo5ksigH+qTZeudsS6ghIHOQ9y9I
         EUzIOUO2IcEUisWxZx73dpUy0V7H+AnIS5vXvkyFOzm6C8gKHrBdpfCNIAbtmYAU5hj2
         7aO7IL8YdHNx4WCY9yjSmYMoGHpIaAtqo+7wAElEqKtQr80LbnqvoMfU22P2sc82lwVm
         gTY8ZSaom9eGjYz2W6Roy2RUDxUesLW2kUh+BFt8FCsCaTCjURnewOyltInm5Gt/xdZW
         G5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HShJID9SqbORjKsKMFhNTMZdx7Euq0wSFpHbpoh/p8E=;
        b=N3vyS+11um1a0sPSZkISgkdGI9ZI4HMAgNv5tGP8wnPBqVr/beeWuwQlgM8HC2LFss
         XgAVZimeRjuL2zr/ucIxHfGCGQl34xKKD5l1f7aJcaRamN2YsSKhO4E0tbtrESGEsPgq
         Nz7jHDinlynyOzo3bPPPL3wrkhCgXMcyRxgymnSEPO0ur7dSs+guEDpLBgZav13GhQEx
         PtbzKAmF8SHeITUbeW4k2sfTCDLJZn7un10IbPtXq3iYmw0kiIC2ErY29X6yke8kBxAA
         7aoZbdHoD2APeyWiCKwsaxT/vOyTuf77b/wbCszTjiUExVigrCJZv8idflzLQ5FUZ1Af
         Z+rw==
X-Gm-Message-State: AOAM533AtwRcxawTslLSHIrXTxjbP0AFbz/RvijN/xThqS5zusRaKhDX
        7d7wHwHv5Q6xtjGtuhos7BMy8A==
X-Google-Smtp-Source: ABdhPJwUlE2YJklG9KyMkHwQVoD24UcRWZAcciox7ibVxuO1J9FjGzjMEBl65PiMueQ8HyObuVcNwg==
X-Received: by 2002:a62:1547:0:b0:50e:d9b:ddf with SMTP id 68-20020a621547000000b0050e0d9b0ddfmr2852690pfv.46.1652416339530;
        Thu, 12 May 2022 21:32:19 -0700 (PDT)
Received: from [10.254.192.101] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id em11-20020a17090b014b00b001d952b8f728sm2603320pjb.2.2022.05.12.21.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 21:32:18 -0700 (PDT)
Message-ID: <26fe8e8f-a7d7-02d9-f8e3-2448c25f1f5d@bytedance.com>
Date:   Fri, 13 May 2022 12:32:11 +0800
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
 <4f04f101-53c1-0ac8-c7e8-ff2999ed35ba@bytedance.com>
 <CAKfTPtDpqECw_mo1+iPN8OPb3cBf7ppJsLSTAJwPRLr-N3auqg@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKfTPtDpqECw_mo1+iPN8OPb3cBf7ppJsLSTAJwPRLr-N3auqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 22:02, Vincent Guittot wrote:
> Hi Chengming,
> 
> Your patch is on my list but I have been busy on other stuff and we
> had enough warnings and problems with this part that I want to
> carefully review that all the cases are covered. I will review it soon
> 

Hi Vincent,

Thanks for your reply. There's no rush, just take your time. I agree
that we should be very careful with this part due to previous problems.

Thanks.

> Vincent
> 
> On Wed, 11 May 2022 at 14:05, Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> Hello, friendly ping...
>>
>>
>> On 2022/4/28 00:05, Chengming Zhou wrote:
>>> We notice the rq leaf_cfs_rq_list has two problems when do bugfix
>>> backports and some test profiling.
>>>
>>> 1. cfs_rqs under throttled subtree could be added to the list, and
>>>    make their fully decayed ancestors on the list, even though not needed.
>>>
>>> 2. #1 also make the leaf_cfs_rq_list management complex and error prone,
>>>    this is the list of related bugfix so far:
>>>
>>>    commit 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
>>>    commit fe61468b2cbc ("sched/fair: Fix enqueue_task_fair warning")
>>>    commit b34cb07dde7c ("sched/fair: Fix enqueue_task_fair() warning some more")
>>>    commit 39f23ce07b93 ("sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list")
>>>    commit 0258bdfaff5b ("sched/fair: Fix unfairness caused by missing load decay")
>>>    commit a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")
>>>    commit fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added after unthrottling")
>>>    commit 2630cde26711 ("sched/fair: Add ancestors of unthrottled undecayed cfs_rq")
>>>
>>> commit 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
>>> delete every cfs_rq under throttled subtree from rq->leaf_cfs_rq_list,
>>> and delete the throttled_hierarchy() test in update_blocked_averages(),
>>> which optimized update_blocked_averages().
>>>
>>> But those later bugfix add cfs_rqs under throttled subtree back to
>>> rq->leaf_cfs_rq_list again, with their fully decayed ancestors, for
>>> the integrity of rq->leaf_cfs_rq_list.
>>>
>>> This patch takes another method, skip all cfs_rqs under throttled
>>> hierarchy when list_add_leaf_cfs_rq(), to completely make cfs_rqs
>>> under throttled subtree off the leaf_cfs_rq_list.
>>>
>>> So we don't need to consider throttled related things in
>>> enqueue_entity(), unthrottle_cfs_rq() and enqueue_task_fair(),
>>> which simplify the code a lot. Also optimize update_blocked_averages()
>>> since cfs_rqs under throttled hierarchy and their ancestors
>>> won't be on the leaf_cfs_rq_list.
>>>
>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>> ---
>>>  kernel/sched/fair.c | 72 ++++++++++-----------------------------------
>>>  1 file changed, 16 insertions(+), 56 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 1ad18b5cc1b8..083c3d32c899 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -309,6 +309,8 @@ const struct sched_class fair_sched_class;
>>>
>>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>>>
>>> +static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
>>> +
>>>  /* Walk up scheduling entities hierarchy */
>>>  #define for_each_sched_entity(se) \
>>>               for (; se; se = se->parent)
>>> @@ -331,7 +333,7 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>>>       struct rq *rq = rq_of(cfs_rq);
>>>       int cpu = cpu_of(rq);
>>>
>>> -     if (cfs_rq->on_list)
>>> +     if (cfs_rq->on_list || throttled_hierarchy(cfs_rq))
>>>               return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;
>>>
>>>       cfs_rq->on_list = 1;
>>> @@ -3242,8 +3244,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
>>>  }
>>>  #endif /* CONFIG_SMP */
>>>
>>> -static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
>>> -
>>>  /*
>>>   * Recomputes the group entity based on the current state of its group
>>>   * runqueue.
>>> @@ -4356,16 +4356,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>>               __enqueue_entity(cfs_rq, se);
>>>       se->on_rq = 1;
>>>
>>> -     /*
>>> -      * When bandwidth control is enabled, cfs might have been removed
>>> -      * because of a parent been throttled but cfs->nr_running > 1. Try to
>>> -      * add it unconditionally.
>>> -      */
>>> -     if (cfs_rq->nr_running == 1 || cfs_bandwidth_used())
>>> +     if (cfs_rq->nr_running == 1) {
>>>               list_add_leaf_cfs_rq(cfs_rq);
>>> -
>>> -     if (cfs_rq->nr_running == 1)
>>>               check_enqueue_throttle(cfs_rq);
>>> +     }
>>>  }
>>>
>>>  static void __clear_buddies_last(struct sched_entity *se)
>>> @@ -4980,11 +4974,18 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>>>       /* update hierarchical throttle state */
>>>       walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
>>>
>>> -     /* Nothing to run but something to decay (on_list)? Complete the branch */
>>>       if (!cfs_rq->load.weight) {
>>> -             if (cfs_rq->on_list)
>>> -                     goto unthrottle_throttle;
>>> -             return;
>>> +             if (!cfs_rq->on_list)
>>> +                     return;
>>> +             /*
>>> +              * Nothing to run but something to decay (on_list)?
>>> +              * Complete the branch.
>>> +              */
>>> +             for_each_sched_entity(se) {
>>> +                     if (list_add_leaf_cfs_rq(cfs_rq_of(se)))
>>> +                             break;
>>> +             }
>>> +             goto unthrottle_throttle;
>>>       }
>>>
>>>       task_delta = cfs_rq->h_nr_running;
>>> @@ -5022,31 +5023,12 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>>>               /* end evaluation on encountering a throttled cfs_rq */
>>>               if (cfs_rq_throttled(qcfs_rq))
>>>                       goto unthrottle_throttle;
>>> -
>>> -             /*
>>> -              * One parent has been throttled and cfs_rq removed from the
>>> -              * list. Add it back to not break the leaf list.
>>> -              */
>>> -             if (throttled_hierarchy(qcfs_rq))
>>> -                     list_add_leaf_cfs_rq(qcfs_rq);
>>>       }
>>>
>>>       /* At this point se is NULL and we are at root level*/
>>>       add_nr_running(rq, task_delta);
>>>
>>>  unthrottle_throttle:
>>> -     /*
>>> -      * The cfs_rq_throttled() breaks in the above iteration can result in
>>> -      * incomplete leaf list maintenance, resulting in triggering the
>>> -      * assertion below.
>>> -      */
>>> -     for_each_sched_entity(se) {
>>> -             struct cfs_rq *qcfs_rq = cfs_rq_of(se);
>>> -
>>> -             if (list_add_leaf_cfs_rq(qcfs_rq))
>>> -                     break;
>>> -     }
>>> -
>>>       assert_list_leaf_cfs_rq(rq);
>>>
>>>       /* Determine whether we need to wake up potentially idle CPU: */
>>> @@ -5701,13 +5683,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>               /* end evaluation on encountering a throttled cfs_rq */
>>>               if (cfs_rq_throttled(cfs_rq))
>>>                       goto enqueue_throttle;
>>> -
>>> -               /*
>>> -                * One parent has been throttled and cfs_rq removed from the
>>> -                * list. Add it back to not break the leaf list.
>>> -                */
>>> -               if (throttled_hierarchy(cfs_rq))
>>> -                       list_add_leaf_cfs_rq(cfs_rq);
>>>       }
>>>
>>>       /* At this point se is NULL and we are at root level*/
>>> @@ -5731,21 +5706,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>               update_overutilized_status(rq);
>>>
>>>  enqueue_throttle:
>>> -     if (cfs_bandwidth_used()) {
>>> -             /*
>>> -              * When bandwidth control is enabled; the cfs_rq_throttled()
>>> -              * breaks in the above iteration can result in incomplete
>>> -              * leaf list maintenance, resulting in triggering the assertion
>>> -              * below.
>>> -              */
>>> -             for_each_sched_entity(se) {
>>> -                     cfs_rq = cfs_rq_of(se);
>>> -
>>> -                     if (list_add_leaf_cfs_rq(cfs_rq))
>>> -                             break;
>>> -             }
>>> -     }
>>> -
>>>       assert_list_leaf_cfs_rq(rq);
>>>
>>>       hrtick_update(rq);
