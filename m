Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A639F4E4D24
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242111AbiCWHRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242099AbiCWHRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:17:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80EF6E8C6;
        Wed, 23 Mar 2022 00:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGzoqcrQ5kLgta43dJoN1KKLmbLRFgPCyu8uM4R6d52kkdWFW5qS6PtnCjS2HmSzSZ5b0bYZII9l6Gr0728WwXtcozO/LmG7G+/wXgT7M0KwgzRLoUzQxfQ1LceiTqWehD6HVVAm7Dd4/iLfQFtAxiVPtdRjE5BKJhgm1o3/M2xppoLvM0LV0y/ceIE3vWbG0CFNeE4HlURKkn4XQH60mbQZHOzIQDWvynm+O5aHmVXFw7YCKq8A/HLZn2AOMkUSl76TqAKP53wR2Nl97NGMTXV1zUZFTIZVkv57klCy/qjga8FMDaeXILl0F9wLw69tTfhJripplneRfjwMQQtF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6mLjL0gjwJwzJgA+Qdpg7SgRygrfExgGsALxNiPB4I=;
 b=c4pVOaO1BGskWcZhqA/27uBiPiJNoLfdMnoB2CR9hRWdUVXPDa6YdxO0FZFD78Dj1mUOIBS5MD5QroWPVK8iNXfV6ANjA7lpfN1Baf4dYoOOsCJSseKykBG4ug5sW2jqvQtw3nOkaWbkdWZOfl860UwtKRB+yQh1z/yp6yhKwGpAgOklP1HmWLd/HDfCrTHtLVaCkSOugq3vsXU7honMY7BrucB3ti1A7Mr8LHX7Sp1aRlFhBxRd6/tirxchQ0v0yEg23lFwWLZisOJ3rz0dPExaD8nvNUnedXofBt0TnOHooKRdmUSo82Ng1fo3k/pLB1ISvwNZ4gJlCj8OpvAjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6mLjL0gjwJwzJgA+Qdpg7SgRygrfExgGsALxNiPB4I=;
 b=U7ief088VYyQbbICZekHtWoMQWcVIuB4aTZmOBqlnrbzaWUI7m3aXegY3zbz+w9Iq1ObJ2uyby7M1b8flSLt9bXu502tSdpbee6p4VxrCxRbkIZAOXZxP3EtuW9o0gZOjyp4awtSinmxy7qEwbH1DORxMc3ZWgeU+BJMwCYnAMQ=
Received: from DM6PR11CA0065.namprd11.prod.outlook.com (2603:10b6:5:14c::42)
 by MN2PR12MB3055.namprd12.prod.outlook.com (2603:10b6:208:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Wed, 23 Mar
 2022 07:15:45 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::d7) by DM6PR11CA0065.outlook.office365.com
 (2603:10b6:5:14c::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Wed, 23 Mar 2022 07:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 07:15:44 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 02:15:40 -0500
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
Date:   Wed, 23 Mar 2022 15:15:00 +0800
Message-ID: <20220323071502.2674156-2-li.meng@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1ef84536-64f5-4ad5-5fc7-08da0c9cf273
X-MS-TrafficTypeDiagnostic: MN2PR12MB3055:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3055461B6851D8B7ACB7AD98F7189@MN2PR12MB3055.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vwQ8j7QEVH/4BDP5tYgX5/ejCHVAhycdk+AIpBCxzrbQc5ezGJZElzTUejx/X8xB7jaWJSKE8kAC4eAoXCbMnCysgEgtN1Qb7BARBTSw8LDG2xFPrGrjJNC6yrXuNl8slkwSS1HGuETj10vi5XJTn4z6QPbJCm1suK8/8mMlHh22QIiBTlWyuX5Gm8FSdDjQDOz2EyirN/DCnZ8vlgd0/ie8rD5/A2zCvChHjVOTC/U2gtFoBXYtnyEKysYp4K5Dh3q/z0+X58OIkLt7mhqMZj/VNol6tgXJyHblKz+UsTDRPWpT7CCoJ8f5eWPhIf+qSLglLMSIsqoSa1N5SQnX7B4urXcbIRL2uyWSuchEBilYD1xK4lcUKgXs8VaMeNhNkMbHz63P8VYPxdUTNcijIJ5fTH00fezWVKl2o6CdfvXUNUJqpguyte7DNuDehYCuVQg0eLbA6Z2GL/L4uecbRw6QYR51EkJiBBRWIyo9lsbzzWDz2G3OhE8i5G5YG7Jwx+Uvhk+2cj+kNfaUA9BZUdaJmceuGUeoN2PexkcdAEtv3nhdy96+Nyi5PZB+EjCAd8SvjRN7+64lWkjruIH34YKeRwushm0iJFaWIcD+waliginub+Ke0aeggo38CTFlczaj46L5mGi4bAbbGpn0OXllE0J+YosthhVauamRZ1TIU3TFpHNLhjjfioMyOVunsLe1P1O+B8zkIBi6M9U26w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(16526019)(316002)(356005)(4326008)(36860700001)(40460700003)(8676002)(82310400004)(2616005)(2906002)(6666004)(5660300002)(7696005)(83380400001)(86362001)(70206006)(186003)(426003)(70586007)(36756003)(8936002)(336012)(1076003)(54906003)(508600001)(110136005)(47076005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 07:15:44.7487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef84536-64f5-4ad5-5fc7-08da0c9cf273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3055
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
(amd-pstate-ut) module. The amd-pstate-ut module can get some AMD P-State
infomations by this data struct. For example: highest perf, nominal
perf, boost supported etc.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 60 +----------------------------
 include/linux/amd-pstate.h   | 74 ++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/amd-pstate.h

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

