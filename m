Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60FF592D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242170AbiHOJti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiHOJtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:49:32 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991DC22BEC
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:49:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 17so5926523plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=BCXqxA1iZkGnhJ2ThdyKfS81ld1ehxTyv7iteToL9Go=;
        b=qaoxoBXUvVJj0HHk/Fl+p1f0mKPh/jHVLJYCzaarm0O/LNSzNg4rye/+LSvXHbEZ6V
         TSqCfxbWX0mWC/3J+nuHr8xowZHRsbitF7Pzx7iggF1YZj00ryLp3SmX5YcPLGyEv3B4
         +n+FhFRBwoDntoB01sIprvq5GwgbSrjSERwJeHruMyShtQJZupEExZfTdCbxoTPGn84N
         AU0zFlrDxKoarzOqoda2Fl3D7lOwYk5QuCv8O4AejlhOaqjmLrbET7rnLkE9+aFXT9oU
         u3UfzOWING+2V+WDqmUSeJhxSd5r5L9mq3kFqSHKOpBeGzcxkcyoqsmoK79eaCkQp/GN
         xx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BCXqxA1iZkGnhJ2ThdyKfS81ld1ehxTyv7iteToL9Go=;
        b=uP9kIHLxTyUAg42k8bwhrNYJh+9EIrgBVbYMHesgEkVh65KqZ+9JAMh+MZmYl65MU3
         xRDrCEy5QWoUTPpP+LubYLK3apuoIu9hWdmLX9EYxeLkap/5oVxoLEvKpQP01bl3FFbC
         SeYUP1HvuDtMtw28psabfPQGiCtHopy7qMe129XFy8/qlj8nrX2sPF3LFuMuwvIvXKmZ
         afASKkNQnd941bqbUS3eGs1TcFfXBGOsOUYtAcvXrD0JmZB/S0s86ZRxCJMKACImxrKo
         0RiNly1f2Ehpn8uru8mue8UFgv/WquZ/Ml/zZlIib4ySUFlLyQ3vXFxQuXa640ZffyBf
         mDDQ==
X-Gm-Message-State: ACgBeo0zi3cE9bd+1hd215TIeFFuwgO8DY2WpEqFmCp7WCnnbfsT/EN4
        ZJSWsXKmgCe/Yp5NJX85n26KhjMJzdg56J/O
X-Google-Smtp-Source: AA6agR4JyC9R+djX9QH6QxGAgiedA3npgQ9Md1Djp6UQtqh/aQv83BhUw+zSlEhzY0oYgIk0eRBPZA==
X-Received: by 2002:a17:902:cece:b0:16e:ea30:6287 with SMTP id d14-20020a170902cece00b0016eea306287mr16350904plg.104.1660556971111;
        Mon, 15 Aug 2022 02:49:31 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b0016ee3d7220esm6671229plg.24.2022.08.15.02.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 02:49:30 -0700 (PDT)
Message-ID: <04cfb7ee-72dc-0a53-deb7-eaee6f0e9590@bytedance.com>
Date:   Mon, 15 Aug 2022 17:49:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v4 7/7] sched/fair: de-entropy for SIS filter
Content-Language: en-US
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-8-wuyun.abel@bytedance.com>
 <Ytg2oRUUpYmYYzCS@BLR-5CG11610CF.amd.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <Ytg2oRUUpYmYYzCS@BLR-5CG11610CF.amd.com>
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

On 7/21/22 1:08 AM, Gautham R. Shenoy Wrote:
> Hello Abel,
> 
> On Sun, Jun 19, 2022 at 08:04:51PM +0800, Abel Wu wrote:
>> Now when updating core state, there are two main problems that could
>> pollute the SIS filter:
>>
>>    - The updating is before task migration, so if dst_cpu is
>>      selected to be propagated which might be fed with tasks
>>      soon, the efforts we paid is no more than setting a busy
>>      cpu into the SIS filter. While on the other hand it is
>>      important that we update as early as possible to keep the
>>      filter fresh, so it's not wise to delay the update to the
>>      end of load balancing.
>>
>>    - False negative propagation hurts performance since some
>>      idle cpus could be out of reach. So in general we will
>>      aggressively propagate idle cpus but allow false positive
>>      continue to exist for a while, which may lead to filter
>>      being fully polluted.
> 
> Ok, so the false positive case is being addressed in this patch.
> 
>>
>> Pains can be relieved by a force correction when false positive
>> continuously detected.
>>
> [..snip..]
> 
>> @@ -111,6 +117,7 @@ struct sched_group;
>>   enum sd_state {
>>   	sd_has_icores,
>>   	sd_has_icpus,
>> +	sd_may_idle,
>>   	sd_is_busy
>>   };
>>   
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d55fdcedf2c0..9713d183d35e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
> 
> [...snip..]
> 
>> @@ -9321,7 +9327,7 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>>   {
>>   	struct sched_domain_shared *sd_smt_shared = env->sd->shared;
>>   	enum sd_state new = sds->sd_state;
>> -	int this = env->dst_cpu;
>> +	int icpu = sds->idle_cpu, this = env->dst_cpu;
>>   
>>   	/*
>>   	 * Parallel updating can hardly contribute accuracy to
>> @@ -9331,6 +9337,22 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>>   	if (cmpxchg(&sd_smt_shared->updating, 0, 1))
>>   		return;
>>   
>> +	/*
>> +	 * The dst_cpu is likely to be fed with tasks soon.
>> +	 * If it is the only unoccupied cpu in this domain,
>> +	 * we still handle it the same way as as_has_icpus
>                                                ^^^^^^^^^^^^^
> Nit:                                          sd_has_icpus

Will fix.

> 
>> +	 * but turn the SMT into the unstable state, rather
>> +	 * than waiting to the end of load balancing since
>> +	 * it's also important that update the filter as
>> +	 * early as possible to keep it fresh.
>> +	 */
>> +	if (new == sd_is_busy) {
>> +		if (idle_cpu(this) || sched_idle_cpu(this)) {
>> +			new = sd_may_idle;
>> +			icpu = this;
>> +		}
>> +	}
>> +
>>   	/*
>>   	 * There is at least one unoccupied cpu available, so
>>   	 * propagate it to the filter to avoid false negative
>> @@ -9338,6 +9360,12 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>>   	 * idle cpus thus throughupt downgraded.
>>   	 */
>>   	if (new != sd_is_busy) {
>> +		/*
>> +		 * The sd_may_idle state is taken into
>> +		 * consideration as well because from
>> +		 * here we couldn't actually know task
>> +		 * migrations would happen or not.
>> +		 */
>>   		if (!test_idle_cpus(this))
>>   			set_idle_cpus(this, true);
>>   	} else {
>> @@ -9347,9 +9375,26 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>>   		 */
>>   		if (sd_smt_shared->state == sd_is_busy)
>>   			goto out;
>> +
>> +		/*
>> +		 * Allow false positive to exist for some time
>> +		 * to make a tradeoff of accuracy of the filter
>> +		 * for relieving cache traffic.
>> +		 */
> 
> I can understand allowing the false positive to exist when there are
> no other idle CPUs in this SMT domain other than this CPU, which is
> handled by the case where new != sd_is_busy in the current
> load-balance round and will be handled by the "else" clause in the
> subsequent round if env->dst_cpu ends up becoming busy.
> 

Yes.

> 
> However, when we know that new == sd_is_busy and the previous state of
> this SMT domain was sd_has_icpus, should we not immediately clear this
> core's cpumask from the LLCs icpus mask? What is the need for the
> intermediate sd_may_idle state transition between sd_has_icpus and
> sd_is_busy in this case ?
> 

The thought was to make addition more aggressive than deletion to the
filter to try to avoid real idle cpus being out of reach. Take short
running tasks for example, the cpus in this newly-busy SMT domain can
become idle multiple times during next balancing period, which won't
be selected if update to sd_is_busy intermediately. While for the non-
short running workloads, the only downside is sacrificing the filter's
accuracy for a short while.

IOW, temporarily containing false positive cpus in the filter is more
acceptable than missing some real idle ones which would cause throughput
reduced. Besides, in this way the cache traffic can be relieved more
or less.

> 
> 
>> +		if (sd_smt_shared->state == sd_has_icpus) {
>> +			new = sd_may_idle;
>> +			goto update;
>> +		}
>> +
>> +		/*
>> +		 * If the false positive issue has already been
>> +		 * there for a while, a correction of the filter
>> +		 * is needed.
>> +		 */
>>   	}
>>   
>>   	sd_update_icpus(this, sds->idle_cpu);
>                                ^^^^^^^^^^^^^^
> 
> I think you meant to use icpu here ?  sds->idle_cpu == -1 in the case
> when new == sd_may_idle. Which will end up clearing this core's
> cpumask from this LLC's icpus mask. This defeats the
> "allow-false-positive" heuristic.
> 

Nice catch, will fix.

Thanks & Best Regards,
Abel
