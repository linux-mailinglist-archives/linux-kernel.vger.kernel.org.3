Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF409511657
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiD0LhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiD0LhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:37:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8C23BBC6;
        Wed, 27 Apr 2022 04:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORS+qsUQHWsh1/KfpH3qvgnWCq8p2vNF4sSgtHQHvw036YUU0RzvfcNMfPbpcn6RTY5m0TkmwgLX5bkxUMAp0GPO2NuQqT3ou9lXgTSsG/ynBix/7mtbEZRPPOf1DdGzz16epChXFoJUNk9dY6ejoL+vBxBCO7gRot4ag8t7Wh8nuJvAzlAseqqN+avAtdMAMbN8Rpc0ADpE+eQWM3ImDAydRp1qqcQEAVxyhNCZEVty0QNttLqKpGryyYZNZPJ77zHVEkaG+G0y+oDhLQcefk56kX+IIMDK6P/5n55rJvnLeVNn0XOvDsvM4XpiDdxclpTuGD3cxDLLqqgr/LE09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhQT6jHAZn451+RXSUApTMeFj2UVgOhU8eCpe6i7iZA=;
 b=Xv/7b76pAcPqbMJws+vjFsdNi44fX1Guv1waBdeXSXOrQFRa6MX3JqpXEr4LFWLQa386lYMo7c2TegDXwWVDha/zG8jDqS8Ivql9Gx/9Eg1KzZkPnKg+3aYKfu8RjFOz8eOTD+04vkq/OaMiLHe46ypjFXlec4/qe3E6/m16gRpBCPtYV60Ip39KWsiNU1QLkMIh/2vtQFNhuUGRgqgTzCanZPXYJfhWWZXh+wZKuyUQ99jcIyVg2GvPTU9zKdi2iFAA6+AjkblXuLV8jw3khslbVS3ZgmtZpEvcOa7RLaBokkcTIzCIJ+y+FwpQUFbz65h930kDC2SFkuPhC0VQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhQT6jHAZn451+RXSUApTMeFj2UVgOhU8eCpe6i7iZA=;
 b=tJZhIumfJtRC8LDBNjegYfyyLoV2OL8RLZ2mZYXpUU9opClX8OYoJ0y4jO6fDlk0TLfDOJmDDReUtHjK3g4hkBRwI5SzBe5Fj1gZc9j0bqDYPxKf2ZbCZA6UpNujZg/Jtr8yxLHtcjikY/nvnILi5LBHrNZqFRibFQCdPLNGwqQ=
Received: from DM6PR13CA0022.namprd13.prod.outlook.com (2603:10b6:5:bc::35) by
 MWHPR12MB1936.namprd12.prod.outlook.com (2603:10b6:300:114::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Wed, 27 Apr
 2022 11:33:43 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::16) by DM6PR13CA0022.outlook.office365.com
 (2603:10b6:5:bc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Wed, 27 Apr 2022 11:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 11:33:42 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 06:33:35 -0500
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
Subject: [PATCH v4 5/7] perf/x86/amd/core: Add PerfMonV2 counter control
Date:   Wed, 27 Apr 2022 17:01:47 +0530
Message-ID: <5c30d99af03fff90e2fc3165755d18d14bdb229f.1651058600.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ee46361e-0617-4901-d7f6-08da2841c845
X-MS-TrafficTypeDiagnostic: MWHPR12MB1936:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1936AA3A29A18A8ED90534398BFA9@MWHPR12MB1936.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dt9aa+DdWfiYu7WzB2+DUuwD/RfFaYYYPXcUj6OSw98Q4j48W+wBpdMEX/aWlhvHUaFP+JR8i1uu5p8w1UFWrt6qM4uEzQlikFipIrB9Zp/A6IBmHzMBK3C7a1LaSykCXdNnInJZvFMjTqaFJp6HkJQ+U53xS2ssub9EjEee/9WWEKyGjaT1upXEixHsFrVE/pNZoyFyexZblIcWI8ssrSdkPXw/G9hfYgHCT91SKu8tZl9hWBGiuWXwQrbOazxNdCrcYzTc/S52r/RHymUTmchxwAg9H1xotmkhEP2/2ynd+nk/et2BSbbAThM3pn/I6JpjBIm5JUkTn9D4j6+sObVR5oKZT7j3SA3qoJMpZyNZek6qHSSxwnWfMz3w+t3ImeujZB4Xkmwpg7IqXZ8uQPsdBNgyZOSuveJh89T1M5RHNXfZ8Ii00t8gMTWg4R90FUA6KB2PAuvLtIkj/DkJSkLDGphhW+nMo/PsmI7lYX34O+78oqqcPcThdkwtcFeFBoXHaXeroA+cSdC+aSmf0bMeCbSHjTbsHqPnLS8iv+hsmSlWPdD5kTClSRd41REUhpDP6G/J2rjgsEKg8zJ5AEqJPV9S3CuzEx7GgbBornjQinSBdT3hHxz1ZicaZkBN6R89P9tji9DGriXJcJUN4Yet+CTOzPtzeOuEs/BklhbiXSi+pT1kB5oK8AUk4BlzHFkLdr/OQn3ZolubV9YDEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(4326008)(70206006)(2906002)(44832011)(70586007)(36860700001)(36756003)(8936002)(40460700003)(7416002)(8676002)(186003)(426003)(2616005)(336012)(16526019)(26005)(508600001)(6666004)(316002)(82310400005)(110136005)(54906003)(83380400001)(356005)(86362001)(81166007)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 11:33:42.3258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee46361e-0617-4901-d7f6-08da2841c845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1936
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If AMD Performance Monitoring Version 2 (PerfMonV2) is
supported, use a new scheme to manage the Core PMCs using
the new global control and status registers. This will be
bypassed on unsupported hardware (x86_pmu.version < 2).

Currently, all PMCs have dedicated control (PERF_CTL) and
counter (PERF_CTR) registers. For a given PMC, the enable
(En) bit of its PERF_CTL register is used to start or stop
counting.

The Performance Counter Global Control (PerfCntrGlobalCtl)
register has enable (PerfCntrEn) bits for each PMC. For a
PMC to start counting, both PERF_CTL and PerfCntrGlobalCtl
enable bits must be set. If either of those are cleared,
the PMC stops counting.

In x86_pmu_{en,dis}able_all(), the PERF_CTL registers of
all active PMCs are written to in a loop. Ideally, PMCs
counting the same event that were started and stopped at
the same time should record the same counts. Due to delays
in between writes to the PERF_CTL registers across loop
iterations, the PMCs cannot be enabled or disabled at the
same instant and hence, record slightly different counts.
This is fixed by enabling or disabling all active PMCs at
the same time with a single write to the PerfCntrGlobalCtl
register.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 50 ++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 61a2fce99aa1..5b100a5f8489 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -664,6 +664,11 @@ static void amd_pmu_cpu_dead(int cpu)
 	amd_pmu_cpu_reset();
 }
 
+static inline void amd_pmu_set_global_ctl(u64 ctl)
+{
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
+}
+
 /*
  * When a PMC counter overflows, an NMI is used to process the event and
  * reset the counter. NMI latency can result in the counter being updated
@@ -693,15 +698,11 @@ static void amd_pmu_wait_on_overflow(int idx)
 	}
 }
 
-static void amd_pmu_disable_all(void)
+static void amd_pmu_check_overflow(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int idx;
 
-	amd_brs_disable_all();
-
-	x86_pmu_disable_all();
-
 	/*
 	 * This shouldn't be called from NMI context, but add a safeguard here
 	 * to return, since if we're in NMI context we can't wait for an NMI
@@ -748,6 +749,26 @@ static void amd_pmu_enable_all(int added)
 	}
 }
 
+static void amd_pmu_v2_enable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	/*
+	 * Testing cpu_hw_events.enabled should be skipped in this case unlike
+	 * in x86_pmu_enable_event().
+	 *
+	 * Since cpu_hw_events.enabled is set only after returning from
+	 * x86_pmu_start(), the PMCs must be programmed and kept ready.
+	 * Counting starts only after x86_pmu_enable_all() is called.
+	 */
+	__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
+}
+
+static void amd_pmu_v2_enable_all(int added)
+{
+	amd_pmu_set_global_ctl(amd_pmu_global_cntr_mask);
+}
+
 static void amd_pmu_disable_event(struct perf_event *event)
 {
 	x86_pmu_disable_event(event);
@@ -765,6 +786,20 @@ static void amd_pmu_disable_event(struct perf_event *event)
 	amd_pmu_wait_on_overflow(event->hw.idx);
 }
 
+static void amd_pmu_disable_all(void)
+{
+	amd_brs_disable_all();
+	x86_pmu_disable_all();
+	amd_pmu_check_overflow();
+}
+
+static void amd_pmu_v2_disable_all(void)
+{
+	/* Disable all PMCs */
+	amd_pmu_set_global_ctl(0);
+	amd_pmu_check_overflow();
+}
+
 static void amd_pmu_add_event(struct perf_event *event)
 {
 	if (needs_branch_stack(event))
@@ -1216,6 +1251,11 @@ static int __init amd_core_pmu_init(void)
 		x86_pmu.num_counters = ebx.split.num_core_pmc;
 
 		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
+
+		/* Update PMC handling functions */
+		x86_pmu.enable_all = amd_pmu_v2_enable_all;
+		x86_pmu.disable_all = amd_pmu_v2_disable_all;
+		x86_pmu.enable = amd_pmu_v2_enable_event;
 	}
 
 	/*
-- 
2.34.1

