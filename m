Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C74461D07
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242407AbhK2Rxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:53:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55072 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbhK2Rvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:51:46 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638208107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hebj8aC3wqf8zcdV4QNi9m7i1BFcLB8bFJ7GSEzXgF0=;
        b=hhHMV0Y/uMBaWyoJY15fYZ0s6+ofik5x0NwQtH+wwjGH2PGG9PlFX33elRij096NS6AO+b
        14tgHQC8L7ip/0IgfhzwAki8qFYA2VYK+lq+e6GDs7S6sZttu8Nba5pBgrZuYXVoVMKqsY
        llnE7NWDd/drPJxXshJyw+p6kITpQimdcUFd2qCpC24qvDI+b0WpczZ692Ur6UOzHHR2Jp
        tzwo/pQz7k70TrHvNFjZKvjOWkD2MC1wNd0l3UcNcc20qde547ueRwXxO3cFnVHsTWps6b
        o79hC9k7B2QqEn0lIIi1SxXJDJoToBxccF9vmDUyGu9zvZs25HrUk0JnW4Ik8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638208107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hebj8aC3wqf8zcdV4QNi9m7i1BFcLB8bFJ7GSEzXgF0=;
        b=UYTIu9qO9uqHsVwbtG1PVZuN6IxEMpzbcoHytQ9cj2heu0EB9ww3aZKvd0lVXGXSvKT4vl
        DWqW5F2sCZdPqfAg==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 03/11] locking/rtmutex: Squash self-deadlock check for ww_rt_mutex.
Date:   Mon, 29 Nov 2021 18:46:46 +0100
Message-Id: <20211129174654.668506-4-bigeasy@linutronix.de>
In-Reply-To: <20211129174654.668506-1-bigeasy@linutronix.de>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Similar to the issues in commits:

  6467822b8cc9 ("locking/rtmutex: Prevent spurious EDEADLK return caused by=
 ww_mutexes")
  a055fcc132d4 ("locking/rtmutex: Return success on deadlock for ww_mutex w=
aiters")

ww_rt_mutex_lock() should not return EDEADLK without first going through
the __ww_mutex logic to set the required state. In fact, the chain-walk
can deal with the spurious cycles (per the above commits) this check
warns about and is trying to avoid.

Therefore ignore this test for ww_rt_mutex and simply let things fall
in place.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 0c6a48dfcecb3..f89620852774d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1103,8 +1103,11 @@ static int __sched task_blocks_on_rt_mutex(struct rt=
_mutex_base *lock,
 	 * the other will detect the deadlock and return -EDEADLOCK,
 	 * which is wrong, as the other waiter is not in a deadlock
 	 * situation.
+	 *
+	 * Except for ww_mutex, in that case the chain walk must already deal
+	 * with spurious cycles, see the comments at [3] and [6].
 	 */
-	if (owner =3D=3D task)
+	if (owner =3D=3D task && !(build_ww_mutex() && ww_ctx))
 		return -EDEADLK;
=20
 	raw_spin_lock(&task->pi_lock);
--=20
2.34.0

