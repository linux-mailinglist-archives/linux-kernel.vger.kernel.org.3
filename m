Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25853465A80
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354263AbhLBAQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:16:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51154 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354100AbhLBAOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:14:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C89C6B821A1;
        Thu,  2 Dec 2021 00:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA6DC53FD4;
        Thu,  2 Dec 2021 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403842;
        bh=COn6/0d4JQ0AfFMFlOnsdxnUgj69pk0tjNCrhr73Fg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amZeYdyUM3APbn4Tucgk2wtUgJyFijvrKNsO/ezjQdvaUQZUDuo23il+MjMgdAX7l
         fMNoD9MgAQ8B3RW4Y5YfD4SqyVCdklBgz39ID34wN0791tLn//m8uaxaEqEY0JFQhw
         k0As4j/Vqdc1iyrjJtCgBXuIK3FDpbKyp1RELBwdaukXKSvURrfvsttEGiWBXHw/pP
         Rc13biULc8ORH4UDHalSmODLiNmX/FFMLh14Mpy5J2SDVGO1ykDD6gtNEifANxS6ob
         JvN2CgTBai185rblfGj/rcUuyowhtiehNPSjdPQTCzVILTvuR5Blt6r0mv/bnvfDXy
         eN/TRipDBjzMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 008E55C117F; Wed,  1 Dec 2021 16:10:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/7] rcu: Mark sync_sched_exp_online_cleanup() ->cpu_no_qs.b.exp load
Date:   Wed,  1 Dec 2021 16:10:37 -0800
Message-Id: <20211202001040.3126390-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
References: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sync_sched_exp_online_cleanup() is called from rcutree_online_cpu(),
which can be invoked with interrupts enabled.  This means that
the ->cpu_no_qs.b.exp field is subject to data races from the
rcu_exp_handler() IPI handler, so this commit marks the load from
that field.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index fc2ee326a6f73..12f1a18d7b6d6 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -759,7 +759,7 @@ static void sync_sched_exp_online_cleanup(int cpu)
 	my_cpu = get_cpu();
 	/* Quiescent state either not needed or already requested, leave. */
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
-	    rdp->cpu_no_qs.b.exp) {
+	    READ_ONCE(rdp->cpu_no_qs.b.exp)) {
 		put_cpu();
 		return;
 	}
-- 
2.31.1.189.g2e36527f23

