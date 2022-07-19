Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B17F579526
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiGSIU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiGSIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:20:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB24C2AC7B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:20:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bk26so20410704wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xd0Nc+zNCPBmUNJaS2OhYDDTwIO4yuqtAZex5tQXAwY=;
        b=KKTnV56L2I48XJSkwd71YzfFHWnJ6hVS7EBPHqF7YAFYqcpiMOZAdj7w4WkyPSVlhM
         PVOdyHwoltehxoPYDPltF8QL2MpdK1M8V8GoLAWsJd6K8QTwtftTjpCKfHyCQi74aE3u
         9E148AQz5DJmXBhRwyTFUmmek6rKToMgbu0yA1zs6BvYlEe+t3KE43G3dMQc2oPtx8nq
         +5yG81pEmqTyg17UU0vND6WRzQNghnQiliz1+2+fhinspiE8KW4eTocRjEJ8ze7ppgQc
         UeemB2I2f6bnsznb1t5K5s16J5Tt4ZbOI9BQK/VV0dEADnYWdBeh3jB4NEuZT3RUlGK8
         qYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xd0Nc+zNCPBmUNJaS2OhYDDTwIO4yuqtAZex5tQXAwY=;
        b=DzN06x9g1CIpLapNes+1JiHLXZJEmoD95zBOyme6OON6c6bIi6r+lshSqWkxa+ak/s
         CHfSysFI3rvjZrEuN2BrCkf77UcqtRmggqxGeQVjz2ul/rHXoDB4r17rKqWj0wv+qKPK
         kMtwKcdoF3/8pLEadIok5BPnW2E+iXgPwAV+Om5Cl/ohLmvO9FAEWHuoen0MDcSQbVAb
         1aOaIZp3yJ8D9/D/KqPfSegGUYy6JYkxyxzGEW101X+x0CCSgeFre95IyHJ/jqvmmsBV
         6P66Hcvtz9yAeUlOFqqti9Z7CoxvZPInLWmDjym9yGAOOeKVHFHMnCVitqOXvGqJF+/H
         7/iQ==
X-Gm-Message-State: AJIora+tKTMcZktqj+Qx/MpbEGjrb8zbTFeUh9drexKm2hvDM8H7oE+/
        McRT09aTnaxGIgiIwOlRjlw4aQ==
X-Google-Smtp-Source: AGRyM1uRPrVhXybr+/OpVvs2JrvOxXfHp6ae4STNmjP1jNiXbtdo4HafHXzI9Q6EnMnSbvPw6pDYhQ==
X-Received: by 2002:a05:6000:156b:b0:21d:9daf:3cdb with SMTP id 11-20020a056000156b00b0021d9daf3cdbmr25978919wrz.492.1658218850304;
        Tue, 19 Jul 2022 01:20:50 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id h24-20020adfa4d8000000b0021d83eed0e9sm12490145wrb.30.2022.07.19.01.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 01:20:49 -0700 (PDT)
Message-ID: <b318df5a-bf11-bfb8-aa7a-59d719081f8b@sifive.com>
Date:   Tue, 19 Jul 2022 09:20:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 7/7] pwm: dwc: add snps,pwm-number to limit pwm count
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-8-ben.dooks@sifive.com>
 <20220718200828.GA3453680-robh@kernel.org>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220718200828.GA3453680-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2022 21:08, Rob Herring wrote:
> On Tue, Jul 12, 2022 at 11:01:13AM +0100, Ben Dooks wrote:
>> Add snps,pwm-number property to indicate if the block does not have
>> all 8 of the PWM blocks.
>>
>> Not sure if this should be a general PWM property consider optional
>> for all PWM types, so have added a specific one here (there is only
>> one other controller with a property for PWM count at the moment)
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>>   Documentation/devicetree/bindings/pwm/pwm-synposys.yaml | 5 +++++
>>   drivers/pwm/pwm-dwc.c                                   | 8 ++++++++
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml b/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
>> index 38ac0da75272..15bdf764b46a 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
>> @@ -30,11 +30,16 @@ properties:
>>         - items:
>>           - const: snps,pwm
>>   
>> +  snps,pwm-number:
>> +    $ref: '/schemas/types.yaml#/definitions/uint32'
>> +    description: u32 value representing the number of PWM devices
> 
> Why do we need to know this? Are you going to have a consumer to a
> non-existent PWM? If you do need to know how many, it should be implied
> by the compatible string.

For this IP block it is a build time option for 1..8 timers
so I thought it best we don't register non-existant timers


The system we are working on only has 1 PWM timer per block.

-- 
Ben

