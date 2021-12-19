Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59A347A157
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhLSQgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:36:35 -0500
Received: from mail-dm3nam07on2082.outbound.protection.outlook.com ([40.107.95.82]:34368
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236160AbhLSQgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:36:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiGHSc7+Zr0kLP4G+cEdBkIcSnU0sdtOq2n9c81r1WV1qQCoUH7y03J4iYqd888S4yIo/nVzIg+JeT5NDXWayDTXOmIjCGi/6gu04CoGUXefOrka4TpL5Qd7EA8st3y50AxM+8ZqttmZfHFvmuqJkADkkCrXNF1Awb1UtXB9SKg2i7+TAIXjCY/+/GOClZ+EJRVtAbL3Cu3jG3xlWNw1EJrw/5ZU93GC9RgrCdpllkZIFZ6P5hSxZiAUCK5wjEpgltYOqBU1tcU8DTaeggIHpz6Rrp9IfRO/KJYxdUIHP/RXntuuZxf4WhUHEy0bqpqAAcVoBTqkWw5TMQOVmD9NEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/YZNx8dqWVW8i5iymqkkyOg0pOd6Z0GSAuyX5YSmX0=;
 b=RsQTVPelB03AXr1Z2HVNM4vt5AfU54c0wrEUnJnESmitbzN91+/7fmA9VTeGeUBUYK72RkKsR3ElCjM1vjTajh+8Bb76uE4/BmifhruddQtrlrwL5kbEQRc7TjDyMTwsmAgxHYf/O2coc9IdW7Nk2uyEbYhBpUENHNqdgJh4eZL8xc7JWGPUNy3J1OBznsJMuCJrF/ywVObD2QgsiMgrkaV0G+Ck3clNOlCa/Lk3aGOos7F6CunsXr8NX9cS/bSG6eGOICB61E3A1geYlfuGP/n2yIW7tzM9EPym+Cg1Sja8ulhrbUZ82Saf4sCCcP59grCRbmzKSXNZBpgmWOHNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/YZNx8dqWVW8i5iymqkkyOg0pOd6Z0GSAuyX5YSmX0=;
 b=MCwaNQE5LzD/ErFe4nz5pq5ahTghWoPYgxrF+VpsKt/ajux4DcFykWRT/CdWQhXYXgDnP7DSw0jt9qsIoTXsQsXF5JHQB8A9Yd1nKpQe6b0fbYDqB5aymJMPfq6oK54nTezfy+ZXYof4CoqRZk3p7IQwsPrWqDFEOx71xI0Wgcs=
Received: from BN9PR03CA0552.namprd03.prod.outlook.com (2603:10b6:408:138::17)
 by CH2PR12MB3655.namprd12.prod.outlook.com (2603:10b6:610:25::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Sun, 19 Dec
 2021 16:36:26 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::6e) by BN9PR03CA0552.outlook.office365.com
 (2603:10b6:408:138::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Sun, 19 Dec 2021 16:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:36:26 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:36:21 -0600
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
Subject: [PATCH v6 06/14] cpufreq: amd-pstate: introduce a new AMD P-State driver to support future processors
Date:   Mon, 20 Dec 2021 00:35:20 +0800
Message-ID: <20211219163528.1023186-7-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9c9e2837-a75a-4d28-83ea-08d9c30db3bb
X-MS-TrafficTypeDiagnostic: CH2PR12MB3655:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3655EECE9C049CAC37699068EC7A9@CH2PR12MB3655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLRneR8wotzaQbpj1U38WZCckYgQP4jFE0N9/pjFUbh6ITMmbV+vaFTX2oAlxOAkCildDwiliUyTcphqj5rnDoNZ+2wnzb77qK+uUdiZCSZMuLc/nQD6vI1crWMxknfFqw0P0zzOlAyEhb+aU6nZS6MSyQY27hpFDqBc3vpWsewLhei6LONozcXT/ZUBk6zEWHKPJr19qNfPoGC4PtvZY0XycvWihbXQzqtsYME/yDQbmnCGUaQ8PP/q5NCO53KzvndfdRYlqJLf/JSifXvH044jrLTswFurGuJcTS0/FD+B5owB9YaXEBuS3k4QDwigeY/eCbrp2g0tCve17YSjpscWjvzc0oa+WgVcgvEDn+ULblpJYRxI1SLpVRzZS25bDo/uk5lWAvYUvKdy7kEGVDkBywm9ixuiMaZLTAWny9qS8fCRYEVsqd86JN+BbnBbd7djkRTrbQMsGRZCwXjD/sQg2gScrP0baQQXJpoKmn7KC99fXvS8oQ4Ewr0L4zbi6KFWuioFTR788iXK/168sBKQ7tq8rxUm9ppu6+NBlAi9Ayke4EqqPzfbNczYS9nZLzq6YOI+LztskCx6jYJ8XvuSsLXgkSuDwx2XafUoA4tB30FsKPp83EFT9ChN0wlicCABLTmuYKXKjt3c5dhxT5FToaeEYa2+SuUViz2zgzpcOBElJH4+8CkUPTQWAHgf0ZB4KuBcl/KImUMtcKFzVmSnmEciFBfMKZ1+SXZDv80OuR52nejcijMtrCE94+wVLgZTfVwIVHxCkb1SnE3bKUsJCYUaQqbTMeTeOB8Sq5p9SmjCUf4dL9R/2lX2dVDqJeNW3sXJQ9RpVTG3DYCotUbIDxP7W98dlV3rQEhcGXeUhcslmbWSJ6/yb92M+zgT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(426003)(86362001)(26005)(186003)(16526019)(2616005)(36756003)(30864003)(7416002)(336012)(1076003)(316002)(2906002)(110136005)(8676002)(7696005)(508600001)(70586007)(36860700001)(70206006)(966005)(83380400001)(82310400004)(47076005)(356005)(40460700001)(81166007)(5660300002)(8936002)(54906003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:36:26.6725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9e2837-a75a-4d28-83ea-08d9c30db3bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3655
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD P-State is the AMD CPU performance scaling driver that introduces a
new CPU frequency control mechanism on AMD Zen based CPU series in Linux
kernel. The new mechanism is based on Collaborative processor
performance control (CPPC) which is finer grain frequency management
than legacy ACPI hardware P-States. Current AMD CPU platforms are using
the ACPI P-states driver to manage CPU frequency and clocks with
switching only in 3 P-states. AMD P-State is to replace the ACPI
P-states controls, allows a flexible, low-latency interface for the
Linux kernel to directly communicate the performance hints to hardware.

AMD P-State leverages the Linux kernel governors such as *schedutil*,
*ondemand*, etc. to manage the performance hints which are provided by CPPC
hardware functionality. The first version for AMD P-State is to support one
of the Zen3 processors, and we will support more in future after we verify
the hardware and SBIOS functionalities.

There are two types of hardware implementations for AMD P-State: one is full
MSR support and another is shared memory support. It can use
X86_FEATURE_CPPC feature flag to distinguish the different types.

Using the new AMD P-State method + kernel governors (*schedutil*,
*ondemand*, ...) to manage the frequency update is the most appropriate
bridge between AMD Zen based hardware processor and Linux kernel, the
processor is able to adjust to the most efficiency frequency according to
the kernel scheduler loading.

Please check the detailed CPU feature and MSR register description in
Processor Programming Reference (PPR) for AMD Family 19h Model 51h,
Revision A1 Processors:

https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/Kconfig.x86  |  17 ++
 drivers/cpufreq/Makefile     |   1 +
 drivers/cpufreq/amd-pstate.c | 386 +++++++++++++++++++++++++++++++++++
 3 files changed, 404 insertions(+)
 create mode 100644 drivers/cpufreq/amd-pstate.c

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 92701a18bdd9..a951768c3ebb 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -34,6 +34,23 @@ config X86_PCC_CPUFREQ
 
 	  If in doubt, say N.
 
+config X86_AMD_PSTATE
+	tristate "AMD Processor P-State driver"
+	depends on X86
+	select ACPI_PROCESSOR if ACPI
+	select ACPI_CPPC_LIB if X86_64 && ACPI
+	select CPU_FREQ_GOV_SCHEDUTIL if SMP
+	help
+	  This driver adds a CPUFreq driver which utilizes a fine grain
+	  processor performance frequency control range instead of legacy
+	  performance levels. _CPC needs to be present in the ACPI tables
+	  of the system.
+
+	  For details, take a look at:
+	  <file:Documentation/admin-guide/pm/amd-pstate.rst>.
+
+	  If in doubt, say N.
+
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
 	depends on ACPI_PROCESSOR
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 48ee5859030c..c8d307010922 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 # speedstep-* is preferred over p4-clockmod.
 
 obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
+obj-$(CONFIG_X86_AMD_PSTATE)		+= amd-pstate.o
 obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
 obj-$(CONFIG_X86_PCC_CPUFREQ)		+= pcc-cpufreq.o
 obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
new file mode 100644
index 000000000000..70b69c660192
--- /dev/null
+++ b/drivers/cpufreq/amd-pstate.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * amd-pstate.c - AMD Processor P-state Frequency Driver
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
+ *
+ * Author: Huang Rui <ray.huang@amd.com>
+ *
+ * AMD P-State introduces a new CPU performance scaling design for AMD
+ * processors using the ACPI Collaborative Performance and Power Control (CPPC)
+ * feature which works with the AMD SMU firmware providing a finer grained
+ * frequency control range. It is to replace the legacy ACPI P-States control,
+ * allows a flexible, low-latency interface for the Linux kernel to directly
+ * communicate the performance hints to hardware.
+ *
+ * AMD P-State is supported on recent AMD Zen base CPU series include some of
+ * Zen2 and Zen3 processors. _CPC needs to be present in the ACPI tables of AMD
+ * P-State supported system. And there are two types of hardware implementations
+ * for AMD P-State: 1) Full MSR Solution and 2) Shared Memory Solution.
+ * X86_FEATURE_CPPC CPU feature flag is used to distinguish the different types.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <linux/cpufreq.h>
+#include <linux/compiler.h>
+#include <linux/dmi.h>
+#include <linux/slab.h>
+#include <linux/acpi.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/uaccess.h>
+#include <linux/static_call.h>
+
+#include <acpi/processor.h>
+#include <acpi/cppc_acpi.h>
+
+#include <asm/msr.h>
+#include <asm/processor.h>
+#include <asm/cpufeature.h>
+#include <asm/cpu_device_id.h>
+
+#define AMD_PSTATE_TRANSITION_LATENCY	0x20000
+#define AMD_PSTATE_TRANSITION_DELAY	500
+
+static struct cpufreq_driver amd_pstate_driver;
+
+/**
+ * struct amd_cpudata - private CPU data for AMD P-State
+ * @cpu: CPU number
+ * @cppc_req_cached: cached performance request hints
+ * @highest_perf: the maximum performance an individual processor may reach,
+ *		  assuming ideal conditions
+ * @nominal_perf: the maximum sustained performance level of the processor,
+ *		  assuming ideal operating conditions
+ * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
+ *			   savings are achieved
+ * @lowest_perf: the absolute lowest performance level of the processor
+ * @max_freq: the frequency that mapped to highest_perf
+ * @min_freq: the frequency that mapped to lowest_perf
+ * @nominal_freq: the frequency that mapped to nominal_perf
+ * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
+ *
+ * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
+ * represents all the attributes and goals that AMD P-State requests at runtime.
+ */
+struct amd_cpudata {
+	int	cpu;
+
+	u64	cppc_req_cached;
+
+	u32	highest_perf;
+	u32	nominal_perf;
+	u32	lowest_nonlinear_perf;
+	u32	lowest_perf;
+
+	u32	max_freq;
+	u32	min_freq;
+	u32	nominal_freq;
+	u32	lowest_nonlinear_freq;
+};
+
+static inline int amd_pstate_enable(bool enable)
+{
+	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
+}
+
+static int amd_pstate_init_perf(struct amd_cpudata *cpudata)
+{
+	u64 cap1;
+
+	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
+				     &cap1);
+	if (ret)
+		return ret;
+
+	/*
+	 * TODO: Introduce AMD specific power feature.
+	 *
+	 * CPPC entry doesn't indicate the highest performance in some ASICs.
+	 */
+	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
+
+	WRITE_ONCE(cpudata->nominal_perf, CAP1_NOMINAL_PERF(cap1));
+	WRITE_ONCE(cpudata->lowest_nonlinear_perf, CAP1_LOWNONLIN_PERF(cap1));
+	WRITE_ONCE(cpudata->lowest_perf, CAP1_LOWEST_PERF(cap1));
+
+	return 0;
+}
+
+static void amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
+				   u32 des_perf, u32 max_perf, bool fast_switch)
+{
+	if (fast_switch)
+		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
+	else
+		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
+			      READ_ONCE(cpudata->cppc_req_cached));
+}
+
+static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
+			      u32 des_perf, u32 max_perf, bool fast_switch)
+{
+	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u64 value = prev;
+
+	value &= ~REQ_MIN_PERF(~0L);
+	value |= REQ_MIN_PERF(min_perf);
+
+	value &= ~REQ_DES_PERF(~0L);
+	value |= REQ_DES_PERF(des_perf);
+
+	value &= ~REQ_MAX_PERF(~0L);
+	value |= REQ_MAX_PERF(max_perf);
+
+	if (value == prev)
+		return;
+
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+
+	amd_pstate_update_perf(cpudata, min_perf, des_perf,
+			       max_perf, fast_switch);
+}
+
+static int amd_pstate_verify(struct cpufreq_policy_data *policy)
+{
+	cpufreq_verify_within_cpu_limits(policy);
+
+	return 0;
+}
+
+static int amd_pstate_target(struct cpufreq_policy *policy,
+			     unsigned int target_freq,
+			     unsigned int relation)
+{
+	struct cpufreq_freqs freqs;
+	struct amd_cpudata *cpudata = policy->driver_data;
+	unsigned long max_perf, min_perf, des_perf, cap_perf;
+
+	if (!cpudata->max_freq)
+		return -ENODEV;
+
+	cap_perf = READ_ONCE(cpudata->highest_perf);
+	min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+	max_perf = cap_perf;
+
+	freqs.old = policy->cur;
+	freqs.new = target_freq;
+
+	des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
+				     cpudata->max_freq);
+
+	cpufreq_freq_transition_begin(policy, &freqs);
+	amd_pstate_update(cpudata, min_perf, des_perf,
+			  max_perf, false);
+	cpufreq_freq_transition_end(policy, &freqs, false);
+
+	return 0;
+}
+
+static int amd_get_min_freq(struct amd_cpudata *cpudata)
+{
+	struct cppc_perf_caps cppc_perf;
+
+	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	/* Switch to khz */
+	return cppc_perf.lowest_freq * 1000;
+}
+
+static int amd_get_max_freq(struct amd_cpudata *cpudata)
+{
+	struct cppc_perf_caps cppc_perf;
+	u32 max_perf, max_freq, nominal_freq, nominal_perf;
+	u64 boost_ratio;
+
+	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	nominal_freq = cppc_perf.nominal_freq;
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	max_perf = READ_ONCE(cpudata->highest_perf);
+
+	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
+			      nominal_perf);
+
+	max_freq = nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
+
+	/* Switch to khz */
+	return max_freq * 1000;
+}
+
+static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
+{
+	struct cppc_perf_caps cppc_perf;
+
+	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	/* Switch to khz */
+	return cppc_perf.nominal_freq * 1000;
+}
+
+static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
+{
+	struct cppc_perf_caps cppc_perf;
+	u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
+	    nominal_freq, nominal_perf;
+	u64 lowest_nonlinear_ratio;
+
+	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	nominal_freq = cppc_perf.nominal_freq;
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+
+	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
+
+	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
+					 nominal_perf);
+
+	lowest_nonlinear_freq = nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT;
+
+	/* Switch to khz */
+	return lowest_nonlinear_freq * 1000;
+}
+
+static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
+{
+	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
+	struct device *dev;
+	struct amd_cpudata *cpudata;
+
+	dev = get_cpu_device(policy->cpu);
+	if (!dev)
+		return -ENODEV;
+
+	cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
+	if (!cpudata)
+		return -ENOMEM;
+
+	cpudata->cpu = policy->cpu;
+
+	ret = amd_pstate_init_perf(cpudata);
+	if (ret)
+		goto free_cpudata;
+
+	min_freq = amd_get_min_freq(cpudata);
+	max_freq = amd_get_max_freq(cpudata);
+	nominal_freq = amd_get_nominal_freq(cpudata);
+	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
+
+	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
+		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
+			min_freq, max_freq);
+		ret = -EINVAL;
+		goto free_cpudata;
+	}
+
+	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
+	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
+
+	policy->min = min_freq;
+	policy->max = max_freq;
+
+	policy->cpuinfo.min_freq = min_freq;
+	policy->cpuinfo.max_freq = max_freq;
+
+	/* It will be updated by governor */
+	policy->cur = policy->cpuinfo.min_freq;
+
+	/* Initial processor data capability frequencies */
+	cpudata->max_freq = max_freq;
+	cpudata->min_freq = min_freq;
+	cpudata->nominal_freq = nominal_freq;
+	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
+
+	policy->driver_data = cpudata;
+
+	return 0;
+
+free_cpudata:
+	kfree(cpudata);
+	return ret;
+}
+
+static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	kfree(cpudata);
+
+	return 0;
+}
+
+static struct cpufreq_driver amd_pstate_driver = {
+	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
+	.verify		= amd_pstate_verify,
+	.target		= amd_pstate_target,
+	.init		= amd_pstate_cpu_init,
+	.exit		= amd_pstate_cpu_exit,
+	.name		= "amd-pstate",
+};
+
+static int __init amd_pstate_init(void)
+{
+	int ret;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return -ENODEV;
+
+	if (!acpi_cpc_valid()) {
+		pr_debug("the _CPC object is not present in SBIOS\n");
+		return -ENODEV;
+	}
+
+	/* don't keep reloading if cpufreq_driver exists */
+	if (cpufreq_get_current_driver())
+		return -EEXIST;
+
+	/* capability check */
+	if (!boot_cpu_has(X86_FEATURE_CPPC)) {
+		pr_debug("AMD CPPC MSR based functionality is not supported\n");
+		return -ENODEV;
+	}
+
+	/* enable amd pstate feature */
+	ret = amd_pstate_enable(true);
+	if (ret) {
+		pr_err("failed to enable amd-pstate with return %d\n", ret);
+		return ret;
+	}
+
+	ret = cpufreq_register_driver(&amd_pstate_driver);
+	if (ret)
+		pr_err("failed to register amd_pstate_driver with return %d\n",
+		       ret);
+
+	return ret;
+}
+
+static void __exit amd_pstate_exit(void)
+{
+	cpufreq_unregister_driver(&amd_pstate_driver);
+
+	amd_pstate_enable(false);
+}
+
+module_init(amd_pstate_init);
+module_exit(amd_pstate_exit);
+
+MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
+MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

