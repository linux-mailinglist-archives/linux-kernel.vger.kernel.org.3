Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B47560C10
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiF2WBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiF2WBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F7E33349;
        Wed, 29 Jun 2022 15:01:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7B796154F;
        Wed, 29 Jun 2022 22:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3CEC34114;
        Wed, 29 Jun 2022 22:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656540077;
        bh=mFbXz9vYObUL4T0NtvzA2Dv8lJdjYdzhwt+Di4Q9MlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WSO5Hk87h6w+ubdc0VUZqD+oahL9CAWlLFFxJfjh+vUorOZuUVuItoIGHLt6AwKax
         H0v+mD0V+A+e45u5r2lMGn805cKGE/OO1uN8XODokYjGO3XY1HrEbfZJf/oI3TIMjS
         N/YHRdsz7cGEQZrDgrw+GfO2vb4qOfMkjrl/oLK2QXAYHCBbh+TmVIFAtPxx6AShyN
         0yr5Hul6/mC1RQvAMScA9hoE1CAG201AmU5g92R+ogSETXOdtXrEmpQFS0bdGryqkg
         yv/YxowpRK7ordXlYpB7pp+SOLTwkUX6zGHeEjzwgjzw+jVFPStAKH2yW9ISjdwDnb
         ywagcVVaYgEcg==
Date:   Thu, 30 Jun 2022 00:01:14 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <20220629220114.GA2127569@lothringen>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
 <20220629115349.GA2119930@lothringen>
 <Yry2PAc0KtkYW24A@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yry2PAc0KtkYW24A@google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 08:29:48PM +0000, Joel Fernandes wrote:
> On Wed, Jun 29, 2022 at 01:53:49PM +0200, Frederic Weisbecker wrote:
> > On Wed, Jun 22, 2022 at 10:50:55PM +0000, Joel Fernandes (Google) wrote:
> > > @@ -414,30 +427,37 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > >  	}
> > >  	WRITE_ONCE(rdp->nocb_nobypass_count, c);
> > >  
> > > -	// If there hasn't yet been all that many ->cblist enqueues
> > > -	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
> > > -	// ->nocb_bypass first.
> > > -	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
> > > +	// If caller passed a non-lazy CB and there hasn't yet been all that
> > > +	// many ->cblist enqueues this jiffy, tell the caller to enqueue it
> > > +	// onto ->cblist.  But flush ->nocb_bypass first. Also do so, if total
> > > +	// number of CBs (lazy + non-lazy) grows too much.
> > > +	//
> > > +	// Note that if the bypass list has lazy CBs, and the main list is
> > > +	// empty, and rhp happens to be non-lazy, then we end up flushing all
> > > +	// the lazy CBs to the main list as well. That's the right thing to do,
> > > +	// since we are kick-starting RCU GP processing anyway for the non-lazy
> > > +	// one, we can just reuse that GP for the already queued-up lazy ones.
> > > +	if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
> > > +	    (lazy && n_lazy_cbs >= qhimark)) {
> > >  		rcu_nocb_lock(rdp);
> > >  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> > >  		if (*was_alldone)
> > >  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> > > -					    TPS("FirstQ"));
> > > -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > > +					    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
> > > +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
> > 
> > That's outside the scope of this patchset but this makes me realize we
> > unconditionally try to flush the bypass from call_rcu() fastpath, and
> > therefore we unconditionally lock the bypass lock from call_rcu() fastpath.
> > 
> > It shouldn't be contended at this stage since we are holding the nocb_lock
> > already, and only the local CPU can hold the nocb_bypass_lock without holding
> > the nocb_lock. But still...
> > 
> > It looks safe to locklessly early check if (rcu_cblist_n_cbs(&rdp->nocb_bypass))
> > before doing anything. Only the local CPU can enqueue to the bypass list.
> > 
> > Adding that to my TODO list...
> > 
> 
> I am afraid I did not understand your comment. The bypass list lock is held
> once we have decided to use the bypass list to queue something on to it.
> 
> The bypass flushing is also conditional on either the bypass cblist growing
> too big or a jiffie elapsing since the first bypass queue.
> 
> So in both cases, acquiring the lock is conditional. What do you mean it is
> unconditionally acquiring the bypass lock? Where?

Just to make sure we are talking about the same thing, I'm referring to this
path:

	// If there hasn't yet been all that many ->cblist enqueues
	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
	// ->nocb_bypass first.
	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
		rcu_nocb_lock(rdp);
		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
		if (*was_alldone)
			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
					    TPS("FirstQ"));
		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
		return false; // Caller must enqueue the callback.
	}

This is called whenever we decide not to queue to the bypass list because
there is no flooding detected (rdp->nocb_nobypass_count hasn't reached
nocb_nobypass_lim_per_jiffy for the current jiffy). I call this the fast path
because this is what I would except in a normal load, as opposed to callbacks
flooding.

And in this fastpath, the above rcu_nocb_flush_bypass() is unconditional.

> 
> Thanks!
> 
>  - Joel
> 
