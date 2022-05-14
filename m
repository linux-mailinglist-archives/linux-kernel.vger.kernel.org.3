Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82404527142
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiENNcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiENNc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:32:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFAE222A1;
        Sat, 14 May 2022 06:32:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y21so13055924edo.2;
        Sat, 14 May 2022 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cfFP3xfa8xoziXYuGDbSCKt0RTxwr0nsgNiwx+imKA0=;
        b=YmK8Gm6dvg1hmXX0XRB5bV3MWQEQ0DGYM8C0ACNy6JqfvrhAmaxNZclAZSR03TCEJA
         bP9YhnwETeCNkvsjGdw16hEfOQrmev9eSS8S+83BLzNJKwHjER0u0o2aoWcSHSk6kHr3
         /rRDO1j4+DcBVKO80WxHzpdVhec7f2MeMiqJcYJhJ5CW2MgTLWFhcx3er/2hpc+OHfOn
         0PHoUIedtnsHHfUkY0Vg+tOmKMtpdM+cWhowgZT0+KSSsr8Nra37zPecaRPqt61ILc0x
         HVx7do/kxXO57Ut/BBcQjHl5JTqs8s06cV1eL+iXnIdRO4+efisxpGfNmRN/X9IxWU8J
         Xp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cfFP3xfa8xoziXYuGDbSCKt0RTxwr0nsgNiwx+imKA0=;
        b=JG9YuAkEUQyOgg8PanslDowIR7UrKWIOGlBtc01qKgChoRT7A2gO+sfWAawsbwmmUN
         9al0Vf/idQwMzzjD94HUNQSuZtYTF1nGqoZFKiazFrkoHK3tQOl23vuIMIDJ9HLosFim
         1STZukT6FI88cjaqV4+AWb+EqSxuvS1EA5t5Nk4TgiTwNLhw/FTbcdmlTZJgBswTENgZ
         g4G1LsMuEkyCIJLzqd+IbazkKEI35/5qxVVwrLegmy3R9CHHnN5G/KGqx40MbWMoZALC
         /xy1FYwTxc+pgoKkExt9JDsyMSsKyhIZqReJThqJdep99CKttSxFFwqS4qtX0iuihAxM
         Xn9A==
X-Gm-Message-State: AOAM530mJPCgtcDCaHdsBqezutC2f0XXA9T0hpW5nMsv0UXHmAC5GjFc
        Lz7TVJ0zO+oOpqL1WnoX52wWD76/10A=
X-Google-Smtp-Source: ABdhPJwSQdGzkpM8IMpJVsaMDIQhBaKThUul2amjq4BK1Mfs1gbXpG1WnhlimcyGx1iB12/mAgxprQ==
X-Received: by 2002:aa7:cd10:0:b0:428:659e:a4c8 with SMTP id b16-20020aa7cd10000000b00428659ea4c8mr3902005edw.190.1652535145876;
        Sat, 14 May 2022 06:32:25 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.86.218])
        by smtp.gmail.com with ESMTPSA id s15-20020a50ab0f000000b0042617ba637fsm2286822edc.9.2022.05.14.06.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 06:32:25 -0700 (PDT)
Message-ID: <f5af3894-c76e-04b6-830a-2687427991b6@gmail.com>
Date:   Sat, 14 May 2022 16:32:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/2] iio: adc: ad4130: add AD4130 driver
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20220419150828.191933-1-cosmin.tanislav@analog.com>
 <20220419150828.191933-3-cosmin.tanislav@analog.com>
 <20220501170807.1e728524@jic23-huawei>
 <5d932a4a-790e-ca95-c5de-c2267e1f365c@gmail.com>
 <20220507173551.1bc45a82@jic23-huawei>
 <39cb9ade-14af-c53b-bd42-06a9b965b57f@gmail.com>
 <20220507180210.4c48a85f@jic23-huawei>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20220507180210.4c48a85f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/22 20:04, Jonathan Cameron wrote:
> On Sat, 7 May 2022 19:49:17 +0300
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
>> On 5/7/22 19:35, Jonathan Cameron wrote:
>>>    
>>>>>       
>>>>>> +static int ad4130_set_fifo_watermark(struct iio_dev *indio_dev, unsigned int val)
>>>>>> +{
>>>>>> +	struct ad4130_state *st = iio_priv(indio_dev);
>>>>>> +	unsigned int eff;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	if (val > AD4130_FIFO_SIZE)
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Always set watermark to a multiple of the number of enabled channels
>>>>>> +	 * to avoid making the FIFO unaligned.
>>>>>> +	 */
>>>>>> +	eff = rounddown(val, st->num_enabled_channels);
>>>>>> +
>>>>>> +	mutex_lock(&st->lock);
>>>>>> +
>>>>>> +	ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
>>>>>> +				 AD4130_WATERMARK_MASK,
>>>>>> +				 FIELD_PREP(AD4130_WATERMARK_MASK,
>>>>>> +					    ad4130_watermark_reg_val(eff)));
>>>>>> +	if (ret)
>>>>>> +		goto out;
>>>>>> +
>>>>>> +	st->effective_watermark = eff;
>>>>>> +	st->watermark = val;
>>>>>
>>>>> Hmm this is a potential inconsistency in the IIO ABI.
>>>>> ABI docs describes watermark as being number of 'scan elements' which is
>>>>> not the clearest text we could have gone with...
>>>>>
>>>>> Now I may well have made a mistake in the following as it's rather a long time
>>>>> since I last looked at the core handling for this...
>>>>>
>>>>> The core treats it as number datum (which is same as a scan) when using
>>>>> it for the main watermark attribute and also when using watermarks with the
>>>>> kfifo (the IIO fifo is made up of objects each of which is a scan. So kfifo_len()
>>>>> returns the number of scans.
>>>>>     
>>>>> Looking very quickly at a few other drivers
>>>>> adxl367 seems to use number of samples.
>>>>> adxl372 is using number of scans.
>>>>> bmc150 hardware seems to work on basis of frame count which I 'think' is probably scans.
>>>>> fxls8962 uses 'samples count' which is not clearly defined in the datasheet but there
>>>>> is an example showing that it's scans (I think)...
>>>>> lsm6dsx - some of the fifos used with this are based on tagged data so the connection to
>>>>> what hits the front end buffers is non obvious.
>>>>>
>>>>> So, not great for consistency :(
>>>>>
>>>>> Going forwards i think we should standardize the hardware fifo watermark on what is being
>>>>> used for the software watermark which I believe is number of scans.
>>>>> Not necessary much we can do about old drivers though due to risk of breaking ABI...
>>>>> We should make the documentation clearer though.
>>>>>       
>>>>
>>>> I was confused too, but this seemed more logical to me at the time, and
>>>> since you didn't say anything regarding it on ADXL367, I did it the same
>>>> way here. I guess we can't go back and change it now on ADXL367, I'm
>>>> sorry for this. I'll fix it.
>>>
>>> I missed it.  Review is never perfect (mine definitely aren't!)
>>>
>>> Thinking more on the adxl367. We still have a window to  fix that as
>>> the driver isn't yet in a release kernel.  Would you mind spinning a
>>> patch to fix that one?  Even if we miss the rc cycle (it's a bit tight
>>> timing wise) we can sneak it in as an early fix in stable without
>>> significant risk of breaking anyone's userspace.
>>>    
>>
>> I hope Monday is not too late to do it?
> 
> Any time next week should be fine.  If it ends up later that's fine as well.
> We have at least a few weeks until the 5.18 release and then if we were to land
> this during the first few weeks of the next cycle that would be fine as well.
> No one should be insane enough to not pick up at least the first few stable
> releases of a new kernel!
> 
>> I can also try to do the changes tomorrow but I don't have the hardware
>> anymore so I won't be able to test until I get it back, which is only
>> next week.
>>
>>> There might be other drivers that have that interpretation we can't
>>> fix but if we can reduce the scope of the problem by changing the adxl367
>>> that would be great.
>>>
>>> We should also definitely improve the docs and perhaps add a note to say
>>> that due to need to maintain ABI, a few drivers use scans * number of channels
>>> rather than scans.
>>
>> I guess I could also do that at the same time.
> 
> Perfect :)
> 
> Thanks for sorting this out.
> 
> Jonathan
> 
> 

I've just had another good look at ADXL367. It seems that I'm quick at
forgetting stuff about the code I write.

In adxl367_set_fifo_samples(), fifo_watermark is multiplied by
fifo_set_size, then, if it is larger than the maximum watermark,
it is capped at the maximum watermark, and then, it is divided
by fifo_set_size again.

In the end, fifo_watermark actually seems to mean number of scans
in that driver too.

So this was a huge confusion. The different thing about AD4130 is that
the register actually means number of samples, and not number of scans,
so that's where that confussion stemmed from.

Sorry for wasting your time on this.
