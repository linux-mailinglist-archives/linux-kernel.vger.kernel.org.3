Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B004558FC5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiHKMeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKMeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:34:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9ABDF38;
        Thu, 11 Aug 2022 05:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1rvkpUnckP/tOIJ0/hmtTjpzrKyQCkJEHl9za6NxiYbVomgfV6ROa2tnVPEiGK/2r3C3BDML4kVjiBlegWLzl9JHvgeW6LQBT036A5S2A+m26Fokwji56waQ60Gcn5owMfVEcN/CNpywk2B6Eme6NcfYlS+JRPukCS/3E8bjeulW37OhTEc2PDfcB/ITarJ0oku6OUlmn7hMYgb8YW3jH7qErcwtmhoHXSJlquswabTZG1F9AstJT1dUugZ5JEhBjmnVNdu4T2t1ynv8XdRDuI94kdybd8RnLkpZuLupcxtr6gEEkJuImaaJOc81WaTePfKHaJgMDksxB5zmLrAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgSejP2fIr+1iG2vTY7E0mBP93zHzawB+panIjVatGE=;
 b=B9xVi7NTX+/F4ihBygGjdkMI3i83z5HRYyzctunKxxSZ8vozTScJYZDvmZbWyxc2MZKl3ptKF4pAa27upCl1IAjxEZoD23U4cZgYl32UHEm7TUVRSeoL3zBpjwUfSUL0Q1kyamsc0V2/6NhtOLf/uBqwv81j+PRrWIx24stL2pbrMW/9bIXiOb4yrpZap5XEQPcYB+goH94Yf2HuEYBIUWGLbjvFHPFyfKTvV/MwPJGQdYKKMPfJQMAnU3IjEMERUXJqrnyTSSFzkd0l8a1+u4VJP6yvJIXXszOFauB5z49Kiyh/emvBnMQqRiFMGEbHG7AoJoLYLkyMR3/5OGVZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgSejP2fIr+1iG2vTY7E0mBP93zHzawB+panIjVatGE=;
 b=Cy+0q4L0A/WRCxWGo6crPOzz13I/ALnWZ/3ChngtCMc0WpLYsPQaOozh2frCryBAOs9WJl1GMkY/0coupvyBCcvWlIAp/GtoEKDIhCBBHYD/z6DnY40jmZMx5JxMcYQF7r5/ntwU8E2/M7k8Jnw9Tqy5V8KvPNrWsxyxH3HGefg=
Received: from MW2PR2101CA0028.namprd21.prod.outlook.com (2603:10b6:302:1::41)
 by MN2PR12MB4784.namprd12.prod.outlook.com (2603:10b6:208:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 11 Aug
 2022 12:34:04 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::94) by MW2PR2101CA0028.outlook.office365.com
 (2603:10b6:302:1::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.6 via Frontend
 Transport; Thu, 11 Aug 2022 12:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:34:03 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:33:57 -0500
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
Subject: [PATCH 05/13] perf/x86/amd/lbr: Detect LbrExtV2 support
Date:   Thu, 11 Aug 2022 17:59:53 +0530
Message-ID: <fc6e45378ada258f1bab79b0de6e05c393a8f1dd.1660211399.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ade182f-4ce5-4574-79b8-08da7b95c673
X-MS-TrafficTypeDiagnostic: MN2PR12MB4784:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWfdpy+fjOXE3mlVocaFdlPRBPX6Tpguq7ZFqxBWoXHH4E4zA18xnBlKt5MzawT3WIvVIPHm5w+JpmeCQ+ziyAL46bxyu3TIFf8QqWgjVkn6psxiNw3d+8PcgfDEhG19pJzX7erCiP7ou9C56u7mo3TAe3r5YLc98sf+EkoV9JGQSsk9QbMEkXxe29GOA92JOFnaYFgnJog404jRx06Z2gkrz+afhYkj38odQLyYbG9sZjcrMtya2+m1bp7yFsAKYTrHuta5xoIewILwOg/9TtIalpx335m8ibUJd5Wcfb5PRzxXG6DRuf04kS44NowsFgSjlpl/dmV+FztoZzyOF/ZyK0OtrFgXIBeMVJEAubG00ZlQGV8RF5dIuDazMHex7W/dg11lvgthIMxY2Ue+X3OjbPqaUW6Hm8o22wtOargAwfYOSMvWs3qDPl9NhizlCklvbhIJTC5yRpZ/GJR2vxi/UBsUv7kQq5VBSBXpdusdC1NKvxZcArA8aMq3JoMXRojPuCmaXBtZnnCVpZrjX/DjGfybKziRLareqUwDnGVRqL9Y5Vn+9+29jFeQNk/XCwLAx+hL/GBDqmxtxnrSjJbFIkQYkDlJYMR4UiEO5j+8qHi47r6EIk8M/byWyLWDqKb8kqtZ/NnmH0KqIFmR2PhDAPDcSPzAS8F3clm4BFgdjNqjT0jSPUqTBViHMd4Hp9KSjzieIXG/S39rB/6Y7i1OzCaxfsCbTLtQ8qV39SuqaIkmP+MYC/+pQyp6COhWY6w9oE3tj2PSjJieNYXeMprE7l7qMm+hp13F0CxD62nTp7ZjULCl7swphEo1I5aAUd1DS9j1Luts27IAbFN0MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(40470700004)(36840700001)(2906002)(2616005)(82310400005)(356005)(36860700001)(86362001)(40460700003)(82740400003)(40480700001)(83380400001)(41300700001)(5660300002)(110136005)(54906003)(81166007)(8676002)(44832011)(8936002)(7416002)(7696005)(70586007)(336012)(6666004)(70206006)(4326008)(478600001)(186003)(47076005)(426003)(316002)(16526019)(36756003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:34:03.4271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ade182f-4ce5-4574-79b8-08da7b95c673
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4784
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Last Branch Record Extension Version 2 (LbrExtV2) is driven by Core PMC
overflows. It records recently taken branches up to the moment when the PMC
overflow occurs.

Detect the feature during PMU initialization and set the branch stack depth
using CPUID leaf 0x80000022 EBX.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/Makefile      |  2 +-
 arch/x86/events/amd/core.c        |  9 +++++----
 arch/x86/events/amd/lbr.c         | 21 +++++++++++++++++++++
 arch/x86/events/perf_event.h      |  2 ++
 arch/x86/include/asm/perf_event.h |  3 ++-
 5 files changed, 31 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/events/amd/lbr.c

diff --git a/arch/x86/events/amd/Makefile b/arch/x86/events/amd/Makefile
index b9f5d4610256..527d947eb76b 100644
--- a/arch/x86/events/amd/Makefile
+++ b/arch/x86/events/amd/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CPU_SUP_AMD)		+= core.o
+obj-$(CONFIG_CPU_SUP_AMD)		+= core.o lbr.o
 obj-$(CONFIG_PERF_EVENTS_AMD_BRS)	+= brs.o
 obj-$(CONFIG_PERF_EVENTS_AMD_POWER)	+= power.o
 obj-$(CONFIG_X86_LOCAL_APIC)		+= ibs.o
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index ef3520731a20..a3aa67b4fd50 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1374,10 +1374,11 @@ static int __init amd_core_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_PAIR;
 	}
 
-	/*
-	 * BRS requires special event constraints and flushing on ctxsw.
-	 */
-	if (boot_cpu_data.x86 >= 0x19 && !amd_brs_init()) {
+	/* LBR and BRS are mutually exclusive features */
+	if (amd_pmu_lbr_init() && !amd_brs_init()) {
+		/*
+		 * BRS requires special event constraints and flushing on ctxsw.
+		 */
 		x86_pmu.get_event_constraints = amd_get_event_constraints_f19h;
 		x86_pmu.sched_task = amd_pmu_brs_sched_task;
 		x86_pmu.limit_period = amd_pmu_limit_period;
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
new file mode 100644
index 000000000000..d240ff722b78
--- /dev/null
+++ b/arch/x86/events/amd/lbr.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/perf_event.h>
+#include <asm/perf_event.h>
+
+#include "../perf_event.h"
+
+__init int amd_pmu_lbr_init(void)
+{
+	union cpuid_0x80000022_ebx ebx;
+
+	if (x86_pmu.version < 2 || !boot_cpu_has(X86_FEATURE_LBREXT_V2))
+		return -EOPNOTSUPP;
+
+	/* Set number of entries */
+	ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
+	x86_pmu.lbr_nr = ebx.split.lbr_v2_stack_sz;
+
+	pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
+
+	return 0;
+}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 6d23e88d232c..a6cd83c57e8b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1230,6 +1230,8 @@ static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
 
 int amd_pmu_init(void);
 
+int amd_pmu_lbr_init(void);
+
 #ifdef CONFIG_PERF_EVENTS_AMD_BRS
 
 #define AMD_FAM19H_BRS_EVENT 0xc4 /* RETIRED_TAKEN_BRANCH_INSTRUCTIONS */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 34348ae41cdb..07844424aaea 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -207,7 +207,8 @@ union cpuid_0x80000022_ebx {
 	struct {
 		/* Number of Core Performance Counters */
 		unsigned int	num_core_pmc:4;
-		unsigned int	reserved:6;
+		/* Number of available LBR Stack Entries */
+		unsigned int	lbr_v2_stack_sz:6;
 		/* Number of Data Fabric Counters */
 		unsigned int	num_df_pmc:6;
 	} split;
-- 
2.34.1

