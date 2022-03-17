Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ECE4DBF90
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiCQGcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiCQGcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:32:04 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8938F9F3BA;
        Wed, 16 Mar 2022 23:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JF8y3h3WaB/IBNSGY8lEx5hveIOqNxr/XWZM0cBwo0TCG9jS82UybKADlFH+IWtP4lmahw/zkroPS4g/xkAp9pcXDcqdf9wqnTJhGIUZIzOB2cndLjmVJxy16WvkXvJK1q99t8bOsOlFXsw+/KNWi+OqgkWTnVBRhkACKMNX0hT27YFpbBOJuIo57N80+v5o7uVSPS9RH5R2SrFmbwaBoE5b8HU7A2kXS7UsRKR5RliiWMfvODgW1bDVM8lkXZ091VMiyjCTXAI3rQKiMNX8CWihY+p0duErOr4cr2NV8mCCbboXpShAR9dntmAQcFOVkv5b4Xwg4yUirGWGLPgb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChraegVOseBu9qXb4vm1ovNPgh6iYko3O8om7bkDq3Q=;
 b=j+DeAO3noS+tM5iSzc+8wj2ZxGA0xHtNTW+WMW9h/G1jS9mJK1OV1PqbS+nT4Q42PYeXT2u2noAXGrfTXqHO2pC0uTKmuvZ1WYEj6aaO8LSXT+vaUimnsZiqdxtUEvluqwQbkBCN9z1k4FCG5d0+ZqVaakJ8Bes8MAUkrwU+Bc5QMSSFsRCXXPtorB1+5KIEccriolk1Y7eF37LKvDivaOHW7LW68hWCCxyttUp8652YJaxAUm1UFv5gBsiD81PTpIKgPo0AjXTJbBVmoV1Q3cxHmWG2kugWLBT8KhwkTaZYbCBDTGCCREQfJmHO5M/usTQGILbixQT29aa9aHmUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChraegVOseBu9qXb4vm1ovNPgh6iYko3O8om7bkDq3Q=;
 b=u95JDEDaw4jha9egXlNcRC9w6WfQMeSkYqbY1mIrOqjaQs9C3ZWiIAYO/GT1RCm7k1CDn3fZVuDCIG5Xe5VjOpQiZq0Dee5vavPv+lZYeKXBHX34sEl6ukZVyf5gZ4gc/f21bTm/4JdI5LcbNNEvBBW7Tjn5q+Ex8nwstEA3G9A=
Received: from DM6PR01CA0008.prod.exchangelabs.com (2603:10b6:5:296::13) by
 CY4PR12MB1464.namprd12.prod.outlook.com (2603:10b6:910:d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.25; Thu, 17 Mar 2022 06:30:44 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::b3) by DM6PR01CA0008.outlook.office365.com
 (2603:10b6:5:296::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Thu, 17 Mar 2022 06:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 06:30:44 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 01:30:38 -0500
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
Subject: [PATCH 6/7] perf/x86/amd/core: Add PerfMonV2 overflow handling
Date:   Thu, 17 Mar 2022 11:58:35 +0530
Message-ID: <7d43b4ba8a7c3c0833495f3fabfcfc6df8db3732.1647498015.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1647498015.git.sandipan.das@amd.com>
References: <cover.1647498015.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08000805-ebfa-43ab-7a31-08da07dfaa66
X-MS-TrafficTypeDiagnostic: CY4PR12MB1464:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1464FC2A148AB35FAEDD37DC8B129@CY4PR12MB1464.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cePuP8xUAXhZYw6vkzwJSp+oNk2WEAz7TDQ2dUzbOzBI/Z4f3byA7GHoEIiU0fOplgTMZfcMEan9nw43wP2aG9K96l1c3omLnSTgwK36oWj/uJ1jMoJcn+XwuHEwM6p6N4VaGK4zyeyOi0tA0pt9zUHGzI4JwFZgJrtu4rQ2B5JdVg9IpXkpybOboMqggyU5szXKipKcCMQKHDQZUpTB/CghB2JKjmso8Vc7X8cRZPp7i+Bl3sGZ8j7JJgT7fqlBAQnlJa2CJbj4FE3D0fk42MQJQkto6RasPbVTZa/rsp2vnP4O5S+6SEO07qFnu0aUSVFvTyDUztG9CyH7UUcq0wZJAUQSvNjDH4Ph3Z/ah3hQM3GNE5MQqRLccXvjYhJOaODP6AUhqnV8CnF+dGFtRHy2RAMwZzbIqc6t1MgG2F3tm3YCDDfQHi/2HVHEr4Sj5Ej1ULD/LmpT3n1BNmSN64B0C7obesNpM92swGOAeGarVlQ8jvcvMUXAtCX7Eio9eG8xVkj6UrsAcZf/ZrBimjg2AFI9pMf9Q+tEnpHsCmZ6Q4mM9rawXlNYTkaqLt9JcT2PzJ61OY6VZjmfpYRlh83BgZcZQuiBYf+OyrWvmDX9Sa9S9RBo9hg9e2CMiiefi70XxJ4s6gQ0To6TAIm8PTTe9/QMAXX1gSq8QSy8GBWhc7cBbqbncJhty6HaLul9Qwtb/smZuQBLba7GzLJILQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(36860700001)(40460700003)(36756003)(316002)(4326008)(70206006)(8676002)(5660300002)(70586007)(54906003)(110136005)(7416002)(8936002)(83380400001)(82310400004)(426003)(336012)(6666004)(356005)(81166007)(186003)(26005)(16526019)(47076005)(508600001)(86362001)(2906002)(7696005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 06:30:44.3197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08000805-ebfa-43ab-7a31-08da07dfaa66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1464
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/events/amd/core.c | 125 +++++++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 532e9bd76bf1..fbbba981d0bd 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/jiffies.h>
 #include <asm/apicdef.h>
+#include <asm/apic.h>
 #include <asm/nmi.h>
 
 #include "../perf_event.h"
@@ -601,6 +602,45 @@ static inline void amd_pmu_set_global_ctl(u64 ctl)
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
 }
 
+static inline u64 amd_pmu_get_global_overflow(void)
+{
+	u64 status;
+
+	/* PerfCntrGlobalStatus is read-only */
+	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, status);
+
+	return status & amd_pmu_global_cntr_mask;
+}
+
+static inline void amd_pmu_ack_global_overflow(u64 status)
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
+static bool amd_pmu_legacy_has_overflow(int idx)
+{
+	u64 counter;
+
+	rdmsrl(x86_pmu_event_addr(idx), counter);
+
+	return !(counter & BIT_ULL(x86_pmu.cntval_bits - 1));
+}
+
+static bool amd_pmu_global_has_overflow(int idx)
+{
+	return amd_pmu_get_global_overflow() & BIT_ULL(idx);
+}
+
+DEFINE_STATIC_CALL(amd_pmu_has_overflow, amd_pmu_legacy_has_overflow);
+
 /*
  * When a PMC counter overflows, an NMI is used to process the event and
  * reset the counter. NMI latency can result in the counter being updated
@@ -613,7 +653,6 @@ static inline void amd_pmu_set_global_ctl(u64 ctl)
 static void amd_pmu_wait_on_overflow(int idx)
 {
 	unsigned int i;
-	u64 counter;
 
 	/*
 	 * Wait for the counter to be reset if it has overflowed. This loop
@@ -621,8 +660,7 @@ static void amd_pmu_wait_on_overflow(int idx)
 	 * forever...
 	 */
 	for (i = 0; i < OVERFLOW_WAIT_COUNT; i++) {
-		rdmsrl(x86_pmu_event_addr(idx), counter);
-		if (counter & (1ULL << (x86_pmu.cntval_bits - 1)))
+		if (!static_call(amd_pmu_has_overflow)(idx))
 			break;
 
 		/* Might be in IRQ context, so can't sleep */
@@ -718,6 +756,83 @@ static void amd_pmu_enable_event(struct perf_event *event)
 	static_call(amd_pmu_enable_event)(event);
 }
 
+static int amd_pmu_global_handle_irq(struct pt_regs *regs)
+{
+	struct perf_sample_data data;
+	struct cpu_hw_events *cpuc;
+	struct hw_perf_event *hwc;
+	struct perf_event *event;
+	u64 val, status, mask;
+	int handled = 0, idx;
+
+	status = amd_pmu_get_global_overflow();
+
+	/* Check if any overflows are pending */
+	if (!status)
+		return 0;
+
+	/* Stop counting */
+	amd_pmu_global_disable_all();
+
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	/*
+	 * Some chipsets need to unmask the LVTPC in a particular spot
+	 * inside the nmi handler.  As a result, the unmasking was
+	 * pushed into all the nmi handlers.
+	 *
+	 * This generic handler doesn't seem to have any issues where
+	 * the unmasking occurs so it was left at the top.
+	 *
+	 * N.B. Taken from x86_pmu_handle_irq()
+	 */
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+
+	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+		if (!test_bit(idx, cpuc->active_mask))
+			continue;
+
+		event = cpuc->events[idx];
+		hwc = &event->hw;
+		val = x86_perf_event_update(event);
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
+	}
+
+	/*
+	 * It should never be the case that some overflows are not handled as
+	 * the corresponding PMCs are expected to be inactive according to the
+	 * active_mask
+	 */
+	WARN_ON(status > 0);
+
+	/* Clear overflow bits */
+	amd_pmu_ack_global_overflow(~status);
+
+	inc_irq_stat(apic_perf_irqs);
+
+	/* Resume counting */
+	amd_pmu_global_enable_all(0);
+
+	return handled;
+}
+
+DEFINE_STATIC_CALL(amd_pmu_handle_irq, x86_pmu_handle_irq);
+
 /*
  * Because of NMI latency, if multiple PMC counters are active or other sources
  * of NMIs are received, the perf NMI handler can handle one or more overflowed
@@ -741,7 +856,7 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 	int handled;
 
 	/* Process any counter overflows */
-	handled = x86_pmu_handle_irq(regs);
+	handled = static_call(amd_pmu_handle_irq)(regs);
 
 	/*
 	 * If a counter was handled, record a timestamp such that un-handled
@@ -1041,6 +1156,8 @@ static int __init amd_core_pmu_init(void)
 		static_call_update(amd_pmu_enable_all, amd_pmu_global_enable_all);
 		static_call_update(amd_pmu_disable_all, amd_pmu_global_disable_all);
 		static_call_update(amd_pmu_enable_event, amd_pmu_global_enable_event);
+		static_call_update(amd_pmu_has_overflow, amd_pmu_global_has_overflow);
+		static_call_update(amd_pmu_handle_irq, amd_pmu_global_handle_irq);
 	}
 
 	/*
-- 
2.32.0

