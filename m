Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE1B464A91
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348226AbhLAJ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:29:47 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10975 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348203AbhLAJ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638350784; x=1669886784;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KGYZYTDg5dnuCQwKnhxYJTqdcyPScNChmwtnWbo6LOE=;
  b=oPXjAG+66J8OsnwD0XwRk1Rlgj06RoV2QIuLCVwdVBEGdXwPg0coVN80
   y5gFOrExnpBHff37obYq1qWqMg++miyluMkZuOrS48FJ6Te6r9LL0WBci
   3X1GuQSSHdUXRHzbaLat6lKIOzf5UwrSskMdcOAFInYuwYlVG3aLSHc1C
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Dec 2021 01:26:24 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 01:26:23 -0800
Received: from [10.216.8.32] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 1 Dec 2021
 01:26:21 -0800
Message-ID: <1c74b167-eb1e-42d8-2c8d-e1740240ca2b@quicinc.com>
Date:   Wed, 1 Dec 2021 14:56:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/6] rcu/nocb: Optimize kthreads and rdp initialization
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-4-frederic@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20211123003708.468409-4-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2021 6:07 AM, Frederic Weisbecker wrote:
> Currently cpumask_available() is used to prevent from unwanted
> NOCB initialization. However if neither "rcu_nocbs=" nor "nohz_full="
> parameters are passed but CONFIG_CPUMASK_OFFSTACK=n, the initialization
> path is still taken, running through all sorts of needless operations
> and iterations on an empty cpumask.
> 
> Fix this with relying on a real initialization state instead. This
> also optimize kthreads creation, sparing iteration over all online CPUs
> when nocb isn't initialized.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---

Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

>   kernel/rcu/tree_nocb.h | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index e1cb06840454..d8ed3ee47a67 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -60,6 +60,9 @@ static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
>    * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
>    * If the list is invalid, a warning is emitted and all CPUs are offloaded.
>    */
> +
> +static bool rcu_nocb_is_setup;
> +
>   static int __init rcu_nocb_setup(char *str)
>   {
>   	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
> @@ -67,6 +70,7 @@ static int __init rcu_nocb_setup(char *str)
>   		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
>   		cpumask_setall(rcu_nocb_mask);
>   	}
> +	rcu_nocb_is_setup = true;
>   	return 1;
>   }
>   __setup("rcu_nocbs=", rcu_nocb_setup);
> @@ -1159,13 +1163,17 @@ void __init rcu_init_nohz(void)
>   		need_rcu_nocb_mask = true;
>   #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>   
> -	if (!cpumask_available(rcu_nocb_mask) && need_rcu_nocb_mask) {
> -		if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
> -			pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
> -			return;
> +	if (need_rcu_nocb_mask) {
> +		if (!cpumask_available(rcu_nocb_mask)) {
> +			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
> +				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
> +				return;
> +			}
>   		}
> +		rcu_nocb_is_setup = true;
>   	}
> -	if (!cpumask_available(rcu_nocb_mask))
> +
> +	if (!rcu_nocb_is_setup)
>   		return;
>   
>   #if defined(CONFIG_NO_HZ_FULL)
> @@ -1267,8 +1275,10 @@ static void __init rcu_spawn_nocb_kthreads(void)
>   {
>   	int cpu;
>   
> -	for_each_online_cpu(cpu)
> -		rcu_spawn_cpu_nocb_kthread(cpu);
> +	if (rcu_nocb_is_setup) {
> +		for_each_online_cpu(cpu)
> +			rcu_spawn_cpu_nocb_kthread(cpu);
> +	}
>   }
>   
>   /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
> 
