Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7CE4B1D85
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 05:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245331AbiBKEyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 23:54:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244047AbiBKEyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 23:54:16 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9722637;
        Thu, 10 Feb 2022 20:54:16 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21B3xgL1008090;
        Thu, 10 Feb 2022 20:54:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=cpv4j42uTKYKkvCTzUK1ZUWfKZlhr7nT+6R8BskCb7s=;
 b=IbqawX6jVmEuPXvtP9XQUKGZKyKRDaad3DlL7s9dQ+si/i+bbRYlvs/iMBp0eziFI3np
 OPnTaavwfD4Xa4jtWT6TRGk8fE2wEbyrquCOG0waLVHpbtKi4uZmuG4B4ZM46OOGKZvL
 yfF2Wz64rz49nWNe0R+w3AFtBvdEa4hCRtf8Hx79R7geDJLZjlFVuMw8dYINw1sgBGt8
 nGZncsSZ2apkUppfQwiLUr0r+L1JdVkhZD9tS7DHaevMmVn+Lz60siX+PrqixYfYRFSG
 Vlbf70rGyqdgzDMZMoQmS61iBjUgr2cpIayyAwXrhjbFcGxS2o5H24g23JirBHql7RTH 7g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3e50uccadp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 20:54:08 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Feb
 2022 20:54:06 -0800
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 10 Feb 2022 20:54:04 -0800
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbudiredla@marvell.com>, <sgoutham@marvell.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v8 4/4] perf/marvell: cn10k DDR perf event core ownership
Date:   Fri, 11 Feb 2022 10:23:46 +0530
Message-ID: <20220211045346.17894-5-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211045346.17894-1-bbhushan2@marvell.com>
References: <20220211045346.17894-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 5d0b1X_6UNDKSv14DV5klvElhgAC8-sG
X-Proofpoint-ORIG-GUID: 5d0b1X_6UNDKSv14DV5klvElhgAC8-sG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_01,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As DDR perf event counters are not per core, so they should be accessed
only by one core at a time. Select new core when previously owning core
is going offline.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Reviewed-by: Bhaskara Budiredla <bbudiredla@marvell.com>
---
v7->v8:
 - No change

 drivers/perf/Kconfig                 |  7 ++++
 drivers/perf/marvell_cn10k_ddr_pmu.c | 50 ++++++++++++++++++++++++++--
 include/linux/cpuhotplug.h           |  1 +
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index e1a0c44bc686..f3c4ac70f3b5 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -148,4 +148,11 @@ config MARVELL_CN10K_TAD_PMU
 
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
index 19c8744e1a23..7f3146e71f99 100644
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
@@ -697,12 +729,26 @@ static struct platform_driver cn10k_ddr_pmu_driver = {
 
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
index 411a428ace4d..2bc550ac8dc7 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -231,6 +231,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
 	CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
 	CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
+	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
-- 
2.17.1

