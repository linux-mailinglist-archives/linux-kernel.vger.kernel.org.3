Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC31E5AE4BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbiIFJtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbiIFJs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:48:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC43077578;
        Tue,  6 Sep 2022 02:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8767D61447;
        Tue,  6 Sep 2022 09:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658F4C433C1;
        Tue,  6 Sep 2022 09:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662457735;
        bh=smvlnDa2aUP9CQxZLZ4OAcvHkFcZN1wTPEeebRVS+70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t4OoI6h7n6xQNy/mkYb2L/acJbi0amTjMTX7xvzvKCGFTF70rSyIX5JWXWrek5UNf
         ra4KDvsljow2BAdsV9NtQI2qWGyg7HXBaLiYqSy0IYtnZqGay91VjSmhsRN7j3Ptr7
         0WBRc3CD78xXLpHlClWlzOA1o6U2L64A6/N5V2RR80eYEXpu8i0cmUnd4ZY2Ud2RWV
         WYuyABDeVhgBsgOTzduqJwg/sesxDDBscBY3K9li9ek99wC7/CsGE1KbgVwr6bi4jN
         RGbrp8V1bBBCkFsSwvOEcq8+NC1cTSb5WjFskYol7wD4C/2lAwA8SC8qMityvTjfIz
         IY159b02FabEA==
Date:   Tue, 6 Sep 2022 11:48:52 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 04/18] rcu: Fix late wakeup when flush of bypass
 cblist happens
Message-ID: <20220906094852.GA174244@lothringen>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-5-joel@joelfernandes.org>
 <Yxa5WVwwcDmCL9Dw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxa5WVwwcDmCL9Dw@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:07:05AM +0000, Joel Fernandes wrote:
> On Thu, Sep 01, 2022 at 10:17:06PM +0000, Joel Fernandes (Google) wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH v6] rcu: Fix late wakeup when flush of bypass cblist happens
> 
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
> [ Frederic Weisbec: changes to not do wake up GP thread unless needed ].
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_nocb.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 0a5f0ef41484..4dc86274b3e8 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -433,8 +433,9 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
>  	    ncbs >= qhimark) {
>  		rcu_nocb_lock(rdp);
> +		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> +
>  		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
> -			*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>  			if (*was_alldone)
>  				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>  						    TPS("FirstQ"));
> @@ -447,7 +448,13 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  			rcu_advance_cbs_nowake(rdp->mynode, rdp);
>  			rdp->nocb_gp_adv_time = j;
>  		}
> -		rcu_nocb_unlock_irqrestore(rdp, flags);
> +
> +		// The flush succeeded and we moved CBs into the ->cblist.
> +		// However, the bypass timer might still be running. Wakeup the

That part of the comment mentioning the bypass timer looks strange...


> +		// GP thread by calling a helper with was_all_done set so that
> +		// wake up happens (needed if main CB list was empty before).

How about:

                // The flush succeeded and we moved CBs into the regular list.
		// Don't wait for the wake up timer as it may be too far ahead.
		// Wake up now GP thread instead if the cblist was empty

Thanks.

Other than that the patch looks good, thanks!

> +		__call_rcu_nocb_wake(rdp, *was_alldone, flags);
> +
>  		return true; // Callback already enqueued.
>  	}
>  
> -- 
> 2.37.2.789.g6183377224-goog
> 
