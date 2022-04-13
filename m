Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BBE4FF2E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiDMJJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiDMJI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:08:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1853945067;
        Wed, 13 Apr 2022 02:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9Bw2IIWHxpEb/KhCdlQ1aVYKl8gP9w+Fn4V0GTjguCpNgLfISdJgbLMqeR3Z0VxoSHHYFAxVhaj6bmhQxK48no2EFV3R4DzByqve6q9v0qqC67I0l8OgqCE3S3MznZAbHgmg2zMgZWtsExps6Gh4yE0Y9N2FNNZ4AdJB3i82IKoawvQEZhB7WiKUEYkDo0eUjIh1APKTw5GkSBVxk1WjfoOSKrLQY4Iq8nv92tGTQxIwAGrStrG1xb66ZncV4AIgDL2Ev3ickLEaWebT9mxb7zl2p3kphZhnwV2UCkiAk0uiJk9bYAZqDp94u0lckhtyNCt61s2qVw+7E1OJdODFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1M/gAui03GK7QWanBmlzhDkBO7xvhEjMyYIWDq8v50=;
 b=JMHvVcnh+//0OrJmndtvBcvKqDawkMlN3rVT0JTb40zy16gQ0i55Eb2QAYlBOAbVRdYt5PUmHQmGTqC3emvayBOpWY2bJ28CouDXIgWh1nakCoo8AivNTcVlVkvu3KPNO8ZKTqqUqlslb1o5h5xCqjUAj8+uIX+ldyXtE8UBpKjPSNdjlWEKGBhvahA9SZxGTBSt9nmQtkcoYtVsTfbts/xHkuB9GlWXOZABFK7PNZLJzrmWCFSm7RJsu6K6aKJoH+2SEQ2suYCD4SBwu/891aTQJH4QnoYuUyg5qitocBE5+LVxb2/D4aYJiBcuyApoJuEiJVd3JWRB1y3GY3rfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1M/gAui03GK7QWanBmlzhDkBO7xvhEjMyYIWDq8v50=;
 b=F+4tKnrUorRFDESYcHIcokfQgGWm80QgFal7IUC0ScJO9caAfYsJsjchzesXnZiHFVsKVf5i2iELu2ASzeyw40FX9c3zQnNbuA3qJGYuXSqb9G8ULdhpNFr0dDpdLEoLDhPqWiUuDSqxfIxlxSiw+z7HurZ1kG0BucNB+hUPh70=
Received: from BN9PR03CA0412.namprd03.prod.outlook.com (2603:10b6:408:111::27)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 09:06:32 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::c0) by BN9PR03CA0412.outlook.office365.com
 (2603:10b6:408:111::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 13 Apr 2022 09:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 09:06:30 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 04:06:26 -0500
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
Subject: [PATCH 1/3] cpufreq: amd-pstate: Expose struct amd_cpudata
Date:   Wed, 13 Apr 2022 17:05:08 +0800
Message-ID: <20220413090510.4039589-2-li.meng@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d352b309-ae0b-415e-0122-08da1d2ce693
X-MS-TrafficTypeDiagnostic: MW5PR12MB5598:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB559860B133F14C782A0131AEF7EC9@MW5PR12MB5598.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syYFovIqM3Wp82a04zOyRSXGEKTvkRIp/z1dmB08CAN8V/4D7ES+4BsOKAXaSOKzbaZ0ermNS5UrCE8Z8o0R4/YCyC4S8/prU41W0KS/YS+YjxMROpN4/SsrBTI8tBpzJyzc9L+sMCCvRREzjopI1Np0zl/vY2ijP8gBj7qpEoJngilP6LymdiynJMdunpaOqoX21J9/KASVQdiCwsyM/K7rDBDaMkcafNTqCC049P4iG6z16l9KG/MvKr3sgEiPSzKv+WfH+65+w76qKO+IjOMrW/rC/24JX/ek/Pk68Wy/Eqz5CYr3ZM4+DySO0grHbj2kpUBf9Ahu31rKZpTcDvSKMuaZvav+XKZEIEaVrOyROFKLnMtgQlaH8fEYcsq/IY3xauoprAnioWLoYcy2STGyzNa8rnnC8UCWSv4iAtQdV6fY+aEooVWWMI47jjfXKVYvhVPvX0WdFIvLUPlzjp5GzwuTmS+gcnUz4+5rVVDZUMgAugFTe987NIS70Q+awUuQ3o5fR5bppewlGI9vsyJv0K64q7vnV7NOMux/vTbaVGUU+SafM63rdkmlJT0l69xvRhr5EUbSRPVrFHJ1AL4XlLMszOvcepv7xdIJRK4jU34BXApAQsKt8Qu1PXaaT/Me73koVHUktx1XWxT0R7aOXTwkbogcIwbXoRuX/b5Yl4tatn2ypdug05TU3/1+trr7+KYuWWgbv5AbzkPR4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(82310400005)(36860700001)(8676002)(4326008)(336012)(426003)(70206006)(83380400001)(81166007)(2906002)(356005)(5660300002)(40460700003)(2616005)(16526019)(8936002)(26005)(47076005)(508600001)(316002)(1076003)(86362001)(6666004)(7696005)(54906003)(70586007)(110136005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 09:06:30.9881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d352b309-ae0b-415e-0122-08da1d2ce693
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
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
(amd-pstate-ut) module. The amd-pstate-ut module can get some AMD
infomations by this data struct. For example: highest perf,
nominal perf, boost supported etc.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 MAINTAINERS                  |  1 +
 drivers/cpufreq/amd-pstate.c | 60 +----------------------------
 include/linux/amd-pstate.h   | 74 ++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/amd-pstate.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9832b607e2e2..f108e83ba851 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1003,6 +1003,7 @@ S:	Supported
 F:	Documentation/admin-guide/pm/amd-pstate.rst
 F:	drivers/cpufreq/amd-pstate*
 F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
+F:	include/linux/amd-pstate.h
 
 AMD PTDMA DRIVER
 M:	Sanjay R Mehta <sanju.mehta@amd.com>
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
index 000000000000..790b04c9000b
--- /dev/null
+++ b/include/linux/amd-pstate.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * linux/include/linux/amd-pstate.h
+ *
+ * Copyright (C) 2007-2010 Advanced Micro Devices, Inc.
+ * Author: Meng Li <li.meng@amd.com>
+ */
+#ifndef _LINUX_AMD_PSTATE_H
+#define _LINUX_AMD_PSTATE_H
+
+#include <linux/pm_qos.h>
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

