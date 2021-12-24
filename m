Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6430547EA0F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350662AbhLXBGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:06:48 -0500
Received: from mail-dm6nam11on2086.outbound.protection.outlook.com ([40.107.223.86]:7265
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350627AbhLXBGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:06:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCYQN415f3IhT51sQpNtbc8d4UszrHobCp3oGNXAAM6YGmK1t7PZK8vBFQU/K+QOhQgWV9V0Q2WL+OjYhlSi6gEBwEnjTD+perltkhw0xagzMbx+1TApX0M7ld879z+juHiaTD8+yCf10OZbBpunVd9A0ZefSh8iMz1QoXaWI07LeJjQCylFxpeyddHRCzWxxOUZxdIFy4u7xuhGkQW3bzOnJ0z4InTSvR5brRRAOA+vQNTU9DxIC0n/9HnUMhwBmbvExanG//1dlPIbIRbe93+yBsgYCJdGnuy4hFcWIWN0oW2iOIy/vCcJsP/jhNc+817XBQJM+qQKypG1PG9+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqYZm80jBoV7PpjGr1WcXjku6+NjEe0Pp/axryI3Y+g=;
 b=YXlwVbk5qvAGRfwNQmoi9QHcA7cIc7PaXmB2Ss4w5lycvZmDyG4nxPrHpNV6KqnNba98sk7D6FHLV+CMV4/T/pTOgcYTOF+89isL2k2D8P1p9yL44bIloDLrW2zZ4xqh3wymvYU9z/Mk9ClPRc2cakeEgC1z97Cj8cVTE6fRduMp8HCK0olYFkM//W6CtnewuiiS4jFkAChrO5I65ZqXx+c1cUbcGPfA6udJ887VPCbtHxW1zyBBHsfMbAdjxxMNjnIARnM93VvUSDm4MOlW2gsW2DtPVqfZArWaMYEGaAtFXCk9kxeNMf4nA1H05tsUr/1tQDpLsGkxjXSX+VkLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqYZm80jBoV7PpjGr1WcXjku6+NjEe0Pp/axryI3Y+g=;
 b=v0n8wMKcgirmbODMZwSdI4NReDgrKdkYKsD0BdSfLYQWP3D2j/rPJVFyNb8ErXq09RmPj9h5E0EVnOBWdXtRHG7DuFJQU6aGP6xa1LnoooLUFg3foFGbMWIEyzrQnicnR8GsLsmZGm6sAGeXs5XgFdR6M3YR080bNduWe5gJ+54=
Received: from DM5PR19CA0004.namprd19.prod.outlook.com (2603:10b6:3:151::14)
 by BY5PR12MB5511.namprd12.prod.outlook.com (2603:10b6:a03:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Fri, 24 Dec
 2021 01:06:36 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::50) by DM5PR19CA0004.outlook.office365.com
 (2603:10b6:3:151::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18 via Frontend
 Transport; Fri, 24 Dec 2021 01:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 01:06:35 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 19:06:30 -0600
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
Subject: [PATCH v7 10/14] cpufreq: amd-pstate: Add boost mode support for AMD P-State
Date:   Fri, 24 Dec 2021 09:05:04 +0800
Message-ID: <20211224010508.110159-11-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3fef9fda-e1df-4bd3-0cee-08d9c679a1d1
X-MS-TrafficTypeDiagnostic: BY5PR12MB5511:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB551150855A4B804DBF63BDCBEC7F9@BY5PR12MB5511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +SUEequgtmzzq7t2zyq6NJJVGXVJyhTqlT2ioKWQR2T1WVK/N4BR35ZESc4ZHYnsSkhBHknlkTikJW6zRhJJuD5GbmJBW3lXOLJDXJg/Zi21NMl/cJ/R9Ox+ocuZsajH7r+jkqMkK8YIVzlPOzW6ECqn9KoHOM7syqbqQILkX0MAj0VcldwBwNfXxHjY77q5Dx7+duQknWsYo8yOa3pNngCpZEEPx83R9hjSgQ+vr4cjrKTGLASmJq9iTI39JRS4F8oFlxwu8dADhhmUr3U8KPG7dBKF5XBqx/jvG4PTw/TnuFYthciIB3bvrUqUvhjzr7rXuxj7IDHjghm8E1pK4Pr+m/vXpVTG7t3W2VGpDpnAmel/IueFoeMct7VTerdYVuRGBsY1B/eOw+SZ1Nhis4vvsvQG0omksuSD/eBTJ21h4UvVhmCc/3WmxVlxOwGoZ/3di6Wz3e1SUrojtofGOqHjuUek84F0vvjSKQXDcDhxWnYkK6Q5I/7XHNaC5eC/cm3jUk1DVroGbszmCOrTKZcwKgpw2C0zjvlWpLVx6xYVFUOFD6C2059Lk0WCnvqG/qzokErEZdlNhA0EKADfLBO1LLxj7hPM2gRWKZdVZHmvF0jdLMNBOLHNy0MWtS9BKBb81fihb9IV3O33TqzUcC27TkvLSZCNPyxXnR/X8gZgbgLyjjrUyUytcFKWQI0Fa3+eqUu1/L4KS5KG1dPYv/uL8oYZBAFJzi/eAkFzN9SNYz8qSNuZtSEX6hgu8IqUKYXOUqjmVshND6HYMLmjJ6wHFWowuM4RmVlWUNuYeVw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(316002)(86362001)(83380400001)(7416002)(36756003)(8676002)(54906003)(110136005)(8936002)(36860700001)(82310400004)(5660300002)(81166007)(426003)(6666004)(356005)(47076005)(26005)(508600001)(70206006)(16526019)(40460700001)(186003)(1076003)(7696005)(2616005)(336012)(70586007)(2906002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 01:06:35.6716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fef9fda-e1df-4bd3-0cee-08d9c679a1d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5511
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the sbios supports the boost mode of AMD P-State, let's switch to
boost enabled by default.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 69 ++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 63efd5de98a2..9e23efc7b9eb 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -87,6 +87,7 @@ static struct cpufreq_driver amd_pstate_driver;
 struct amd_cpudata {
 	int	cpu;
 
+	struct	freq_qos_request req[2];
 	u64	cppc_req_cached;
 
 	u32	highest_perf;
@@ -98,6 +99,8 @@ struct amd_cpudata {
 	u32	min_freq;
 	u32	nominal_freq;
 	u32	lowest_nonlinear_freq;
+
+	bool	boost_supported;
 };
 
 static inline int pstate_enable(bool enable)
@@ -374,6 +377,45 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
 	return lowest_nonlinear_freq * 1000;
 }
 
+static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
+
+	if (!cpudata->boost_supported) {
+		pr_err("Boost mode is not supported by this processor or SBIOS\n");
+		return -EINVAL;
+	}
+
+	if (state)
+		policy->cpuinfo.max_freq = cpudata->max_freq;
+	else
+		policy->cpuinfo.max_freq = cpudata->nominal_freq;
+
+	policy->max = policy->cpuinfo.max_freq;
+
+	ret = freq_qos_update_request(&cpudata->req[1],
+				      policy->cpuinfo.max_freq);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
+{
+	u32 highest_perf, nominal_perf;
+
+	highest_perf = READ_ONCE(cpudata->highest_perf);
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+
+	if (highest_perf <= nominal_perf)
+		return;
+
+	cpudata->boost_supported = true;
+	amd_pstate_driver.boost_enabled = true;
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -392,7 +434,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
-		goto free_cpudata;
+		goto free_cpudata1;
 
 	min_freq = amd_get_min_freq(cpudata);
 	max_freq = amd_get_max_freq(cpudata);
@@ -403,7 +445,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
 			min_freq, max_freq);
 		ret = -EINVAL;
-		goto free_cpudata;
+		goto free_cpudata1;
 	}
 
 	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
@@ -421,6 +463,20 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (boot_cpu_has(X86_FEATURE_CPPC))
 		policy->fast_switch_possible = true;
 
+	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
+				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
+		goto free_cpudata1;
+	}
+
+	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[1],
+				   FREQ_QOS_MAX, policy->cpuinfo.max_freq);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
+		goto free_cpudata2;
+	}
+
 	/* Initial processor data capability frequencies */
 	cpudata->max_freq = max_freq;
 	cpudata->min_freq = min_freq;
@@ -429,9 +485,13 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
+	amd_pstate_boost_init(cpudata);
+
 	return 0;
 
-free_cpudata:
+free_cpudata2:
+	freq_qos_remove_request(&cpudata->req[0]);
+free_cpudata1:
 	kfree(cpudata);
 	return ret;
 }
@@ -442,6 +502,8 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 
 	cpudata = policy->driver_data;
 
+	freq_qos_remove_request(&cpudata->req[1]);
+	freq_qos_remove_request(&cpudata->req[0]);
 	kfree(cpudata);
 
 	return 0;
@@ -453,6 +515,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.target		= amd_pstate_target,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
+	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
 };
 
-- 
2.25.1

