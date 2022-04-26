Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF5E50FE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350633AbiDZNKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiDZNKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:10:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9FF255BD;
        Tue, 26 Apr 2022 06:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA0o+VU1rENNKaT6zH2rTfIk4g9hfOY0hRR6DkiG8Jt3VK2ahi1HFsGijF9u8RBeFPBUDIK0jlyHXjR1AZtqTB9czy+gxwVeTBDm8eKtg9iYikleGUq0a+dpho+D4jNw1x68ePRXRV1jR+pi044g/nEtwS1QhBwn8kWbe7HAs3kZGPoL9w5/HS/Zn2taWMZW5oQdVFXX+x+9BL+LDVwic0swpNLzYJ5Ife33ctQtof+ruWr5tHCgEdidSr0otsDQLBEIhGUQrjgDH/5CFwSLXe2nLbVvItxUtc/CNQsiFjdkO3g3e+3m9s6/kkf5STNP5wHp0XGZLZJI5ryghQhnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhQT6jHAZn451+RXSUApTMeFj2UVgOhU8eCpe6i7iZA=;
 b=gwV2k5XvOYu0wYnxZnVL7K8Q+IrNxNkW5KRtXYy0uAxLhA1UMTVr2LVsAJfgP41QUjkYao8ibnz+cnfp0TnwP0j9+DEU2vUw+lN+pSEK0f04XnzROkUJFMiVR8xDsa6yRwMYIUB1w0ZITLNm5jih3jPcdRG8UnRt8zYX6bUAol4a46/LL+Rq3we5jUsLKYhe8lIqe+NfBCFApTwdGVhapt5QhYa1EgCs+m1+u3Vh1/RdTVOLAGoDMHSfLuQp3nIhWgL8DDHi2RkLH84ErYvZSiWmehbeCFdjuvjQlVhMDX7Af5yK4mI0yfT4IS3kl9/3sRz4DuNbScXz33kgpmmvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhQT6jHAZn451+RXSUApTMeFj2UVgOhU8eCpe6i7iZA=;
 b=lD8jZD1tx4IbVGRbXUR/2NcKk0WfN8HU23BLiBRYJDCg7ZKgdqJeZBwpa0OdFcwgx0Hds91VMi8G0wTi6JsvCc2cMURK5sW+KHoNlmenRnMCjQ0ULMIWy3ob//rs86HjD9l6cGVc6XSmglH1yohbuCtFhCHOmkBrBHvC7e89/b8=
Received: from MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::27)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 26 Apr
 2022 13:07:31 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::a2) by MW4P221CA0022.outlook.office365.com
 (2603:10b6:303:8b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 26 Apr 2022 13:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 13:07:31 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 08:07:24 -0500
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
Subject: [PATCH v3 5/7] perf/x86/amd/core: Add PerfMonV2 counter control
Date:   Tue, 26 Apr 2022 18:35:36 +0530
Message-ID: <5c30d99af03fff90e2fc3165755d18d14bdb229f.1650977962.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650977962.git.sandipan.das@amd.com>
References: <cover.1650977962.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 327e2be0-2676-4454-ed51-08da2785b8f7
X-MS-TrafficTypeDiagnostic: MN0PR12MB6174:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB617456AC1A16C12E9BED77458BFB9@MN0PR12MB6174.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCdTenmQKJPsr4uhXF8gZTsKFuXN0FpB0TnTXAV+THmr5lbKS1MwdLq33SI+8r4nllcoPPpfJPP1gDcYjRSr99qzCqr8Q7tC7Z7c/IYYdMcnZ3GTiTPH8s935rxv1f/WZLUmQpkIY8N9PToVAIhyYDJl29zridjaXR0yg1ZrKMrffDTQidhvFm33LNKMNmpHKq32UpI3PU/n0SCr34p+zofoWEteFnqvIWFlpPrjeJ0fPVUmSxeQE0VZ+vOReb3Fyxf1vqNUEOPbfQ5C0aUo2O4xr4tCGhpuc1aUIDvRa0TBL5blfHRpOvVtJ+uzQsa84a0LLjd+aL+Kv2nu7tQklqTvCd4qtsjCT1qPcazbCEEuVohljVwpOJX5g+ZQUfLqWOqpbRTuJ9UQG4wScn3n0uCRo07ZBHqfSC+gpwS/XnvUNnKt5y+QksZNW1TPBLCFlE50gNVnM86kC38j1vauRHaKlDgCwRjb6N27vl3frMTYBa7svLSCfizu1+gn3CSamLPrzw5kpFIqbs8UP55S42uMzKRZgcChu60V43+wKpuImUicgEUUt0Pp2I4Ph+wnGthO5cZRWmEQaa0c1ikWGS9/WbIErJHQV/Gz5lWPzhffPuNSGpwJ66W8T+6LDjE9xIrvpoAu5ra/1SMx5chVk+qvnOCsog2MzxGgvWHPW8LUdYQK+4j7WGqtfYTb1W60iJ2xEx8xw0YcWAM0KG69fA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(2616005)(70206006)(44832011)(6666004)(356005)(5660300002)(2906002)(7416002)(508600001)(36860700001)(81166007)(8936002)(83380400001)(86362001)(40460700003)(16526019)(186003)(426003)(336012)(47076005)(316002)(70586007)(8676002)(82310400005)(110136005)(54906003)(36756003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 13:07:31.1704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327e2be0-2676-4454-ed51-08da2785b8f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174
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

