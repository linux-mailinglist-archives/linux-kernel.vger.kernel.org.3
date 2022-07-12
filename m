Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559D257296B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiGLWl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiGLWl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:41:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A132AC9107;
        Tue, 12 Jul 2022 15:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F07B0B81C02;
        Tue, 12 Jul 2022 22:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62AFC3411C;
        Tue, 12 Jul 2022 22:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657665712;
        bh=gcpS5IjNq7vPIAW2z9IP0oEJtHOCjjqDUGD6XXcRb4I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R+hd0m4+30tYLrDZDH9CrNlEFC5lAhUQyLS7wjMyl8XzQ92GbiAxaNxPUQnsv2UY4
         gPLU/KDMTI9XRD7tzSVbBGBBZr9KC/Yszy4Ru7ITXq+nunbdc/ldb0v6OJtUiGaPN5
         oq67o1iKNe0E3zHP7vpe5pAPPFjnzqIzNDxqnKQlJ2aCWA1KQWVOTMSS9ndIieQA68
         soC5ONAQKzjNjvdIWFfASZ0w6aCEVwt5u80EjhPhLMERerlRJV4lPMQUKVAeGis0pa
         HucyIeO3o/OVuHSddP+Mv5COpsSXUgQMtz+6nQ5T6/Zgt7dh/q+yHyqb44WctXxg3c
         VZAo+ARZ1wrdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3C0C25C08C7; Tue, 12 Jul 2022 15:41:52 -0700 (PDT)
Date:   Tue, 12 Jul 2022 15:41:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <20220712224152.GI1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
 <20220626040019.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yso4690g+lI/8eJS@google.com>
 <20220710160330.GI1790663@paulmck-ThinkPad-P17-Gen-1>
 <aef0f8a6-cde6-18f3-16ab-7e07a4413f31@joelfernandes.org>
 <20220712210406.GF1790663@paulmck-ThinkPad-P17-Gen-1>
 <8441c152-2953-3cb1-c585-b3b0d48a363f@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8441c152-2953-3cb1-c585-b3b0d48a363f@joelfernandes.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 05:10:41PM -0400, Joel Fernandes wrote:
> 
> 
> On 7/12/2022 5:04 PM, Paul E. McKenney wrote:
> > On Tue, Jul 12, 2022 at 04:53:48PM -0400, Joel Fernandes wrote:
> >>
> >> On 7/10/2022 12:03 PM, Paul E. McKenney wrote:
> >> [..]
> >>>>>> +	// Note that if the bypass list has lazy CBs, and the main list is
> >>>>>> +	// empty, and rhp happens to be non-lazy, then we end up flushing all
> >>>>>> +	// the lazy CBs to the main list as well. That's the right thing to do,
> >>>>>> +	// since we are kick-starting RCU GP processing anyway for the non-lazy
> >>>>>> +	// one, we can just reuse that GP for the already queued-up lazy ones.
> >>>>>> +	if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
> >>>>>> +	    (lazy && n_lazy_cbs >= qhimark)) {
> >>>>>>  		rcu_nocb_lock(rdp);
> >>>>>>  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> >>>>>>  		if (*was_alldone)
> >>>>>>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> >>>>>> -					    TPS("FirstQ"));
> >>>>>> -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> >>>>>> +					    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
> >>>>>> +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
> >>>>>
> >>>>> The "false" here instead of "lazy" is because the caller is to do the
> >>>>> enqueuing, correct?
> >>>>
> >>>> There is no difference between using false or lazy here, because the bypass
> >>>> flush is not also enqueuing the lazy callback, right?
> >>>>
> >>>> We can also pass lazy instead of false if that's less confusing.
> >>>>
> >>>> Or maybe I missed the issue you're raising?
> >>>
> >>> I am mostly checking up on your intended meaning of "lazy" in various
> >>> contexts.  It could mean only that the caller requested laziness, or in
> >>> some cases it could mean that the callback actually will be lazy.
> >>>
> >>> I can rationalize the "false" above as a "don't care" in this case
> >>> because (as you say) there is not callback.  In which case this code
> >>> is OK as is, as long as the header comment for rcu_nocb_flush_bypass()
> >>> clearly states that this parameter has meaning only when there really
> >>> is a callback being queued.
> >>
> >> I decided to change this and the below to "lazy" variable instead of
> >> true/false, as the code is cleaner and less confusing IMO. It makes
> >> sense to me and in my testing it works fine. Hope that's Ok with you.
> > 
> > Sounds plausible.
> > 
> >> About changing the lazy length count to a flag, one drawback of doing
> >> that is, say if there are some non-lazy CBs in the bypass list, then the
> >> lazy shrinker will end up reporting an inaccurate count. Also
> >> considering that it might be harder to add the count back later say if
> >> we need it for tracing, I would say lets leave it as is. I will keep the
> >> counter for v3 and we can discuss. Does that sound good to you?
> > 
> > You lost me on this one.  If there are any non-lazy callbacks, the whole
> > bypass list is already being treated as non-lazy, right?  If so, then
> > the lazy shrinker should report the full count if all callbacks are lazy,
> > and should report none otherwise.  Or am I missing something here?
> > 
> 
> That's one way to interpret it, another way is say there were a 1000
> lazy CBs, and now 1 non-lazy came in. The shrinker could report the lazy
> count as 0 per your interpretation. Yes its true they will get flushed
> out in the next jiffie, but for that time instant, the number of lazy
> CBs in the list is not zero! :) Yeah OK its a weak argument, still an
> argument! ;-)
> 
> In any case, we saw the need for the length of the segcb lists to figure
> out things via tracing, so I suspect we may need this in the future as
> well, its a small cost so I would rather keep it if that's Ok with you! :)

OK, being needed for tracing/diagnostics is a somewhat less weak argument...

Let's see what v3 looks like.

							Thanx, Paul
