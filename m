Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A35E4B81B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiBPHh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:37:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiBPHho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:37:44 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F9E194152;
        Tue, 15 Feb 2022 23:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBBmkqwcG0dVGwlyEXwUIQry5KQUuWAGoNnNzrkUdLLDyr+LzWquPeWFFts3/4ZK93NrlLQg+J1paVmsbRGuwv0WEBecyZYAhc2EAndbJh7i4FJRwcdj7W9LINHYOl7H8A+uFuu4yoU/0zKVLF3meqPlkSHeUN8fEBzdAa5LxTY+yeftMHBztxYxLttaokn8cFg7YxMPM3aGtwrX3/Os+D9uJmdKHDGM+ChT3tnxXf3VQzebjN9+EOJ7xyhOeurJbHCYh0jL1zi2fqumwFHlJv9hIgWMNZTsoqiPKEy81XBm8gpFSw2C7aQdSzUWUpVTUhq0HCvDSL9QsxL8pCuwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yol6P6KRnDUyQ4DPHJ3vilDlXJzt5hUiI1yau0/FGRU=;
 b=NOfsNC5AUM8fXWahZtASPqQvsbHu4hvwvO0T4PUAfyalmAajR9t+xkR1+FKGn3melMk83dMlE4MKOLR0WiYCLSFspOtr65xCRg9q9rFUdDhAlKYDVXFGTnJ3Gjwu9kM9hRk/Qs3qu4YPh/OxzkSMw4tDz4HeUoZFFdPa26YLK//4Y/eMhW/3t/s3Lq8NCbx36AqJ1u0HlL1iSqkdap2L2vlgB3j1TeeL2o3Tq/qaBtf3wjZYqdz5gW9XyVvrnLK/orF329XYkSl5+VnK1d844I7pHHYk8ulrna6BVAgDnmaufhyWhFWA5lBzVuBfMl/3PA/rTwsrGJHgcqAZKLTQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yol6P6KRnDUyQ4DPHJ3vilDlXJzt5hUiI1yau0/FGRU=;
 b=dYLWv1xvwcFutE++jZaFLO4Zo7Y4hFqPd8M880VYYvkZQof48CdT8r7a2RBiFmGhB4zAmCleF0ipa29iluv6oLWsxrfyBKCSkH0Z8OdVjW70CPGSbzBkgTeERpQZzC371q1UrJvRT6eLvG93lhuNnnQ42EhdExKtId8sXOzw8cU=
Received: from BN9PR03CA0651.namprd03.prod.outlook.com (2603:10b6:408:13b::26)
 by DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 07:37:00 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::1a) by BN9PR03CA0651.outlook.office365.com
 (2603:10b6:408:13b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 07:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:37:00 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:36:53 -0600
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
Subject: [PATCH RESEND v6 6/9] cpupower: Add AMD P-State sysfs definition and access helper
Date:   Wed, 16 Feb 2022 15:35:55 +0800
Message-ID: <20220216073558.751071-7-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7313c0e2-28c3-4add-e741-08d9f11f1e3b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3370622D235C3C09A2DDDA5DEC359@DM6PR12MB3370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wHJCp7aIAewgaqKlJW4b89q8EItz0NkB1WfFs0eyiDBAccRwLALnxXoYYElBX7IB72W8subN19G89FK2Aidg+CpC0XXC17zzwCLlW8K9uApXaQrahTB5EfSeqKhgRmVuBj0uastqm2/I9PDQJ9LDZaPSKM4aiOTqAYXJJkzRdigrgpurXTeyKdoOJhH3sQlakjjR1EaW0uhBZHEkhWWv5XlypQ2/Lz3g6t6ZMiXGNltFvv8fTXWb+lVlfAPadNQv0KVZx3qJSGht5+6vUS850S+OVgTR9pu+JSTnGWo9SXA3oQTB4OcHtx+vwE8GGFrCESrRxzPLTSsHZrqyMDz3ZHWvMDB7Fu9JLpL3JJNIgS4meQtAtrujxEneZYQLy3gpmuWzeS2Elvhw6d/obQAyletK/pyQFnrIcv8LQ5MCKxRg9G9Sxp99WLjMXnFp2hEKO2fQXUxe5UTeHkRSdTEqRPXSl/n4okfU32i/t+hZage0LIQtljZr7uIn0ZjA0lMDnm3PhpZXKTnxzjbWOs1iAwXevHhyvMEhSw+h4TJByGWcSWAIE4kFuRSjceO5kRaxzrplrY1RZnxYMOmT25/JUpnFZzNSbfzC76O6TY5S7qDk73EY/YqrvgsiaBh9YtEiCnRWjJETmamga6erCeV1DbIBNY7HR8tAROEGSv2YCf6HxDuGOyTxq0EHJkgXVp9aR4vMUgTc0jG89eORQWi9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(7696005)(2616005)(40460700003)(82310400004)(508600001)(36860700001)(26005)(16526019)(356005)(186003)(1076003)(336012)(426003)(47076005)(83380400001)(86362001)(4326008)(2906002)(8676002)(316002)(36756003)(70586007)(70206006)(8936002)(54906003)(110136005)(7416002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:37:00.2533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7313c0e2-28c3-4add-e741-08d9f11f1e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3370
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

