Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EF24F5042
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1841024AbiDFBOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381275AbiDEOQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:16:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B88E1605D0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXmXqpn3NofSunwzqNnR5gD7XckdQVvKnX7XHbR2rObbT6vRHBAnuA5CWpE3oQdSoamIiie4jH4zeBHcY9hzCgmhcqwzjQKIe/wPLp7DqR6Zo3CA6N469QzAQM3IAZ3cXo8Xuwe9lrVQiGGadmWvezFQkgtgsxLUlMvx2tU3qKda7HRVhsu3TGf7alSTNxxCstinUnF9vHRBsp7bkCC/vNbvzJqu0vg1icT4MTxgDLgSj4m8B5Sbdd4unDzXVcXmnEmD0N7Bt1fpRkf6Pohur4nsQZU+VotCUylh2nbdofebm1LPevMa3+g3CaVj6G/ScYHMQeD3PAqcQPwGdSKDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4EHduKSLYaEls4HHSadyYWQJIVgLOKHJCnvh30NzUc=;
 b=SJQT5ETHxALAvlZSIs6MO9gYj2HYQa9DoyfUUdDy6slAsGzW8enH0jbq2Cof4rWQZGVs/HG9JBJVmqhkItKplZuHk3OR8tbWvRXlVCf4tYopbABRu0+0zqVzDHDREtwZ2MkStegpGO0wpwftYb+p8j7rh+wKF3Sq3WxTmBXMJu2dnhtrgyDpdbvCSnhJuyafIbDbyE+aagPVyUT5KKqncepNExxF8KGD8BekQCLi/WdDFu50j966qqM40x1Q5T9SxTZBr1latZLY1w2antx6R+9pVb+rVBuWDp1oXAIq7Bz1/BcOmJHZa1vGpA/cZ4hOGYQmNm69kfB3AR72SReYmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4EHduKSLYaEls4HHSadyYWQJIVgLOKHJCnvh30NzUc=;
 b=D5VJhC4cXfSfmaHI6SrtEIVHcXv4IH0BLJamMWdx5U8+uY7LhAeXYswA+Zhf3Id/zvhtY+XDp2vKYnkoni0prBRiKS6OOY1oa3ltTYMCGYzinOShEZf0fOehux1QOgsy70KeODtlcZMideN8mbIOHv8bGVQ6afBrQoxBYFo18UI=
Received: from DS7PR07CA0011.namprd07.prod.outlook.com (2603:10b6:5:3af::22)
 by CY4PR1201MB0151.namprd12.prod.outlook.com (2603:10b6:910:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 13:00:44 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::c4) by DS7PR07CA0011.outlook.office365.com
 (2603:10b6:5:3af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 13:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 13:00:43 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 08:00:38 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <Lewis.Carroll@amd.com>, <Mario.Limonciello@amd.com>,
        <gautham.shenoy@amd.com>, <Ananth.Narayan@amd.com>,
        <bharata@amd.com>, <len.brown@intel.com>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <peterz@infradead.org>, <chang.seok.bae@intel.com>,
        <keescook@chromium.org>, <metze@samba.org>,
        <zhengqi.arch@bytedance.com>, <mark.rutland@arm.com>
Subject: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Date:   Tue, 5 Apr 2022 18:30:21 +0530
Message-ID: <20220405130021.557880-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b88505c-1d12-4675-631d-08da17044b82
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0151:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB015162BBA772AB80CD96C91C84E49@CY4PR1201MB0151.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6SJ9G8eNbB4GMpB6SwZJmnDboKoQCekebmAALX2K/2y4y8b422r3IptWiP6jZqRWzwVayXJmSl5IguzS+CUji3D4/PuzH8ZEWdKxFwLZDRV34a165XkTKOjts6ospRLUM/CHr9QqlwObKqw/DI8Cn+ls7S9NFUMCwOAdJoXpyD43cdoxB4dy8Lk4twGq/IjWsv0fYJ43C5lcnOvSOR0HETrueXSETgNssArzscVKlBHrNS0SEgz2Peg8kGPqFUF7JVjmSGUyu0JdVRyFsDAnA0Vw6UcYJBojQVhtobwfnX/0mqRCcpcrYP1d9Bms8ZETgkpeGe2PqkarltjOzJCSdwbm1A0RjkW7cYGSdSPVRLWRnza1p1mZ8LuPhde/PkTH2gKfobbU9rjGCYL0nnfjDecdDDOWZMAWkfy5YTd4Q94q+sgwkAjRcDw+57Pl0/+rLfYctYYJSj6CQoPcYOCsi2HmMsRwDINLavw2QI1z63jQPzLPTLaMG9mF8C2vD/l3NdmBCmc36iZYemrGPG6r3dk9pLhlHYkfZ2viFzgGRyIhC0BPwqwjQKY8/l9esVCelN70KlECAoUcjJLklcmH3wLx46zdqDVo7Qtp5xpEvCGzSfuqi1hA9GUjUXQQC1ZjVQVw+PvG9nuUJCiHUprUjFets244bGAL+dHR/pYv+Qqtt6CEWdXDe06oY6V66gnJBeu3ftXf+2SKDLcCP9uJKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(16526019)(8676002)(6666004)(47076005)(7696005)(83380400001)(82310400005)(54906003)(36756003)(81166007)(6916009)(70206006)(70586007)(2906002)(4326008)(316002)(508600001)(36860700001)(356005)(7416002)(336012)(1076003)(426003)(44832011)(26005)(2616005)(186003)(8936002)(40460700003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 13:00:43.9553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b88505c-1d12-4675-631d-08da17044b82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lewis Caroll <lewis.carroll@amd.com>

Currently in the absence of the cpuidle driver (eg: when global
C-States are disabled in the BIOS or when cpuidle is driver is not
compiled in), the default idle state on AMD Zen processors uses the
HALT instruction even though there is support for MWAIT instruction
which is more efficient than HALT.

The below table represents the exit latency for HALT and MWAIT on AMD
Zen 3 system.
Exit latency is measured by issuing a wakeup (IPI) to other
CPU and measuring how many clock cycles it took to wakeup.
Each iteration measures 10K wakeups by pinning source and
destination.

HALT:

25.0000th percentile  :      1900 ns
50.0000th percentile  :      2000 ns
75.0000th percentile  :      2300 ns
90.0000th percentile  :      2500 ns
95.0000th percentile  :      2600 ns
99.0000th percentile  :      2800 ns
99.5000th percentile  :      3000 ns
99.9000th percentile  :      3400 ns
99.9500th percentile  :      3600 ns
99.9900th percentile  :      5900 ns
  Min latency         :      1700 ns
  Max latency         :      5900 ns
Total Samples      9999

MWAIT:

25.0000th percentile  :      1400 ns
50.0000th percentile  :      1500 ns
75.0000th percentile  :      1700 ns
90.0000th percentile  :      1800 ns
95.0000th percentile  :      1900 ns
99.0000th percentile  :      2300 ns
99.5000th percentile  :      2500 ns
99.9000th percentile  :      3200 ns
99.9500th percentile  :      3500 ns
99.9900th percentile  :      4600 ns
  Min latency         :      1200 ns
  Max latency         :      4600 ns
Total Samples      9997

Improvement: 21.74%

A similar trend is observed on older Zen processors also.

Here we enable MWAIT instruction as the default idle call for AMD
Zen processors which support MWAIT. We retain the existing behaviour
for older processors which depend on HALT.

NOTE: This change only impacts the default idle behaviour in the
absence of cpuidle driver. If the cpuidle driver is present, it
controls the processor idle behaviour.

Fixes: commit b253149b843f ("sched/idle/x86: Restore mwait_idle() to fix boot hangs, to improve power savings and to improve performance")
Signed-off-by: Lewis Caroll <lewis.carroll@amd.com>
Signed-off-by: Wyes Karny <Wyes.Karny@amd.com>
---
 arch/x86/kernel/process.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 81d8ef036637..952d0382354b 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -809,19 +809,34 @@ static void amd_e400_idle(void)
 	raw_local_irq_enable();
 }
 
+/*
+ * Intel and AMD Zen processors allow MWAIT early on.
+ */
+static inline bool early_mwait_supported(const struct cpuinfo_x86 *c)
+{
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return true;
+
+	if (c->x86_vendor == X86_VENDOR_AMD && cpu_has(c, X86_FEATURE_ZEN))
+		return true;
+
+	return false;
+}
+
 /*
  * Intel Core2 and older machines prefer MWAIT over HALT for C1.
  * We can't rely on cpuidle installing MWAIT, because it will not load
  * on systems that support only C1 -- so the boot default must be MWAIT.
  *
- * Some AMD machines are the opposite, they depend on using HALT.
+ * Even AMD Zen processors prefer MWAIT over HALT. But older AMD processors
+ * depend on HALT.
  *
  * So for default C1, which is used during boot until cpuidle loads,
- * use MWAIT-C1 on Intel HW that has it, else use HALT.
+ * use MWAIT-C1 on Intel and AMD HW that have it, else use HALT.
  */
 static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 {
-	if (c->x86_vendor != X86_VENDOR_INTEL)
+	if (!early_mwait_supported(c))
 		return 0;
 
 	if (!cpu_has(c, X86_FEATURE_MWAIT) || boot_cpu_has_bug(X86_BUG_MONITOR))
-- 
2.27.0

