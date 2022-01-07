Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79645487459
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346247AbiAGI5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:57:49 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57341 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346181AbiAGI5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:57:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V1AKtGu_1641545860;
Received: from 30.240.102.225(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V1AKtGu_1641545860)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Jan 2022 16:57:42 +0800
Message-ID: <c3ddb561-15b0-855f-b50c-c97ebd0f5976@linux.alibaba.com>
Date:   Fri, 7 Jan 2022 16:57:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v3 2/6] crypto: arm64/sm3-ce - make dependent on sm3
 library
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211223043547.32297-1-tianjia.zhang@linux.alibaba.com>
 <20211223043547.32297-3-tianjia.zhang@linux.alibaba.com>
 <YdezdZQHZT2+iYV3@gondor.apana.org.au>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <YdezdZQHZT2+iYV3@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On 1/7/22 11:28 AM, Herbert Xu wrote:
> On Thu, Dec 23, 2021 at 12:35:43PM +0800, Tianjia Zhang wrote:
>> SM3 generic library is stand-alone implementation, sm3-ce can depend
>> on the SM3 library instead of sm3-generic.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   arch/arm64/crypto/Kconfig       |  2 +-
>>   arch/arm64/crypto/sm3-ce-glue.c | 20 ++++++++++++++------
>>   2 files changed, 15 insertions(+), 7 deletions(-)
> 
> This doesn't compile cleanly with C=1 W=1:
> 
>    CC [M]  arch/arm64/crypto/sm3-ce-glue.o
>    AS [M]  arch/arm64/crypto/sm3-ce-core.o
>    CC [M]  arch/arm64/crypto/sm4-ce-glue.o
>    CHECK   ../arch/arm64/crypto/sha3-ce-glue.c
> ../arch/arm64/crypto/sm3-ce-glue.c: In function ‘sm3_ce_update’:
> ../arch/arm64/crypto/sm3-ce-glue.c:30:10: error: void value not ignored as it ought to be
>     30 |   return sm3_update(shash_desc_ctx(desc), data, len);
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../arch/arm64/crypto/sm3-ce-glue.c: In function ‘sm3_ce_final’:
> ../arch/arm64/crypto/sm3-ce-glue.c:42:10: error: void value not ignored as it ought to be
>     42 |   return sm3_final(shash_desc_ctx(desc), out);
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> make[3]: *** [../scripts/Makefile.build:287: arch/arm64/crypto/sm3-ce-glue.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> 
> Please make sure everything builds cleanly with C=1 W=1 *before*
> you submit.
> 
> Thanks,

Thanks for pointing it out, will fix it in next patch. There will never 
be such a low-level error in the future

Kind Regards,
Tianjia
