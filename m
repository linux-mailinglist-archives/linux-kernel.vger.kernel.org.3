Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA78847EA08
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350612AbhLXBGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:06:09 -0500
Received: from mail-co1nam11on2086.outbound.protection.outlook.com ([40.107.220.86]:5984
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350595AbhLXBGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:06:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDyP6gPmQvKBTgCop9w2a8FWEN1m2I4wyNOOmuQDfnQ52bjbm5K0Gn1Lcmz6sT3GwqLjWVnrIDnXsvU0lA84+7uETD2ogEr+Qq9TPQtWxKzbuMdUvznIvMl+bA/4YBaNKvypK6fuwP4gHZlstK1tVIAMz9tuVl6N9Lf1SsMvyT5E8BHN8KJ1lTV+ZubKkWCcT4w6UwZ6eFCC4gFtxdMcifv6pau+uV7TnQxFXhqgTl5qS6gu2Fn3YISE5la7Vr4mx+AfisLgsE1hyic7lyJ1478Tpq81XZzsb7OFPZAhvR/gA38cYnibR2Xmgh2/D72CtvQpvG9YpQYhnGcxkr+r+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDt0XQVQ9ZSi2UwjdLLQGxKQsEfZtNEOarSmckuszuQ=;
 b=REcuKnxtsgw2a67wEOnGAGJK/afdK3HJNa5J+r416EDCaqPQ6u9y+vXkE5HGd4CCrTcEkEi3tvu0OONhl2DVQCCIMbePlWwRbJ4xksKMrQ27kIibEZ+6MvHPTDU+xyvRtWbzCld+eHdvjFFo7sHHxvLli1wB6o9MwNwWFjPq1e6DHVn1NXspZwMyZl2AHLoCesiAmeLz13xE/L2lN1g4D6a0w39FMiW+LbOp0444f6TvENFa1xFMO2LCDVVLOrOwj/Y69OHKovrPJRHgM8wNqevqw3Y2ROAy8RRplmSFeaFvOScbge0lDrT86xQEcBsbbARzig/+HB5ePmQH1ailsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDt0XQVQ9ZSi2UwjdLLQGxKQsEfZtNEOarSmckuszuQ=;
 b=ikv3fTNK5UcktGnydPRVxYpZlyAZlfHDbi/juMcwwKcYM00Z4LrnZW5duK+3V22Dgr4w6JGY+B21NAxJ+NTcw/CLPDKnF5sQfg/O7cKRxcSo1TfTGZcrg3an02DxoNhXBxq9m+YXXa7kYqhxAjp2tGAdoqHagW6Y3hI+0sD0D5M=
Received: from DM3PR14CA0138.namprd14.prod.outlook.com (2603:10b6:0:53::22) by
 SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Fri, 24 Dec 2021 01:06:04 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::45) by DM3PR14CA0138.outlook.office365.com
 (2603:10b6:0:53::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Fri, 24 Dec 2021 01:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 01:06:04 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 19:05:57 -0600
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
Subject: [PATCH v7 07/14] cpufreq: amd-pstate: Add fast switch function for AMD P-State
Date:   Fri, 24 Dec 2021 09:05:01 +0800
Message-ID: <20211224010508.110159-8-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 743306c7-afae-4b2e-7516-08d9c6798f40
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB452506F50E344CB52B7AD687EC7F9@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: co+ug05++l4n/SMCf3+pjyiJhNTFJshRN8XnMGDexfshsyUorJV82YYZRDqzrRG5WmN2R6gUUYtEqjEl24naTomGc3cIo/GU2/PEisvXBI91H5sYRNtuuxtwgvKexU8ju/GxpeL8ZLw+BUJws0kQ2wP1+/2MdyVNxHgdFwa9s18C7Z7SYJkFr/eI3gzLd8HzsPs0igpYrLb71TWXLa/AEp2iEvwstTLADpBbHYKI5a42dD7RHhUW7F5i5T/tTK/prrB1hks9i6CH/Bbz//d9rFtFInePyQRtIKDN6Rge1dCEh9fV0j8yZdTsnoD6WeZqYkpcwriYpVOUo2rtDJJtYhppLDkRobxWoZNk4VK5uMfM4tCmEZ/i9yQ0BTLOk3zAPQuHl+qeGk+zBC/F+F1fI9nBKOqW+YjyfrOIwPn7sp/4d80/ebowVWKOfgiufZnrE9+metVN7kewFemYFincAICobWj+Jiyx8D6Dy14GR+XxuzxY5FExL5ab39OzdSs3SmE7F0oDu6tJmg1Jcq4ReOf69mPlotR/Vuuf3OePvy0O+u4AFC758zkwn3MpNhNLwKYhp/XFb8AmQmFzBTRBFkDga2zBzcTwxdtkYWzI4PQdq2R7bq5FgUZxOd4u6STiOAR6YEJXTXWqcsoqRT4qMlSzpESxAYItqvhS3e3cACa4uYMwQw0VbfK1QYnMKGFcX/Tnwil9HWd3Fmz5aCYGJQiZUGR1t0M9fD+A3oULQC4wLu9QsYVZ/GGDyWhdC3N3BMHRjdUrC92NPRHE5tnV8jnSAqsxZ0hQieFiz02hDtU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(26005)(186003)(86362001)(7416002)(70206006)(336012)(8676002)(16526019)(6666004)(70586007)(8936002)(82310400004)(110136005)(426003)(5660300002)(40460700001)(54906003)(4326008)(7696005)(47076005)(2616005)(36756003)(83380400001)(508600001)(81166007)(36860700001)(356005)(2906002)(1076003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 01:06:04.5563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743306c7-afae-4b2e-7516-08d9c6798f40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
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
index 2698ed5ec6d7..8c9c199b560e 100644
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

