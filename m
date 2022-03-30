Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814AC4ECDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350928AbiC3USM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350967AbiC3USJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:18:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D424413DF8;
        Wed, 30 Mar 2022 13:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B6C0615E7;
        Wed, 30 Mar 2022 20:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1EDC340EC;
        Wed, 30 Mar 2022 20:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648671380;
        bh=dFReK6G/ccqgxyvll3RmFnqr4xK5lD8zAWj5KJcsY9k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dEQJQG9lABs7yWkrhMxL9f9z14ZF87wT3ku3wy2CbRtmMLAIVhVqvqrRRlTev1z4s
         POhXsVvUz9Kz1UJkHsUofSmTNFDoq8zKSZRhpxkEN+Njo7u8dWt7/2UsJDQEFlxrr4
         SJamsoRTAklkUWzUuIdbe2pKhZZSUWlAa3K+cafOlGwrXFEJAOgmqsbV+r6DKrBb1H
         +8N1XPu8syL3CkAkeW+5r6i+X9fAPNj5BKhFkVaMaaabUMzCBi3HV6/3DNbMpcsyvA
         epip0Sy5+tVn22fpHk5vA3+ht1E9g7NMfeSVGGdqWERPsTpQlGsvGqiKOBOqnqwmm1
         yIZR68TNVIFNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4D6895C12E4; Wed, 30 Mar 2022 13:16:20 -0700 (PDT)
Date:   Wed, 30 Mar 2022 13:16:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Put the irq work into hard interrupt context for
 execution
Message-ID: <20220330201620.GM4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220330060012.2470054-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330060012.2470054-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 02:00:12PM +0800, Zqiang wrote:
> In PREEMPT_RT kernel, if irq work flags is not set, it will be
> executed in per-CPU irq_work kthreads. set IRQ_WORK_HARD_IRQ flags
> to irq work, put it in the context of hard interrupt execution,
> accelerate scheduler to re-evaluate.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c        | 2 +-
>  kernel/rcu/tree_plugin.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e2ffbeceba69..a69587773a85 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -678,7 +678,7 @@ static void late_wakeup_func(struct irq_work *work)
>  }
>  
>  static DEFINE_PER_CPU(struct irq_work, late_wakeup_work) =
> -	IRQ_WORK_INIT(late_wakeup_func);
> +	IRQ_WORK_INIT_HARD(late_wakeup_func);

This is used only by rcu_irq_work_resched(), which is invoked only by
rcu_user_enter(), which is never invoked until userspace is enabled,
by which time all of the various kthreads will have been spawned, correct?

Either way, please show me the exact sequence of events that lead to a
problem with the current IRQ_WORK_INIT().

>  /*
>   * If either:
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 3037c2536e1f..cf7bd28af8ef 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -661,7 +661,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
> -				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
> +				rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
>  				rdp->defer_qs_iw_pending = true;
>  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>  			}

OK, in theory, rcu_read_unlock() could get to this point before all of
the various kthreads were spawned.  In practice, the next time that the
boot CPU went idle, the end of the quiescent state would be noticed.

Or has this been failing in some other manner?  If so, please let me
know the exact sequence of events.

							Thanx, Paul
