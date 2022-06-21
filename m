Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5A552F61
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbiFUKCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiFUKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:02:42 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3CD27FE6;
        Tue, 21 Jun 2022 03:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655805761; x=1687341761;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QVzdBNyMcQCp/AEcPlHdcIajijCDUBwKc+Y/v0orBkM=;
  b=eqnyOnIjL/YKQUBORWQy/F+HIltdSWTHTpqzj57zBW+s6AG7Mv5mHdQJ
   N/VQrsW+WcAOtjmldSSDLC+IIfQCBgABxsEaGcbdSEe+IFwOXLPZkQXgx
   V5XjpUfqbpnvzB+sAJ/4SUpKj8PuuaaiNm6iQR61TRsOZ/r0+zUOzjbX0
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Jun 2022 03:02:41 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 03:02:41 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 21 Jun
 2022 03:02:39 -0700
Message-ID: <e70c457c-0ac6-174d-fa0f-807d8e563f40@quicinc.com>
Date:   Tue, 21 Jun 2022 15:32:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 09/12] rcu/kvfree: Remove useless monitor_todo flag
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-9-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620222032.3839547-9-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/2022 3:50 AM, Paul E. McKenney wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> monitor_todo is not needed as the work struct already tracks
> if work is pending. Just use that to know if work is pending
> using schedule_delayed_work() helper.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>


Thanks
Neeraj

>   kernel/rcu/tree.c | 33 ++++++++++++++++-----------------
>   1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5445b19b48408..7919d7b48fa6a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3216,7 +3216,6 @@ struct kfree_rcu_cpu_work {
>    * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
>    * @lock: Synchronize access to this structure
>    * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> - * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
>    * @initialized: The @rcu_work fields have been initialized
>    * @count: Number of objects for which GP not started
>    * @bkvcache:
> @@ -3241,7 +3240,6 @@ struct kfree_rcu_cpu {
>   	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
>   	raw_spinlock_t lock;
>   	struct delayed_work monitor_work;
> -	bool monitor_todo;
>   	bool initialized;
>   	int count;
>   
> @@ -3421,6 +3419,18 @@ static void kfree_rcu_work(struct work_struct *work)
>   	}
>   }
>   
> +static bool
> +need_offload_krc(struct kfree_rcu_cpu *krcp)
> +{
> +	int i;
> +
> +	for (i = 0; i < FREE_N_CHANNELS; i++)
> +		if (krcp->bkvhead[i])
> +			return true;
> +
> +	return !!krcp->head;
> +}
> +
>   /*
>    * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
>    */
> @@ -3477,9 +3487,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>   	// of the channels that is still busy we should rearm the
>   	// work to repeat an attempt. Because previous batches are
>   	// still in progress.
> -	if (!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head)
> -		krcp->monitor_todo = false;
> -	else
> +	if (need_offload_krc(krcp))
>   		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
>   
>   	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> @@ -3667,11 +3675,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>   	WRITE_ONCE(krcp->count, krcp->count + 1);
>   
>   	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> -	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> -	    !krcp->monitor_todo) {
> -		krcp->monitor_todo = true;
> +	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
>   		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> -	}
>   
>   unlock_return:
>   	krc_this_cpu_unlock(krcp, flags);
> @@ -3746,14 +3751,8 @@ void __init kfree_rcu_scheduler_running(void)
>   		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>   
>   		raw_spin_lock_irqsave(&krcp->lock, flags);
> -		if ((!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head) ||
> -				krcp->monitor_todo) {
> -			raw_spin_unlock_irqrestore(&krcp->lock, flags);
> -			continue;
> -		}
> -		krcp->monitor_todo = true;
> -		schedule_delayed_work_on(cpu, &krcp->monitor_work,
> -					 KFREE_DRAIN_JIFFIES);
> +		if (need_offload_krc(krcp))
> +			schedule_delayed_work_on(cpu, &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
>   		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>   	}
>   }
