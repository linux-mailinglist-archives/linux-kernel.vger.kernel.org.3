Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96C7595C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiHPM5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiHPM5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:57:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3B91EAFA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:57:06 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a9so14771632lfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=u6vsO210HbSOzl+ApBtKdfKeKIVufqnfwmwO0kmWyvI=;
        b=ryshPL7gSJngeT8mVWdgphUp3NPNc5/8T07ioXmLOYFE+RM9kMFox6j/QSmMx+MRjW
         IF5Tvsu+eUNa/PURaluKXcxsPoKwTU0v6obcpVNF6S4E2WUJQwfcMoAedizNNTEJVzIN
         qApkaeQsH9W4FBpYE2y4cHYlnaFnoj9yBLWWtHAiDyYD2WSMopnYkuWFR3AZvGXe9orE
         W7mL52SexG3h2NyytiRZEwQPnlFxYDDwyJbFKcIuCS7pw5DDoUXAJcdrv+Qc4tTN48CC
         ofihlq8KHD75r9tNZ+KV2KtQWXkZp55mGCW7DPJAuyRkCANnLDWg9JgV8nXF25DqpsEo
         /E1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=u6vsO210HbSOzl+ApBtKdfKeKIVufqnfwmwO0kmWyvI=;
        b=I9IzU9zmvCON3RYo13rpi6m+4eXo/WIEpqHvpgDmlUUW9bWY9rKLhSeL+UbdQL5Ukd
         rohGN5b7Ue/y2ADV1Z2Wtcvi5WSTIN38E8WCppUQQ9bTv6ZjVk5jRY/ZPpx0AAoBeqrV
         3y90yC8BwwlolMsQTNJb4GFQIhdcSajGT9d3WtrmObEIHLOYt3TJTBAOYNwDFsT+lHsc
         oUtR/Dnl22NReetyBQb1xwt8g5Lq2OzrpoT4c0vutx83ujXWUs6k0A6k7pxmsIOvFNG8
         JsX1Grz7uySQGvoj8oTSQu3E0X36thSuhh1gm1tI/Qykn7xKqbP9vThrlhsFnTl2rB+X
         b6Uw==
X-Gm-Message-State: ACgBeo3v0jlOgNe6c6g5tpqBAbYvnZcEFnLxs9egaz3WWpkEMyd/I1+Q
        Sl98xCSrNzWUkEhfuSaYbwTXZw==
X-Google-Smtp-Source: AA6agR60sMxOHtIXk2hcNdYq73fYG6QiAiIF8W4tR5L6Ra08qXNqi9BEiQFyK2ct4uvflrrmAZRnVQ==
X-Received: by 2002:a05:6512:b03:b0:492:88d3:8369 with SMTP id w3-20020a0565120b0300b0049288d38369mr3820559lfu.552.1660654625046;
        Tue, 16 Aug 2022 05:57:05 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id b26-20020ac2411a000000b0048af9d2d119sm1379707lfi.130.2022.08.16.05.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 05:57:04 -0700 (PDT)
Message-ID: <1349b271-796b-c9d2-a568-f9be84926ed4@linaro.org>
Date:   Tue, 16 Aug 2022 15:57:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/1] regulator: dt-bindings: mediatek: add mt6366
Content-Language: en-US
To:     "zhiyong.tao" <zhiyong.tao@mediatek.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, eddie.huang@mediatek.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        fshao@chromium.org, sen.chu@mediatek.com, hui.liu@mediatek.com,
        allen-kh.cheng@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220812092901.6429-1-zhiyong.tao@mediatek.com>
 <20220812092901.6429-2-zhiyong.tao@mediatek.com>
 <cbe761af-5011-83a2-0509-2b3c4fe0a79c@linaro.org>
 <4a49b619deb5453749a47874377cad6a36a9a054.camel@mediatek.com>
 <CAGE=qrohYZ6f9bbEuYfF=2Rz21nbW_8ho3rBQmHt1D+kQG2-jA@mail.gmail.com>
 <9bc148119fc36c34f404091ca0f5a2e37727c285.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9bc148119fc36c34f404091ca0f5a2e37727c285.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 15:54, zhiyong.tao wrote:
> On Fri, 2022-08-12 at 15:55 +0300, Krzysztof Kozlowski wrote:
>> On Fri, 12 Aug 2022 at 15:52, zhiyong.tao <zhiyong.tao@mediatek.com>
>> wrote:
>>>
>>> On Fri, 2022-08-12 at 13:55 +0300, Krzysztof Kozlowski wrote:
>>>> On 12/08/2022 12:29, Zhiyong Tao wrote:
>>>>> Add mt6366 regulator document
>>>>>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: mediatek,mt6366-regulator
>>>>> +
>>>>> +  regulators:
>>>>> +    type: object
>>>>> +    description: List of regulators and its properties
>>>>> +
>>>>> +    patternProperties:
>>>>> +      "^buck-
>>>>> v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$":
>>>>> +        type: object
>>>>> +        $ref: regulator.yaml#
>>>>> +        unevaluatedProperties: false
>>>>> +
>>>>> +      "^ldo-v(dram2|sim1|ibr|rf12|usb|camio|camd|cn18|fe28)$":
>>>>> +        type: object
>>>>> +        $ref: regulator.yaml#
>>>>
>>>> You miss unevaluatedProperties in most of the places.
>>>
>>> Hi Krzysztof,
>>>    Thanks for your suggestion,
>>>    Do you mean that all places should have the
>>> unevaluatedProperties
>>> Properties ?
>>
>> Yes. You put it in some of the places which does not really make
>> sense...
> 
> Hi Krzysztof,
>    Thanks for your suggestion,
>    We find that if there is a properties "compatible = "regulator-
> fixed";" in ldo-vrf12, we should set unevaluatedProperties as true.
> or it will check yaml warning "Unevaluated Properties are not
> allowed('compatible' was unexpected)". is it right?
>    There is a properties "compatible = "regulator-fixed";"in ldo-vrf12.
> It will cause the checking yaml error "ldo-vrf12: 'regulator-name' is a
> required property". Can you help to give a suggestion to fix the
> warning? Add regulator-name for ldo-vrf12 or other suggestion?
> 

And how this regulator is supposed to work? Are you populating DT
children in your driver?

Best regards,
Krzysztof
