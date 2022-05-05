Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305BB51B5FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbiEECde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbiEECd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:33:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FB549F35;
        Wed,  4 May 2022 19:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOfVymYPRY9Knwba5zkz2qQWqzhsgV5nQMVwverzKRCi74J86iU+ICNnyqhiBmgAMdWLjJW57Bt6Z11uBLaAC4/rPLvIMV65NHngzcBZmY6AqWruizVcBgGUDQ0TH1U7C/d6lwdi3nFZv9LS4tLawPrFH5GiCXLYl+DZZeZdehvLQ5VTPmsyHtohin5Dd/njnSUsFuJoici/4DbOV8MMT4GVYMNehVWNa8xkf0ZHUopVhixB6+HORAMQjubRqTX2PaHNdNNd0cE2TO1awCQQqxILVgCesLsVzyeuT0H3Fjv/Oqeg9zlC5omMmdAcJKgNHsisuW2WQAKg83GbB128Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPnNI2bIDkdlt38aPtGjA+tsnC2UfqcIM1ohrVtJmu8=;
 b=mx2s9R+KOZt7SLUkEwL4gc22utkn6UEvfaGxs8elZ0Dl8Ysuy14p27Wf5dy+InqHQbW6HHX5cAcJZmpTC0MFGwNvZ3x31uqgZzgyAJLLNhpYvJKC+fBn1xoYkVSJj+3xcyL5hVfqhhY/Tn188rHwuQqOy9HiAgBFydKT/HQWL1fO5j8fj2qohvkhnctMxYPV2TpzR9inwvgww/MK4pVibqg8Rm//MWAhDELXytvPELS8PYZT2EFqLbWZ/VMsBf4UZqwSW7I7/IhSV5C0YcesOSYtuXDd/hNBbIXD6InYXbbEX8N+j/OlxkXNGQpBN/jZNBvajw1uZIo/BX9iAKzMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPnNI2bIDkdlt38aPtGjA+tsnC2UfqcIM1ohrVtJmu8=;
 b=dd10giTut9Fp6KwonPu2FsvlO4sKZDTqOYXfsxKu36QP/1LYuaU9l5y4OqEckssxcOeQ43Cl4Ibq0+Qw75ejrHtqr0U1fsbwznBzunp4QK7Te3oStPiSiPgXxS7eGYuEfChLAq+/BiHdicKyXhuaLJx3EXJKbpbLJFSAqxqngDo=
Received: from BN1PR14CA0003.namprd14.prod.outlook.com (2603:10b6:408:e3::8)
 by MN2PR12MB3821.namprd12.prod.outlook.com (2603:10b6:208:16f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 02:29:49 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::f5) by BN1PR14CA0003.outlook.office365.com
 (2603:10b6:408:e3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 02:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 02:29:48 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 21:29:44 -0500
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
Subject: [PATCH V5 1/3] cpufreq: amd-pstate: Expose struct amd_cpudata
Date:   Thu, 5 May 2022 10:29:11 +0800
Message-ID: <20220505022913.329259-2-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505022913.329259-1-li.meng@amd.com>
References: <20220505022913.329259-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f49c203-6faf-4c86-59be-08da2e3f207e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3821:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3821030D544237620E76BA5FF7C29@MN2PR12MB3821.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NsTOEPztFYwQx3wbS+Roa0Fb1icvssEYe8xE4UVuz1qNF/qHWWu1EfXJNoZRXGA9hetvc9fuOCVXdY8uE/IPA/KupM7Y2vyBXpQnk+MvF1fP03lJp5kUB9JuJARBE9uTgDE3i5YSREM7gGUQAHoApygJhdA+5KCc2tYwi8LZJw9u3BtiopVtN4UW45resi61Hri6LKVpHkfvX0AaXVJpTQpO3wlRmhecz115zAo26XInfwJMziM3U1iZktRIP9Moejonw0LfxVLTJEm8SchPx6GwSiwsalwAyndYQ4yj6JnLK8oODjMw0jrL0oUJ+ntbBcXql7+ygotLMc/x9OeZQK6BxsWEibOx0IRXasT8gzkaKmsZxRf62XJwvIIDQW6S2IaOJsR/0xdS17Dy04KGjgri9Wg84g6LR5P6bEpfVk7rGBsHTEQxSm5Tw8H5Ohx5BXzxPcMI8iAA0B9TMPbdFkrrPdpskfFA0AZyxcys3CxFZjkCron6lqp4Rqu34v0NdY0FmQ1nwp/rT/BlLGh6rUJQQXQAqgFgHL8ekg6xhhL0WA0Zhdvt5x+LOeZrlh7QZB1TaSDuw2VJW11BvAHb6pJkMA0CbJ9bcK930noQhTm0ENDH+rsztniLZGC6BpBWiQIhZXfNXdcAfN9mVuk+c6kO9PZcyZH1ZqKTZLLx2xUCClCi6lE1pFymlWsNVYM5WS0OUG1TZWKwtzllbDSXHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(336012)(426003)(47076005)(40460700003)(81166007)(70586007)(83380400001)(70206006)(2616005)(110136005)(36860700001)(16526019)(316002)(186003)(1076003)(54906003)(82310400005)(8676002)(26005)(86362001)(2906002)(36756003)(6666004)(356005)(5660300002)(7696005)(508600001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 02:29:48.8690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f49c203-6faf-4c86-59be-08da2e3f207e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3821
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
---
 MAINTAINERS                  |  1 +
 drivers/cpufreq/amd-pstate.c | 60 +---------------------------
 include/linux/amd-pstate.h   | 77 ++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/amd-pstate.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 40fa1955ca3f..db85d9e52547 100644
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

