Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4723448C292
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiALK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbiALK4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:56:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4696C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RyPTjyORhO00i1q4goOpUypIulFTgRFrnhUWBFmCR8U=; b=NDG7jX9b/p02nmDTKKgMTrQfud
        DbeWe9+YJS6+c2WLX6Fk68a9Ih3Z5kNrUcffoU1DOy1tfjPwehEMC8R8AnX96DSeKxULcZb2TB1Y3
        jNbu8fFhcIz4ng9TU7cVfP9B0DuVAncxU+Rwgdcnz27o9VBuMwfaWwliaVRls3gU6JBFzqBGEeqrC
        Qozri3KivbZ9lOhmPiEPteuezr7efETRTNXtyz1g64lLHdqZn9SKkCu3yhm81mey5HSRKkf6lih3P
        BGPis2dtEMzuG0QmRG9v6ybEtrWcM82gw6toQwKI3Bil/VD/yyMvC99OjWxqmTGGE27+LkzuRuUgd
        a0IxTY7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7bI7-000mxv-Nq; Wed, 12 Jan 2022 10:55:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40FBE3001CD;
        Wed, 12 Jan 2022 11:55:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EBE12B33EC0F; Wed, 12 Jan 2022 11:55:41 +0100 (CET)
Date:   Wed, 12 Jan 2022 11:55:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: [PATCH] x86/entry_32: Fix segment exceptions
Message-ID: <Yd6zrbFBzSn3ducx@hirez.programming.kicks-ass.net>
References: <20220106083523.GB32167@xsang-OptiPlex-9020>
 <Yd1l0gInc4zRcnt/@hirez.programming.kicks-ass.net>
 <Yd4u2rVVSdpEpwwM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd4u2rVVSdpEpwwM@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 01:28:58AM +0000, Sean Christopherson wrote:
> On Tue, Jan 11, 2022, Peter Zijlstra wrote:
> > On Thu, Jan 06, 2022 at 04:35:23PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed the following commit (built with clang-14):
> > > 
> > > commit: aa93e2ad7464ffb90155a5ffdde963816f86d5dc ("x86/entry_32: Remove .fixup usage")
> > > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/core
> > > 
> > > in testcase: kernel-selftests
> > > version: 
> > > with following parameters:
> > > 
> > > 	group: x86
> > > 
> > 
> > It would be very useful if this thing would also say which of the many
> > x86 selftests fails... it appears to be: ldt_gdt_32.
> > 
> > The below fixes it, but I'm still not entirely sure what the actual
> > problem is, although Andy did find a bug in that the exception handler
> > should do: *(ss:esp) = 0, adding ss-base (using insn_get_seg_base())
> > doesn't seem to cure things.
> 
> Because I was curious...
> 
> The issue is that PARANOID_EXIT_TO_KERNEL_MODE in the handle_exception_return
> path overwrites the entry stack data with the task stack data, restoring the "bad"
> segment value.

Full and proper patch below. Boris, if you could merge in x86/core that
branch should then be ready for a pull req.

---
Subject: x86/entry_32: Fix segment exceptions
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 11 Jan 2022 12:11:14 +0100

The LKP robot reported that commit aa93e2ad7464 ("x86/entry_32: Remove
.fixup usage") caused failure. Turns out the ldt_gdt_32 selftest turns
into an infinite loop trying to clear the segment.

As discovered by Sean; what happens is that
PARANOID_EXIT_TO_KERNEL_MODE in the handle_exception_return path
overwrites the entry stack data with the task stack data, restoring
the "bad" segment value.

Instead of having the exception re-take the instruction, have it
emulate the full instruction. Replace EX_TYPE_POP_ZERO with
EX_TYPE_POP_REG which will do the equivalent of: POP %reg;
MOV $imm, %reg.

In order to encode the segment registers, add them as registers 8-11
for 32bit.

By setting regs->[defg]s the (nested) RESTORE_REGS will pop this value
at the end of the exception handler and by increasing regs->sp we'll
have skipped the stack slot.

Fixes: aa93e2ad7464 ("x86/entry_32: Remove .fixup usage")
Reported-by: kernel test robot <oliver.sang@intel.com>
Debugged-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Yd1l0gInc4zRcnt/@hirez.programming.kicks-ass.net
---
 arch/x86/entry/entry_32.S                  |   13 +++++++++----
 arch/x86/include/asm/extable_fixup_types.h |    5 ++++-
 arch/x86/lib/insn-eval.c                   |    5 +++++
 arch/x86/mm/extable.c                      |   17 +++--------------
 4 files changed, 21 insertions(+), 19 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -268,11 +268,16 @@
 1:	popl	%ds
 2:	popl	%es
 3:	popl	%fs
-	addl	$(4 + \pop), %esp	/* pop the unused "gs" slot */
+4:	addl	$(4 + \pop), %esp	/* pop the unused "gs" slot */
 	IRET_FRAME
-	_ASM_EXTABLE_TYPE(1b, 1b, EX_TYPE_POP_ZERO)
-	_ASM_EXTABLE_TYPE(2b, 2b, EX_TYPE_POP_ZERO)
-	_ASM_EXTABLE_TYPE(3b, 3b, EX_TYPE_POP_ZERO)
+
+	/*
+	 * There is no _ASM_EXTABLE_TYPE_REG() for ASM, however since this is
+	 * ASM the registers are known and we can trivially hard-code them.
+	 */
+	_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_POP_ZERO|EX_DATA_REG(8))
+	_ASM_EXTABLE_TYPE(2b, 3b, EX_TYPE_POP_ZERO|EX_DATA_REG(9))
+	_ASM_EXTABLE_TYPE(3b, 4b, EX_TYPE_POP_ZERO|EX_DATA_REG(10))
 .endm
 
 .macro RESTORE_ALL_NMI cr3_reg:req pop=0
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -16,6 +16,7 @@
 #define EX_DATA_FLAG_SHIFT		12
 #define EX_DATA_IMM_SHIFT		16
 
+#define EX_DATA_REG(reg)		((reg) << EX_DATA_REG_SHIFT)
 #define EX_DATA_FLAG(flag)		((flag) << EX_DATA_FLAG_SHIFT)
 #define EX_DATA_IMM(imm)		((imm) << EX_DATA_IMM_SHIFT)
 
@@ -41,7 +42,9 @@
 #define	EX_TYPE_RDMSR_IN_MCE		13
 #define	EX_TYPE_DEFAULT_MCE_SAFE	14
 #define	EX_TYPE_FAULT_MCE_SAFE		15
-#define	EX_TYPE_POP_ZERO		16
+
+#define	EX_TYPE_POP_REG			16 /* reg := (long)imm */
+#define EX_TYPE_POP_ZERO		(EX_TYPE_POP_REG | EX_DATA_IMM(0))
 
 #define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
 #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(-EFAULT))
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -428,6 +428,11 @@ static const int pt_regoff[] = {
 	offsetof(struct pt_regs, r13),
 	offsetof(struct pt_regs, r14),
 	offsetof(struct pt_regs, r15),
+#else
+	offsetof(struct pt_regs, ds),
+	offsetof(struct pt_regs, es),
+	offsetof(struct pt_regs, fs),
+	offsetof(struct pt_regs, gs),
 #endif
 };
 
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -126,18 +126,6 @@ static bool ex_handler_clear_fs(const st
 	return ex_handler_default(fixup, regs);
 }
 
-static bool ex_handler_pop_zero(const struct exception_table_entry *fixup,
-				struct pt_regs *regs)
-{
-	/*
-	 * Typically used for when "pop %seg" traps, in which case we'll clear
-	 * the stack slot and re-try the instruction, which will then succeed
-	 * to pop zero.
-	 */
-	*((unsigned long *)regs->sp) = 0;
-	return ex_handler_default(fixup, regs);
-}
-
 static bool ex_handler_imm_reg(const struct exception_table_entry *fixup,
 			       struct pt_regs *regs, int reg, int imm)
 {
@@ -218,8 +206,9 @@ int fixup_exception(struct pt_regs *regs
 	case EX_TYPE_RDMSR_IN_MCE:
 		ex_handler_msr_mce(regs, false);
 		break;
-	case EX_TYPE_POP_ZERO:
-		return ex_handler_pop_zero(e, regs);
+	case EX_TYPE_POP_REG:
+		regs->sp += sizeof(long);
+		fallthrough;
 	case EX_TYPE_IMM_REG:
 		return ex_handler_imm_reg(e, regs, reg, imm);
 	case EX_TYPE_FAULT_SGX:
