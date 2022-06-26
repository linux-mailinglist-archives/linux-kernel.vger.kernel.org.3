Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111E655AE6C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 05:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiFZDMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 23:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiFZDMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 23:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D25140B1;
        Sat, 25 Jun 2022 20:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13B0C6100D;
        Sun, 26 Jun 2022 03:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED4FC341C6;
        Sun, 26 Jun 2022 03:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656213127;
        bh=AXeVf6h4Nfj3KQurMLHUyo1k4lOvkrxgNJByd+BctN8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZtsvnImYwEdjJiQM1l8to5/itB6yIc3gXnJs8k7zU2O53mqc/AsULSi5zmVdaDTFT
         Y+g5JXhviFJARuXdSIOmHlwMWZ39MdkFjQsYvyNGpxxVfSCLP1rT7asvMZKmdVbT2f
         NOHZTrqvdpBYKopoosM7oClmilddej4yspImPYwScim3DekBwaz93za8WHbgMbXxSn
         1hzTZBYig/4OF6w2Y9z84pO2pjKyl++VRWQsF1RxiakHRZPb2bJEXKWQa9J0ZrraQ7
         ac7T5XpATFAacGuXJpVsHjig5xaWOCilulkY4ySxS4jpNv0xueUXfSG4XnUonjmotN
         GTgCHTmn3hwAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E111E5C0260; Sat, 25 Jun 2022 20:12:06 -0700 (PDT)
Date:   Sat, 25 Jun 2022 20:12:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 0/8] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <20220626031206.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622225102.2112026-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:50:53PM +0000, Joel Fernandes (Google) wrote:
> 
> Hello!
> Please find the next improved version of call_rcu_lazy() attached.  The main
> difference between the previous version is that it is now using bypass lists,
> and thus handling rcu_barrier() and hotplug situations, with some small changes
> to those parts.
> 
> I also don't see the TREE07 RCU stall from v1 anymore.
> 
> In the v1, we some numbers below (testing on v2 is in progress). Rushikesh,
> feel free to pull these patches into your tree. Just to note, you will also
> need to pull the call_rcu_lazy() user patches from v1. I have dropped in this
> series, just to make the series focus on the feature code first.
> 
> Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
> The observation is that due to a 'trickle down' effect of RCU callbacks, the
> system is very lightly loaded but constantly running few RCU callbacks very
> often. This confuses the power management hardware that the system is active,
> when it is in fact idle.
> 
> For example, when ChromeOS screen is off and user is not doing anything on the
> system, we can see big power savings.
> Before:
> Pk%pc10 = 72.13
> PkgWatt = 0.58
> CorWatt = 0.04
> 
> After:
> Pk%pc10 = 81.28
> PkgWatt = 0.41
> CorWatt = 0.03

So not quite 30% savings in power at the package level?  Not bad at all!

> Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> can see that the display pipeline is constantly doing RCU callback queuing due
> to open/close of file descriptors associated with graphics buffers. This is
> attributed to the file_free_rcu() path which this patch series also touches.
> 
> This patch series adds a simple but effective, and lockless implementation of
> RCU callback batching. On memory pressure, timeout or queue growing too big, we
> initiate a flush of one or more per-CPU lists.

It is no longer lockless, correct?  Or am I missing something subtle?

Full disclosure: I don't see a whole lot of benefit to its being lockless.
But truth in advertising!  ;-)

> Similar results can be achieved by increasing jiffies_till_first_fqs, however
> that also has the effect of slowing down RCU. Especially I saw huge slow down
> of function graph tracer when increasing that.
> 
> One drawback of this series is, if another frequent RCU callback creeps up in
> the future, that's not lazy, then that will again hurt the power. However, I
> believe identifying and fixing those is a more reasonable approach than slowing
> RCU down for the whole system.

Very good!  I have you down as the official call_rcu_lazy() whack-a-mole
developer.  ;-)

							Thanx, Paul

> Disclaimer: I have intentionally not CC'd other subsystem maintainers (like
> net, fs) to keep noise low and will CC them in the future after 1 or 2 rounds
> of review and agreements.
> 
> Joel Fernandes (Google) (7):
>   rcu: Introduce call_rcu_lazy() API implementation
>   fs: Move call_rcu() to call_rcu_lazy() in some paths
>   rcu/nocb: Add option to force all call_rcu() to lazy
>   rcu/nocb: Wake up gp thread when flushing
>   rcuscale: Add test for using call_rcu_lazy() to emulate kfree_rcu()
>   rcu/nocb: Rewrite deferred wake up logic to be more clean
>   rcu/kfree: Fix kfree_rcu_shrink_count() return value
> 
> Vineeth Pillai (1):
>   rcu: shrinker for lazy rcu
> 
>  fs/dcache.c                   |   4 +-
>  fs/eventpoll.c                |   2 +-
>  fs/file_table.c               |   2 +-
>  fs/inode.c                    |   2 +-
>  include/linux/rcu_segcblist.h |   1 +
>  include/linux/rcupdate.h      |   6 +
>  kernel/rcu/Kconfig            |   8 ++
>  kernel/rcu/rcu.h              |   8 ++
>  kernel/rcu/rcu_segcblist.c    |  19 +++
>  kernel/rcu/rcu_segcblist.h    |  24 ++++
>  kernel/rcu/rcuscale.c         |  64 +++++++++-
>  kernel/rcu/tree.c             |  35 +++++-
>  kernel/rcu/tree.h             |  10 +-
>  kernel/rcu/tree_nocb.h        | 217 +++++++++++++++++++++++++++-------
>  14 files changed, 345 insertions(+), 57 deletions(-)
> 
> -- 
> 2.37.0.rc0.104.g0611611a94-goog
> 
