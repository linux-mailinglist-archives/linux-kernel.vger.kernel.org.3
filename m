Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21FE5060E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbiDSAXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239913AbiDSAXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:23:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A946B1E3DE;
        Mon, 18 Apr 2022 17:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30B82B81128;
        Tue, 19 Apr 2022 00:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A4AC385A1;
        Tue, 19 Apr 2022 00:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327617;
        bh=UlASbxdaJC26sZo/Sw3lITaVi+I0acxpsrvyIgwsydw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNSPEKlpUoYR1B3aj7n3NzB+rvDoqmmJeyt6y6hDaJ470PSI8gPHFgvLGkAicyli3
         9KAztn8V8jMMSoyBQcsukpWPhj8QuAx+zGxN9zRegn3Y8viqtg+NioUUhFK2N+0KGg
         kahpW3TutAur0ytYu3yOXOpMH2mDSneidNVeeZreZKHla6dKiLlUJhjdpGAy7pD3RU
         ZPkm5kF7CSiVnoN8o9qUzA4fybh/JCjB42gk77x1hrkNSoBZcpxWtUsEch5xBSClt3
         1nb22aczed4IptvPNKjBaai9GaZ8i+pe2tEnCTfdrLfeUnlHWTLCO/uYwARz0ehJR5
         Z6IK/H4BMzCbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9F0515C04BD; Mon, 18 Apr 2022 17:20:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/2] rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
Date:   Mon, 18 Apr 2022 17:20:13 -0700
Message-Id: <20220419002014.3951121-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419002008.GA3950677@paulmck-ThinkPad-P17-Gen-1>
References: <20220419002008.GA3950677@paulmck-ThinkPad-P17-Gen-1>
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

From: Uladzislau Rezki <uladzislau.rezki@sony.com>

Currently both expedited and regular grace period stall warnings use
a single timeout value that with units of seconds.  However, recent
Android use cases problem require a sub-100-millisecond expedited RCU CPU
stall warning.  Given that expedited RCU grace periods normally complete
in far less than a single millisecond, especially for small systems,
this is not unreasonable.

Therefore introduce the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT kernel
configuration that defaults to 20 msec on Android and remains the same
as that of the non-expedited stall warnings otherwise.  It also can be
changed in run-time via: /sys/.../parameters/rcu_exp_cpu_stall_timeout.

Signed-off-by: Uladzislau Rezki <uladzislau.rezki@sony.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst               | 18 +++++++++++++
 .../admin-guide/kernel-parameters.txt         |  9 +++++++
 kernel/rcu/Kconfig.debug                      | 13 ++++++++++
 kernel/rcu/rcu.h                              |  2 ++
 kernel/rcu/tree_exp.h                         |  4 +--
 kernel/rcu/tree_stall.h                       | 26 +++++++++++++++++++
 kernel/rcu/update.c                           |  2 ++
 7 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 78404625bad2..1d863b04727c 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -162,6 +162,24 @@ CONFIG_RCU_CPU_STALL_TIMEOUT
 	Stall-warning messages may be enabled and disabled completely via
 	/sys/module/rcupdate/parameters/rcu_cpu_stall_suppress.
 
+CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
+--------------------------------
+
+	Same as the CONFIG_RCU_CPU_STALL_TIMEOUT parameter but only for
+	the expedited grace period. This parameter defines the period of
+	time that RCU will wait from the beginning of an expedited grace
+	period until it issues an RCU CPU stall warning. This time period
+	is normally 20 milliseconds on Android devices.
+
+	This configuration parameter may be changed at runtime via the
+	/sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout, however
+	this parameter is checked only at the beginning of a cycle. If you
+	are in a current stall cycle, setting it to a new value will change
+	the timeout for the -next- stall.
+
+	Stall-warning messages may be enabled and disabled completely via
+	/sys/module/rcupdate/parameters/rcu_cpu_stall_suppress.
+
 RCU_STALL_DELAY_DELTA
 ---------------------
 
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..ddce43b539fb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4893,6 +4893,15 @@
 
 	rcupdate.rcu_cpu_stall_timeout= [KNL]
 			Set timeout for RCU CPU stall warning messages.
+			The value is in seconds and the maximum allowed
+			value is 300 seconds.
+
+	rcupdate.rcu_exp_cpu_stall_timeout= [KNL]
+			Set timeout for expedited RCU CPU stall warning
+			messages.  The value is in milliseconds
+			and the maximum allowed value is 21000
+			milliseconds. Please note that this value is
+			adjusted to an arch timer tick resolution.
 
 	rcupdate.rcu_expedited= [KNL]
 			Use expedited grace-period primitives, for
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 4fd64999300f..c483a166f1c2 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -91,6 +91,19 @@ config RCU_CPU_STALL_TIMEOUT
 	  RCU grace period persists, additional CPU stall warnings are
 	  printed at more widely spaced intervals.
 
+config RCU_EXP_CPU_STALL_TIMEOUT
+	int "Expedited RCU CPU stall timeout in milliseconds"
+	depends on RCU_STALL_COMMON
+	range 1 21000
+	default 20 if ANDROID
+	default 21000 if !ANDROID
+
+	help
+	  If a given expedited RCU grace period extends more than the
+	  specified number of milliseconds, a CPU stall warning is printed.
+	  If the RCU grace period persists, additional CPU stall warnings
+	  are printed at more widely spaced intervals.
+
 config RCU_TRACE
 	bool "Enable tracing for RCU"
 	depends on DEBUG_KERNEL
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 24b5f2c2de87..20f0300f6cb1 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -210,7 +210,9 @@ static inline bool rcu_stall_is_suppressed_at_boot(void)
 extern int rcu_cpu_stall_ftrace_dump;
 extern int rcu_cpu_stall_suppress;
 extern int rcu_cpu_stall_timeout;
+extern int rcu_exp_cpu_stall_timeout;
 int rcu_jiffies_till_stall_check(void);
+int rcu_exp_jiffies_till_stall_check(void);
 
 static inline bool rcu_stall_is_suppressed(void)
 {
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 60197ea24ceb..b1f52b59fa4b 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -496,7 +496,7 @@ static void synchronize_rcu_expedited_wait(void)
 	struct rcu_node *rnp_root = rcu_get_root();
 
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
-	jiffies_stall = rcu_jiffies_till_stall_check();
+	jiffies_stall = rcu_exp_jiffies_till_stall_check();
 	jiffies_start = jiffies;
 	if (tick_nohz_full_enabled() && rcu_inkernel_boot_has_ended()) {
 		if (synchronize_rcu_expedited_wait_once(1))
@@ -571,7 +571,7 @@ static void synchronize_rcu_expedited_wait(void)
 				dump_cpu_task(cpu);
 			}
 		}
-		jiffies_stall = 3 * rcu_jiffies_till_stall_check() + 3;
+		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
 	}
 }
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 0c5d8516516a..84b812a3ab44 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -25,6 +25,32 @@ int sysctl_max_rcu_stall_to_panic __read_mostly;
 #define RCU_STALL_MIGHT_DIV		8
 #define RCU_STALL_MIGHT_MIN		(2 * HZ)
 
+int rcu_exp_jiffies_till_stall_check(void)
+{
+	int cpu_stall_timeout = READ_ONCE(rcu_exp_cpu_stall_timeout);
+	int exp_stall_delay_delta = 0;
+	int till_stall_check;
+
+	/*
+	 * Limit check must be consistent with the Kconfig limits for
+	 * CONFIG_RCU_EXP_CPU_STALL_TIMEOUT, so check the allowed range.
+	 * The minimum clamped value is "2UL", because at least one full
+	 * tick has to be guaranteed.
+	 */
+	till_stall_check = clamp(msecs_to_jiffies(cpu_stall_timeout), 2UL, 21UL * HZ);
+
+	if (jiffies_to_msecs(till_stall_check) != cpu_stall_timeout)
+		WRITE_ONCE(rcu_exp_cpu_stall_timeout, jiffies_to_msecs(till_stall_check));
+
+#ifdef CONFIG_PROVE_RCU
+	/* Add extra ~25% out of till_stall_check. */
+	exp_stall_delay_delta = ((till_stall_check * 25) / 100) + 1;
+#endif
+
+	return till_stall_check + exp_stall_delay_delta;
+}
+EXPORT_SYMBOL_GPL(rcu_exp_jiffies_till_stall_check);
+
 /* Limit-check stall timeouts specified at boottime and runtime. */
 int rcu_jiffies_till_stall_check(void)
 {
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 180ff9c41fa8..fc7fef575606 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -506,6 +506,8 @@ EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress);
 module_param(rcu_cpu_stall_suppress, int, 0644);
 int rcu_cpu_stall_timeout __read_mostly = CONFIG_RCU_CPU_STALL_TIMEOUT;
 module_param(rcu_cpu_stall_timeout, int, 0644);
+int rcu_exp_cpu_stall_timeout __read_mostly = CONFIG_RCU_EXP_CPU_STALL_TIMEOUT;
+module_param(rcu_exp_cpu_stall_timeout, int, 0644);
 #endif /* #ifdef CONFIG_RCU_STALL_COMMON */
 
 // Suppress boot-time RCU CPU stall warnings and rcutorture writer stall
-- 
2.31.1.189.g2e36527f23

