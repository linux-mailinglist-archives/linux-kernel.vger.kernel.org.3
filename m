Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D093464A86
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348186AbhLAJ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:28:45 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:22389 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242016AbhLAJ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638350722; x=1669886722;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dKE6KwoCVDe5nrsMnFrIyynDqmZRSWCYWIE6c/WPwXo=;
  b=ushzoAuF8HbBybTSma7iwnKMCVO2G7Rz6WuXzWjgGl67ByZPZYSnNCW4
   f8X/3xB8mMLEe5iwaQOIIGkipyuo5/cXdzgX+WBqfJRV6TWQYx9nzsWVv
   cMfRUOOImxfa4PH3It316PyB5MhWy+uR+kAgUGGPBpRKnl5MMaJVH8K6S
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Dec 2021 01:25:22 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 01:25:22 -0800
Received: from [10.216.8.32] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 1 Dec 2021
 01:25:19 -0800
Message-ID: <84ab6b4a-6fc4-be3f-d990-1f46265a46e6@quicinc.com>
Date:   Wed, 1 Dec 2021 14:55:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/6] rcu/nocb: Remove rdp from nocb list when de-offloaded
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-2-frederic@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20211123003708.468409-2-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2021 6:07 AM, Frederic Weisbecker wrote:
> nocb_gp_wait() iterates all CPUs within the rcuog's group even if they
> are have been de-offloaded. This is suboptimal if only few CPUs are
> offloaded within the group. And this will become even more a problem
> when a nocb kthread will be created for all possible CPUs in the future.
> 
> Therefore use a standard double linked list to link all the offloaded
> rdps and safely add/del their nodes as we (de-)offloaded them.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---

Few queries below.

Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>



>   kernel/rcu/tree.h      |  7 +++++--
>   kernel/rcu/tree_nocb.h | 37 ++++++++++++++++++++++++++++++-------
>   2 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index deeaf2fee714..486fc901bd08 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -221,8 +221,11 @@ struct rcu_data {
>   	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
>   	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
>   	struct task_struct *nocb_cb_kthread;
> -	struct rcu_data *nocb_next_cb_rdp;
> -					/* Next rcu_data in wakeup chain. */
> +	struct list_head nocb_head_rdp; /*
> +					 * Head of rcu_data list in wakeup chain,
> +					 * if rdp_gp.
> +					 */
> +	struct list_head nocb_entry_rdp; /* rcu_data node in wakeup chain. */
>   
>   	/* The following fields are used by CB kthread, hence new cacheline. */
>   	struct rcu_data *nocb_gp_rdp ____cacheline_internodealigned_in_smp;
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 2461fe8d0c23..cc1165559177 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -625,7 +625,15 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>   	 * and the global grace-period kthread are awakened if needed.
>   	 */
>   	WARN_ON_ONCE(my_rdp->nocb_gp_rdp != my_rdp);
> -	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
> +	/*
> +	 * An rdp can be removed from the list after being de-offloaded or added
> +	 * to the list before being (re-)offloaded. If the below loop happens while
> +	 * an rdp is de-offloaded and then re-offloaded shortly afterward, we may
> +	 * shortcut and ignore a part of the rdp list due to racy list iteration.
> +	 * Fortunately a new run through the entire loop is forced after an rdp is
> +	 * added here so that such race get quickly fixed.
> +	 */
> +	list_for_each_entry_rcu(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp, 1) {

Can we hit a (unlikely) case where repeated calls to de-offload/offload 
cause this loop to continue for long time?


>   		bool needwake_state = false;
>   
>   		if (!nocb_gp_enabled_cb(rdp))

Now that we can probe flags here, without holding the nocb_gp_lock first 
( the case where de-offload and offload happens while we are iterating 
the list); can it cause a WARNING from below code?


	WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
	rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);

The sequence like this is possible?

1. <de-offload>
     Clear SEGCBLIST_OFFLOADED
2. nocb_gp_wait() clears SEGCBLIST_KTHREAD_GP in 
nocb_gp_update_state_deoffloading() and continues to next rdp.
3. <offload>
     rdp_offload_toggle() hasn't been called yet.
4. rcuog thread migrates to different CPU, while executing the
loop in nocb_gp_wait().
5. nocb_gp_wait() reaches the tail rdp.
6. Current CPU , where  rcog thread is running hasn't observed
SEGCBLIST_OFFLOADED clearing done in step 1; so, nocb_gp_enabled_cb()
passes.
7. nocb_gp_wait() acquires the rdp's nocb lock and read the state to
be deoffloaded; however, SEGCBLIST_KTHREAD_GP is not set and
we hit WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, 
SEGCBLIST_KTHREAD_GP));

Thanks
Neeraj

> @@ -1003,6 +1011,8 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>   	swait_event_exclusive(rdp->nocb_state_wq,
>   			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
>   							SEGCBLIST_KTHREAD_GP));
> +	/* Don't bother iterate this one anymore on nocb_gp_wait() */
> +	list_del_rcu(&rdp->nocb_entry_rdp);
>   	/*
>   	 * Lock one last time to acquire latest callback updates from kthreads
>   	 * so we can later handle callbacks locally without locking.
> @@ -1066,6 +1076,15 @@ static long rcu_nocb_rdp_offload(void *arg)
>   		return -EINVAL;
>   
>   	pr_info("Offloading %d\n", rdp->cpu);
> +
> +	/*
> +	 * Iterate this CPU on nocb_gp_wait(). We do it before locking nocb_gp_lock,
> +	 * resetting nocb_gp_sleep and waking up the related "rcuog". Since nocb_gp_wait()
> +	 * in turn locks nocb_gp_lock before setting nocb_gp_sleep again, we are guaranteed
> +	 * to iterate this new rdp before "rcuog" goes to sleep again.
> +	 */
> +	list_add_tail_rcu(&rdp->nocb_entry_rdp, &rdp->nocb_gp_rdp->nocb_head_rdp);
> +
>   	/*
>   	 * Can't use rcu_nocb_lock_irqsave() before SEGCBLIST_LOCKING
>   	 * is set.
> @@ -1268,7 +1287,6 @@ static void __init rcu_organize_nocb_kthreads(void)
>   	int nl = 0;  /* Next GP kthread. */
>   	struct rcu_data *rdp;
>   	struct rcu_data *rdp_gp = NULL;  /* Suppress misguided gcc warn. */
> -	struct rcu_data *rdp_prev = NULL;
>   
>   	if (!cpumask_available(rcu_nocb_mask))
>   		return;
> @@ -1288,8 +1306,8 @@ static void __init rcu_organize_nocb_kthreads(void)
>   			/* New GP kthread, set up for CBs & next GP. */
>   			gotnocbs = true;
>   			nl = DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
> -			rdp->nocb_gp_rdp = rdp;
>   			rdp_gp = rdp;
> +			INIT_LIST_HEAD(&rdp->nocb_head_rdp);
>   			if (dump_tree) {
>   				if (!firsttime)
>   					pr_cont("%s\n", gotnocbscbs
> @@ -1302,12 +1320,11 @@ static void __init rcu_organize_nocb_kthreads(void)
>   		} else {
>   			/* Another CB kthread, link to previous GP kthread. */
>   			gotnocbscbs = true;
> -			rdp->nocb_gp_rdp = rdp_gp;
> -			rdp_prev->nocb_next_cb_rdp = rdp;
>   			if (dump_tree)
>   				pr_cont(" %d", cpu);
>   		}
> -		rdp_prev = rdp;
> +		rdp->nocb_gp_rdp = rdp_gp;
> +		list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
>   	}
>   	if (gotnocbs && dump_tree)
>   		pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
> @@ -1369,6 +1386,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
>   {
>   	char bufw[20];
>   	char bufr[20];
> +	struct rcu_data *nocb_next_rdp;
>   	struct rcu_segcblist *rsclp = &rdp->cblist;
>   	bool waslocked;
>   	bool wassleep;
> @@ -1376,11 +1394,16 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
>   	if (rdp->nocb_gp_rdp == rdp)
>   		show_rcu_nocb_gp_state(rdp);
>   
> +	nocb_next_rdp = list_next_or_null_rcu(&rdp->nocb_gp_rdp->nocb_head_rdp,
> +					      &rdp->nocb_entry_rdp,
> +					      typeof(*rdp),
> +					      nocb_entry_rdp);
> +
>   	sprintf(bufw, "%ld", rsclp->gp_seq[RCU_WAIT_TAIL]);
>   	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
>   	pr_info("   CB %d^%d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
>   		rdp->cpu, rdp->nocb_gp_rdp->cpu,
> -		rdp->nocb_next_cb_rdp ? rdp->nocb_next_cb_rdp->cpu : -1,
> +		nocb_next_rdp ? nocb_next_rdp->cpu : -1,
>   		"kK"[!!rdp->nocb_cb_kthread],
>   		"bB"[raw_spin_is_locked(&rdp->nocb_bypass_lock)],
>   		"cC"[!!atomic_read(&rdp->nocb_lock_contended)],
> 
