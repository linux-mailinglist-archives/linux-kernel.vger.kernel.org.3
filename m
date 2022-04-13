Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271774FF2F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiDMJJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbiDMJJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:09:04 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F4245067;
        Wed, 13 Apr 2022 02:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8o3FTn28Fm16hpHJCDTxSUzkPC7O3NEWgj7zoCuVDWkVGEzjRLhT8Cu9UDYlfRJAZk/+AJKRzQibZI0NLJ/jgH04BSLm1yUqO5H48xJDAlCaoU67VzlHIHMHprFMe8erqSeWWS1xRv9L+NYgT61MB6MERuJCUMNbkNcK+Ba4Ji9HU42jUSjzlVmKfQ0zxFbB0W9829P3Kc9vFQBoTMMOdf9n6/BI1AV5H07GUKbckBDXa1rxWJad9vn466AbLrxZtXaR1B4r/VrzPP9/CeUE+kC4F7A206sWNN7UPZ04Ha2bZSIYxi6Td6Oq3uaC7jHbjk/Cjnxgp8TAwU2ymUXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMGb2bXdspLmjc8UBhXEQRf05qd3SYNi93eN/C1xdas=;
 b=OuQYh0/oAfRinsMB7S4QsbZnp7calozAUzCuCao1sfa+Rhhs2AFU7PrR4FeM1/fdp04vijS2SHk18SW/1x9v5DjpwhXxOFXP36ZzrL42IDvsJZvcbxXUMLZSXFrJ2Fevoc5YWQryGQgyv9n/X06cYeaPlaLUm8G7Q4371+UV/jNv5oHkbmAUu6SDL7Kxwwgj4PddiwpzhTqzvUaxzgDZ88QA5Yanp1v3wFOh1bk9GDffnU1+9GUz73hv6bYtHQJSc5Ng2osVZq4EGcGAQ8t2H/b+D0AKu+k5UtDrjnIQkRbeKxF5JCpg0UCtOQdacyIlFhUSino14czdoH58C7UjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMGb2bXdspLmjc8UBhXEQRf05qd3SYNi93eN/C1xdas=;
 b=o1Kk7fQ84mg83pjxKcbWQjYk39bclODVgZGqIVlsBwNqLvQOfDazRAcp5WUt3rM/hGJYK32FfbUVfXrqIp0HHJwk7smemLZLl61DCKY7BM3GlO8/iaV6/Eleqm9tLvZGta6cMqoelAU7qfp2b5mfuVJp/7wqnFCtE/78PMMHqvY=
Received: from BN9PR03CA0404.namprd03.prod.outlook.com (2603:10b6:408:111::19)
 by MWHPR12MB1534.namprd12.prod.outlook.com (2603:10b6:301:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 09:06:40 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::77) by BN9PR03CA0404.outlook.office365.com
 (2603:10b6:408:111::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 13 Apr 2022 09:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 09:06:39 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 04:06:34 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH 3/3] selftests: cpufreq: Add amd_pstate_testmod kernel module for testing
Date:   Wed, 13 Apr 2022 17:05:10 +0800
Message-ID: <20220413090510.4039589-4-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413090510.4039589-1-li.meng@amd.com>
References: <20220413090510.4039589-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 356f08bc-4e0c-4c0b-7ec9-08da1d2ceba1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1534:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15348E50F13EA043D2CFBB65F7EC9@MWHPR12MB1534.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7I0V+4dlOggipgZ1saZAggM6TgK0QguSu9iCJBpnubPP1FaL/uEUrzb0d9aKBgQIA45z4kv9VVpNiMoJ8c7goSMScRHxENZm8Q2nZnCVxmPK4mqvaVm9pw+mZGvtSKkfRiLmP4R3uPe8tbxinonQTMTSDZ4AFIjf+qT+LRZAXp70giSfiAR58uD7saY3nD0hQI9NOG6gvUju82808Ugzy6CC4S+JqN6M+3WvmSXKceHNZ2GjIApgDcfHZtD69ofYMPmr1YL6eLSU6rzBMxMKizEy9YYBcUo/7q/6xjoC955J81habBMH9LPToXeGmSzWU/4qrH7YLT0CP7HTLb5l2sL8fkaSgMtBNbe14nJGAm6ntD9BkhBbM2nC94RLm4OPvZaUm1Vz4M9nGPIQTZj3yKNGoy2nzoeAiW8226fp5HXr9LbdMSTDY4LUhwhSStiearJnPmRXkdrHlBcpD4mleNQlZYv1IZzZkeH9nl9ZvnYORvBKIDYVZokFdadvO0ZB8My1l4OKeAURA2W4eA/31xX1zwNRPa2gezufpKv6Z90jcbEdd0cyHIjaoTQEOgAGKGWxJ1pzEzCqMaKtwOYAw5yJu1BhrmN3PHz3x9unfXSzPmp7mgny1F0Jlfa8xXIOf14uLTwQNU0SGv8aNCVUFu0qu4ZBmbasjgwxyGgaILm35WBdwYZUNRLnat9R2topboRRo4T8zQ93aNfol/w9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(186003)(6666004)(26005)(8676002)(16526019)(40460700003)(70206006)(316002)(82310400005)(54906003)(36756003)(36860700001)(110136005)(81166007)(86362001)(70586007)(4326008)(356005)(83380400001)(47076005)(7696005)(2906002)(426003)(336012)(8936002)(5660300002)(508600001)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 09:06:39.4717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 356f08bc-4e0c-4c0b-7ec9-08da1d2ceba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1534
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add amd_pstate_testmod module, which is conceptually out-of-tree module and
provides ways for selftests/cpufreq amd pstate driver to test various
kernel module-related functionality. This module will be expected by some
of selftests to be present and loaded.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 .../cpufreq/amd_pstate_testmod/Makefile       |  20 ++
 .../amd_pstate_testmod/amd_pstate_testmod.c   | 302 ++++++++++++++++++
 2 files changed, 322 insertions(+)
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
index 000000000000..a892cecf19da
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/amd_pstate_testmod/amd_pstate_testmod.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-1.0-or-later
+/*
+ * AMD Processor P-state Frequency Driver Unit Test
+ *
+ * Copyright (C) 2022 Advanced Micro Devices, Inc. All Rights Reserved.
+ *
+ * Author: Meng Li <li.meng@amd.com>
+ *
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
+*/
+
+KSTM_MODULE_GLOBALS();
+
+/*
+ * Kernel module for testing the AMD P-State unit test
+ */
+enum aput_result {
+	APUT_RESULT_PASS,	//0
+	APUT_RESULT_FAIL,	//
+	MAX_APUT_RESULT,
+};
+
+struct aput_struct {
+	const char *name;
+	void (*func)(u32 index);
+	enum aput_result result;
+};
+
+static void aput_x86_vendor(u32 index);
+static void aput_acpi_cpc(u32 index);
+static void aput_modprobed_driver(u32 index);
+static void aput_capability_check(u32 index);
+static void aput_enable(u32 index);
+static void aput_init_perf(u32 index);
+static void aput_support_boost(u32 index);
+
+static struct aput_struct aput_cases[] = {
+	{"x86_vendor",          aput_x86_vendor          },
+	{"acpi_cpc_valid",      aput_acpi_cpc            },
+	{"modprobed_driver",    aput_modprobed_driver    },
+	{"capability_check",    aput_capability_check    },
+	{"enable",              aput_enable              },
+	{"init_perf",           aput_init_perf           },
+	{"support_boost",       aput_support_boost       }
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
+	{
+		pr_err("%s Open param file fail! \n", __func__);
+	}
+	else
+	{
+		ret = kernel_read(filp, &buf, sizeof(buf), &pos);
+		if (ret < 0)
+		{
+			pr_err("%s ret=%ld unable to read from param file! \n", __func__, ret);
+		}
+		filp_close(filp, NULL);
+	}
+
+	if ('Y' == *buf)
+	{
+		result = true;
+	}
+
+	return (result);
+}
+
+static void aput_x86_vendor(u32 index)
+{
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	{
+		aput_cases[index].result = APUT_RESULT_PASS;
+	}
+	else
+	{
+		aput_cases[index].result = APUT_RESULT_FAIL;
+	}
+}
+
+static void aput_acpi_cpc(u32 index)
+{
+	if (acpi_cpc_valid())
+	{
+		aput_cases[index].result = APUT_RESULT_PASS;
+	}
+	else
+	{
+		aput_cases[index].result = APUT_RESULT_FAIL;
+	}
+}
+
+static void aput_modprobed_driver(u32 index)
+{
+	if (cpufreq_get_current_driver())
+	{
+		aput_cases[index].result = APUT_RESULT_PASS;
+	}
+	else
+	{
+		aput_cases[index].result = APUT_RESULT_FAIL;
+	}
+}
+
+static void aput_capability_check(u32 index)
+{
+	if (boot_cpu_has(X86_FEATURE_CPPC))
+	{
+		aput_cases[index].result = APUT_RESULT_PASS;
+	}
+	else
+	{
+		//shared memory
+		if (get_shared_mem())
+		{
+			aput_cases[index].result = APUT_RESULT_PASS;
+		}
+		else
+		{
+			aput_cases[index].result = APUT_RESULT_FAIL;
+		}
+	}
+}
+
+static void aput_pstate_enable(u32 index)
+{
+	int ret = 0;
+	u64 cppc_enable = 0;
+
+	ret = rdmsrl_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
+	if (ret)
+	{
+		aput_cases[index].result = APUT_RESULT_FAIL;
+		pr_err("%s rdmsrl_safe MSR_AMD_CPPC_ENABLE ret=%d is error! \n", __func__, ret);
+		return;
+	}
+	if (cppc_enable)
+	{
+		aput_cases[index].result = APUT_RESULT_PASS;
+	}
+	else
+	{
+		aput_cases[index].result = APUT_RESULT_FAIL;
+	}
+}
+
+static void aput_enable(u32 index)
+{
+	if (get_shared_mem())
+	{
+		//not check
+		aput_cases[index].result = APUT_RESULT_PASS;
+	}
+	else
+	{
+		aput_pstate_enable(index);
+	}
+}
+
+static void aput_init_perf(u32 index)
+{
+	int cpu = 0, ret = 0;
+	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
+	u64 cap1 = 0;
+	struct cppc_perf_caps cppc_perf;
+	struct cpufreq_policy *policy = NULL;
+        struct amd_cpudata *cpudata = NULL;
+
+	//get perf
+	highest_perf = amd_get_highest_perf();
+
+	for_each_possible_cpu(cpu)
+	{
+		//get amd cpudata
+		policy = cpufreq_cpu_get(cpu);
+		if (!policy)
+			break;
+		cpudata = policy->driver_data;
+
+		if (get_shared_mem())
+		{
+			ret = cppc_get_perf_caps(cpu, &cppc_perf);
+			if (ret)
+			{
+				aput_cases[index].result = APUT_RESULT_FAIL;
+				pr_err("%s cppc_get_perf_caps ret=%d is error! \n", __func__, ret);
+				return;
+			}
+
+			nominal_perf = cppc_perf.nominal_perf;
+			lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
+			lowest_perf = cppc_perf.lowest_perf;
+		}
+		else
+		{
+			ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
+			if (ret)
+			{
+				aput_cases[index].result = APUT_RESULT_FAIL;
+				pr_err("%s rdmsrl_safe_on_cpu MSR_AMD_CPPC_CAP1 ret=%d is error! \n", __func__, ret);
+				return;
+			}
+
+			//get perf from MSR
+			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
+			lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
+			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
+		}
+
+		//check highest_perf,nominal_perf,lowest_nonlinear_perf
+		if ((highest_perf != READ_ONCE(cpudata->highest_perf)) ||
+			(nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
+			(lowest_nonlinear_perf != READ_ONCE(cpudata->lowest_nonlinear_perf)) ||
+			(lowest_perf != READ_ONCE(cpudata->lowest_perf)))
+		{
+			aput_cases[index].result = APUT_RESULT_FAIL;
+			pr_err("%s cpu%d highest_perf=%d %d nominal_perf=%d %d lowest_nonlinear_perf=%d %d lowest_perf=%d %d are not equal! \n",
+				__func__, cpu, highest_perf, cpudata->highest_perf,
+				nominal_perf, cpudata->nominal_perf,
+				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
+				lowest_perf, cpudata->lowest_perf);
+			return;
+		}
+	}
+
+	aput_cases[index].result = APUT_RESULT_PASS;
+}
+
+static void aput_support_boost(u32 index)
+{
+	int cpu = 0;
+	struct cpufreq_policy *policy = NULL;
+        struct amd_cpudata *cpudata = NULL;
+
+	for_each_possible_cpu(cpu)
+	{
+		//get amd cpudata
+		policy = cpufreq_cpu_get(cpu);
+		if (!policy)
+			break;
+		cpudata = policy->driver_data;
+
+		if (READ_ONCE(cpudata->boost_supported))
+		{
+			aput_cases[index].result = APUT_RESULT_PASS;
+		}
+		else
+		{
+			aput_cases[index].result = APUT_RESULT_FAIL;
+			break;
+		}
+	}
+}
+
+static void aput_do_test_case(void)
+{
+	u32 i=0, arr_size = ARRAY_SIZE(aput_cases);
+
+	for (i = 0; i < arr_size; i++)
+	{
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
+KSTM_MODULE_LOADERS(amd_pstate_testmod);
+MODULE_AUTHOR("Meng Li <li.meng@amd.com>");
+MODULE_DESCRIPTION("Unit test for AMD P-state driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

