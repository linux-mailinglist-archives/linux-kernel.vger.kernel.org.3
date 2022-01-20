Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779F349485B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359039AbiATHgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:36:11 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34402
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359036AbiATHgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:36:07 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 634D740049
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642664166;
        bh=zhYn8boZjrSS5W0P+2ZuZiKfL1ZEsv8IDdezIAswal4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=E+FTgTdnm6O2/xXog9zJcp8hgqw/8BUE5rkKp8Rz2iyysKy2o52c5TPbT3K1WmiWb
         btlPRcm0stbLYoPICcYS+uB6xB6i+yM4BdaV3YV4tjl+HftejxO9CObE6M+b1IMlKl
         AywmGGpJc29aD3IlfyiOeRBKarD06vXEsNsvc2wwQ4vMOMaMQ+PSnprC6b0Y9dM+3Z
         U+A9elBmG61OyJwSfpOiL9dX5SHcJGD6s8U+bHkEnL1f0AwEwBeBt92GoeOo9Aob8Q
         uRM3EQ7py5Y/zb20mPswssZlJUFxOn1ffYyKhnJdzal8GXD3nszPbeBD4XPJQeDdwE
         Bp65bleQ9gdZw==
Received: by mail-ed1-f72.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso3927613edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 23:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zhYn8boZjrSS5W0P+2ZuZiKfL1ZEsv8IDdezIAswal4=;
        b=hVR9Q719sRQzuBlNtiOz+mpwdepi7ZFmyPqotYB08Lt5zfj5wV5/hNpH2G9X4tD351
         5gkMpSefObxgGr2ZCC8DYifo3b1eUCDwdHhQ/qkoeMDHuuBdqoae1Y0czQgId4Z25bIE
         fwXiXhlsTrnmsJaqaseVaGEw2hbM2hVPpXptEjmiW9AAs4YVZ67pH7d0F4Gxj9fus1T5
         rb0hE7kV8hZg9Kd7Sek66to1eSbGrKEXAbGdOFyMKsL6taliWZ05Oy7dXHV7zW2obp1C
         myCinXQuVMpv7sve31fY9yBvVVmXCN6L00Wsla49bzJYCYkBLSaHkIzwsbTqYkPsju7n
         NLLg==
X-Gm-Message-State: AOAM531dpO+jlzZNcyASXZrtmHFVryhbeRDO4yGZDu+LsmTupTxQjN4X
        ge/mkMQNy7dat49cQ7Zpj6S2Q7K3Fuuh5KrQFNGgSYZUpJ2SJ5jpd3UEIIVxgp/7d7TXQ6ANl8Z
        pT6t6TUHIY3xpI0BCcDuQ+HEFf1wqw9k2y3kTf7oCUA==
X-Received: by 2002:a50:cc47:: with SMTP id n7mr35474292edi.12.1642664165700;
        Wed, 19 Jan 2022 23:36:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRo4NxIGorVtNdob0Lm6QIN6OP4s0aOpoSNREkcHOOEBwGNSi+1C/m3PhCGISP9/C0vDH51Q==
X-Received: by 2002:a50:cc47:: with SMTP id n7mr35474270edi.12.1642664165509;
        Wed, 19 Jan 2022 23:36:05 -0800 (PST)
Received: from [192.168.0.45] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g27sm878115edj.79.2022.01.19.23.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 23:36:04 -0800 (PST)
Message-ID: <0c0a22ed-2c4b-374c-4f4c-06afd4e8681d@canonical.com>
Date:   Thu, 20 Jan 2022 08:36:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 2/4] spi: dt-bindings: samsung: convert to dtschema
Content-Language: en-US
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sam Protsenko <semen.protsenko@linaro.org>
References: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
 <20220112100046.68068-3-krzysztof.kozlowski@canonical.com>
 <20220119192758.z3lvlkaeyeiqi73a@ti.com>
 <5f912896-0635-fbe7-4fda-f4cb569190d9@canonical.com>
 <20220120070620.wyeosdstbfcsaplt@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220120070620.wyeosdstbfcsaplt@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2022 08:06, Pratyush Yadav wrote:
> On 19/01/22 08:49PM, Krzysztof Kozlowski wrote:
>> On 19/01/2022 20:31, Pratyush Yadav wrote:
>>> On 12/01/22 11:00AM, Krzysztof Kozlowski wrote:
>>>> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
>>>> controller bindings to DT schema format
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
>>>> ---
>>>>  .../spi/samsung,spi-peripheral-props.yaml     |  35 ++++
>>>>  .../devicetree/bindings/spi/samsung,spi.yaml  | 187 ++++++++++++++++++
>>>>  .../bindings/spi/spi-peripheral-props.yaml    |   1 +
>>>>  .../devicetree/bindings/spi/spi-samsung.txt   | 122 ------------
>>>>  MAINTAINERS                                   |   2 +-
>>>>  5 files changed, 224 insertions(+), 123 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
>>>>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
>>>>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
>>>> new file mode 100644
>>>> index 000000000000..aa5a1f48494b
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
>>>> @@ -0,0 +1,35 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/spi/samsung,spi-peripheral-props.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Peripheral-specific properties for Samsung S3C/S5P/Exynos SoC SPI controller
>>>> +
>>>> +maintainers:
>>>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> +
>>>> +description:
>>>> +  See spi-peripheral-props.yaml for more info.
>>>> +
>>>> +properties:
>>>> +  controller-data:
>>>> +    type: object
>>>> +    additionalProperties: false
>>>> +
>>>> +    properties:
>>>> +      samsung,spi-feedback-delay:
>>>> +        description: |
>>>> +          The sampling phase shift to be applied on the miso line (to account
>>>> +          for any lag in the miso line). Valid values:
>>>> +           - 0: No phase shift.
>>>> +           - 1: 90 degree phase shift sampling.
>>>> +           - 2: 180 degree phase shift sampling.
>>>> +           - 3: 270 degree phase shift sampling.
>>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>>> +        enum: [0, 1, 2, 3]
>>>> +
>>>> +    required:
>>>> +      - samsung,spi-feedback-delay
>>>
>>> I am not quite sure if this required would work here. Let's say another 
>>> controller also uses a controller-data node, but it contains a different 
>>> set of properties. Won't this cause an error to be raised for that 
>>> controller since this property is not there?
>>
>> The controller-data is Samsung SPI specific (does not exist in any other
>> binding), so why would controller-data get added to a different controller?
> 
> It does not as of now, but the name is fairly generic and some 
> controller in the future might use it. I do not think it is a good idea 
> to list required properties in X-peripheral-props.yaml in general since 
> all those will be collected by spi-peripheral-props.yaml and so will 
> apply to _all_ controllers that reference it.

Right, but have in mind this is merely a bindings conversion. These were
made like this long time ago.

I think we can drop the "required:" entirely with the commit 3/4 which
makes it optional.



Best regards,
Krzysztof
