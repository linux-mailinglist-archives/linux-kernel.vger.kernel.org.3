Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013114FDF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351161AbiDLMZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354802AbiDLMXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:23:09 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B006D193;
        Tue, 12 Apr 2022 04:29:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id m8so6197110ljc.7;
        Tue, 12 Apr 2022 04:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p3zat+YZ3Q6rrI9gIqIt/pGEypx33FFWchYKCQpul8g=;
        b=PhGwfwHKPrrErKoIX46PYBBPZ7TGMb9MPe1sa97C68uGag78Lh5cXYwe4r5FBomIcC
         4NB0fdMPTnKOzWirEaJ2nZbtw5zsTTfsZ892kTTRD9qzuj1yP9gHJipV0ChSZU2a+ko6
         DnrRjfa225x6AMy2xu+90sXEjTwMPOWfb0knEWd6JIGfv47vzkkUkMBrZ5j0JTG5FNC1
         Bk9xCc/rZgjBfaRst4gZDX+vQOUEPc03WdvBEHt71/F/BRfhfGoePL6gCvB1O66uEAY6
         a5qreC50CmjDuX9MUv2F1sFYZg42pGYcWBYl513MyZkGlTeVts2/aU0Wgpuw9rngHi4a
         mMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p3zat+YZ3Q6rrI9gIqIt/pGEypx33FFWchYKCQpul8g=;
        b=z8ieMYKPbzNTs9P/UmsB5d66p8iW9DOe8eWUWgE6d+5k0YyI9ZqvxTzlBO5+riyP5w
         70HHTCqnhslbNQOM5yXNm8D1VfRmW6TRuaL/eqXHNb9Di2M4HKeL9sgYiS1yhKzAq0Ei
         8Bp4Lz6bzHAmxLi8KCYQHJAdQczS7jELqbxAKMCVM/F//fP6+wxkhhT6EOxGDNwv4Ehu
         b9pzTKcn2b0UqsCHFtmFLtz2EifUoE3vooALadHk0U5/JhJvsf8CkooVObvU16ESTQEU
         rCbmFg8tAacs8PlFA5Rls8KGRqlh0sabI+aC2lXaXG6hYQ9X9TD7ra4vY5IqVUbtZzkP
         5rZQ==
X-Gm-Message-State: AOAM533Yrv4RjNxWlI/tUe8oLVUibuP4kmOwIe3ZZdY8MgAmpYuzS++a
        4AAW8MYKM644JY98LSZQ1aMKG6eJkwzg7A==
X-Google-Smtp-Source: ABdhPJwl9VcXPw/AjXf51p0MpJESvjiUCEx6bZEy8shnlTceuPr0piOLsLkEsMebNYhf2g38MbRXpQ==
X-Received: by 2002:a2e:9549:0:b0:24b:4f99:4e76 with SMTP id t9-20020a2e9549000000b0024b4f994e76mr12660741ljh.350.1649762992525;
        Tue, 12 Apr 2022 04:29:52 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id v8-20020a2e7a08000000b0024b611ccab5sm644293ljc.106.2022.04.12.04.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 04:29:52 -0700 (PDT)
Date:   Tue, 12 Apr 2022 14:29:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, dac2@pensando.io,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] dt-bindings: spi: dw: Add Pensando Elba SoC SPI
 Controller bindings
Message-ID: <20220412112950.pdsfx72wrhnqm7ky@mobilestation>
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-6-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406233648.21644-6-brad@pensando.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 04:36:42PM -0700, Brad Larson wrote:
> The Pensando Elba SoC has integrated the DW APB SPI Controller
> and requires the property pensando,syscon-spics for access
> to the spics control register.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Change from V3:
> - Add required property pensando,syscon-spics to go with
>   pensando,elba-spi
> 
>  .../bindings/spi/snps,dw-apb-ssi.yaml           | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index d7e08b03e204..41c3bbf5a55c 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -37,6 +37,21 @@ allOf:
>      else:
>        required:
>          - interrupts
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - pensando,elba-spi
> +    then:
> +      properties:

> +        pensando,syscon-spics:

Please see my comment to the "[PATCH 11/11] arm64: dts: Add Pensando
Elba SoC support" patch regarding this property implementation.

-Sergey

> +          $ref: /schemas/types.yaml#/definitions/phandle
> +          description:
> +            Phandle to the system control device node which provides access to
> +            the spics control register
> +      required:
> +        - pensando,syscon-spics
>  
>  properties:
>    compatible:
> @@ -73,6 +88,8 @@ properties:
>                - renesas,r9a06g032-spi # RZ/N1D
>                - renesas,r9a06g033-spi # RZ/N1S
>            - const: renesas,rzn1-spi   # RZ/N1
> +      - description: Pensando SoC SPI Controller
> +        const: pensando,elba-spi
>  
>    reg:
>      minItems: 1
> -- 
> 2.17.1
> 
