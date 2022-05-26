Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1053497A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbiEZDsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbiEZDr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:47:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A5EBDA2A;
        Wed, 25 May 2022 20:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=At4wsPRiT6n4TboGw+ZsCRv5Bo3ZJdv+xNRIRlk4t2O089ofb6j1dsgUftkhGrsBRB8lXKaw4GyxMZZ8DSQX5sLc8Ac8iM9u9GImrRn3rkllhRMnjQHgfU29LEsCQ+cjtuYRLBMwNN5keLj6o1aMrYb2lSlOlWQrKB04ZZM027UCWQGkNxuUVlEhcN8nQ4N/J7dGwFmvgOjyyXkOukwnniR21XSilnzuBpnniUMxSAy+hOIztvGvmhMrgQGNEugKrdHucZeOXN47kwLOXW1BlF2K9VXxnr6fIYOrkwFI9izCMzU8REUFtq2moW3uaMJfV0y+0Mi2LsPXBeD+ODmk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMKPx5SHlHKb67SIczUcoI7YWpllYob01xC80sSRcJ8=;
 b=W7XPK9jxY3Vbu6ym7Z09oNyUhibMWxDIAYdxUA44Jqn89oYWWqKP6UBAUOH/RTi6h4KQplaYSCokxApb4Va14aVUvOq1oN3uSFALEllEO8aDBxpu7oRmdpOyaeeZxxjnjYXej/EING5gbFIwrscX5/3CeXzkoF+tIO4hy8Ocr615bNxosgLI+Ds9qCCiUTqbjyG68BEVRveTNVnHTWBgwCYaOeG1/FBWlH2By2rkCoXBl9WDHcogNVwAeXTaSN2WyXBhc/JS4y6EKuOola3u9JK7bKQ8D0uL0Kkb0yZuDHGGCA6JwUBr5+OPR0JuJz6bZkMeDsIxjAkUSOiQJ9Vr6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMKPx5SHlHKb67SIczUcoI7YWpllYob01xC80sSRcJ8=;
 b=Fz/oXGfa6ZYaZ7W6NDAx6BIB54Vm2UCEe8NrbyylHmvEOr5Z/Tw36K1rBGqQ1CpR4XyoJv26bgJ1Lq2bSj26HuUu/0sQ/z+LFUiloWJ2DewhL91pstCeCNSjdcZ7JBe1yrvwRIRfduq5DHvCZRg+C2iGCq1On/0U4jxh5AustzE=
Received: from MW4PR04CA0149.namprd04.prod.outlook.com (2603:10b6:303:84::34)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Thu, 26 May
 2022 03:47:55 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::b6) by MW4PR04CA0149.outlook.office365.com
 (2603:10b6:303:84::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 03:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 03:47:53 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 22:47:49 -0500
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
Subject: [V8 PATCH 2/4] cpufreq: amd-pstate: Add test module for amd-pstate driver
Date:   Thu, 26 May 2022 11:47:23 +0800
Message-ID: <20220526034725.1708916-3-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526034725.1708916-1-li.meng@amd.com>
References: <20220526034725.1708916-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4221b1e-47f6-46d0-3222-08da3eca83c2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5801:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB580163F08DD2F109B787C4F7F7D99@BL1PR12MB5801.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFsA5i+rNQcCuoAoIMQzPZ0dKe/rtfhQ/RckYYQq045WGRjiFdzhHE3xVMzJXv0u6V+sR2heElzQhgsuKfvJeZ53Rcvy8gZ+I4vvCWiZNrQRcVPiTulNtkwMZR48HhOrWj/AS1u+W/KelEBlUeHTfaoQBtHurhyGNtxVeZxo50WszlR6Eb89M5d7THpAK+h9DA1Idr2vixfRThg9FIvIZDvG0+kc2k7fZMeEXzFl7EpcWjgg6PICVop5Dk0s0cClVlDQrTwYZfqa2ppUIsIaC6JdKPotTVfQ9ZTAk0uRBeWEqSJCVraNCksDtt8suOg3uudh5xvAYcjgEvAwkFAghYR8WM/h+nQhTtjWzfVnu8hhaD1qLDUjSlrHmyVGSquiWpc4rGMI4XG8Kvj2EuHX8RidKc3l5SSIfGn1eWbygy+p9WYrpcsSMslsRzn+CsVCZWutqzgZV7Xm8czqxN9yVoeAU6EWdgekfDLxq5jQW2lnTpPRvxIFCRuxuBEdyEuN2xwG3nuTx6YT8f6QuT8InOd7rLz1VH5GUnKiQgt9Ce5MszYl3DjQTQb1cAG3fY0bZBPS3ornRs3uh4r2JdeMH0E9BQCOpKPR99XXG7E4ykGJSCORRDc+4ko+KYa5ClhmHV+pfl7MyeNC5mpZF3cOSEV6D1yGRwLGLSBLxLpOYLvaL6ELM5n/TdLsUwfwrArmWYMcZBPJbu6uqS4XDQd3KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(40460700003)(508600001)(83380400001)(54906003)(36860700001)(8936002)(110136005)(86362001)(70206006)(81166007)(70586007)(4326008)(8676002)(36756003)(426003)(16526019)(26005)(30864003)(6666004)(336012)(186003)(2906002)(2616005)(82310400005)(5660300002)(1076003)(47076005)(7696005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 03:47:53.9329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4221b1e-47f6-46d0-3222-08da3eca83c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

