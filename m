Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E264464A94
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbhLAJbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:31:03 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:56041 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhLAJbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638350861; x=1669886861;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=If7BHbZQhs+8WlDNGMSt1ShXWORx7OCxSgCPHvg3rt4=;
  b=TPs5511OQJzK3aZBLWSp8aE7sAc/NY6Wy0GMRHETLjfj1ij2xbrrr09X
   ZCFcPXcqyAcbJDt2VFuezaleLAKG05NEe6W6qN2iBGAEd2uQDjdnINBqQ
   az36ncgPe0pc2XLS9Q4GIlVLF3hzTw47U/1SXnApahSPrHbZHll9YTxEo
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Dec 2021 01:27:41 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 01:27:41 -0800
Received: from [10.216.8.32] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 1 Dec 2021
 01:27:38 -0800
Message-ID: <6df45c8e-88be-a8f9-1991-3c20d318c921@quicinc.com>
Date:   Wed, 1 Dec 2021 14:57:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 5/6] rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-6-frederic@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20211123003708.468409-6-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2021 6:07 AM, Frederic Weisbecker wrote:
> If a user wants to boot without any CPU in offloaded mode initially but
> with the possibility to offload them later using cpusets, provide a way
> to simply pass an empty "rcu_nocbs" kernel parameter which will enforce
> the creation of dormant nocb kthreads.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---


Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

>   .../admin-guide/kernel-parameters.txt         | 26 ++++++++++++-------
>   kernel/rcu/tree_nocb.h                        | 10 ++++---
>   2 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cd860dc7c60b..6ff1a5f06383 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4351,20 +4351,28 @@
>   				Disable the Correctable Errors Collector,
>   				see CONFIG_RAS_CEC help text.
>   
> -	rcu_nocbs=	[KNL]
> -			The argument is a cpu list, as described above.
> +	rcu_nocbs[=cpu-list]
> +			[KNL] The optional argument is a cpu list,
> +			as described above.
>   
> -			In kernels built with CONFIG_RCU_NOCB_CPU=y, set
> -			the specified list of CPUs to be no-callback CPUs.
> -			Invocation of these CPUs' RCU callbacks will be
> -			offloaded to "rcuox/N" kthreads created for that
> -			purpose, where "x" is "p" for RCU-preempt, and
> -			"s" for RCU-sched, and "N" is the CPU number.
> -			This reduces OS jitter on the offloaded CPUs,
> +			In kernels built with CONFIG_RCU_NOCB_CPU=y, enable the
> +			no-callback CPU mode. Invocation of such CPUs' RCU
> +			callbacks will be offloaded to "rcuox/N" kthreads
> +			created	for that purpose, where "x" is "p" for
> +			RCU-preempt, and "s" for RCU-sched, and "N" is the CPU
> +			number.	This reduces OS jitter on the offloaded CPUs,
>   			which can be useful for HPC and real-time
>   			workloads.  It can also improve energy efficiency
>   			for asymmetric multiprocessors.
>   
> +			If a cpulist is passed as an argument, the specified
> +			list of	CPUs is set to no-callback mode from boot.
> +
> +			If otherwise the '=' sign and the cpulist arguments are
> +			omitted, no CPU will be set to no-callback mode from
> +			boot but cpuset will allow for toggling that mode at
> +			runtime.
> +
>   	rcu_nocb_poll	[KNL]
>   			Rather than requiring that offloaded CPUs
>   			(specified by rcu_nocbs= above) explicitly
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 9d37916278d4..d915780d40c8 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -66,14 +66,16 @@ static bool rcu_nocb_is_setup;
>   static int __init rcu_nocb_setup(char *str)
>   {
>   	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
> -	if (cpulist_parse(str, rcu_nocb_mask)) {
> -		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
> -		cpumask_setall(rcu_nocb_mask);
> +	if (*str == '=') {
> +		if (cpulist_parse(++str, rcu_nocb_mask)) {
> +			pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
> +			cpumask_setall(rcu_nocb_mask);
> +		}
>   	}
>   	rcu_nocb_is_setup = true;
>   	return 1;
>   }
> -__setup("rcu_nocbs=", rcu_nocb_setup);
> +__setup("rcu_nocbs", rcu_nocb_setup);
>   
>   static int __init parse_rcu_nocb_poll(char *arg)
>   {
> 
