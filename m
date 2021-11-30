Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64754634A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhK3Mml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:42:41 -0500
Received: from mail-mw2nam12on2071.outbound.protection.outlook.com ([40.107.244.71]:4449
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241959AbhK3Mlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:41:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+zFSX1cPevPRr0rlmxUOIUXvSHKZZN2cU86HDgick7BwiO89mPA+2FmCAxx9GCDODhoe8GcTa3dEtisw9qSXsoipD+mm2BYiIVBlUIK8Ylamj3jPGUeAjb3uaxy/lwZIpWHoZ8DM7k4MHoV17RCZRX/R/GWZfXSqjrNlV/SkMiZCFZpsvjpmsEwzz54UofTsGD+5+VOVmCbfQIsO8R6k4sroACWaNNmYwDKaEGUKAvGTPW3psqhsW32tlucFwadxESqEOu6TkzbQYHokYKdHtmyRYEBwR0cYtbZSCMVaNIpCKnVwxzpaOUHCRZT0KShWQMf65vxtQgUHzhmwfz8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10ZoxYKeFuCwEWIzDfr8ONAa8ASibQTmUMy9E8/1byc=;
 b=GNBmE/Yu6EjiQIDsN2Hka+L3TWN/KvlvSkCOkxJhL4UpbFbeECC6EhecRET8FG7vcgqt0K0kcnajL0NxcXXrRSKjTYdd8LstBNAeXlJJmI9k6NyEgDpGvGKSXnaUJ+oyLEUGBTmieFn3bq3mXJkDXl04hnq97+24WME65nvTRndu1gGKIWFgtP3qqB9TAHqw/6gXuQYGGIWT84i/uE7RfBBojAiEHoYe81bb5fM/mHffd1Calv6rkmdWp0ldPULRrfzICM1O2Sg6tmfUsjv+/h6gNcGs84XBCz8wPnfvcnxb0Ic3/Mqe8oAkSqxRRU8WA5KYTP9vkQyUH08tn0vgDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10ZoxYKeFuCwEWIzDfr8ONAa8ASibQTmUMy9E8/1byc=;
 b=Osn8PbcXgGkmGYzGp/N/FmTXIcE6Fqk7V6O7brymK9zbMbZCQuG24Ju6I5eH3QgMHj9Ga9ZB2lt0NPkuXs0+ESZ/Uj4o0K0QfPCIco42BGf4vj+7buXluUCQJ5NPInfLLlHjZcK9so6Di9f3qUxoqTLMR+yJn3lZ+49vBLT7ni0=
Received: from BN9PR03CA0093.namprd03.prod.outlook.com (2603:10b6:408:fd::8)
 by MWHPR12MB1613.namprd12.prod.outlook.com (2603:10b6:301:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 12:38:28 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::7d) by BN9PR03CA0093.outlook.office365.com
 (2603:10b6:408:fd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:38:27 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:38:23 -0600
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
Subject: [PATCH v5 19/22] cpupower: enable boost state support for amd-pstate module
Date:   Tue, 30 Nov 2021 20:36:38 +0800
Message-ID: <20211130123641.1449041-20-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c1a81d19-0de6-46bd-01e5-08d9b3fe4f10
X-MS-TrafficTypeDiagnostic: MWHPR12MB1613:
X-Microsoft-Antispam-PRVS: <MWHPR12MB16133DBEE355773AEB1C39D2EC679@MWHPR12MB1613.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXigq1cRT5DH/WTBmOTl0mcScxBib8pzxGbylUeN9VDbeVhy1E9+3nwjtRNHbvnbJzGxKYx6Ar/w2VdfTseEwXp4KuzwbeBL0YePRz4DbOSSE6oClHYmjmPTxtH5ldi4MW1sSNGtyJYMClMbzB9S2HJ64ZVDtKf02WpGvO3s+3Oc5bmACnncC0djaMgzrDmKb2SNbAQ8hRkSuWwkToyq0/8PBVYwRKXk6bcQfTx2HrfRDumrOO/wZx/wiVIEo5a8SfG0DND4UfwNW4xrUFBLGZ02HbK0lli2U5qVlo3/x+g02U491E0IC/VaYYhqhzs6m3gHfJDseUED86tZqjmRhMYzaz0gY0mu4MO1sDQXu9CkCgMZsc2gJVndglaN3y/DRYBmNuEeDWL3z1rnVNbCPuYN1GWopjTp0Dww8O5c+bgu7VJ+Us4yCt5WJXQ9rFeCAyt8sdR7pyhh7HRauE7WSjHPKVu9YDTfgVHh7M9AwE8Itsmzs8gVIJNAX26vpM27nxnLHuaTTsRIuKMmAwm95VWnhsQbl1ayFA1VPSqqrr6Xq/qjFdwh+5BgN4rQx68LJu9bjXvv3EzMbxNvk1workQpbBgF1sNDDZ4rQun3YiN/tyYHW1WwOZE7Jet+mj5d+s+boqW+ATOUn0NrCvWuc9qGQeN6cDQRxIzpXU1Gy4WxKZcaRV/aXQ12f1I1gsx9XXy3ZjiWpZfCfQPsNiMbDkAAa1mPpun8cO+digbX9iemFJyVVKD9A4HkXKNktuBIjX2gnNTAlzT5WtNbH+MwR3oOi/M3OU5Vkg8sPHTDbyU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(4326008)(336012)(8936002)(2616005)(82310400004)(7696005)(26005)(2906002)(356005)(47076005)(36756003)(16526019)(8676002)(5660300002)(508600001)(81166007)(426003)(7416002)(1076003)(316002)(110136005)(54906003)(70586007)(70206006)(6666004)(186003)(86362001)(40460700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:38:27.8720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a81d19-0de6-46bd-01e5-08d9b3fe4f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1613
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy ACPI hardware P-States function has 3 P-States on ACPI table,
the CPU frequency only can be switched between the 3 P-States. While the
processor supports the boost state, it will have another boost state
that the frequency can be higher than P0 state, and the state can be
decoded by the function of decode_pstates() and read by
amd_pci_get_num_boost_states().

However, the new AMD P-States function is different than legacy ACPI
hardware P-State on AMD processors. That has a finer grain frequency
range between the highest and lowest frequency. And boost frequency is
actually the frequency which is mapped on highest performance ratio. The
similiar previous P0 frequency is mapped on nominal performance ratio.
If the highest performance on the processor is higher than nominal
performance, then we think the current processor supports the boost
state. And it uses amd_pstate_boost_init() to initialize boost for AMD
P-States function.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c     | 18 ++++++++++++++++++
 tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
 tools/power/cpupower/utils/helpers/misc.c    |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 14c658daba4b..bde6065cabf4 100644
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
 /* AMD P-States Helper Functions ***************/
 #endif /* defined(__i386__) || defined(__x86_64__) */
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index e03cc97297aa..c03925bea655 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -140,6 +140,8 @@ extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 
 /* AMD P-States stuff **************************/
 extern bool cpupower_amd_pstate_enabled(void);
+extern void amd_pstate_boost_init(unsigned int cpu,
+				  int *support, int *active);
 
 /* AMD P-States stuff **************************/
 
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

