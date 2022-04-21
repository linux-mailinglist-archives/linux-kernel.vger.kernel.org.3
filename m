Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBAA509705
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384565AbiDUFvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384564AbiDUFvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:51:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D04B12AC2;
        Wed, 20 Apr 2022 22:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoLJUbfxYMhnQc5rOxdz5fjOvKX5q+cplw6toa5begrSqmdxpoAigLDPUFCom3u+Ubom0FAwOw3DQkuofwjHsgLWLgkwGL0gqG1qlxURQhnL9A2MyJSZlWgEof4YYQx3PvAkpzADYbv8frEPY2AzYg/yuQGGCO6wKZuVfjg5EZRz1cDJiOgTX2l8WUlvmrdi62rbJ1SVaiKs9NcSjhj2xKITF6fftINeZGlhE7QgnKnJx/efn9ayI/cf3UyQE4/NhfIJBLNRud4ly4QykN5prvdCrHV7hHsALz69vUMQ92t/931WVm5CPerMMuUFCbTnPQt5Qk+jlgKgcan93RS1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g46KbNfYuldnStK3msgnxdZT7nDoRcIesFsAkCzbtsw=;
 b=O6MadGnR+oSYFRkrY7WKXKMyp+sTvmY7LnU1iuqJxKlzMB2lfkz2RlYd9GfyYHpnbrP9gXL282JbaEkWqh4gn0gVZVfazvU1j2R2wKy2pSCWlkcHzZv5CzHnb+N3CIlxk9ixunm+aQW2I7Mvxi36L27jlWwI3GI1Swa8ot4ThbfBXqhkPu9gOOwtR4CELKRApbgQ8cZvkiQcO3WR9h9HiacodimoVEEGfyS+7Ztv8JCVzrqrEnoT0kIHuIw+rWrXrtXB3IX4Ot56VPvd3GULurqsQVH/oIxm3Ak8zL5o3WS6vH9FOezI8R5uA5BuOBmo4EQD0O7Bv32GTENek/F7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g46KbNfYuldnStK3msgnxdZT7nDoRcIesFsAkCzbtsw=;
 b=D3AapoGEARHcJXiobRq023ku3+XOZUcEwsYXexhcIclqoix89g3sr/6QTZYSCqlmXYYPnQfQDKSIHIpw3kOrhUiRT+aZs3md+67jJRaO2MTx0R7fYauBSgedbvLve0YAzcypw49bkzztwAkhuXl+qsZwkSPWglBQdp1h0QvehrE=
Received: from DM6PR02CA0129.namprd02.prod.outlook.com (2603:10b6:5:1b4::31)
 by DM5PR12MB4663.namprd12.prod.outlook.com (2603:10b6:4:a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 05:48:11 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::52) by DM6PR02CA0129.outlook.office365.com
 (2603:10b6:5:1b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.21 via Frontend
 Transport; Thu, 21 Apr 2022 05:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 05:48:11 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 00:48:04 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 3/7] perf/x86/amd/core: Detect PerfMonV2 support
Date:   Thu, 21 Apr 2022 11:16:55 +0530
Message-ID: <dc8672ecbddff394e088ca8abf94b089b8ecc2e7.1650515382.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1650515382.git.sandipan.das@amd.com>
References: <cover.1650515382.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44ff462f-a18a-4e8a-2a66-08da235a852d
X-MS-TrafficTypeDiagnostic: DM5PR12MB4663:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB46633E6F94784800116863E78BF49@DM5PR12MB4663.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcIjKXcKu+LmVtWEXSj7H4NkW6f6vt9rH1TpVGHk+NLTXbv2XeUCowAbjSqf8QWxSliCqV4IOMH9fo8Ho07EfpUTeNk69LSsZjuhpnq9PeZE07nNQuiE7YTb7W+HjUzJ7e9nrjz7Kj3+CdkmrIdScjHc+Gyz6vF+EmxMmpXWmmz1EvkhvTbRNkhqplApSeYx0JkOZoTbbSS65GouwmKFoqmj+Eao3hvAH6VUlriyOYgr24/vt3XetXfHNlU+jl730rJ4lrzaOPrLQaupBRuHrmkglkP4HEM9nynk8MgLOWoQ/kD3jS+PyiYFPBUgbS8xM1WUmW2ap8mcKeiHZFalRgsQeb74UuwmRGEskGH2SZ14M3yaE5EYHJV//jw9WK1IElfp5qRrftuQbVFT0bnsyao1k3CSxRcNfSXNEY54ibYZgUXRqG45cfGWNyxqXa6QOimpH1gjXGW0drpHGk3TPXEAt+z/CFoQXQGA4oUfTqEvJbxxjBeHS6eUGRh6LheufKdLsDB6AQyw04gZEbxLFTnt88a53OWAW/SKYdThfOlCEdgQEPN+NHjj0gT7OGrlp+tjKnYjd7BDXpBZmHshfpCrgAj+JJv6JaIDVJfiP3XWar447RkhmkOJ+L67Lis9oM4a9Eb+qN5ldlioGOvt7RVKhrX6rpUMYeLV6DCFe8K80zUxMoDiK/Ld3OFPUgYqJsnXEU9nzrUCcHqL/xNUkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(26005)(356005)(82310400005)(36860700001)(47076005)(40460700003)(2906002)(81166007)(83380400001)(426003)(316002)(508600001)(16526019)(86362001)(8676002)(7416002)(4326008)(54906003)(8936002)(186003)(110136005)(336012)(44832011)(6666004)(5660300002)(70586007)(70206006)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 05:48:11.3767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ff462f-a18a-4e8a-2a66-08da235a852d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4663
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Performance Monitoring Version 2 (PerfMonV2) introduces
some new Core PMU features such as detection of the number
of available PMCs and managing PMCs using global registers
namely, PerfCntrGlobalCtl and PerfCntrGlobalStatus.

Clearing PerfCntrGlobalCtl and PerfCntrGlobalStatus ensures
that all PMCs are inactive and have no pending overflows
when CPUs are onlined or offlined.

The PMU version (x86_pmu.version) now indicates PerfMonV2
support and will be used to bypass the new features on
unsupported processors.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8e1e818f8195..b70dfa028ba5 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -19,6 +19,9 @@ static unsigned long perf_nmi_window;
 #define AMD_MERGE_EVENT ((0xFULL << 32) | 0xFFULL)
 #define AMD_MERGE_EVENT_ENABLE (AMD_MERGE_EVENT | ARCH_PERFMON_EVENTSEL_ENABLE)
 
+/* PMC Enable and Overflow bits for PerfCntrGlobal* registers */
+static u64 amd_pmu_global_cntr_mask __read_mostly;
+
 static __initconst const u64 amd_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -578,6 +581,18 @@ static struct amd_nb *amd_alloc_nb(int cpu)
 	return nb;
 }
 
+static void amd_pmu_cpu_reset(int cpu)
+{
+	if (x86_pmu.version < 2)
+		return;
+
+	/* Clear enable bits i.e. PerfCntrGlobalCtl.PerfCntrEn */
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+
+	/* Clear overflow bits i.e. PerfCntrGLobalStatus.PerfCntrOvfl */
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, amd_pmu_global_cntr_mask);
+}
+
 static int amd_pmu_cpu_prepare(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
@@ -625,6 +640,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	cpuc->amd_nb->refcnt++;
 
 	amd_brs_reset();
+	amd_pmu_cpu_reset(cpu);
 }
 
 static void amd_pmu_cpu_dead(int cpu)
@@ -644,6 +660,8 @@ static void amd_pmu_cpu_dead(int cpu)
 
 		cpuhw->amd_nb = NULL;
 	}
+
+	amd_pmu_cpu_reset(cpu);
 }
 
 /*
@@ -1185,6 +1203,15 @@ static int __init amd_core_pmu_init(void)
 	x86_pmu.eventsel	= MSR_F15H_PERF_CTL;
 	x86_pmu.perfctr		= MSR_F15H_PERF_CTR;
 	x86_pmu.num_counters	= AMD64_NUM_COUNTERS_CORE;
+
+	/* Check for Performance Monitoring v2 support */
+	if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
+		/* Update PMU version for later usage */
+		x86_pmu.version = 2;
+
+		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
+	}
+
 	/*
 	 * AMD Core perfctr has separate MSRs for the NB events, see
 	 * the amd/uncore.c driver.
-- 
2.32.0

