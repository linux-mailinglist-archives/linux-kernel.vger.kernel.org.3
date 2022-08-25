Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41455A1191
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242420AbiHYNLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242093AbiHYNKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:10:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF83A50EB;
        Thu, 25 Aug 2022 06:10:52 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MD3Ds583CznTXf;
        Thu, 25 Aug 2022 21:08:29 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 21:10:49 +0800
Subject: Re: [PATCH -next 1/2] crypto: api - Fix IS_ERR() vs NULL check
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220825084138.1881954-1-cuigaosheng1@huawei.com>
 <20220825084138.1881954-2-cuigaosheng1@huawei.com>
 <Ywc3u9ObRCpxQsK0@gondor.apana.org.au>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <0ae57826-6a8c-b08b-2889-f91d50bf6e59@huawei.com>
Date:   Thu, 25 Aug 2022 21:10:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <Ywc3u9ObRCpxQsK0@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking the time to review this patch.

crypto_alloc_test_larval() will return null if manager is disabled,
it will not return error pointers, IS_ERR should not be used to checking
return value, should we fix it? or use another solution?

It would be helpful if you could give some advice or fix the problem by yourself.

Thanks very much!

ÔÚ 2022/8/25 16:50, Herbert Xu Ð´µÀ:
> On Thu, Aug 25, 2022 at 04:41:37PM +0800, Gaosheng Cui wrote:
>> The crypto_alloc_test_larval() will return null if manager is disabled,
>> it may not return error pointers, so using IS_ERR_OR_NULL()
>> to check the return value to fix this.
>>
>> The __crypto_register_alg() will return null if manager is disabled,
>> it may not return error pointers, so using IS_ERR_OR_NULL()
>> to check the return value to fix this.
>>
>> Fixes: cad439fc040e ("crypto: api - Do not create test larvals if manager is disabled")
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   crypto/algapi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/crypto/algapi.c b/crypto/algapi.c
>> index 5c69ff8e8fa5..5a080b8aaa11 100644
>> --- a/crypto/algapi.c
>> +++ b/crypto/algapi.c
>> @@ -283,7 +283,7 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
>>   	}
>>   
>>   	larval = crypto_alloc_test_larval(alg);
>> -	if (IS_ERR(larval))
>> +	if (IS_ERR_OR_NULL(larval))
>>   		goto out;
> A NULL indicates success, why are you jumping to the error path?
>
> Cheers,
