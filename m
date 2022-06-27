Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DC555D779
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiF0KNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiF0KNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:13:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CEA631D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:13:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l2so7615487pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bjmpDO+EZO0KvHA36KuaOy89MHPBaQ1uO4r5LOYgjz8=;
        b=lX5BzcQuAdzCWObYYTgfqpom4RhgUx//V6dCY0RrJucddmWDmV1DniDaqViomkuXyD
         kh6Eaqp++V+WcN7y0E9PK9pVTARWJEtVHlENHkyMis5kVLwYU+KQW8jiSFlJELx17ELl
         OblLKciYvT0uU7G6phlxnCmssfdzjhdNwexxEHEKUSfGb4pWXzcNb5s2ceElSNmp9cZS
         0zU3qLr0yc4oiHfQqcMTk1GqcWX9ibM2/XGGwg0wvgAjX+g51Q6G99NdLq06sbV8i2Il
         42hsBLU/LopdCjFwNCKeMBQ5xm5i8McGHcXt1gejTQj9CyCNDrQUmjtI6QnAnuHNVZi2
         NIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bjmpDO+EZO0KvHA36KuaOy89MHPBaQ1uO4r5LOYgjz8=;
        b=b8pjQ/vLToDLD+c8m5cZc1HN87if/zyl7osSTQanmHzG/xJfnMhi+WFGhBNaQCkyGX
         QqNGFcv7KBDkK4fKQ5COl1B4+fj9fvtWTftscWOqG63He9d7aGA9kwGHhApnXOunbXWE
         RbfgN0/iVLN2gAYGLzCCOuGFd596b9ljsf/IlphKW+6TkIjyVKCy5q+ao1DyAmTnpJHK
         1RvH1e6DtE/mgX4Nqx2knkvcWwvohGhOluaK5OwsVme2XXpcSQgM2rwqXJkQ8OzKRSjH
         wvDvphsU1UI/A5CjwMi+fPmg7lqyOcMtieM0Ame6PnF9n5Vir7ldKqsaH9Wug8FZ8VQQ
         K/VQ==
X-Gm-Message-State: AJIora8KAfnay2VKlez0AMKgXj9ZsyRVVHb4EghvJ5gkfDRGdgdnmSHP
        zUN4F4BjHM/6sdsoZXKUDS6vGg==
X-Google-Smtp-Source: AGRyM1sZ3aQKavMTMrAU6uWH7XKrwJDEv4OppmI6Z3JUIlg81Wfnw/3aq+1h1G4Th3YUzd/BajL0fg==
X-Received: by 2002:a17:90b:3505:b0:1ec:db5d:794b with SMTP id ls5-20020a17090b350500b001ecdb5d794bmr15334368pjb.24.1656324808763;
        Mon, 27 Jun 2022 03:13:28 -0700 (PDT)
Received: from [10.4.104.191] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903019100b00163de9e9342sm6923312plg.17.2022.06.27.03.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 03:13:28 -0700 (PDT)
Message-ID: <3e4d2594-f678-b77a-4883-0b893daf19f6@bytedance.com>
Date:   Mon, 27 Jun 2022 18:13:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 6/7] sched/fair: skip busy cores in SIS search
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-7-wuyun.abel@bytedance.com>
 <20220621181442.GA37168@chenyu5-mobl1>
 <543d55e1-fad8-3df3-8bae-d79c0c8d8340@bytedance.com>
 <20220624033032.GA14945@chenyu5-mobl1>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220624033032.GA14945@chenyu5-mobl1>
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


On 6/24/22 11:30 AM, Chen Yu Wrote:
>> ...
>>>> @@ -9273,8 +9319,40 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>>>    static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>>>>    {
>>>> -	if (sds->sd_state == sd_has_icpus && !test_idle_cpus(env->dst_cpu))
>>>> -		set_idle_cpus(env->dst_cpu, true);
>>>> +	struct sched_domain_shared *sd_smt_shared = env->sd->shared;
>>>> +	enum sd_state new = sds->sd_state;
>>>> +	int this = env->dst_cpu;
>>>> +
>>>> +	/*
>>>> +	 * Parallel updating can hardly contribute accuracy to
>>>> +	 * the filter, besides it can be one of the burdens on
>>>> +	 * cache traffic.
>>>> +	 */
>>>> +	if (cmpxchg(&sd_smt_shared->updating, 0, 1))
>>>> +		return;
>>>> +
>>>> +	/*
>>>> +	 * There is at least one unoccupied cpu available, so
>>>> +	 * propagate it to the filter to avoid false negative
>>>> +	 * issue which could result in lost tracking of some
>>>> +	 * idle cpus thus throughupt downgraded.
>>>> +	 */
>>>> +	if (new != sd_is_busy) {
>>>> +		if (!test_idle_cpus(this))
>>>> +			set_idle_cpus(this, true);
>>>> +	} else {
>>>> +		/*
>>>> +		 * Nothing changes so nothing to update or
>>>> +		 * propagate.
>>>> +		 */
>>>> +		if (sd_smt_shared->state == sd_is_busy)
>>>> +			goto out;
>>>> +	}
>>>> +
>>>> +	sd_update_icpus(this, sds->idle_cpu);
>>> I wonder if we could further enhance it to facilitate idle CPU scan.
>>> For example, can we propagate the idle CPUs in smt domain, to its parent
>>> domain in a hierarchic sequence, and finally to the LLC domain. If there is
>>
>> In fact, it was my first try to cache the unoccupied cpus in SMT
>> shared domain, but the overhead of cpumask ops seems like a major
>> stumbling block.
>>
>>> a cluster domain between SMT and LLC domain, the cluster domain idle CPU filter
>>> could benefit from this mechanism.
>>> https://lore.kernel.org/lkml/20220609120622.47724-3-yangyicong@hisilicon.com/
>>
>> Putting SIS into a hierarchical pattern is good for cache locality.
>> But I don't think multi-level filter is appropriate since it could
>> bring too much cache traffic in SIS,
> Could you please elaborate a little more about the cache traffic? I thought we
> don't save the unoccupied cpus in SMT shared domain, but to store it in middle
> layer shared domain, say, cluster->idle_cpus, this would reduce cache write
> contention compared to writing to llc->idle_cpus directly, because a smaller
> set of CPUs share the idle_cpus filter. Similarly, SIS can only scan the cluster->idle_cpus
> first, without having to query the llc->idle_cpus. This looks like splitting
> a big lock into fine grain small lock.

I'm afraid I didn't quite follow.. Did you mean replace the LLC filter
with multiple cluster filters? Then I agree with what you suggested
that the contention would be reduced. But there are other concerns:

   a. Is it appropriate to fake an intermediate sched_domain if
      cluster level doesn't available? How to identify the proper
      size of the faked sched_domain?

   b. The SIS path might touch more cachelines (multiple cluster
      filters). I'm not sure how much is the impact.

Whatever, this seems worth a try. :)

>> and it could be expected to be
>> a disaster for netperf/tbench or the workloads suffering frequent
>> context switches.
>>
> So this overhead comes from the NEWLY_IDLE case?
> 

Yes, I think it's the main cause to rise the contention to new heights.
But it's also important to keep the filter fresh.

Thanks & BR,
Abel
