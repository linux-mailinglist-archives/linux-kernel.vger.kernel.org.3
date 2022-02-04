Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301344AA443
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378101AbiBDXX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:23:59 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45732 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346197AbiBDXX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:23:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3B752CE24BC;
        Fri,  4 Feb 2022 23:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCD5C004E1;
        Fri,  4 Feb 2022 23:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017035;
        bh=b/qWUsU6i+4L1ic9GtIUoK+xe4iHh0IrR+QA65q2pgA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=t1Kp5HVMsc2c6XRPzEmwhTujJDnQADYh3wPbFcbHmL912gQJoiWzsTcgmEKSQVqHF
         bCmhRbMeia0e3jT4vCNBLxNxaf2NNcRezuQlx3DhvJB/HgAgVIMQTCxerpbVhiS+yn
         Yuj7d3U0SpNOm+Wvb/M65aBGi1Qt0euMk0c1UJSMaIu1hLVyqG5lwVoykFuxb7ud0K
         4Kr82tAzUUqzH6Ynbgpnz1aerqe4jW5BEzBRoqnvb+aqMXsHoJ2Dnp8An5YDXd9AIL
         9nsbe+G3fPK2DfH6nLzX3kfH04joJdsWUkxd6qtJ5d+xyPPryIhnC72ZhLRpsrIigF
         ZhWdSNaqq0srw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6B9655C0418; Fri,  4 Feb 2022 15:23:55 -0800 (PST)
Date:   Fri, 4 Feb 2022 15:23:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/10] Real-time-related updates for v5.18
Message-ID: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides real-time-related RCU updates:

1.	Mark accesses to boost_starttime.

2.	Handle concurrent nocb kthreads creation, courtesy of Neeraj
	Upadhyay.

3.	Remove unused rcu_state.boost, courtesy of Neeraj Upadhyay.

4.	Create per-cpu rcuc kthreads only when rcutree.use_softirq=0,
	courtesy of Zqiang.

5.	Move kthread_prio bounds-check to a separate function, courtesy
	of Alison Chaiken.

6.	Make priority of grace-period thread consistent, courtesy of
	Alison Chaiken.

7.	Elevate priority of offloaded callback threads, courtesy of
	Alison Chaiken.

8.	Update documentation regarding kthread_prio cmdline parameter,
	courtesy of Alison Chaiken.

9.	Don't deboost before reporting expedited quiescent state.

10.	Add per-CPU rcuc task dumps to RCU CPU stall warnings, courtesy
	of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt |    2 +
 b/kernel/rcu/rcutorture.c                         |    7 ++-
 b/kernel/rcu/tree.c                               |    2 -
 b/kernel/rcu/tree.h                               |    2 +
 b/kernel/rcu/tree_nocb.h                          |    7 +++
 b/kernel/rcu/tree_plugin.h                        |    2 -
 b/kernel/rcu/tree_stall.h                         |   35 +++++++++++++++++
 kernel/rcu/tree.c                                 |   44 +++++++++++++---------
 kernel/rcu/tree.h                                 |    6 +--
 kernel/rcu/tree_nocb.h                            |    7 +++
 kernel/rcu/tree_plugin.h                          |   11 +++--
 11 files changed, 94 insertions(+), 31 deletions(-)
