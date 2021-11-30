Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3D046348A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241742AbhK3MlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:41:15 -0500
Received: from mail-mw2nam08on2055.outbound.protection.outlook.com ([40.107.101.55]:4384
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241693AbhK3Mkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:40:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaA8ZnM5w9WMXf9o3s7/Uagt7e/vqLoZq5cB4F7wwveRtp7c71LfzNneK3EyDCq4iQDoTtxgN7KYnyDjgUVaG8AMQfyClJsRgV6RV8Gkt3kSb96r9taPzz1wYoGvxg48Qa3yWl6+e8m5DfaLp0wdrU5MeSGXNuqaab4osOoL/DQTv9pWo4vcBkQ75ieJtFDSk/QYNMCTwH4jEDJSpwBzZXHde7h+K/aGjdpbcG9bgfQvuUjanJvv1jH2L+sb4otIJfVH4DcgXWQWBC+XRKTI/4U45gaN4GbkjJSB5dSuJk9+jq5Ki8u9i5bnDJlWdXcr3wYyF+9W82vvPqCRjR5Ahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGOOoWSbHBWYvNHrsiRqd6fgQdFM9ypE9MIK78pEaLY=;
 b=mJ0a7r6fOenYcyVT3DnGPs1pVhdfsdV4eHVyPZcIH2FtAaPnzwEDc9y6C7Szf8dP3ZqW10Qia9lV+fRt546FtX1lD6G9TiDCDuT8JdZVGoc3liR1e16hBbDwLVNPc7W72frq3ZpOXgf4CF3rCO25p0F0Tm7wVUMgyvFODgSKIPX4swQv35zv1Y/yGJ5XDlA/QsdE21tO14Wz1RsDhqugXUCUhOmOgMmkArzeNAc/ck/5KT+72lXzEOh595kvNgY0ULlzWDs1hAyk8nWzwT3D6c3LPJG+Atu59LQrfG1uzf5KuyPQ/JtzNkDdSfUu/7dJzA7n+cnYKmalB7ZlfRIUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGOOoWSbHBWYvNHrsiRqd6fgQdFM9ypE9MIK78pEaLY=;
 b=DYOeXxPF2H36qC4ZMQ1R73jEGRqrL3kQ2JoX8RbNL9Vu3hSqyo/gW9ewMfyFW75y6M1fQ62JK94C/E6jfvo3rTsv9RePjvi42HaEjnluZOApDCCdS3477P63ndAfsdG1olhP2SKc6Ozn3qnkh0n4vgBZmGEkW6XATpToj8nCqjs=
Received: from BN9PR03CA0166.namprd03.prod.outlook.com (2603:10b6:408:f4::21)
 by SN6PR12MB4734.namprd12.prod.outlook.com (2603:10b6:805:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 12:37:34 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::5c) by BN9PR03CA0166.outlook.office365.com
 (2603:10b6:408:f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:37:33 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:37:25 -0600
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
Subject: [PATCH v5 06/22] cpufreq: amd: introduce a new amd pstate driver to support future processors
Date:   Tue, 30 Nov 2021 20:36:25 +0800
Message-ID: <20211130123641.1449041-7-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f9ee3fb1-1ce4-41e4-8f8c-08d9b3fe2e92
X-MS-TrafficTypeDiagnostic: SN6PR12MB4734:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4734C26DF09318785B9B25A5EC679@SN6PR12MB4734.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtJdZ1K5gjqW6gdnsztuKYJJAa8SnSC1vDUUEZ5Z8wwLFJRMd9jlrKkwT2qSPfhv8tybtt2wbz+7vNzYWrZiO6ZLOri/WnQtEtMTjjx0fzM7Qc0STjD4xMvcsZ2NTXbQJ0/pBnjkf3vT8Zhg4ZZ2byLiJoKyg0AqqYiZgwCEobw7kdcRlcXOMPM5ATOpD4vBj9rHvWLwFo1YkOZ90lRllqQ+68EqhrDSGfxBQlP5Z5zjwD18VtwmvPNl4tzQBI4oR1xteKLBEY8k1a/NQySiNSQaNEfxzci2ZJO5tD4A4qCOsuUCFXabJWYbTH1ODSCtvZDSQomoVFsHPZ8pwAZ0Wom977YnsY+DNR2bIMYGkOmpbyB5ctcwCUb1K0znV7DjiCYxA4FAFzF3ssfAg4lgsU5GP/AVYxzOlP57XODprGB81W4OzRgQKCg05GO88RtG6EYMoW9Hu2n69nSAmTc5BwjGTWl21w5WXjWNcr8Ayf9FLxH3ohjuM3FAyumMmpSDcn0BoaS79x1Qtc+4FCQfeuEj63mb5ZD4yG11BZq5bEVbM+ZMx7jstm2JNHl1mKSbMwCeNvIBxZmb0hkYUiqz512YgIv6LSgDbrl+OqnAJQ+bYNT9kXFDMuM73ztYRmUve5etMuGvcquJUdGU8+VZ+Eeo/L3pTTl7wH5h/yAeDSzumEl3VGFONXGTw79h27QTXI3ECH4nANSUzfocCehxbhVnygYtssxAO4XFmHX1cZ4UVo3HLdeB4jRsDswl9breWQABHjjX1UmoeiqcfyuleO7c3DqeWE0kvqlZcR5bA5tXHGYkaCJ9jgyk3HI2RAee0mJ/pgWsmjmJoWNTxyTZb4lnapGVwFInWynouFqlh+VPgszab8MDlnUgi26tHd6+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(186003)(4326008)(83380400001)(508600001)(7696005)(7416002)(8936002)(47076005)(86362001)(26005)(5660300002)(426003)(16526019)(70586007)(70206006)(36756003)(966005)(54906003)(82310400004)(336012)(36860700001)(30864003)(81166007)(316002)(2906002)(2616005)(356005)(8676002)(40460700001)(110136005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:37:33.2568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ee3fb1-1ce4-41e4-8f8c-08d9b3fe2e92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4734
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd-pstate is the AMD CPU performance scaling driver that introduces a
new CPU frequency control mechanism on AMD Zen based CPU series in Linux
kernel. The new mechanism is based on Collaborative processor
performance control (CPPC) which is finer grain frequency management
than legacy ACPI hardware P-States. Current AMD CPU platforms are using
the ACPI P-states driver to manage CPU frequency and clocks with
switching only in 3 P-states. AMD P-States is to replace the ACPI
P-states controls, allows a flexible, low-latency interface for the
Linux kernel to directly communicate the performance hints to hardware.

"amd-pstate" leverages the Linux kernel governors such as *schedutil*,
*ondemand*, etc. to manage the performance hints which are provided by CPPC
hardware functionality. The first version for amd-pstate is to support one
of the Zen3 processors, and we will support more in future after we verify
the hardware and SBIOS functionalities.

There are two types of hardware implementations for amd-pstate: one is full
MSR support and another is shared memory support. It can use
X86_FEATURE_CPPC feature flag to distinguish the different types.

Using the new AMD P-States method + kernel governors (*schedutil*,
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
 drivers/cpufreq/amd-pstate.c | 398 +++++++++++++++++++++++++++++++++++
 3 files changed, 416 insertions(+)
 create mode 100644 drivers/cpufreq/amd-pstate.c

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 92701a18bdd9..21837eb1698b 100644
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
+	  performance levels. This driver supports the AMD processors with
+	  _CPC object in the SBIOS.
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
index 000000000000..20ffbc30118f
--- /dev/null
+++ b/drivers/cpufreq/amd-pstate.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * amd-pstate.c - AMD Processor P-state Frequency Driver
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
+ *
+ * Author: Huang Rui <ray.huang@amd.com>
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
+struct amd_cpudata {
+	int	cpu;
+
+	struct freq_qos_request req[2];
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
+static inline int pstate_enable(bool enable)
+{
+	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
+}
+
+DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
+
+static inline int amd_pstate_enable(bool enable)
+{
+	return static_call(amd_pstate_enable)(enable);
+}
+
+static int pstate_init_perf(struct amd_cpudata *cpudata)
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
+DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
+
+static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
+{
+	return static_call(amd_pstate_init_perf)(cpudata);
+}
+
+static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
+			       u32 des_perf, u32 max_perf, bool fast_switch)
+{
+	if (fast_switch)
+		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
+	else
+		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
+			      READ_ONCE(cpudata->cppc_req_cached));
+}
+
+DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
+
+static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
+					  u32 min_perf, u32 des_perf,
+					  u32 max_perf, bool fast_switch)
+{
+	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
+					    max_perf, fast_switch);
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
+		goto free_cpudata1;
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
+		goto free_cpudata1;
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
+	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
+				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
+		goto free_cpudata1;
+	}
+
+	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[1],
+				   FREQ_QOS_MAX, policy->cpuinfo.max_freq);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
+		goto free_cpudata2;
+	}
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
+free_cpudata2:
+	freq_qos_remove_request(&cpudata->req[0]);
+free_cpudata1:
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
+	freq_qos_remove_request(&cpudata->req[1]);
+	freq_qos_remove_request(&cpudata->req[0]);
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

