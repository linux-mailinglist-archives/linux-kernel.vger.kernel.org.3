Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78E64C45E8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbiBYNUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiBYNUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:20:45 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A621FED99
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:20:12 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s1so4765648plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ChkwFL8B5MC3m/eSD6MJ5bgkvknISjdcFMOClKl9M+A=;
        b=3lDS8ITYSQzc4t/MoZwjwd9kXkkPbxvy3yAos1ivFoos5fGMwLgYiCZnw3DHuwS273
         X5VfWPumOFkVvWMv9Sz3eHYKQ9pIsFLhCXlCo6hT8x5XeZiGEOArhTULVbQuqI7eZSpv
         cUtFEuUYztIsktCAy58m+P3zW5t6BTRT8mF3e2tae0swpuH3vo07bag9uY/J1IqLT0vN
         HZoBnyKWa/WO+yHdBiJsg+MqpovmLhZTLuxzAxXcShcCBX5QY6hHc2YPY4aDd0mMLee6
         cGGYkaIYgMaDtRCoi0N3EwfiBkKgOfxyUPQYAaFCTvD6R2vyCQHcIQJZ1xsKSZPNSrQx
         jgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ChkwFL8B5MC3m/eSD6MJ5bgkvknISjdcFMOClKl9M+A=;
        b=IVZLjCaZTwklluROrw9fqsWyGWE7UYlqTfCqTAvLoe56Y+Ra2w5rfV9i1bm5FAHcDe
         HWeSNu6IJ4jMQn5S31iDHp8UHKssX9bnpRyES1RSfhy4IEQcZ6LPutc/4FfeLHyuDspZ
         HKiHJH0IWDPgRuiiJBHmT8owI3X9YbGNTsz9X36XBnEbpMe9pZIngW7BSApJufC7rDi7
         19G5N9b88KYUBqlXl4QmwgZyOluHjrffbO7polUQm507ml3zvo/FCeAx55KmDj/tsZuA
         FDFLTjKUDAw5bpGj/HcgEjuiiKk3ehSzkNMkJCLZqxMDrDXVIsIuP/yCf+X11I7Kqlsv
         Yi7w==
X-Gm-Message-State: AOAM533/8ud1ln0huxcB8f/P7X/Gr24fa0gpTYp8na6z/JcRqb5nqIDd
        xe9abfrLRPb3zLLFYxa7i5ThVQ==
X-Google-Smtp-Source: ABdhPJyAXFYgNPAcXyTpNpKQrdaKv3KKSnlrnzoYcDCWqZtffJETS6FI8paRP0KQ5mY/V3i7Z5+c1Q==
X-Received: by 2002:a17:90a:dd45:b0:1bc:9466:9b64 with SMTP id u5-20020a17090add4500b001bc94669b64mr3167146pjv.23.1645795211652;
        Fri, 25 Feb 2022 05:20:11 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id j16-20020a63e750000000b00373598b8cbfsm2717032pgk.74.2022.02.25.05.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 05:20:10 -0800 (PST)
Message-ID: <6737ab1a-a794-7e06-fbb1-8f154c4e901b@bytedance.com>
Date:   Fri, 25 Feb 2022 21:20:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/5] introduce sched-idle balancing
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
 <20220224164711.GA4363@suse.de>
 <99805673-50a1-78cd-b710-0f00ce7de809@bytedance.com>
 <20220225101625.GB4363@suse.de>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220225101625.GB4363@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel, thanks a lot for your review!

On 2/25/22 6:16 PM, Mel Gorman Wrote:
> On Fri, Feb 25, 2022 at 04:15:06PM +0800, Abel Wu wrote:
>>> As the overloaded mask may be updated on each idle, it could be a
>>> significant source of cache misses between CPUs sharing the domain for
>>> workloads that rapidly idle so there should be data on whether cache misses
>>> are increased heavily. It also potentially delays the CPU reaching idle
>>> but it may not be by much.
>>
>> Yes, that's why I cached overloaded status in rq->overloaded. So in
>> this case of short running tasks, when cpus rapidly/frequently go
>> idle, the cpumask/counter are not actually updated if the cached
>> status is already 0 (not overloaded).
>>
> 
> Which is a good idea in some respects. It tries to limit the number of
> updates and treats it as a boolean but it's probably prone to races.
> 
>>> The filter may be out of date. It takes up to one tick to detect
>>> overloaded and the filter to have a positive impact. As a CPU is not
>>> guaranteed to enter idle if there is at least one CPU-bound task, it may
>>> also be up to 1 tick before the mask is cleared. I'm not sure this is a
>>> serious problem though as SIS would not pick the CPU with the CPU-bound
>>> task anyway.
>>
>> Yes, it can be out of date, but increasing the accuracy means more
>> frequent update which would introduce cache issues you mentioned
>> above. Rate limit the updating to tick at the LLC basis might be an
>> acceptable tradeoff I presume.
>>
>>>
>>> At minimum, the filter should be split out and considered first as it
>>> is the most likely reason why a performance difference was measured. It
>>> has some oddities like why nr_overloaded is really a boolean and as
>>> it's under rq lock, it's not clear why it's atomic. The changelog
>>> would ideally contain some comment on the impact to cache misses
>>> if any and some sort of proof that SIS search depth is reduced which
>>> https://lore.kernel.org/lkml/20210726102247.21437-2-mgorman@techsingularity.net/
>>> may be some help.
>>>
>>> At that point, compare the idle task balancing on top to isolate how
>>> much it improves things if any and identify why existing balancing is
>>> insufficient. Split out the can_migrate_task change beforehand in case it
>>> is the main source of difference as opposed to the new balancing mechanism.
>>>
>>
>> The nr_overloaded sits in shared domain structure thus shared in
>> LLC domain and needs to be atomic_t, while rq->overloaded is a
>> boolean updated under rq lock. Maybe the naming can cause some
>> confusion, please lighten me up if you have better idea :)
>>
> 
> The naming doesn't help because it's not really "the number of overloaded
> rq's". atomic_t would be slightly safer against parallel updates but
> it's race prone. I didn't think about it deeply but I suspect that two
> separate rq's could disagree on what the boolean value should be if one rq
> is overloaded, the other is not and they are updating via the idle path at
> the same time. This probably can happen because the locking is rq based
> and the cpumask is shared. On the flip side, making it an accurate count
> would result in more updates and incur cache misses as well as probably
> needing a cpumask check instead of a nr_overloaded comparison to determine
> if the rq is already accounted for so it costs more. You are very likely
> trading accuracy versus cost of update.

The boolean value (rq->overloaded) is accessed under rq lock, and almost
accessed by its own rq except the very rare case in sched_idle_balance()
where a double check failed on cfs_rq_overloaded(). So this value should
be accurate and has good data locality.

But as you said, the nr_overloaded and cpu mask are race prone in the
following pattern in my patches:

	if (nr_overloaded > 0)
		/* nr_overloaded can be zero now */
		read(overloaded_mask);

since the mask is accessed without rq locked, the cost might not be too
much. This is quite similar with the idle_cpu() usage in SIS I guess.

> 
> Whichever choice you make, add comments on the pros/cons and describe
> the limitation of either approach. e.g. if overloaded is effectively a
> boolean, describe in a comment the limitations.

OK, will do.

> 
>> And yes, I agree it would be nice if test result on SIS search
>> depth can be shown, and I actually did the test, but the result
>> didn't show a reduction in depth due to sched-idle balancing
>> will also consume sched-idle/idle cpus. I will apply your patch
>> and make some further tests on that, thanks.
>>
> 
> Just remember to use the patch to measure changes in SIS depth but
> performance figures should not include the patch as the schedstat
> overhead distorts results.

Yes, agreed.

> 
> Also place the filter first and do any measurements of any change to
> balancing versus the filter. I'm suggesting placing the filter first
> because it's less controversial than a new balancer. Just be aware that
> the filter alone is not a guarantee of merging as there have been a few
> approaches to filtering and so far all of them had downsides on either cost

Yes, understood. I will adjust the patches as you suggested and send v2
together with more tests next week.

> or accuracy. IIRC the only active approach to reducing search cost in SIS
> is https://lore.kernel.org/all/20220207034013.599214-1-yu.c.chen@intel.com/
> and it's likely to get a new version due to
> https://lore.kernel.org/all/20220207135253.GF23216@worktop.programming.kicks-ass.net/.
> It also updates sched_domain_shared but with a single boolean instead of
> an atomic+cpumask.
> 

Chen Yu's patch disables idle cpu searching in SIS when the LLC domain
is overloaded (that is 85% capacity usage) and Peter suggested him use
this metric to replace/improve SIS_PROP feature to make search depth
varying gently.

I don't think either of the two approaches conflict with mine, as they
are to reduce the effort of searching when system is busy and cpus are
not likely to be idle, and mine is to consume sched-idle/idle cpus by
themselves by pulling non-idle tasks from overloaded rqs so there will
be fewer sched-idle/idle cpus.

Thanks and best regards,
	Abel
