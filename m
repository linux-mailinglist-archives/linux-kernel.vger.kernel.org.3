Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2775967D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 05:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbiHQDtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 23:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiHQDte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:49:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CA47C1E4;
        Tue, 16 Aug 2022 20:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJZdhvObxdFAd/MImSJdLwbnSyhTOcX9NClzHMmqJotGIWanICb0onBsIqrFhJQp3uCEa22LUEXAuk5ym3/pJp5dBaebLPxe1C36+SVjeY5V/INRUUz3lRoKWzcBn5eshJ2myiVnu3g3FDPQlSgUMg4o0B+uF84DWRQ6S3I1zzfESNm3ALifoZjMqUVgwYSo/Q38I0lDS4c+nmI7Tut5CeQWtro7Vmf58eU/quteyPUhb1795saK046fOCoS4lZmAmUQTS8VioIOTmLMPK5DxL9SFBLz534nE+fAw7nnuaA14UNxpfCSs5LXXZYNFy2ThU7SRiBSk31JWkHRXF9TKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMKPx5SHlHKb67SIczUcoI7YWpllYob01xC80sSRcJ8=;
 b=YxeUqo+Y/Elouy6jaaolI8bLJwjz6bTkQvLGHM4EnjmZtLLN8McrOMx1IjPGh3F1dF7cFl/3+2utVblBkvFNetkGH85LQpgGGSpoiPfZMwnjW/AcGCl05JN5r6CM30SZEGCs+puPthXvEYgK/rWC/wivJZtRP5gwSY1KIU3t3Nsqytu/X4g4ezl4IEHzbOqJLU3IwJ6FHQPgyjOAXGaVujCxfslOaerGfptdzO7nTN9jwOvTmWK9caf2De8EPHRIwOwoQ2OKc/OiNakr7V8TNQ1hHLPc8YJiMBobACUBJLXRo1+nJi+86Tr7xSJkCcInFcyui59lY7GJgTDz8wnB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMKPx5SHlHKb67SIczUcoI7YWpllYob01xC80sSRcJ8=;
 b=TZ/K0QAATjmixG+tgtfnC/bFKW5NaKti3pxGqHCPj6tcVipCoGm2laJ9skT33Vhty1cSzw7t3jdSBO/zaxVkTlkc6/9YJ+flxtFqjNTYb6XE+TFuS/6eH4TWbyU576DVx8iF5kschRkzD8MP2Suax9VOoUYN+BcTf1tYzd9ZX0c=
Received: from BN9PR03CA0784.namprd03.prod.outlook.com (2603:10b6:408:13f::9)
 by BN6PR12MB1425.namprd12.prod.outlook.com (2603:10b6:404:1f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 03:49:30 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::73) by BN9PR03CA0784.outlook.office365.com
 (2603:10b6:408:13f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Wed, 17 Aug 2022 03:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Wed, 17 Aug 2022 03:49:30 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 16 Aug
 2022 22:48:07 -0500
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
Subject: [RESEND PATCH 2/4] cpufreq: amd-pstate: Add test module for amd-pstate driver
Date:   Wed, 17 Aug 2022 11:46:28 +0800
Message-ID: <20220817034630.1172065-3-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817034630.1172065-1-li.meng@amd.com>
References: <20220817034630.1172065-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54e2eadd-a43e-4f6a-1a17-08da80037d3e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1425:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dLOa2UmTkFwTzSp6MXJauuL9lx9dLCKLoj/jI/Z4jUt4V/yrpB0bwaqEwB1o14FvoCR97TbS0Qlh6NKSgwKin2GR4IRWwgPgtyDUR7F3K3KQ7FvhIXHr2r3v26C+XqvaJEUo2+IqYARnx/ddOUVGKvVPfzzhVgruHdkMvYauv8IAvYjApVTN+iWvWWFixlETZ2XUI1+iC8jTa5D+fzJMxDgTwqe6HIEGEPu1e54+eKa4eopCPMgMQL1L4W3KDpyTPalmjfz5DbEoALcVF7Ts0BZPrS+jqFGoY/1eecUs9Hbc+qCnpTk0xQbRGbosyRqAZ7rEXEu6Rh2UkYBoUZZ7hXjOjluHKRsgYmQar0rEIOI1UwVgbQhG8ypHzxBwvnWV2Y/6GdPyOJPkkT0EVsdCbqm6fFHeekOMEb4Is1zhzUgSOwsQ/O+GCHpD5ZDd4D/qsoa0vDzYIeamDfeawtFPTbHU1gepfZ8e2nphhZTqcOJKbHCWCRsDEgbD80dh6t7R3aSk6iApOfscqQcVfMuJ5BD6gJXvD9XdIMG5TF23GEACRRNoleUvcyZ9OVG4RhWKGL38HI/ryDjcZQVHRtBTKZqT9le4iLrl/75587Wx8a/utAhqghDTfnaj+fnUXFZdnnfhkMfFB5GM5zzIQahkFCKiaUgCgVgTRtGjpBG7TPRvhPnwiN3pEOJAQC1/zqoZFACQgMqsxTqBGRhWLl6If7ojnsnxoUsb9hLdpmUdR9NUTpFpyNrgjZQZkyfNeGfKqkLkNjqT78tNXJQLfEqU4+tLwt3mjqVA/SkJc2OlkipL0RfvXmmTqBUzinE05+D8+ZDMa4Ccz801fvhAr2q5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(40470700004)(30864003)(47076005)(83380400001)(336012)(1076003)(426003)(81166007)(82740400003)(16526019)(356005)(70206006)(316002)(70586007)(5660300002)(186003)(8676002)(82310400005)(7696005)(2616005)(4326008)(2906002)(26005)(54906003)(110136005)(478600001)(36756003)(36860700001)(40480700001)(41300700001)(86362001)(8936002)(40460700003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 03:49:30.0044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e2eadd-a43e-4f6a-1a17-08da80037d3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1425
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add amd-pstate-ut test module, this module is used by kselftest
to unit test amd-pstate functionality. This module will be
expected by some of selftests to be present and loaded.

Signed-off-by: Meng Li <li.meng@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/cpufreq/Kconfig.x86     |   7 +
 drivers/cpufreq/Makefile        |   1 +
 drivers/cpufreq/amd-pstate-ut.c | 293 ++++++++++++++++++++++++++++++++
 3 files changed, 301 insertions(+)
 create mode 100644 drivers/cpufreq/amd-pstate-ut.c

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 55516043b656..fdd819069d72 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -51,6 +51,13 @@ config X86_AMD_PSTATE
 
 	  If in doubt, say N.
 
+config X86_AMD_PSTATE_UT
+	tristate "selftest for AMD Processor P-State driver"
+	depends on X86 && ACPI_PROCESSOR
+	default n
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
index 000000000000..3947b7138184
--- /dev/null
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -0,0 +1,293 @@
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
+ * This driver implements basic framework with plans to enhance it with
+ * additional test cases to improve the depth and coverage of the test.
+ *
+ * See Documentation/admin-guide/pm/amd-pstate.rst Unit Tests for
+ * amd-pstate to get more detail.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
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
+ * amd_pstate_ut: used as a shortform for AMD P-State unit test.
+ * It helps to keep variable names smaller, simpler
+ */
+enum amd_pstate_ut_result {
+	AMD_PSTATE_UT_RESULT_PASS,
+	AMD_PSTATE_UT_RESULT_FAIL,
+};
+
+struct amd_pstate_ut_struct {
+	const char *name;
+	void (*func)(u32 index);
+	enum amd_pstate_ut_result result;
+};
+
+/*
+ * Kernel module for testing the AMD P-State unit test
+ */
+static void amd_pstate_ut_acpi_cpc_valid(u32 index);
+static void amd_pstate_ut_check_enabled(u32 index);
+static void amd_pstate_ut_check_perf(u32 index);
+static void amd_pstate_ut_check_freq(u32 index);
+
+static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
+	{"amd_pstate_ut_acpi_cpc_valid",   amd_pstate_ut_acpi_cpc_valid   },
+	{"amd_pstate_ut_check_enabled",    amd_pstate_ut_check_enabled    },
+	{"amd_pstate_ut_check_perf",       amd_pstate_ut_check_perf       },
+	{"amd_pstate_ut_check_freq",       amd_pstate_ut_check_freq       }
+};
+
+static bool get_shared_mem(void)
+{
+	bool result = false;
+	char path[] = "/sys/module/amd_pstate/parameters/shared_mem";
+	char buf[5] = {0};
+	struct file *filp = NULL;
+	loff_t pos = 0;
+	ssize_t ret;
+
+	if (!boot_cpu_has(X86_FEATURE_CPPC)) {
+		filp = filp_open(path, FMODE_PREAD, 0);
+		if (IS_ERR(filp))
+			pr_err("%s unable to open %s file!\n", __func__, path);
+		else {
+			ret = kernel_read(filp, &buf, sizeof(buf), &pos);
+			if (ret < 0)
+				pr_err("%s read %s file fail ret=%ld!\n",
+					__func__, path, (long)ret);
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
+/*
+ * check the _CPC object is present in SBIOS.
+ */
+static void amd_pstate_ut_acpi_cpc_valid(u32 index)
+{
+	if (acpi_cpc_valid())
+		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
+	else {
+		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+		pr_err("%s the _CPC object is not present in SBIOS!\n", __func__);
+	}
+}
+
+static void amd_pstate_ut_pstate_enable(u32 index)
+{
+	int ret = 0;
+	u64 cppc_enable = 0;
+
+	ret = rdmsrl_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
+	if (ret) {
+		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+		pr_err("%s rdmsrl_safe MSR_AMD_CPPC_ENABLE ret=%d error!\n", __func__, ret);
+		return;
+	}
+	if (cppc_enable)
+		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
+	else {
+		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+		pr_err("%s amd pstate must be enabled!\n", __func__);
+	}
+}
+
+/*
+ * check if amd pstate is enabled
+ */
+static void amd_pstate_ut_check_enabled(u32 index)
+{
+	if (get_shared_mem())
+		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
+	else
+		amd_pstate_ut_pstate_enable(index);
+}
+
+/*
+ * check if performance values are reasonable.
+ * highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0
+ */
+static void amd_pstate_ut_check_perf(u32 index)
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
+				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+				pr_err("%s cppc_get_perf_caps ret=%d error!\n", __func__, ret);
+				return;
+			}
+
+			nominal_perf = cppc_perf.nominal_perf;
+			lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
+			lowest_perf = cppc_perf.lowest_perf;
+		} else {
+			ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
+			if (ret) {
+				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+				pr_err("%s read CPPC_CAP1 ret=%d error!\n", __func__, ret);
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
+			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+			pr_err("%s cpu%d highest=%d %d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d, they should be equal!\n",
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
+			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+			pr_err("%s cpu%d highest=%d >= nominal=%d > lowest_nonlinear=%d > lowest=%d > 0, the formula is incorrect!\n",
+				__func__, cpu, highest_perf, nominal_perf,
+				lowest_nonlinear_perf, lowest_perf);
+			return;
+		}
+	}
+
+	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
+}
+
+/*
+ * Check if frequency values are reasonable.
+ * max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0
+ * check max freq when set support boost mode.
+ */
+static void amd_pstate_ut_check_freq(u32 index)
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
+			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
+				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
+				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
+			return;
+		}
+
+		if (cpudata->min_freq != policy->min) {
+			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+			pr_err("%s cpu%d cpudata_min_freq=%d policy_min=%d, they should be equal!\n",
+				__func__, cpu, cpudata->min_freq, policy->min);
+			return;
+		}
+
+		if (cpudata->boost_supported) {
+			if ((policy->max == cpudata->max_freq) ||
+					(policy->max == cpudata->nominal_freq))
+				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
+			else {
+				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
+					__func__, cpu, policy->max, cpudata->max_freq,
+					cpudata->nominal_freq);
+				return;
+			}
+		} else {
+			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
+			pr_err("%s cpu%d must support boost!\n", __func__, cpu);
+			return;
+		}
+	}
+
+	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
+}
+
+static int __init amd_pstate_ut_init(void)
+{
+	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
+
+	for (i = 0; i < arr_size; i++) {
+		amd_pstate_ut_cases[i].func(i);
+		switch (amd_pstate_ut_cases[i].result) {
+		case AMD_PSTATE_UT_RESULT_PASS:
+			pr_info("%-4d %-20s\t success!\n", i+1, amd_pstate_ut_cases[i].name);
+			break;
+		case AMD_PSTATE_UT_RESULT_FAIL:
+		default:
+			pr_info("%-4d %-20s\t fail!\n", i+1, amd_pstate_ut_cases[i].name);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static void __exit amd_pstate_ut_exit(void)
+{
+}
+
+module_init(amd_pstate_ut_init);
+module_exit(amd_pstate_ut_exit);
+
+MODULE_AUTHOR("Meng Li <li.meng@amd.com>");
+MODULE_DESCRIPTION("AMD P-state driver Test module");
+MODULE_LICENSE("GPL");
-- 
2.25.1

