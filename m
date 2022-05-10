Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29579520A33
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiEJAf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiEJAfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:35:55 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6491339D7;
        Mon,  9 May 2022 17:31:58 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-ed8a3962f8so16592872fac.4;
        Mon, 09 May 2022 17:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XtS/P9SmLyk3QKWLF6JMOAV4b0xIsdiYHPObF4LauGQ=;
        b=BSrhzxAFg7vDoEAPdmxTC8b0yvX+6eIwJS56/qBvt4E/7YteelJ39f3uaU1h+irl8b
         ESQGYmYixD9vuUqsyx/heCdeCpMFaUzpjkTMN5+rOI3+V741UInfr4UjTURRj+A8dbfZ
         qnJdOX//nsKTILx+LQJNrepr0D1xnlZGZJN+s6fsqRhk1bmsnipSgnC75kYCs+GIlBY+
         eYSybBLKHYBZMXWpIYNRxDsoTb8TWNZncYA2dUNcyLYHjQpSUqSavXO6HT1oKWNDgLdm
         JxPWEMnvgdr4LFgx4ASFDtFGzeS2DZJqEl88jHtvm+S/myRHPG7428A+gmvvX0SjKpv9
         xvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XtS/P9SmLyk3QKWLF6JMOAV4b0xIsdiYHPObF4LauGQ=;
        b=l6GO3Z9LrLRAptxyrZnDAvTdIl+46z9voprg2GasIyARXEF1gudgjTd1YCfQ0NgrWj
         vJfxwR2soEZQho5IJIydYcbrklpeJQBHa1jZnGFUuRZW2D4j4sUiEYVhRO0+PBTG/YW8
         S6PodaKgKLJ0OB4PJF7dLR1DGagL1gRiqodiTvKWnySi+D7PWDn+HvYQYvEQ0D0R+jrV
         3Okh4GfzH115B3valBKUJjZ+htSKqm1HZEfxMeTXKdev9F0jxxkx7pSJ5r6f1AjZuzXb
         DtujnX92q+FFJEztJtCDMH97fKIWnc7HgAwWVy1fJToQbJkcUKVNpguwIe4MY3VNpmTl
         R41Q==
X-Gm-Message-State: AOAM533c50Hc2c11xFY6NLJbSUb9pFgS2EtZ3g05gTTrGJbBnQB4liGD
        YG9V2DriUacOlKVJKWxVnSA=
X-Google-Smtp-Source: ABdhPJxQubDMBuGGFGcBGtQ05uHQ5cLejrRVo9CQ00xyhkTOd/6FYn7yVWlRvW8lJ7+aTn/5BuMQ/A==
X-Received: by 2002:a05:6870:15d0:b0:e9:8787:60c2 with SMTP id k16-20020a05687015d000b000e9878760c2mr11629759oad.294.1652142717960;
        Mon, 09 May 2022 17:31:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b14-20020a4aac8e000000b0035eb4e5a6bcsm5622339oon.18.2022.05.09.17.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 17:31:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 May 2022 17:31:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add nuvoton,nct6775
Message-ID: <20220510003156.GA1561729@roeck-us.net>
References: <20220428012707.24921-1-zev@bewilderbeest.net>
 <20220428012707.24921-2-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428012707.24921-2-zev@bewilderbeest.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:27:06PM -0700, Zev Weiss wrote:
> These Super I/O chips have an i2c interface that some systems expose
> to a BMC; the BMC's device tree can now describe that via this
> binding.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  .../bindings/hwmon/nuvoton,nct6775.yaml       | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
> new file mode 100644
> index 000000000000..358b262431fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
> @@ -0,0 +1,57 @@
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
> +  nuvoton,tsi-channel-mask:
> +    description:
> +      Bitmask indicating which TSI temperature sensor channels are
> +      active.  LSB is TSI0, bit 1 is TSI1, etc.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 0xff
> +    default: 0
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
> +            nuvoton,tsi-channel-mask = <0x03>;
> +        };
> +    };
