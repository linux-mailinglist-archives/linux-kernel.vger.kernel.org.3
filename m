Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D695AAC05
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbiIBKED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiIBKEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC31A9D8FF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 03:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662113038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/Gz871G0r3DaRFYqQ3S5WxV9Ql0JYSdOHTdwlcxNcA=;
        b=a7tcqXXbfoHwllvVYv9YVCp3DK0TOmajtXtqCN9mEGZJ5vnf+lisFarEyiiiYMl8dKYvIe
        GVQIRNYiAOcVjjvOzDrDf2yHeXyAaZdlocNelJLgo/1qDY+Uoz5HwaXmx7/tYOaOHPxRdL
        3rzgZEe9LkaQ/L+TQhDztFhRyR+xZu0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-148-0S3nancVONqt-gSt-cacLw-1; Fri, 02 Sep 2022 06:03:57 -0400
X-MC-Unique: 0S3nancVONqt-gSt-cacLw-1
Received: by mail-ej1-f69.google.com with SMTP id ds17-20020a170907725100b007419bfb5fd4so830945ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 03:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=j/Gz871G0r3DaRFYqQ3S5WxV9Ql0JYSdOHTdwlcxNcA=;
        b=azwjsDOQzqC02qNdnMsgOZcUq1QD1a96c0Cdm9iOuxPMU0SIiZXF/QT1a+6gM6KPRP
         Qo4Un3GXu7a9aH3kfIzdGObHiid2wSxBpvhenT/v2MQV5qGAuAyTUdaL85Gh6AKzTxa0
         lBk34gqMQLO6HQnzZ5scvWilwSJjAQ5IYNap0MCAPlfRnfrPuESecN5RIKYPhQs2ahhO
         t3Od0G+/9OKDJdchS033kwAnlDtKV6ZOsBdm8KJRP3Rr5s/mQxbxA/AAdm23U3Sks5OF
         S2u3RBhHHNydK7G0t1buhjz55mFX3SzRcgXm/62GvoZbeKMl6RWTZk+39r+UvIdDLGlj
         65tg==
X-Gm-Message-State: ACgBeo3TmfCokwmUPGF7lmbAmPJoDO+jIWrtuBA8Ta6F13Spd3xESt1O
        S+5o8hMXExYzN+d4YSR+1DZs7VaflgCg2h03WMBX37H2Rfi1/ZkU6c+/Lo+EyiRYs7XMG96IDdo
        BeUHLkBEso9HDpMncjlrQla7m
X-Received: by 2002:a17:907:7242:b0:742:7c5:46b5 with SMTP id ds2-20020a170907724200b0074207c546b5mr13219663ejc.274.1662113036039;
        Fri, 02 Sep 2022 03:03:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6KMGdyE0O48VAyeBV+XNMPxY0b6N8xa9jewEIGRQh4cmFCQ1tG2cO7SGa9seJ0ddSfBRugKA==
X-Received: by 2002:a17:907:7242:b0:742:7c5:46b5 with SMTP id ds2-20020a170907724200b0074207c546b5mr13219641ejc.274.1662113035689;
        Fri, 02 Sep 2022 03:03:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id g26-20020a50ec1a000000b0044604ad8b41sm1087334edr.23.2022.09.02.03.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 03:03:55 -0700 (PDT)
Message-ID: <8d81852a-91d0-1760-a6a7-086316a0b4d6@redhat.com>
Date:   Fri, 2 Sep 2022 12:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20220831135749.78743-1-andriy.shevchenko@linux.intel.com>
 <20220831135749.78743-2-andriy.shevchenko@linux.intel.com>
 <4f388bda-b991-0ab6-4098-4f5dbabe57fb@redhat.com>
 <Yw+0jGdk2pIQSoOT@smile.fi.intel.com>
 <073c2dce-bd03-9dfe-539f-203b6fb7eeaf@redhat.com>
 <YxHUIBaEwG3pxGnT@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YxHUIBaEwG3pxGnT@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/2/22 12:00, Andy Shevchenko wrote:
> On Thu, Sep 01, 2022 at 11:02:11AM +0200, Hans de Goede wrote:
>> On 8/31/22 21:20, Andy Shevchenko wrote:
>>> On Wed, Aug 31, 2022 at 08:19:24PM +0200, Hans de Goede wrote:
>>>> On 8/31/22 15:57, Andy Shevchenko wrote:
> 
> ...
> 
>>>>> -	if (regmap_read(regmap, (reg - 1), &val))
>>>>> -		return -EIO;
>>>>> -	temp_h = (u8) val;
>>>>
>>>> Hmm, you are changing the order of the register
>>>> reads here. The old code is doing:
>>>>
>>>> 	read(reg);
>>>> 	read(reg -1);
>>>>
>>>> Where as the new code is doing:
>>>>
>>>> 	read(reg -1);
>>>> 	read(reg);
>>>>
>>>> The order matters since typically upon reading the
>>>> low byte, the high bits will get latched so that
>>>> the next read of the high bytes uses the bits
>>>> from the same x-bits value as the low 8 bits.
>>>>
>>>> This avoids things like:
>>>>
>>>> 1. Entire register value (all bits) 0x0ff
>>>> 2. Read reg with low 8 bits, read 0x0ff
>>>> 3. Entire register value becomes 0x100
>>>> 4. Read reg with high bits
>>>> 5. Combined value now reads as 0x1ff
>>>>
>>>> I have no idea if the bxtwc PMIC latches
>>>> the bits, but giving the lack of documentation
>>>> it would IMHO be better to not change the reading order.
>>>
>>> Interestingly documentation suggests otherwise, e.g.:
>>>
>>> THRMZN0H_REG
>>> Battery Thermal Zone 0 Limit Register High
>>> Offset 044H
>>>
>>> Description
>>>
>>> Z0HYS	  Temperature hysteresis value for TCOLD threshold
>>>
>>> Z0CURHYS  Battery ChargerTemperature Zone Current hysteresis for TCOLD (MSBs)
>>> 	  3 bits of the battery charger temperature zone current hysteresis for zones 0/1.
>>>
>>> TCOLD_H	  Battery ChargerTemperature Zone Threshold for TCOLD (MSBs)
>>> 	  Upper 1 bit of the battery charger temperature zone threshold for zones 0/1.
>>> 	  Writes to THRMZN0H (and all thermal zone registers) are not committed until
>>> 	  THRMZN0L (lower byte) is written to.
>>> 	  Write Before: THRMZN0L_REG.TCOLD_L
>>>
>>> (Note the last description)
>>
>> I see, but that is about writes and the write path was already
>> first doing a read + write of reg - 1, followed by writing
>> reg 1. So for the write path this patch does not introduce
>> any functional changes. But what about the read path, is read
>> latching the same or does it need the inverse order of writes?
>>
>> Note I think it is likely the read order for proper latching
>> is likely also first high then low, but it would be good to check.
>> If that is indeed the case then this would actually be a bugfix,
>> not just a cleanup.
>>
>> Also you have only checked for 1 of the 4 PMICs you are making
>> changes to in this patch?
>>
>> The commit message suggests this code change does not cause any
>> functional changes, but as discussed it actually does make changes,
>> so this should be in the commit message.
>>
>> Talking about making changes to 4 PMICs unlike patch 1 and 3 the changes
>> in this one are not trivial so IMHO this should be split into 1 patch
>> per PMIC. This has 3 advantages:
>>
>> 1. It makes reviewing easier, during my initial review I stopped
>> at the intel_bxtwc_pmic changes not even realizing more was coming...
>>
>> 2. This makes properly describing the actual functional changes
>> in the commit message a lot easier, otherwise the commit msg
>> is going to become somewhat messy.
>>
>> 3. This will also make reverting things easier if something does
>> break (even if it is just for testing if these changes are the cause
>> of the breakage).
>>
>> ###
>>
>> So I've been taking a closer look at these changes and here are some
>> more remarks:
>>
>> intel_crc_pmic_get_raw_temp() you are again changing the order
>> in which the 2 (low/high) registers are read. This needs to be
>> checked and mentioned in the commit message.
>>
>> intel_crc_pmic_update_aux() unlike the intel_pmic_bxtwc.c
>> equivalent in this case your changes do switch the write-order,
>> assuming the same write order as in bxtwc should be used
>> this would actually be another bugfix.
>>
>> For intel_pmic_chtdc_ti.c this does seems to be purely a refactor.
>>
>> For intel_pmic_xpower.c the original code actually seems
>> to be wrong, the datasheet says:
>>
>> REG 5AH: GPADC pin input ADC data, highest 8bit
>> Bit 7-0 GPADC pin input ADC data, highest 8bit
>>
>> REG 5BH: GPADC pin input ADC data, lowest 4bit
>> Bit 7-4 Reserved
>> Bit 3-0 GPADC pin input ADC data, lowest 4bit
> 
>> So it looks like instead of your patch we actually need
> 
> Not instead, but probably as a prerequisite fix.

Since there is a hole in the bits:

    high-byte           low-byte
bit 11 10 9 8 7 6 5 4   r r r r 3 2 1 0

r = reserved

I don't think we can use be16_to_cpu here at all.


> 
>> the following fix:
>>
>> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
>> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
>> @@ -257,7 +257,7 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>>  
>>  	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, 2);
>>  	if (ret == 0)
>> -		ret = (buf[0] << 4) + ((buf[1] >> 4) & 0x0f);
>> +		ret = (buf[0] << 4) | (buf[1] & 0x0f);
>>  
>>  	if (adc_ts_pin_ctrl & AXP288_ADC_TS_CURRENT_ON_OFF_MASK) {
>>  		regmap_update_bits(regmap, AXP288_ADC_TS_PIN_CTRL,
>>
>> I will try to make some time to check this on actual hw to see if
>> the code or the doc is right soon-ish
> 
> Thanks for your review and explanations. I will split pure cleanups and resend
> with Mika's tag, and will see what I can do about the rest (considering
> availability of the documentation and it's fullness).

Thanks.

Regards,

Hans

