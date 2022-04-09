Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2644FA12B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbiDIB3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbiDIB3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:29:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ECBDA6DF;
        Fri,  8 Apr 2022 18:27:23 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467642;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJEJ0EYWeJWu3nu5hajmx4qwo3tvuJglxoa+gD2xJXg=;
        b=AFaY0xuglFgMb4cFRcntvFP6C6uTiC754vhxSzPMgukfWFOrriLzDcxfaMVcDIN76QMSuS
        h6a5mPPOA82SbxwNzA+0zybdklbPoOWp3VlE8wjpaO26vbvsg+23lRIaDakQQ4Ix8mc8t/
        YiSxTprgR95fkI/vkfMj1loABLBN8hdpNtdJXDHaq96kOQprthXyHbDAyFzTiXHJRE8EK2
        Fx2f2BtnJfsR+uxRX2Dogv4GIC3HhEmRRBmM/urlP7TRWMRS3ZAcZNPkA9fpUDnBzii8xs
        2hCcaOMkqmaxE/f9Ce1J2fOIV9nb3wS7H95tq2Cym3tVKiLB4f7zb8BzhVktvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467642;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJEJ0EYWeJWu3nu5hajmx4qwo3tvuJglxoa+gD2xJXg=;
        b=n4pBGpQ0RFs7cJoVzR82pNTwtUD3f75ouyyRL3lvyy64e04uizPihCMTmtmw2DOK90kRg4
        Q/ghEv2pm1AeTqCg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/mm/cpa: Add support for TDX shared memory
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-27-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-27-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946764149.4207.1620159764822684171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     7dbde7631629896b478bc5b1f4c3e52e6d518d12
Gitweb:        https://git.kernel.org/tip/7dbde7631629896b478bc5b1f4c3e52e6d518d12
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:35 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:53 -07:00

x86/mm/cpa: Add support for TDX shared memory

Intel TDX protects guest memory from VMM access. Any memory that is
required for communication with the VMM must be explicitly shared.

It is a two-step process: the guest sets the shared bit in the page
table entry and notifies VMM about the change. The notification happens
using MapGPA hypercall.

Conversion back to private memory requires clearing the shared bit,
notifying VMM with MapGPA hypercall following with accepting the memory
with AcceptPage hypercall.

Provide a TDX version of x86_platform.guest.* callbacks. It makes
__set_memory_enc_pgtable() work right in TDX guest.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-27-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/core.c    |   1 +-
 arch/x86/coco/tdx/tdx.c | 133 +++++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/traps.c |   2 +-
 3 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 70956f9..9f74125 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -21,6 +21,7 @@ static bool intel_cc_platform_has(enum cc_attr attr)
 	switch (attr) {
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
 	case CC_ATTR_HOTPLUG_DISABLED:
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return true;
 	default:
 		return false;
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index f50f530..03deb4d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -10,10 +10,15 @@
 #include <asm/vmx.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/pgtable.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
 #define TDX_GET_VEINFO			3
+#define TDX_ACCEPT_PAGE			6
+
+/* TDX hypercall Leaf IDs */
+#define TDVMCALL_MAP_GPA		0x10001
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -531,6 +536,130 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 	return ret;
 }
 
+static bool tdx_tlb_flush_required(bool private)
+{
+	/*
+	 * TDX guest is responsible for flushing TLB on private->shared
+	 * transition. VMM is responsible for flushing on shared->private.
+	 *
+	 * The VMM _can't_ flush private addresses as it can't generate PAs
+	 * with the guest's HKID.  Shared memory isn't subject to integrity
+	 * checking, i.e. the VMM doesn't need to flush for its own protection.
+	 *
+	 * There's no need to flush when converting from shared to private,
+	 * as flushing is the VMM's responsibility in this case, e.g. it must
+	 * flush to avoid integrity failures in the face of a buggy or
+	 * malicious guest.
+	 */
+	return !private;
+}
+
+static bool tdx_cache_flush_required(void)
+{
+	/*
+	 * AMD SME/SEV can avoid cache flushing if HW enforces cache coherence.
+	 * TDX doesn't have such capability.
+	 *
+	 * Flush cache unconditionally.
+	 */
+	return true;
+}
+
+static bool try_accept_one(phys_addr_t *start, unsigned long len,
+			  enum pg_level pg_level)
+{
+	unsigned long accept_size = page_level_size(pg_level);
+	u64 tdcall_rcx;
+	u8 page_size;
+
+	if (!IS_ALIGNED(*start, accept_size))
+		return false;
+
+	if (len < accept_size)
+		return false;
+
+	/*
+	 * Pass the page physical address to the TDX module to accept the
+	 * pending, private page.
+	 *
+	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
+	 */
+	switch (pg_level) {
+	case PG_LEVEL_4K:
+		page_size = 0;
+		break;
+	case PG_LEVEL_2M:
+		page_size = 1;
+		break;
+	case PG_LEVEL_1G:
+		page_size = 2;
+		break;
+	default:
+		return false;
+	}
+
+	tdcall_rcx = *start | page_size;
+	if (__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL))
+		return false;
+
+	*start += accept_size;
+	return true;
+}
+
+/*
+ * Inform the VMM of the guest's intent for this physical page: shared with
+ * the VMM or private to the guest.  The VMM is expected to change its mapping
+ * of the page in response.
+ */
+static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+{
+	phys_addr_t start = __pa(vaddr);
+	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+
+	if (!enc) {
+		/* Set the shared (decrypted) bits: */
+		start |= cc_mkdec(0);
+		end   |= cc_mkdec(0);
+	}
+
+	/*
+	 * Notify the VMM about page mapping conversion. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
+	 * section "TDG.VP.VMCALL<MapGPA>"
+	 */
+	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
+		return false;
+
+	/* private->shared conversion  requires only MapGPA call */
+	if (!enc)
+		return true;
+
+	/*
+	 * For shared->private conversion, accept the page using
+	 * TDX_ACCEPT_PAGE TDX module call.
+	 */
+	while (start < end) {
+		unsigned long len = end - start;
+
+		/*
+		 * Try larger accepts first. It gives chance to VMM to keep
+		 * 1G/2M SEPT entries where possible and speeds up process by
+		 * cutting number of hypercalls (if successful).
+		 */
+
+		if (try_accept_one(&start, len, PG_LEVEL_1G))
+			continue;
+
+		if (try_accept_one(&start, len, PG_LEVEL_2M))
+			continue;
+
+		if (!try_accept_one(&start, len, PG_LEVEL_4K))
+			return false;
+	}
+
+	return true;
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
@@ -555,5 +684,9 @@ void __init tdx_early_init(void)
 	 */
 	physical_mask &= cc_mask - 1;
 
+	x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
+	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
+	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
+
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f9fb653..a4e2efd 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1378,7 +1378,7 @@ static void ve_raise_fault(struct pt_regs *regs, long error_code)
  *
  * In the settings that Linux will run in, virtualization exceptions are
  * never generated on accesses to normal, TD-private memory that has been
- * accepted.
+ * accepted (by BIOS or with tdx_enc_status_changed()).
  *
  * Syscall entry code has a critical window where the kernel stack is not
  * yet set up. Any exception in this window leads to hard to debug issues
