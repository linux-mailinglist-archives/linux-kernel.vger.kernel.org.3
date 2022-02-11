Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F914B1DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 06:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiBKFjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 00:39:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiBKFjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 00:39:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BFD25CC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 21:39:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3FPNPUVuDVqNrL4A/NoyJ212jHN1PCHohqflxtlpBW5OFGkpE4tdZTewThdQv+DG7K830mm7eAtqbd4psVO8l71r5utyvz6H42nMLPIfp3mAw3kimqTbgwv8TxMDUddEsE6ZhSWLgfy6Pr5q2gE1+FmIarxANdBPG6oNbaqtltsksM9e4H8enD8sSFTUNjMR8YijW+cakLeV+9Wg0HBBnFmQueEHVQ3Z5QkAVs+OTozqo/S+EDBVPvADQmH4JVBG73MDpckaowYJzbiWGAb40GegBLdIqFnIdnI2mkl6Bg4gYOpDNzKT+kBAnIXICCwiaNnkPp/934zyNnKAHAAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqIAtB+yszVZB2Qg2Nx7xTZFDyUVZAVpePXsJSddbkg=;
 b=ZbIJucb+/ElxZBuZ04b18Uh7ADiWlCHowf+PplQcFkIg4ceYYmjQIP9Jz+2Xr88EiPjJUfNaxo1Z70WfFSsfMTfKBEqn5JB3XUBhFcyG744CyldiXR4gAo9XEZECCW+joXbDteYo379rC7Et8YMz4Qjpnq3s+xXVaYIDu9gH/n02Ajel4S+cXYxaYUShh4u9ITHpec1h9NGzodqFerwSU2rtNOZJcphPB5zoP4BSc92kmOzMTf3+rAuW3pDu7qUlKQ29sjql/eX0mdryQh7O4b95hvhXBNhwtwZF19VLKYa0lHZLnh5V+MM/JmybG39eeDfVi0NDDQvoZwZ/ZJLY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqIAtB+yszVZB2Qg2Nx7xTZFDyUVZAVpePXsJSddbkg=;
 b=CHYOHXYsPcszV9KiuhKpYsFlV2L/XOmZq8GVLnMDlxLyvK6xWYfzwBoxPkdqoOGefOoyWqiG+xh4YfJ2wL/USDmurJiOnqkA+NK8LY0C4pT70AgTFXuqH3U9w0zIWN6+ru5EGE7oKSz7Pj7zo5OuYWsARtq6FN4JC3Z9vMoEces=
Received: from DM6PR14CA0067.namprd14.prod.outlook.com (2603:10b6:5:18f::44)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 05:39:40 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::2f) by DM6PR14CA0067.outlook.office365.com
 (2603:10b6:5:18f::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 05:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 05:39:38 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 23:39:37 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        <hughsient@gmail.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/2] x86: Use CPUID 0x8000001f to confirm SME availability
Date:   Thu, 10 Feb 2022 23:36:51 -0600
Message-ID: <20220211053652.64655-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14b33156-a15e-4724-2dec-08d9ed20e4fb
X-MS-TrafficTypeDiagnostic: MN0PR12MB6002:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6002933D27448236D3205116E2309@MN0PR12MB6002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lY9KwgpdR5o0TGbkvpvX6+hE7EQJ00i29QOffHoPeZowVQAPB62OAq6nW7bBsyNe3GnbXXKt3ju3chyMXDAVKYt+PaAWDG7cmNRDIW05zpgaKnzX9YyANmmBpRi6CaGO89UT8tRBcAoyhFlqOgjhipHPsnMfWlcA/UDbg6ESMZKeNkcwFriFchchuzyFl11gC6GHqhJLxDCK/PxxXB+6A6ghCtzwLfYVlAVCaGK4gWGcaky7q2w512Cxerg56yk+ZiHDKF8L5Jy0qpDGgmoNNiv+IREdfeQCtbYph00DLBgaGu/wITA0YBnG/CpGvLrLpWxam6lk+A3GPGc9fOASFsgRQZ+DQzOYpw2OBGYgauBnGtA+yXtGP34y6CXeHl/c98z6UPhxkQ1/iNL+SisixckvTLL8S0YCrVA1dcCg9qA9uwLVlJeaUwz/3gtozed/rL3fLpGo1D15pGrEVYzjTCs2eTu2tsP9xRkUx1EeV2xnxlADTGrpdQII49ehgtD1TL4UjuX6CJv63i902RuWDfqbT/2/mIz28ltrdNS/IhH0giMGdcStBJ7Bp2OUeyn/gMh1FO8wU3BE5LqYz/A2JvydGjJPxGFMxkQP0KfdFsoiJBeOMjqVntk7FxtL9jDK78p17S3JjL2kv6RwRXpTweVACJ427rHJE2S3jOlFWkCp2tM3zz2wlMbQpDgiA2AV4AIpoPIMQoQxhts7IuK/Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(36860700001)(40460700003)(86362001)(356005)(5660300002)(44832011)(36756003)(2906002)(508600001)(4326008)(316002)(70586007)(16526019)(81166007)(26005)(54906003)(1076003)(2616005)(186003)(336012)(426003)(8936002)(110136005)(8676002)(83380400001)(6666004)(70206006)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 05:39:38.4945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b33156-a15e-4724-2dec-08d9ed20e4fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An upcoming change will disable the X86 SME feature flag when the
kernel hasn't activated SME.  Avoid relying upon that when determining
whether to call `native_wbinvd` by directly calling the CPUID that
indicates it.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/process.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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

