Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150EA5958B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiHPKnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbiHPKmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:42:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B420D3F307
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:00:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r17so14208564lfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=NiqjZdaElPv0Moy0J0kc1e2plbktdvmbHILgFoEtkN0=;
        b=x+JEVq67Pgxsj6flc0kjfjNPIoXYPrJNovtiA9koO4BMEsg4+opIi+s1y1obKFPI9Q
         RAhO2dGD0vie3y2wBj+L5ti5PrJwBP48GbOXQrtaFWgVQdldzlnpxojBkSVzq85hskGd
         OT+QLlaw4f42MQUb+TSMvufxU+JEtSM0StxGuRV9CZSpsV4qpTecwCxOlF1H5ZC1zSL8
         kqZ/nkA0UK5kZJseHHUJ7+8MP4ILZeWa9jdLkBbTmFzE4nzQ386JMPXIm45QjKxku9P4
         DRmeQJkWUaxEYMzqA2ognq9H6iNVrD47ZUJOn5RV/YFoz52MYTgr8IyYQuYXtbahOg6F
         jlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=NiqjZdaElPv0Moy0J0kc1e2plbktdvmbHILgFoEtkN0=;
        b=nHomgZS5ew64xFfkYljNx/V7/a+A4sB+DPukNfjaPF+T+Zq+u6xyh5LSz2e3wsV184
         YIUc59d2+4CYx+KLDFcnY1bHe3s29Ibb+3z8+llQ/mj3Jp6HpUR+HZ6sULKx+WM3nMsa
         nQPTe8Mg12WswdxbY7sddRnks6R4K1OZilXoXOFzvZkgfTRMWmJg/Q3LxXAKDa6DsgS/
         fZW4du7o3iRTb2HR4HA7ezef1IonUrjYvDnbuzLeUjS0ZfjFMBa/eDmOYNbFd1FqtQCK
         ogg23sNnKhLr2i6TzZRwQaAEzbqzVUAew+pEteNUD8h76w09uMs8QwqW2UIXbsgrtWIo
         LFOg==
X-Gm-Message-State: ACgBeo0h65oCeuvz1j3z7JkOV1nS0vq5o0WHZXJ8oDxq3fRRfae3+9cN
        +hlw5uUdMPtZk4q93b5cs0+3vA==
X-Google-Smtp-Source: AA6agR5J9MnoK1JzNnr2RzzIi4yHAdEmc5+JM9mzKRac2egPPP/6bbZQLUoxHKb/IDwxVOf9+ki2YA==
X-Received: by 2002:a05:6512:3c93:b0:48c:dc60:4786 with SMTP id h19-20020a0565123c9300b0048cdc604786mr6701452lfv.208.1660644036069;
        Tue, 16 Aug 2022 03:00:36 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id c7-20020a056512324700b0048b01bd4dbasm1333291lfr.307.2022.08.16.03.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 03:00:35 -0700 (PDT)
Message-ID: <aca7a302-0f90-3164-9574-0bf0e613a2e2@linaro.org>
Date:   Tue, 16 Aug 2022 13:00:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/4] regulator: dt-bindings: Add Allwinner D1 LDOs
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220815043436.20170-1-samuel@sholland.org>
 <20220815043436.20170-2-samuel@sholland.org> <4371868.Wku2Vz74k6@diego>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4371868.Wku2Vz74k6@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 18:32, Heiko Stübner wrote:
> Am Montag, 15. August 2022, 06:34:32 CEST schrieb Samuel Holland:
>> The Allwinner D1 SoC contains two pairs of in-package LDOs. One pair is
>> for general purpose use. LDOA generally powers the board's 1.8 V rail.
>> LDOB generally powers the in-package DRAM, where applicable.
>>
>> The other pair of LDOs powers the analog power domains inside the SoC,
>> including the audio codec, thermal sensor, and ADCs. These LDOs require
>> a 0.9 V bandgap voltage reference. The calibration value for the voltage
>> reference is stored in an eFuse, accessed via an NVMEM cell.
>>
>> Neither LDO control register is in its own MMIO range; instead, each
>> regulator device relies on a regmap/syscon exported by its parent.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>> Changes in v3:
>>  - Add "reg" property to bindings
>>  - Add "unevaluatedProperties: true" to regulator nodes
>>  - Minor changes to regulator node name patterns
>>  - Remove system-ldos example (now added in patch 3)
>>
>> Changes in v2:
>>  - Remove syscon property from bindings
>>  - Update binding examples to fix warnings and provide context
>>
>>  .../allwinner,sun20i-d1-analog-ldos.yaml      | 74 +++++++++++++++++++
>>  .../allwinner,sun20i-d1-system-ldos.yaml      | 37 ++++++++++
>>  2 files changed, 111 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
>>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
>> new file mode 100644
>> index 000000000000..d6964b44ef21
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
>> @@ -0,0 +1,74 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-analog-ldos.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Allwinner D1 Analog LDOs
>> +
>> +description:
>> +  Allwinner D1 contains a set of LDOs which are designed to supply analog power
>> +  inside and outside the SoC. They are controlled by a register within the audio
>> +  codec MMIO space, but which is not part of the audio codec clock/reset domain.
>> +
>> +maintainers:
>> +  - Samuel Holland <samuel@sholland.org>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - allwinner,sun20i-d1-analog-ldos
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  nvmem-cells:
>> +    items:
>> +      - description: NVMEM cell for the calibrated bandgap reference trim value
>> +
>> +  nvmem-cell-names:
>> +    items:
>> +      - const: bg_trim
> 
> aren't dashes "-" preferred over underscores "_" in
> string names?
> 
> Maybe even make this "bandgap-trim" for a bit more
> explanatory naming?

In node names yes. In strings, I think there is no preference. At least
I am not aware of it.

Best regards,
Krzysztof
