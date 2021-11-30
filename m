Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA94634A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbhK3Mm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:42:29 -0500
Received: from mail-mw2nam12on2071.outbound.protection.outlook.com ([40.107.244.71]:38368
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241902AbhK3Mlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:41:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/0XolXYJSTsyWbKUL8lepoLRTZtrj+Xuedgw/7rndX7J5+mm6ySOPWiEwQ8+Q7bXj4JFc4ue87eTgI549pgPe7fWc9nCw98x0Zt7fBEBNu5YUNXkl++Z5/kWvdDQsPT4+8kibDvC5LbSeNbpcul/SCY+ivs8SOrQn+ISLhWWMYdm7Sc6UM1pALgsFBOnG+TzqIPqfc1iW+9kTnW/5E3Nl0IrEWr6iW5Ux3KkBQxIreIMmS2r+dyl8xUGZcJb2gtJPUWdZ/PZAzWKFFOQUTkM7GqDQX5D0x8hOb0FDV9zhlsTRJJ8RVEz7cN5mVVClxfLUX6ikYwyIS61K2y4VuTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RbkQn3dD3s1QYVuk934xqyMRVB5dSeR+NldY7tUrnk=;
 b=NHUZacc+azhFrUQ0w5Cso5zbbx7kOzaNKfzp55GnW8XxMDmgSAk4iuolBwD/hmQvwr+SLRl05jeb686igpawIg3WnUCRMNMm2M9Hh0h6d05hav58OtTYPMRz8dihPPwGgJbys4/sRkD+voksniK9O1ysXzxdxhAx4IfpQtiphxVYA6JoYmzmk2yFZ6Uk20kNuSMoIg1X6WiK7oGgfz3dzVVxFI/o/vWknQQi0JesFCMcfZChvyO+TJXT2oe5eZ4FmIFR/hR47st7oVVWPWN1Sllk002zHIKZ/7HMN0euqKSl/nBV7S8MK4qqvXO84HTCa37283Ar6MLBlz06t1U7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RbkQn3dD3s1QYVuk934xqyMRVB5dSeR+NldY7tUrnk=;
 b=2ZimuTBu2QKhAbwv4+Ea2Kaz0yksueoLszirQfLTNKz3ZmG2IE43yt7ftf/JP/37FPC187C0UkdUr6CjhjoZs1h6+pRSPSH22hKj7cFLt2MrlSCxov8OPZEroCy8oT9u0tunJXUomGHb8URI09p2l06qbNmKYexFHXOLg1Ig5VU=
Received: from BN6PR21CA0019.namprd21.prod.outlook.com (2603:10b6:404:8e::29)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 30 Nov
 2021 12:38:14 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::52) by BN6PR21CA0019.outlook.office365.com
 (2603:10b6:404:8e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.2 via Frontend
 Transport; Tue, 30 Nov 2021 12:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:38:14 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:38:09 -0600
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
Subject: [PATCH v5 16/22] cpupower: add the function to get the sysfs value from specific table
Date:   Tue, 30 Nov 2021 20:36:35 +0800
Message-ID: <20211130123641.1449041-17-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e2ebbfa-71e3-42f0-d891-08d9b3fe471c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4163:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4163187017B2B5B1596CE54DEC679@BY5PR12MB4163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjNJbJJxkzlSnt/wn2sZX/kw4UxUPDt8lt2vghvrZdOtRfAEGaL0bBDYXk0/LvuEyCc+ksSHPJ1E9tjBY1Krj/voEmNxOlG6c02QxIWZphP2JpwJnk9xEpAwIcEr+Mzp170vNtMHvEbJU7st9RJX4JR840OjHkYk4xtrqWBiAV713ALTXpDyMWb+j2LyF0tz+c3ArZcKMJpTZwQV3JzBD3wNFKiHVlBWeCxQqy4HayJzsZlTCKqF4c2IDf1MySPCPrmlJ8IU/uvVdXm+xgmTr4vRrfpBXvYbHdv8Bvr//qu0+47hTZlwOxZNeAJy4TY85Jp/3DS16efmNdFjjueggTK1I9i749oSjV1uUUsPlehQ+LnbRpERvhu4HAZvc7da89rovxz6i89O2W5V87fEolqjlKwry6Qv9Y9w6z6Pezs/J68Iq5m2GwvGYb0Qd6pQ1SJX6ChycF4xMqgc4QcyTaFcip9Lc9jdXm6VRuEyw/ZwLVgF4fnBmHVhwDHffhT6ssY8XCPmBb7HOPkaV4/KfcX8dneLdvNnaL/WUargGVHKFHRDmpP7OK2D0OC6tCLUiZrnOkxHgk6lIhbmL1dvA7HwR3H8brOrLXBu4fzWrjHFJzEgER65cce9vq8t340x3BXbNfI+ig89CqAcjUBmnqx09jDB68d+eZL+ryfV4EDaQwEpVR6O4GlbiMLR/c7bO33fCCaXiIuFE9U011/euzRawlme0MmWI8Cgo+c/Y9w1iN1X3hQ4mrM+O4Yzz4+sbmpXlANzxaWwNT7w+KJR2ZjPQ7RuGCGaPo1uOm562l8xdcvXtS62ptLzW6IAOwfjslNHHtP+59MwSZMqYmpdgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(5660300002)(7416002)(316002)(54906003)(83380400001)(26005)(336012)(81166007)(1076003)(508600001)(36756003)(7696005)(356005)(86362001)(4326008)(70586007)(426003)(70206006)(110136005)(40460700001)(186003)(36860700001)(8676002)(47076005)(82310400004)(16526019)(2616005)(8936002)(6666004)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:38:14.5313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2ebbfa-71e3-42f0-d891-08d9b3fe471c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the helper into cpufreq header, then cpufreq driver can use this
function to get the sysfs value if it has any specific sysfs interfaces.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/lib/cpufreq.c | 21 +++++++++++++++------
 tools/power/cpupower/lib/cpufreq.h | 12 ++++++++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index c3b56db8b921..c011bca27041 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -83,20 +83,21 @@ static const char *cpufreq_value_files[MAX_CPUFREQ_VALUE_READ_FILES] = {
 	[STATS_NUM_TRANSITIONS] = "stats/total_trans"
 };
 
-
-static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
-						 enum cpufreq_value which)
+unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
+						 const char **table,
+						 unsigned index,
+						 unsigned size)
 {
 	unsigned long value;
 	unsigned int len;
 	char linebuf[MAX_LINE_LEN];
 	char *endp;
 
-	if (which >= MAX_CPUFREQ_VALUE_READ_FILES)
+	if (!table || index >= size || !table[index])
 		return 0;
 
-	len = sysfs_cpufreq_read_file(cpu, cpufreq_value_files[which],
-				linebuf, sizeof(linebuf));
+	len = sysfs_cpufreq_read_file(cpu, table[index], linebuf,
+				      sizeof(linebuf));
 
 	if (len == 0)
 		return 0;
@@ -109,6 +110,14 @@ static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
 	return value;
 }
 
+static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
+						 enum cpufreq_value which)
+{
+	return cpufreq_get_sysfs_value_from_table(cpu, cpufreq_value_files,
+						  which,
+						  MAX_CPUFREQ_VALUE_READ_FILES);
+}
+
 /* read access to files which contain one string */
 
 enum cpufreq_string {
diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
index 95f4fd9e2656..107668c0c454 100644
--- a/tools/power/cpupower/lib/cpufreq.h
+++ b/tools/power/cpupower/lib/cpufreq.h
@@ -203,6 +203,18 @@ int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
 int cpufreq_set_frequency(unsigned int cpu,
 				unsigned long target_frequency);
 
+/*
+ * get the sysfs value from specific table
+ *
+ * Read the value with the sysfs file name from specific table. Does
+ * only work if the cpufreq driver has the specific sysfs interfaces.
+ */
+
+unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
+						 const char **table,
+						 unsigned index,
+						 unsigned size);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.25.1

