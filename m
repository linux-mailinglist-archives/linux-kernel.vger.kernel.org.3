Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F2C569B51
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiGGHNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiGGHNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:13:40 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0089E2A719
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1657178015; bh=ppbGeYOQcIvSTiYj6vLLsomHZRDhW2cFfKDbRX+db6U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WjRzEqDqktrI48vPzdcQq4D3jO8oqbt3yBlDzJncnbSU02vXOLBjPFX1ry6B9sWbY
         YbjLkmNnZVOzxhohwQLsPS8EqcjB4qI+rY/a8dAsILcERzqqSaZ1TZH5G/lyd/KV5z
         sTlyWl6AetR6ULV/Ya3muCHhwzhG3gx3r/1Evr2s=
Received: from [100.100.57.190] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 3B6EB6010B;
        Thu,  7 Jul 2022 15:13:35 +0800 (CST)
Message-ID: <0145342f-920a-0ce6-e50e-2b3285b5fb4f@xen0n.name>
Date:   Thu, 7 Jul 2022 15:13:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH v3] LoongArch: Remove vcsr in loongarch_fpu
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>, huqi <huqi@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <20220706112937.1218573-1-huqi@loongson.cn>
 <CAAhV-H6MHjzdwyZqk6a3sKByRofG1Th6QEk0Be5NBhiAsVNcTg@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H6MHjzdwyZqk6a3sKByRofG1Th6QEk0Be5NBhiAsVNcTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/7 14:45, Huacai Chen wrote:
> Hi, all,
>
> I have rewritten the commit message. If no problem, this patch will be
> queued for loongarch-fixes.
> --
> The `vcsr` only exists in the old hardware design, it isn't used in any
> shipped hardware from Loongson-3A5000 on. FPU and LSX/LASX both use the
> `fcsr` as their control and status registers now. For example, the RM
> control bit in fcsr0 is shared by FPU, LSX and LASX.

FPU is a function unit while LSX/LASX are ISA extensions, they don't 
belong to the same category.

"Scalar FP and LSX/LASX instructions all use ...", and "... is shared by 
FP, LSX and LASX instructions." sound better.

> Particularly, fcsr16 to fcsr31 are reserved for LSX/LASX now, access to
> these registers has no visible effect if LSX/LASX is enabled, and will
> cause SXD/ASXD exceptions if LSX/LASX is not enabled.
>
> So, mentions of vcsr are obsolete in the first place, let's remove them.

Works for me and the wording is objective enough.

> --
> Huacai
>
> On Wed, Jul 6, 2022 at 7:29 PM huqi <huqi@loongson.cn> wrote:
>> From: Qi Hu <huqi@loongson.cn>
>>
>> The `vcsr` is not used anymore. Remove this member from `loongarch_fpu`.
>>
>>  From 3A5000(LoongArch), `vcsr` is removed in hardware. FP and LSX/LASX
>> both use `fcsr` as their csr.
>>
>> Particularly, fcsr from $r16 to $r31 are reserved for LSX/LASX, an
>> using the registers in this area will cause SXD/ASXD if LSX/LASX is
>> not enabled.
>>
>> Signed-off-by: Qi Hu <huqi@loongson.cn>
>> ---
>> V3:
>> - Modify commit message to conform to the format.
>> V2:
>> - Add more details in the commit message.
>> ---
>>   arch/loongarch/include/asm/fpregdef.h  |  1 -
>>   arch/loongarch/include/asm/processor.h |  2 --
>>   arch/loongarch/kernel/asm-offsets.c    |  1 -
>>   arch/loongarch/kernel/fpu.S            | 10 ----------
>>   4 files changed, 14 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/fpregdef.h b/arch/loongarch/include/asm/fpregdef.h
>> index adb16e4b43b0..b6be527831dd 100644
>> --- a/arch/loongarch/include/asm/fpregdef.h
>> +++ b/arch/loongarch/include/asm/fpregdef.h
>> @@ -48,6 +48,5 @@
>>   #define fcsr1  $r1
>>   #define fcsr2  $r2
>>   #define fcsr3  $r3
>> -#define vcsr16 $r16
>>
>>   #endif /* _ASM_FPREGDEF_H */
>> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
>> index 1d63c934b289..57ec45aa078e 100644
>> --- a/arch/loongarch/include/asm/processor.h
>> +++ b/arch/loongarch/include/asm/processor.h
>> @@ -80,7 +80,6 @@ BUILD_FPR_ACCESS(64)
>>
>>   struct loongarch_fpu {
>>          unsigned int    fcsr;
>> -       unsigned int    vcsr;
>>          uint64_t        fcc;    /* 8x8 */
>>          union fpureg    fpr[NUM_FPU_REGS];
>>   };
>> @@ -161,7 +160,6 @@ struct thread_struct {
>>           */                                                     \
>>          .fpu                    = {                             \
>>                  .fcsr           = 0,                            \
>> -               .vcsr           = 0,                            \
>>                  .fcc            = 0,                            \
>>                  .fpr            = {{{0,},},},                   \
>>          },                                                      \
>> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
>> index bfb65eb2844f..20cd9e16a95a 100644
>> --- a/arch/loongarch/kernel/asm-offsets.c
>> +++ b/arch/loongarch/kernel/asm-offsets.c
>> @@ -166,7 +166,6 @@ void output_thread_fpu_defines(void)
>>
>>          OFFSET(THREAD_FCSR, loongarch_fpu, fcsr);
>>          OFFSET(THREAD_FCC,  loongarch_fpu, fcc);
>> -       OFFSET(THREAD_VCSR, loongarch_fpu, vcsr);
>>          BLANK();
>>   }
>>
>> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
>> index 75c6ce0682a2..a631a7137667 100644
>> --- a/arch/loongarch/kernel/fpu.S
>> +++ b/arch/loongarch/kernel/fpu.S
>> @@ -146,16 +146,6 @@
>>          movgr2fcsr      fcsr0, \tmp0
>>          .endm
>>
>> -       .macro sc_save_vcsr base, tmp0
>> -       movfcsr2gr      \tmp0, vcsr16
>> -       EX      st.w \tmp0, \base, 0
>> -       .endm
>> -
>> -       .macro sc_restore_vcsr base, tmp0
>> -       EX      ld.w \tmp0, \base, 0
>> -       movgr2fcsr      vcsr16, \tmp0
>> -       .endm
>> -
>>   /*
>>    * Save a thread's fp context.
>>    */
>> --
>> 2.36.1
>>
>>
Apart from the syntactical nit:

Reviewed-by: WANG Xuerui <git@xen0n.name>

