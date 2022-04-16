Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16C05033BB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiDPAXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 20:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiDPAW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 20:22:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E545C625B;
        Fri, 15 Apr 2022 17:20:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEDECB831C0;
        Sat, 16 Apr 2022 00:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B04AC385A4;
        Sat, 16 Apr 2022 00:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650068425;
        bh=MGY5sOKWDHr0IONFBvmLrFAAGBvZRGoXCHHFVj2f5cM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pXKAZlVv2VqcV6lZKS7kWAq5SwTg6zAWtK8XHhqlW6Bdy8tyJuYalqlXCRzCv9kGS
         dHtZvaS2eD81u0mLll/ID9c7UkP3ccNhbqmmjuJKcrUwh6vzf61LdfFb05axrpqX0+
         7TCuYbZAeqZcZLCcIHBnRmqDpafZv7kg4vmy14gxH168ZaSxq91TckLg64sz+iQqDQ
         /MnYGsDtpT9XfKViCrDiMtAfJs/cedVGpASOWy10jyB4K7qkcy5RptRCtiXwM9P/WG
         v6JkZQ0CtK4eSppjXuT3PiFgjiuRiiZbnDHLjim4FSg9U66dpdLBEr4eMNcOyaKTTx
         mGL+ze3FyOPdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0F1355C30D2; Fri, 15 Apr 2022 17:20:25 -0700 (PDT)
Date:   Fri, 15 Apr 2022 17:20:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Message-ID: <20220416002025.GO4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220413074411.2369623-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413074411.2369623-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:44:11PM +0800, Zqiang wrote:
> If the rcutree.use_softirq is configured, when RCU Stall event
> happened, dump status of all rcuc kthreads who due to starvation
> prevented grace period ends on CPUs that not report quiescent
> state.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

This could be a good improvement!  But a few questions and comments below.

							Thanx, Paul

> ---
>  kernel/rcu/tree_stall.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index d7956c03edbd..e6ecc32cfe23 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -348,6 +348,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
>  }
>  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>  
> +static void rcuc_kthread_dump(struct rcu_data *rdp);
>  /*
>   * Dump stacks of all tasks running on stalled CPUs.  First try using
>   * NMIs, but fall back to manual remote stack tracing on architectures
> @@ -368,6 +369,7 @@ static void rcu_dump_cpu_stacks(void)
>  					pr_err("Offline CPU %d blocking current GP.\n", cpu);
>  				else if (!trigger_single_cpu_backtrace(cpu))
>  					dump_cpu_task(cpu);
> +				rcuc_kthread_dump(per_cpu_ptr(&rcu_data, cpu));

Was this addition inspired by the chasing of a bug?  If so, please let me
know exactly what information was (or would have been) the most helpful.

For example, the starvation information might be more compactly
represented in the information printed by print_cpu_stall_info().
Unless the stack trace was quite valuable, it might be best to omit it.
After all, RCU CPU stall warnings are already infamously heavy on the
text output.

>  			}
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	}
> @@ -471,6 +473,9 @@ static void rcuc_kthread_dump(struct rcu_data *rdp)
>  	unsigned long j;
>  	struct task_struct *rcuc;
>  
> +	if (use_softirq)
> +		return;
> +
>  	rcuc = rdp->rcu_cpu_kthread_task;
>  	if (!rcuc)

The checks for use_softirq on the one hand and the checks for non-NULL
rdp->rcu_cpu_kthread_task are a bit "interesting".  Not your fault or
problem, of course!

>  		return;
> @@ -659,9 +664,6 @@ static void print_cpu_stall(unsigned long gps)
>  	rcu_check_gp_kthread_expired_fqs_timer();
>  	rcu_check_gp_kthread_starvation();
>  
> -	if (!use_softirq)

In particular, I am wondering if this "if" is redundant.

> -		rcuc_kthread_dump(rdp);
> -
>  	rcu_dump_cpu_stacks();
>  
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> -- 
> 2.25.1
> 
