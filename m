Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642C3463487
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbhK3MlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:41:11 -0500
Received: from mail-bn8nam08on2072.outbound.protection.outlook.com ([40.107.100.72]:31328
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241732AbhK3Mk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:40:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CizFNLK05OuEi412U3+4KlfH6UQYiVvgm9DxmTP0dpRLkD9ACTA31qWuCldfi0s3zklwPDU2E1OKlNdps5SAcX3uteq9ghuLter1OyywDFwBiX816OXsv8+owddBGTdLcuBeLqE0mHXSg5djT1rqo5tU1Ems0KxUfEgGTL7Drydv2lLAe8sQFc40/rvo92+C8NvdDv+aK5XMT4FHFtSsDKNQjzjV8aRJeQT0V0hhIWOy2pY4Ne+nesq+O/xULF/U0D0OWd6HQr6PtZKeqbCVYVZ2WOiqDXnGpf6/34rt9gUdmfElmB5Zo4Wgl6m3Zt36Qxce7XcW7tJVcesb3sL5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBpTnHqsOWJaDFNwdqn5bnI9m/niNeoI6abthsLgn5Q=;
 b=Xz7chfnGfG/hkpEuL4PLQZNmbG3OOnMv+P8VRmnzpSJEBbxOAzCwuS2FWokzd2z6DYvIC0sSt8nb+kA7w2pz2V92aB8xbGwTEKj3bS9PgNYH62fEHqcZhB1y/UInki+XZydmJkkhUyh7ElGxFFhGNpV4rfttXYhRljZK+ZgLu5lZGkP03HCGYXSTspiDGsh0rZtxwj/Es0EQEy4hhu0zaesis6N62nilc78kLozv+/SxDudg8ZU4nqsIJBqmaSZDMml2MaO6vh60+nof53Fm1KR8EJ1rFwYYQORaafOfCap4zHhoYU3onSeVpJjtQ6ZLz5yIpLr2lg/W3ucViNEbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBpTnHqsOWJaDFNwdqn5bnI9m/niNeoI6abthsLgn5Q=;
 b=5Oq8xI0ORj6pVA7x1HLit3BRGa9+NTiuaL2QMFdfXb4ZUcqnaZ9XkBEvo73MgY3s5mXvx5Pk7C7yxIdEAhuy8RXLEJlSWTnNo0cDhz2+HIr6Yobk1nDb05EvqX79p57RgrwQMCGMS2sNRzQ7r1u97U/U3p2iSOLNfpTL2TbLeew=
Received: from BN9PR03CA0180.namprd03.prod.outlook.com (2603:10b6:408:f4::35)
 by DM5PR12MB1706.namprd12.prod.outlook.com (2603:10b6:3:10f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 12:37:35 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::b9) by BN9PR03CA0180.outlook.office365.com
 (2603:10b6:408:f4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:37:34 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:37:30 -0600
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
Subject: [PATCH v5 07/22] cpufreq: amd: add fast switch function for amd-pstate
Date:   Tue, 30 Nov 2021 20:36:26 +0800
Message-ID: <20211130123641.1449041-8-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1628b16a-ff6f-452a-ca0c-08d9b3fe2f7c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1706:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1706749BA90B7F8C034F3D33EC679@DM5PR12MB1706.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gL+573lm3TxsYXa70C6MMh1Pb6C/Hnpi1SxarKAvneZiHo7wWiWYVpFghxpvc5nS6WcrWy7eIUPtyXr5wTJHHGJS0mBGmgggRDWrHVo0RAn0FH8aMNAmtMLUORhMA8E5EDrObE2eN8SWx4YgqymNoPcFMa0O46rGXgQZ2Y7sGFyFBX6ArEAeiA3dFdyXpykuKyYIeNJ/zzO3ZLac3qnzCgrotGvfE38m7GA624ajEZgGrE0koVuINocIMkF+4XxXz4AuJ0gXefE8AaLA+oTkcofwIvIJIblpANXgcHDtGYDVW3T7UABZNobRlG0VQqQfltTcXYJL7s9X3mz9D6btAbJ4xnEfvpDx8NnrKcyLSXfX3hY3IViWPcMyOwVNrb6CPZapcXo0+9T1QrLrs60cdwXjFQHWOGCs5JPn8Z5WL+eJ9fAp1Xikatt5yXk0et+NhjQA7Bpmkxn0fIoYq4iCzwhE02Wyp3Y7DLj1oaMhwLFFCmljD5GtyS49Q2T+bwbpcaXmap5KBmQr/9/ezPNNYoXHkxegmjqFVGsjs1oCwRg107iWh6LQuB5TDvNrqeiZ435D+AdzyEF/8uuz4Kwb6mztujCLVq9Lu+VFDNSRTr98aL0Q76lz3u/eRbdB1kLk3hPlISQzgnRmOzmq6WHyhOUrZOsgYUzB6mc0/pHVLbC1FNLBG1Qogom5qaoagVl3Gg36ZTKcKfD3BKkrdnVQNStiR8odzlrguqNkhMknTCAg1nVIi6cOT88oYmVWxxp5ISigzeX/0NUETsn2aCMU9ZIL+2WblW6IRDIswkFRQjU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(7696005)(2616005)(1076003)(8676002)(7416002)(47076005)(86362001)(36756003)(356005)(81166007)(110136005)(186003)(5660300002)(36860700001)(54906003)(82310400004)(336012)(70586007)(83380400001)(70206006)(2906002)(316002)(26005)(6666004)(16526019)(508600001)(8936002)(426003)(4326008)(40460700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:37:34.5800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1628b16a-ff6f-452a-ca0c-08d9b3fe2f7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1706
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the fast switch function for amd-pstate on the AMD processors
which support the full MSR register control. It's able to decrease the
latency on interrupt context.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 20ffbc30118f..cab266b8bf35 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -177,6 +177,39 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
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
@@ -293,6 +326,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
+	policy->fast_switch_possible = true;
+
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
 				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
 	if (ret < 0) {
@@ -341,6 +376,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.adjust_perf    = amd_pstate_adjust_perf,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.name		= "amd-pstate",
-- 
2.25.1

