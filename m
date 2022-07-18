Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE11578AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiGRTbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbiGRTay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:30:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B08532450
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:29:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658172588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aYp242IdwuYVAcj98nVtRD4XE77Ls9MIrbkAaHfo6PE=;
        b=Di8XvZdgMB0dJWVoPg3ft0laTZw67efewm9FLP1O0c6zTBcMNE/ae32cXyK8VRGTpPIjQ1
        HeglaPkvOZk7l0weG1+pyip6TnWL5/a3MZ14MHWXGuT8JTq0NyEzNPle3Z6N6zD/TPsWoq
        UVDNIlSqNx0jHuuV8qiGUan2iZzgvz19PGw3/SoQ1ao1khM/I+KV/u8jR9aQEtPRM6wXF0
        60iKOueSCAerggR5gSMn+TW/qlrJlyIOuPNAhqIMhLnRsHaUowRJelr2qHdpvyHawtjjhm
        5FdNqBxA6dJsfQBtOyIv1PoTsQXBv2Nwn0zZEW1oJTCNQgTrC6u0fdWMBAnBeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658172588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aYp242IdwuYVAcj98nVtRD4XE77Ls9MIrbkAaHfo6PE=;
        b=7n7eMEjCjsvhhP8rEfQFrT++bG6BpJTAQt+jSCPtnfeqvYipumofQOvFEdJuO+/NKYdNSB
        a0ssI+tMLLogb0DQ==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
In-Reply-To: <20220716230344.239749011@linutronix.de>
References: <20220716230344.239749011@linutronix.de>
Date:   Mon, 18 Jul 2022 21:29:47 +0200
Message-ID: <87wncauslw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17 2022 at 01:17, Thomas Gleixner wrote:
> The function alignment option does not work for that because it just
> guarantees that the next function entry is aligned, but the padding size
> depends on the position of the last instruction of the previous function
> which might be anything between 0 and padsize-1 obviously, which is not a
> good starting point to put 10 bytes of accounting code into it reliably.
>
> I hacked up GCC to emit such padding and from first experimentation it
> brings quite some performance back.
>
>            	      	 IBRS	    stuff       stuff(pad)
> sockperf 14   bytes: 	 -23.76%    -19.26%     -14.31%
> sockperf 1472 bytes: 	 -22.51%    -18.40%     -12.25%
> microbench:   	     	 +37.20%    +18.46%     +15.47%    
> hackbench:	     	 +21.24%    +10.94%     +10.12%
>
> For FIO I don't have numbers yet, but I expect FIO to get a significant
> gain too.
>
>>From a quick survey it seems to have no impact for the case where the
> thunks are not used. But that really needs some deep investigation and
> there is a potential conflict with the clang CFI efforts.
>
> The kernel text size increases with a Debian config from 9.9M to 10.4M, so
> about 5%. If the thunk is not 16 byte aligned, the text size increase is
> about 3%, but it turned out that 16 byte aligned is slightly faster.
>
> The 16 byte function alignment turned out to be beneficial in general even
> without the thunks. Not much of an improvement, but measurable. We should
> revisit this independent of these horrors.
>
> The implementation falls back to the allocated thunks when padding is not
> available. I'll send out the GCC patch and the required kernel patch as a
> reply to this series after polishing it a bit.

Here it goes. GCC hackery first.

---
Subject: gcc: Add padding in front of function entry points
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 15 Jul 2022 14:37:53 +0200

For testing purposes:

Add a 16 byte padding filled with int3 in front of each function entry
so the kernel can put call depth accounting into it.

Not-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 gcc/config/i386/i386.cc  |   11 +++++++++++
 gcc/config/i386/i386.h   |    7 +++++++
 gcc/config/i386/i386.opt |    4 ++++
 gcc/doc/invoke.texi      |    6 ++++++
 4 files changed, 28 insertions(+)

--- a/gcc/config/i386/i386.cc
+++ b/gcc/config/i386/i386.cc
@@ -6182,6 +6182,17 @@ ix86_code_end (void)
     file_end_indicate_split_stack ();
 }
 
+void
+x86_asm_output_function_prefix (FILE *asm_out_file,
+				const char *fnname ATTRIBUTE_UNUSED)
+{
+  if (flag_force_function_padding)
+    {
+      fprintf (asm_out_file, "\t.align 16\n");
+      fprintf (asm_out_file, "\t.skip 16,0xcc\n");
+    }
+}
+
 /* Emit code for the SET_GOT patterns.  */
 
 const char *
--- a/gcc/config/i386/i386.h
+++ b/gcc/config/i386/i386.h
@@ -2860,6 +2860,13 @@ extern enum attr_cpu ix86_schedule;
 #define LIBGCC2_UNWIND_ATTRIBUTE __attribute__((target ("no-mmx,no-sse")))
 #endif
 
+#include <stdio.h>
+extern void
+x86_asm_output_function_prefix (FILE *asm_out_file,
+				const char *fnname ATTRIBUTE_UNUSED);
+#undef ASM_OUTPUT_FUNCTION_PREFIX
+#define ASM_OUTPUT_FUNCTION_PREFIX x86_asm_output_function_prefix
+
 /*
 Local variables:
 version-control: t
--- a/gcc/config/i386/i386.opt
+++ b/gcc/config/i386/i386.opt
@@ -1064,6 +1064,10 @@ mindirect-branch=
 Target RejectNegative Joined Enum(indirect_branch) Var(ix86_indirect_branch) Init(indirect_branch_keep)
 Convert indirect call and jump to call and return thunks.
 
+mforce-function-padding
+Target Var(flag_force_function_padding) Init(0)
+Put a 16 byte padding area before each function
+
 mfunction-return=
 Target RejectNegative Joined Enum(indirect_branch) Var(ix86_function_return) Init(indirect_branch_keep)
 Convert function return to call and return thunk.
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -1451,6 +1451,7 @@ See RS/6000 and PowerPC Options.
 -mindirect-branch=@var{choice}  -mfunction-return=@var{choice} @gol
 -mindirect-branch-register -mharden-sls=@var{choice} @gol
 -mindirect-branch-cs-prefix -mneeded -mno-direct-extern-access}
+-mforce-function-padding @gol
 
 @emph{x86 Windows Options}
 @gccoptlist{-mconsole  -mcygwin  -mno-cygwin  -mdll @gol
@@ -32849,6 +32850,11 @@ Force all calls to functions to be indir
 when using Intel Processor Trace where it generates more precise timing
 information for function calls.
 
+@item -mforce-function-padding
+@opindex -mforce-function-padding
+Force a 16 byte padding are before each function which allows run-time
+code patching to put a special prologue before the function entry.
+
 @item -mmanual-endbr
 @opindex mmanual-endbr
 Insert ENDBR instruction at function entry only via the @code{cf_check}
