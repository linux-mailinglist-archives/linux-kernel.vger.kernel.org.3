Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB30464A93
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhLAJaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:30:46 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:55964 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhLAJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638350844; x=1669886844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7yTvaK2Bca7cNy1SowsIssNG5KckWZ2iLuWtxup9oac=;
  b=xLvoTfcw+JWEZXEMXB39NhtytF6loj1IBSqKBJma091wOZwjg8nusPFw
   oaJL6XGIisLjm5Q9trvF2sIQzqmsmaUwMgQ3M/Gh+3Km7OgKQ6UI6b70W
   oTufBD6qoD70KeFCKHApdBeKWb7Cyed+XhwS+0zzELs1/Tg2h7Qlf1GYt
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Dec 2021 01:27:24 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 01:27:24 -0800
Received: from [10.216.8.32] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 1 Dec 2021
 01:27:20 -0800
Message-ID: <5010f7fa-faf4-1857-81d7-36cc08956f49@quicinc.com>
Date:   Wed, 1 Dec 2021 14:57:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/6] rcu/nocb: Create kthreads on all CPUs if "rcu_nocb="
 or "nohz_full=" are passed
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-5-frederic@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20211123003708.468409-5-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2021 6:07 AM, Frederic Weisbecker wrote:
> In order to be able to (de-)offload any CPU using cpuset in the future,
> create a NOCB kthread for all possible CPUs. For now this is done only
> as long as the "rcu_nocb=" or "nohz_full=" kernel parameters are passed
> to avoid the unnecessary overhead for most users.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---

Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>


>   kernel/rcu/tree_nocb.h | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index d8ed3ee47a67..9d37916278d4 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1229,11 +1229,8 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
>   	struct rcu_data *rdp_gp;
>   	struct task_struct *t;
>   
> -	/*
> -	 * If this isn't a no-CBs CPU or if it already has an rcuo kthread,
> -	 * then nothing to do.
> -	 */
> -	if (!rcu_is_nocb_cpu(cpu) || rdp->nocb_cb_kthread)

As rcu_is_nocb_cpu() does not have a user, we can probably remove it?


Thanks
Neeraj

> +	/* If it already has an rcuo kthread, then nothing to do. */
> +	if (rdp->nocb_cb_kthread)
>   		return;
>   
>   	/* If we didn't spawn the GP kthread first, reorganize! */
> @@ -1261,7 +1258,7 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
>    */
>   static void rcu_spawn_cpu_nocb_kthread(int cpu)
>   {
> -	if (rcu_scheduler_fully_active)
> +	if (rcu_scheduler_fully_active && rcu_nocb_is_setup)
>   		rcu_spawn_one_nocb_kthread(cpu);
>   }
>   
> @@ -1311,7 +1308,7 @@ static void __init rcu_organize_nocb_kthreads(void)
>   	 * Should the corresponding CPU come online in the future, then
>   	 * we will spawn the needed set of rcu_nocb_kthread() kthreads.
>   	 */
> -	for_each_cpu(cpu, rcu_nocb_mask) {
> +	for_each_possible_cpu(cpu) {
>   		rdp = per_cpu_ptr(&rcu_data, cpu);
>   		if (rdp->cpu >= nl) {
>   			/* New GP kthread, set up for CBs & next GP. */
> @@ -1335,7 +1332,8 @@ static void __init rcu_organize_nocb_kthreads(void)
>   				pr_cont(" %d", cpu);
>   		}
>   		rdp->nocb_gp_rdp = rdp_gp;
> -		list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
> +		if (cpumask_test_cpu(cpu, rcu_nocb_mask))
> +			list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
>   	}
>   	if (gotnocbs && dump_tree)
>   		pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
> 
