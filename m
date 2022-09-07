Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F3C5B00B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiIGJk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiIGJkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5483A84EDD;
        Wed,  7 Sep 2022 02:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA4096183D;
        Wed,  7 Sep 2022 09:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDB9C433D6;
        Wed,  7 Sep 2022 09:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662543617;
        bh=Hr5+aZcVWl6y16hq00Ch1HiG5Xj0qqyjZBPbI6n2aJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEKEXeLi2DMICa6qMVttCThbm7230aMFc3x/0NvPQ9f4JLVjt3u0NrDBKr7wkeeJB
         GQ9H1VCa09WxK7P39c93t8EmE4/FHmE4QSnxoXgMssmJ97/nYZWFfh3zAAZj7SBazF
         noAtbrHz+NxC0/RbIZuZSePwfYppPuE5bRK8287lZwphYk/ZE+msBg5Ar+nNxnYQkf
         yXl3VCubvkZnxAM0fEmkSDWrgKpMP5m/ueGFkkmcEJjz1L/JBYZavkNdJkO9UP0/pR
         ddV1gnNBEgRxwUnAb6AcTF6TCryzFIqEGQt/ymhauhdwlwvldb5K8+YWXoQf3lFWZ5
         4ZcjZPS20O3wA==
Date:   Wed, 7 Sep 2022 11:40:14 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <20220907094014.GA193994@lothringen>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen>
 <Yxfggt1/cLBhUi/y@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxfggt1/cLBhUi/y@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 12:06:26AM +0000, Joel Fernandes wrote:
> > > @@ -326,13 +372,20 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > >   * Note that this function always returns true if rhp is NULL.
> > >   */
> > >  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > > -				  unsigned long j)
> > > +				  unsigned long j, unsigned long flush_flags)
> > >  {
> > > +	bool ret;
> > > +
> > >  	if (!rcu_rdp_is_offloaded(rdp))
> > >  		return true;
> > >  	rcu_lockdep_assert_cblist_protected(rdp);
> > >  	rcu_nocb_bypass_lock(rdp);
> > > -	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
> > > +	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
> > > +
> > > +	if (flush_flags & FLUSH_BP_WAKE)
> > > +		wake_nocb_gp(rdp, true);
> > 
> > Why the true above?
> > 
> > Also should we check if the wake up is really necessary (otherwise it means we
> > force a wake up for all rdp's from rcu_barrier())?
> > 
> >        was_alldone = rcu_segcblist_pend_cbs(&rdp->cblist);
> >        ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
> >        if (was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist))
> >        	  wake_nocb_gp(rdp, false);
> 
> You mean something like the following right? Though I'm thinking if its
> better to call wake_nocb_gp() from tree.c in entrain() and let that handle
> the wake. That way, we can get rid of the extra FLUSH_BP flags as well and
> let the flush callers deal with the wakeups..

Ah yes that could make sense if only one caller cares.

> 
> Anyway, for testing this should be good...
> 
> ---8<-----------------------
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index bd8f39ee2cd0..e3344c262672 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -382,15 +382,19 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  				  unsigned long j, unsigned long flush_flags)
>  {
>  	bool ret;
> +	bool was_alldone;
>  
>  	if (!rcu_rdp_is_offloaded(rdp))
>  		return true;
>  	rcu_lockdep_assert_cblist_protected(rdp);
>  	rcu_nocb_bypass_lock(rdp);
> +	if (flush_flags & FLUSH_BP_WAKE)
> +		was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> +

You can check that outside bypass lock (but you still need nocb_lock).

>  	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
>  
> -	if (flush_flags & FLUSH_BP_WAKE)
> -		wake_nocb_gp(rdp, true);
> +	if (flush_flags & FLUSH_BP_WAKE && was_alldone)
> +		wake_nocb_gp(rdp, false);

That doesn't check if the bypass list was empty.

Thanks.
