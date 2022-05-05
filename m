Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3351CD40
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387309AbiEFADX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387129AbiEFABs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5274C60DB4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795075; x=1683331075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/O+HEX9RnyO8ZBUK3lK021eADBWVL0Yl8Mx87L868do=;
  b=Bacrrn10qNt3fZKGU4HocyRE3pr6vF9pu1IyA8P6kjJh6awJn6hucxao
   r+YypSpKObHslD76oqqbPUhWF2hbsv/vPzxKDH8iJ8x5qUYqJcj+I1YNu
   niSmiC21WXLaijVuFYAJ5TgV2dPrqhOlXFC4iMrdPxs3ps6+UP1VABPxf
   o2AK6+iUcLuSiQlH2HhatywFJ+HYPP8nb7BKWeKlsCGQQ1p+53aFF6pv5
   p5fn0nDzzEdwzzWR7Isxdk0hSNNRa/fEdqSTKc7fOLoVtv568T6xlDCn5
   cg/VTSGP7+OceqZZBEcO/77q9fmIxuZ2nS/lfF3i2/1VPP2XIodGt1PPi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283646"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283646"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914406"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:52 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v6 19/29] watchdog/hardlockup: Decouple the hardlockup detector from perf
Date:   Thu,  5 May 2022 16:59:58 -0700
Message-Id: <20220506000008.30892-20-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current default implementation of the hardlockup detector assumes that
it is implemented using perf events. However, the hardlockup detector can
be driven by other sources of non-maskable interrupts (e.g., a properly
configured timer).

Group and wrap in #ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF all the code
specific to perf: create and manage perf events, stop and start the perf-
based detector.

The generic portion of the detector (monitor the timers' thresholds, check
timestamps and detect hardlockups as well as the implementation of
arch_touch_nmi_watchdog()) is now selected with the new intermediate config
symbol CONFIG_HARDLOCKUP_DETECTOR_CORE.

The perf-based implementation of the detector selects the new intermediate
symbol. Other implementations should do the same.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * None

Changes since v4:
 * None

Changes since v3:
 * Squashed into this patch a previous patch to make
   arch_touch_nmi_watchdog() part of the core detector code.

Changes since v2:
 * Undid split of the generic hardlockup detector into a separate file.
   (Thomas Gleixner)
 * Added a new intermediate symbol CONFIG_HARDLOCKUP_DETECTOR_CORE to
   select generic parts of the detector (Paul E. McKenney,
   Thomas Gleixner).

Changes since v1:
 * Make the generic detector code with CONFIG_HARDLOCKUP_DETECTOR.
---
 include/linux/nmi.h   |  5 ++++-
 kernel/Makefile       |  2 +-
 kernel/watchdog_hld.c | 32 ++++++++++++++++++++------------
 lib/Kconfig.debug     |  4 ++++
 4 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 1b68f48ad440..cf12380e51b3 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -94,8 +94,11 @@ static inline void hardlockup_detector_disable(void) {}
 # define NMI_WATCHDOG_SYSCTL_PERM	0444
 #endif
 
-#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
+#if defined(CONFIG_HARDLOCKUP_DETECTOR_CORE)
 extern void arch_touch_nmi_watchdog(void);
+#endif
+
+#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
 extern void hardlockup_detector_perf_stop(void);
 extern void hardlockup_detector_perf_restart(void);
 extern void hardlockup_detector_perf_disable(void);
diff --git a/kernel/Makefile b/kernel/Makefile
index 847a82bfe0e3..27e75b735ef7 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -95,7 +95,7 @@ obj-$(CONFIG_FAIL_FUNCTION) += fail_function.o
 obj-$(CONFIG_KGDB) += debug/
 obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
-obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
+obj-$(CONFIG_HARDLOCKUP_DETECTOR_CORE) += watchdog_hld.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_SYSCTL) += utsname_sysctl.o
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index b352e507b17f..bb6435978c46 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -22,12 +22,8 @@
 
 static DEFINE_PER_CPU(bool, hard_watchdog_warn);
 static DEFINE_PER_CPU(bool, watchdog_nmi_touch);
-static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
-static DEFINE_PER_CPU(struct perf_event *, dead_event);
-static struct cpumask dead_events_mask;
 
 static unsigned long hardlockup_allcpu_dumped;
-static atomic_t watchdog_cpus = ATOMIC_INIT(0);
 
 notrace void arch_touch_nmi_watchdog(void)
 {
@@ -98,14 +94,6 @@ static inline bool watchdog_check_timestamp(void)
 }
 #endif
 
-static struct perf_event_attr wd_hw_attr = {
-	.type		= PERF_TYPE_HARDWARE,
-	.config		= PERF_COUNT_HW_CPU_CYCLES,
-	.size		= sizeof(struct perf_event_attr),
-	.pinned		= 1,
-	.disabled	= 1,
-};
-
 void inspect_for_hardlockups(struct pt_regs *regs)
 {
 	if (__this_cpu_read(watchdog_nmi_touch) == true) {
@@ -157,6 +145,24 @@ void inspect_for_hardlockups(struct pt_regs *regs)
 	return;
 }
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+#undef pr_fmt
+#define pr_fmt(fmt) "NMI perf watchdog: " fmt
+
+static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
+static DEFINE_PER_CPU(struct perf_event *, dead_event);
+static struct cpumask dead_events_mask;
+
+static atomic_t watchdog_cpus = ATOMIC_INIT(0);
+
+static struct perf_event_attr wd_hw_attr = {
+	.type		= PERF_TYPE_HARDWARE,
+	.config		= PERF_COUNT_HW_CPU_CYCLES,
+	.size		= sizeof(struct perf_event_attr),
+	.pinned		= 1,
+	.disabled	= 1,
+};
+
 /* Callback function for perf event subsystem */
 static void watchdog_overflow_callback(struct perf_event *event,
 				       struct perf_sample_data *data,
@@ -298,3 +304,5 @@ int __init hardlockup_detector_perf_init(void)
 	}
 	return ret;
 }
+
+#endif /* CONFIG_HARDLOCKUP_DETECTOR_PERF */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 55b9acb2f524..1640532cdc6a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1079,9 +1079,13 @@ config BOOTPARAM_SOFTLOCKUP_PANIC_VALUE
 	default 0 if !BOOTPARAM_SOFTLOCKUP_PANIC
 	default 1 if BOOTPARAM_SOFTLOCKUP_PANIC
 
+config HARDLOCKUP_DETECTOR_CORE
+	bool
+
 config HARDLOCKUP_DETECTOR_PERF
 	bool
 	select SOFTLOCKUP_DETECTOR
+	select HARDLOCKUP_DETECTOR_CORE
 
 #
 # Enables a timestamp based low pass filter to compensate for perf based
-- 
2.17.1

