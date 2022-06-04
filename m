Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07A153D69C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 13:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiFDLqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 07:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240941AbiFDLqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 07:46:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657F36B52;
        Sat,  4 Jun 2022 04:46:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f7-20020a1c3807000000b0039c1a10507fso5516909wma.1;
        Sat, 04 Jun 2022 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=UNcb1+OAEz29UmQTuC38RVucQOv89XoH/qGn3tO4q/A=;
        b=A8n5C4eeN3rBtjn5PJ96ByYM7oO6NkBkBKvLknmNZp2PNal722mJoCjWFY5olyhSfO
         JrJhN3M0X4uDSagMmQTKi2BxZqVGIYYYe1SGtY4uFiENLs4tJkYsfQkyW+Nr2/vnMkhD
         Hr15/muobpQCV6hq2dBPDu1j3nLLJCO3lZEHfVB3Q8CbhA+tqlqqx0laXXSWXyOEWugS
         bCiuIEbvmMcFStB8CGHLNeP2lk2qoIOw+yZAnaPRfV8RnjSOARqmwG2qNfGMKB3jOcgZ
         mGB4mfO2Yl8s5fVkAKAJBNogQQZ6ox4c5/HICMjrwgO47JV7Ynm1tD6K7J7LnIXw26eB
         0RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=UNcb1+OAEz29UmQTuC38RVucQOv89XoH/qGn3tO4q/A=;
        b=TXVChFp57pc1Gr+Pmt8jQ+6rXHjBl0WzN9cSP0Fh62DYsHnCrwjX1dUVhGA7AKHS64
         1IZHoWAlr0n59hfSej0/YFrKuTzXFkElFdQdkGpNjXCfQt1Wj4kCt93j18A7P3B0YO2K
         V6f7jWC/xldNrz0xVGlitxIMx4e4TPT2OMkMIQFZ+CkwnSQPoqS25ZSFA8Wl2gn3dWAb
         KIBL/xu5t/9vSOGNBkSJ2y8zmfG5R3QqbEjoy2GeQxW+Tr+csY+3j9DqYHZbRrsym/tj
         tZm2umdAiIzznzkb0QUY2GdO2nkx/delqkLW5SwiDwaFe2wrIBLzFAllAEOCkmEUiHUl
         4uvQ==
X-Gm-Message-State: AOAM530vXI1Frqoyp+nXQWtqYz5T3/jVkyZKzda5ZfZO5tGbu5kOWl8T
        Yb9Zr0nvn7bwXsY2zuxTnJkIOPNKFM7XPQ==
X-Google-Smtp-Source: ABdhPJxew7II36E+AsQSwtmwW7YAe0USk5OTDodFDdU2bcH99rLacx5YONc1ONJd0qiZqjTded+fPA==
X-Received: by 2002:a05:600c:1e89:b0:397:82c8:eda9 with SMTP id be9-20020a05600c1e8900b0039782c8eda9mr12996669wmb.156.1654343177807;
        Sat, 04 Jun 2022 04:46:17 -0700 (PDT)
Received: from localhost (92.40.202.101.threembb.co.uk. [92.40.202.101])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d4d8b000000b0020c7ec0fdf4sm11586195wru.117.2022.06.04.04.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 04:46:17 -0700 (PDT)
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-4-aidanmacdonald.0x0@gmail.com>
 <20220603173404.4cb83647@jic23-huawei>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: iio: adc: axp209: Add AXP192 compatible
Date:   Sat, 04 Jun 2022 12:33:25 +0100
In-reply-to: <20220603173404.4cb83647@jic23-huawei>
Message-ID: <t8jiSeLliI9SkNKKcN2aBMxSntde4pn7@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Cameron <jic23@kernel.org> writes:

> On Fri,  3 Jun 2022 14:57:07 +0100
> Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:
>
>> The AXP192 is identical to the AXP20x, except for two additional
>> GPIO ADC channels.
>> 
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>
> There is an argument that could be made here to say this should
> have a fallback compatible to a suitable existing part as the driver
> would work, we'd just be missing a couple of channels.
>
> I don't feel strongly either way, but thought I'd raise the possibility.
>
> I guess it's irrelevant if an updated kernel is needed anyway to have
> it functional because of support needed for some other part of the chip
> though.
>
> Jonathan
>

That may be possible, but you can't probe the IIO driver without having
an updated MFD driver so I'm not sure a fallback compatible is needed.

Regards,
Aidan

>> ---
>>  .../bindings/iio/adc/x-powers,axp209-adc.yaml  | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
>> index d6d3d8590171..1a68e650ac7d 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
>> @@ -14,6 +14,23 @@ description: |
>>    Device is a child of an axp209 multifunction device
>>    ADC channels and their indexes per variant:
>>  
>> +  AXP192
>> +  ------
>> +   0 | acin_v
>> +   1 | acin_i
>> +   2 | vbus_v
>> +   3 | vbus_i
>> +   4 | pmic_temp
>> +   5 | gpio0_v
>> +   6 | gpio1_v
>> +   7 | gpio2_v
>> +   8 | gpio3_v
>> +   9 | ipsout_v
>> +  10 | batt_v
>> +  11 | batt_chrg_i
>> +  12 | batt_dischrg_i
>> +  13 | ts_v
>> +
>>    AXP209
>>    ------
>>     0 | acin_v
>> @@ -50,6 +67,7 @@ description: |
>>  properties:
>>    compatible:
>>      oneOf:
>> +      - const: x-powers,axp192-adc
>>        - const: x-powers,axp209-adc
>>        - const: x-powers,axp221-adc
>>        - const: x-powers,axp813-adc

