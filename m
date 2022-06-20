Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9F95526DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244155AbiFTWSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242006AbiFTWSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:18:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6AFE0BC;
        Mon, 20 Jun 2022 15:18:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8213DB81647;
        Mon, 20 Jun 2022 22:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329C0C341C4;
        Mon, 20 Jun 2022 22:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763479;
        bh=3IjzAH3IU8DX6ygvyChO/By+o8Dkf/HjE2ORydBJA9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IepZHb3VEz6sSDFyoWiQK4YBMsGDaaD2jmlkmWB7TLDO/OwCiUKoYLc/V6C/W003L
         Xy+9KSuRMzKosvOeE/ZtJSdklxoYdC54DEhBdVd4DqgFZz2a6zypgbEAsOEBHGq+ph
         m2OruJi6xwWTMqleGxyKQjlWBmalYc1Ap8lcIkgC5HRSZ/TKpXmApwm82h8n/pkShb
         9MJUCUYdTMk77oWe3NxXw/3Ua/ikTJKYu1TCvi6sbEOWnRNwTeFIkbptN5DEnsb6La
         M+3OXiyy3nUXb46YV5MdyoDj74dHl4uQ4n17qb5neQkyrcdTqPaKzQZyeGN//KHGUZ
         a0qvssxpsoQ3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D41F45C05B9; Mon, 20 Jun 2022 15:17:58 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/3] rcutorture: Update rcutorture.fwd_progress help text
Date:   Mon, 20 Jun 2022 15:17:55 -0700
Message-Id: <20220620221757.3839212-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620221733.GA3839136@paulmck-ThinkPad-P17-Gen-1>
References: <20220620221733.GA3839136@paulmck-ThinkPad-P17-Gen-1>
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

This commit updates the rcutorture.fwd_progress help text to say that
it is the number of forward-progress kthreads to spawn rather than the
old enable/disable functionality.  While in the area, make the list of
torture-test parameters easier to read by taking advantage of 100 columns.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 53 ++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7120165a93426..6f47d1490c4f5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -75,62 +75,45 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@
 
 torture_param(int, extendables, RCUTORTURE_MAX_EXTEND,
 	      "Extend readers by disabling bh (1), irqs (2), or preempt (4)");
-torture_param(int, fqs_duration, 0,
-	      "Duration of fqs bursts (us), 0 to disable");
+torture_param(int, fqs_duration, 0, "Duration of fqs bursts (us), 0 to disable");
 torture_param(int, fqs_holdoff, 0, "Holdoff time within fqs bursts (us)");
 torture_param(int, fqs_stutter, 3, "Wait time between fqs bursts (s)");
-torture_param(int, fwd_progress, 1, "Test grace-period forward progress");
+torture_param(int, fwd_progress, 1, "Number of grace-period forward progress tasks (0 to disable)");
 torture_param(int, fwd_progress_div, 4, "Fraction of CPU stall to wait");
-torture_param(int, fwd_progress_holdoff, 60,
-	      "Time between forward-progress tests (s)");
-torture_param(bool, fwd_progress_need_resched, 1,
-	      "Hide cond_resched() behind need_resched()");
+torture_param(int, fwd_progress_holdoff, 60, "Time between forward-progress tests (s)");
+torture_param(bool, fwd_progress_need_resched, 1, "Hide cond_resched() behind need_resched()");
 torture_param(bool, gp_cond, false, "Use conditional/async GP wait primitives");
 torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
-torture_param(bool, gp_normal, false,
-	     "Use normal (non-expedited) GP wait primitives");
+torture_param(bool, gp_normal, false, "Use normal (non-expedited) GP wait primitives");
 torture_param(bool, gp_poll, false, "Use polling GP wait primitives");
 torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
 torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
 torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
-torture_param(int, n_barrier_cbs, 0,
-	     "# of callbacks/kthreads for barrier testing");
+torture_param(int, n_barrier_cbs, 0, "# of callbacks/kthreads for barrier testing");
 torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
-torture_param(int, object_debug, 0,
-	     "Enable debug-object double call_rcu() testing");
+torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
-torture_param(int, onoff_interval, 0,
-	     "Time between CPU hotplugs (jiffies), 0=disable");
+torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
 torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
 torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
-torture_param(int, read_exit_delay, 13,
-	      "Delay between read-then-exit episodes (s)");
-torture_param(int, read_exit_burst, 16,
-	      "# of read-then-exit bursts per episode, zero to disable");
+torture_param(int, read_exit_delay, 13, "Delay between read-then-exit episodes (s)");
+torture_param(int, read_exit_burst, 16, "# of read-then-exit bursts per episode, zero to disable");
 torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
 torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
-torture_param(int, stall_cpu_holdoff, 10,
-	     "Time to wait before starting stall (s).");
-torture_param(bool, stall_no_softlockup, false,
-	     "Avoid softlockup warning during cpu stall.");
+torture_param(int, stall_cpu_holdoff, 10, "Time to wait before starting stall (s).");
+torture_param(bool, stall_no_softlockup, false, "Avoid softlockup warning during cpu stall.");
 torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
 torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
-torture_param(int, stall_gp_kthread, 0,
-	      "Grace-period kthread stall duration (s).");
-torture_param(int, stat_interval, 60,
-	     "Number of seconds between stats printk()s");
+torture_param(int, stall_gp_kthread, 0, "Grace-period kthread stall duration (s).");
+torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of seconds to run/halt test");
 torture_param(int, test_boost, 1, "Test RCU prio boost: 0=no, 1=maybe, 2=yes.");
-torture_param(int, test_boost_duration, 4,
-	     "Duration of each boost test, seconds.");
-torture_param(int, test_boost_interval, 7,
-	     "Interval between boost tests, seconds.");
-torture_param(bool, test_no_idle_hz, true,
-	     "Test support for tickless idle CPUs");
-torture_param(int, verbose, 1,
-	     "Enable verbose debugging printk()s");
+torture_param(int, test_boost_duration, 4, "Duration of each boost test, seconds.");
+torture_param(int, test_boost_interval, 7, "Interval between boost tests, seconds.");
+torture_param(bool, test_no_idle_hz, true, "Test support for tickless idle CPUs");
+torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 
 static char *torture_type = "rcu";
 module_param(torture_type, charp, 0444);
-- 
2.31.1.189.g2e36527f23

