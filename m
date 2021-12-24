Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2102647EA12
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350736AbhLXBG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:06:57 -0500
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:35681
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350657AbhLXBGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:06:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlugO3gaPXevngz9BICGsivvV0NzgzOS4NiaxLbEDoxhbcH5Q5xKDEWOUMt3L+iu44baNA/MP3PucLL7pSLe4LJ5ACWwJ5EIMWPO4MCALwAjnjI828R//EDc1ZgC9L1exR7wGFRfjGdsvenY6tUTp+hS6Md/qVwBOJCFwVphFfb5qZq3fNntGrJqsg9rtYa/tgnoipNxWLFPx/mx1UYaJnaJ54a3ksqr2qeqXAw9rK7tf6npAYNCI15EeVgL15q59n8nAzasbbxhctRnDbnHwRTY17M1FSqnRbVC7cRNRbU+MoLDLwF10yctYgwawKAuhlzchWMGsKi1D2vxesixEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3T8IutR7NEgnK4LWinnjTp3gj+WMAyBspZE7yihd/4=;
 b=izk+HB9yYRg2SRF5FJ38nMghHUwQWb8DWz4laVIm07frdanJx8t9T2oRZFYr/ipvpviy4P0bgd3oiGnV+sDvt7A2tci8zWQnvpOE+OTm9RConNcEChzjfihL4xHuhcb0nrPFbrErn3CPZe9oDIDcRSme/BCXGRUWW1AA8DegTV7ox6s9O0afVgf6QTYysyznx9F2CAm1CAmNv06TL68GRjVPGWtyqu+AeKHkoyD5ehsjB8DTpB+KWRvBp0gbETcfqcDvm/ou0jVEQDXfMJK92sOhUkOdyzOammUVfPKE65prKTVBBFKPW+mVeEnqjknsiBlxqoKc58/Z1i12NDVQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3T8IutR7NEgnK4LWinnjTp3gj+WMAyBspZE7yihd/4=;
 b=zc4hQM4sWlrpGVUUCnkvH/8sXpbSNu87QL/zJ/+abb3Ddv4VsyOr+zmARjVE1dqY1NhudZ2li34Ou3UcnXsMghv3phUzil+YJMrop81T5i7kGaJn7wYgFlBQSXbGIS3qVfZTkXAnGhtbYTjteN7/a42HRXMMdiwYy6WY80x3SPY=
Received: from DM5PR06CA0048.namprd06.prod.outlook.com (2603:10b6:3:5d::34) by
 BYAPR12MB2742.namprd12.prod.outlook.com (2603:10b6:a03:6a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Fri, 24 Dec 2021 01:06:45 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::4a) by DM5PR06CA0048.outlook.office365.com
 (2603:10b6:3:5d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Fri, 24 Dec 2021 01:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 01:06:45 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 19:06:39 -0600
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
Subject: [PATCH v7 12/14] cpufreq: amd-pstate: Add AMD P-State performance attributes
Date:   Fri, 24 Dec 2021 09:05:06 +0800
Message-ID: <20211224010508.110159-13-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f678ff36-efa1-442f-8682-08d9c679a765
X-MS-TrafficTypeDiagnostic: BYAPR12MB2742:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2742E659BF4E9C5C43CFCC7CEC7F9@BYAPR12MB2742.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vaz96KFGt6fYx/Tuo7z9lvDkRY/nXZeaNFgLdpGPC6VTCAPCNqBGf+jgUSgaMlvSmhkdFZCYGqgGKPBpYe/5CB6mP5+jLKlU+h0Ai6+ZZWS9Itqp5xHubujdDeugikAIJ2kQW1/y8ZRcYePIEiBsB7ADtRhTSHGdGNdi90OS5gP8KDe/RGnh30Ux/Dh85njpa36AMSIAz9GZZYFrOdSTCd/usEfrc1RjZRRSzjcotnJUfmzIr6LBTAQHABMu6KzQ6wf90RXhl87OjnopCbM9lre9M3PYPOkNuXSDHgFGCS5r1nPj+u0jSpwK5LIEP7DEGw3JMf3z+oO72Zeg1NLJ8O2NasR+JhP5vyP+aJLVXQZpoyG35Qq8bJP0Gm/QX6w01OB/caXcHA+WJuD8op4qg6XdpexJsRLSlEdUnNKqLFvZjfmpqVIspbUV+C/IhsHBRxQWEd/3yC1kFLG3Lu1/nunoBlw9GLpu3iI+TsgJ8BnsL8oASK9SrFoBjdrdUu9uRsA7I8ByN4lXtDygp6lWW6SAX1CzjFJUBd+ws7kz3F/iP+EEJjLiG6Q38OnGa/DbFZI+5YYn47mZzdwx4A7g7KnBUbs53oti2EJxiweJYibBhjjbalYLPbHcBJq8bT/on7UyKJwKz6Vdg+7R2VrXX0bzQwYVa3yWbFsVSv9BJn2lbvnMppE6w36DTxZKjvqAPKluosIhM10/16jVfBu3yeUZ+pqeWIrdwEWCYuqdKRV82XJeNRjgrbIdLiNrT4/EiwiZIM7fFgXv9CCnkbO1eKiH3lCnBLgXklgxlUd/R5w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(86362001)(1076003)(5660300002)(426003)(4326008)(70586007)(8936002)(16526019)(26005)(70206006)(2906002)(2616005)(47076005)(36860700001)(336012)(186003)(8676002)(316002)(508600001)(7696005)(7416002)(36756003)(6666004)(40460700001)(82310400004)(83380400001)(110136005)(81166007)(54906003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 01:06:45.0333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f678ff36-efa1-442f-8682-08d9c679a765
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2742
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce sysfs attributes to get the different level AMD P-State
performances.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index dbb7eee11170..40ceb031abf5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -546,12 +546,30 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 	return sprintf(&buf[0], "%u\n", freq);
 }
 
+/*
+ * In some of ASICs, the highest_perf is not the one in the _CPC table, so we
+ * need to expose it to sysfs.
+ */
+static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
+					    char *buf)
+{
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->highest_perf);
+
+	return sprintf(&buf[0], "%u\n", perf);
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
+cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
+	&amd_pstate_highest_perf,
 	NULL,
 };
 
-- 
2.25.1

