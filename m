Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A3D546646
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbiFJMFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245550AbiFJMFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:05:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339CF3F322;
        Fri, 10 Jun 2022 05:05:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C179B834DC;
        Fri, 10 Jun 2022 12:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2574C3411E;
        Fri, 10 Jun 2022 12:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654862745;
        bh=f9tCZ3dUGujHwZtgBBhgrGaWaeeMtU5w+k7egcKNfkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jR8trHrWTHYG7Z9ccS+GVbKyAVHH9oRp5ckreKkEj0zGsQL+sdaLJz/xs+JTOXidt
         +oEYLXGUcHLwrC8KnvQ8Ua2sMCxlC3qTniMSMxVVgVjRTH0AsnjchsRcXwmbvjNMLz
         6k5SvVcwPRHnbw4bOV+Cyi3FNXjJzno+2ilZJU82Mi6tLJZ7CJcdxpM9WSTTdsvJF/
         atC1RjwAyHrMA0l6ivT7fsoo9rVhuSvkHzKZJezQmPZOerlkPNxgfzcBehEnHmg7oA
         KDOe0t1Q1hhwJIJsWdeJpD8YbiA4r/r7fPAj63FCX/fbs14+yBZi3RIWXjTSHo7JeG
         hBYCeFocezpLQ==
Date:   Fri, 10 Jun 2022 14:05:42 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp
 list is empty
Message-ID: <20220610120542.GA1811980@lothringen>
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

I suspect you have based your patch on upstream tree which doesn't seem
to have this one yet:

   "rcu/nocb: Add/del rdp to iterate from rcuog itself"

With this patch you can't wait on changes to my_rdp->nocb_toggling_rdp because
nocb_gp_wait() now performs the list_add/list_del itself.

Please rebase your patch on top of latest rcu:dev from Paul's tree. Then
all you need to do is to change the wait side, something like this (untested):

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index fa8e4f82e60c..f36d6be4f372 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -584,6 +584,15 @@ static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
 	return ret;
 }
 
+static void nocb_gp_sleep(struct rdp *my_rdp, int cpu)
+{
+	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
+	swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
+					    !READ_ONCE(my_rdp->nocb_gp_sleep));
+	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
+}
+
+
 /*
  * No-CBs GP kthreads come here to wait for additional callbacks to show up
  * or for grace periods to end.
@@ -701,13 +710,19 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		/* Polling, so trace if first poll in the series. */
 		if (gotcbs)
 			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
-		schedule_timeout_idle(1);
+		if (list_empty(&my_rdp->nocb_head_rdp)) {
+			raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
+			if (!my_rdp->nocb_toggling_rdp)
+				WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
+			raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
+			/* Wait for any offloading rdp */
+			rdp_gp_sleep(my_rdp, cpu);
+		} else {
+			schedule_timeout_idle(1);
+		}
 	} else if (!needwait_gp) {
 		/* Wait for callbacks to appear. */
-		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
-		swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
-				!READ_ONCE(my_rdp->nocb_gp_sleep));
-		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
+		rdp_gp_sleep(my_rdp, cpu);
 	} else {
 		rnp = my_rdp->mynode;
 		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
