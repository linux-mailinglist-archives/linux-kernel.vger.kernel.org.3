Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A6D5B08B0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiIGPiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIGPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FA579601;
        Wed,  7 Sep 2022 08:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB0DF61991;
        Wed,  7 Sep 2022 15:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF38CC433D7;
        Wed,  7 Sep 2022 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662565084;
        bh=CJ/9X9yaWCYIbwN84bcl2w5M5Ih6vNQPXelDZsGvvts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+Gu8iqqJ5tSjpY98143fFYZyUNVbhKl0X2oW3SCLc0MjPqJBX0wsUHdEk2wOgsn7
         qAdPxp9vjw8vAqN/r8Qm+ymBwM67WBDrjp0WiFlyyqDYuNHLdmSJn6G0F46XZz828R
         My/tmM5MPp7zVn032lO7Gmal0TygM/ggk03JNw4P9W/80ZhcI7LCwjxyqJ5AdVkkwc
         DpepZpmdqIaLhshu3kZeAqLWCRr2mVd+aFOUkhy2xIQ67KdLG2/R76Bbszy41Mgdio
         IWn83BarPBfpC5hkFKs0+q+amYX8X1YIfp7ohSUGrJAyXs83FbrzFoIHLvjiFChWdh
         COEBUoJluKSVQ==
Date:   Wed, 7 Sep 2022 17:38:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <20220907153801.GB198228@lothringen>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen>
 <Yxfggt1/cLBhUi/y@google.com>
 <20220907094014.GA193994@lothringen>
 <07215af0-4164-efb6-4ba8-63d33fe8664e@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07215af0-4164-efb6-4ba8-63d33fe8664e@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:44:01AM -0400, Joel Fernandes wrote:
> Hi Frederic,
> 
> On 9/7/2022 5:40 AM, Frederic Weisbecker wrote:
> >>
> >> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> >> index bd8f39ee2cd0..e3344c262672 100644
> >> --- a/kernel/rcu/tree_nocb.h
> >> +++ b/kernel/rcu/tree_nocb.h
> >> @@ -382,15 +382,19 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >>  				  unsigned long j, unsigned long flush_flags)
> >>  {
> >>  	bool ret;
> >> +	bool was_alldone;
> >>  
> >>  	if (!rcu_rdp_is_offloaded(rdp))
> >>  		return true;
> >>  	rcu_lockdep_assert_cblist_protected(rdp);
> >>  	rcu_nocb_bypass_lock(rdp);
> >> +	if (flush_flags & FLUSH_BP_WAKE)
> >> +		was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> >> +
> > You can check that outside bypass lock (but you still need nocb_lock).
> 
> Right, ok. I can make it outside the bypass lock, and the nocb_lock is implied
> by rcu_lockdep_assert_cblist_protected().
> 
> > 
> >>  	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
> >>  
> >> -	if (flush_flags & FLUSH_BP_WAKE)
> >> -		wake_nocb_gp(rdp, true);
> >> +	if (flush_flags & FLUSH_BP_WAKE && was_alldone)
> >> +		wake_nocb_gp(rdp, false);
> > That doesn't check if the bypass list was empty.
> 
> thanks, will add your suggested optimization, however I have a general question:
> 
> For the case where the bypass list is empty, where does rcu_barrier() do a wake
> up of the nocb GP thread after entrain()?
> 
> I don't see a call to __call_rcu_nocb_wake() like rcutree_migrate_callbacks()
> does. Is the wake up done in some other path?

Actually I can't find it. You're right it may be missing. It's not even just
about the bypass list but also the entrain'ed callback. Would you be willing to
cook a fix?

Thanks!

> 
> thanks,
> 
>  - Joel
