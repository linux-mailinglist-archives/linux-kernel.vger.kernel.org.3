Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92F257AABF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 02:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiGTACL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 20:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiGTABx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:01:53 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B744C63B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:01:50 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1oDx9t-0000cl-02; Wed, 20 Jul 2022 02:01:45 +0200
Message-ID: <32be2ea4-b60b-fbca-10c2-8c06f5bc135b@maciej.szmigiero.name>
Date:   Wed, 20 Jul 2022 02:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        hjl.tools@gmail.com, andrew.cooper3@citrix.com,
        mark.rutland@arm.com, will@kernel.org, ndesaulniers@google.com,
        x86@kernel.org, Ankur Arora <ankur.a.arora@oracle.com>
References: <20211204134338.760603010@infradead.org>
 <20211204134908.140103474@infradead.org>
 <9011132e-d78b-8bec-10cb-2b3d77a4e1fc@maciej.szmigiero.name>
 <Ytcguqp+/aTiOcnN@worktop.programming.kicks-ass.net>
 <YtcjEEpfvYmvHjmE@worktop.programming.kicks-ass.net>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC][PATCH] x86,nospec: Simplify {JMP,CALL}_NOSPEC
In-Reply-To: <YtcjEEpfvYmvHjmE@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2022 23:33, Peter Zijlstra wrote:
> On Tue, Jul 19, 2022 at 11:23:07PM +0200, Peter Zijlstra wrote:
>> Subject: x86,nospec: Simplify {JMP,CALL}_NOSPEC
>>
>> Have {JMP,CALL}_NOSPEC generate the same code GCC does for indirect
>> calls and rely on the objtool retpoline patching infrastructure.
>>
>> There's no reason these should be alternatives while the vast bulk of
>> compiler generated retpolines are not.
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> ---
>>   arch/x86/include/asm/nospec-branch.h | 24 ++++++++++++++++++------
>>   1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
>> index 10a3bfc1eb23..7bb319d2932c 100644
>> --- a/arch/x86/include/asm/nospec-branch.h
>> +++ b/arch/x86/include/asm/nospec-branch.h
>> @@ -93,6 +93,19 @@
>>   #endif
>>   .endm
>>   
>> +/*
>> + * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
>> + * to the retpoline thunk with a CS prefix when the register requires
>> + * a RAX prefix byte to encode. Also see apply_alternatives().
> 
> Obviously I meant: apply_retpolines() ...

Will apply_retpolines() actually patch in that trailing int3 in
the X86_FEATURE_RETPOLINE_LFENCE case?

Looking at its code it uses just ordinary NOPs as fill:
> 	/*
> 	 * For RETPOLINE_LFENCE: prepend the indirect CALL/JMP with an LFENCE.
> 	 */
> 	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
> 		bytes[i++] = 0x0f;
> 		bytes[i++] = 0xae;
> 		bytes[i++] = 0xe8; /* LFENCE */
> 	}
> 
> 	ret = emit_indirect(op, reg, bytes + i);
> 	if (ret < 0)
> 		return ret;
> 	i += ret;
> 
> 	for (; i < insn->length;)
> 		bytes[i++] = BYTES_NOP1;

BYTES_NOP1 is 0x90.

>> + */
>> +.macro __CS_PREFIX reg:req
>> +	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15
>> +	.ifc \reg,\rs
>> +	.byte 0x2e
>> +	.endif
>> +	.endr
>> +.endm
>> +
>>   /*
>>    * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
>>    * indirect jmp/call which may be susceptible to the Spectre variant 2
>> @@ -100,19 +113,18 @@
>>    */
>>   .macro JMP_NOSPEC reg:req
>>   #ifdef CONFIG_RETPOLINE
>> -	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
>> -		      __stringify(jmp __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
>> -		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_LFENCE
>> +	__CS_PREFIX \reg
>> +	jmp	__x86_indirect_thunk_\reg
>>   #else
>>   	jmp	*%\reg
>> +	int3
>>   #endif

Perhaps that int3 should be here to be common to both
"#ifdef CONFIG_RETPOLINE" branches?

>>   .endm
>>   

Thanks,
Maciej
