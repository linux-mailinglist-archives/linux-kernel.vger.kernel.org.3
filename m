Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB850C0AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 22:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiDVUQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 16:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiDVUQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 16:16:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD2923956D;
        Fri, 22 Apr 2022 13:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7axkxW61hGORC/uqUcKw6GS+5YgcKP31zFHvYq62RgxpKsGQPtHJYIide610YQsWrfH0Xh6X0rj42am9VElrpgoEMq2FCaldxISBBHHShDdcuXJwB/QQ5KAz1bkRrsIg+yJmm7FfCbakrULv+R2M3HCwTk7njzq5p7PLbxQssYOvgodAQgL55kdCywKatR2h9T/8BHA09JeH0QE8nJn9O0hFqibhHvAQrkcb1SXxlfnC/LjouEnx6lrJBNwuUdrWm/mt80pQ+u23gQ+Zg8EJbLG+/km4vGmcxGxORDReusf24lPU514N8wHLjoGIQg6mN9dM4dbCW8G2KpClgtwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nq8pB5EiIPJ8OvLCkvBJ//nvB8j11WcfakPs+zZTgQ=;
 b=MX3Ju3WnP0/pXBNEraqRc/LX38D75+PwdDry8rfxxrvVCXf5esAMqcDE9uEUF5V0GsT+/ZDoGpfOLh0DiYganqpujyAVsVGOzCs7CMSsAWM/3N88Kp8iorooDYkK91ZxgQvquHSS7hUxDD7NSftNATSCNnTeU1TGec0xRyyx65tlvXbNLxlOi5hRJM2PMUNgAMs47weNTJcqkoIGg3I794VpMOpjWT11IQ82Vjd+O8DckqGjS9YJV0aKe8lihM2ym1/NSinMdmuqQdbP/FYPjIjs5rj66hI0IqOQt+zasliZUkLn14hMgSDLfdAXBxfEe6ZtEO7OkvMOLmyjydpwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nq8pB5EiIPJ8OvLCkvBJ//nvB8j11WcfakPs+zZTgQ=;
 b=v+1mX+E56eSAfY6toQew36bAo/WOsegOb8MUbCAXkU4Sjmzk3ryBYuR1lfu7i6cbkYEXiz+4SGXIJPO0t3MSbe3tvQYVDorpyA9ePaNYbr/8pEF/zA3FotUDXa2K0dv1mI/zjc03s3xnzPIUFISTqb4bS5i8UgrwANIVvZ3Oi4Y=
Received: from MW4PR04CA0136.namprd04.prod.outlook.com (2603:10b6:303:84::21)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 19:27:11 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::b0) by MW4PR04CA0136.outlook.office365.com
 (2603:10b6:303:84::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 19:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 19:27:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 14:27:09 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <hpa@zytor.com>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <joro@8bytes.org>,
        <Suravee.Suthikulpanit@amd.com>, <will@kernel.org>,
        <iommu@lists.linux-foundation.org>, <robin.murphy@arm.com>,
        <Vasant.Hegde@amd.com>
CC:     Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5] Documentation: x86: rework IOMMU documentation
Date:   Fri, 22 Apr 2022 15:26:56 -0400
Message-ID: <20220422192656.624920-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35556068-0649-4173-a007-08da24961925
X-MS-TrafficTypeDiagnostic: DM4PR12MB5793:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB57933B2DCC14F814CC981F4DF7F79@DM4PR12MB5793.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljZV5j56y0xO6fZ8Z91QaYtwbmW3BGg6XFsgvJMH29STNLAC4vpYNebIesE3DarOKVAjWQU8db+dfi4nfsLPDx5ZJU0eL8hw7lyTG5uIo65bbqw5d3388BQga5QfXp7nadTVdEKj8hS1YzONrZtE4OejmJbgJiJwySNnhd0SkF4RTNUEwWtXTop80x6dRBKNhNTjynxJU90dGVanAJAyvIk5NtuEnIvr+g99jhatHyCvOFJzHxy3S6XrQK674AvSyiFfxZXE7F2pRE81MUv32Ks1U+T7ZVSlJAgy5yzZb2d4DI378+2tUVgwYGLDEQ8RocgmH1LXx0AuS5pVdW8F2YvYfv5SUsVzIbqUxKiSM0BduK7U+nYZREL/5NfrmdQQRXx4tUcM2ahNQtdCY0zieb3/6pV1WMu/QQbcaHBsw+3jmKLbxqv9aV9uNy1NXkvcLKYivqwGoiqmBCrsvhsdFgqSpTGuoAJrtOLVYlsTzZdY3i8r13xKUyJlwRvSjXRZDlvyWVz3LRjjgn2DvPbMDkg3LA1hz/eDrWp2jY3lptFawDFchVDfy+TAjGt2haUgUaeU5eV3Ox/ibP0VufJN3cEwr8erJl9YtsrMMjFhIa6DEzbmNPRVoZ/k7thTgPqp5XX+Hoo0RhRuxSMtuoFP+gjM2waLLMXi42J4RNXfQj5GEe+udSEcjzcGGhb0nKqw1Z14/v48U+ZK3eUm0fBooyvQbE1ON543EfakZTnt3k2wCIZgjwXrRZo1gJ/43OqZz71LAu1Hp/01iRzNJjBFaYoiog5eeGY3AP4Jxe916+PKe16URfPfnc4XhExv+G/tAFW1NB9e9Xk8SUdZoPZ4vNQXX40TTmOEGKAhruYu8ek=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(70206006)(336012)(6666004)(426003)(4326008)(83380400001)(40460700003)(921005)(81166007)(356005)(7416002)(966005)(5660300002)(316002)(8936002)(8676002)(26005)(30864003)(2906002)(36860700001)(7696005)(70586007)(6636002)(47076005)(508600001)(2616005)(1076003)(86362001)(36756003)(110136005)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 19:27:11.0062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35556068-0649-4173-a007-08da24961925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add preliminary documentation for AMD IOMMU and combine
with the existing Intel IOMMU documentation and clean
up and modernize some of the existing documentation to
align with the current state of the kernel.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

V2: Incorporate feedback from Robin to clarify IOMMU vs DMA engine (e.g.,
    a device) and document proper DMA API.  Also correct the fact that
    the AMD IOMMU is not limited to managing PCI devices.
v3: Fix spelling and rework text as suggested by Vasant
v4: Combine Intel and AMD documents into a single document as suggested
    by Dave Hansen
v5: Flag keywords as ACPI related.  Some grammatical fixes.

 Documentation/x86/index.rst       |   2 +-
 Documentation/x86/intel-iommu.rst | 115 -----------------------
 Documentation/x86/iommu.rst       | 151 ++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 116 deletions(-)
 delete mode 100644 Documentation/x86/intel-iommu.rst
 create mode 100644 Documentation/x86/iommu.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index f498f1d36cd3..6f8409fe0674 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -21,7 +21,7 @@ x86-specific Documentation
    tlb
    mtrr
    pat
-   intel-iommu
+   iommu
    intel_txt
    amd-memory-encryption
    pti
diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-iommu.rst
deleted file mode 100644
index 099f13d51d5f..000000000000
--- a/Documentation/x86/intel-iommu.rst
+++ /dev/null
@@ -1,115 +0,0 @@
-===================
-Linux IOMMU Support
-===================
-
-The architecture spec can be obtained from the below location.
-
-http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
-
-This guide gives a quick cheat sheet for some basic understanding.
-
-Some Keywords
-
-- DMAR - DMA remapping
-- DRHD - DMA Remapping Hardware Unit Definition
-- RMRR - Reserved memory Region Reporting Structure
-- ZLR  - Zero length reads from PCI devices
-- IOVA - IO Virtual address.
-
-Basic stuff
------------
-
-ACPI enumerates and lists the different DMA engines in the platform, and
-device scope relationships between PCI devices and which DMA engine  controls
-them.
-
-What is RMRR?
--------------
-
-There are some devices the BIOS controls, for e.g USB devices to perform
-PS2 emulation. The regions of memory used for these devices are marked
-reserved in the e820 map. When we turn on DMA translation, DMA to those
-regions will fail. Hence BIOS uses RMRR to specify these regions along with
-devices that need to access these regions. OS is expected to setup
-unity mappings for these regions for these devices to access these regions.
-
-How is IOVA generated?
-----------------------
-
-Well behaved drivers call pci_map_*() calls before sending command to device
-that needs to perform DMA. Once DMA is completed and mapping is no longer
-required, device performs a pci_unmap_*() calls to unmap the region.
-
-The Intel IOMMU driver allocates a virtual address per domain. Each PCIE
-device has its own domain (hence protection). Devices under p2p bridges
-share the virtual address with all devices under the p2p bridge due to
-transaction id aliasing for p2p bridges.
-
-IOVA generation is pretty generic. We used the same technique as vmalloc()
-but these are not global address spaces, but separate for each domain.
-Different DMA engines may support different number of domains.
-
-We also allocate guard pages with each mapping, so we can attempt to catch
-any overflow that might happen.
-
-
-Graphics Problems?
-------------------
-If you encounter issues with graphics devices, you can try adding
-option intel_iommu=igfx_off to turn off the integrated graphics engine.
-If this fixes anything, please ensure you file a bug reporting the problem.
-
-Some exceptions to IOVA
------------------------
-Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
-The same is true for peer to peer transactions. Hence we reserve the
-address from PCI MMIO ranges so they are not allocated for IOVA addresses.
-
-
-Fault reporting
----------------
-When errors are reported, the DMA engine signals via an interrupt. The fault
-reason and device that caused it with fault reason is printed on console.
-
-See below for sample.
-
-
-Boot Message Sample
--------------------
-
-Something like this gets printed indicating presence of DMAR tables
-in ACPI.
-
-ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT 0x00000097) @ 0x000000007f5b5ef0
-
-When DMAR is being processed and initialized by ACPI, prints DMAR locations
-and any RMRR's processed::
-
-	ACPI DMAR:Host address width 36
-	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
-	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
-	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
-	ACPI DMAR:RMRR base: 0x00000000000ed000 end: 0x00000000000effff
-	ACPI DMAR:RMRR base: 0x000000007f600000 end: 0x000000007fffffff
-
-When DMAR is enabled for use, you will notice..
-
-PCI-DMA: Using DMAR IOMMU
--------------------------
-
-Fault reporting
-^^^^^^^^^^^^^^^
-
-::
-
-	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
-	DMAR:[fault reason 05] PTE Write access is not set
-	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
-	DMAR:[fault reason 05] PTE Write access is not set
-
-TBD
-----
-
-- For compatibility testing, could use unity map domain for all devices, just
-  provide a 1-1 for all useful memory under a single domain for all devices.
-- API for paravirt ops for abstracting functionality for VMM folks.
diff --git a/Documentation/x86/iommu.rst b/Documentation/x86/iommu.rst
new file mode 100644
index 000000000000..42c7a6faa39a
--- /dev/null
+++ b/Documentation/x86/iommu.rst
@@ -0,0 +1,151 @@
+=================
+x86 IOMMU Support
+=================
+
+The architecture specs can be obtained from the below locations.
+
+- Intel: http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
+- AMD: https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
+
+This guide gives a quick cheat sheet for some basic understanding.
+
+Basic stuff
+-----------
+
+ACPI enumerates and lists the different IOMMUs on the platform, and
+device scope relationships between devices and which IOMMU controls
+them.
+
+Some ACPI Keywords:
+
+- DMAR - Intel DMA Remapping table
+- DRHD - Intel DMA Remapping Hardware Unit Definition
+- RMRR - Intel Reserved Memory Region Reporting Structure
+- IVRS - AMD I/O Virtualization Reporting Structure
+- IVDB - AMD I/O Virtualization Definition Block
+- IVHD - AMD I/O Virtualization Hardware Definition
+
+What is Intel RMRR?
+^^^^^^^^^^^^^^^^^^^
+
+There are some devices the BIOS controls, for e.g USB devices to perform
+PS2 emulation. The regions of memory used for these devices are marked
+reserved in the e820 map. When we turn on DMA translation, DMA to those
+regions will fail. Hence BIOS uses RMRR to specify these regions along with
+devices that need to access these regions. OS is expected to setup
+unity mappings for these regions for these devices to access these regions.
+
+What is AMD IVRS?
+^^^^^^^^^^^^^^^^^
+
+The architecture defines an ACPI-compatible data structure called an I/O
+Virtualization Reporting Structure (IVRS) that is used to convey information
+related to I/O virtualization to system software.  The IVRS describes the
+configuration and capabilities of the IOMMUs contained in the platform as
+well as information about the devices that each IOMMU virtualizes.
+
+The IVRS provides information about the following:
+
+- IOMMUs present in the platform including their capabilities and proper configuration
+- System I/O topology relevant to each IOMMU
+- Peripheral devices that cannot be otherwise enumerated
+- Memory regions used by SMI/SMM, platform firmware, and platform hardware. These are generally exclusion ranges to be configured by system software.
+
+How is an I/O Virtual Address (IOVA) generated?
+-----------------------------------------------
+
+Well behaved drivers call dma_map_*() calls before sending command to device
+that needs to perform DMA. Once DMA is completed and mapping is no longer
+required, driver performs dma_unmap_*() calls to unmap the region.
+
+Intel Specific Notes
+--------------------
+
+Graphics Problems?
+^^^^^^^^^^^^^^^^^^
+
+If you encounter issues with graphics devices, you can try adding
+option intel_iommu=igfx_off to turn off the integrated graphics engine.
+If this fixes anything, please ensure you file a bug reporting the problem.
+
+Some exceptions to IOVA
+^^^^^^^^^^^^^^^^^^^^^^^
+
+Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
+The same is true for peer to peer transactions. Hence we reserve the
+address from PCI MMIO ranges so they are not allocated for IOVA addresses.
+
+AMD Specific Notes
+------------------
+
+Graphics Problems?
+^^^^^^^^^^^^^^^^^^
+
+If you encounter issues with integrated graphics devices, you can try adding
+option iommu=pt to the kernel command line use a 1:1 mapping for the IOMMU.  If
+this fixes anything, please ensure you file a bug reporting the problem.
+
+Fault reporting
+---------------
+When errors are reported, the IOMMU signals via an interrupt. The fault
+reason and device that caused it is printed on the console.
+
+
+Kernel Log Samples
+------------------
+
+Intel Boot Messages
+^^^^^^^^^^^^^^^^^^^
+
+Something like this gets printed indicating presence of DMAR tables
+in ACPI:
+
+::
+
+	ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT 0x00000097) @ 0x000000007f5b5ef0
+
+When DMAR is being processed and initialized by ACPI, prints DMAR locations
+and any RMRR's processed:
+
+::
+
+	ACPI DMAR:Host address width 36
+	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
+	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
+	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
+	ACPI DMAR:RMRR base: 0x00000000000ed000 end: 0x00000000000effff
+	ACPI DMAR:RMRR base: 0x000000007f600000 end: 0x000000007fffffff
+
+When DMAR is enabled for use, you will notice:
+
+::
+
+	PCI-DMA: Using DMAR IOMMU
+
+Intel Fault reporting
+^^^^^^^^^^^^^^^^^^^^^
+
+::
+
+	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
+	DMAR:[fault reason 05] PTE Write access is not set
+	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
+	DMAR:[fault reason 05] PTE Write access is not set
+
+AMD Boot Messages
+^^^^^^^^^^^^^^^^^
+
+Something like this gets printed indicating presence of the IOMMU:
+
+::
+
+	iommu: Default domain type: Translated
+	iommu: DMA domain TLB invalidation policy: lazy mode
+
+AMD Fault reporting
+^^^^^^^^^^^^^^^^^^^
+
+::
+
+	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007 address=0xffffc02000 flags=0x0000]
+	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0 domain=0x0007 address=0xffffc02000 flags=0x0000]
-- 
2.35.1

