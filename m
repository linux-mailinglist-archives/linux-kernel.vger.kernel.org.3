Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E80453F4AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiFGDlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbiFGDlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16BA1EC70;
        Mon,  6 Jun 2022 20:41:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 563616145D;
        Tue,  7 Jun 2022 03:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10B7C385A5;
        Tue,  7 Jun 2022 03:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654573293;
        bh=zCMYLn1BsuiUSRHpxFYCTwy18i6bAaXXDCJJ56euczE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SP7rwgdlMRSmLb2HeJYrMlv6dM8NRvMirjw1Xntas8BOQYY6xdK9tkorm2czTZ99O
         oo42Q2Mrt7FhoFLB1VLYg5yINTTsiW6uUzjIs3n/OAOVhIpAS29JHzyVU6Op1/mjbD
         KbocavbrqaL066HawGhwpsJKtND1r0SQycm4Fp7lqWyQb5MrvwnlyVWSH2alzMWHoX
         eXjn2idDajkrWpIJRmVt5bREa2E8pYPnVuS0I6pqiyolPEd04nZKG6nMAdr+pVXd8J
         UKHBSPqy5N5zCvHdcjLhFxUFurE6yChMpIKnH/fmcsoHtanAr3fWvr72nmMI+hIzYs
         F5q9sHPlPzutw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4AA4D5C05C5; Mon,  6 Jun 2022 20:41:33 -0700 (PDT)
Date:   Mon, 6 Jun 2022 20:41:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp list
 is empty
Message-ID: <20220607034133.GC1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220606065143.3159643-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606065143.3159643-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 02:51:43PM +0800, Zqiang wrote:
> Currently, If the 'rcu_nocb_poll' bootargs is enable, all rcuog kthreads
> enter polling mode. however, due to only insert CPU's rdp which belong to
> rcu_nocb_mask to 'nocb_head_rdp' list or all CPU's rdp served by rcuog
> kthread have been de-offloaded, these cause the 'nocb_head_rdp' list
> served by rcuog kthread is empty, when the 'nocb_head_rdp' is empty,
> the rcuog kthread in polling mode not actually do anything. fix it by
> exiting polling mode when the 'nocb_head_rdp'list is empty, otherwise
> entering polling mode.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Looks promising!  A couple of questions below.

> ---
>  kernel/rcu/tree_nocb.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index fa8e4f82e60c..c25c3e3dd22d 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -698,10 +698,14 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  				   TPS("WakeBypassIsDeferred"));
>  	}
>  	if (rcu_nocb_poll) {
> -		/* Polling, so trace if first poll in the series. */
> -		if (gotcbs)
> -			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
> -		schedule_timeout_idle(1);
> +		if (list_empty(&my_rdp->nocb_head_rdp)) {

Do we need to set rdp_gp->nocb_gp_sleep to true in here somewhere?

> +			rcu_wait(READ_ONCE(my_rdp->nocb_toggling_rdp));
> +		} else {
> +			/* Polling, so trace if first poll in the series. */
> +			if (gotcbs)
> +				trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
> +			schedule_timeout_idle(1);
> +		}
>  	} else if (!needwait_gp) {
>  		/* Wait for callbacks to appear. */
>  		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
> @@ -980,7 +984,7 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
>  	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
>  	// Queue this rdp for add/del to/from the list to iterate on rcuog
>  	WRITE_ONCE(rdp_gp->nocb_toggling_rdp, rdp);
> -	if (rdp_gp->nocb_gp_sleep) {
> +	if (rcu_nocb_poll || rdp_gp->nocb_gp_sleep) {

Is it the case that other than when (de-)offloading, the rcuog kthread
is never awakened when rcu_nocb_poll is set?  If this is not the case,
we would have spurious wakeups.  (I believe that rcu_nocb_poll suppresses
those wakeups, but it would be good to check.)

>  		rdp_gp->nocb_gp_sleep = false;
>  		wake_gp = true;
>  	}
> -- 
> 2.25.1
> 
