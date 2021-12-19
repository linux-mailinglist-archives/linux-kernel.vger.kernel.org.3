Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F205547A15E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhLSQgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:36:50 -0500
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:62273
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236217AbhLSQgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:36:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvrmWGL6RYdPcGXL/8nFjMEEokhMWfXD1LNMXMT7HoKHVb1BUgk9qKW1O5r3903l76G72SIPh3V+KxETBYwG0p6yRGG/mWRpBuXI8z7a6LpMdl5tet6fIMtbZO2IZBuUD4sw/XcgUYXj8b4wojBUHgx31srnY7PSg3KJ7SSL2001szJH2UUoYZQfxL0ol2sVaWxJjGdh21SpCok/NwZBaqdmiNLk77vENorIusyj9J81Nqm5WFVihlkBuXnkKTUsKX11g5vAHX2+Plaa63cZP6UezBqCdKegRnscccUH2joaG++GZ4VvruKnWmn4pb4fazc9bTY9URCWSPUjOxKZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4kofuvLXlSSIG90eoO+W7aG/JHiKFyGYrrKhIaJD2w=;
 b=ce7/yb7oNvx4eg4GNj/5hIFDSU0b9sshAqLBiId1i69Z45DdDTrvbTa67efgdyFsCYM4n4yCyv6H/525TUoYP2SwvHJ3LxfiEWJUAgiPTHkgSsKEGuFYxvJsqc1fgXDMaeVDDNcBofUVL5ijcApvT9xPpdw3Sw9IVzP2ibzcwYUczBfnTP57dt+e423pI05KeNIkkFomHG32aCVpoltV4ztPq+mJHAxIlSCjEG/UgLPgZdW5lWivmDmUdH30zL7fN0C0ixfhXHVMmWjzbXzDiVHyaKy8sK0gGNDR2D1aNoEsPZshHqAq/Ewu7MivJmHax/gj2NSUx8XWKsme6EmVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4kofuvLXlSSIG90eoO+W7aG/JHiKFyGYrrKhIaJD2w=;
 b=1H64Nhljp6UPx5DBH3dFLFKrp0wPNZ2jPgGcL67Bple8ZeOZO+3Q8osiPioyMefvtiUce+/eXGZ0xMmSt8LZcDWabJO4mSLMCXyvihiyBe+ZTaS4ZBF8qfnvyvw0dusWizgMMKjLOeqNqnXoiYnXCwG+4Pp5f0dRGsoJAK65UrU=
Received: from BN9PR03CA0578.namprd03.prod.outlook.com (2603:10b6:408:10d::13)
 by CH2PR12MB5545.namprd12.prod.outlook.com (2603:10b6:610:67::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Sun, 19 Dec
 2021 16:36:37 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::fc) by BN9PR03CA0578.outlook.office365.com
 (2603:10b6:408:10d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Sun, 19 Dec 2021 16:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:36:36 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:36:31 -0600
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
Subject: [PATCH v6 08/14] cpufreq: amd-pstate: introduce the support for the processors with shared memory solution
Date:   Mon, 20 Dec 2021 00:35:22 +0800
Message-ID: <20211219163528.1023186-9-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211219163528.1023186-1-ray.huang@amd.com>
References: <20211219163528.1023186-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dd5166d-f082-4bee-5245-08d9c30db9b6
X-MS-TrafficTypeDiagnostic: CH2PR12MB5545:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB55450B3596BAFE45BACBBFEEEC7A9@CH2PR12MB5545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwddfgNNJBxhMKEh6CFXH6luTlsXHYL89g+RzQ0a2lMVdayQ85GXHbsa+tdi2NDJYEjCXDyF2Q2W2fc37beAApSqTxNWxAaQcvRYHVw3AJDEufODFGHnmM3k1oplXvxdnPEbAvktRBU5TfSKym3S04aVajwKpk/J50PvGIDRQwpfxuw//KYv0MDWyyfGpvUjnYJql6xaLvu6FasZpCl+RJkfZYM+wLXbX6V7b1IYF9mr/55M3cmKCmDTGJXrrHAVZgaiCnFtG08wLrZrAkDAAWWQRqBAJXKbo5ZB9CCpapJUpPyUabykaUqRnwaugnIEHg608qYI4PvQ7bZKQHVg44LhgzyK9YeozVPgv1+Ph9Qaa0bCFkE8jGMrbG1L8NLpSuuzAOOhb7mhxVRPRkw5Kp1nkEMyO1NgmGOF+2HbF0Gyprk40GbtmHFmFqoUSAHaCsY2gkBKZEmmcqHDkW2ZUMrCiEO6JsG7kK3QYFzqwByHTYG6jvyKlIVgzHEwQMZgHXI8c/JhgZWXsVipfB2JVqQq+T1JLmdvjIHopQmc07unB8I1ebtZRI6Gp96j7JAH2WbP5nshWScMPUzLxey8SBMsktj/wY6w0C/ZVnPr9J2ULgfjh49Pi4h5Rzx0PbmEHSb9Ne2kt69szD0fVk2upavm38lDy9NPyvms5vM2k2qxMo7Zl2O847pOLKr7KdSeKkxtKJfzJ4j62+6D4sQIVNGNOobpOAJx3/2HaSAZmGKa/EclEFEU9ZuXtiu9fl7wDz6JKjoczy5xH0LPHgexkmTnLgeYRBgTEoMVwPWzC08=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(426003)(6666004)(70586007)(336012)(2616005)(1076003)(70206006)(47076005)(36860700001)(4326008)(7696005)(5660300002)(16526019)(356005)(81166007)(83380400001)(316002)(8936002)(82310400004)(86362001)(40460700001)(2906002)(110136005)(8676002)(54906003)(26005)(186003)(508600001)(36756003)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:36:36.6891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd5166d-f082-4bee-5245-08d9c30db9b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5545
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
index 14e8a566ea17..25d4f0563a84 100644
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

