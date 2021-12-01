Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B701464A8A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348197AbhLAJ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:29:16 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10837 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242016AbhLAJ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638350753; x=1669886753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RuZH4w90n5W5nJ9qxjET1aTW0ME4PBkPQ1uu/8hLefg=;
  b=pfWFMYuUtp9rcZBTNMuhS0lKMCZlyvoXGnGyAZDxTX+4yDgz6yXAz6da
   e3m7ssgKDLQWQ1yybSQEjyumLuFcevEFZfYTjIPL3GBfbKGtehb4XdDDF
   LFPqjJCKrPnBDzp8G8XZFWSa9UcHp1yGwOPqGwV7uw0uLyQbVfPNmdtVA
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Dec 2021 01:25:53 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 01:25:52 -0800
Received: from [10.216.8.32] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 1 Dec 2021
 01:25:50 -0800
Message-ID: <4b192489-ed1d-179b-ea35-cc9b23b8f389@quicinc.com>
Date:   Wed, 1 Dec 2021 14:55:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/6] rcu/nocb: Prepare nocb_cb_wait() to start with a
 non-offloaded rdp
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-3-frederic@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20211123003708.468409-3-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2021 6:07 AM, Frederic Weisbecker wrote:
> In order to be able to toggle the offloaded state from cpusets, a nocb
> kthread will need to be created for all possible CPUs whenever the
> "rcu_nocbs=" or "nohz_full=" parameters are passed.
> 
> Therefore nocb_cb_wait() kthread must prepare to start running on a
> de-offloaded rdp. Simply move the sleeping condition in the beginning
> of the kthread callback is enough to prevent from running callbacks
> before the rdp ever becomes offloaded.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---

Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>


Thanks
Neeraj

>   kernel/rcu/tree_nocb.h | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index cc1165559177..e1cb06840454 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -797,6 +797,18 @@ static void nocb_cb_wait(struct rcu_data *rdp)
>   	bool can_sleep = true;
>   	struct rcu_node *rnp = rdp->mynode;
>   
> +	do {
> +		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> +						    nocb_cb_wait_cond(rdp));
> +
> +		// VVV Ensure CB invocation follows _sleep test.
> +		if (smp_load_acquire(&rdp->nocb_cb_sleep)) { // ^^^
> +			WARN_ON(signal_pending(current));
> +			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
> +		}
> +	} while (!nocb_cb_can_run(rdp));
> +
> +
>   	local_irq_save(flags);
>   	rcu_momentary_dyntick_idle();
>   	local_irq_restore(flags);
> @@ -849,17 +861,6 @@ static void nocb_cb_wait(struct rcu_data *rdp)
>   
>   	if (needwake_state)
>   		swake_up_one(&rdp->nocb_state_wq);
> -
> -	do {
> -		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> -						    nocb_cb_wait_cond(rdp));
> -
> -		// VVV Ensure CB invocation follows _sleep test.
> -		if (smp_load_acquire(&rdp->nocb_cb_sleep)) { // ^^^
> -			WARN_ON(signal_pending(current));
> -			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
> -		}
> -	} while (!nocb_cb_can_run(rdp));
>   }
>   
>   /*
> 
