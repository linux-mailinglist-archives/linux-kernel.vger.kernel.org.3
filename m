Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87064B5E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiBOAAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:00:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiBOAAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:00:34 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F067D40A30
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:00:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9ohbPc9OY/s2XSJ+e0a3acL3hBT9xVjKi/M/H5sIbGZnoleh53HcwU5v5IV+KQtCGvWEtXX5wp1o1/AWdjl/yeyqU1qgtgt0KQXYb6iUZFa6sfa2sGQdtbF3OhSd9a2MXkSrH2/JmX9YyZHRUugA2/nlxDqtw13dtoNjEOrzX6u9xKgw5U6/3JJLa8kAkIa4dCqmeSbfvtTfoo28q56oxRqueD+bZHbfgWj4Z4GA5s7VRp2TM3eumPxzzdvL/oqofWeDxhNSwLP2Zay5CmV29lhsvBvy7NKhca5siuqN2NFixH5yBcZJI4P6mqKoaAfn/IrZIAeODDwyYFOVU1R5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m+khP40jw3Nmgzgv8CUk2CeRg/5iPb6gK2L4CWgrFs=;
 b=C7PQDP0Iz0/EqKMgysJXRGldwCtPB3suZxweQUy0yNktgFjYgd7jux1a8TlUoOW479NcsNts9zzxD7aLeBrgkPLZDDAk4BCZc4GQs3YJBgF6dSa18/qsRicEZOE/FDoOhvodh5M5HnC9ioMgghO7Amn4R4Tm961scvI6grvPWgFjJeEaWQ9TVyX76CvunSXnZ8lXwqnKynmDZRcYTJmZgDc/Ro71WO1hYf4fWIAND/QjR5syH4KXRzaSsaIbky1HjPtM/wriRtz6RpUwUVRZYoUcjxW/oV9P7SXkh/kvpXBqPGQ1gN7uRSuwfCV+56pXlxmcFKPOogs861hRtn789g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m+khP40jw3Nmgzgv8CUk2CeRg/5iPb6gK2L4CWgrFs=;
 b=1VLyZo1kOHgEYHzDCvLsxB+pZHtA4YGTGah60Txjm7xwM31UWu3D6YvvNfMaXiaoZ2PX76c92JfZZALnsY2gZdxCE7C2xbbanfGSbUaCcr/BmMP/sI4ciiz21gDLhnFbyzzZCuthHRCl/Pr0J3Mn5dIFM+IX8WnKB9Pj2kCCKGE=
Received: from DS7PR06CA0011.namprd06.prod.outlook.com (2603:10b6:8:2a::6) by
 DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Tue, 15 Feb 2022 00:00:24 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::5) by DS7PR06CA0011.outlook.office365.com
 (2603:10b6:8:2a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Tue, 15 Feb 2022 00:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 00:00:23 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 18:00:22 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        <hughsient@gmail.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        <linux-kernel@vger.kernel.org>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3] x86/cpu: clear SME features when not in use
Date:   Mon, 14 Feb 2022 17:58:01 -0600
Message-ID: <20220214235801.238260-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fe44da9-8ff8-4b11-ed16-08d9f01629ea
X-MS-TrafficTypeDiagnostic: DM6PR12MB4233:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB42335AE633F378B127783BA6E2349@DM6PR12MB4233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQV1tQelg7DiEUlIOkUaGqiMrCoYApEtOOZT9t1ZHxQOHulq36WQPLUwLUl8iOByzukW8c/nQQflrjqfiNv9hQoEb3w15mZeOS8/KjBCVTkAqxE7nRAAO3yqqz2gvnNErcfqpkNs3avjTkg5XvyL+/G0p8M5lrh4qIQ+9TVIdHEbhV2BggBc6gd31JE7x15ZwqKC3VbsUgGSdi9PoWgIBvesdvKomLeVgy5P/PDL44DFJr5LdS04VosYBJGC8Ga92ey/+uxyeCEuGx+h6FV2jkzvq2HStrXDtS+R+7tNTWg9HyS/sviAXwdZSIL6uLE4fm6jLAdp1FdOCQfcqzroydjjhqdj6DcnmljIiDGQf5FMCQ3paLRXRiSsqn+yaFrIQgWNgqtb5BBjth/yXE7NXjh06lQWOy4tcHNni+Oxe879/Yih2pa3xD/bXpZ3L3xAdbmNuq8pslmkHxxEYjfxPXdliLpL2MCNwzEHhyDB36+SFbiGxsxOr2qo7l/zQvbMd1AYYXA4cSs4LDF7aEQ8VNWPoAWaEBW1rdbKwfqTm5ipDRISRxrkPKWn6kl2gg47jB931gMb8p5MD8H/jVnzbWlap2APoBXdVNXxTkSTcpiH42JXqA7Z99qzMqMo7JDgN4yN6negDMaq+XG8CepSe1wSzC8RDTmgnK4CRMo4fRFV2h8q7d3iBUPOObT9/vEW0oB8kgBP6OD4+2ayTZ4gFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(8676002)(70586007)(70206006)(4326008)(426003)(6666004)(86362001)(508600001)(2616005)(83380400001)(16526019)(1076003)(26005)(82310400004)(110136005)(54906003)(316002)(186003)(36756003)(356005)(2906002)(81166007)(40460700003)(47076005)(5660300002)(8936002)(44832011)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 00:00:23.2063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe44da9-8ff8-4b11-ed16-08d9f01629ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the SME CPU feature flag is reflective of whether the CPU
supports the features but not whether they have been activated by the
kernel.

Change this around to clear the features if the kernel is not using
them so userspace can determine if they are available and in use
from `/proc/cpuinfo`.

As the feature flag is now cleared on systems that SME isn't active
use CPUID 0x8000001f to confirm SME availability before calling
`native_wbinvd`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v2->v3:
 * Drop all changes related to SEV, these will be worked out separately.
 * Only clear SME flag rather than all flags if sme_me_mask is not set

 arch/x86/kernel/cpu/amd.c | 3 +++
 arch/x86/kernel/process.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 4edb6f0f628c..8421b9d9f552 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -607,6 +607,9 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 		if (IS_ENABLED(CONFIG_X86_32))
 			goto clear_all;
 
+		if (!sme_me_mask)
+			setup_clear_cpu_cap(X86_FEATURE_SME);
+
 		rdmsrl(MSR_K7_HWCR, msr);
 		if (!(msr & MSR_K7_HWCR_SMMLOCK))
 			goto clear_sev;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 81d8ef036637..e131d71b3cae 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -765,8 +765,11 @@ void stop_this_cpu(void *dummy)
 	 * without the encryption bit, they don't race each other when flushed
 	 * and potentially end up with the wrong entry being committed to
 	 * memory.
+	 *
+	 * Test the CPUID bit directly because the machine might've cleared
+	 * X86_FEATURE_SME due to cmdline options.
 	 */
-	if (boot_cpu_has(X86_FEATURE_SME))
+	if (cpuid_eax(0x8000001f) & BIT(0))
 		native_wbinvd();
 	for (;;) {
 		/*
-- 
2.34.1

