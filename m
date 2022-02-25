Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDC84C4CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243955AbiBYRnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbiBYRnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:43:17 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344842E682
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645810963; x=1677346963;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=su/qhVPuYLxTfT8fzqkZOhgpHt3kPueh7BZnSyEF2DI=;
  b=RkrXM00c1epK5wvLgcOSaFklEMrHchk6KuoawQ6vjXue6l8jaWIp8CKH
   pV3J/NCWXXOaUpRc2KZBljY1QqtGgrZfQt292A7VM4C7RIlR9QCAmJnp0
   COF2JRMYHZs8C2ibUeVsLkstjW4xb+L9aLISrPkYvP34g4VeWXAKVryk1
   keKVGao61pD4OoFHVOviGtSBpwbRFTLq4Y5efONhN//WSJ556C71EFnPS
   4BDPntT0MbrGBnt7F/sHY4Rngq3hba+wwuaL5Y4p3Dg4DU011PTE/QErb
   xrXwFVGpc9EP+lEk6mPlEAG5IbNLqOSvOLdqjG2S0xkj02idWVCtgt1K5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252465700"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="252465700"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:42:42 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="533650818"
Received: from wreed-mobl.amr.corp.intel.com (HELO [10.212.247.12]) ([10.212.247.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:42:42 -0800
Message-ID: <98248dc2-7802-72e9-4936-ccfca330d1d3@intel.com>
Date:   Fri, 25 Feb 2022 09:42:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-31-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 30/30] Documentation/x86: Document TDX kernel
 architecture
In-Reply-To: <20220224155630.52734-31-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#VE Exceptions:
> +===============
> +
> +In TDX guests, #VE Exceptions are delivered to TDX guests in following
> +scenarios:
> +
> +* Execution of certain instructions (see list below)
> +* Certain MSR accesses.
> +* CPUID usage (only for certain leaves)
> +* Shared memory access (including MMIO)

This makes it sound like *ALL* MMIO will cause a #VE.  Is this strictly
true?  I didn't see anything in the spec that completely disallowed a
host from passing through an MMIO range to a guest in a shared memory
range.  Granted, the host can unilaterally make that range start causing
a #VE at any time.  But, is MMIO itself disallowed?  Or, do guests just
have to be *prepared* for a #VE when accessing something that might be MMIO?

> +#VE due to instruction execution
> +---------------------------------
> +
> +Intel TDX dis-allows execution of certain instructions in non-root

		^ disallows

> +mode. Execution of these instructions would lead to #VE or #GP.


Some instruction behavior changes when running inside a TDX guest.
These are typically instructions that would have been trapped by a
hypervisor and emulated.  In a TDX guest, these instructions either lead
to a #VE or #GP.

* Instructions that always cause a #VE:

> +* String I/O (INS, OUTS), IN, OUT
> +* HLT
> +* MONITOR, MWAIT
> +* WBINVD, INVD
> +* VMCALL

* Instructions always cause a #GP:

> +* All VMX instructions: INVEPT, INVVPID, VMCLEAR, VMFUNC, VMLAUNCH,
> +  VMPTRLD, VMPTRST, VMREAD, VMRESUME, VMWRITE, VMXOFF, VMXON
> +* ENCLS, ENCLV

		^ ENCLU

I don't think there's an "ENCLV" instruction.

> +* GETSEC
> +* RSM
> +* ENQCMD


* Instructions that conditionally cause a #VE (more details below)
 * WRMSR, RDMSR (details below)
 * CPUID
> +#VE due to MSR access
> +----------------------

<Sigh> The title of this section is #VE.  Then, it talks about how #GP's
are triggered.

> +In TDX guest, MSR access behavior can be categorized as,
> +
> +* Native supported (also called "context switched MSR")
> +  No special handling is required for these MSRs in TDX guests.
> +* #GP triggered
> +  Dis-allowed MSR read/write would lead to #GP.
> +* #VE triggered
> +  All MSRs that are not natively supported or dis-allowed
> +  (triggers #GP) will trigger #VE. To support access to
> +  these MSRs, it needs to be emulated using TDCALL.

This is really struggling to do anything useful.  I mean, it says: "look
there are three categories."  It defines the third category as
"everything not in the other two". <sigh>  That's just a waste of bytes.

--

MSR access behavior falls into three categories:

 * #GP generated
 * #VE generated
 * MSR "just works"

In general, the #GP MSRs should not be used in guests.  Their use likely
indicates a bug in the guest.  The guest _can_ try to handle the #GP
with a hypercall but it is unlikely to succeed.

The #VE MSRs are typically able to be handled by the hypervisor.  Guests
can make a hypercall to the hypervisor to handle the #VE.

The "just works" MSRs do not need any special guest handling.  They
might be implemented by directly passing through the MSR to the hardware
or by trapping and handling in the TDX module.  Other than possibly
being slow, these MSRs appear to function just as they would on bare metal.

> +Look Intel TDX Module Specification, sec "MSR Virtualization" for the complete
> +list of MSRs that fall under the categories above.

Could we try to write some actual coherent text here, please?  This
isn't even a complete sentence.

> +#VE due to CPUID instruction
> +----------------------------
> +
> +In TDX guests, most of CPUID leaf/sub-leaf combinations are virtualized by
> +the TDX module while some trigger #VE. Whether the leaf/sub-leaf triggers #VE
> +defined in the TDX spec.
> +
> +VMM during the TD initialization time (using TDH.MNG.INIT) configures if
> +a feature bits in specific leaf-subleaf are exposed to TD guest or not.

This needs to *say* something.  Otherwise, it's just useless bytes.
Basically, this is a long-winded way of saying "if you want to know
anything about CPUID, look at the TDX spec".

What do we want the reader to take away from this?

> +#VE on Memory Accesses
> +----------------------
> +
> +A TD guest is in control of whether its memory accesses are treated as
> +private or shared.  It selects the behavior with a bit in its page table
> +entries.

... and what?

Why does this matter?  What does it have to do with #VE?

> +#VE on Shared Pages
> +-------------------
> +
> +Access to shared mappings can cause a #VE. The hypervisor controls whether
> +access of shared mapping causes a #VE, so the guest must be careful to only
> +reference shared pages it can safely handle a #VE, avoid nested #VEs.
> +
> +Content of shared mapping is not trusted since shared memory is writable
> +by the hypervisor. Shared mappings are never used for sensitive memory content
> +like stacks or kernel text, only for I/O buffers and MMIO regions. The kernel
> +will not encounter shared mappings in sensitive contexts like syscall entry
> +or NMIs.
> +
> +#VE on Private Pages
> +--------------------
> +
> +Some accesses to private mappings may cause #VEs.  Before a mapping is
> +accepted (AKA in the SEPT_PENDING state), a reference would cause a #VE.
> +But, after acceptance, references typically succeed.
> +
> +The hypervisor can cause a private page reference to fail if it chooses
> +to move an accepted page to a "blocked" state.  However, if it does
> +this, page access will not generate a #VE.  It will, instead, cause a
> +"TD Exit" where the hypervisor is required to handle the exception.
> +
> +Linux #VE handler
> +-----------------
> +
> +Both user/kernel #VE exceptions are handled by the tdx_handle_virt_exception()
> +handler. If successfully handled, the instruction pointer is incremented to
> +complete the handling process. If failed to handle, it is treated as a regular
> +exception and handled via fixup handlers.
> +
> +In TD guests, #VE nesting (a #VE triggered before handling the current one
> +or AKA syscall gap issue) problem is handled by TDX module ensuring that
> +interrupts, including NMIs, are blocked. The hardware blocks interrupts
> +starting with #VE delivery until TDGETVEINFO is called.
> +
> +The kernel must avoid triggering #VE in entry paths: do not touch TD-shared
> +memory, including MMIO regions, and do not use #VE triggering MSRs,
> +instructions, or CPUID leaves that might generate #VE.
> +
> +MMIO handling:
> +==============
> +
> +In non-TDX VMs, MMIO is usually implemented by giving a guest access to a
> +mapping which will cause a VMEXIT on access, and then the VMM emulates the
> +access. That's not possible in TDX guests because VMEXIT will expose the
> +register state to the host. TDX guests don't trust the host and can't have
> +their state exposed to the host.
> +
> +In TDX the MMIO regions are instead configured to trigger a #VE
> +exception in the guest. The guest #VE handler then emulates the MMIO
> +instructions inside the guest and converts them into a controlled TDCALL
> +to the host, rather than completely exposing the state to the host.
> +
> +MMIO addresses on x86 are just special physical addresses. They can be
> +accessed with any instruction that accesses memory. However, the
> +introduced instruction decoding method is limited. It is only designed
> +to decode instructions like those generated by io.h macros.
> +
> +MMIO access via other means (like structure overlays) may result in
> +MMIO_DECODE_FAILED and an oops.
> +
> +Shared memory:
> +==============
> +
> +Intel TDX doesn't allow the VMM to access guest private memory. Any
> +memory that is required for communication with VMM must be shared
> +explicitly by setting the bit in the page table entry. The shared bit
> +can be enumerated with TDX_GET_INFO.
> +
> +After setting the shared bit, the conversion must be completed with
> +MapGPA hypercall. The call informs the VMM about the conversion between
> +private/shared mappings.
> +
> +set_memory_decrypted() converts a range of pages to shared.
> +set_memory_encrypted() converts memory back to private.
> +
> +Device drivers are the primary user of shared memory, but there's no
> +need in touching every driver. DMA buffers and ioremap()'ed regions are
> +converted to shared automatically.
> +
> +TDX uses SWIOTLB for most DMA allocations. The SWIOTLB buffer is
> +converted to shared on boot.
> +
> +For coherent DMA allocation, the DMA buffer gets converted on the
> +allocation. Check force_dma_unencrypted() for details.
> +


> +More details about TDX module (and its response for MSR, memory access,
> +IO, CPUID etc) can be found at,
> +
> +https://www.intel.com/content/dam/develop/external/us/en/documents/tdx-module-1.0-public-spec-v0.931.pdf
> +
> +More details about TDX hypercall and TDX module call ABI can be found
> +at,
> +
> +https://www.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface-1.0-344426-002.pdf
> +
> +More details about TDVF requirements can be found at,
> +
> +https://www.intel.com/content/dam/develop/external/us/en/documents/tdx-virtual-firmware-design-guide-rev-1.01.pdf

None of these are stable URLs.  Let's just get rid of them.
