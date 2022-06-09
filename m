Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9D854524D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbiFIQu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241991AbiFIQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:50:24 -0400
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6EF3FBF0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:50:20 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id zLMKnvUPC2ovCzLMKnxhmD; Thu, 09 Jun 2022 18:50:18 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 09 Jun 2022 18:50:18 +0200
X-ME-IP: 90.11.190.129
Message-ID: <5cf8ad88-629c-e75a-df99-e893b8af967f@wanadoo.fr>
Date:   Thu, 9 Jun 2022 18:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] crypto: x86/camellia - Replace kernel.h with the
 necessary inclusions
Content-Language: en-CA
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-crypto@vger.kernel.org
References: <65634fb748cc0ce2cc5bafaf904cb5f76bd4edc4.1654414362.git.christophe.jaillet@wanadoo.fr>
 <YqHIPE0MlZLP8C5I@gondor.apana.org.au>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YqHIPE0MlZLP8C5I@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/06/2022 à 12:15, Herbert Xu a écrit :
> On Sun, Jun 05, 2022 at 09:32:53AM +0200, Christophe JAILLET wrote:
>> When kernel.h is used in the headers it adds a lot into dependency hell,
>> especially when there are circular dependencies are involved.
>>
>> Replace kernel.h inclusion with the list of what is really being used.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   arch/x86/crypto/camellia.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/crypto/camellia.h b/arch/x86/crypto/camellia.h
>> index 1dcea79e8f8e..547fb7e30928 100644
>> --- a/arch/x86/crypto/camellia.h
>> +++ b/arch/x86/crypto/camellia.h
>> @@ -4,7 +4,7 @@
>>   
>>   #include <crypto/b128ops.h>
>>   #include <linux/crypto.h>
>> -#include <linux/kernel.h>
>> +#include <linux/types.h>
>>   
>>   #define CAMELLIA_MIN_KEY_SIZE	16
>>   #define CAMELLIA_MAX_KEY_SIZE	32
> 
> This is not sufficient.  For example, asmlinkage isn't explicitly
> defined by any of these header files so it would be relying on an
> implicit inclusion which is prone to breakage.

Agreed, I missed that.

> 
> Did you audit the entire file?

Yes, but I missed the asmlinkage.

In fact, I've sent a few "obvious" (but nothing is never obvious at the 
end...) patches like that to see the interest.

I've spotted a few .h file with "easy to check" content.
Mostly #define, function declarations, a few u<something> datatypes.

Then, I made the #include simplification and compile tested the change.

If it worked, I consider that the patch looks fine.


In this particular case, I guess that the 'asmlinkage' should come from 
another #include when "camellia.h" is used.

My goal was not to introduce some new hidden constraints related to the 
order of the included .h. I just wanted to make them explicit (and 
complete) and start to simplify things.


As said, nothing is never obvious, and I'll stay away from this kind of 
changes :)


Thanks a lot for the review.

CJ



> 
> Cheers,

