Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77245099C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384217AbiDUHpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386095AbiDUHpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:45:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CC91AF37;
        Thu, 21 Apr 2022 00:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYCK/EgtBcySOxMSrD8jaATEwdX4cK6CZq8I5HpFsfyo8GA1rcZMNGfZQx0ihWxVQPmpMxM6Oss8r8gL53i+jGLZp1PcCf1o8X6u3MZRMPGnHb6JnO8bGEI+MKmlgHMU9QA6HKyh3ChjrbvUvoKj6vrNmhftYTJ81QEO9DDicMFbKKJRYYRjyLiaSjcsI+iHj+YzMmws0KwnIUCxiAawKdN73LeKRr83bvu82XR46aUmn+95T5bzvoS52rFXkZPpLhp2uU7BCodxqLbzyFPAVuj09wnRDdLlADhTg7N0D8tPNYHMelfQ+xIk24ddyahZ7f8cWGMHNG/qRoE6O2LbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+HIy5F3Mghw8wabNJpVsCIKnWTQy3XGzrLVsZ4po1E=;
 b=R8895m2AFEmiZQI6/R9NoL8dY7/fj2/huK9ERf/oIIv6okPf2Vim4ouW+aMKhjw4ZKkKVxczQhNt+UDs5Z57WIuKrtgsh7MJD3DZEV9Z+nkJtyMWcmjRwJsD3QtPfYG5/ufHAkOl+m1T+vqW2OvqdU7GJlQ5SJvXZEB46IqoNXs5jxLI/UHGkjl6G2VsAA1Dfai4VId16QJKcZuEvGtKM2zHSPl5Yk1B8itIgI7yrLqU0/KYgP/Mux/HP0S2PZ+fyzkHztauNN/mgB5Q0lk9s3E3ElCgVCMI4R9+epdWatBsnJxAW54BcdTV5YIcyCkvWhLA26F72y0PJwdHXnRtZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+HIy5F3Mghw8wabNJpVsCIKnWTQy3XGzrLVsZ4po1E=;
 b=i06JWyDjfnMSGRWb9qt3B5fKXPR35gY5kAgvGSsmr+3w7SCaz5IEMzj4zTXddrLC5FNJxK87mbFRinhb84EaiRNhXCoOZ+4aFOn4ULyKlV6u36V0qtAX24LAywyXed7WSENqzdu8gC3w0St5Dpp1UcPNJPt86tp9F5h12m3R/J4=
Received: from BN8PR03CA0009.namprd03.prod.outlook.com (2603:10b6:408:94::22)
 by BN6PR12MB1795.namprd12.prod.outlook.com (2603:10b6:404:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 07:42:19 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::bd) by BN8PR03CA0009.outlook.office365.com
 (2603:10b6:408:94::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 21 Apr 2022 07:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 07:42:19 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 02:42:13 -0500
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
Subject: [PATCH V3 1/3] cpufreq: amd-pstate: Expose struct amd_cpudata
Date:   Thu, 21 Apr 2022 15:41:50 +0800
Message-ID: <20220421074152.599419-2-li.meng@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2027affb-9262-4ba9-2ccb-08da236a76f0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1795:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB17955CF8778C900FBECD6AFEF7F49@BN6PR12MB1795.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPBgiRyWj9gkBK1ppJkSlaBxUF5VALZoCU1mdhro4AbdaVoP4ZoPBfwPcbXMvaOaKWwJPCnLKwvR3tbl9eJ+niVYkFmUqb221Os6Hx4vYN67HO6EQJRZZij0n1bekHPfUYep3zUoyHNmxwRm293EtrQazWqBimPp/4Y2Ytrc6guuYcAaV3XAS5cN7dRc8filpq61WqmsjE/vqA2PUGo0OaOvO0bi8Dx9+yje9gcFQRX21Pb01WrHLjt8K8AlANqIbJVTLBRdq+l3fIgTqdbYLPV67O5i0ikKbLEFtVLedC6GxseLMIArQYx1z3898vczvzVB7WAsHml44FyLY8MrhdA7vrimv6fO0H7YqKGYhuRVa4BVpE8CXvAoROVUKK435fbFwsy+6Sl0MhzTvdFkyW9ilC/0W6Vo/k4pqU+W5xgQV5KycpOF/u5uqrWVRoKbESHc2RLYVRTBJuYIcl3nDlne+a5S8ILQUElfH1pW4XXi7bQtGauc03EZQKVK/mkvY8ulgI+Okj22W2ZHpxgDScJvzHgD53pJ4MYBgNC6dq234zW2vhxaEfHq4iISy+qkooIBYj328TZbcXwY4eQYROSNuvtboj9mg8L3xCPKphNZoGr9jg2/GSYof7OvbBhx8Mjckz4+s3oaYDhRhEMl7+ChKRG69b8u2tc0B/VQfrWQJI1l7cK8XElOBELqLNgDboECrPuQRpsHMc04D1W6Cg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(36860700001)(1076003)(316002)(2616005)(426003)(16526019)(186003)(86362001)(356005)(70586007)(70206006)(83380400001)(81166007)(47076005)(4326008)(40460700003)(26005)(508600001)(5660300002)(7696005)(54906003)(6666004)(36756003)(2906002)(110136005)(8936002)(82310400005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 07:42:19.4678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2027affb-9262-4ba9-2ccb-08da236a76f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1795
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose struct amd_cpudata to AMD P-State unit test module.

This data struct will be used on the following AMD P-State unit test
(amd_pstate_testmod) module. The amd_pstate_testmod module can get
some AMD infomations by this data struct. For example: highest perf,
nominal perf, boost supported etc.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 MAINTAINERS                  |  1 +
 drivers/cpufreq/amd-pstate.c | 60 +---------------------------
 include/linux/amd-pstate.h   | 77 ++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/amd-pstate.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 61d9f114c37f..6f814eda95b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1020,6 +1020,7 @@ L:	linux-pm@vger.kernel.org
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
index 000000000000..4dffb7db3807
--- /dev/null
+++ b/include/linux/amd-pstate.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * linux/include/linux/amd-pstate.h
+ *
+ * Copyright (C) 2007-2010 Advanced Micro Devices, Inc.
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

