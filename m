Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD4569BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiGGHgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiGGHfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:35:32 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00BA327FC8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:35:30 -0700 (PDT)
Received: from [10.90.50.23] (unknown [192.168.200.1])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv9C9jMZibp8OAA--.1787S3;
        Thu, 07 Jul 2022 15:35:25 +0800 (CST)
Message-ID: <8a9cd14a-54ed-cd2b-88ad-647a43b09d0e@loongson.cn>
Date:   Thu, 7 Jul 2022 15:35:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] LoongArch: Remove vcsr in loongarch_fpu
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <20220706112937.1218573-1-huqi@loongson.cn>
 <CAAhV-H6MHjzdwyZqk6a3sKByRofG1Th6QEk0Be5NBhiAsVNcTg@mail.gmail.com>
From:   Qi Hu <huqi@loongson.cn>
In-Reply-To: <CAAhV-H6MHjzdwyZqk6a3sKByRofG1Th6QEk0Be5NBhiAsVNcTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxv9C9jMZibp8OAA--.1787S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4fJF1rtryxXF4UtFWfAFb_yoWrJF15pF
        ZrAF4kGF4rGrn3tryqy34DWFWktw4DGw12gasFkFyrCr4qqw1kWry8tF98uFyjqa1FkrW0
        gFyrWwnaqF1UX3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQAACV3QvPyW3wABsN
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
>
> Particularly, fcsr16 to fcsr31 are reserved for LSX/LASX now, access to
> these registers has no visible effect if LSX/LASX is enabled, and will
> cause SXD/ASXD exceptions if LSX/LASX is not enabled.
>
> So, mentions of vcsr are obsolete in the first place, let's remove them.

Or simply say this?

Remove VCSR from "loongarch_fpu" which is used for debugging.
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

