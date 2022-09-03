Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93195ABF80
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 17:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiICPWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 11:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiICPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 11:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86E057579;
        Sat,  3 Sep 2022 08:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63EDF61558;
        Sat,  3 Sep 2022 15:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA90C433C1;
        Sat,  3 Sep 2022 15:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662218562;
        bh=4fSdg3x+dbs0HcJOpxRQdY0iKbLq+SeYxIdhDJU+piY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Qpoj6gqWRBnngKRJQKDmGO4MlTMRsG0VPjn5/U0AWgY7Wbu7oB58zXKivfdLNulj/
         bbf28WrMGgt7UAU3sRPGexCq+j12kiHFC2FNHN4rb89SRAJGgtsfslPVEmecrAfPam
         OxMZlcOv1clsU12G3gTBWqUXe9BYJeK/ooPkLRt3TgoMptF6kGoeNRmdlW788561I0
         cgu1Qa5lNveb7lnpCbJwx/c06iXLBAcc4W4/HfMx39bKDz9XFQb7XyEyj4GVTwG81d
         nc71FdezLqr4SiczM0tdHaeQ4jdvSEecl0MQXinsDkcG0aVL83mfe/FYQpa4wtlDB4
         wK6Yye1EBJvOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4A5AB5C086C; Sat,  3 Sep 2022 08:22:42 -0700 (PDT)
Date:   Sat, 3 Sep 2022 08:22:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 00/18] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <20220903152242.GA870876@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:17:02PM +0000, Joel Fernandes (Google) wrote:
> Here is v5 of call_rcu_lazy() based on the latest RCU -dev branch. Main changes are:
> - moved length field into rcu_data (Frederic suggestion)
> - added new traces to aid debugging and testing.
> 	- the new trace patch (along with the rcuscale and rcutorture tests)
> 	  gives confidence that the patches work well. Also it is tested on
> 	  real ChromeOS hardware and the boot time is looking good even though
> 	  lazy callbacks are being queued (i.e. the lazy ones do not effect the
> 	  synchronous non-lazy ones that effect boot time)
> - rewrote some parts of the core patch.
> - for rcutop, please apply the diff in the following link to the BCC repo:
>   https://lore.kernel.org/r/Yn+79v4q+1c9lXdc@google.com
>   Then, cd libbpf-tools/ and run make to build the rcutop static binary.
>   (If you need an x86 binary, ping me and I'll email you).
>   In the future, I will attempt to make rcutop built within the kernel repo.
>   This is already done for another tool (see tools/bpf/runqslower) so is doable.
> 
> The 2 mm patches are what Vlastimil pulled into slab-next. I included them in
> this series so that the tracing patch builds.
> 
> Previous series was posted here:
>  https://lore.kernel.org/all/20220713213237.1596225-1-joel@joelfernandes.org/
> 
> Linked below [1] is some power data I collected with Turbostat on an x86
> ChromeOS ADL machine. The numbers are not based on -next, but rather 5.19
> kernel as that's what booted on my ChromeOS machine).
> 
> These are output by Turbostat, by running:
> turbostat -S -s PkgWatt,CorWatt --interval 5
> PkgWatt - summary of package power in Watts 5 second interval.
> CoreWatt - summary of core power in Watts 5 second interval.
> 
> [1] https://lore.kernel.org/r/b4145008-6840-fc69-a6d6-e38bc218009d@joelfernandes.org

Thank you for all your work on this!

I have pulled these in for testing and review.  Some work is required
for them to be ready for mainline.

> Joel Fernandes (Google) (15):

I took these:

> rcu/tree: Use READ_ONCE() for lockless read of rnp->qsmask
> rcu: Fix late wakeup when flush of bypass cblist happens
> rcu: Move trace_rcu_callback() before bypassing
> rcu: Introduce call_rcu_lazy() API implementation

You and Frederic need to come to agreement on "rcu: Fix late wakeup when
flush of bypass cblist happens".

These have some difficulties, so I put them on top of the stack:

> rcu: Add per-CB tracing for queuing, flush and invocation.
	This one breaks 32-bit MIPS.
> rcuscale: Add laziness and kfree tests
	I am concerned that this one has OOM problems.
> rcutorture: Add test code for call_rcu_lazy()
	This one does not need a separate scenario, but instead a separate
	rcutorture.gp_lazy boot parameter.  For a rough template for this
	sort of change, please see the rcutorture changes in this commit:

	76ea364161e7 ("rcu: Add full-sized polling for start_poll()")

	The key point is that every rcutorture.torture_type=rcu test then
	becomes a call_rcu_lazy() test.  (Unless explicitly overridden.)

I took these, though they need go up their respective trees or get acks
from their respective maintainers.

> fs: Move call_rcu() to call_rcu_lazy() in some paths
> cred: Move call_rcu() to call_rcu_lazy()
> security: Move call_rcu() to call_rcu_lazy()
> net/core: Move call_rcu() to call_rcu_lazy()
> kernel: Move various core kernel usages to call_rcu_lazy()
> lib: Move call_rcu() to call_rcu_lazy()
> i915: Move call_rcu() to call_rcu_lazy()
> fork: Move thread_stack_free_rcu() to call_rcu_lazy()
> 
> Vineeth Pillai (1):

I took this:

> rcu: shrinker for lazy rcu
> 
> Vlastimil Babka (2):

As noted earlier, I took these strictly for testing.  I do not expect
to push them into -next, let alone into mainline.

> mm/slub: perform free consistency checks before call_rcu
> mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head

These all are on -rcu not-yet-for-mainline branch lazy.2022.09.03b.

							Thanx, Paul

> drivers/gpu/drm/i915/gem/i915_gem_object.c    |   2 +-
> fs/dcache.c                                   |   4 +-
> fs/eventpoll.c                                |   2 +-
> fs/file_table.c                               |   2 +-
> fs/inode.c                                    |   2 +-
> include/linux/rcupdate.h                      |   6 +
> include/linux/types.h                         |  44 +++
> include/trace/events/rcu.h                    |  69 ++++-
> kernel/cred.c                                 |   2 +-
> kernel/exit.c                                 |   2 +-
> kernel/fork.c                                 |   6 +-
> kernel/pid.c                                  |   2 +-
> kernel/rcu/Kconfig                            |  19 ++
> kernel/rcu/rcu.h                              |  12 +
> kernel/rcu/rcu_segcblist.c                    |  23 +-
> kernel/rcu/rcu_segcblist.h                    |   8 +
> kernel/rcu/rcuscale.c                         |  74 ++++-
> kernel/rcu/rcutorture.c                       |  60 +++-
> kernel/rcu/tree.c                             | 187 ++++++++----
> kernel/rcu/tree.h                             |  13 +-
> kernel/rcu/tree_nocb.h                        | 282 +++++++++++++++---
> kernel/time/posix-timers.c                    |   2 +-
> lib/radix-tree.c                              |   2 +-
> lib/xarray.c                                  |   2 +-
> mm/slab.h                                     |  54 ++--
> mm/slub.c                                     |  20 +-
> net/core/dst.c                                |   2 +-
> security/security.c                           |   2 +-
> security/selinux/avc.c                        |   4 +-
> .../selftests/rcutorture/configs/rcu/CFLIST   |   1 +
> .../selftests/rcutorture/configs/rcu/TREE11   |  18 ++
> .../rcutorture/configs/rcu/TREE11.boot        |   8 +
> 32 files changed, 783 insertions(+), 153 deletions(-)
> create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11
> create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
> 
> --
> 2.37.2.789.g6183377224-goog
> 
