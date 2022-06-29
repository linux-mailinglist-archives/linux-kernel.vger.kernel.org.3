Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DF255FF13
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiF2Lxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiF2Lxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:53:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E99637ABC;
        Wed, 29 Jun 2022 04:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 197B461B2F;
        Wed, 29 Jun 2022 11:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C3CC34114;
        Wed, 29 Jun 2022 11:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656503632;
        bh=XGEvwoztRJLvPhLVPeZ5ptFzPtTgQZgUKEEXGctgUgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2Dwmg85FXWGa74zSj1F1asR7BgnUQ82FPwOnlgqxTHDhWkRzhqiut5fcOWK7DlXC
         sWffcUn4AcmevmB7HyJkslYg57uXRTtee95+C9Af75Fo0e+tyZtzPULCe0/KmRnxW/
         Fjo3zfkYATGwGvVe9vNba5jufWAtvaunb2Gz+2dNuLXOSwN0bIpDd0paatZoOzLr2E
         b3sbKQd2P4JdEmqO3/eNiMbHuBCM9yE9rfT4Y84uyfZ2jXRF/4o+e6SiKyYlySwJYE
         Q2r4iQ/GyV0Aw4WOWp93+IBH8BOr8S11u5TLzlCG6PRlGJZtuFUi7tTiWKODpTEXwa
         jub1wDiW2gU6w==
Date:   Wed, 29 Jun 2022 13:53:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <20220629115349.GA2119930@lothringen>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622225102.2112026-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:50:55PM +0000, Joel Fernandes (Google) wrote:
> @@ -414,30 +427,37 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	}
>  	WRITE_ONCE(rdp->nocb_nobypass_count, c);
>  
> -	// If there hasn't yet been all that many ->cblist enqueues
> -	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
> -	// ->nocb_bypass first.
> -	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
> +	// If caller passed a non-lazy CB and there hasn't yet been all that
> +	// many ->cblist enqueues this jiffy, tell the caller to enqueue it
> +	// onto ->cblist.  But flush ->nocb_bypass first. Also do so, if total
> +	// number of CBs (lazy + non-lazy) grows too much.
> +	//
> +	// Note that if the bypass list has lazy CBs, and the main list is
> +	// empty, and rhp happens to be non-lazy, then we end up flushing all
> +	// the lazy CBs to the main list as well. That's the right thing to do,
> +	// since we are kick-starting RCU GP processing anyway for the non-lazy
> +	// one, we can just reuse that GP for the already queued-up lazy ones.
> +	if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
> +	    (lazy && n_lazy_cbs >= qhimark)) {
>  		rcu_nocb_lock(rdp);
>  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>  		if (*was_alldone)
>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> -					    TPS("FirstQ"));
> -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> +					    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
> +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));

That's outside the scope of this patchset but this makes me realize we
unconditionally try to flush the bypass from call_rcu() fastpath, and
therefore we unconditionally lock the bypass lock from call_rcu() fastpath.

It shouldn't be contended at this stage since we are holding the nocb_lock
already, and only the local CPU can hold the nocb_bypass_lock without holding
the nocb_lock. But still...

It looks safe to locklessly early check if (rcu_cblist_n_cbs(&rdp->nocb_bypass))
before doing anything. Only the local CPU can enqueue to the bypass list.

Adding that to my TODO list...

