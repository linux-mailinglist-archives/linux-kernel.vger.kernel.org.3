Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3894610C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbhK2JHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:07:34 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59464
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240356AbhK2JFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:05:32 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC9323F1B9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638176534;
        bh=+klvKK+faRKLaDg9Hg7NVSa08prt4fM01iOQLi+L9zY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Fvs0Oylz5sN3CxTlVB19nDIygbjt1VhPj4sfK0ai86FDclSQT/nzTeV/CfgSy7XY8
         HeAP+T3CXyor+jmTCaaU77cNp9VNd2+d7AZC5/D7et8DBqV2icb8niDKvscQokPg43
         kXLZX1etipIkvhd4WKHwsRA44ev+vGWOnLtTvqpUdHcRWjfuLRlec+1pPasJ5OAtHK
         BaSkK0rGzigQG6mmcx7Qc/ruKm7wJjpLITIVBn4+STzpci+1WXguJVMNpP8G3hZi5M
         JPmohMEfRRqBV0WtptN6RD1TC+qlDdXbhG60oIwMr/8t8aC7nYsWtqHLyHtQ2x8z9V
         k+vc5kET3/K6Q==
Received: by mail-lj1-f198.google.com with SMTP id z18-20020a2e8e92000000b00218e583aff1so6534292ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 01:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+klvKK+faRKLaDg9Hg7NVSa08prt4fM01iOQLi+L9zY=;
        b=OvRAVEUERXX/lEY7g4jfkgQQRsCcz6aPLIRF/bNI0SPOK+h1HTZ7by09W2yugawGYN
         ccpAxItPtVirk4uYS7lcR9bF9NJHAoOmnsZ0S3DV2EpJqFNpvuxxsTeMtiNFTNgkr+nE
         Dzc1kcnQEDTif18Jcg/j8UAGKvGb6lwkkLvyYaayYCUiiI4qliyjmGyvCeZLvgZAw/J4
         pnGQFWYUHDrLK2MsUBwVWRtwVFo7trImvNVt17tV8QzueMoEGxlkMDy4JylMamf8e6x1
         i6IOifJBIYMYbuQmrNZpFRWgP4+QxLXbymyOqJFTaU/ahzqg6T1OWBEECjx243QVDRVZ
         aQ4A==
X-Gm-Message-State: AOAM530S2DMDrld3Vp08v8WX26rh/dMioEbYtVwGCBG5v1SLQgu0quxW
        qQkksGf1kGnaueu19CVLLkcB8CCXXFd8BMZl8MYfRfHauVKokgqFrura6RlCP4++mnRCgkm2rQ5
        O61bw/v4DTCRqMD5EH/LgM5hUURvG5msItZZ09SYAiA==
X-Received: by 2002:a2e:9c8:: with SMTP id 191mr51057822ljj.262.1638176533982;
        Mon, 29 Nov 2021 01:02:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfGeBl6B/J9dcWZ1YaA7JAygGQ1hd6YaFyoQjt6umkddkhFy1DycoprioX3nIn6ZG+Rj4h3Q==
X-Received: by 2002:a2e:9c8:: with SMTP id 191mr51057790ljj.262.1638176533695;
        Mon, 29 Nov 2021 01:02:13 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id f24sm1266012lfe.247.2021.11.29.01.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 01:02:13 -0800 (PST)
Message-ID: <1b55a6fb-1a23-1f50-9025-1b901ede70a8@canonical.com>
Date:   Mon, 29 Nov 2021 10:02:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 0/8] soc: samsung: Add USIv2 driver
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20211127223253.19098-1-semen.protsenko@linaro.org>
 <b9807fcc69713fb016838958a3df1c4e54309fc4.camel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <b9807fcc69713fb016838958a3df1c4e54309fc4.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2021 04:15, David Virag wrote:
> On Sun, 2021-11-28 at 00:32 +0200, Sam Protsenko wrote:
>> USIv2 IP-core provides selectable serial protocol (UART, SPI or
>> High-Speed I2C); only one can be chosen at a time. This series
>> implements USIv2 driver, which allows one to select particular USI
>> function in device tree, and also performs USI block initialization.
>>
>> With that driver implemented, it's not needed to do USI
>> initialization
>> in protocol drivers anymore, so that code is removed from the serial
>> driver.
>>
> 
> I think the downstream way of doing this (USI node reg being on the
> SW_CONF register itself rather than an offset from uart/i2c/spi, the
> USI driver only controlling the SW_CONF, and the uart/i2c/spi drivers
> controlling their USI_CON and USI_OPTION regs) is cleaner, better, and
> easier to adapt to USIv1 too.
> 
> For example: I'm sure this is the case on USIv2 devices too, but on
> Exynos7885, different devices have USI modes configured differently.
> For example a Samsung Galaxy A8 (2018) has all the USI blocks
> configured as SPI while a Samsung Galaxy M20 has the first USI
> configured as dual HSI2C, the second as HSI2C on the first 2 pins and
> the third as HSI2C on the last 2 pins. With this way of doing
> everything on USIv2 we'd need 3 disabled USIv2 nodes in the SoC DTSI
> for one USI block, each for every protocol the USI block can do, all
> having a single child for their protocol and each referencing the same
> sysreg (not even sure if that's even supported). Then the board DTS
> could enable the USI node it needs.

It's not supported (one cannot have three same nodes with same unit
addresses), so this would be solved by dropping out unused interfaces,
commenting them out or storing everything under one USI:

usi@0x1abcdef0 {
  serial@.... {
    status = "okay";
  }

  i2c@.... {
    status = "disabled";
  }

  spi@.... {
    status = "disabled";
  }
}

> 
> With the downstream way we could have just one USI node and we could
> add the 3 protocols it can do disabled as seperate or child nodes. This
> way the board DTS only needs to set the appropriate mode setting and
> enable the protocol it needs. I'd say much better than having 3 USI
> nodes for the same USI block.

Then however you need to handle probe ordering and possible probe deferrals.

> 
> Also this way is pretty USIv2 centric. Adding USIv1 support to this
> driver is difficult this way because of the the lack of USI_CON and
> USI_OPTION registers as a whole (so having nowhere to actually set the
> reg of the USI node to, as the only thing USIv1 has is the SW_CONF
> register). 

How is it difficult? Not having a register is easy - noop on given platform.

> In my opinion being able to use the same driver and same
> device tree layout for USIv1 and USIv2 is a definite plus
> 
> The only real drawback of that way is having to add code for USIv2
> inside the UART, HSI2C, and SPI drivers but in my opinion the benefits
> overweigh the drawbacks greatly. We could even make the uart/spi/hsi2c
> drivers call a helper function in the USI driver to set their USI_CON
> and USI_OPTION registers up so that code would be shared and not
> duplicated. Wether this patch gets applied like this is not my choice
> though, I'll let the people responsible decide
> :-)
> 
> Anyways, soon enough I can write an USIv1 driver after I submit all the
> 7885 stuff I'm working on currently. If you want to, you can add USIv2
> support to that driver, or if an USIv2 driver is already in upstream at
> that point, if it is written in the downstream way I can add v1 support
> to that, or if it's like this I'll have to make a whole seperate driver
> with a whole seperate DT structure.
> 
> Best regards,
> David
> 


Best regards,
Krzysztof
