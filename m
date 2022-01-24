Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BC64982F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243341AbiAXPDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:03:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:18497 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240234AbiAXPCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036553; x=1674572553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dsefuNW/uaII71woGzX+BNGxwSbHexqdQ8a8s4IKvyM=;
  b=g4T87JfpM71ptSD6Rb3hHfvmuyZeoAwJefWn/ejGqBSKP+QcWlDxWWoG
   Klqc7segTo84ylW0PGv7MmVeYf5odlV9cwkwFhQh0eZgCvL8uyg4VB39v
   bRWSkCkmaHaT11/a9JeAFkUIKX+I57k1hzabmE5KnYubPswZj4ojC9Ce1
   dHkbtvQsfuyk8BbpEECg4D3lWrTOW8lH71lizjzyK2L+eDCpAPjSg5KOA
   OgCOzRPcg07rR7ZucJXPX71kF4GymfvJPmEhDOZeIKoVZo65+oCNILRAq
   WFgzxfXbYrCX81gSelwszPkTkTlyXNXtf92azjdLG8CFUudQ2hyEpk1uT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332416548"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332416548"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476743361"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2022 07:02:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B89EADDA; Mon, 24 Jan 2022 17:02:20 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 29/29] Documentation/x86: Document TDX kernel architecture
Date:   Mon, 24 Jan 2022 18:02:15 +0300
Message-Id: <20220124150215.36893-30-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Document the TDX guest architecture details like #VE support,
shared memory, etc.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/x86/index.rst |   1 +
 Documentation/x86/tdx.rst   | 194 ++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+)
 create mode 100644 Documentation/x86/tdx.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index f498f1d36cd3..382e53ca850a 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -24,6 +24,7 @@ x86-specific Documentation
    intel-iommu
    intel_txt
    amd-memory-encryption
+   tdx
    pti
    mds
    microcode
diff --git a/Documentation/x86/tdx.rst b/Documentation/x86/tdx.rst
new file mode 100644
index 000000000000..903c9cecccbd
--- /dev/null
+++ b/Documentation/x86/tdx.rst
@@ -0,0 +1,194 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+Intel Trust Domain Extensions (TDX)
+=====================================
+
+Intel's Trust Domain Extensions (TDX) protect confidential guest VMs
+from the host and physical attacks by isolating the guest register
+state and by encrypting the guest memory. In TDX, a special TDX module
+sits between the host and the guest, and runs in a special mode and
+manages the guest/host separation.
+
+Since the host cannot directly access guest registers or memory, much
+normal functionality of a hypervisor (such as trapping MMIO, some MSRs,
+some CPUIDs, and some other instructions) has to be moved into the
+guest. This is implemented using a Virtualization Exception (#VE) that
+is handled by the guest kernel. Some #VEs are handled inside the guest
+kernel, but some require the hypervisor (VMM) to be involved. The TD
+hypercall mechanism allows TD guests to call TDX module or hypervisor
+function.
+
+#VE Exceptions:
+===============
+
+In TDX guests, #VE Exceptions are delivered to TDX guests in following
+scenarios:
+
+* Execution of certain instructions (see list below)
+* Certain MSR accesses.
+* CPUID usage (only for certain leaves)
+* Shared memory access (including MMIO)
+
+#VE due to instruction execution
+---------------------------------
+
+Intel TDX dis-allows execution of certain instructions in non-root
+mode. Execution of these instructions would lead to #VE or #GP.
+
+Details are,
+
+List of instructions that can cause a #VE is,
+
+* String I/O (INS, OUTS), IN, OUT
+* HLT
+* MONITOR, MWAIT
+* WBINVD, INVD
+* VMCALL
+
+List of instructions that can cause a #GP is,
+
+* All VMX instructions: INVEPT, INVVPID, VMCLEAR, VMFUNC, VMLAUNCH,
+  VMPTRLD, VMPTRST, VMREAD, VMRESUME, VMWRITE, VMXOFF, VMXON
+* ENCLS, ENCLV
+* GETSEC
+* RSM
+* ENQCMD
+
+#VE due to MSR access
+----------------------
+
+In TDX guest, MSR access behavior can be categorized as,
+
+* Native supported (also called "context switched MSR")
+  No special handling is required for these MSRs in TDX guests.
+* #GP triggered
+  Dis-allowed MSR read/write would lead to #GP.
+* #VE triggered
+  All MSRs that are not natively supported or dis-allowed
+  (triggers #GP) will trigger #VE. To support access to
+  these MSRs, it needs to be emulated using TDCALL.
+
+Look Intel TDX Module Specification, sec "MSR Virtualization" for the complete
+list of MSRs that fall under the categories above.
+
+#VE due to CPUID instruction
+----------------------------
+
+In TDX guests, most of CPUID leaf/sub-leaf combinations are virtualized by
+the TDX module while some trigger #VE. Combinations of CPUID leaf/sub-leaf
+which triggers #VE are configured by the VMM during the TD initialization
+time (using TDH.MNG.INIT).
+
+#VE on Memory Accesses
+----------------------
+
+A TD guest is in control of whether its memory accesses are treated as
+private or shared.  It selects the behavior with a bit in its page table
+entries.
+
+#VE on Shared Pages
+-------------------
+
+Access to shared mappings can cause a #VE. The hypervisor controls whether
+access of shared mapping causes a #VE, so the guest must be careful to only
+reference shared pages it can safely handle a #VE, avoid nested #VEs.
+
+Content of shared mapping is not trusted since shared memory is writable
+by the hypervisor. Shared mappings are never used for sensitive memory content
+like stacks or kernel text, only for I/O buffers and MMIO regions. The kernel
+will not encounter shared mappings in sensitive contexts like syscall entry
+or NMIs.
+
+#VE on Private Pages
+--------------------
+
+Some accesses to private mappings may cause #VEs.  Before a mapping is
+accepted (AKA in the SEPT_PENDING state), a reference would cause a #VE.
+But, after acceptance, references typically succeed.
+
+The hypervisor can cause a private page reference to fail if it chooses
+to move an accepted page to a "blocked" state.  However, if it does
+this, page access will not generate a #VE.  It will, instead, cause a
+"TD Exit" where the hypervisor is required to handle the exception.
+
+Linux #VE handler
+-----------------
+
+Both user/kernel #VE exceptions are handled by the tdx_handle_virt_exception()
+handler. If successfully handled, the instruction pointer is incremented to
+complete the handling process. If failed to handle, it is treated as a regular
+exception and handled via fixup handlers.
+
+In TD guests, #VE nesting (a #VE triggered before handling the current one
+or AKA syscall gap issue) problem is handled by TDX module ensuring that
+interrupts, including NMIs, are blocked. The hardware blocks interrupts
+starting with #VE delivery until TDGETVEINFO is called.
+
+The kernel must avoid triggering #VE in entry paths: do not touch TD-shared
+memory, including MMIO regions, and do not use #VE triggering MSRs,
+instructions, or CPUID leaves that might generate #VE.
+
+MMIO handling:
+==============
+
+In non-TDX VMs, MMIO is usually implemented by giving a guest access to a
+mapping which will cause a VMEXIT on access, and then the VMM emulates the
+access. That's not possible in TDX guests because VMEXIT will expose the
+register state to the host. TDX guests don't trust the host and can't have
+their state exposed to the host.
+
+In TDX the MMIO regions are instead configured to trigger a #VE
+exception in the guest. The guest #VE handler then emulates the MMIO
+instructions inside the guest and converts them into a controlled TDCALL
+to the host, rather than completely exposing the state to the host.
+
+MMIO addresses on x86 are just special physical addresses. They can be
+accessed with any instruction that accesses memory. However, the
+introduced instruction decoding method is limited. It is only designed
+to decode instructions like those generated by io.h macros.
+
+MMIO access via other means (like structure overlays) may result in
+MMIO_DECODE_FAILED and an oops.
+
+Shared memory:
+==============
+
+Intel TDX doesn't allow the VMM to access guest private memory. Any
+memory that is required for communication with VMM must be shared
+explicitly by setting the bit in the page table entry. The shared bit
+can be enumerated with TDX_GET_INFO.
+
+After setting the shared bit, the conversion must be completed with
+MapGPA hypercall. The call informs the VMM about the conversion between
+private/shared mappings.
+
+set_memory_decrypted() converts a range of pages to shared.
+set_memory_encrypted() converts memory back to private.
+
+Device drivers are the primary user of shared memory, but there's no
+need in touching every driver. DMA buffers and ioremap()'ed regions are
+converted to shared automatically.
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
+More details about TDX module (and its response for MSR, memory access,
+IO, CPUID etc) can be found at,
+
+https://www.intel.com/content/dam/develop/external/us/en/documents/tdx-module-1.0-public-spec-v0.931.pdf
+
+More details about TDX hypercall and TDX module call ABI can be found
+at,
+
+https://www.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface-1.0-344426-002.pdf
+
+More details about TDVF requirements can be found at,
+
+https://www.intel.com/content/dam/develop/external/us/en/documents/tdx-virtual-firmware-design-guide-rev-1.01.pdf
-- 
2.34.1

