Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEED4DBF8D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiCQGbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiCQGbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:31:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662929D4EC;
        Wed, 16 Mar 2022 23:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNni8gX0MKSB80kM0NMV8wlT9hdD3ggLftf/HXFfCbMsPqDG8vj5eCbO3/mxz4/TEmXX0ncofwMp4Le5+2ZR5jcOs4jFeoZwzFODfWapE2vHqX4sZyODxkWhScy8yBhc2w0nV3lLoqFTsKRxKtZq2s9jSQH74E0K29VsuVk1xzSriguOvCC3ZIvUX+diRf03K1RGWJe6wEu8y24Eqls/JKd8wyBm9bzV7X/n7AjrLQYlxa26BxN6VQUiBZJFBQoMfUQbdYua5jJoxEtGm8VufQZEKjOJzLrd6ZnNM6Yy8ZFkY0rrJ7PrWumvAuTBVdHk69XcKc0LllV9KWmpE2xzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1uLYdxN5YomtSEcSWqZblu88g7sXS6hzmZbP9zVsz0=;
 b=B+oWE2Cl02vGLRkAVKWxiSk5opBR8ntf7tRM2vEUCsz967UYUWTF4LRiwYo7Zh3XeMEeo9H6JFJ4M/oqd7PuR5iGvgGS8UvRWK30HQ0tS05v9ipNbXowesb0dnP4LXMOy6feE9eTVJrPSB4tZSnk3ZRL2aZwQqItxDb6fsJWaEBQiNGYDreQcTLu1KscZd3opi7/AK2BEO7ot7VGvYWHdRXFpNNOzbGSq9O+j84ZWQW92RAr9w1HUuCmfrTYgufeeDHSSjfGN43+hEe4qq3Ww4T8Qs8faGuilQ0FXePxScqZWtbcCDLtadhJ7NXfdYUub+LhPAh9uPkYdhFhajIvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1uLYdxN5YomtSEcSWqZblu88g7sXS6hzmZbP9zVsz0=;
 b=liDY+b+5isIscRFe65zD1QQZAAzw8PZikmiNH1dy/isSZkRzzTlbitATwwwjOyLfF0/QOF4P6txdMxtBA4r+QUCA87DIq4Ae7NKOIBV+9gGg5yKEFhWT+dSh8CRq9cGwTn64DMdgMIRBcSS5ieWm+/NxRW/Irz2iqlscGwlBzts=
Received: from DM6PR06CA0004.namprd06.prod.outlook.com (2603:10b6:5:120::17)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 06:30:12 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::e4) by DM6PR06CA0004.outlook.office365.com
 (2603:10b6:5:120::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24 via Frontend
 Transport; Thu, 17 Mar 2022 06:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 06:30:12 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 01:30:00 -0500
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
Subject: [PATCH 4/7] perf/x86/amd/core: Detect available counters
Date:   Thu, 17 Mar 2022 11:58:33 +0530
Message-ID: <7393a62ef0489c4b86034c68ff8e11bc97456385.1647498015.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a5e7741-ca4d-499a-3400-08da07df9752
X-MS-TrafficTypeDiagnostic: CH2PR12MB4183:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4183F0955F99BD3C10FA43508B129@CH2PR12MB4183.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYbnG6dZIfQimMouVPBeOvnkPPxTSR2GfLD/8gPQt+fGXVnbC3j7TpZpddK3EFeT8EbvbX5uW/i/C4R+DGXip3yqQvauTswekhHMErR+vfzNtEO3wf5CIrzb0gYJdS+rcJMWjWOMq980XH/gRRKFjHWz5Jcc9x+Bzg6t7va5R7kr+szQcCA7lD0aT6cG2jKVUoKkPDdnfvIQ2mPgC3wYFWPUwG448WLfUTJ3UBGiyJA104xB4R8T2IwmpTPHCxNhBR4TBMOTdBtAqIg3O8BaOVgBhO3uyv6Ldg/zAJLCvD7SOjqWg6dKRZccPz9FkJ/jDzpzbPkFu26fYPejHK0GClvz84pmLGca1zCcRRz4CqftqoYSf5YNr3wIr54JNAI8sw2MNZRK84mfRVUfHYd6Jx88EHGojEV3Gf6rE8tfQLMMNjbSK0Wi6QXukNfaZwkYVbhACuPN3xf+tTDpRb2O2VTpTV52/V8KmH3cFhaQ6y+AZ4D9HEUb533Kvtd6Jbw1Wcj7/4WHOEGlo5loeFprWWLkiOw3ZLk3nSq/R2aDjZsSa7Z16IGkBAOjpph8Nm7q4mgq1Oot6EHdyeSUcGVgVQLDMpg6bHLbOJ0gYmfRF3ewJ6URhyg7Lq8L/rFi7pikzRR0YsJidEmyDlDXoymPmZc7/jOAFbOMjsyh3vzSpVwMYJgTel2zXosDg3cmc+FJWb6Is8ZHm7fmQM6UG3PZpIFYyOcVMGIpDta6lq8LJMDFNrAwukpZDRZ37f3Jz9kO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400004)(4326008)(16526019)(2616005)(186003)(336012)(26005)(426003)(70586007)(70206006)(508600001)(83380400001)(356005)(81166007)(86362001)(54906003)(8676002)(110136005)(316002)(2906002)(6666004)(7696005)(40460700003)(36756003)(47076005)(7416002)(8936002)(5660300002)(36860700001)(44832011)(131093003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 06:30:12.3101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5e7741-ca4d-499a-3400-08da07df9752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
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
supported, use CPUID Fn80000022[EBX] to detect the number
of Core PMCs. This offers more flexibility if the counts
change across processor families.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c        | 5 +++++
 arch/x86/include/asm/perf_event.h | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index a074af97faa9..05d79afe5173 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -980,9 +980,14 @@ static int __init amd_core_pmu_init(void)
 
 	/* Check for Performance Monitoring v2 support */
 	if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
+		int ebx = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
+
 		/* Update PMU version for later usage */
 		x86_pmu.version = 2;
 
+		/* Find the number of available Core PMCs */
+		x86_pmu.num_counters = EXT_PERFMON_DEBUG_NUM_CORE_PMC(ebx);
+
 		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
 	}
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc1b5003713..d7dfef3e998d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -365,6 +365,14 @@ struct pebs_xmm {
 	u64 xmm[16*2];	/* two entries for each register */
 };
 
+/*
+ * AMD Extended Performance Monitoring and Debug cpuid feature detection
+ */
+#define EXT_PERFMON_DEBUG_FEATURES		0x80000022
+
+/* Extended Performance Monitoring and Debug EBX feature bits */
+#define EXT_PERFMON_DEBUG_NUM_CORE_PMC(ebx)	((ebx) & GENMASK(3, 0))
+
 /*
  * IBS cpuid feature detection
  */
-- 
2.32.0

