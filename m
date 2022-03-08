Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2208B4D20DF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349369AbiCHTGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbiCHTGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:06:12 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0E93A5F2;
        Tue,  8 Mar 2022 11:05:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fglkX5YsH7wnefmXHtUplbijYuJ3coTFkZustvUfvGwatNZTaiFSXh458OwbOtzUEOIRbknlLsqS7Q8oPB8fTOP5LqPkhX4uupT/7H9iKT2UHQkTrijQ2qosiX7Uu4bI2am8yi5WmDPdZVzclyrJHp67HVALU5+IpC2lrGj7QYucD6Nib1D7rG15rnpNNfk0rvKsbdY0hGuf0krVRXuMIqD74pbRnU2CigJskgYr6/O6MOxQvH3fI7l5jBIwug7DHF61yYnxkdX2ngJ1otLkI2zjL8CHjZrQYHEZC/M8DItzLbp2DTdVfXbmZ8I25+JTdWKqiH/KLKT22CK/62UyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sqBVO76QF+x0lgrVfX6lEzx/CHKqUZ7Y0WSLbidHV4=;
 b=nGQNOYcQJ2Rj7AseYbEjZsueU0YLTJpWIZ3nVfxUG+d/jkpN+bZ6A87QzezGF28MsjOibYlZ2XRYBCpzzqr0vnCqlgTbOyYQB0V8VWnITpfrnlCebNjPaga83fStZqNFs5mm6GeulyaUFBL1ryj7u9jRwZUveDZKuEPccnM0ll13FHNrQqIDcLA4BG7uOG3hHAOg4INsy3GoLYNJAl8+K++/+spYN08jQMxTJgKtzlJ/wmmN0LYaCnDLwzn+/mir6dfwb+XuQpzmfL8yiPhrl8Hh2d4XjR6rOs5vBYNgZW8Ce2idIhRUFj2jvqutaVsU6NwJVt/n+ZyTN56wy/hopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sqBVO76QF+x0lgrVfX6lEzx/CHKqUZ7Y0WSLbidHV4=;
 b=jqsOicIFGlatHbOZq+Z5n0Th0IorR1eLNunXtySp/J2vOU0hXwtYvqTSAdPMalbUnY60Ha0gfM/+iQBrUnVgckUAE3vFWY/KdaRwO6/v52EWtLtRXQCbphvwtP5qnAUaNmgAMLmrb4kl9iUgwWXqnWgfvxZLS/eA3KmnvUNtUxs=
Received: from BN9PR03CA0310.namprd03.prod.outlook.com (2603:10b6:408:112::15)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 19:05:13 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::3d) by BN9PR03CA0310.outlook.office365.com
 (2603:10b6:408:112::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 19:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 19:05:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Mar
 2022 13:05:11 -0600
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <hpa@zytor.com>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <joro@8bytes.org>,
        <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
        <iommu@lists.linux-foundation.org>
CC:     Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Documentation: x86: add documenation for AMD IOMMU
Date:   Tue, 8 Mar 2022 14:04:53 -0500
Message-ID: <20220308190453.135068-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f9c99c5-833e-497d-7180-08da01369312
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5951BA93FBA7B354446579EBF7099@PH7PR12MB5951.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vd0tvjOCNflMapdZy/62MKr+eX8GbG4oCsqN2QnR5sugsDWW3n21I406NKpPMBG7D+gxvm8CackwhhdWgILUwFzelZjEKdYCSTAiR82MlNaGYOIXQeiGdTIdPFOokziNgHWFPwWFFLIC4SLEdobvdDjqpsPahWhVXS4m9pcNg7e5Sk8AgqySqhqR7P0US0L1vD5gHSeQKpVmrYbM68LIUM23t7eDOJ9oOvmCqlQHBvtHDN9TOf0AkvPufDNggl7Ww7O0EwlrW5Z5Lj4wfEt/MxeCbTO23Lw+175fL03lQj4rYuaZRd55SX/3Przq/sf0pD/eSLWf+UBLYZVHujdLGMkP3WOJKPAvmVSR432j0a91xNNphtt3+nkEmTiytWsQSrHNaSG+i964dCADd1MTr8YP+soAfj2/Zs4h/9RTsV9BkVynF2OV82pyHLXSmaoEAvvlV2m/FDd11RMFCd3WWdJea3baK/GCYsyeanRJL/2eB64YJcH6UNatTZoceuWwuEe0twKKVhPleqMYt3oVeMfY6BDxpEMudaGOYFWBbIgScCLfzpRvCAAkxaTW5L89wQ8m5s1744h+c/fIarK5VONLwsMBZ/JTbRqGvDSAvLZJZH715eEgdAaK/KWN2AMk+1VIkamutN/XSyBPatzH7c89DAUuX9jT995tjBjqOEwebuKX7Z+emDwZsVv1qJmh6+iOSTg8p9SHWn+TYFerajonGuV8GjI5hW5CPfO3bUVfW1BOLGu8Xr6SmR/LzkfPKCpR5jIGjIst7jd0nAXrtPP4KGvYewPm2kum8D2u9hQ4h4SaEsjthHLlt4ZIXag7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(36756003)(40460700003)(83380400001)(186003)(5660300002)(47076005)(8936002)(36860700001)(26005)(7416002)(2906002)(426003)(110136005)(1076003)(8676002)(4326008)(2616005)(81166007)(336012)(82310400004)(70206006)(316002)(70586007)(508600001)(356005)(921005)(16526019)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 19:05:13.2574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9c99c5-833e-497d-7180-08da01369312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add preliminary documenation for AMD IOMMU.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/x86/amd-iommu.rst   | 85 +++++++++++++++++++++++++++++++
 Documentation/x86/index.rst       |  1 +
 Documentation/x86/intel-iommu.rst |  2 +-
 3 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/x86/amd-iommu.rst

diff --git a/Documentation/x86/amd-iommu.rst b/Documentation/x86/amd-iommu.rst
new file mode 100644
index 000000000000..89820140fefa
--- /dev/null
+++ b/Documentation/x86/amd-iommu.rst
@@ -0,0 +1,85 @@
+=================
+AMD IOMMU Support
+=================
+
+The architecture spec can be obtained from the below location.
+
+https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
+
+This guide gives a quick cheat sheet for some basic understanding.
+
+Some Keywords
+
+- IVRS - I/O Virtualization Reporting Structure
+- IVDB - I/O Virtualization Definition Block
+- IVHD - I/O Virtualization Hardware Definition
+- IOVA - I/O Virtual Address.
+
+Basic stuff
+-----------
+
+ACPI enumerates and lists the different DMA engines in the platform, and
+device scope relationships between PCI devices and which DMA engine controls
+them.
+
+What is IVRS?
+-------------
+
+The architecture defines an ACPI-compatible data structure called an I/O
+Virtualization Reporting Structure (IVRS) that is used to convey information
+related to I/O virtualization to system software.  The IVRS describes the
+configuration and capabilities of the IOMMUs contained in the platform as
+well as information about the devices that each IOMMU virtualizes.
+
+The IVRS provides information about the following:
+- IOMMUs present in the platform including their capabilities and proper configuration
+- System I/O topology relevant to each IOMMU
+- Peripheral devices that cannot be otherwise enumerated
+- Memory regions used by SMI/SMM, platform firmware, and platform hardware. These are
+generally exclusion ranges to be configured by system software.
+
+How is IOVA generated?
+----------------------
+
+Well behaved drivers call pci_map_*() calls before sending command to device
+that needs to perform DMA. Once DMA is completed and mapping is no longer
+required, device performs a pci_unmap_*() calls to unmap the region.
+
+The AMD IOMMU driver allocates a virtual address per domain. Each PCIE
+device has its own domain (hence protection). Devices under p2p bridges
+share the virtual address with all devices under the p2p bridge due to
+transaction id aliasing for p2p bridges.
+
+IOVA generation is pretty generic. We used the same technique as vmalloc()
+but these are not global address spaces, but separate for each domain.
+Different DMA engines may support different number of domains.
+
+
+Fault reporting
+---------------
+When errors are reported, the DMA engine signals via an interrupt. The fault
+reason and device that caused it with fault reason is printed on console.
+
+See below for sample.
+
+
+Boot Message Sample
+-------------------
+
+Something like this gets printed indicating presence of the IOMMU.
+
+	iommu: Default domain type: Translated
+	iommu: DMA domain TLB invalidation policy: lazy mode
+
+
+PCI-DMA: Using AMD IOMMU
+------------------------
+
+Fault reporting
+^^^^^^^^^^^^^^^
+
+::
+
+	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007 address=0xffffc02000 flags=0x0000]
+	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0 domain=0x0007 address=0xffffc02000 flags=0x0000]
+
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index f498f1d36cd3..15711134eb68 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -22,6 +22,7 @@ x86-specific Documentation
    mtrr
    pat
    intel-iommu
+   amd-iommu
    intel_txt
    amd-memory-encryption
    pti
diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-iommu.rst
index 099f13d51d5f..4d3391c7bd3f 100644
--- a/Documentation/x86/intel-iommu.rst
+++ b/Documentation/x86/intel-iommu.rst
@@ -1,5 +1,5 @@
 ===================
-Linux IOMMU Support
+Intel IOMMU Support
 ===================
 
 The architecture spec can be obtained from the below location.
-- 
2.35.1

