Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9906A497665
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 01:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbiAXAHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 19:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240530AbiAXAHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 19:07:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7946C06173B;
        Sun, 23 Jan 2022 16:07:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66A0861219;
        Mon, 24 Jan 2022 00:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9258C340E3;
        Mon, 24 Jan 2022 00:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642982854;
        bh=sOPV0ZX6vJ/xD8yptJMnME9m2gNuPb3oT/LNhk3LgiI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KAI8PcRr1KyEztG8DepJx/ckB7OmvLi1qrVhpOp3/WMkpHXIBJpxdWLRqVKFUWTmg
         fTNYjzlHcqPd9JhD6vvU760g0EkpHWsw9gx1/uYXg4QtwPlQpXG/CNZHW9CJlFvBVN
         fk/VXGpL6FU+IuCOKXQ23TXn4nuyCPnffUIyxMHFx5FmqN3/jkGkT25J8EqDp6QgnJ
         +TKyRMhYTK33qNlWxHPcRMU8keav1O+fIQxcTs/Mu410yi6/sRm9PhJnD9bDHHSnuf
         XihQ9mxR3gCCxoKP475YBQ+3wPsusnEPkl4kB7CkDf5j1j7ExDOhDSOYAqEpWSxoed
         U38BtFmEEuhYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7D9045C044F; Sun, 23 Jan 2022 16:07:34 -0800 (PST)
Date:   Sun, 23 Jan 2022 16:07:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 22/54] rcu: replace cpumask_weight with cpumask_empty
 where appropriate
Message-ID: <20220124000734.GB4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-23-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123183925.1052919-23-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:38:53AM -0800, Yury Norov wrote:
> In some places, RCU code calls cpumask_weight() to check if any bit of a
> given cpumask is set. We can do it more efficiently with cpumask_empty()
> because cpumask_empty() stops traversing the cpumask as soon as it finds
> first set bit, while cpumask_weight() counts all bits unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Good point!  Queued and pushed, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree_nocb.h   | 4 ++--
>  kernel/rcu/tree_plugin.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index eeafb546a7a0..f83c7b1d6110 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1169,7 +1169,7 @@ void __init rcu_init_nohz(void)
>  	struct rcu_data *rdp;
>  
>  #if defined(CONFIG_NO_HZ_FULL)
> -	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
> +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
>  		need_rcu_nocb_mask = true;
>  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>  
> @@ -1348,7 +1348,7 @@ static void __init rcu_organize_nocb_kthreads(void)
>   */
>  void rcu_bind_current_to_nocb(void)
>  {
> -	if (cpumask_available(rcu_nocb_mask) && cpumask_weight(rcu_nocb_mask))
> +	if (cpumask_available(rcu_nocb_mask) && !cpumask_empty(rcu_nocb_mask))
>  		WARN_ON(sched_setaffinity(current->pid, rcu_nocb_mask));
>  }
>  EXPORT_SYMBOL_GPL(rcu_bind_current_to_nocb);
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c5b45c2f68a1..0dc0c8d6717c 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1215,7 +1215,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>  		    cpu != outgoingcpu)
>  			cpumask_set_cpu(cpu, cm);
>  	cpumask_and(cm, cm, housekeeping_cpumask(HK_FLAG_RCU));
> -	if (cpumask_weight(cm) == 0)
> +	if (cpumask_empty(cm))
>  		cpumask_copy(cm, housekeeping_cpumask(HK_FLAG_RCU));
>  	set_cpus_allowed_ptr(t, cm);
>  	free_cpumask_var(cm);
> -- 
> 2.30.2
> 
