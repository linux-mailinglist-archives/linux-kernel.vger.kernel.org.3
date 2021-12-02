Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0A1465B0B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354659AbhLBAlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhLBAlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:41:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5BFC061574;
        Wed,  1 Dec 2021 16:38:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8BD6DCE2073;
        Thu,  2 Dec 2021 00:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5775C00446;
        Thu,  2 Dec 2021 00:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405506;
        bh=/ckJFm6qpXviL366xNE/ehHXGDPmw59rHuUlhCFqIME=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=C3lt1pgUedC0SnF0studGAAa2rwmJfJIOEXlQ2t+g/3h3kYhX9bVNpDvzejxfkvKY
         V34h7kCk4S3vbWxdfPVrvYglAWRyXwgyr85Dz9tM8GT0TEkitHhC+RLTsVeuO47jT5
         Tj0m5RKDujFu45urCnqILGyD0GaSsCeOFVJFNs/3pNS3tef8oNVXejiUFxS4wjK5Sq
         jpEBUXdg29DR9WL23JDopmsUEBjmocEjIPV1Tu9PsNqZP7CIkOtik0rki3uKd6dTMZ
         iSkJNgwosj32otwjEDUvcNlMdoRYHCSZVsL2Xlt+7ji/m6M8Kf5b9UdpbWmpLcHQP+
         6juBSP/3MhcJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 763195C0FCD; Wed,  1 Dec 2021 16:38:26 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:38:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/18] RCU Tasks updates for v5.17
Message-ID: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides RCU Tasks updates, including making stall warnings
use task_call_func() and providing better update-side scalability for
call_rcu_tasks_trace() and friends:

1.	rcu-tasks: Don't remove tasks with pending IPIs from holdout list.

2.	rcu-tasks:  Create per-CPU callback lists.

3.	rcu-tasks: Introduce ->percpu_enqueue_shift for dynamic queue
	selection.

4.	rcu-tasks: Convert grace-period counter to grace-period sequence
	number.

5.	rcu_tasks: Convert bespoke callback list to rcu_segcblist
	structure.

6.	rcu-tasks: Use spin_lock_rcu_node() and friends.

7.	rcu-tasks: Inspect stalled task's trc state in locked state,
	courtesy of Neeraj Upadhyay.

8.	rcu-tasks: Add a ->percpu_enqueue_lim to the rcu_tasks structure.

9.	rcu-tasks: Abstract checking of callback lists.

10.	rcu-tasks: Abstract invocations of callbacks.

11.	rcu-tasks: Use workqueues for multiple rcu_tasks_invoke_cbs()
	invocations.

12.	rcu-tasks: Make rcu_barrier_tasks*() handle multiple callback
	queues.

13.	rcu-tasks: Add rcupdate.rcu_task_enqueue_lim to set initial
	queueing.

14.	rcu-tasks: Count trylocks to estimate call_rcu_tasks() contention.

15.	rcu-tasks: Avoid raw-spinlocked wakeups from
	call_rcu_tasks_generic().

16.	rcu-tasks: Use more callback queues if contention encountered.

17.	rcu-tasks: Use separate ->percpu_dequeue_lim for callback
	dequeueing.

18.	rcu-tasks: Use fewer callbacks queues if callback flood ends.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt   |   16 
 b/Documentation/admin-guide/kernel-parameters.txt |    7 
 b/kernel/rcu/Kconfig                              |    2 
 b/kernel/rcu/tasks.h                              |    5 
 kernel/rcu/tasks.h                                |  668 ++++++++++++++++------
 5 files changed, 518 insertions(+), 180 deletions(-)
