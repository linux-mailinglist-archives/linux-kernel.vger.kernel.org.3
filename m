Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50103465AC8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242765AbhLBAcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:32:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51706 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhLBAcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D8FD4CE1DC7;
        Thu,  2 Dec 2021 00:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F5EC53FAD;
        Thu,  2 Dec 2021 00:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404929;
        bh=Tr1Np7F8feuJW1m5tGpQOJ4UH+iKcyGWm6eX94xFs7c=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=PLckjzUQVpeBuVyA/By58gAyhVzsUciDPyI+AEJAN7atcZ1wlpWM851hJcjASxhEk
         jus2oTP70zK892Ml2aqCv51EfqiiUFNmAILnAxWScAR9ecow1+ftqnjxE8PDN0ALJr
         oKgt/U0a4SJVIJp77Z47ztq8DKysEnoi7w18C55nTOO0FQB7pLcM8Y/MjMXZ7uDOmv
         96qEbMPAs9IQuOA/UA9Sd2+4uHiRCWEk1yiLKoAJcLL2QtSzWcarEDdFge7Vltbtps
         1ENPgVXrGz0jNjZXEL8m5QWAoIpjnHnIjDGNe4WlqnQSwMvABt/41Hqg1kpNJh/qXt
         wQ0b9diDzxs/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D4B205C1107; Wed,  1 Dec 2021 16:28:48 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:28:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, yury.norov@gmail.com
Subject: [PATCH rcu 0/18] RCU no-CBs CPU updates for v5.17
Message-ID: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides RCU no-CB CPUs updates, most notably the ability
to offload CPUs that are in de-offloaded state at boot time.

1.	Tighten rcu_advance_cbs_nowake() checks.

2.	Make local rcu_nocb_lock_irqsave() safe against concurrent
	deoffloading, courtesy of Frederic Weisbecker.

3.	Prepare state machine for a new step, courtesy of Frederic
	Weisbecker.

4.	Invoke rcu_core() at the start of deoffloading, courtesy of
	Frederic Weisbecker.

5.	Make rcu_core() callbacks acceleration preempt-safe, courtesy
	of Thomas Gleixner.

6.	Make rcu_core() callbacks acceleration (de-)offloading safe,
	courtesy of Frederic Weisbecker.

7.	Check a stable offloaded state to manipulate qlen_last_fqs_check,
	courtesy of Frederic Weisbecker.

8.	Use appropriate rcu_nocb_lock_irqsave(), courtesy of Frederic
	Weisbecker.

9.	Limit number of softirq callbacks only on softirq, courtesy of
	Frederic Weisbecker.

10.	Fix callbacks processing time limit retaining cond_resched(),
	courtesy of Frederic Weisbecker.

11.	Apply callbacks processing time limit only on softirq, courtesy
	of Frederic Weisbecker.

12.	Don't invoke local rcu core on callback overload from nocb
	kthread, courtesy of Frederic Weisbecker.

13.	Remove rcu_node structure from nocb list when de-offloaded,
	courtesy of Frederic Weisbecker.

14.	Prepare nocb_cb_wait() to start with a non-offloaded rdp,
	courtesy of Frederic Weisbecker.

15.	Optimize kthreads and rdp initialization, courtesy of Frederic
	Weisbecker.

16.	Create kthreads on all CPUs if "rcu_nocbs=" or "nohz_full="
	are passed, courtesy of Frederic Weisbecker.

17.	Allow empty "rcu_nocbs" kernel parameter, courtesy of Frederic
	Weisbecker.

18.	Merge rcu_spawn_cpu_nocb_kthread() and
	rcu_spawn_one_nocb_kthread(), courtesy of Frederic Weisbecker.

Note that #17 might be updated given some ongoing work by Yury Norov
to support "none" for bitmaps, including the cpumask taken by the
rcu_nocbs kernel-boot parameter.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt |   37 +++--
 b/include/linux/rcu_segcblist.h                   |   37 +++--
 b/kernel/rcu/rcu_segcblist.c                      |    6 
 b/kernel/rcu/rcu_segcblist.h                      |   12 +
 b/kernel/rcu/tree.c                               |    7 -
 b/kernel/rcu/tree.h                               |   16 +-
 b/kernel/rcu/tree_nocb.h                          |   24 ++-
 include/linux/rcu_segcblist.h                     |   14 ++
 kernel/rcu/rcu_segcblist.c                        |    6 
 kernel/rcu/tree.c                                 |  117 +++++++++++-------
 kernel/rcu/tree.h                                 |    7 -
 kernel/rcu/tree_nocb.h                            |  140 ++++++++++++++--------
 12 files changed, 275 insertions(+), 148 deletions(-)
