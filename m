Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3387158FC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbiHKMjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiHKMjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:39:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5046167DF;
        Thu, 11 Aug 2022 05:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vr4sFIjP3NzJndP1fhCO/7FRD/q5Bip7Irazvk4qAHSaBpvt/hWLGmYH/Y5/EFfZMU2XfQioNLOVd8TK7rfHR9LrH2ns//yWqq6On2Ch/ZXwSbehLmMpP78ffv46v0YGii0lLDMQg54Nsz8MqiDgYlhwkV7C84uXxG/DnbM5VroFNt0/Jny7cBZ01VreYg4hhSMt1RnzhOb0nJ6timdO3fH6djdvvnUykCZewHe9Qjpqjc7DcHzvnxvqGgWIFL6dcM7tV46ppOvEnlT5TnSXt2A9kYDqSwwL4vG7piow4bjwpPWIjBZksosnZya6ZrZtw1y/Olfqi1U8VZu438y03A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYCpHGH1VgtMWzcYYpOhNUiLopgN+3M9EpvYJtDg8Cg=;
 b=iPVbmk+i9PZQjDW+0E2WsZoJfFZMMIkRDX8LuarUIsxVT7ROmZdNaqhRBY0IOo3oZmHV4d0DYfC7aV6pv/nPfXF4dqbhTVGtt+VT3LDxJ/xhMOxBCr2ot2C17GWU9KvOyvpVAOxnfuS3dsqJJ+QGqwcq1+Z6U68K29ux9vXL6ICuctnww5GK96H5RhSuKOwnivq5/e79QsWGOS3nFmEXDnoHhnzRabxJalP7ftsNUbPAf4yQ2tBchTlmJhP+6xz/jMgi08wMLKJ0CB7mJQxkZlU0byCKdOZ7FeXNQbAwGFMZoWw4P58By3Fv0hrXN9jEggqEbb8oN/WqttjT6eGpQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYCpHGH1VgtMWzcYYpOhNUiLopgN+3M9EpvYJtDg8Cg=;
 b=wQ3uejQYGjfDnTXP0YCuev1tRrfKGkQOOGTfBuXsqZGzxFQIW0RNxwIB3/TdGY+3e2U7xK9TZ7QhSkYIt/LtUwfZiXX6hqbmDAOQ9CmvJPeWbhX32zkYlkn66Mk60OUQ7ImN4ZOZuwwy9zLC9+SIa47srxsXMjFAVUdrdkdDxhQ=
Received: from MW4PR03CA0150.namprd03.prod.outlook.com (2603:10b6:303:8c::35)
 by DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 11 Aug
 2022 12:39:42 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::69) by MW4PR03CA0150.outlook.office365.com
 (2603:10b6:303:8c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.12 via Frontend
 Transport; Thu, 11 Aug 2022 12:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:39:41 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:39:35 -0500
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
Subject: [PATCH 13/13] perf/x86/amd/lbr: Add LbrExtV2 branch speculation info support
Date:   Thu, 11 Aug 2022 18:00:01 +0530
Message-ID: <ddc02f6320464cad0e3ff5bdb2314531568a91bc.1660211399.git.sandipan.das@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b1af6e6f-cdc9-4c5e-03bf-08da7b96900d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1418:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Kba9rEMJ7OaPKD4vbD9xf6Hx2Czop5JdNQZzhW1/X5oQxrBItKbjDW3gah9BSgZ+pvvOAObtbBEgc+QZUVf0HAcxiGymfTOJxgR+svcku7Q7fAR9czhAPecK0qg3LA77X4ca3XH7INfq1T5Y2rjIGumyjBuSLs05tMrsI75+8mfbcH/KASU5XbNTBS6JyO3VdMRCR+AtdGAiUVDuwX8MGtCxTqkz4txyclonWyq+sKSKBUpB5W9NjyX2s+n5BGqgYxI+1DjElzvEPYGDKK4Am/wKr71YVWloYhtlMb7USgJc3sK43q+RoieC7Ckzy1WilVDxO75By5g7pI2sQKPjAJqmmzfiNCE7z3RgXX2q+g3sDpH3EqC7A/hEnNIRbrGTu5vZt2K/sC9r6cf2x0145YYG13A14jpbemoEsvZWIhJkPoGe5HdBsth5k8WBs1jfOCHijgbYvgywu1M4Duv0Gzbe+eBbsWg51i/mSJqcTuKceg82bFMey/fubHVKFTn40AGVJFbSZpSkPBrs+WaB5SsWGio6ljQM7kMOznbI3Sy6m1Bqc3rPIA4OXPwgAVewMdfnCxzBxQu0cB7Qy/rLX4MGEd09mejnzOT6x6RviCOGMQb3HrmFjvQTCdpphTZtOyOA/Y221phYa+5gFlibUXIMeE/Vk8e9s3C0yZWWJwrRSiX1uHrEJVPMM6CR0cfbvdJ1cF8KnXxrUR2DLZe+IT7EqnUSk4WBt46c01N0SM2acu/zkdeFGNGVHb0Vb5b3eiFnay7RwYSd/ae7hAZq4MTs8OIfWaMmNN+e/YMB+mOJwhycFiX7C9q54njjVGaODKog17ukD1ClyKuOmniPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(40470700004)(46966006)(36840700001)(26005)(356005)(5660300002)(36756003)(82740400003)(336012)(41300700001)(478600001)(2906002)(7696005)(81166007)(6666004)(40480700001)(82310400005)(70206006)(83380400001)(2616005)(8676002)(110136005)(86362001)(54906003)(7416002)(4326008)(426003)(36860700001)(16526019)(316002)(40460700003)(70586007)(8936002)(44832011)(186003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:39:41.6710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1af6e6f-cdc9-4c5e-03bf-08da7b96900d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide branch speculation information captured via AMD Last Branch Record
Extension Version 2 (LbrExtV2) by setting the speculation info in branch
records. The info is based on the "valid" and "spec" bits in the Branch To
registers.

Suggested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/lbr.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 5fa985cd44cb..3fd316b6adda 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -146,12 +146,19 @@ static void amd_pmu_lbr_filter(void)
 	}
 }
 
+static const int lbr_spec_map[PERF_BR_SPEC_MAX] = {
+	PERF_BR_SPEC_NA,
+	PERF_BR_SPEC_WRONG_PATH,
+	PERF_BR_NON_SPEC_CORRECT_PATH,
+	PERF_BR_SPEC_CORRECT_PATH,
+};
+
 void amd_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_branch_entry *br = cpuc->lbr_entries;
 	struct branch_entry entry;
-	int out = 0, i;
+	int out = 0, idx, i;
 
 	if (!cpuc->lbr_users)
 		return;
@@ -160,8 +167,11 @@ void amd_pmu_lbr_read(void)
 		entry.from.full	= amd_pmu_lbr_get_from(i);
 		entry.to.full	= amd_pmu_lbr_get_to(i);
 
-		/* Check if a branch has been logged */
-		if (!entry.to.split.valid)
+		/*
+		 * Check if a branch has been logged; if valid = 0, spec = 0
+		 * then no branch was recorded
+		 */
+		if (!entry.to.split.valid && !entry.to.split.spec)
 			continue;
 
 		perf_clear_branch_entry_bitfields(br + out);
@@ -170,6 +180,25 @@ void amd_pmu_lbr_read(void)
 		br[out].to	= sign_ext_branch_ip(entry.to.split.ip);
 		br[out].mispred	= entry.from.split.mispredict;
 		br[out].predicted = !br[out].mispred;
+
+		/*
+		 * Set branch speculation information using the status of
+		 * the valid and spec bits.
+		 *
+		 * When valid = 0, spec = 0, no branch was recorded and the
+		 * entry is discarded as seen above.
+		 *
+		 * When valid = 0, spec = 1, the recorded branch was
+		 * speculative but took the wrong path.
+		 *
+		 * When valid = 1, spec = 0, the recorded branch was
+		 * non-speculative but took the correct path.
+		 *
+		 * When valid = 1, spec = 1, the recorded branch was
+		 * speculative and took the correct path
+		 */
+		idx = (entry.to.split.valid << 1) | entry.to.split.spec;
+		br[out].spec = lbr_spec_map[idx];
 		out++;
 	}
 
-- 
2.34.1

