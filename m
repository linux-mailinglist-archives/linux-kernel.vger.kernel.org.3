Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2325D57DFAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiGVKYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVKYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:24:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D6C8B4A1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JewJGBF/2Yab/pmC1U9UTeyXT/BvvNgrbp/cLHueN5Y=; b=jFaBp6/UMaerRjoV1IOxXTri7p
        47fnsk42NxU//aRxORE9jGiXh7qCRLCDAlH+jFh7WmwXlp59rCHoYE9HuwtmYiwgRUxTLDFDAm9uO
        76W3YJyx3MS8E4UglGD9FIUXgHFklY/CYtVc5i2kOlfKcrEiiKNwQZT95eP2wxFwrqMA5csKeBmpg
        SWG9xvft1oP8zqUAljWyht0vf5TI7uORrQDda0EupXfNV68elSz882/zIk+yXlHMq3IOJif3u0cag
        zXYBO8JzES159fL559KFT7UfaGoxEgHRN7hqU9XTOQN4l126SvwUMBO1PudXGIqRQOkyRehpyU5w3
        DYPrf7mw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEpoi-005pge-El; Fri, 22 Jul 2022 10:23:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13E0098029B; Fri, 22 Jul 2022 12:23:31 +0200 (CEST)
Date:   Fri, 22 Jul 2022 12:23:30 +0200
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
Message-ID: <Ytp6ooFQMLr3/h6v@worktop.programming.kicks-ass.net>
References: <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
 <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com>
 <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
 <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net>
 <YtmTK93vHWQUFinE@worktop.programming.kicks-ass.net>
 <CAHk-=whLGENEkjME_v_3P1SwhwjzH4GK2RLA3fn=yQNuyKLBkg@mail.gmail.com>
 <YtmagFcae43wzwCf@worktop.programming.kicks-ass.net>
 <YtnsTs8XkPS4nXdi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtnsTs8XkPS4nXdi@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 05:16:14PM -0700, Sami Tolvanen wrote:

> That looks good to me. I updated my LLVM tree to generate this code
> for the checks:
> 
> https://github.com/samitolvanen/llvm-project/commits/kcfi

Thanks!

The alignment thing you added:

  // Emit int3 padding before the type information to maintain alignment.
  // The X86::MOV32ri instruction we emit is 5 bytes long.
  uint64_t Padding = offsetToAlignment(5, MF.getAlignment());
  while (Padding--)
    EmitAndCountInstruction(MCInstBuilder(X86::INT3));

Doesn't seem to quite do what we want though.

When I use -fpatchable-function-entry=16,16 we effectively get a 32 byte
prefix on every function:

0000000000000000 <__cfi___traceiter_sched_kthread_stop>:
       0:       cc                      int3
       1:       cc                      int3
       2:       cc                      int3
       3:       cc                      int3
       4:       cc                      int3
       5:       cc                      int3
       6:       cc                      int3
       7:       cc                      int3
       8:       cc                      int3
       9:       cc                      int3
       a:       cc                      int3
       b:       b8 26 b1 df 98          mov    $0x98dfb126,%eax
      10:       90                      nop
      11:       90                      nop
      12:       90                      nop
      13:       90                      nop
      14:       90                      nop
      15:       90                      nop
      16:       90                      nop
      17:       90                      nop
      18:       90                      nop
      19:       90                      nop
      1a:       90                      nop
      1b:       90                      nop
      1c:       90                      nop
      1d:       90                      nop
      1e:       90                      nop
      1f:       90                      nop

And given the parameters, that's indeed the only option. However, given
I can scribble the type thing just fine when moving to FineIBT and the
whole Skylake depth tracking only needs 10 bytes, I figured I'd try:
-fpatchable-function-entry=11,11 instead. But that resulted in
unalignment:

0000000000000000 <__cfi___traceiter_sched_kthread_stop>:
       0:       cc                      int3
       1:       cc                      int3
       2:       cc                      int3
       3:       cc                      int3
       4:       cc                      int3
       5:       cc                      int3
       6:       cc                      int3
       7:       cc                      int3
       8:       cc                      int3
       9:       cc                      int3
       a:       cc                      int3
       b:       b8 26 b1 df 98          mov    $0x98dfb126,%eax
      10:       90                      nop
      11:       90                      nop
      12:       90                      nop
      13:       90                      nop
      14:       90                      nop
      15:       90                      nop
      16:       90                      nop
      17:       90                      nop
      18:       90                      nop
      19:       90                      nop
      1a:       90                      nop

000000000000001b <__traceiter_sched_kthread_stop>:

However, if I change clang like so:

 llvm/lib/Target/X86/X86AsmPrinter.cpp | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/llvm/lib/Target/X86/X86AsmPrinter.cpp b/llvm/lib/Target/X86/X86AsmPrinter.cpp
index 789597f8ef1a..6c94313a197d 100644
--- a/llvm/lib/Target/X86/X86AsmPrinter.cpp
+++ b/llvm/lib/Target/X86/X86AsmPrinter.cpp
@@ -124,9 +124,15 @@ void X86AsmPrinter::emitKCFITypeId(const MachineFunction &MF,
     OutStreamer->emitSymbolAttribute(FnSym, MCSA_ELF_TypeFunction);
   OutStreamer->emitLabel(FnSym);
 
+  int64_t PrefixNops = 0;
+  (void)MF.getFunction()
+      .getFnAttribute("patchable-function-prefix")
+      .getValueAsString()
+      .getAsInteger(10, PrefixNops);
+
   // Emit int3 padding before the type information to maintain alignment.
   // The X86::MOV32ri instruction we emit is 5 bytes long.
-  uint64_t Padding = offsetToAlignment(5, MF.getAlignment());
+  uint64_t Padding = offsetToAlignment(5+PrefixNops, MF.getAlignment());
   while (Padding--)
     EmitAndCountInstruction(MCInstBuilder(X86::INT3));
 

Then it becomes:

0000000000000000 <__cfi___traceiter_sched_kthread_stop>:
       0:       b8 26 b1 df 98          mov    $0x98dfb126,%eax
       5:       90                      nop
       6:       90                      nop
       7:       90                      nop
       8:       90                      nop
       9:       90                      nop
       a:       90                      nop
       b:       90                      nop
       c:       90                      nop
       d:       90                      nop
       e:       90                      nop
       f:       90                      nop

0000000000000010 <__traceiter_sched_kthread_stop>:

and things are 'good' again, except for functions that don't get a kcfi
preamble, those are unaligned... I couldn't find where the
patchable-function-prefix nops are generated to fix this up :/


Also; could you perhaps add a switch to supress ENDBR for functions with
a kCFI preamble ?
