Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3775256CFD6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiGJPsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGJPsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:48:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6614EE003;
        Sun, 10 Jul 2022 08:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29C4AB80AB5;
        Sun, 10 Jul 2022 15:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C58C3411E;
        Sun, 10 Jul 2022 15:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657468079;
        bh=abz1JSjbtNOHbSndNZUJjKFTIeCcIyNe++Q4Es2GxHI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VYY3P/6SPW3pOUMuW1Hlsj9meo5RDepXSaU7eA5/Y9ztSKp3QANzggeFve4W9SIbo
         UdPkQq767tvnOU5i/zWITthh24zm/hFdWCwzCBO7U6FnRj3rzILYj/TTnXUeC9CHOv
         kdooaS3k+Ikug4dcKaDNVTmmGVKSLv0eNPYMmTtFFC2Cyy54AXSElgIUjtk2pt/96a
         S2CgM6UQHxlrwOQyznjD/I45HpExT/Z3z4gEaPCv0em3mNHtzWkUsCoi1sj4eoRjjQ
         LtDab7qrDYH+iPs5wzMVMWOEgSCkOzR60p3qrUxQvdUb2/1lEUA6wDPCC0y1jQuN6Z
         ERxsNUz2nGGqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 792CB5C0399; Sun, 10 Jul 2022 08:47:59 -0700 (PDT)
Date:   Sun, 10 Jul 2022 08:47:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 0/8] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <20220710154759.GG1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220626031206.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <Ysev2jbxFGNkLvjG@google.com>
 <20220708224514.GB1790663@paulmck-ThinkPad-P17-Gen-1>
 <YsoteYyJoOSzMGsr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsoteYyJoOSzMGsr@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 01:38:01AM +0000, Joel Fernandes wrote:
> On Fri, Jul 08, 2022 at 03:45:14PM -0700, Paul E. McKenney wrote:
> > On Fri, Jul 08, 2022 at 04:17:30AM +0000, Joel Fernandes wrote:
> > > On Sat, Jun 25, 2022 at 08:12:06PM -0700, Paul E. McKenney wrote:
> > > > On Wed, Jun 22, 2022 at 10:50:53PM +0000, Joel Fernandes (Google) wrote:
> > > > > 
> > > > > Hello!
> > > > > Please find the next improved version of call_rcu_lazy() attached.  The main
> > > > > difference between the previous version is that it is now using bypass lists,
> > > > > and thus handling rcu_barrier() and hotplug situations, with some small changes
> > > > > to those parts.
> > > > > 
> > > > > I also don't see the TREE07 RCU stall from v1 anymore.
> > > > > 
> > > > > In the v1, we some numbers below (testing on v2 is in progress). Rushikesh,
> > > > > feel free to pull these patches into your tree. Just to note, you will also
> > > > > need to pull the call_rcu_lazy() user patches from v1. I have dropped in this
> > > > > series, just to make the series focus on the feature code first.
> > > > > 
> > > > > Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
> > > > > The observation is that due to a 'trickle down' effect of RCU callbacks, the
> > > > > system is very lightly loaded but constantly running few RCU callbacks very
> > > > > often. This confuses the power management hardware that the system is active,
> > > > > when it is in fact idle.
> > > > > 
> > > > > For example, when ChromeOS screen is off and user is not doing anything on the
> > > > > system, we can see big power savings.
> > > > > Before:
> > > > > Pk%pc10 = 72.13
> > > > > PkgWatt = 0.58
> > > > > CorWatt = 0.04
> > > > > 
> > > > > After:
> > > > > Pk%pc10 = 81.28
> > > > > PkgWatt = 0.41
> > > > > CorWatt = 0.03
> > > > 
> > > > So not quite 30% savings in power at the package level?  Not bad at all!
> > > 
> > > Yes this is the package residency amount, not the amount of power. This % is
> > > not power.
> > 
> > So what exactly is PkgWatt, then?  If you can say.  That is where I was
> > getting the 30% from.
> 
> Its the total package power (SoC power) - so like not just the CPU but also
> the interconnect, other controllers and other blocks in there.
> 
> This output is from the turbostat program and the number is mentioned in the
> manpage:
> "PkgWatt Watts consumed by the whole package."
> https://manpages.debian.org/testing/linux-cpupower/turbostat.8.en.html

Are we back to about a 30% savings in power at the package level?  ;-)

Either way, please quantify your "big power savings" by calculating and
stating a percentage decrease.

> > > > > Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> > > > > can see that the display pipeline is constantly doing RCU callback queuing due
> > > > > to open/close of file descriptors associated with graphics buffers. This is
> > > > > attributed to the file_free_rcu() path which this patch series also touches.
> > > > > 
> > > > > This patch series adds a simple but effective, and lockless implementation of
> > > > > RCU callback batching. On memory pressure, timeout or queue growing too big, we
> > > > > initiate a flush of one or more per-CPU lists.
> > > > 
> > > > It is no longer lockless, correct?  Or am I missing something subtle?
> > > > 
> > > > Full disclosure: I don't see a whole lot of benefit to its being lockless.
> > > > But truth in advertising!  ;-)
> > > 
> > > Yes, you are right. Maybe a better way I could put it is it is "lock
> > > contention less" :D
> > 
> > Yes, "reduced lock contention" would be a good phrase.  As long as you
> > carefully indicate exactly what scenario with greater lock contention
> > you are comparing to.
> > 
> > But aren't you acquiring the bypass lock at about the same rate as it
> > would be aquired without laziness?  What am I missing here?
> 
> You are right, why not I just drop the locking phrases from the summary.
> Anyway the main win from this work is not related to locking.

Sounds good!

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> > 
> > 							Thanx, Paul
> > 
> > > > > Similar results can be achieved by increasing jiffies_till_first_fqs, however
> > > > > that also has the effect of slowing down RCU. Especially I saw huge slow down
> > > > > of function graph tracer when increasing that.
> > > > > 
> > > > > One drawback of this series is, if another frequent RCU callback creeps up in
> > > > > the future, that's not lazy, then that will again hurt the power. However, I
> > > > > believe identifying and fixing those is a more reasonable approach than slowing
> > > > > RCU down for the whole system.
> > > > 
> > > > Very good!  I have you down as the official call_rcu_lazy() whack-a-mole
> > > > developer.  ;-)
> > > 
> > > :-D
> > > 
> > > thanks,
> > > 
> > >  - Joel
> > > 
