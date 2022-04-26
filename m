Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5A25103D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353092AbiDZQqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiDZQqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:46:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C4347058;
        Tue, 26 Apr 2022 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650991422; x=1682527422;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=74prdzNGj3JnjJUS0sO17DGbGa0TVADKS42cC0+9fsE=;
  b=f/EJCh2m7C3hjhwNlZtLKlSc3DKoQcgimbs+kNeIGd5ypM/vJ965ggK1
   421Om5acnj5l7jH52nz/oid/cTPIDzUGekVo0sBGYAfdAwcUAtZB5TiSP
   ueryDteaUTSBdNOFlNuyFu7ZRlyJj+fy5R59uSoXkJch6gSpx+a4Fe1ye
   KQA1rvf1dL7+U8FCzBi2wbSfV/MqQEAyhGbToma31Exxia2PoN7BYXXdj
   c4qA/p3vHNS26rengRu2ksLtyXQkFsWOxuBAz0hJHgLQyPMRhy11wyz6v
   ovQ/IzukApS5jTkzKnw/2EzwG+IB2Mh8KXxfDh18vK2XOocUBRfvhjGiS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="352088884"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="352088884"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 09:40:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="513243859"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 09:40:54 -0700
Date:   Tue, 26 Apr 2022 09:44:32 -0700
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <hpa@zytor.com>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <joro@8bytes.org>,
        <Suravee.Suthikulpanit@amd.com>, <will@kernel.org>,
        <iommu@lists.linux-foundation.org>, <robin.murphy@arm.com>,
        <Vasant.Hegde@amd.com>, jacob.jun.pan@intel.com,
        "Lu, Baolu" <baolu.lu@intel.com>
Subject: Re: [PATCH] Documentation: x86: rework IOMMU documentation
Message-ID: <20220426094432.2970966f@jacob-builder>
In-Reply-To: <20220422200607.627754-1-alexander.deucher@amd.com>
References: <20220422200607.627754-1-alexander.deucher@amd.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Thanks for doing this, really helps to catch up the current state. Please
see my comments inline.

On Fri, 22 Apr 2022 16:06:07 -0400, Alex Deucher
<alexander.deucher@amd.com> wrote:

> Add preliminary documentation for AMD IOMMU and combine
> with the existing Intel IOMMU documentation and clean
> up and modernize some of the existing documentation to
> align with the current state of the kernel.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> 
> V2: Incorporate feedback from Robin to clarify IOMMU vs DMA engine (e.g.,
>     a device) and document proper DMA API.  Also correct the fact that
>     the AMD IOMMU is not limited to managing PCI devices.
> v3: Fix spelling and rework text as suggested by Vasant
> v4: Combine Intel and AMD documents into a single document as suggested
>     by Dave Hansen
> v5: Clarify that keywords are related to ACPI, grammatical fixes
> v6: Make more stuff common based on feedback from Robin
> 
>  Documentation/x86/index.rst       |   2 +-
>  Documentation/x86/intel-iommu.rst | 115 ------------------------
>  Documentation/x86/iommu.rst       | 143 ++++++++++++++++++++++++++++++
>  3 files changed, 144 insertions(+), 116 deletions(-)
>  delete mode 100644 Documentation/x86/intel-iommu.rst
>  create mode 100644 Documentation/x86/iommu.rst
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index f498f1d36cd3..6f8409fe0674 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -21,7 +21,7 @@ x86-specific Documentation
>     tlb
>     mtrr
>     pat
> -   intel-iommu
> +   iommu
>     intel_txt
>     amd-memory-encryption
>     pti
> diff --git a/Documentation/x86/intel-iommu.rst
> b/Documentation/x86/intel-iommu.rst deleted file mode 100644
> index 099f13d51d5f..000000000000
> --- a/Documentation/x86/intel-iommu.rst
> +++ /dev/null
> @@ -1,115 +0,0 @@
> -===================
> -Linux IOMMU Support
> -===================
> -
> -The architecture spec can be obtained from the below location.
> -
> -http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
> -
> -This guide gives a quick cheat sheet for some basic understanding.
> -
> -Some Keywords
> -
> -- DMAR - DMA remapping
> -- DRHD - DMA Remapping Hardware Unit Definition
> -- RMRR - Reserved memory Region Reporting Structure
> -- ZLR  - Zero length reads from PCI devices
> -- IOVA - IO Virtual address.
> -
I feel this combined document only focus on IOVA and DMA APIs, it is
considered as legacy DMA after scalable mode is introduced by Intel to
support DMA with PASID, shared virtual addressing (SVA).
Perhaps, we can also combine ./Documentation/x86/sva.rst

With scalable mode, it affects boot messages, fault reporting, etc. I am
not saying no to this document, just suggesting. I don't know where AMD is
at in terms of PASID support but there are lots of things in common between
VT-d and ARM's SMMU in terms of PASID/SVA. Should we broaden the purpose of
this document even further?

> -Basic stuff
> ------------
> -
> -ACPI enumerates and lists the different DMA engines in the platform, and
> -device scope relationships between PCI devices and which DMA engine
> controls -them.
> -
> -What is RMRR?
> --------------
> -
> -There are some devices the BIOS controls, for e.g USB devices to perform
> -PS2 emulation. The regions of memory used for these devices are marked
> -reserved in the e820 map. When we turn on DMA translation, DMA to those
> -regions will fail. Hence BIOS uses RMRR to specify these regions along
> with -devices that need to access these regions. OS is expected to setup
> -unity mappings for these regions for these devices to access these
> regions. -
> -How is IOVA generated?
> -----------------------
> -
> -Well behaved drivers call pci_map_*() calls before sending command to
> device -that needs to perform DMA. Once DMA is completed and mapping is
> no longer -required, device performs a pci_unmap_*() calls to unmap the
> region. -
> -The Intel IOMMU driver allocates a virtual address per domain. Each PCIE
> -device has its own domain (hence protection). Devices under p2p bridges
> -share the virtual address with all devices under the p2p bridge due to
> -transaction id aliasing for p2p bridges.
> -
> -IOVA generation is pretty generic. We used the same technique as
> vmalloc() -but these are not global address spaces, but separate for each
> domain. -Different DMA engines may support different number of domains.
> -
> -We also allocate guard pages with each mapping, so we can attempt to
> catch -any overflow that might happen.
> -
> -
> -Graphics Problems?
> -------------------
> -If you encounter issues with graphics devices, you can try adding
> -option intel_iommu=igfx_off to turn off the integrated graphics engine.
> -If this fixes anything, please ensure you file a bug reporting the
> problem. -
> -Some exceptions to IOVA
> ------------------------
> -Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
> -The same is true for peer to peer transactions. Hence we reserve the
> -address from PCI MMIO ranges so they are not allocated for IOVA
> addresses. -
> -
> -Fault reporting
> ----------------
> -When errors are reported, the DMA engine signals via an interrupt. The
> fault -reason and device that caused it with fault reason is printed on
> console. -
> -See below for sample.
> -
> -
> -Boot Message Sample
> --------------------
> -
> -Something like this gets printed indicating presence of DMAR tables
> -in ACPI.
> -
> -ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT 0x00000097) @
> 0x000000007f5b5ef0 -
> -When DMAR is being processed and initialized by ACPI, prints DMAR
> locations -and any RMRR's processed::
> -
> -	ACPI DMAR:Host address width 36
> -	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
> -	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
> -	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
> -	ACPI DMAR:RMRR base: 0x00000000000ed000 end: 0x00000000000effff
> -	ACPI DMAR:RMRR base: 0x000000007f600000 end: 0x000000007fffffff
> -
> -When DMAR is enabled for use, you will notice..
> -
> -PCI-DMA: Using DMAR IOMMU
> --------------------------
> -
> -Fault reporting
> -^^^^^^^^^^^^^^^
> -
> -::
> -
> -	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> -	DMAR:[fault reason 05] PTE Write access is not set
> -	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> -	DMAR:[fault reason 05] PTE Write access is not set
> -
> -TBD
> -----
> -
> -- For compatibility testing, could use unity map domain for all devices,
> just
> -  provide a 1-1 for all useful memory under a single domain for all
> devices. -- API for paravirt ops for abstracting functionality for VMM
> folks. diff --git a/Documentation/x86/iommu.rst
> b/Documentation/x86/iommu.rst new file mode 100644
> index 000000000000..ed87d76a38d5
> --- /dev/null
> +++ b/Documentation/x86/iommu.rst
> @@ -0,0 +1,143 @@
> +=================
> +x86 IOMMU Support
> +=================
> +
> +The architecture specs can be obtained from the below locations.
> +
> +- Intel:
> http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
> +- AMD: https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf +
> +This guide gives a quick cheat sheet for some basic understanding.
> +
> +Basic stuff
> +-----------
> +
> +ACPI enumerates and lists the different IOMMUs on the platform, and
> +device scope relationships between devices and which IOMMU controls
> +them.
> +
> +Some ACPI Keywords:
> +
> +- DMAR - Intel DMA Remapping table
> +- DRHD - Intel DMA Remapping Hardware Unit Definition
> +- RMRR - Intel Reserved Memory Region Reporting Structure
> +- IVRS - AMD I/O Virtualization Reporting Structure
> +- IVDB - AMD I/O Virtualization Definition Block
> +- IVHD - AMD I/O Virtualization Hardware Definition
> +
> +What is Intel RMRR?
> +^^^^^^^^^^^^^^^^^^^
> +
> +There are some devices the BIOS controls, for e.g USB devices to perform
> +PS2 emulation. The regions of memory used for these devices are marked
> +reserved in the e820 map. When we turn on DMA translation, DMA to those
> +regions will fail. Hence BIOS uses RMRR to specify these regions along
> with +devices that need to access these regions. OS is expected to setup
> +unity mappings for these regions for these devices to access these
> regions. +
> +What is AMD IVRS?
> +^^^^^^^^^^^^^^^^^
> +
> +The architecture defines an ACPI-compatible data structure called an I/O
> +Virtualization Reporting Structure (IVRS) that is used to convey
> information +related to I/O virtualization to system software.  The IVRS
> describes the +configuration and capabilities of the IOMMUs contained in
> the platform as +well as information about the devices that each IOMMU
> virtualizes. +
> +The IVRS provides information about the following:
> +
> +- IOMMUs present in the platform including their capabilities and proper
> configuration +- System I/O topology relevant to each IOMMU
> +- Peripheral devices that cannot be otherwise enumerated
> +- Memory regions used by SMI/SMM, platform firmware, and platform
> hardware. These are generally exclusion ranges to be configured by system
> software. + +How is an I/O Virtual Address (IOVA) generated?
> +-----------------------------------------------
> +
> +Well behaved drivers call dma_map_*() calls before sending command to
> device +that needs to perform DMA. Once DMA is completed and mapping is
> no longer +required, driver performs dma_unmap_*() calls to unmap the
> region. +
> +Some exceptions to IOVAs
> +------------------------
> +
> +Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
> +The same is true for peer to peer transactions. Hence we reserve the
> +address from PCI MMIO ranges so they are not allocated for IOVA
> addresses. +
> +Graphics Problems?
> +------------------
> +
> +If you encounter issues with integrated graphics devices, you can try
> +adding the option "iommu.passthrough=1", or the equivalent "iommu=pt",
> +to the kernel command line to use a 1:1 mapping for the IOMMU in
> +general.  On Intel you can also try "intel_iommu=igfx_off" to turn off
> +translation specifically for the integrated graphics engine only.  If
> +this fixes anything, please ensure you file a bug reporting the problem.
> +
> +Fault reporting
> +---------------
> +When errors are reported, the IOMMU signals via an interrupt. The fault
> +reason and device that caused it is printed on the console.
> +
> +
> +Kernel Log Samples
> +------------------
> +
> +Intel Boot Messages
> +^^^^^^^^^^^^^^^^^^^
> +
> +Something like this gets printed indicating presence of DMAR tables
> +in ACPI:
> +
> +::
> +
> +	ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT 0x00000097) @
> 0x000000007f5b5ef0 +
> +When DMAR is being processed and initialized by ACPI, prints DMAR
> locations +and any RMRR's processed:
> +
> +::
> +
> +	ACPI DMAR:Host address width 36
> +	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
> +	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
> +	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
> +	ACPI DMAR:RMRR base: 0x00000000000ed000 end: 0x00000000000effff
> +	ACPI DMAR:RMRR base: 0x000000007f600000 end: 0x000000007fffffff
> +
> +When DMAR is enabled for use, you will notice:
> +
> +::
> +
> +	PCI-DMA: Using DMAR IOMMU
> +
> +Intel Fault reporting
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> +	DMAR:[fault reason 05] PTE Write access is not set
> +	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> +	DMAR:[fault reason 05] PTE Write access is not set
> +
> +AMD Boot Messages
> +^^^^^^^^^^^^^^^^^
> +
> +Something like this gets printed indicating presence of the IOMMU:
> +
> +::
> +
> +	AMD-Vi: Found IOMMU cap 0x40
> +	AMD-Vi: Extended features (0x4f77ef22294ada): PPR NX GT IA GA PC
> GA_vAPIC
> +	AMD-Vi: Interrupt remapping enabled
> +	AMD-Vi: Virtual APIC enabled
> +
> +AMD Fault reporting
> +^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007
> address=0xffffc02000 flags=0x0000]
> +	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0 domain=0x0007
> address=0xffffc02000 flags=0x0000]


Thanks,

Jacob
