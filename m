Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2085E4F5354
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457821AbiDFDV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451182AbiDFCPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:15:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B11B2C6B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649201727; x=1680737727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v+l/wEK4+zG2qDV8sSvMyjJ+C2lJFtsfGQEyGqDhWJw=;
  b=gX+ud3jKmkoaiYQSUtM1MK0D3S3TjYhNVuTKf+8AO0/8wkOEKFkV7ni5
   sZu48JfrQerVicighdgZcmqK9E6u5/kLb3GvNp/nsJMelFKvjJjyz0jEE
   9D1Nj4ZcIe/QEiLwVKoKqa/NHuMLd3rp069H0mN5QDMGCP5kkrMJ/rOUV
   npVgMr9Zc+5EKFMPKf0Mjkg3Ik4apvJMMQQu1gmx/DkJ7PRFE9SN/PZ5W
   3qCr43mTcp4AHxpOf/VAPgY3MEjxClM/C2y732pKdsLMcCK8Y7pVXNz2A
   tJyy8tuGOTZ3/8douH3b+1ROvWRUK7s7wCg/19+y+k6S/DhwxMiQZB9Rj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260884706"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="260884706"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="523677722"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2022 16:34:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0C9CC11AE; Wed,  6 Apr 2022 02:29:47 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCHv8 30/30] Documentation/x86: Document TDX kernel architecture
Date:   Wed,  6 Apr 2022 02:29:39 +0300
Message-Id: <20220405232939.73860-31-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Document the TDX guest architecture details like #VE support,
shared memory, etc.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 Documentation/x86/index.rst |   1 +
 Documentation/x86/tdx.rst   | 214 ++++++++++++++++++++++++++++++++++++
 2 files changed, 215 insertions(+)
 create mode 100644 Documentation/x86/tdx.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 91b2fa456618..51982dee6c2a 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -26,6 +26,7 @@ x86-specific Documentation
    intel_txt
    amd-memory-encryption
    amd_hsmp
+   tdx
    pti
    mds
    microcode
diff --git a/Documentation/x86/tdx.rst b/Documentation/x86/tdx.rst
new file mode 100644
index 000000000000..8ca60256511b
--- /dev/null
+++ b/Documentation/x86/tdx.rst
@@ -0,0 +1,214 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+Intel Trust Domain Extensions (TDX)
+=====================================
+
+Intel's Trust Domain Extensions (TDX) protect confidential guest VMs from
+the host and physical attacks by isolating the guest register state and by
+encrypting the guest memory. In TDX, a special TDX module sits between the
+host and the guest, and runs in a special mode and manages the guest/host
+separation.
+
+Since the host cannot directly access guest registers or memory, much
+normal functionality of a hypervisor must be moved into the guest. This is
+implemented using a Virtualization Exception (#VE) that is handled by the
+guest kernel. Some #VEs are handled entirely inside the guest kernel, but
+some require the hypervisor to be involved.
+
+TDX includes new hypercall-like mechanisms for communicating from the
+guest to the hypervisor or the TDX module.
+
+New TDX Exceptions
+==================
+
+TDX guests behave differently from bare-metal and traditional VMX guests.
+In TDX guests, otherwise normal instructions or memory accesses can cause
+#VE or #GP exceptions.
+
+Instructions marked with an '*' conditionally cause exceptions.  The
+details for these instructions are discussed below.
+
+Instruction-based #VE
+---------------------
+
+- Port I/O (INS, OUTS, IN, OUT)
+- HLT
+- MONITOR, MWAIT
+- WBINVD, INVD
+- VMCALL
+- RDMSR*,WRMSR*
+- CPUID*
+
+Instruction-based #GP
+---------------------
+
+- All VMX instructions: INVEPT, INVVPID, VMCLEAR, VMFUNC, VMLAUNCH,
+  VMPTRLD, VMPTRST, VMREAD, VMRESUME, VMWRITE, VMXOFF, VMXON
+- ENCLS, ENCLU
+- GETSEC
+- RSM
+- ENQCMD
+- RDMSR*,WRMSR*
+
+RDMSR/WRMSR Behavior
+--------------------
+
+MSR access behavior falls into three categories:
+
+- #GP generated
+- #VE generated
+- "Just works"
+
+In general, the #GP MSRs should not be used in guests.  Their use likely
+indicates a bug in the guest.  The guest may try to handle the #GP with a
+hypercall but it is unlikely to succeed.
+
+The #VE MSRs are typically able to be handled by the hypervisor.  Guests
+can make a hypercall to the hypervisor to handle the #VE.
+
+The "just works" MSRs do not need any special guest handling.  They might
+be implemented by directly passing through the MSR to the hardware or by
+trapping and handling in the TDX module.  Other than possibly being slow,
+these MSRs appear to function just as they would on bare metal.
+
+CPUID Behavior
+--------------
+
+For some CPUID leaves and sub-leaves, the virtualized bit fields of CPUID
+return values (in guest EAX/EBX/ECX/EDX) are configurable by the
+hypervisor. For such cases, the Intel TDX module architecture defines two
+virtualization types:
+
+- Bit fields for which the hypervisor configures the value seen by the
+  guest TD.
+
+- Bit fields for which the hypervisor configures the value such that the
+  guest TD either sees their native value or a value of 0
+
+#VE generated for CPUID leaves and sub-leaves that TDX module doesn't know
+how to handle. The guest kernel may ask the hypervisor for the value with
+a hypercall.
+
+#VE on Memory Accesses
+======================
+
+There are essentially two classes of TDX memory: private and shared.
+Private memory receives full TDX protections.  Its content is protected
+against access from the hypervisor.  Shared memory is expected to be
+shared between guest and hypervisor.
+
+A TD guest is in control of whether its memory accesses are treated as
+private or shared.  It selects the behavior with a bit in its page table
+entries.  This helps ensure that a guest does not place sensitive
+information in shared memory, exposing it to the untrusted hypervisor.
+
+#VE on Shared Memory
+--------------------
+
+Access to shared mappings can cause a #VE.  The hypervisor ultimately
+controls whether a shared memory access causes a #VE, so the guest must be
+careful to only reference shared pages it can safely handle a #VE.  For
+instance, the guest should be careful not to access shared memory in the
+#VE handler before it reads the #VE info structure (TDG.VP.VEINFO.GET).
+
+Shared mapping content is entirely controlled by the hypervisor. Shared
+mappings must never be used for sensitive memory content like stacks or
+kernel text, only for I/O buffers and MMIO regions.  A good rule of thumb
+is that hypervisor-shared memory should be treated the same as memory
+mapped to userspace.  Both the hypervisor and userspace are completely
+untrusted.
+
+MMIO for virtual devices is implemented as shared memory.  The guest must
+be careful not to access device MMIO regions unless it is also prepared to
+handle a #VE.
+
+#VE on Private Pages
+--------------------
+
+Accesses to private mappings can also cause #VEs.  Since all kernel memory
+is also private memory, the kernel might theoretically need to handle a
+#VE on arbitrary kernel memory accesses.  This is not feasible, so TDX
+guests ensure that all guest memory has been "accepted" before memory is
+used by the kernel.
+
+A modest amount of memory (typically 512M) is pre-accepted by the firmware
+before the kernel runs to ensure that the kernel can start up without
+being subjected to #VE's.
+
+The hypervisor is permitted to unilaterally move accepted pages to a
+"blocked" state. However, if it does this, page access will not generate a
+#VE.  It will, instead, cause a "TD Exit" where the hypervisor is required
+to handle the exception.
+
+Linux #VE handler
+=================
+
+Just like page faults or #GP's, #VE exceptions can be either handled or be
+fatal.  Typically, unhandled userspace #VE's result in a SIGSEGV.
+Unhandled kernel #VE's result in an oops.
+
+Handling nested exceptions on x86 is typically nasty business.  A #VE
+could be interrupted by an NMI which triggers another #VE and hilarity
+ensues.  TDX #VE's have a novel solution to make it slightly less nasty.
+
+During #VE handling, the TDX module ensures that all interrupts (including
+NMIs) are blocked.  The block remains in place until the guest makes a
+TDG.VP.VEINFO.GET TDCALL.  This allows the guest to choose when interrupts
+or new #VE's can be delivered.
+
+However, the guest kernel must still be careful to avoid potential
+#VE-triggering actions (discussed above) while this block is in place.
+While the block is in place, #VE's are elevated to double faults (#DF)
+which are not recoverable.
+
+MMIO handling
+=============
+
+In non-TDX VMs, MMIO is usually implemented by giving a guest access to
+a mapping which will cause a VMEXIT on access, and then the hypervisor emulates
+the access.  That is not possible in TDX guests because VMEXIT will expose the
+register state to the host. TDX guests don't trust the host and can't have
+their state exposed to the host.
+
+In TDX, the MMIO regions typically trigger a #VE exception in the guest.
+The guest #VE handler then emulates the MMIO instruction inside the guest
+and converts it into a controlled TDCALL to the host, rather than exposing
+guest state to the host.
+
+MMIO addresses on x86 are just special physical addresses. They can
+theoretically be accessed with any instruction that accesses memory.
+However, the kernel instruction decoding method is limited. It is only
+designed to decode instructions like those generated by io.h macros.
+
+MMIO access via other means (like structure overlays) may result in an
+oops.
+
+Shared Memory Conversions
+=========================
+
+All TDX guest memory starts out as private at boot.  This memory can not
+be accessed by the hypervisor.  However some kernel users like device
+drivers might have a need to share data with the hypervisor.  To do this,
+memory must be converted between shared and private.  This can be
+accomplished using some existing memory encryption helpers:
+
+set_memory_decrypted() converts a range of pages to shared.
+set_memory_encrypted() converts memory back to private.
+
+Device drivers are the primary user of shared memory, but there's no need
+to touch every driver. DMA buffers and ioremap()'ed do the conversions
+automatically.
+
+TDX uses SWIOTLB for most DMA allocations. The SWIOTLB buffer is
+converted to shared on boot.
+
+For coherent DMA allocation, the DMA buffer gets converted on the
+allocation. Check force_dma_unencrypted() for details.
+
+References
+==========
+
+TDX reference material is collected here:
+
+https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
-- 
2.35.1

