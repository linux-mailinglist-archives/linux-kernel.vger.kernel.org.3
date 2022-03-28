Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556E44E9D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244589AbiC1Rae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244470AbiC1Rab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:30:31 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3C022B15;
        Mon, 28 Mar 2022 10:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu+VMvWUpGBPkkteruSikd8bizGxzvDeXGlkRfUx0kBCVIALAvstTmOb4H5tP7ynIdIDTq74NWVO7VlURLS5+t2DjxKEcvgY5vIsJ8kEFys5dmsg39XP3byuSVGXvtjpjGdEQu6/23KOY1FPnQ+d+wvNHpcfXP+5lGyzezkJueKujGSpL56Hhm271/tNHMvJMLRJutqsg3/WDUT5bUyzurxD+YC6+W4K1uwzvxjPTM2huJ9H//wOA7jYa7lNwnMF+NT1PF1l5HKkjOoeIQewN9loYyHCLzdeLY2HQoD8l1RyIIgFdKF2tnat8IAcoVTxr17pP+2OPPhUp+h0xiwB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD6dFuRviy6j/GEsp0EBlmm/FpNfFwy25uFYexSkFKw=;
 b=Kwqh1BRYkb0hQjfekQ4Cv1E/wVh0zd406RWWkcLdoqN2kYmOLpASLwkywHQ0beTnd5tzWtapCnPcXUi7wnvp2EYCHN5KK3lQpw3/7aqZCY18wkHH1uRXIopCLEkgr2sU9uzs5e3OcZ2ytUXw06EHGCyH29ZSRiLyxxZo6q8WDFJAXVJf3q3EDIyRZgSf+mteStt3dISx1uCPlNjzIl0mP+mSTIuJkMynUmnmkyQx5JG4723P8MoP4niEI1rIjUuOalwfvuiTKLS6tVav8WRMwgPL1whMF/Cri9VosOkmh4lES7GYEJ+lmnaijQLQgbtxsgieHBdc+Kdr8i1i/dfXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OD6dFuRviy6j/GEsp0EBlmm/FpNfFwy25uFYexSkFKw=;
 b=ukWbaQwXuGrUVM3wBbzyl83JG2H1foxvH/zNAJZxeLXBl6vu/mkC2GkVV0OZQmjC9Iy/yeIMXgdjvEaE98aJSgaUMjEIWpYFWGmDzNBnJLoQBszaoMZEF0e8qTT4jTfaZVVAtxh4JIzb1uV3cyDHBuu8SySznpgiH37w71viUjA=
Received: from BN9P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::10)
 by DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 17:28:48 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::10) by BN9P221CA0028.outlook.office365.com
 (2603:10b6:408:10a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Mon, 28 Mar 2022 17:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 17:28:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 12:28:46 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <hpa@zytor.com>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <joro@8bytes.org>,
        <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
        <iommu@lists.linux-foundation.org>, <robin.murphy@arm.com>,
        <vasant.hegde@amd.com>
CC:     Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V3 2/2] Documentation: x86: Clarify Intel IOMMU documentation
Date:   Mon, 28 Mar 2022 13:28:29 -0400
Message-ID: <20220328172829.718235-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328172829.718235-1-alexander.deucher@amd.com>
References: <20220328172829.718235-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8f3e3d0-47c8-44d0-39fd-08da10e06afe
X-MS-TrafficTypeDiagnostic: DM5PR12MB1884:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB18846AE2C5550E6D789E3EA9F71D9@DM5PR12MB1884.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPN9ZD83f3wW33/3GLaCRDE7qmuAowo9SXKt59YdJCYlDAkhBsLSXcqCs5I+ocq8XVtcBneE/sdnIqvptzmyLmCIQdMXycsx4hl+NHt5VZU23zE2Yt7Jode1Bnl0TzauZlKwp4BsJzrpEFZ/DIvVye/qgJkLRXsBbv0dhB2FwYQ/B2bI5+smi3icqOtDt2cUdwft44e70UsXMeruwNilwIA7RINRnkbFejs0ylud3N+k/mo5DzNtdGZ4u7+OyMZhjTwv3LrbCrbvL+Jvs49Wdx5/E3KCravDBclA2MZjFfdtvSmNQSneMhE3pJH17euQPOsBObe+NOu9+LBqd738Nf51H3+bZpaiHWddIQx6Rih/qdlKPUyfhfQd7ljetncXn1s2TG5EowyKxCi9H5hsIJKAdlzPzgml/I2sHan6qnsbtT/5mXAdztn2/fNupcfv3E9GB1VBXvaVq8O5kmlDavdqMmHjFpnonhcbbpWu13E8eS5YfILkXTSkpBlW2/24lRQFAp+6b492cJtl7qGV/kKq4Z5Bf3/jMY9D+iIxLfht2BgJccIkk1XDuoiTrA1IQz8T3FsbS5jB0hbjtvY/cFANcBTziTdrC9ujDrNgrXgEpzCR4nbB5NallokmGcxlNKJON3l/58nbRbtHttXFf5UnGQWUgtadvbd/f9KbFFMqfd6ui601ISEjcN059SMK/r8OCmbp91mwmYPMzmnWMdEH2UTR0Y3/UosgxkGrCmk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(47076005)(356005)(921005)(86362001)(70206006)(70586007)(4326008)(2906002)(7696005)(36860700001)(81166007)(36756003)(2616005)(8676002)(83380400001)(16526019)(1076003)(6666004)(5660300002)(316002)(40460700003)(82310400004)(186003)(26005)(508600001)(6636002)(426003)(7416002)(336012)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 17:28:47.9173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f3e3d0-47c8-44d0-39fd-08da10e06afe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on feedback from Robin on the initial AMD IOMMU
documentation, fix up the Intel documentation to
clarify IOMMU vs device and modern DMA API.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

V2: Fix spelling error in commit message
    Rework ACPI section as suggested by Dave Hansen

 Documentation/x86/intel-iommu.rst | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-iommu.rst
index 4d3391c7bd3f..17d8497e506b 100644
--- a/Documentation/x86/intel-iommu.rst
+++ b/Documentation/x86/intel-iommu.rst
@@ -19,9 +19,8 @@ Some Keywords
 Basic stuff
 -----------
 
-ACPI enumerates and lists the different DMA engines in the platform, and
-device scope relationships between PCI devices and which DMA engine  controls
-them.
+ACPI enumerates both the IOMMUs in the platform and which IOMMU
+controls a specific PCI device.
 
 What is RMRR?
 -------------
@@ -36,9 +35,9 @@ unity mappings for these regions for these devices to access these regions.
 How is IOVA generated?
 ----------------------
 
-Well behaved drivers call pci_map_*() calls before sending command to device
+Well behaved drivers call dma_map_*() calls before sending command to device
 that needs to perform DMA. Once DMA is completed and mapping is no longer
-required, device performs a pci_unmap_*() calls to unmap the region.
+required, device performs a dma_unmap_*() calls to unmap the region.
 
 The Intel IOMMU driver allocates a virtual address per domain. Each PCIE
 device has its own domain (hence protection). Devices under p2p bridges
@@ -68,7 +67,7 @@ address from PCI MMIO ranges so they are not allocated for IOVA addresses.
 
 Fault reporting
 ---------------
-When errors are reported, the DMA engine signals via an interrupt. The fault
+When errors are reported, the IOMMU signals via an interrupt. The fault
 reason and device that caused it with fault reason is printed on console.
 
 See below for sample.
-- 
2.35.1

