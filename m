Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA5350C336
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiDVWeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbiDVWdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:33:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3496128CC9;
        Fri, 22 Apr 2022 14:26:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E05C1FB;
        Fri, 22 Apr 2022 14:26:18 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4EE13F73B;
        Fri, 22 Apr 2022 14:26:15 -0700 (PDT)
Message-ID: <595a738e-583a-d2da-b724-a627ff91918a@arm.com>
Date:   Fri, 22 Apr 2022 22:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Documentation: x86: rework IOMMU documentation
Content-Language: en-GB
To:     Alex Deucher <alexander.deucher@amd.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, joro@8bytes.org, Suravee.Suthikulpanit@amd.com,
        will@kernel.org, iommu@lists.linux-foundation.org,
        Vasant.Hegde@amd.com
References: <20220422200607.627754-1-alexander.deucher@amd.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220422200607.627754-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-22 21:06, Alex Deucher wrote:
> Add preliminary documentation for AMD IOMMU and combine
> with the existing Intel IOMMU documentation and clean
> up and modernize some of the existing documentation to
> align with the current state of the kernel.

FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> 
> V2: Incorporate feedback from Robin to clarify IOMMU vs DMA engine (e.g.,
>      a device) and document proper DMA API.  Also correct the fact that
>      the AMD IOMMU is not limited to managing PCI devices.
> v3: Fix spelling and rework text as suggested by Vasant
> v4: Combine Intel and AMD documents into a single document as suggested
>      by Dave Hansen
> v5: Clarify that keywords are related to ACPI, grammatical fixes
> v6: Make more stuff common based on feedback from Robin
> 
>   Documentation/x86/index.rst       |   2 +-
>   Documentation/x86/intel-iommu.rst | 115 ------------------------
>   Documentation/x86/iommu.rst       | 143 ++++++++++++++++++++++++++++++
>   3 files changed, 144 insertions(+), 116 deletions(-)
>   delete mode 100644 Documentation/x86/intel-iommu.rst
>   create mode 100644 Documentation/x86/iommu.rst
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index f498f1d36cd3..6f8409fe0674 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -21,7 +21,7 @@ x86-specific Documentation
>      tlb
>      mtrr
>      pat
> -   intel-iommu
> +   iommu
>      intel_txt
>      amd-memory-encryption
>      pti
> diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-iommu.rst
> deleted file mode 100644
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
> -Basic stuff
> ------------
> -
> -ACPI enumerates and lists the different DMA engines in the platform, and
> -device scope relationships between PCI devices and which DMA engine  controls
> -them.
> -
> -What is RMRR?
> --------------
> -
> -There are some devices the BIOS controls, for e.g USB devices to perform
> -PS2 emulation. The regions of memory used for these devices are marked
> -reserved in the e820 map. When we turn on DMA translation, DMA to those
> -regions will fail. Hence BIOS uses RMRR to specify these regions along with
> -devices that need to access these regions. OS is expected to setup
> -unity mappings for these regions for these devices to access these regions.
> -
> -How is IOVA generated?
> -----------------------
> -
> -Well behaved drivers call pci_map_*() calls before sending command to device
> -that needs to perform DMA. Once DMA is completed and mapping is no longer
> -required, device performs a pci_unmap_*() calls to unmap the region.
> -
> -The Intel IOMMU driver allocates a virtual address per domain. Each PCIE
> -device has its own domain (hence protection). Devices under p2p bridges
> -share the virtual address with all devices under the p2p bridge due to
> -transaction id aliasing for p2p bridges.
> -
> -IOVA generation is pretty generic. We used the same technique as vmalloc()
> -but these are not global address spaces, but separate for each domain.
> -Different DMA engines may support different number of domains.
> -
> -We also allocate guard pages with each mapping, so we can attempt to catch
> -any overflow that might happen.
> -
> -
> -Graphics Problems?
> -------------------
> -If you encounter issues with graphics devices, you can try adding
> -option intel_iommu=igfx_off to turn off the integrated graphics engine.
> -If this fixes anything, please ensure you file a bug reporting the problem.
> -
> -Some exceptions to IOVA
> ------------------------
> -Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
> -The same is true for peer to peer transactions. Hence we reserve the
> -address from PCI MMIO ranges so they are not allocated for IOVA addresses.
> -
> -
> -Fault reporting
> ----------------
> -When errors are reported, the DMA engine signals via an interrupt. The fault
> -reason and device that caused it with fault reason is printed on console.
> -
> -See below for sample.
> -
> -
> -Boot Message Sample
> --------------------
> -
> -Something like this gets printed indicating presence of DMAR tables
> -in ACPI.
> -
> -ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT 0x00000097) @ 0x000000007f5b5ef0
> -
> -When DMAR is being processed and initialized by ACPI, prints DMAR locations
> -and any RMRR's processed::
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
> -- For compatibility testing, could use unity map domain for all devices, just
> -  provide a 1-1 for all useful memory under a single domain for all devices.
> -- API for paravirt ops for abstracting functionality for VMM folks.
> diff --git a/Documentation/x86/iommu.rst b/Documentation/x86/iommu.rst
> new file mode 100644
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
> +- Intel: http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
> +- AMD: https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
> +
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
> +regions will fail. Hence BIOS uses RMRR to specify these regions along with
> +devices that need to access these regions. OS is expected to setup
> +unity mappings for these regions for these devices to access these regions.
> +
> +What is AMD IVRS?
> +^^^^^^^^^^^^^^^^^
> +
> +The architecture defines an ACPI-compatible data structure called an I/O
> +Virtualization Reporting Structure (IVRS) that is used to convey information
> +related to I/O virtualization to system software.  The IVRS describes the
> +configuration and capabilities of the IOMMUs contained in the platform as
> +well as information about the devices that each IOMMU virtualizes.
> +
> +The IVRS provides information about the following:
> +
> +- IOMMUs present in the platform including their capabilities and proper configuration
> +- System I/O topology relevant to each IOMMU
> +- Peripheral devices that cannot be otherwise enumerated
> +- Memory regions used by SMI/SMM, platform firmware, and platform hardware. These are generally exclusion ranges to be configured by system software.
> +
> +How is an I/O Virtual Address (IOVA) generated?
> +-----------------------------------------------
> +
> +Well behaved drivers call dma_map_*() calls before sending command to device
> +that needs to perform DMA. Once DMA is completed and mapping is no longer
> +required, driver performs dma_unmap_*() calls to unmap the region.
> +
> +Some exceptions to IOVAs
> +------------------------
> +
> +Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
> +The same is true for peer to peer transactions. Hence we reserve the
> +address from PCI MMIO ranges so they are not allocated for IOVA addresses.
> +
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
> +	ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT 0x00000097) @ 0x000000007f5b5ef0
> +
> +When DMAR is being processed and initialized by ACPI, prints DMAR locations
> +and any RMRR's processed:
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
> +	AMD-Vi: Extended features (0x4f77ef22294ada): PPR NX GT IA GA PC GA_vAPIC
> +	AMD-Vi: Interrupt remapping enabled
> +	AMD-Vi: Virtual APIC enabled
> +
> +AMD Fault reporting
> +^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007 address=0xffffc02000 flags=0x0000]
> +	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0 domain=0x0007 address=0xffffc02000 flags=0x0000]
