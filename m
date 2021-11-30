Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7929B46349B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbhK3MmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:42:12 -0500
Received: from mail-dm3nam07on2051.outbound.protection.outlook.com ([40.107.95.51]:58528
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241775AbhK3Ml1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:41:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BirXbAk8BK3JOq8G7gY9RFetRJR/09br1iIijttx2/qD0pGk1y1ttBqAAqjgUu2djquGlylEgZTFu5VdJPd6Z4xnqLyLHC+UEaPwPXnUVtDrLNgRTB3LKdFIP8oUF8GlrjV61v6+oO0GrcN4tdjC7rkTVqGL6PQOBZKZfre+KK+UYFxHs5hqS3E5s6RMCC747eXPs8FOdJ6Dw42PSH2mEkz/3lREZn6Oue6NrHP2nOfPngUKTx2nRrT5etxtSMwsxWN1YUk1hRCqi6Mmea3os3WUt2FmSlEVoOB9eSG8oOChMipPugSE+VfRJW/yFo+V/9sZJCfk1u2/VDlQq4PntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcWX6wnAZ9kKR3lnWrFfRGLYbt7fR1JVVSvMwIGnjnk=;
 b=jNWuG5kOIzEzWObOcbTgeX690cjt6kCCHukkFjK9oerY8gaW/VM6IgDasJ1FbqGK21sUjsEFoA8SCsH7ct46ddumZ6OKk6RLh5aE89xiTwJwBXne3fpiVyDsagVqydRg9o3w+pCPcUGh8oqM5DSuKOGmMZtyrRMQ6+49Z/9vrF0dRgDA30qLyBINI6g3ggi9L+NL/ruzrbCPPThUucWXmnO09DtEjsRecEbrdJWLtnPp/WPq/B7SSLfrxw+0Mm7b1Xzwg5N38iDGFL3fCPD+9FSKyWg7kjA+V+PRKLTgai5UlrwJhnugE4eSgmsKrIi4B5TZ5ELGDKq+wI12wUxTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcWX6wnAZ9kKR3lnWrFfRGLYbt7fR1JVVSvMwIGnjnk=;
 b=Es8n1eQHzS7yOhctH7EzGrRxk1EYQdHzpx1rJnIUg0atmYkfAD6+O/beKm3qz+qMqYxbPQ58RO0W6NPUj2CHpKgWIWxFvt2u5PPxQpTH3cKzDrKaYBRnf9vM9+ueIpwuFGIFgzPRzgTvsSjMRMXeyyc6w4Ka9vzEadJrGoXouv0=
Received: from BN6PR16CA0024.namprd16.prod.outlook.com (2603:10b6:404:f5::34)
 by BN6PR12MB1409.namprd12.prod.outlook.com (2603:10b6:404:1e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 12:38:05 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::20) by BN6PR16CA0024.outlook.office365.com
 (2603:10b6:404:f5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:38:05 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:38:01 -0600
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
Subject: [PATCH v5 14/22] cpupower: add the function to check amd-pstate enabled
Date:   Tue, 30 Nov 2021 20:36:33 +0800
Message-ID: <20211130123641.1449041-15-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 39dc3321-c659-4562-421a-08d9b3fe41dd
X-MS-TrafficTypeDiagnostic: BN6PR12MB1409:
X-Microsoft-Antispam-PRVS: <BN6PR12MB14091027B2AE2A365F737F46EC679@BN6PR12MB1409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scpqJyMC9sKj0SuZstb1YVbM93yPukPtRnKLfj/1er4fMU8l/W/uasj+Ec0r8k3tJE+huGz9HGwO6heQ9pLctmWyVaTGqUY8EZCGYccv113ucsuRU99aopr6u3cy7k78LiCqSxAm3URPaqh8RqpQTQxgOr70KUX4bc4bsL4u5JG9IvirbVGxAze7G4CS8BjW3do5jk83YeNlxERmUb0VMapXAoLYUAxpUtvf28RwwKb21UJ/dS0CGjAosdn/HStLajVG3RiNBid/FbzzVRfLcoNUMZB5m5ovhvitBYneO2VkPi3hm7qGcixgsdhNT7/Jqp0xirtKuueOGAvid0a21UPmaQCMp5djcmJufaxvvNAW7WRuIpGUGGpZovZzPkRzckITfMXhjaod2HU3bwZvEgplK0l3XwQ4RdMiE+r0xTxvSfWdt2N0iTEgoWKZ2UG01B/nx5Tkb4MmzvH3CmOSdoTfIDikqgCw0trmlD3HtS1bxvuAul3LZBZAaRT5fZtXcW5XfV87ksKTHJE4VAdCXDAEFFQYsTd3w1nH4OXgdr1mYBlBzXDtXOmzPijpEd158In2r3wG2SQ7zCMmtnbSHn2n9MLOuQSWX5rtR4hEFUVAGErQxXCM98/IBG29A80LZG5TmbbTVsFcFcFS7TJnkAaeAPjK9h0Aj4UyAyM61Od8vePvizEOTZh1LkY/obXw2ybFT/IRy+1+t9einGJtmEjxSAlFK57Cfk+LHpSuLucybG8aKW3uiYK8cbNZm7Vat5z/5ZmJUTt65yDTr1uqrc4dyI2uSFTrI0EXJb2wAws=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(86362001)(5660300002)(26005)(70586007)(6666004)(2616005)(47076005)(82310400004)(70206006)(186003)(356005)(336012)(426003)(110136005)(36756003)(81166007)(36860700001)(316002)(8936002)(7696005)(8676002)(7416002)(4326008)(1076003)(2906002)(54906003)(508600001)(16526019)(40460700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:38:05.7286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dc3321-c659-4562-421a-08d9b3fe41dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1409
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The processor with amd-pstate function also supports legacy ACPI
hardware P-States feature as well. Once driver sets amd-pstate eanbled,
the processor will respond the finer grain amd-pstate feature instead of
legacy ACPI P-States. So it introduces the cpupower_amd_pstate_enabled()
to check whether the current kernel enables amd-pstate or acpi-cpufreq
module.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/helpers.h | 10 ++++++++++
 tools/power/cpupower/utils/helpers/misc.c    | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index b4813efdfb00..e03cc97297aa 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -11,6 +11,7 @@
 
 #include <libintl.h>
 #include <locale.h>
+#include <stdbool.h>
 
 #include "helpers/bitmask.h"
 #include <cpupower.h>
@@ -136,6 +137,12 @@ extern int decode_pstates(unsigned int cpu, int boost_states,
 
 extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 				     int *active, int * states);
+
+/* AMD P-States stuff **************************/
+extern bool cpupower_amd_pstate_enabled(void);
+
+/* AMD P-States stuff **************************/
+
 /*
  * CPUID functions returning a single datum
  */
@@ -168,6 +175,9 @@ static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
 					    int *active, int * states)
 { return -1; }
 
+static inline bool cpupower_amd_pstate_enabled(void)
+{ return false; }
+
 /* cpuid and cpuinfo helpers  **************************/
 
 static inline unsigned int cpuid_eax(unsigned int op) { return 0; };
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index fc6e34511721..0c483cdefcc2 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -3,9 +3,11 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
+#include "cpufreq.h"
 
 #if defined(__i386__) || defined(__x86_64__)
 
@@ -83,6 +85,22 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
 	return 0;
 }
 
+bool cpupower_amd_pstate_enabled(void)
+{
+	char *driver = cpufreq_get_driver(0);
+	bool ret = false;
+
+	if (!driver)
+		return ret;
+
+	if (!strcmp(driver, "amd-pstate"))
+		ret = true;
+
+	cpufreq_put_driver(driver);
+
+	return ret;
+}
+
 #endif /* #if defined(__i386__) || defined(__x86_64__) */
 
 /* get_cpustate
-- 
2.25.1

