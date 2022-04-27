Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F46F511655
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiD0LgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiD0LgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:36:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA60F3B3CA;
        Wed, 27 Apr 2022 04:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoXUge+ZLEhyADeGL1qvbToHmeGoS7uGDS+SLSjjXvFhYC5dfFcyxyd93+XUZC0NyScfXdwFMMRXWuiB35GGCGaLpZxM2z06ZxZ5D3VTPQynMzdHxa1cFattbUjV4z/vGEtNXz9+IlzLpcmDOdxgj+LPCjdgmRbQWg18oOl935pG1bd4/TUPpf7lsjj7VX6jO/zTDhSzDmEm+5eb9EihPmbCPJ2mtVje9em6jZNQxsLKW1Fsj9NRJwkn+TecF+yabDqV67DWn8b6cpXKcxOHEXeNlfvHws0xHGQIpm5FNZ0UnnlrJl5DWqwFez0bTTSfwVxYG1NUR5rCKkFsvghgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+5MAzqZznIdQ7Jtgruyhqaq+eiEjTomSvHbSZXympQ=;
 b=Cc2qiDTl853MCWxuTjjNGdkrlBIKQHPZTZkrlZEDzWjhpyOmc3H+ixjysWgMQG4wzbMeSt2qtn/kdJT1Q9fBR21VkVHOoFC0Nv50ipKJyKB5Ngm78QFxm4WMQ+7iL9IyhtM9YrJOi8nOu2W37xAVz9U2WTCsalfI6z0tAlU4gLmhKgurVGODCTABaDRSBk1ct4rvA3JRloLJ0/SdZGeLqVxGQz711GoQyvHTHnpsAofQw7oFT2IBE4f5D/ChlFy225aNzsZBGAwjvhX3gkUXQVnFAQiUfebnjjTgB5qoU9NNT+9Jf6N8C2ajzab18Vdql3Hz0kD1goAGoEsOg+ucpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+5MAzqZznIdQ7Jtgruyhqaq+eiEjTomSvHbSZXympQ=;
 b=LQux/PJ0WsdV1hNrZEORzgNeW882jU6E9fsoxs+ITusYLfjKXDOBGo9DjJiKrxYHcum2TinIzfvL60tJ/B/dgFFvhrp+3a5eo82Bt6p6BlJZJQkqyGYhpqyDq5uuebkJXtCz3kWa7c6rqZxQWApPFH59y+LHfLYRuvVhDM3nBF0=
Received: from DM6PR11CA0015.namprd11.prod.outlook.com (2603:10b6:5:190::28)
 by MWHPR12MB1584.namprd12.prod.outlook.com (2603:10b6:301:a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 11:33:03 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::f8) by DM6PR11CA0015.outlook.office365.com
 (2603:10b6:5:190::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Wed, 27 Apr 2022 11:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 11:33:03 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 06:32:56 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>, <puwen@hygon.cn>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 3/7] perf/x86/amd/core: Detect PerfMonV2 support
Date:   Wed, 27 Apr 2022 17:01:45 +0530
Message-ID: <8d3e23760726cf6647a98999e1fcd12a37f36a42.1651058600.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651058600.git.sandipan.das@amd.com>
References: <cover.1651058600.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ae801b-8677-4eed-f33c-08da2841b106
X-MS-TrafficTypeDiagnostic: MWHPR12MB1584:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1584E10B77DBB1802896C5168BFA9@MWHPR12MB1584.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QgFWe5GROJAKQer7AA7z/bzeeufsEj18I5zrrEZc6VI9nInGZilQSSPOSn415I8/QNEEMs5AR3PeJy909lFzM/4PytQ+McdEmbCez5mVHxT+aZLwidlwqERbxYjMV30b2vQYrGuSZglxyrtZOOYAL++VSH5J86+tAF5jGfjbbGtdNtGv40kXRmYQAK1Pu5w01goxWAlnAaUP5msxyS9K1vlwvtJVjaL/E+SuiGcEEg50k0WvXfZsIvl+g8v1b04ygRRPaAmrbl92Jr7Zy/FqbAHHlzwtQxP7sOgQHDetLlPNPVeUVOxyRU90D8LE0xPuw64DxYFsPYEjXmlNSRO729U9nJjYSC2Dpeb2ouCBB9+fW2u7r/+z6+CABiWPQj5DnQoOuZnK+Z/m7X+qOhCVr1qN0QD7DW9lWaRhoJKJNn2Xy6l3satSqKVYyh2yPoIZQJgHuw4u7jJRqTM10ID0QC8YyJFeDjMZkxNZL4xOJQyf15GASHMrH2qNWBerWWQV6eO8wSKXJtUBbfdTf5wAs7Y89fvZrBJAMR1vJK0esyfhUDYJoHW7x8ZvMcEhTcaDBbrakoYKZpcWQXrizIbL663oxrBiBlSC/5cCUOkvHP50nDuHtnTJhn+ISlpUzx+k1e+phYFvW6I5GLngM5SaSyYMtpUNxH82up9ihbmuEwdD8aIYdwCsDXpe+WBoP7o5Wma8FzwZ+jitLh9+H9Dvdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(356005)(7416002)(6666004)(8936002)(336012)(426003)(16526019)(186003)(40460700003)(47076005)(86362001)(81166007)(54906003)(5660300002)(83380400001)(508600001)(110136005)(2906002)(44832011)(8676002)(82310400005)(36860700001)(4326008)(36756003)(26005)(2616005)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 11:33:03.3417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ae801b-8677-4eed-f33c-08da2841b106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1584
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
index 8e1e818f8195..4a61257fc58d 100644
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
 
+static void amd_pmu_cpu_reset(void)
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
+	amd_pmu_cpu_reset();
 }
 
 static void amd_pmu_cpu_dead(int cpu)
@@ -644,6 +660,8 @@ static void amd_pmu_cpu_dead(int cpu)
 
 		cpuhw->amd_nb = NULL;
 	}
+
+	amd_pmu_cpu_reset();
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
2.34.1

