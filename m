Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C6C5ABF77
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiICPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiICPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 11:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA72B26A;
        Sat,  3 Sep 2022 08:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36EDF60F43;
        Sat,  3 Sep 2022 15:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858F5C433C1;
        Sat,  3 Sep 2022 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662217822;
        bh=8IEA9lKfjv6wyMTNOQpS9rK6fnzPn4FCZYLIOnHNrUc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r+8ZgbVMJlKdmFUvR21SRCjE5TzL/DUWP2uYVTUsQseS+r8x9ZkbMxr24t7r9pPeu
         IGILim5MhLVRm3YZloFonxyw32lh/e023DlonEqhyPOeghHT4zGjzyfZgliyB2yDG0
         3jX4aTXcJZlR817Fho7bvSbibNSndloS7v8fdI9Cz6VPyP8N5n0O2NyezB2cyJwTNK
         yFH/qregllUR+cGw6ovMpl+DPoF+8QdsCenagh4y1PBOKVa3WzLvVXJ4bJRgldlnbr
         t7Ii9K4rEj/cU2PhUpeYNF3dCdHvcSGu+jka2Gra7XtbyhJHjyiqDjcpMcm4h8b7Ep
         hgHhiXFdY07PA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 170145C086C; Sat,  3 Sep 2022 08:10:22 -0700 (PDT)
Date:   Sat, 3 Sep 2022 08:10:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 04/18] rcu: Fix late wakeup when flush of bypass
 cblist happens
Message-ID: <20220903151022.GV6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-5-joel@joelfernandes.org>
 <20220902113500.GA113405@lothringen>
 <d24157f4-924c-7113-75ac-ed691191584f@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d24157f4-924c-7113-75ac-ed691191584f@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 07:58:42PM -0400, Joel Fernandes wrote:
> On 9/2/2022 7:35 AM, Frederic Weisbecker wrote:
> > On Thu, Sep 01, 2022 at 10:17:06PM +0000, Joel Fernandes (Google) wrote:
> >> When the bypass cblist gets too big or its timeout has occurred, it is
> >> flushed into the main cblist. However, the bypass timer is still running
> >> and the behavior is that it would eventually expire and wake the GP
> >> thread.
> >>
> >> Since we are going to use the bypass cblist for lazy CBs, do the wakeup
> >> soon as the flush happens. Otherwise, the lazy-timer will go off much
> >> later and the now-non-lazy cblist CBs can get stranded for the duration
> >> of the timer.
> >>
> >> This is a good thing to do anyway (regardless of this series), since it
> >> makes the behavior consistent with behavior of other code paths where queueing
> >> something into the ->cblist makes the GP kthread in a non-sleeping state
> >> quickly.
> >>
> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> ---
> >>  kernel/rcu/tree_nocb.h | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> >> index 0a5f0ef41484..31068dd31315 100644
> >> --- a/kernel/rcu/tree_nocb.h
> >> +++ b/kernel/rcu/tree_nocb.h
> >> @@ -447,7 +447,13 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >>  			rcu_advance_cbs_nowake(rdp->mynode, rdp);
> >>  			rdp->nocb_gp_adv_time = j;
> >>  		}
> >> -		rcu_nocb_unlock_irqrestore(rdp, flags);
> >> +
> >> +		// The flush succeeded and we moved CBs into the ->cblist.
> >> +		// However, the bypass timer might still be running. Wakeup the
> >> +		// GP thread by calling a helper with was_all_done set so that
> >> +		// wake up happens (needed if main CB list was empty before).
> >> +		__call_rcu_nocb_wake(rdp, true, flags)
> >> +
> > 
> > Ok so there are two different changes here:
> > 
> > 1) wake up nocb_gp as we just flushed the bypass list. Indeed if the regular
> >    callback list was empty before flushing, we rather want to immediately wake
> >    up nocb_gp instead of waiting for the bypass timer to process them.
> > 
> > 2) wake up nocb_gp unconditionally (ie: even if the regular queue was not empty
> >    before bypass flushing) so that nocb_gp_wait() is forced through another loop
> >    starting with cancelling the bypass timer (I suggest you put such explanation
> >    in the comment btw because that process may not be obvious for mortals).
> > 
> > The change 1) looks like a good idea to me.
> > 
> > The change 2) has unclear motivation. It forces nocb_gp_wait() through another
> > costly loop even though the timer might have been cancelled into some near
> > future, eventually avoiding that extra costly loop. Also it abuses the
> > was_alldone stuff and we may get rcu_nocb_wake with incoherent meanings
> > (WakeEmpty/WakeEmptyIsDeferred) when it's actually not empty.
> 
> Yes #2 can be optimized as follows I think on top of this patch, good point:

I am holding off on this for the moment.

							Thanx, Paul

> =============
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index ee5924ba2f3b..24aabd723abd 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -514,12 +514,13 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp,
> struct rcu_head *rhp,
>             ncbs >= qhimark) {
>                 rcu_nocb_lock(rdp);
> 
> +               *was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> +
>                 rcu_cblist_set_flush(&rdp->nocb_bypass,
>                                 lazy ? BIT(CB_DEBUG_BYPASS_LAZY_FLUSHED) :
> BIT(CB_DEBUG_BYPASS_FLUSHED),
>                                 (j - READ_ONCE(cb_debug_jiffies_first)));
> 
>                 if (!rcu_nocb_flush_bypass(rdp, rhp, j, lazy, false)) {
> -                       *was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>                         if (*was_alldone)
>                                 trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>                                                     TPS("FirstQ"));
> @@ -537,7 +538,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct
> rcu_head *rhp,
>                 // However, the bypass timer might still be running. Wakeup the
>                 // GP thread by calling a helper with was_all_done set so that
>                 // wake up happens (needed if main CB list was empty before).
> -               __call_rcu_nocb_wake(rdp, true, flags)
> +               __call_rcu_nocb_wake(rdp, *was_all_done, flags)
> 
>                 return true; // Callback already enqueued.
>         }
> =============
> 
> > So you may need to clarify the purpose. And I would suggest to make two patches
> > here.
> I guess this change only #2 is no longer a concern? And splitting is not needed
> then as it is only #1.
> 
> Thanks,
> 
>  - Joel
> 
> 
> 
> 
> 
