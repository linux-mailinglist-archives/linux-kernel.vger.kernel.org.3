Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563C45650C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiGDJ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbiGDJ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:27:26 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCF02CE0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:27:24 -0700 (PDT)
Received: from [198.18.0.1] (unknown [192.168.200.1])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxWeBxssJi2E0IAA--.20655S3;
        Mon, 04 Jul 2022 17:27:14 +0800 (CST)
Message-ID: <7904571e-3ef4-5841-497d-6796c8c36c52@loongson.cn>
Date:   Mon, 4 Jul 2022 17:27:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] LoongArch: Clean useless vcsr in loongarch_fpu.
Content-Language: en-US
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220704061402.683762-1-huqi@loongson.cn>
 <1470d272-e148-c600-f759-a1e2dac776e1@xen0n.name>
From:   huqi <huqi@loongson.cn>
In-Reply-To: <1470d272-e148-c600-f759-a1e2dac776e1@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxWeBxssJi2E0IAA--.20655S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW7trW8ury8KF15trWxXrb_yoWrAryrpF
        1kAr1kJFW5Gr1kJryUtr1UWryUJr1UGw12qF1UJFy8Jr4UXr1jgr18Xr1qgF1UJw48Jr10
        qF1rXw17ZF1UJ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQARCV3QvPwsxQADs+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/4 15:28, WANG Xuerui wrote:
> On 2022/7/4 14:14, huqi wrote:
>> From: Qi Hu <huqi@loongson.cn>
>>
>> The `vcsr` do not use anymore. Remove this member from `loongarch_fpu`.
> "The VCSR is not used any more."
Thanks, this is incorrect to use `use`.
>>
>> Signed-off-by: Qi Hu <huqi@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/fpregdef.h  |  1 -
>>   arch/loongarch/include/asm/processor.h |  2 --
>>   arch/loongarch/kernel/asm-offsets.c    |  1 -
>>   arch/loongarch/kernel/fpu.S            | 10 ----------
>>   4 files changed, 14 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/fpregdef.h 
>> b/arch/loongarch/include/asm/fpregdef.h
>> index adb16e4b43b0..b6be527831dd 100644
>> --- a/arch/loongarch/include/asm/fpregdef.h
>> +++ b/arch/loongarch/include/asm/fpregdef.h
>> @@ -48,6 +48,5 @@
>>   #define fcsr1    $r1
>>   #define fcsr2    $r2
>>   #define fcsr3    $r3
>> -#define vcsr16    $r16
>>     #endif /* _ASM_FPREGDEF_H */
>> diff --git a/arch/loongarch/include/asm/processor.h 
>> b/arch/loongarch/include/asm/processor.h
>> index 1d63c934b289..57ec45aa078e 100644
>> --- a/arch/loongarch/include/asm/processor.h
>> +++ b/arch/loongarch/include/asm/processor.h
>> @@ -80,7 +80,6 @@ BUILD_FPR_ACCESS(64)
>>     struct loongarch_fpu {
>>       unsigned int    fcsr;
>> -    unsigned int    vcsr;
>>       uint64_t    fcc;    /* 8x8 */
>>       union fpureg    fpr[NUM_FPU_REGS];
>>   };
>> @@ -161,7 +160,6 @@ struct thread_struct {
>>        */                            \
>>       .fpu            = {                \
>>           .fcsr        = 0,                \
>> -        .vcsr        = 0,                \
>>           .fcc        = 0,                \
>>           .fpr        = {{{0,},},},            \
>>       },                            \
>> diff --git a/arch/loongarch/kernel/asm-offsets.c 
>> b/arch/loongarch/kernel/asm-offsets.c
>> index bfb65eb2844f..20cd9e16a95a 100644
>> --- a/arch/loongarch/kernel/asm-offsets.c
>> +++ b/arch/loongarch/kernel/asm-offsets.c
>> @@ -166,7 +166,6 @@ void output_thread_fpu_defines(void)
>>         OFFSET(THREAD_FCSR, loongarch_fpu, fcsr);
>>       OFFSET(THREAD_FCC,  loongarch_fpu, fcc);
>> -    OFFSET(THREAD_VCSR, loongarch_fpu, vcsr);
>>       BLANK();
>>   }
>>   diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
>> index 75c6ce0682a2..a631a7137667 100644
>> --- a/arch/loongarch/kernel/fpu.S
>> +++ b/arch/loongarch/kernel/fpu.S
>> @@ -146,16 +146,6 @@
>>       movgr2fcsr    fcsr0, \tmp0
>>       .endm
>>   -    .macro sc_save_vcsr base, tmp0
>> -    movfcsr2gr    \tmp0, vcsr16
>> -    EX    st.w \tmp0, \base, 0
>> -    .endm
>> -
>> -    .macro sc_restore_vcsr base, tmp0
>> -    EX    ld.w \tmp0, \base, 0
>> -    movgr2fcsr    vcsr16, \tmp0
>> -    .endm
>> -
>>   /*
>>    * Save a thread's fp context.
>>    */
>
> The original code was written with future LSX/LASX support in mind; 
> the code is dead currently, but expected to get utilized Soon (TM).
>
> So, I'd like to confirm if future LoongArch models would *not* feature 
> LSX/LASX in its current form, and that the Loongson Corporation is not 
> going to upstream LSX/LASX support, given you are apparently a 
> Loongson employee with the first-hand information? We'd like to avoid 
> code churn in general, so if the LSX/LASX support is to be eventually 
> mainlined, removing them now would only lead to them being introduced 
> later.

`vcsr` is removed because it has been removed in hardware. What's more, 
it will not be used to support LSX/LASX in the future.

