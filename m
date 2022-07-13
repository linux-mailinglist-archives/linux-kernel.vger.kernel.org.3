Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BE5573AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbiGMQOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbiGMQOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:14:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6A50046
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:14:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e16so10636374pfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zVb0AXgDy5WTUVVpyifwCxe4LQIJemPu4zWD+4Tz1EE=;
        b=ddrrK2MTjpPKNPNONuAMhoq2PiFTAoln1LCwANaeT2TFNQk0a2r4WhC2n4lonnirsD
         QR5KtgdYOJgPiBir9ZaXsWJGc/+x/dCe3XAzyNt61jpn1JzUnMHsge+Z0zqWDPVncSoq
         cpS6h4KDUK7jwQ/YOI1H2vwpetlGivZ4ELcNADOkVl76tR9n42Inu6ASQlCHbK8JF57N
         QqiYrufzl/x3z5JqJRi2QB1tTsAPspH0N81e8uHXXJQiF50ZVt/7x3Hw2lO66bQayObG
         Z3dMjS9Qw7H8VQBbTy6SljUeSWSI1huAdJ+wHx8fh4tTUgfGYN72BcfT9CzJU4XNtSmp
         DtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zVb0AXgDy5WTUVVpyifwCxe4LQIJemPu4zWD+4Tz1EE=;
        b=Xm3B/izDm04DyBcQTMIgeDlG+dV8gAFMLwP8/PKv/Qn0bDrtS+XeNmX8hdNyCY0xJL
         /Bde+RmdcPl66hLkSNQgZI9Veca2JfnghW5SEjq5SEifKa7NPUSVD+Ywkigg2Epgf7c+
         dYBxFVZvbJ1rVi4S/D/ebqv5mniOeivNEFKy/cFujzH0dR3Ee2H2gFjY7BmGyNRLbIDz
         x214hCQVjLAHcFhmWPoerXzzPlqgUAKSoPw/6IalCEPZJHzubohu1ZG7sy3jCzLLBp3R
         lrHhclw4ymZCPUDubwdF78SIX3050K48l8/pmIncAyfGMPRgE8jOB8ZTv82vD/XVpfbw
         sMOw==
X-Gm-Message-State: AJIora9BcbmEFmqpt6SxjCN1iMz0VTiPuKltu5+eQ8AAUNxzxIhflLmE
        cMFYTuPurq5i6H8AgzDcA5mY3A==
X-Google-Smtp-Source: AGRyM1tNbuYLU/i4dpn/oK54WJKz+er/+EV/Jew/aQaGDoYpnknI7w7mI2VP5CNYEMckJofTliFf3A==
X-Received: by 2002:a63:164e:0:b0:411:ce18:5532 with SMTP id 14-20020a63164e000000b00411ce185532mr3693989pgw.55.1657728874573;
        Wed, 13 Jul 2022 09:14:34 -0700 (PDT)
Received: from [10.4.113.6] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b0016be96e07d1sm9099601plh.121.2022.07.13.09.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 09:14:34 -0700 (PDT)
Message-ID: <eaa543fa-421d-2194-be94-6a5e24a33b37@bytedance.com>
Date:   Thu, 14 Jul 2022 00:14:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <20220713034708.GA23431@chenyu5-mobl1>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220713034708.GA23431@chenyu5-mobl1>
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


On 7/13/22 11:47 AM, Chen Yu Wrote:
> On Tue, Jul 12, 2022 at 04:20:32PM +0800, Abel Wu wrote:
>> When SIS_UTIL is enabled, SIS domain scan will be skipped if
>> the LLC is overloaded. Since the overloaded status is checked
>> in the load balancing at LLC level, the interval is llc_size
>> miliseconds. The duration might be long enough to affect the
>> overall system throughput if idle cores are out of reach in
>> SIS domain scan.
> The idle core scan was skipped in SIS_UTIL because we saw better
> improvement in some benchmarks. But yes, we could make has_idle_core
> to scan anyway no matter what the system load is, if we have some
> data to support it. I'll test this patch on top of latest sched/core
> branch to see if this makes a difference.

I did some benchmark in my machine: netperf showed ~3% regression
and considerable improvement in hackbench pipe.

Maybe there are some workload benefit from selecting the recent
cpus rather than idle ones, but I don't think the recent_cpu can
out-perform the idle core much, since the two cpus still share
LLC cache and idle core has more capacity than idle cpu. Besides
this case, idle cores usually are better choices I think. So it
might worth a full scan if idle cores are available.

Thanks,
Abel

-------8<---

Tests are done in an Intel Xeon(R) Platinum 8260 CPU@2.40GHz machine
with 2 NUMA nodes each of which has 24 cores with SMT2 enabled, so 96
CPUs in total.

All of the benchmarks are done inside a normal cpu cgroup in a clean
environment with cpu turbo disabled.

Based on tip sched/core c02d5546ea34 (v5.19-rc2).

1) hackbench-process-pipes

Amean     1        0.2307 (   0.00%)      0.2277 (   1.30%)
Amean     4        0.6277 (   0.00%)      0.6037 (   3.82%)
Amean     7        0.7897 (   0.00%)      0.7710 *   2.36%*
Amean     12       1.2067 (   0.00%)      1.3087 (  -8.45%)
Amean     21       2.6717 (   0.00%)      2.5077 (   6.14%)
Amean     30       5.0893 (   0.00%)      3.9610 (  22.17%)
Amean     48       9.2407 (   0.00%)      7.4030 *  19.89%*
Amean     79       9.5607 (   0.00%)      9.3960 (   1.72%)
Amean     110     10.6053 (   0.00%)     10.6453 (  -0.38%)
Amean     141     12.8210 (   0.00%)     12.5253 (   2.31%)
Amean     172     14.9777 (   0.00%)     14.4317 (   3.65%)
Amean     203     18.1320 (   0.00%)     16.9753 *   6.38%*
Amean     234     20.1207 (   0.00%)     19.0730 *   5.21%*
Amean     265     22.7037 (   0.00%)     21.7953 (   4.00%)
Amean     296     25.6753 (   0.00%)     23.6877 *   7.74%*

2) hackbench-process-sockets

Amean     1        0.4223 (   0.00%)      0.4300 (  -1.82%)
Amean     4        1.4470 (   0.00%)      1.4593 *  -0.85%*
Amean     7        2.4803 (   0.00%)      2.4843 (  -0.16%)
Amean     12       4.1457 (   0.00%)      4.1170 *   0.69%*
Amean     21       7.0223 (   0.00%)      7.0053 (   0.24%)
Amean     30       9.9570 (   0.00%)      9.8683 *   0.89%*
Amean     48      16.0213 (   0.00%)     15.6657 *   2.22%*
Amean     79      26.8140 (   0.00%)     26.3657 *   1.67%*
Amean     110     37.3530 (   0.00%)     36.8800 *   1.27%*
Amean     141     47.6123 (   0.00%)     47.1627 (   0.94%)
Amean     172     57.6757 (   0.00%)     57.1430 *   0.92%*
Amean     203     68.2310 (   0.00%)     67.6030 (   0.92%)
Amean     234     78.1990 (   0.00%)     77.7073 *   0.63%*
Amean     265     88.9657 (   0.00%)     87.9833 *   1.10%*
Amean     296     99.8617 (   0.00%)     98.1073 *   1.76%*

3) hackbench-thread-pipes

Amean     1        0.2650 (   0.00%)      0.2807 (  -5.91%)
Amean     4        0.6650 (   0.00%)      0.6257 *   5.91%*
Amean     7        0.8283 (   0.00%)      0.8207 (   0.93%)
Amean     12       1.3343 (   0.00%)      1.3050 (   2.20%)
Amean     21       3.7053 (   0.00%)      2.7530 *  25.70%*
Amean     30       7.2817 (   0.00%)      4.2013 *  42.30%*
Amean     48       9.9037 (   0.00%)      8.8483 *  10.66%*
Amean     79      10.0790 (   0.00%)     10.1603 (  -0.81%)
Amean     110     11.5837 (   0.00%)     11.1297 (   3.92%)
Amean     141     13.4760 (   0.00%)     12.9903 (   3.60%)
Amean     172     16.2357 (   0.00%)     15.5903 (   3.97%)
Amean     203     18.2873 (   0.00%)     17.8690 (   2.29%)
Amean     234     21.2920 (   0.00%)     20.4680 (   3.87%)
Amean     265     23.9393 (   0.00%)     22.3933 *   6.46%*
Amean     296     26.6683 (   0.00%)     26.1260 (   2.03%)

4) hackbench-thread-sockets

Amean     1        0.4700 (   0.00%)      0.4437 (   5.60%)
Amean     4        1.4837 (   0.00%)      1.4960 (  -0.83%)
Amean     7        2.5497 (   0.00%)      2.5240 *   1.01%*
Amean     12       4.2473 (   0.00%)      4.2137 *   0.79%*
Amean     21       7.2530 (   0.00%)      7.1800 *   1.01%*
Amean     30      10.1973 (   0.00%)     10.1483 (   0.48%)
Amean     48      16.2163 (   0.00%)     16.0870 *   0.80%*
Amean     79      27.4460 (   0.00%)     27.0770 *   1.34%*
Amean     110     38.1103 (   0.00%)     37.5573 *   1.45%*
Amean     141     48.4513 (   0.00%)     48.0347 (   0.86%)
Amean     172     59.4410 (   0.00%)     58.4020 *   1.75%*
Amean     203     70.0873 (   0.00%)     69.0470 *   1.48%*
Amean     234     80.3570 (   0.00%)     79.4163 *   1.17%*
Amean     265     91.8550 (   0.00%)     90.3417 *   1.65%*
Amean     296    102.7420 (   0.00%)    100.8933 *   1.80%*

5) netperf-udp

Hmean     send-64         210.14 (   0.00%)      202.26 *  -3.75%*
Hmean     send-128        418.23 (   0.00%)      404.14 *  -3.37%*
Hmean     send-256        821.31 (   0.00%)      789.94 *  -3.82%*
Hmean     send-1024      3161.96 (   0.00%)     3025.23 *  -4.32%*
Hmean     send-2048      5959.67 (   0.00%)     5725.35 *  -3.93%*
Hmean     send-3312      9196.99 (   0.00%)     8830.47 *  -3.99%*
Hmean     send-4096     11061.30 (   0.00%)    10675.83 *  -3.48%*
Hmean     send-8192     17320.16 (   0.00%)    17601.11 *   1.62%*
Hmean     send-16384    27936.12 (   0.00%)    27859.52 (  -0.27%)
Hmean     recv-64         210.14 (   0.00%)      202.26 *  -3.75%*
Hmean     recv-128        418.23 (   0.00%)      404.14 *  -3.37%*
Hmean     recv-256        821.31 (   0.00%)      789.94 *  -3.82%*
Hmean     recv-1024      3161.95 (   0.00%)     3025.23 *  -4.32%*
Hmean     recv-2048      5959.44 (   0.00%)     5725.35 *  -3.93%*
Hmean     recv-3312      9196.99 (   0.00%)     8830.44 *  -3.99%*
Hmean     recv-4096     11061.26 (   0.00%)    10675.83 *  -3.48%*
Hmean     recv-8192     17319.62 (   0.00%)    17601.10 *   1.63%*
Hmean     recv-16384    27935.00 (   0.00%)    27859.40 (  -0.27%)

6) netperf-tcp

Hmean     64        1222.35 (   0.00%)     1195.62 *  -2.19%*
Hmean     128       2372.82 (   0.00%)     2311.15 *  -2.60%*
Hmean     256       4305.82 (   0.00%)     4244.00 (  -1.44%)
Hmean     1024     13645.83 (   0.00%)    13299.13 *  -2.54%*
Hmean     2048     21119.56 (   0.00%)    21042.51 (  -0.36%)
Hmean     3312     24835.87 (   0.00%)    25282.73 *   1.80%*
Hmean     4096     26705.57 (   0.00%)    26851.09 (   0.54%)
Hmean     8192     30889.25 (   0.00%)    31436.74 *   1.77%*
Hmean     16384    35108.55 (   0.00%)    35172.76 (   0.18%)

7) tbench4 Throughput

Hmean     1        289.23 (   0.00%)      289.58 (   0.12%)
Hmean     2        577.35 (   0.00%)      576.40 *  -0.17%*
Hmean     4       1141.02 (   0.00%)     1155.58 *   1.28%*
Hmean     8       2258.36 (   0.00%)     2287.82 *   1.30%*
Hmean     16      4410.02 (   0.00%)     4510.76 *   2.28%*
Hmean     32      7414.89 (   0.00%)     7474.74 *   0.81%*
Hmean     64      9011.49 (   0.00%)     8973.50 *  -0.42%*
Hmean     128    19892.18 (   0.00%)    19913.82 *   0.11%*
Hmean     256    19854.73 (   0.00%)    20239.21 *   1.94%*
Hmean     384    19808.80 (   0.00%)    19709.59 *  -0.50%*



> 
> thanks,
> Chenyu
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
>> -- 
>> 2.31.1
>>
