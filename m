Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B8C5099EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386114AbiDUHqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386047AbiDUHpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:45:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148D7DF94;
        Thu, 21 Apr 2022 00:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYE4hWnbdiXlJSBW6WeE083+RjqsVzTMs2Q3HXZlR82l7OPWFKDhLwLnUGanzDyKh5ls0PX3+qXZZrVnpFWuvX5xiY0GgaR48jeGjv39kyIoaD2RJTu62qe9+i7kZTmklnaJ3ZZiPzQL1B2hYN9bXG/AWqfE+Jmd98Ol5dsJnwZAwb3xIulGXs7OKKdR2onF8mJ/nvZ4E87hieMWs7NXV4AAp5mZcQCzTEOy0DDl6+qRLLXPnDeyYi+4c3KRlVV5xLY23YMa4mnlbARMn4EdDLwDdNFzMh2Yv0dS+Ku2DaMgYh4tL/0fWOCwE1C+1xeP2tBbSMqTIYmbDsJuYTTqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DB1ujxLnLyLbXO9YjMVydcZW8jk7YR/ZWYUoV3+x02A=;
 b=fHpr7ANn6y0N90AHOz9nVDGx1Fjv4ypZTyZfMEfZMo3oS4HtoHrF2JIMu12ipB9Yd9gp4c5rcd8E3qtdhJjuB5TJnbRRA1rKqE9XfhHs3IE+ENrhdawA6jsPsFhwSYE0SjkYWU8uAoFuO8JiJZNJ3fF9xhXQDKEdWFd6cJEqvF6PoRIIpErUu8f/gBnmmT30gFUlYJUwGVySZGhpS+VVZ/WaII5P8xBjE6DVSBb50VPjbYnwZmVyMCD7DY/eN8UnSbIHVEu+iBlqhFbf8NJ/pGHI+T19dnkNiFDG0LFHy1S4MB9bqwtitd1ydMeP4SilRTROoNtNmyC/h+3WSavARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DB1ujxLnLyLbXO9YjMVydcZW8jk7YR/ZWYUoV3+x02A=;
 b=ie7rdM92nFaJAQXlP0UEQta6e7j46Y0WuB7mAXTlm3SvvtKRekdzu4U3VX9wsO+HYY+aKnqS0Fmc+DnBD0FgxLJRr1O8riL05FaNH2hVM/Ljacf7BjiBNsWmmghHw8s3ggHEN/srybnMC/gK109PAiCEFEvUlcdVseXXvXx/W8Y=
Received: from BN8PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:94::45)
 by MN2PR12MB2973.namprd12.prod.outlook.com (2603:10b6:208:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 07:42:26 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::c9) by BN8PR03CA0032.outlook.office365.com
 (2603:10b6:408:94::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 21 Apr 2022 07:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 07:42:25 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 02:42:21 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V3 3/3] selftests: cpufreq: Add amd_pstate_testmod kernel module for testing
Date:   Thu, 21 Apr 2022 15:41:52 +0800
Message-ID: <20220421074152.599419-4-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421074152.599419-1-li.meng@amd.com>
References: <20220421074152.599419-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e53928f-e640-4fc5-d72e-08da236a7abc
X-MS-TrafficTypeDiagnostic: MN2PR12MB2973:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2973CDE81FC5A80BF3406D95F7F49@MN2PR12MB2973.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPwUHD3OhkF6y+Iforh+Lq9f+LLCx75MBddXWxNcFhxWM87wVM1qXAgO+emCEHIaQVQ5vjmAgRIGPG0dplrbiKkDNtrvD3v6RQIQzYF6g0Db5ajujqXNk1wYQdUjKI2xOpJ1G/03Qzj8ZBKDnhWXhTC102AfzYgqNE+SavFeEG9FbBTTcX7nFI7xn7hk4dX1+c2PIAfobqxmpLlQVJwCVBQrE0SKb0N27U4bp/yh2+fcxmqD0lc7wfz3fEhY+L5q1Rz/ggTTovO4uFxNxHWQDLiReyMz5QGKeL2peofPoKRUrkA90iXX3S7Xkq0xekuunxww5T50usAV/8vERv0gGkpgZ2dTt5tNefcwy5J33OOpMBRzVY8jCySczYEzdzgtB3yAHwYTygsusCOauFMDgx5nhJ1mmR4kJffEnkwUICLSw7wYT5muKR2T/xKi6pZkAptdciyC7z1apU0k6kQRrx1YQ+pL9uar9Rn+SmziZ9a8HDhTkaWYlTZfubu3gJNzA1nBdh+ZLOUjpV3ghW73cNTM8iWuC2GB4FvDTmy0m5qtkuqhJm7mzBpAL4P+5h1kg2bsRa58CPABlLqN3EhGuHKexILwBtqraATOqGjHoqRhNoOQBQDcm3634Q97SLTIkTe2+UN2sUMv4J7NPlvXHw0YCBHS5ThvKA70Fyc4n5LaMKLfklgLCReDxZZPCyEiTHA244mkcfhEDjupHPU5cg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(86362001)(7696005)(36860700001)(356005)(508600001)(30864003)(6666004)(2906002)(5660300002)(81166007)(8936002)(83380400001)(2616005)(70206006)(1076003)(40460700003)(336012)(47076005)(186003)(426003)(16526019)(70586007)(36756003)(82310400005)(110136005)(316002)(8676002)(54906003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 07:42:25.8267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e53928f-e640-4fc5-d72e-08da236a7abc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2973
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add amd_pstate_testmod module, which is conceptually out-of-tree module
and provides ways for selftests/cpufreq amd pstate driver to test various
kernel module-related functionality. This module will be expected by
some of selftests to be present and loaded.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 .../cpufreq/amd_pstate_testmod/Makefile       |  20 ++
 .../amd_pstate_testmod/amd_pstate_testmod.c   | 329 ++++++++++++++++++
 2 files changed, 349 insertions(+)
 create mode 100644 tools/testing/selftests/cpufreq/amd_pstate_testmod/Makefile
 create mode 100644 tools/testing/selftests/cpufreq/amd_pstate_testmod/amd_pstate_testmod.c

diff --git a/tools/testing/selftests/cpufreq/amd_pstate_testmod/Makefile b/tools/testing/selftests/cpufreq/amd_pstate_testmod/Makefile
new file mode 100644
index 000000000000..8a5596cb2c18
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/amd_pstate_testmod/Makefile
@@ -0,0 +1,20 @@
+AMD_PSTATE_TESTMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(abspath $(AMD_PSATE_TESTMOD_DIR)/../../../../..)
+
+ifeq ($(V),1)
+Q =
+else
+Q = @
+endif
+
+MODULES = amd_pstate_testmod.ko
+
+obj-m += amd_pstate_testmod.o
+CFLAGS_amd_pstate_testmod.o = -I$(src)
+
+all:
+	+$(Q)make -C $(KDIR) M=$(AMD_PSTATE_TESTMOD_DIR) modules
+
+clean:
+	+$(Q)make -C $(KDIR) M=$(AMD_PSTATE_TESTMOD_DIR) clean
+
diff --git a/tools/testing/selftests/cpufreq/amd_pstate_testmod/amd_pstate_testmod.c b/tools/testing/selftests/cpufreq/amd_pstate_testmod/amd_pstate_testmod.c
new file mode 100644
index 000000000000..5391412a49c4
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/amd_pstate_testmod/amd_pstate_testmod.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-1.0-or-later
+/*
+ * AMD Processor P-state Frequency Driver Unit Test
+ *
+ * Copyright (C) 2022 Advanced Micro Devices, Inc. All Rights Reserved.
+ *
+ * Author: Meng Li <li.meng@amd.com>
+ *
+ * The AMD P-State Unit Test is a test module for testing the amd-pstate
+ * driver. 1) It can help all users to verify their processor support
+ * (SBIOS/Firmware or Hardware). 2) Kernel can have a basic function
+ * test to avoid the kernel regression during the update. 3) We can
+ * introduce more functional or performance tests to align the result
+ * together, it will benefit power and performance scale optimization.
+ *
+ * At present, it only implements the basic framework and some simple
+ * test cases. Next, 1) we will add a rst document. 2) we will add more
+ * test cases to improve the depth and coverage of the test.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "../../kselftest_module.h"
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/fs.h>
+#include <linux/amd-pstate.h>
+
+#include <acpi/cppc_acpi.h>
+
+/*
+ * Abbreviations:
+ * aput: used as a shortform for AMD P-State unit test.
+ * It helps to keep variable names smaller, simpler
+ */
+
+KSTM_MODULE_GLOBALS();
+
+/*
+ * Kernel module for testing the AMD P-State unit test
+ */
+enum aput_result {
+	APUT_RESULT_PASS,
+	APUT_RESULT_FAIL,
+	MAX_APUT_RESULT,
+};
+
+struct aput_struct {
+	const char *name;
+	void (*func)(u32 index);
+	enum aput_result result;
+};
+
+static const char ap_drv[] = "amd-pstate";
+
+static void aput_x86_vendor(u32 index);
+static void aput_modprobed_driver(u32 index);
+static void aput_acpi_cpc(u32 index);
+static void aput_check_enabled(u32 index);
+static void aput_check_perf(u32 index);
+static void aput_check_freq(u32 index);
+
+static struct aput_struct aput_conditions[] = {
+	{"x86_vendor",              aput_x86_vendor          },
+	{"modprobed_amd_pstate",    aput_modprobed_driver    },
+};
+
+static struct aput_struct aput_cases[] = {
+	{"acpi_cpc_valid",   aput_acpi_cpc         },
+	{"check_enabled",    aput_check_enabled    },
+	{"check_perf",       aput_check_perf       },
+	{"check_freq",       aput_check_freq       }
+};
+
+static bool get_shared_mem(void)
+{
+	bool result = false;
+	char buf[5] = {0};
+	struct file *filp = NULL;
+	loff_t pos = 0;
+	ssize_t ret;
+
+	filp = filp_open("/sys/module/amd_pstate/parameters/shared_mem", FMODE_PREAD, 0);
+	if (IS_ERR(filp))
+		pr_err("%s Open param file fail!\n", __func__);
+	else {
+		ret = kernel_read(filp, &buf, sizeof(buf), &pos);
+		if (ret < 0)
+			pr_err("%s ret=%ld unable to read from param file!\n", __func__, ret);
+		filp_close(filp, NULL);
+	}
+
+	if ('Y' == *buf)
+		result = true;
+
+	return result;
+}
+
+static void aput_x86_vendor(u32 index)
+{
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		aput_conditions[index].result = APUT_RESULT_PASS;
+	else {
+		aput_conditions[index].result = APUT_RESULT_FAIL;
+		pr_warn("Exit test: the vendor is not X86_VENDOR_AMD!\n");
+	}
+}
+
+static void aput_modprobed_driver(u32 index)
+{
+	const char *cur_drv;
+
+	cur_drv = cpufreq_get_current_driver();
+	if (cur_drv) {
+		if (!strncmp(cur_drv, ap_drv, min_t(size_t, strlen(cur_drv), strlen(ap_drv))))
+			aput_conditions[index].result = APUT_RESULT_PASS;
+		else {
+			aput_conditions[index].result = APUT_RESULT_FAIL;
+			pr_warn("Exit test: current driver %s is not amd-pstate!\n", cur_drv);
+		}
+	} else {
+		aput_conditions[index].result = APUT_RESULT_FAIL;
+		pr_warn("Exit test: this cpu is not supported anymore!\n");
+	}
+}
+
+static void aput_acpi_cpc(u32 index)
+{
+	if (acpi_cpc_valid())
+		aput_cases[index].result = APUT_RESULT_PASS;
+	else
+		aput_cases[index].result = APUT_RESULT_FAIL;
+}
+
+static void aput_pstate_enable(u32 index)
+{
+	int ret = 0;
+	u64 cppc_enable = 0;
+
+	ret = rdmsrl_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
+	if (ret) {
+		aput_cases[index].result = APUT_RESULT_FAIL;
+		pr_err("%s rdmsrl_safe MSR_AMD_CPPC_ENABLE ret=%d is error!\n", __func__, ret);
+		return;
+	}
+	if (cppc_enable)
+		aput_cases[index].result = APUT_RESULT_PASS;
+	else
+		aput_cases[index].result = APUT_RESULT_FAIL;
+}
+
+/*
+ *Check if enabled amd pstate
+ */
+static void aput_check_enabled(u32 index)
+{
+	if (get_shared_mem())
+		aput_cases[index].result = APUT_RESULT_PASS;
+	else
+		aput_pstate_enable(index);
+}
+
+/*
+ * Check if the each performance values are reasonable.
+ * highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0
+ */
+static void aput_check_perf(u32 index)
+{
+	int cpu = 0, ret = 0;
+	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
+	u64 cap1 = 0;
+	struct cppc_perf_caps cppc_perf;
+	struct cpufreq_policy *policy = NULL;
+	struct amd_cpudata *cpudata = NULL;
+
+	highest_perf = amd_get_highest_perf();
+
+	for_each_possible_cpu(cpu) {
+		policy = cpufreq_cpu_get(cpu);
+		if (!policy)
+			break;
+		cpudata = policy->driver_data;
+
+		if (get_shared_mem()) {
+			ret = cppc_get_perf_caps(cpu, &cppc_perf);
+			if (ret) {
+				aput_cases[index].result = APUT_RESULT_FAIL;
+				pr_err("%s cppc_get_perf_caps ret=%d is error!\n", __func__, ret);
+				return;
+			}
+
+			nominal_perf = cppc_perf.nominal_perf;
+			lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
+			lowest_perf = cppc_perf.lowest_perf;
+		} else {
+			ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
+			if (ret) {
+				aput_cases[index].result = APUT_RESULT_FAIL;
+				pr_err("%s read CPPC_CAP1 ret=%d is error!\n", __func__, ret);
+				return;
+			}
+
+			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
+			lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
+			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
+		}
+
+		if ((highest_perf != READ_ONCE(cpudata->highest_perf)) ||
+			(nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
+			(lowest_nonlinear_perf != READ_ONCE(cpudata->lowest_nonlinear_perf)) ||
+			(lowest_perf != READ_ONCE(cpudata->lowest_perf))) {
+			aput_cases[index].result = APUT_RESULT_FAIL;
+			pr_err("%s cpu%d highest=%d %d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d are not equal!\n",
+				__func__, cpu, highest_perf, cpudata->highest_perf,
+				nominal_perf, cpudata->nominal_perf,
+				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
+				lowest_perf, cpudata->lowest_perf);
+			return;
+		}
+
+		if (!((highest_perf >= nominal_perf) &&
+			(nominal_perf > lowest_nonlinear_perf) &&
+			(lowest_nonlinear_perf > lowest_perf) &&
+			(lowest_perf > 0))) {
+			aput_cases[index].result = APUT_RESULT_FAIL;
+			pr_err("%s cpu%d highest=%d nominal=%d lowest_nonlinear=%d lowest=%d have error!\n",
+				__func__, cpu, highest_perf, nominal_perf,
+				lowest_nonlinear_perf, lowest_perf);
+			return;
+		}
+	}
+
+	aput_cases[index].result = APUT_RESULT_PASS;
+}
+
+/*
+ * Check if the each frequency values are reasonable.
+ * max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0
+ * check max freq when set support boost mode.
+ */
+static void aput_check_freq(u32 index)
+{
+	int cpu = 0;
+	struct cpufreq_policy *policy = NULL;
+	struct amd_cpudata *cpudata = NULL;
+
+	for_each_possible_cpu(cpu) {
+		policy = cpufreq_cpu_get(cpu);
+		if (!policy)
+			break;
+		cpudata = policy->driver_data;
+
+		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
+			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
+			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
+			(cpudata->min_freq > 0))) {
+			aput_cases[index].result = APUT_RESULT_FAIL;
+			pr_err("%s cpu%d max=%d nominal=%d lowest_nonlinear=%d min=%d have error!\n",
+				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
+				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
+			return;
+		}
+
+		if (cpudata->min_freq != policy->min) {
+			aput_cases[index].result = APUT_RESULT_FAIL;
+			pr_err("%s cpu%d cpudata_min_freq=%d policy_min=%d have error!\n",
+				__func__, cpu, cpudata->min_freq, policy->min);
+			return;
+		}
+
+		if (cpudata->boost_supported) {
+			if ((policy->max == cpudata->max_freq) ||
+					(policy->max == cpudata->nominal_freq))
+				aput_cases[index].result = APUT_RESULT_PASS;
+			else {
+				aput_cases[index].result = APUT_RESULT_FAIL;
+				pr_err("%s cpu%d policy_max=%d cpu_max=%d cpu_nominal=%d have error!\n",
+					__func__, cpu, policy->max, cpudata->max_freq,
+					cpudata->nominal_freq);
+				return;
+			}
+		} else {
+			aput_cases[index].result = APUT_RESULT_FAIL;
+			pr_err("%s cpu%d not support boost!\n", __func__, cpu);
+			return;
+		}
+	}
+}
+
+static bool aput_check_conditions(void)
+{
+	bool result = true;
+	u32 i = 0, arr_size = ARRAY_SIZE(aput_conditions);
+
+	for (i = 0; i < arr_size; i++) {
+		aput_conditions[i].func(i);
+		if (aput_conditions[i].result != APUT_RESULT_PASS) {
+			result = false;
+			break;
+		}
+	}
+
+	return result;
+}
+
+static void aput_do_test_case(void)
+{
+	u32 i = 0, arr_size = ARRAY_SIZE(aput_cases);
+
+	for (i = 0; i < arr_size; i++) {
+		pr_info("****** Begin %-5d\t %-20s\t ******\n", i+1, aput_cases[i].name);
+		aput_cases[i].func(i);
+		KSTM_CHECK_ZERO(aput_cases[i].result);
+		pr_info("****** End   %-5d\t %-20s\t ******\n", i+1, aput_cases[i].name);
+	}
+}
+
+static void __init selftest(void)
+{
+	if (aput_check_conditions())
+		aput_do_test_case();
+}
+
+KSTM_MODULE_LOADERS(amd_pstate_testmod);
+MODULE_AUTHOR("Meng Li <li.meng@amd.com>");
+MODULE_DESCRIPTION("Unit test for AMD P-state driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

