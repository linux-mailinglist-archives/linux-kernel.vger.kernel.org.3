Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96E65117EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiD0LhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiD0LhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:37:19 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF47C3C4AC;
        Wed, 27 Apr 2022 04:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7iBJE2cPfr/xnTBmGtDMcqEA3cx8pIeWUXv9FVhVyHEaBclD3wMlrS5qepsMkAQys2YU/zUBuu/TssIADCHrR0bPushpNGwQ0jdg6H48uXWbmuLC4TJEDQ3ZpA3D9ojy49+9o3jxvNok2/YOYHKzR+WObHrPUPwg45Nzo8LYW8MHP0pi4MvTdo3AR2EUVq8+BcgMuyI+dLPFqXbPfjWhnSR7V+BXqmurw5kwvpjPStpCtnqK3lEYr3kwPSzGVd4tJZEuXkAAlKDOJJq5Ftal4Q3jfUZxSyDicU4dzTJVgra5dIVvAgjlFFngzXiNsO2kVfVTUjCo4QAGgjsIg6taQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYcwpkz8Ydg9vg1C6sLvGFvJJy4EfAEpNqAfiGP6aFI=;
 b=CpVvAKD45am3JJ2U7PAZ9AWEe4C84QrBn5lpM6V0yX5sFBEJE2WolDiR8rnVyxoAcAjxPahfp5cyF2JJ9fPccvemf5izDHDXh/MAj7BhklNnHzm4jdYCREHjUlQfy60mQ3TK3iHMnqpSe0nofAE9wY2KW9EspaM+J7YQPkX9Wx2W1bB5rT4yx2Bct+uC1XqNf+B3ZLFfuF2hTqOJPnIgTmj986EF2F0OtHkiuTo2zikfSRTGOf90EbBaJQ7IiSynOkso/YHE7Cy0vaKftt2C3Ax3nztsoU/h+JWwqcpdmn6ue9Scwpfk1OMv4B3F1tHX8lJDgWFzQxYXlegtwn+mOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYcwpkz8Ydg9vg1C6sLvGFvJJy4EfAEpNqAfiGP6aFI=;
 b=UUO0iZlgiFjNNBxxabHX7Rgsa9LphvHOEIE+nhcb82B+N5kP4IZTq8Uh8u3qn3aMix0UeZaATcmAIhic9e8rvVGLoe1uuaSQeIN9+r6pAC1Ti72Dc3QhfXksOLjtrsn383KMFnDHCEmuzETWJbLxSBR2QDwnz7ifJP4d1waPX9g=
Received: from DS7PR05CA0018.namprd05.prod.outlook.com (2603:10b6:5:3b9::23)
 by BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Wed, 27 Apr
 2022 11:34:02 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::b8) by DS7PR05CA0018.outlook.office365.com
 (2603:10b6:5:3b9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Wed, 27 Apr 2022 11:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 11:34:01 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 06:33:54 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>, <puwen@hygon.cn>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 6/7] perf/x86/amd/core: Add PerfMonV2 overflow handling
Date:   Wed, 27 Apr 2022 17:01:48 +0530
Message-ID: <6bb3a6de79afbdb1ebc1b804fb8c2002c00cbaee.1651058600.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651058600.git.sandipan.das@amd.com>
References: <cover.1651058600.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76a32067-0a5e-46f7-9d4c-08da2841d3da
X-MS-TrafficTypeDiagnostic: BY5PR12MB4936:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4936F25B8A620C788917BC7E8BFA9@BY5PR12MB4936.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uq+efyALpJfEZHLiADlNDvZJHnxcrraSAxoKzyfTRa7igVPZ0TUgFw09keslD8wHbBD6+aJMEKLQUwLiGqYQNrEb7f5bWYIPnb70bTBYuV3Pch/HEGrLvTmkNYqdOh1yFFecQB1aPphk9FDt31+tlXUCioiDmqvqBYlZZRvtxKxcxuQbz6jxDPdglpzy93+B3sbROhu1q610sKJIF3LfpCpPEVuXoYZ6FPryzJjZjSsS90plEPnPywYORqGZ4s8nr3yJVAMZMOoM5j8qk8ooLc6+n5/1Kmgg10qkn72kc3U3LrzPO8DSmdmSvtMseIigcNpoVDjPIs3mi2ywN2f8Dmzq03ybCmOjEE1mjJKeZlnSwMVSgxxfu6utYorrcQGOJCWnBXXb3XRLW4hhqGoDWzeyp2UtwgUs6p7ZtCn2+tSAoXOWCNzFHz8RmolvTRn5ihCFWUj4scz10O/AaxEuAtiGGE7o3iCvGBczljDl96mAIjiGzI/+QZtWdgOE1ihzJ4MAA87jckmeOI1ZSVJ42ivV/0dUsCKlbtaQBLbfriUoh5H6Y+dZ1pWdcJcAnPovY5Vj7Mv04ZbN6TAN807cfq1msriWacrWILUEGHIaLmeRFG/HpK0FdTkfUPWUf2AGupJf8Qo70L7Nq35XM2/Hc9ktGTBt3NettWOQMLXEdK+vWX57EufyoD72If3LdUf2wCsYip/hF+dNUpMfQgbbsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(186003)(316002)(426003)(356005)(82310400005)(7416002)(40460700003)(336012)(83380400001)(54906003)(36860700001)(8936002)(110136005)(47076005)(16526019)(5660300002)(44832011)(70586007)(70206006)(81166007)(508600001)(86362001)(2906002)(4326008)(26005)(6666004)(8676002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 11:34:01.7714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a32067-0a5e-46f7-9d4c-08da2841d3da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
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
index 5b100a5f8489..5de2c833acf2 100644
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
2.34.1

