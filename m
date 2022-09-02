Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219245AADC3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiIBLfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbiIBLfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:35:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298CE13D23;
        Fri,  2 Sep 2022 04:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF680B82A62;
        Fri,  2 Sep 2022 11:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F717C433C1;
        Fri,  2 Sep 2022 11:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662118503;
        bh=2/OOTjoOIduO1UI7uBOAGDsBOU3c9ZeozsMCg1Vve0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kodGV5uAXxcpEJWoO7bQx9nEBLin1ASmVRNrHL6Uh68eMrFL50tJaLWcMUgX1UTmI
         GYO3qKsxxxVbTzfRDsxI5qgEdQgZu2k4WNi/d9xFV7Yp72eUOGOW/81pHO38nWDo1U
         KV8byabl3rBB6CUxFfsf3PjOUusLHdr5k78vtyUrc6Uw4ut3Y+MqlF4pNI6WC1wlIc
         w5zSHU1GZgIMd54YB5JWJ4UVB4yVo6cElx9xPZXFBrc2rU2MdAQLyKX0RD/s/SazzU
         CpNtTX9yRDbtCssvlvEvDvJFZ+4Wp9UrjB0rnT5OZZoBsP0hrI+ezUn41BA0nnmncq
         etnc5p+hyL3KQ==
Date:   Fri, 2 Sep 2022 13:35:00 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 04/18] rcu: Fix late wakeup when flush of bypass
 cblist happens
Message-ID: <20220902113500.GA113405@lothringen>
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
> +

Ok so there are two different changes here:

1) wake up nocb_gp as we just flushed the bypass list. Indeed if the regular
   callback list was empty before flushing, we rather want to immediately wake
   up nocb_gp instead of waiting for the bypass timer to process them.

2) wake up nocb_gp unconditionally (ie: even if the regular queue was not empty
   before bypass flushing) so that nocb_gp_wait() is forced through another loop
   starting with cancelling the bypass timer (I suggest you put such explanation
   in the comment btw because that process may not be obvious for mortals).

The change 1) looks like a good idea to me.

The change 2) has unclear motivation. It forces nocb_gp_wait() through another
costly loop even though the timer might have been cancelled into some near
future, eventually avoiding that extra costly loop. Also it abuses the
was_alldone stuff and we may get rcu_nocb_wake with incoherent meanings
(WakeEmpty/WakeEmptyIsDeferred) when it's actually not empty.

So you may need to clarify the purpose. And I would suggest to make two patches
here.

Thanks!


   

   

>  		return true; // Callback already enqueued.
>  	}
>  
> -- 
> 2.37.2.789.g6183377224-goog
> 
