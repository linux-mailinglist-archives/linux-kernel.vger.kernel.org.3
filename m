Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D275350FE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350564AbiDZNKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350644AbiDZNKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:10:04 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F33BB1CE;
        Tue, 26 Apr 2022 06:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICs7W16nRL5jcnAVeoXB2MSuDFkLGZ1Dicr+dZD2p1cKoVQ9gSOQBZ7NBWlWijt7SaiAPNDwycpCkNtaxgnDNxO+gfFkWTRbN05Hqk51nZNV31F+U4/HG3CtZ4W5uP2PDUBEmKRVK2PDZINolwJVtyf3WjmRaBWBFPIWdYnfqSwpAwgE51/EvdAl/Hg39HfMJzUe7Nfk8nBTHh4kuiTDwlsvUvPD8EnmOJVCbwDjxqCXmVRkLxoWDr3DAwyMNSrjbCDXXeG4wLFiaUNNXytU3OWUBSmxtGBTRIM7sEaUh3Wul1Vmd5g6c+RUjkeMBxT4kTEwFFQ8DDaEhmcjhPIIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+5MAzqZznIdQ7Jtgruyhqaq+eiEjTomSvHbSZXympQ=;
 b=VqMqqpgdKCnGXqnFyc4p73J94KY65Mtix30geK6GTR2P74TLJmUQJQgZAUEX1dh6E7EDiGltNBYNlxCoEFz7tw76WRGmoNhHp/empy77x4/Xi4t5uCxy/Ibq4PTUMNibg3jyKA9AsKNynaf0LvpAFkUMh2+0mb9akSpTnRtTqqMgrKlYnoj3qm9IrViEMptnwA1Jd1vk7g4BtQ4HHODWqpnQc5jPS7X90T5vcgfhuMnfqkxA87zwuZNPtQAd54G2DBozTCJMsSiJtmWHkOvfYKJa0bLItPvYtQkOBlamngyPjxv1Cn7IajUYe0HkYAF8t8jSD75ZRtKUY4Qljsa+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+5MAzqZznIdQ7Jtgruyhqaq+eiEjTomSvHbSZXympQ=;
 b=DSjNLojxwUPQc1qlPKZ9N147b1mK+1RFE/wlKbsae3j90dozp8JgTr5omxe/pA1cR2rLxiq3icHrHLfrsbpZzUkKPuow4JHup+qqUwthChL/vTtwKEYu/1B77EfXzNAs134C69pXKC/eSAVYKjII8rso2oyqUXSS1f3YgG4kLX4=
Received: from MW4PR02CA0008.namprd02.prod.outlook.com (2603:10b6:303:16d::27)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 26 Apr
 2022 13:06:52 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::18) by MW4PR02CA0008.outlook.office365.com
 (2603:10b6:303:16d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 13:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 13:06:51 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 08:06:44 -0500
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
Subject: [PATCH v3 3/7] perf/x86/amd/core: Detect PerfMonV2 support
Date:   Tue, 26 Apr 2022 18:35:34 +0530
Message-ID: <8d3e23760726cf6647a98999e1fcd12a37f36a42.1650977962.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a48a6287-caa9-4f99-c06d-08da2785a17d
X-MS-TrafficTypeDiagnostic: IA1PR12MB6234:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB623487C43FC23C9804A7B57D8BFB9@IA1PR12MB6234.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eqf5F7LZx0aRx2Jx7NIyVhfFiDm7K0BF1S3m3pdKpwVy7etmufgcJKTC32TZGVqFHEtAB6HYVlKKJLtNOb3qgP7rm5kvshvhtHRGAND2J4WfyUBHeInbIizI9w7AcAxbUn/ba0S/HeKabOQNySYVksqHjtv2IIXyxSKwq+zzl9RlmwSZS+ZOT81kNDSnyr3mdqL4oNLo2BezMMqhIT24IfR8PP82t3/obyQZvRMh/XaEj5gdW2nMb695GJP5MTyVak7W4F9CIW2vY5SynYhKHwW0b0PSCcSaEW3rIZmop4MnMZrl2E/1ZgfjQK9QyFcrgs3XDamt4Qw7aUKf/bYMe7RhTLD8rj0vI3yC7EcWFUN2jkHi+dACSlHTmAEf5ao7oySXdxzjK6FcmFjM18vZ6EyHblAKnMdxXGmW8UQc54ZsnMEGnxVHktzhjVNBr/k62FXyGiGdeosmU7SMrGGb5MCpYLl+Mq+pfWnbJ1NyxT7Q08+p56+z/eTPFK+F/08nMr1ZKKu+mKtcjG9lu4A38JUBLOFk0PZ2wfUDE0wS34U4d+zG0Uh06HOwa4dfhVLt9gChz2WgtnGO13xnxfYXHyd/xKe3Sy/mcLPk3bBlSmhQdGphT4rU4E4srT370O7B95pGwV5JnQ3rKY+T+EYWtE0nJpOxPPO476j1Zn3bxHeW5/ZU8I23uXJI7IQsa+8s2JnhGTLZL1epzdg9oGJfMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(7416002)(316002)(6666004)(47076005)(16526019)(8936002)(186003)(86362001)(426003)(336012)(81166007)(5660300002)(54906003)(83380400001)(2906002)(508600001)(110136005)(44832011)(8676002)(82310400005)(4326008)(36860700001)(36756003)(26005)(70586007)(2616005)(70206006)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 13:06:51.7978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48a6287-caa9-4f99-c06d-08da2785a17d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234
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

