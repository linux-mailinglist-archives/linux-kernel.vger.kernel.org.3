Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064E44F0B9A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 19:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359690AbiDCRmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 13:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbiDCRmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 13:42:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AE922BDE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 10:40:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p8so6927427pfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r14zp06TFYUz+HGr+WGPyeJlAIncpVh0iIXgkiJ2aD4=;
        b=c5ouUgtcQeOOMgqKkhTAgUG/cjpMdSYlu6QbCbSPgx0d6mX6XNYscwTQcEkRAC0OSB
         MjQId8MVmFon8tCPgkeEf0cINy+gB+ocOLhfbyWUIgVwWHShN/ZFEqVt/lBtOzmr3Ebx
         4GUv+Y2wiZfhAL/u5Igirct1q4H8MYshQvh7gZw01q4xLyEr0FSnB3n6fqSDYj76D5rW
         eQOWddl42fIk9+dwakC+CiowmHgqzHew4OnCdiHnZca4QNxBJ97/cKNXgKDzhm17uEq8
         Lucx6ZMjwys1IK1UkiaD31BiBXoZ9YUwhHdnl8h/8nVrpNXMqhujdVL3MhTE4h4vKFZO
         N/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r14zp06TFYUz+HGr+WGPyeJlAIncpVh0iIXgkiJ2aD4=;
        b=7Yd2kIynPiPDWBdGyxd61xflIXgj6JXZBf0qQGIF0pux+3HqPjcxvNwC+LgsdwqX0V
         btcqNdFJ4jPN6wopn1wraGrY1EbneXKt6zo2oLtNmD/ziEB6ajTcteJQuzouKASEntXk
         KE2oPpf1wh0dsa1WmyIPYCmq6YUV26RITq62saKuykan3YpTxTVmJXwrPm31wCcA8X24
         UzFXP8f7WobTxpSMTWVcGXajU3UyMoqusoaSoWYwhNhIyweYb/ZGHXFgqEtaQU4UeVVU
         X2wumE8qdKZm0sjJ5SoBdeJ42q7sv3Jwq+69+uXeRc1crFOHTpLHuyidusSPjn0tX6Vg
         34qA==
X-Gm-Message-State: AOAM530Dy6tcBjxufiP6ZPuwVjrCea9/dkcnZ8WA0VeyRN2ZejV3M3TR
        auX9xGFI872tp2QEL6Xx5DM=
X-Google-Smtp-Source: ABdhPJzR4RSqQJftBRD5ishJ8GKRNbmPZVIiZA+Zw00K66Iwv3ZBHFMXdogVGGrW7AApIgTazwhUxQ==
X-Received: by 2002:a65:6943:0:b0:376:333b:1025 with SMTP id w3-20020a656943000000b00376333b1025mr23085768pgq.164.1649007613415;
        Sun, 03 Apr 2022 10:40:13 -0700 (PDT)
Received: from [192.168.219.17] (ip72-219-184-175.oc.oc.cox.net. [72.219.184.175])
        by smtp.gmail.com with ESMTPSA id l67-20020a633e46000000b003986e01e982sm7933773pga.67.2022.04.03.10.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 10:40:12 -0700 (PDT)
Message-ID: <6bf0a0b6-99ac-1555-31d5-ce74c8497dfa@gmail.com>
Date:   Sun, 3 Apr 2022 10:40:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64/io: Remind compiler that there is a memory side
 effect
Content-Language: en-US
To:     Andrew Pinski <pinskia@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        GCC Mailing List <gcc@gcc.gnu.org>, f.fainelli@gmail.com,
        maz@kernel.org, marcan@marcan.st,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220401164406.61583-1-jeremy.linton@arm.com>
 <Ykc0xrLv391/jdJj@FVFF77S0Q05N>
 <CA+=Sn1k23tzMKbMWKW7c3EBoXidJCT-k_k_oF_sKTsGLJTKTnw@mail.gmail.com>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <CA+=Sn1k23tzMKbMWKW7c3EBoXidJCT-k_k_oF_sKTsGLJTKTnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/2022 12:36 AM, Andrew Pinski wrote:
> On Fri, Apr 1, 2022 at 10:24 AM Mark Rutland via Gcc <gcc@gcc.gnu.org> wrote:
>>
>> Hi Jeremy,
>>
>> Thanks for raising this.
>>
>> On Fri, Apr 01, 2022 at 11:44:06AM -0500, Jeremy Linton wrote:
>>> The relaxed variants of read/write macros are only declared
>>> as `asm volatile()` which forces the compiler to generate the
>>> instruction in the code path as intended. The only problem
>>> is that it doesn't also tell the compiler that there may
>>> be memory side effects. Meaning that if a function is comprised
>>> entirely of relaxed io operations, the compiler may think that
>>> it only has register side effects and doesn't need to be called.
>>
>> As I mentioned on a private mail, I don't think that reasoning above is
>> correct, and I think this is a miscompilation (i.e. a compiler bug).
>>
>> The important thing is that any `asm volatile` may have a side effects
>> generally outside of memory or GPRs, and whether the assembly contains a memory
>> load/store is immaterial. We should not need to add a memory clobber in order
>> to retain the volatile semantic.
>>
>> See:
>>
>>    https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile
>>
>> ... and consider the x86 example that reads rdtsc, or an arm64 sequence like:
>>
>> | void do_sysreg_thing(void)
>> | {
>> |       unsigned long tmp;
>> |
>> |       tmp = read_sysreg(some_reg);
>> |       tmp |= SOME_BIT;
>> |       write_sysreg(some_reg);
>> | }
>>
>> ... where there's no memory that we should need to hazard against.
>>
>> This patch might workaround the issue, but I don't believe it is a correct fix.

I agree with Mark that this patch is an attempt to work around a bug in 
the GCC 12 compiler.
> 
> It might not be the most restricted fix but it is a fix.
> The best fix is to tell that you are writing to that location of memory.
> volatile asm does not do what you think it does.
> You didn't read further down about memory clobbers:
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-Registers
> Specifically this part:
> The "memory" clobber tells the compiler that the assembly code
> performs memory reads or writes to items other than those listed in
> the input and output operands

I agree that volatile asm does not do what I think it should do in this 
case, but it appears to me that it does not do what the documentation 
states that it should do, and that is the bug in GCC 12.

My interpretation of the referenced documentation is that the volatile 
qualifier of the asm keyword should prevent the GCC optimizer from 
performing certain optimizations. Of specific relevance in this scenario 
is the optimizers that "sometimes discard asm statements if they 
determine there is no need for the output variables."

The clobbers tell the compiler about side effects or dependencies that 
the asm block may have that could be relevant to code outside the asm 
block so that proper functionality can be preserved and the optimizer 
can still do a good job. The functions in this patch do access memory 
(well technically registers...) and therefore adding the "memory" 
clobber is not "wrong", but the read variants of these functions also 
access memory so adding the "memory" clobber to them would be equally 
appropriate (or inappropriate). This would not affect the functionality, 
but it is "heavy-handed" and can have an unnecessary effect on performance.

The "memory" clobber indicates that memory is somehow affected by the 
asm block and therefore requires the compiler to flush data in working 
registers to memory before the block and reload values from memory after 
the block. A better solution is to communicate the side effects more 
precisely to avoid operations that can be determined to be unnecessary.

In the case of these functions, the only address accessed is in register 
space. Accesses to register space can have all kinds of side effects, 
but these side effects are communicated to the compiler by declaring the 
addr formal parameter with the volatile and __iomem attributes. In this 
way it is clear to the compiler that any writes to addr by code before 
the start of the asm block must occur before entering the block and any 
accesses to addr by code after the block must occur after executing the 
block such that the use of the "memory" clobber is unnecessary.

> 
>>
>>> For an example function look at bcmgenet_enable_dma(), before the
>>> relaxed variants were removed. When built with gcc12 the code
>>> contains the asm blocks as expected, but then the function is
>>> never called.
>>
>> So it sounds like this is a regression in GCC 12, which IIUC isn't released yet
>> per:
> 
> It is NOT a bug in GCC 12. Just you depended on behavior which
> accidently worked in the cases you were looking at. GCC 12 did not
> change in this area at all even.

GCC 12 should not have changed in this area, but the evidence suggests 
that in fact the behavior has changed such that an asm volatile block 
can be discarded by an optimizer. This appears unintentional and is 
therefore a bug that should be corrected before release of the toolchain 
since it could potentially affect any asm volatile block in the Linux 
source.

Regards,
     Doug

> 
> Thanks,
> Andrew Pinski
> 
>>
>>    https://gcc.gnu.org/gcc-12/changes.html
>>
>> ... which says:
>>
>> | Note: GCC 12 has not been released yet
>>
>> Surely we can fix it prior to release?
>>
>> Thanks,
>> Mark.
>>
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>   arch/arm64/include/asm/io.h | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
>>> index 7fd836bea7eb..3cceda7948a0 100644
>>> --- a/arch/arm64/include/asm/io.h
>>> +++ b/arch/arm64/include/asm/io.h
>>> @@ -24,25 +24,25 @@
>>>   #define __raw_writeb __raw_writeb
>>>   static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
>>>   {
>>> -     asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr));
>>> +     asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
>>>   }
>>>
>>>   #define __raw_writew __raw_writew
>>>   static inline void __raw_writew(u16 val, volatile void __iomem *addr)
>>>   {
>>> -     asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr));
>>> +     asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
>>>   }
>>>
>>>   #define __raw_writel __raw_writel
>>>   static __always_inline void __raw_writel(u32 val, volatile void __iomem *addr)
>>>   {
>>> -     asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
>>> +     asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
>>>   }
>>>
>>>   #define __raw_writeq __raw_writeq
>>>   static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
>>>   {
>>> -     asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
>>> +     asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
>>>   }
>>>
>>>   #define __raw_readb __raw_readb
>>> --
>>> 2.35.1
>>>

