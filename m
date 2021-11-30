Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77B446348D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241845AbhK3MlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:41:24 -0500
Received: from mail-bn1nam07on2084.outbound.protection.outlook.com ([40.107.212.84]:38403
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241710AbhK3MlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:41:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqaN9EEck7oGxjm3HZ2aFmJJ7URBAHuRo9Mmz+ODOXsTnk++8XzSzUAv0bWq3MaI/VJMNzUsSJdaNnk8mP5EYWo1wAURNVPmTDNnqeH2MCtIGYPbVYgEEfsyVUnK5dsev4B96XXAmMHIbgYnlsjUrxtKYNSIhBk5lLLBXn++Db/zFhaKELDx4qGiZ06GxBEixPTyZKybh+qHKQPEj3laIcc8dpt56Y3cQdwAVrCxrP5NeTbpyibXOOowsEy6S2eS645AvdFgP0G6rjk77uMYRz3jX52bM5gZOZsfEsHIgvALlSo/LwVXyCDTQLzDZ+SwkgIsw5CuRBlN9S4iPxCX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaIQhV6ZO5Mhgfnyx9AKtXjRFarWiunj1JUA58iF7JY=;
 b=cjW7kwqLCOrqg2uxrwrNDsWL1vwRYF4cH+T4WYOSwij8xT+vydAqokQCB96WwRxABFaHb2+oHN85cTcyM+q8Dvx9AzRbDPqYdvHv7qYMdv+HocaKS4KtY2+O4twKAF4iWjd0gZtG6Y3a5keTGrvxOne0ffD6akRW+/vHy5JvZ7fJyxN/DZbe1uHUuA7rfm+LvqhKfydGLaNlbx/+UKOP391/mVIOTJ9EPWfYPtZVYZ83GEFYGHUhNd9xJ27JKX0wKJ3qRrNCaSCzOserv9idCMzeq5LQkgKjZMOidS9XP6xAYTvXrGlh/sqpB88lU4eKE0+EeQYXI7l0gwp83MGbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaIQhV6ZO5Mhgfnyx9AKtXjRFarWiunj1JUA58iF7JY=;
 b=PQA87mE9GaVZ81B53fLPkNoSMC3yxFZIou43qsdA8U3n+r9qfxAMfO7lob2zLg7fASv2eZS7bJopuYyJaZLpqYHJbbbFrBPVN7DqxpZkYEa9AxMncAqyv2kCT03MbNTtG62+0KRym5pZd1cUCmFKRkkMWe24DGTU8FcKCP5++EI=
Received: from BN9PR03CA0332.namprd03.prod.outlook.com (2603:10b6:408:f6::7)
 by DM5PR12MB1833.namprd12.prod.outlook.com (2603:10b6:3:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 12:37:44 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::12) by BN9PR03CA0332.outlook.office365.com
 (2603:10b6:408:f6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Tue, 30 Nov 2021 12:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:37:43 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:37:39 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
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
Subject: [PATCH v5 09/22] cpufreq: amd: add trace for amd-pstate module
Date:   Tue, 30 Nov 2021 20:36:28 +0800
Message-ID: <20211130123641.1449041-10-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130123641.1449041-1-ray.huang@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96306f62-5cfa-4854-6c63-08d9b3fe34c4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1833:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1833E386DB89DAAA2A559716EC679@DM5PR12MB1833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4UB27Qr5/d00KUUEArs9/Kae0XMvgYkeDmTxj0q9cu5/97DEpMcIIM6uXPIqGM8pzjZqzEgtNvSqIYc8+FZuHtV3K1eB5+yuqz+KI6+IwlJJXhe3tZJDQWxvq/CYJvI0TxPU3sNg3cdEh8qLbna+e3bmWxCDGf7F/MUzipwM/iQ3pjAUdeu/mt2Pv1X/P0sg5Sd58vpJb1iLW1y/Ale1TE00C6OKfmLY1srRo/FkXHIC/0LPAHRFSG/I90rrpTlW7/c30+Xw2RHmn33/2YxvJr/qKFUk2YSE2K6LUXKNdSfqcf8+2jQFQxiiHR9WmImykc3HToCJtkGcgDlWA5MHEnW1KhzPSc68j4yp4yJ4JtjqbkVeyX8kDp0dgAh3IwmyuJ6COcQ6BBQ/okr8d9SFo5apoE3Ts0+jWAqeDSjzT10zWVLL43OLcyR/sdWVQQk6X0Ljshv1Wnbp2LtJRETjpLcbxx/emZxCwClNfmk6iwlD5OMMOKdiv5gxz+q2EqrnggOP97aedvmFLyYO+FuNxziBZAc7QaiUg6SfwZZwM/f4FztozsLRdxGr5Q90DdtO9UgeiLAKIlEOn/UuocxoSnKkcdH/fGO12LvnnWbj/PpyqVcODPDKI38yBBA0piBajJYxlclgLqdgn/ZKUk1JLTAr7wtgW1GO+8ARAw5I+rZCPv89K65WSjKn20FjpSg65+SjEUambSlsBDIbsvCJNnDairMktuAnYGzHQAqkJ2RAynxnvWkmIJMcqJY7gQRkFF5sgU84N9LZS5O2g3+wZYktKWRl3gtSgiGhwtYoJ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(7696005)(2906002)(186003)(16526019)(426003)(70206006)(36756003)(508600001)(26005)(1076003)(86362001)(4326008)(82310400004)(5660300002)(70586007)(8936002)(8676002)(110136005)(6666004)(336012)(7416002)(316002)(54906003)(47076005)(356005)(36860700001)(81166007)(2616005)(40460700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:37:43.7559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96306f62-5cfa-4854-6c63-08d9b3fe34c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
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
index 68991c450fd5..72a4e2258fe7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -31,6 +31,7 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_device_id.h>
+#include "amd-pstate-trace.h"
 
 #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
 #define AMD_PSTATE_TRANSITION_DELAY	500
@@ -189,6 +190,9 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~REQ_MAX_PERF(~0L);
 	value |= REQ_MAX_PERF(max_perf);
 
+	trace_amd_pstate_perf(min_perf, des_perf, max_perf,
+			      cpudata->cpu, (value != prev), fast_switch);
+
 	if (value == prev)
 		return;
 
-- 
2.25.1

