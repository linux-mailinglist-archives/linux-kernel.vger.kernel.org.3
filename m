Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592BC465B28
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354949AbhLBAp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:45:59 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57864 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354985AbhLBApL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:45:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4DC0ACE2073;
        Thu,  2 Dec 2021 00:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DCFC00446;
        Thu,  2 Dec 2021 00:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405706;
        bh=Zw3QWYNvmZ52RDnMhOiLMv7PpdGoNvyrGuD4QFpzGSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7a2MxYwZbPLXHc4SwIFIu/WJhgr5nIJPepfiSg3+zAIHBri8yi1pDHq85zxd0sfF
         k6Qr/1n5SP/vwViWoiA/L2zD3Ga5FNnFvAMwxCDx08f5maPuVzQzHqQkLhxGf+SmgI
         WABuKceDPljMp85IAefvJidXQi5TUbgTtETXyAmYFI/75pSCuiDj6MlsIDl5aGse9f
         tzdUkqL4Cz7ag9lB+PnQDANBuixbNEB/m60Ve/5hbBZeBNscGHDgq0fSYZ37ZFVe2Q
         zEh11u30s/nZIyJ7CEuZBYoSx+yY/XMzL2oTkFfwqDcnOTf14gx8VSkK8YZLcq75JC
         mIY0ga8Yr8Miw==
Date:   Thu, 2 Dec 2021 01:41:42 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Guillaume Morin <guillaume@morinfr.org>
Subject: Re: [PATCH rcu 01/18] rcu: Tighten rcu_advance_cbs_nowake() checks
Message-ID: <20211202004142.GA631289@lothringen>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
 <20211202002912.3127710-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202002912.3127710-1-paulmck@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 04:28:55PM -0800, Paul E. McKenney wrote:
> Currently, rcu_advance_cbs_nowake() checks that a grace period is in
> progress, however, that grace period could end just after the check.
> This commit rechecks that a grace period is still in progress the lock.

*while holding the node lock.

> The grace period cannot end while the current CPU's rcu_node structure's
> ->lock is held, thus avoiding false positives from the WARN_ON_ONCE().
> 
> As Daniel Vacek noted, it is not necessary for the rcu_node structure
> to have a CPU that has not yet passed through its quiescent state.
> 
> Tested-By: Guillaume Morin <guillaume@morinfr.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Thanks!

> ---
>  kernel/rcu/tree.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ef8d36f580fc3..8706b30c2ac88 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1590,10 +1590,11 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
>  						  struct rcu_data *rdp)
>  {
>  	rcu_lockdep_assert_cblist_protected(rdp);
> -	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) ||
> -	    !raw_spin_trylock_rcu_node(rnp))
> +	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) || !raw_spin_trylock_rcu_node(rnp))
>  		return;
> -	WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
> +	// The grace period cannot end while we hold the rcu_node lock.
> +	if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))
> +		WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
>  	raw_spin_unlock_rcu_node(rnp);
>  }
>  
> -- 
> 2.31.1.189.g2e36527f23
> 
