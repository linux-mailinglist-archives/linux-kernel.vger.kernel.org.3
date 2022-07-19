Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AFC579658
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiGSJ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiGSJ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:29:01 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D061BE8D;
        Tue, 19 Jul 2022 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658222940; x=1689758940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sF4kvTiDQg5suexIpAJFDFIgzvrKHcboc+NRtAftRjI=;
  b=YCNn1mIfJGYehPpTVQNKfqWdCAmLTM2LfJ2qMY0kxKgktnCWmCxNQXFB
   7ylWlLrX3WuoRB+IR3oDoGcwDSqQ0n/+x8j/wC4jCo+ySS97kVTjZjwrr
   tnUsTDaESJKd67008qg5dvFGwCrcCllXqOxDp5okQOU5gahcJCLuRzV0F
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Jul 2022 02:29:00 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 02:29:00 -0700
Received: from [10.50.41.193] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Jul
 2022 02:28:43 -0700
Message-ID: <6058fc59-928f-6dad-126c-221e07714f42@quicinc.com>
Date:   Tue, 19 Jul 2022 14:58:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 3/7] rcu/nocb: Fix NOCB kthreads spawn failure with
 rcu_nocb_rdp_deoffload() direct call
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>, Zqiang <qiang1.zhang@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
 <20220620224503.3841196-3-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620224503.3841196-3-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/2022 4:14 AM, Paul E. McKenney wrote:
> From: Zqiang <qiang1.zhang@intel.com>
> 
> If the rcuog/o[p] kthreads spawn failed, the offloaded rdp needs to
> be explicitly deoffloaded, otherwise the target rdp is still considered
> offloaded even though nothing actually handles the callbacks.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>


Thanks
Neeraj

>   kernel/rcu/tree_nocb.h | 80 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 64 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index f2f2cab6285a1..4cf9a29bba79d 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -986,10 +986,7 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
>   	}
>   	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
>   
> -	if (wake_gp)
> -		wake_up_process(rdp_gp->nocb_gp_kthread);
> -
> -	return 0;
> +	return wake_gp;
>   }
>   
>   static long rcu_nocb_rdp_deoffload(void *arg)
> @@ -997,9 +994,15 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>   	struct rcu_data *rdp = arg;
>   	struct rcu_segcblist *cblist = &rdp->cblist;
>   	unsigned long flags;
> -	int ret;
> +	int wake_gp;
> +	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
>   
> -	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
> +	/*
> +	 * rcu_nocb_rdp_deoffload() may be called directly if
> +	 * rcuog/o[p] spawn failed, because at this time the rdp->cpu
> +	 * is not online yet.
> +	 */
> +	WARN_ON_ONCE((rdp->cpu != raw_smp_processor_id()) && cpu_online(rdp->cpu));
>   
>   	pr_info("De-offloading %d\n", rdp->cpu);
>   
> @@ -1023,10 +1026,41 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>   	 */
>   	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
>   	invoke_rcu_core();
> -	ret = rdp_offload_toggle(rdp, false, flags);
> -	swait_event_exclusive(rdp->nocb_state_wq,
> -			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
> -							SEGCBLIST_KTHREAD_GP));
> +	wake_gp = rdp_offload_toggle(rdp, false, flags);
> +
> +	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
> +	if (rdp_gp->nocb_gp_kthread) {
> +		if (wake_gp)
> +			wake_up_process(rdp_gp->nocb_gp_kthread);
> +
> +		/*
> +		 * If rcuo[p] kthread spawn failed, directly remove SEGCBLIST_KTHREAD_CB.
> +		 * Just wait SEGCBLIST_KTHREAD_GP to be cleared by rcuog.
> +		 */
> +		if (!rdp->nocb_cb_kthread) {
> +			rcu_nocb_lock_irqsave(rdp, flags);
> +			rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
> +			rcu_nocb_unlock_irqrestore(rdp, flags);
> +		}
> +
> +		swait_event_exclusive(rdp->nocb_state_wq,
> +					!rcu_segcblist_test_flags(cblist,
> +					  SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP));
> +	} else {
> +		/*
> +		 * No kthread to clear the flags for us or remove the rdp from the nocb list
> +		 * to iterate. Do it here instead. Locking doesn't look stricly necessary
> +		 * but we stick to paranoia in this rare path.
> +		 */
> +		rcu_nocb_lock_irqsave(rdp, flags);
> +		rcu_segcblist_clear_flags(&rdp->cblist,
> +				SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
> +		rcu_nocb_unlock_irqrestore(rdp, flags);
> +
> +		list_del(&rdp->nocb_entry_rdp);
> +	}
> +	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
> +
>   	/*
>   	 * Lock one last time to acquire latest callback updates from kthreads
>   	 * so we can later handle callbacks locally without locking.
> @@ -1047,7 +1081,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>   	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
>   
>   
> -	return ret;
> +	return 0;
>   }
>   
>   int rcu_nocb_cpu_deoffload(int cpu)
> @@ -1079,7 +1113,8 @@ static long rcu_nocb_rdp_offload(void *arg)
>   	struct rcu_data *rdp = arg;
>   	struct rcu_segcblist *cblist = &rdp->cblist;
>   	unsigned long flags;
> -	int ret;
> +	int wake_gp;
> +	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
>   
>   	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
>   	/*
> @@ -1089,6 +1124,9 @@ static long rcu_nocb_rdp_offload(void *arg)
>   	if (!rdp->nocb_gp_rdp)
>   		return -EINVAL;
>   
> +	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
> +		return -EINVAL;
> +
>   	pr_info("Offloading %d\n", rdp->cpu);
>   
>   	/*
> @@ -1113,7 +1151,9 @@ static long rcu_nocb_rdp_offload(void *arg)
>   	 *      WRITE flags               READ callbacks
>   	 *      rcu_nocb_unlock()         rcu_nocb_unlock()
>   	 */
> -	ret = rdp_offload_toggle(rdp, true, flags);
> +	wake_gp = rdp_offload_toggle(rdp, true, flags);
> +	if (wake_gp)
> +		wake_up_process(rdp_gp->nocb_gp_kthread);
>   	swait_event_exclusive(rdp->nocb_state_wq,
>   			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
>   			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
> @@ -1126,7 +1166,7 @@ static long rcu_nocb_rdp_offload(void *arg)
>   	rcu_segcblist_clear_flags(cblist, SEGCBLIST_RCU_CORE);
>   	rcu_nocb_unlock_irqrestore(rdp, flags);
>   
> -	return ret;
> +	return 0;
>   }
>   
>   int rcu_nocb_cpu_offload(int cpu)
> @@ -1248,7 +1288,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
>   				"rcuog/%d", rdp_gp->cpu);
>   		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__)) {
>   			mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
> -			return;
> +			goto end;
>   		}
>   		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
>   		if (kthread_prio)
> @@ -1260,12 +1300,20 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
>   	t = kthread_run(rcu_nocb_cb_kthread, rdp,
>   			"rcuo%c/%d", rcu_state.abbr, cpu);
>   	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
> -		return;
> +		goto end;
>   
>   	if (kthread_prio)
>   		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
>   	WRITE_ONCE(rdp->nocb_cb_kthread, t);
>   	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
> +	return;
> +end:
> +	mutex_lock(&rcu_state.barrier_mutex);
> +	if (rcu_rdp_is_offloaded(rdp)) {
> +		rcu_nocb_rdp_deoffload(rdp);
> +		cpumask_clear_cpu(cpu, rcu_nocb_mask);
> +	}
> +	mutex_unlock(&rcu_state.barrier_mutex);
>   }
>   
>   /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
