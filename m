Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB10C513A01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350135AbiD1Qmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350169AbiD1Qmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:42:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0875B1AB2;
        Thu, 28 Apr 2022 09:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B35F8B82E55;
        Thu, 28 Apr 2022 16:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCA1C385A0;
        Thu, 28 Apr 2022 16:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651163954;
        bh=TbNY5tMdiOJsUndqHUIgwjtYqFvQZxRvr7x1ta32hY0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=i5CkhbODY8Sum9+Yz4Fpb6tkKF2ca7C34NwKO/9j+IqF2xnOuQoxCIjqd5DOQpDCU
         uHFJFj0989Dpyn1ipb8cVX10kPs/46uKbG2t6aorIeTU+L6iuJITnR5ipgZKMEKKAe
         5sJrn8tocJDsB+4U+Rmn4CvL5xQnXL0SxSIUCQMNUrVzfJBAn/QcdPXfyG6ucxBsZP
         mI06EdGRtO6B0bh1WtkAhE9cdfC+mDafcLuDSpa+szuCXF/ur7EnevbchY9uuN496l
         UnSnr20gFnRCfyL5nVlkhIvOj2Ii1RgwNKNjjKTghg8x+DpVs3Zv2L+j+dD/vh76Ru
         5S0vt35Xu+Rbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E52985C0564; Thu, 28 Apr 2022 09:39:13 -0700 (PDT)
Date:   Thu, 28 Apr 2022 09:39:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] rcu: Add nocb_cb_kthread check to
 rcu_is_callbacks_kthread()
Message-ID: <20220428163913.GI1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220426070031.3759998-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426070031.3759998-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:00:31PM +0800, Zqiang wrote:
> At present, there are two situations which the rcu callback function
> be exectued in the kthreads, one is if the use_softirq is set to zero,
> the RCU_SOFTIRQ processing is carried out by the per-CPU rcuc kthreads,
> for non-offload rdp, the rdp's rcu callback function be exectued in rcuc
> kthreads. another one is if the rdp is set to offloaded, the rdp's rcu
> callback function be exectued in the rcuop kthreads.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good catch!

From what I can see, this affects only tracing.  Or did I miss a
use case?

Also, should the two definitions of rcu_is_callbacks_kthread() be merged?
It looks like the current situation dates back to when the only time
rcuc kthreads were created was in kernels built with CONFIG_RCU_BOOST=y.
If so, the definition of this function should move from tree_plugin.h
to tree.c.

							Thanx, Paul

> ---
>  v1->v2:
>  fix compilation error when CONFIG_RCU_NOCB_CPU is no define
> 
>  kernel/rcu/tree.c        |  4 ++--
>  kernel/rcu/tree.h        |  2 +-
>  kernel/rcu/tree_plugin.h | 12 +++++++++---
>  3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5c587e00811c..9dc4c4e82db6 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2610,7 +2610,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  		trace_rcu_batch_end(rcu_state.name, 0,
>  				    !rcu_segcblist_empty(&rdp->cblist),
>  				    need_resched(), is_idle_task(current),
> -				    rcu_is_callbacks_kthread());
> +				    rcu_is_callbacks_kthread(rdp));
>  		return;
>  	}
>  
> @@ -2688,7 +2688,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	rcu_nocb_lock_irqsave(rdp, flags);
>  	rdp->n_cbs_invoked += count;
>  	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
> -			    is_idle_task(current), rcu_is_callbacks_kthread());
> +			    is_idle_task(current), rcu_is_callbacks_kthread(rdp));
>  
>  	/* Update counts and requeue any remaining callbacks. */
>  	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 996387962de3..3cdc18997a38 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -433,7 +433,7 @@ static void rcu_flavor_sched_clock_irq(int user);
>  static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
>  static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
>  static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
> -static bool rcu_is_callbacks_kthread(void);
> +static bool rcu_is_callbacks_kthread(struct rcu_data *rdp);
>  static void rcu_cpu_kthread_setup(unsigned int cpu);
>  static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
>  static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 971bb6a00ede..120bade40e02 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1155,9 +1155,15 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
>   * Is the current CPU running the RCU-callbacks kthread?
>   * Caller must have preemption disabled.
>   */
> -static bool rcu_is_callbacks_kthread(void)
> +static bool rcu_is_callbacks_kthread(struct rcu_data *rdp)
>  {
> -	return __this_cpu_read(rcu_data.rcu_cpu_kthread_task) == current;
> +	bool ret;
> +#ifdef CONFIG_RCU_NOCB_CPU
> +	ret = rdp->rcu_cpu_kthread_task == current || rdp->nocb_cb_kthread == current;
> +#else
> +	ret = rdp->rcu_cpu_kthread_task == current;
> +#endif

The problem here is that the first part of that condition is duplicated.
This is an accident waiting to happen when someone fixes one side of that
#ifdef without also adjusting the other side.  One approach is to define a
function that tests "nocb_cb_kthread == current" in CONFIG_RCU_NOCB_CPU=y
kernels and just returns "false" otherwise.

Alternatively, you could make ->nocb_cb_kthread defined unconditionally,
but left always NULL in CONFIG_RCU_NOCB_CPU=n kernels.

> +	return ret;
>  }
>  
>  #define RCU_BOOST_DELAY_JIFFIES DIV_ROUND_UP(CONFIG_RCU_BOOST_DELAY * HZ, 1000)
> @@ -1242,7 +1248,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  }
>  
> -static bool rcu_is_callbacks_kthread(void)
> +static bool rcu_is_callbacks_kthread(struct rcu_data *rdp)
>  {
>  	return false;
>  }
> -- 
> 2.25.1
> 
