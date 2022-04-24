Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7468550CF66
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 06:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbiDXEhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 00:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiDXEhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 00:37:22 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2C1643F;
        Sat, 23 Apr 2022 21:34:23 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e656032735so11605537fac.0;
        Sat, 23 Apr 2022 21:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2X1LQAUaG1A9g+OlRp/gW/SPOQ8FED7p/vA2pGz4Lu4=;
        b=G+UKUkslo+L77OX1S9EGj5QusiatXdL5lW3PgRxOdCwb8LkpUh8zQBfh8GU4tRttA9
         ELbPhICsSB1c/v9t0pnMBDCjbZAVTE81zB1frgBYrlOI/5L2AyhO7O+npwQohFhbt8WY
         Kqfot2kWT/vKMYCq8JuIGeP5cft8sPbq4+gu6T/Nhv9aXZCNlooY21YcE8m3LInwD49l
         Ebutltt+/fZuVHYzqOsJr6eBe33rA34fvkh32nwzZkSozr9PDo+r1BOL1BgG/J6d4mJq
         rfumrzULwIe6LkyP3EBC3bNfuQ/7IDniF2G6gOXrYSjMyLDxW0t+7bGbK8K29ffKJF/T
         MunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=2X1LQAUaG1A9g+OlRp/gW/SPOQ8FED7p/vA2pGz4Lu4=;
        b=3H6BBsFBfujNGXa5ZOqqrPwKMc1YjysKWLOGGXHZVQ4RCKqXDexA8h33GLso24AVGd
         qVqKJsQASm9/3hz89sc+KVSbxa5H1kzEFWkRi3vdWZOs07CKsxJOUv5MLIlt3lyF3d2G
         T1g9/c/Zxp3fddfTQRwjaOYbVXYOk78QV1BOTjoL21X7MVUaS7xvBv/cxk/hjDHaKpWK
         WnLfyt9afgxYruy1petSJsSKNm5kA3wINoIUCftgtVN7KxniTBfYu56iORMq1GSME+pz
         MFrNWErvLB8WVncmKzxmipOuemMlzlw+23+02DoSR8L7hRlD+kfplGRBBbr026rHPDDI
         nDpQ==
X-Gm-Message-State: AOAM530elJVgsXFNPyULoVuvW2RQdOAWtfZXLKw8ppCe84eG9LApBdtd
        VrQB6+52bpQmgORtL4uatWYptDhB3ug=
X-Google-Smtp-Source: ABdhPJznJM+sP0rXPunVhdrPDFSh+zJTm4CagCwBXP4ZICE0usxszO07TyRoLFFy9vHQa0T8Fvq0Uw==
X-Received: by 2002:a05:6870:33a5:b0:dd:f6e6:7837 with SMTP id w37-20020a05687033a500b000ddf6e67837mr4514655oae.154.1650774862797;
        Sat, 23 Apr 2022 21:34:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c17-20020a9d6851000000b0060551d14386sm2453167oto.13.2022.04.23.21.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 21:34:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Apr 2022 21:34:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Camel Guo <camel.guo@axis.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
Message-ID: <20220424043420.GA4000967@roeck-us.net>
References: <20220414075824.2634839-1-camel.guo@axis.com>
 <20220414075824.2634839-2-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220414075824.2634839-2-camel.guo@axis.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 09:58:22AM +0200, Camel Guo wrote:
> Document the TMP401, TMP411 and TMP43x device devicetree bindings
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Camel Guo <camel.guo@axis.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Notes:
>     v4:
>     - Add Reviewed-by from Rob H.
>     
>     v3:
>     - Remove unneeded address-cells and size-cells;
>     - Change range of ti,n-factor to [-128, 127];
>     - Remove unneeded 'items' of ti,beta-compensation;
>     - Got Reviewed-by from Krzysztof.
>     
>     v2:
>     - Fix format and describe hardware properties instead of programming
>       models
> 
>  .../devicetree/bindings/hwmon/ti,tmp401.yaml  | 105 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
> new file mode 100644
> index 000000000000..fe0ac08faa1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/ti,tmp401.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TMP401, TPM411 and TMP43x temperature sensor
> +
> +maintainers:
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +description: |
> +  ±1°C Remote and Local temperature sensor
> +
> +  Datasheets:
> +  https://www.ti.com/lit/ds/symlink/tmp401.pdf
> +  https://www.ti.com/lit/ds/symlink/tmp411.pdf
> +  https://www.ti.com/lit/ds/symlink/tmp431.pdf
> +  https://www.ti.com/lit/ds/symlink/tmp435.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tmp401
> +      - ti,tmp411
> +      - ti,tmp431
> +      - ti,tmp432
> +      - ti,tmp435
> +
> +  reg:
> +    maxItems: 1
> +
> +  ti,extended-range-enable:
> +    description:
> +      When set, this sensor measures over extended temperature range.
> +    type: boolean
> +
> +  ti,n-factor:
> +    description:
> +      value to be used for converting remote channel measurements to
> +      temperature.
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    items:
> +      minimum: -128
> +      maximum: 127
> +
> +  ti,beta-compensation:
> +    description:
> +      value to select beta correction range.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 15
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tmp401
> +    then:
> +      properties:
> +        ti,n-factor: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tmp401
> +              - ti,tmp411
> +    then:
> +      properties:
> +        ti,beta-compensation: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      sensor@4c {
> +        compatible = "ti,tmp401";
> +        reg = <0x4c>;
> +      };
> +    };
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      sensor@4c {
> +        compatible = "ti,tmp431";
> +        reg = <0x4c>;
> +        ti,extended-range-enable;
> +        ti,n-factor = <0x3b>;
> +        ti,beta-compensation = <0x7>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61d9f114c37f..6b0d8f5cc68e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19838,6 +19838,7 @@ TMP401 HARDWARE MONITOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
>  F:	Documentation/hwmon/tmp401.rst
>  F:	drivers/hwmon/tmp401.c
>  
