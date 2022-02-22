Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDBC4BFCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiBVPgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiBVPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:35:50 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B5B163066;
        Tue, 22 Feb 2022 07:35:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcyd1B2zHXBA2YYxXo/PeTAE+q9qNPZZU2UiEhmD4EjdZ+/cytWGQwCnubPa/tzS7jYQ5y1i7Bt9U8YOUi47oIvqsRg/kiuhMoTUaobRjPV4yhe6H3PfNpvVXoS4cwo6EBINKz51PdIj0Nnv8UTgmqexQlru+ERyi3EgXoAdtJRgsQeTCN2jVWLgJq8q15bfrd02b9vzjWnhSnFt70LZKAlnvUugogK/zOx5uqxqIU5vy0cJDzVz7ki8/0T9AO1MXGbnpqX8yTKAkU2jGnWuRQJjP8y+qYhj04BnMRNUDyzHUecq3CBAv8snZZrOonGQnv3KXtgIChDr7YIyJGG4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yol6P6KRnDUyQ4DPHJ3vilDlXJzt5hUiI1yau0/FGRU=;
 b=BC4JiBjmfdK03dQWJXqOnwk9xNkmmb7Elfsu0Oxwl0P9DgUUWMLLalb7yF8yi/2oR2pywiwqowS+7Mn+JqL2G2sZsnMBWXSE3GVZXqDqBQDouQZnOAJpYwufycvYT9WH+2tnbvvnmHqyBBN2zqoWvViMPHqWqZddurStqPdmAiA9LbQ4Eg+Nz0tbaXstLAzQsz792m+LFZzpOEvA9/0WYq6O4hp9kXl/NXn2byWq5Z+HuR7IuxWRJ3VtSupIZfAu6QAQErKtLxXzgVsNP9qd2qsmk1HKNidhsQUQR95mbuQW4KDb37Atylun30CIOgpf1KjWYBGRRBz5ZAojzUvWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yol6P6KRnDUyQ4DPHJ3vilDlXJzt5hUiI1yau0/FGRU=;
 b=V7sitmmTZcQIeK623UIPfB7yIAkD1tFTctjPtbk3zKG9H/KqAGMda92boasgT8GTqXUbJgss8ZEHlAlO09L2jvXMLQJwLmKBfdg8RFzgE1l/DSaSv35rN2RZLY5lDsKK70NQxJO016iyQZz/ZOs6geYEAcXVjxvZAYy11OcKBdQ=
Received: from DS7PR06CA0023.namprd06.prod.outlook.com (2603:10b6:8:2a::14) by
 MN2PR12MB3088.namprd12.prod.outlook.com (2603:10b6:208:c4::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Tue, 22 Feb 2022 15:35:20 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::73) by DS7PR06CA0023.outlook.office365.com
 (2603:10b6:8:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Tue, 22 Feb 2022 15:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.20 via Frontend Transport; Tue, 22 Feb 2022 15:35:19 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 09:35:14 -0600
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
Subject: [PATCH v7 06/10] cpupower: Add AMD P-State sysfs definition and access helper
Date:   Tue, 22 Feb 2022 23:34:22 +0800
Message-ID: <20220222153426.2216974-7-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7cde8743-5e5f-4064-ab35-08d9f618eefa
X-MS-TrafficTypeDiagnostic: MN2PR12MB3088:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3088157F087091055879A80DEC3B9@MN2PR12MB3088.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qs17vQd3Yc1fPWhIhbzlheEi9hdLZFQEpEg/jUxajdmpP5GidYaZKzq/E/JXyPzOl2vFjNFzpSh0597RwpkSvy2oDcW+M748NOaoryqR66m3Ukcq5wXSozfpvSpGFe6QEwCXyuh5zD8NmJuAi/Wcy/3VSQCIII9xu6AxboWuF6m2ooftoXIKtnx+Yq7/13PtGr2eiVsv0P4zaSoMm9q3cE8SN5O1b3ZcmnYeOUOCe1QtRQT/ZozMt5tn3i2lsnz4HS9fOocNGVRGrHajjZuXw96/retyB0qeUMjVUIF3rEs5/+/3zG+caXirsCRQKuwQ7PZyITsqhMmfXDryrq0OvkjCjrWT4EGL90KFbicEdN3BAOym5dkd6YKyOlcS4zaXPOkQoGGb8/nRuX9/m10SAJb86SSqhFpb/0rL2wUL6J+plGRlIZZquG2TdqzzsBuKq7GLyJ4TP0SRrYVIjB5FtmYcLU9f7mJjczsYxIdU6Lp/sMKn9CdXeP90ZN7nBx0fAY+kYS7qcVLxamm6crZCHUwuhaxIwzVAWo9W+/uN4YTxQnkbcmJ4hzEALNZ8jrlt79irhNCb8mr4F06ZWn81FSe9HCI+4+AWDuPIIf+Pkyw6vJad87qFijfDA2oomqb6DYfPzuQdImIb3fz/yV3MdPn/RCbA39BjdD64IlZtQv48/uzaJGN9a1msvqfIWgZnKoEeLpARWWr4NPAn4sZH4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(16526019)(1076003)(26005)(426003)(336012)(70206006)(54906003)(2616005)(316002)(356005)(2906002)(81166007)(70586007)(40460700003)(36756003)(86362001)(47076005)(7416002)(8936002)(83380400001)(82310400004)(36860700001)(508600001)(4326008)(8676002)(6666004)(110136005)(5660300002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:35:19.7751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cde8743-5e5f-4064-ab35-08d9f618eefa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the marco definitions and access helper function for
AMD P-State sysfs interfaces such as each performance goals and frequency
levels in amd helper file. They will be used to read the sysfs attribute
from AMD P-State cpufreq driver for cpupower utilities.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 97f2c857048e..4d45d1b44164 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -8,7 +8,10 @@
 #include <pci/pci.h>
 
 #include "helpers/helpers.h"
+#include "cpufreq.h"
+#include "acpi_cppc.h"
 
+/* ACPI P-States Helper Functions for AMD Processors ***************/
 #define MSR_AMD_PSTATE_STATUS	0xc0010063
 #define MSR_AMD_PSTATE		0xc0010064
 #define MSR_AMD_PSTATE_LIMIT	0xc0010061
@@ -146,4 +149,31 @@ int amd_pci_get_num_boost_states(int *active, int *states)
 	pci_cleanup(pci_acc);
 	return 0;
 }
+
+/* ACPI P-States Helper Functions for AMD Processors ***************/
+
+/* AMD P-State Helper Functions ************************************/
+enum amd_pstate_value {
+	AMD_PSTATE_HIGHEST_PERF,
+	AMD_PSTATE_MAX_FREQ,
+	AMD_PSTATE_LOWEST_NONLINEAR_FREQ,
+	MAX_AMD_PSTATE_VALUE_READ_FILES,
+};
+
+static const char *amd_pstate_value_files[MAX_AMD_PSTATE_VALUE_READ_FILES] = {
+	[AMD_PSTATE_HIGHEST_PERF] = "amd_pstate_highest_perf",
+	[AMD_PSTATE_MAX_FREQ] = "amd_pstate_max_freq",
+	[AMD_PSTATE_LOWEST_NONLINEAR_FREQ] = "amd_pstate_lowest_nonlinear_freq",
+};
+
+static unsigned long amd_pstate_get_data(unsigned int cpu,
+					 enum amd_pstate_value value)
+{
+	return cpufreq_get_sysfs_value_from_table(cpu,
+						  amd_pstate_value_files,
+						  value,
+						  MAX_AMD_PSTATE_VALUE_READ_FILES);
+}
+
+/* AMD P-State Helper Functions ************************************/
 #endif /* defined(__i386__) || defined(__x86_64__) */
-- 
2.25.1

