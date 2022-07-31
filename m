Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9A1585E80
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiGaKt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGaKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:49:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4749FC8;
        Sun, 31 Jul 2022 03:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 20F0ECE0E5F;
        Sun, 31 Jul 2022 10:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF50C433C1;
        Sun, 31 Jul 2022 10:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659264588;
        bh=PUNN+rCT3YXN5pehv7cULkzpQnreNsgjU2b4qW3dOto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bejCl17Yd2Tvvo8nEdqDOHsy6MvrBm2YL4gdQtABzahCWd1IyD+yGqMbF12AxcAWe
         qAygk10Ha3H7fLFiBYQSB4iWD8kP2ijEKXmypi14eeKaUCHteH4bhwLNmaBA6Bp2vT
         niOdnThWuwAMSrAFmciEp7SwuJkvJCdV+xSsz1NR8TnBHwOFi3s9AmyHhKwNiUfI87
         T1Eg1ckCHjMqwRXwMk+cHD9wlP1VYfhCv1AU0WOBX5W9xX7nAp1xgR06+kSBUCF73O
         oDuiVbu2X4nk0Ec512FsjObYmYNNDOTvLjek+grtmp63BtCjYzqdbVEJqFNsla+Vqc
         Rw/q6SHFNAfjA==
Date:   Sun, 31 Jul 2022 11:59:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Belisko <marek@goldelico.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/1] spi/panel: dt-bindings: drop CPHA and CPOL from
 common properties
Message-ID: <20220731115955.1977f429@jic23-huawei>
In-Reply-To: <20220722191539.90641-2-krzysztof.kozlowski@linaro.org>
References: <20220722191539.90641-1-krzysztof.kozlowski@linaro.org>
        <20220722191539.90641-2-krzysztof.kozlowski@linaro.org>
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

On Fri, 22 Jul 2022 21:15:39 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> The spi-cpha and spi-cpol properties are device specific and should be
> accepted only if device really needs them.  Drop them from common
> spi-peripheral-props.yaml schema, mention in few panel drivers which use
> them and include instead in the SPI controller bindings.  The controller
> bindings will provide CPHA/CPOL type validation and one place for
> description.  Each device schema must list the properties if they are
> applicable.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This seems like a good solution to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../bindings/display/panel/lgphilips,lb035q02.yaml    |  3 +++
>  .../bindings/display/panel/samsung,ld9040.yaml        |  3 +++
>  .../bindings/display/panel/sitronix,st7789v.yaml      |  3 +++
>  .../devicetree/bindings/display/panel/tpo,td.yaml     |  3 +++
>  .../devicetree/bindings/spi/spi-controller.yaml       | 11 +++++++++++
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml | 10 ----------
>  6 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml b/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
> index 5e4e0e552c2f..628c4b898111 100644
> --- a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
> @@ -21,6 +21,9 @@ properties:
>    enable-gpios: true
>    port: true
>  
> +  spi-cpha: true
> +  spi-cpol: true
> +
>  required:
>    - compatible
>    - enable-gpios
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
> index d525165d6d63..c0fabeb38628 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
> @@ -42,6 +42,9 @@ properties:
>    panel-height-mm:
>      description: physical panel height [mm]
>  
> +  spi-cpha: true
> +  spi-cpol: true
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> index 9e1d707c2ace..d984b59daa4a 100644
> --- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> @@ -23,6 +23,9 @@ properties:
>    backlight: true
>    port: true
>  
> +  spi-cpha: true
> +  spi-cpol: true
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/display/panel/tpo,td.yaml b/Documentation/devicetree/bindings/display/panel/tpo,td.yaml
> index f902a9d74141..e8c8ee8d7c88 100644
> --- a/Documentation/devicetree/bindings/display/panel/tpo,td.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/tpo,td.yaml
> @@ -28,6 +28,9 @@ properties:
>    backlight: true
>    port: true
>  
> +  spi-cpha: true
> +  spi-cpol: true
> +
>  required:
>    - compatible
>    - port
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 678cee68b52a..655713fba7e2 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -95,6 +95,17 @@ patternProperties:
>      type: object
>      $ref: spi-peripheral-props.yaml
>  
> +    properties:
> +      spi-cpha:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The device requires shifted clock phase (CPHA) mode.
> +
> +      spi-cpol:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The device requires inverse clock polarity (CPOL) mode.
> +
>      required:
>        - compatible
>        - reg
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 5e32928c4fc3..2349f83c07f3 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -34,16 +34,6 @@ properties:
>      description:
>        The device requires 3-wire mode.
>  
> -  spi-cpha:
> -    $ref: /schemas/types.yaml#/definitions/flag
> -    description:
> -      The device requires shifted clock phase (CPHA) mode.
> -
> -  spi-cpol:
> -    $ref: /schemas/types.yaml#/definitions/flag
> -    description:
> -      The device requires inverse clock polarity (CPOL) mode.
> -
>    spi-cs-high:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:

