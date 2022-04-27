Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C396C511A75
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiD0N5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbiD0N5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:57:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B89140D4;
        Wed, 27 Apr 2022 06:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpdhOFzxY+7+kBOKpumIOGYHprUcU08IOdCSNKUQDsyY+qEjWhm5H6H36uvDPQigp/AWWwE+Ql5M4C9nWCt5h2iEHzuDN5Tnel0aQWiSL7R2rxY28jX1GXwVUX5brYoJdi1LDAOqGE59e3pPJTGVZboAjGBgAHDYlINSmV+hvCubJMTIgayKFl9PAdPQagagdczmp1H0OPuJMrhQ41n2O4W48eUXVL6Jz+qdSVQGCzWA4xE6MWlgpSsvBmyINl2zSUKxfL50dMrbi8+ONUP83z1cRIaPtxkzC1drK0XZSqPyhvY4jpgZqlFaRFMl0GsxscX7I7U8b7uGdJKN21xQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7srT7lEaFGAs6fK0ZhC34lSCziJ6HG8/XWOe6Mpe/s=;
 b=WJkSNphvBiqF321XCpPzaATf5qL5umQbLTU/8PIJ44+gBQlfvvkm2SQKLUOTuQ1sPpbDZnIb09+Hzrkyj+53/9xtBfXgg6XWuoQrsZeg3Y+D+z10irgclZIJpKo9iLWitCaqbOeCKXt77LvBuKtkm/1e+SYoIETJ2f6bzetF5u2Jkk+y4SgJkGFdaxmR6s2S3zSVtxSIzDG3PWmuqcwPaKgW8Vcq4a4D2v2ECIa3vW33TeLLJLuQKysIrfTKpt34UHzBCglmymN8GM3TsbTWDiRSHZD1NaIlOT4CT+a7ucoT6XLYBNLAk9MeeeJGUx9rXbsuk+Ps/rQZiFHy1hyKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7srT7lEaFGAs6fK0ZhC34lSCziJ6HG8/XWOe6Mpe/s=;
 b=KoNuh+baF4nyyRGhXKgWFFSl7PsUhRA/CyMgJ8IphbR2QJ6Yyt6dsalf6c40QhaZatlsAP3rAmCjcFZfGr473gJXQpjdX7Gwr+KSL5L4bHadngemjH5kEY81/tsAwqoCdzoEcXz7kAGTCwykzq0SvCG8dwjsblgny/SKiCdFOHA=
Received: from BN9PR03CA0866.namprd03.prod.outlook.com (2603:10b6:408:13d::31)
 by DM6PR12MB3692.namprd12.prod.outlook.com (2603:10b6:5:14a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 13:54:29 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::da) by BN9PR03CA0866.outlook.office365.com
 (2603:10b6:408:13d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 13:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 13:54:29 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 08:54:25 -0500
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
Subject: [PATCH V4 2/3] selftests: amd-pstate: Add test module for amd-pstate driver
Date:   Wed, 27 Apr 2022 21:53:14 +0800
Message-ID: <20220427135315.3447550-3-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427135315.3447550-1-li.meng@amd.com>
References: <20220427135315.3447550-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0226f1a5-efab-497a-92e3-08da28557331
X-MS-TrafficTypeDiagnostic: DM6PR12MB3692:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3692C4594FE116F9ABD9CD9BF7FA9@DM6PR12MB3692.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7H5XR2nJeHuTk3yZGMQksER2LhN/buoCiUIq16YIuKcLelECwr4/IMctbA24zApXcgDifVkLZZ8dL6nDpm98QoiBeWrmTacAywijve8Ng5ThOoP4iFNtMLCe+JOSbDVrZC2ojdRiFu/J3z/w9Y+XrVkArrSz4gE9RFz5bzjP/rMveeoSjshvBAVJoUzwrPRgnpALBbGY+1UpvZbfRCsZGjq2mU4szw4X2bLqvZB+iSSSHl/8tnmDrYf6i3fbqNsibTQnMvhSa6BXmmlbvIlM8OLXiEVPiQVRPfN+BZRrgKSKX+ChCCEowi4DtiSmhoRxSS/ao1xiYyR6OxJj25KBzvD4Q18fxOPg9/46V06317sxroDtOLZqcMystoJlqr3m6sLAaz3pI5p8L+4lVs7Krf/HNdGlImeRqQ2lwv8MUXBNA4wi957mFOgI8lm0UGujiYIF5/uLDg4Ty6QMkaB2728qkw2q8thTUpXLnA2hEohDCsIry1fGVPoxOGvBn5rlq3rilvSX97zKrADBpp/fup8dBBqh2Gnd4U2HBiLXcdN5ZE+yIJ0Qdz+3ueYmRAIL6/XFvXpatcmL86qrBK36pbXrCBRxCbvxxLDBWkyJmq8laATBxgEJlYQ2KmNiPgc8qWGYzANDWj/q5CGx8pU9vdSoXj3lSKS3ndAbNxh7IJC5sSwXeK+nrktSVxn+I/EsZwR53AJYopcG9p44dHz1ZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(54906003)(508600001)(110136005)(70206006)(6666004)(2906002)(356005)(7696005)(1076003)(8676002)(2616005)(81166007)(316002)(86362001)(4326008)(186003)(16526019)(36756003)(47076005)(426003)(336012)(5660300002)(8936002)(26005)(82310400005)(40460700003)(30864003)(36860700001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 13:54:29.5681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0226f1a5-efab-497a-92e3-08da28557331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3692
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/amd-pstate/Makefile   |   9 +
 .../selftests/amd-pstate/amd-pstate-ut.sh     |  27 ++
 .../amd-pstate/amd-pstate-ut/Makefile         |  20 ++
 .../amd-pstate/amd-pstate-ut/amd-pstate-ut.c  | 275 ++++++++++++++++++
 tools/testing/selftests/amd-pstate/config     |   1 +
 6 files changed, 333 insertions(+)
 create mode 100644 tools/testing/selftests/amd-pstate/Makefile
 create mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100644 tools/testing/selftests/amd-pstate/amd-pstate-ut/Makefile
 create mode 100644 tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.c
 create mode 100644 tools/testing/selftests/amd-pstate/config

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2319ec87f53d..975c13368286 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TARGETS += alsa
+TARGETS += amd-pstate
 TARGETS += arm64
 TARGETS += bpf
 TARGETS += breakpoints
diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
new file mode 100644
index 000000000000..199867f44b32
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Makefile for amd-pstate/ function selftests
+
+# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
+all:
+
+TEST_PROGS := amd-pstate-ut.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
new file mode 100755
index 000000000000..9e787ead6b14
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# amd-pstate-ut is a test module for testing the amd-pstate driver.
+# (1) It can help all users to verify their processor support
+# (SBIOS/Firmware or Hardware).
+# (2) Kernel can have a basic function test to avoid the kernel
+# regression during the update.
+# (3) We can introduce more functional or performance tests to align
+# the result together, it will benefit power and performance scale optimization.
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
+	echo "$0 # Skipped: Test can only run on x86 architectures."
+	exit $ksft_skip
+fi
+
+scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
+
+if [ "$scaling_driver" != "amd-pstate" ]; then
+	echo "$0 # Skipped: Test can only run on amd-pstate driver."
+	exit $ksft_skip
+fi
+
+$(dirname $0)/../kselftest/module.sh "amd-pstate-ut" amd-pstate-ut
diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut/Makefile b/tools/testing/selftests/amd-pstate/amd-pstate-ut/Makefile
new file mode 100644
index 000000000000..16e09c64369a
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/amd-pstate-ut/Makefile
@@ -0,0 +1,20 @@
+AMD_PSTATE_UT_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(abspath $(AMD_PSATE_UT_DIR)/../../../../..)
+
+ifeq ($(V),1)
+Q =
+else
+Q = @
+endif
+
+MODULES = amd-pstate-ut.ko
+
+obj-m += amd-pstate-ut.o
+CFLAGS_amd-pstate-ut.o = -I$(src)
+
+all:
+	+$(Q)make -C $(KDIR) M=$(AMD_PSTATE_UT_DIR) modules
+
+clean:
+	+$(Q)make -C $(KDIR) M=$(AMD_PSTATE_UT_DIR) clean
+
diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.c b/tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.c
new file mode 100644
index 000000000000..ec7b5c984879
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.c
@@ -0,0 +1,275 @@
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
diff --git a/tools/testing/selftests/amd-pstate/config b/tools/testing/selftests/amd-pstate/config
new file mode 100644
index 000000000000..f43103c9adc4
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/config
@@ -0,0 +1 @@
+CONFIG_X86_AMD_PSTATE_UT=m
-- 
2.25.1

