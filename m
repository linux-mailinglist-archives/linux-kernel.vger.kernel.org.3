Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBEC509701
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384585AbiDUFwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384591AbiDUFwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:52:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB87312AC8;
        Wed, 20 Apr 2022 22:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1qqAsvaNRk8yZ00hrVyYsuZHTdY7HR8TmdhitUeReVEkO3aiTWUZVVH2cyan6kb4R40bRwGbf2eC565bql7eBX8ifN3cB7t91lvGfvahDBypUKxngVGAf8A0dihc5zXBNmFmWclmuwYPWY+dJJ3K0/rtnboEkj0iJzJY3NZj512eyy6Hq3ZKUMDVv37GmhZKV1zYU8rbJfebrpS/xPDrx/pLPlOLv3BoQNrKvmJF8LsqVdeafqOTpBuD0pvbKp+z37JEXbdjuxeRGaTnKeniyWPE/83iYi6EaHiDzyiOFb9i9AUQr8k3/0/0uBH8oCBTntC6UdzsiOsVQPnuzEQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHOBURdxTYilIOFJpBsY7AQNn6MlMdr1IgdeWCbTm50=;
 b=nJD31ipJX7iZAXBruEPsxq78gG/OsYpO4nevtayjBQlnGqTAegcj92TCsd3k/r7t/1sdRQH+YxbmVogXmC/mhfh4atRozFsappL9KQFILJPLa+LrGTSGx3VpYAIYElCqrwv20Vj5FargW2hh1e1bghGgFfi3CbyCrhejUtssfouS8dZFmlK+bWl40nBEc9bBnJ7hr8t4OjZYNNmGDhwLS1SI0N+zW2pUBvh5qjSfTkf6/Rm92bKB8Iv3tBra44MNw2zvs5erBMretmFDkJ8YiIKovMkAZCpTdNfEfaadgJm3H3lHjPEzghMDPs7J7fy0hybq1/1WjC8xZ19O99oSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHOBURdxTYilIOFJpBsY7AQNn6MlMdr1IgdeWCbTm50=;
 b=tVLVuH0q5aXdq59w//nIvLZwwOynl/nahd5mKq9A/kv+40I9yERHTMef+eJSUiqg2zx1J90PlwokBccHUxjuUeylNZXqEE2DuJ4aEXgvLVUzqtRopiuR36yUs93efxI6SfUFAdDUJsdnPCEhbVuRq1CcYllp+kLNCPyOQ0y4FQM=
Received: from DM6PR06CA0031.namprd06.prod.outlook.com (2603:10b6:5:120::44)
 by CH0PR12MB5201.namprd12.prod.outlook.com (2603:10b6:610:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 05:49:18 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::96) by DM6PR06CA0031.outlook.office365.com
 (2603:10b6:5:120::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 21 Apr 2022 05:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 05:49:17 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 00:49:01 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 6/7] perf/x86/amd/core: Add PerfMonV2 overflow handling
Date:   Thu, 21 Apr 2022 11:16:58 +0530
Message-ID: <f20b7e4da0b0a83bdbe05857f354146623bc63ab.1650515382.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1650515382.git.sandipan.das@amd.com>
References: <cover.1650515382.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6afbd837-64de-48d1-2f42-08da235aac8f
X-MS-TrafficTypeDiagnostic: CH0PR12MB5201:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB520134C4EB9749E8B568A88E8BF49@CH0PR12MB5201.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0FV5AXjvcY1BIV3sB7yA1gUVUnReHyMa9dRHBGwHcghXsMNlubYz4BwEI+DKwX0tJzU9n9TqaHuStb0BOUjO0slF09b7s0sMe0TzD0gmE7zaDyyXlWlk3yYVCaiwCDQJVt24ZB2jAIwLhvImA9xhTQV/zpfNQiDT1PLKzZAhLNKlAgn+7Z7bMCd96VtrwzXODTF69Hk9SNr0SYmpvRmCpZUzNxKerafVwUU7JdrPUj6M7QDOKIjkI/IbmFRLukDnpR7emNkQbnOMaL851L+BCmJt9bPSZ5PDlE6SotG4YaH8C/nhSlK2++Tx4XZ4LdyHUtDM0ZVTO9dqyXVc1dBIdx4nK0fZp4NpElIeFVqkQh9au+KQnwItbL9bDDEnE+iprxpH0iAokDUkyjjA1NGz2ahqH69A63g5Ra1rOLsoa3BhjOnvNSf1bAOBUX6zLtAfgsAz4gEBhKpvOprvikQNTBKl23fL34K4yh9uP+pCEwxUIY78+xxJ/1fVb2cTeLAR1aYgdrzq2BzJFKqzj1mIeFLJrEAa/2YBP65goyvEPHJ2xd7Ml7Onmk4TcjPdnrLNHMLsuucEk581fyn1yNizAb8V8K9+2mWQKoNaKEKoaPuPjLj1auhssSkJF6stDcl/CJnODV9SaS8COZi/MAzL85KfCWl26Fn9Mgx1hh7v8Rzu2seRH+VDs9vVug+tFxG0RJ+7vtVDDGNi1vE7uvtKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(54906003)(316002)(26005)(4326008)(40460700003)(508600001)(5660300002)(7416002)(44832011)(8676002)(8936002)(36756003)(82310400005)(110136005)(2906002)(426003)(2616005)(16526019)(336012)(86362001)(186003)(36860700001)(83380400001)(81166007)(47076005)(356005)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 05:49:17.4346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afbd837-64de-48d1-2f42-08da235aac8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If AMD Performance Monitoring Version 2 (PerfMonV2) is
supported, use a new scheme to process Core PMC overflows
in the NMI handler using the new global control and status
registers. This will be bypassed on unsupported hardware
(x86_pmu.version < 2).

In x86_pmu_handle_irq(), overflows are detected by testing
the contents of the PERF_CTR register for each active PMC in
a loop. The new scheme instead inspects the overflow bits of
the global status register.

The Performance Counter Global Status (PerfCntrGlobalStatus)
register has overflow (PerfCntrOvfl) bits for each PMC. This
is, however, a read-only MSR. To acknowledge that overflows
have been processed, the NMI handler must clear the bits by
writing to the PerfCntrGlobalStatusClr register.

In x86_pmu_handle_irq(), PMCs counting the same event that
are started and stopped at the same time record slightly
different counts due to delays in between reads from the
PERF_CTR registers. This is fixed by stopping and starting
the PMCs at the same before and with a single write to the
Performance Counter Global Control (PerfCntrGlobalCtl) upon
entering and before exiting the NMI handler.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 144 ++++++++++++++++++++++++++++++++++---
 1 file changed, 133 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index a339c3e0be33..262e39a85031 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/jiffies.h>
 #include <asm/apicdef.h>
+#include <asm/apic.h>
 #include <asm/nmi.h>
 
 #include "../perf_event.h"
@@ -669,6 +670,45 @@ static inline void amd_pmu_set_global_ctl(u64 ctl)
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
 }
 
+static inline u64 amd_pmu_get_global_status(void)
+{
+	u64 status;
+
+	/* PerfCntrGlobalStatus is read-only */
+	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, status);
+
+	return status & amd_pmu_global_cntr_mask;
+}
+
+static inline void amd_pmu_ack_global_status(u64 status)
+{
+	/*
+	 * PerfCntrGlobalStatus is read-only but an overflow acknowledgment
+	 * mechanism exists; writing 1 to a bit in PerfCntrGlobalStatusClr
+	 * clears the same bit in PerfCntrGlobalStatus
+	 */
+
+	/* Only allow modifications to PerfCntrGlobalStatus.PerfCntrOvfl */
+	status &= amd_pmu_global_cntr_mask;
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, status);
+}
+
+static bool amd_pmu_test_overflow_topbit(int idx)
+{
+	u64 counter;
+
+	rdmsrl(x86_pmu_event_addr(idx), counter);
+
+	return !(counter & BIT_ULL(x86_pmu.cntval_bits - 1));
+}
+
+static bool amd_pmu_test_overflow_status(int idx)
+{
+	return amd_pmu_get_global_status() & BIT_ULL(idx);
+}
+
+DEFINE_STATIC_CALL(amd_pmu_test_overflow, amd_pmu_test_overflow_topbit);
+
 /*
  * When a PMC counter overflows, an NMI is used to process the event and
  * reset the counter. NMI latency can result in the counter being updated
@@ -681,7 +721,6 @@ static inline void amd_pmu_set_global_ctl(u64 ctl)
 static void amd_pmu_wait_on_overflow(int idx)
 {
 	unsigned int i;
-	u64 counter;
 
 	/*
 	 * Wait for the counter to be reset if it has overflowed. This loop
@@ -689,8 +728,7 @@ static void amd_pmu_wait_on_overflow(int idx)
 	 * forever...
 	 */
 	for (i = 0; i < OVERFLOW_WAIT_COUNT; i++) {
-		rdmsrl(x86_pmu_event_addr(idx), counter);
-		if (counter & (1ULL << (x86_pmu.cntval_bits - 1)))
+		if (!static_call(amd_pmu_test_overflow)(idx))
 			break;
 
 		/* Might be in IRQ context, so can't sleep */
@@ -830,6 +868,24 @@ static void amd_pmu_del_event(struct perf_event *event)
  * handled a counter. When an un-handled NMI is received, it will be claimed
  * only if arriving within that window.
  */
+static inline int amd_pmu_adjust_nmi_window(int handled)
+{
+	/*
+	 * If a counter was handled, record a timestamp such that un-handled
+	 * NMIs will be claimed if arriving within that window.
+	 */
+	if (handled) {
+		this_cpu_write(perf_nmi_tstamp, jiffies + perf_nmi_window);
+
+		return handled;
+	}
+
+	if (time_after(jiffies, this_cpu_read(perf_nmi_tstamp)))
+		return NMI_DONE;
+
+	return NMI_HANDLED;
+}
+
 static int amd_pmu_handle_irq(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -857,20 +913,84 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 	if (pmu_enabled)
 		amd_pmu_enable_all(0);
 
+	return amd_pmu_adjust_nmi_window(handled);
+}
+
+static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_sample_data data;
+	struct hw_perf_event *hwc;
+	struct perf_event *event;
+	int handled = 0, idx;
+	u64 status, mask;
+	bool pmu_enabled;
+
 	/*
-	 * If a counter was handled, record a timestamp such that un-handled
-	 * NMIs will be claimed if arriving within that window.
+	 * Save the PMU state as it needs to be restored when leaving the
+	 * handler
 	 */
-	if (handled) {
-		this_cpu_write(perf_nmi_tstamp, jiffies + perf_nmi_window);
+	pmu_enabled = cpuc->enabled;
+	cpuc->enabled = 0;
 
-		return handled;
+	/* Stop counting */
+	amd_pmu_v2_disable_all();
+
+	status = amd_pmu_get_global_status();
+
+	/* Check if any overflows are pending */
+	if (!status)
+		goto done;
+
+	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+		if (!test_bit(idx, cpuc->active_mask))
+			continue;
+
+		event = cpuc->events[idx];
+		hwc = &event->hw;
+		x86_perf_event_update(event);
+		mask = BIT_ULL(idx);
+
+		if (!(status & mask))
+			continue;
+
+		/* Event overflow */
+		handled++;
+		perf_sample_data_init(&data, 0, hwc->last_period);
+
+		if (!x86_perf_event_set_period(event))
+			continue;
+
+		if (perf_event_overflow(event, &data, regs))
+			x86_pmu_stop(event, 0);
+
+		status &= ~mask;
 	}
 
-	if (time_after(jiffies, this_cpu_read(perf_nmi_tstamp)))
-		return NMI_DONE;
+	/*
+	 * It should never be the case that some overflows are not handled as
+	 * the corresponding PMCs are expected to be inactive according to the
+	 * active_mask
+	 */
+	WARN_ON(status > 0);
 
-	return NMI_HANDLED;
+	/* Clear overflow bits */
+	amd_pmu_ack_global_status(~status);
+
+	/*
+	 * Unmasking the LVTPC is not required as the Mask (M) bit of the LVT
+	 * PMI entry is not set by the local APIC when a PMC overflow occurs
+	 */
+	inc_irq_stat(apic_perf_irqs);
+
+done:
+	cpuc->enabled = pmu_enabled;
+
+	/* Resume counting only if PMU is active */
+	if (pmu_enabled)
+		amd_pmu_v2_enable_all(0);
+
+	return amd_pmu_adjust_nmi_window(handled);
 }
 
 static struct event_constraint *
@@ -1256,6 +1376,8 @@ static int __init amd_core_pmu_init(void)
 		x86_pmu.enable_all = amd_pmu_v2_enable_all;
 		x86_pmu.disable_all = amd_pmu_v2_disable_all;
 		x86_pmu.enable = amd_pmu_v2_enable_event;
+		x86_pmu.handle_irq = amd_pmu_v2_handle_irq;
+		static_call_update(amd_pmu_test_overflow, amd_pmu_test_overflow_status);
 	}
 
 	/*
-- 
2.32.0

