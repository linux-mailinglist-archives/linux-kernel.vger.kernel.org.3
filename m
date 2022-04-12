Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA21F4FDF97
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352190AbiDLMaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353258AbiDLM16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:27:58 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E073182;
        Tue, 12 Apr 2022 04:37:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o2so10035784lfu.13;
        Tue, 12 Apr 2022 04:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5aneK7Rl07kK1qGmCVmUb7811DnxlqneA9Z72R6PRJc=;
        b=HxQcMx486YxA3qXMLBqpak4qkZIVxLl/ycmPCLsPG+cpIO8n/09K/HAcK5/LPYhkxZ
         oq8z7qo/cw9fpuSHQikyXY7xnWM4u84DnBmJGaOOR7KYFNWv8vfHGrbYpMikl5RswyaF
         FnB+0zQGyFpE2J1RuTAE/CqtzQa5937jjDUwRhsSMwnrZl5EKqjUI5XrfoE+YqriPfr7
         jVHKnK5k0q2pRgZXwIZBCTZYPizAB0a7OzPn1fLDety23eDV2k95zPfdJhgKn/WCdV+4
         h7Y/xkdQLhKCwxLttf1slKfwUEnES7YAA5d3ogJH1/OIqgYCW/0Y+hHrg3v1MlpVN12l
         Gnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5aneK7Rl07kK1qGmCVmUb7811DnxlqneA9Z72R6PRJc=;
        b=3JQ/rbJVZRVfBXDjqXKDZJzNb/ayFNkulKuEXznxKbbFwgJhjr0PERQcxIy/PrB18L
         w5pRc6rqvsi2Bvg0lCBkDfRr0fZDsMdGm4W0uBg+VKsKdeCwLHAVRHA4BBUe3KgtZiKM
         7U0TEyTjdWe+qhFQcO9PeNip+pnbBTyafeEoQbd7bFhrmaEy5HDCFIqGaH2C5TSrcRCu
         0amn3vviPOTqnsqq8j70jC/ss+UkDP3lKRfdDeSiNp2T2fRSUecn/BODJ0PP0Mk+gVt1
         +henfqIGdoMyQMvDURG06MSh4QEeq3NE35Ntsb70sTpYvMzqacF515HOHUlUWLq6gAgC
         6w5A==
X-Gm-Message-State: AOAM5303864SCDCXUX+IzWJxiiv2mAb3qtNRubX30msJ1It4xiROltT/
        1pgMLxToyNdhq5AmhyHEBtg=
X-Google-Smtp-Source: ABdhPJxAmdxPltsou8uUUjeWnJuCK2JK93YfESll7d9K7ZQG+0dZuU+DhMEF1dNWNnaVHcgqlzdCPg==
X-Received: by 2002:a05:6512:c18:b0:44a:9992:28bc with SMTP id z24-20020a0565120c1800b0044a999228bcmr25269448lfu.641.1649763461666;
        Tue, 12 Apr 2022 04:37:41 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id bq8-20020a056512150800b00448ab58bd53sm3618431lfb.40.2022.04.12.04.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 04:37:41 -0700 (PDT)
Date:   Tue, 12 Apr 2022 14:37:39 +0300
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
Subject: Re: [PATCH 04/11] dt-bindings: spi: Add compatible for Pensando Elba
 SoC
Message-ID: <20220412113739.xczqscungojcitrm@mobilestation>
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-5-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406233648.21644-5-brad@pensando.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [PATCH 04/11] dt-bindings: spi: Add compatible for Pensando Elba SoC

I think you need to be more specific in the patch title to what bindings
you are adding the new compatible string. Something like this
"dt-bindings: spi: cdns: ..."
The same concerns the patch "[PATCH 03/11] dt-bindings: mmc: Add Pensando
Elba SoC binding".
Otherwise it isn't clear to what schema you are adding the Elba SoC
support to.

-Sergey

On Wed, Apr 06, 2022 at 04:36:41PM -0700, Brad Larson wrote:
> Document the cadence qspi controller compatible for Pensando Elba SoC
> boards.  The Elba qspi fifo size is 1024.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index 0a537fa3a641..bc298e413842 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -30,6 +30,7 @@ properties:
>                - intel,lgm-qspi
>                - xlnx,versal-ospi-1.0
>                - intel,socfpga-qspi
> +              - pensando,elba-qspi
>            - const: cdns,qspi-nor
>        - const: cdns,qspi-nor
>  
> @@ -48,7 +49,7 @@ properties:
>      description:
>        Size of the data FIFO in words.
>      $ref: "/schemas/types.yaml#/definitions/uint32"
> -    enum: [ 128, 256 ]
> +    enum: [ 128, 256, 1024 ]
>      default: 128
>  
>    cdns,fifo-width:
> -- 
> 2.17.1
> 
