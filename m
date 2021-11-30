Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12812463493
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbhK3Mla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:41:30 -0500
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:34144
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233024AbhK3MlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:41:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX7YQesLK0VAiF/4s9D56vv02L9Km6KDGX5u4cyZbz9MTHlwdUck3DPq8xgJqf3fcYfhHfi9JKUAD2syEzUygSUOVs/egNGOOWneXGnnwqiGxixRl4OQ1shtpDtUJs5UTFqWn4Y/ztbPHxu91EQMqT19nns+wAafSeVcC5ik8ihR7UL+aQOvA9sS705Aqwgf4X+DNdzll3+XL9ES+3al8WF9GVnBNhlhjnbodo7KQE0SXJyJHmcSUwO22Dr3PmyKfu5tRUaXVQ/vWiBlhjiqQci3JZzLxQT8Ar+PLvglDWyNvUCx+YjxLMSfpAZrduAPlckg6whyIlPvsH12ZauhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W0eRJjp6bEZWY5A7Hs+79XaNsUs9UyUf+dVkRNMdV4=;
 b=Vo3dAQQkOSzhdIVsNugOfl2zO5s05W1y29OLy9ngra6qW4zHjDLG/QQ5Q3pNulYyBaT1X836+vCPiAPUJOLtqrRrUc90TNPF7dkgWY6p/RbrrXCqv9FoRBtffZfujLJ4F82WYHs2HrJNy1adFDOFn3fcVX74Qb04jkQiSFycm5bNZU0LNLAEBPJVZ/La0Vs++1RhCn45eKRRXgMciJsZpuatJseYGmdBf+ixnwVi3eV/qPpvqEUSXrMJiIUSVIcYNUKz3wgwc3mgdld1b6sJji2lgQTq6muPi13fCuE9s5IZL2Vwy1CST6V5jyKkZtqzKxdErRwNMCWt537dFD+Rrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W0eRJjp6bEZWY5A7Hs+79XaNsUs9UyUf+dVkRNMdV4=;
 b=vRl0++dz623tH5GZHta5G/uMJf2m6YHdPEB/5mup6497rtnRNZjkfsKV1IkZoMMzajIr7CB0ju0QGBCROEwXYZE5B0HF91n/8GhiQAN4AYTY5H9RXe8FbWGqFvbhBL3gA26Zx+ckEvdTuE1XY6Z2yrq0BxacSh/AzRVjQV4Ufpo=
Received: from BN6PR14CA0013.namprd14.prod.outlook.com (2603:10b6:404:79::23)
 by MN2PR12MB4013.namprd12.prod.outlook.com (2603:10b6:208:163::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 12:37:47 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::24) by BN6PR14CA0013.outlook.office365.com
 (2603:10b6:404:79::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Tue, 30 Nov 2021 12:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:37:48 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:37:43 -0600
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
Subject: [PATCH v5 10/22] cpufreq: amd: add boost mode support for amd-pstate
Date:   Tue, 30 Nov 2021 20:36:29 +0800
Message-ID: <20211130123641.1449041-11-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 35b97b56-f8eb-42dd-c067-08d9b3fe375e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4013:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40131CEF843A10BC767B8396EC679@MN2PR12MB4013.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m5ZTvHaypjfiRisM63C88g8AaqL8YLUsme7pR5qzYnwmBzcUb0oZZc2WCPBhzTAB0U22sx9JjeRSsjrXgZEaD6RSOeq6IsueLpWPgratoJUXtmqq1eIzcVon3wYUXh8Oo/Eq9tQ8UF8XaFxZoaWbwo2HnvodOLUEiekeajucL94mb835i5HXeBB66wWXLcXWOGNs+3NeHDFI18bf/skwDiiN5rBA0d82a3UBKnBQSj7vW69yRo3Mfb0JxNkXL+QsIosPNHROKEizH9JZArLzGoOqJJDNzf9MHRykWijYQ3s6MYhqTl/4QJCwLTWh0vHqLpA6+ZEdeZwOcngWXPRKJdpcs4I/6ZQUTivuH0u7cQ6of/BKyJVgAdDhbk2yieri0yVkylSSID13tCycn2R7fbpq20NYXZ3twCLDHU3xbfFiMJ//Lr4JXoxK+cGpqZm30D3EqQjUDU0rOWyxUpkm4wrLLVzhzS9evshxNTNmZX13xYl9FlEhCH/nkp7xQy8HBWeH0n5ZFa92qCt7jgSTnG6atQHazrT2jOhUCMRavaD3E0OL8clb53JfxNqV2bb4i/iwa45wcR0z+d4kdkjlnnK6tpPhXZ02twoQO7w0cWxdi26kINATFM6BSh0Hw+vHW6Lyyo5MXwo01QdisLp33tlit9JJ5xUn/ZQr+f0FlPR621MS05tUEyAHfP12FWi2TmbPctdrFKWc1hztHCDDNWZp45eX5AEt2KeXNONcfgHl4VAfIYoSO6ejgjqFLEQhfwXsamnJAp2RewBpBysJusJhoShIvhdB7tgwWM4sL0o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(356005)(186003)(16526019)(2906002)(8676002)(6666004)(83380400001)(7696005)(40460700001)(82310400004)(36860700001)(86362001)(26005)(47076005)(4326008)(7416002)(81166007)(54906003)(110136005)(1076003)(316002)(70206006)(70586007)(336012)(8936002)(508600001)(36756003)(2616005)(426003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:37:48.1227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b97b56-f8eb-42dd-c067-08d9b3fe375e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4013
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the sbios supports the boost mode of amd-pstate, let's switch to
boost enabled by default.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 72a4e2258fe7..c5d786af199d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -67,6 +67,8 @@ struct amd_cpudata {
 	u32	min_freq;
 	u32	nominal_freq;
 	u32	lowest_nonlinear_freq;
+
+	bool	boost_supported;
 };
 
 static inline int pstate_enable(bool enable)
@@ -343,6 +345,45 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
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
@@ -412,6 +453,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
+	amd_pstate_boost_init(cpudata);
+
 	return 0;
 
 free_cpudata2:
@@ -440,6 +483,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.target		= amd_pstate_target,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
+	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
 };
 
-- 
2.25.1

