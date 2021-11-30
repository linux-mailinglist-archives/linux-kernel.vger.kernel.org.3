Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62446348B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbhK3MlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:41:17 -0500
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:45152
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241748AbhK3MlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:41:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghpCq8Ncf3m8Ja/FrcarYWLj+TP+G9Z9W6It/OWsQsjowqytQWs7/rjaYIrdM5YQImLRZqdyPKW0L2GOXYNWpL5ORCTYvQmNPpIuHzNDqK8ReY+V+J1+qRqPWi5uJxe6iK1nSDzkit90K5UDluEIwyK596MZEcrafpc9tl5McdMLp93kY0KCV8UOM5CYg+LdQKFEN10OjxyG2EnlbHpTsJB+1exRJIY2INXvHvQDUa9bn3Uhc1oanH4nRO1LVwQtpbCZn4Ot/joTlufr8NIOEmTgNGZDgJmYBsi2WEmMGy6pVPku47pA1fHxJe3biupXMUeAzPyrvswDZ0hDJbx3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8kCzHZKtQvqC+wWuS3fiICxhskb3JWH1Q4GUeQMwsY=;
 b=azgDYRxNxqtwvzZ/ap15me4zYLp9oOVuMtuzm/z4MOJiTrYS/kSbpf9Uk4mv4bEcnLx7gUWWwKORZfAMaHMMMLVSS2p8kM7ChAugo/FovJZfcZMMojQk6F0bXL5VgAnLl5bN6HHJ9v3sGcIxBznsg74YSlqTT31ulgAT/hO46XE2NKDcPYbh69QWsSOWNkTbp5S0hNuzCtY3cPPgynIYuBV2hKMhaLMOGYH+jZ+1hRWHivBDU/R85WaLpF5v2yhcE9n0SFRGzAsDIOPbFu8Q+ZIh6ezK6HqzXEBfZz7Bv+4YtMzEoeSsPCIbZIz0+LaAQdt8MlIACABEdB3BY7jRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8kCzHZKtQvqC+wWuS3fiICxhskb3JWH1Q4GUeQMwsY=;
 b=rJc315nN8C9C+KB188hwVJ0kDO1tJraBkcARvCd3QmPWA8xYQQx0Wcs2QPpcN5BEM1VvIvSnqtR7j7OsazeNfig54f0JzvD13RB51JGXwzFaWYohKU0UByTVUgpLIV4PPiL9l3fWV0oYg67lEpq/zRo1YqKdEXO5toXt9c+omz8=
Received: from BN9PR03CA0766.namprd03.prod.outlook.com (2603:10b6:408:13a::21)
 by DM6PR12MB3113.namprd12.prod.outlook.com (2603:10b6:5:11b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 12:37:39 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::5e) by BN9PR03CA0766.outlook.office365.com
 (2603:10b6:408:13a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:37:39 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:37:34 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v5 08/22] cpufreq: amd: introduce the support for the processors with shared memory solution
Date:   Tue, 30 Nov 2021 20:36:27 +0800
Message-ID: <20211130123641.1449041-9-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130123641.1449041-1-ray.huang@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b16d09c-0130-46ba-ff43-08d9b3fe3226
X-MS-TrafficTypeDiagnostic: DM6PR12MB3113:
X-Microsoft-Antispam-PRVS: <DM6PR12MB311344C20F4D2F357C57BED0EC679@DM6PR12MB3113.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /YgQahlvxlsvTfugCfxYsbZVe3AHOF3MMU+t6Mfzs0n5UPmaavzOLNB7dNxLWJ+4e+01GXPFpOO423WvQyPOyfLwsBdrYN/g4ahN8LvsnfaSnU8mAgvZsuBOYWv8A0Kc0ydvYpNJGAqgv1YnaJYvga5Z3POi3bhDjj/8jOpZdhE4Aa9qVltgvG4uK7AGjv6rSH/U7BGcM0uMCGMCCbbV0mTRzpfeML/w04dm4ZziTJZUm/3vcEhhkhO9meeIQiGvyKCxUWbcuFJDm+EJ4Au0W3QxPx4KiggSVMeshuZgWKQdktgtjSPH8G3wZd1nMt4SmB/H78jW6C3OvxlcTxGWbP+f9PqHLml2wlccV78Ey5Yn8m7EbmqzNuWZmWKThPVAcOcySeEiA+e76kGMBjZzLtvzUmg1OOUGL5MIQl3iJsA7MHOBQV9yC+7F++p+dmcPnfHA2urNmHiIU/kp6NxbFrhqGevITIxFlWVF19o56rEZ+U4ACrvEkOJQxbV5/ZZYlCFjpQxIkgT6LPZEf+3c5bXjJ/h24dCm8aZ2kgJlPEU61vyzjtJLOSbdy/w9orGf8TGmiLoYyiLLGnnN7UOZghvbM2cvq0JzoHUxyel3LvRPsht/aHr9RLN2psa4SUN7JfWCnit3Ynwibh6LCqxA+mbYt0g/K92xvYiQa/7FW4Z9cgcvUHkYr2IcX72kchRjXtW+/7dZ+5ZOgUvFL3KqcBEd4iVpV9rS/xAD2+TQEepyQgI7x6mCW2hM0+JRUUW8lZjS+IEFimvhK9sx1V6qgTpGNjljMQu1qVJP44WyvSM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(5660300002)(2616005)(110136005)(426003)(186003)(508600001)(7416002)(16526019)(356005)(4326008)(8936002)(26005)(54906003)(86362001)(83380400001)(316002)(1076003)(8676002)(6666004)(81166007)(36756003)(336012)(82310400004)(36860700001)(70206006)(47076005)(2906002)(40460700001)(7696005)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:37:39.3307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b16d09c-0130-46ba-ff43-08d9b3fe3226
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some of Zen2 and Zen3 based processors, they are using the shared
memory that exposed from ACPI SBIOS. In this kind of the processors,
there is no MSR support, so we add acpi cppc function as the backend for
them.

It is using a module param (shared_mem) to enable related processors
manually. We will enable this by default once we address performance
issue on this solution.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 72 ++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index cab266b8bf35..68991c450fd5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -35,6 +35,19 @@
 #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
 #define AMD_PSTATE_TRANSITION_DELAY	500
 
+/* TODO: We need more time to fine tune processors with shared memory solution
+ * with community together.
+ *
+ * There are some performance drops on the CPU benchmarks which reports from
+ * Suse. We are co-working with them to fine tune the shared memory solution. So
+ * we disable it by default to go acpi-cpufreq on these processors and add a
+ * module parameter to be able to enable it manually for debugging.
+ */
+static bool shared_mem = false;
+module_param(shared_mem, bool, 0444);
+MODULE_PARM_DESC(shared_mem,
+		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
+
 static struct cpufreq_driver amd_pstate_driver;
 
 struct amd_cpudata {
@@ -60,6 +73,19 @@ static inline int pstate_enable(bool enable)
 	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
 }
 
+static int cppc_enable(bool enable)
+{
+	int cpu, ret = 0;
+
+	for_each_online_cpu(cpu) {
+		ret = cppc_set_enable(cpu, enable);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
 
 static inline int amd_pstate_enable(bool enable)
@@ -90,6 +116,24 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	return 0;
 }
 
+static int cppc_init_perf(struct amd_cpudata *cpudata)
+{
+	struct cppc_perf_caps cppc_perf;
+
+	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
+
+	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
+	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
+		   cppc_perf.lowest_nonlinear_perf);
+	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+
+	return 0;
+}
+
 DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
 
 static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
@@ -107,6 +151,19 @@ static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 			      READ_ONCE(cpudata->cppc_req_cached));
 }
 
+static void cppc_update_perf(struct amd_cpudata *cpudata,
+			     u32 min_perf, u32 des_perf,
+			     u32 max_perf, bool fast_switch)
+{
+	struct cppc_perf_ctrls perf_ctrls;
+
+	perf_ctrls.max_perf = max_perf;
+	perf_ctrls.min_perf = min_perf;
+	perf_ctrls.desired_perf = des_perf;
+
+	cppc_set_perf(cpudata->cpu, &perf_ctrls);
+}
+
 DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
 
 static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
@@ -326,7 +383,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	policy->fast_switch_possible = true;
+	if (boot_cpu_has(X86_FEATURE_CPPC))
+		policy->fast_switch_possible = true;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
 				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
@@ -376,7 +434,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
-	.adjust_perf    = amd_pstate_adjust_perf,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.name		= "amd-pstate",
@@ -399,8 +456,15 @@ static int __init amd_pstate_init(void)
 		return -EEXIST;
 
 	/* capability check */
-	if (!boot_cpu_has(X86_FEATURE_CPPC)) {
-		pr_debug("AMD CPPC MSR based functionality is not supported\n");
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		pr_debug("AMD CPPC MSR based functionality is supported\n");
+		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
+	} else if (shared_mem) {
+		static_call_update(amd_pstate_enable, cppc_enable);
+		static_call_update(amd_pstate_init_perf, cppc_init_perf);
+		static_call_update(amd_pstate_update_perf, cppc_update_perf);
+	} else {
+		pr_info("This processor supports shared memory solution, you can enable it with amd_pstate.shared_mem=1\n");
 		return -ENODEV;
 	}
 
-- 
2.25.1

