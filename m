Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE2348F78E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 16:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiAOPqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 10:46:15 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34558
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231264AbiAOPqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 10:46:15 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 68D213F1E1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642261568;
        bh=IwcThkHD1M745uJYhI7iaznT2u01Lps6VJrALSxU+Rk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=NxR/xxcZv2n1kUXvODvOxk9e7cdCJaeVBrs02WtaTXUHMTh9Vav0HgadvGNvacRSI
         Wpn9HbwN8DOn3WXFkPMMGDt+JUbx82PCh9uXK8NFJfMO6TdUu8RdtFLIu7OIUmln/q
         rWgm+xsP71ghBGNPg1oPKyjtneqm+7GZcb2pPsJlalMECOpfS9kc/x+ogGIBzsF39c
         JQI6TdnkTG5zsYXbXnz0tfw43lM57RuZix8m3zseBxpqHDs1nIhhnappDZYl3VziLi
         cOAQHvIHOIz4H/NZLzfI8I02lJ5fAKUAua6Hh7exWDolHSNc9fmUzag3ied8TRjm8q
         O3ZYItVZPwKNg==
Received: by mail-wm1-f70.google.com with SMTP id w5-20020a1cf605000000b0034b8cb1f55eso1057822wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 07:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IwcThkHD1M745uJYhI7iaznT2u01Lps6VJrALSxU+Rk=;
        b=M+dBeEWHvvh0yFSipxLTZO+OCpxW0CvbPOEMLKJYv/IwLJ/Jq7PSiA/O/ShHHaB8hF
         Z7S6+5V/swVboIAngpOfmR1Dqq4UdZ2p/RuYzBIQ11PpPd4hhfZ2fmLPU3kVmvbwFkWG
         9vLi57eQsZIGVAEi8imvCZjGaaoAqCja92PrsPJRVN+5cKfXdlJdr0a+HmBQZ2vSjLFn
         x61uQiIxbZPP/dxTaKgZzUytoNcTwDAoYTC3/ChD5k27heI2iW1JMaQ/UaqwZ2KmfTKD
         copkHXhj8n5ysnnrBhQFkchksGqBpl9TELFDkIzCiv+nairWThrY2aTiZQZbO7jbonMo
         m9kw==
X-Gm-Message-State: AOAM532iRbwplpD4sCIvgCkvEIbw80lBYZR5i2whBFSqvGfxiKur5JO+
        WQ+fmcKqjkPx73cTrNtwTM7WMQ8GzOSCHLltW35eHeYx+czGB/xSEW/a91EZRUQv/lTmd/9eY2E
        HiUR5vxn6hzwtnqFRoubAuX2ok7xT736Nq2CxWMVTeQ==
X-Received: by 2002:a05:600c:1d06:: with SMTP id l6mr10253010wms.174.1642261567816;
        Sat, 15 Jan 2022 07:46:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBbL9obDsMaUtfq0uDglT/AgPjn7nbgQzf/iMd3w1K/WEY44FZfb/7Q/pgfge3Qa3cELlqnQ==
X-Received: by 2002:a05:600c:1d06:: with SMTP id l6mr10252993wms.174.1642261567624;
        Sat, 15 Jan 2022 07:46:07 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id l25sm8156419wmh.18.2022.01.15.07.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 07:46:07 -0800 (PST)
Message-ID: <1a09cd4e-71da-43e6-9732-33d704e1744e@canonical.com>
Date:   Sat, 15 Jan 2022 16:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: Exynos850 and ExynosAuto v9 pinctrl wakeup muxed interrupt
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Chanho Park <chanho61.park@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
References: <3c0087a9-5c3b-d665-136e-6110a0482775@canonical.com>
 <CAPLW+4nrPKA66GrF4XukyHWHJ=wBycjyK3ZPLCofEFe-VJ9wWg@mail.gmail.com>
 <06320ea8-9297-1e90-dafd-978f73c22fff@canonical.com>
 <CAPLW+4=xD5hM_tYDD+kwqkiVq5h0tjO+7q6Akbd6iO_Ou-g=0A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAPLW+4=xD5hM_tYDD+kwqkiVq5h0tjO+7q6Akbd6iO_Ou-g=0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 21:32, Sam Protsenko wrote:
> On Fri, 7 Jan 2022 at 10:16, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 03/01/2022 21:59, Sam Protsenko wrote:
>>> On Thu, 30 Dec 2021 at 21:34, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@canonical.com> wrote:
>>>>
>>>> Hi Chanho and Sam,
>>>>
>>>> I am slowly finishing dtschema for Samsung pinctrl drivers [1] and I
>>>> noticed that Exynos850 and Auto v9 do not define interrupt in pinctrl
>>>> node with: wakeup-interrupt-controller. This is an interrupt muxing
>>>> several external wakeup interrupts, e.g. EINT16 - EINT31.
>>>>
>>>> For Exynos5433 this looks like:
>>>> https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/exynos/exynos5433.dtsi#L857
>>>>
>>>> Missing muxed interrupt for Exynos850 and Autov9 might be fine, although
>>>> you should see in dmesg error log like:
>>>>     "irq number for muxed EINTs not found"
>>>>
>>>> Can you check that your wakeup-interrupt-controller is properly defined
>>>> in DTSI? If yes, I will need to include such differences in the dtschema.
>>>>
>>>
>>> In case of Exynos850, no muxed interrupts exist for wakeup GPIO
>>> domains. Basically, "pinctrl_alive" and "pinctrl_cmgp" domains are
>>> wake-up capable, and they have dedicated interrupt for each particular
>>> GPIO pin. All those interrupts are defined in exynos850-pinctrl.dtsi
>>> file, in next nodes:
>>>   - pinctrl_alive: gpa0..gpa4 (interrupt numbers 1..36)
>>>   - pinctrl_cmgp: gpm0..gpm7 (interrupt numbers 39..46)
>>>
>>> All mentioned interrupts are wakeup interrupts, and there are no muxed
>>> ones. So it seems like it's not possible to specify "interrupts"
>>> property in pinctrl nodes with wakeup-interrupt-controller. The PM is
>>> not enabled in Exynos850 platform yet, so I can't really test if
>>> interrupts I mentioned are able to wake up the system.
>>
>> Thanks for confirming, I'll adjust the schema.
>>
>>>
>>> After adding this patch ("arm64: dts: exynos: Add missing gpm6 and
>>> gpm7 nodes to Exynos850"), I can't see this error message anymore:
>>>
>>>     samsung-pinctrl 11c30000.pinctrl: irq number for muxed EINTs not found
>>>
>>> That's because exynos_eint_wkup_init() function exits in this check:
>>>
>>>     if (!muxed_banks) {
>>>         of_node_put(wkup_np);
>>>         return 0;
>>>     }
>>>
>>> But I actually can see another error message, printed in
>>> exynos_eint_gpio_init() function (for wake-up capable pinctrl nodes,
>>> because those nodes don't have "interrupts" property now -- you
>>> removed those in your patch):
>>>
>>>     samsung-pinctrl 11850000.pinctrl: irq number not available
>>>     samsung-pinctrl 11c30000.pinctrl: irq number not available
>>>
>>> which in turn leads to exynos_eint_gpio_init() function to exit with
>>> -EINVAL code in the very beginning, and I'm not sure if it's ok? As I
>>> said, those errors only appear after your patch ("arm64: dts: exynos:
>>> drop incorrectly placed wakeup interrupts in Exynos850").
>>
>> Yeah, I replied to this next to my patch. I think my patch was not
>> correct and you need one - exactly one - interrupt for regular GPIO
>> interrupts.
>>
> 
> I just need to remove ".eint_gpio_init" in exynos850_pin_ctrl[] for
> pinctrl_alive and pinctrl_gpmc. Those already have ".eint_wkup_init",
> which is enough to handle all interrupts (per-pin). GPIO_ALIVE and
> GPIO_GPMC lack EINT capabilities: judging from TRM, there are no EINT
> interrupts (like EINT_SVC, which is accessed in EINT ISR), and there
> are no EINT interrupts wired to GIC (like INTREQ__GPIO_ALIVE or
> INTREQ__GPIO_GPMC). With removed ".eint_gpio_init", I can see in
> "/proc/interrupts" that corresponding interrupts are still handled
> properly (because of .eint_wkup_init), and the error message is gone.

This would mean that my dts patch removing all interrupts for alive and
cmgp was correct:
https://lore.kernel.org/linux-samsung-soc/66754058-187e-ffd5-71ba-4720101f5d98@canonical.com/T/#mf0b06ebdac554d57d8230dc546c3d57d59d7bd6b
Was it?

> Will send the patch soon -- please add it to the beginning of your
> series along with my other patch I already submitted.

Sure.





Best regards,
Krzysztof
