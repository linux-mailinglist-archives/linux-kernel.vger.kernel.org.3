Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C5847A15C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbhLSQgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:36:47 -0500
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:33408
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233242AbhLSQgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:36:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVSs8ysJ1sOAy4RkgoAopePp9mJK5HRnyObFAN5qpT/bWcF1UT7krK2ASyHTJq9Z6f6NDWiYEysdbHwKR23OZQ3wByMG9DofW5JuYMambCk94jUIkiypRRuWswgouc3U0ueUoC5Z6m3e/7JNzO6EQaykUhF+RzYJPNADyk1GSch27sNd9Bdn9M/R+JDmAtYBpSaiRNgHgbPg+Y3fGFhuVBXCL1/GoGM1p1jDHVV0uQB1S8gxd7lWO+8xjhL0RvHm8Y8bHH5/HhiezEfljtaMLoahdKy6hrWhzEeQjl8oub6G84z9D8UPINfxVr3gim5mlLE01zjtlImOOD2PSumJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9tzQyaRzYBPxFz5y4SUrWigvn/BifH9eIh6YGHrdc4=;
 b=hEr2APLTSht3NwFfQn57FRbGyx8VRCu9NLYGC421PODqu4b9k2tDQTVV1Fny2sHlPWhoyYyRv9vBfTKEnNp8nopdrXgRazfm6eYCUrkr0AQVUlkQmPAHPzPnbiXq2OD6svHdtVTYAnokczNCqFt3qVvDrBE0EenOAnVoGEmNYiXEKs8iePl7E5SvKoTm0sGLeO7Jvx1YWoGcC1EDYjEKVlvwty2V9rvtl5x3z84RC2BlKHFY14855XLztc71cOwPs0oUmaMgxTNPa/ubbpoPR5h0mO5G+UeEZ2+Xdr66p9MA5EEm0+Ej+Ls4FLF/fk24OCYMd1vUAIZQVukXRyYtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9tzQyaRzYBPxFz5y4SUrWigvn/BifH9eIh6YGHrdc4=;
 b=sOjmd11vS8H64RB4iBJMSNJo0umziOtx7FlCIXl9FhhlJx0NGkIhMTiUw+YvycSbtb2d24UG7LZng+zyGPZkuTazLScOMW2Och+WgjjwJHQ27mFb2vVOHQCM59Hgfef3lvoXWPivQqPi3jmhKVCX/iSORKCPRytPgI77IEVAlTc=
Received: from BN6PR13CA0005.namprd13.prod.outlook.com (2603:10b6:404:10a::15)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Sun, 19 Dec
 2021 16:36:40 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::ef) by BN6PR13CA0005.outlook.office365.com
 (2603:10b6:404:10a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.10 via Frontend
 Transport; Sun, 19 Dec 2021 16:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:36:40 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:36:35 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v6 09/14] cpufreq: amd-pstate: add trace for AMD P-State module
Date:   Mon, 20 Dec 2021 00:35:23 +0800
Message-ID: <20211219163528.1023186-10-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211219163528.1023186-1-ray.huang@amd.com>
References: <20211219163528.1023186-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 064c7fe3-2a5f-43f8-67f9-08d9c30dbc21
X-MS-TrafficTypeDiagnostic: SA0PR12MB4559:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB455907EA9B19D66377440D41EC7A9@SA0PR12MB4559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxHmHpc0v/uafJHd8PqGAnHC5ygmGXl9hJMj6DuJItb2OkwwJtLt++Wm26WC57IVoeF3IdFs5f8CeyhnmiLJ5szXqjfWNLyqUrlEKjdfa3nA9icUIjmnHh34FME1rEPxqmBR80mK1pU2BmdbzTPMHeZAwjXK5cfpUPYTXj/bVl2Kq+B2CJIVbPVcYbvsTdIoSPeqLVpc7/W12kNwXUGAVH/A65agBY9ML0RDK9X0zhCBkxATFN6Ovu3yGiyvt/ARLOXRDwtM6jRS0DcWiPTEco3zMvrMl6zcSG5juLyYW5vPHjGB1/A9Do8aac6U9ctWw3b4KWYOXj+qHLFpwIGeszEqIQN6+Fj3M8Ubtl2PGhqlaTzyRUFG7Z8NKn4+b2RFLAXIEhU/nezoikImMlDPS7r0PebYDhMx0PazGM/2WMNWDcHSziKvsloputVBfJfY6OHZEMs2MMH1GJ9EJKkGqCOxju344QDNqtBPtrRnul4uWgQzfrwyjR1bPuKuyseTuQ9GCkYEnq+e/TrY3LqwMbVRohZHp4hdFMMHKPxO6UVPIT9gGHO9yThA0ZKJOvIAvhL5x6L/BO7TZEW1qwWCTelXLLjxWVP/lMjQ0428saHmXoHA2Y6Kd45h61iKpoA2v0rQyh/GrF0LGvUbL1FxHBTnlofNBOLlggQI8MXNG0YC9hrT6HbpIVVWJMWK9i+aCo88aTNozma9hJgntYBfyyemKyDS5egFk9DVBx7OWtL3d1y2dX5mE47rznUH2x0CBHTuS240cETh8XSP0g5wIIAKHHc+VgW1UUzX11FeipQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(4326008)(110136005)(186003)(8676002)(2616005)(70206006)(8936002)(16526019)(5660300002)(47076005)(54906003)(316002)(356005)(26005)(86362001)(6666004)(70586007)(7696005)(82310400004)(81166007)(36756003)(426003)(508600001)(36860700001)(83380400001)(40460700001)(2906002)(336012)(1076003)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:36:40.7488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 064c7fe3-2a5f-43f8-67f9-08d9c30dbc21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trace event to monitor the performance value changes which is
controlled by cpu governors.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/Makefile           |  6 ++-
 drivers/cpufreq/amd-pstate-trace.c |  2 +
 drivers/cpufreq/amd-pstate-trace.h | 77 ++++++++++++++++++++++++++++++
 drivers/cpufreq/amd-pstate.c       |  4 ++
 4 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpufreq/amd-pstate-trace.c
 create mode 100644 drivers/cpufreq/amd-pstate-trace.h

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index c8d307010922..285de70af877 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -17,6 +17,10 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
 obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
 obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 
+# Traces
+CFLAGS_amd-pstate-trace.o               := -I$(src)
+amd_pstate-y				:= amd-pstate.o amd-pstate-trace.o
+
 ##################################################################################
 # x86 drivers.
 # Link order matters. K8 is preferred to ACPI because of firmware bugs in early
@@ -25,7 +29,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 # speedstep-* is preferred over p4-clockmod.
 
 obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
-obj-$(CONFIG_X86_AMD_PSTATE)		+= amd-pstate.o
+obj-$(CONFIG_X86_AMD_PSTATE)		+= amd_pstate.o
 obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
 obj-$(CONFIG_X86_PCC_CPUFREQ)		+= pcc-cpufreq.o
 obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
diff --git a/drivers/cpufreq/amd-pstate-trace.c b/drivers/cpufreq/amd-pstate-trace.c
new file mode 100644
index 000000000000..891b696dcd69
--- /dev/null
+++ b/drivers/cpufreq/amd-pstate-trace.c
@@ -0,0 +1,2 @@
+#define CREATE_TRACE_POINTS
+#include "amd-pstate-trace.h"
diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
new file mode 100644
index 000000000000..647505957d4f
--- /dev/null
+++ b/drivers/cpufreq/amd-pstate-trace.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * amd-pstate-trace.h - AMD Processor P-state Frequency Driver Tracer
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
+ *
+ * Author: Huang Rui <ray.huang@amd.com>
+ */
+
+#if !defined(_AMD_PSTATE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _AMD_PSTATE_TRACE_H
+
+#include <linux/cpufreq.h>
+#include <linux/tracepoint.h>
+#include <linux/trace_events.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM amd_cpu
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE amd-pstate-trace
+
+#define TPS(x)  tracepoint_string(x)
+
+TRACE_EVENT(amd_pstate_perf,
+
+	TP_PROTO(unsigned long min_perf,
+		 unsigned long target_perf,
+		 unsigned long capacity,
+		 unsigned int cpu_id,
+		 bool changed,
+		 bool fast_switch
+		 ),
+
+	TP_ARGS(min_perf,
+		target_perf,
+		capacity,
+		cpu_id,
+		changed,
+		fast_switch
+		),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, min_perf)
+		__field(unsigned long, target_perf)
+		__field(unsigned long, capacity)
+		__field(unsigned int, cpu_id)
+		__field(bool, changed)
+		__field(bool, fast_switch)
+		),
+
+	TP_fast_assign(
+		__entry->min_perf = min_perf;
+		__entry->target_perf = target_perf;
+		__entry->capacity = capacity;
+		__entry->cpu_id = cpu_id;
+		__entry->changed = changed;
+		__entry->fast_switch = fast_switch;
+		),
+
+	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu cpu_id=%u changed=%s fast_switch=%s",
+		  (unsigned long)__entry->min_perf,
+		  (unsigned long)__entry->target_perf,
+		  (unsigned long)__entry->capacity,
+		  (unsigned int)__entry->cpu_id,
+		  (__entry->changed) ? "true" : "false",
+		  (__entry->fast_switch) ? "true" : "false"
+		 )
+);
+
+#endif /* _AMD_PSTATE_TRACE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#include <trace/define_trace.h>
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 25d4f0563a84..fa2268df4f2e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -44,6 +44,7 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_device_id.h>
+#include "amd-pstate-trace.h"
 
 #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
 #define AMD_PSTATE_TRANSITION_DELAY	500
@@ -220,6 +221,9 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~REQ_MAX_PERF(~0L);
 	value |= REQ_MAX_PERF(max_perf);
 
+	trace_amd_pstate_perf(min_perf, des_perf, max_perf,
+			      cpudata->cpu, (value != prev), fast_switch);
+
 	if (value == prev)
 		return;
 
-- 
2.25.1

