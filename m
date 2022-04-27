Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9AF5115E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiD0Lfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiD0Lfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:35:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2043.outbound.protection.outlook.com [40.107.95.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CE239B8D;
        Wed, 27 Apr 2022 04:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlJH+o9cB9RmcvwI8xNyM+oq+iU3fCRJWkK2MYyaVhW/tnGwBAxFp/d89esKQ5OMlylJEC4SL8EAIaEWU69ooPfdyer95pxjQgQNvYK/RoYdNRICtPPDAEcRGVX1kzOixSCvj6eYqGLNGE7w17z+59WZshH8S03DeleIqVvgovtNjdbQ7xdcUHzJwmat8QWAbn2t9ttO0p0GHqNRIlfDB3+w8m6rBQcHMq/myfs6dI1TSKv8RDd5yPNc4lzeJE5QcVbwFk2mqlGlEKHtr3i4zzrDVBW9MCAbpQGfSAGdFDONw4S0j+RtQHEZG4Dh1lwOlKcGRJM6NZzqbg3UrwZZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53kMNLRsdMJuHmhc4FDZO1SfLmeN3FHdZAVddqSFqhA=;
 b=Rj2JIFdpNkPyIPut92tQMKeBItUsEX9pxxJrTsme1s12muxoNfM8KGrz+0TOB9aeAzOHcz95I1zqplk4OQSD+E3fjoeXlJzeV+dF8a6Qm3tCuYOrYbm+qEDiqiifpZ46VsGbukb9MP6AW3CjV1g3aVd4XVGviqK4fXgfwUif6DhDda/NYADnG8fuQeCOR4MAbgNSfwI29xS8bXm5S4UyMProrCet10y6J3uIG/EsAc6WawBldehzgksIuOZzwsvgKDpwdUDSoBxmHTJkk3vSerC1b9ZDQsz2qzjJREuhq9RH4W65YOTpxY0efDPJF1Hixgz2VNPl0TsOeHf0zQJkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53kMNLRsdMJuHmhc4FDZO1SfLmeN3FHdZAVddqSFqhA=;
 b=XPp2IgtRX3aQcNcFTweeKU9/cjf4aIi1W0cYiVihGeOCz6xDRSfN322sZwRN11mCkEEmRDpXxkAerH1JjFYNLECOWM9HxmOgVUsdBKpUYPvIINFIXCHWd1Uxl478S/bEnO4hSp7bDNkfQrQS+Jroq1LhS9Ax9XKxYmb1S8gpYMk=
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 MN2PR12MB2944.namprd12.prod.outlook.com (2603:10b6:208:ae::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.12; Wed, 27 Apr 2022 11:32:24 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::98) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 11:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 11:32:23 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 06:32:17 -0500
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
Subject: [PATCH v4 1/7] x86/cpufeatures: Add PerfMonV2 feature bit
Date:   Wed, 27 Apr 2022 17:01:43 +0530
Message-ID: <8a660418bdcf1ee9f36e733cb109cbd54f05ad76.1651058600.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7bbe21ab-948c-4ab0-ad75-08da2841998c
X-MS-TrafficTypeDiagnostic: MN2PR12MB2944:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB29448549E31783F2A21F5F848BFA9@MN2PR12MB2944.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H14oYl/cw5t8c2sOhACkn3wfFagWPhKqvxJwSpBMiHVhMehX4t5o8D8t6J6b8xXtgCDZqtsMf/pD4dmSxxE4/oGTC6tt1lwVVbsdwMSpB6x+PXzqRUTzrXVjo+UPSmOxP4vlx1bDfDy+4/aV77eDLZ6PC3cAI1lj2bpPLrkYv0g8snrk3pI7bhaN3JI5O96mlgbNlwXZShPWln6OXzBJmqEBfgFIOXzc5w+AnUrajTmDG6VSOMlRNKTGziHIhugocOQbJ1NnkJDqSkHmW7ggQ1WKIXSRTMXkw/ek20VOuq7M12/H/16jaG5diCITrVc8Lz0vaS/2j924emC4bnhNBGS/a+G8riowGWbR3el+mNRikyiHSg5wXr6PHs8uRGWDaoaSXIlOwK+YBMzPvOOOUPykfIFn/IwsXd8ISQ816Vzq1L43CcnZkBM3fEbjO625OSYiEY9fR8qhGDF/OfN3HdG8ixouQhcWxZgKJTZCGQmNzgRA2xvNo/DLDdZKDjyDiRZT00i/nXROvhW/Imv2huel4jWDoWpydvJrErzfHD5H3HUqF8ti2IIvloDbtEi9lYZPe8kw8icn7NF6k3AMJtme6neujPBFrsXTFztI51+Xhf+nCqYYpCfJQq8q9lngqMP5MLP/lq4RH3dQbveC3QcwOrDK/1NvpWRE497+deDXeWhVQtlWWq1X5K7M6iwDQUNhvp/1X34AHVyPYuDe1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(186003)(47076005)(83380400001)(336012)(26005)(16526019)(426003)(2616005)(81166007)(40460700003)(36860700001)(356005)(316002)(2906002)(54906003)(44832011)(82310400005)(110136005)(4326008)(8676002)(70586007)(70206006)(7416002)(5660300002)(8936002)(508600001)(6666004)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 11:32:23.9371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbe21ab-948c-4ab0-ad75-08da2841998c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2944
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUID leaf 0x80000022 i.e. ExtPerfMonAndDbg advertises some
new performance monitoring features for AMD processors.

Bit 0 of EAX indicates support for Performance Monitoring
Version 2 (PerfMonV2) features. If found to be set during
PMU initialization, the EBX bits of the same CPUID function
can be used to determine the number of available PMCs for
different PMU types. Additionally, Core PMCs can be managed
using new global control and status registers.

For better utilization of feature words, PerfMonV2 is added
as a scattered feature bit.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 30da1341f226..9b8ad6f4d310 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -201,7 +201,7 @@
 #define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
-/* FREE!                                ( 7*32+10) */
+#define X86_FEATURE_PERFMON_V2		( 7*32+10) /* AMD Performance Monitoring Version 2 */
 #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
 #define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_LFENCE	( 7*32+13) /* "" Use LFENCE for Spectre variant 2 */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 4143b1e4c5c6..dbaa8326d6f2 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -43,6 +43,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
+	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.34.1

