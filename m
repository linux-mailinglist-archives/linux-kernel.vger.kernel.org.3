Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7353465B37
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354835AbhLBArr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:47:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39234 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344426AbhLBArE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C27ABB821A2;
        Thu,  2 Dec 2021 00:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3909C58324;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=eL+euvuzQ5Lzuz/udVG7kV9oFa8ERST2BS75W1bjwzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iBz7SuAvtzH+0Js2QEjIb1D9O05g3Gje2maFbZjEgqTy4jczTYdQcrHdz0dstymfc
         tcTSRxLHzbbKf96oY1ykRKUGj5djp7V8UjJqdGC7p43ca6pHRQ8bZHpJMlb8x2kGT8
         +Yastfg4ArpSEJvhdNMWyFat3ol1oBKjU0gjNkgnFkfA9kqUEowjhauUBrS5u6U8Hs
         7ZMdkw95KiQd9bFRmdGsG2f+knWn0cFxg9mF7X/8MqtlKho0xE5kSALfgUhUY/huFb
         sA2Ohb32Z/HDgvYmEzerW/26K9tmTyxGxiIMDntXsR9iRv3PCnM3hmaij5wtaInOtF
         QO+jXRChieGDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E82D5C12FE; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Wander Lairson Costa <wander@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 13/17] rcutorture: Avoid soft lockup during cpu stall
Date:   Wed,  1 Dec 2021 16:43:32 -0800
Message-Id: <20211202004337.3130175-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wander Lairson Costa <wander@redhat.com>

If we use the module stall_cpu option, we may get a soft lockup warning
in case we also don't pass the stall_cpu_block option.

Introduce the stall_no_softlockup option to avoid a soft lockup on
cpu stall even if we don't use the stall_cpu_block option.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 36a273589a35c..bc854f9355488 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -46,6 +46,7 @@
 #include <linux/oom.h>
 #include <linux/tick.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/nmi.h>
 
 #include "rcu.h"
 
@@ -112,6 +113,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
 torture_param(int, stall_cpu_holdoff, 10,
 	     "Time to wait before starting stall (s).");
+torture_param(bool, stall_no_softlockup, false,
+	     "Avoid softlockup warning during cpu stall.");
 torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
 torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
 torture_param(int, stall_gp_kthread, 0,
@@ -2085,6 +2088,8 @@ static int rcu_torture_stall(void *args)
 #else
 				schedule_timeout_uninterruptible(HZ);
 #endif
+			} else if (stall_no_softlockup) {
+				touch_softlockup_watchdog();
 			}
 		if (stall_cpu_irqsoff)
 			local_irq_enable();
-- 
2.31.1.189.g2e36527f23

