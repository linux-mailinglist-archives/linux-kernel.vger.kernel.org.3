Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EA45606F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiF2RGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiF2RF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FAD3B296;
        Wed, 29 Jun 2022 10:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F234761E42;
        Wed, 29 Jun 2022 17:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE7FC341C8;
        Wed, 29 Jun 2022 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656522356;
        bh=KIFRM8nwOuVLd+9MyiDnuk3iBXdJb5KJ3YZk9O/MIaA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DY0Qe//FUSGFB1cD3BQp9Tj4JNh5MlXern4Mxa/sB1jd4Y2Yr8B4h4LuQy2aUDurX
         w61bbRHwB6P2dL7Fmpw43yja9XHCKwsxUfBjLGT8hQC0Z5jamyLPPXdgwWlUZmpF34
         +0dzHIdSiiFo++q+cLmy7V3GYpsg0PrBUC+0VffAVma/xK1axP3+15p3AD77hgqwUc
         WU3ED7FDTASm1WGuVaBKdQjg0jDFQzqCpA0kvEHL38LbcZWdYEoWwFjzBfEuym4LUr
         Tl0NJg6zKXBPGM+BX+7FPKDoDXN3G5C7OI1Hg+zckH+s6+nWBIwVZMBw2z5n7jPPMV
         p+LEIjcwWjrlg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E529C5C0E5F; Wed, 29 Jun 2022 10:05:55 -0700 (PDT)
Date:   Wed, 29 Jun 2022 10:05:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <20220629170555.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
 <20220629115349.GA2119930@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629115349.GA2119930@lothringen>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 01:53:49PM +0200, Frederic Weisbecker wrote:
> On Wed, Jun 22, 2022 at 10:50:55PM +0000, Joel Fernandes (Google) wrote:
> > @@ -414,30 +427,37 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >  	}
> >  	WRITE_ONCE(rdp->nocb_nobypass_count, c);
> >  
> > -	// If there hasn't yet been all that many ->cblist enqueues
> > -	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
> > -	// ->nocb_bypass first.
> > -	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
> > +	// If caller passed a non-lazy CB and there hasn't yet been all that
> > +	// many ->cblist enqueues this jiffy, tell the caller to enqueue it
> > +	// onto ->cblist.  But flush ->nocb_bypass first. Also do so, if total
> > +	// number of CBs (lazy + non-lazy) grows too much.
> > +	//
> > +	// Note that if the bypass list has lazy CBs, and the main list is
> > +	// empty, and rhp happens to be non-lazy, then we end up flushing all
> > +	// the lazy CBs to the main list as well. That's the right thing to do,
> > +	// since we are kick-starting RCU GP processing anyway for the non-lazy
> > +	// one, we can just reuse that GP for the already queued-up lazy ones.
> > +	if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
> > +	    (lazy && n_lazy_cbs >= qhimark)) {
> >  		rcu_nocb_lock(rdp);
> >  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> >  		if (*was_alldone)
> >  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> > -					    TPS("FirstQ"));
> > -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > +					    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
> > +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
> 
> That's outside the scope of this patchset but this makes me realize we
> unconditionally try to flush the bypass from call_rcu() fastpath, and
> therefore we unconditionally lock the bypass lock from call_rcu() fastpath.
> 
> It shouldn't be contended at this stage since we are holding the nocb_lock
> already, and only the local CPU can hold the nocb_bypass_lock without holding
> the nocb_lock. But still...
> 
> It looks safe to locklessly early check if (rcu_cblist_n_cbs(&rdp->nocb_bypass))
> before doing anything. Only the local CPU can enqueue to the bypass list.
> 
> Adding that to my TODO list...

That does sound like a potentially very helpful approach!  As always,
please analyze and test carefully!

							Thanx, Paul
