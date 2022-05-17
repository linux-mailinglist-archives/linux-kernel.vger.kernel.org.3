Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12AF529C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243216AbiEQIcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243156AbiEQIcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:32:41 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CA443ADA;
        Tue, 17 May 2022 01:32:39 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id C70C0240008;
        Tue, 17 May 2022 08:32:31 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 17 May 2022 01:32:31 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
In-Reply-To: <YoNXPVQRvIFS81aW@hirez.programming.kicks-ass.net>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
 <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
 <CABCJKucXA2jbTc9TF1mLUsEDKu52t71tzxpnsGOXY3_ks+W4Bg@mail.gmail.com>
 <20220516183047.GM76023@worktop.programming.kicks-ass.net>
 <202205161531.3339CA95@keescook>
 <YoNXPVQRvIFS81aW@hirez.programming.kicks-ass.net>
Message-ID: <141870fac344a671029e2684f84bc828@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Cons:
>> - FineIBT does callee-based hash verification, which means any
>>   attacker-constructed memory region just has to have an endbr and 
>> nops at
>>   "shellcode - 9". KCFI would need the region to have the hash at
>>   "shellcode - 6" and an endbr at "shellcode". However, that hash is 
>> well
>>   known, so it's not much protection.
> 
> How would you get the ENDBR there anyway? If you can write code it's
> game over.
> 
+1 here. If you can't keep W^X, both approaches are equally doomed.

Yet, there is a relevant detail here. ENDBR has a pre-defined/fixed 
opcode, which means that it is predictable from the binary perspective. 
Because of that, compilers already do security optimizations and prevent 
for example the emission of ENDBR's opcode as immediate operands. This 
very same approach can be used by JIT stuff, preventing ENDBRs to be 
emitted as unintended gadgets. Because KCFI hashes aren't predictable, 
you can't (or at least I can't think of a way to) prevent these from 
being emitted as operands, which means that if you have an IBT-able 
machine, you will want to enable it even if you have KCFI.

With this said, the instrumentation for KCFI on IBT-enabled machines 
should be of at least 9 bytes (5 for the hash/mov and 4 for ENDBR, not 
counting the additional 4 bytes we asked for).

>> - Potential performance hit due to making an additional "call" outside
>>   the cache lines of both caller and callee.
> 
> That was all an effort to shrink and simplify, all this CFI stuff is
> massive bloat :/
> 
> If we use %eax instead of %r10d for the hash transfer (as per Joao), 
> and
> use int3 instead of ud2, then we can shrink the fineibt sequence to:
> 
> __cfi_\func:
> 	endbr				# 4
> 	xorl	$0x12345678, %eax	# 5
> 	jz	1f			# 2
> 	int3				# 1
> \func:
> 	...
> 
> Which is 12 bytes, and needs a larger preamble (up from 9 in the 
> current
> proposal).

As per the above-analysis, if we can make FineIBT instrumentation fit in 
12 bytes, this means that the 9 bytes required for KCFI+IBT plus three 
bytes would suffice for having FineIBT (again, if we can make it fit). 
And this would make that call go away.

> 
> If we do the objtool/linker fixup, such that direct calls/jumps will
> *never* hit ENDBR, then we can do something ugly like:
> 
> 	kCFI			FineIBT
> 
> __cfi_\func:			__cfi_\func:
> 	int3				endbr
> 	movl $0x12345678, %rax		xorl $0x12345678, %eax
> 	int3				jz   1f
> 	int3				int3
> \func:
> 	endbr
> __direct_\func:			__direct_\func:
> 	...				...
> 
> which is 12 bytes on both sides and shrinks the preaamble to 8 bytes
> while additionally also supporting kCFI+IBT for those few people that
> don't care about speculation based attacks much.
> 
> But now it's complicated again and requires significant tools work :/
> (also, using int3 isn't ideal).
> 
>> Pros:
>> - FineIBT can be done without read access to the kernel text, which 
>> will
>>   be nice in the exec-only future.
> 
>   - Mostly kills SpectreBHB (because it has the hash check *after*
>     ENDBR).

- Callee-side checks allow you to make an specific function 
coarse-grained without making an indirect call instruction 
coarse-grained. I.e: If you have a binary blob or some function that for 
whatever reason can't have a hash, you just disable the check in this 
function, making it reachable by every indirect call in the binary but 
being reasonably able to measure the risks behind it. If you make an 
indirect call coarse-grained, this means that now this indirect call can 
reach all functions in the binary, including functions like 
"disable_cet" and "disable_super_nice_security_feature". The risk 
impacts of these latter relaxations are much harder to measure, imho 
(yet, I would enjoy hearing counter-arguments, if any).

> 
> So were IBT limits speculation to all sites that have ENDBR, you can
> still target any of them. With FineIBT you loose all sites that don't
> match on hash value, significantly reducing the options.
> 
>> I'd kind of like the "dynamic FineIBT conversion" to be a config 
>> option,
>> at least at first. We could at least do performance comparisons 
>> between
>> them.
> 
> Why would you need a config option for that? Since it is dynamic anyway
> a boot option works fine.
> 
> 
> Also, regardless of all this, it probably makes sense to add an LTO 
> pass
> to remove all unused __cfi_ symbols and endbr instructions, less viable
> targets is more better :-)

We have that for IBT in clang already (I implemented and upstreamed it 
back when you were trying ibt-seal in objtool). I did not find the time 
to test it with the final IBT support but it is in my todo list to take 
a look and perhaps send a RFC here. FWIIW, 
https://reviews.llvm.org/D116070

> 
> I've been doing that with objtool for the IBT builds.
