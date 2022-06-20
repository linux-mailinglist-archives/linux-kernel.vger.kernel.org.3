Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767F15526DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbiFTWU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiFTWUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C1EDF33;
        Mon, 20 Jun 2022 15:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4329612CB;
        Mon, 20 Jun 2022 22:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7D8C3411B;
        Mon, 20 Jun 2022 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763623;
        bh=dOn7IFVHepIOKt7W0XFTmdchLSxER8uJ6Yxc9qWJKY4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=j/SGtcxArewsx/zCH0B5/u4IuUpeKqPku/xwG/BSAc9ct5COBsNDWTHw7Gu1N8HVP
         GfbJC+wxX3hR+yw9SBPMRYtCw9Qi3j1cSRoI00PVuQBlw2CoB7W9XcpB5+XqeUCOWp
         Swi3Inb+ZwQJoKo+8LVc3VaChALqeYMEiimHgxaPU0mYdUqPjcSIC+YMWVRxE8/770
         o2Lz+1MFcGnQX+v6P7+NX9VTqfey5it4dAwkPbReoPUww22vkHRmFYyAXFElJImcES
         lKnhT2D+SdIvk1FhB0PxL1RHb7i+C8huOLQ+PktnxKMMhweO99dSQpy7lhxc81F76Y
         edyatkZxNx5sg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CCEA45C05B9; Mon, 20 Jun 2022 15:20:22 -0700 (PDT)
Date:   Mon, 20 Jun 2022 15:20:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/12] Miscellaneous fixes for v5.20
Message-ID: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains miscellaneous fixes:

1.	Decrease FQS scan wait time in case of callback overloading.

2.	Avoid tracing a few functions executed in stop machine, courtesy
	of Patrick Wang.

3.	Add rnp->cbovldmask check in rcutree_migrate_callbacks(),
	courtesy of Zqiang.

4.	Immediately boost preempted readers for strict grace periods,
	courtesy of Zqiang.

5.	Forbid RCU_STRICT_GRACE_PERIOD in TINY_RCU kernels.

6.	locking/csd_lock: Change csdlock_debug from early_param to
	__setup, courtesy of Chen Zhongjin.

7.	tiny: Record kvfree_call_rcu() call stack for KASAN, courtesy
	of Johannes Berg.

8.	Cleanup RCU urgency state for offline CPU, courtesy of Zqiang.

9.	Remove useless monitor_todo flag, courtesy of "Joel Fernandes
	(Google)".

10.	Initialize first_gp_fqs at declaration in rcu_gp_fqs().

11.	Add comment to describe GP-done condition in fqs loop, courtesy
	of Neeraj Upadhyay.

12.	Block less aggressively for expedited grace periods.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcutiny.h  |   11 +++++++++-
 b/kernel/rcu/Kconfig.debug |    2 -
 b/kernel/rcu/srcutree.c    |   20 ++++++++++++------
 b/kernel/rcu/tiny.c        |   14 +++++++++++++
 b/kernel/rcu/tree.c        |    5 ++++
 b/kernel/rcu/tree_plugin.h |    6 ++---
 b/kernel/smp.c             |    4 +--
 kernel/rcu/tree.c          |   48 ++++++++++++++++++++++++++-------------------
 kernel/rcu/tree_plugin.h   |    3 +-
 9 files changed, 78 insertions(+), 35 deletions(-)
