Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1335AD2D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiIEMia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiIEMiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:38:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBB467171
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:32:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z6so12903724lfu.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=luMotQSnu9DwzICqr56kY4I1QccgfPEIbfc2jLVutUA=;
        b=daY6NPc/H4d2Q79SfxBY81+FsBpckwl52NXQXn7EqI3KV1Qm0FeAyBwF6sQLTPf4QZ
         GA0X8yYhnRnvEZ98kiS5qG0UYyblK6YGLovfqV2mpHm0+u4lmSz4wr4OX8/jqH0EF83Q
         KqeQiXSWvkclevXgXon2I+vK9tDsKxX/3iTKubcs3MTQxD/yEoAnpjYm4l/ex8hXdoSL
         3SEJf+t+3aeLlDjimuiRccvIARPZ+CgS5R39jG9CD4qJ0Md/j8HLlqcCW9ZLWw/ECqLX
         jbUP3UwsXwx+VvKjVZP0PIRUqNw4XRVrWW+a/EnCGOHgQ8GL/q4HZGZQao6b9fCS33Wm
         O0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=luMotQSnu9DwzICqr56kY4I1QccgfPEIbfc2jLVutUA=;
        b=WWxz9yeX1JK3QpNsLrgs+U7LdLOy7I9qMIb6nlywhLWBwHAAO/Y718lZaZf/RHjUDM
         5lD771cRl7pRJaqwolfMs0QoKK/dlVs3xr7Uu66f725uYbfO6PWYzTY/wXp5h0Apc4Gs
         NUVIQrHb/GCQClDncrs9QBVcERIJlPBVFVrypFOc/rBJWYcH2mtM1Br/COEo7C/Tp1Gb
         cUFU/i1LZltYi2AJwTcDy5Ako1NPxOCHUZlra2TolllMQrlSSnoTB7O9Fh1obxfhkxW1
         ZUa7NUhcKC/SQCYg8kuCfj2Cs0QaTtZ02xmRDDR1Crhly1SVyVSnXFO424KCp06QhCz/
         U8XA==
X-Gm-Message-State: ACgBeo1kiuueXcH2mrVqcKmFvb8KEw8Pge9TBdbFYz0UiSgLbnqJtwF4
        I230TUcbEt/GwWneSrIeM5xsxg==
X-Google-Smtp-Source: AA6agR6FD9/InwzG/uA0Mw1j0ew/Cccp+ehBOLRW+h/s+XVgdEkcqqQofCLMTDVrpsQTxvmwftH5KA==
X-Received: by 2002:a05:6512:1293:b0:494:96ee:80c1 with SMTP id u19-20020a056512129300b0049496ee80c1mr7082313lfs.417.1662381129687;
        Mon, 05 Sep 2022 05:32:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c4-20020a056512074400b00494961d8efbsm1177336lfs.189.2022.09.05.05.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 05:32:09 -0700 (PDT)
Message-ID: <67ca6131-c2c8-058a-ec6d-34412de2921c@linaro.org>
Date:   Mon, 5 Sep 2022 14:32:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/4] dt-bindings: memory: Factor out common properties of
 LPDDR bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20220831013359.1807905-1-jwerner@chromium.org>
 <20220831013359.1807905-2-jwerner@chromium.org>
 <08d8807e-18cf-032e-90e9-e08023e7a6e0@linaro.org>
 <CAODwPW-UfvgbGaZtyu_g-8dv_rmz8Zk6Xb6M5DTtRah_1W2KVA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAODwPW-UfvgbGaZtyu_g-8dv_rmz8Zk6Xb6M5DTtRah_1W2KVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 03:09, Julius Werner wrote:
>>> +properties:
>>> +  manufacturer-id:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      Manufacturer ID read from Mode Register 5.
>>
>> Are you sure that register numbers (here 5, 6-7-8 later) are the same
>> between LPDDR 2-5? The description should match the broadest case and
>> specific schema can narrow or correct it.
> 
> Yes, the new LPDDR versions only ever seem to add new mode registers,
> but the meaning of 5, 6 and 7 have always stayed the same. (For 8, the
> bit fields have remained the same but the mapping of bit patterns to
> values has changed.)
> 
>>> This also un-deprecates the manufacturer ID property for LPDDR3 (and
>>> introduces it to LPDDR2), since it was found that having this
>>> information available in a separate property can be useful in some
>>> cases.
>>
>> Why do you need to un-deprecate them if you have this information in
>> compatible? This was not exactly the previous consensus. My statement
>> was ok for un-deprecating if you cannot derive them from compatible. Now
>> you can. This should be the same as USB device schema.
> 
> Okay. I think there is value in having these as separate properties,
> because it makes them much easier to read and use. 

Storing same value in multiple places is duplication and maintenance
effort. Does not make anything easier.


> If we don't have
> them we always need to do all this string parsing first, and if
> systems allow both kinds of compatible strings (auto-generated and
> static) they'll need to be able to distinguish and handle both of
> those when parsing... I think it would be much less friction if each
> datum of interest could directly be read out of a property. I think
> having a bit of redundancy is fine and common in device tree bindings

No, it's not common.

> (e.g. most properties for most devices are really implied by the
> compatible string because that same type of device is always built in
> the same way, but that doesn't mean it's not useful to list them
> separately for ease-of-access). But I can remove them if you disagree.

Just like we do not have them for USB, I don't really see the reason to
have them for memory.

Best regards,
Krzysztof
