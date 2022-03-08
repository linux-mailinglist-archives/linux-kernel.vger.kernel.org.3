Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4784D2232
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350128AbiCHUKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiCHUKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:10:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B767DEB7;
        Tue,  8 Mar 2022 12:09:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD55C1650;
        Tue,  8 Mar 2022 12:09:08 -0800 (PST)
Received: from [10.57.41.254] (unknown [10.57.41.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A14E03F7D7;
        Tue,  8 Mar 2022 12:09:06 -0800 (PST)
Message-ID: <1cd577e8-1364-ffc5-020c-330378a72c78@arm.com>
Date:   Tue, 8 Mar 2022 20:09:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] Documentation: x86: add documenation for AMD IOMMU
Content-Language: en-GB
To:     Alex Deucher <alexander.deucher@amd.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        will@kernel.org, iommu@lists.linux-foundation.org
References: <20220308190453.135068-1-alexander.deucher@amd.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220308190453.135068-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-08 19:04, Alex Deucher via iommu wrote:
> Add preliminary documenation for AMD IOMMU.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   Documentation/x86/amd-iommu.rst   | 85 +++++++++++++++++++++++++++++++
>   Documentation/x86/index.rst       |  1 +
>   Documentation/x86/intel-iommu.rst |  2 +-
>   3 files changed, 87 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/x86/amd-iommu.rst
> 
> diff --git a/Documentation/x86/amd-iommu.rst b/Documentation/x86/amd-iommu.rst
> new file mode 100644
> index 000000000000..89820140fefa
> --- /dev/null
> +++ b/Documentation/x86/amd-iommu.rst
> @@ -0,0 +1,85 @@
> +=================
> +AMD IOMMU Support
> +=================
> +
> +The architecture spec can be obtained from the below location.
> +
> +https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
> +
> +This guide gives a quick cheat sheet for some basic understanding.
> +
> +Some Keywords
> +
> +- IVRS - I/O Virtualization Reporting Structure
> +- IVDB - I/O Virtualization Definition Block
> +- IVHD - I/O Virtualization Hardware Definition
> +- IOVA - I/O Virtual Address.
> +
> +Basic stuff
> +-----------
> +
> +ACPI enumerates and lists the different DMA engines in the platform, and
> +device scope relationships between PCI devices and which DMA engine controls
> +them.

"DMA engine" typically means a dedicated device for peripheral-to-memory 
or memory-to-memory transfers, or the responsible block within a general 
DMA-capable endpoint. In the context of the original Intel doc from 
whence I see this is copied, this probably should have said "DMAR unit" 
or similar; here I'd suggest picking your favourite vendor-appropriate 
term for "instance of IOMMU translation hardware". Let's not promote 
confusion more than necessary.

> +
> +What is IVRS?
> +-------------
> +
> +The architecture defines an ACPI-compatible data structure called an I/O
> +Virtualization Reporting Structure (IVRS) that is used to convey information
> +related to I/O virtualization to system software.  The IVRS describes the
> +configuration and capabilities of the IOMMUs contained in the platform as
> +well as information about the devices that each IOMMU virtualizes.
> +
> +The IVRS provides information about the following:
> +- IOMMUs present in the platform including their capabilities and proper configuration
> +- System I/O topology relevant to each IOMMU
> +- Peripheral devices that cannot be otherwise enumerated
> +- Memory regions used by SMI/SMM, platform firmware, and platform hardware. These are
> +generally exclusion ranges to be configured by system software.
> +
> +How is IOVA generated?
> +----------------------
> +
> +Well behaved drivers call pci_map_*() calls before sending command to device

Horribly out-of-date drivers call pci_map_*(). Modern well-behaved 
drivers call dma_map_*() ;)

> +that needs to perform DMA. Once DMA is completed and mapping is no longer
> +required, device performs a pci_unmap_*() calls to unmap the region.
> +
> +The AMD IOMMU driver allocates a virtual address per domain. Each PCIE
> +device has its own domain (hence protection). Devices under p2p bridges
> +share the virtual address with all devices under the p2p bridge due to
> +transaction id aliasing for p2p bridges.
> +
> +IOVA generation is pretty generic. We used the same technique as vmalloc()
> +but these are not global address spaces, but separate for each domain.
> +Different DMA engines may support different number of domains.

I'm not sure about this whole section, really - IOVA management was 
entirely decoupled from drivers some time ago. If there's value in 
having some overview documentation, then it's probably worth 
consolidating into a common "IOMMU API" doc that can be cross-referenced 
for a summary of domains, groups, and iommu_dma_ops.

> +
> +
> +Fault reporting
> +---------------
> +When errors are reported, the DMA engine signals via an interrupt. The fault

Again, here I instinctively read "DMA engine" as being the endpoint 
device *making* the DMA transaction that faulted, and indeed that might 
happen to raise its own error interrupt if it gets an unexpected abort 
back from the IOMMU, which is coincidental to a thoroughly misleading 
degree...

Thanks,
Robin.

> +reason and device that caused it with fault reason is printed on console.
> +
> +See below for sample.
> +
> +
> +Boot Message Sample
> +-------------------
> +
> +Something like this gets printed indicating presence of the IOMMU.
> +
> +	iommu: Default domain type: Translated
> +	iommu: DMA domain TLB invalidation policy: lazy mode
> +
> +
> +PCI-DMA: Using AMD IOMMU
> +------------------------
> +
> +Fault reporting
> +^^^^^^^^^^^^^^^
> +
> +::
> +
> +	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007 address=0xffffc02000 flags=0x0000]
> +	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0 domain=0x0007 address=0xffffc02000 flags=0x0000]
> +
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index f498f1d36cd3..15711134eb68 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -22,6 +22,7 @@ x86-specific Documentation
>      mtrr
>      pat
>      intel-iommu
> +   amd-iommu
>      intel_txt
>      amd-memory-encryption
>      pti
> diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-iommu.rst
> index 099f13d51d5f..4d3391c7bd3f 100644
> --- a/Documentation/x86/intel-iommu.rst
> +++ b/Documentation/x86/intel-iommu.rst
> @@ -1,5 +1,5 @@
>   ===================
> -Linux IOMMU Support
> +Intel IOMMU Support
>   ===================
>   
>   The architecture spec can be obtained from the below location.
