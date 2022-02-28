Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4604C701D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiB1Oyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiB1Oyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:54:43 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02379424A6;
        Mon, 28 Feb 2022 06:54:05 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso18941234ooc.12;
        Mon, 28 Feb 2022 06:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=2NpcbtVausRghlc2AF5Qk8ViAeV3CmmMKoQv0S/ZKco=;
        b=e4hQZRDoDSvjOTGyDC3NZH8J2agWHdGzO/Ys1xnWTiuprlAxF6MwS+woRFaG9MeigN
         74c/cdJVK4s2CZfcgu9MFw9a9gaPcrL8kYRI8b2u2YBgzA8VSDGT2cOoqQCIFGZ/Zx+J
         3ocQ22ZXwdjF69EQVwhDL5f+jD5T4hWUGtcxhk5OxuCOryzJWuB9tIuEV8qsW0FRUV+c
         7kU7bUYmixGQAhcoOMyj9XhAzcyYrSEnxcdmyZDjULb4/ztsTAKP+IuuP8Y7AgZm8rHd
         PE3Z8adfBcg19EdC6wETI5E+l3l5Bv1HG5/U0I0Hx9S9yKkP2VlXFfXQlhzxPDC78k65
         Lv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=2NpcbtVausRghlc2AF5Qk8ViAeV3CmmMKoQv0S/ZKco=;
        b=4OG8VZ29oP1rZQQVyHM2CBDMT+mbKnBRjPUoRGWf+IgVk0F1KIPFrAGgTwrHMJ88eL
         C1Q+WGCsRRHDfX02/ovQmXs4/ovtgEuDvC4JEcqTYLoq/aOIGVBzPZgc5Fh3rbd+0nPR
         37NCUtZ4iHql0+YGStyG7LCQibsCgl9y0+p5R843Q487QyocfM24Z3xQ/Ior+wl/UTGg
         IWnPfus7+HXbV0ardCrvgdITSMqAguC2M9Lr+LEK6VGCjMXhUBSFhnWvRd9A+izK/Y1e
         A9Qf1/3/68DTxCt8gOXlW3sple5OMXDB9Qtna6ydodPyOdTiRd8zA4sR+OUvL6wyVWcw
         099w==
X-Gm-Message-State: AOAM533GL07UqZ2C1bnf3hGeiLTnD3mRvG0+Qk1TuHeT9WrlFAP7Mk6j
        kHYbsuKnP3ClX/OtrUbvqtw=
X-Google-Smtp-Source: ABdhPJw5p564wo1FNct20/m8JSOhTn/r/zg8QD5FiplZuhydA8Gvqhwc9cyDH8tncVS6Nt+1026Yuw==
X-Received: by 2002:a05:6870:218a:b0:d7:3be1:b842 with SMTP id l10-20020a056870218a00b000d73be1b842mr1414568oae.0.1646060044314;
        Mon, 28 Feb 2022 06:54:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v24-20020a9d5a18000000b005ad458facbdsm5231148oth.27.2022.02.28.06.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:54:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <eb049c6f-f196-95de-265e-c3454fcb808a@roeck-us.net>
Date:   Mon, 28 Feb 2022 06:54:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Potin Lai <potin.lai@quantatw.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220228103716.10774-1-potin.lai@quantatw.com>
 <20220228103716.10774-3-potin.lai@quantatw.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: Add sample averaging
 properties for ADM1275
In-Reply-To: <20220228103716.10774-3-potin.lai@quantatw.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 02:37, Potin Lai wrote:
> Add documentation of new properties for sample averaging in PMON_CONFIG
> register.
> 
> New properties:
> - adi,volt-curr-sample-average
> - adi,power-sample-average
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> 
> doc
> ---
>   .../bindings/hwmon/adi,adm1275.yaml           | 39 +++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> index 223393d7cafd..bc4206b257a8 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> @@ -37,6 +37,43 @@ properties:
>       description:
>         Shunt resistor value in micro-Ohm.
>   
> +  adi,volt-curr-sample-average:
> +    description: |
> +      Number of samples to be used to report voltage and current values.
> +      If the configured value is not a power of 2, sample averaging number
> +      will be configured with smaller and closest power of 2.
> +
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 128
> +    default: 1
> +
> +  adi,power-sample-average:
> +    description: |
> +      Number of samples to be used to report power values.
> +      If the configured value is not a power of 2, sample averaging number
> +      will be configured with smaller and closest power of 2.
> +

Both properties should only accept 1, 2, 4, 8, 16, 32, 64, and 128.

We accept non-exact numbers in sysfs attributes because we can not
expect the end users to know permitted values, but devicetree authors
should know what is acceptable. Valid values can be expressed here
easily with something like
	enum: [1, 2, 4, 8, 16, 32, 64, 128]

This can also be easily tested in the code by ensuring that
the devicetree property is in the range of 1..128 and has exactly
one bit set, such as
	if (!val || val > 128 || hweight32(val) != 1)
or with something like
	if (!val || val > 128 || BIT(__fls(val)) != val)

Guenter

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 128
> +    default: 1
> +
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        contains:
> +          enum:
> +          - adi,adm1272
> +          - adi,adm1278
> +          - adi,adm1293
> +          - adi,adm1294
> +then:
> +  properties:
> +    adi,power-sample-average:
> +      description: This property is not allowed.
> +
>   required:
>     - compatible
>     - reg
> @@ -53,5 +90,7 @@ examples:
>               compatible = "adi,adm1272";
>               reg = <0x10>;
>               shunt-resistor-micro-ohms = <500>;
> +            adi,volt-curr-sample-average = <128>;
> +            adi,power-sample-average = <128>;
>           };
>       };

