Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17A57E811
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiGVULa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbiGVUL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:11:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25747A9B98
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658520687; x=1690056687;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TDg/+6wBwme/2Hkfd05RWXB2rfGyaMu54q4M571X0q4=;
  b=VgoMhvGkkcvHUhMlIqdyIFndS5Q1DFMrnAFcmiMvUzwGhr93NHRyLmH/
   3NvbViZfK50q+hkDoyKlLzyWmVOj99HI3l+WijC143KdA/YSaJ1vZXJeU
   Ag+8gc8pBjk4/qiOapqAsgFPU/+C08Of6KtO0QCM6LQqbS5d58bJCLNT1
   Tg7NsTLygtex0jABTmlQIJ8Gnb2iax5vwksQ0g12WJnANuEK55PFphY+Y
   0DHwhLIQKVDdsb9DXEqM5bhues/N3/kEYlstXrnluZ92Lk7GekG010CmJ
   AB/JYgpGjiojJO22haFDrtYwBJq9Ll0xi8f4joXA8+kj21LywW46fveUh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="267792192"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="267792192"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 13:11:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="844883130"
Received: from schen9-mobl.jf.intel.com ([10.24.10.91])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 13:11:25 -0700
Message-ID: <e84fd559e79152d7065f7ceb3bcdd9af6b496ac5.camel@linux.intel.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
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
Date:   Fri, 22 Jul 2022 13:11:25 -0700
In-Reply-To: <87o7xmup5t.ffs@tglx>
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
         <87tu7euska.ffs@tglx>
         <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
         <87o7xmup5t.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-18 at 22:44 +0200, Thomas Gleixner wrote:
> On Mon, Jul 18 2022 at 12:51, Linus Torvalds wrote:
> > On Mon, Jul 18, 2022 at 12:30 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > Let the compiler add a 16 byte padding in front of each function entry
> > > point and put the call depth accounting there. That avoids calling out
> > > into the module area and reduces ITLB pressure.
> > 
> > Ooh.
> > 
> > I actually like this a lot better.
> > 
> > Could we just say "use this instead if you have SKL and care about the issue?"
> > 
> > I don't hate your module thunk trick, but this does seem *so* much
> > simpler, and if it performs better anyway, it really does seem like
> > the better approach.
> 
> Yes, Peter and I came from avoiding a new compiler and the overhead for
> everyone when putting the padding into the code. We realized only when
> staring at the perf data that this padding in front of the function
> might be an acceptable solution. I did some more tests today on different
> machines with mitigations=off with kernels compiled with and without
> that padding. I couldn't find a single test case where the result was
> outside of the usual noise. But then my tests are definitely incomplete.
> 

Here are some performance numbers for FIO running on a SKX server with
Intel Cold Stream SSD. Padding improves performance significantly.

Tested latest depth tracking code from Thomas:
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/log/?h=depthtracking
(SHA1 714d29e3e7e3faac27142424ae2533163ddd3a46)
latest gcc patch from Thomas is included at the end.


					Baseline	Baseline
read (kIOPs)		Mean	stdev	mitigations=off	retbleed=off	CPU util
================================================================================
mitigations=off		356.33	6.35	0.00%		7.11%		98.93%
retbleed=off		332.67	5.51	-6.64%		0.00%		99.16%
retbleed=ibrs		242.00	5.57	-32.09%		-27.25%		99.41%
retbleed=stuff (nopad)	281.67	4.62	-20.95%		-15.33%		99.35%
retbleed=stuff (pad)	310.67	0.58	-12.82%		-6.61%		99.29%
					
read/write 				Baseline 	Baseline 
70/30 (kIOPs)		Mean	stdev	mitigations=off	retbleed=off	CPU util
================================================================================
mitigations=off		340.60	8.12	0.00%		4.01%		96.80%
retbleed=off		327.47	8.03	-3.86%		0.00%		97.06%
retbleed=ibrs		239.47	0.75	-29.69%		-26.87%		98.23%
retbleed=stuff (nopad)	275.20	0.69	-19.20%		-15.96%		97.86%
retbleed=stuff (pad)	296.60	2.03	-12.92%		-9.43%		97.14%
					
					Baseline 	Baseline 
write (kIOPs)		Mean	stdev	mitigations=off	retbleed=off	CPU util
================================================================================
mitigations=off		299.33	4.04	0.00%		7.16%		93.51%
retbleed=off		279.33	7.51	-6.68%		0.00%		94.30%
retbleed=ibrs		231.33	0.58	-22.72%		-17.18%		95.84%
retbleed=stuff (nopad)	257.67	0.58	-13.92%		-7.76%		94.96%
retbleed=stuff (pad)	274.67	1.53	-8.24%		-1.67%		94.31%


Tim

gcc patch from Thomas:


---
 gcc/config/i386/i386.cc  |   13 +++++++++++++
 gcc/config/i386/i386.h   |    7 +++++++
 gcc/config/i386/i386.opt |    4 ++++
 gcc/doc/invoke.texi      |    6 ++++++
 4 files changed, 30 insertions(+)

--- a/gcc/config/i386/i386.cc
+++ b/gcc/config/i386/i386.cc
@@ -6182,6 +6182,19 @@ ix86_code_end (void)
     file_end_indicate_split_stack ();
 }
 
+void
+x86_asm_output_function_prefix (FILE *asm_out_file,
+				const char *fnname ATTRIBUTE_UNUSED)
+{
+  if (force_function_padding)
+    {
+      fprintf (asm_out_file, "\t.align %d\n",
+	       1 << force_function_padding);
+      fprintf (asm_out_file, "\t.skip %d,0xcc\n",
+	       1 << force_function_padding);
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
 
+mforce-function-padding=
+Target Joined UInteger Var(force_function_padding) Init(0) IntegerRange(0, 6)
+Put a 2^$N byte padding area before each function
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



