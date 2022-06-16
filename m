Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB40454E043
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376319AbiFPLw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376388AbiFPLwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:52:53 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BF211142;
        Thu, 16 Jun 2022 04:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iwc+gR0NUnSG5eOsgojqOkJ/EwjcygQPUekza0gcdvEK4V5hsXj2YYu0FO8G3WCaJMzmYo84AQD2OPSjPgTNa3o6URfbCIP7HUak1ZEA7tOj4g9YQLHkYy6GuXDOQQuOlFcJshsSY5rQmiDSFJ00b0/XYy6/mPOKy1KxjzaN2MskZsmbIpFR6sY3qdLLgux2pUAg588Tx2W4QAZn/etXZbAQW6BfY4SWbIyuERTKWZmPu4QNscFQLbaw12ULVg7gpchJd+Bj0LzC6Ve7YKfCrqzEZAsmV69Z7g7h88cBgIPJBZtRWQdX559Phc/+Zq2LOu83xc7hrEwNALneH2s9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKLakMdrkAVu9f32gxCSS2Cz4DX5ANfhmki/GiOHOIw=;
 b=Iz/s8XsMwrSipZW6YgvrZSnovQMVJd9XzJgq9/MYnzn/U16JVkilPuYtkU/z4ay9rnXwmpaLwk/LmJP6wZ/+B17aRFOu7FYCHW1solMIj/PTgYGU+gDRQhySHmlx2oWDpQFk/o1qK7xOm+qcCaJkbJc0v72NRxNoYpSbtXFqvll4uyVnBf4A39qJwmKIRP+PJ5rXL6gwYQxyBzcy2WRObphr+9SbvzAT7+hmFGy0uCe9mLjZlOBQ2AaOAbSSF8pAndtpE3Ruex5EcyYuj9JEkp+nORqWmw6mtQ0EfrGrESTUOUEbhvJFmM6BjODt5UagKtAGM0jCan84TB1QgjXP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKLakMdrkAVu9f32gxCSS2Cz4DX5ANfhmki/GiOHOIw=;
 b=qt5yFERSrFp9AeCQ42uEQfOXSyg4uvRR8rbbFmuxlfCiukU2Qmw3PUz2mfzgY8S9KI/VhmdieEB37DYU/dX0zxdBhqBg8YovKhFHsC3bF1qPWUTKdKMi/XhT6fLPMvY1wvZPOY1IJam3mA0XOG+rSXSpZGX3oDDY0P8U/Ofj/Gw=
Received: from MW4P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::24)
 by DM6PR12MB2649.namprd12.prod.outlook.com (2603:10b6:5:49::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 11:52:46 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::46) by MW4P221CA0019.outlook.office365.com
 (2603:10b6:303:8b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Thu, 16 Jun 2022 11:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:52:45 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:52:34 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 11/14] perf mem/c2c: Add load store event mappings for AMD
Date:   Thu, 16 Jun 2022 17:22:04 +0530
Message-ID: <20220616115207.1143-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616115207.1143-1-ravi.bangoria@amd.com>
References: <20220616113638.900-1-ravi.bangoria@amd.com>
 <20220616115207.1143-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 063e82da-f315-4050-d491-08da4f8eba68
X-MS-TrafficTypeDiagnostic: DM6PR12MB2649:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2649E99D8EC52A9DF13582DFE0AC9@DM6PR12MB2649.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EtIjMhVHzqvlMUxwspJQRDXCkA61RCdPfx1VU5Munu83L4gbqXqM/Kn/OvsF4Nmcp1nlVvfEbj4mmtR9V53x0y/LR5Ew0DWIIPxspzPjblQ7QJvOVewNh59B+MWFqECBXOBL+XIHYtW9Q8PjQAMvLKs/lPE6oDMigGDuIrRC1yfX/R4gL47yrEmp1rGhPGNNJxOhaROAqLysGIcfraczcqhBd6OaTKmCsLB944gfm8TN0N1Ef3Pjrq3u3BZKRz7iHWrh1uK1aY12lJt0qxAJewv9wwynRfPcc4IZSy6VDCiBBw3/xUVLXSceuop8A1O8mCzgjarjpkqHWGG1VWiNyGEPTeTq2WrkxLBfcgsetKm1bM19d2Ko3ImrL6pA0cDMGiv/jKl1gzXsEXiLWMAJOE9mr6GDDv6tDG2hc8mlEUHFymUFMPLkaL8VwBLvcRRR1JBJ3oS8cEvYrgMyaN9yIqri9bnhgnHtjuk5IYY/OvXdBlreOjzu8z7EEYsdJ3ZxYmUyvYnIfK0Qinoo2hjtqnhMuK+MbVxsQcFINFDx/nAi4VzaQW5+pJIg+iKJgyIoC8UgPkhNvB71xh0hCFrbTMlxIDCgxVFecbxseDZpGVe7105aBhiyjLzWF3Eo+kCJbo+u3r/gTa2RlCjs/PVpCYIygHGteJEi7TeLXpAmTD3TZc87SnBke9pHRj5hUXqeBzpGWBh2yCoH0nJ2sVjRIBx7+E4QTesNxnsi+Vkxy3phOrPSsOpynCEtg+maEqr8SnL86mxzCFtFE6X6enjnHskx5f3ybuQDxC4GfPaCXak=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(82310400005)(83380400001)(44832011)(8936002)(36756003)(86362001)(4326008)(70206006)(2616005)(54906003)(316002)(110136005)(8676002)(81166007)(508600001)(16526019)(70586007)(6666004)(356005)(2906002)(5660300002)(7416002)(336012)(186003)(1076003)(40460700003)(426003)(47076005)(966005)(26005)(36860700001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:52:45.5854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063e82da-f315-4050-d491-08da4f8eba68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf mem and c2c tools are wrappers around perf record with mem load/
store events. IBS tagged load/store sample provides most of the
information needed for these tools. Wire in ibs_op// event as mem-ldst
event for AMD.

There are some limitations though: Only load/store instructions provide
mem/c2c information. However, IBS does not provide a way to choose a
particular type of instruction to tag. This results in many non-LS
instructions being tagged which appear as N/A. IBS, being an uncore pmu
from kernel point of view[1], does not support per process monitoring.
Thus, perf mem/c2c on AMD are currently supported in per-cpu mode only.

Example:
  $ sudo ./perf mem record -- -c 10000
  ^C[ perf record: Woken up 227 times to write data ]
  [ perf record: Captured and wrote 58.760 MB perf.data (836978 samples) ]

  $ sudo ./perf mem report -F mem,sample,snoop
  Samples: 836K of event 'ibs_op//', Event count (approx.): 8418762
  Memory access                  Samples  Snoop
  N/A                             700620  N/A
  L1 hit                          126675  N/A
  L2 hit                             424  N/A
  L3 hit                             664  HitM
  L3 hit                              10  N/A
  Local RAM hit                        2  N/A
  Remote RAM (1 hop) hit            8558  N/A
  Remote Cache (1 hop) hit             3  N/A
  Remote Cache (1 hop) hit             2  HitM
  Remote Cache (2 hops) hit            10  HitM
  Remote Cache (2 hops) hit             6  N/A
  Uncached hit                         4  N/A

[1]: https://lore.kernel.org/lkml/20220113134743.1292-1-ravi.bangoria@amd.com

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/Documentation/perf-c2c.txt | 14 ++++++++----
 tools/perf/Documentation/perf-mem.txt |  3 ++-
 tools/perf/arch/x86/util/mem-events.c | 31 +++++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 6f69173731aa..32d173fb6541 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -19,9 +19,10 @@ C2C stands for Cache To Cache.
 The perf c2c tool provides means for Shared Data C2C/HITM analysis. It allows
 you to track down the cacheline contentions.
 
-On x86, the tool is based on load latency and precise store facility events
+On Intel, the tool is based on load latency and precise store facility events
 provided by Intel CPUs. On PowerPC, the tool uses random instruction sampling
-with thresholding feature.
+with thresholding feature. On AMD, the tool uses IBS op pmu (due to hardware
+limitations, perf c2c is not supported on Zen3 cpus).
 
 These events provide:
   - memory address of the access
@@ -49,7 +50,8 @@ RECORD OPTIONS
 
 -l::
 --ldlat::
-	Configure mem-loads latency. (x86 only)
+	Configure mem-loads latency. Supported on Intel and Arm64 processors
+	only. Ignored on other archs.
 
 -k::
 --all-kernel::
@@ -133,11 +135,15 @@ Following perf record options are configured by default:
   -W,-d,--phys-data,--sample-cpu
 
 Unless specified otherwise with '-e' option, following events are monitored by
-default on x86:
+default on Intel:
 
   cpu/mem-loads,ldlat=30/P
   cpu/mem-stores/P
 
+following on AMD:
+
+  ibs_op//
+
 and following on PowerPC:
 
   cpu/mem-loads/
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 66177511c5c4..005c95580b1e 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -85,7 +85,8 @@ RECORD OPTIONS
 	Be more verbose (show counter open errors, etc)
 
 --ldlat <n>::
-	Specify desired latency for loads event. (x86 only)
+	Specify desired latency for loads event. Supported on Intel and Arm64
+	processors only. Ignored on other archs.
 
 In addition, for report all perf report options are valid, and for record
 all perf record options.
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index 5214370ca4e4..f683ac702247 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/pmu.h"
+#include "util/env.h"
 #include "map_symbol.h"
 #include "mem-events.h"
+#include "linux/string.h"
 
 static char mem_loads_name[100];
 static bool mem_loads_name__init;
@@ -12,18 +14,43 @@ static char mem_stores_name[100];
 
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
 
-static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
+static struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] = {
 	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads"),
 	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores"),
 	E(NULL,			NULL,				NULL),
 };
 
+static struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
+	E(NULL,		NULL,		NULL),
+	E(NULL,		NULL,		NULL),
+	E("mem-ldst",	"ibs_op//",	"ibs_op"),
+};
+
+static int perf_mem_is_amd_cpu(void)
+{
+	struct perf_env env = { .total_mem = 0, };
+
+	perf_env__cpuid(&env);
+	if (env.cpuid && strstarts(env.cpuid, "AuthenticAMD"))
+		return 1;
+	return -1;
+}
+
 struct perf_mem_event *perf_mem_events__ptr(int i)
 {
+	/* 0: Uninitialized, 1: Yes, -1: No */
+	static int is_amd;
+
 	if (i >= PERF_MEM_EVENTS__MAX)
 		return NULL;
 
-	return &perf_mem_events[i];
+	if (!is_amd)
+		is_amd = perf_mem_is_amd_cpu();
+
+	if (is_amd == 1)
+		return &perf_mem_events_amd[i];
+
+	return &perf_mem_events_intel[i];
 }
 
 bool is_mem_loads_aux_event(struct evsel *leader)
-- 
2.31.1

