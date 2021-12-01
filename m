Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AA5464AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348281AbhLAJbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:31:36 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:56123 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348245AbhLAJbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638350893; x=1669886893;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dxvR2sfHg0z9rwAdC1aOZBCjXfu5wHa2jadPmVI2QH0=;
  b=f6x4dE7LklWwujdGEGvDJw6jCylkeRaSKy1mlb4xeztY5YgKj6QaJtRW
   jv/Ju3AXus8ae1jmGVoKi10UQvi8AhVDPFPniepeNCqVt2Lx6bj/jq2SM
   U3eYptEp4jvQlJmhrTySVlH1neNXvBZqx5XIDBiQqT2jWsMiSyYsn9Mns
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Dec 2021 01:28:13 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 01:28:12 -0800
Received: from [10.216.8.32] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 1 Dec 2021
 01:28:10 -0800
Message-ID: <f067a100-baac-5c08-f432-8475667ad762@quicinc.com>
Date:   Wed, 1 Dec 2021 14:58:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 6/6] rcu/nocb: Merge rcu_spawn_cpu_nocb_kthread() and
 rcu_spawn_one_nocb_kthread()
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-7-frederic@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20211123003708.468409-7-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2021 6:07 AM, Frederic Weisbecker wrote:
> rcu_spawn_one_nocb_kthread() is only called by
> rcu_spawn_cpu_nocb_kthread(). Don't bother with two separate functions
> and merge them.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---


Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

>   kernel/rcu/tree_nocb.h | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index d915780d40c8..7e8da346127a 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1225,12 +1225,15 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
>    * rcuo CB kthread, spawn it.  Additionally, if the rcuo GP kthread
>    * for this CPU's group has not yet been created, spawn it as well.
>    */
> -static void rcu_spawn_one_nocb_kthread(int cpu)
> +static void rcu_spawn_cpu_nocb_kthread(int cpu)
>   {
>   	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>   	struct rcu_data *rdp_gp;
>   	struct task_struct *t;
>   
> +	if (!rcu_scheduler_fully_active || !rcu_nocb_is_setup)
> +		return;
> +
>   	/* If it already has an rcuo kthread, then nothing to do. */
>   	if (rdp->nocb_cb_kthread)
>   		return;
> @@ -1254,16 +1257,6 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
>   	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
>   }
>   
> -/*
> - * If the specified CPU is a no-CBs CPU that does not already have its
> - * rcuo kthread, spawn it.
> - */
> -static void rcu_spawn_cpu_nocb_kthread(int cpu)
> -{
> -	if (rcu_scheduler_fully_active && rcu_nocb_is_setup)
> -		rcu_spawn_one_nocb_kthread(cpu);
> -}
> -
>   /*
>    * Once the scheduler is running, spawn rcuo kthreads for all online
>    * no-CBs CPUs.  This assumes that the early_initcall()s happen before
> 
