Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E793C49F6BF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347766AbiA1J50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:57:26 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41034
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347746AbiA1J5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:57:25 -0500
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BE0B73F1E8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643363838;
        bh=uujg11plXD3RPnX/2BdooTtCRuBvYUtO19nJlVqdK68=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iwFlbAW/sGndKWq6x8m84IWp/HHUT258A7n0Ojq0lwhNZT/gOfULjyU70BEt4T/8L
         /fHYJK4zFnaU+9C0mN/Z2nugCDeqtyzfERk/z1SigVdns2F3EhRd3gVMh8ds99AoHy
         QvHwcgrrMMx0AthFUa8854Z/6HMPDb7ZFugXerP0NRT1vvw2Htb8EtYHvClpMBCBTi
         3Ok/bBDG09uC3/JBmyy6rTQ3PIZ4UzJxoY49i5SxtPtjpBhYzRLkdzVoLZexX5BZk9
         w59+FYI/QeGd3mSuPx1yhYHy6SXlqldx3ipnR+hV2BUTWYK9fyk0rQCLXcUKz+mp5X
         IsbzSFdhDGzuA==
Received: by mail-ej1-f69.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so2627815ejw.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uujg11plXD3RPnX/2BdooTtCRuBvYUtO19nJlVqdK68=;
        b=bnL1PC76dlp0mUDK2SRWvixrk7TomLJ/7riBtHacZWBqQgxZqaTFni/h3LC8RbGf93
         3WYaiCQwZsBfoSpGZYsmOAuY6T6HOF+FqRKNsRxtZcYjwy0380F4nszEKS7xAHAovBnE
         vI2rH6IrW9Yofr7rNQQjJ6OUq97BEdlsijWNxMqPmkmflUdfF2i5rL1n+fPM+TmuT3+9
         6Ko5o1VdDzQ4TZdimE2tSX12cxsnGnMg2hzOrnx6eXK5JUU5iFQrlf0FCaXFP0luwquF
         3Uev0hl7Dhg9Rbx1O+fDfyjMKap047NmlQfu08+rvGVXDshawgRjxujmVVPqhYog09ER
         iDLw==
X-Gm-Message-State: AOAM531CGHS19vfBz+cdjO28mcXmZ2NlyKYXerjPcjaGFkUn6+ptoJT9
        W9J+M3LFAOkefeVl1BplG04sZeInF/Sjyab68XifZP4lxzPid0JIZk3jYXpk51g3KQ1aZJkE30+
        P0TrsNMVx6Xe0qMiZjfUdc2i1Esa9SAC4stiZ+QWqPA==
X-Received: by 2002:a17:907:7f29:: with SMTP id qf41mr6268523ejc.12.1643363838414;
        Fri, 28 Jan 2022 01:57:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4HPsZXd/c07KXWv0puKOj92zskLUE1EEXftGa9cX5bE4gS+zy99NsmGnqeVXc9YXAa5/o8g==
X-Received: by 2002:a17:907:7f29:: with SMTP id qf41mr6268511ejc.12.1643363838150;
        Fri, 28 Jan 2022 01:57:18 -0800 (PST)
Received: from [192.168.0.66] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p13sm9732226ejx.191.2022.01.28.01.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 01:57:16 -0800 (PST)
Message-ID: <64ee2334-aa99-7226-8946-84c95676041a@canonical.com>
Date:   Fri, 28 Jan 2022 10:57:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 6/8] dt-bindings: vendor-prefixes: add LG Electronics
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, Petr Vorel <petr.vorel@gmail.com>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean THOMAS <virgule@jeanthomas.me>
References: <YfHlV13Zi4KV+bNT@pevik>
 <c69d1daf-45c8-3ac5-a0b0-bb853593c54e@canonical.com>
 <5883435.31r3eYUQgx@g550jk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <5883435.31r3eYUQgx@g550jk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 21:51, Luca Weiss wrote:
> Hi all,
> 
> On Donnerstag, 27. Jänner 2022 08:45:33 CET Krzysztof Kozlowski wrote:
>> On 27/01/2022 01:20, Petr Vorel wrote:
>>> Hi all,
>>>
>>>>> Hi Krzysztof,
>>>>>
>>>>> On Montag, 13. September 2021 10:49:43 CEST Krzysztof Kozlowski wrote:
>>>>>> On 12/09/2021 01:27, Luca Weiss wrote:
>>>>>>> LG Electronics is a part of the LG Corporation and produces, amongst
>>>>>>> other things, consumer electronics such as phones and smartwatches.
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Thanks for the patches.
>>>>>>
>>>>>> I think "lge" it's the same prefix as "lg". There is no sense in having
>>>>>> multiple vendor prefixes just because company splits inside business
>>>>>> units or subsidiaries. The same as with other conglomerates, e.g.
>>>>>> Samsung - if we wanted to be specific, there will be 4-5 Samsung
>>>>>> vendors... Not mentioning that company organisation is not always
>>>>>> disclosed and can change.
>>>>>
>>>>> I was mostly following qcom-msm8974-lge-nexus5-hammerhead as it's the
>>>>> other LG device tree I am aware of so I've picked lge instead of lg.
>>>>> Also worth noting that Google uses "LGE" in the Android device tree[1]
>>>>> or in the model name in the LG G Watch R kernel sources ("LGE APQ
>>>>> 8026v2 LENOK rev-1.0")
>>>>
>>>> [1] Does not point to kernel tree. Downstream user could be a good
>>>> argument to switch to lge, but then I would expect correcting other "lg"
>>>> devices which are in fact made by LGE.
>>>>
>>>>> I don't have a strong opinion either way so I'm fine with either.
>>>>>
>>>>> If we decide to go with "lg" do we want to change the Nexus 5 devicetree
>>>>> (hammerhead) also, that one has the lge name in at least compatible and
>>>>> filename (I don't know how much of a breaking change that would be
>>>>> considered as).
>>>>
>>>> We would have to add a new one and mark the old compatible as deprecated.
>>>
>>> Have we sorted this lg- vs. lge- ?
>>>
>>> There are both:
>>> arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
>>> vs
>>> arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
>>
>> Probably renaming/unifying/correcting prefix in existing compatibles is
>> not worth the effort. This would make a mess and affect other DTS users.
> 
> If wanted I can send a patch renaming the Nexus 5 to just LG, this would 
> adjust both compatible in the file (which shouldn't really affect anything) and 
> the filename (which probably will affect various scripts and whatnot used by 
> existing users of the dtb). 
> Is this something that can be done in mainline or should we rather just let it 
> be? I'm not sure what the policies there are.

The "lge" compatible is already in the bindings, so it should not be
changed without valid reason. Imagine there is an user-space code
parsing compatibles to adjust some power-management settings to
different models. It would be broken now.

What could be done is to mark it as deprecated and a add new one:
compatible = "lg,hammerhead", "lge,hammerhead", "qcom,msm8974";
This should be safe for user-space and allow transition to common "lg".


Best regards,
Krzysztof
