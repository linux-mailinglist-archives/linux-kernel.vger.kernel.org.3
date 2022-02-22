Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA64BFCCF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiBVPgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiBVPf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:35:58 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0103163D52;
        Tue, 22 Feb 2022 07:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3nc5jRUm/RvsRc/UKoDoYBwUiJM7HrSW3p6MVUslnZSHm2j80zOVh9J4/fDpXUZTO4VMowyZ7zDtX46Pdj/nADnhBeAVYH2n26fgFt9R4DxgVp1RiLQFAd6o7FR9WDht0VMYz7X0C12P3sK6CXWtiR+cPJDakBS9tsYMRtiKvM4AdHLlsvDS2haLaSRdJk/NsG6io5twek20loC2HKS7c8DytVXaqKgDqqku/xe6R9vPQnaclJa4WdqEVJuvlhmN41S1Nw+REruNHjgcv5bHzudJk4l3mFV6TdXpc/Zrkz5WM2Q4z0XvoGwLJUJn8M4lLuzYzLAa/5r5sQrx6tolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uz07zVC8cj67pjbnl/vi8YOpJrgczM0tkZce7Od41g0=;
 b=QI9ULVOQVQAUjAvotEdInOLJNZXC3RxIepIGf2MPUDw9Tk/BYgMkatVkc1hXnnjW7dAYzkg8pirT/SZHoH3G6/sSMrTdDjWockZxYnVOh6AI3ENGXRXc9NOxcA5EBBkBtSf+90xDI1Yd4YIlSlkP9gz2kIkUSEZCr96b0Jf+vHzpIiDBluBTejLM7bw9YY23A11Rpx5ASzFVif5p1CX2nzEMVlPW6bw9OdWcxuGvaIsu9aHXh8Pv7iALQKiy0cX6KMygmsWKc88xiaP2PgS4s/SE1JL/gViW5UvCGFiV9XT7BabcsXsK/V1qtaDCJ3uhRExjSLtWPouuSZx1+9OhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz07zVC8cj67pjbnl/vi8YOpJrgczM0tkZce7Od41g0=;
 b=F1uEMyG5EMgxFCAx1iZkoV5QDq+9sFWujbnGsvPI0Y0uw4VLLCqUzTClzUXlMtW1FOizitTf2QXLP4bI7X1H/tgNS8iWYAL9XJLmtradt5maR8TgQE2WOWiZWM4CPBFA/GMtQpkqmRmHa/SoZ5Wpuf9aCBcpdJPXa5Y+pJyq10I=
Received: from DS7PR03CA0090.namprd03.prod.outlook.com (2603:10b6:5:3bb::35)
 by PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.23; Tue, 22 Feb
 2022 15:35:24 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::39) by DS7PR03CA0090.outlook.office365.com
 (2603:10b6:5:3bb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Tue, 22 Feb 2022 15:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:35:24 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 09:35:18 -0600
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
Subject: [PATCH v7 07/10] cpupower: Enable boost state support for AMD P-State module
Date:   Tue, 22 Feb 2022 23:34:23 +0800
Message-ID: <20220222153426.2216974-8-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 97d75fcb-6ec3-4c7f-55cb-08d9f618f1dc
X-MS-TrafficTypeDiagnostic: PH0PR12MB5498:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54988F831C63FE9482862D62EC3B9@PH0PR12MB5498.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rimlLIZvF6zof4QmXPrMhxJTG5ZylgxfW38QvURCKhwffBr3sWJe5I0pYknYHICucJfQ7zLH61InUSSNwEV6PAaDiqX+spaZEULqy5hum6XRifkwIC+wU8sm/0CIyB0nSswzgQFcAD5hYN1JZAQwSUmvT4j1lhT1m4USCHI4l5pBlVG3GRPM/7KBVKFgKqWT9tvVfPr+VSSc128m/vVuQ/MXtCVLT4uw3zdiEzP15UpGGVfW5+bPW3CCHYTeaIyap6wMFULpEaVQ/rc9eMtWOKW82bboR3VRjWids+g2HsaD7hP3D2qwecpL8+zdC/s8WmMgWJOggcqD6WbKarEETFGKijVawt1xTDlSLi1Z/XgTu8oEfDZM9KlEpqQi2kpuHLgEKdYjl/BQ1AcSH6TAjlZ9A580ukBlohDygKLXSuOZOw2f1WkKpJHJlf2ePfq0R+IOJ+NSNbP01A3rwcqHkQcaHJfCd2KpoIlWtlDE0N5eUQzr70khkSX1gBPC05FiVqkoZJYA0CSBntKqjLuuSCVUcqVD87ZTKVqmwMEAZHbJtYTuAFuOzRjlR00F5PBxza6BOhYTHHD/9RPSEFvtlxAU06qFtdDqvItWw4T6dJ9/unazNhIo5kbMtp0rHl4HdwRPE3S6k0YWYw1hz+OLszzrlaB4Ytt40W6EQq1CzZw82yez3FElGzUyUwjb0NYwXIqSG25DRiAGdEXr7qW11A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(4326008)(82310400004)(110136005)(83380400001)(70586007)(70206006)(508600001)(336012)(8676002)(316002)(426003)(7416002)(1076003)(8936002)(5660300002)(2616005)(356005)(6666004)(47076005)(36756003)(81166007)(7696005)(26005)(40460700003)(86362001)(186003)(16526019)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:35:24.6095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d75fcb-6ec3-4c7f-55cb-08d9f618f1dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
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
similar previous P0 frequency is mapped on nominal performance ratio.
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
index 62771a086871..326491e11c6e 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -140,6 +140,8 @@ extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 
 /* AMD P-State stuff **************************/
 bool cpupower_amd_pstate_enabled(void);
+void amd_pstate_boost_init(unsigned int cpu,
+			   int *support, int *active);
 
 /* AMD P-State stuff **************************/
 
@@ -177,6 +179,9 @@ static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
 
 static inline bool cpupower_amd_pstate_enabled(void)
 { return false; }
+static inline void amd_pstate_boost_init(unsigned int cpu, int *support,
+					 int *active)
+{}
 
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

