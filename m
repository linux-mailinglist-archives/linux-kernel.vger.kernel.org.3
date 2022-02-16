Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31B74B7EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242855AbiBPDvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:51:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBPDvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:51:36 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914D4B88
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:51:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9rAoiMhVWSmNsqnF2q13de0oK8RHl5b2AuBsW56jWATBJwaROE0BxpsziRxx3TY33CjM4Rj3vCRVPYs0lLWYwmeIgGSs2UwwKtNBoydujeaa6HpKAQo2IA9mnXxvMWGpnzLkqxaiW2kfSMnb8A0n2xkWPyMJpa++bPQ9Vuv+w1abFp7TZM7LMbiKg/kukPNnvS7wAwwsiEB6TjLItEesGbVeL2Fw2WMapmPNMtOJwXMJSivd76HQu39dOeZL8oc7HH00GoNquJ1kEDeM9qHAbA37HDXzVgr0GYaxPrDTFhzPwmF4wF/2IHemXQ1M604EY9y0I17pbFel6RImpZf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEHv6tSW1r58Ybk5HzBgN9SboqAcGwAvBNOiTNaofIU=;
 b=ZjZw5DhF2j1jUPDyrtw/Gnb5m8mTAIHjs0LlOsfYQYjD7Clk6wcm5UZLPWmJOoFevknXtxzbZ7LkDS2yC2sBq3wuykGp/d1r2Blwt87J7rkX6BsMq8YR250kqXB6PuN5OCoubEMwym+oAolXIFcDx00ffNw1qm4BqaWOv2hQ+4MsBzgn9Y3+sBInaR4DVjqdeQw95yibBnSZ1wZw/SBSJ1izL76ucqsLuy+o/TdM2QMK8CWxRkdRtch83YTuZjGe2EU8CTfX53brMi3Yh+xxtMThAkiUNbdS9t6VHeP9m+Wn5L7/7/t+32TlmEPyQdSHD4Hb4hAcQUPMEaumBC0CZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEHv6tSW1r58Ybk5HzBgN9SboqAcGwAvBNOiTNaofIU=;
 b=wEuhAYLOhO8XgQoBv5iR8VCHfmphe3OsoJPFBUUNut3HwPFL7bI+jH3cTIqkTPVJv/ANGUURMgbGO8Gi59ebO8AFVv+6ReSZki3L9gYpB1fOe4hsg/1WReoJgYg1GvbCmLt3iYn0lWgpwh/QBr7/zL1A4HZbiLExJ71tZpVFIpk=
Received: from MWHPR15CA0060.namprd15.prod.outlook.com (2603:10b6:301:4c::22)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 03:51:22 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::5) by MWHPR15CA0060.outlook.office365.com
 (2603:10b6:301:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 16 Feb 2022 03:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 03:51:20 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 21:51:19 -0600
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
Subject: [PATCH v4] x86/cpu: clear SME feature flag when not in use
Date:   Tue, 15 Feb 2022 21:44:46 -0600
Message-ID: <20220216034446.2430634-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f25c3115-ad70-4290-35ad-08d9f0ff980b
X-MS-TrafficTypeDiagnostic: LV2PR12MB5800:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB58006B98100CC49FAC2133CAE2359@LV2PR12MB5800.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4/ypZGtipEm5Y4ToK/kQ5Q0sAlkJo3K+xpy25XLRtytSeajkbu3qy+2IOmcylL7AngyzpW6DIalAftJYwYh6IhclGweKd+AlIOzgE9yhSk/NthBMwMtcFkEiEu1G520Tav2OUh7Gax7RTpp7m7I2+XsU7g066O14E8nYsAyds8ZfSABy14ODelbBmwfb867juww+vPwOlnFhFpNP0yy67dS8suG1IIEsnEhwbZZenDBkiBl/T1nj6GXvM4Ied+eDRQfPDBmA4XvZ8cmnS/p5nLrROSmxkdANfNsQRaBauzHY0GA0ugBPhhp8Qk5Y6CmR86t2u/ls+gfxnbFjBbai8/U6zVSE4vw0FWHPPBYuSAiOIl8ghQybKAZr3SvrRXDV62ZDVoqbbY8zRZraATPge47w1AcVgJN2hlCIe+/eREtuPUQNblU9SfqfjHqpMtCkazNl7iaC+R7N5N8mF7f5+7xhsRZl4743EcyPgXJkeSyLxFwMWTqjENgZSN3KkMaf7Gd54OaXWawp63Fv/hGjXsL4YECJrP32it61UQDjIG5ITgPPEIvpIM0RkIECFUpYrlISwF9nqTJ/N7dCefg22Tk/uzG/DWz89yt0vBkVqt8Xbh5XhXet2gKh2gdc3FMJrOO8uOEoFZf2VG1KVIYS3dWiW4LbaKOwKOPrzO47Qt1zgQgl6XlJoO1TF19OdgeZqQFZ2rh5y/0REMXeiTa/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(356005)(110136005)(426003)(8936002)(508600001)(54906003)(5660300002)(2616005)(26005)(16526019)(1076003)(186003)(316002)(83380400001)(2906002)(336012)(36756003)(6666004)(47076005)(70586007)(70206006)(40460700003)(44832011)(36860700001)(82310400004)(81166007)(8676002)(4326008)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 03:51:20.6427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25c3115-ad70-4290-35ad-08d9f0ff980b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
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
supports the feature but not whether is has been activated by the
kernel.

Change this around to clear the SME feature flag if the kernel is not
using it so userspace can determine if it is available and in use
from `/proc/cpuinfo`.

As the feature flag is cleared on systems where SME isn't active use
CPUID 0x8000001f to confirm SME availability before calling
`native_wbinvd`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v3->v4:
 * Update block comment to explain SME can get turned off
 * Reword commit message
 arch/x86/kernel/cpu/amd.c | 5 +++++
 arch/x86/kernel/process.c | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 4edb6f0f628c..dcfbb25b119a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -585,6 +585,8 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 	 *	      the SME physical address space reduction value.
 	 *	      If BIOS has not enabled SME then don't advertise the
 	 *	      SME feature (set in scattered.c).
+	 *	      If the kernel has not enabled SME via any means then
+	 *	      don't advertise the SME feature.
 	 *   For SEV: If BIOS has not enabled SEV then don't advertise the
 	 *            SEV and SEV_ES feature (set in scattered.c).
 	 *
@@ -607,6 +609,9 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
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

