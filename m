Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A38E4873BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiAGHrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:47:37 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37340
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235999AbiAGHrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:47:36 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9B22F402EA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 07:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641541655;
        bh=PdugAwOKj5OweNcK0/97VfSiKgWNV0xCmwKuJGhwWoE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=uEBUumSQwUxDSX+8q4UuuyyDBmXgq/LhLCAnGxShgh7U/w3R+ccT2HASdO2Eu1+FK
         egKmBVbaY8z8XwyaTkCSIkG0RTlNZXoLM8ggrzI7pdxy7dgX/L6XmOI3xmssuNFJKU
         QUKAkN+jBHVX2OP1Bl7jNk6FhCJoKKRvB5Ltvdu11Nm0GfhHrtv29ceKc19m98t25t
         omwSrWlA9xL13qzZLaibbimIYj3UO19rlvyNIBo3NrZ8jzXmXPChJTcU5eaUjxZUDs
         Lbf249DI/LSXnj5Gi161tUBPKc8v5LQu11Ti6OyYMrN8EBdDHYF8nxxCcPXf24SV2M
         5K0RsrbrM6J0g==
Received: by mail-wm1-f70.google.com with SMTP id m15-20020a05600c3b0f00b003465ede5e04so1134437wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 23:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PdugAwOKj5OweNcK0/97VfSiKgWNV0xCmwKuJGhwWoE=;
        b=HKD/AliQYpx9hL1x3+rbvNmiOJsd0CM6FSVYWubggO6ilvAsrKaCwVBS7zPGSBvbVQ
         NZh49QKNWUSXSz9z3LQqT1dAAFOpwa+Uk/bB8xgpFtmyxFfPPFiOzr8Ytcg7z/OQ2269
         89AE9Pykc3XyBqo9BhtRyvt+aGnRAji+4uVgClFl2eYNeDTXc0QwI0NKm+eTLFIOe0v2
         Swu1tRLJeBZ3mi21gWlLDhZV0BopefuI7GgUtkUhzk4sYn/ci7G2A6ByIZWY8Sy4+Hi4
         w1A0SL0avns/ayVjeez6FA+szvFcMTuhuKqYAWeas5LI906NtToMQRCWzU0DVIvwl2TK
         BHew==
X-Gm-Message-State: AOAM530FemI2RMC/hnMxhxi+Jwm/u92kdv//jU2h9GpQtWaRoZVWJ59G
        nDrVZ/rhnM+JmlvozdfAeYCSrsMxaMiwStTotfO1gTCnP7Q9FObUghVXFsBWfX5xcy5O/i6ne0X
        8+ibHbcHxFYySNQlSXjGz/y4eFbchnxbahH5fSdmnMQ==
X-Received: by 2002:a05:600c:34c8:: with SMTP id d8mr10369563wmq.94.1641541654978;
        Thu, 06 Jan 2022 23:47:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBTfZa15VkS7xNqxo/0lg4qbFu1EvIdIy6O7U40/j2g0LzvxAKZFECt3AXaHWvqWXpOlO3KA==
X-Received: by 2002:a05:600c:34c8:: with SMTP id d8mr10369553wmq.94.1641541654841;
        Thu, 06 Jan 2022 23:47:34 -0800 (PST)
Received: from [192.168.1.126] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id w8sm1271049wrs.41.2022.01.06.23.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 23:47:34 -0800 (PST)
Message-ID: <66754058-187e-ffd5-71ba-4720101f5d98@canonical.com>
Date:   Fri, 7 Jan 2022 08:47:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFT][PATCH 3/3] arm64: dts: exynos: drop incorrectly placed
 wakeup interrupts in Exynos850
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
References: <20211230195325.328220-1-krzysztof.kozlowski@canonical.com>
 <20211230195325.328220-3-krzysztof.kozlowski@canonical.com>
 <CAPLW+4mDWg1xAGEALNVN1vs8jb3rzH2VqEBfacTkM_gNxeuhRg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAPLW+4mDWg1xAGEALNVN1vs8jb3rzH2VqEBfacTkM_gNxeuhRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2022 22:09, Sam Protsenko wrote:
> On Thu, 30 Dec 2021 at 21:53, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> The pin controller device node is expected to have one (optional)
>> interrupt.  Its pin banks capable of external interrupts, should define
>> interrupts for each pin, unless a muxed interrupt is used.
>>
>> Exynos850 defined the second part - interrupt for each pin in wake-up
>> pin controller - but also added these interrupts in main device node,
>> which is not correct.
>>
>> Fixes: e3493220fd3e ("arm64: dts: exynos: Add initial Exynos850 SoC support")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
> 
> Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> 
> Despite some errors brought by this change:
> 
>     samsung-pinctrl 11850000.pinctrl: irq number not available
>     samsung-pinctrl 11c30000.pinctrl: irq number not available
> 
> the interrupts seem to be functional still. Tested on E850-96 board,
> by pressing buttons connected to gpa0..gpa1, and checking
> /proc/interrupts info. I guess it's ok to merge this one as is, and
> then work further to fix the driver (or dts?) accordingly.
> 
> Also, I submitted related patch ("arm64: dts: exynos: Add missing gpm6
> and gpm7 nodes to Exynos850"), please take a look.
> 

Several Exynos850 pinctrl banks use exynos_eint_gpio_init, so they need
the interrupt property (for external interrupts). Otherwise external
GPIO interrupts won't work. The ones you checked, could be the external
wakeup interrupts which are not affected here.

This change seems wrong. Instead one interrupt should be left. However I
don't know which - should be described in reference manual in interrupt
sources.


Best regards,
Krzysztof
