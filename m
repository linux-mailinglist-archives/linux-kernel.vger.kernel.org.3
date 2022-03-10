Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41194D4578
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241548AbiCJLRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbiCJLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:17:26 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3A1141454
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:16:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjeUmMjUkHehHX7EBQbrpYsxNQhCpseYPNz2fS6BuWCSAD+e2caMrRvhTSugRT4ddwZeSt4DEr8aJE/YQ+iQ9/96v2vXx8sPq2/Zc237xbaud0rCKa7jW4ZqQwBVLyGkeoGOoLPvDdHcszMXFmcl+2WeibxS7SkAtXaQTh1F40x3R2ZJei5mN7E7CXp35hxBB58+/o73vhjVu7PegPPoZSBypDQNr6KZmR9sLO8AU09fQt0uklH56Ld9mLyfN7Y7Pqn5+XLpND91j9s5nw6fynDpAFhZ6bgWtmDabXjImypMqST9VyCvhCZpNoqMtF3XMhqtzNuUnF1RNhcV7r6omQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irr2hZii6rdNNuY/EL2TLNU++YjSdRudQr8Tk9/mCMQ=;
 b=YcS3RS8CGLBCUcKztuUcd2B+tJUKIGHxymzYs87HMQWQrJFMshD5l4QaM6fcokXw5RLHhSC0r1CfLaoI4COnRAFaAf7+hBkPSuRuFleBRsO3tBn3yNKvqWkTxmsC8+KowVKvFL3fQd7jB4K2Yl715cc5ZHx6cZ7vz2TdH/e7mDOdyQeRGGLRxUZP2/Z9Z/6M3gLSDhwUo+YqDwSSLwJHodhTb608LMN9rOMTSOq615M9fie4H/nNVl6J8F32SS3vMFRl6I9gv7WNTmvGE+glxRlfsGgJoDv5CQYjxq6mmS627777i1B/5WuKHLLBKpYUODni4OWWBbQCe3zd0lt/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irr2hZii6rdNNuY/EL2TLNU++YjSdRudQr8Tk9/mCMQ=;
 b=YJRZaocepxslC8CUaqHVPGYEfXt4m8+7/V5ADjbB8+7lf7L26Nalwm1CR6c/2WPw3GmlCq5CEqpwG6XRWav+w4xMp4XAOia5Z4WxZpV3T46OdiUjg+ybVyErG+HQ+9SxtBzRSsa6Q7i5o/TgVkN0paqjvAhazDAqUET73zr8NXY=
Received: from MW4PR04CA0304.namprd04.prod.outlook.com (2603:10b6:303:82::9)
 by BL0PR12MB2388.namprd12.prod.outlook.com (2603:10b6:207:4a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 11:16:22 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::ab) by MW4PR04CA0304.outlook.office365.com
 (2603:10b6:303:82::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 11:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 11:16:21 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 05:16:15 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <x86@kernel.org>,
        <kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <shuah@kernel.org>,
        <oleg@redhat.com>, <ananth.narayan@amd.com>,
        "Bharata B Rao" <bharata@amd.com>
Subject: [RFC PATCH v0 2/6] x86/cpufeatures: Add Upper Address Ignore(UAI) as CPU feature
Date:   Thu, 10 Mar 2022 16:45:41 +0530
Message-ID: <20220310111545.10852-3-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310111545.10852-1-bharata@amd.com>
References: <20220310111545.10852-1-bharata@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ec121ed-844a-4d92-35a0-08da0287680e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2388:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2388354016ED6422CC0F69E4B00B9@BL0PR12MB2388.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hhctx1XeHMFfNbpLvvVWo3kwzZLf6VQPqTAKmNjfmfSRSk1pRcgfUaznEMq2I+64rFLbXkuvEnQI8S3AmZLUkaCKF7nFZSbQTzmMzlaThAIwcW5CM9BRI/YhPpuGyy9+V9U43ukMZs8BXi46+0VdbEhl2lDwW2Ejn6GOrKUm2guSr3IX8qD8xC4pkf72hHOtVzFuUWr/d5Jc/URs6nM2VkNicW3CjrIzc6SXsEhdQLgASU6cQEVnuajAPBZ8Q0dYwWSDoknUqfS4k9zrRfWUZpq+CN3UogFZK49cqRP1z02dOwGJTCABdq1A0I8/Rvj1HQ9IiXpkRC3ro0VazFg/DcZfu6221bJpzUXDW0zwrZ/8NkDoPnGJbNt3VH3RTlUh5Qql7CLJnK8ZPUboCuuXVkl6LlktDrQ3if1G1q0AMP5f8kIaC+S0ce2+YQdcHk81d/eM8Bfu7wIue5LxY0WdyMRvpUJmRkWHc5M+aoQHa+uhi1baeU0iMBPJad+h1KB7QO7GBb0clp3xjla7wz4fHXyLLJ2HRuDHlFlwhZjyesSV4/zC6YyUGa/UdWzFEnHsXidscmgCpCPGM7rMNN0du/5cngksfBiXhAO25VKVNBBSMWkknhkK0S1k8q5lruF2XdbqURxMaZp17fh6J43+pnITcxxmhsqMhA2a8pcaw4Bj8asR+bDjQM4zpksgBXjhui8GyUW03evSkUQ6vGEqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(81166007)(86362001)(40460700003)(1076003)(2616005)(26005)(186003)(16526019)(336012)(7696005)(83380400001)(36756003)(316002)(426003)(54906003)(6916009)(2906002)(70586007)(47076005)(6666004)(70206006)(508600001)(7416002)(5660300002)(4326008)(82310400004)(8676002)(8936002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:16:21.3917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec121ed-844a-4d92-35a0-08da0287680e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the maximum logical address size for AMD processors in
64 bit mode is 57 bits. This means that the remaining 7 upper bits
[63:57] are available for software use. With UAI feature turned ON,
the processor ignores these upper bits when performing canonical
check on these addresses.

Add UAI as a CPU feature.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6db4e2932b3d..5f4e88e67feb 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -201,7 +201,7 @@
 #define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
-/* FREE!                                ( 7*32+10) */
+#define X86_FEATURE_UAI			( 7*32+10) /* AMD Upper Address Ignore */
 #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
 #define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD	( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 21d1f062895a..5c19f6f525cf 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -42,6 +42,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
+	{ X86_FEATURE_UAI,		CPUID_EAX,  7, 0x80000021, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.25.1

