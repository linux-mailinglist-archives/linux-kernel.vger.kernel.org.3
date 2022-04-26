Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F2B50FE43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350556AbiDZNJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350792AbiDZNJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:09:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A1B2DC4;
        Tue, 26 Apr 2022 06:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D07DpChmY/rFtfBftCeNixdOjzNI0v8Iw1SLBQczQIy1ujjKq36eiyicnus3YZv+ynykmbR0u5MZmNVse5F4nF5je/DyQjxJqNMUbSsWiLwNx1eid+8UQqfjHUPxfQUUdBW47vVGe6bFFfu4vAIZGUX9ImBlkHIPHIWVSFC9RKNFsgleHmHj/Vh62TcC11BkYfb2IUn2K/H+hs1clzKrW72cFk8voKW9ggwz4/GiQfU8PzKvnnjORHPLl6zEZIEj85byebNAbToQzosh4VOqZWmz5JvUts5Y8Hlt2wRy67aCQmwhZBvXxKNaIUZ/KgbiYTf74NxAAwnnl46XnXsrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53kMNLRsdMJuHmhc4FDZO1SfLmeN3FHdZAVddqSFqhA=;
 b=VtwDXIeETL9oxxH2M8xf6Cv7cMAMvFwAH007q8npocMxqFgtNuEezz0FE5EBdgOaBghmYQYGRiqoWqCBflAaYBnnCXAkmgFsmuze5zVu1KyjNjWnCBcRUAxKH8fT9yqofjpYPtz+UDnBiiHnUCxceokXYPgGStcDtvQEZ9T5UtRduGDEatPmlLfTqhc7Bc2Axyda5/VJ78Fvu14amE76mghcQdK6NEDMK2nopsBuo0+9y5bWiF1O4qh6DhAd8An49wYyI5XUrB1nD7TdZO/vFKQQhRpK238lU6/2goPrZ9CVAuFmqZ+Ahfi0l1CedN7gjlOzJR4rvoLAqqy6/iGqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53kMNLRsdMJuHmhc4FDZO1SfLmeN3FHdZAVddqSFqhA=;
 b=3NlE1RNJ56aPLGacRF/AF5M0Dz9WQtVLyQcJyMJKbxCzj76BO15UD4xFGePBio5pPvpii7BaPOe1a59RMkywUN1hlIEaRZgkUSbuK2+MyhBVfiJghdUuyIR8pA7mPSbV7GLiyaJlFvklrF14jfiICEuTkfA/hUOVYYoxjjbCNQY=
Received: from MW4PR03CA0229.namprd03.prod.outlook.com (2603:10b6:303:b9::24)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 26 Apr
 2022 13:06:13 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::4c) by MW4PR03CA0229.outlook.office365.com
 (2603:10b6:303:b9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 26 Apr 2022 13:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 13:06:12 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 08:06:05 -0500
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
Subject: [PATCH v3 1/7] x86/cpufeatures: Add PerfMonV2 feature bit
Date:   Tue, 26 Apr 2022 18:35:32 +0530
Message-ID: <8a660418bdcf1ee9f36e733cb109cbd54f05ad76.1650977962.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42c8833b-9cdd-49d8-dd65-08da27858a4a
X-MS-TrafficTypeDiagnostic: LV2PR12MB6016:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB601645F5E6183B0974342B7C8BFB9@LV2PR12MB6016.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzOaSvaCGBw68h2OQPxFFXwlbJaLdNpQaA/VmXgvIVPJkbYsc1Et7v6oyh2B3S7soPoXaL+jgLanb2uJP58z5J5PAKVxgdmhWD6ACyWlf8dlkbTy1dso4EwlljvuUb+jt6zFv/S+npJvs8JSvVH7E2RIF7Wa8EzbQMbu/NDL+fh7DqhwofLSeznBPHBoUm8kf+NuupvYOr8thn15WWaYRkqVQHIvI2SnqQMfOKMTjkdnwuehYFinBorp2hf+T6smKKZqofs2vdjDaFNowXdU6KVKJ0aasoI/SJFOVY0MmZKDf7RmO8Ng0Xq0qlrMIssO5DMzPvmbbYDe/B7j1B1jUeAN2Vq0wIIQiiNi82Xld4vDmL0L8ig68y5k0fbcD+nmTknpWfAozuKhdHLTAAjlSJ0DbWvMfH862RYFpprHkgFvoxzg3adreXfzSWot1eoPe7nRW7CoNkfM5A55uyxJybLTCyqenUs/PCi0L5PhE5BZyUDR5y7o5O72ZRQXcqkMygFUIg7ru03haQgoBl8p88jOmk8zCyfUC5AHipu7dzSG6+FP5bLeFMnZISdmKAgToSkYvzTxjgoA1lrAOzIoIAua3rASsC23rryf9z5nI393T6rdQBNwK2V8OZ6JQ53fU4pbfyfJ+pwlqDGg/e0QcW8OR6nlZXoEKpaXmmSZWW/V2Te9pxpSExN8IfJ/fkDjyBQG+5JBTdoP0dAu8IpZAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(316002)(54906003)(110136005)(2906002)(8936002)(16526019)(336012)(426003)(47076005)(186003)(26005)(4326008)(8676002)(70586007)(70206006)(2616005)(356005)(36860700001)(86362001)(83380400001)(7416002)(5660300002)(508600001)(44832011)(82310400005)(40460700003)(81166007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 13:06:12.7986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c8833b-9cdd-49d8-dd65-08da27858a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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

