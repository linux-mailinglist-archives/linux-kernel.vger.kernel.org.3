Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB5E478619
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhLQIV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:21:56 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38282
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230445AbhLQIVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:21:53 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0992F3F1F0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639729312;
        bh=xfmZvtdVL4Nqs/cnkKhKrTzxRXy+hfPyDSZiWdGZz7I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=O+2Fh4pgg1abeEQgpbwX+1/oXVJOXGZPzxQd5YZgvhXca3SKQ1TKZG4i2Um17Smga
         ZC9w9FrQpL975u3/wCHtHfd0+cyUvsKDYPfpCj8YqFIhSESlRzZ07Wr3sBtQ4M43PS
         1fioe8V7sFeHcSFp25mIyO5MeELG9KtbRFvCPbCYSSL3sqFk6z30sOW/cPfkI7j2ys
         8a9UfRiDl8L1h2rgH59yAhnqmajhG4LYiRPYWrYMAsWXhDFjJ48Ae8kx/BEFtFIFb9
         gBeRkPW7xPWabYvMUXa2lCwGNqRvCesf6+SXvOM6+FXXljXOUAaBnz5/8LcJe8+5x9
         lxQj4+0JBBpHA==
Received: by mail-lj1-f197.google.com with SMTP id b3-20020a2ebc03000000b0021ffe75b14cso343180ljf.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 00:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xfmZvtdVL4Nqs/cnkKhKrTzxRXy+hfPyDSZiWdGZz7I=;
        b=zwY4zcxOUCuUvz/1MmcGjJQb/e/3EoZhZ/Rw9fzRejmOjJU9+Pb5u4MRwcW7XnitLS
         AwZHgbhWJh9etuAxywWXEOiA3cGe0y0BKDxz1aMo6upQmYTdPwOT0Ug3u1y9acKaDKen
         SQzkRDq1m15ST8lE4DePx73i3P53G9ofL4BM3YHmzklqxf2+WBuYpG9TZ/TnutPByjOC
         Q8u5McO6ESrkLHQaHoJ7UN0MzNM0+HxxSgVlyOveRV5SUeFJs1FLxCobpjKL2ODxTOgE
         kvV6fMDmRo9T/wgG0xEVOMVVA926NkHWV1MgW28YUpiH1k3YKLbmoCMpQ67+QgWRIiIS
         y6GQ==
X-Gm-Message-State: AOAM531Stzkj+YEobTDuhXiQhUpFr5XI13XuYsGml6mQaJsFhjXr+s4W
        H2ni88olrlhU8MWkxvH4ZzBOBIjmyRpk5U10Xw4gCP9jPJF7K+KMzgA88w4x9nmf41BzbzP1HNW
        BERlh9eMjTnLhwyn/EchuAHurjkAZS3CNCgCTTim43g==
X-Received: by 2002:a05:6512:3c9e:: with SMTP id h30mr1919897lfv.212.1639729311038;
        Fri, 17 Dec 2021 00:21:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfMYzlQckD0Wb0EtQqx2AZ0wkcSDj7w3Z/nn8EeyMb/BCnVstW2Dbq/zvfD5jISNkS6mUEQA==
X-Received: by 2002:a05:6512:3c9e:: with SMTP id h30mr1919870lfv.212.1639729310766;
        Fri, 17 Dec 2021 00:21:50 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id a24sm119818lff.207.2021.12.17.00.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 00:21:49 -0800 (PST)
Message-ID: <73c5a527-2d5d-8524-b067-f9128055ff10@canonical.com>
Date:   Fri, 17 Dec 2021 09:21:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 6/7] arm64: dts: exynos: Add initial Exynos850 SoC support
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
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
 <20211215160906.17451-7-semen.protsenko@linaro.org>
 <8c1dbcda-ce01-81c9-b34a-f64b6f61c868@canonical.com>
 <CAPLW+4ndeokx3WiYaK_3ooe0J+BQe8Dx7QCecA7Deowk0AdxnA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAPLW+4ndeokx3WiYaK_3ooe0J+BQe8Dx7QCecA7Deowk0AdxnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2021 20:40, Sam Protsenko wrote:
> On Wed, 15 Dec 2021 at 18:47, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>

(...)

>>> +             serial0 = &serial_0;
>>> +             serial1 = &serial_1;
>>> +             serial2 = &serial_2;
>>> +             i2c0 = &i2c_0;
>>> +             i2c1 = &i2c_1;
>>> +             i2c2 = &i2c_2;
>>> +             i2c3 = &i2c_3;
>>> +             i2c4 = &i2c_4;
>>> +             i2c5 = &i2c_5;
>>> +             i2c6 = &i2c_6;
>>> +             i2c7 = &hsi2c_0;
>>> +             i2c8 = &hsi2c_1;
>>> +             i2c9 = &hsi2c_2;
>>> +             i2c10 = &hsi2c_3;
>>> +             i2c11 = &hsi2c_4;
>>> +     };
>>> +
>>> +     arm-pmu {
>>> +             compatible = "arm,cortex-a55-pmu";
>>> +             interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
>>> +                          <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
>>> +                          <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
>>> +                          <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
>>> +                          <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
>>> +                          <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
>>> +                          <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
>>> +                          <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
>>> +             interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
>>> +                                  <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
>>> +     };
>>> +
>>> +     /* Main system clock (XTCXO); external, must be 26 MHz */
>>> +     oscclk: clock-oscclk {
>>> +             compatible = "fixed-clock";
>>> +             clock-output-names = "oscclk";
>>> +             #clock-cells = <0>;
>>> +     };
>>> +
>>> +     /* RTC clock (XrtcXTI); external, must be 32.768 kHz */
>>
>> This clock is usually provided by PMIC, so instead I expect updating
>> s2mps11-clk driver. It's not correct to mock it with fixed-clock, but in
>> some cases might be needed. Then I would need an explanation and maybe a
>> TODO note.
>>
>> I wonder if we already discussed this...
>>
> 
> Don't really remember discussing that. That's actually something new
> for me :) I was planning to add PMIC support as a part of separate
> activity later, it might not be so easy: S2MPU12 uses I3C connection.
> And RTC clock is not handled even in downstream kernel. So I'll have
> to implement that by PMIC datasheet. I'll keep some TODO comment for
> now, hope it's ok with you?

Assuming it is really coming from the PMIC (should be visible in the
board schematics), it should be using s2mps11-clk. I am fine with
keeping fixed-clock now + TODO note, but please move it to the board
DTS. It's not the property of the SoC.

> 
>>> +     rtcclk: clock-rtcclk {> +               compatible = "fixed-clock";
>>> +             clock-output-names = "rtcclk";
>>> +             #clock-cells = <0>;
>>> +     };
>>> +


Best regards,
Krzysztof
