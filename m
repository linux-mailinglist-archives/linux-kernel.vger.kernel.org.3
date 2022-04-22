Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6F150C10A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiDVVYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiDVVYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:24:02 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCF7255BC3;
        Fri, 22 Apr 2022 13:20:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLEDBNFoCaqPBpqmgGjf70pPZ8GYGDpc3CX6uHZ2A0IcW5UovltrlndnNfsGH2e4BUQbvWU5K5Crqu176kPkwIhp7PuVlnlwwvpFv753THvNseoJoONitSh643TmUr7FESdkecHpz1rxgCb48RjRuMg2lhon1/7l0C68g2tlQFuiafwBxztLrm5/vX+CEk/fgO9VWM5wWC9YaWeAPUMA6WCspkg00fHD8Bwp7XQQqf2XH+/Gc92myDHhARQNHwZ9vtRuckACQFx4/dvHO/p44RBC2BQpZeQH34O5UsjEvBmcwtt4KpNGDYPsQ5rpPoU/0N3zCmsLt2Il4aXiQ7W7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOS2kmC7UY4VQ8qFBPVcFC2QJdlosXUymUzSxPukAfI=;
 b=dq9ZvhJEaX7hMxAEk3GWNw7Pi0vPU9sYdqll2uapKibMl1IACHWJMpBot8p/SM9C+JkicTg1p5eENY4zVqp8yIY+2s2GKIoPSEvayw1t3CDb3vLHL7+g2Zt/XtaWjIgcqeeCRhKsLpNjSWdsks4VtVS2gRWPWLM2L3/VTS/miQ6xiS5mUUuefdVcrY632ISpsiXnv8EN0GCPmI6cNphc6xigq7fJoKU0CqGnUjfRsPKjhYyNkobW6Cux79TapkAQvAcGJoDQh+vq36NZDxWLxnhAs5tN6bmSO1FFGQ/7O5o8TgNTNgQpYhi4SOi1BGRGWPAmEdYrKlMqV7ISQjBIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOS2kmC7UY4VQ8qFBPVcFC2QJdlosXUymUzSxPukAfI=;
 b=TDmtTqX8kpz6fgEjEWYxX/TOmMOibYXUhm7RAdjcep25qv7Vi+IBD5dExopyQsjFGDjngqpXPNCow0rqyIDV/J7dzC3pOSGJ+QPLf8XJqxq2Sd8HJ2tLzy32DFF7NaLbPXUUnbVOWLXtWCG9llv3K7Sh/AD/28gpJjjx0N/HqHM=
Received: from DM6PR08CA0040.namprd08.prod.outlook.com (2603:10b6:5:1e0::14)
 by BYAPR12MB3237.namprd12.prod.outlook.com (2603:10b6:a03:13a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Fri, 22 Apr
 2022 20:06:21 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::d3) by DM6PR08CA0040.outlook.office365.com
 (2603:10b6:5:1e0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 20:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 20:06:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 15:06:19 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <hpa@zytor.com>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <joro@8bytes.org>,
        <Suravee.Suthikulpanit@amd.com>, <will@kernel.org>,
        <iommu@lists.linux-foundation.org>, <robin.murphy@arm.com>,
        <Vasant.Hegde@amd.com>
CC:     Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Documentation: x86: rework IOMMU documentation
Date:   Fri, 22 Apr 2022 16:06:07 -0400
Message-ID: <20220422200607.627754-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee0f2f27-21e6-48c2-303e-08da249b91fe
X-MS-TrafficTypeDiagnostic: BYAPR12MB3237:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3237DBC680158622A7401668F7F79@BYAPR12MB3237.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNRHdiUV0GNHoH/8z7bgr9evB1SKnwMWSjXXbbKUVD9ieyl8609xiigdGsKBIQjor8q+Lztqnex9oos4Xo+QTlW0SwXjdoXCZcZwOu6ZddUp4hsMxmss2Shm8yQfbCoCj33yISvGsQLN9P9smEI7rqR//wlmcoeTt5P/+Z1LGoxQ6d37T4qteAU8IGc+O2vgDzj9jl4zDN2n98cOIw820G1TOhmCS1KxbjGa+9eyw3ky9Mb8jRZ+ogfyg89O/hebXsIfHqyKVttV81PvwGwPvOMOGPzMLsLA/JjMexf9HQkrJ79xS9nfyuuPhzPvk6dErmFjO/cCtMfc97bZXjJTOJZoDOSX8RVgJAF+28q3m7uUKp2x1Z9mKNDiFgrvQcr5sGVqxw/5S6MLNb9dX3JQ6uCdHdjDe/yXoQMwT8JZdUqjC+wF/d1RLt3045o+vYM9ZftH6XefnsGHb07Gm9l8MHk9t4QfGz1Wf5kRfcR0Gw/Yv68EtY+yq0iPTFz9adV5H/f/ySF8aH7EmBDmpIzyco7fRBtLtAzXzHBYp3gJvNP3+K2Y1OjTDBH3+q5gOX1ovnK2h4TZObQceh117f5hBjBBQtQIv5/9yRYWy8nZcprqgE9g0Sqg6g8vmXpXyC06JhkBXXFQVyCXOQq6ZHTn3k525WEDtkhaXRkt1nPRXVXXav4l4xUVEqMtyVEcv4ScgoBhmj3Yu25JWOeL69Tob4QZE5hqh+SOoZ9td5YwUIsM4CAfTg/G+Ajez/No1/zJQLBjtYEvVUPnIT9JfpAbM+7z7j+gGN2cZh2cEdMZl7TLLAxDlkJxraH45Ish5AhjusvUJfpeFaxTtdBTrSmQgL/TqnKpVJyJdmAFnbAzJ10=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(2616005)(82310400005)(110136005)(47076005)(40460700003)(70586007)(2906002)(6666004)(4326008)(83380400001)(336012)(426003)(8676002)(7696005)(6636002)(81166007)(16526019)(921005)(8936002)(7416002)(966005)(26005)(86362001)(316002)(36860700001)(36756003)(1076003)(508600001)(356005)(5660300002)(30864003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 20:06:21.3294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0f2f27-21e6-48c2-303e-08da249b91fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3237
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
v5: Clarify that keywords are related to ACPI, grammatical fixes
v6: Make more stuff common based on feedback from Robin

 Documentation/x86/index.rst       |   2 +-
 Documentation/x86/intel-iommu.rst | 115 ------------------------
 Documentation/x86/iommu.rst       | 143 ++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 116 deletions(-)
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
index 000000000000..ed87d76a38d5
--- /dev/null
+++ b/Documentation/x86/iommu.rst
@@ -0,0 +1,143 @@
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
+Some exceptions to IOVAs
+------------------------
+
+Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
+The same is true for peer to peer transactions. Hence we reserve the
+address from PCI MMIO ranges so they are not allocated for IOVA addresses.
+
+Graphics Problems?
+------------------
+
+If you encounter issues with integrated graphics devices, you can try
+adding the option "iommu.passthrough=1", or the equivalent "iommu=pt",
+to the kernel command line to use a 1:1 mapping for the IOMMU in
+general.  On Intel you can also try "intel_iommu=igfx_off" to turn off
+translation specifically for the integrated graphics engine only.  If
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
+	AMD-Vi: Found IOMMU cap 0x40
+	AMD-Vi: Extended features (0x4f77ef22294ada): PPR NX GT IA GA PC GA_vAPIC
+	AMD-Vi: Interrupt remapping enabled
+	AMD-Vi: Virtual APIC enabled
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

