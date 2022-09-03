Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913FC5ABF36
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 16:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiICOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiICOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 10:04:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35353F1FC;
        Sat,  3 Sep 2022 07:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 591B760F43;
        Sat,  3 Sep 2022 14:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA18C433C1;
        Sat,  3 Sep 2022 14:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662213843;
        bh=j/pj0bHVmuYUq9znAh7I/ovm3zE9qoINZ/qCciC00os=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GLH23crRycOQvp7HHp46YTGhuedwfQ77Fn7DNVjFcVA/1AdWwzndlf9Xh+pNbh7Z6
         EwJZ+j5eNb4dxh30eIOwm49KfDLRHcp27fovvc3Pe6rqiE67pLhfnrBQQ0IVr7+yiM
         4cxUaJ4Dv5RsT0RHH/lb/Ug+LITyR17vfkLwFGI6ckv5RsLNXWtFJskgYFr5m+b9FY
         abR7/1ZkqDjZlYtNZm081QHkatIqfZ3vuGYnVcf0hzxtE8f6qdQJE8YxSsEyEW3DaJ
         5P5jKVi+AnIGJpZtWAjkgCsdFBHhzmMM00keeGwJLacqmiFVcRSH79B1G0qB4lhS9C
         N9v5yDq/NfFlA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 601B45C0531; Sat,  3 Sep 2022 07:04:03 -0700 (PDT)
Date:   Sat, 3 Sep 2022 07:04:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 04/18] rcu: Fix late wakeup when flush of bypass
 cblist happens
Message-ID: <20220903140403.GU6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901221720.1105021-5-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:17:06PM +0000, Joel Fernandes (Google) wrote:
> When the bypass cblist gets too big or its timeout has occurred, it is
> flushed into the main cblist. However, the bypass timer is still running
> and the behavior is that it would eventually expire and wake the GP
> thread.
> 
> Since we are going to use the bypass cblist for lazy CBs, do the wakeup
> soon as the flush happens. Otherwise, the lazy-timer will go off much
> later and the now-non-lazy cblist CBs can get stranded for the duration
> of the timer.
> 
> This is a good thing to do anyway (regardless of this series), since it
> makes the behavior consistent with behavior of other code paths where queueing
> something into the ->cblist makes the GP kthread in a non-sleeping state
> quickly.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_nocb.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 0a5f0ef41484..31068dd31315 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -447,7 +447,13 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  			rcu_advance_cbs_nowake(rdp->mynode, rdp);
>  			rdp->nocb_gp_adv_time = j;
>  		}
> -		rcu_nocb_unlock_irqrestore(rdp, flags);
> +
> +		// The flush succeeded and we moved CBs into the ->cblist.
> +		// However, the bypass timer might still be running. Wakeup the
> +		// GP thread by calling a helper with was_all_done set so that
> +		// wake up happens (needed if main CB list was empty before).
> +		__call_rcu_nocb_wake(rdp, true, flags)

TREE01 and TREE04 gripe about the missing ";".  I added it.

							Thanx, Paul

> +
>  		return true; // Callback already enqueued.
>  	}
>  
> -- 
> 2.37.2.789.g6183377224-goog
> 
