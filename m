Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7555284CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbiEPM4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243894AbiEPM4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:56:04 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11C9393E3;
        Mon, 16 May 2022 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652705759; x=1684241759;
  h=from:to:cc:subject:date:message-id;
  bh=NujqjRizuBf3cIzWf3CK7LJlKgLj8HX9ToWEqxFAgBQ=;
  b=XFebXXwUCmcFM4xpYaz3gYOlAz+BalUsYfNe2dsflo7Us7Ym2uWC/Dbf
   rzSkPuW+lY3ujztS5ZIoXmFDS3YeLi76BjoXwV5oKNr6B8JExB7uax57n
   QZcu2DB3Os2o1Sy8v/PNxO8HLAsFJak+lYULr6uZPsO61QztGS6Wl3eZ/
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 16 May 2022 05:55:58 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 May 2022 05:55:57 -0700
X-QCInternal: smtphost
Received: from hu-c-spathi-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.108.59])
  by ironmsg02-blr.qualcomm.com with ESMTP; 16 May 2022 18:25:41 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id E44573DC6; Mon, 16 May 2022 18:25:39 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
To:     will@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Subject: [PATCH V4] arm64: perf: Set PMCR.X of PMCR_EL0 during pmu reset
Date:   Mon, 16 May 2022 18:25:38 +0530
Message-Id: <1652705738-1628-1-git-send-email-quic_c_spathi@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable exporting of events over PMU event export bus by setting
PMCR.X of PMCR_EL0 during pmu reset.

As it impacts power consumption make it configurable at bootup
with kernel arguments and at runtime with sysctl.

Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
---
Changes since V3:
	- export bit is now configurable with sysctl
	- enabling export bit on reset instead of retaining

Changes since V2:
	Done below changes as per Will's comments
	- enabling pmcr_x now configurable with kernel parameters and
	  by default it is disabled.
	
Changes since V1:
	- Preserving only PMCR_X bit as per Robin Murphy's comment.
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 Documentation/admin-guide/sysctl/kernel.rst     |  8 ++++++++
 arch/arm64/kernel/perf_event.c                  | 15 +++++++++++++++
 include/linux/perf_event.h                      |  1 +
 kernel/sysctl.c                                 | 12 ++++++++++++
 5 files changed, 40 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index de3da15..2139b81 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5150,6 +5150,10 @@
 			Useful for devices that are detected asynchronously
 			(e.g. USB and MMC devices).
 
+	export_pmu_events
+			[KNL] Sets export bit of PMCR_EL0 to enable the exporting of
+			events over PMU event export bus.
+
 	retain_initrd	[RAM] Keep initrd memory after extraction
 
 	rfkill.default_state=
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ddccd10..8fbc3a0 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -892,6 +892,14 @@ The default value is 0 (access disabled).
 
 See Documentation/arm64/perf.rst for more information.
 
+export_pmu_events
+=================
+Controls the export bit(4th bit) of PMCR_EL0 which enables the exporting of
+events over an IMPLEMENTATION DEFINED PMU event export bus to another device.
+
+0: disables exporting of events
+
+1: enables exporting of events
 
 pid_max
 =======
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1..271a8c6 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -34,6 +34,7 @@
 #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_ACCESS		0xEC
 #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED
 
+int sysctl_export_pmu_events __read_mostly;
 /*
  * ARMv8 Architectural defined events, not all of these may
  * be supported on any given implementation. Unsupported events will
@@ -1025,6 +1026,17 @@ static int armv8pmu_filter_match(struct perf_event *event)
 	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
 }
 
+static int __init export_pmu_events(char *str)
+{
+	/* Exporting of events can be enabled at runtime with sysctl or
+	 * statically at bootup with kernel parameters.
+	 */
+	sysctl_export_pmu_events = 1;
+	return 0;
+}
+
+early_param("export_pmu_events", export_pmu_events);
+
 static void armv8pmu_reset(void *info)
 {
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
@@ -1047,6 +1059,9 @@ static void armv8pmu_reset(void *info)
 	if (armv8pmu_has_long_event(cpu_pmu))
 		pmcr |= ARMV8_PMU_PMCR_LP;
 
+	if (sysctl_export_pmu_events)
+		pmcr |= ARMV8_PMU_PMCR_X;
+
 	armv8pmu_pmcr_write(pmcr);
 }
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index da75956..7790328 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1311,6 +1311,7 @@ extern void put_callchain_entry(int rctx);
 
 extern int sysctl_perf_event_max_stack;
 extern int sysctl_perf_event_max_contexts_per_stack;
+extern int sysctl_export_pmu_events;
 
 static inline int perf_callchain_store_context(struct perf_callchain_entry_ctx *ctx, u64 ip)
 {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e52b6e3..3b751a2e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2008,6 +2008,18 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE_THOUSAND,
 	},
 #endif
+#ifdef CONFIG_HW_PERF_EVENTS
+	{
+		.procname       = "export_pmu_events",
+		.data           = &sysctl_export_pmu_events,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+
+	},
+#endif
 	{
 		.procname	= "panic_on_warn",
 		.data		= &panic_on_warn,
-- 
2.7.4

