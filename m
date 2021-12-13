Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CB3473522
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbhLMTl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:41:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36058 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242436AbhLMTly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:41:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55FED611DA;
        Mon, 13 Dec 2021 19:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA740C34602;
        Mon, 13 Dec 2021 19:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639424513;
        bh=qW9T2rELRJWjZiDK05qYGlaZ7KW6KZTBlr8kXEFzOF8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=L6GrtPu/82K+1q5q+iloPMWSevPfO/rE6Z/nmV/BSxv1Nchxsclgri48S3QB0SC0d
         YSN06jvilRT/b3o/cRfcLJrmMdCc+ZwZL1FCyNAfrkDJRxX+wO+4jrauoHPC22aI/J
         Kg/j8HU1or80fC7DJ5BbRfQ9mbmOrbufX9bGUSPD381TnunCebvyf+Up7ICBi9yOvP
         rFIgNfRTUyUwsUefNaDnXxBmu9JmrZkNIOu82XE/8UGm/J42HSV72eOyX4F/0xQLW/
         XoKi6LWgsyUPxK74YQlOqbEMgzZtX9ouelgAulFV2nCZSPsktXkGyKoaLLSawtroV+
         05tW6uf4QBDcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5F9105C0B9E; Mon, 13 Dec 2021 11:41:53 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:41:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        frederic@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH] rcu: Remove unused rcu_state.boost
Message-ID: <20211213194153.GS641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211213070209.7464-1-quic_neeraju@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213070209.7464-1-quic_neeraju@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:32:09PM +0530, Neeraj Upadhyay wrote:
> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

Good eyes!  This has since been replaced by the ->can_boost field of
the rcu_torture_ops structure.

Queued for review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.h        | 5 ++---
>  kernel/rcu/tree_plugin.h | 2 --
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 4b889081f4f4..caea946700f3 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -303,9 +303,8 @@ struct rcu_state {
>  
>  	/* The following fields are guarded by the root rcu_node's lock. */
>  
> -	u8	boost ____cacheline_internodealigned_in_smp;
> -						/* Subject to priority boost. */
> -	unsigned long gp_seq;			/* Grace-period sequence #. */
> +	unsigned long gp_seq ____cacheline_internodealigned_in_smp;
> +						/* Grace-period sequence #. */
>  	unsigned long gp_max;			/* Maximum GP duration in */
>  						/*  jiffies. */
>  	struct task_struct *gp_kthread;		/* Task for grace periods. */
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 1439cb3680eb..54ef0e8c8742 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1174,8 +1174,6 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
>  	if (rnp->boost_kthread_task || !rcu_scheduler_fully_active)
>  		goto out;
>  
> -	rcu_state.boost = 1;
> -
>  	t = kthread_create(rcu_boost_kthread, (void *)rnp,
>  			   "rcub/%d", rnp_index);
>  	if (WARN_ON_ONCE(IS_ERR(t)))
> -- 
> 2.17.1
> 
