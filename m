Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AAB508B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379444AbiDTOx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354576AbiDTOx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:53:57 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919AF1A3A4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:51:10 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id f14so1123131qtq.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZL0l8b4wbBeGrEgFlJDiTjtc+TjJhGaniGSaIqgaD1k=;
        b=t68OR5DPLBvQmIxDi7WTg+GTbzdlNHhKn9u361cqNFERKUlE7pVWsmWHh5azP7za+l
         VrxAkjyMYvpNFBD8mdg6o9sZawYPy1ZK2xuTFPxoUwtWIdv/CccZGPN6uR3OpD3QhatL
         lnp8TtuewJJl2gnuPtWP6gvQcntLe93Cxcnc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZL0l8b4wbBeGrEgFlJDiTjtc+TjJhGaniGSaIqgaD1k=;
        b=HBsIRvj0Q9A+ILFki9UU8HnYrtIrm1FjIwlQ3lFPy91qs2Kv6xEhlb4usFv7C4xaWQ
         WxAW2jl2KqJYZ9JEeH4cwq4gdaiFvYZGzTgcR/QYGsVVwJiAgoVz2Fvnvr+L6mwmuyNZ
         Gbnubl68WQehDpG3791uzRD0aGZqUbHcNOF5j8wzN2mFA7/+jIF6Sryf6xJkf7lcev0K
         cCjz+OtRFiAQlUdVOpI5Z7KJoHL6iiNDdDIJQ+Nm+p1ZPuPkvvh17HVwXHCoEc4OJP6E
         1nq3SM6jnQwTpyq+FodwTvU4CGwfA48zY+/OOF2osKDLK1QSi5UWOfxiZ52KXxB0SKNf
         Dllg==
X-Gm-Message-State: AOAM533q+gh9x8tZaatNUUtnGeHIo4XeYBqYiKhlr3Fv2FzE9mPrMnSc
        LbFLBxoivGuggPNeNuYGSuc+iI6C1DPXIQ==
X-Google-Smtp-Source: ABdhPJx7C3j770VG1cEpi7dov9su4SKBTvjfqTAk9HEeykvN0gLX+ExdqYDCQIWudhvozMIHGCV5WA==
X-Received: by 2002:a05:622a:1394:b0:2f3:4383:bf0 with SMTP id o20-20020a05622a139400b002f343830bf0mr1490596qtk.80.1650466269561;
        Wed, 20 Apr 2022 07:51:09 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s19-20020a05622a179300b002e1ceeb21d0sm1854529qtk.97.2022.04.20.07.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:51:09 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        rushikesh.s.kadam@intel.com, vineethrp@gmail.com, urezki@gmail.com
Subject: [PATCH v4.1 rcu/dev] rcu/nocb: Add an option to offload all CPUs on boot
Date:   Wed, 20 Apr 2022 14:50:53 +0000
Message-Id: <20220420145053.2904354-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Fernandes <joel@joelfernandes.org>

On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
which ends up not offloading any CPU. This patch removes a dependency
from the bootloader having to know about RCU and about how to provide
the mask.

With the new option enabled, all CPUs will be offloaded on boot unless
rcu_nocbs= or rcu_nohz_full= kernel parameters provide a CPU list.

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
---
v4.1: Just resend of v4 with trivial fix to if statement braces which broke
      CONFIG_NO_HZ_FULL=y. Sorry, I messed the patch up while fixing up v4.

 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 kernel/rcu/Kconfig                              | 13 +++++++++++++
 kernel/rcu/tree_nocb.h                          | 15 ++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 789ef586009b..1e82ecb7a649 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3572,6 +3572,9 @@
 			just as if they had also been called out in the
 			rcu_nocbs= boot parameter.
 
+			Note that this argument takes precedence over
+			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
+
 	noiotrap	[SH] Disables trapped I/O port accesses.
 
 	noirqdebug	[X86-32] Disables the code which attempts to detect and
@@ -4475,6 +4478,9 @@
 			no-callback mode from boot but the mode may be
 			toggled at runtime via cpusets.
 
+			Note that this argument takes precedence over
+			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
+
 	rcu_nocb_poll	[KNL]
 			Rather than requiring that offloaded CPUs
 			(specified by rcu_nocbs= above) explicitly
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 1c630e573548..27aab870ae4c 100644
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
index 4cf9a29bba79..60cc92cc6655 100644
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
2.36.0.rc0.470.gd361397f0d-goog

