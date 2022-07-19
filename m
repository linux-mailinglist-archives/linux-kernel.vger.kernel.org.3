Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B8E57966B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbiGSJfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiGSJfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:35:18 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4616372;
        Tue, 19 Jul 2022 02:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658223317; x=1689759317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=puC0eKOcq/n3vahgeRPIkQbOACbXeFVj4A6G0TLvQxY=;
  b=weIt4yAP0IBJ2ThC+AGUVFTQsQI0fIanwo0iz2OIva29njfrNRrmIB0q
   gHUFh1r8UeWVY0Wid969qAXNQA4ufwVI+ee92NZ7bTQF+tcn2W8X7SjFf
   IRqVaW6ExYe695cshI7QdXN5onwaaEfLbidKR40hjGoJL83fZagf6m06x
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Jul 2022 02:35:17 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 02:35:17 -0700
Received: from [10.50.41.193] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Jul
 2022 02:35:14 -0700
Message-ID: <1fb673c1-d1a8-6958-65f7-a3df28a78a1c@quicinc.com>
Date:   Tue, 19 Jul 2022 15:05:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 5/7] rcu: Add nocb_cb_kthread check to
 rcu_is_callbacks_kthread()
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>, Zqiang <qiang1.zhang@intel.com>,
        kernel test robot <lkp@intel.com>
References: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
 <20220620224503.3841196-5-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620224503.3841196-5-paulmck@kernel.org>
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



On 6/21/2022 4:15 AM, Paul E. McKenney wrote:
> From: Zqiang <qiang1.zhang@intel.com>
> 
> Callbacks are invoked in RCU kthreads when calbacks are offloaded
> (rcu_nocbs boot parameter) or when RCU's softirq handler has been
> offloaded to rcuc kthreads (use_softirq==0).  The current code allows
> for the rcu_nocbs case but not the use_softirq case.  This commit adds
> support for the use_softirq case.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---


Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>


Thanks
Neeraj

>   kernel/rcu/tree.c        |  4 ++--
>   kernel/rcu/tree.h        |  2 +-
>   kernel/rcu/tree_plugin.h | 33 +++++++++++++++++++--------------
>   3 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c25ba442044a6..74455671e6cf2 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2530,7 +2530,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>   		trace_rcu_batch_end(rcu_state.name, 0,
>   				    !rcu_segcblist_empty(&rdp->cblist),
>   				    need_resched(), is_idle_task(current),
> -				    rcu_is_callbacks_kthread());
> +				    rcu_is_callbacks_kthread(rdp));
>   		return;
>   	}
>   
> @@ -2608,7 +2608,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>   	rcu_nocb_lock_irqsave(rdp, flags);
>   	rdp->n_cbs_invoked += count;
>   	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
> -			    is_idle_task(current), rcu_is_callbacks_kthread());
> +			    is_idle_task(current), rcu_is_callbacks_kthread(rdp));
>   
>   	/* Update counts and requeue any remaining callbacks. */
>   	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 4f8532c33558f..649ad4f0129b1 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -426,7 +426,7 @@ static void rcu_flavor_sched_clock_irq(int user);
>   static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
>   static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
>   static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
> -static bool rcu_is_callbacks_kthread(void);
> +static bool rcu_is_callbacks_kthread(struct rcu_data *rdp);
>   static void rcu_cpu_kthread_setup(unsigned int cpu);
>   static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
>   static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c8ba0fe17267c..0483e1338c413 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1012,6 +1012,25 @@ static void rcu_cpu_kthread_setup(unsigned int cpu)
>   	WRITE_ONCE(rdp->rcuc_activity, jiffies);
>   }
>   
> +static bool rcu_is_callbacks_nocb_kthread(struct rcu_data *rdp)
> +{
> +#ifdef CONFIG_RCU_NOCB_CPU
> +	return rdp->nocb_cb_kthread == current;
> +#else
> +	return false;
> +#endif
> +}
> +
> +/*
> + * Is the current CPU running the RCU-callbacks kthread?
> + * Caller must have preemption disabled.
> + */
> +static bool rcu_is_callbacks_kthread(struct rcu_data *rdp)
> +{
> +	return rdp->rcu_cpu_kthread_task == current ||
> +			rcu_is_callbacks_nocb_kthread(rdp);
> +}
> +
>   #ifdef CONFIG_RCU_BOOST
>   
>   /*
> @@ -1151,15 +1170,6 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
>   	}
>   }
>   
> -/*
> - * Is the current CPU running the RCU-callbacks kthread?
> - * Caller must have preemption disabled.
> - */
> -static bool rcu_is_callbacks_kthread(void)
> -{
> -	return __this_cpu_read(rcu_data.rcu_cpu_kthread_task) == current;
> -}
> -
>   #define RCU_BOOST_DELAY_JIFFIES DIV_ROUND_UP(CONFIG_RCU_BOOST_DELAY * HZ, 1000)
>   
>   /*
> @@ -1242,11 +1252,6 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
>   	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>   }
>   
> -static bool rcu_is_callbacks_kthread(void)
> -{
> -	return false;
> -}
> -
>   static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
>   {
>   }
