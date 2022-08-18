Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03778598684
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343760AbiHROxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343759AbiHROw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:52:57 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7484BCCE4;
        Thu, 18 Aug 2022 07:52:56 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id j1so1340317qvv.8;
        Thu, 18 Aug 2022 07:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=a4VtptYFiMhs+4gYUKZsYXi/lu0W0eij1h9NsHTMJbo=;
        b=CGJfgPVFzm27bJ/zqJF7438rrGmUKjGMH1N0ArHGUJRCFdQrgbtkQyY0LPKPlaQCeo
         jkY15x8RoxSdDSxZ+saQXMpdskX0xvNDVHy7fWTqcTVkwnoGyGA0X4Tm9iU8ICSz1+MI
         TXXa68j+sQi+doXZq9LxxXboI8MPEEigIWMQCBORfyurUNjJtvOUz3CpTTvsCLHutJfb
         ZGiVhKPCTc9Ht531RVw8Sz3M3zP9dhKVChWmzeVO2Jb1FgHXBXFgVeoi4IUPcTwMJ1AZ
         queb+UquZhIs1ac0p3tI+iuQxmZcgEDF/xiLOcStvs+6sW0cxXbOBl1XUaWr4hIiHMsn
         z4kg==
X-Gm-Message-State: ACgBeo0g0S10EFi1m/+lDDiNQk7VzernilFmkaq3k7ZUHQvZXqbHfvpT
        uuur9uH3GeZDnNIxPn8GRA==
X-Google-Smtp-Source: AA6agR5kgLJINTWzIQpr+fol9UDQPoki4fHlKM3IV9awT2FM/v9Eg7knSU96NbBTawka2w5UCzUhMw==
X-Received: by 2002:a05:6214:c2f:b0:476:dd77:b0f with SMTP id a15-20020a0562140c2f00b00476dd770b0fmr2897401qvd.69.1660834375899;
        Thu, 18 Aug 2022 07:52:55 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:25d2:ea0d:b91c:d10a:6423:3870])
        by smtp.gmail.com with ESMTPSA id bs37-20020a05620a472500b006bb208bd889sm1599501qkb.120.2022.08.18.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:52:55 -0700 (PDT)
Received: (nullmailer pid 1850860 invoked by uid 1000);
        Thu, 18 Aug 2022 14:52:48 -0000
Date:   Thu, 18 Aug 2022 08:52:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?Q?M=C3=A5rten_Lindahl?= <martenli@axis.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andrew Davis <afd@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 00/10] dt-bindings: iio: use spi-peripheral-props.yaml
Message-ID: <20220818145248.GD1829017-robh@kernel.org>
References: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 03:43:11PM +0300, Krzysztof Kozlowski wrote:
> Hi,
> 
> The patchset is independent of my other recent changes around SPI, so feel free
> to apply it for next release.
> 
> Changes since v2
> ================
> 1. Keep spi-3wire also in device bindings (not in spi-peripheral-props.yaml).
> 2. Add Rb tag.
> 
> Changes since v1
> ================
> 1. Continue the rework for entire IIO.
> v1: https://lore.kernel.org/all/20220715095302.214276-1-krzysztof.kozlowski@linaro.org/
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (10):
>   dt-bindings: iio: adc: use spi-peripheral-props.yaml
>   dt-bindings: iio: accel: use spi-peripheral-props.yaml
>   dt-bindings: iio: amplifiers: adi,ada4250: use
>     spi-peripheral-props.yaml
>   dt-bindings: iio: dac: use spi-peripheral-props.yaml
>   dt-bindings: iio: frequency: adf4371: use spi-peripheral-props.yaml
>   dt-bindings: iio: health: ti,afe4403: use spi-peripheral-props.yaml
>   dt-bindings: iio: imu: use spi-peripheral-props.yaml
>   dt-bindings: iio: potentiometer: use spi-peripheral-props.yaml
>   dt-bindings: iio: samsung,sensorhub-rinato: use
>     spi-peripheral-props.yaml
>   dt-bindings: iio: temperature: use spi-peripheral-props.yaml

For the series,

Reviewed-by: Rob Herring <robh@kernel.org>
