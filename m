Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059614DCB27
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiCQQYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiCQQYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:24:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2015A27CE;
        Thu, 17 Mar 2022 09:23:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E66361269;
        Thu, 17 Mar 2022 16:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E0BC340E9;
        Thu, 17 Mar 2022 16:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647534180;
        bh=ImQoBTsHebNJ/T3CW7t2GWhQ4WI2Vkh2QjjRMp1jqPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEb6cct6YvAtYn00NaHSXzpD7cVSX8otKlkfnUcbxploRSARisnXsbC9DM0FHwjHb
         k8Lp6uvBVa4bJZceAjF8uzTik9HuKk8NxNKUVwOVTa78zxVuJDxxOZ8kNlIkRU6Wj+
         TZNIgXENw+kP1u1Zr/EQd86S36ZMqOnjJkxEu9AVB5eQDkD0roccNrtapFuPHt0Hpo
         9y57yJdhnqnLu6hi100F6AvZ8nDIuh6YngzAobMW3dP4leSQtqQk6AiNStG/7dBIAs
         i14MPUP7NTyp1muOFArjSX0D9yR55/Eirdo8BB1rlttIYM9mJhCJxiHoqCIW3pwupj
         n/NNwiva/7xjg==
Date:   Thu, 17 Mar 2022 17:22:57 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Deoffload rdp if rcuop/rcuog kthreads spawn
 failed
Message-ID: <20220317162257.GA463894@lothringen>
References: <20220314023314.795253-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314023314.795253-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zqiang,

Thanks for poking into this! Several comments:

On Mon, Mar 14, 2022 at 10:33:14AM +0800, Zqiang wrote:
> When CONFIG_RCU_NOCB_CPU is enabled and 'rcu_nocbs' is set, the rcuop
> and rcuog kthreads is created. however the rcuop or rcuog kthreads
> creation may fail, if failed, deoffload per-cpu rdp which belong
> to rcu_nocb_mask.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  v1->v2:
>  Invert the locking dependency order between
>  rcu_state.barrier_mutex and hotplug lock.
>  
>  Holding nocb_gp_kthread_mutex, ensure that
>  the nocb_gp_kthread exists.
>  
>  kernel/rcu/tree_nocb.h | 63 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 47 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 46694e13398a..4ec96d0c11de 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -972,10 +972,7 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
>  	}
>  	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
>  
> -	if (wake_gp)
> -		wake_up_process(rdp_gp->nocb_gp_kthread);
> -
> -	return 0;
> +	return wake_gp;
>  }
>  
>  static long rcu_nocb_rdp_deoffload(void *arg)
> @@ -984,11 +981,18 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>  	struct rcu_segcblist *cblist = &rdp->cblist;
>  	unsigned long flags;
>  	int ret;
> +	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
>  
> +	/*
> +	 *When rcuog or rcuop spawn fail, direct call rcu_nocb_rdp_deoffload().
> +	 *due to the target CPU(rdp->cpu) is not online(cpu_online(rdp->cpu)
> +	 *return false) yet. this warning will be triggered.
> +	 */
>  	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());

How about:

    WARN_ON_ONCE((rdp->cpu != raw_smp_processor_id()) && cpu_online(cpu));

>  
>  	pr_info("De-offloading %d\n", rdp->cpu);
>  
> +	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);

Please instead lock nocb_gp_kthread_mutex right above the
rdp_gp->nocb_gp_kthread check below. It doesn't look needed before that.

>  	rcu_nocb_lock_irqsave(rdp, flags);
>  	/*
>  	 * Flush once and for all now. This suffices because we are
> @@ -1010,9 +1014,19 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>  	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
>  	invoke_rcu_core();
>  	ret = rdp_offload_toggle(rdp, false, flags);

Better use a new wake_gp variable for clarity.

> -	swait_event_exclusive(rdp->nocb_state_wq,
> -			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
> +
> +	if (rdp_gp->nocb_gp_kthread) {
> +		if (ret)
> +			wake_up_process(rdp_gp->nocb_gp_kthread);
> +		swait_event_exclusive(rdp->nocb_state_wq,
> +				!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
>  							SEGCBLIST_KTHREAD_GP));

> +	} else {
> +		rcu_nocb_lock_irqsave(rdp, flags);
> +		rcu_segcblist_clear_flags(&rdp->cblist,
> +				SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
> +		rcu_nocb_unlock_irqrestore(rdp, flags);
> +	}

And you can unlock nocb_gp_kthread_mutex here.


>  	/* Stop nocb_gp_wait() from iterating over this structure. */
>  	list_del_rcu(&rdp->nocb_entry_rdp);
>  	/*
> @@ -1030,12 +1044,12 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>  	 * rcu_nocb_unlock_irqrestore() anymore.
>  	 */
>  	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> -
> +	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
>  	/* Sanity check */
>  	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
>  
>  
> -	return ret;
> +	return 0;
>  }
>  
>  int rcu_nocb_cpu_deoffload(int cpu)
> @@ -1043,8 +1057,8 @@ int rcu_nocb_cpu_deoffload(int cpu)
>  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  	int ret = 0;
>  
> -	mutex_lock(&rcu_state.barrier_mutex);
>  	cpus_read_lock();
> +	mutex_lock(&rcu_state.barrier_mutex);

Please do the locking order change in a separate patch. It's a significant
change on its own.

>  	if (rcu_rdp_is_offloaded(rdp)) {
>  		if (cpu_online(cpu)) {
>  			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
> @@ -1068,6 +1082,7 @@ static long rcu_nocb_rdp_offload(void *arg)
>  	struct rcu_segcblist *cblist = &rdp->cblist;
>  	unsigned long flags;
>  	int ret;
> +	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
>  
>  	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
>  	/*
> @@ -1077,6 +1092,12 @@ static long rcu_nocb_rdp_offload(void *arg)
>  	if (!rdp->nocb_gp_rdp)
>  		return -EINVAL;
>  
> +	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
> +	if (!rdp_gp->nocb_gp_kthread) {
> +		mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
> +		return -EINVAL;
> +	}

I believe you don't need to hold nocb_gp_kthread_mutex here. I think
a simple WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread) is enough because it's
unexpected here.

> +
>  	pr_info("Offloading %d\n", rdp->cpu);
>  
>  	/*
> @@ -1112,6 +1133,8 @@ static long rcu_nocb_rdp_offload(void *arg)
>  	 *      rcu_nocb_unlock()         rcu_nocb_unlock()
>  	 */
>  	ret = rdp_offload_toggle(rdp, true, flags);
> +	if (ret)

You can use wake_gp here too.

> +		wake_up_process(rdp_gp->nocb_gp_kthread);

Thanks!
