Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0A550BF32
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiDVSBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiDVR6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:58:24 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC6CF699D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:55:28 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f14so6053015qtq.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3suXFPAIIsNc8vClgktn14UGrHFlgIhscB9sf0a4rCY=;
        b=oCtVv53tqeFtiktsk8s/I/910YU7MoJyXMt4MGIHjyHIHxZA/XkdtRvOV3UsGVNs0F
         vzl22oUIjH6TlbqjmZEyGS812vApqW2txAoMZJJk1kLmfXfESUghzeXr5BLiSFU6QuTS
         PlurV6bRC1aWJJkDJBu8cxMyfRxySnkWQrxaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3suXFPAIIsNc8vClgktn14UGrHFlgIhscB9sf0a4rCY=;
        b=rrzLMhmqVXjj8SP2Ubx4t0J363Za11b3dihwpFvMoluOxR8C5JJ7f9YrnqA4fjiZJC
         KBDQdk1yKA9kpsxNZeY7ndTs8OC0NisSs4LeKqDCGW5BcHy7/BQntTO6rOi1lCLpoxAA
         qJJAy9a/061xSHL6HfPW2GJ0pud4JdDklDz0Pa3aXzBzHLtGytp3m6s5DZC4blSZvHob
         jBvdET7IwnPbBk6eMbVRHT6ju44bLtE3Hmfq7wo2FMeSiAAO9ODRnfOZNt1/ZIjv0yqe
         sdFYej5114F0fCECbXwaRLF+UPhBbalOE5U4ZG39G09VKlUgpsEonVEFIA85VvyFvOco
         IXvw==
X-Gm-Message-State: AOAM530dE8uO0TRdt1dBL15tf+t3MTYkWq4X9WOCb1uaX8ygFBR6UDFn
        AvmF/eLItucWo3t5f59C/bnpQfDtuliXyQ==
X-Google-Smtp-Source: ABdhPJx4wAxFNokJwvZUYiBT8fyjmEEDHqXQXn1Z1OkEl4ErXHjIt/lnVjYsuMjCAwUhd3THICEooQ==
X-Received: by 2002:a05:622a:302:b0:2e0:7aed:d653 with SMTP id q2-20020a05622a030200b002e07aedd653mr4212117qtw.492.1650649984322;
        Fri, 22 Apr 2022 10:53:04 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id j1-20020ac85c41000000b002f24ed4fc04sm1679629qtj.83.2022.04.22.10.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:53:03 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        rushikesh.s.kadam@intel.com
Subject: [PATCH v4.1] rcu/nocb: Add an option to offload all CPUs on boot
Date:   Fri, 22 Apr 2022 17:52:47 +0000
Message-Id: <20220422175247.2197949-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
(In v4.1, fixed issues with CONFIG maze reported by kernel test robot).
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
---

Rebased and tested on rcu/dev branch.

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
2.36.0.rc2.479.g8af0fa9b8e-goog

