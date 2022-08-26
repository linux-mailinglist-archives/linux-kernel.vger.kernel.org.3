Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451135A3290
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 01:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbiHZXX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 19:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiHZXXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:23:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389AAB6012;
        Fri, 26 Aug 2022 16:23:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m3so3814493lfg.10;
        Fri, 26 Aug 2022 16:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Z3ofurWE8ZXj18ZbZuUVHMAHqzrPPON1XujjS2A1mJI=;
        b=eVt6zDYt7Q/bxAb1Y9vBCNEDDpgiDmI1Ed33Vdj8QpED8unQkG0OAq797b7Oe4pXJa
         XqN1SJgB1oEJ7d7aiqyhiTogQuvpN4EprkaswnTldjvDs63bGvVtGk3K8GN4y3pxwiwi
         uPPQ299I7dv8JGZ0iwHkNlFpz7oUsd/8Y+yk38cTcyeTx8n7LOHyKWtwfj2/kG8iIAKR
         OadSk+Ft7WZ+qIA53CADNRTJXh4SVAvQQP9clLwzSLpvAn5TmWTFx+cYnqxf0g9r/W/I
         IJ1ghMZsR/cPbpQ3wfdmevGMpEq2QSFBCWR3sxqontwZTserBfckR8h3hVXbnVrHg/BQ
         R2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Z3ofurWE8ZXj18ZbZuUVHMAHqzrPPON1XujjS2A1mJI=;
        b=ENFdFEbrf8jaYQD6hRdfyDFFCsa1Ovu6bQpQyZFYYNAmsqSbsVWV3/jdFrbQVVqtRq
         wSjDKmox2Fhn5h2g6yelv/TEtThRpxT8d+L2kNf1etIHlC7Lhf5Hs7McggIJNLfLilIF
         MYsZ/buzOKU0hf0wB5az7CQksLYn2ZRiCzLskxRuGZfG2mCkC9jk18XmNJ/A78WDDGzn
         D960y61lYy6zo9+M0pfdWHRnFEvpdOg6BOM85XXg92aJ54dJjR5vqEY31uGQYk9jhGx4
         9ncdmxRJKWqRoeFYYBrTjcUoCjTSFBiInS1z9QYi+cTupvYRD5HNiJudGEdpE2wFrZD6
         gCKw==
X-Gm-Message-State: ACgBeo3oBkNbQR+U0wSyQkyyFOMhK1Sv6QxunjJpKll2EffoPMSamtu2
        AyDQ9FxgFi3dcv+ZskHvMfA=
X-Google-Smtp-Source: AA6agR6FMR+24UHpiJIJi6iCKiRAnzQjwOTvqzo9P1JxnIKRWkzTixJSeUXUbPKki7K8uhYw+t70uQ==
X-Received: by 2002:a05:6512:318b:b0:492:c484:9d1c with SMTP id i11-20020a056512318b00b00492c4849d1cmr3430819lfe.38.1661556200627;
        Fri, 26 Aug 2022 16:23:20 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id s20-20020a197714000000b00492e7b8e26asm495703lfc.208.2022.08.26.16.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 16:23:19 -0700 (PDT)
Date:   Sat, 27 Aug 2022 02:23:17 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 10/11] spi: dw-apb-ssi: add generic 1.03a version
Message-ID: <20220826232317.h4vmijjotzu7qvpg@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-11-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-11-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:57:54PM +0100, Sudip Mukherjee wrote:
> From: Ben Dooks <ben.dooks@sifive.com>
> 
> Add new snps,dw-ssi-1.03a version to the bindings.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index 37c3c272407d..35aa04a85813 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -45,6 +45,7 @@ properties:
>          enum:
>            - snps,dw-apb-ssi
>            - snps,dwc-ssi-1.01a

> +          - snps,dwc-ssi-1.03a

There is no point in having the IP-core versions used in the
compatible string. The controller version is retrieved from the device
CSR. Just add new generic compatible string "snps,dw-ahb-ssi" and use
it to identify your device.

-Sergey

>        - description: Microsemi Ocelot/Jaguar2 SoC SPI Controller
>          items:
>            - enum:
> -- 
> 2.30.2
> 
