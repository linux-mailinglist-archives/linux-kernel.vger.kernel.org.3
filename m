Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD5348F8E9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiAOSyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiAOSyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:54:07 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550CDC061574;
        Sat, 15 Jan 2022 10:54:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g22so679428edu.1;
        Sat, 15 Jan 2022 10:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n2R2ZhP6GNYIJL6t7o7dLr/7nQXsaI+rjsrgvhUUv5M=;
        b=GoOFp0UBRzR8BqVyP3sG6/jAZUw5/xUg2XHA/ITHninTlFTygdwr+BA9L4EvtFWyfc
         2pPt1MRSR+Czuoe+nW8XJJCvyuTi/D0xgZFILWyFTPjg76CtKEPHfiIkmiV+Ox+FNRZT
         c+aaDUEizjHBbDMil6oKzsqK5sM0V1ieuIPLyHJI4ydV3L2APwAoI7vhMs9A0UDwm9/p
         seTlqjKg6Cs5UTog9eH28hr9dJCHR8xiH/dIlpVXtCGmf5Z6AYWNTq6i4kg3Fg/xKObN
         1faOYvhNdiZ6nykwEuhu9SnGdCZ4819NRa9ZcVHgrj0vYbQjZyjC9HHMpVaNsZqItbcZ
         svOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n2R2ZhP6GNYIJL6t7o7dLr/7nQXsaI+rjsrgvhUUv5M=;
        b=3kwvV6TOY3sCjgPqBPdLg1/OhoXTeBEPbePqUl9tmrOgs6c+Jk0z2uShTxUscwgIyy
         yGPtkY0rq/3BJWzEG00xITKDjgVfq0kWb7/Qyi3xtNTbEkDzS3H5a96MPkqWv6V8T0UU
         KLWiUqIhPel1rcCrRB1UlN6t8rthOFAKzUq23eMsRf/Oi2MUxfkeov5p4zXWLB3Yd68u
         bP//ngJ6a3Tzi9KL5xOEfFg5gWvYmojVxJtKHeZa12cIbdDREkhK1fOWzcnDfiTUEn/D
         j3QOcW9hF/xsxJAG+mw5yutd5E41n/bSzpO2MCfgrU4uMY1N5hfywjedSxpC5cqsExuS
         J4iA==
X-Gm-Message-State: AOAM5338hCZkjGIbyLCim0ihvur3mJKFv1MjJU6j5XpLzJ3WDmbjArA8
        wIr2SQ2TSuxKr4cE83h4giFjcNK65Vw=
X-Google-Smtp-Source: ABdhPJxrDy73PZUgnaPqk/8NPZ4Q2qBJqmkKOXGeNkQDj6NQvAl2lU360cUhFFbSY6hbJZvMextbpQ==
X-Received: by 2002:a17:907:3d93:: with SMTP id he19mr2705961ejc.333.1642272845921;
        Sat, 15 Jan 2022 10:54:05 -0800 (PST)
Received: from [192.168.0.182] ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id nd6sm2775709ejc.157.2022.01.15.10.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 10:54:05 -0800 (PST)
Message-ID: <e8172ace-035b-b847-cc5c-90fb4d2ece43@gmail.com>
Date:   Sat, 15 Jan 2022 20:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] iio: adc: ad7124: fix mask used for setting AIN_BUFP &
 AIN_BUFM bits
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220112200036.694490-1-cosmin.tanislav@analog.com>
 <20220115185615.403ee183@jic23-huawei>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20220115185615.403ee183@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/22 20:56, Jonathan Cameron wrote:
> On Wed, 12 Jan 2022 22:00:36 +0200
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
>> According to page 90 of the datasheet [1], AIN_BUFP is bit 6 and
>> AIN_BUFM is bit 5 of the CONFIG_0 -> CONFIG_7 registers.
>>
>> Fix the mask used for setting these bits.
>>
>> [1]: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7124-8.pdf
>>
>> Fixes: 0eaecea6e487 ("iio: adc: ad7124: Add buffered input support")
>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Curious that didn't cause problems anyone noticed before. Ah well.
> 

I only noticed it because I'm writing a driver for a similar device,
it was not even reported by anyone.

> Applied to the fixes-togreg branch of iio.git and marked for stable.
> 
> Note that branch will probably be rebased after rc1 as I have some
> other things that need rc1 which will be in same pull request.
> 
> Jonathan
> 
>> ---
>>   drivers/iio/adc/ad7124.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
>> index e45c600fccc0..18c154afbd7a 100644
>> --- a/drivers/iio/adc/ad7124.c
>> +++ b/drivers/iio/adc/ad7124.c
>> @@ -76,7 +76,7 @@
>>   #define AD7124_CONFIG_REF_SEL(x)	FIELD_PREP(AD7124_CONFIG_REF_SEL_MSK, x)
>>   #define AD7124_CONFIG_PGA_MSK		GENMASK(2, 0)
>>   #define AD7124_CONFIG_PGA(x)		FIELD_PREP(AD7124_CONFIG_PGA_MSK, x)
>> -#define AD7124_CONFIG_IN_BUFF_MSK	GENMASK(7, 6)
>> +#define AD7124_CONFIG_IN_BUFF_MSK	GENMASK(6, 5)
>>   #define AD7124_CONFIG_IN_BUFF(x)	FIELD_PREP(AD7124_CONFIG_IN_BUFF_MSK, x)
>>   
>>   /* AD7124_FILTER_X */
> 
