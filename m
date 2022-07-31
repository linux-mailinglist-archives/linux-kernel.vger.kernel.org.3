Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B48B585F88
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbiGaPju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiGaPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:39:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B79E0A5;
        Sun, 31 Jul 2022 08:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D27D0CE0E12;
        Sun, 31 Jul 2022 15:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1785C433D6;
        Sun, 31 Jul 2022 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659281982;
        bh=k0Z/QQGsxryaJHqpVcnWbLxKZy2oviaSn81n5NkcmWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O/wsOm9jn2DG4hwj7ptUtdIV8P1Cg+weZnBXsdTR8QOHD8kY3HiRqUOq5r6Pssgwj
         KxDoVtuJWmv0FfvjtuRnlR7l8j8MXXnh3zxLRJPRsQkRl9xe+JMZMZgGTF5VDMnBaR
         zQ3cw42+eYyAWvMpgEh8+YPeZHPAxoxF9/6FGJuAmKmJwpQfNyCQLmRbTlJpXqLjVR
         47Haa6+NTZVIh9ZO7vXsh4dxmaB2vgw6iD9TOl/RFgYY/GpfOKSFTZqcd12BOUNyIO
         +iFBDLUCACrCDSZVFkvyPL5Qsgp0ynqtykbkQR2V5vb/i++2OUMKOiPKGLzi5MD7tx
         0HtcxWKj2C60A==
Date:   Sun, 31 Jul 2022 16:49:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?B?TcOlcnRlbg==?= Lindahl <martenli@axis.com>,
        Bogdan Pricop <bogdan.pricop@emutex.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Dan Murphy <dmurphy@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Lukas Wunner <lukas@wunner.de>,
        Robert Jones <rjones@gateworks.com>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v2 02/10] dt-bindings: iio: accel: use
 spi-peripheral-props.yaml
Message-ID: <20220731164943.320babe4@jic23-huawei>
In-Reply-To: <20220727164646.387541-3-krzysztof.kozlowski@linaro.org>
References: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
        <20220727164646.387541-3-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 18:46:38 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Instead of listing directly properties typical for SPI peripherals,
> reference the spi-peripheral-props.yaml schema.  This allows using all
> properties typical for SPI-connected devices, even these which device
> bindings author did not tried yet.
> 
> Remove the spi-* properties which now come via spi-peripheral-props.yaml
> schema, except for the cases when device schema adds some constraints
> like maximum frequency.
> 
> While changing additionalProperties->unevaluatedProperties, put it in
> typical place, just before example DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> I wonder if spi-3wire is device specific (not controller) and should be
> rather explicitly mentioned by device schema. Just like spi-cpol/cpha.

I think it is, but Mark is expert on this.
In general I'm waiting on Mark's opinion on the whole idea!

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/accel/adi,adis16201.yaml     | 7 ++++---
>  .../devicetree/bindings/iio/accel/adi,adis16240.yaml     | 7 ++++---
>  .../devicetree/bindings/iio/accel/adi,adxl313.yaml       | 9 ++++-----
>  .../devicetree/bindings/iio/accel/adi,adxl345.yaml       | 7 ++++---
>  .../devicetree/bindings/iio/accel/adi,adxl355.yaml       | 7 ++++---
>  .../devicetree/bindings/iio/accel/adi,adxl367.yaml       | 7 ++++---
>  .../devicetree/bindings/iio/accel/adi,adxl372.yaml       | 7 ++++---
>  .../devicetree/bindings/iio/accel/bosch,bma220.yaml      | 7 ++++---
>  .../devicetree/bindings/iio/accel/bosch,bma255.yaml      | 5 ++++-
>  .../devicetree/bindings/iio/accel/bosch,bmi088.yaml      | 7 ++++---
>  .../devicetree/bindings/iio/accel/fsl,mma7455.yaml       | 7 ++++---
>  .../devicetree/bindings/iio/accel/kionix,kxsd9.yaml      | 7 ++++---
>  .../devicetree/bindings/iio/accel/murata,sca3300.yaml    | 5 ++++-
>  .../devicetree/bindings/iio/accel/nxp,fxls8962af.yaml    | 7 ++++---
>  14 files changed, 56 insertions(+), 40 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
> index 6f8f8a6258fe..7332442e5661 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
> @@ -27,15 +27,16 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  spi-max-frequency: true
> -
>    vdd-supply: true
>  
>  required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> index 8d829ef878bc..f6f97164c2ca 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> @@ -25,14 +25,15 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  spi-max-frequency: true
> -
>  required:
>    - compatible
>    - reg
>    - interrupts
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> index d6afc1b8c272..7c1bc7810528 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> @@ -22,10 +22,6 @@ properties:
>    reg:
>      maxItems: 1
>  
> -  spi-3wire: true
> -
> -  spi-max-frequency: true
> -
>    vs-supply:
>      description: Regulator that supplies power to the accelerometer
>  
> @@ -48,7 +44,10 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> index 9bb039e2f533..346abfb13a3a 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -32,8 +32,6 @@ properties:
>  
>    spi-cpol: true
>  
> -  spi-max-frequency: true
> -
>    interrupts:
>      maxItems: 1
>  
> @@ -42,7 +40,10 @@ required:
>    - reg
>    - interrupts
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> index ba54d6998f2e..14b487088ab4 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> @@ -45,13 +45,14 @@ properties:
>    vddio-supply:
>      description: Regulator that provides power to the bus
>  
> -  spi-max-frequency: true
> -
>  required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> index d259e796c1d6..f10d98d34cb8 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> @@ -35,8 +35,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  spi-max-frequency: true
> -
>    vdd-supply: true
>    vddio-supply: true
>  
> @@ -45,7 +43,10 @@ required:
>    - reg
>    - interrupts
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> index 38b59b6454ce..73a5c8f814cc 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> @@ -25,14 +25,15 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  spi-max-frequency: true
> -
>  required:
>    - compatible
>    - reg
>    - interrupts
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
> index 942b23ad0712..5dd06f5905b4 100644
> --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
> @@ -20,8 +20,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  spi-max-frequency: true
> -
>    vdda-supply: true
>    vddd-supply: true
>    vddio-supply: true
> @@ -30,7 +28,10 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> index 478e75ae0885..457a709b583c 100644
> --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> @@ -72,7 +72,10 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> index 272eb48eef5a..3cb82576d758 100644
> --- a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> @@ -24,8 +24,6 @@ properties:
>    reg:
>      maxItems: 1
>  
> -  spi-max-frequency: true
> -
>    vdd-supply: true
>  
>    vddio-supply: true
> @@ -50,7 +48,10 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml b/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
> index 7c8f8bdc2333..589ca8178f4a 100644
> --- a/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
> @@ -40,13 +40,14 @@ properties:
>          - "INT1"
>          - "INT2"
>  
> -  spi-max-frequency: true
> -
>  required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
> index 390b87242fcb..f64d99b35492 100644
> --- a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
> @@ -29,13 +29,14 @@ properties:
>    mount-matrix:
>      description: an optional 3x3 mounting rotation matrix.
>  
> -  spi-max-frequency: true
> -
>  required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
> index f6e2a16a710b..00c990caa1e4 100644
> --- a/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
> @@ -29,7 +29,10 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> index ad529ab2c6e2..65ce8ea14b52 100644
> --- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> @@ -27,8 +27,6 @@ properties:
>    vdd-supply:
>      description: phandle to the regulator that provides power to the accelerometer
>  
> -  spi-max-frequency: true
> -
>    interrupts:
>      maxItems: 1
>  
> @@ -44,7 +42,10 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |

