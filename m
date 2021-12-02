Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACD2465A90
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354143AbhLBAWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344287AbhLBAWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:22:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E411CC061574;
        Wed,  1 Dec 2021 16:18:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72805B8210E;
        Thu,  2 Dec 2021 00:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E914C53FCC;
        Thu,  2 Dec 2021 00:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404319;
        bh=qgWP/Rv554H+pR+gHHeG3HZ4uwuAwa8dDkUx4Tv579U=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=sZpHyUwSp/pz6OTjw80fUAkY1TPZNjFo7kMxsBlRGjcsOTegdfUP7WGHoRNj7SztF
         wjCDnQZqBCUh6jY+D9r1NQV8VLCuK+Tp2AFP2xu2On/MnQOa8Y+9VMalNMX5EG2EuC
         ytHfQlW3Dc6w+PlT906rw8iyZy+/x0eyc566pgcTI48MJ5CaLSoTB+b/qdQowr+jp5
         f7m+ZCTGv3cQFu/RFpzCyT6g9HqiCCjhprbFM0ClHaIWgwjC4xQIZKzNi+VmvpZfG2
         UzEQ+pHgN4ddIMt9Is9ZJq76GwlqMhMVfFUZB9fNHI3zZZR/4qocMuEUNEMxYr9dxh
         v0RSTJ6YVrDYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C950D5C1107; Wed,  1 Dec 2021 16:18:38 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:18:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/4] CONFIG_RCU_FAST_NO_HZ removal for v5.17
Message-ID: <20211202001838.GA3126627@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series removes CONFIG_RCU_FAST_NO_HZ support.  The reason for
taking this step is that in every case that I know of where kernels
are built with CONFIG_RCU_FAST_NO_HZ=y, those kernels also offload RCU
callbacks from all CPUs, for example, by booting with rcu_nocbs=0-N.
This is counterproductive because CONFIG_RCU_FAST_NO_HZ only applies
to CPUs that do not offload their callbacks.  For CPUs with offloaded
callbacks, this Kconfig option does nothing but (slightly) increase your
to/from idle latencies, which is not normally what anyone wants.

So if you know of someone who is gaining real benefit from building their
kernels with CONFIG_RCU_FAST_NO_HZ=y, this would be a most excellent
time to make me aware of this fact.  ;-)

1.	Remove RCU_FAST_NO_HZ from rcuscale and refscale scenarios.

2.	Remove RCU_FAST_NO_HZ from rcu scenarios.

3.	Remove the RCU_FAST_NO_HZ Kconfig option.

4.	Move rcu_needs_cpu() to tree.c.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/RCU/stallwarn.rst                               |   11 
 b/Documentation/admin-guide/kernel-parameters.txt               |    4 
 b/Documentation/timers/no_hz.rst                                |   10 
 b/kernel/rcu/Kconfig                                            |   18 
 b/kernel/rcu/tree.c                                             |   11 
 b/kernel/rcu/tree.h                                             |    7 
 b/kernel/rcu/tree_plugin.h                                      |  185 ----------
 b/kernel/rcu/tree_stall.h                                       |   27 -
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE01         |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE02         |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04         |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05         |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE06         |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE07         |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE08         |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10         |    1 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY      |    1 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01   |    1 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE      |    1 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54    |    1 
 b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT |    1 
 b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT   |    1 
 b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt   |    1 
 kernel/rcu/tree.c                                               |   18 
 kernel/rcu/tree_plugin.h                                        |   16 
 25 files changed, 25 insertions(+), 297 deletions(-)
