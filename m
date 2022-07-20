Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D8157BF75
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiGTVOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGTVOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:14:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6601442AD3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kMWXfrkX0KV7UVEW0A2YIUVYYSZnVBn30EuggOhd7MY=; b=FkKAQDFjSfsxjXz1O5O2/7J33N
        J5htel6g80VHLNqLCAX79raT1BAi/dhn6+sFlz8inHye1N3kXe1c4U22CAwDMdvl1cxpbzXy2jgeI
        vW/TGGDwVI0MPKeUz/PVGPG9vkEyYubf8zvHbiVND1vZvAtDgDr8z9K6fSi7p2WzDLeTxVE+84KGi
        xOCoXew0MWeNf+3OQ4QFx9opOodBC3pO89xupVUEg4vI9JetiSZVwMXyeZMXqgiPsWkHCLJpIBFjf
        1FJ+HqwJ5W8GIZ1Nu3nYUvYZRtjoockxmKnqMAPbSCFvbfgPDzB0e1byV74YONjL13UjzEbPFC3o5
        QDqUkeMQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEH0Q-005PHu-VE; Wed, 20 Jul 2022 21:13:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9746980BBE; Wed, 20 Jul 2022 23:13:16 +0200 (CEST)
Date:   Wed, 20 Jul 2022 23:13:16 +0200
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
Message-ID: <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
References: <87lesqukm5.ffs@tglx>
 <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx>
 <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
 <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytbnlms90+LBLbrY@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:19:18AM -0700, Sami Tolvanen wrote:

> Clang's current CFI implementation is somewhat similar to this. It
> creates separate thunks for address-taken functions and changes
> function addresses in C code to point to the thunks instead.
> 
> While this works, it creates painful situations when interacting with
> assembly (e.g. a function address taken in assembly cannot be used
> for indirect calls in C as it doesn't point to the thunk) and needs
> unpleasant hacks when we want take the actual function address in C
> (i.e. scattering the code with function_nocfi() calls).
> 
> I have to agree with Peter on this, I would rather avoid messing with
> function pointers in KCFI to avoid these issues.

It is either this; and I think I can avoid the worst of it (see below);
or grow the indirect_callsites to obscure the immediate (as Linus
suggested), there's around ~16k indirect callsites in a defconfig-ish
kernel, so growing it isn't too horrible, but it isn't nice either.

The prettiest option to obscure the immediate at the callsite I could
conjure up is something like:

kcfi_caller_linus:
	movl	$0x12345600, %r10d
	movb	$0x78, %r10b
	cmpl	%r10d, -OFFSET(%r11)
	je	1f
	ud2
1:	call	__x86_thunk_indirect_r11

Which comes to around 22 bytes (+5 over the original).

Joao suggested putting part of that in the retpoline thunk like:

kcfi_caller_joao:
	movl	$0x12345600, %r10d
	movb	$0x78, %r10b
	call	__x86_thunk_indirect_cfi

__x86_thunk_indirect_cfi:
	cmpl    %r10d, -OFFSET(%r11)
	je      1f
	ud2
1:
	call    1f
	int3
1:
	mov     %r11, (%rsp)
	ret
	int3

The only down-side there is that eIBRS hardware doesn't need retpolines
(given we currently default to ignoring Spectre-BHB) and as such this
doesn't really work nicely (we don't want to re-introduce funneling).


The other option I came up with, alluded to above, is below, and having
written it out, I'm pretty sure I faviour just growing the indirect
callsite as per Linus' option above.

Suppose:

indirect_callsite:
	cmpl	$0x12345678, -6(%r11)		# 8
	je	1f				# 2
	ud2					# 2
	call	__x86_indirect_thunk_r11	# 5	(-> .retpoline_sites)


__cfi_\func:
	movl	$0x12345678, %eax		# 5
	int3					# 1
	int3					# 1
\func:			# aligned 16
	endbr					# 4
	nop12					# 12
	call __fentry__				# 5
	...


And for functions that do not get their address taken:


\func:			# aligned 16
	nop16					# 16
	call __fentry__				# 5
	...



Instead, extend the objtool .call_sites to also include tail-calls and
for:

 - regular (!SKL, !IBT) systems;
   * patch all direct calls/jmps to +16		(.call_sites)
   * static_call/ftrace/etc.. can triviall add the +16
   * retpolines can do +16 for the indirect calls
   * retutn thunks are patched to ret;int3	(.return_sites)

   (indirect calls for eIBRS which don't use retpoline
    simply eat the nops)


 - SKL systems;
   * patch the first 16 bytes into:

	nop6
	sarq	$5, PER_CPU_VAR(__x86_call_depth)

   * patch all direct calls to +6		(.call_sites)
   * patch all direct jumps to +16		(.call_sites)
   * static_call/ftrace adjust to +6/+16 depending on instruction type
   * retpolines are split between call/jmp and do +6/+16 resp.
   * return thunks are patches to x86_return_skl (.return_sites)


 - IBT systes;
   * patch the first 16 bytes to:

	endbr					# 4
	xorl	$0x12345678, %r10d		# 7
	je	1f				# 2
	ud2					# 2
	nop					# 1
1:

   * patch the callsites to:			(.retpoline_sites)

	movl	$0x12345678, %r10d		# 7
	call	*$r11				# 3
	nop7					# 7

   * patch all the direct calls/jmps to +16	(.call_sites)
   * static_call/ftrace/etc.. add +16
   * retutn thunks are patched to ret;int3	(.return_sites)


Yes, frobbing the address for static_call/ftrace/etc.. is a bit
horrible, but at least &sym remains exactly that address and not
something magical.

Note: It is possible to shift the __fentry__ call, but that would mean
that we loose alignment or get to carry .call_sites at runtime (and it
is *huge*)


