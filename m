Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C246D47DDF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 03:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbhLWC70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 21:59:26 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37775 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231389AbhLWC7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 21:59:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0V.Thv79_1640228358;
Received: from 30.240.100.46(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V.Thv79_1640228358)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 10:59:20 +0800
Message-ID: <83ab2a55-d31e-acb8-3cae-9c2d06f08f6c@linux.alibaba.com>
Date:   Thu, 23 Dec 2021 10:59:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 1/5] crypto: sha256 - remove duplicate generic hash init
 function
Content-Language: en-US
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-mips@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
References: <20211220092318.5793-1-tianjia.zhang@linux.alibaba.com>
 <20211220092318.5793-2-tianjia.zhang@linux.alibaba.com>
 <CAGRGNgXE_5H20K+e9oejqybOGh8JezMpi2yrDJKqaZ4rWJkZdA@mail.gmail.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <CAGRGNgXE_5H20K+e9oejqybOGh8JezMpi2yrDJKqaZ4rWJkZdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julian,

On 12/23/21 6:35 AM, Julian Calaby wrote:
> Hi Tianjia,
> 
> On Mon, Dec 20, 2021 at 8:25 PM Tianjia Zhang
> <tianjia.zhang@linux.alibaba.com> wrote:
>>
>> crypto_sha256_init() and sha256_base_init() are the same repeated
>> implementations, remove the crypto_sha256_init() in generic
>> implementation, sha224 is the same process.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   crypto/sha256_generic.c | 16 ++--------------
>>   1 file changed, 2 insertions(+), 14 deletions(-)
>>
>> diff --git a/crypto/sha256_generic.c b/crypto/sha256_generic.c
>> index 3b377197236e..bf147b01e313 100644
>> --- a/crypto/sha256_generic.c
>> +++ b/crypto/sha256_generic.c
>> @@ -72,7 +60,7 @@ EXPORT_SYMBOL(crypto_sha256_finup);
>>
>>   static struct shash_alg sha256_algs[2] = { {
>>          .digestsize     =       SHA256_DIGEST_SIZE,
>> -       .init           =       crypto_sha256_init,
>> +       .init           =       sha256_base_init,
>>          .update         =       crypto_sha256_update,
>>          .final          =       crypto_sha256_final,
>>          .finup          =       crypto_sha256_finup,
>> @@ -86,7 +74,7 @@ static struct shash_alg sha256_algs[2] = { {
>>          }
>>   }, {
>>          .digestsize     =       SHA224_DIGEST_SIZE,
>> -       .init           =       crypto_sha224_init,
>> +       .init           =       sha224_base_init,
>>          .update         =       crypto_sha256_update,
>>          .final          =       crypto_sha256_final,
>>          .finup          =       crypto_sha256_finup,
> 
> Aren't these two functions defined as static inline functions? It
> appears that these crypto_ wrappers were added so there's "actual"
> referenceable functions for these structs.
> 
> Did this actually compile?
> 
> Thanks,
> 

Judging from the compilation results, there is really no difference, but 
the modification made by this patch is still necessary, because 
crypto_sha256_init() wrapper and sha256_base_init() are two completely 
duplicate functions.

Best regards,
Tianjia
