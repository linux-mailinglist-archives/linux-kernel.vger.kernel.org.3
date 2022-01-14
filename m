Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D6D48E4E6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 08:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiANHeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 02:34:31 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52814
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239331AbiANHea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:34:30 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3AE7F3F198
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642145669;
        bh=mteS+HvR1DGukuOVJN2MZ0A5d8t+icrvQbG1zYE72KQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=NVKxByARpkK5AkUDkqdkURIyhrQFd+IwUlD1IrFX23UoxTCKFwEKYrHnEHDW84H+b
         GGLdixG3NeFAhTdUeGRaID8J117NOrKalAt9ZsW3QNw38jFZFzA+UKwlR84ZCyApOS
         2x0aNHF2EouexbGVX6hxJkTftGN/ygrp+SvhijLjPOqy33qFYOi+pGMTmcFkaTuvEV
         t4dUnbWjnJQb4UAIyPaQ8hFtvGgWOTwhmm6vHhS88idbGTCD5awMSAe+Vx3pwGgDOo
         B6Pe9gIpP90zgSkI7B20EDfndfmqDV9xuysR1xqdmcRKqG1wN72GpI0nsfYKzKdLnh
         lTIGR3Ys89vxw==
Received: by mail-ed1-f72.google.com with SMTP id o20-20020a056402439400b003f83cf1e472so7593228edc.18
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 23:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mteS+HvR1DGukuOVJN2MZ0A5d8t+icrvQbG1zYE72KQ=;
        b=6cufTRlMhV0/z5E18E58LBqBeB8O7apUi+hXJkxaTsEtQz9P+7iPJ2K09oJeyTuibp
         rdJRug7cX8sHNWkXP2J1leAkrQp+Uc63lQdz+gE680an0vdZJKO7qF7/9hNg+PU7lujV
         /m+7e/zF4T7znCiLhHPBeSKHBAhv6MqMi6D5RtwCQfTMqQYYTjTZbN/1uh01805Iwr3m
         sXExx1DwdsuNGzScRhHKMYNUvM6241Zm/OmoYJ8Ib4wTfFAsOYstJBg3lkRQjywqEWQ8
         w/lU0woY5M5bpXsQtmpbuaISJM0uZOv4o+OJwQBheJwo6TTjJVOtiDg0dMnjvQUZrkeR
         aVBg==
X-Gm-Message-State: AOAM531RoKcj5yJWTideG84X0zirPSp9oFvvfvP4JoxXRavNMHBmFVm/
        X+RcUsmhQ1fycm47OPZ+QdPpIE1OsM+Pnl1Z442hXXrwKAd4g2hSmE4iRQXKH39sfLMShvFHHjh
        g3yvO5VBSXwgMBkQ9YVgD9RnnKHF1lcmlQRWZCoz78Q==
X-Received: by 2002:a17:907:6e02:: with SMTP id sd2mr6286811ejc.276.1642145668308;
        Thu, 13 Jan 2022 23:34:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPYpFBXNfBuxsoAXAMpsTbqNgiDwQGWbcN8/zT8+trFSXbW3w4GwrSWxUCYjfS0jRzR3y3XA==
X-Received: by 2002:a17:907:6e02:: with SMTP id sd2mr6286798ejc.276.1642145668097;
        Thu, 13 Jan 2022 23:34:28 -0800 (PST)
Received: from [192.168.0.30] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id ky10sm1567611ejc.151.2022.01.13.23.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 23:34:27 -0800 (PST)
Message-ID: <5e3f84e0-7b91-8eac-1643-d44f61a47620@canonical.com>
Date:   Fri, 14 Jan 2022 08:34:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 00/23] Add support for Tesla Full Self-Driving (FSD) SoC
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        olof@lixom.net
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, robh+dt@kernel.org,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, arnd@arndb.de,
        Arnd Bergmann <arnd@arndb.de>
References: <CGME20220113122302epcas5p1d45c0714fe286f8f91d0f28c3fad86e4@epcas5p1.samsung.com>
 <20220113121143.22280-1-alim.akhtar@samsung.com>
 <d1a852e1-c4c2-b7c4-ddeb-7fbcfd9b4e58@canonical.com>
 <076001d80909$52d201c0$f8760540$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <076001d80909$52d201c0$f8760540$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 06:41, Alim Akhtar wrote:
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>> Sent: Thursday, January 13, 2022 6:02 PM
>> To: Alim Akhtar <alim.akhtar@samsung.com>; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Cc: soc@kernel.org; linux-clk@vger.kernel.org; devicetree@vger.kernel.org;
>> olof@lixom.net; linus.walleij@linaro.org; catalin.marinas@arm.com;
>> robh+dt@kernel.org; s.nawrocki@samsung.com; linux-samsung-
>> soc@vger.kernel.org; pankaj.dubey@samsung.com
>> Subject: Re: [PATCH 00/23] Add support for Tesla Full Self-Driving (FSD) SoC
>>
>> On 13/01/2022 13:11, Alim Akhtar wrote:
>>> This patch set adds basic support for the Tesla Full Self-Driving
>>> (FSD) SoC. This SoC contains three clusters of four Cortex-A72 CPUs,
>>> as well as several IPs.
>>>
>>> Patches 1 to 8 provide support for the clock controller (which is
>>> designed similarly to Exynos SoCs).
>>>
>>> The remaining changes provide pinmux support, initial device tree
>>> support, and SPI, ADC, and MCT IP functionality.
>>
>> Does FSD have some version number? The FDS, especially in compatibles,
>> looks quite generic, so what will happen if a newer SoC comes later? You
>> would have:
>> - tesla,fsd-pinctrl
>> - tesla,fsd-xxxx-pinctrl (where xxxx could be some new version)
>>
>> This will be extra confusing, because fsd-pinctrl looks like the generic one,
>> while it is specific...
>>
> AFAIK, there is no version for FSD SoC (like we see on Exynos or any other SoC)
> In case something comes in future, may be just adopt as Olof suggested in the other thread like fsd2 etc..
>> Best regards,
>> Krzysztof

The naming is still confusing. The SoC is FSD, compatible is "fsd" but
entire sub-architecture is also FSD called. Therefore it looks like
creating entire sub-architecture for only one SoC, which actually in
multiple pieces is or looks like Samsung Exynos (designed by Samsung,
using several blocks from Exynos SoC).

Best regards,
Krzysztof
