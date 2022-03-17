Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9374DBF88
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiCQGay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiCQGaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:30:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2042.outbound.protection.outlook.com [40.107.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27385595;
        Wed, 16 Mar 2022 23:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIlyKJcDH/VcURgrczyaWvqq6COOwcn7J3PLGLTJlTk3KjLp9rcwwV6azx2KQD1v0xVzTJrm8fRD6lngvutxGe5A2LqgQqrxS0ckTE8WEOL5XBnx5AtE1uenDs1HoAej/PBSCjFv553s1E/9dqa2MpetLHAHz6bIw6Ax3Ejp3zX8uWL5zLA3isMIY9CbgY1YXjiOh5nEvASfTHJovqJVF8pe0t2B/ja2PGeiRIMbYQuH3U28U0OZMqc+m796uL1ZVddDzONsAKwGJb+xaziiGfThWd1g+esory97kaeO0Tj3W3FRYTaEVp+jibeJsj4GZmt3BEWqAQObXnjeQFUktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQtFkL/4Fkk8KQZF9MjkayqH+KdOHs8Ihlquf/xj/Z8=;
 b=ZE36ZEUp1IeGxKjtO8K8Dc7tS7YoqkD3YubU9PM1DDdBE0Q7dcY1m/a+6oKd3gtN5DxsinsUM4fFeFECA49U7/F0bj77bgqQOuELYNothSzFAt9Gw49lSRlMHHaN/pp/aXOaNeSwV6SP9T2NtGHoGZVerI36H6aMuVcDTcVyvAU8s+HfT8L7cp6gEKTDUT2nzaXuemIEoe2Oyxkfg71fB89qAL1R+XwlOdu7vgvJuDCdkpTakt6dc8GWXHBF/E4EfCBNmkPOejMO0xDaC/8pT5KtYT4nmtPjJdGcCjIzoftlSGIoQDmYiWeRIN5BnjXeCZ5WIVLvtcwh7X7RYZSv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQtFkL/4Fkk8KQZF9MjkayqH+KdOHs8Ihlquf/xj/Z8=;
 b=sMS1oQQMCJnaYbfzLWlEdG21E2PpDugSNCGHgxSl9h7y00K/3Oz8tv4aHz3hV55dM224X1Bkk/iY1Gy0aYaOfitO/DA0jqNOINfKFoZHN63OfVFtZ4RB39dMYcCrqTQFuUZiVplsR8Yu5dbiV0hwUtKaWjgOo4r6mRwTzgAfBMw=
Received: from DM5PR06CA0091.namprd06.prod.outlook.com (2603:10b6:3:4::29) by
 MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Thu, 17 Mar 2022 06:29:15 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::77) by DM5PR06CA0091.outlook.office365.com
 (2603:10b6:3:4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Thu, 17 Mar 2022 06:29:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 06:29:15 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 01:29:03 -0500
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
Subject: [PATCH 1/7] x86/cpufeatures: Add PerfMonV2 feature bit
Date:   Thu, 17 Mar 2022 11:58:30 +0530
Message-ID: <515f26e6190f3f9d332bd947b91f18cd6f15c192.1647498015.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c42b909c-89ba-48cd-4128-08da07df753d
X-MS-TrafficTypeDiagnostic: MN0PR12MB5809:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5809FF9CDA3CBCABB2564E238B129@MN0PR12MB5809.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CUr8mlpu7hVxkDoJbfld0bhL3jGki8k7tpSzpZ86zo+ZU+kac3YT31pG4J8hse5uDXH2ypnIt7f35JS+bZDLo9onBXQSP9Eg70J80dglXKhXKTVkxJViBd568vJVzJgrpYQ727Z4om16kSos3W/Hwk2D2/EZygNGfu4AMBNG+yI6y89PL03NHhYxVrV33BuzJAWSh71uobTw1V/1UkWT/D/8IWBzUwk33e9TZrAira8G4/fo2qQH+E+Sf2rejE10O7E9ghaN0Mo6lnIvQDR1ygC4ZxFaZLay5bv+hjhBL8N0x9YAOQuwDUXbj1OibAmS+j+kI76mA50gZzy2AlcPIHePXgjN4hc/MBlLXh8qTAamxAg1lildXHHLF/5GruwaLWRUt9Fd2W/ElpIrsJYarkWmb1DPfq4C6q2lwkbJqhA9cnp58ZMGfd7tzB9yA4Bl9TfX2dwuF2s2yrvCYXg+t62IbMX2bJak1c9wPj6L+jQIgpQHVig0QdXFI5f+6ETEzJKmBOrFQWD5U2U2ZoRqnC557FE7gPBhhxVruGwTC1M047EsvK8vqdBSRyRoUV0TqUv45kehpXt41bCWsOWblEgvuj1PK0qa9nl3RO1Nlcog6w14hWjg0ciU39AXA5H7q+CPlFPzWQs49fih4ohEBIzzmtltX4l0B0T8g21690fP2mzRDDwrBqd8iLvi2pcbDhbIVfWK74ouN4GY8D8Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(36860700001)(16526019)(186003)(26005)(110136005)(508600001)(7696005)(336012)(426003)(54906003)(6666004)(36756003)(316002)(82310400004)(4326008)(356005)(8676002)(70586007)(70206006)(2906002)(2616005)(8936002)(44832011)(7416002)(5660300002)(40460700003)(86362001)(81166007)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 06:29:15.1302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c42b909c-89ba-48cd-4128-08da07df753d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUID Fn80000022 i.e. ExtPerfMonAndDbg advertises some new
performance monitoring features for upcoming AMD processors.

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
index 65d147974f8d..7af0ee914e2d 100644
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
index 21d1f062895a..8c0d9b5426f7 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -42,6 +42,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
+	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.32.0

