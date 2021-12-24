Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824E647EA10
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350676AbhLXBGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:06:49 -0500
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:19937
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350607AbhLXBGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:06:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMR7n70RolcbyHPxWJuprMOfxue3exjr5eIdu1JBCzCX7AQzte3aef7DWPFmJcHucXdmXd8Tidx96kZY5q9ympNZzTiXIDExIYx0PaAA/gwcAiofZxN2NLTeYmQ9IR2TBGkB+J4oKDf09+wQiyTqfshUMhXEoo2ALGnidw7lwBm86ZJA6tVEaxqdhGwOePhayu1Atu/81ZCMetKuRx4K2o1ZKmo+do0QdACUapWvYb27EDzj3M4CTXiPyJw81PW2gtwMwK2352gtEsc56hAx5obXf4cfL7jylX8007VYmgEshWmNG3MfaKeUq07na8dF2KwG6Kq7dq2T5SI/bwabUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfHVOR5MJ3VyX0YfHVKUZEdogqkMGGtH17rk3ghUFLw=;
 b=bBxNyP2tOt7BN70d9XbRTf+u9ImT6h0R6NnxEF1L84VailUFsX+PVbBVgZy9ve5xIK8aMyZqkl2Z9Heeqr/MjxyKE8oYFCgTwgoKe8Q/I/mtV8mdHEKVTI0EheriYBnjghMCJBCCmYNuZqGXuMOD/HL8dQQgoEVJ52POoH0UwLfEajMJ1WCYM5asrDwlw5PkGGQXXe7u1DMAY4knE7OrG1jm3liVqy+XRJTFaHz9Sk6S0QEqQh8xpM5me2AGURiH5m/hTda1YF+3JHbe8ewxih4DWLkSoi4ToZbPwR5Xqe4nmGqnfWuS9MGHu2/msyX9YK2p9OuAbAEMU2DxIXRhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfHVOR5MJ3VyX0YfHVKUZEdogqkMGGtH17rk3ghUFLw=;
 b=Ui3ag+a39iht0ngN7cFwhnpvl4F/65YyA2aNIxweu2opfcCyELWwV60zI/gZoHr42rvo3vEVihuJbyRDV/jl949n18Lf6xcKTOjS17Q2JCMvbeCCZDgm0Grr/cYCeOiCQwTw73n0BTFjp9y90yGwLRrGcxlLv2WUOEU2xXO5rYM=
Received: from DM6PR07CA0088.namprd07.prod.outlook.com (2603:10b6:5:337::21)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Fri, 24 Dec 2021 01:06:40 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::45) by DM6PR07CA0088.outlook.office365.com
 (2603:10b6:5:337::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18 via Frontend
 Transport; Fri, 24 Dec 2021 01:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 01:06:40 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 19:06:35 -0600
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
Subject: [PATCH v7 11/14] cpufreq: amd-pstate: Add AMD P-State frequencies attributes
Date:   Fri, 24 Dec 2021 09:05:05 +0800
Message-ID: <20211224010508.110159-12-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: aee38677-fe8a-42f6-5dd4-08d9c679a491
X-MS-TrafficTypeDiagnostic: DM8PR12MB5430:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5430B395E4DCE2217B08BF72EC7F9@DM8PR12MB5430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZc3x4PLDZd6UdYO8O9ul4T4HrQpOssNqcoTW9j1+JPCzwwDe6v4Jy/0kCWBvot+lJ9RoBAh2TgJ1ImQZxA66oEKBeHk9R35csvBlmJPFjNPt804SvS74aAdMqIHGnjQC1WtvT0SHy/UvEK1uP5ddgH0AEsfHntauMngXnbsvTP+gGC3VhuRwJt6BGS+b9VGlXA40R5pkEDe4Rk2/8DhLo7snsdZlLid3TaeAGmsIqIbdTe9VBn6RygqjSZjPwVLal/Jyj0TvQ1kPf9ZusL6i6tmFbQslTMq2oMe4SC93r2lez4LTDmxS5f+r362Qo9rPYnqEEawPLuxRDRnEwB8YVp/FFbAdJ4YafrkEwHsUgo/aSxhlyIYaoFzRQh4MbBtp63s1+NEE0tA9oPex0gZRqCEJwI5w6J84puJb9q6fH/2wXnEFr2FG5OtSx3d7e1g/R1YoNlrKh+lUgyfV0apJzLmAjYMOrjYrnm8neMqghI+C1YnAw7Lb3LYxvvzY1Y14h7BfmPfZjQv+y+feZhnZ+tDzPGTRtSSTEiWfgPTjzVs8OJ7ErGbsFOICdo3kfW2Wm1JjQSCVQqE5PCy1633qTh1zfRPCt1GdF02qBD8duzuA+Umbv/wGi+wHFZCtnzx4dfog/E0f4qUOPpVsJtoj2cWKiYpGxjbphADrx4t8VXj4iEOL+Zy8s+K9D9FZ0d6686A4d0rHez9mnAyxpZsRen2VcCuCBw2G/GL9zwYVtJw+OAPr+6ndcpFQlBBoYp3zI9+6FMQDgWVEmXcp0rPHZ6Ib+eTfpXL8ea0R5EUZkk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(356005)(47076005)(83380400001)(36860700001)(110136005)(54906003)(336012)(4326008)(5660300002)(316002)(1076003)(2906002)(16526019)(7416002)(186003)(2616005)(81166007)(36756003)(7696005)(6666004)(426003)(26005)(8936002)(8676002)(70586007)(508600001)(86362001)(40460700001)(82310400004)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 01:06:40.3031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee38677-fe8a-42f6-5dd4-08d9c679a491
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce sysfs attributes to get the different level processor
frequencies.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9e23efc7b9eb..dbb7eee11170 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -509,6 +509,52 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
+/* Sysfs attributes */
+
+/*
+ * This frequency is to indicate the maximum hardware frequency.
+ * If boost is not active but supported, the frequency will be larger than the
+ * one in cpuinfo.
+ */
+static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
+					char *buf)
+{
+	int max_freq;
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	max_freq = amd_get_max_freq(cpudata);
+	if (max_freq < 0)
+		return max_freq;
+
+	return sprintf(&buf[0], "%u\n", max_freq);
+}
+
+static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
+						     char *buf)
+{
+	int freq;
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	freq = amd_get_lowest_nonlinear_freq(cpudata);
+	if (freq < 0)
+		return freq;
+
+	return sprintf(&buf[0], "%u\n", freq);
+}
+
+cpufreq_freq_attr_ro(amd_pstate_max_freq);
+cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
+
+static struct freq_attr *amd_pstate_attr[] = {
+	&amd_pstate_max_freq,
+	&amd_pstate_lowest_nonlinear_freq,
+	NULL,
+};
+
 static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
@@ -517,6 +563,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
+	.attr           = amd_pstate_attr,
 };
 
 static int __init amd_pstate_init(void)
-- 
2.25.1

