Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD8A47A15F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbhLSQgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:36:51 -0500
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com ([40.107.223.69]:57120
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233242AbhLSQgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:36:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmYVM6VJq8isMa/D8csUUwJnjZXdHVzx67HO2L0FShYhaTxABAnIcTrf9gaaxaJekigLLTcvWSI7bZMsnqUfpbFYSMqD9LZnltFEr6Vge8mnOl8ezkxFdnGp6ouwzNnjv4WaobKrfna5X6Chu0DH0itUMedpePJQLQzCpmkHZtNUjQVRJz5ZfAg2vy7ROrNJTh7tXeUrYvlhDqXI9dfgBQs/T2M1tYx5UnoXQVgeJ1vB5XEA5TqbAnbvYJ8lepwU8yD9TnqUIJ4+20xCyL81nNGDC3C2fwbij9cj7BHm8YjmCWdvFOEDvmeqjnepoujHvy9Od4dtnY5ZIrrlTVn/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsweGZd59ASmysXDcH4gaST+YsTEnJ8wdyuLHN4Veq8=;
 b=brW0DKmdt1TGMuKepqWVUM9xQ9iMPCYWDJUz0SWnbFx2m0NEL8Wq3eMJhMb2/64IFZUST29+U9ipSQB5NxbHrwDpyL7ZD5bom/IY+YorQZxCpvhAD+JjDPVGpf4dLnOuQWfqkWyGDh/voQxbVGu7+ReqH21Jzu8XHrGX7gB/94/md1lxdpnQv4YuHr+X5Qpb525hzaa/tZ+ZgeW1GaBnILlLqXxAg0zbCvQV2/i+XScrN8EWBFTYUk1IfZaOdilawh1oIoWFiF4DCYUKFH5gRx+68WAiso7tn1j1PfHEG5Ass0axbp/ISx+izXJ1dc2nZi8agZvhbzpiSqW5H216Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsweGZd59ASmysXDcH4gaST+YsTEnJ8wdyuLHN4Veq8=;
 b=bxn6PUDLXcGAIWR4zUVmp2UblU5B9+hdhiByHhk+mZWjuQHLuJ8dB0XGE2ufZAK6fF6FJftN4c9LNZiSLle62sJPTWa5t70aQ/iLa+gPGfP9abxZ5coH1GYnpPxtihJD0bZxXdr7uVkInbCVRtkSuniA7VtqRWaxEhnmRgR+bHY=
Received: from BN9PR03CA0358.namprd03.prod.outlook.com (2603:10b6:408:f6::33)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sun, 19 Dec
 2021 16:36:45 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::5a) by BN9PR03CA0358.outlook.office365.com
 (2603:10b6:408:f6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Sun, 19 Dec 2021 16:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:36:45 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:36:40 -0600
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
Subject: [PATCH v6 10/14] cpufreq: amd-pstate: add boost mode support for AMD P-State
Date:   Mon, 20 Dec 2021 00:35:24 +0800
Message-ID: <20211219163528.1023186-11-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 648451ef-2824-41d8-1841-08d9c30dbedd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4430:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB44307213A53DB06A192A719EEC7A9@SA0PR12MB4430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /iGLzrXs8RGAhvfROp2swjGp9lwWf3IcM8JPSvVdocK0mUnvVQbftWPhxpLIf0a/prbTX7GrNC7GU1zzOuTBAc6WonNmM+bBGJyyg2VZRD8IUrvgrmORmC60T3Gw8+Jq9GaNBg9b8QJVK8BLY88p5U4jM8eBBcbG5hfZ/O5DSKBjuugdz8pfSH9/C1s7b6X2IIwIC5wwMdqIpNVVcV9i7Yf7mAze010GQ2kVY/8Htt3I87AtGr3ZTKV+uBOfCa+pxCoVxTVwiowfzeTt05j1WhC95Ndgy2V5mu6tgLqVdibnt6pGsvc1pi5s5vyeW8EhXrra5QspmNc725rnopiEtNaFLopkU1j4c81oPzPenDLA/eEFpKCkGw7rY3rGGl5hFFTjJaAN/LfCm1luombTE+fkkewk/yFSe/HhazOoZdUmTJgI4AuTBRj9wt1wXc6dULAzbqiohjysHrOLdA9npPeao+ohFikQwzkRG2vQmYFoT3J0bcTGN8DEWDtY/TXsa8ejyecqeFr+EgO8wOWRo7QNbswDM0xNSK9m172vM5uVunotvkGYOlIBedNW/gS/DNiyDIHjSFOdkimqFJAfr/L61FuVhYI/H8Mcwnie4OE/EyJ1fO2d2S+JoJONKudhtj/GBAEc8hWlB/taTjPnDTZ3FC+3VaNcFl/LzQ4sZrLh8peGiZRRl2hFBKmLwF8XLh5Y9OoLxZPKyyXg+hDqgkG71JqpYOQu0RrGVIlh8ExnzWuO6BFxkOJoIVXLFRpb33GqVRurGY8/7R5r+eH5obAHcAYJc+mpiLUqj1rtLLQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(40460700001)(81166007)(316002)(82310400004)(6666004)(36860700001)(8936002)(2906002)(83380400001)(86362001)(47076005)(8676002)(356005)(2616005)(426003)(70586007)(70206006)(7416002)(336012)(36756003)(1076003)(110136005)(4326008)(16526019)(54906003)(26005)(5660300002)(508600001)(186003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:36:45.3353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 648451ef-2824-41d8-1841-08d9c30dbedd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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
index fa2268df4f2e..4ff4fb7c3de6 100644
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

