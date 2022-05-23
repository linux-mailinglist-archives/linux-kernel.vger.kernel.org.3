Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20937530F91
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiEWLuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiEWLuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:50:00 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA0850B01;
        Mon, 23 May 2022 04:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653306599; x=1684842599;
  h=from:to:cc:subject:date:message-id;
  bh=WmKCF3EyU++9G579lZKMTRj5Z0y/zWQdzCZSNlAEd+Q=;
  b=M9hck+nvp3KH1uxLrOk+Dm4aMMNzU1QLSZL1wiJTIRndXf1937jVJ6zN
   SX4QUqEYCxBh2ITmCfM1ljFnI8PajbUGLKDDE8fgywxVZpgQijCl/70qZ
   kGOtnpvKoozSdJA+W7qXISEN7ahX66gFJMsbFT/BZrqxPQTM8WeCMjb66
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 23 May 2022 04:49:59 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 May 2022 04:49:57 -0700
X-QCInternal: smtphost
Received: from hu-c-spathi-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.108.59])
  by ironmsg01-blr.qualcomm.com with ESMTP; 23 May 2022 17:19:41 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id 4EDBA39C8; Mon, 23 May 2022 17:19:40 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
To:     will@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Subject: [PATCH V5] arm64: perf: Make exporting of pmu events configurable
Date:   Mon, 23 May 2022 17:19:34 +0530
Message-Id: <1653306574-20946-1-git-send-email-quic_c_spathi@quicinc.com>
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

The PMU export bit (PMCR_EL0.X) is getting reset during pmu reset,
Make is configurable using sysctls to enable/disable at runtime.
It can also be enabled at early bootup with kernel arguments.

Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
---
Changes since V4:
	- Registering sysctls dynamically for only arm64 as suggested by Will
	- Not removed the code to configure with kernel parameters 
	  as the sysctl's kernel parameter(sysctl.kernel.export_pmu_events)
	  is not working at early bootup. pmu_reset() getting called before 
	  sysctl's kernel parameter is set.
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
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 Documentation/admin-guide/sysctl/kernel.rst     |  9 +++++++++
 arch/arm64/kernel/perf_event.c                  | 24 ++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index de3da15..2bf1187 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5150,6 +5150,11 @@
 			Useful for devices that are detected asynchronously
 			(e.g. USB and MMC devices).
 
+	export_pmu_events
+			[KNL,ARM64] Sets the PMU export bit (PMCR_EL0.X), which enables
+			the exporting of events over an IMPLEMENTATION DEFINED PMU event
+			export bus to another device.
+
 	retain_initrd	[RAM] Keep initrd memory after extraction
 
 	rfkill.default_state=
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ddccd10..db42d4c 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -892,6 +892,15 @@ The default value is 0 (access disabled).
 
 See Documentation/arm64/perf.rst for more information.
 
+export_pmu_events (arm64 only)
+==============================
+Controls the PMU export bit (PMCR_EL0.X), which enables the exporting of
+events over an IMPLEMENTATION DEFINED PMU event export bus to another device.
+
+0: disables exporting of events (default).
+
+1: enables exporting of events.
+
 
 pid_max
 =======
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1..d93e7c4 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -298,6 +298,7 @@ PMU_FORMAT_ATTR(long, "config1:0");
 PMU_FORMAT_ATTR(rdpmc, "config1:1");
 
 static int sysctl_perf_user_access __read_mostly;
+static int sysctl_export_pmu_events __read_mostly;
 
 static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
 {
@@ -1025,6 +1026,17 @@ static int armv8pmu_filter_match(struct perf_event *event)
 	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
 }
 
+static int __init export_pmu_events(char *str)
+{
+	/* Enable exporting of pmu events at early bootup with kernel
+	 * arguments.
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
 
@@ -1221,6 +1236,15 @@ static struct ctl_table armv8_pmu_sysctl_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname       = "export_pmu_events",
+		.data           = &sysctl_export_pmu_events,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
 	{ }
 };
 
-- 
2.7.4

