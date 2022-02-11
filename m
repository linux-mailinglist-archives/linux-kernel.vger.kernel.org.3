Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D77A4B2D13
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiBKSoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:44:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiBKSo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:44:29 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FAA334;
        Fri, 11 Feb 2022 10:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644605067; x=1676141067;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RoOvLmtTLMq+x2yPt3uZmZva8/9SoG2i2LgSLbwtN+8=;
  b=g0slqgk4pGDV7FV6KAHRJH2cVFnt2fDHqplXQAcdfxdw5JypaYLEYVB5
   8OJ4LlDhIqguvM3ROOIMRiRj5bd7fkVDGV3DtVZzWJooDWYsIbovHJRfb
   pffn46Q+cwchWf8o3siZsdR1a8c9S4M8IxmAxp5m0WtUFtVcS20e0BXOq
   o=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 10:44:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 10:44:26 -0800
Received: from [10.216.46.141] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 11 Feb
 2022 10:44:24 -0800
Message-ID: <ede5ef2e-a804-3b9e-dfd1-d050baf48828@quicinc.com>
Date:   Sat, 12 Feb 2022 00:14:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH rcu 3/3] rcu: Allow expedited RCU grace periods on
 incoming CPUs
Content-Language: en-US
To:     <paulmck@kernel.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>
References: <20220204225409.GA4193020@paulmck-ThinkPad-P17-Gen-1>
 <20220204225507.4193113-3-paulmck@kernel.org>
 <de3a9710-fbf4-8005-a781-adc95ae4a090@quicinc.com>
 <20220209220601.GB4285@paulmck-ThinkPad-P17-Gen-1>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220209220601.GB4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 2/10/2022 3:36 AM, Paul E. McKenney wrote:
> On Wed, Feb 09, 2022 at 11:53:33PM +0530, Mukesh Ojha wrote:
>> On 2/5/2022 4:25 AM, Paul E. McKenney wrote:
>>> Although it is usually safe to invoke synchronize_rcu_expedited() from a
>>> preemption-enabled CPU-hotplug notifier, if it is invoked from a notifier
>>> between CPUHP_AP_RCUTREE_ONLINE and CPUHP_AP_ACTIVE, its attempts to
>>> invoke a workqueue handler will hang due to RCU waiting on a CPU that
>>> the scheduler is not paying attention to.  This commit therefore expands
>>> use of the existing workqueue-independent synchronize_rcu_expedited()
>>> from early boot to also include CPUs that are being hotplugged.
>>>
>>> Link: https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
>>> Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>> Cc: Tejun Heo <tj@kernel.org>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> ---
>>>    kernel/rcu/tree_exp.h | 14 ++++++++++----
>>>    1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>>> index 60197ea24ceb9..1a45667402260 100644
>>> --- a/kernel/rcu/tree_exp.h
>>> +++ b/kernel/rcu/tree_exp.h
>>> @@ -816,7 +816,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
>>>     */
>>>    void synchronize_rcu_expedited(void)
>>>    {
>>> -	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
>>> +	bool no_wq;
>>>    	struct rcu_exp_work rew;
>>>    	struct rcu_node *rnp;
>>>    	unsigned long s;
>>> @@ -841,9 +841,15 @@ void synchronize_rcu_expedited(void)
>>>    	if (exp_funnel_lock(s))
>>>    		return;  /* Someone else did our work for us. */
>>> +	/* Don't use workqueue during boot or from an incoming CPU. */
>>> +	preempt_disable();
>>> +	no_wq = rcu_scheduler_active == RCU_SCHEDULER_INIT ||
>>> +		!cpumask_test_cpu(smp_processor_id(), cpu_active_mask);
>>> +	preempt_enable();
>>> +
>>>    	/* Ensure that load happens before action based on it. */
>>> -	if (unlikely(boottime)) {
>>> -		/* Direct call during scheduler init and early_initcalls(). */
>>> +	if (unlikely(no_wq)) {
>>> +		/* Direct call for scheduler init, early_initcall()s, and incoming CPUs. */
>>>    		rcu_exp_sel_wait_wake(s);
>>>    	} else {
>>>    		/* Marshall arguments & schedule the expedited grace period. */
>>> @@ -861,7 +867,7 @@ void synchronize_rcu_expedited(void)
>>>    	/* Let the next expedited grace period start. */
>>>    	mutex_unlock(&rcu_state.exp_mutex);
>>> -	if (likely(!boottime))
>>> +	if (likely(!no_wq))
>>>    		destroy_work_on_stack(&rew.rew_work);
>>>    }
>>>    EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
>> Can we reach a condition after this change where no_wq = true and during
>> rcu_stall report where exp_task = 0 list and exp_mask contain only this cpu
>> ?
> Hello, Mukesh, and thank you for looking this over!
>
> At first glance, I do not believe that this can happen because the
> expedited grace-period machinery avoids waiting on the current CPU.
> (See sync_rcu_exp_select_node_cpus(), both the raw_smp_processor_id()
> early in the function and the get_cpu() later in the function.)
>
> But please let me know if I am missing something here.
>
> But suppose that we could in fact reach this condition.  What bad thing
> would happen?  Other than a resched_cpu() having been invoked several
> times on a not-yet-online CPU, of course.  ;-)


I thought more about this, what if  synchronize_rcu_expedited thread got 
schedule out and run on some other cpu
and we clear out cpu on which it ran next from exp_mask.

Queuing the work on same cpu ensures that it will always be right cpu to 
clear out.
Do you think this can happen ?

-Mukesh

>
> 							Thanx, Paul
