Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB482552710
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343758AbiFTWpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244164AbiFTWpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C9A15719;
        Mon, 20 Jun 2022 15:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D89DD61380;
        Mon, 20 Jun 2022 22:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D79DC341C7;
        Mon, 20 Jun 2022 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765105;
        bh=MMOx/Mf+yKKYBlxJNUzhxx2Qq1PONGZHWw4SbSZ2Fg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=De2IbPfUhj6EBIINGusqFVBFmyqaHC2Q4V/WSdOprQoKjbnXGSOGNvojCrZb/yfM8
         a6OsC+yxw2LdULBw3Kc8ZzflHVoZMX+G5pMUYr1Ds7e/+gX0LmK/HmdS6a23FY2DPM
         BoBv4g4TZH+lzMexrpNjCli8DPnPwNzxHumebBMKGGuJI+XOjl2cqxfzcv5OC1SFAH
         K9jCJmmGg7AGAggM9NhfEh7kKNXEtYgLOUR9GQ/HstpsTXlcjM7PGPahlYCBzUiNcS
         j8sIBw+WLrpPM7OWChmjQnamGW213G/bWXi9uwcsIoy+OFYdWL4CCl8kEYSrS9Qxtd
         pydIILwYsLO7w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ED9825C0A33; Mon, 20 Jun 2022 15:45:04 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Joel Fernandes <joel@joelfernandes.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        kernel test robot <lkp@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/7] rcu/nocb: Add an option to offload all CPUs on boot
Date:   Mon, 20 Jun 2022 15:45:00 -0700
Message-Id: <20220620224503.3841196-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
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

From: Joel Fernandes <joel@joelfernandes.org>

Systems built with CONFIG_RCU_NOCB_CPU=y but booted without either
the rcu_nocbs= or rcu_nohz_full= kernel-boot parameters will not have
callback offloading on any of the CPUs, nor can any of the CPUs be
switched to enable callback offloading at runtime.  Although this is
intentional, it would be nice to have a way to offload all the CPUs
without having to make random bootloaders specify either the rcu_nocbs=
or the rcu_nohz_full= kernel-boot parameters.

This commit therefore provides a new CONFIG_RCU_NOCB_CPU_DEFAULT_ALL
Kconfig option that switches the default so as to offload callback
processing on all of the CPUs.  This default can still be overridden
using the rcu_nocbs= and rcu_nohz_full= kernel-boot parameters.

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
(In v4.1, fixed issues with CONFIG maze reported by kernel test robot).
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 kernel/rcu/Kconfig                              | 13 +++++++++++++
 kernel/rcu/tree_nocb.h                          | 15 ++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2522b11e593f2..34605c275294c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3659,6 +3659,9 @@
 			just as if they had also been called out in the
 			rcu_nocbs= boot parameter.
 
+			Note that this argument takes precedence over
+			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
+
 	noiotrap	[SH] Disables trapped I/O port accesses.
 
 	noirqdebug	[X86-32] Disables the code which attempts to detect and
@@ -4557,6 +4560,9 @@
 			no-callback mode from boot but the mode may be
 			toggled at runtime via cpusets.
 
+			Note that this argument takes precedence over
+			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
+
 	rcu_nocb_poll	[KNL]
 			Rather than requiring that offloaded CPUs
 			(specified by rcu_nocbs= above) explicitly
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 1c630e573548d..27aab870ae4cf 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -262,6 +262,19 @@ config RCU_NOCB_CPU
 	  Say Y here if you need reduced OS jitter, despite added overhead.
 	  Say N here if you are unsure.
 
+config RCU_NOCB_CPU_DEFAULT_ALL
+	bool "Offload RCU callback processing from all CPUs by default"
+	depends on RCU_NOCB_CPU
+	default n
+	help
+	  Use this option to offload callback processing from all CPUs
+	  by default, in the absence of the rcu_nocbs or nohz_full boot
+	  parameter. This also avoids the need to use any boot parameters
+	  to achieve the effect of offloading all CPUs on boot.
+
+	  Say Y here if you want offload all CPUs by default on boot.
+	  Say N here if you are unsure.
+
 config TASKS_TRACE_RCU_READ_MB
 	bool "Tasks Trace RCU readers use memory barriers in user and idle"
 	depends on RCU_EXPERT && TASKS_TRACE_RCU
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 4cf9a29bba79d..60cc92cc66552 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1197,11 +1197,21 @@ void __init rcu_init_nohz(void)
 {
 	int cpu;
 	bool need_rcu_nocb_mask = false;
+	bool offload_all = false;
 	struct rcu_data *rdp;
 
+#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
+	if (!rcu_state.nocb_is_setup) {
+		need_rcu_nocb_mask = true;
+		offload_all = true;
+	}
+#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
+
 #if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
+	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
 		need_rcu_nocb_mask = true;
+		offload_all = false; /* NO_HZ_FULL has its own mask. */
+	}
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
 	if (need_rcu_nocb_mask) {
@@ -1222,6 +1232,9 @@ void __init rcu_init_nohz(void)
 		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
+	if (offload_all)
+		cpumask_setall(rcu_nocb_mask);
+
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
-- 
2.31.1.189.g2e36527f23

