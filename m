Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6344B81DD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiBPHi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:38:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiBPHhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:37:52 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD87171875;
        Tue, 15 Feb 2022 23:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxTlKkz8bmnN2o9mnGpEAIBxAnpSp9YysrXoZ/wAClpqj1An40W6sAQ7jWtrm+FzT+mBRKalzCwR+W4k87rRplpqgT6aUCfnD02cx2pUVNRKdIedHSNd82iepwpMauT668+E27r/0jhqfSjnjAwlGOQ/8Zo6KObn/FXsXARERfWc4PwUzYOX0bxBXNhwAbpy1H8/uC/uy4KzR97NqAHaIQWbwKQBLc/jtTxd4/d0p8jeJ9Z/iaUD0UuASlZo5W5ZNqRAtclzvyFjUPvy+WE6KnDTghruvUsM2IsyYO5nTOhW05V4IOP/DxXlNbPBld69q5AnlZHTwiASZBuC6ovOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RbkQn3dD3s1QYVuk934xqyMRVB5dSeR+NldY7tUrnk=;
 b=HwEWVBFXl/oUT+WCXaQRh9UL0ge9YvimQOQWZFHc0r+hRzQBxOJTvov+LHseGjDqXWb0IQv1iNCHJ0nfVZOjQd+gF9qRdCL6oLxGGU7y9h6GY9FAFTn0dcN/JGc7JuWyflUi2PX4K3CcabVaSHneCvmPjPVG4KlvZZM7T4MwPBz15cDMXK7hgCckBMEEpwxYUqkAHH42gY7j7nSJwI0Rfhcw2sLW2bGicbY668La4c1/Y3ioRfvXU9TdjL8aRI6XMiJg98vABmhjfeEr3/uwy+qAAcyiDVzgBUHVzMgIIBquf1QD7q8AsksP8ig6AaNMSTOgTiYXtObmleJ5KLvgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RbkQn3dD3s1QYVuk934xqyMRVB5dSeR+NldY7tUrnk=;
 b=lieJObwJSVomQv1LgErQP1mYNQqKaNTT4O/VZd7caq75n9ReSRDZckbavkCkOL/HhmWPVeYSgHhP/aZOk1+GDjUgeT01XCxaw0rzLrwuSiL9uHqlreVEINerACCBA5sPw1XPTGKug1GWiCHSUBiCxJ+2/Axu+vWGuv43mwTvarQ=
Received: from BN9PR03CA0478.namprd03.prod.outlook.com (2603:10b6:408:139::33)
 by BY5PR12MB4003.namprd12.prod.outlook.com (2603:10b6:a03:196::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 07:36:55 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::34) by BN9PR03CA0478.outlook.office365.com
 (2603:10b6:408:139::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 07:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:36:49 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:36:44 -0600
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
Subject: [PATCH RESEND v6 4/9] cpupower: Add the function to get the sysfs value from specific table
Date:   Wed, 16 Feb 2022 15:35:53 +0800
Message-ID: <20220216073558.751071-5-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216073558.751071-1-ray.huang@amd.com>
References: <20220216073558.751071-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c3324a2-796c-4a90-5461-08d9f11f1799
X-MS-TrafficTypeDiagnostic: BY5PR12MB4003:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB40034C9CAADE92DDFE0C20C6EC359@BY5PR12MB4003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiXft6a7JCFyU85DzHC/0Cyf95SAiYd6Ws1+4a3GQRy/MGtJmLhkUvs2ZM4HkwYp8qYf/PZpet+tF8GiBVChl22loZbhZSp6EgMcsTTrWrXqNGXnko0be8DaMzMQnwvga6nkBqENWuu1PKKic0MenFlz2KrbK87XQN7l4br3j0YLeASbIVwIvAkFR7ZV9PjOQJdgwXRzQeELgDhyR1cylfFSBzM+kdIiEkoToerIrtCiwZn50ITtIP2BWJhfNfg+nAfxHUnMZdQfd//aXkZ93bLlKyyR1kVVnk/iraZi5EqU65GXMyjnYTq3STPe37hobmPOnJM2PnAZn9Lz6GdF7ziSAEvyj/OVFEFct9k4hhf1Y0RVwpT3x2E03vws3v+WSO7IJ69bJXBZ9bQEKq+EPmxDpATdm2VoK70otsb5miDZZgMov8oEEUN/P/VmZg/zfd+iOyhxkvXKy3O2AFBFCabd3RRDkCQfODBJxon1c6W0h7RXeHkFmbQxbYpwbc5jHYd0WVB2BHDqWxWevEta5AaVlfPD0tLEC20nzaxEVJSB2B6wBP8/JGyb41EwbOicfRTl4yUC2Pjg9SMHiP2ijwEBBfBQMs5dqlX2yS+PqiMYKhFISTHhOUgxU8YAu42GAWRl96VoxdR5f+8XloWoJwxNHMJUzu+L5EPjSs6UouFJpZ2WuvqvRbqVqZAzd5/Tf/pkY1BbXZbseL+cFSZTk8eFLzPUEyNvUQPDK3MT8CM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(54906003)(70586007)(336012)(316002)(4326008)(2906002)(8676002)(110136005)(26005)(7696005)(6666004)(1076003)(36860700001)(16526019)(82310400004)(2616005)(186003)(508600001)(426003)(47076005)(83380400001)(36756003)(70206006)(81166007)(5660300002)(7416002)(8936002)(40460700003)(356005)(86362001)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:36:49.1215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3324a2-796c-4a90-5461-08d9f11f1799
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4003
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

