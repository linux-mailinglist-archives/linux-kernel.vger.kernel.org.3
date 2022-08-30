Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8137A5A5EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiH3JG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiH3JGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:06:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3263AA74FC;
        Tue, 30 Aug 2022 02:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC29B615AF;
        Tue, 30 Aug 2022 09:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244D4C433D6;
        Tue, 30 Aug 2022 09:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661850384;
        bh=Vt/mtohIT2VR6QX+APoBOLefU3pHXRvFEjj8wrJYyaw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Pw15LS/WdE/hI3Wsk2Z1JXEjYVk35MJpjqsEkonJ0vdCb2P6RM1WVRZkvmAbWBlni
         9cwvG3Xc5zKgM9yu6M9K/+BrxJcXuNzEy8/jJZ/Td6FyxYoD0f+H/TPk/BQ4yToysX
         h12VwmKwgAuwOWXZQqZtN43CshWwlAe/z/Egighnq5NxyzvpEwdEBzjA8AmnuOFz4V
         2TY9fTNg2dC0ZpL0Pm6XWMcgpG3cm9LM0eWN0HmOxLZQnwloVwfOzuQW0sQbAoNxr8
         Y/x0aI9FKB4/QCtwzlWMiiGyBlH2ml70h9BeXGtwEINMIro45F69UVEEUmPf4gKS8q
         C3hOvMabyN2ig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C44F85C0531; Tue, 30 Aug 2022 02:06:23 -0700 (PDT)
Date:   Tue, 30 Aug 2022 02:06:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Remove duplicate RCU exp QS report from
 rcu_report_dead()
Message-ID: <20220830090623.GR6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220830083151.396561-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830083151.396561-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 04:31:51PM +0800, Zqiang wrote:
> For PREEMPT_RCU, the rcu_report_dead() is invoked means that the
> outgoing CPU mask is clear from leaf rcu_node and has no further
> need of RCU, so invoke rcu_preempt_depth() return value is always
> zero in rcu_report_dead(), if the current outgoing CPU rcu_data
> structure's cpu_no_qs.b.exp is true, the rcu_preempt_deferred_qs()
> will invoke rcu_report_exp_rdp() to report exp QS.
> 
> for non-PREEMPT_RCU, the rcu_preempt_deferred_qs() is equivalent to
> rcu_report_exp_rdp().
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Nice!  

One question... Currently, for PREEMPT_RCU, the outgoing CPU silently
reports a quiescent state even if there was a bug that resulted in that
CPU still being in an RCU read-side critical section.  With your change,
the outgoing CPU would silently refuse to report a quiescent state.

Is there something along the CPU-offline code path that already complains
about this situation?  If not, I believe that the first WARN_ON_ONCE()
in rcu_implicit_dynticks_qs() would complain.

Could you please try this, just so we know what happens in this case?
One way of forcing this would be to do rcu_read_lock() just before the
call to rcu_report_dead(), though other diagnostics might require that
rcu_read_lock() to be earlier in the code.

Another question in both cases...  There is a more subtle change where the
old code ignores rdp->cpu_no_qs.b.exp (thus invoking rcu_report_exp_rdp()
unconditionally) and the new code avoids invoking rcu_report_exp_rdp()
unless this is set.  How does this interact with a new expedited
grace period that starts just as this CPU calls rcu_report_dead()?
The expedited grace-period code in __sync_rcu_exp_select_node_cpus()
is of special concern here.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6bb8e72bc815..0ca21ac0f064 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4276,8 +4276,6 @@ void rcu_report_dead(unsigned int cpu)
>  	// Do any dangling deferred wakeups.
>  	do_nocb_deferred_wakeup(rdp);
>  
> -	/* QS for any half-done expedited grace period. */
> -	rcu_report_exp_rdp(rdp);
>  	rcu_preempt_deferred_qs(current);
>  
>  	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
> -- 
> 2.25.1
> 
