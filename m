Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D195096FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384545AbiDUFu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384538AbiDUFuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:50:25 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911441208F;
        Wed, 20 Apr 2022 22:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMRd5LfJL21IPWo367JPNm87BppZzGKTGki7i4tw1k1b8eGDVkLzyh3dMT2yCGj+7/W5YS+iqhr8qiy0IHep17EETFWjhATkBNifRnRQSDLhd4mnuWbroROQ7wqU2S8IKg6oa880sqSFZ7GOnAt4DlGc3dlsOYDN2O0ka5/CbPIO0Q3JXG9cfcMzH5r/6Ew2tab1gkSLgaU+sV6RJWajgSD5rlpX5qhyBoKsuBYEYk/3TTS+T5GgCVkwwmYTlFO6Dwuf3XA9WusO1PUNlzPveYWl/D3FaqFIpo5QNRfQlPolVCxeIi0xBFjdcNs02jyUmPFW0wcG+E/jJtKRjOXTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+in/oCZD8WJKt9Oc0L7VFfVVJf6qU/6xlqv6i8Ff+tY=;
 b=CVClYKWersDUTdUc7NczQ/vkOgIJmScZL7cfnp8T8KbZ6HHK3h7pF26SvRA9boKKZmBMMbJfCJoBtFj74SuN9klR7X4Q0VIrqdGjdNGTJLSen/h8swLmILtkbQZ860suZf3MSk4l/OMLBOh6ZhjT6AOxReHulr/fTgupqmhK6PxCugOTQurCLg5gqtbOIcIZmkVumdPB6o14Jntk3uS7OCz7fe+UElzW5Gg7z5cdPRbOLfV3/IY2Z9KCs4fh+Y6IvEKzS4TviLdZ0SDbCBxwZSBrPBG3LUo/knQUwl3h/7YBJFNZ8rrf1W8NYWDGZrnGJAoGixztRvqbGm7B5UyeQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+in/oCZD8WJKt9Oc0L7VFfVVJf6qU/6xlqv6i8Ff+tY=;
 b=174x/9gJQVXjwVaWwjh8O2+6qXpRMjWMqRkS7mHPIuhZPqbng4iLsQ1J1Pi435X4Z0XiPuB73jlmWxghOkyZzF2NWjaS5ZtZxj1vtulaTOWkk95Z4CIVxdDhXpxfe5gp2E1UmlgNtPBVE5IM61gSsb3NnO+YzIjfmxtjuBjT6lE=
Received: from DS7PR05CA0035.namprd05.prod.outlook.com (2603:10b6:8:2f::18) by
 MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 05:47:34 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::3a) by DS7PR05CA0035.outlook.office365.com
 (2603:10b6:8:2f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.8 via Frontend
 Transport; Thu, 21 Apr 2022 05:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 05:47:33 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 00:47:26 -0500
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
Subject: [PATCH v2 1/7] x86/cpufeatures: Add PerfMonV2 feature bit
Date:   Thu, 21 Apr 2022 11:16:53 +0530
Message-ID: <c70e497e22f18e7f05b025bb64ca21cc12b17792.1650515382.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c148fad5-c734-4ccd-f484-08da235a6ec3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4047:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4047FFEF24729AD80DCAE6CA8BF49@MN2PR12MB4047.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPipRK4oe5+VF91lPkpvqspr8uG8ULn05jzTlB2MGMLOtr+YOuJxWMznmYMmOQYyJWvzXIHlAULyuiJJp17JHod7HiZw7mR8Jm9LtYG0JvKKdoE7diiGQaZ2if6hTZY/SH+Iv6NrGUJ18NK/ca1UtAHzCKzRJ3Ghf0JJqx6rei5y/kgYzuZToBdwbtuCfKHs/vYtUHvHEVfGl3JYZkcWAfR8JolDlCXlXrXpxQd0FkJSk6eaVo7Jopq7jHJzzGlvi0JVPLedFPqESAytzTkG0NDdpPBgV74p9HSiaIRY72/s1GGgiNEjEMgn+9fcYLA+q0JhZOJZVa954DO19NBoyP3s6NWg7TJpf3RHGLYZ7xNDltTHWrUnWUjfNgO3o9lLac8BdaCW3WKsdWtk1mxfto6tKnga6d9RaLJ3yeqPBkkcUaAiVHHEvrLtOMtgNwZdCtNYR+VUAM5BoMVzpUGPhBGOFKUeK0W3hKCci4+X188920lIZQqEj0/sMgs9lijdXgvzXzKDfbZw3WBW2ezEwlA3aYWGIuKDWz0NCiGXBzvUmI9iDEH0qpFo6VxRe+roF1mirD3pajL04ovwMTHQkO5LNcqdP3OL2uoDSXEBlk+LRb+wiEDUcrRnjiUaoLXNaPty+H4rVActn/SUdbhTO4W6BBPfIy8X6LaOh4RCmVNIg5jhoBg7X3YoSSlk99ne7KTazAnesnR++eRpNU/hZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(2906002)(44832011)(5660300002)(2616005)(70586007)(16526019)(6666004)(8936002)(47076005)(336012)(508600001)(40460700003)(26005)(86362001)(426003)(186003)(82310400005)(36756003)(316002)(36860700001)(356005)(81166007)(54906003)(110136005)(8676002)(7416002)(70206006)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 05:47:33.7617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c148fad5-c734-4ccd-f484-08da235a6ec3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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
2.32.0

