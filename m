Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B55A5096FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384574AbiDUFvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384572AbiDUFvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:51:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17FB1274D;
        Wed, 20 Apr 2022 22:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glkd5GmXtSEYEWAaU7aYw4q6Ksc8QRDsaeG0Wo/Js4HalUnjDgoeB8LbxfYCEruetqikLk/EKol/EXZpbKiPp16vwEHc2IlJ9X1PPIvjplZmEO/ZDpK4IIaimlbDLkEzJ4FQ0oYC+xmW/f0XsTRe5cUrZjdKL0Hgxv2kUOD8RfxQe7+DOFpg8IGPgubS5skfo5mLYnKNgq6QoCDhnaw0oDa5tcDATJd+pX1EkxlrVondKhtgl3d3C1kVWgSpfz0TU8VWxANM7eUx2VwVUs/snagI1KCAbI7GQBqvCIYzLe4/4CJxjdeA5/no4nxIAXTS9sk7f+7L3Fp1QysaUXOhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajI3Vjn+MotcW5xIRn7CWpdnXD0uXDyBZOhI5ao497Y=;
 b=DwnN+y+23t431XGNM/BSbZ6YvOCy5R7NOtkUS75XbTMWcTVTXQF+UuyaOytTlzIJoMuXpZ52IM2qss4sLahU9YNqD8E0DdfrzdVOQ/OMaF8E7YtlQ/x+II5pHOnYy7unrw0nBs2BGZvfBkTWjG7ds8enA4CMYXsGKlVtc+q3BC3+eMkpSdKJ08Z6RV6DRuXYwNTp7PJaTuXe6dNPRhxUSo05zY7BcbGUEYuFz0xaUv0N29B/pKAWM0H+8wuY+DYubHnBUqcBdvgeXLDD8fuaM1SAysfmv0ojDmPiP6U0gHg9T1IQ9dsdvVksGkvISIu3M/VuJVHoYHvCIre4aC1H2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajI3Vjn+MotcW5xIRn7CWpdnXD0uXDyBZOhI5ao497Y=;
 b=2hSRrtZJMpafwT/Zd9Jst2xveSsjtjjM5HnkIbJfagJ1OlpG5QTEYFsYIJJOmqKiAwllUB4A5OY+GO+LMe5yLniuyHXfHGvsrqGQ5jHRYlusWIu7y1oKd/yHoSTnYcJ3PdLBjk1h0i6MJKQ8YSsF3hjPhazN5a79EL4Gm+nzJds=
Received: from DM6PR05CA0065.namprd05.prod.outlook.com (2603:10b6:5:335::34)
 by MW2PR12MB2348.namprd12.prod.outlook.com (2603:10b6:907:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 05:48:30 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::23) by DM6PR05CA0065.outlook.office365.com
 (2603:10b6:5:335::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 21 Apr 2022 05:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 05:48:30 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 00:48:23 -0500
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
Subject: [PATCH v2 4/7] perf/x86/amd/core: Detect available counters
Date:   Thu, 21 Apr 2022 11:16:56 +0530
Message-ID: <68a6d9688df189267db26530378870edd34f7b06.1650515382.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3890f804-119f-414b-7daf-08da235a9078
X-MS-TrafficTypeDiagnostic: MW2PR12MB2348:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB23486423C102EF411EE5E22C8BF49@MW2PR12MB2348.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ukAGNC0rbLxmRm25SuWltuXvBp80d/KyDR6pqCE0DPNIpGtcIVsLh1hRkYbztYCcBNxoFczvPvutY1IbjrTVOU1oELpnzB4qr2PjDPm074Bpm1uIvVR4hcV0xtUlhSHy/VZ07SJ7rfEGDdA9E5UlYfmGuYOR0GR+Km4McyekT79PYntjSbQBqf4aulUQphD+3p4jW7cnwyC7O2Tpwq1vP2E0UDbbrTX4SmBn+98GGrApew35o5eqwYOZig4un4WpX02mvszeRq/4lGiS9FIHR/IJlRUh5WQeLNpxGLdhdHb4EX72pxnpAU6v+Z72RYR6nquF74qwoHXU1s+1Ar/jJExdVG8kgIV8LOAt5wZgIBR/uS9+mhwaQR5N8dS+YwL3BpUK/dToLEGeh9l3fenDE2LcQ71ezK/084UqnYgL4C03wXwUdlnHWeXYrwMcuWcYkM2faO41IKmZA6C/kSRrTLfOjp4fFUppzDBg6BpdcZDZaHNYOJ+8BhY71LzqWYG/sXURyRmzvylPkcnrMVw1uClqzoPgTDlR+aqbETJ9p8zdvaFTYGPi97jzK5VoWC7EY0PBEFcdAVatYrM6FyYmC0R9Lo0HwAPzauHKbfe76UI28dqfjgSTEnpOlKzEK4fg4PlYsCvlFCdaK7q/ULdV9I7DOcg8dKoUWzDCVQMThmrHKHfDbDLqoE+WiHMBghjaThqLswrq2kbld5JJa6JZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400005)(316002)(81166007)(70586007)(36756003)(2616005)(16526019)(110136005)(426003)(83380400001)(336012)(47076005)(186003)(54906003)(44832011)(36860700001)(2906002)(40460700003)(508600001)(5660300002)(70206006)(8676002)(6666004)(86362001)(356005)(26005)(4326008)(8936002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 05:48:30.2628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3890f804-119f-414b-7daf-08da235a9078
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2348
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
supported, use CPUID leaf 0x80000022 EBX to detect the
number of Core PMCs. This offers more flexibility if the
counts change in later processor families.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c        |  6 ++++++
 arch/x86/include/asm/perf_event.h | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index b70dfa028ba5..52fd7941a724 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1186,6 +1186,7 @@ static const struct attribute_group *amd_attr_update[] = {
 
 static int __init amd_core_pmu_init(void)
 {
+	union cpuid_0x80000022_ebx ebx;
 	u64 even_ctr_mask = 0ULL;
 	int i;
 
@@ -1206,9 +1207,14 @@ static int __init amd_core_pmu_init(void)
 
 	/* Check for Performance Monitoring v2 support */
 	if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
+		ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
+
 		/* Update PMU version for later usage */
 		x86_pmu.version = 2;
 
+		/* Find the number of available Core PMCs */
+		x86_pmu.num_counters = ebx.split.num_core_pmc;
+
 		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
 	}
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index a5dea5da1b52..7aa1d420c779 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -186,6 +186,18 @@ union cpuid28_ecx {
 	unsigned int            full;
 };
 
+/*
+ * AMD "Extended Performance Monitoring and Debug" CPUID
+ * detection/enumeration details:
+ */
+union cpuid_0x80000022_ebx {
+	struct {
+		/* Number of Core Performance Counters */
+		unsigned int	num_core_pmc:4;
+	} split;
+	unsigned int		full;
+};
+
 struct x86_pmu_capability {
 	int		version;
 	int		num_counters_gp;
@@ -372,6 +384,11 @@ struct pebs_xmm {
 	u64 xmm[16*2];	/* two entries for each register */
 };
 
+/*
+ * AMD Extended Performance Monitoring and Debug cpuid feature detection
+ */
+#define EXT_PERFMON_DEBUG_FEATURES		0x80000022
+
 /*
  * IBS cpuid feature detection
  */
-- 
2.32.0

