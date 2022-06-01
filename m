Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F8B53A27F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351745AbiFAKYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiFAKYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:24:41 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C84889B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:24:40 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id x12so1495001pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/xae2cHy0Ag/cM7+bO/e+/rnzKdVsm0R+aXgJWwYsv8=;
        b=bqXZVclN2iOI5+a9KOMvt8fJ8VNdk0HLE3YEJAm6RA2yU2NJauOPO64SSR76neoxy/
         b4X2JMtiqz8CzjV5BrPMdSxs97i7ssNqGZHqnRsrR7VGCSSXgDnk6DkN6PZqs48LP1ew
         zqEJ8+yiTMCvxi/tLS95nfIG/tbCepUIsyiowj0J4kypllRaey79NO6neOtZpbQUK2Sf
         JXEwM1yP4FiTxmY+l7Iqukx6iY4isM1co17dRaMR6dc3r2yH+SNMLAp6oNmdqfGv5KUo
         7T5IL62CcIiObi84bnlZHxKBpoDtkNO/3dWZT7q3EWRFOcTThSOmeFqIRUnkrFtpgHAn
         mzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/xae2cHy0Ag/cM7+bO/e+/rnzKdVsm0R+aXgJWwYsv8=;
        b=IGrZgMV65SzSE/ynXBFmLGnpwYpjj5vG2MsyhWxdOqK3l/CXHsQTSuvzsCr1iHSV/G
         ecLTcW9gtHU5yAMNSAyZFoL2SZYz0iknDf0JIdpFEF41PXdtRzZc72uSRR0Gybec+Xtp
         tjgcRbwxlUGUG7CMklODL0rZR25M+5fbzj5fU1iD0YYYOQmsVh8+lP0DackZq4GRJLrQ
         zJ5GzvRJ5hvtFiHeLt9eJz0AIimRffIkqie9OEuWEozNWGeORbZxv1gtm3sN1jf3bUbw
         H31IRzREpOlGQGMjYNvyu7I05js9tWKVmnRsKJor+C10nK8ITB3oPCztejfITSWUUGdR
         prPQ==
X-Gm-Message-State: AOAM532U8LEbkkG6KLaucgwMvCo+yoVINh83ZGsqS7OdOIQ7J2XQ5DaG
        r3hmsj3LB/Mhd1j8j9Qg278=
X-Google-Smtp-Source: ABdhPJxyOeb4YSMhduYjFv3Qq/yxj1KqB6M7rN2kLa3xLTtflpwL8GL1JYtrWwQniot6S1t+VBNQxw==
X-Received: by 2002:a63:2c49:0:b0:3fb:1b5e:45c with SMTP id s70-20020a632c49000000b003fb1b5e045cmr26142346pgs.474.1654079079553;
        Wed, 01 Jun 2022 03:24:39 -0700 (PDT)
Received: from [192.168.1.104] ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902d50b00b0015e8d4eb276sm1170387plg.192.2022.06.01.03.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:24:39 -0700 (PDT)
Message-ID: <99faf6b0-30bf-f87c-2620-1eafb4eac1ac@gmail.com>
Date:   Wed, 1 Jun 2022 18:24:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: kmemleak: check boundary of objects allocated with
 physical address when scan
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
References: <20220531150823.1004101-1-patrick.wang.shcn@gmail.com>
 <YpZCWbfNE32EzCnz@arm.com>
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
In-Reply-To: <YpZCWbfNE32EzCnz@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/1 00:29, Catalin Marinas wrote:
> On Tue, May 31, 2022 at 11:08:23PM +0800, Patrick Wang wrote:
>> @@ -1132,8 +1135,13 @@ EXPORT_SYMBOL(kmemleak_no_scan);
>>   void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
>>   			       gfp_t gfp)
>>   {
>> -	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
>> -		kmemleak_alloc(__va(phys), size, min_count, gfp);
>> +	pr_debug("%s(0x%p, %zu, %d)\n", __func__, __va(phys), size, min_count);
> 
> I'd print just phys here since that's the function argument.

Will do.

> 
>> +	if (kmemleak_enabled && (unsigned long)__va(phys) >= PAGE_OFFSET &&
>> +	    !IS_ERR(__va(phys)))
>> +		/* create object with OBJECT_PHYS flag */
>> +		create_object((unsigned long)__va(phys), size, min_count,
>> +			      gfp, true);
> 
> Do we still need to check for __va(phys) >= PAGE_OFFSET? Also I don't
> think IS_ERR(__va(phys)) makes sense, we can't store an error in a
> physical address. The kmemleak_alloc_phys() function is only called on
> successful allocation, so shouldn't bother with error codes.

In this commit:
972fa3a7c17c(mm: kmemleak: alloc gray object for reserved
region with direct map)

The kmemleak_alloc_phys() function is called directly by passing
physical address from devicetree. So I'm concerned that could
__va() => __pa() convert always get the phys back? I thought
check for __va(phys) might help, but it probably dosen't work
and using IS_ERR is indeed inappropriate.

We might have to store phys in object and convert it via __va()
for normal use like:

#define object_pointer(obj)	\
	(obj->flags & OBJECT_PHYS ? (unsigned long)__va((void *)obj->pointer)	\
				: obj->pointer)

> 
>> @@ -1436,6 +1441,13 @@ static void kmemleak_scan(void)
>>   			dump_object_info(object);
>>   		}
>>   #endif
>> +
>> +		/* outside lowmem, make it black */
> 
> Maybe a bit more verbose:
> 
> 		/* ignore objects outside lowmem (paint them black) */

Will do.

> 
>> +		if (object->flags & OBJECT_PHYS)
>> +			if (PHYS_PFN(__pa((void *)object->pointer)) < min_low_pfn ||
>> +			    PHYS_PFN(__pa((void *)object->pointer)) >= max_low_pfn)
>> +				__paint_it(object, KMEMLEAK_BLACK);
> 
> I'd skip the checks if the object is OBJECT_NO_SCAN (side-effect of
> __paint_it()) so that the next scan won't have to go through the __pa()
> checks again. It's also probably more correct to check the upper object
> boundary). Something like:
> 
> 		if ((object->flags & OBJECT_PHYS) &&
> 		    !(object->flags & OBJECT_NO_SCAN)) {
> 			unsigned long phys = __pa((void *)object->pointer);
> 			if (PHYS_PFN(phys) < min_low_pfn ||
> 			    PHYS_PFN(phys + object->size) >= max_low_pfn)
> 				__paint_it(object, KMEMLEAK_BLACK);
> 		}

Right, much more thorough. Will do.

Thanks,
Patrick

