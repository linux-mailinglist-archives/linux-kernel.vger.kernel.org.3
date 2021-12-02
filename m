Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8F5465B34
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354843AbhLBArd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344326AbhLBArD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C747C061748;
        Wed,  1 Dec 2021 16:43:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5893DCE1DC7;
        Thu,  2 Dec 2021 00:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8006BC53FCC;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=uOWnjx1bRd9B2FlFMLTKtpnUxOJQUoZ8Ey4kwag2k98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Niccbgu/bIs3XkI2Qmx8JqUw9qk3ZYY+lU160edDmpq8TnfniYY76IEw4pQ9V299Z
         jdqIHxp/xBJE8NzlZ8PIrdav3NXZDv4JUMRYhUfgU7tRo8+bq18L/fjqonC+xfRqXG
         CPL+vC2tv3M8ba3w6A4YqTLjb4pelRF5y+rW6nWomb5e4UfamKfEpr41K2NTD62EXg
         vKVFSHucyTe0/gOMMHkyVnszXlVxcBGZeCsr2vAOiyz7LdcNJv6NIDhZhYrTl2LVeA
         hfOQpAn+aJuqO8xUcgjF5jvdZ6hniOe05G4F3JnlUjZVfel6JG0/zK7090GXSUq58x
         EceupB35a6Oew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4C3CA5C1010; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/17] rcutorture: Suppress pi-lock-across read-unlock testing for Tiny SRCU
Date:   Wed,  1 Dec 2021 16:43:22 -0800
Message-Id: <20211202004337.3130175-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because Tiny srcu_read_unlock() directly calls swake_up_one(), lockdep
complains when a pi lock is held across that srcu_read_unlock().
Although this is a lockdep false positive (there is no other CPU to
complete the deadlock cycle), lockdep is what it is at the moment.
This commit therefore prevents rcutorture from holding pi lock across
a Tiny srcu_read_unlock().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d295da380fb4f..503e14e62e8f2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -349,6 +349,7 @@ struct rcu_torture_ops {
 	int can_boost;
 	int extendables;
 	int slow_gps;
+	int no_pi_lock;
 	const char *name;
 };
 
@@ -670,6 +671,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
 	.irq_capable	= 1,
+	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.name		= "srcu"
 };
 
@@ -703,6 +705,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
 	.irq_capable	= 1,
+	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.name		= "srcud"
 };
 
@@ -723,6 +726,7 @@ static struct rcu_torture_ops busted_srcud_ops = {
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
 	.irq_capable	= 1,
+	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.extendables	= RCUTORTURE_MAX_EXTEND,
 	.name		= "busted_srcud"
 };
@@ -1473,8 +1477,9 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 		idxold2 = 0;
 	}
 	if (statesold & RCUTORTURE_RDR_RCU_1) {
-		bool lockit = !statesnew && !(torture_random(trsp) & 0xffff);
+		bool lockit;
 
+		lockit = !cur_ops->no_pi_lock && !statesnew && !(torture_random(trsp) & 0xffff);
 		if (lockit)
 			raw_spin_lock_irqsave(&current->pi_lock, flags);
 		cur_ops->readunlock((idxold1 >> RCUTORTURE_RDR_SHIFT_1) & 0x1);
-- 
2.31.1.189.g2e36527f23

