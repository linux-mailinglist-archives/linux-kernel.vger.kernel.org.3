Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565AE57A77C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiGSTxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiGSTxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:53:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A24352E58;
        Tue, 19 Jul 2022 12:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4UzIan0PdAxBTjsIMYmsD/kW7hC88AqlRUgyIxoEY1n0a63l8zEf48mDWE9qO9goJQayUD8T2R9e8ZJRw8S2KShcBeD5SBhrEh9mfFG+wRMO9vzWBoz7RQ/LnCePJrrxekRbUuf7Uo9onnM/Nx8wlLCVd7my1dagKb8T8thqi+5hH0/U4oXPxZx8nkO2ecmfs1n6tWxY6U6g+LPkyOiQv9sZylDeZhb3nUUG86IStBhMSoFz6GgFiOlcN9d4WD1Z3IZyDddqhVUInONN+nC0R+OiyatMThiQvbyt4Wh2d1JhU758Lsui9a1ZOLzkEL39nifj6BVJeTDwwiMfC7Nlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lraqjdspnUZBgZbHj4lK9hf+TQMDQIspSmx+jDuzy24=;
 b=JZjKfcc8LFar3RtPbhiDcR4hdj13eojjFaDAh94oeQ521R+Z5T9C2bGKvSRB1FldGMz5rCnmfpufg5eEMXYPzPTGKD0Usb1wyIfDZ3ucKM7EO9bUgDQrASzrDZil8RdL5azwih1CEHFrEZcJnb72QUM/20Bhz1b8F8jrX7iViDPIR55xAho47oRCrEbqr+AU+LC6Os3eC0ABZt2biYnOm8ihl1m91z45RMEmcD7N4I3EG2NzR6bnOW27zb/A7kmpkGW51T70SwcbY5pNq3eJwHPDiY9z8DXtod6j6Rvc6CLMbFwCxlGlBa3Bl7Ssz9qgm3EtCYY1989J8eDaEmMxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lraqjdspnUZBgZbHj4lK9hf+TQMDQIspSmx+jDuzy24=;
 b=4mv7bejmnv9eTDoXNheWxbdJHwz191yZA+a9VnoCsdFybkTbVDWAw+3C1A38dwSgvlYozC6/f1veaSuaRtuuLDT+6DUCw1N911kH05upecua6CpO4FfWa7aBcmNBSL2urnQoFTff2Vfr31RHoamqpGP59CBvDIB0Mo9fst/tLKg=
Received: from MW4PR04CA0240.namprd04.prod.outlook.com (2603:10b6:303:87::35)
 by DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 19:52:59 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::b8) by MW4PR04CA0240.outlook.office365.com
 (2603:10b6:303:87::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Tue, 19 Jul 2022 19:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 19:52:59 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 14:52:56 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
CC:     <linux-hwmon@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <babu.moger@amd.com>, <yazen.ghannam@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 RESEND 1/6] x86/amd_nb: Add AMD Family 17h A0-AF IDs
Date:   Tue, 19 Jul 2022 14:52:51 -0500
Message-ID: <20220719195256.1516-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719195256.1516-1-mario.limonciello@amd.com>
References: <20220719195256.1516-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ac4db73-6db4-4c0a-3db6-08da69c0488b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1867:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qrlkzNmKyFISmq5iYGLwzA6ssjD47jZ2MS94H1h4VLh09DwI3HR01TOT0y0VRTyLCb6Qj5hCPu1e2v18O5+Y5vb5BVTCsUKYTXrMzmlbEZ5LBddijpBBR4ieBYtBBGBHyllAt5OZC0j4+N1k2IpZwDqTR4UCSi181roKKnoN7mol5Gdu0n5NKSey4gdYDr6bDGB6u/waZPqCZGlJ4Z6dlWX1cv2wAxKP5KJVOHjycViSTcCIGsfZtgmeSL3Fo7eKxDZlfa65qYi7w1VJyoEDiM0YQK5fOorrhe7qwFREHtdHDCLoA6Fv9c/id8ye3PpTWgGyApg8FvDS30ioLsWHNz3TixYbWdkhoqYNsOEK2FGlStd8o84Ul0ntW8GrAC1nhGSFYINPKkTqxLFMCZ9ycH3NBomcF+5nhoAWYdSrAedM2OzI7Oymj11N+TDHdBzD98bAIuC2O620KwjInGITA/U46wESXpx2/aYt5yuluqMUgCB1M6gAzFkHm8KuIZO6FcYGOAEHaIr+dHrk0fZkklpG0k0weZN8/FJ/wIRLIN6uL4AcUWSf69x4cU8bAC6PXbaviIkeQAvVMkEF+zutiPZ++fn2Kc+hcOJ8onkcdY+MjdvmsjmgOs05jmK+2GMiGSpcr7POjkPoRNqA4zhhmWGmiOOmN/JmQUkBwAXqNe0b3mJzNo84o89JMxJfS2ai004JgrvpJ5TkUM0pCZJhvSXop2qztD4c8VLhsbWu2fyiTJRH5/PBG+rRtXW3YNQf/bzVnhT9gPH+GUyWbOfAtTroaklzT6cI5EfZeCdu13WtteTswS+Dp0WoTwnEY61HFM1y3mm1iSikrhzx9alNQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(40470700004)(36840700001)(46966006)(86362001)(478600001)(70586007)(8676002)(4326008)(2906002)(70206006)(40460700003)(5660300002)(82740400003)(356005)(44832011)(8936002)(7416002)(81166007)(36756003)(40480700001)(2616005)(1076003)(26005)(47076005)(16526019)(41300700001)(186003)(82310400005)(426003)(336012)(316002)(54906003)(36860700001)(110136005)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 19:52:59.6350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac4db73-6db4-4c0a-3db6-08da69c0488b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SMN communication on Family 17h Model A0h.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
---
 arch/x86/kernel/amd_nb.c | 5 +++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 190e0f7633755..60c7bd525237a 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -19,12 +19,14 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
 #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
 #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
+#define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
+#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4 0x1728
 #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4 0x14b1
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
@@ -41,6 +43,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
 	{}
@@ -61,6 +64,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
@@ -81,6 +85,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 0178823ce8c20..ec1c226d13e60 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -556,6 +556,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
+#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3 0x1727
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
-- 
2.25.1

