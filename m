Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EB8475D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244458AbhLOQW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:22:26 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55248
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239539AbhLOQWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:22:24 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E17FD3F1D7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639585343;
        bh=Z23gqncjXTDma3MAGbF/ABiF38CqvJFbYLGLj7MCGK4=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=uZCNW0b5LE2n7T0TvqhLYKjPjidHZyWTMF/UaYtUT7nz9poX/jeUXLfmikyEydq6t
         d4taU0KpA8ZRplyJOLglS7lAsqgFUJodS78RFjpzaRZqYj+tGcQKJbh2m2s3myczG6
         VzmZpiDPaYOAmp1bC13c/a2GHaZamGpVC5PNZxeHgTm8SgrubJTWmi+gp0Wx0ugiai
         6NLAa8hHgrhql6bTnA6oCN0BeXrv9vcLU8B4s3LlmlOBwcP4I2ZquSUHfMxpM0uDI2
         Ljs9mWJInWbO36RHe7J6F2oD7G3rowK3n4O6rclE6lyOrrUH/10Nk8uB3azqYJliH0
         Raj+uy07+Fiyw==
Received: by mail-lf1-f71.google.com with SMTP id d2-20020a0565123d0200b0040370d0d2fbso9804584lfv.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Z23gqncjXTDma3MAGbF/ABiF38CqvJFbYLGLj7MCGK4=;
        b=qWpVDuB2NA3P3VZBsdHdUFNFbJ83chAW3nSPj9Sn5UzFtB8Wb8dh+ZOFGHDYK2TnCX
         Pp9Jgnd7XiGF3rc4YobuJ2bveHA/n8P/VL+wFTP9UjbmbZ0dN+ekIiWgAtCvCxiHMJHb
         deGbM55ZTXLRCObpvChXWSgQ36LtskzlduRITjMnJs1r8g0eaR77xbwLXg3yRXQ1635r
         xmqmIHwbW24fDtoSHsIca5H5EbI52seghGrV2XfWoxyH6FWaUcOcPjixTQRvMeVVJS6E
         Ams/ToOhJh5CuMeIz2aAvzYcFAqhYcIN5MvYikcwVn4omgrhdzDVjNtf0LQ5QDtWGspg
         99eA==
X-Gm-Message-State: AOAM531gPljmb3Oz+dVFGz9dGNdwRBjjM6UneHn448abM+LzBjVMgdr6
        kAS9z24ynr4T5rwkX2woV+CNeXN7ssr3ri1x9VKzL0y8bjmovNHnY2pb/V+qr/qkrIwIfa0Xf3T
        Cp4GEHSYsNeJ5DYaD/f02V6RjDbL6caQVyhqhnuyG1w==
X-Received: by 2002:a05:6512:487:: with SMTP id v7mr10206225lfq.386.1639585343419;
        Wed, 15 Dec 2021 08:22:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9qgUSsoTZTEVQwfLvYImmD5LtPngqbyyxLpVI0FQzdKit4LPRNPEyh4OhT5jRHrAxhd9mLg==
X-Received: by 2002:a05:6512:487:: with SMTP id v7mr10206167lfq.386.1639585342645;
        Wed, 15 Dec 2021 08:22:22 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id b13sm388572lfv.200.2021.12.15.08.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 08:22:22 -0800 (PST)
Message-ID: <77ab7341-2311-da24-1128-b5775a71db1c@canonical.com>
Date:   Wed, 15 Dec 2021 17:22:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 4/7] dt-bindings: arm: samsung: Document E850-96 board
 binding
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
 <20211215160906.17451-5-semen.protsenko@linaro.org>
 <55294fa1-9988-5c10-1fc1-c33f3ec9b231@canonical.com>
In-Reply-To: <55294fa1-9988-5c10-1fc1-c33f3ec9b231@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2021 17:14, Krzysztof Kozlowski wrote:
> On 15/12/2021 17:09, Sam Protsenko wrote:
>> Add binding for the WinLink E850-96 board, which is based on Samsung
>> Exynos850 SoC.
>>
>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>> ---
>>  .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
>> index ef6dc14be4b5..00f122197476 100644
>> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
>> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
>> @@ -205,6 +205,12 @@ properties:
>>                - samsung,exynosautov9-sadk   # Samsung Exynos Auto v9 SADK
>>            - const: samsung,exynosautov9
>>  
>> +      - description: Exynos850 based boards
>> +        items:
>> +          - enum:
>> +              - winlink,e850-96                 # WinLink E850-96
>> +          - const: samsung,exynos850
>> +
> 
> Add it before Exynos Auto v9 entry, please.
> 

And also rebase on my latest for-next - I just applied conflicting
change for Exynos7885 boards.


Best regards,
Krzysztof
