Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426545955F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiHPJLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiHPJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:10:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233CDAEDC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:27:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u6so9806196ljk.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jgkKAq27nalp4xFLW3mk73yjlH+iPel54g7OBjDZ1oI=;
        b=Mq7r6vRNCChXlYPF+zT+4Ept2VrTSrrP38C87uSqO8mXR/YVOX0bc2McxNSYlkkJTO
         e+yH0rOVHqI0INUR/tSCYNXQU+p5/vwbT6u6aPRBaxQ6rMZpSy5k/VWsBL9Xp6vvIR8X
         0PA3lUFcXPoMfb260xJiszNnXlRH9NvLF1m2hpHFs9gT4V8lV0SsJpmw9BR4vZ1gHH1j
         c9kr3Vsajkbe22PtuANvdRgPeaUZ8sSt9fVW+ovyMLUS7440oFkcHs1atjIug+i2nGDx
         WK6smRGXOaT1y5GxG6ZvcY5C348l7BHW39G0lV6+iqdC754xonpL8n7jbkfhynuZP2bv
         sBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jgkKAq27nalp4xFLW3mk73yjlH+iPel54g7OBjDZ1oI=;
        b=V0vXXT4ANFvUAVXDxnw6tyhlzg3QpZvbmMKHzEI3TWLvXRK4MjMRZD9O/7ItZ5YzrD
         06OlrrEIFKmQ8+SkHOF4UEASV2MGALZRqQDurg5GJpH5o2m2zKZkn6BVdM5su13OKxPL
         Go1bX55BV+e6BCIu6mKUn03IVZ4vveTYjDCymiJ02GO/XyfvoQ2yv4Nq5UzRF2bK3Dfh
         wdeD2qKgLsf8oNtGCRT7TLRlVVtrxpxI2YUPL9fHOj+FwnEle5MdEffnsb9R3yKPppD3
         J4iYG7TrKrJnqp561ZqZdjpWSsYT2WbB+HG0zIRNa86VN5Vkq2mgwVdd6vi2l8VnZi/r
         t4yw==
X-Gm-Message-State: ACgBeo2AwFExSvXM+jSrRf3R0oP/dTapyXACowRgwvdSZz+YLEmLvmLd
        Z5mzDVHr7yVaDxAEV8TRwoGquQ==
X-Google-Smtp-Source: AA6agR4jEHWzEqPmD1v9ED+1vw84vjsvdHwzpp1nZoCUPf9WX8jWoeSl8sl+A2IWC5wW16bz/hCrFg==
X-Received: by 2002:a2e:a311:0:b0:25f:d95a:9c66 with SMTP id l17-20020a2ea311000000b0025fd95a9c66mr6273478lje.208.1660634836806;
        Tue, 16 Aug 2022 00:27:16 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id q22-20020a056512211600b00491dda41e4bsm794337lfr.172.2022.08.16.00.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:27:16 -0700 (PDT)
Message-ID: <343268e1-0c11-ae5f-c99a-62617e23f396@linaro.org>
Date:   Tue, 16 Aug 2022 10:27:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add Richtek RT9471
 battery charger
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?B?5ri45a2Q6aao?= <alina_yu@richtek.com>,
        cy_huang <cy_huang@richtek.com>, alinayu829@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <1660225318-4063-1-git-send-email-u0084500@gmail.com>
 <1660225318-4063-2-git-send-email-u0084500@gmail.com>
 <3cae9d60-4012-1dfd-abd9-4d0b9379e6bb@linaro.org>
 <CADiBU3_depGDZtiyizU3MB939A3oH1uTWzTMyruUy0z=u6BZkQ@mail.gmail.com>
 <40261b95-637a-1304-2e06-8c8ff7fc377b@linaro.org>
 <CADiBU38+9sR1r20=YWt-9s2+u7maHH+1VudCnV1-0+F4jYKdQQ@mail.gmail.com>
 <CADiBU3_Jt6n6tm=oVvjk5vsoEAneH7t-37S6skepA6v6bVVYUw@mail.gmail.com>
 <f2a664be-71e9-7a26-2f0c-5f654d9cb3cb@linaro.org>
 <CADiBU3-bKGhW2Yy13svNUykqW+WN3VS6LftWMU0rMeCc+fMySg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CADiBU3-bKGhW2Yy13svNUykqW+WN3VS6LftWMU0rMeCc+fMySg@mail.gmail.com>
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

On 13/08/2022 17:52, ChiYuan Huang wrote:
>>> Some gauge HW needs this information to enhance the battery capacity accuracy.
>>
>> Other supply stack pieces do it via supplies (supplied to/from in
>> include/linux/power_supply.h) and reporting power_supply_changed().
>>
>> With such explanation, your device is an interrupt source, but it is not
>> an interrupt controller. If your device is interrupt controller, it
>> means someone routes the interrupt line to your device. Physical line.
>>
> Yap, sure. And so on, just use the SW power supply chain to do this
> kind of event notification.
> To remove it, it doesn't affect the internal interrupt request inside
> the driver.
> Just cannot be used for the outer driver to request the events directly.
> 
> If so, I think 'interrupt-controller' and even '#interrupt-cells' need
> to be removed.
> OK?

Yes, both should be removed. Your device is not an interrupt controller...

Best regards,
Krzysztof
