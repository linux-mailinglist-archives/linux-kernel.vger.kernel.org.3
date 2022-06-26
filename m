Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E203355B1C7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 14:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiFZMOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 08:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiFZMOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 08:14:01 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA04BCA8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 05:14:00 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d129so6583297pgc.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 05:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tr68Ko7MQ6JUiXILlPaoYGFCJ0N9R+PrijE84Purgho=;
        b=TZhLT36nwtHY/WVuNH7I5CsjpgXfm4frSU1iHJL/Asak5I4oMdKWsf94H8G7H+F5GP
         PNVvJHNn3sMLVCgFISw4Ikj/LJAj7/OTcwMzLebdF8UwFHx74edT+gLeFcyj1PqJE0OZ
         Efwguxvu7wFK4ndc3XYnzAzE9LWVTYc2S9pX5rJRezfv7+HPbxmwWZI4RPfo4qolV3Fr
         CUuJ3yjT5bwq2hMnmZRviOhuU3wXM7VjguoCn177BhzgN0nxSp/VIa7IFxKoCHGSHnMG
         z7o9QoFx+91mWBRlZE349xVHjtUC02mDtgsRn2SnN83o2YGu27gfCNl9tCooT8mw6vR4
         RIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tr68Ko7MQ6JUiXILlPaoYGFCJ0N9R+PrijE84Purgho=;
        b=Jaa6nww58jExt3IyKMMlPHr8a6q3SZU1AJZa87VX9PDuFg4DJLP22a8ZNRc5OCKCNF
         +hhSI1wA15WA72c6JyVra2RJ43GTnsCCg3WH5v/dPjFRqgU9V7lBYTLQ3qzW9Q7ucLpU
         hc5IB1H95fuT+Scodr3K5UAmpOj/LeFYsu6a6cvinIhGy9O98kZhlQ8fJ203X3fIs36z
         BQ8qW0dW/I2yKgS7c2fv0tuJ7uog3Y5HZIQAXiw50ppd8HYpR4rEvuALuuurut/MIYab
         jNsgNzVPEkBts2rUFE/fEDndkPr/AhTX1z/EFOaOIKvwJP0s7mI14j/5EBbcoRhJChrC
         T4Lw==
X-Gm-Message-State: AJIora+1MknDcsyTW08+ksGcO7hWoy243VP3f/Twzi+bt11gax/FBHD0
        6ZMvKtFJWWHF11fghj3LVnOsQA==
X-Google-Smtp-Source: AGRyM1ulaCu5x4K9J0xYmasjXbqgcmxlk4TjCjMtWzuoOWSuYjU+znuodThM2hmpigRy20rCoyVd1w==
X-Received: by 2002:aa7:9298:0:b0:525:a210:465f with SMTP id j24-20020aa79298000000b00525a210465fmr3581210pfa.77.1656245639499;
        Sun, 26 Jun 2022 05:13:59 -0700 (PDT)
Received: from [10.4.126.80] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id a23-20020a17090a6d9700b001eccb13dfb0sm7366645pjk.4.2022.06.26.05.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 05:13:58 -0700 (PDT)
Message-ID: <9cf43b10-85a2-1a83-057f-c43be339265e@bytedance.com>
Date:   Sun, 26 Jun 2022 20:13:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Content-Language: en-US
To:     Yicong Yang <yangyicong@hisilicon.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tim.c.chen@linux.intel.com,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        guodong.xu@linaro.org, hesham.almatary@huawei.com,
        john.garry@huawei.com, shenyang39@huawei.com
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
 <20220609120622.47724-3-yangyicong@hisilicon.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220609120622.47724-3-yangyicong@hisilicon.com>
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


On 6/9/22 8:06 PM, Yicong Yang Wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> For platforms having clusters like Kunpeng920, CPUs within the same cluster
> have lower latency when synchronizing and accessing shared resources like
> cache. Thus, this patch tries to find an idle cpu within the cluster of the
> target CPU before scanning the whole LLC to gain lower latency.
> 
> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so this patch
> doesn't consider SMT for this moment.
> 
> Testing has been done on Kunpeng920 by pinning tasks to one numa and two
> numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
> 
> With this patch, We noticed enhancement on tbench within one numa or cross
> two numa.
> 
> On numa 0:
>                              5.19-rc1                patched
> Hmean     1        350.27 (   0.00%)      406.88 *  16.16%*
> Hmean     2        702.01 (   0.00%)      808.22 *  15.13%*
> Hmean     4       1405.14 (   0.00%)     1614.34 *  14.89%*
> Hmean     8       2830.53 (   0.00%)     3169.02 *  11.96%*
> Hmean     16      5597.95 (   0.00%)     6224.20 *  11.19%*
> Hmean     32     10537.38 (   0.00%)    10524.97 *  -0.12%*
> Hmean     64      8366.04 (   0.00%)     8437.41 *   0.85%*
> Hmean     128     7060.87 (   0.00%)     7150.25 *   1.27%*
> 
> On numa 0-1:
>                              5.19-rc1                patched
> Hmean     1        346.11 (   0.00%)      408.47 *  18.02%*
> Hmean     2        693.34 (   0.00%)      805.78 *  16.22%*
> Hmean     4       1384.96 (   0.00%)     1602.49 *  15.71%*
> Hmean     8       2699.45 (   0.00%)     3069.98 *  13.73%*
> Hmean     16      5327.11 (   0.00%)     5688.19 *   6.78%*
> Hmean     32     10019.10 (   0.00%)    11862.56 *  18.40%*
> Hmean     64     13850.57 (   0.00%)    17748.54 *  28.14%*
> Hmean     128    12498.25 (   0.00%)    15541.59 *  24.35%*
> Hmean     256    11195.77 (   0.00%)    13854.06 *  23.74%*
> 
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>   kernel/sched/fair.c | 44 +++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 77b2048a9326..6d173e196ad3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6327,6 +6327,40 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>   
>   #endif /* CONFIG_SCHED_SMT */
>   
> +#ifdef CONFIG_SCHED_CLUSTER
> +/*
> + * Scan the cluster domain for idle CPUs and clear cluster cpumask after scanning
> + */
> +static inline int scan_cluster(struct task_struct *p, struct cpumask *cpus,
> +			       int target, int *nr)
> +{
> +	struct sched_domain *sd = rcu_dereference(per_cpu(sd_cluster, target));
> +	int cpu, idle_cpu;
> +
> +	/* TODO: Support SMT system with cluster topology */
> +	if (!sched_smt_active() && sd) {
> +		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
> +			if (!--*nr)
> +				break;

return -1;
:)

> +
> +			idle_cpu = __select_idle_cpu(cpu, p);
> +			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +				return idle_cpu;
> +		}
> +
> +		cpumask_andnot(cpus, cpus, sched_domain_span(sd));
> +	}
> +
> +	return -1;
> +}
> +#else
> +static inline int scan_cluster(struct task_struct *p, struct cpumask *cpus,
> +			       int target, int *nr)
> +{
> +	return -1;
> +}
> +#endif
> +
>   /*
>    * Scan the LLC domain for idle CPUs; this is dynamically regulated by
>    * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> @@ -6375,6 +6409,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>   		time = cpu_clock(this);
>   	}
>   
> +	idle_cpu = scan_cluster(p, cpus, target, &nr);
> +	if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +		return idle_cpu;
> +
>   	for_each_cpu_wrap(cpu, cpus, target + 1) {
>   		if (has_idle_core) {
>   			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> @@ -6382,7 +6420,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>   				return i;
>   
>   		} else {
> -			if (!--nr)
> +			if (--nr <= 0)
>   				return -1;
>   			idle_cpu = __select_idle_cpu(cpu, p);
>   			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> @@ -6481,7 +6519,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   	/*
>   	 * If the previous CPU is cache affine and idle, don't be stupid:
>   	 */
> -	if (prev != target && cpus_share_cache(prev, target) &&
> +	if (prev != target && cpus_share_resources(prev, target) &&
>   	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>   	    asym_fits_capacity(task_util, prev))
>   		return prev;
> @@ -6507,7 +6545,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   	p->recent_used_cpu = prev;
>   	if (recent_used_cpu != prev &&
>   	    recent_used_cpu != target &&
> -	    cpus_share_cache(recent_used_cpu, target) &&
> +	    cpus_share_resources(recent_used_cpu, target) &&
>   	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
>   	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
>   	    asym_fits_capacity(task_util, recent_used_cpu)) {
