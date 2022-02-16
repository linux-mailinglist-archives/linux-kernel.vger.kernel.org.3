Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A64B81E0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiBPHip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:38:45 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiBPHhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:37:50 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7322118405C;
        Tue, 15 Feb 2022 23:37:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka34EYtNo+Fwn+FpAJK54cMHimxzwGRKX9lOej+oMk76zRwksxnuDRXui83IMlDV4up/CCsqjEhamDfEM8hLs57ERYQq+99xUFwbM/yZdn8R86kc06+zSUN0yykBryqQ/6s+c3b9gMA/kASjZ7YK6GVSkrBBWPiLbETJucLp6cB2C5ekr5e6RSQ668RfGJIoJ48ZuYS+VYDuAgOXDxrrqMpA5lsBAeRKuNqXkD2SiNnb7twx741hrc3MS0H/i0r9QMUY8HrZzCV9H9Cq7CmSi473xR9BIxnCEkyIjcHiLFUIRoXy2Ur0jTAa7Hu9NktipsH6VH7D6EBVfkSHRhzPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA8jBDdLU3KAWwOP5ypihhXb7wKXVSEgUafhpCVEulI=;
 b=KAE9IBRaNRgDcCPIW8BvbcRXy0+gK+s6TVHcgGav43znPIXZnKrHFMB/PG+gardp1s0X5jSjIVP9OmhVG2q3nns+BVSjrPQ4T8Bc8/ikMH4aWX3P9iWYdQK5p2Lcrsu2iGAjwM7j5X4FUSEgpl/zkGNXUUUIySotdD+uB7gc5iUDER9GfZl5pXayDGWaDZD6asokU2usQjqhBwk+vH4mDxyC0KGrtV4UWqw/RHouW35tOP7qAc4PrQkNfSku32R/sKKKyFsMbxMxq1oLUttTAcR1Nrld+RsHaZqPrAnsNXhQ2OolftcWbqH6P9vMQo3TUb795OmGmiUF4zpINXwvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA8jBDdLU3KAWwOP5ypihhXb7wKXVSEgUafhpCVEulI=;
 b=f3gi4pmCVLjBgp3EcZd33LkQFHeSndJKVEQFBv4jMmbe2R5m8cGKvGcVWZDdrsH6sC7mGLylsC4iXyb3j8jajoC1gx+KemIsJr/IPbuaDoDfBcfXuquWqlreUAIZa/tIZqyMcnGLGz3NyWKldCVOu0fU1dlLvbD3g/U5+FKEez8=
Received: from BN9PR03CA0553.namprd03.prod.outlook.com (2603:10b6:408:138::18)
 by BL0PR12MB2436.namprd12.prod.outlook.com (2603:10b6:207:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Wed, 16 Feb
 2022 07:37:12 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::78) by BN9PR03CA0553.outlook.office365.com
 (2603:10b6:408:138::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Wed, 16 Feb 2022 07:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:37:06 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:36:58 -0600
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
Subject: [PATCH RESEND v6 7/9] cpupower: Enable boost state support for AMD P-State module
Date:   Wed, 16 Feb 2022 15:35:56 +0800
Message-ID: <20220216073558.751071-8-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 24884339-441b-4d86-519d-08d9f11f21f6
X-MS-TrafficTypeDiagnostic: BL0PR12MB2436:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2436BC7DAFB9B6EB0D902433EC359@BL0PR12MB2436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iefgkYwo7Ie9D4ABoFwFHlnLFKph7PLEA5iOpAG7LYAz+cu60v8mRwDG0XBWz1WEprQtPdoodekKFQdaWMxXEILbr3eM8e2wEt/2s7FQ9gvK5CICJvugC9FND3spd4f4HvnSJRhifrsEr1c3cJXg+aGtLc54jCByx7Y8exRA2rp+G7d1bgTAsPHPMQsDm2Jn8PTEbAgHeh2iVvJVu7CkK071w88F4BlEyC5t5Xn/Ks7BApFZHYlbHE0sxexnz2dU5vA+s4GCjnfVTB/tC9T1MMMX8nRXdfn2n15es7CUTrlm69EZWPKVfvV71REnQqGZYCDat6BIrSYBmDuTDXQBwbDmgNzHdZwWJrkf3U/eH4/5WKzFyQFoLOqx9yrTKfRgXfcs5bKmW1T7LIR2HoK/XutaH1m7LVBzBqj8ZVBNJDXJfKWwVtbdcok+9yam3zFt3ISMCrim0HTcw6r+zDHr71llbUZ/8nTudVkLXvg5ZT19P7ABv4PKJlMoQf1ot9r22CddpeSGpfEIjqNJM+RvX3GJOyQ+4lVV5sSWPPJCf3aIQBIQyQbzHe5fuUVCuACljxOfvuoBDQKGayWg6TYK3Wh8JUC1A61eHu1CrUe9xVxtizsFtqoW4/Q/PZgQHonwj6yy6LckbO8eBPSK6F2jq0uvgMWo91URMjOtYX1E8eWcZXxDmHoBHGt3g7OXDI2HvaGDjjQuIUqCzkO5Sk3RFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(356005)(110136005)(54906003)(2906002)(316002)(81166007)(7416002)(8936002)(5660300002)(4326008)(86362001)(8676002)(70586007)(82310400004)(70206006)(36756003)(2616005)(426003)(336012)(1076003)(47076005)(83380400001)(26005)(16526019)(186003)(7696005)(40460700003)(508600001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:37:06.5081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24884339-441b-4d86-519d-08d9f11f21f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2436
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy ACPI hardware P-States function has 3 P-States on ACPI table,
the CPU frequency only can be switched between the 3 P-States. While the
processor supports the boost state, it will have another boost state
that the frequency can be higher than P0 state, and the state can be
decoded by the function of decode_pstates() and read by
amd_pci_get_num_boost_states().

However, the new AMD P-State function is different than legacy ACPI
hardware P-State on AMD processors. That has a finer grain frequency
range between the highest and lowest frequency. And boost frequency is
actually the frequency which is mapped on highest performance ratio. The
similiar previous P0 frequency is mapped on nominal performance ratio.
If the highest performance on the processor is higher than nominal
performance, then we think the current processor supports the boost
state. And it uses amd_pstate_boost_init() to initialize boost for AMD
P-State function.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c     | 18 ++++++++++++++++++
 tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
 tools/power/cpupower/utils/helpers/misc.c    |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 4d45d1b44164..f5ba528dc7db 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -175,5 +175,23 @@ static unsigned long amd_pstate_get_data(unsigned int cpu,
 						  MAX_AMD_PSTATE_VALUE_READ_FILES);
 }
 
+void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
+{
+	unsigned long highest_perf, nominal_perf, cpuinfo_min,
+		      cpuinfo_max, amd_pstate_max;
+
+	highest_perf = amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF);
+	nominal_perf = acpi_cppc_get_data(cpu, NOMINAL_PERF);
+
+	*support = highest_perf > nominal_perf ? 1 : 0;
+	if (!(*support))
+		return;
+
+	cpufreq_get_hardware_limits(cpu, &cpuinfo_min, &cpuinfo_max);
+	amd_pstate_max = amd_pstate_get_data(cpu, AMD_PSTATE_MAX_FREQ);
+
+	*active = cpuinfo_max == amd_pstate_max ? 1 : 0;
+}
+
 /* AMD P-State Helper Functions ************************************/
 #endif /* defined(__i386__) || defined(__x86_64__) */
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 557524078e94..f142fbfa4a77 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -140,6 +140,8 @@ extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 
 /* AMD P-State stuff **************************/
 extern bool cpupower_amd_pstate_enabled(void);
+extern void amd_pstate_boost_init(unsigned int cpu,
+				  int *support, int *active);
 
 /* AMD P-State stuff **************************/
 
@@ -177,6 +179,9 @@ static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
 
 static inline bool cpupower_amd_pstate_enabled(void)
 { return false; }
+static void amd_pstate_boost_init(unsigned int cpu,
+				  int *support, int *active)
+{ return; }
 
 /* cpuid and cpuinfo helpers  **************************/
 
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 0c483cdefcc2..e0d3145434d3 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -41,6 +41,8 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 			if (ret)
 				return ret;
 		}
+	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) {
+		amd_pstate_boost_init(cpu, support, active);
 	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
 		*support = *active = 1;
 	return 0;
-- 
2.25.1

