Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC424B8C26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiBPPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:12:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiBPPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:12:35 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E5425E89;
        Wed, 16 Feb 2022 07:12:23 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so2784030oos.9;
        Wed, 16 Feb 2022 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=8EagOatwpnloVBLpvuiKwC6cqbSfSGAyVDbY82VfmWY=;
        b=jMVJG6jmB956M6R2glFKs7DuDGfAEIwnDxhZnoKiWbN8B5UtumCOqFPrqlRtMkD0hM
         5ofS1qBPXRvdPdBL3uBDr5BHI0q31ncP7fr3ka1gzZecIcIS8o6f+xW5nma18gR7TIsV
         FnCpn1czuwMDEIWDEL3+3/BxPIvWOpkG5KEgmodBzqlBT4zlsGUcB3lKIXE42VoGaDC7
         uouj2+tF00W/LJ1eC/WXF12DJJ7WKQAnQmuiYR3QLdddl+BU+U3sm2Vm88+t8aSyYDpi
         3obsm1gNbaS1NwK+rfUPV65680+TNuEsqWBOk6SfAF3qzkl2BPYx54gD52QKw1EKfP0I
         Xd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=8EagOatwpnloVBLpvuiKwC6cqbSfSGAyVDbY82VfmWY=;
        b=NfEJ1Q8VVQ5LwC0uCDxbwZ0cfyzkOOv/0FdB4ovMkY32sA9d2GCfQv8FoujcVkO4qf
         h33RDTt8Ewmh9ajfVzw+2jn8NkZg1CQ3SPBVWuNIqRPOaStM5CkaKoJK+NSzZHkmtBtt
         xC7c136lvym52c2Fz8E/LmlehBN0XOjlcm3aZPX6TXCdQ5GhppcMU3IaqftgwD51/EbH
         7+4V5HS1+VF9WL/a8oho6c/qKXfYGUQEDeNCqqvW0K4yg4uZKYc2OqTaqK1X984mUBOx
         HuCg02aAOv6BtdjdNuE12lfUH6Du7EcnTVtPqGQY/QF6kBQZ9VqFh2T9V2ScvXD6jX2v
         60gQ==
X-Gm-Message-State: AOAM532dpQMCIEavnIMDoGcvsgDdLmHnExM2SWtAvVtpTQHeUrzbNEuc
        whFJt4LJ8yfjLrJHpjMOWKk=
X-Google-Smtp-Source: ABdhPJw48DZ1orM9cbn6ZFn7AiWfOVbGIy7a36NIzJQkXx0dVyF5qE8kcJHqasvZEJe8HaZY0eeQZw==
X-Received: by 2002:a05:6870:41d4:b0:d1:2682:277c with SMTP id z20-20020a05687041d400b000d12682277cmr632495oac.206.1645024342369;
        Wed, 16 Feb 2022 07:12:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e11sm2245139oiw.3.2022.02.16.07.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 07:12:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <130a9cbe-ee0c-1908-1d62-0f3c674ca648@roeck-us.net>
Date:   Wed, 16 Feb 2022 07:12:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Agathe Porte <agathe.porte@nokia.com>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>
References: <20220216070720.2131761-1-linux@roeck-us.net>
 <20220216070720.2131761-2-linux@roeck-us.net>
 <2f7780b8-ce67-6cd6-4097-d8113f557444@nokia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/2] hwmon: Add driver for Texas Instruments TMP464 and
 TMP468
In-Reply-To: <2f7780b8-ce67-6cd6-4097-d8113f557444@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 04:42, Agathe Porte wrote:
> Hi Guenter,
> 
> Le 16/02/2022 à 08:07, Guenter Roeck a écrit :
>> Add support for Texas Instruments TMP464 and TMP468 temperature sensor
>> ICs.
>>
>> TI's TMP464 is an I2C temperature sensor chip. This chip is
>> similar to TI's TMP421 chip, but with 16bit-wide registers (instead
>> of 8bit-wide registers). The chip has one local sensor and four
>> remote sensors. TMP468 is similar to TMP464 but has one local and
>> eight remote sensors.
>>
>> Originally-from: Agathe Porte <agathe.porte@nokia.com>
>> Cc: Agathe Porte <agathe.porte@nokia.com>
>> Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v3:
>> - Added support for TMP468
>> - Added support for various limits, temperature hysteresis, alarm attributes,
>>    and update interval
>> - Use regmap instead of local caching
>> - Use static chip configuration
>> - Unlock check if needed when loading driver, and lock it when unloading it
>>    - Call tmp464_init_client() before calling tmp464_probe_from_dt()
>>      since the latter changes registers, which requires the chip to be
>>      unlocked.
>> - Restore configuration register when unloading driver
>> - ti,n-factor is optional, so don't fail if the property is not present
>>
>> Notes:
>> - Tested with real TMP468. Module tested for TMP464.
>> - I was not able to test with a system supporting devicetree;
>>    especially negative values for "ti,n-factor" need testing
>>    (and I wonder if of_property_read_s8() would be needed to
>>     support this properly).
> 
> I just did the test on our system and both positive and negative value n-factor fails.
> 
> With the following overlay:
> 
> /dts-v1/;
> /plugin/;
> / {
>          fragment@0 {
>                  target-path = "/soc/.../i2c@4/tmp464@49";
>                  __overlay__ {
>                          #address-cells = <1>;
>                          #size-cells = <0>;
> 
>                          channel@0 {
>                                  reg = <0x0>;
>                                  label = "local";
>                                  ti,n-factor = /bits/ 8 <(-10)>;
>                          };
> 
>                          channel@1 {
>                                  reg = <0x1>;
>                                  label = "ch1";
>                          };
> 
>                          channel@2 {
>                                  reg = <0x2>;
>                                  label = "ch2";
>                          };
> 
>                          channel@3 {
>                                  reg = <0x3>;
>                                  label = "ch3";
>                          };
> 
>                          channel@4 {
>                                  reg = <0x4>;
>                                  label = "ch4";
>                          };
>                  };
>          };
> 
> };
> 
> I get the following probing error:
> 
> [ 3580.557425] tmp464: probe of 16-0049 failed with error -75
> 

I think that may be caused by using of_property_read_s32() for reading
an 8-bit property. Can you try and replace of_property_read_s32()
with of_property_read_u8() and the variable it points to to s8 ?

	s8 val;
	...
	err = of_property_read_u8(child, "ti,n-factor", &val);

There is no of_property_read_s8(), so we can not use that,
but maybe using of_property_read_u8() does the trick.

Thanks,
Guenter

> With a positive n-factor in the overlay (<(10)> instead of <(-10)>), the driver *does not load either*, with the same error message.
> 
> Without any n-factor set, the v3 driver you proposed loads just fine with the DT.
> 
> Any idea of where this could come from? This was probably not working in my own implementation either.
> 
> PS: check your spam folder eventually for my mail asking delivery details of the TMP464 samples.
> 
> Bests,
> 
> Agathe.
> 

