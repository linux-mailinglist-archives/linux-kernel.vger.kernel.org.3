Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2F058FC52
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiHKMdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiHKMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:33:18 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7AFDECF;
        Thu, 11 Aug 2022 05:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClOvMSNaTdtk8HjtBVEgWCWbMr0hBb8CQaPsYIpU2VdiJwc/8/65VO1oeHzEz38X1vhtATwwOLXdKVd/qOlS4SfWD/RBnL5Ss1vq/prlevyaP0bomM32qfNMW1qSEhaykCTRf5wv5TdsjHcaTi8eWogAEHTC2c/XOwb8TPwZNnB6AcbDjS4XvKJ8eB2UJ9/BYL8FJiN607CmvU/OX+XHTBZJj8CEUc6rpk0CeoYHXLPVmTEaXRMEDLW2QAOQ08kmo8zP8F1dBWgkvQ4MRYyfKGxONsMEg7jV0KE0MChRi9byGvLh5Hj+xFsOp0AFiO8Gk/NHomQKGCap8mNBzCMKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvDmQPsFpUzzlzT6cpXiZvGIiABgfERnaavB60hctpY=;
 b=R+JiFXwFp1xHoOLb5F4TLPZeIOA3fHFuuOxPEFcThsQflr339QsvzfLKeu4b+hLPsQOW5HstydjpSjJ2onkU2flaX3w+B2HswmbUkrDa3lCm7/K+nto3cZ8QdoslSSHMysZCbmDIM6UDj/KWA1szz4Oxsa5vwbSsoJIK9VUQzL9ceKbHG1m8wPX8IXLgbxrNgPMJynAGggj4HCpbKcrIaYUQNFO9l8wevw1H2qIDA1Y3wNrTCD5NCdBJFBLS2XK1oB8gJKtobTyg9o05gEHli996mq4I66RfkngE5rR5d41+N0z3KsSzU7ENvugg30vhFa9YsRRUtF/Sl+zOL1yOAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvDmQPsFpUzzlzT6cpXiZvGIiABgfERnaavB60hctpY=;
 b=qL7JYbMHlmLa6Lg7QSxLU5JxU1CjxsaYbz5gjGXZN0d7UvY1deh69DkiaM+QG707LDZGhlRS+uIhCI2DTYVwfPyRnSmawewwJoLt+Kr0eOe+YUmfMH67WcADsyQQxztmtJU8OX3NbAQ+92dWJcCj+aAUcjYFZnS7czo0VZTtoxQ=
Received: from MW4PR04CA0323.namprd04.prod.outlook.com (2603:10b6:303:82::28)
 by DM6PR12MB2730.namprd12.prod.outlook.com (2603:10b6:5:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 11 Aug
 2022 12:33:14 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::fb) by MW4PR04CA0323.outlook.office365.com
 (2603:10b6:303:82::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Thu, 11 Aug 2022 12:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:33:14 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:33:08 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 04/13] x86/cpufeatures: Add LbrExtV2 feature bit
Date:   Thu, 11 Aug 2022 17:59:52 +0530
Message-ID: <172d2b0df39306ed77221c45ee1aa62e8ae0548d.1660211399.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1660211399.git.sandipan.das@amd.com>
References: <cover.1660211399.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69d00bd6-fda8-4713-93f1-08da7b95a912
X-MS-TrafficTypeDiagnostic: DM6PR12MB2730:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCWZnRGtFhyRMzBhxXuTGYeIGT2jKAZHKJ3sVDd3Wte4HtD94Jyotd2ACvxM8LeH5Is5RpvRM9YkseB5icauhvZe2FYuzICnW8Webj/m69+YMmBXWxucKH1htxDVYQaWC5pkgrYnJ6YdrRDw/NSRTkRej5PKOy6rJvrxZ6qfviyDynsx2yFGqS/8WrnnbPFHB4VkBaTzNpxkUaWmC2ZFjjgz+/JL0y8XsVfvrU23+KGwOF9yeA8R1ZOiVEkvxVtGaZ75TgOXsrFvFAfOXKssFGUz2/9WGeMrofvn4KCoX2BVjJ/SfBUlAU71J5lE4DMalFRqxLeWep7nVM4Ybem5UMsVZZBeC/Al1prPJbVJvUiUxPo7Lb+H6JSWDgJdFwxCrbOeGG+Fu9Wl228ZVLCOKsqld4OwdQNO5VZbWLBPkiKljSwSsJBPRrEpHJ0kAJV8KkH9+ixFk3+1Z9Dse7zl3sp1CXmmRPxnLPpG1qqxGKqh81UEpN4prZUhf46q699m6uP0U+B8rLInorsI1DCKcra15HXmuRkXUhvNMpLZbPYwetEwUHxo82bb/clnVZnmidaPMLg/u9t/yw1Y17wMlojruYjeBLhMZkr7Zu1uM8iunUBj1WEzqR9vJ/iIz/e6oY70iQgWbu9d3lzZW+Bu3vPXB59oSjb+AcvPaTG23qHM1oNv0aVI/CTJPbF+mbCj2pzbs40RQTjVIQTtqqBh42kzQ4CIpxj2EI+0Cv79LfTPpCy6ClCoFKenNex/NjtzEvtRKPRyDUA/qBbvG4W/iEyYOZlIVF6XI8MT3FaksvAnFXueKwd4OFbHxzp9rOUov/3YD2CgeKhbsRQ/tkuAQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(40470700004)(426003)(16526019)(336012)(7416002)(5660300002)(47076005)(478600001)(186003)(86362001)(316002)(54906003)(110136005)(82740400003)(7696005)(40480700001)(26005)(2616005)(44832011)(41300700001)(6666004)(4326008)(36860700001)(81166007)(83380400001)(8936002)(70206006)(8676002)(70586007)(82310400005)(36756003)(40460700003)(356005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:33:14.1382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d00bd6-fda8-4713-93f1-08da7b95a912
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2730
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUID leaf 0x80000022 i.e. ExtPerfMonAndDbg advertises some new performance
monitoring features for AMD processors.

Bit 1 of EAX indicates support for Last Branch Record Extension Version 2
(LbrExtV2) features. If found to be set during PMU initialization, the EBX
bits of the same leaf can be used to determine the number of available LBR
entries.

For better utilization of feature words, LbrExtV2 is added as a scattered
feature bit.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 393f2bbb5e3a..e3fa476a24b0 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -96,7 +96,7 @@
 #define X86_FEATURE_SYSCALL32		( 3*32+14) /* "" syscall in IA32 userspace */
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
-/* FREE!                                ( 3*32+17) */
+#define X86_FEATURE_LBREXT_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
 #define X86_FEATURE_LFENCE_RDTSC	( 3*32+18) /* "" LFENCE synchronizes RDTSC */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index dbaa8326d6f2..6be46dffddbf 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
+	{ X86_FEATURE_LBREXT_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.34.1

