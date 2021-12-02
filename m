Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6932C465ACF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354488AbhLBAd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:33:26 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51954 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344828AbhLBAck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AFD87CE213F;
        Thu,  2 Dec 2021 00:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD78EC58326;
        Thu,  2 Dec 2021 00:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404954;
        bh=s3AZrbFEY7mQ4FEK2Fw3R8UNO82a9tvDi5H7msuMihQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G27nKuPcAJzrBOjSrPINW/PtC+BLoLD2dCkx4TJdVWqJhTQ4DpmDsPkjX8BH+pueH
         i3y4OdGEFmoe+vPEIGfx1/RZ4763AjG8OAXO9fGKGBYl0pfJHpPorqlYoHoKakml2k
         ekuh5XiAaP+xT9Wr8Iq/gFhp/9hh2r96IOjOl0TU+pLHpEeQUfHYZGQw/GrZb/8ZYc
         B6oX2ZHnOPGrO0GnIi2nHoLcaFWsXYQ/Ooinbs+NFVnJB6MTSezDKj04ewIXPWQDvN
         daw/g6imMFlsG/5yShyQF5ECwcVyS3q5e5MitlH368zglbfqYSqaUVt9NltEwfHWbZ
         IBU/3sf31ewWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6C7795C12FE; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/18] rcu/nocb: Use appropriate rcu_nocb_lock_irqsave()
Date:   Wed,  1 Dec 2021 16:29:02 -0800
Message-Id: <20211202002912.3127710-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Instead of hardcoding IRQ save and nocb lock, use the consolidated
API (and fix a comment as per Valentin Schneider's suggestion).

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4cbfc4e4fa9ed..20587d035d03b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2478,12 +2478,11 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	}
 
 	/*
-	 * Extract the list of ready callbacks, disabling to prevent
+	 * Extract the list of ready callbacks, disabling IRQs to prevent
 	 * races with call_rcu() from interrupt handlers.  Leave the
 	 * callback counts, as rcu_barrier() needs to be conservative.
 	 */
-	local_irq_save(flags);
-	rcu_nocb_lock(rdp);
+	rcu_nocb_lock_irqsave(rdp, flags);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
 	pending = rcu_segcblist_n_cbs(&rdp->cblist);
 	div = READ_ONCE(rcu_divisor);
@@ -2546,8 +2545,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		}
 	}
 
-	local_irq_save(flags);
-	rcu_nocb_lock(rdp);
+	rcu_nocb_lock_irqsave(rdp, flags);
 	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
-- 
2.31.1.189.g2e36527f23

