Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1574748A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhLNQ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:57:04 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:64164 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236184AbhLNQ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:56:47 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BEAJNb0019136;
        Tue, 14 Dec 2021 08:56:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=KVPT9YuQHVKIVVFbgfzciMdndK+q6IgzJf8ey6H0cgE=;
 b=X2jrWQQMh+KJu3WQn21MrLEbmFeFXGii+UCBWAvsmr+cNs1zArHcjjYQtCbV4ftgys1L
 dz4IIA7zhiXShwcEr5Ew+NgP7IOFkb+6hPo/Y+zBKaNWCBFhuPoxHFHaW6AYUKH2Mb3v
 hGgzSUcivF12U0lPX9TUfXZE8E90BDz7Y2llrK5pGHxbn1axKHRCQBj9cCKfWx3F352u
 icTPYEXbz9R5aKvdBFJKw0Bwpk+OqkSFhmdocIARC8hnYPMEKAUTDgE6IMeyg0Ct5pt2
 dHX2/N0oVytD0IGmykCplrYSEwEcOiH5alIJ94abg1Zw6gq5OE4toIBW+SPJV8G/Hbzy PQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3cxsds1mfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 08:56:39 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 14 Dec
 2021 08:56:37 -0800
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Dec 2021 08:56:35 -0800
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbudiredla@marvell.com>, <sgoutham@marvell.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v7 4/4] perf/marvell: cn10k DDR perf event core ownership
Date:   Tue, 14 Dec 2021 22:26:13 +0530
Message-ID: <20211214165613.26479-5-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214165613.26479-1-bbhushan2@marvell.com>
References: <20211214165613.26479-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: Y67Zfnlk-Lb6lZvCpdcG4dn6pPU2dMDg
X-Proofpoint-ORIG-GUID: Y67Zfnlk-Lb6lZvCpdcG4dn6pPU2dMDg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As DDR perf event counters are not per core, so they should be accessed
only by one core at a time. Select new core when previously owning core
is going offline.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Reviewed-by: Bhaskara Budiredla <bbudiredla@marvell.com>
---
v6->v7:
 - Moved MARVELL_CN10K_DDR_PMU here as driver is ready to use

v1->v6
 - No Change

 drivers/perf/Kconfig                 |  7 ++++
 drivers/perf/marvell_cn10k_ddr_pmu.c | 50 ++++++++++++++++++++++++++--
 include/linux/cpuhotplug.h           |  1 +
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 4374af292e6d..c99dec8e45f1 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -141,4 +141,11 @@ config ARM_DMC620_PMU
 
 source "drivers/perf/hisilicon/Kconfig"
 
+config MARVELL_CN10K_DDR_PMU
+	tristate "Enable MARVELL CN10K DRAM Subsystem(DSS) PMU Support"
+	depends on ARM64 || (COMPILE_TEST && 64BIT)
+	help
+	  Enable perf support for Marvell DDR Performance monitoring
+	  event on CN10K platform.
+
 endmenu
diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 21fccb9090c5..bef0cee3a46a 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -129,6 +129,7 @@ struct cn10k_ddr_pmu {
 	int active_events;
 	struct perf_event *events[DDRC_PERF_NUM_COUNTERS];
 	struct hrtimer hrtimer;
+	struct hlist_node node;
 };
 
 #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
@@ -610,6 +611,24 @@ static enum hrtimer_restart cn10k_ddr_pmu_timer_handler(struct hrtimer *hrtimer)
 	return HRTIMER_RESTART;
 }
 
+static int cn10k_ddr_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct cn10k_ddr_pmu *pmu = hlist_entry_safe(node, struct cn10k_ddr_pmu,
+						     node);
+	unsigned int target;
+
+	if (cpu != pmu->cpu)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
+	pmu->cpu = target;
+	return 0;
+}
+
 static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 {
 	struct cn10k_ddr_pmu *ddr_pmu;
@@ -661,18 +680,31 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	hrtimer_init(&ddr_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ddr_pmu->hrtimer.function = cn10k_ddr_pmu_timer_handler;
 
+	cpuhp_state_add_instance_nocalls(
+				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
+				&ddr_pmu->node);
+
 	ret = perf_pmu_register(&ddr_pmu->pmu, name, -1);
 	if (ret)
-		return ret;
+		goto error;
 
 	pr_info("CN10K DDR PMU Driver for ddrc@%llx\n", res->start);
 	return 0;
+error:
+	cpuhp_state_remove_instance_nocalls(
+				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
+				&ddr_pmu->node);
+	return ret;
 }
 
 static int cn10k_ddr_perf_remove(struct platform_device *pdev)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = platform_get_drvdata(pdev);
 
+	cpuhp_state_remove_instance_nocalls(
+				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
+				&ddr_pmu->node);
+
 	perf_pmu_unregister(&ddr_pmu->pmu);
 	return 0;
 }
@@ -695,12 +727,26 @@ static struct platform_driver cn10k_ddr_pmu_driver = {
 
 static int __init cn10k_ddr_pmu_init(void)
 {
-	return platform_driver_register(&cn10k_ddr_pmu_driver);
+	int ret;
+
+	ret = cpuhp_setup_state_multi(
+				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
+				"perf/marvell/cn10k/ddr:online", NULL,
+				cn10k_ddr_pmu_offline_cpu);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&cn10k_ddr_pmu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(
+				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE);
+	return ret;
 }
 
 static void __exit cn10k_ddr_pmu_exit(void)
 {
 	platform_driver_unregister(&cn10k_ddr_pmu_driver);
+	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE);
 }
 
 module_init(cn10k_ddr_pmu_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 773c83730906..2e7db18e2971 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -230,6 +230,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
 	CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
 	CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
+	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
-- 
2.17.1

