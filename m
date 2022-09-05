Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC75AD35C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbiIENAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbiIEM7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:59:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79584140A9;
        Mon,  5 Sep 2022 05:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 159406129D;
        Mon,  5 Sep 2022 12:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3889C433D7;
        Mon,  5 Sep 2022 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662382792;
        bh=2eOqgawcABXVV4gOh23+WeWnGET+f/Aa/lTAgLHKL6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iokQNvZYDslZwVeN03ttTAM4Vsa0dSThsuIToPp/F6bErZkx/3Hl/TarEPziQPgrL
         DFq3cg3wj/pDNsEGlhSysLqqzsgbH2jBegL8rZv9JpaRPxLYiLowinp/8KbhGsTHgn
         auogjceKHl3vkOyiCWrk3JHp/exXB59Bdn23F57KDVmXLYDygHiK6BcEgdxzrv3y84
         Fo+Hrvw35e7aXceILMzYtV+psUd06uQKZ5zn+seeFRXjY6XkUTn5/JkXU5tuDUiWlM
         x/WbxZqE+ny0oa2R8VIEhbMiBQnVXJ847JosNXukmMZX2SjhwPOFczfPnRNM+CZKOo
         Pk3Ma9FHAhB3g==
Date:   Mon, 5 Sep 2022 14:59:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <20220905125949.GA173859@lothringen>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <67122ae3-d69e-438c-18fc-a8de6e40201e@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67122ae3-d69e-438c-18fc-a8de6e40201e@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 07:09:39PM -0400, Joel Fernandes wrote:
> On 9/2/2022 11:21 AM, Frederic Weisbecker wrote:
> >> @@ -3904,7 +3943,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> >>  	rdp->barrier_head.func = rcu_barrier_callback;
> >>  	debug_rcu_head_queue(&rdp->barrier_head);
> >>  	rcu_nocb_lock(rdp);
> >> -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> >> +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false,
> >> +		     /* wake gp thread */ true));
> > 
> > It's a bad sign when you need to start commenting your boolean parameters :)
> > Perhaps use a single two-bit flag instead of two booleans, for readability?
> 
> That's fair, what do you mean 2-bit flag? Are you saying, we encode the last 2
> parameters to flush bypass in a u*?

Yeah exactly. Such as rcu_nocb_flush_bypass(rdp, NULL, jiffies, FLUSH_LAZY | FLUSH_WAKE)

> 
> > Also that's a subtle change which purpose isn't explained. It means that
> > rcu_barrier_entrain() used to wait for the bypass timer in the worst case
> > but now we force rcuog into it immediately. Should that be a separate change?
> 
> It could be split, but it is laziness that amplifies the issue so I thought of
> keeping it in the same patch. I don't mind one way or the other.

Ok then lets keep it here but please add a comment for the reason to
force wake here.

> >> +	case RCU_NOCB_WAKE_BYPASS:
> >> +		mod_jif = 2;
> >> +		break;
> >> +
> >> +	case RCU_NOCB_WAKE:
> >> +	case RCU_NOCB_WAKE_FORCE:
> >> +		// For these, make it wake up the soonest if we
> >> +		// were in a bypass or lazy sleep before.
> >>  		if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
> >> -			mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
> >> -		if (rdp_gp->nocb_defer_wakeup < waketype)
> >> -			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> >> +			mod_jif = 1;
> >> +		break;
> >>  	}
> >>  
> >> +	if (mod_jif)
> >> +		mod_timer(&rdp_gp->nocb_timer, jiffies + mod_jif);
> >> +
> >> +	if (rdp_gp->nocb_defer_wakeup < waketype)
> >> +		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> > 
> > So RCU_NOCB_WAKE_BYPASS and RCU_NOCB_WAKE_LAZY don't override the timer state
> > anymore? Looks like something is missing.
> 
> My goal was to make sure that NOCB_WAKE_LAZY wake keeps the timer lazy. If I
> don't do this, then when CPU enters idle, it will immediately do a wake up via
> this call:
> 
> 	rcu_nocb_need_deferred_wakeup(rdp_gp, RCU_NOCB_WAKE)

But if the timer is in RCU_NOCB_WAKE_LAZY mode, that shouldn't be a problem.

> 
> That was almost always causing lazy CBs to be non-lazy thus negating all the
> benefits.
> 
> Note that bypass will also have same issue where the bypass CB will not wait for
> intended bypass duration. To make it consistent with lazy, I made bypass also
> not override nocb_defer_wakeup.

I'm surprised because rcu_nocb_flush_deferred_wakeup() should only do the wake up
if the timer is RCU_NOCB_WAKE or RCU_NOCB_WAKE_FORCE. Or is that code buggy
somehow?

Actually your change is modifying the timer delay without changing the timer
mode, which may shortcut rcu_nocb_flush_deferred_wakeup() check and actually
make it perform early upon idle loop entry.

Or am I missing something?


> 
> I agree its not pretty, but it works and I could not find any code path where it
> does not work. That said, I am open to ideas for changing this and perhaps some
> of these unneeded delays with bypass CBs can be split into separate patches.
> 
> Regarding your point about nocb_defer_wakeup state diverging from the timer
> programming, that happens anyway here in current code:
> 
>  283        } else {
>  284                if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
>  285                        mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
>  286                if (rdp_gp->nocb_defer_wakeup < waketype)
>  287                        WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>  288        }

How so?

> >> @@ -705,12 +816,21 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >>  	my_rdp->nocb_gp_gp = needwait_gp;
> >>  	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
> >>  
> >> -	if (bypass && !rcu_nocb_poll) {
> >> -		// At least one child with non-empty ->nocb_bypass, so set
> >> -		// timer in order to avoid stranding its callbacks.
> >> -		wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
> >> -				   TPS("WakeBypassIsDeferred"));
> >> +	// At least one child with non-empty ->nocb_bypass, so set
> >> +	// timer in order to avoid stranding its callbacks.
> >> +	if (!rcu_nocb_poll) {
> >> +		// If bypass list only has lazy CBs. Add a deferred
> >> +		// lazy wake up.
> >> +		if (lazy && !bypass) {
> >> +			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_LAZY,
> >> +					TPS("WakeLazyIsDeferred"));
> > 
> > What if:
> > 
> > 1) rdp(1) has lazy callbacks
> > 2) all other rdp's have no callback at all
> > 3) nocb_gp_wait() runs through all rdp's, everything is handled, except for
> >    these lazy callbacks
> > 4) It reaches the above path, ready to arm the RCU_NOCB_WAKE_LAZY timer,
> >    but it hasn't yet called wake_nocb_gp_defer()
> > 5) Oh but rdp(2) queues a non-lazy callback. interrupts are disabled so it defers
> >    the wake up to nocb_gp_wait() with arming the timer in RCU_NOCB_WAKE.
> > 6) nocb_gp_wait() finally calls wake_nocb_gp_defer() and override the timeout
> >    to several seconds ahead.
> > 7) No more callbacks queued, the non-lazy callback will have to wait several
> >    seconds to complete.
> > 
> > Or did I miss something?
> 
> In theory, I can see this being an issue. In practice, I have not seen it to
> be.

What matters is that the issue looks plausible.

> In my view, the nocb GP thread should not go to sleep in the first place if
> there are any non-bypass CBs being queued. If it does, then that seems an
> optimization-related bug.

Yeah, it's a constraint introduced by the optimized delayed wake up.
By why would RCU_NOCB_WAKE_LAZY need to overwrite RCU_NOCB_WAKE in the first
place?

> 
> That said, we can make wake_nocb_gp_defer() more robust perhaps by making it not
> overwrite the timer if the wake-type requested is weaker than RCU_NOCB_WAKE,
> however that should not cause the going-into-idle issues I pointed. Whether the
> idle time issue will happen, I have no idea. But in theory, will that address
> your concern above?

Yes, but I'm still confused by this idle time issue.

> 
> > Note that the race exists with RCU_NOCB_WAKE_BYPASS
> > but it's only about one jiffy delay, not seconds.
> 
> Well, 2 jiffies. But yeah.
> 
> Thanks, so far I do not see anything that cannot be fixed on top of this patch
> but you raised some good points. Maybe we ought to rewrite the idle path to not
> disturb lazy CBs in a different way, or something (while keeping the timer state
> consistent with the programming of the timer in wake_nocb_gp_defer()).

I'd rather see an updated patch (not the whole patchset but just this one) rather
than deltas, just to make sure I'm not missing something in the whole picture.

Thanks.
