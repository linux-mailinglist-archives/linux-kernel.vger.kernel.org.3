Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163A347EA0D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350616AbhLXBGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:06:42 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:51360
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350458AbhLXBGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:06:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqCO+kd153uocLhSQgsBMS/RcQqK4lQZY+8vRaJ4PvneF9WXTLqd3f5gjoiYYc1zSFg+3Z15TWJsJdCyTYqsFBoEEBCHsXBhmkhOb5bxQoHEvgrJHd/4r5JG04u4ID4YyvdEsXB2xGrmC4Y1bblJLcDtNqW4TvkUfnisxZstwJB+1iuHgNO9UMr2f/AZUNo+v53jYsGBK5HasPpOCpUiwN7LX6dWJdDlYpgeyTA8LsFFSM2vO8+aV4qoA7yrVODnoPPPNY4Jl2yvhtqrtKgk9nwjGg1JReuYGs2GB93kUV06k/JNWIl/XU1ZhzxXQuBsgWTBVES5mqUUHlqCv+sOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIu8TTFQvNoBuGVFVvUTiRSFusqNEuS4LIum8FGwcxc=;
 b=fzDWflO8ioAV2JZvkkITqLUPVgqFVjH03JNlchoXVquoU4oFvvH9qQFssh74rX2pF0mhOS0Y0ENHjDHTq4ymxmTHsIba66TEq5QWvMc/N5Xlk1GdJFnscFMM0up81hHSXpNQXBx+Z2ZEgXOPpXC8BGE1j7SMRt5fe0pFwcMSMCxz/CEYZloBG1sKp8NacrExcM68JHKDcnvK7MJ37Buxm348AGrGNlSMXeJ0at/ZGzzno12ilIrC4oHPmi48ZdIm9I2vKDH7Y9LVG026dF5dx9O3DbmxQvTAiI8QfrQsAEOdMjeo1F9iIFiWuXKLr12rkMwxgL1XHoYgunu2PVKd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIu8TTFQvNoBuGVFVvUTiRSFusqNEuS4LIum8FGwcxc=;
 b=yed6nQ2L67BfvzOwmIXM4z8SNQ7l+FY4eQoH3Tm978Sd8EgYkQqNP+Kkg6xVSdIQkn+cY1Bd0v3bshILFW8Wp70MDDw16e0m9gGK9pxJT5iNpot1JJKMYVtl1rlcOEL17gKgVL8DSLls19Fg5fwAHFj4ubn4Dtz6miOvu9VIGnU=
Received: from DM6PR06CA0060.namprd06.prod.outlook.com (2603:10b6:5:54::37) by
 DM6PR12MB3786.namprd12.prod.outlook.com (2603:10b6:5:14a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.20; Fri, 24 Dec 2021 01:06:31 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::75) by DM6PR06CA0060.outlook.office365.com
 (2603:10b6:5:54::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Fri, 24 Dec 2021 01:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 01:06:31 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 19:06:26 -0600
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
Subject: [PATCH v7 09/14] cpufreq: amd-pstate: Add trace for AMD P-State module
Date:   Fri, 24 Dec 2021 09:05:03 +0800
Message-ID: <20211224010508.110159-10-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224010508.110159-1-ray.huang@amd.com>
References: <20211224010508.110159-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c8070a2-4a7b-4c22-f9ad-08d9c6799f20
X-MS-TrafficTypeDiagnostic: DM6PR12MB3786:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3786B7A162417996153330A4EC7F9@DM6PR12MB3786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBXnn/BPt1FSrcHbzTmQ3R6Fb6y4DauQzwgfP/kp1iYmuyqx5dpLPmE1brlU9tNKsXhO84mp7f3DDXJhzR2MbKwah2+FcpUrAPD0/Uk+/b3IB8qPGxTB2ma8JbBzlg63Jz1uvo+V1ohU7YZjHfQes1y+dG68L4dfdlZAU8/iEhB3Vu5qZX4y6ojqKMIYyItVk0j58GQlvSYFDRHxHpHTmQKwFkSRKZiMhuA/cZij5Fiw8u0VAYs/eyQ84WIzsSlJl3/5GvpsSSL2cJnGuImVH1cD1CGJTv4X7+Hr3l8JXKP7UJNYpSWvID5RtlbOsOiCbX18Te0u6J3a4Ln+ybu6tFw4WcwUMSTLddVFW3iL1z+YRwyp684x3h8cfOp+flENjQ4QVc6mIa39f+UxlWwLs1Z0mOW5NRt0uRwZA6/vStoNzBvApnk0JDiNxpwXm388W9cUXdqttxF8eF8KJ8NKPcrXBLVwnxrlen+jp2ZWfmsJlq8QrLskiANBAzrgB379WsP11faL5k1WrAiie1TipXfYm3rqXeML9z5+DbrQJOOuCZ/k7UjPu79RY8UwHH0fpfZA++XJm4avKqnOkrlfY0fOHvZq7YI0vFoyH7CG2O17o814C9zlSr99hZQGw3OkWDmiRa+/zXvvBX3TfQBmHo5Jf04Vx+trbC/T2RZ4cMm8Y2nqfnX8A2/JD0WNinZPqz8ffRxmzE8XoOqEilxARcZxm2fY3OgH8fDKk56HzgSxEe8ELSqhD0ELTOh5UgJRlEedPlDXt16/314rzKmSvDs1WflBziblURljGaQfIFM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(8936002)(47076005)(110136005)(2616005)(6666004)(83380400001)(54906003)(2906002)(426003)(336012)(16526019)(36756003)(316002)(36860700001)(8676002)(508600001)(86362001)(40460700001)(7696005)(70586007)(7416002)(26005)(356005)(5660300002)(81166007)(70206006)(4326008)(186003)(1076003)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 01:06:31.1935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8070a2-4a7b-4c22-f9ad-08d9c6799f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3786
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
index cc62f7484007..63efd5de98a2 100644
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
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
+	trace_amd_pstate_perf(min_perf, des_perf, max_perf,
+			      cpudata->cpu, (value != prev), fast_switch);
+
 	if (value == prev)
 		return;
 
-- 
2.25.1

