Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ED4533A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241252AbiEYJow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbiEYJoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:44:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC63BC10;
        Wed, 25 May 2022 02:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQEKI8ilRrrd4TGPLXad0BtBTX81x4nSSPQyBQaavpomEihvJ4KnF8vK/hphj8DPaIMKmvcs8GmmVsPTu6Dv7iztoWfQaCBSxi2Z7OtA1Jh3pmAMiUkuX1NckRh7Gdz2Vsnsb3+/8Elx5AHjxzdCNb/jm2Eb9Y4w2xIxWu5fC8r2VUFxXAPQMPpGrXEVGjjWeUB+9BYh6hBIKnNMiS7J9VbcjOS3DQPJjEfBZSKsmQmkSXf+9vzEvz/N7eu4eMdL03cFNFNzFa/Jsd7B+awG1QY22WT9Hr9zO3jueRialtKZJGNNkWOv4epG0XONbaKHgcVZdmYlxqdaDAFC8ZPE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSuVjM3GfV77vfpVUhMGxfRGDciTOD9kouy1sVBao/E=;
 b=AMciFoUDnSfaLkv1AOpxDnJoKYZVAbGURXmUFGiBEKkNHONqLES1rRyURg+Hx+ngIJs0Vor6evGpD7n+83gFDbroYbOyGpiHsm/nDA7EjQ3YXXr6qy7Xrr9IO7Lq1v218wsDx3lV01J8A2OgWBmmNhLrIuixRwT6ODDmlMhZky95rxeoqsiWGTQiA66Y3Z8Bazziw/F0WZlAabvLZbBNzAs+RO6W1YhTLYYt7uyozjSF0uNMFKTXvWYWt8K0T6xYq0L9vLxUI7QJ18Aib6GdiCLtePHggqXxwjgICaB3qwA0bXRFbZ7wZtmCgyYi7V92Rwv2/wQHT2YfU4+XHdc/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSuVjM3GfV77vfpVUhMGxfRGDciTOD9kouy1sVBao/E=;
 b=Ke64TivC7ByrrH+AwDi9LhD40r5ZJBe+NDobYnoqVQ+VL4S/4eeRjKGr/ttxUP0jYS/bBEhOmL5BUi55+GevyYjtqyPNT9VwfvyFpA4QSJCHfv0h5gvxL/oZjvrYyUT5J2XZ6kBYTKUMjYzAj9ybYf52tXn8oR5rwdGkieP57Jg=
Received: from MWHPR07CA0003.namprd07.prod.outlook.com (2603:10b6:300:116::13)
 by BN6PR12MB1393.namprd12.prod.outlook.com (2603:10b6:404:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 25 May
 2022 09:44:14 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::c0) by MWHPR07CA0003.outlook.office365.com
 (2603:10b6:300:116::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 09:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:44:14 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:43:59 -0500
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
Subject: [PATCH 11/13] perf mem/c2c: Add load store event mappings for AMD
Date:   Wed, 25 May 2022 15:09:36 +0530
Message-ID: <20220525093938.4101-12-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525093938.4101-1-ravi.bangoria@amd.com>
References: <20220525093938.4101-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc165b41-42c5-41dc-fafc-08da3e332108
X-MS-TrafficTypeDiagnostic: BN6PR12MB1393:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1393FFEB74479631FDCC1EF3E0D69@BN6PR12MB1393.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+xBAxXpVmGeWQQ1NO83Efcq38cKxnRdUgA1+7M7xojhc+F0gIgdAf9HXylUGQ2Izk9T8W6GmSnZulvjFC76uAcFZHOUi2OWAbOZer78x4JWruhwIx7itd+ROYspq/n7E13oNpVqVDqZwFS+xn5m6pOrFXA5IRt8UaLiOeTcliW8xBwPZ9mfTh1S2DzYW2wAk9j7irFB813r3sWtyvcgbWOho2CqoxM6AAEbh1O++gPvBm2EeEW4wFz26dChT6H16Zkt4fYkh/rexy+HwIFYMVi9MZwZFp+h1WayovferkPxY5ILXTAnlnaqKFa6ibvnr7m5mxbInJ+QN4e9HjPRRV+bIsnN6lA9ogAORMVEJYwKAf6D222O/Wi7/cni8pMlhPBUao8yGiS6DDlJwPxFxk4JbTBPlP9YbNeWDZudmExwDhPyNFEFsrMNaC0u3b4U/UKCUqHaXUbTY1TkaHLhBpFVCfiP9bSbufc3XulUpm44LLMitbG5bFQPnA0QBRmxsyYlrZwAZjZo+DpLEBO736MdJDw+WoSUNmQV1i5hH4yWvb+nz18RPEUNTyjPp2/J6LE/JK1cMd9sQvkkom9KvCdxkvHlOFqcL6QFW4OvCI1hVJxUC6R6gM/hS4o1lWD4gmrTAdmZLGfWhwZACtY00D0rcCT7NH5Qd4z+tuJGdy1edc9XPqeofXRH4dgM8sWY7Owgp4J0PT5K6P37SX4oSO6Pp6pe3hAnttEF1M1Q6rVgyxtvx+PnsNkbfwx40wqFRoqDNL3FpXLnM2DtDbaDEKVEt+5JXEB8NeUv2Zp1Ij0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(5660300002)(44832011)(8936002)(7416002)(356005)(4326008)(966005)(81166007)(40460700003)(83380400001)(2906002)(70206006)(8676002)(2616005)(508600001)(186003)(316002)(110136005)(54906003)(426003)(16526019)(1076003)(336012)(47076005)(7696005)(70586007)(26005)(82310400005)(6666004)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:44:14.2493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc165b41-42c5-41dc-fafc-08da3e332108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1393
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

There are some limitations though: IBS does not have any filtering
capabilities which means many non-load/store samples are captured by
IBS which are immaterial for these tools. Such samples will be shown
as N/A in perf mem/c2c report. IBS, being an uncore pmu from kernel
point of view[1], does not support per process monitoring. Thus, perf
mem/c2c on AMD are currently supported in per-cpu mode only.

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
index 3b6a2c84ea02..b07f258ec6a5 100644
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

