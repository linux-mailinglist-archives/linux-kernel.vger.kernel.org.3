Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA385606B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiF2Qwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiF2Qw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:52:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DB4140D3;
        Wed, 29 Jun 2022 09:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EEDBB825DB;
        Wed, 29 Jun 2022 16:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E460CC341C8;
        Wed, 29 Jun 2022 16:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656521546;
        bh=XsA4u8GaKpwaBT1HA+WHx3qEMftdGr6f1nnBdtIFfoQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=M4MrnoyVYCt53k4YI5Yr5KTZTp8lRTsZRdtfGp27dZHd0zj/5k27unZR8X5Z+2yMQ
         PZpkOdD8UWlGptlDm3mVweklZx0RuFzbv6xOBXZsOceI3Ex5TWB9/0GyfGfKDsSXZl
         IPpaL21o/nf+DeAXV88faAon9Kk2OLKtrOEqxaG317ptT9vLBq2/9vwkEcjRC8vafC
         l3DND+0PYlP87FIc7kQJfQp2IWdfNNCqbG1LKiV0y67mN7YdO7/4tdAqUyaF+OAQm5
         3hUMWxAcS+zrFz7fa8UnLuHpweCYYuJzkmuveYV8xceoFQS2XZoX37vs5h16DplFvn
         YQWl62KdRmYMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 883745C0E5F; Wed, 29 Jun 2022 09:52:25 -0700 (PDT)
Date:   Wed, 29 Jun 2022 09:52:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 8/8] rcu/kfree: Fix kfree_rcu_shrink_count() return
 value
Message-ID: <20220629165225.GH1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-10-joel@joelfernandes.org>
 <Yrn9a5pOvhvL/eZj@pc638.lan>
 <20220627205907.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YroelcGVNhQj91ab@google.com>
 <20220627214359.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YrsyrmDbfnkpfDEP@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrsyrmDbfnkpfDEP@google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:56:14PM +0000, Joel Fernandes wrote:
> On Mon, Jun 27, 2022 at 02:43:59PM -0700, Paul E. McKenney wrote:
> > On Mon, Jun 27, 2022 at 09:18:13PM +0000, Joel Fernandes wrote:
> > > On Mon, Jun 27, 2022 at 01:59:07PM -0700, Paul E. McKenney wrote:
> > > > On Mon, Jun 27, 2022 at 08:56:43PM +0200, Uladzislau Rezki wrote:
> > > > > > As per the comments in include/linux/shrinker.h, .count_objects callback
> > > > > > should return the number of freeable items, but if there are no objects
> > > > > > to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> > > > > > should be when we are unable to determine the number of objects, or the
> > > > > > cache should be skipped for another reason.
> > > > > > 
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > ---
> > > > > >  kernel/rcu/tree.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index 711679d10cbb..935788e8d2d7 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > > > > >  		atomic_set(&krcp->backoff_page_cache_fill, 1);
> > > > > >  	}
> > > > > >  
> > > > > > -	return count;
> > > > > > +	return count == 0 ? SHRINK_EMPTY : count;
> > > > > >  }
> > > > > >  
> > > > > >  static unsigned long
> > > > > > -- 
> > > > > > 2.37.0.rc0.104.g0611611a94-goog
> > > > > > 
> > > > > Looks good to me!
> > > > > 
> > > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > 
> > > > Now that you mention it, this does look independent of the rest of
> > > > the series.  I have pulled it in with Uladzislau's Reviewed-by.
> > > 
> > > Thanks Paul and Vlad!
> > > 
> > > Paul, apologies for being quiet. I have been working on the series and the
> > > review comments carefully. I appreciate your help with this work.
> > 
> > Not a problem.  After all, this stuff is changing some of the trickier
> > parts of RCU.  We must therefore assume that some significant time and
> > effort will be required to get it right.
> 
> To your point about trickier parts of RCU, the v2 series though I tested it
> before submitting is now giving me strange results with rcuscale. Sometimes
> laziness does not seem to be in effect (as pointed out by rcuscale), other
> times I am seeing stalls.
> 
> So I have to carefully look through all of this again. I am not sure why I
> was not seeing these issues with the exact same code before (frustrated).

This is one of the mechanisms behind that famous Brian Kerghnihan saying
about code being three times harder to debug than to write.  You see,
when you are writing the code, you only need to deal with that part of
the state space that you are aware of.  When you are debugging code,
the rest of the state space makes its presence known.

That is, if you are lucky.

If you are not so lucky, the rest of the state space waits to make
its presence known until your code is running some critical workload
in production.  ;-)

							Thanx, Paul
