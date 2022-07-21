Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFF957D2D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiGUR4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGUR4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:56:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F458810C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aGCdA0oy0ExkilJgMyu6nxyVwVfsPF+6Fxmkt0K0bO4=; b=LWls5ks2K60cBgc7+u3P5xJeUe
        hh0OUBx99MfBG4Wubbgh43z5J/oEJPjObRXlx1eZLY8GiI1VjK30OKZEUnk4CP9X5YkD3XwqECoGW
        EhYW6+Ot3fiFnDl9FJp9ITANPB6HxKf/7ezohrRCBLaR5t8g1+P3ADVdfjCAagvnekC8EA5kYiJx1
        2tjB47lLBg9NYfIcSthR0vlW6UWkdELYGKmcEu82K1bASqoe1NurIA+vhr/WJTrtyPUUG4t5YijSV
        0RwEYp+3ry5hfsxCOQoabZCbIgo+elHnsvn8e6/p6ciKtIQYQUlqNT4lDRfBQq51ZXvxhldjGaYTn
        fXBc2LDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEaOz-005bM6-1a; Thu, 21 Jul 2022 17:55:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE05B980BD2; Thu, 21 Jul 2022 19:55:55 +0200 (CEST)
Date:   Thu, 21 Jul 2022 19:55:55 +0200
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
Message-ID: <YtmTK93vHWQUFinE@worktop.programming.kicks-ass.net>
References: <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx>
 <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
 <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com>
 <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
 <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 05:54:38PM +0200, Peter Zijlstra wrote:
> My very firstest LLVM patch; except it explodes at runtime and I'm not
> sure where to start looking...
> 
> On top of sami-llvm/kcfi

Thanks Sami!

this seems to work, let me go hack the kernel..

---
 clang/lib/Driver/SanitizerArgs.cpp     | 12 ---------
 llvm/lib/Target/X86/X86AsmPrinter.cpp  | 11 --------
 llvm/lib/Target/X86/X86MCInstLower.cpp | 47 ++++++++++++++++++++++------------
 3 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/clang/lib/Driver/SanitizerArgs.cpp b/clang/lib/Driver/SanitizerArgs.cpp
index 373a74399df0..b6ebc8ad1842 100644
--- a/clang/lib/Driver/SanitizerArgs.cpp
+++ b/clang/lib/Driver/SanitizerArgs.cpp
@@ -719,18 +719,6 @@ SanitizerArgs::SanitizerArgs(const ToolChain &TC,
       D.Diag(diag::err_drv_argument_not_allowed_with)
           << "-fsanitize=kcfi"
           << lastArgumentForMask(D, Args, SanitizerKind::CFI);
-
-    if (Arg *A = Args.getLastArg(options::OPT_fpatchable_function_entry_EQ)) {
-      StringRef S = A->getValue();
-      unsigned N, M;
-      // With -fpatchable-function-entry=N,M, where M > 0,
-      // llvm::AsmPrinter::emitFunctionHeader injects nops before the
-      // KCFI type identifier, which is currently unsupported.
-      if (!S.consumeInteger(10, N) && S.consume_front(",") &&
-          !S.consumeInteger(10, M) && M > 0)
-        D.Diag(diag::err_drv_argument_not_allowed_with)
-            << "-fsanitize=kcfi" << A->getAsString(Args);
-    }
   }
 
   Stats = Args.hasFlag(options::OPT_fsanitize_stats,
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
index 16c4d2e45970..4ed23348aa7c 100644
--- a/llvm/lib/Target/X86/X86MCInstLower.cpp
+++ b/llvm/lib/Target/X86/X86MCInstLower.cpp
@@ -1340,22 +1340,37 @@ void X86AsmPrinter::LowerKCFI_CHECK(const MachineInstr &MI) {
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
-                              .addReg(MI.getOperand(0).getReg())
-                              .addImm(1)
-                              .addReg(X86::NoRegister)
-                              .addImm(-6)
-                              .addReg(X86::NoRegister)
-                              .addImm(MI.getOperand(1).getImm()));
+  const Function &F = MF->getFunction();
+  unsigned Imm = MI.getOperand(1).getImm();
+  unsigned Num = 0;
+
+  if (F.hasFnAttribute("patchable-function-prefix")) {
+    if (F.getFnAttribute("patchable-function-prefix")
+            .getValueAsString()
+            .getAsInteger(10, Num))
+      Num = 0;
+  } 
+
+  // movl $(~0x12345678), %r10d
+  EmitAndCountInstruction(MCInstBuilder(X86::MOV32ri)
+		  .addReg(X86::R10D) // dst
+		  .addImm(~Imm));
+
+  // negl %r10d
+  EmitAndCountInstruction(MCInstBuilder(X86::NEG32r)
+		  .addReg(X86::R10D) // dst
+		  .addReg(X86::R10D) // src
+		  );
+
+  // cmpl %r10d, -off(%r11)
+  EmitAndCountInstruction(MCInstBuilder(X86::CMP32mr)
+                              .addReg(MI.getOperand(0).getReg()) // base
+                              .addImm(0) // scale
+                              .addReg(0) // index
+                              .addImm(-(Num+4)) // offset
+                              .addReg(0) // segment
+                              .addReg(X86::R10D) // reg
+			      );
 
   MCSymbol *Pass = OutContext.createTempSymbol();
   EmitAndCountInstruction(
