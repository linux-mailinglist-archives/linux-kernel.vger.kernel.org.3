Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD50D4DBF8F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiCQGcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiCQGbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:31:55 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD96FA27D2;
        Wed, 16 Mar 2022 23:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0jrmqx+rVmsvLecPT49vFHEhuZ4dLIbNuRgT9WGcg7eZhgYxcX+QqipkgMS+EreJ795p8VvqKGs4VQiGiLOHDfX02GLo6getx9NBHY04wKRC6K40ZTllE8qjVacVMTPwiLff2wa2QuAB6X5j6wxCcQTlTm/FPLuxZJ7l+cZbNAsXu1Ljet2UZeC8VYt2HIOuDz6h7w4hVu9VuiS6mu3hbm7WKXjYRwy+Qo35jH5Z1vP0GWZ6m6O3frKfxx4bkz+jEAxI8DI6byQ8fW/s54Mx+Ogv+/x7CQVuhl53E9aoun9JVNLCestUFjxdWNSnFKt5jqQra0+lMjB4I2zUPO5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPCanE0PeJlHQWtReKqTJwNJaUIyEKG4fN+DeQIB4sc=;
 b=WmSo9fasAp/BZw7klizEtKBMySxZquuAlQJ+pWPa/bTQ9VoV/aXvlPnrxCNML6QXSKyWxFMeZin0EXoHUJgjd5JQE5ucf2P52WTofB/0aMsMCNtN+76EkeKcrDx1HgUBoD7S+EKLMdADM3g0tSxkt8paCq+YWbNj6oSZTbQz+9RjCqt21/3xKkTzjj9NALVEDLXpfqXMmPgSYNtiD9su1fwrIeMEmR3UXjFvlWsGnbIjlXuhOaTzjTpyI0+Lr6BQJ4wsBXsDdKa4IqZAU5ndfGBFCbId0yJzMJTNaovFg5RYMOsYWPk4anpgUbOObFYy9CyjXxJs8RJDrFiwkZMQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPCanE0PeJlHQWtReKqTJwNJaUIyEKG4fN+DeQIB4sc=;
 b=Hfbgduq7quudEX9Kx6lHFggshSdjMzWMB9RC7jyPUo/y99MAgVACODBYr+hBwm7RWzl508nUFfCLQ2Y/p9JoeY1alyT0xIoMPnYkX7eC1v+k6dWThkKnIm1iyyOIO4AQmiNnohESbCkGGTmhVrj11O62SseHZnK8uV2DhDKLhqQ=
Received: from DM6PR21CA0014.namprd21.prod.outlook.com (2603:10b6:5:174::24)
 by CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Thu, 17 Mar
 2022 06:30:32 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::31) by DM6PR21CA0014.outlook.office365.com
 (2603:10b6:5:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.6 via Frontend
 Transport; Thu, 17 Mar 2022 06:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 06:30:32 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 01:30:19 -0500
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
Subject: [PATCH 5/7] perf/x86/amd/core: Add PerfMonV2 counter control
Date:   Thu, 17 Mar 2022 11:58:34 +0530
Message-ID: <7958e729c6be0f682379bec81f115b8cd7cca1ad.1647498015.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1647498015.git.sandipan.das@amd.com>
References: <cover.1647498015.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a23bf401-7e53-435d-6eb5-08da07dfa359
X-MS-TrafficTypeDiagnostic: CH0PR12MB5371:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5371CBB76645A1CCCE734EC78B129@CH0PR12MB5371.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QX928dG472QjgxgRyd+9rNftglPwIiSJdiHMPOdZHrT+5tyuT8hzc71htbONpAvHAdrS8Dwrfsu+6aOodAHHLD5bGDElVkLVtp5INZv9jVK/hrgYlR/wASD/AiE04baqfBqZHDGaxnSWrqOziFjkiuku908JZHa84gMaSrgmmZ3UJbZ2nYEOAUbdN2CrmxpuUmRALtReNeNsFD/885LPjzKM2gva15spEGA+g3RUKsr+o44bbzVFKP91dFtGDxsfoqHAUTCNp3kJpHqVIyUPiS2udm8l5c69kb6s1idliuEU7+GZKWpCHxa2YgdtqgDtIZ3mgrxZhDzfDWs9ilRZ8K/RpBI8nLsv4pugJPszV8v2ziDAho/iubaZPPNZglmFhoHfLuqPdvBs497YJ7U5LKu5MMDqNTESQcn/ZFoT3+Z0m3eWlH/f97hEYPvQHaED5ugVHCsGvSFkReWlzp0y+ECGMSgRk19XmFOe2o7WyEBW/JeL0bQOgGQ5HQoHtOPzf08j9RQ6lCWngkJPUOjxUqTzXFsZ2AYiBk9pB1ji/QVMnrAH1EAmTEP94wBhq7OCvw1HVbihtjbS6zxaXG0w1kvH4XTO/+0iWYgJGP7Vycsexp6h01gRctmopa2cd+GUxg93gHltlrCf4Vjby1mm4ITZD/1D3ciJAncbk6bHKsLpte37i0/Nud7sA1ko/VqWoNORsYv2m3zzfe3rU+abnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(36756003)(16526019)(8676002)(2906002)(70586007)(47076005)(186003)(8936002)(83380400001)(5660300002)(336012)(426003)(2616005)(508600001)(4326008)(7696005)(26005)(70206006)(6666004)(81166007)(110136005)(356005)(86362001)(36860700001)(40460700003)(316002)(7416002)(54906003)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 06:30:32.4901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a23bf401-7e53-435d-6eb5-08da07dfa359
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/events/amd/core.c | 58 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 05d79afe5173..532e9bd76bf1 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -596,6 +596,11 @@ static void amd_pmu_cpu_dead(int cpu)
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
@@ -625,12 +630,32 @@ static void amd_pmu_wait_on_overflow(int idx)
 	}
 }
 
+static void amd_pmu_global_enable_all(int added)
+{
+	amd_pmu_set_global_ctl(amd_pmu_global_cntr_mask);
+}
+
+DEFINE_STATIC_CALL(amd_pmu_enable_all, x86_pmu_enable_all);
+
+static void amd_pmu_enable_all(int added)
+{
+	static_call(amd_pmu_enable_all)(added);
+}
+
+static void amd_pmu_global_disable_all(void)
+{
+	/* Disable all PMCs */
+	amd_pmu_set_global_ctl(0);
+}
+
+DEFINE_STATIC_CALL(amd_pmu_disable_all, x86_pmu_disable_all);
+
 static void amd_pmu_disable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int idx;
 
-	x86_pmu_disable_all();
+	static_call(amd_pmu_disable_all)();
 
 	/*
 	 * This shouldn't be called from NMI context, but add a safeguard here
@@ -671,6 +696,28 @@ static void amd_pmu_disable_event(struct perf_event *event)
 	amd_pmu_wait_on_overflow(event->hw.idx);
 }
 
+static void amd_pmu_global_enable_event(struct perf_event *event)
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
+DEFINE_STATIC_CALL(amd_pmu_enable_event, x86_pmu_enable_event);
+
+static void amd_pmu_enable_event(struct perf_event *event)
+{
+	static_call(amd_pmu_enable_event)(event);
+}
+
 /*
  * Because of NMI latency, if multiple PMC counters are active or other sources
  * of NMIs are received, the perf NMI handler can handle one or more overflowed
@@ -929,8 +976,8 @@ static __initconst const struct x86_pmu amd_pmu = {
 	.name			= "AMD",
 	.handle_irq		= amd_pmu_handle_irq,
 	.disable_all		= amd_pmu_disable_all,
-	.enable_all		= x86_pmu_enable_all,
-	.enable			= x86_pmu_enable_event,
+	.enable_all		= amd_pmu_enable_all,
+	.enable			= amd_pmu_enable_event,
 	.disable		= amd_pmu_disable_event,
 	.hw_config		= amd_pmu_hw_config,
 	.schedule_events	= x86_schedule_events,
@@ -989,6 +1036,11 @@ static int __init amd_core_pmu_init(void)
 		x86_pmu.num_counters = EXT_PERFMON_DEBUG_NUM_CORE_PMC(ebx);
 
 		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
+
+		/* Update PMC handling functions */
+		static_call_update(amd_pmu_enable_all, amd_pmu_global_enable_all);
+		static_call_update(amd_pmu_disable_all, amd_pmu_global_disable_all);
+		static_call_update(amd_pmu_enable_event, amd_pmu_global_enable_event);
 	}
 
 	/*
-- 
2.32.0

