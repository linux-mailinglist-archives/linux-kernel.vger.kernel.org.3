Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F814B33F2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 09:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiBLIrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 03:47:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBLIrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 03:47:12 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324D42613A;
        Sat, 12 Feb 2022 00:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644655629; x=1676191629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hzzb+fJTJc1tulTuP7YJcCY0JzMe/zjnBtpSneNShTU=;
  b=Ajgb9oHFEUfR79OokmuzugozQMpUXbaRI14SOY6SLHf+aqkn9FT989NL
   5kOt0nEYVGrNgDkUkhuYqeMRsHyd+a2nLw1BjRPajtuxFX7e/q0LN8g+e
   313q+I+6iA+Fob8OWtNMbrSmPAnYYY+xHv4mzqQOoqlaqUWlQK7D+n70e
   o=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 12 Feb 2022 00:47:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 00:47:09 -0800
Received: from [10.216.46.141] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Sat, 12 Feb
 2022 00:47:05 -0800
Message-ID: <2a4870e9-41ae-60cf-fef3-aeb1de6f559c@quicinc.com>
Date:   Sat, 12 Feb 2022 14:17:02 +0530
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
 <ede5ef2e-a804-3b9e-dfd1-d050baf48828@quicinc.com>
 <20220211221455.GM4285@paulmck-ThinkPad-P17-Gen-1>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220211221455.GM4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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


On 2/12/2022 3:44 AM, Paul E. McKenney wrote:
> On Sat, Feb 12, 2022 at 12:14:20AM +0530, Mukesh Ojha wrote:
>> On 2/10/2022 3:36 AM, Paul E. McKenney wrote:
>>> On Wed, Feb 09, 2022 at 11:53:33PM +0530, Mukesh Ojha wrote:
>>>> On 2/5/2022 4:25 AM, Paul E. McKenney wrote:
>>>>> Although it is usually safe to invoke synchronize_rcu_expedited() from a
>>>>> preemption-enabled CPU-hotplug notifier, if it is invoked from a notifier
>>>>> between CPUHP_AP_RCUTREE_ONLINE and CPUHP_AP_ACTIVE, its attempts to
>>>>> invoke a workqueue handler will hang due to RCU waiting on a CPU that
>>>>> the scheduler is not paying attention to.  This commit therefore expands
>>>>> use of the existing workqueue-independent synchronize_rcu_expedited()
>>>>> from early boot to also include CPUs that are being hotplugged.
>>>>>
>>>>> Link: https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
>>>>> Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>>> Cc: Tejun Heo <tj@kernel.org>
>>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>>> ---
>>>>>     kernel/rcu/tree_exp.h | 14 ++++++++++----
>>>>>     1 file changed, 10 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>>>>> index 60197ea24ceb9..1a45667402260 100644
>>>>> --- a/kernel/rcu/tree_exp.h
>>>>> +++ b/kernel/rcu/tree_exp.h
>>>>> @@ -816,7 +816,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
>>>>>      */
>>>>>     void synchronize_rcu_expedited(void)
>>>>>     {
>>>>> -	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
>>>>> +	bool no_wq;
>>>>>     	struct rcu_exp_work rew;
>>>>>     	struct rcu_node *rnp;
>>>>>     	unsigned long s;
>>>>> @@ -841,9 +841,15 @@ void synchronize_rcu_expedited(void)
>>>>>     	if (exp_funnel_lock(s))
>>>>>     		return;  /* Someone else did our work for us. */
>>>>> +	/* Don't use workqueue during boot or from an incoming CPU. */
>>>>> +	preempt_disable();
>>>>> +	no_wq = rcu_scheduler_active == RCU_SCHEDULER_INIT ||
>>>>> +		!cpumask_test_cpu(smp_processor_id(), cpu_active_mask);
>>>>> +	preempt_enable();
>>>>> +
>>>>>     	/* Ensure that load happens before action based on it. */
>>>>> -	if (unlikely(boottime)) {
>>>>> -		/* Direct call during scheduler init and early_initcalls(). */
>>>>> +	if (unlikely(no_wq)) {
>>>>> +		/* Direct call for scheduler init, early_initcall()s, and incoming CPUs. */
>>>>>     		rcu_exp_sel_wait_wake(s);
>>>>>     	} else {
>>>>>     		/* Marshall arguments & schedule the expedited grace period. */
>>>>> @@ -861,7 +867,7 @@ void synchronize_rcu_expedited(void)
>>>>>     	/* Let the next expedited grace period start. */
>>>>>     	mutex_unlock(&rcu_state.exp_mutex);
>>>>> -	if (likely(!boottime))
>>>>> +	if (likely(!no_wq))
>>>>>     		destroy_work_on_stack(&rew.rew_work);
>>>>>     }
>>>>>     EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
>>>> Can we reach a condition after this change where no_wq = true and during
>>>> rcu_stall report where exp_task = 0 list and exp_mask contain only this cpu
>>>> ?
>>> Hello, Mukesh, and thank you for looking this over!
>>>
>>> At first glance, I do not believe that this can happen because the
>>> expedited grace-period machinery avoids waiting on the current CPU.
>>> (See sync_rcu_exp_select_node_cpus(), both the raw_smp_processor_id()
>>> early in the function and the get_cpu() later in the function.)
>>>
>>> But please let me know if I am missing something here.
>>>
>>> But suppose that we could in fact reach this condition.  What bad thing
>>> would happen?  Other than a resched_cpu() having been invoked several
>>> times on a not-yet-online CPU, of course.  ;-)
>>
>> I thought more about this, what if  synchronize_rcu_expedited thread got
>> schedule out and run on some other cpu
>> and we clear out cpu on which it ran next from exp_mask.
>>
>> Queuing the work on same cpu ensures that it will always be right cpu to
>> clear out.
>> Do you think this can happen ?
> Indeed it might.
>
> But if it did, the scheduler would invoke RCU's hook, which is named
> rcu_note_context_switch(), and do so on the pre-switch CPU.  There are
> two implementations for this function, one for CONFIG_PREEMPT=y
> and another for CONFIG_PREEMPT=n.  Both look to me like they invoke
> rcu_report_exp_rdp() when needed, one directly and the other via the
> CONFIG_PREEMPT=n variant of rcu_qs().
>
> Am I missing something?
>
> 	

There is a issue we are facing where exp_mask is not getting cleared and 
rcu_stall report that
the cpu we are waiting on sometime in idle and sometime executing some 
other task but
it is not clearing itself from exp_mask from a very long time and in all 
the instances exp_task list is NULL.

    expmask = 8,     ==> cpu3

[80235.522440][T12441] rcu: INFO: rcu_preempt detected expedited stalls 
on CPUs/tasks: { 3-... } 9163622 jiffies s: 634705 root: 0x8/.
[80235.534757][T12441] rcu: blocking rcu_node structures:
[80235.540102][T12441] Task dump for CPU 3:
[80235.540118][T12441] task:core_ctl        state:D stack:    0 pid:  
172 ppid:     2 flags:0x00000008
[80235.540150][T12441] Call trace:
[80235.540178][T12441]  __switch_to+0x2a8/0x3ac
[80235.540207][T12441]  rcu_state+0x11b0/0x1480


[80299.010105][T12441] rcu: INFO: rcu_preempt detected expedited stalls 
on CPUs/tasks: { 3-... } 9179494 jiffies s: 634705 root: 0x8/.
[80299.022623][T12441] rcu: blocking rcu_node structures:
[80299.027924][T12441] Task dump for CPU 3:
[80299.027942][T12441] task:swapper/3       state:R  running task     
stack:    0 pid:    0 ppid:     1 flags:0x00000008
[80299.027993][T12441] Call trace:
[80299.028025][T12441]  __switch_to+0x2a8/0x3ac
[80299.028051][T12441]  0xffffffc010113eb4


As we were not seeing this earlier.
Below is compile tested patch, can we do something like this  ?

==========================================><====================================================

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6453ac5..f0332e4 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -812,10 +812,12 @@ static int rcu_print_task_exp_stall(struct 
rcu_node *rnp)
   */
  void synchronize_rcu_expedited(void)
  {
-    bool no_wq;
+    bool no_wq = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
+    bool is_active;
      struct rcu_exp_work rew;
      struct rcu_node *rnp;
      unsigned long s;
+    int next_cpu;

      RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
               lock_is_held(&rcu_lock_map) ||
@@ -837,19 +839,28 @@ void synchronize_rcu_expedited(void)
      if (exp_funnel_lock(s))
          return;  /* Someone else did our work for us. */

-    /* Don't use workqueue during boot or from an incoming CPU. */
-    preempt_disable();
-    no_wq = rcu_scheduler_active == RCU_SCHEDULER_INIT ||
-        !cpumask_test_cpu(smp_processor_id(), cpu_active_mask);
-    preempt_enable();
-
      /* Ensure that load happens before action based on it. */
      if (unlikely(no_wq)) {
-        /* Direct call during scheduler init, early_initcalls() and 
incoming CPUs. */
+        /* Direct call during scheduler init, early_initcalls(). */
          rcu_exp_sel_wait_wake(s);
+        mutex_unlock(&rcu_state.exp_mutex);
+        return;
+    }
+
+    preempt_disable();
+    is_active = cpumask_test_cpu(smp_processor_id(), cpu_active_mask);
+    preempt_enable();
+
+    rew.rew_s = s;
+    if (!is_active) {
+        INIT_WORK(&rew.rew_work, wait_rcu_exp_gp);
+        next_cpu = cpumask_next(smp_processor_id(), cpu_active_mask);
+        if (next_cpu >= nr_cpu_ids)
+            next_cpu = cpumask_first(cpu_active_mask);
+
+        queue_work_on(next_cpu, rcu_gp_wq, &rew.rew_work);
      } else {
          /* Marshall arguments & schedule the expedited grace period. */
-        rew.rew_s = s;
          INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
          queue_work(rcu_gp_wq, &rew.rew_work);
      }
@@ -863,7 +874,9 @@ void synchronize_rcu_expedited(void)
      /* Let the next expedited grace period start. */
      mutex_unlock(&rcu_state.exp_mutex);

-    if (likely(!no_wq))
+    if (likely(is_active))
          destroy_work_on_stack(&rew.rew_work);
+    else
+        flush_work(&rew.rew_work);
  }
  EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
-- 
2.7.4


-Mukesh




> 					Thanx, Paul
