Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2132F465ACC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354456AbhLBAdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:33:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59956 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhLBAci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC0DAB80DAC;
        Thu,  2 Dec 2021 00:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939EEC53FCD;
        Thu,  2 Dec 2021 00:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404954;
        bh=5AbQ0ckihc7MT5sAb2Vp/Hh2tLondw2b2CClNs1ma3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lwkm+IahV5WZjLn3o8TsMg0NbELVCw6LvCQqj3w3FGTeCQ24RFz5qBN1YzSIb21/e
         69DU+96FkNrvgcjWMWN7LN2iRorgB4AjcYYcz31mN//PfJ+qMYD11GpAtVfgUnyVrg
         WGok3tfPT4Y0WTzTIZpAd/N14Rh5tq1T0FIiMPPvv0LrwX3GPg9I7Rigr39Znfn2zg
         kygmYPy4zfatwj5UmTIB7P0fG5jd1M8VuEnChmIt9DX/ozSBv7LbnEYem+FjYUdB+y
         qUBQm78zZZU+HRHG9zjefskNHZBwyT9gajIqOB8J2125tgauTRP8Kzx4vN1nayVVRS
         u71zXcr39z3xg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5CAC95C1107; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Guillaume Morin <guillaume@morinfr.org>
Subject: [PATCH rcu 01/18] rcu: Tighten rcu_advance_cbs_nowake() checks
Date:   Wed,  1 Dec 2021 16:28:55 -0800
Message-Id: <20211202002912.3127710-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rcu_advance_cbs_nowake() checks that a grace period is in
progress, however, that grace period could end just after the check.
This commit rechecks that a grace period is still in progress the lock.
The grace period cannot end while the current CPU's rcu_node structure's
->lock is held, thus avoiding false positives from the WARN_ON_ONCE().

As Daniel Vacek noted, it is not necessary for the rcu_node structure
to have a CPU that has not yet passed through its quiescent state.

Tested-By: Guillaume Morin <guillaume@morinfr.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ef8d36f580fc3..8706b30c2ac88 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1590,10 +1590,11 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
 						  struct rcu_data *rdp)
 {
 	rcu_lockdep_assert_cblist_protected(rdp);
-	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) ||
-	    !raw_spin_trylock_rcu_node(rnp))
+	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) || !raw_spin_trylock_rcu_node(rnp))
 		return;
-	WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
+	// The grace period cannot end while we hold the rcu_node lock.
+	if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))
+		WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
 	raw_spin_unlock_rcu_node(rnp);
 }
 
-- 
2.31.1.189.g2e36527f23

