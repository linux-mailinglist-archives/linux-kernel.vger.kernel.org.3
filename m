Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B041447BB39
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhLUHjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:39:37 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44549 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235359AbhLUHje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:39:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V.JbicZ_1640072369;
Received: from 30.240.100.46(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V.JbicZ_1640072369)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 15:39:30 +0800
Message-ID: <404b02be-2e94-1d80-8512-f25a5a93378e@linux.alibaba.com>
Date:   Tue, 21 Dec 2021 15:39:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH 5/6] crypto: x86/sm3 - add AVX assembly implementation
Content-Language: en-US
To:     Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211220082251.1445-1-tianjia.zhang@linux.alibaba.com>
 <20211220082251.1445-6-tianjia.zhang@linux.alibaba.com>
 <9e70bf33-bab5-83a3-1eb0-7cae442c2f64@iki.fi>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <9e70bf33-bab5-83a3-1eb0-7cae442c2f64@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/21 2:03 AM, Jussi Kivilinna wrote:
> On 20.12.2021 10.22, Tianjia Zhang wrote:
>> This patch adds AVX assembly accelerated implementation of SM3 secure
>> hash algorithm. From the benchmark data, compared to pure software
>> implementation sm3-generic, the performance increase is up to 38%.
>>
>> The main algorithm implementation based on SM3 AES/BMI2 accelerated
>> work by libgcrypt at:
>> https://gnupg.org/software/libgcrypt/index.html
>>
>> Benchmark on Intel i5-6200U 2.30GHz, performance data of two
>> implementations, pure software sm3-generic and sm3-avx acceleration.
>> The data comes from the 326 mode and 422 mode of tcrypt. The abscissas
>> are different lengths of per update. The data is tabulated and the
>> unit is Mb/s:
>>
>> update-size |     16      64     256    1024    2048    4096    8192
>> --------------------------------------------------------------------
>> sm3-generic | 105.97  129.60  182.12  189.62  188.06  193.66  194.88
>> sm3-avx     | 119.87  163.05  244.44  260.92  257.60  264.87  265.88
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   arch/x86/crypto/Makefile         |   3 +
>>   arch/x86/crypto/sm3-avx-asm_64.S | 521 +++++++++++++++++++++++++++++++
>>   arch/x86/crypto/sm3_avx_glue.c   | 134 ++++++++
>>   crypto/Kconfig                   |  13 +
>>   4 files changed, 671 insertions(+)
>>   create mode 100644 arch/x86/crypto/sm3-avx-asm_64.S
>>   create mode 100644 arch/x86/crypto/sm3_avx_glue.c
>>
>> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
>> index f307c93fc90a..7cbe860f6201 100644
>> --- a/arch/x86/crypto/Makefile
>> +++ b/arch/x86/crypto/Makefile
>> @@ -88,6 +88,9 @@ nhpoly1305-avx2-y := nh-avx2-x86_64.o 
>> nhpoly1305-avx2-glue.o
>>   obj-$(CONFIG_CRYPTO_CURVE25519_X86) += curve25519-x86_64.o
>> +obj-$(CONFIG_CRYPTO_SM3_AVX_X86_64) += sm3-avx-x86_64.o
>> +sm3-avx-x86_64-y := sm3-avx-asm_64.o sm3_avx_glue.o
>> +
>>   obj-$(CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64) += sm4-aesni-avx-x86_64.o
>>   sm4-aesni-avx-x86_64-y := sm4-aesni-avx-asm_64.o sm4_aesni_avx_glue.o
>> diff --git a/arch/x86/crypto/sm3-avx-asm_64.S 
>> b/arch/x86/crypto/sm3-avx-asm_64.S
>> new file mode 100644
>> index 000000000000..e7a9a37f3609
>> --- /dev/null
>> +++ b/arch/x86/crypto/sm3-avx-asm_64.S
>> @@ -0,0 +1,521 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * SM3 AVX accelerated transform.
>> + * specified in: 
>> https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
>> + *
>> + * Copyright (C) 2021 Jussi Kivilinna <jussi.kivilinna@iki.fi>
>> + * Copyright (C) 2021 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> + */
> <snip>
>> +
>> +#define R(i, a, b, c, d, e, f, g, h, round, widx, 
>> wtype)                      \
>> +    /* rol(a, 12) => t0 
>> */                                                \
>> +    roll3mov(12, a, t0); /* rorxl here would reduce perf by 6% on 
>> zen3 */ \
>> +    /* rol (t0 + e + t), 7) => t1 
>> */                                      \
>> +    addl3(t0, e, 
>> t1);                                                     \
>> +    addl $K##round, 
>> t1;                                                   \
> 
> It's better to use "leal K##round(t0, e, 1), t1;" here and fix K0-K63 
> macros
> instead as I noted at libgcrypt mailing-list:
>   https://lists.gnupg.org/pipermail/gcrypt-devel/2021-December/005209.html
> 
> -Jussi

Thanks for pointing it out, I will fix it in the next patch.

Best regards,
Tianjia
