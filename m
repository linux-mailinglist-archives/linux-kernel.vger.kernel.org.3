Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCD856A8A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiGGQwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiGGQwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:52:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025CE326D9;
        Thu,  7 Jul 2022 09:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJEPunSvkxCrkUA4zx3yPBndF7+tZnbcA1Tpv9M6TC0PJvcOesODZFqR6IsvMcQQVRzx3w0P/Ik28B+jhpIeeNZ72P7zdfosQuXGZz9/APIjGSCIsDjcjXNIuNrqSkWYHwYOw8bWPFfkICUBQdvuu6nbOi4t4vAERKwL+kO8RaSXF8tkIigR+sbS3dMpGpf0FgTByrVd4K3IuUWmpqhzg7YIoTFXCc5xlSTPsejTQITlm793sm7cwL/ErdprntoUK/PBbOZKC44hNS3E50FJmAmicT9BhAOoSMld5rsX7E59gDJ80ecfg6yaSh+siBnCfP74YHk95ymnYlBBAxyW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZjYVInbbsLWr3JkIKw3CSb4z2A1d1LNPl48JfqA8SQ=;
 b=X0Q/U84aXODsN5x09fz9j2A0SEYey74Gf/NlpjkbLmuVYgg6Apt2OdQjSiaE31RHQqYR7+rs1+ZCP7TLhYn932DICcDkiNT6egIigE/mQc46bA5bEURJlYhFeH5gwMCIXcY49iutEdILgpecAPtOtegvB90ehlJyOmNWrDv0QDO2lc1gexSycdrnaC1jUn8Mpxca3o6sIda8rSCO7ECUIvEf8Xcebde4BcYOKiQkgsXC73lhELrTnV1+UpAlGEpsJyryGI8XvLCMVIKuYlF2lSrIS5vMPD/Ul4DR/uQsQESQh8WjpAbMF4y9auxNeLFfKwVNv0flL2oNl8A3xZAmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZjYVInbbsLWr3JkIKw3CSb4z2A1d1LNPl48JfqA8SQ=;
 b=e3KbPufNfZy9gri57HOvnTksqY/ehHZ5Exnf6X4PeW2l3DLrG11UD+nLGgsVgyfusqxeXxNOgK+tPj3f/RD7w7FIfqD1gAZz13c2rT80XJc7jnSzRiE9C5UdH5eO/U0ufkK+BmKYaoAS9LJRoO1sRgNM+7FVH4TDeVRYicfnvyw=
Received: from BN6PR22CA0028.namprd22.prod.outlook.com (2603:10b6:404:37::14)
 by BN6PR1201MB2482.namprd12.prod.outlook.com (2603:10b6:404:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 16:51:57 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::77) by BN6PR22CA0028.outlook.office365.com
 (2603:10b6:404:37::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Thu, 7 Jul 2022 16:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 16:51:57 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 11:51:50 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Huang Rui <ray.huang@amd.com>, Tony Luck <tony.luck@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH 01/12] x86/msr: Add the MSR definition for AMD CPPC hardware control.
Date:   Thu, 7 Jul 2022 12:51:36 -0400
Message-ID: <20220707165137.211400-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa90c8af-c751-48b2-a3d4-08da6039013b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2482:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hmDu6B4aqLihL8HtdUZRsU4bJ9pNWPfxEkWH/XIAybSdW1V2i60WUAmdkJfJ?=
 =?us-ascii?Q?b7JDfIBXSMJx4w0MjnYl8Vl/ScUYeY+EWZBBHtYUA7Bv2u9cLOqTk97ydwOr?=
 =?us-ascii?Q?kZwmyXSeiepSVjtTY52mvv4wOfDhhCtIBGbLu5+HFCBdR/U6kti6Z8fRmpKu?=
 =?us-ascii?Q?mcm7QPVfxMnrLrxzwo84AsAG/UuKdaMK2O4NTiRYBDDRFknZveaNn0rudk1a?=
 =?us-ascii?Q?6ZvbWgDAEF4oJTiN2oaIwkMQC8ZiY6RW30Qkkivi8VDy2xtfK+UXU03se29A?=
 =?us-ascii?Q?1kMcP+AWVl39oxFIqZf8qJllIICQ75LA/hVDyY8/Iz48/D/2/OZQiCxi91SC?=
 =?us-ascii?Q?N/cv8rY3emQJddKWXEXXOc1vpHBWerlA79f1zN3RwMBZSgJkQrwVGBnwN3Mz?=
 =?us-ascii?Q?ZlCWnX/uojAGRsPUlUA94inNmn9vtklXC3ObttL5uUw9DZMfBPn/rbacb+p4?=
 =?us-ascii?Q?+FeQuaIP6+DiHyTxCzEYta/JZnLBzMoi/axeOp1C2PRAPmlmf0MghLKVTghL?=
 =?us-ascii?Q?8W20qg6CkNtRHvSBFAhcl6sJwe0NVojNAJpa6Q4LhOWrNg27leaZlM4r/oxQ?=
 =?us-ascii?Q?GDRDAFNEeKhLwu8bJE7yxhVYOMOgm6O9k2KHei+mq1da5FxJYPdQXNK4tELk?=
 =?us-ascii?Q?zWFlFeudJePJX7P3nRCn93WEqRXEhMp4/Wtk0HZCJwNzu+cQ2rXB9KnwtxMK?=
 =?us-ascii?Q?NcORXi5+KM+1honSpv1q2/Zyzb9Q2ed6I922xq39q/peLnmQUTXGeL6MQGXs?=
 =?us-ascii?Q?PL+ErhCvJPpLomUE//DL+zgR3r5cZYS3vVbzqTMzYsdlI3IHeU1/H2Lx+yrY?=
 =?us-ascii?Q?T02w6hpH71Jum0hf3e1mlXD4mUuwvAkhZN74Ag7bPHAGdJQ3ShYMOIH7Q1LW?=
 =?us-ascii?Q?40n1kPjAXUlkrkowyswcYP696Pr4Y8g7nG5jGdiTon00vlQRE1REMN64LAxo?=
 =?us-ascii?Q?5hnPWX2/MNxFoUJTLOniBYawJR8LL1fM4HK96A+XfzU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(82310400005)(316002)(36860700001)(54906003)(40460700003)(110136005)(426003)(186003)(47076005)(36756003)(26005)(16526019)(34020700004)(336012)(7696005)(70206006)(4744005)(5660300002)(2906002)(8676002)(86362001)(1076003)(7416002)(478600001)(70586007)(81166007)(4326008)(6666004)(41300700001)(966005)(40480700001)(82740400003)(921005)(2616005)(356005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 16:51:57.5653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa90c8af-c751-48b2-a3d4-08da6039013b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This MSR can be used for controlling whether the CPU boost state
is enabled in the hardware.

AMD Processor Programming Reference (PPR)
Link: https://www.amd.com/system/files/TechDocs/40332.pdf [p1095]
Link: https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip [p162]

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index d27e0581b777..869508de8269 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -548,6 +548,7 @@
 #define MSR_AMD_CPPC_CAP2		0xc00102b2
 #define MSR_AMD_CPPC_REQ		0xc00102b3
 #define MSR_AMD_CPPC_STATUS		0xc00102b4
+#define MSR_AMD_CPPC_HW_CTL		0xc0010015
 
 #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
 #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
-- 
2.25.1

