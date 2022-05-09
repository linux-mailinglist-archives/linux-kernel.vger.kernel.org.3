Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B975203AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbiEIRdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbiEIRdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:33:11 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B942802C3;
        Mon,  9 May 2022 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652117357; x=1683653357;
  h=from:to:cc:subject:date:message-id;
  bh=w8WwiKdUcDjQO2d2znxaFZegHXKvmkZZDdebrvYoFpk=;
  b=TYD0qEn1toU0uBBWTkhdHJzWA0BkMmIuh4oN1PxsqISFdrZdQ4ZQRZ/v
   Bug0T85g5srE3CTStWYoF5MuZZ7JSzYM7g6Yq4DhzuBot7fjKAbiemn1b
   LfHwTl6pwUgZpc4W7OTlPIp8M0HYaHlWUWhV0ANDuQ4XLLjprbLvfMv8/
   E=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 May 2022 10:29:16 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 May 2022 10:29:15 -0700
X-QCInternal: smtphost
Received: from hu-c-spathi-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.108.59])
  by ironmsg01-blr.qualcomm.com with ESMTP; 09 May 2022 22:58:59 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id 19C663D62; Mon,  9 May 2022 22:58:58 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
To:     will@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Subject: [PATCH V3] arm64: perf: Retain PMCR.X of PMCR_EL0 during reset
Date:   Mon,  9 May 2022 22:58:50 +0530
Message-Id: <1652117330-21976-1-git-send-email-quic_c_spathi@quicinc.com>
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

Preserve the bit PMCR.X of PMCR_EL0 during PMU reset to export
PMU events. as it could be set before PMU initialization.

Exporting events could result in additional power consumption
so making it configurable.

Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
---
Changes since V2:
	Done below changes as per Will's comments
	- enabling pmcr_x now configurable with kernel parameters and
	  by default it is disabled.
	
Changes since V1:
	- Preserving only PMCR_X bit as per Robin Murphy's comment.
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 arch/arm64/kernel/perf_event.c                  | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index de3da15..cf3410e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5150,6 +5150,10 @@
 			Useful for devices that are detected asynchronously
 			(e.g. USB and MMC devices).
 
+	retain_pmcr_x
+			[KNL] Retain export bit of PMCR_EL0 that is getting reset
+			during pmu reset.
+
 	retain_initrd	[RAM] Keep initrd memory after extraction
 
 	rfkill.default_state=
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1..1ac251f 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -34,6 +34,7 @@
 #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_ACCESS		0xEC
 #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED
 
+static int export_pmu_events  __read_mostly;
 /*
  * ARMv8 Architectural defined events, not all of these may
  * be supported on any given implementation. Unsupported events will
@@ -1025,6 +1026,14 @@ static int armv8pmu_filter_match(struct perf_event *event)
 	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
 }
 
+static int __init retain_pmcr_x(char *str)
+{
+	export_pmu_events = 1;
+	return 0;
+}
+
+early_param("retain_pmcr_x", retain_pmcr_x);
+
 static void armv8pmu_reset(void *info)
 {
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
@@ -1047,6 +1056,10 @@ static void armv8pmu_reset(void *info)
 	if (armv8pmu_has_long_event(cpu_pmu))
 		pmcr |= ARMV8_PMU_PMCR_LP;
 
+	/* Preserve PMCR_X to export PMU events */
+	if (export_pmu_events)
+		pmcr |= (armv8pmu_pmcr_read() & ARMV8_PMU_PMCR_X);
+
 	armv8pmu_pmcr_write(pmcr);
 }
 
-- 
2.7.4

