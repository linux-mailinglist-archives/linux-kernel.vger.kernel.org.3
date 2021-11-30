Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C78F463496
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbhK3Mlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:41:37 -0500
Received: from mail-mw2nam10on2081.outbound.protection.outlook.com ([40.107.94.81]:59777
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241734AbhK3MlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:41:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKFWopc228v5JaD/ZIz/MP6g+UH7gdmo4Xm/5iE+McwffkvMsrbwIl+vy5PPOD2qf8Qe3rXlVylut27QyQx/n2ORhtb7iQ9/FJ39yEW+tSGa7uDQRB2u4pnI3RMCV2ATZV4oK49CqMOkCTW4AmwG+f7sLSWkFuPyXr+SdjK7NnsUR7bqCb9REFk5ju/GP8YOFCymEoYMFAbZGGO6qXFrbcl7Z3yy4xRfhSyJnkfUBFNyGQ30NilQ2cicDvD3i6NVtHV+SHoHqXzr4fJfoYYXT7seb8RpXiAS2kToz3A6qSjt3BCSIGkjvIukFyKYVOfzRpVpzXT5L7d5DPMOQi9D3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOa2psuYI9AE9KzYFlXBfifTVOwFsxZlAY+KN69Omqo=;
 b=DRjq/Ucty5QO+JvOcA5JY6M2RYix5ZYwRV4NOkptQs6nfLjN0C3GHXoy8dkGxz575AvMYGrwpoK/mUdgKjLr22KhRmc3aU58KS2Oip+aJREFqL1JIzMIKKWzWyMJ+5gZOUJqvnfNd2fgi7xuiozsSvd8So6zI6HfBlaW+Mw9v55jTOcX6ZXtiTTYW2/Pj0CPaK+npcoEYFJR6/IimK57TKBU6HUJP3FESEbFNv57gj9K2xgVTS2j/6iKcA0cYRJV1pMixhXbSXb/vQQv9gnULEQ9zDmIKBElaRnu/pkWITYQcUuDZ+YlF+ViBxgpkWbXrvHFT6nwrTNrYnM1WjOjGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOa2psuYI9AE9KzYFlXBfifTVOwFsxZlAY+KN69Omqo=;
 b=39tXDqdTRve14T2M/NLBmAlxLuUxKQJcsKlDlp80VWDTYzL6F9vjBRBm5K4V6mp4/l2O1XrCLAGI7Dr3ed26HdyUMGjWzHHlQI+czemjVhMw4Ay/wt6s+BXyqdlk6+b0sl49nvM+7tF7F+/uPshp+w36C570TlcBl7/8bFq90nQ=
Received: from BN6PR19CA0051.namprd19.prod.outlook.com (2603:10b6:404:e3::13)
 by BN8PR12MB3507.namprd12.prod.outlook.com (2603:10b6:408:6e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Tue, 30 Nov
 2021 12:37:52 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::ef) by BN6PR19CA0051.outlook.office365.com
 (2603:10b6:404:e3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:37:52 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:37:47 -0600
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
Subject: [PATCH v5 11/22] cpufreq: amd: add amd-pstate frequencies attributes
Date:   Tue, 30 Nov 2021 20:36:30 +0800
Message-ID: <20211130123641.1449041-12-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1d0f7a45-62c6-4c9d-b3ad-08d9b3fe39fb
X-MS-TrafficTypeDiagnostic: BN8PR12MB3507:
X-Microsoft-Antispam-PRVS: <BN8PR12MB350737A0B5D55DC441448C43EC679@BN8PR12MB3507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wygKUhZl2DoI2KNUyapzSEHWBy8D3CV39OdSZA1GLHl+njUOnFVxoieHrvdGQEb5oUMciRA/9He0O3VlVTFEGEwGe1tlCyyqHeBM14f3sbHCkojzrreUB+qUYSQ7Cgxlvtzv/awNeaxjpY9Z/Yz1S1wiJPbyVhty2PpI5IrnM1Ll9Fr2QrPxOVejwX5cj50fAN6mWlUCpBFe8kpYgl1P1Ujm1807l7WFPpIYeBmZovt/RU2/x/pfAa0bjcg7z2N1nsJRj+DuO87KksCkHn++qanO00fmx5o9uJ5+W7widstcd1+9kgUeLqpMgiVrUiHyGibOyTxTAg7heM8rB+F54cNX5r04HLEMqEp/doR9gTVzWVLCKhq4yLTt751NYl1KPPWdRQSaIxTPUM7QVeDmksN1+SlKMlLbfwiq/dOPz0CySth94eJ56TGKuHwuaer+idU+2larToZhfW0tYcJWxPiupCuJRjpTmztXtJzfd8dLdcc9cRv0xAAfphFjvsvAhAlRDmNyUFj0x7kCa9jXAo2Rnay72aIlKIhWIEI/I77ZC1Vu+2wbvg6UzLhI3U8pG374sAK+yJQUdP6Bji/ydZGKYjFizMTBg58ZnGkEiLa7QtOoT6PCEpUjdbzfVfQyGmL//BnFxeRwaObMkhuZlnaOXJDivkUMVfQH2dnLpEX/JLCGVs8KNO24/mZYhyGWa4kDzmzLuI0t5WQnlhp/pJGBvcTZG4XZEijOUn8EzETeTokme2uPvyhSldR741EF8yQXfCckvogF8gphuODt4HWsJGHu3ZtkxQxSfPCkWvU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(16526019)(5660300002)(8936002)(4326008)(7416002)(186003)(47076005)(356005)(426003)(110136005)(36756003)(8676002)(86362001)(7696005)(2906002)(70206006)(54906003)(36860700001)(70586007)(82310400004)(83380400001)(1076003)(6666004)(508600001)(336012)(26005)(316002)(2616005)(40460700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:37:52.5068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0f7a45-62c6-4c9d-b3ad-08d9b3fe39fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3507
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce sysfs attributes to get the different level processor
frequencies.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c5d786af199d..d462d5a28e08 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -477,6 +477,51 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
+/* Sysfs attributes */
+
+/* This frequency is to indicate the maximum hardware frequency.
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
@@ -485,6 +530,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
+	.attr           = amd_pstate_attr,
 };
 
 static int __init amd_pstate_init(void)
-- 
2.25.1

