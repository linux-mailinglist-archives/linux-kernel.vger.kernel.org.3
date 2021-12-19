Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838D947A159
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbhLSQgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:36:38 -0500
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:2848
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236197AbhLSQgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:36:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQn81BlBWDxah/8CTaSHCqfERyVwuXi0y8H0KnLswoBPR38T48utWXyf70vYHH6HAfU8TTy9ZtXRhfUzc0GWHOLEJUz6iapvBHCK/l75BLat3bvzORwfRXAOF894trIC4QufYIIA5U/ZUA3CkTdU0DAkmeeRl+sEIMhSTVfxXBH/RG2K5kd0MldT5CWFq3LE8PuiTXwVKyli+ckCmTi0ayo9h9AtK1mzN6bGAiB1Cp11eeA6/9+AZCm5Z36zWiOpQHP24GmOwph/Au1s+b9y9ar0S19BG+hM+59Lrg9Qxs//dJUT1xiPPKFrLpalRNwEJ1Yugj1YvaCg0eArOMX3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqUc/o7LeoErK5Nkt2WCgSbKt3z3dA9m6dnRTq96jg8=;
 b=ob4ubYMySgoFSpffWcbaztZcuSW6qkD4g/Y4rjTnwogm5eh1c4uHZWJKMQmGrHNKBcIy9EWfpSiFk01uCgPgtxAYwDyL5IlGrbElCwwKPEgj/ZGXySFWNSNfa2MpOSO3octBGTN2yjyHCl05Ebb0xgkDMjpZDiBxg3V31kv4F6zxt/o2LVU+4aHOhSI/VVzjmhumWAjaZsurRy2gP2OGNk+Kjcxd7dRSsj6X9Qfe4zJwie7K+gzcFJuz7e5PkwKABYRyVR7mlANbdyqcTVTfAthqTXC2Z751G5GdWQ4kWOSzvCtDxEpQAiRJaHLqJxHyAyeuh8RmMYLxrDKQq7XsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqUc/o7LeoErK5Nkt2WCgSbKt3z3dA9m6dnRTq96jg8=;
 b=5NkqQrkprM/YUqXr5O6GN5foPLB9CblSKxN9Wl2SceYGC/rCEWF6Yl0BkH1O4pUU6ddBOVhEsvPZYAhGUHUmc/jRuVdOBytUisB3nBEMpoIbU5COagKjI7ENzKPDNKRocGa5iCOv/26cxGhlBIDJWoSMBbdOIj2HpQ0TO5Fgf38=
Received: from BN9PR03CA0690.namprd03.prod.outlook.com (2603:10b6:408:10e::35)
 by DM5PR1201MB2475.namprd12.prod.outlook.com (2603:10b6:3:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sun, 19 Dec
 2021 16:36:31 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::91) by BN9PR03CA0690.outlook.office365.com
 (2603:10b6:408:10e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Sun, 19 Dec 2021 16:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:36:31 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:36:26 -0600
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
Subject: [PATCH v6 07/14] cpufreq: amd-pstate: add fast switch function for AMD P-State
Date:   Mon, 20 Dec 2021 00:35:21 +0800
Message-ID: <20211219163528.1023186-8-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6703db7-2534-42f3-3a55-08d9c30db66f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2475:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB247509AA6CD45C86712A7B3DEC7A9@DM5PR1201MB2475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbTyTToy5W+tztiCBGae1Ir7GB3ehL2UBDBUvsOosepxC0DoVtUADsC31xuvYrOMztOpAJbKhKDp0KoeSy6dNEZ54BEBjxvnrbGal8HBQwcvQ0n0p98PuC7RXU+KCIoZWehqvhL38ULWkEmZgA5mOOYUcHWUIE1c4uZY7SA0BdLqyk4+tugFll4aUNqD9IrcYdYd3wH67QlQCkzaEOErrxzpsywPUZ6jB1/z4SPZdCZwc/Sn1XWLnDkE7RhTRJzmfKadKZxu3SISDc9DYKOIalZvd4zMkY0y4WMM4A+bJzNql8ohPotNOLnDHphz+TVu4GWwWqY42T+G1pdauRfjUzA+aScjCCKHzdcMiceStqcIzpt0TksGGHSYCd/O7faKmcxXV+kOFivVW+BC3X+sZImhM+17ToCoCfn26hGT1LYFL5h+JiWtSiwNFd1Q9T9aUoM7hVQFHJxBnkJuxfd56sxpzRusv3x54M8tdXBgBOe6ajEzg4yhTTqf0L6fIm+wJ6GPUvg56RTbK8QM48v57jTLY0MPODBNjYyKoXnipOTxw4y6h9nTlbH6pL2ZUQ4kw8J5aZN0O5uicApwZQpdDA9fYycRaB2fdqYikdXeuWF1FbbtkE/tawph4d3i4RF6vx5Amc0US8S38IED9GzC7F7MRD6kTQ1uVH5c/Eozyg2S5wdqP3mKt7FLQUnmVe6LTI10zPnLFS+qqHG9TaWcr42dUBcJs5/WtTM7zHhol5z8HJlpfOUTcJLFvwObETcLHbMKVRojKo06xG3tMHFUeaBTZNqhA8mvf7dlrWDP6pg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(47076005)(86362001)(36860700001)(16526019)(70206006)(1076003)(36756003)(82310400004)(2906002)(7696005)(2616005)(186003)(26005)(7416002)(83380400001)(6666004)(508600001)(426003)(54906003)(5660300002)(316002)(8936002)(70586007)(336012)(356005)(81166007)(110136005)(4326008)(8676002)(40460700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:36:31.1945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6703db7-2534-42f3-3a55-08d9c30db66f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2475
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the fast switch function for AMD P-State on the AMD processors
which support the full MSR register control. It's able to decrease the
latency on interrupt context.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 70b69c660192..14e8a566ea17 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -183,6 +183,39 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
+static void amd_pstate_adjust_perf(unsigned int cpu,
+				   unsigned long _min_perf,
+				   unsigned long target_perf,
+				   unsigned long capacity)
+{
+	unsigned long max_perf, min_perf, des_perf,
+		      cap_perf, lowest_nonlinear_perf;
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	cap_perf = READ_ONCE(cpudata->highest_perf);
+	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+
+	des_perf = cap_perf;
+	if (target_perf < capacity)
+		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
+
+	min_perf = READ_ONCE(cpudata->highest_perf);
+	if (_min_perf < capacity)
+		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
+
+	if (min_perf < lowest_nonlinear_perf)
+		min_perf = lowest_nonlinear_perf;
+
+	max_perf = cap_perf;
+	if (max_perf < min_perf)
+		max_perf = min_perf;
+
+	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
+
+	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
+}
+
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
@@ -299,6 +332,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
+	policy->fast_switch_possible = true;
+
 	/* Initial processor data capability frequencies */
 	cpudata->max_freq = max_freq;
 	cpudata->min_freq = min_freq;
@@ -329,6 +364,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.adjust_perf    = amd_pstate_adjust_perf,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.name		= "amd-pstate",
-- 
2.25.1

