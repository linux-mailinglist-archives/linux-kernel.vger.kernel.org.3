Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E0C547692
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiFKQtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiFKQtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:49:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE80760DA1;
        Sat, 11 Jun 2022 09:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 488EEB8094D;
        Sat, 11 Jun 2022 16:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FC5C34116;
        Sat, 11 Jun 2022 16:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654966159;
        bh=6ffMB9Bvq8D1Sqnq0KH792Mg/MsPCZth/MfFPkvZa7Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DdXMLSYLDecPoaIZuP87BjoOgeMVu0i4Aa2QtWpPGRIX5NHXykSIrRNIDNpnXMZM6
         EvhxKAcv8c7QZym6g0N6GgXr4qY5gtjpNPNwzJ91XX23GPBYHNgVFrEbkRgW7PBJpX
         NkI0GJPrQPMAKRz6a+SZ4zWQJs8mRR/lz8gB5XkvtJLpfUMq8FaCq4iovp8wwdcbsU
         RMO/MrV3oab/sN5bQe6r7gK7k5jGh6UgrzsbeeBVY5RI4HMnEXkMRIYuZv2SD2Llui
         5HcfJQHP/KAvIxaTRO1Db1d5lGbF+tejsVwdW/4kzGUSd1GIcNC8fjHMQbHBCBHYfz
         OBJSwuerxJYVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9A2EE5C0612; Sat, 11 Jun 2022 09:49:18 -0700 (PDT)
Date:   Sat, 11 Jun 2022 09:49:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp
 list is empty
Message-ID: <20220611164918.GN1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220611110044.2999157-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611110044.2999157-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 07:00:44PM +0800, Zqiang wrote:
> Currently, If the 'rcu_nocb_poll' bootargs is enable, all rcuog kthreads
> enter polling mode. however, due to only insert CPU's rdp which belong to
> rcu_nocb_mask to 'nocb_head_rdp' list or all CPU's rdp served by rcuog
> kthread have been de-offloaded, these cause the 'nocb_head_rdp' list
> served by rcuog kthread is empty, when the 'nocb_head_rdp' is empty,
> the rcuog kthread in polling mode not actually do anything. fix it by
> exiting polling mode when the 'nocb_head_rdp'list is empty, otherwise
> entering polling mode.
> 
> Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Much better, thank you!  One additional question below.

(And we of course need Frederic's "D'accord" before I send this sort of
thing to mainline.)

							Thanx, Paul

> ---
>  v1->v2:
>  Move rcu_nocb_poll flags check from rdp_offload_toggle() to 
>  rcu_nocb_rdp_offload/deoffload(), avoid unnecessary setting of 
>  rdp_gp->nocb_gp_sleep flags, because when rcu_nocb_poll is set  the 
>  rdp_gp->nocb_gp_sleep is not used.
>  
>  v2->v3:
>  When nocb_head_rdp list is empty. put rcuog kthreads in nocb_gp_wq
>  waitqueue to wait offloading.
> 
>  kernel/rcu/tree_nocb.h | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index fa8e4f82e60c..a8f574d8850d 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -584,6 +584,14 @@ static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
>  	return ret;
>  }
>  
> +static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
> +{
> +	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
> +	swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
> +					!READ_ONCE(my_rdp->nocb_gp_sleep));
> +	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
> +}
> +
>  /*
>   * No-CBs GP kthreads come here to wait for additional callbacks to show up
>   * or for grace periods to end.
> @@ -701,13 +709,19 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  		/* Polling, so trace if first poll in the series. */
>  		if (gotcbs)
>  			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
> -		schedule_timeout_idle(1);
> +		if (list_empty(&my_rdp->nocb_head_rdp)) {
> +			raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
> +			if (!my_rdp->nocb_toggling_rdp)

If this "if" condition is false, what prevents this kthread from being
in a CPU-bound loop?

> +				WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
> +			raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
> +			/* Wait for any offloading rdp */
> +			nocb_gp_sleep(my_rdp, cpu);
> +		} else {
> +			schedule_timeout_idle(1);
> +		}
>  	} else if (!needwait_gp) {
>  		/* Wait for callbacks to appear. */
> -		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
> -		swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
> -				!READ_ONCE(my_rdp->nocb_gp_sleep));
> -		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
> +		nocb_gp_sleep(my_rdp, cpu);
>  	} else {
>  		rnp = my_rdp->mynode;
>  		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
> -- 
> 2.25.1
> 
