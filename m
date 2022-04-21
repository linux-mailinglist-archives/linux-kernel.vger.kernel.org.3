Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791A1509702
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384586AbiDUFvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384577AbiDUFvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:51:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F183D1275B;
        Wed, 20 Apr 2022 22:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK2VEOj7LXoRiJMC96O0LNVeUdbw35MJYz4dTMB/o/5L2Ll4fkiT/XRwmZ2gVD9xDIxtsBYNVupKI+kI+Do5ltOND/xkXwJ6f47mO4BS1O0Jbma7nMdR0T9+Ykxzd//zznMo355ygJ8uTU8ZKFInmRqdWmI9MU5USkrWo44GeZFyBxra7XgO95jGnJ/45N85wrHR6tXtGA9oiB059vceWtNoGUtzkzrFw7y+8rPfWRIqKJn1IqVrquOk7EufylYNviknLOQSYu/6lVB0riu20itodmBaJvY1ill0V7Fuppf5s1wLa4rnJAAZ2H1cJfisGJODJQm0yWwny+e9o+pA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqTp8rQytkNZ9pBYVaLEkC05OLsrcBDZBMloQI3XQCk=;
 b=NXoNjiXvHgL6xubsXMgqasK0tU76hcNq75vDpzwnfDpPxAvjV1ZgJt5hqJk7EO5VUFMHxTv4kFnXfk9vP751Qlp2cbdoJxifd7hhHGRWnd8wy5YFZ/ivtAtFwxz8FhCgdv7F44qPaNkgeCZLkgM/jX5lVg73EdVvua9cbnvxkYqhFrXqM6HjNLXjShpIfcRXBchOombxNJcKhGG9UeTgVu9z12QziiaFjPNsxEYoykZfVP5FGXMGJiWGPRvAVZc7cF5btDnZvxz8rODBH+y7M5DWS9VeStZGqc2lVDRRZGhN8BHKE69RDbe4qJRUEPK34Jugt/tEQSc+dspeaS0IyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqTp8rQytkNZ9pBYVaLEkC05OLsrcBDZBMloQI3XQCk=;
 b=vum07Fu26K80w0IlE6nRaz9xHLDl0UwePQq4wf1v33GXeZwGFuvEGiTdYTcN5HMadgzrsJrhDxaWf2LApgFZwaGpoPPt+dPgpV0w1XkE4KSkJUc+VMNk2C1c9yWZIE1L85iIZlaCDFrPrPPFcrCJ+Ci42C6YBUZuMSjgRqh04oM=
Received: from DM6PR02CA0149.namprd02.prod.outlook.com (2603:10b6:5:332::16)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 05:48:49 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::65) by DM6PR02CA0149.outlook.office365.com
 (2603:10b6:5:332::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 21 Apr 2022 05:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 05:48:49 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 00:48:42 -0500
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
Subject: [PATCH v2 5/7] perf/x86/amd/core: Add PerfMonV2 counter control
Date:   Thu, 21 Apr 2022 11:16:57 +0530
Message-ID: <dfe8e934074aaabc6ba748dfaccd0a77c974bb82.1650515382.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a658a6c0-6d9f-4470-3722-08da235a9bcd
X-MS-TrafficTypeDiagnostic: DM4PR12MB5986:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB59866F3F8ADBC5E8342073C08BF49@DM4PR12MB5986.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sx/FLhCc3E7Om3Dg6wV8Mr89sjqWhnaIdfwq+l3G1QuhOhZCvABYJJhGSXajuAv43ZTwnQWOpfSPeUmOQtDn5NQk47OmE23lDaCbR6/PbVm0UGynYmGCbYqPxvPX9UBgALuxHvjIExCfJIqHplH2Ea2z7gKFwJIy1taiJrqRD7UQDSKm77YB+6tr+V+nxZQnZMRYC4xpWKhGuFGVPggzKB0CEKq9JzHoF7YWJ+atf4ze90ojvu/c10M7dFW1m1+iTFe0wUm9xcdKiwSSBjSEHnUWHKbEncr1XnNsHwp+VmEyt7VXLwfF+E7NNolxQcdxPzdOvGECDqJob0w33c468Acgjg41t6Gw0zWWeBr5KrPDkKaUFtliuphafB8ni0kCyBW7gvgifCP5PmyD4+fGD7Qs19zZzl29iFQIh0tbgQPQetG12w2+F1eFxIbrh5Avt39r18GU9WO00nZxpCZ8ArRK2zQjoNBl8YdXFi56MltZY2jz5BmyodROF8NLSfs/bIhFcnFKqOO1HcArtCISuIY+IalagyJh79Viez69GysUPaYAQld2AYj/EqRbpEuuPcje2Y3iSAaPWh7Z0b5evN7YFdN42a2uDAyNvKZ0nxVcOdae2ubJ1OcgeRhuhW2oQk4MXigwe241OdlLEfCQISt+qvf5jXx3pxdKqyTj1UMy5tC5jOrbYChvYyVz8iBjxZJjNcqyRw4bEnCVyP0GoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400005)(70206006)(70586007)(54906003)(81166007)(36756003)(47076005)(426003)(336012)(110136005)(36860700001)(356005)(316002)(8676002)(4326008)(8936002)(2906002)(86362001)(508600001)(26005)(2616005)(40460700003)(186003)(44832011)(7416002)(5660300002)(16526019)(83380400001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 05:48:49.3355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a658a6c0-6d9f-4470-3722-08da235a9bcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986
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
index 52fd7941a724..a339c3e0be33 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -664,6 +664,11 @@ static void amd_pmu_cpu_dead(int cpu)
 	amd_pmu_cpu_reset(cpu);
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
2.32.0

