Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCCF490AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiAQPAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:00:49 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47284
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbiAQPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:00:48 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CAADA3F203
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642431646;
        bh=P1t3TusiuWvEJQvj6KQ3UI4zLwE3rcF19O3O8iabinU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=S+hn/P/+ORd5yFuloev1kgWwDaFAaeiN7nXsJ/Qp+89KwtPN2IBixal8kgeBesRlT
         JuMKK4SrCzKujGFYUxxNKQOm0z40SXJhTOLhDq6j0VDJeJCpv8mH7761XWr1F55ZmH
         hJ6gp4DxAbO+DO2M4AqyUubDXzpV8h+tekH2Au09TTKSWGEiW3p+iDEQWOH4Oa52oQ
         Te3cUZi13alBYA2rH2c53+6rO+sWQgDlZw+xmz1+DhnLX3WgX7EiPopvGNz/ix18YE
         oGpKWMwnMk5fZO+SJ/inzEoQh6y3cF13LtsklT1mh+862F2jLFwWz2QhcrJ7wYrqwZ
         qQnXAJqSWbkpA==
Received: by mail-ed1-f70.google.com with SMTP id r14-20020aa7da0e000000b004021fa39843so3753225eds.15
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P1t3TusiuWvEJQvj6KQ3UI4zLwE3rcF19O3O8iabinU=;
        b=OmO8FBXwiE79BBmOhRXcHxn0ysWj0lAoJoA8Nd9WkB0iE3DrZWsTn/eiESwUBDGZNR
         r2bIR48Bpo+cFZj08dGnxJ6zzAE5cBKzv3V5KFp30FkVyj9f7g3UWHI6N+7Ff21zFNP8
         ofyckDVk6wMBAbi1PrtPK25uirni3xUGOxl3sFtKpDOz1lkT31rh+39+OO2GOaZkQPs9
         M/9qB2w7VWLYaddnkZ+M4dJUMAXc8k4MPkbXmYE7hXn3J74Hj9a58gmESIpV+8pDqBTr
         l8GW+y0IfqQttW5AuCWlt/kav9akXW3aeGfd2/p4PQ1ID8vV8dlYmHQxLvWrrM3SUmYP
         77jQ==
X-Gm-Message-State: AOAM533/HpxLfcG1tqg+cWAvJ50kIvwhYqB+PGE4ydZGdstnutFOnn2U
        CvamCryurfbk8PVvVASMT5zXIInvtEIFJityfk7ldnGew57xmDCRFI/GGh4L3fPOfjaG3I5dyN8
        7OXdks6RA1D4L+HbU5q2cxbXlviY08oNVzRQrlHHfSA==
X-Received: by 2002:a17:906:8053:: with SMTP id x19mr11918936ejw.485.1642431646520;
        Mon, 17 Jan 2022 07:00:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwi5fMBz8oaksx3ekbOg74TUZaXBrRwCj5lzvu6SsBncvDyD0ZOfpPjH3B+rGmVa8PY2miIKA==
X-Received: by 2002:a17:906:8053:: with SMTP id x19mr11918904ejw.485.1642431646225;
        Mon, 17 Jan 2022 07:00:46 -0800 (PST)
Received: from [192.168.0.39] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bg20sm3958261ejb.59.2022.01.17.07.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 07:00:45 -0800 (PST)
Message-ID: <9b98fd89-87b5-5026-fb0c-16bb956801ea@canonical.com>
Date:   Mon, 17 Jan 2022 16:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 13/23] dt-bindings: arm: add Tesla FSD ARM SoC
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>, linux-fsd@tesla.com
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
 <CGME20220113122408epcas5p45053d1bf0acf2d8233a98b6c1abab6eb@epcas5p4.samsung.com>
 <20220113121143.22280-14-alim.akhtar@samsung.com>
 <53c17ddc-a049-72ed-7237-de23db7889da@canonical.com>
 <085801d80967$e4b8fe00$ae2afa00$@samsung.com>
 <5ab62673-8d46-ec1d-1c80-696421ab69ca@canonical.com>
 <00c901d80ba5$c9ae6ab0$5d0b4010$@samsung.com>
 <CAK8P3a31bCHNcNWrLX+QW+4RuK=DBpxLA_j5BFKxXxXKCT8PFQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAK8P3a31bCHNcNWrLX+QW+4RuK=DBpxLA_j5BFKxXxXKCT8PFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2022 15:14, Arnd Bergmann wrote:
> On Mon, Jan 17, 2022 at 2:26 PM Alim Akhtar <alim.akhtar@samsung.com> wrote:
>>
>>> I cannot judge how different this is from Exynos subarchitecture - looking at
>>> patches it is not different - so I could understand a FSD sub-arch with only one
>>> SoC.
>>>
>> I understand, it is a bit difficult to visualize it with the current patch set.
>> As discuss on the other thread, FSD is different, more over the vendor is different, internal design is different.
> 
> Is it based on another SoC design then? Most new SoCs are derived from
> some other
> one, so it makes sense to put it into the same family. E.g. the Apple
> M1 takes bits from
> both Exynos and PA-Semi SoCs but has more newly added components than
> either one.

It seems Apple M1 shares only few bits with SoC. I am aware of only UART
driver as directly re-usable.

> 
> I would argue that if this SoC shares the pinctrl, clock, spi, adc,
> and timer implementation

Plus: UART, watchdog, PWM, I2C, I2S, USB PHY, DWC3 USB (in Exynos
flavor), UFS (also in Exynos-looking flavor), MFC (video codec), some
similarities in DW PCIe, TMU (thermal). Looking at DTS there are
differences but just few comparing to most of shared blocks.

Additionally SoC BSP (and maybe SoC itself...) was actually developed or
co-developed by Samsung, judging by copyrights in the BSP code. Even the
original DTSI has:

	TURBO TRAV SoC device tree source
	Copyright (c) 2017 Samsung Electronics Co., Ltd.


Tesla could still customize it a lot, but it is a strong hint that most
of it came from Samsung LSI and shares with existing Samsung designs.

Have in mind that recent Exynos chips are significantly different than
early ARMv7 or ARMv8 designs and we still consider them part of Exynos
family.

> with Exynos, we should consider it part of the Exynos family,
> regardless of what other
> blocks may exist next to those.

Yes. I don't see the benefit of keeping it outside of Exynos. It will
sprinkle "depends on ARCH_EXYNOS || ARCH_FSD" all over (or depend on
Exynos like you suggested).


Best regards,
Krzysztof
