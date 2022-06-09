Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A9A544CD4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbiFINA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343630AbiFINAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:00:23 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414914A3F0;
        Thu,  9 Jun 2022 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654779614; x=1686315614;
  h=from:to:cc:subject:date:message-id;
  bh=MbluhEaJzamnhyK/2T+/wKWSz4GPM1oLHU1upxZh1bA=;
  b=WPLD68DbZDWaxxpOhDc+kSPDlxypjyKTacj4jkv9MeWUN9QDo1KpyxVm
   MorHx6Cv/xfktb9sTBIrSy8DkD+m8lGuA6bcKNl7xDkSdzc8EudG1Qa9U
   4IPGGIkzGURDcywc/Za4ziw+Nl/E64gMBQZRI8ZyaUmjmt3j5Ns9Vz75K
   o=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Jun 2022 06:00:10 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Jun 2022 06:00:09 -0700
X-QCInternal: smtphost
Received: from hu-c-spathi-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.108.59])
  by ironmsg02-blr.qualcomm.com with ESMTP; 09 Jun 2022 18:29:53 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id C53E83E5A; Thu,  9 Jun 2022 18:29:51 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
To:     will@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Subject: [PATCH V6] arm64: perf: Make exporting of pmu events configurable
Date:   Thu,  9 Jun 2022 18:29:49 +0530
Message-Id: <1654779589-19937-1-git-send-email-quic_c_spathi@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMU export bit (PMCR_EL0.X) is getting reset during pmu reset,
Make it configurable using sysctls to enable/disable at runtime.

Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
---
Changes since V5:
	- removed configuring with kernel parameters.
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
 Documentation/admin-guide/sysctl/kernel.rst | 11 +++++++++++
 arch/arm64/kernel/perf_event.c              | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ddccd10..c2ecd84 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -267,6 +267,17 @@ domain names are in general different. For a detailed discussion
 see the ``hostname(1)`` man page.
 
 
+export_pmu_events (arm64 only)
+==============================
+
+Controls the PMU export bit (PMCR_EL0.X), which enables the exporting of
+events over an IMPLEMENTATION DEFINED PMU event export bus to another device.
+
+0: disables exporting of events (default).
+
+1: enables exporting of events.
+
+
 firmware_config
 ===============
 
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1..a8c32a0 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -298,6 +298,7 @@ PMU_FORMAT_ATTR(long, "config1:0");
 PMU_FORMAT_ATTR(rdpmc, "config1:1");
 
 static int sysctl_perf_user_access __read_mostly;
+static int sysctl_export_pmu_events __read_mostly;
 
 static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
 {
@@ -1047,6 +1048,9 @@ static void armv8pmu_reset(void *info)
 	if (armv8pmu_has_long_event(cpu_pmu))
 		pmcr |= ARMV8_PMU_PMCR_LP;
 
+	if (sysctl_export_pmu_events)
+		pmcr |= ARMV8_PMU_PMCR_X;
+
 	armv8pmu_pmcr_write(pmcr);
 }
 
@@ -1221,6 +1225,15 @@ static struct ctl_table armv8_pmu_sysctl_table[] = {
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

