Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00005540392
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344823AbiFGQQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344914AbiFGQQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:16:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BA1100536;
        Tue,  7 Jun 2022 09:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B56FA617CC;
        Tue,  7 Jun 2022 16:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E1DC385A5;
        Tue,  7 Jun 2022 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654618581;
        bh=pZ0N3kVmID+M42htHeCDWI/UBkUn4DOHwjZbPNx736A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UIV3IEAAq9umOzgHxHRMDm+JQ9rRW/rCgMfjUe4JFKLAGLG1mWx0oAy5xuTqa8N9D
         ZMHZm+aa9W7dcOvRKVm74Sy/6yMuijoKJcbx6braoXJA0F1mjIdTfXRm/ECj/B+8B+
         zURMMpv2iihqCjWcP2e+TnOBgSA+stsXWEnUcfpOxe8RnRd7BRHp5I8PTPA34hioht
         EHdBW+qyWxAjbOyQX12NK23TnE/0V4nKE2+qL0G3nqpgoEgQ/JvSC5ZZdF7qbt6QYI
         qqGkHJDFLc73S52n3GBgNVdtoMuef+AcsJprU0+s15SvRgrBtDQk1gp3c3kMfjrOy0
         v5LwwExSsHVTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ADB205C05DA; Tue,  7 Jun 2022 09:16:20 -0700 (PDT)
Date:   Tue, 7 Jun 2022 09:16:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp
 list is empty
Message-ID: <20220607161620.GH1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220607075057.909070-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607075057.909070-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 03:50:57PM +0800, Zqiang wrote:
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

This looks a bit more plausible, but what have you done to test this?

							Thanx, Paul

> ---
>  v1->v2:
>  Move rcu_nocb_poll flags check from rdp_offload_toggle() to
>  rcu_nocb_rdp_offload/deoffload(), avoid unnecessary setting of
>  rdp_gp->nocb_gp_sleep flags, because when rcu_nocb_poll is set
>  the rdp_gp->nocb_gp_sleep is not used.
> 
>  kernel/rcu/tree_nocb.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index fa8e4f82e60c..2a52c9abc681 100644
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
> @@ -1030,7 +1034,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>  
>  	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
>  	if (rdp_gp->nocb_gp_kthread) {
> -		if (wake_gp)
> +		if (wake_gp || rcu_nocb_poll)
>  			wake_up_process(rdp_gp->nocb_gp_kthread);
>  
>  		/*
> @@ -1152,7 +1156,7 @@ static long rcu_nocb_rdp_offload(void *arg)
>  	 *      rcu_nocb_unlock()         rcu_nocb_unlock()
>  	 */
>  	wake_gp = rdp_offload_toggle(rdp, true, flags);
> -	if (wake_gp)
> +	if (wake_gp || rcu_nocb_poll)
>  		wake_up_process(rdp_gp->nocb_gp_kthread);
>  	swait_event_exclusive(rdp->nocb_state_wq,
>  			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
> -- 
> 2.25.1
> 
