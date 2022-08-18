Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7F9598DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345994AbiHRUZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345954AbiHRUZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:25:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EC6E5C;
        Thu, 18 Aug 2022 13:25:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c2so2446633plo.3;
        Thu, 18 Aug 2022 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=hawSr6EW79x1Tt14JmxznMiR5uu37L77vXSBKHyhS2M=;
        b=dFAjWjouQfBXw/HNVPbxT+n8+WwbRR/BhhbJtDnmXhXukoRr0zKdG+AKlkUrdt5DKB
         Hv13SgrJUnOkvByLfwy86T3cyIzXlaTRL7ZGqk7z2SMPnJO84baoJq6+zYU0umPCzKIw
         iTdZAOfJMaYG42bXDRgFvjsaUgn0sAPqg4Cnjzr7h1eQf+ncIIdAP3rnNTitf984QZUt
         /7BTLeyGF0cCPeOceEty7QrAhEMXpuUgEBJp4p3ndA810SQQbeurNydj1l2ur2NYzzIn
         NJXUcK3X8GUFRWLgGZUFYW32egLt54HoadrdpZTanK6+TigYu1B2QbL11T1xRhlclHbq
         I+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=hawSr6EW79x1Tt14JmxznMiR5uu37L77vXSBKHyhS2M=;
        b=pMw5990vPHBpRkOwMcZ26ta2iNqlnJCZSlyQC3eSU4a1bY95+Vcg37jMrpxWICI8Cj
         d2+zB8+FpI1aX705GaJitYMHhXcDKRGcCW/D0ad5825oagE+H3Hk4iIo0wfseEitTceg
         udrhxlc9bnmmx8ehxzOid2VOJ8/nvrNFN7zVptYwYsAf+H2tdHiTHiYvqr5GT462mIbR
         ycXveJyfbXMovJL8jyLrfE3xXpMeyUc1lYfxYpnyd4eL0RKXeGBs9W/QE2IqErOrtWcq
         WKiwA9GwxLS3N+EtQ/venBtzMoXuxx7xeYETiw2MhCmZBMlMF3lhQXCL6/Af0+tADvrB
         Shig==
X-Gm-Message-State: ACgBeo2Nq0cvptNY45Ux58/wlU4TXWH/uF9CdLawxtamf/Rmg1Btomwq
        7ovPEQArDt+Af1Ln2k8bXMw=
X-Google-Smtp-Source: AA6agR6+79n1acOYDvuegoZ4V3jl1ePIl+Fdn8o458LQhkyXsXLvxhkIyCtHVKfxU8NutAFG1ahXQQ==
X-Received: by 2002:a17:902:d489:b0:172:bedc:995c with SMTP id c9-20020a170902d48900b00172bedc995cmr559670plg.162.1660854333306;
        Thu, 18 Aug 2022 13:25:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902ea0700b0016f1aa00abbsm1800402plg.195.2022.08.18.13.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:25:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 13:25:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 13/16] hwmon: (mr75203) add thermal coefficient
 properties for Moortec PVT controller
Message-ID: <20220818202531.GA3431466@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-14-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817054321.6519-14-farbere@amazon.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 05:43:18AM +0000, Eliav Farber wrote:
> Add optional "ts-coeff-g", "ts-coeff-h", "ts-coeff-cal5" and
> "ts-coeff-j" properties to be used instead of defaults for the
> thermal equasion.
> 
Vendor prefix again, and shouldn;t there be some note about the
to-be-used defaults ?

Guenter

> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  .../bindings/hwmon/moortec,mr75203.yaml       | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index e2a55001eefc..867664bd937f 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -62,6 +62,30 @@ properties:
>        used to normalzie the voltage output results.
>      $ref: /schemas/types.yaml#definitions/uint32
>  
> +  ts-coeff-g:
> +    description:
> +      G coefficient for thermal equation.
> +    maxItems: 1
> +    $ref: /schemas/types.yaml#definitions/uint32
> +
> +  ts-coeff-h:
> +    description:
> +      H coefficient for thermal equation.
> +    maxItems: 1
> +    $ref: /schemas/types.yaml#definitions/uint32
> +
> +  ts-coeff-cal5:
> +    description:
> +      cal5 coefficient for thermal equation (can't be 0).
> +    maxItems: 1
> +    $ref: /schemas/types.yaml#definitions/uint32
> +
> +  ts-coeff-j:
> +    description:
> +      J coefficient for thermal equation.
> +    maxItems: 1
> +    $ref: /schemas/types.yaml#definitions/int32
> +
>  required:
>    - compatible
>    - reg
> @@ -75,6 +99,10 @@ additionalProperties:
>    - reset-control-skip
>    - vm-active-channels
>    - vm-pre-scalar-ch#
> +  - ts-coeff-g
> +  - ts-coeff-h
> +  - ts-coeff-cal5
> +  - ts-coeff-j
>  
>  examples:
>    - |
> @@ -90,5 +118,10 @@ examples:
>          resets = <&rcu0 0x40 7>;
>          vm-active-channels = [08 10 02];
>          vm-pre-scalar-ch5 = <2>;
> +        ts-coeff-g = <57400>;
> +        ts-coeff-h = <249400>;
> +        ts-coeff-cal5 = <4096>;
> +        ts-coeff-j = <0>;
> +
>          #thermal-sensor-cells = <1>;
>      };
