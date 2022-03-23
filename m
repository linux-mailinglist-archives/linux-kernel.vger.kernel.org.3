Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E6D4E4D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbiCWHRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242116AbiCWHRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:17:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9470E6E8D2;
        Wed, 23 Mar 2022 00:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHVnCKw4Pz3Y5X8fXzmljItF8FkQs2WItc11WLbnDAkB6etBjXU0OKY827FjAF48S6oYTAh0nkcbPBAlHhFPTaoaiXvQR4WNjgMLIw3aFYlHcVKNmkgVR7rXx+D2ok1gngJ40oUgfo5EuomScppjojcH+oNF6SZ13YyCfRo6vFHChHVQUzUhyvjr1vXasdLTTILfBLelSZPKjmpYVAhiRhzFXH+0CoO2t12kxWQjqK1aoc/RxnSRydqMsr433B49RQlaZHYP4R0JhwE1pC7ht3TNKZz+4QIJxDrdLT2nXrCArS3iubKWroAdrUZsScycSiJjuoE2jxJ7NS2yDNAXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+88sbr6YJG6pmXeUfFBupdDRznisuI5v3lKD1ormUA=;
 b=dA2mjEVXEdtJL7TMPHZR6xN4ljoYUrN36hY6hY7DMiXdwsi2OOAbuvOS8iIaXOWqsIW/2jFPVjwzM7ZaoacTue7Q3exSDxUwwvTng2nSQx6SfmxaRsTu/bgpIM+x9fusc4cbHKyxOtspUsY4rroCiIcGuLLy7qK8QLEczoFjRgUtwuLKI+SfU2Wfufv6LHxgx5t1sLsLJtZFIZFrUXn1LGICyySatNLobhUHpecrqtOF9i0OZq6JmWAkHsrZY0+nvJJFoAIn8rk+1yHluNPKgDmEqeFetPrs+5UiKBfYRqEnMPWcLk96dvx7MAFlQF9zok3LTogAdbSVn7Zzl5MJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+88sbr6YJG6pmXeUfFBupdDRznisuI5v3lKD1ormUA=;
 b=m5V+tj5DpFZKL4NSc99FqvkZw6eNv3rqTc/b8/rNuTS2RiKRaPacBCYv0jeTSSVXfToMO3ZfnUt0YHXdxHq+n9B380N9N4DFjZOja9teQT/OiH/v3y8QnegGS28UPMUCBPojxPuWC7hwzI6I01WjAjCPm/S2OpHccyWRX8fzVQ4=
Received: from DM3PR14CA0149.namprd14.prod.outlook.com (2603:10b6:0:53::33) by
 DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.19; Wed, 23 Mar 2022 07:15:49 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::a9) by DM3PR14CA0149.outlook.office365.com
 (2603:10b6:0:53::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Wed, 23 Mar 2022 07:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 07:15:48 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 02:15:44 -0500
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
Subject: [PATCH 2/3] cpupower: Introduce a new unit test module for AMD P-State driver
Date:   Wed, 23 Mar 2022 15:15:01 +0800
Message-ID: <20220323071502.2674156-3-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323071502.2674156-1-li.meng@amd.com>
References: <20220323071502.2674156-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08556449-5007-46e2-08b4-08da0c9cf4de
X-MS-TrafficTypeDiagnostic: DM6PR12MB2859:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2859834914B390C99CCF67DDF7189@DM6PR12MB2859.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dLeS5OG7g7VVgypwmHJrmUK3j4XpoFSfGoshfJq8QMzO0GqjDjErQP1r+Bv2J9xBg2FFEbBmjKyywkAgbr3Z7d9a/AhDrVehcFmlnX1jii3+ZEi5dTCg3B+0XFf9SIn8hr84mO+/cBVZUhqmRUro/rczLfskIG7im/09tY2Cm/V65vesXX7cNLU+wwa3UNzuAQ5xajmCK0vqejcOy4Hk0W997nbKAt1Hr9J5OQAc8xw/kNXM3codN1/PsBtI9c7rt4ThGpjFOFFjuMXAsHQqRb6SLdPBNIADxk6gbIWIXjqlrPLZtb0fbytnm5EI4CZvygwRhL9ye0Y5Civ5ofSUO9wP2aspB7cLla1tv0i3CcPFX5AVWVzig71lrQRJGSjEI+WhEVwy1FXuSDznaXUydxXXUDpx/zvzzn2ikHch1drJcuUNO+ORlwAJW/xntfs4/CPr/9QRl1+DGBXyoW5UEaJ5W2ShSZC5DBp04tUDbL6TG+Hgvw7YSMmMkaBBxsI9WTAKVWmSmYQyG5cK2oIXb6RE9mWkJUh3PVDPANdWcBWG7YV5SZmKFAaHJS678UaEBc5W0ef7SQWU4O1Z8+58Po39Mc19GBJUY8eB/AdFFtGG5qAB9Mm5l2WBnCUJozqYslMS25S493oaHFJZSt0Jc+Hxk54FpK4aqqrX9ungHNSQyMuLiNtc1hPtCaf276CJ6RszpzldyigwNCnX5SIJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(30864003)(316002)(86362001)(40460700003)(82310400004)(508600001)(81166007)(356005)(26005)(16526019)(54906003)(47076005)(186003)(6666004)(2616005)(7696005)(83380400001)(1076003)(70586007)(36860700001)(8676002)(336012)(70206006)(426003)(8936002)(4326008)(110136005)(5660300002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 07:15:48.7876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08556449-5007-46e2-08b4-08da0c9cf4de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2859
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd-pstate-ut is a kernel module for testing the functions of AMD P-State driver.

It can verify the required conditions and basic functions of AMD P-State
driver before integration test.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 tools/power/cpupower/debug/kernel/Makefile    |  10 +-
 .../cpupower/debug/kernel/amd-pstate-ut.c     | 618 ++++++++++++++++++
 2 files changed, 627 insertions(+), 1 deletion(-)
 create mode 100644 tools/power/cpupower/debug/kernel/amd-pstate-ut.c

diff --git a/tools/power/cpupower/debug/kernel/Makefile b/tools/power/cpupower/debug/kernel/Makefile
index 7b5c43684be1..314827f106b4 100644
--- a/tools/power/cpupower/debug/kernel/Makefile
+++ b/tools/power/cpupower/debug/kernel/Makefile
@@ -8,11 +8,19 @@ ifeq ("$(CONFIG_X86_TSC)", "y")
   obj-m	 += cpufreq-test_tsc.o
 endif
 
+amd_pstate_ut-y := amd-pstate-ut.o
+
+ifeq ("$(CONFIG_X86_AMD_PSTATE)", "y")
+  obj-m	 += amd_pstate_ut.o
+else ifeq ("$(CONFIG_X86_AMD_PSTATE)", "m")
+  obj-m	 += amd_pstate_ut.o
+endif
+
 default:
 	$(MAKE) -C $(KDIR) M=$(CURDIR)
 
 clean:
-	- rm -rf *.o *.ko .*.cmd .*.mod.* *.mod.c
+	- rm -rf *.o *.ko .*.cmd *.mod .*.mod.* *.mod.c
 	- rm -rf Module.symvers modules.order
 
 install: default
diff --git a/tools/power/cpupower/debug/kernel/amd-pstate-ut.c b/tools/power/cpupower/debug/kernel/amd-pstate-ut.c
new file mode 100644
index 000000000000..0cb08e50947b
--- /dev/null
+++ b/tools/power/cpupower/debug/kernel/amd-pstate-ut.c
@@ -0,0 +1,618 @@
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
+#define pr_fmt(fmt) "AMD P-state UT: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/fs.h>
+#include <linux/amd-pstate.h>
+
+#include <acpi/cppc_acpi.h>
+
+#define AMD_PSTATE_UT_ERR(...) pr_err(__VA_ARGS__)
+#define AMD_PSTATE_UT_DEBUG(...) pr_debug(__VA_ARGS__)
+#define AMD_PSTATE_UT_INFO(...) pr_info(__VA_ARGS__)
+
+#define UT_LOG_BEGIN(index) AMD_PSTATE_UT_DEBUG("****** Begin %-5d\t %-20s\t ******\n", index, ut_cases[index].name)
+#define UT_LOG_END(index) AMD_PSTATE_UT_DEBUG("****** End   %-5d\t %-20s\t ******\n", index, ut_cases[index].name)
+
+enum ut_index {
+	UT_INDEX_BEGIN=0,
+	UT_INDEX_END,
+	MAX_UT_INDEX,
+};
+
+enum ut_result {
+	UT_RESULT_NOT_TEST=0,	//' '
+	UT_RESULT_PASS,		//'P'
+	UT_RESULT_FAIL,		//'F'
+	MAX_UT_RESULT,
+};
+
+struct ut_struct {
+	const char *name;
+	void (*func)(u32 index);
+	u32 index;
+	enum ut_result result;
+};
+
+static enum ut_result ut_special(u32 begin_index,
+		u32 end_index);
+
+static void ut_stop(u32 index);
+static void ut_all(u32 index);
+static void ut_x86_vendor(u32 index);
+static void ut_acpi_cpc(u32 index);
+static void ut_modprobed_driver(u32 index);
+static void ut_capability_check(u32 index);
+static void ut_enable(u32 index);
+static void ut_init_perf(u32 index);
+static void ut_support_boost(u32 index);
+static void ut_clear_status(u32 index);
+
+/* Amd-pstate unit test cases
+ * 0 : stop
+ * 1 : all
+ * n : from n to start
+ */
+static u32 ut_array_index[MAX_UT_INDEX] = {0};
+
+static struct ut_struct ut_cases[] = {
+	{"stop",                ut_stop                }, //0
+	{"all",                 ut_all                 }, //1
+	{"x86_vendor",          ut_x86_vendor          },
+	{"acpi_cpc_valid",      ut_acpi_cpc            },
+	{"modprobed_driver",    ut_modprobed_driver    },
+	{"capability_check",    ut_capability_check    },
+	{"enable",              ut_enable              },
+	{"init_perf",           ut_init_perf           },
+	{"support_boost",       ut_support_boost       },
+	{"clear_status",        ut_clear_status        } //max
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
+		AMD_PSTATE_UT_ERR("%s Open param file fail!", __func__);
+	}
+	else
+	{
+		ret = kernel_read(filp, &buf, sizeof(buf), &pos);
+		if (ret < 0)
+		{
+			AMD_PSTATE_UT_ERR("%s ret=%ld unable to read from param file!", __func__, ret);
+		}
+	}
+	filp_close(filp, NULL);
+
+	if ('Y' == *buf)
+	{
+		result = true;
+	}
+
+	return (result);
+}
+
+static bool ut_check_index(u32 index,
+		const char *func_name)
+{
+	bool ret = true;
+
+	if (index != ut_cases[index].index)
+	{
+		AMD_PSTATE_UT_ERR("%s index=%d is error!", func_name, index);
+		ret = false;
+	}
+
+	return (ret);
+}
+
+static void ut_stop(u32 index)
+{
+	if (!ut_check_index(index, __func__))
+	{
+		return;
+	}
+
+	AMD_PSTATE_UT_DEBUG("!====! Stop unit test! !====! \n");
+
+	//memset begin/end index
+	memset(ut_array_index, 0, sizeof(ut_array_index));
+}
+
+static void ut_all(u32 index)
+{
+	u32 arr_size = ARRAY_SIZE(ut_cases);
+	enum ut_result result = UT_RESULT_PASS;
+
+	if (!ut_check_index(index, __func__))
+	{
+		return;
+	}
+
+	if (index+1 < arr_size)
+	{
+		AMD_PSTATE_UT_DEBUG("!====! Begin all unit test! !====!\n");
+
+		//Not include ut_clear_status
+		result = ut_special(index+1, arr_size-1-1);
+
+		AMD_PSTATE_UT_DEBUG("!====! End   all unit test! !====!\n");
+	}
+	else
+	{
+		result = UT_RESULT_FAIL;
+		AMD_PSTATE_UT_ERR("%s arr_size=%d is error!", __func__, arr_size);
+	}
+	ut_cases[index].result = result;
+}
+
+static enum ut_result ut_special(u32 begin_index,
+		u32 end_index)
+{
+	u32 i = 0;
+	enum ut_result result = UT_RESULT_PASS;
+
+	for (i=begin_index; i<=end_index; i++)
+	{
+		if ((0 == ut_array_index[UT_INDEX_BEGIN]) &&
+			(0 == ut_array_index[UT_INDEX_END]))
+		{
+			AMD_PSTATE_UT_DEBUG("!====! Stop unit test : End %-5d\t %-20s\t! !====! \n", i, ut_cases[i].name);
+			break;
+		}
+		else
+		{
+			ut_cases[i].func(i);
+			if (UT_RESULT_PASS != ut_cases[i].result)
+			{
+				result = ut_cases[i].result;
+			}
+		}
+	}
+
+	return (result);
+}
+
+static void ut_x86_vendor(u32 index)
+{
+	if (!ut_check_index(index, __func__))
+	{
+		return;
+	}
+
+	UT_LOG_BEGIN(index);
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	{
+		ut_cases[index].result = UT_RESULT_PASS;
+	}
+	else
+	{
+		ut_cases[index].result = UT_RESULT_FAIL;
+	}
+
+	UT_LOG_END(index);
+}
+
+static void ut_acpi_cpc(u32 index)
+{
+	if (!ut_check_index(index, __func__))
+	{
+		return;
+	}
+
+	UT_LOG_BEGIN(index);
+
+	if (acpi_cpc_valid())
+	{
+		ut_cases[index].result = UT_RESULT_PASS;
+	}
+	else
+	{
+		ut_cases[index].result = UT_RESULT_FAIL;
+	}
+
+	UT_LOG_END(index);
+}
+
+static void ut_modprobed_driver(u32 index)
+{
+	if (!ut_check_index(index, __func__))
+	{
+		return;
+	}
+
+	UT_LOG_BEGIN(index);
+
+	if (cpufreq_get_current_driver())
+	{
+		ut_cases[index].result = UT_RESULT_PASS;
+	}
+	else
+	{
+		ut_cases[index].result = UT_RESULT_FAIL;
+	}
+
+	UT_LOG_END(index);
+}
+
+static void ut_capability_check(u32 index)
+{
+	if (!ut_check_index(index, __func__))
+	{
+		return;
+	}
+
+	UT_LOG_BEGIN(index);
+
+	if (boot_cpu_has(X86_FEATURE_CPPC))
+	{
+		ut_cases[index].result = UT_RESULT_PASS;
+	}
+	else
+	{
+		//shared memory
+		if (get_shared_mem())
+		{
+			ut_cases[index].result = UT_RESULT_PASS;
+		}
+		else
+		{
+			ut_cases[index].result = UT_RESULT_FAIL;
+		}
+	}
+
+	UT_LOG_END(index);
+}
+
+static void ut_pstate_enable(u32 index)
+{
+	int ret = 0;
+	u64 cppc_enable = 0;
+
+	ret = rdmsrl_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
+	if (ret)
+	{
+		ut_cases[index].result = UT_RESULT_FAIL;
+		AMD_PSTATE_UT_ERR("%s rdmsrl_safe MSR_AMD_CPPC_ENABLE ret=%d is error!", __func__, ret);
+		return;
+	}
+	if (cppc_enable)
+	{
+		ut_cases[index].result = UT_RESULT_PASS;
+	}
+	else
+	{
+		ut_cases[index].result = UT_RESULT_FAIL;
+	}
+}
+
+static void ut_enable(u32 index)
+{
+	if (!ut_check_index(index, __func__))
+	{
+		return;
+	}
+
+	UT_LOG_BEGIN(index);
+
+	if (get_shared_mem())
+	{
+		//not check
+		ut_cases[index].result = UT_RESULT_PASS;
+	}
+	else
+	{
+		ut_pstate_enable(index);
+	}
+
+	UT_LOG_END(index);
+}
+
+static void ut_init_perf(u32 index)
+{
+	int cpu = 0, ret = 0;
+	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
+	u64 cap1 = 0;
+	struct cppc_perf_caps cppc_perf;
+	struct cpufreq_policy *policy = NULL;
+        struct amd_cpudata *cpudata = NULL;
+
+	if (!ut_check_index(index, __func__))
+	{
+		return;
+	}
+
+	UT_LOG_BEGIN(index);
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
+				ut_cases[index].result = UT_RESULT_FAIL;
+				AMD_PSTATE_UT_ERR("%s cppc_get_perf_caps ret=%d is error!", __func__, ret);
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
+				ut_cases[index].result = UT_RESULT_FAIL;
+				AMD_PSTATE_UT_ERR("%s rdmsrl_safe_on_cpu MSR_AMD_CPPC_CAP1 ret=%d is error!", __func__, ret);
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
+			ut_cases[index].result = UT_RESULT_FAIL;
+			AMD_PSTATE_UT_ERR("%s cpu%d highest_perf=%d %d nominal_perf=%d %d lowest_nonlinear_perf=%d %d lowest_perf=%d %d are not equal!",
+					__func__, cpu, highest_perf, cpudata->highest_perf,
+					nominal_perf, cpudata->nominal_perf,
+					lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
+					lowest_perf, cpudata->lowest_perf);
+			return;
+		}
+	}
+
+	ut_cases[index].result = UT_RESULT_PASS;
+
+	UT_LOG_END(index);
+}
+
+static void ut_support_boost(u32 index)
+{
+	int cpu = 0;
+	struct cpufreq_policy *policy = NULL;
+        struct amd_cpudata *cpudata = NULL;
+
+	if (!ut_check_index(index, __func__))
+	{
+		return;
+	}
+
+	UT_LOG_BEGIN(index);
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
+			ut_cases[index].result = UT_RESULT_PASS;
+		}
+		else
+		{
+			ut_cases[index].result = UT_RESULT_FAIL;
+			break;
+		}
+	}
+
+	UT_LOG_END(index);
+}
+
+static void ut_clear_status(u32 index)
+{
+	int i = 0;
+
+	if (!ut_check_index(index, __func__))
+	{
+		return;
+	}
+
+	UT_LOG_BEGIN(index);
+
+	for (i = 0; i < ARRAY_SIZE(ut_cases); i++)
+	{
+		ut_cases[i].result = UT_RESULT_NOT_TEST;
+	}
+
+	//memset begin/end index
+	memset(ut_array_index, 0, sizeof(ut_array_index));
+
+	UT_LOG_END(index);
+}
+
+static int param_set_index(const char *str)
+{
+	int i = 0, result = 0;
+
+	//memset begin/end index
+	memset(ut_array_index, 0, sizeof(ut_array_index));
+
+	//get begin/end index
+	while ((NULL != str) && ('\0' != *str) && ('\n' != *str))
+	{
+		ut_array_index[i] = ut_array_index[i]*10 + *str - '0';
+		str++;
+		if (' ' == *str)
+		{
+			str++;
+			i++;
+			if (MAX_UT_INDEX <= i)
+			{
+				result = -EINVAL;
+				AMD_PSTATE_UT_ERR("%s arg_num=%d, Invalid argument! \n", __func__, i);
+				break;
+			}
+		}
+	}
+
+	AMD_PSTATE_UT_DEBUG("%s %d %d result=%d! \n", __func__, ut_array_index[0], ut_array_index[1], result);
+
+	return (result);
+}
+
+static void ut_init_index(void)
+{
+	int i = 0;
+
+	if (1 != ut_cases[1].index)
+	{
+		//init all unit test cases index
+		for (i = 0; i < ARRAY_SIZE(ut_cases); i++)
+		{
+			ut_cases[i].index = i;
+		}
+	}
+}
+
+/* Parameters */
+static int param_set_unit_test(const char *buffer,
+		const struct kernel_param *kp)
+{
+	int result = 0;
+	u32 begin_index = 0, end_index = 0;
+
+	//init test case index
+	ut_init_index();
+
+	//get begin/end index
+	result = param_set_index(buffer);
+	if (result < 0)
+		return result;
+
+	begin_index  = ut_array_index[UT_INDEX_BEGIN];
+	end_index  = ut_array_index[UT_INDEX_END];
+	if (0 == begin_index)
+	{
+		ut_array_index[UT_INDEX_END] = 0;
+		ut_stop(0);
+	}
+	else if (1 == begin_index)
+	{
+		//Not include ut_clear_status
+		ut_array_index[UT_INDEX_END] = ARRAY_SIZE(ut_cases) - 1 - 1;
+		ut_all(1);
+	}
+	else
+	{
+		if (begin_index > end_index)
+		{
+			end_index = begin_index;
+			ut_array_index[UT_INDEX_END] = end_index;
+		}
+		ut_special(begin_index, end_index);
+	}
+
+	return result;
+};
+
+static int param_get_unit_test(char *buffer,
+		const struct kernel_param *kp)
+{
+	char ret = 'N';
+	int i = 0, result = 0;
+
+	result = sprintf(buffer, "%-5s\t %-20s\t Status\n", "Index", "Test cases");
+
+	for (i = 0; i < ARRAY_SIZE(ut_cases); i++)
+	{
+		switch (ut_cases[i].result)
+		{
+		case UT_RESULT_NOT_TEST:
+			ret = ' ';
+			break;
+
+		case UT_RESULT_PASS:
+			ret = 'P';
+			break;
+
+		case UT_RESULT_FAIL:
+			ret = 'F';
+			break;
+
+		default:
+			ret = ' ';
+			break;
+		}
+
+		result += sprintf(buffer + result, "%-5d\t %-20s\t [%c]\n",
+				ut_cases[i].index,
+				ut_cases[i].name,
+				ret);
+	}
+
+	result += sprintf(buffer + result, "------------------------------------------\nbegin_index = %d end_index= %d\n",
+			ut_array_index[UT_INDEX_BEGIN], ut_array_index[UT_INDEX_END]);
+
+	return result;
+};
+
+static const struct kernel_param_ops param_ops_unittest = {
+	.set = param_set_unit_test,
+	.get = param_get_unit_test,
+};
+
+module_param_cb(unit_test, &param_ops_unittest, &ut_array_index, 0664);
+MODULE_PARM_DESC(unit_test,
+		" AMD P-state unit test 0 : stop 1 : start all x: start from x");
+
+/* Module */
+static int __init amd_pstate_ut_init(void)
+{
+	//init test case index
+	ut_init_index();
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
+MODULE_DESCRIPTION("Unit test for AMD P-state driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

