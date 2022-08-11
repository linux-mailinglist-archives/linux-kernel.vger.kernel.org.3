Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770A258FC62
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiHKMet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiHKMer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:34:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A7313EA2;
        Thu, 11 Aug 2022 05:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oifu4e4yTYZ4H9X6b81kXeLj9tR7veYEJlv9AW0KIimK15Tqm/CDELYeS8k7aggdRoTghxV1Oom9jMzfsAGcyFPgFEzGIl5pJ6oi9PllwBb1uOe8BuhiS28A+rxHT/BqVSOFehM6tEfXLqWkfYfb5vPetSnKtFNnMHH96WsgnWE9005ZYLI+v1yMXHDEdRgBq3m2KY6CwERr3K5YnqfuQT6rJcg4Ii6oR7j6WyIPKOmu76INRHg2/WudVtmsjldpn7AbzUC1hKYT5QrnsOFdEYViTnrdvx4+eoqFxbF3F06eDLCbfEs0itJc1NULnnDoFEkjhouYQHmFAbpFKxDywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2nG0q17xE51uFBZ/DKe+LXh7BN3wXbQk5XH6Qe1Hpg=;
 b=eN3n9MauDVRu4MXIsbOhE35fLYEOoFQuV9uxMveo0b3sxS5pt3iBwRBHabbiAtKlcOvcAku3qji0H1SioolxIK97E2/Jr5v3ln5VErZytcHry8C9dfpu43zhgMMJm9aboYX2H2qV4fTG07VaMD/HZqDTFs7qXO73OsSz6Ul17M0SFF92wfZNWfkKUZPQj0UWYfN9ehU8RxjbdEvbIot47z2JlbQE03ogj3FrFabG6SBPVJgY+5vg0Chh9UyX7rHUyDlEj/b5uZn9sPEuQY6xtXypOsfzJ5PHELdtjiRqJr6fyP0QEt9t19/TSGle6ra+TbRHEh48yPRuNW3of7RTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2nG0q17xE51uFBZ/DKe+LXh7BN3wXbQk5XH6Qe1Hpg=;
 b=11uZvbxAgO2ypBKK6Or8bZqVkiRANkE8poSkUmd0jxwCg+T5Sp96D1Ehge+j9btuTmdDjqsN6Zi5jxzQ3Zbd9LtvH30zVOlG+CY08DuBBbiDxhg+iZwzNfvXOLf+uPHhXFR9N3+D2TX0Kjzwjs9geFpIhiDXQafwgDSOXGIv4Ao=
Received: from MW4PR04CA0218.namprd04.prod.outlook.com (2603:10b6:303:87::13)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 12:34:31 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::a1) by MW4PR04CA0218.outlook.office365.com
 (2603:10b6:303:87::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Thu, 11 Aug 2022 12:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:34:30 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:34:24 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 06/13] perf/x86/amd/lbr: Add LbrExtV2 branch record support
Date:   Thu, 11 Aug 2022 17:59:54 +0530
Message-ID: <d3b8500a3627a0d4d0259b005891ee248f248d91.1660211399.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1660211399.git.sandipan.das@amd.com>
References: <cover.1660211399.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc7e9389-a813-4b73-3990-08da7b95d66f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4335:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0K7wx0GJgrXx/WEKPA3pTK5Y9PKuoEBiDl8gtNMdmdD2YuXTWG59ZDarxBjr2oDPUqIvkcthjfh67I7sAikVFIlx36Ix6CXL2gt4LVaiWVleVWl9smaII7zeLSzSRZaQMM9Yt0fBqb6hRBcl7I+ZutBkcVrNItOpdTQOFVQI3lLSoVYbfcSYifkZJ74iG+gLNXguIVBmsmLgHO4Z03qNkBGkQW608zQG8+MhlXEccHGYXKPFpB/Ozk6qRyrbSdljKDx77xMrhApQR0jBqr+w99wRwSUKW4ng+CcHuPNDB+hBGQyUaNh5rvrEfKA/liIPgCMWVIIoLaJlC/IaJI5JTOUz1//8B9Z2ILbk7jOEqm66C5lGmZjNsK8mV80NdtGAwWiQON0pLz3U4TapUlWCK+oTACv6vJy/rMJXZ6DYjpJNsjrtLNbvoWjFuw2pzvmrxpGcZjetLLvdjXte0VGafLUCs1F/X/pb8mur2fa6Hu6pzzjW39fGRZI+uQbAv28yXMV310wmnnIwdMJXJeTgkMhXiFMiKxgev39XhAwiRLfnV1zAg7aek02HVXlwTvMY6kvxbKHGaWwHOESgUQuk7pT1gx4e1nUmMj9GPpc9lhGoiYbQCy92IOJ6FbMlk5dGK0VwsSf3o7PxkA6fqO8YjsbYuBzBUupHlIVhOt6yvvExsrr5h11CHGpDtGJUAIE/2kuEONP7oeLrMCdOO69gsTJZS9fgSRPcwgojJLVENnv/C3LRl8yWHcDqKD86zUhLoXp1ZxX94E5VCkubJqb6bYFJNZLuIPgWHAzCB8I3w5SeG85nCnwLs9y59eoj4kgQGfnmYwQbJEUlJdTAgPxXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(40470700004)(46966006)(36840700001)(316002)(7416002)(356005)(41300700001)(70206006)(8676002)(2906002)(70586007)(7696005)(26005)(4326008)(30864003)(6666004)(82740400003)(82310400005)(81166007)(44832011)(5660300002)(16526019)(186003)(36756003)(47076005)(336012)(426003)(83380400001)(86362001)(478600001)(40460700003)(8936002)(40480700001)(54906003)(110136005)(36860700001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:34:30.2428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7e9389-a813-4b73-3990-08da7b95d66f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If AMD Last Branch Record Extension Version 2 (LbrExtV2) is detected,
enable it alongside LBR Freeze on PMI when an event requests branch stack
i.e. PERF_SAMPLE_BRANCH_STACK.

Each branch record is represented by a pair of registers, LBR From and LBR
To. The freeze feature prevents any updates to these registers once a PMC
overflows. The contents remain unchanged until the freeze bit is cleared by
the PMI handler.

The branch records are read and copied to sample data before unfreezing.
However, only valid entries are copied. There is no additional register to
denote which of the register pairs represent the top of the stack (TOS)
since internal register renaming always ensures that the first pair (i.e.
index 0) is the one representing the most recent branch and so on.

The LBR registers are per-thread resources and are cleared explicitly
whenever a new task is scheduled in. There are no special implications on
the contents of these registers when transitioning to deep C-states.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c       |  47 +++++--
 arch/x86/events/amd/lbr.c        | 203 +++++++++++++++++++++++++++++++
 arch/x86/events/perf_event.h     |   8 ++
 arch/x86/include/asm/msr-index.h |   5 +
 4 files changed, 252 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index a3aa67b4fd50..d799628016c8 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -620,7 +620,7 @@ static inline u64 amd_pmu_get_global_status(void)
 	/* PerfCntrGlobalStatus is read-only */
 	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, status);
 
-	return status & amd_pmu_global_cntr_mask;
+	return status;
 }
 
 static inline void amd_pmu_ack_global_status(u64 status)
@@ -631,8 +631,6 @@ static inline void amd_pmu_ack_global_status(u64 status)
 	 * clears the same bit in PerfCntrGlobalStatus
 	 */
 
-	/* Only allow modifications to PerfCntrGlobalStatus.PerfCntrOvfl */
-	status &= amd_pmu_global_cntr_mask;
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, status);
 }
 
@@ -742,11 +740,17 @@ static void amd_pmu_v2_enable_event(struct perf_event *event)
 	__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
 }
 
-static void amd_pmu_v2_enable_all(int added)
+static __always_inline void amd_pmu_core_enable_all(void)
 {
 	amd_pmu_set_global_ctl(amd_pmu_global_cntr_mask);
 }
 
+static void amd_pmu_v2_enable_all(int added)
+{
+	amd_pmu_lbr_enable_all();
+	amd_pmu_core_enable_all();
+}
+
 static void amd_pmu_disable_event(struct perf_event *event)
 {
 	x86_pmu_disable_event(event);
@@ -771,10 +775,15 @@ static void amd_pmu_disable_all(void)
 	amd_pmu_check_overflow();
 }
 
-static void amd_pmu_v2_disable_all(void)
+static __always_inline void amd_pmu_core_disable_all(void)
 {
-	/* Disable all PMCs */
 	amd_pmu_set_global_ctl(0);
+}
+
+static void amd_pmu_v2_disable_all(void)
+{
+	amd_pmu_core_disable_all();
+	amd_pmu_lbr_disable_all();
 	amd_pmu_check_overflow();
 }
 
@@ -877,8 +886,8 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	pmu_enabled = cpuc->enabled;
 	cpuc->enabled = 0;
 
-	/* Stop counting */
-	amd_pmu_v2_disable_all();
+	/* Stop counting but do not disable LBR */
+	amd_pmu_core_disable_all();
 
 	status = amd_pmu_get_global_status();
 
@@ -886,6 +895,12 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	if (!status)
 		goto done;
 
+	/* Read branch records before unfreezing */
+	if (status & GLOBAL_STATUS_LBRS_FROZEN) {
+		amd_pmu_lbr_read();
+		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
+	}
+
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
@@ -905,6 +920,9 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
+		if (has_branch_stack(event))
+			data.br_stack = &cpuc->lbr_stack;
+
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
 
@@ -918,7 +936,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	 */
 	WARN_ON(status > 0);
 
-	/* Clear overflow bits */
+	/* Clear overflow and freeze bits */
 	amd_pmu_ack_global_status(~status);
 
 	/*
@@ -932,7 +950,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 
 	/* Resume counting only if PMU is active */
 	if (pmu_enabled)
-		amd_pmu_v2_enable_all(0);
+		amd_pmu_core_enable_all();
 
 	return amd_pmu_adjust_nmi_window(handled);
 }
@@ -1375,7 +1393,14 @@ static int __init amd_core_pmu_init(void)
 	}
 
 	/* LBR and BRS are mutually exclusive features */
-	if (amd_pmu_lbr_init() && !amd_brs_init()) {
+	if (!amd_pmu_lbr_init()) {
+		/* LBR requires flushing on context switch */
+		x86_pmu.sched_task = amd_pmu_lbr_sched_task;
+		static_call_update(amd_pmu_branch_hw_config, amd_pmu_lbr_hw_config);
+		static_call_update(amd_pmu_branch_reset, amd_pmu_lbr_reset);
+		static_call_update(amd_pmu_branch_add, amd_pmu_lbr_add);
+		static_call_update(amd_pmu_branch_del, amd_pmu_lbr_del);
+	} else if (!amd_brs_init()) {
 		/*
 		 * BRS requires special event constraints and flushing on ctxsw.
 		 */
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index d240ff722b78..39247e7be53c 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -4,6 +4,209 @@
 
 #include "../perf_event.h"
 
+struct branch_entry {
+	union {
+		struct {
+			u64	ip:58;
+			u64	ip_sign_ext:5;
+			u64	mispredict:1;
+		} split;
+		u64		full;
+	} from;
+
+	union {
+		struct {
+			u64	ip:58;
+			u64	ip_sign_ext:3;
+			u64	reserved:1;
+			u64	spec:1;
+			u64	valid:1;
+		} split;
+		u64		full;
+	} to;
+};
+
+static __always_inline void amd_pmu_lbr_set_from(unsigned int idx, u64 val)
+{
+	wrmsrl(MSR_AMD_SAMP_BR_FROM + idx * 2, val);
+}
+
+static __always_inline void amd_pmu_lbr_set_to(unsigned int idx, u64 val)
+{
+	wrmsrl(MSR_AMD_SAMP_BR_FROM + idx * 2 + 1, val);
+}
+
+static __always_inline u64 amd_pmu_lbr_get_from(unsigned int idx)
+{
+	u64 val;
+
+	rdmsrl(MSR_AMD_SAMP_BR_FROM + idx * 2, val);
+
+	return val;
+}
+
+static __always_inline u64 amd_pmu_lbr_get_to(unsigned int idx)
+{
+	u64 val;
+
+	rdmsrl(MSR_AMD_SAMP_BR_FROM + idx * 2 + 1, val);
+
+	return val;
+}
+
+static __always_inline u64 sign_ext_branch_ip(u64 ip)
+{
+	u32 shift = 64 - boot_cpu_data.x86_virt_bits;
+
+	return (u64)(((s64)ip << shift) >> shift);
+}
+
+void amd_pmu_lbr_read(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_branch_entry *br = cpuc->lbr_entries;
+	struct branch_entry entry;
+	int out = 0, i;
+
+	if (!cpuc->lbr_users)
+		return;
+
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		entry.from.full	= amd_pmu_lbr_get_from(i);
+		entry.to.full	= amd_pmu_lbr_get_to(i);
+
+		/* Check if a branch has been logged */
+		if (!entry.to.split.valid)
+			continue;
+
+		perf_clear_branch_entry_bitfields(br + out);
+
+		br[out].from	= sign_ext_branch_ip(entry.from.split.ip);
+		br[out].to	= sign_ext_branch_ip(entry.to.split.ip);
+		br[out].mispred	= entry.from.split.mispredict;
+		br[out].predicted = !br[out].mispred;
+		out++;
+	}
+
+	cpuc->lbr_stack.nr = out;
+
+	/*
+	 * Internal register renaming always ensures that LBR From[0] and
+	 * LBR To[0] always represent the TOS
+	 */
+	cpuc->lbr_stack.hw_idx = 0;
+}
+
+static int amd_pmu_lbr_setup_filter(struct perf_event *event)
+{
+	/* No LBR support */
+	if (!x86_pmu.lbr_nr)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+int amd_pmu_lbr_hw_config(struct perf_event *event)
+{
+	int ret = 0;
+
+	/* LBR is not recommended in counting mode */
+	if (!is_sampling_event(event))
+		return -EINVAL;
+
+	ret = amd_pmu_lbr_setup_filter(event);
+	if (!ret)
+		event->attach_state |= PERF_ATTACH_SCHED_CB;
+
+	return ret;
+}
+
+void amd_pmu_lbr_reset(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int i;
+
+	if (!x86_pmu.lbr_nr)
+		return;
+
+	/* Reset all branch records individually */
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		amd_pmu_lbr_set_from(i, 0);
+		amd_pmu_lbr_set_to(i, 0);
+	}
+
+	cpuc->last_task_ctx = NULL;
+	cpuc->last_log_id = 0;
+}
+
+void amd_pmu_lbr_add(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (!x86_pmu.lbr_nr)
+		return;
+
+	perf_sched_cb_inc(event->ctx->pmu);
+
+	if (!cpuc->lbr_users++ && !event->total_time_running)
+		amd_pmu_lbr_reset();
+}
+
+void amd_pmu_lbr_del(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (!x86_pmu.lbr_nr)
+		return;
+
+	cpuc->lbr_users--;
+	WARN_ON_ONCE(cpuc->lbr_users < 0);
+	perf_sched_cb_dec(event->ctx->pmu);
+}
+
+void amd_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	/*
+	 * A context switch can flip the address space and LBR entries are
+	 * not tagged with an identifier. Hence, branches cannot be resolved
+	 * from the old address space and the LBR records should be wiped.
+	 */
+	if (cpuc->lbr_users && sched_in)
+		amd_pmu_lbr_reset();
+}
+
+void amd_pmu_lbr_enable_all(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 dbg_ctl, dbg_extn_cfg;
+
+	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
+		return;
+
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+
+	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg | DBG_EXTN_CFG_LBRV2EN);
+}
+
+void amd_pmu_lbr_disable_all(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 dbg_ctl, dbg_extn_cfg;
+
+	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
+		return;
+
+	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+
+	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
+	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+}
+
 __init int amd_pmu_lbr_init(void)
 {
 	union cpuid_0x80000022_ebx ebx;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a6cd83c57e8b..c8397290f388 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1231,6 +1231,14 @@ static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
 int amd_pmu_init(void);
 
 int amd_pmu_lbr_init(void);
+void amd_pmu_lbr_reset(void);
+void amd_pmu_lbr_read(void);
+void amd_pmu_lbr_add(struct perf_event *event);
+void amd_pmu_lbr_del(struct perf_event *event);
+void amd_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
+void amd_pmu_lbr_enable_all(void);
+void amd_pmu_lbr_disable_all(void);
+int amd_pmu_lbr_hw_config(struct perf_event *event);
 
 #ifdef CONFIG_PERF_EVENTS_AMD_BRS
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 403e83b4adc8..440d0490f71e 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -539,6 +539,9 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Last Branch Record MSRs */
+#define MSR_AMD64_LBR_SELECT			0xc000010e
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
@@ -707,6 +710,8 @@
 #define MSR_AMD_DBG_EXTN_CFG		0xc000010f
 #define MSR_AMD_SAMP_BR_FROM		0xc0010300
 
+#define DBG_EXTN_CFG_LBRV2EN		BIT_ULL(6)
+
 #define MSR_IA32_MPERF			0x000000e7
 #define MSR_IA32_APERF			0x000000e8
 
-- 
2.34.1

