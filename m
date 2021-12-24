Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333AE47EA0A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350596AbhLXBGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:06:33 -0500
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:7299
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350616AbhLXBG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:06:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3fmc+vwGlV0Ky4xk/A5NrbT5Ah6fVQQoQa4E1mWisYwn+4eQ6vuHOiS4sORZt3SQiFxiQSnb5PIc7S1t7owi4vJ4AZsxi4YW5vYxsea3F4HRLIEFnjDiRI/L6R7WSSmTU3di7/1iTEDibEy5j6BH74W//D/s6OnCNZa79K/EDHGnbTdCpzFJZvG5GWHRGQeXJQmkkInH2C0+rgtP+mDNWA4sDYD7Q46NfUqYiiUKKZ1DoCIQv0CKYvbtuApSYxr6mNPHGV35wahJlTMPMhAsimqSCDYot5S2uiy4UNaNdWdAkVaAinfeYcuVOIF5O4a9bchZTz266hZtK9/3VmdTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWpuXfWTucxJ2qCTCcDd/T/+bNnu//YZTSnNXBij8aU=;
 b=cUnQrlAu/mwEJ9doA9ziu+t5UpIi0MuvbH/NmWvogxi/w26WlmvfHkCcbgtoG8ntt12F+v3BRXZUT0SlgzKycGj0EQJZuR70MTlantWce85I1ByAv8YecnXtINW7lG/ltKsaQuAh3V5ADx0dZTZGDsmxCOuDYAQIUSatIlsoScJnMPnsJAqg4d9ew+11hUKfDLmrVyDm0BqkZuLT6Ufaa8GFlaeUaop9746OyGxlCxzCuaedcUY3EudkgpcbomOz+SImdjHIzP6mWdWKlhFfvJMfFnIrc6Y48uKPNtBXruXeoH4SgBBm7dl8k8Q7BJwfAOzdL+5BLPK9yq+nwNK61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWpuXfWTucxJ2qCTCcDd/T/+bNnu//YZTSnNXBij8aU=;
 b=f6ZNCwvF1tr6s5F0JVnIesofSMTGQD9b8ussiE8l2Kwt5BRBL5DWIeE9KQ7zB9J1WvESAbo0IpwiYxqXXHFWDO7zixqddRDPQq0FuHQtdBSP5EHfQPua0Hl5fxpzNrEM0AJOu3NUD1TdXhSEH8thdhFyXvV67k26T94bszzh8AI=
Received: from DM5PR19CA0041.namprd19.prod.outlook.com (2603:10b6:3:9a::27) by
 DM5PR1201MB0235.namprd12.prod.outlook.com (2603:10b6:4:4f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.17; Fri, 24 Dec 2021 01:06:26 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::bf) by DM5PR19CA0041.outlook.office365.com
 (2603:10b6:3:9a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Fri, 24 Dec 2021 01:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 01:06:26 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 19:06:02 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Subject: [PATCH v7 08/14] cpufreq: amd-pstate: Introduce the support for the processors with shared memory solution
Date:   Fri, 24 Dec 2021 09:05:02 +0800
Message-ID: <20211224010508.110159-9-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224010508.110159-1-ray.huang@amd.com>
References: <20211224010508.110159-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc84c6e3-5ae5-4f81-25c9-08d9c6799c5d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0235:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02356299A06D0A302812327AEC7F9@DM5PR1201MB0235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9HFCEQwC6SF0L1D8KrGkWYM0ohYBIsJcwZbWLtCqpaQZWTV+xiBZa5QoP2RTPS/zYDyFggLQGFjSACqjokfelaqCmb/4+mHed+K/pX6m8q+YdK9P9k+ZQWREZyruBKIkiuq347ZydbubQ6rgS+3LW/uGp/4xQ1Kza2iAylrAKQHIQjrRn0gOFzgQH0UmsHCayhheSPCfcxbeeRgFYjfopXowXnJQy8p+BdyePeHacocgolocPoTr/mvBjnTwaX8yfmAjw2RWzfp1vOkb6Wd+koqL9fUKKs12VYRIaJIOG3s30Q7FzgAKfiaFT9XBjBZld6dsGgs235iRxEhkqJdTco8n3gNmm0otK3AKuYu1Unbk53ncKXShlB81Sp9IXtT8Ati+SEBYPb0YjK4GSZP+mrkw1og1rGh5eCC52Tr/tHq7yXRplBf2aQwPeh8CqhRVzYrlL5HNNPcovAPkycKBoY9+utCf2q1xeptbJwiMsONJXzLgAyW3NtFuUkszCihJKUd9gIDV4Vo5Nzn0Y8KnDs0GG9ebpHuqC/Wp258qWNflF3JPo07wvER99K7jwomo5ggz/vB9YSihlBCWy/VHgH6XHjqfwdrpDikEW+gI8R/V6Dw4fYB+fylew2xf3QTGW0t/d5EZkI7sHMKNA6WfEtMl8jr9NorItJ4xt2T/i+LOG7+Pqu6/py13Rp2FEJsOVPm4ANyLPtcOLiz1nuddespP5MXWfX5j02JnjncFaggVm7S+nwWu57IgCVCZ8rc3Ea1B5FES4MtIPcOqTf9d+EDVMgFD46mEARSyrYUYY0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(54906003)(110136005)(5660300002)(1076003)(7696005)(2616005)(83380400001)(316002)(186003)(40460700001)(7416002)(4326008)(82310400004)(47076005)(70206006)(356005)(8676002)(2906002)(36756003)(36860700001)(26005)(426003)(16526019)(508600001)(81166007)(70586007)(86362001)(8936002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 01:06:26.5391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc84c6e3-5ae5-4f81-25c9-08d9c6799c5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0235
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
 drivers/cpufreq/amd-pstate.c | 105 ++++++++++++++++++++++++++++++++---
 1 file changed, 97 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8c9c199b560e..cc62f7484007 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -48,6 +48,20 @@
 #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
 #define AMD_PSTATE_TRANSITION_DELAY	500
 
+/*
+ * TODO: We need more time to fine tune processors with shared memory solution
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
 
 /**
@@ -85,12 +99,32 @@ struct amd_cpudata {
 	u32	lowest_nonlinear_freq;
 };
 
-static inline int amd_pstate_enable(bool enable)
+static inline int pstate_enable(bool enable)
 {
 	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
 }
 
-static int amd_pstate_init_perf(struct amd_cpudata *cpudata)
+static int cppc_enable(bool enable)
+{
+	int cpu, ret = 0;
+
+	for_each_present_cpu(cpu) {
+		ret = cppc_set_enable(cpu, enable);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
+
+static inline int amd_pstate_enable(bool enable)
+{
+	return static_call(amd_pstate_enable)(enable);
+}
+
+static int pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	u64 cap1;
 
@@ -113,8 +147,33 @@ static int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 	return 0;
 }
 
-static void amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
-				   u32 des_perf, u32 max_perf, bool fast_switch)
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
+DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
+
+static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
+{
+	return static_call(amd_pstate_init_perf)(cpudata);
+}
+
+static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
+			       u32 des_perf, u32 max_perf, bool fast_switch)
 {
 	if (fast_switch)
 		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
@@ -123,6 +182,29 @@ static void amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
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
+DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
+
+static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
+					  u32 min_perf, u32 des_perf,
+					  u32 max_perf, bool fast_switch)
+{
+	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
+					    max_perf, fast_switch);
+}
+
 static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch)
 {
@@ -332,7 +414,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	policy->fast_switch_possible = true;
+	if (boot_cpu_has(X86_FEATURE_CPPC))
+		policy->fast_switch_possible = true;
 
 	/* Initial processor data capability frequencies */
 	cpudata->max_freq = max_freq;
@@ -364,7 +447,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
-	.adjust_perf    = amd_pstate_adjust_perf,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.name		= "amd-pstate",
@@ -387,8 +469,15 @@ static int __init amd_pstate_init(void)
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

