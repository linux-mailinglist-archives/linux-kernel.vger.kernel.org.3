Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFF550E40D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242748AbiDYPLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiDYPLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:11:10 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D81689AA;
        Mon, 25 Apr 2022 08:08:05 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e5ca5c580fso16355866fac.3;
        Mon, 25 Apr 2022 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=za1mZHss+li0ybPEY6i/L34F8j+pk+2DumO4nFr5Nqw=;
        b=HOTPf6CKzKzNtGoZg5BVXqz56lD0FnvFQgQD/QpQp1mfRh5BLZkKlYB/4e+q1voe+D
         DvtwJpjx10q5fE3em4lCpWGNIECHmNi/ok0z7UsAjJO94VwvAmVWERtLUUF/AVyUCoEN
         bBB/TG/yuJpuEnfJyvea0qz7bVQhCfUoVb+fh/W4vL4a6B5oXDSiV/0RFgvBJHLaVs05
         K8vGTzOh2yoHv6De3UwwJoNkzCC8aDfGjjmWOCDv7ugp9P8iT2RbrboATd+nd1ltD4Cd
         pW5/ti8Yr/Jon7QRkHj4YBoClzCR3Bj+D0+CMCuVVyzlC5/g0jaUrW61hp8+6EtC9f0F
         8gZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=za1mZHss+li0ybPEY6i/L34F8j+pk+2DumO4nFr5Nqw=;
        b=5olCd3kCrKoIFbMlk0e2RrhfbtAiUszljHgncmYMPCHNXTuvh249JwvTbYRSyP1pPe
         6MaxPaz3Un2H01z98DeGAhluSkMG7egTV7ZFzgi4Y5zzHFWcjqAPTwYr0O3RGWJsQa9r
         rsecOvwMNKY+kN/avneQg1S88M/cZq7JjVMP1++9pC6TQ3p/T3rNDVH8+zA/sqLoljtw
         xFrBIVB8n+J1s28nTtwCtLy7u10K5WPy80u1xcdhbPYSLAb6z1bB1fu0VBebpJq9KwG1
         LrCnvJMgI//4i4c0NStqO5SDEk2he3Cscbnf7ZaOyaQwymOuULduPUnlNNXsI5+/0GJ+
         EVlA==
X-Gm-Message-State: AOAM531xNR3bGsQzV1PHm/Ip+X9Dj4FIR15ZL5w8rd37h8ZqUxP3lih6
        0W4ZNhowKdIUXv0uLw5xKRQ21k7CjmE=
X-Google-Smtp-Source: ABdhPJyzc6gXFrcLW8x8oJ6ozRGcsrCXhmmdRz6dFfIR7Qz8FnM7l8VZx/RvOA7UfN3sl1y6XrSwIA==
X-Received: by 2002:a05:6870:15d0:b0:e9:12ad:288c with SMTP id k16-20020a05687015d000b000e912ad288cmr4799481oad.223.1650899284840;
        Mon, 25 Apr 2022 08:08:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e26-20020a056820061a00b0035e46250f56sm3782576oow.13.2022.04.25.08.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:07:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Apr 2022 08:07:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: hwmon: Add nuvoton,nct6775
Message-ID: <20220425150748.GA4165124@roeck-us.net>
References: <20220309005047.5107-1-zev@bewilderbeest.net>
 <20220309005047.5107-2-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309005047.5107-2-zev@bewilderbeest.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 04:50:42PM -0800, Zev Weiss wrote:
> These Super I/O chips have an i2c interface that some systems expose
> to a BMC; the BMC's device tree can now describe that via this
> binding.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

This is still waiting for DT maintainer approval.

Do you expect to add further properties along the line ?
If not, you might consider adding the chips to trivial devices instead.

Guenter

> ---
>  .../bindings/hwmon/nuvoton,nct6775.yaml       | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
> new file mode 100644
> index 000000000000..7b1054db46b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct6775.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NCT6775 and compatible Super I/O chips
> +
> +maintainers:
> +  - Zev Weiss <zev@bewilderbeest.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,nct6106
> +      - nuvoton,nct6116
> +      - nuvoton,nct6775
> +      - nuvoton,nct6776
> +      - nuvoton,nct6779
> +      - nuvoton,nct6791
> +      - nuvoton,nct6792
> +      - nuvoton,nct6793
> +      - nuvoton,nct6795
> +      - nuvoton,nct6796
> +      - nuvoton,nct6797
> +      - nuvoton,nct6798
> +
> +  reg:
> +    maxItems: 1
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
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        superio@4d {
> +            compatible = "nuvoton,nct6779";
> +            reg = <0x4d>;
> +        };
> +    };
