Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDDE5527E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245103AbiFTXMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346326AbiFTXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:11:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E00B26123;
        Mon, 20 Jun 2022 16:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5E0E61501;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC696C341D2;
        Mon, 20 Jun 2022 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766632;
        bh=CBtjLr8hEiHJztrqXuMM/t8/2akXKqG1GWOYWGjDjto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FpYnt8NGPzUjDTeXDjdORCcJSvLTA57hO76FKnvZZMPaIGDKQI0kYx/9PHNRAy3la
         QOfpfXJcF70V2K1x2qqTlJr8i2V/GS+nodXeCTJMNDr4qRtei6vQhTysuIjQfgv4BW
         C2clgWrMt9ei9sazSGh+GL9HjYQhAKlkD6eGZQoevoXJXvt2i8dIQErS4wO4fGE9h5
         eClv//+5c6dgFYJbLUeyYExD+Ek0kePmdpwctThmw308s6n/2kYzrDtWcrc475emof
         OCFQQlepKfsIsBkk74pgdo9yf44MTS2JgJmKyvzRHcNrtflijMU47u29t6JmNr1xQe
         k1uPN+czdcD+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5A7E45C0CCE; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>, Phil Auld <pauld@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alex Belits <abelits@marvell.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/23] context_tracking: Rename context_tracking_cpu_set() to ct_cpu_track_user()
Date:   Mon, 20 Jun 2022 16:10:14 -0700
Message-Id: <20220620231029.3844583-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
References: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

context_tracking_cpu_set() is called in order to tell a CPU to track
user/kernel transitions. Since context tracking is going to expand in
to also track transitions from/to idle/IRQ/NMIs, the scope
of this function name becomes too broad and needs to be made more
specific. Also shorten the prefix to align with the new namespace.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/context_tracking.h | 2 +-
 kernel/context_tracking.c        | 4 ++--
 kernel/time/tick-sched.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 7a5f04ae1758f..63259fece7c76 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -11,7 +11,7 @@
 
 
 #ifdef CONFIG_CONTEXT_TRACKING
-extern void context_tracking_cpu_set(int cpu);
+extern void ct_cpu_track_user(int cpu);
 
 /* Called with interrupts disabled.  */
 extern void __ct_user_enter(enum ctx_state state);
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 87454e3515546..7f457a1a1b551 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -228,7 +228,7 @@ void user_exit_callable(void)
 }
 NOKPROBE_SYMBOL(user_exit_callable);
 
-void __init context_tracking_cpu_set(int cpu)
+void __init ct_cpu_track_user(int cpu)
 {
 	static __initdata bool initialized = false;
 
@@ -258,6 +258,6 @@ void __init context_tracking_init(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		context_tracking_cpu_set(cpu);
+		ct_cpu_track_user(cpu);
 }
 #endif
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 58a11f859ac79..de192dcff8282 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -571,7 +571,7 @@ void __init tick_nohz_init(void)
 	}
 
 	for_each_cpu(cpu, tick_nohz_full_mask)
-		context_tracking_cpu_set(cpu);
+		ct_cpu_track_user(cpu);
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
 					"kernel/nohz:predown", NULL,
-- 
2.31.1.189.g2e36527f23

