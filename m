Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8422A53497B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344412AbiEZDr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245484AbiEZDr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:47:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84DC257;
        Wed, 25 May 2022 20:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXcyitcoe3QqkzuSNyDojVAo1T4cntvMIwFRbf63EqDjUFOLzUVGZFnNmt9bRuhDKWp2z43fsbWEHhfhvMGS1qagALgtAtQf0k97iCPnNEe9njs6byypGavNmfkK34XbNH2uFUFYQAszuX2jbvW7cGsLkmMEP6Te9Arcad7PcILqDl85iTHltESMXQ6OJefU3xBtupFADqZ83RFLDAfVtlA6Ch30ZYwnJnefktYBfeyq3zjDIJtaynnGHHhf+0Q3UaXCbCbbPpr4jIzbIEWexUHq531w2srA5HPrUt3LyTiVx0+6ad9UVqJBgYrzK8Cp1TiCWVLIytquLYBSPoZeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5USH2qu+8lHDbU0wt8WVxAu8I8cPsArKF+b29UfO9k=;
 b=Ld1hqx6TxrEMITXFERaYlfCObmMSSAP06KmnIYv3Z/Y6zjm0IpSv90Yk7QcK8f+M/vypwt+uTrlZWEZZtJ2KCr5RQSnMyHX2Hk5xYekA+A0+nhcBI+j7aBfIrtwMoSNOiAb0SII6+/6IThXeI2ZFBorD5GItH0lFE7NxEhNK8rcOU1fSTYQdgLbjWVtfq4XZUSNxYk0SOAF0sMkS3no6s4NbDf8OgSeykVh7HAYEQLCddlxvV09Tqbt+lFlCUQV0vOqeJZEnICNDXC8SElZHYFHEP7CJ3rIf44Fii/alX8hZysX8Z4aZgNXAlk4jPpzxYRgYyYmpcEyEmvx3kcYEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5USH2qu+8lHDbU0wt8WVxAu8I8cPsArKF+b29UfO9k=;
 b=aIaRsIhiMYcc86nUDgv4Sdew1TPwIM5ikoflNosXpJ1odspJFbg+CVuDZNLq7Ywu0fDkwQyRk9+08dLz8rGqUDJaNBuwkSbpjFemBp1EwupRVJmCGYF98rssV+GTAHmJEtyU3O30khYhRBx6EUrmOAcRDY2HInIFjksuZ822IYE=
Received: from MW4PR04CA0106.namprd04.prod.outlook.com (2603:10b6:303:83::21)
 by DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 03:47:51 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::b1) by MW4PR04CA0106.outlook.office365.com
 (2603:10b6:303:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 03:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 03:47:51 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 22:47:45 -0500
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
Subject: [V8 PATCH 1/4] cpufreq: amd-pstate: Expose struct amd_cpudata
Date:   Thu, 26 May 2022 11:47:22 +0800
Message-ID: <20220526034725.1708916-2-li.meng@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8ab32b35-2947-4f14-14da-08da3eca8227
X-MS-TrafficTypeDiagnostic: DM6PR12MB2844:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB28446595F4EF4230BCD213F8F7D99@DM6PR12MB2844.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiC+Odu6wjX5cL+hTSgqsSUd4p2jOOjUFW8Ywy3KnihIuTiic5ToYjHDXeqYE5Hr77KlCExPRTgArOYa1e9XTZoY8d/knNNSAPv7vqb/YTa66k2hele1RCqp0ynT8LtmhO0lXTncIEGyl5P0mU39ghNQXqJ7Ym1p5svjt6Naz2wLm8qrxliM2/is+VKY0RqlgDHBaTXfrxCsJHSzMnQ3BI5MLTPT7PWxhnlqIHOjiCtcISdTYN5MdM101HSIPIzVuWs/sWyjFLmfRs8f71uu2ck8ONMaow13kEfxBqUVKYXxbj9TbN+4vdYZpz+0ohvwNjU4Gw6y64U9yCFt2AaGJ9Nwo4i+W+8WQdQN9FUn0caXjw+igsy0M2mfjxumXIeICnM4JsmoVuvc9Vml276fNKovYmOQO8/vFmFJPyjk5mD/1pLC2HOvxGMDZspBabdqoDC8H4UEhpZmExw3EdaUPZBHUwFDWggZg/wEki9YbIAHnfbh96uNr9q9pj349bXI5W7/K+ZxwsjHPFvoXx6L7n+reFZeA3+l0bT08sm8Dghv4xcHoymgFiPEWIiQkmhJVJaWl1gsFxPPj8XrrmfvgxmsQ1aV6lipYCcrWMAQdF02K9XCeJ8zirH3Tu9BVCo6+BIQ5NhyuJwwmDfHv+AB1q5YCRjQAdRvqdCY/vyiehpimLOdQE7zLIXST8sFCIwFAB0KN0ClPgpQThm2WH7G1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(110136005)(36860700001)(47076005)(336012)(5660300002)(8936002)(54906003)(7696005)(426003)(6666004)(16526019)(186003)(36756003)(1076003)(83380400001)(2616005)(2906002)(82310400005)(26005)(81166007)(356005)(40460700003)(4326008)(86362001)(70586007)(8676002)(70206006)(508600001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 03:47:51.2386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab32b35-2947-4f14-14da-08da3eca8227
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2844
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose struct amd_cpudata to AMD P-State unit test module.

This data struct will be used on the following AMD P-State unit test
(amd-pstate-ut) module. The amd-pstate-ut module can get some
AMD infomations by this data struct. For example: highest perf,
nominal perf, boost supported etc.

Signed-off-by: Meng Li <li.meng@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
 MAINTAINERS                  |  1 +
 drivers/cpufreq/amd-pstate.c | 60 +---------------------------
 include/linux/amd-pstate.h   | 77 ++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/amd-pstate.h

diff --git a/MAINTAINERS b/MAINTAINERS
index edc96cdb85e8..c2e5299b0051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1021,6 +1021,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/admin-guide/pm/amd-pstate.rst
 F:	drivers/cpufreq/amd-pstate*
+F:	include/linux/amd-pstate.h
 F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
 
 AMD PTDMA DRIVER
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7be38bc6a673..5f7a00a64f76 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/uaccess.h>
 #include <linux/static_call.h>
+#include <linux/amd-pstate.h>
 
 #include <acpi/processor.h>
 #include <acpi/cppc_acpi.h>
@@ -65,65 +66,6 @@ MODULE_PARM_DESC(shared_mem,
 
 static struct cpufreq_driver amd_pstate_driver;
 
-/**
- * struct  amd_aperf_mperf
- * @aperf: actual performance frequency clock count
- * @mperf: maximum performance frequency clock count
- * @tsc:   time stamp counter
- */
-struct amd_aperf_mperf {
-	u64 aperf;
-	u64 mperf;
-	u64 tsc;
-};
-
-/**
- * struct amd_cpudata - private CPU data for AMD P-State
- * @cpu: CPU number
- * @req: constraint request to apply
- * @cppc_req_cached: cached performance request hints
- * @highest_perf: the maximum performance an individual processor may reach,
- *		  assuming ideal conditions
- * @nominal_perf: the maximum sustained performance level of the processor,
- *		  assuming ideal operating conditions
- * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
- *			   savings are achieved
- * @lowest_perf: the absolute lowest performance level of the processor
- * @max_freq: the frequency that mapped to highest_perf
- * @min_freq: the frequency that mapped to lowest_perf
- * @nominal_freq: the frequency that mapped to nominal_perf
- * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
- * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
- * @prev: Last Aperf/Mperf/tsc count value read from register
- * @freq: current cpu frequency value
- * @boost_supported: check whether the Processor or SBIOS supports boost mode
- *
- * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
- * represents all the attributes and goals that AMD P-State requests at runtime.
- */
-struct amd_cpudata {
-	int	cpu;
-
-	struct	freq_qos_request req[2];
-	u64	cppc_req_cached;
-
-	u32	highest_perf;
-	u32	nominal_perf;
-	u32	lowest_nonlinear_perf;
-	u32	lowest_perf;
-
-	u32	max_freq;
-	u32	min_freq;
-	u32	nominal_freq;
-	u32	lowest_nonlinear_freq;
-
-	struct amd_aperf_mperf cur;
-	struct amd_aperf_mperf prev;
-
-	u64 freq;
-	bool	boost_supported;
-};
-
 static inline int pstate_enable(bool enable)
 {
 	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
new file mode 100644
index 000000000000..1c4b8659f171
--- /dev/null
+++ b/include/linux/amd-pstate.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * linux/include/linux/amd-pstate.h
+ *
+ * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ *
+ * Author: Meng Li <li.meng@amd.com>
+ */
+
+#ifndef _LINUX_AMD_PSTATE_H
+#define _LINUX_AMD_PSTATE_H
+
+#include <linux/pm_qos.h>
+
+/*********************************************************************
+ *                        AMD P-state INTERFACE                       *
+ *********************************************************************/
+/**
+ * struct  amd_aperf_mperf
+ * @aperf: actual performance frequency clock count
+ * @mperf: maximum performance frequency clock count
+ * @tsc:   time stamp counter
+ */
+struct amd_aperf_mperf {
+	u64 aperf;
+	u64 mperf;
+	u64 tsc;
+};
+
+/**
+ * struct amd_cpudata - private CPU data for AMD P-State
+ * @cpu: CPU number
+ * @req: constraint request to apply
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
+ * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
+ * @prev: Last Aperf/Mperf/tsc count value read from register
+ * @freq: current cpu frequency value
+ * @boost_supported: check whether the Processor or SBIOS supports boost mode
+ *
+ * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
+ * represents all the attributes and goals that AMD P-State requests at runtime.
+ */
+struct amd_cpudata {
+	int	cpu;
+
+	struct	freq_qos_request req[2];
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
+
+	struct amd_aperf_mperf cur;
+	struct amd_aperf_mperf prev;
+
+	u64	freq;
+	bool	boost_supported;
+};
+
+#endif /* _LINUX_AMD_PSTATE_H */
-- 
2.25.1

