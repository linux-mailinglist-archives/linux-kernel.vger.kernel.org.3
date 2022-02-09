Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB58E4AF9E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiBISXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiBISXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:23:37 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9018DC0613C9;
        Wed,  9 Feb 2022 10:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644431020; x=1675967020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GVWMK2ZEVnJLDUgMZ5P6+xGyx1f3F94joSIq+IIPcCs=;
  b=uKdRgaK++8hrfvBy50LLb1e8CrN1WQKl1tRdSPEiAi5XJpHWbrOAoDyP
   sZUWgo9p+EaZXJfvtwmInoZroG4N4QZn9Tkz3cLBzRJpQbAi65H4fgD1o
   vaj5b4q8YhSlVyOlc5zda/8oCnMdD7Hbtw+PLrtk1KEXzvKWwCkChY0tj
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Feb 2022 10:23:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:23:40 -0800
Received: from [10.216.32.197] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 9 Feb 2022
 10:23:37 -0800
Message-ID: <de3a9710-fbf4-8005-a781-adc95ae4a090@quicinc.com>
Date:   Wed, 9 Feb 2022 23:53:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH rcu 3/3] rcu: Allow expedited RCU grace periods on
 incoming CPUs
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
References: <20220204225409.GA4193020@paulmck-ThinkPad-P17-Gen-1>
 <20220204225507.4193113-3-paulmck@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220204225507.4193113-3-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/5/2022 4:25 AM, Paul E. McKenney wrote:
> Although it is usually safe to invoke synchronize_rcu_expedited() from a
> preemption-enabled CPU-hotplug notifier, if it is invoked from a notifier
> between CPUHP_AP_RCUTREE_ONLINE and CPUHP_AP_ACTIVE, its attempts to
> invoke a workqueue handler will hang due to RCU waiting on a CPU that
> the scheduler is not paying attention to.  This commit therefore expands
> use of the existing workqueue-independent synchronize_rcu_expedited()
> from early boot to also include CPUs that are being hotplugged.
>
> Link: https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
> Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   kernel/rcu/tree_exp.h | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 60197ea24ceb9..1a45667402260 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -816,7 +816,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
>    */
>   void synchronize_rcu_expedited(void)
>   {
> -	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
> +	bool no_wq;
>   	struct rcu_exp_work rew;
>   	struct rcu_node *rnp;
>   	unsigned long s;
> @@ -841,9 +841,15 @@ void synchronize_rcu_expedited(void)
>   	if (exp_funnel_lock(s))
>   		return;  /* Someone else did our work for us. */
>   
> +	/* Don't use workqueue during boot or from an incoming CPU. */
> +	preempt_disable();
> +	no_wq = rcu_scheduler_active == RCU_SCHEDULER_INIT ||
> +		!cpumask_test_cpu(smp_processor_id(), cpu_active_mask);
> +	preempt_enable();
> +
>   	/* Ensure that load happens before action based on it. */
> -	if (unlikely(boottime)) {
> -		/* Direct call during scheduler init and early_initcalls(). */
> +	if (unlikely(no_wq)) {
> +		/* Direct call for scheduler init, early_initcall()s, and incoming CPUs. */
>   		rcu_exp_sel_wait_wake(s);
>   	} else {
>   		/* Marshall arguments & schedule the expedited grace period. */
> @@ -861,7 +867,7 @@ void synchronize_rcu_expedited(void)
>   	/* Let the next expedited grace period start. */
>   	mutex_unlock(&rcu_state.exp_mutex);
>   
> -	if (likely(!boottime))
> +	if (likely(!no_wq))
>   		destroy_work_on_stack(&rew.rew_work);
>   }
>   EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);

Can we reach a condition after this change where no_wq = true and during 
rcu_stall report where exp_task = 0 list and exp_mask contain only this 
cpu ?

-Mukesh


