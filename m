Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFBC4B5751
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356442AbiBNQoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:44:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353459AbiBNQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:44:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821F960D8F;
        Mon, 14 Feb 2022 08:44:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EDD7614D0;
        Mon, 14 Feb 2022 16:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847A8C340E9;
        Mon, 14 Feb 2022 16:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644857075;
        bh=+Ul9ZI9HN2iowXmQeqpOx9t7aXHQnEWGLPnkZRHoU9w=;
        h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
        b=o+X5xWqh+9cqj0N8XiHp7Bf2Bf2IhiKT+CVLnEAtRecTNBPDCk91/txutU2fhrM1e
         2bqNDcrIr5YviKcca3mWiRFgPmbk/o5dT3bD0La1aSMT8Rv8hQK0Afkgo/Pvu13oi0
         aCpipqIoHN5GYj06aF1tAFpqCkRA/eL68WNlaynsRqaAiddPdpr6Zb7ORCj2lmL0WR
         DgymN7V9lT3YNIDRk7ydtMsZJGLWDgZKd4oUzkmkSsZUg2GaYec419MjwrH7GM31Zf
         8sHGc9qhxQ7C+pE71Sir2xy4hKYQdzyMSl7FiQCirIQX3PaItxJYMnCbP+XMh27C/k
         1phAgMGQLQMZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 46C405C0388; Mon, 14 Feb 2022 08:44:35 -0800 (PST)
Date:   Mon, 14 Feb 2022 08:44:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        quic_mojha@quicinc.com, rcu@vger.kernel.org, rostedt@goodmis.org,
        tj@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH rcu 3/3] rcu: Allow expedited RCU grace periods on
 incoming CPUs
Message-ID: <20220214164435.GA2805255@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220209233811.GC557593@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209233811.GC557593@lothringen>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 12:38:11AM +0100, Frederic Weisbecker wrote:
> On Fri, Feb 04, 2022 at 02:55:07PM -0800, Paul E. McKenney wrote:
> > Although it is usually safe to invoke synchronize_rcu_expedited() from a
> > preemption-enabled CPU-hotplug notifier, if it is invoked from a notifier
> > between CPUHP_AP_RCUTREE_ONLINE and CPUHP_AP_ACTIVE, its attempts to
> > invoke a workqueue handler will hang due to RCU waiting on a CPU that
> > the scheduler is not paying attention to.  This commit therefore expands
> > use of the existing workqueue-independent synchronize_rcu_expedited()
> > from early boot to also include CPUs that are being hotplugged.
> > 
> > Link: https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
> > Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> I'm surprised by this scheduler behaviour.
> 
> Since sched_cpu_activate() hasn't been called yet,
> rq->balance_callback = balance_push_callback. As a result, balance_push() should
> be called at the end of schedule() when the workqueue is picked as the next task.
> Then eventually the workqueue should be immediately preempted by the stop task to
> be migrated elsewhere.
> 
> So I must be missing something. For the fun, I booted the following and it
> didn't produce any issue:
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 80faf2273ce9..b1e74a508881 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4234,6 +4234,8 @@ int rcutree_online_cpu(unsigned int cpu)
>  
>  	// Stop-machine done, so allow nohz_full to disable tick.
>  	tick_dep_clear(TICK_DEP_BIT_RCU);
> +	if (cpu != 0)
> +		synchronize_rcu_expedited();
>  	return 0;
>  }

That does seem compelling.  And others have argued that the workqueue
system's handling of offline CPUs should deal with this.

Mukesh, was this a theoretical bug, or did you actually make it happen?
If you made it happen, as seems to have been the case given your original
email [1], could you please post your reproducer?

							Thanx, Paul

[1] https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
