Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C201D52D504
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbiESNtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbiESNtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:49:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0B463AF;
        Thu, 19 May 2022 06:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW1WKv8gn45p94Zw5lxqlBrhfb6KctqCh/R7ZyVwAu7+wdH/fpNl/RYZlQj2InCXQpSk0yLmoKjhxWfflutb2sAvWh0g51Eo0bj1J/BR49QZNX2Z8MaJw6+Zh26+9Pqo0jMktjhgTexa/YuY8N2z08or/jEFzRnGHGL505NdR0Tq5t7+a0W+xIkqbIsGKHSTIadDAPT6+dY2qSBRV7xTJ98jd8f3n10TwCRAAYjorMHAjXILKTrNdJewrGo5TqKJJL9b8Z4vwip+iLyCXUOt0weFus6IMAWEF9ZAMSUSdYzJIeqxuz5HLBen299mbdP9og+Y/mK+nM32/jRoJzWifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMS0KIT5zi3HbRcPHdoPs8D4m1tTMbAyvvohsHgh9YM=;
 b=cY2YTm8gvh7CMdUFfPYC3lKv37jQsYdpeHsYI8P5ctjagQ4Hs5cQuuAEgOMptlZAmWQds9g1kyOhCWkNzRcgqnRgN+F6O+Xs1HHiK9ocq3wh0qF1VGr9JO9lf4beoYvxYOEViWmjgcwUiG3fnGb+JlvqHEe4Q2xoF2VfItobrmo/tiqpJLDHbOmpnKoLQakVKt0d1XIf+naCr4K4mxg8lBek5A2DEa+9KqnR516hF0AO/M/zd+K03y1sHodAky93xksxtvnVMr0KCZoNNZU7R8KWjJOHWS0hqQ7OPlQouqZeiiDT/TQDD6IwxCXEJ9u1bFd+4GPxYW+5XF92FnPosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMS0KIT5zi3HbRcPHdoPs8D4m1tTMbAyvvohsHgh9YM=;
 b=U+M4mP9a85AUjBin0NWTCUA4wTR1L37k8VYfAWlB6K86slLBQVO+AIIqqMoZLr3Xdj7O0Eg1DrIX72ZQ+u+AO2gSRDRbzXkStc+7XjkhXO5fzJsBwB+RBQB9Q2AOlXhTuOSIFxecxaNLNs9FhXfb907NLFQYdDhx0ykS0Xaq9V8=
Received: from BN9PR03CA0353.namprd03.prod.outlook.com (2603:10b6:408:f6::28)
 by DM5PR12MB1660.namprd12.prod.outlook.com (2603:10b6:4:9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.13; Thu, 19 May 2022 13:48:05 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::c9) by BN9PR03CA0353.outlook.office365.com
 (2603:10b6:408:f6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Thu, 19 May 2022 13:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 13:48:04 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 08:48:00 -0500
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
Subject: [PATCH V6 2/4] cpufreq: amd-pstate: Add test module for amd-pstate driver
Date:   Thu, 19 May 2022 21:47:35 +0800
Message-ID: <20220519134737.359290-3-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519134737.359290-1-li.meng@amd.com>
References: <20220519134737.359290-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41a29bfc-b8f1-475f-1bf9-08da399e32fc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1660:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB166095D652EC12C40DD19C97F7D09@DM5PR12MB1660.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Uw5xcmQgqUJZtxrPtcuiNvOUXaJAjvhmH/Y5wg+gaH5+Mq8oB23wv8FEKyIlIhbsU8cmuMkEs1dQGUriZwGQOAysDq+CKK681AH170eDuXsVDHGiS5iuVzvFjjNwbTg/V2hWqybtuxZYKa5oOE84Sv88FWzZx+kFHU+gPIiBnkiDvNX5ZptLJZfRHAUh6Ly2yj7fuwjkVRMo42AtW3zZAyJlaBvAQZbdzMsyWQJES3RyVI4e7pirm9/Z/2o3FRCsrpUSgcy37RmCZfjr46R1yEaXUkWF8NQWQKgVn/ginGLuKWTVKyUr/+1VspMyO0/pJhbBjIoEu7NfigICQ6ObDAtydw1UiX9RJZw+28c7VWCzIvndMldsQBAOMFAlqZeqc58wyozOKBzehV/mu53rFEllQbJiyFESdGAZ1cqx6H8ggyeKojh2P22wlHl6CMjO8ueSPnREfVrQ3uSW/j1pRup+8a7L73sJrRke4nbPZuHXUD9wEzvaX2OzXU0KgDFViISk/k5zoMwjYJ/t/RcSne6R5XdqkNWgKBCBytVOlkBgIlUwXOtDOfBSuDtKl/Wc7VHd3qGQ+jZ0iRTXI0/xkijUjPeZTMMoST8phQJU3VtCSg/yI9P3ZMINYvFREg5L8mKQqSyMFjTxbtZl/fRF1AZveiACgVC9M+iZ/qlFEbHozQk+UKGoLn3GP2y4bMrTFimJAfgP5t8GoLi5T+qTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(70206006)(26005)(508600001)(81166007)(110136005)(54906003)(2906002)(316002)(8676002)(86362001)(356005)(4326008)(6666004)(40460700003)(83380400001)(36756003)(8936002)(5660300002)(36860700001)(47076005)(336012)(426003)(82310400005)(1076003)(16526019)(2616005)(70586007)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 13:48:04.8720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a29bfc-b8f1-475f-1bf9-08da399e32fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1660
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add amd-pstate-ut module, which is conceptually out-of-tree module
and provides ways for selftests/amd-pstate driver to test various
kernel module-related functionality. This module will be expected by
some of selftests to be present and loaded.

Signed-off-by: Meng Li <li.meng@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/Kconfig.x86     |   6 +
 drivers/cpufreq/Makefile        |   1 +
 drivers/cpufreq/amd-pstate-ut.c | 278 ++++++++++++++++++++++++++++++++
 3 files changed, 285 insertions(+)
 create mode 100644 drivers/cpufreq/amd-pstate-ut.c

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 55516043b656..37ba282cd156 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -51,6 +51,12 @@ config X86_AMD_PSTATE
 
 	  If in doubt, say N.
 
+config X86_AMD_PSTATE_UT
+	tristate "selftest for AMD Processor P-State driver"
+	depends on X86_AMD_PSTATE
+	help
+	  This kernel module is used for testing. It's safe to say M here.
+
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
 	depends on ACPI_PROCESSOR
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 285de70af877..49b98c62c5af 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -30,6 +30,7 @@ amd_pstate-y				:= amd-pstate.o amd-pstate-trace.o
 
 obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
 obj-$(CONFIG_X86_AMD_PSTATE)		+= amd_pstate.o
+obj-$(CONFIG_X86_AMD_PSTATE_UT)		+= amd-pstate-ut.o
 obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
 obj-$(CONFIG_X86_PCC_CPUFREQ)		+= pcc-cpufreq.o
 obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
new file mode 100644
index 000000000000..a510355b804e
--- /dev/null
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -0,0 +1,278 @@
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
+#include "../tools/testing/selftests/kselftest_module.h"
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
+static void aput_acpi_cpc(u32 index);
+static void aput_check_enabled(u32 index);
+static void aput_check_perf(u32 index);
+static void aput_check_freq(u32 index);
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
+	if (!boot_cpu_has(X86_FEATURE_CPPC)) {
+		filp = filp_open("/sys/module/amd_pstate/parameters/shared_mem", FMODE_PREAD, 0);
+		if (IS_ERR(filp))
+			pr_err("%s Open param file fail!\n", __func__);
+		else {
+			ret = kernel_read(filp, &buf, sizeof(buf), &pos);
+			if (ret < 0)
+				pr_err("%s ret=%ld unable to read from param file!\n",
+					__func__, ret);
+			filp_close(filp, NULL);
+		}
+
+		if ('Y' == *buf)
+			result = true;
+	}
+
+	return result;
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
+	aput_do_test_case();
+}
+
+KSTM_MODULE_LOADERS(amd_pstate_ut);
+MODULE_AUTHOR("Meng Li <li.meng@amd.com>");
+MODULE_DESCRIPTION("Unit test for AMD P-state driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

