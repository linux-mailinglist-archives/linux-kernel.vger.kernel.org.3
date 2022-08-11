Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36F258FC67
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiHKMfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiHKMfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:35:38 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE209B1F1;
        Thu, 11 Aug 2022 05:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIIbsj/HIah9SecJbuBqX2sk4cs4zfpycmRG0OJZJJFuTzSA3PwgIjU6ZbkF+kWO/0HiHjdxGAZi3sB6vQO/vItSlkCqbtJOCJGPTSJk9c97+jVfRvmWzDZsl0qXcpt2J65KSWr/V0UJyjMwemsjbf2+64nInZI2R37IcHT8WKx0PLCYJ8U/53i6Ynp/55+HKwOcG0M6DEDaMa9DiCZEyUQdekAL5sktpDYIB16cp/PKBHs3lUj9vjbJQhteG2+YfaNLv2fAGBsGXumCvGzatHJK6i1z5fPr7wZZdvdQSfBCN7yvBxItbzMBZ8LQaW4COTM7bNkEUebx5cOnxZ6nYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktCkq4RksL6s63xNn8wN9/EKhsCeFjP0+cY2Mcf2TZo=;
 b=JqdhM+kDIgJK3Cn/nAN7h8jkXOf3JcuG2SNkZKYQ5N5dr3KWfwY3o7jIdsx+NAYGAhr3AxxdT5FYtkkLp74l3e3BnqWBP2IClNleBSQJrDsUhtJDa3gJzKFststdT4QbNfhpHkJqpWi8ylwSWYy2GY1sOv2/IyvOE4RQnGBBkQ9ClinSgp0CpIwIlGt+UM3t+re53fNmVl/FwSaph44//xnRqoD2x7yZy4KkoFGh+rslFs094wpq/DFL62k/ZzK9CE/FIyyt9V4b9BQDTOU+TFD8JbjQS5dPZ2Fg2cGbjLmsRKvmiEO2/yYkUaQQPfQHK+b11ZqtvNZGfqqGqwcXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktCkq4RksL6s63xNn8wN9/EKhsCeFjP0+cY2Mcf2TZo=;
 b=hemKoF9yUBqo1HH7plk3mlyjtjlAR9bUawm8hpwKylXDF9kj7NQivuveOXKjOEFacJyeXpFIE3LpVNX+lm6vM0d9Pr/qhvYsK7OcIGbBm9JG0nhoiVW8wsEhrn8cDHHd1sYTz+RHti6ln5SeXZLlsJg9HczCcKg5McGftDX6JLo=
Received: from MW4PR04CA0256.namprd04.prod.outlook.com (2603:10b6:303:88::21)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Thu, 11 Aug
 2022 12:35:21 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::fc) by MW4PR04CA0256.outlook.office365.com
 (2603:10b6:303:88::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 11 Aug 2022 12:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:35:20 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:34:43 -0500
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
Subject: [PATCH 07/13] perf/x86/amd/lbr: Add LbrExtV2 hardware branch filter support
Date:   Thu, 11 Aug 2022 17:59:55 +0530
Message-ID: <9336af5c9785b8e14c62220fc0e6cfb10ab97de3.1660211399.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ba06bbe7-b9e6-4c5b-2ee8-08da7b95f468
X-MS-TrafficTypeDiagnostic: PH7PR12MB5594:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKfkXx5ENN6vfqaYdjxsGhVc61zDciL9gH3uwMEyjir2xzGKycUI9evd/fqZ4e3rx5st6Od9y6sI038+nZx6plj11BHyzSzrOgL6lroUW1T+a9t7ASs3k6Fo5xkiSCVAdPdqjC6XXEYyQ2e/0qtJf3qSg3xYNbgzMFURrMVIOcyuIsc5Cr0q7fFXuYf5QG80UJv33dgA3oDVBatZlX955KQ91yYCxHy2p6GqtAHmzUcBhbA81Eyc0rr07EfY5+eXfJI89WvUDXV1cvD7DHV2vOENM//wX8eCZnL9j8Sxynpe3STWPQRjyDWe00+y3N1kH/zWR3H/J5EMuRvsD5N3AZuU1uY9A+Y6rlYMvVwRg8N1TOi8ez261/z8pkJO7sx4/fkjJel/cJjdGorh+nHchGGdYT6OiWidv4Z8/pvXEgAdIv6wBQcnbS7vgIwONOa3KPn1XTsN9Hcys1VGZxK+BTB1KhdxtBKuINyVGSGhEAf5AtRol88ZNkB/GQh881dMzDxYdSyGV2WJdRuki7U2OHvt/owuUktE+lKCino2m7wskNhBU9i/gdgTJ1t+Pl2r1JA006xGKDGx1BNYGBWThEWRyiPI3EuMDlp3aYk9Vmn0UWjwxmDRkz7j3nVFSNuXYdek/sEqy+7IsEyLrG7MxT5u0pgXgo1uOrvQCalE7GkRT5qOI2ZbVx972z2B4LcB7YsIJQQFETI/LtukWh6/ruRgMIU+8aiqRaAfqJPlOL+jyzScrYvK0jBPIm0vprW0yNIDsGyPPmDjGhvZegXpZ33sXZu9jYMOp4emfRquZ9q8bLr5yxYvU2LQ9jlQobL7CkkEV63bRmOdzqaJS2ukOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(40470700004)(36840700001)(54906003)(70206006)(36860700001)(186003)(4326008)(82740400003)(5660300002)(7416002)(316002)(8676002)(82310400005)(40460700003)(44832011)(8936002)(36756003)(70586007)(110136005)(478600001)(26005)(16526019)(426003)(336012)(41300700001)(7696005)(6666004)(47076005)(2906002)(2616005)(356005)(81166007)(83380400001)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:35:20.5283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba06bbe7-b9e6-4c5b-2ee8-08da7b95f468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
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
convert the requested branch filter (PERF_SAMPLE_BRANCH_* flags) to the
corresponding hardware filter value and stash it in the event data when
a branch stack is requested. The hardware filter value is also saved in
per-CPU areas for use during event scheduling.

Hardware filtering is provided by the LBR Branch Select register. It has
bits which when set, suppress recording of the following types of branches:

  * CPL = 0 (Kernel only)
  * CPL > 0 (Userspace only)
  * Conditional Branches
  * Near Relative Calls
  * Near Indirect Calls
  * Near Returns
  * Near Indirect Jumps (excluding Near Indirect Calls and Near Returns)
  * Near Relative Jumps (excluding Near Relative Calls)
  * Far Branches

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 21 ++++++---
 arch/x86/events/amd/lbr.c  | 94 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index d799628016c8..36bede1d7b1e 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -542,16 +542,24 @@ static int amd_pmu_cpu_prepare(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 
+	cpuc->lbr_sel = kzalloc_node(sizeof(struct er_account), GFP_KERNEL,
+				     cpu_to_node(cpu));
+	if (!cpuc->lbr_sel)
+		return -ENOMEM;
+
 	WARN_ON_ONCE(cpuc->amd_nb);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return 0;
 
 	cpuc->amd_nb = amd_alloc_nb(cpu);
-	if (!cpuc->amd_nb)
-		return -ENOMEM;
+	if (cpuc->amd_nb)
+		return 0;
 
-	return 0;
+	kfree(cpuc->lbr_sel);
+	cpuc->lbr_sel = NULL;
+
+	return -ENOMEM;
 }
 
 static void amd_pmu_cpu_starting(int cpu)
@@ -589,13 +597,14 @@ static void amd_pmu_cpu_starting(int cpu)
 
 static void amd_pmu_cpu_dead(int cpu)
 {
-	struct cpu_hw_events *cpuhw;
+	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
+
+	kfree(cpuhw->lbr_sel);
+	cpuhw->lbr_sel = NULL;
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
 
-	cpuhw = &per_cpu(cpu_hw_events, cpu);
-
 	if (cpuhw->amd_nb) {
 		struct amd_nb *nb = cpuhw->amd_nb;
 
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 39247e7be53c..064a6c8e1597 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -4,6 +4,39 @@
 
 #include "../perf_event.h"
 
+/* LBR Branch Select valid bits */
+#define LBR_SELECT_MASK		0x1ff
+
+/*
+ * LBR Branch Select filter bits which when set, ensures that the
+ * corresponding type of branches are not recorded
+ */
+#define LBR_SELECT_KERNEL		0	/* Branches ending in CPL = 0 */
+#define LBR_SELECT_USER			1	/* Branches ending in CPL > 0 */
+#define LBR_SELECT_JCC			2	/* Conditional branches */
+#define LBR_SELECT_CALL_NEAR_REL	3	/* Near relative calls */
+#define LBR_SELECT_CALL_NEAR_IND	4	/* Indirect relative calls */
+#define LBR_SELECT_RET_NEAR		5	/* Near returns */
+#define LBR_SELECT_JMP_NEAR_IND		6	/* Near indirect jumps (excl. calls and returns) */
+#define LBR_SELECT_JMP_NEAR_REL		7	/* Near relative jumps (excl. calls) */
+#define LBR_SELECT_FAR_BRANCH		8	/* Far branches */
+
+#define LBR_KERNEL	BIT(LBR_SELECT_KERNEL)
+#define LBR_USER	BIT(LBR_SELECT_USER)
+#define LBR_JCC		BIT(LBR_SELECT_JCC)
+#define LBR_REL_CALL	BIT(LBR_SELECT_CALL_NEAR_REL)
+#define LBR_IND_CALL	BIT(LBR_SELECT_CALL_NEAR_IND)
+#define LBR_RETURN	BIT(LBR_SELECT_RET_NEAR)
+#define LBR_REL_JMP	BIT(LBR_SELECT_JMP_NEAR_REL)
+#define LBR_IND_JMP	BIT(LBR_SELECT_JMP_NEAR_IND)
+#define LBR_FAR		BIT(LBR_SELECT_FAR_BRANCH)
+#define LBR_NOT_SUPP	-1	/* unsupported filter */
+#define LBR_IGNORE	0
+
+#define LBR_ANY		\
+	(LBR_JCC | LBR_REL_CALL | LBR_IND_CALL | LBR_RETURN |	\
+	 LBR_REL_JMP | LBR_IND_JMP | LBR_FAR)
+
 struct branch_entry {
 	union {
 		struct {
@@ -97,12 +130,56 @@ void amd_pmu_lbr_read(void)
 	cpuc->lbr_stack.hw_idx = 0;
 }
 
+static const int lbr_select_map[PERF_SAMPLE_BRANCH_MAX_SHIFT] = {
+	[PERF_SAMPLE_BRANCH_USER_SHIFT]		= LBR_USER,
+	[PERF_SAMPLE_BRANCH_KERNEL_SHIFT]	= LBR_KERNEL,
+	[PERF_SAMPLE_BRANCH_HV_SHIFT]		= LBR_IGNORE,
+
+	[PERF_SAMPLE_BRANCH_ANY_SHIFT]		= LBR_ANY,
+	[PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT]	= LBR_REL_CALL | LBR_IND_CALL,
+	[PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT]	= LBR_RETURN,
+	[PERF_SAMPLE_BRANCH_IND_CALL_SHIFT]	= LBR_IND_CALL,
+	[PERF_SAMPLE_BRANCH_ABORT_TX_SHIFT]	= LBR_NOT_SUPP,
+	[PERF_SAMPLE_BRANCH_IN_TX_SHIFT]	= LBR_NOT_SUPP,
+	[PERF_SAMPLE_BRANCH_NO_TX_SHIFT]	= LBR_NOT_SUPP,
+	[PERF_SAMPLE_BRANCH_COND_SHIFT]		= LBR_JCC,
+
+	[PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT]	= LBR_NOT_SUPP,
+	[PERF_SAMPLE_BRANCH_IND_JUMP_SHIFT]	= LBR_IND_JMP,
+	[PERF_SAMPLE_BRANCH_CALL_SHIFT]		= LBR_REL_CALL,
+
+	[PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT]	= LBR_NOT_SUPP,
+	[PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT]	= LBR_NOT_SUPP,
+
+	[PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT]	= LBR_NOT_SUPP,
+};
+
 static int amd_pmu_lbr_setup_filter(struct perf_event *event)
 {
+	struct hw_perf_event_extra *reg = &event->hw.branch_reg;
+	u64 br_type = event->attr.branch_sample_type;
+	u64 mask = 0, v;
+	int i;
+
 	/* No LBR support */
 	if (!x86_pmu.lbr_nr)
 		return -EOPNOTSUPP;
 
+	for (i = 0; i < PERF_SAMPLE_BRANCH_MAX_SHIFT; i++) {
+		if (!(br_type & BIT_ULL(i)))
+			continue;
+
+		v = lbr_select_map[i];
+		if (v == LBR_NOT_SUPP)
+			return -EOPNOTSUPP;
+
+		if (v != LBR_IGNORE)
+			mask |= v;
+	}
+
+	/* Filter bits operate in suppress mode */
+	reg->config = mask ^ LBR_SELECT_MASK;
+
 	return 0;
 }
 
@@ -137,6 +214,7 @@ void amd_pmu_lbr_reset(void)
 
 	cpuc->last_task_ctx = NULL;
 	cpuc->last_log_id = 0;
+	wrmsrl(MSR_AMD64_LBR_SELECT, 0);
 }
 
 void amd_pmu_lbr_add(struct perf_event *event)
@@ -146,6 +224,11 @@ void amd_pmu_lbr_add(struct perf_event *event)
 	if (!x86_pmu.lbr_nr)
 		return;
 
+	if (has_branch_stack(event)) {
+		cpuc->lbr_select = 1;
+		cpuc->lbr_sel->config = event->hw.branch_reg.config;
+	}
+
 	perf_sched_cb_inc(event->ctx->pmu);
 
 	if (!cpuc->lbr_users++ && !event->total_time_running)
@@ -159,6 +242,9 @@ void amd_pmu_lbr_del(struct perf_event *event)
 	if (!x86_pmu.lbr_nr)
 		return;
 
+	if (has_branch_stack(event))
+		cpuc->lbr_select = 0;
+
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
 	perf_sched_cb_dec(event->ctx->pmu);
@@ -180,11 +266,17 @@ void amd_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
 void amd_pmu_lbr_enable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	u64 dbg_ctl, dbg_extn_cfg;
+	u64 lbr_select, dbg_ctl, dbg_extn_cfg;
 
 	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
 		return;
 
+	/* Set hardware branch filter */
+	if (cpuc->lbr_select) {
+		lbr_select = cpuc->lbr_sel->config & LBR_SELECT_MASK;
+		wrmsrl(MSR_AMD64_LBR_SELECT, lbr_select);
+	}
+
 	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
 	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
 
-- 
2.34.1

