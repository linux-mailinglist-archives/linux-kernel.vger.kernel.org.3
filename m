Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE97449C628
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbiAZJTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:19:44 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46998
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238978AbiAZJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:19:42 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9CB183F1C2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643188780;
        bh=pBqXXr3PeJ7ykOBVowRPGxEs/0VxNU9EERyHzmf0x6M=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=EfX9r4op6weVIEDsPKAY1RW8BlvGMMde9jR66SWJbHnrY2GaqrMPjJt9wfU2aHmsQ
         +noU71vtCyHrxLlPuuuSTh1Qel5pmmBkMr78L0/auNLMjMZiSBKIC08WN4MplQetN/
         dVGy+TcAEYpho7X5k6TbkvGO9NdG3BNVN6QQS/e5x6XZfEuo2eX0BELDTag5dVGCRX
         Ry1Xr7b7WWJj4qA0cnEu5AUNvVdroOXkshA0VM3ML7l9L712N4xQnlCfBt4Gu7ZSiT
         tmdorWyYIzlJVhS6mDgsiQ0/o2MDxvYaIwwUiVf5y3W5fI9JBwuj+e9I36b9HCN10t
         HUWi59QaaRvng==
Received: by mail-wr1-f70.google.com with SMTP id o26-20020adfa11a000000b001dd1d3a73c7so1580068wro.21
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pBqXXr3PeJ7ykOBVowRPGxEs/0VxNU9EERyHzmf0x6M=;
        b=e1Pn41HAqOTCV9IS4caDhZFZNwQhjEpeXItDMIK+dvBjJuiYeoOWE8GZ5Lxf8bYLjt
         9LDdvtClBfH/6ZrhnbYHqx4y1CGCFTmpZJsKUxF8bSqfMxovDLpqtrEy9kOZa9SfgJo4
         +r4v4I5aS/fKfqzVYaRadpja6GWCF5bbWqav+WHqf1NZ0ms4q5N6ueExYzqCSMrfC4Xh
         HvfQnI5HU+uIsF7qSBElmP4KZebCNPhawQ+TWf+Us9DRtLBuwmXyN14NQAlY4hocuB3q
         QOXy1u4fUaQOpjj2zYnAyrwkFrZnxac0epLL9e9/KVKnr56Gfr3Gl2/QU3KQlt5usD0k
         Njzg==
X-Gm-Message-State: AOAM532fX7D/Vk6x/P+Oq01yxrNtgOiATMA7X/jo2rGG6o7HFAvDW8do
        l8qNj+7SacaNjsHkeC90E7H/qJ4H2CAD8wYMkolT5F+jplHbWrXOqyU2lKvz3ek9v76Pny6tK/1
        Kt4VIdmuo762AHPYs7TdkKFATZpgbuVxVE916gnbhWQ==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr21742769wrn.147.1643188778786;
        Wed, 26 Jan 2022 01:19:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEP5/lu7fbvZTNXya5lAtVgrXBoVxZH1tRfgYLoGaoAPtg9tM6DO08WcYy4M6fXSv2af6NTA==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr21742754wrn.147.1643188778608;
        Wed, 26 Jan 2022 01:19:38 -0800 (PST)
Received: from [192.168.0.60] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id j2sm3230420wms.2.2022.01.26.01.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 01:19:38 -0800 (PST)
Message-ID: <4c029f92-ece7-78c1-e64b-cbe438b45a5f@canonical.com>
Date:   Wed, 26 Jan 2022 10:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 00/16] Add support for Tesla Full Self-Driving (FSD)
 SoC
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        sboyd@kernel.org
References: <CGME20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b@epcas5p2.samsung.com>
 <20220124141644.71052-1-alim.akhtar@samsung.com>
 <d9682f16-13b7-b6dc-5afd-b2d319143de5@canonical.com>
 <4cfcde38-50cb-646a-0d17-c2cb2977a2e4@canonical.com>
 <063501d81281$10e5b3c0$32b11b40$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <063501d81281$10e5b3c0$32b11b40$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2022 07:50, Alim Akhtar wrote:
> Hi Krzysztof
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>> Sent: Tuesday, January 25, 2022 10:56 PM
>> To: Alim Akhtar <alim.akhtar@samsung.com>; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Cc: soc@kernel.org; linux-clk@vger.kernel.org; devicetree@vger.kernel.org;
>> olof@lixom.net; arnd@arndb.de; linus.walleij@linaro.org;
>> catalin.marinas@arm.com; robh+dt@kernel.org; s.nawrocki@samsung.com;
>> linux-samsung-soc@vger.kernel.org; pankaj.dubey@samsung.com;
>> sboyd@kernel.org
>> Subject: Re: [PATCH v5 00/16] Add support for Tesla Full Self-Driving (FSD) SoC
>>
>> On 25/01/2022 18:12, Krzysztof Kozlowski wrote:
>>> On 24/01/2022 15:16, Alim Akhtar wrote:
>>>> Adds basic support for the Tesla Full Self-Driving (FSD) SoC. This
>>>> SoC contains three clusters of four Cortex-A72 CPUs, as well as
>>>> several IPs.
>>>>
>>>> Patches 1 to 9 provide support for the clock controller (which is
>>>> designed similarly to Exynos SoCs).
>>>>
>>>> The remaining changes provide pinmux support, initial device tree support.
>>>>
>>>> - Changes since v4
>>>> * fixed 'make dtbs_check' warnings on patch 14/16
>>>>
>>>> - Changes since v3
>>>> * Addressed Stefen's review comments on patch 14/16
>>>> * Fixed kernel test robot warning on patch 04/16
>>>> * rebsaed this series on Krzysztof's pinmux new binding schema work
>>>> [1]
>>>>
>>>> - Changes since v2
>>>> * Addressed Krzysztof's and Stephen's review comments
>>>> * Added Reviewed-by and Acked-by tags
>>>> * Rebased on next-20220120
>>>>
>>>> - Changes since v1
>>>> * fixed make dt_binding_check error as pointed by Rob
>>>> * Addressed Krzysztof's and Rob's review comments
>>>> * Added Reviewed-by and Acked-by tags
>>>> * Dropped SPI, MCT and ADC from this series (to be posted in small
>>>> sets)
>>>>
>>>> NOTE: These patches are based on Krzysztof's pinmux for-next branch
>>>> commit 832ae134ccc1 ("pinctrl: samsung: add support for Exynos850 and
>>>> ExynosAutov9 wake-ups") [1]
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git/l
>>>> og/?h=for-next
>>>>
>>>>
>>>
>>> Thanks, applied DTS/soc and pinctrl patches.
>>>
>>> I expect Sylwester will pick up the clock ones. Otherwise please let
>>> me know to pick it up as well.
>>
>> I forgot that clock macros are used in DTS. This does not compile and I cannot
>> take drivers into DTS branch.
>>
>> Alim,
>> DTS changes dropped. Please resend with the same trick we did for
>> Exynos850 board - hard-coded clock IDs as defines. See:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/diff/arch/arm6
>> 4/boot/dts/exynos/exynos850.dtsi?h=samsung-dt64-5.17-
>> 2&id=e3493220fd3e474abcdcefbe14fb60485097ce06
>>
> Ok, I will resend patch 14 and 15 (DTS changes) only as suggested above.

I see Sylwester acked clock patches, so I will take them. No need to
resend, I'll organize the patches so they will compile.


Best regards,
Krzysztof
