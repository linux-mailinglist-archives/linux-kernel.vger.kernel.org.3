Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7055967D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 05:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiHQDtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 23:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiHQDtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:49:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5CD79608;
        Tue, 16 Aug 2022 20:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrPGAyjWMIA08NLFOznWCQhGV0aAvromCRUC/MivrEP0Yk7i9ZVbPbzAUfMX76lp5FVI6W5E8mftH3RzRRQZba3cxbd3SwXRgwo3pAZz34BcJsZHpClDkAUklQx/MnU4ZkjtK6UN40CRjHQbkRghKeY3JTNfNBIjzQK/5l0xxUkWg188cfo/cThEy4vghsoJgW6eAioeXR1LcLU8uZpzZ+QrsSQFteMfaszr19k06ofMO7tOryfQNa+OnkPxEoVRc7egOWyNU3CDY4QiN6RlPyyog82S4V5qnh6I45v67/dZoe8xRbfLTiPXzlj5NZzeURwJd6eV5oKErJe1B002Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTbV5Bqs2MGDamG3ZbiKfiDeggMgoBRYGVPEMhRI0+g=;
 b=buGIoklXc96Wi/dze0KYNtVDYs0ZNjao02Woj/FNXKrygElf9mrlFOGIbKvUengiLH0ZbrYog5QCw+zYdLmoU5NYTEe9ySqB+8n3mxKnHPFgtJabLQHceiX7JERVb3dMXodQCPpEFZUgieiwpOa1sYU5LWrYYEoa7KhAg1r238SFPztBxJEQENpEIkNHUFHRPFt+dfPWfFdu3nIQBsRauyusr+Fq+/n9643IV8sx0T3lz+jOv/v9OhZJqfEaw2X5cCG+p4Y4Om82ww9lzpwR4z0VthoNTUy7dgvfu6lOLPx+9UOOM+2GDYmg8EkLmtIcBPP4NAzRVGO2NR9deqNnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTbV5Bqs2MGDamG3ZbiKfiDeggMgoBRYGVPEMhRI0+g=;
 b=ugm7B6WMpVULXx40h0ZebIUZ6tggkpDY+WuwZyFajxgrzH4O0MBd+Vl3L3i9dzLNFWFw+WaRD4ZGdDtapUNvto4IZtytGthrbrtcB36ZSgYUh2tNyQTeRy02OtQkrK3UXLEFUum6lcopE6SHYUPJZ8J2NGEsvFeUmKxBdiZO+jk=
Received: from BN9PR03CA0267.namprd03.prod.outlook.com (2603:10b6:408:ff::32)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 17 Aug
 2022 03:48:58 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::ce) by BN9PR03CA0267.outlook.office365.com
 (2603:10b6:408:ff::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19 via Frontend
 Transport; Wed, 17 Aug 2022 03:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Wed, 17 Aug 2022 03:48:58 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 16 Aug
 2022 22:46:57 -0500
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
Subject: [RESEND PATCH 1/4] cpufreq: amd-pstate: Expose struct amd_cpudata
Date:   Wed, 17 Aug 2022 11:46:27 +0800
Message-ID: <20220817034630.1172065-2-li.meng@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1ce7eb1e-aecf-470b-4795-08da80036a5a
X-MS-TrafficTypeDiagnostic: BL3PR12MB6377:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBLxiZDXVNQXWSK6BerXjQFsDRovSexejzRXFXlvGp/eMonHTqfWPhlTjpgTcgOPU252huHhHIZEF1ODZ39+UNqSonFn5tcXf3Qm3UyTAda1QBR1+K4gelp+rdpHeOrElcuOb5kpvlAfN5CV6tNI8yQg+/8PdB2tLjuSKG7ncmgzXqQUB9yMzxEJTsvkaS2qCOmUhNy6tmKBxnJQOdfvda5K948SDPssyhZsySGngx8Oynm4epWw8Jsiy86q2DcYMu7m7S7IDitsQm489hkwAR3ovB0XXGiXq9MvChhJQVCE64mbc/to0QVO5EfVny4wm/Rx2rmQxE7uk1djZVRDsfQ2x5AHJs03G+8esRGISiYtxyKxl0VhJEqWcy0LCWM67SzRK+zEwYH/gA+N4XcazYTOUYhmeyNfeS0Q1/AB2J9Tbly9ZBbByg1VgI7I7LvwSXkLW09j6kh3g2Yr3r7tFfCW8CQPhrKm2MiRwjlZ0LgJlWEr/iOf9TJg0idh98QPKR5AfZmsyAfFEL8nHziRiA/OITNHKPyjukeWgDSFBhmMSB2obPJ20vHlaIJzbPPuvu9pQShkgJWbFZWyQPbydXG6f/QVXrW7aSJ7o6ZLaINaKnoqqc5P37FUr6flmX8EbtHQrWt70JS81mkq5QyTalDl+uuarRYDq9AHwP4LC3dMzEddu5nSYvDGjgV3183bx3LtIRe4zXrrwJUQ5X1rVY0rpw4Pb1hWgu2htUqrGkVXYp52Qy1S7p04z84S19ga+yfqJFYZuZPPFKelE+4N2Xql3lGbgCSLRQUqyfhie/KLQniuumSNr+oIlQ67oAjYWNF5SRBVdZs3Nt/hUAXK2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(40470700004)(2616005)(41300700001)(336012)(426003)(1076003)(54906003)(47076005)(478600001)(356005)(186003)(110136005)(82310400005)(16526019)(7696005)(86362001)(316002)(26005)(40480700001)(82740400003)(6666004)(81166007)(40460700003)(83380400001)(8936002)(2906002)(4326008)(36860700001)(8676002)(36756003)(5660300002)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 03:48:58.3280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce7eb1e-aecf-470b-4795-08da80036a5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 8a5012ba6ff9..5c404d2686d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1045,6 +1045,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/admin-guide/pm/amd-pstate.rst
 F:	drivers/cpufreq/amd-pstate*
+F:	include/linux/amd-pstate.h
 F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
 
 AMD PTDMA DRIVER
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9ac75c1cde9c..218f777a5915 100644
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

