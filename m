Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E0456C3D7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbiGHWp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240223AbiGHWph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:45:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A3B3F301;
        Fri,  8 Jul 2022 15:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D949621B4;
        Fri,  8 Jul 2022 22:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3987C341C0;
        Fri,  8 Jul 2022 22:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657320314;
        bh=h8ppUN6nD9FPD3uXhWbPgG+hzPAApfWBYDuuqxzZCbY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uEs2LCE7+ea24T5vt5WsR6kc+M4InIcY8i+6LOJgKdF1wtv87TV8yhOw2OEAXjNW5
         YDo30dajgnwVMXH4U97IRPt1+Yp7CHeDQWqHRjqb7Sb98M3HTpA8I1IcniArTzMsGa
         2IK650eY86QvjdhSL74KtkgNNVojfIGEu50V86PHEBjd/Qo5cUwQG9QmS4G3Yhm/FB
         6Vo14hC004kxXzl1M794cUbQekPgZZPriqDLwoiOyYHiQrvoBk1T/S7ydQVD4b0P7S
         0mzXhYpNl0xgOb4k+GHzm1mCJJEhdqpY3zhHh8r1+uiPiQ2cguJ9sNz0KngQdQHH9g
         YDSXGFDys3P+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 578C95C0835; Fri,  8 Jul 2022 15:45:14 -0700 (PDT)
Date:   Fri, 8 Jul 2022 15:45:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 0/8] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <20220708224514.GB1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220626031206.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <Ysev2jbxFGNkLvjG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysev2jbxFGNkLvjG@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 04:17:30AM +0000, Joel Fernandes wrote:
> On Sat, Jun 25, 2022 at 08:12:06PM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 22, 2022 at 10:50:53PM +0000, Joel Fernandes (Google) wrote:
> > > 
> > > Hello!
> > > Please find the next improved version of call_rcu_lazy() attached.  The main
> > > difference between the previous version is that it is now using bypass lists,
> > > and thus handling rcu_barrier() and hotplug situations, with some small changes
> > > to those parts.
> > > 
> > > I also don't see the TREE07 RCU stall from v1 anymore.
> > > 
> > > In the v1, we some numbers below (testing on v2 is in progress). Rushikesh,
> > > feel free to pull these patches into your tree. Just to note, you will also
> > > need to pull the call_rcu_lazy() user patches from v1. I have dropped in this
> > > series, just to make the series focus on the feature code first.
> > > 
> > > Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
> > > The observation is that due to a 'trickle down' effect of RCU callbacks, the
> > > system is very lightly loaded but constantly running few RCU callbacks very
> > > often. This confuses the power management hardware that the system is active,
> > > when it is in fact idle.
> > > 
> > > For example, when ChromeOS screen is off and user is not doing anything on the
> > > system, we can see big power savings.
> > > Before:
> > > Pk%pc10 = 72.13
> > > PkgWatt = 0.58
> > > CorWatt = 0.04
> > > 
> > > After:
> > > Pk%pc10 = 81.28
> > > PkgWatt = 0.41
> > > CorWatt = 0.03
> > 
> > So not quite 30% savings in power at the package level?  Not bad at all!
> 
> Yes this is the package residency amount, not the amount of power. This % is
> not power.

So what exactly is PkgWatt, then?  If you can say.  That is where I was
getting the 30% from.

> > > Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> > > can see that the display pipeline is constantly doing RCU callback queuing due
> > > to open/close of file descriptors associated with graphics buffers. This is
> > > attributed to the file_free_rcu() path which this patch series also touches.
> > > 
> > > This patch series adds a simple but effective, and lockless implementation of
> > > RCU callback batching. On memory pressure, timeout or queue growing too big, we
> > > initiate a flush of one or more per-CPU lists.
> > 
> > It is no longer lockless, correct?  Or am I missing something subtle?
> > 
> > Full disclosure: I don't see a whole lot of benefit to its being lockless.
> > But truth in advertising!  ;-)
> 
> Yes, you are right. Maybe a better way I could put it is it is "lock
> contention less" :D

Yes, "reduced lock contention" would be a good phrase.  As long as you
carefully indicate exactly what scenario with greater lock contention
you are comparing to.

But aren't you acquiring the bypass lock at about the same rate as it
would be aquired without laziness?  What am I missing here?

							Thanx, Paul

> > > Similar results can be achieved by increasing jiffies_till_first_fqs, however
> > > that also has the effect of slowing down RCU. Especially I saw huge slow down
> > > of function graph tracer when increasing that.
> > > 
> > > One drawback of this series is, if another frequent RCU callback creeps up in
> > > the future, that's not lazy, then that will again hurt the power. However, I
> > > believe identifying and fixing those is a more reasonable approach than slowing
> > > RCU down for the whole system.
> > 
> > Very good!  I have you down as the official call_rcu_lazy() whack-a-mole
> > developer.  ;-)
> 
> :-D
> 
> thanks,
> 
>  - Joel
> 
