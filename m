Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9950C4B8ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiBPNwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:52:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiBPNwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:52:32 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3986D2B25A;
        Wed, 16 Feb 2022 05:52:20 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id t14so3395609ljh.8;
        Wed, 16 Feb 2022 05:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4EiYPm2+HRbScmOb/jcDnsvCiWEez/3XhwQHbUUhXA=;
        b=UPAr3hbP4qmCmUzh2N1lcrpDce/QofsGFvr0EOGtApfPjTXGT2StAgdjzFt735kXqg
         mZEree2WrFpMRPnuU3IYK3hqb3P9miUjJROXFfbODy8h1fLfIyRYextRYlXh2+Rf6PDh
         fP1d8ni987rFFwkCBetTKrDr9SsRGYpvN0Rw/uunEKQYAlgfwShSW27LU7OcLyPmTCbW
         beNDTouLUC3FhbVcEM2SgvwjLs3ZreBTRyO5X6lKnv4AFIp2GyMSCVm87kKU39RFftop
         tLaoj+w95da6LKkKp3L/+rt8aBN9Xrvk8q1SYA2aq94FPSjT6D+noewaToJzD3gSBi9l
         vbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4EiYPm2+HRbScmOb/jcDnsvCiWEez/3XhwQHbUUhXA=;
        b=ccbVXL1OFyA6Kvm1FOtLc9R1qMJpZzpo6wOdWXSzSPWY5zwzhyDWJ97zk2vNJjFB9j
         p7FYHeDkSDK3tFj31dVAfbm0YpH2L3a9+C9CmhX6Yz5AH/mvbQWKPAWXjuEt60vqFcgk
         pHsx7BFHe14/g7Kwu4OBBAbTJIVtoa+kiQmlMlW5xQc+o57Yhn2j+P5GIl2wGON4gBSL
         KDr0u5gP4BtZrqNcmuYkpPRKUcwZHBJjqkPGCTq+SNZ4Y3FgsoVEMs6icDW0fMqPMa1o
         8n744PY0aivBiiZnIO3u6BTs6KpvrvRQ1ug28enOK7yTf9xTICRLDlEM0Eo3GwE6AJA9
         bOxg==
X-Gm-Message-State: AOAM531/C9BTrevRjGyV/b+MFs/+dmC4W6E+O7/SHhQ7LCv8SLw9zbph
        oYdYQLkcsMSUTjuKDvW4GeV3NwS96HzYOQ==
X-Google-Smtp-Source: ABdhPJyXUZm9WRFHJO5mC+6U9BqdYlz5AYmSqaBZHIfudZ8P8JlG5sSmpBrg/AjbXTYHAZNpWmDSKA==
X-Received: by 2002:a2e:b8c3:0:b0:244:8a88:6bf9 with SMTP id s3-20020a2eb8c3000000b002448a886bf9mr2187033ljp.67.1645019538355;
        Wed, 16 Feb 2022 05:52:18 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id y38sm2923227lfa.145.2022.02.16.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:52:17 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>
Subject: [PATCH 1/1] rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
Date:   Wed, 16 Feb 2022 14:52:09 +0100
Message-Id: <20220216135209.3070-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uladzislau Rezki <uladzislau.rezki@sony.com>

Currently for both expedited and regular grace periods stall
warnings are emitted based on one timeout value that is defined
in seconds. The problem is that, a stall timeout in seconds for
expedited grace period is a way long.

The idea of expedited grace period is to force CPUs to report
their quiescent states as fast as possible. If in RCU read-side
critical section, it will request the next rcu_read_unlock() to
record the quiescent state. If not either it reports immediately
or set TIF_NEED_RESCHED to initiate the task switch.

Therefore introduce the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT kernel
configuration that is set to 20 msec. It also can be changed in
run-time via: /sys/.../parameters/rcu_exp_cpu_stall_timeout.

Signed-off-by: Uladzislau Rezki <uladzislau.rezki@sony.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 Documentation/RCU/stallwarn.rst               | 18 +++++++++++++
 .../admin-guide/kernel-parameters.txt         |  6 +++++
 kernel/rcu/Kconfig.debug                      | 12 +++++++++
 kernel/rcu/rcu.h                              |  2 ++
 kernel/rcu/tree_exp.h                         |  4 +--
 kernel/rcu/tree_stall.h                       | 26 +++++++++++++++++++
 kernel/rcu/update.c                           |  2 ++
 7 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 78404625bad2..b9ce89980779 100644
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
+	is normally 20 milliseconds.
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
index 9ab6a4a5be06..9a32030f5d1e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4817,6 +4817,12 @@
 	rcupdate.rcu_cpu_stall_timeout= [KNL]
 			Set timeout for RCU CPU stall warning messages.
 
+	rcupdate.rcu_exp_cpu_stall_timeout= [KNL]
+			Set timeout for expedited RCU CPU stall warning messages.
+			The value is in milliseconds and a maximum allowed parameter
+			is 21000 milliseconds. Please note, a set value is adjusted
+			to an arch timer tick resolution.
+
 	rcupdate.rcu_expedited= [KNL]
 			Use expedited grace-period primitives, for
 			example, synchronize_rcu_expedited() instead
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 4fd64999300f..e0f2c5edef44 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -91,6 +91,18 @@ config RCU_CPU_STALL_TIMEOUT
 	  RCU grace period persists, additional CPU stall warnings are
 	  printed at more widely spaced intervals.
 
+config RCU_EXP_CPU_STALL_TIMEOUT
+	int "Expedited RCU CPU stall timeout in milliseconds"
+	depends on RCU_STALL_COMMON
+	range 1 21000
+	default 20
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
index 819f9d979e61..f8ec1df4b91e 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -217,7 +217,9 @@ static inline bool rcu_stall_is_suppressed_at_boot(void)
 extern int rcu_cpu_stall_ftrace_dump;
 extern int rcu_cpu_stall_suppress;
 extern int rcu_cpu_stall_timeout;
+extern int rcu_exp_cpu_stall_timeout;
 int rcu_jiffies_till_stall_check(void);
+int rcu_exp_jiffies_till_stall_check(void);
 
 static inline bool rcu_stall_is_suppressed(void)
 {
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 404198808683..30f05fd080ca 100644
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
2.30.2

