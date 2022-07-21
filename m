Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B62B57D065
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiGUPzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiGUPzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:55:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC064E2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OXzDgWNAnXOwdpceHc0k3d33+7QUehGvNXK1iZIzZMA=; b=nJgtNcQNwjhdrI8llY65aVRZuN
        SMWD3dUGjXu9YIEwujccQkqPg2Dp8oA8C/i5TkzWLE2Q/qOfPfHTM7lbxu7k16+mOc0usWMaARcll
        eFOGjdorwt6YgT2qKPVqjNNpSN5lfshA0R31XY17SXiIPkCoSf9cmg6xd12WcSOyuupgnWEASTvEN
        qK1NyaLLJdY39//fi3v9gw60/7zQ+cpBs6/CWTsIetXNSkVJlkjiVbJdE5+gjcSsXBcu4ub9lSj9Y
        TNZgnqFtBDsIyhojsprKbvDfvQQnc9+pCqaa43Hz49ZVJDGsVtEcr5ffI4czIaYp+2ouugGJwT8Za
        g5IZlzlA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEYVc-00FTBw-Eb; Thu, 21 Jul 2022 15:54:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3C7F980BD2; Thu, 21 Jul 2022 17:54:38 +0200 (CEST)
Date:   Thu, 21 Jul 2022 17:54:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joao Moreira <joao@overdrivepizza.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Nuzman, Joseph" <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net>
References: <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx>
 <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
 <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com>
 <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 11:13:16PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 19, 2022 at 10:19:18AM -0700, Sami Tolvanen wrote:
> 
> > Clang's current CFI implementation is somewhat similar to this. It
> > creates separate thunks for address-taken functions and changes
> > function addresses in C code to point to the thunks instead.
> > 
> > While this works, it creates painful situations when interacting with
> > assembly (e.g. a function address taken in assembly cannot be used
> > for indirect calls in C as it doesn't point to the thunk) and needs
> > unpleasant hacks when we want take the actual function address in C
> > (i.e. scattering the code with function_nocfi() calls).
> > 
> > I have to agree with Peter on this, I would rather avoid messing with
> > function pointers in KCFI to avoid these issues.
> 
> It is either this; and I think I can avoid the worst of it (see below);
> or grow the indirect_callsites to obscure the immediate (as Linus
> suggested), there's around ~16k indirect callsites in a defconfig-ish
> kernel, so growing it isn't too horrible, but it isn't nice either.
> 
> The prettiest option to obscure the immediate at the callsite I could
> conjure up is something like:
> 
> kcfi_caller_linus:
> 	movl	$0x12345600, %r10d
> 	movb	$0x78, %r10b
> 	cmpl	%r10d, -OFFSET(%r11)
> 	je	1f
> 	ud2
> 1:	call	__x86_thunk_indirect_r11
> 
> Which comes to around 22 bytes (+5 over the original).

My very firstest LLVM patch; except it explodes at runtime and I'm not
sure where to start looking...

On top of sami-llvm/kcfi

If I comment out the orl and cmpl it compiles stuff, put either one back
and it explodes in some very unhelpful message.

The idea is the above callthunk that makes any offset work by not having
the full hash as an immediate and allow kCFI along with
-fpatchable-function-entry=N,M and include M in the offset.

Specifically, I meant to use -fpatchable-function-entry=16,16, but alas,
I never got that far.

Help ?

---

diff --git a/llvm/lib/Target/X86/X86AsmPrinter.cpp b/llvm/lib/Target/X86/X86AsmPrinter.cpp
index 5e011d409ee8..ffdb95324da7 100644
--- a/llvm/lib/Target/X86/X86AsmPrinter.cpp
+++ b/llvm/lib/Target/X86/X86AsmPrinter.cpp
@@ -124,23 +124,12 @@ void X86AsmPrinter::emitKCFITypeId(const MachineFunction &MF,
     OutStreamer->emitSymbolAttribute(FnSym, MCSA_ELF_TypeFunction);
   OutStreamer->emitLabel(FnSym);
 
-  // Emit int3 padding to allow runtime patching of the preamble.
-  EmitAndCountInstruction(MCInstBuilder(X86::INT3));
-  EmitAndCountInstruction(MCInstBuilder(X86::INT3));
-
   // Embed the type hash in the X86::MOV32ri instruction to avoid special
   // casing object file parsers.
   EmitAndCountInstruction(MCInstBuilder(X86::MOV32ri)
                               .addReg(X86::EAX)
                               .addImm(Type->getZExtValue()));
 
-  // The type hash is encoded in the last four bytes of the X86::MOV32ri
-  // instruction. Emit additional X86::INT3 padding to ensure the hash is
-  // at offset -6 from the function start to avoid potential call target
-  // gadgets in checks emitted by X86AsmPrinter::LowerKCFI_CHECK.
-  EmitAndCountInstruction(MCInstBuilder(X86::INT3));
-  EmitAndCountInstruction(MCInstBuilder(X86::INT3));
-
   if (MAI->hasDotTypeDotSizeDirective()) {
     MCSymbol *EndSym = OutContext.createTempSymbol("cfi_func_end");
     OutStreamer->emitLabel(EndSym);
diff --git a/llvm/lib/Target/X86/X86MCInstLower.cpp b/llvm/lib/Target/X86/X86MCInstLower.cpp
index 16c4d2e45970..d72e82f4f63a 100644
--- a/llvm/lib/Target/X86/X86MCInstLower.cpp
+++ b/llvm/lib/Target/X86/X86MCInstLower.cpp
@@ -1340,22 +1340,34 @@ void X86AsmPrinter::LowerKCFI_CHECK(const MachineInstr &MI) {
   assert(std::next(MI.getIterator())->isCall() &&
          "KCFI_CHECK not followed by a call instruction");
 
-  // The type hash is encoded in the last four bytes of the X86::CMP32mi
-  // instruction. If we decided to place the hash immediately before
-  // indirect call targets (offset -4), the X86::JCC_1 instruction we'll
-  // emit next would be a potential indirect call target as it's preceded
-  // by a valid type hash.
-  //
-  // To avoid generating useful gadgets, X86AsmPrinter::emitKCFITypeId
-  // emits the type hash prefix at offset -6, which makes X86::TRAP the
-  // only possible target in this instruction sequence.
-  EmitAndCountInstruction(MCInstBuilder(X86::CMP32mi)
+  const Function &F = MF->getFunction();
+  unsigned Imm = MI.getOperand(1).getImm();
+  unsigned Num;
+
+  if (F.hasFnAttribute("patchable-function-prefix")) {
+    if (F.getFnAttribute("patchable-function-prefix")
+            .getValueAsString()
+            .getAsInteger(10, Num))
+      Num = 0;
+  }
+
+  // movl $0x12345600, %r10d
+  EmitAndCountInstruction(MCInstBuilder(X86::MOV32ri)
+		  .addReg(X86::R10)
+		  .addImm(Imm & ~0xff));
+
+  // orl $0x78, %r10d
+  EmitAndCountInstruction(MCInstBuilder(X86::OR32ri8)
+		  .addReg(X86::R10)
+		  .addImm(Imm & 0xff));
+
+  // cmpl %r10, -off(%r11)
+  EmitAndCountInstruction(MCInstBuilder(X86::CMP32rm)
+                              .addReg(X86::R10)
                               .addReg(MI.getOperand(0).getReg())
                               .addImm(1)
                               .addReg(X86::NoRegister)
-                              .addImm(-6)
-                              .addReg(X86::NoRegister)
-                              .addImm(MI.getOperand(1).getImm()));
+                              .addImm(-(Num + 4)));
 
   MCSymbol *Pass = OutContext.createTempSymbol();
   EmitAndCountInstruction(
