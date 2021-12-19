Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F91D47A163
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhLSQhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:37:04 -0500
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:52097
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236249AbhLSQhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:37:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpFUjKVf8kpxw0TRXzWqyvZa1x4TlgdPiEaOe8qW8R4lhKoCG6nJZ+UEGi+qEBPWHSfh1Q3O3R0Dim0+F1x8Uzkf63lEMNt5JlFNql/0VCRc7WpF4kzWMZOnPCIwV2vFs7xSgt89leLRp60TbEkEBCTbGER42GFXafRRjII0k0Av/2vXXp2c2O0GZANXzCpmKIJgn0ICq6I/TWrzYaO/Zep8ExYAlIG9JEpwkYqrVTqijEk2aApQuBoAxBt4xpMVy0jECp1g/nifoHAIaqHddJSq2wHkJVBzdNdYaKkv2qspkvfuIMmCLGxHlS/2Cqaawsilgk27dvRZrTjGFDPb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw8lIw88TsUzNkCpch3PbhH3RZiBPX3LpCAnucPFsEc=;
 b=JVeOzTCVu2l34kOSWIV0IZzUTl+xISzXl+RDnPFMhM8aF45rWJxX/ddZZ6I5epcE0xS1Vt7WopdQBnIx084f1RrDgU8XKT3zmiLeiD2pBOD21OFo+EdZ1q4ZxHmQj2fhVkYSwLBeOlkoYHMcjLmSZMIhx/BLETvcWHYuRPgjBV0EEvQIeTdY6RGmKne68/isOzxTtkIKzKUpgsXzXvBVHv6t+jlAm2H4oBD2mJWsf+cfjQt4FD1Y6fa1YKU5mebaSX256ktJpgdSzHE3/imPjR/ngSHrlRjLLIEavXuYzrtBcqfs6/VfpOlG5N6iMagorwKLhudyym5nsURVpVaOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw8lIw88TsUzNkCpch3PbhH3RZiBPX3LpCAnucPFsEc=;
 b=Re9WFMB/Trb27ehkXUYJzK/PytMjQHtxXm/d+2wFdY6fCNqmnFc4c5p2eiST6jZaWAUiNHvG5WAj6Yn2iIIDBuh2vQKXj+pvBCxYQKxZoh4VEtoRGpkVhVtM+uCas8mcQBPeCwFv+MwejEl+ZC8VUCtinEiPbMpBpy8XkxuJmrA=
Received: from BN6PR17CA0058.namprd17.prod.outlook.com (2603:10b6:405:75::47)
 by DM6PR12MB4844.namprd12.prod.outlook.com (2603:10b6:5:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Sun, 19 Dec
 2021 16:36:58 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::25) by BN6PR17CA0058.outlook.office365.com
 (2603:10b6:405:75::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Sun, 19 Dec 2021 16:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:36:57 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:36:49 -0600
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
Subject: [PATCH v6 12/14] cpufreq: amd-pstate: add AMD P-State performance attributes
Date:   Mon, 20 Dec 2021 00:35:26 +0800
Message-ID: <20211219163528.1023186-13-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9976c41b-c32f-4365-932b-08d9c30dc655
X-MS-TrafficTypeDiagnostic: DM6PR12MB4844:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4844467ADB5EC7E1220AF3FBEC7A9@DM6PR12MB4844.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlmK5qFxpMueLgDWAa6clBimsj2v+TruJekMdAtHZRMWTlKGGv8NMIl7ShRzwtn60dZMXJZxU5xeFN0TRviw+b1k+jO5Jrrv4TzeCnSg28jg9QLe+7R0ry0uQ+0d6ecoFTYTN6GF6DzU+KJtOWbWMaajZqzrILpBbwRKVCasLi6C2bVIuZFQXqHWrwOU9apKevLQ6vmri0B5W1KTnXDXKtInIuMaOo0ggHMQRD7gZPkhegr6wy1WgiLN9QesZ0pr2Q+kUPqnRhCqrhVe0vZUpm3HZ6ByXTbOWCBRsaqW+txQBQDpRfMuUkqd/ayY4dyw9vjb2QUfP9+hK/jfkkO910Z9cqr+Kcw11vKnkNJauhi5+hRJMX09Z0j43xz6vKSA3HhW0m0i4kjMZ1vU0mySAUrHLZUHAhhOWKQGFDeiGodJkaxl3YQWN9KisEaL0m5cy2Gt4dkhsoqeGBbrb1ZeRUATtep+jo0/SuzvX8TX6jPksvt2Yeao1df37vXwzTOUyeHsnFZl/vOXPAjj4K0cghUBbnj//zalo3hEJfgEkypqAtjJVTxscGWF50ALpgbtV7zxnh9YD5GHRSjJM8FUNC+Neq4OTYN2bomeHl54zI9OVCijrjTTpLI5iPZNAl6RkfriIyMlvnxOVJnmnP3YsYoCi43Pyi+ylGSYVRtTGbrVBl15SNL4rFABKaZsD53adnR6+hDzRvh34fFF6UgRMoB7GeEhdmv7O8ZSxyZQ37U1+zGrHRderNpOkBtg9Q/8OW2IqkJRctPBI1s13hlL+N7/rtIWZzDJzEkbzACNIlc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(8936002)(81166007)(36860700001)(110136005)(54906003)(7696005)(356005)(8676002)(1076003)(6666004)(70206006)(2906002)(7416002)(426003)(86362001)(16526019)(47076005)(336012)(70586007)(508600001)(5660300002)(186003)(26005)(36756003)(4326008)(2616005)(82310400004)(83380400001)(40460700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:36:57.8699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9976c41b-c32f-4365-932b-08d9c30dc655
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4844
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
index dd8c0e894532..2471a311fb4d 100644
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

