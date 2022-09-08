Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2044E5B2224
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiIHPZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiIHPZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:25:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A6A8E44B;
        Thu,  8 Sep 2022 08:25:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id l65so18269918pfl.8;
        Thu, 08 Sep 2022 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=R9fy6rIwPYYPUr649S1/ZTzp1ypM+H+I42SYzE1zgp8=;
        b=ZH2zxCqPv3b5TjMLC9XVBoHUv8YDQquI+F21Y/6qd9h4+GMTGsU0L8TiZhWy0CqYkC
         QyD6/cSNGFS3KkBfASRxtqZLAt3llRZJu2BKh6jrb2ayXRQIvbvM1cdq3HRlw91jpHNn
         uU7cmSbxSVzZ/VzQ9Uwt87kqGlOTtzd9IkpATuvdb/mFyAy+q2yy8j06CXZRIwe4/0tT
         OW1G/VsVgj1TcYhTRn9oHQKHV2h0UKGe+Q3NKJAQ7hD3qmdJbdgnEfVw+HQhGsOcGKLj
         sDsGDJPTvzK2PXh3f/BEYlovT85UgnQpKb0HBjK6M4kbBjpEzkmEz9U4zjB6Cew7ZXDl
         vDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=R9fy6rIwPYYPUr649S1/ZTzp1ypM+H+I42SYzE1zgp8=;
        b=dTYt6+Yo6ygcu4TdOtfIGvZ+GEu7UQdPIUUjzkiFn0Dc5EXy09OUBmSfNf3CXLNR4R
         TrAzYPBjps8QH7Fjye4zp7ZUCPlGmsNTaq/0q0FreNZtBzy5012DzAFflCJ3SE1Civ14
         MyghClo2P+HOjVXjg/rgksCoZmWgFTNUS82pt7zqIfbrBty8pqGLKqYXiwpy8enm0U/L
         1sI3oD7Jj3vRMJhDGr3CvNnHoR7boy/2ZRnsEp8VOnaeKiDKMUXY46uthQL1sigqC66y
         1rrfG/BazbcvrxXOFDThyOAEM0M28aMVgVTdqKQumNDwK6qgxSv1F+DosWTHPt3C0N42
         g8Ig==
X-Gm-Message-State: ACgBeo3l883hIMRBA1DOTn9AIaq6b8xsRwEqrR9jlM+HDDtXP1s0Fz8i
        KSgLhbvXGSwUV241bSipzGkw5RSTVDuk2A==
X-Google-Smtp-Source: AA6agR46YCF8iiF+Pqc7gN7oq3atqulRj4vpdfbeS6B2YY8FdFpq9+ltJV998fGIWx03BqEyHNdPpw==
X-Received: by 2002:a63:5b20:0:b0:430:682:8fb5 with SMTP id p32-20020a635b20000000b0043006828fb5mr8493792pgb.451.1662650714388;
        Thu, 08 Sep 2022 08:25:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 64-20020a621443000000b0053e669cc845sm4538463pfu.190.2022.09.08.08.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 08:25:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5d36f4f2-f67b-32c3-ff6a-937b2e4723fe@roeck-us.net>
Date:   Thu, 8 Sep 2022 08:25:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND v6 3/4] dt-bindings: hwmon: Add bindings for
 max31760
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220908082358.186268-1-Ibrahim.Tilki@analog.com>
 <20220908082358.186268-4-Ibrahim.Tilki@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220908082358.186268-4-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 01:23, Ibrahim Tilki wrote:
> Adding bindings for Analog Devices MAX31760 Fan-Speed Controller
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>

This time you dropped the maintainers from Cc:. Why ?

Guenter

> ---
>   .../bindings/hwmon/adi,max31760.yaml          | 44 +++++++++++++++++++
>   1 file changed, 44 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31760.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
> new file mode 100644
> index 000000000..003ec1317
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/adi,max31760.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX31760 Fan-Speed Controller
> +
> +maintainers:
> +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> +
> +description: |
> +  Analog Devices MAX31760 Fan-Speed Controller
> +  https://datasheets.maximintegrated.com/en/ds/MAX31760.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max31760
> +
> +  reg:
> +    description: |
> +      I2C address of slave device.
> +    items:
> +      minimum: 0x50
> +      maximum: 0x57
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        max31760@50 {
> +                reg = <0x50>;
> +                compatible = "adi,max31760";
> +        };
> +    };

