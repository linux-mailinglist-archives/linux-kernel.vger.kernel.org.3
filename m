Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD9C4B7AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbiBOWpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:45:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiBOWpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:45:35 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7040DF7454
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:45:23 -0800 (PST)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id E9B18100002;
        Tue, 15 Feb 2022 22:45:19 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 15 Feb 2022 14:45:19 -0800
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
In-Reply-To: <20220211133803.GV23216@worktop.programming.kicks-ass.net>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
 <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
 <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
 <20220211133803.GV23216@worktop.programming.kicks-ass.net>
Message-ID: <ad72aa54607151a5d838058f8493d9a7@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 05:38, Peter Zijlstra wrote:
> On Tue, Feb 08, 2022 at 09:18:44PM -0800, Joao Moreira wrote:
>> > Ah, excellent, thanks for the pointers. There's also this in the works:
>> > https://reviews.llvm.org/D119296 (a new CFI mode, designed to play nice
>> > to objtool, IBT, etc.)
>> 
>> Oh, great! Thanks for pointing it out. I guess I saw something with a
>> similar name before ;) 
>> https://www.blackhat.com/docs/asia-17/materials/asia-17-Moreira-Drop-The-Rop-Fine-Grained-Control-Flow-Integrity-For-The-Linux-Kernel.pdf
>> 
>> Jokes aside (and perhaps questions more targeted to Sami), from a 
>> diagonal
>> look it seems that this follows the good old tag approach proposed by
>> PaX/grsecurity, right? If this is the case, should I assume it could 
>> also
>> benefit from features like -mibt-seal? Also are you considering that 
>> perhaps
>> we can use alternatives to flip different CFI instrumentation as 
>> suggested
>> by PeterZ in another thread?
> 
> So, lets try and recap things from IRC yesterday. There's a whole bunch
> of things intertwining making indirect branches 'interesting'. Most of
> which I've not seen mentioned in Sami's KCFI proposal which makes it
> rather pointless.
> 
> I think we'll end up with something related to KCFI, but with distinct
> differences:
> 
>  - 32bit immediates for smaller code
>  - __kcfi_check_fail() is out for smaller code
>  - it must interact with IBT/BTI and retpolines
>  - we must be very careful with speculation.
> 
> Right, so because !IBT-CFI needs the check at the call site, like:
> 
> caller:
> 	cmpl	$0xdeadbeef, -0x4(%rax)		# 7 bytes
> 	je	1f				# 2 bytes
> 	ud2					# 2 bytes
> 1:	call	__x86_indirect_thunk_rax	# 5 bytes
> 
> 
> 	.align 16
> 	.byte 0xef, 0xbe, 0xad, 0xde		# 4 bytes
> func:
> 	...
> 	ret
> 
> 
> While FineIBT has them at the landing site:
> 
> caller:
> 	movl	$0xdeadbeef, %r11d		# 6 bytes
> 	call	__x86_indirect_thunk_rax	# 5 bytes
> 
> 
> 	.align 16
> func:
> 	endbr					# 4 bytes
> 	cmpl	$0xdeadbeef, %r11d		# 7 bytes
> 	je	1f				# 2 bytes
> 	ud2					# 2 bytes
> 1:	...
> 	ret
> 
> 
> It seems to me that always doing the check at the call-site is simpler,
> since it avoids code-bloat and patching work. That is, if we allow both
> we'll effectivly blow up the code by 11 + 13 bytes (11 at the call 
> site,
> 13 at function entry) as opposed to 11+4 or 6+13.
> 
> Which then yields:
> 
> caller:
> 	cmpl	$0xdeadbeef, -0x4(%rax)		# 7 bytes
> 	je	1f				# 2 bytes
> 	ud2					# 2 bytes
> 1:	call	__x86_indirect_thunk_rax	# 5 bytes
> 
> 
> 	.align 16
> 	.byte 0xef, 0xbe, 0xad, 0xde		# 4 bytes
> func:
> 	endbr					# 4 bytes
> 	...
> 	ret
> 
> For a combined 11+8 bytes overhead :/
> 
> Now, this setup provides:
> 
>  - minimal size (please yell if there's a smaller option I missed;
>    s/ud2/int3/ ?)
>  - since the retpoline handles speculation from stuff before it, the
>    load-miss induced speculation is covered.
>  - the 'je' branch is binary, leading to either the retpoline or the
>    ud2, both which are a speculation stop.
>  - the ud2 is placed such that if the exception is non-fatal, code
>    execution can recover
>  - when IBT is present we can rewrite the thunk call to:
> 
> 	lfence
> 	call *(%rax)
> 
>    and rely on the WAIT-FOR-ENDBR speculation stop (also 5 bytes).
>  - can disable CFI by replacing the cmpl with:
> 
> 	jmp	1f
> 
>    (or an 11 byte nop, which is just about possible). And since we
>    already have all retpoline thunk callsites in a section, we can
>    trivially find all CFI bits that are always in front it them.
>  - function pointer sanity
> 

Agreed that it is sensible to support CFI for CPUs without CET. KCFI is 
a win.
Yet, I still think that we should support FineIBT and there are a few 
reasons
for that (other than hopeful performance benefits).

- KCFI is more prone to the presence of unintended allowed targets. 
Since the
IBT scheme always rely on the same watermark tag (the ENDBR 
instruction), it
is easier to prevent these from being emitted by JIT/compilers (fwiiw, 
see
https://reviews.llvm.org/rGf385823e04f300c92ec03dbd660d621cc618a271 and
https://dl.acm.org/doi/10.1145/3337167.3337175).

- Regarding the space overhead, I can try to verify if FineIBT can be 
feasibly
reshaped into:

caller:
     movl    $0xdeadbeef,%r10            # 6 bytes
     sub     $0x5,%r11                   # 4 bytes
     call    *(%r11)                     # 5 bytes

     .align 16
     endbr                               # 4 bytes
     call __x86_fineibt_thunk_deadbeef   # 5 bytes
func+4:
     ...
     ret

__x86_fineibt_thunk_deadbeef:
     xor     $0xdeadbeef, %r10
     je      1f
     ud2
1:
     retq

This scheme would require less space and less runtime patching. We would 
need
one additional byte on callees to patch both the ENDBR and the 5-byte 
call
instruction, plus space to hold the thunks somewhere else. The thunks 
overhead
is then dilluted across the functions belonging to the same equivalence 
set,
as these will use the same thunk. On a quick analysis over defconfig, it 
seems
that the number of equivalence sets are ~25% of the number of functions 
(thus,
space overhead is cut to a fourth). I guess this would only require the 
KCFI
compiler support to emit an additional "0xcc" before the tag.

Thunks can also be placed in a special section and dropped during boot 
to
reduce the runtime memory footprint.

What do you think, is this worth investigating?

Also, in my understanding, r11 does not need to be preserved as, 
per-ABI, it
is a scratch register. So there is no need to add $0x5,%r11 back after 
the
call. Let me know if I'm mistaken.

> 
> Additionally, if we ensure all direct call are +4 and only indirect
> calls hit the ENDBR -- as it optimal anyway, saves on decoding ENDBR. 
> We
> can replace those ENDBR instructions of functions that should never be
> indirectly called with:
> 
> 	ud1    0x0(%rax),%eax
> 
> which is a 4 byte #UD. This gives us the property that even on !IBT
> hardware such a call will go *splat*.

Given that the space overhead is a big concern, isn't it better to use 
the
compiler support to prevent ENDBRs in the first place? Patching #UD is 
kinda
cool, yeah, but I don't see it providing meaningful security guarantees 
over
not having the ENDBRs emitted at all.

> 
> Further, Andrew put in the request for __attribute__((cfi_seed(blah)))
> to allow distinguishing indirect functions with otherwise identical
> signature; eg. cookie = hash32(blah##signature).
> 
> 
> Did I miss anything? Got anything wrong?

I understand that Today there are not too many CET-enabled CPUs out 
there,
and that the benefits might be a bit blurred currently. Yet, given that 
this
is something that should continuously change with time, would you object 
to
FineIBT as a build option, i.e., something which might not be supported 
by
alternatives when using defconfig?
