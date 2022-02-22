Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCBE4BFCE0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiBVPgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiBVPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:35:47 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3073163D47;
        Tue, 22 Feb 2022 07:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoASEehTer57OAZbwwljmAUOxTBmJXKr5MLFmWq4ylrKU/BkYQ8+lIm3xd07YSy8ZLB42VIwq3/W6jU9kJNl/EIoEk3Gsh0V/F5ql820iCVxb6xnPacRnGMS0KGzldYoPip7ZMGIMWTI/Q095O4rPJHCtXLPyHxnhnbsbW8+rK3kcYrNaPTjmw+n8nz7Um+R/J1iqsVB1r8GquddAxDZqHnQZIExp1Z/+7gsC4diuTbdnBFPxJ7NFYL6249if5zULNFacxFDdytfo5ryNWGqWXMauW+Mp+/6Wc3IG18N2J7Sajjky4f87fYzE3HaOLcKX9bZoUqf8Oz0qT4f8z+RZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsCkX7QoRw25vkfoybD4NlCtdj6eCweUKUNCEZE2v6Q=;
 b=aCgp50IoMqgYNPRwBD5lOlsb39Wsxv3ZETJgwhI7ODIjSYfJ13M71LjifexgU9pi43oELa+oygldgdcwkwjbvS7eNgoCn8ymU5zo4nAPPtnz5/NZbJsAeYHtHZXZbGi/Lvs2TIAqE8nrO6RhvxoQlEg4p+ygObSGoNV3oV752dIPOdY34OPCJVBvYpOfWV2uxuHotcfsLzl9sNa+nc26EhnZD130jD3ODjeeEnO9ZPFOojXqU2T1/V41ztAi/qosUkNs5hyHiP0b44slYbOmlO4WjPmNq39sKxYStuHRpG00KQZXpKPNFIZzpVOcHfhDTpIlqsatgqQ3x3i3LpmE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsCkX7QoRw25vkfoybD4NlCtdj6eCweUKUNCEZE2v6Q=;
 b=apFxeHxlMg/1ISxjOJD2LWuxcMQW6/iKQRCRAH3weIUPs3Irc40Ctc7T0YZ+an39uVX1nc0hVL+nbxHH4J/PwZvX9oloqYEcGzSlEuLYCjG6YBvO43ck88fcaZijpR51G+huAKT3AshsWZZkmf6yezuK2sWAGEc87+AbY5Hx9Ek=
Received: from DM5PR19CA0052.namprd19.prod.outlook.com (2603:10b6:3:116::14)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 15:35:11 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::eb) by DM5PR19CA0052.outlook.office365.com
 (2603:10b6:3:116::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 22 Feb 2022 15:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:35:09 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 09:35:04 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Giovanni Gherdovich" <ggherdovich@suse.cz>,
        <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v7 04/10] cpupower: Add the function to get the sysfs value from specific table
Date:   Tue, 22 Feb 2022 23:34:20 +0800
Message-ID: <20220222153426.2216974-5-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222153426.2216974-1-ray.huang@amd.com>
References: <20220222153426.2216974-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ac9eae6-c85a-4438-26cc-08d9f618e926
X-MS-TrafficTypeDiagnostic: MW3PR12MB4427:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB44272B95A8276F88677AB274EC3B9@MW3PR12MB4427.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFRt1QmcrQ1c24QRLJRBTd+jxE9j3RoZ77h3cO83yFyYXShjr0hTjKKi6hgmaKKA0KKTR/vt4UmNqc1WzhHwLzWFgcBmsjsrvUWuvBdbVpJ7ALWaKCkaN83kbyjwAKlXj1F2lx3EYkN1Amb6yalquMGVa+syGDQEjukLJTiKT63Vk0GdWw/O2RmjG0mcPKNkVHB2+ZaMyA+5ddXCQh1hgZgWBCUmqzx4VCQcPfOJdPEGALa6dyPQLk1WIXiE+9DZzbmnDYN+M5oDza3qwZZBzktCGKBKCb/oIgqbmAX8EaVbWCc5NWazly3soy4zGAlS9z5GlX26/7zgSE894XHz8+I2nvo4m7rFf9RsELdvFGTV9oETPVQzTQ6Yk1B+xjhc+YrZGEl0n9ChCDLU5ESHWBYB2NDbtKN7mMI7YUvhGKHQPsbHnjeFrFeFnDOtR9SupLKTSSzQhg0NkMGCvayXMA/8IVpDjOwtZIKmPu9d1qngburKplyH5zyJZi3Ww+w/1JaciYrTLbyJJhitjiQUXeLPr8Ky73wkRFQ+2MD70ykCl7tF+i2k4Dujd65aKxa7B9xVoI8vI5/8JCN/v6G5C1ltWX+9MJGf5aS4f9/AOr9gpGdDeLJloaxR7K0lysRuaX9VVNvE7b2myutk8MWPuxMZq5+zDzrSrXh3Ay/2K36+SbJViSa5aka4aviCBGSQgI1W3fZvF+F7gD1Yx4QcBb+2P7C3j0lmF+KnGmI5hYA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(82310400004)(70586007)(2906002)(8676002)(8936002)(81166007)(6666004)(508600001)(4326008)(356005)(7696005)(5660300002)(316002)(7416002)(86362001)(16526019)(426003)(1076003)(2616005)(36860700001)(336012)(36756003)(186003)(26005)(40460700003)(83380400001)(110136005)(47076005)(54906003)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:35:09.9781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac9eae6-c85a-4438-26cc-08d9f618e926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the helper into cpufreq header, then cpufreq driver can use this
function to get the sysfs value if it has any specific sysfs interfaces.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/lib/cpufreq.c | 23 ++++++++++++++++-------
 tools/power/cpupower/lib/cpufreq.h | 12 ++++++++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index c3b56db8b921..1516d23c17c9 100644
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
+						 unsigned int index,
+						 unsigned int size)
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
@@ -124,7 +133,7 @@ static const char *cpufreq_string_files[MAX_CPUFREQ_STRING_FILES] = {
 
 
 static char *sysfs_cpufreq_get_one_string(unsigned int cpu,
-					   enum cpufreq_string which)
+					  enum cpufreq_string which)
 {
 	char linebuf[MAX_LINE_LEN];
 	char *result;
diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
index 95f4fd9e2656..2f3c84035806 100644
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
+						 unsigned int index,
+						 unsigned int size);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.25.1

