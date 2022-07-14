Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE093574564
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiGNG71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiGNG7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:59:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EB32B18E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:59:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p9so1789509pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ow4XbAB1kGJrqkjsozYWdg/Tqr2cl2cAwtPRj5iANg0=;
        b=e49Dx/FgmmC+u0cLfWEccN+STzae4HNxpR12zfpRrKatQl+teVi5WpoTNVO21UMmGH
         xHRWi9659SKfCisk8E6rbyvNAHcdP5Xslm+djwK7ibmtNwO1NIKU5eF20IwueieZ9D0T
         M/Jn0KkrcRWUb9b29bS+UEe5JJjVwmnYymKoQM3Ytt6QiFxyrlbaWIMTuSUk7ppYAPcC
         bMtXZUMtAg3yKpHZaAW43CXWLShmAmsLwe9KC6QSgyHl0crTRhaRiucm2UJbd5NWXFUS
         si1uopG+eL1Mj8J8a6/Vt+rG5LSLCzw+lVrC/tyNkZVpXgGyLPQs3C00Tnfs91/3L3xH
         OaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ow4XbAB1kGJrqkjsozYWdg/Tqr2cl2cAwtPRj5iANg0=;
        b=e9zSvoqnpJrYICLMA3RL256XFw6FUPXKppKdnGazu3bdZCPbBS+nBLIZV7iYGyb4Vr
         dTfSYdbNEf2Poxj4Ni/MvZZAEdWB7Sx19lh1ecyRMklMdGK6tE5H0wQ9y+JRXAp0hCJf
         O3gcvN95bcArH+uNsOEkN95wYHr97XuEEUQqYQZ4dpsr+8mB1OccOtlIa1yO9LX5oQvm
         KT0HY0IWZaP1mc0RV+isVQbNPe2/a4a7Xj59LGBCPLtdoQp4HLdLwuv40b/jqK20QPri
         i9kkshv4vQwSdP9ly4IPkcViop5ZQQ25twMJou7aAAkZJvMHyU9uHfHyi340Nx9ht3Vh
         SPrA==
X-Gm-Message-State: AJIora889cZWBJfW91tUcT20HbvO+bn0lVdW3lvyr5QHqv50obdy6HDs
        YLeG+24iOxh1Dzkti8YZCGe4iw==
X-Google-Smtp-Source: AGRyM1u+gj9QBnJGI7/EAHFZOzjWarTZdvd5rjA0Jt4p+UND+USOG0cyqCXj3ZER6khMHYSjmZmCxw==
X-Received: by 2002:a17:90a:bc95:b0:1ef:8b48:fa0b with SMTP id x21-20020a17090abc9500b001ef8b48fa0bmr14273066pjr.189.1657781945443;
        Wed, 13 Jul 2022 23:59:05 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id h19-20020a631213000000b003fcf1279c84sm522567pgl.33.2022.07.13.23.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 23:59:05 -0700 (PDT)
Message-ID: <4dde05be-8470-5984-0a30-ba077b9fe6bd@bytedance.com>
Date:   Thu, 14 Jul 2022 14:58:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Content-Language: en-US
To:     Yicong Yang <yangyicong@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     yangyicong@hisilicon.com, Josh Don <joshdon@google.com>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <8e7d75d4-613e-f35e-e932-323789666fb1@huawei.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <8e7d75d4-613e-f35e-e932-323789666fb1@huawei.com>
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


On 7/14/22 2:19 PM, Yicong Yang Wrote:
> On 2022/7/12 16:20, Abel Wu wrote:
>> When SIS_UTIL is enabled, SIS domain scan will be skipped if
>> the LLC is overloaded. Since the overloaded status is checked
>> in the load balancing at LLC level, the interval is llc_size
>> miliseconds. The duration might be long enough to affect the
>> overall system throughput if idle cores are out of reach in
>> SIS domain scan.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   kernel/sched/fair.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index a78d2e3b9d49..cd758b3616bd 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6392,16 +6392,19 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>   	struct sched_domain *this_sd;
>>   	u64 time = 0;
>>   
>> -	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>> -	if (!this_sd)
>> -		return -1;
>> -
>>   	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>>   
>> -	if (sched_feat(SIS_PROP) && !has_idle_core) {
>> +	if (has_idle_core)
>> +		goto scan;
>> +
>> +	if (sched_feat(SIS_PROP)) {
>>   		u64 avg_cost, avg_idle, span_avg;
>>   		unsigned long now = jiffies;
>>   
>> +		this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>> +		if (!this_sd)
>> +			return -1;
>> +
> 
> I don't follow the change here. True that this_sd is used only in SIS_PROP, but it seems irrelevant with your
> commit. Does the position of this make any performance difference?

No, this change doesn't make much difference to performance. Are
you suggesting that I should make this a separate patch?

Thanks,
Abel

> 
> Thanks.
> 
>>   		/*
>>   		 * If we're busy, the assumption that the last idle period
>>   		 * predicts the future is flawed; age away the remaining
>> @@ -6436,7 +6439,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>   				return -1;
>>   		}
>>   	}
>> -
>> +scan:
>>   	for_each_cpu_wrap(cpu, cpus, target + 1) {
>>   		if (has_idle_core) {
>>   			i = select_idle_core(p, cpu, cpus, &idle_cpu);
>>
