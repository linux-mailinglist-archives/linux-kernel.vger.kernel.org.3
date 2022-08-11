Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5AF58FC72
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiHKMgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiHKMgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:36:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560111144E;
        Thu, 11 Aug 2022 05:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+c4TuCNOEQzppBX1dziu6tiSooHHZmMUw8n2axmugdB2TkAR0n4OPiI7Sgx/GwoXIVwGcMi55BwImMOX6xmgG0+nCn4w8CScMgmcuDpOHUsCBUCpvhhOjfUQRYZNKHXBa/xtuSDv4q6iZIMiXYbRvzwTTsHLebeXn5M65trBWt09LCsFG87O9p0OAgkdfWyWGX8C93qEf+1kGiZz5ZZ0zJ9NysoM2TlFYfT12Wl/WqpCBDf3RNAoABK7o0nnpZEBed49YKVDoLie8rg9g6GkwPv6I3f81ubYHuba1klptZWAks69Y1ZiJbU5MNImGTcWZP673YkSJnOMC50a2E4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRhbQZlBRmMsALmcrlo+FaGXFHPTpoQk3uvWQWSEYhg=;
 b=DWFVX8AmzTcV+YcsQAUdOIo1ZSDhgfRH4v6IJALNhifOuRab8fmxXxbM7tf/IuSEQBqm+3NxM4mWozGSV2gnmJao0SEA2gctuQaZKTZvrgJro/kN87TCR7P6GBRFvxC4JemitVgwl5oF5fF7DPfyu+15V8/D1F96wzDLOZkYKwRC7VCftwpRrWWN64VoKvKq7orqEnelDRXFVKivbp24+Y8tGmMAq1c//KNsJY1kHN8oRERpdG+v3A/1xhduMGBCVRo4cCnzsB2XkL+FQ7dWlfYGJZ6l1Lr2kAXYLG3P2ctttDCfMmnYiXnLcgvVHfMOoEgYBrPMA1ZtUbxL1KiScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRhbQZlBRmMsALmcrlo+FaGXFHPTpoQk3uvWQWSEYhg=;
 b=R4wt/YkKJfEOGh2m+1Z3apkB5T/x8GwPpEF1EiUDewKpN0WDojbnLdrlCX/JLUPZ6KAIx2jT0C1oVXZ1KVqfAU7da+/Rw3LpwCl9KBe1IhpywiKDM5aB0G6/RPAt1aE0GDIX9EU9aVKvdjJWLMHn9QFRy5V3BbvkKABEIURgLns=
Received: from MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7)
 by BY5PR12MB3970.namprd12.prod.outlook.com (2603:10b6:a03:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 12:36:47 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::81) by MW4PR04CA0302.outlook.office365.com
 (2603:10b6:303:82::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Thu, 11 Aug 2022 12:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:36:46 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:36:41 -0500
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
Subject: [PATCH 09/13] perf/x86/amd/lbr: Add LbrExtV2 software branch filter support
Date:   Thu, 11 Aug 2022 17:59:57 +0530
Message-ID: <e51de057517f77788abd393c832e8dea616d489c.1660211399.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ca1782fb-954e-4608-71c5-08da7b9627d9
X-MS-TrafficTypeDiagnostic: BY5PR12MB3970:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: demYzxeE0FyiJOmptuvCEvVJxqr07x1jcnafo5bAlDd78ar0pXDDjjwuyWBVgAgF/EnTAfcI68DwHui5jkIKo5S35Nx/o8Uwz9UQFSk8qmTzwZ73i81YLOhrmdr1qub5YHDI/p6VqsuygJ3Pop5tpWG3PbYWHuJfQkt89eOz56Y4Xrjqvb9YMk3zcB9X2BYRFGqPCqP++R6KEnPoNeN7Swwrsm9ZY7XyqGkGhmiOuXi4UodrN46JpLrqFvndgNQpt3RduoOVjwS5Y7C7XT50Kr2eNOzUfjdadXXbPeS4Abv5U2jVWjkuxYNRO3VPSzR29NsOtA7oFlPb155AdhyjSqTPj8NMeJJ2nE4uloMmdFELQogb+73zBAae8/gR2TpzcGB3J2aIgl0/lQQDR4mIBpgjI43NgB6I4F+6vE6RAxyv5QseVXJqWXs7OPoLHMjrsoOeJXPNRRwpQ5f1eJAAzn9jHTeZ5L44IwjpqGtucLO1lDJFaZeX0ag4CrtTQSa2IQTG9UxaqGGjA/Qz7wOOYlcoGMUb/2bVeOiWd5uw/DNQ1ZLcUiZpDh8C4o5dTCAmfkG4ctGftK+RRb+lOQHGPB7xGhQe+8PqcsZ1/9wpae501EuMNX0nL1a/Nh40gA+FFzVTNXFqPttKmI3To3ME+vfhjJ4ZLk4BWo2KlLOsfx/rDEoiOnvPsPxH3pbEuxoCOKQTJFgXYfIbFwkq3gshusWwehleZI21rFaUVkZ9U243ahQfZfwvLMc6dnHSVHVtaKXqoBu1t6DYD66xsh0hpdz0igQiSQkswzw5od8pDM5czarRHJ9te0XBUKSn7uLAUWSm2IkvQYEYNdiUZcHiGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(40470700004)(36840700001)(46966006)(41300700001)(6666004)(7696005)(478600001)(26005)(83380400001)(426003)(47076005)(40460700003)(336012)(2616005)(2906002)(186003)(44832011)(7416002)(16526019)(5660300002)(40480700001)(82310400005)(316002)(54906003)(110136005)(8936002)(8676002)(4326008)(70206006)(82740400003)(86362001)(81166007)(70586007)(36756003)(356005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:36:46.8188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1782fb-954e-4608-71c5-08da7b9627d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3970
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With AMD Last Branch Record Extension Version 2 (LbrExtV2), it is necessary
to process the branch records further as hardware filtering is not granular
enough for identifying certain types of branches. E.g. to record system
calls, one should record far branches. The filter captures both far calls
and far returns but the irrelevant records are filtered out based on the
branch type as seen by the branch classifier.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/lbr.c | 92 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 064a6c8e1597..3699ba53a326 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -94,6 +94,50 @@ static __always_inline u64 sign_ext_branch_ip(u64 ip)
 	return (u64)(((s64)ip << shift) >> shift);
 }
 
+static void amd_pmu_lbr_filter(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int br_sel = cpuc->br_sel, type, i, j;
+	bool compress = false;
+	u64 from, to;
+
+	/* If sampling all branches, there is nothing to filter */
+	if (((br_sel & X86_BR_ALL) == X86_BR_ALL) &&
+	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
+		return;
+
+	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
+		from = cpuc->lbr_entries[i].from;
+		to = cpuc->lbr_entries[i].to;
+		type = branch_type(from, to, 0);
+
+		/* If type does not correspond, then discard */
+		if (type == X86_BR_NONE || (br_sel & type) != type) {
+			cpuc->lbr_entries[i].from = 0;	/* mark invalid */
+			compress = true;
+		}
+
+		if ((br_sel & X86_BR_TYPE_SAVE) == X86_BR_TYPE_SAVE)
+			cpuc->lbr_entries[i].type = common_branch_type(type);
+	}
+
+	if (!compress)
+		return;
+
+	/* Remove all invalid entries */
+	for (i = 0; i < cpuc->lbr_stack.nr; ) {
+		if (!cpuc->lbr_entries[i].from) {
+			j = i;
+			while (++j < cpuc->lbr_stack.nr)
+				cpuc->lbr_entries[j - 1] = cpuc->lbr_entries[j];
+			cpuc->lbr_stack.nr--;
+			if (!cpuc->lbr_entries[i].from)
+				continue;
+		}
+		i++;
+	}
+}
+
 void amd_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -128,6 +172,9 @@ void amd_pmu_lbr_read(void)
 	 * LBR To[0] always represent the TOS
 	 */
 	cpuc->lbr_stack.hw_idx = 0;
+
+	/* Perform further software filtering */
+	amd_pmu_lbr_filter();
 }
 
 static const int lbr_select_map[PERF_SAMPLE_BRANCH_MAX_SHIFT] = {
@@ -136,8 +183,8 @@ static const int lbr_select_map[PERF_SAMPLE_BRANCH_MAX_SHIFT] = {
 	[PERF_SAMPLE_BRANCH_HV_SHIFT]		= LBR_IGNORE,
 
 	[PERF_SAMPLE_BRANCH_ANY_SHIFT]		= LBR_ANY,
-	[PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT]	= LBR_REL_CALL | LBR_IND_CALL,
-	[PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT]	= LBR_RETURN,
+	[PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT]	= LBR_REL_CALL | LBR_IND_CALL | LBR_FAR,
+	[PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT]	= LBR_RETURN | LBR_FAR,
 	[PERF_SAMPLE_BRANCH_IND_CALL_SHIFT]	= LBR_IND_CALL,
 	[PERF_SAMPLE_BRANCH_ABORT_TX_SHIFT]	= LBR_NOT_SUPP,
 	[PERF_SAMPLE_BRANCH_IN_TX_SHIFT]	= LBR_NOT_SUPP,
@@ -150,8 +197,6 @@ static const int lbr_select_map[PERF_SAMPLE_BRANCH_MAX_SHIFT] = {
 
 	[PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT]	= LBR_NOT_SUPP,
 	[PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT]	= LBR_NOT_SUPP,
-
-	[PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT]	= LBR_NOT_SUPP,
 };
 
 static int amd_pmu_lbr_setup_filter(struct perf_event *event)
@@ -165,6 +210,41 @@ static int amd_pmu_lbr_setup_filter(struct perf_event *event)
 	if (!x86_pmu.lbr_nr)
 		return -EOPNOTSUPP;
 
+	if (br_type & PERF_SAMPLE_BRANCH_USER)
+		mask |= X86_BR_USER;
+
+	if (br_type & PERF_SAMPLE_BRANCH_KERNEL)
+		mask |= X86_BR_KERNEL;
+
+	/* Ignore BRANCH_HV here */
+
+	if (br_type & PERF_SAMPLE_BRANCH_ANY)
+		mask |= X86_BR_ANY;
+
+	if (br_type & PERF_SAMPLE_BRANCH_ANY_CALL)
+		mask |= X86_BR_ANY_CALL;
+
+	if (br_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
+		mask |= X86_BR_RET | X86_BR_IRET | X86_BR_SYSRET;
+
+	if (br_type & PERF_SAMPLE_BRANCH_IND_CALL)
+		mask |= X86_BR_IND_CALL;
+
+	if (br_type & PERF_SAMPLE_BRANCH_COND)
+		mask |= X86_BR_JCC;
+
+	if (br_type & PERF_SAMPLE_BRANCH_IND_JUMP)
+		mask |= X86_BR_IND_JMP;
+
+	if (br_type & PERF_SAMPLE_BRANCH_CALL)
+		mask |= X86_BR_CALL | X86_BR_ZERO_CALL;
+
+	if (br_type & PERF_SAMPLE_BRANCH_TYPE_SAVE)
+		mask |= X86_BR_TYPE_SAVE;
+
+	reg->reg = mask;
+	mask = 0;
+
 	for (i = 0; i < PERF_SAMPLE_BRANCH_MAX_SHIFT; i++) {
 		if (!(br_type & BIT_ULL(i)))
 			continue;
@@ -220,13 +300,15 @@ void amd_pmu_lbr_reset(void)
 void amd_pmu_lbr_add(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event_extra *reg = &event->hw.branch_reg;
 
 	if (!x86_pmu.lbr_nr)
 		return;
 
 	if (has_branch_stack(event)) {
 		cpuc->lbr_select = 1;
-		cpuc->lbr_sel->config = event->hw.branch_reg.config;
+		cpuc->lbr_sel->config = reg->config;
+		cpuc->br_sel = reg->reg;
 	}
 
 	perf_sched_cb_inc(event->ctx->pmu);
-- 
2.34.1

