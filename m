Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFBA572839
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiGLVEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiGLVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:04:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25781658E;
        Tue, 12 Jul 2022 14:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57CB8B81BDC;
        Tue, 12 Jul 2022 21:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D63C3411C;
        Tue, 12 Jul 2022 21:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657659847;
        bh=St6/VdAKGLX+JJf7JsVyNpbfxGkR3gNsSZDo3YD+UPQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=refsQ9gY4AlqPp0e2bt982paTgyx7v5LAkIStviFafU6RJNRDx+jwlqapPTvnhF2m
         J1S8AalgLJjI4dJFsqVsDZAcLe61ppumzqm40au4EPVET1W/SwJonLHxpUfVvlgbng
         5nrC0ZJbiXQkgp0+GO4N4L9VVOJt0ccRECFg2lxj+PWVbyZQtdZFXjgvvOsFLUZwSb
         jjhTRy9qjM8MNrFa7rXoVxItZTmOlK+wKu0ZlBlGsTgkFP7VslhAhlAqXjLqjpv8oU
         NskUew8QAZEhSkK4SshVAyLipZfKmhOSQTPiG3c7qKdtODsrm9Ooe/f64fPcHWgGZA
         g11PXHGLtamzA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 890C75C08C7; Tue, 12 Jul 2022 14:04:06 -0700 (PDT)
Date:   Tue, 12 Jul 2022 14:04:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <20220712210406.GF1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
 <20220626040019.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yso4690g+lI/8eJS@google.com>
 <20220710160330.GI1790663@paulmck-ThinkPad-P17-Gen-1>
 <aef0f8a6-cde6-18f3-16ab-7e07a4413f31@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef0f8a6-cde6-18f3-16ab-7e07a4413f31@joelfernandes.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:53:48PM -0400, Joel Fernandes wrote:
> 
> On 7/10/2022 12:03 PM, Paul E. McKenney wrote:
> [..]
> >>>> +	// Note that if the bypass list has lazy CBs, and the main list is
> >>>> +	// empty, and rhp happens to be non-lazy, then we end up flushing all
> >>>> +	// the lazy CBs to the main list as well. That's the right thing to do,
> >>>> +	// since we are kick-starting RCU GP processing anyway for the non-lazy
> >>>> +	// one, we can just reuse that GP for the already queued-up lazy ones.
> >>>> +	if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
> >>>> +	    (lazy && n_lazy_cbs >= qhimark)) {
> >>>>  		rcu_nocb_lock(rdp);
> >>>>  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> >>>>  		if (*was_alldone)
> >>>>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> >>>> -					    TPS("FirstQ"));
> >>>> -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> >>>> +					    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
> >>>> +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
> >>>
> >>> The "false" here instead of "lazy" is because the caller is to do the
> >>> enqueuing, correct?
> >>
> >> There is no difference between using false or lazy here, because the bypass
> >> flush is not also enqueuing the lazy callback, right?
> >>
> >> We can also pass lazy instead of false if that's less confusing.
> >>
> >> Or maybe I missed the issue you're raising?
> > 
> > I am mostly checking up on your intended meaning of "lazy" in various
> > contexts.  It could mean only that the caller requested laziness, or in
> > some cases it could mean that the callback actually will be lazy.
> > 
> > I can rationalize the "false" above as a "don't care" in this case
> > because (as you say) there is not callback.  In which case this code
> > is OK as is, as long as the header comment for rcu_nocb_flush_bypass()
> > clearly states that this parameter has meaning only when there really
> > is a callback being queued.
> 
> I decided to change this and the below to "lazy" variable instead of
> true/false, as the code is cleaner and less confusing IMO. It makes
> sense to me and in my testing it works fine. Hope that's Ok with you.

Sounds plausible.

> About changing the lazy length count to a flag, one drawback of doing
> that is, say if there are some non-lazy CBs in the bypass list, then the
> lazy shrinker will end up reporting an inaccurate count. Also
> considering that it might be harder to add the count back later say if
> we need it for tracing, I would say lets leave it as is. I will keep the
> counter for v3 and we can discuss. Does that sound good to you?

You lost me on this one.  If there are any non-lazy callbacks, the whole
bypass list is already being treated as non-lazy, right?  If so, then
the lazy shrinker should report the full count if all callbacks are lazy,
and should report none otherwise.  Or am I missing something here?

> I think some more testing, checkpatch running etc and I should be good
> to send v3 :)

Sounds good!

							Thanx, Paul

> Thanks!
> 
>  - Joel
> 
> 
> > 
> >>>>  		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> >>>>  		return false; // Caller must enqueue the callback.
> >>>>  	}
> >>>>  
> >>>>  	// If ->nocb_bypass has been used too long or is too full,
> >>>>  	// flush ->nocb_bypass to ->cblist.
> >>>> -	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
> >>>> -	    ncbs >= qhimark) {
> >>>> +	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) || ncbs >= qhimark) {
> >>>>  		rcu_nocb_lock(rdp);
> >>>> -		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
> >>>> +		if (!rcu_nocb_flush_bypass(rdp, rhp, j, true)) {
> >>>
> >>> But shouldn't this "true" be "lazy"?  I don't see how we are guaranteed
> >>> that the callback is in fact lazy at this point in the code.  Also,
> >>> there is not yet a guarantee that the caller will do the enqueuing.
> >>> So what am I missing?
> >>
> >> Sorry I screwed this part up. I think I meant 'false' here, if the list grew
> >> too big- then I think I would prefer if the new lazy CB instead is treated as
> >> non-lazy. But if that's too confusing, I will just pass 'lazy' instead. What
> >> do you think?
> > 
> > Good point, if we are choosing to override the laziness requested by the
> > caller, then it should say "true".  It would be good to have a comment
> > saying that is what we are doing, correct?
> > 
> >> Will reply more to the rest of the comments soon, thanks!
> > 
> > Sounds good!  (Hey, wouldn't want you to be bored!)
> > 
> > 							Thanx, Paul
