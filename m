Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D3E50FE52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350591AbiDZNLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbiDZNLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:11:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2834E3DDCD;
        Tue, 26 Apr 2022 06:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0XtRrQ2ctir239gixwtVdCtCDTvNQlZO3iEKCcREQWA9p2t5d8KNAE3WAgadiNy5/nP0HanEiOwPasrTctkDHrfTWo2D/+1B6dA072yp81bqtU6J2OlwTFOo4RohTT5bJfkeh9vuVwn8SLJ8YrSFhUHh1LU/JgsEu27pkHrhuE343FJneKwwlBoobZqDB5ZB63Q4KJkj1tUpWtqO8keaKzBWUoBGtisIN29IbKfAJkZCGxGnICuUIzMDU5YLzhMaEqchQiQJcgvIyxS55gR7OiBCQgJ4gLx4wGfeKvedjJaJjBXuRsC23GQOUy4mklnizXFwuBbSZuI8RmPQAWdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYcwpkz8Ydg9vg1C6sLvGFvJJy4EfAEpNqAfiGP6aFI=;
 b=JGtO6fCiZ/N/gr9oA3jW8Vl3hETkTBkUIXIYn5E92QPDCfkkM4aVI1WSspdnBk2iIvGC8Zi+dNRdzGV5ivZe3XSwQDiiAIkLnDxo96Ey9OIc4mgrY7AQ+MVh44VOcp2rEO3L/pV3omfw4dmHXGE5yGp9xluMOXPPHgy+RU/BGs35cG6IPLvTAF8f7olKuXMofkkP+nYgH1rtz808/a5z4p0HmELi+IGMElEtZQ8dpQwDqg2pgVN9aQrq1vjUXsK5+Mn4QAk6Be+r9hSwShEF8Nw7LI1mQJ3E3GVGIFe9EnzGg8tMf7XoWdfrxqme18NRv9DjJDsK1BRqJWRhv37IDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYcwpkz8Ydg9vg1C6sLvGFvJJy4EfAEpNqAfiGP6aFI=;
 b=SSUij6JnmqCu2fdiAytFxNG46HgxBNDLAJHCcZvGedVno5UcTXVm85hVji9MLF+aORrZpggIG8Z01E+yyf1h9MJc6wPXAAHrk4I4NDSMpdmkeHUL227u7taO/3YzFPwO2a0p3TcSjV/eMClk11iGtxBZEvn076PKyBCjPMftK7A=
Received: from MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::10)
 by BN8PR12MB3250.namprd12.prod.outlook.com (2603:10b6:408:99::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 13:07:50 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::9) by MW4P221CA0005.outlook.office365.com
 (2603:10b6:303:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 13:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 13:07:50 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 08:07:43 -0500
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
Subject: [PATCH v3 6/7] perf/x86/amd/core: Add PerfMonV2 overflow handling
Date:   Tue, 26 Apr 2022 18:35:37 +0530
Message-ID: <6bb3a6de79afbdb1ebc1b804fb8c2002c00cbaee.1650977962.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650977962.git.sandipan.das@amd.com>
References: <cover.1650977962.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ff46225-ead1-4996-1ba2-08da2785c465
X-MS-TrafficTypeDiagnostic: BN8PR12MB3250:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB325035BEC7386825CCB6EAC68BFB9@BN8PR12MB3250.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QosrpBlRTxujnrK4EXle2AyMhPenvHzTkwSWUNDWo01n5T/IeYtWvH+WIX6aSgwTIjPiaA97doCCEmVSie+9SifSRFZ7rXmWTNMCb88hry8sM4a0SYizBaNPTax7BeBwllsg71PEGHlEVwUhmZavZX7+MQU0K90hdaaJHp0rzRSf/lbcnWbZww7ILs95xIRACAQJL2im/ZRDPQXz3NzDhX96+TghRhsy61L5j0Lf7bZ83Hs5YpDfWxsSAWA88ZRNqfbxOwydk7+RPto7FZ3cAHAqQ76KP5Nkb0tD+dYewcKT5EKH6N+sdREJIdjyE1SiJwWCOhVmLwLcb6vF1yo99JEj0tBWVlUHORlvR7+8C9cb6/FZKDAbCsbJ5SYCDdCWQcZWyrM7CZ7Fwu0d9hs6BQTM57LKPTX0Y0bO0URk3JKExsV6hK98qh6oNQFgor3+Sq8RTGD2TVjFdV6A7dMNctjp5Eoj9/xq7ao2bG5gytu+po8kDmKA733kP9ccbhxmpVnOaok7Dn0E66nMAO7ZrrkR8BXK+3Jidxb5peR7d6zp3LUDAkbDSCDwQXuR16jsUhidgxcytl/kzD5xcCaCQ3EsPgspjhto7WOGmL1zB9XwiSNAsygB2arK1maPC1ya806Twfllz4jxj6ruf3Ymv4n0ERlRlOTA3jv4Nr+L4Q5071ynRdwI9ERACCGZ/ltuIm7OLZPrGjg5Rf8QDXJHUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(4326008)(70206006)(70586007)(36860700001)(5660300002)(26005)(47076005)(426003)(508600001)(336012)(316002)(8676002)(6666004)(2616005)(16526019)(186003)(36756003)(44832011)(40460700003)(110136005)(54906003)(86362001)(2906002)(82310400005)(81166007)(8936002)(7416002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 13:07:50.3409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff46225-ead1-4996-1ba2-08da2785c465
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3250
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

