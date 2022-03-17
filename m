Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF134DBF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiCQGb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiCQGbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:31:08 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EBD9D042;
        Wed, 16 Mar 2022 23:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z35ZbMjx5AfAl+Ud9MHs1yy+wQj2alM928iaybjSmtTzBY/6T1OiI/UbwOjaefDDMuE9BTqqsPUXAWBBVre8v91FIqKzdZ0Q+YjqFwPs7L82DyOZLm4m4fKSWCVzwMFDQAmQ8UNUrSWjdeWM6fNh3o0/jtvtkm88xuBLpUK8nkfSwoD8O9XmxCn4hieM3JbWfavPoa93GcNWbFoDzWjB8tHDMfXbVvYVZhU3bXKkHQzzW4BbZ+aP5MXNX9Q85JZXlwY7dwdmZQ7edQem6xbrNTzVTimpqIuMG/TAWFDhPaXtoRMOE3+jEcglPcU6/qssC7cOoyMC+9jRkNTtipxpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPvXKe2/tGIJP0TCZFJufwtJdhTq8I8rcIksYpfMgRo=;
 b=HOUlatSt1ueeEs9eoyJN94Bozv4nMgH4tqfFehkz+hT51GKj0LltoBX0g9Ws7zo4osfrMyfaNSw1m99sFoSUzu+jxjISB6omhZzOvKGB+eUbaLYo37wkloVd21dbTihXdnhlWSkbciJktnrwiqWFsRtYEfzkEA+qp4n+OomSbSPKj6XUF5vVtI7ZQ5EbddfPWOglhfpkuCkyQucjcRwVHCT5ngWgdkzX320GCcG1pe4eA+3AVBgt4UfhSDTs67kqxpiYarDy75I6udlMrWUQTxc66eP8Mdvnz3LUuvBOE1WEIeAvo21TZAhai6nYOzLiMQ/1Cogqe2wghoImpkhD3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPvXKe2/tGIJP0TCZFJufwtJdhTq8I8rcIksYpfMgRo=;
 b=IRyqeX1lTn699NMxVTlkPCo59WjpQLjIC1Hk4Mk+UTURMLhvvWM72huxpoJxEnZEbMyKPuAl5VcKwMfqu1EY5v+dCYBXcGO5BFlpOV61gKlolLduI4DR78F7V2RH5PNj1FEmTf5iTRNtaUtQDbBVstzbzJ6uwm+RNge0c8fOTZU=
Received: from DM6PR18CA0020.namprd18.prod.outlook.com (2603:10b6:5:15b::33)
 by MN2PR12MB2925.namprd12.prod.outlook.com (2603:10b6:208:ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 06:29:47 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::3f) by DM6PR18CA0020.outlook.office365.com
 (2603:10b6:5:15b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17 via Frontend
 Transport; Thu, 17 Mar 2022 06:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 06:29:46 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 01:29:41 -0500
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
Subject: [PATCH 3/7] perf/x86/amd/core: Detect PerfMonV2 support
Date:   Thu, 17 Mar 2022 11:58:32 +0530
Message-ID: <1ddd003765ac0d057b2137eab869be4ffee69473.1647498015.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3766cf94-41dc-4aeb-5b1f-08da07df8834
X-MS-TrafficTypeDiagnostic: MN2PR12MB2925:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB29252E508E3DE22878FA26968B129@MN2PR12MB2925.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yF1UV/XFt/5MY6QT/MMklPd2lnoAls/HPWFP1fdtlhpIO3vjHJasE47Y9+mgo7PfPsEHO1XNkU/TDn3Y0GnpmDkT7ae7JDjfBHDfBqfOwXUbLo4VtLQoFUlp3VGzrwxi6Vjc95nwr/Oz0zwMg6SHa+nZjv4XG9495fIEmSo57bIaYBEc96g3JqkFoVoJoV7F3uXDLaW3MqWGMwgjRwiozgmn9xE2bWeFxh+FHKmtEN8ztpB3otbUFE1vghAAFnWDpXhPqlWWyLtHmVe4HGPTJHbbEyBEJw0forAtD1MopE+LAmC+WWc5aj7NZ8mo5OnZp3W4C8pU6oNtVVWY6bBsxx4da4lV9q/sG1erUYws3AVHQ5p0Dw5Igno8jgDSjmvr7ebs3AQwNqJW9QXwZBoiPtWjNiWJX2SdGlA4ST52p+u2cg2/Y8sxjg5UPY5A1EKuXa+8m4n6kcM67zeLYTId0Tq0tR7XqJQkFkfHNStKNdnTenbrhMP9KkZFr/5xHvmDYSM2TEy3hXLbzENmvdMuKji/Sv/9JaPXBijGVpT1pKLZ7wQwUU6DwXC2ZvjXMNQel8eyPQ7n9deGSDkeZT+QCdOBiMqWaoXQuGQgDMAgXOhUcdK5yw4bVvPY+bAaDvwlOoeCCczwfsBWoW62vcgJ11Q6o0YYOeBNJElUdbYKl23Uoqs0FlUIrZNiEz4GPQbMdJdTLM9KiqNNdCnFyxW7zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(82310400004)(40460700003)(6666004)(47076005)(86362001)(54906003)(7696005)(36860700001)(110136005)(44832011)(70586007)(316002)(508600001)(70206006)(4326008)(8936002)(8676002)(26005)(7416002)(186003)(83380400001)(356005)(426003)(336012)(16526019)(81166007)(2906002)(5660300002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 06:29:46.9486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3766cf94-41dc-4aeb-5b1f-08da07df8834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/events/amd/core.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9687a8aef01c..a074af97faa9 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -18,6 +18,9 @@ static unsigned long perf_nmi_window;
 #define AMD_MERGE_EVENT ((0xFULL << 32) | 0xFFULL)
 #define AMD_MERGE_EVENT_ENABLE (AMD_MERGE_EVENT | ARCH_PERFMON_EVENTSEL_ENABLE)
 
+/* PMC Enable and Overflow bits for PerfCntrGlobal* registers */
+static u64 amd_pmu_global_cntr_mask __read_mostly;
+
 static __initconst const u64 amd_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -510,6 +513,19 @@ static struct amd_nb *amd_alloc_nb(int cpu)
 	return nb;
 }
 
+static void amd_pmu_cpu_reset(int cpu)
+{
+	if (x86_pmu.version < 2)
+		return;
+
+	/* Clear enable bits i.e. PerfCntrGlobalCtl.PerfCntrEn */
+	wrmsrl_on_cpu(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+
+	/* Clear overflow bits i.e. PerfCntrGLobalStatus.PerfCntrOvfl */
+	wrmsrl_on_cpu(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+		      amd_pmu_global_cntr_mask);
+}
+
 static int amd_pmu_cpu_prepare(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
@@ -555,6 +571,8 @@ static void amd_pmu_cpu_starting(int cpu)
 
 	cpuc->amd_nb->nb_id = nb_id;
 	cpuc->amd_nb->refcnt++;
+
+	amd_pmu_cpu_reset(cpu);
 }
 
 static void amd_pmu_cpu_dead(int cpu)
@@ -574,6 +592,8 @@ static void amd_pmu_cpu_dead(int cpu)
 
 		cpuhw->amd_nb = NULL;
 	}
+
+	amd_pmu_cpu_reset(cpu);
 }
 
 /*
@@ -957,6 +977,15 @@ static int __init amd_core_pmu_init(void)
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

