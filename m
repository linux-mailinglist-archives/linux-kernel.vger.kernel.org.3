Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EF755F816
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiF2HGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiF2HGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:06:31 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC141ED
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:05:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o18so13274091plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Bkw660lB7cgN92zSmZk8SWD8hahd63CGP6vX0nGo9UU=;
        b=E7RNLQXKMSjIdj1ctIvW5y6/2BwpzW3Fm0YP+Q+wZimtig3UwfjNuGMeoCP9hwKWFm
         GOJcDSqx39/4KW/TOGacl+I+AIfE7VQAzt2jFpq/YJBXERNMfhCS1y8k8zkRcY10qb7a
         LOgtDcHUzYOHNQZdUz+8c5ux0cVzEuZp6zDOFe4teGL6fnfJ6uHnG/DxxIZcTnTTB0+G
         yO7DLUzOFgTCIK6PxTGCeZq3e1QCWEDeSjVz7iYSlKCi8v8hJRX92lgBOj0ynza1l6EI
         pwVvXNM6iU9Obj3eESbi5IHim2Z1aDW8BTHDCJJO7lzqpegxCpaXoZ8P/s39Q6kK1uD1
         a4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bkw660lB7cgN92zSmZk8SWD8hahd63CGP6vX0nGo9UU=;
        b=TMiGkUnHL9x4tLm3vwU2yl7itrhjjvjWrJrzHD8KmX6aOWinvV1BPrd99OSOYwRMkT
         ZMztMmXHBnGlZyIDLeIdXK8yMdDmYRiGKPy4zg1BcVCUtkbjICcpSbQhn1H0YSaL3sYT
         gukL10nfz+GHQSY827ee+qvVbb3tOUn9ki2xO1t+rYMU3Kjm/XnN2+VCP2B2CQ+8RVdE
         XQw2P1Pwp0Xg54a+ljR0Wx0rR7+bZFqk0AFULUF38w9YfxYTcE9KtNKHefm5Uz6fGGwb
         9NijTOrm7G/OkTqvtrv7buWp08fRojKiqP59oj3nZHKkfd8YmGfXjLMqbcSU99yeev9d
         /DVA==
X-Gm-Message-State: AJIora9hNa8BVJqEOPVbffrE9fszUxMbQYLcrwqRULixUaUAqTgoJwM9
        O2Cd9SRWLBemAbQd6cnV4AhO+w==
X-Google-Smtp-Source: AGRyM1vruM1Fu7EwLCkyu+hgXypEU0y18gI6mrMSNR3lkJCm3Zwt/fMNfxthDoeJGwFGZlwE81qGaw==
X-Received: by 2002:a17:90a:d80b:b0:1ec:9a1a:2266 with SMTP id a11-20020a17090ad80b00b001ec9a1a2266mr2272597pjv.7.1656486316053;
        Wed, 29 Jun 2022 00:05:16 -0700 (PDT)
Received: from [10.4.105.52] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b0015eab1b097dsm10558204pln.22.2022.06.29.00.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 00:05:15 -0700 (PDT)
Message-ID: <d9be50f1-087e-d854-ed54-88731f4d5335@bytedance.com>
Date:   Wed, 29 Jun 2022 15:05:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 5/7] sched/fair: skip SIS domain search if fully busy
Content-Language: en-US
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-6-wuyun.abel@bytedance.com>
 <CABk29NtsTgJT1c-Vg6B5dgYbi+nHEDk2vsBRzRowCXiOPT2qnA@mail.gmail.com>
 <c353f360-e630-ea29-2045-1a9f005d033d@bytedance.com>
 <CABk29NuSONYdmLqUDbJKQfwF3tf1Uv3Yy+WbHkh_gY5FXti1cA@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CABk29NuSONYdmLqUDbJKQfwF3tf1Uv3Yy+WbHkh_gY5FXti1cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/29/22 9:11 AM, Josh Don Wrote:
> On Mon, Jun 27, 2022 at 11:53 PM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>>>>
>>>> -static inline bool test_idle_cores(int cpu)
>>>> +static inline enum sd_state sd_get_state(int cpu)
>>>>    {
>>>>           struct sched_domain_shared *sds;
>>>>
>>>>           sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>>>>           if (sds)
>>>> -               return READ_ONCE(sds->has_idle_cores);
>>>> +               return READ_ONCE(sds->state);
>>>>
>>>> -       return false;
>>>> +       return sd_has_icpus;
>>>> +}
>>>
>>> Why is default not sd_is_busy?
>>
>> The state of sd_is_busy will prevent us from searching the LLC. By
>> design, both sd_has_icores and sd_is_busy indicate deterministic
>> status: has idle cores / no idle cpu exists. While sd_has_icpus is
>> not deterministic, it means there could be unoccupied cpus.
>>
>> The naming seems misleading, it would be nice to have other options.
> 
> sd_has_icores isn't deterministic; when the last fully idle core gets
> an occupied sibling, it will take until the next select_idle_cpu() to
> mark the state as sd_has_icpus instead.

Yes, it's not deterministic in nature, but we treat it as deterministic.
As long as sd_has_icores, a full scan will be fired no matter there are
any idle cores or not.

> 
> A comment here and also at the enum definitions would be helpful I think.

Agreed. I will add some comments here. State descriptions are already
above their definitions, please let me know if any modification needed.

> 
>>>
>>>> +
>>>> +static inline void set_idle_cores(int cpu, int idle)
>>>
>>> nit: Slightly confusing to call the param 'idle', since in the case it
>>> is false we still mark icpus. Consider possibly 'core_idle'.
>>
>> What about changing the param 'cpu' to 'core'?
> 
> I think keeping it as "cpu" is fine, since as "core" that would imply
> some per-core state (when we're still setting this per-cpu).

The function has already been there for a long time, and I haven't
changed its semantics, so maybe it isn't that confusing.. Does the
following naming make things clearer?

static inline void set_idle_cores(int cpu, int has_icores);
static inline void set_idle_cpus(int cpu, int has_icpus);

> 
>>>>           for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>>>>                   struct rq *rq = cpu_rq(i);
>>>> @@ -8692,6 +8740,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>>>                   nr_running = rq->nr_running;
>>>>                   sgs->sum_nr_running += nr_running;
>>>>
>>>> +               if (update_core)
>>>> +                       sd_classify(sds, rq);
>>>> +
>>>>                   if (nr_running > 1)
>>>>                           *sg_status |= SG_OVERLOAD;
>>>>
>>>> @@ -9220,6 +9271,12 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>>>           return idlest;
>>>>    }
>>>>
>>>> +static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>>>> +{
>>>> +       if (sds->sd_state == sd_has_icpus && !test_idle_cpus(env->dst_cpu))
>>>> +               set_idle_cpus(env->dst_cpu, true);
>>>> +}
>>>
>>> We're only setting state to has_icpus here in sd_update_state. That
>>> doesn't feel good enough, since we're only updating state for
>>> env->dst_cpu; all the other per-cpu state will remain stale (ie.
>>> falsely sd_is_busy).
>>
>> It's LLC-wide shared :)
> 
> Oh wow, yea that's the thing I missed... Thanks.
> 
>>> I think you also want a case in __update_idle_core() to call
>>> set_idle_cores(core, 0) in the case where we have a non-idle sibling,
>>> since we want to at least mark has_icpus even if the entire core isn't
>>> idle.
> 
> More specifically, in the __update_idle_core() function, if the
> sibling is still busy and the sd_state is sd_is_busy, we should
> instead mark it as sd_has_icpus, since the current cpu is guaranteed
> to be going idle.

The sd_is_busy state will be cleared during newidle balance. And the
state should not set back to is_busy between the gap before the cpu
actually goes idle.

> 
> Additionally, to be consistent with what we're calling "idle"
> elsewhere, I think you mean to have __update_idle_core() check either
> available_idle_cpu() or sched_idle_cpu()?

I think the condition should be aligned with SIS that an unoccupied
cpu satisfies "idle_cpu(cpu) || sched_idle_cpu(cpu)". The function
available_idle_cpu() is not used in load balancing due to its not
being used immediately.

Thanks & BR,
Abel
