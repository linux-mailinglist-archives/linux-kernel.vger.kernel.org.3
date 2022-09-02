Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8247E5AB923
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiIBUD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIBUD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:03:56 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB7FB9434;
        Fri,  2 Sep 2022 13:03:55 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11edd61a9edso7392918fac.5;
        Fri, 02 Sep 2022 13:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=C9aW5y522OX/8JtSB5bbTEMWELASaLGWe8KFzDOic70=;
        b=ePNjTgPcRC77mtehZ51e/DIyp7snYPjvKToDI3GkT4YFy3n7AQPi3idZEJJcraEFWR
         SvzRlHiFkXzH+vyIouIkK0JGpwRzWl/J/taeHiouCgc5YE8hDsDVXWm0eIFufhgs4O9a
         PbpwBO4Nc8Xg+WL7tUFEY0dOqzGUN7B7AQntaryAIL/ak6Z7erk1inUwplrBl2JIiBzr
         pyJ4TDqgdEl1D9chxTLXeGEE+pBCupmz0hLa8wSVxhLJB4Yiowh3UDRwYp9CCAGMXgJs
         EFZyNa/kUXCAgfds4b+2/n50HMtVL0qXBoeae3WALE0V75hly4K1lhBCTESq7iPWMmnf
         Zgzg==
X-Gm-Message-State: ACgBeo02lKmRWWgOH61Lb3nDKS3RZj1cug5LcI4yEJHTTDlkywUPoR3P
        umTCir9bTJjOXpGzDYjG6Q==
X-Google-Smtp-Source: AA6agR7X7LgSHTrqR4pBUQ6YJvJARDJW7Vt5cNu2uVbOPXyWy9+oS3seWLEkqV6pKwrSwJ56OLaZrQ==
X-Received: by 2002:a05:6870:a90f:b0:11e:949a:e3ef with SMTP id eq15-20020a056870a90f00b0011e949ae3efmr3248791oab.106.1662149034595;
        Fri, 02 Sep 2022 13:03:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s12-20020a056870ea8c00b001226d2100f2sm1537319oap.33.2022.09.02.13.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:03:54 -0700 (PDT)
Received: (nullmailer pid 324903 invoked by uid 1000);
        Fri, 02 Sep 2022 20:03:53 -0000
Date:   Fri, 2 Sep 2022 15:03:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, rahul.tanwar@linux.intel.com,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH v3 16/19] dt-bindings: hwmon: (mr75203) add coefficient
 properties for the thermal equation
Message-ID: <20220902200353.GA318894-robh@kernel.org>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-17-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830192212.28570-17-farbere@amazon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:22:09PM +0000, Eliav Farber wrote:
> Add optional temperature coefficient properties:
>  *) moortec,ts-coeff-g
>  *) moortec,ts-coeff-h
>  *) moortec,ts-coeff-cal5
>  *) moortec,ts-coeff-j
> If defined they shall be used instead of defaults.
> 
> The coefficients were added to device tree on top of the series property
> (which can be used to select between series 5 and series 6), because
> coefficients can vary between product and product, and code defaults might
> not be accurate enough.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V3 -> V2:
> - Add "moortec" prefix to property name.
> 
>  .../bindings/hwmon/moortec,mr75203.yaml       | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index ec2dbe7da9c2..a92da6064285 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -74,6 +74,37 @@ properties:
>      default: 5
>      $ref: /schemas/types.yaml#definitions/uint32
>  
> +  moortec,ts-coeff-g:
> +    description:
> +      G coefficient for temperature equation.
> +      Value should be multiplied by factor 1000.

If you just multiply the values here, you can specify 'multipleOf: 1000'

Either way, some constraints would be nice. Or is 0 - 2^32 valid?


> +      Default for series 5 = 60000
> +      Default for series 6 = 57400
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  moortec,ts-coeff-h:
> +    description:
> +      H coefficient for temperature equation.
> +      Value should be multiplied by factor 1000.
> +      Default for series 5 = 200000
> +      Default for series 6 = 249400
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  moortec,ts-coeff-cal5:
> +    description:
> +      cal5 coefficient for temperature equation (can't be 0).

minimum: 1

> +      Default for series 5 = 4094
> +      Default for series 6 = 4096
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  moortec,ts-coeff-j:
> +    description:
> +      J coefficient for temperature equation.
> +      Value should be multiplied by factor 1000.
> +      Default for series 5 = -100
> +      Default for series 6 = 0
> +    $ref: /schemas/types.yaml#/definitions/int32
> +
>  required:
>    - compatible
>    - reg
> @@ -97,5 +128,7 @@ examples:
>          resets = <&rcu0 0x40 7>;
>          moortec,vm-active-channels = <0x10 0x05>;
>          moortec,vm-pre-scaler = <5 6>;
> +        moortec,ts-coeff-g = <61400>;
> +        moortec,ts-coeff-h = <253700>;
>          #thermal-sensor-cells = <1>;
>      };
> -- 
> 2.37.1
> 
> 
