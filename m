Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5439F582FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbiG0Rah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241857AbiG0R1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:27:14 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6BE7E33B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:47:03 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q7so5012550ljp.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/yOyu6GWLTGzcNYsjeLpWfd27RAacTfDstKqyrSAoE=;
        b=zftOa3M+Qu3zYg8ILzX3Ol1djhj/t7SAeRxKo972bNgpWrEhJmClL+UZJsvsRWxOSV
         8YI2mWF521w9R+aNiQ6iKDDtb7skefK3alDkEo6BmHQN+oUIAACk602U2irOo/AIwH86
         i4pVQhhseEc8K7cqlXODXGwym4vCD4qbbwS9QksbzonBYHSVGUrzPJV0b57ArJjbO9vC
         Pob8fY5MMnhQdmtQww3LEKd9bSKQKIwje2tvqVKXYv8LtIWfIpeTHPamspElaXoe1jhC
         E3fY9mKLFffhlf+V519K2wx1AhWxbEeRXvU/hHUYcGP/vVM/o2ZFJeno4AtnaWeSrmrv
         VORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/yOyu6GWLTGzcNYsjeLpWfd27RAacTfDstKqyrSAoE=;
        b=rw0lvtNoriDU2mYYyRJxmEZIsWoKwSNfkS9RF+Mu6XKmtBhKbBSWFWuDqxI63fbjq+
         dLlck9tDhV5DKo9j5e4xQJFdtpezRymT8ioYcb9XhlKzp4LkokIg6nGucmHzXfgwv2Oq
         a/+XBHcU60AvmDBXfas++hWGFcJg7XZfyyaIUmISLka3+DZ/mbQzyb8+gPa+i8lNJn35
         7QM3X0lVZIBdQfbp74fPUdtMsSorzlDl2UCicpTiyIFapB31XM0Ao94v3q1+cLPSocVS
         lTeoRZar+9ovE/Wsr2hYR1hV8OVUAFBTrbER1Tr+fcQqFNCkqst+lZBhZa/gcdNK7Zgl
         Fn+A==
X-Gm-Message-State: AJIora/RTMqrz2evTHaXKKJ4ez1MhlBRVcG7tYG0b2T1kg2zy6e1woKz
        geWNJSF6UrAQXzvqGOlEpONnsg==
X-Google-Smtp-Source: AGRyM1shwAJq5nKlVyuZgIIaEFt3mg7AsEO781aqRRSC7Qt8FRX7YiWFyEaXLzhx6TvoTrEe0YwYGA==
X-Received: by 2002:a05:651c:11c5:b0:25e:22c9:19e1 with SMTP id z5-20020a05651c11c500b0025e22c919e1mr1242993ljo.428.1658940421850;
        Wed, 27 Jul 2022 09:47:01 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048910301774sm3375149lfz.307.2022.07.27.09.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:47:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>,
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
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 00/10] dt-bindings: iio: use spi-peripheral-props.yaml
Date:   Wed, 27 Jul 2022 18:46:36 +0200
Message-Id: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Technically, this depends on [1] merged to SPI tree, if we want to
preserve existing behavior of not allowing SPI CPHA and CPOL in each of
schemas in this patch.

If this patch comes independently via different tree, the SPI CPHA and
CPOL will be allowed for brief period of time, before [1] is merged.
This will not have negative impact, just DT schema checks will be
loosened for that period.

[1] https://lore.kernel.org/all/20220722191539.90641-2-krzysztof.kozlowski@linaro.org/

Changes since v1
================
1. Continue the rework for entire IIO.
v1: https://lore.kernel.org/all/20220715095302.214276-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (10):
  dt-bindings: iio: adc: use spi-peripheral-props.yaml
  dt-bindings: iio: accel: use spi-peripheral-props.yaml
  dt-bindings: iio: amplifiers: adi,ada4250: use
    spi-peripheral-props.yaml
  dt-bindings: iio: dac: use spi-peripheral-props.yaml
  dt-bindings: iio: frequency: adf4371: use spi-peripheral-props.yaml
  dt-bindings: iio: health: ti,afe4403: use spi-peripheral-props.yaml
  dt-bindings: iio: imu: use spi-peripheral-props.yaml
  dt-bindings: iio: potentiometer: use spi-peripheral-props.yaml
  dt-bindings: iio: samsung,sensorhub-rinato: use
    spi-peripheral-props.yaml
  dt-bindings: iio: temperature: use spi-peripheral-props.yaml

 .../bindings/iio/accel/adi,adis16201.yaml     |  7 ++---
 .../bindings/iio/accel/adi,adis16240.yaml     |  7 ++---
 .../bindings/iio/accel/adi,adxl313.yaml       |  9 +++----
 .../bindings/iio/accel/adi,adxl345.yaml       |  7 ++---
 .../bindings/iio/accel/adi,adxl355.yaml       |  7 ++---
 .../bindings/iio/accel/adi,adxl367.yaml       |  7 ++---
 .../bindings/iio/accel/adi,adxl372.yaml       |  7 ++---
 .../bindings/iio/accel/bosch,bma220.yaml      |  7 ++---
 .../bindings/iio/accel/bosch,bma255.yaml      |  5 +++-
 .../bindings/iio/accel/bosch,bmi088.yaml      |  7 ++---
 .../bindings/iio/accel/fsl,mma7455.yaml       |  7 ++---
 .../bindings/iio/accel/kionix,kxsd9.yaml      |  7 ++---
 .../bindings/iio/accel/murata,sca3300.yaml    |  5 +++-
 .../bindings/iio/accel/nxp,fxls8962af.yaml    |  7 ++---
 .../bindings/iio/adc/adi,ad7124.yaml          |  7 ++---
 .../bindings/iio/adc/adi,ad7192.yaml          |  7 ++---
 .../bindings/iio/adc/adi,ad7280a.yaml         |  7 ++---
 .../bindings/iio/adc/adi,ad7292.yaml          |  7 ++---
 .../bindings/iio/adc/adi,ad7298.yaml          |  6 +++--
 .../bindings/iio/adc/adi,ad7476.yaml          |  8 +++---
 .../bindings/iio/adc/adi,ad7606.yaml          |  7 ++---
 .../bindings/iio/adc/adi,ad7768-1.yaml        |  7 ++---
 .../bindings/iio/adc/adi,ad7923.yaml          |  7 ++---
 .../bindings/iio/adc/adi,ad7949.yaml          |  7 ++---
 .../bindings/iio/adc/holt,hi8435.yaml         |  7 ++---
 .../bindings/iio/adc/lltc,ltc2496.yaml        |  8 +++---
 .../bindings/iio/adc/maxim,max1027.yaml       |  5 +++-
 .../bindings/iio/adc/maxim,max11100.yaml      |  7 +++--
 .../bindings/iio/adc/maxim,max1118.yaml       | 26 ++++++++++---------
 .../bindings/iio/adc/maxim,max1241.yaml       |  7 ++---
 .../bindings/iio/adc/microchip,mcp3201.yaml   |  6 +++--
 .../bindings/iio/adc/microchip,mcp3911.yaml   |  5 +++-
 .../bindings/iio/adc/ti,adc0832.yaml          |  7 ++---
 .../bindings/iio/adc/ti,adc084s021.yaml       |  7 ++---
 .../bindings/iio/adc/ti,adc108s102.yaml       |  6 +++--
 .../bindings/iio/adc/ti,adc12138.yaml         |  7 ++---
 .../bindings/iio/adc/ti,adc128s052.yaml       |  7 ++---
 .../bindings/iio/adc/ti,adc161s626.yaml       |  7 ++---
 .../bindings/iio/adc/ti,ads124s08.yaml        |  7 ++---
 .../bindings/iio/adc/ti,ads131e08.yaml        |  7 ++---
 .../bindings/iio/adc/ti,ads8344.yaml          |  7 ++---
 .../bindings/iio/adc/ti,ads8688.yaml          |  7 ++---
 .../bindings/iio/adc/ti,tlc4541.yaml          |  7 ++---
 .../bindings/iio/adc/ti,tsc2046.yaml          |  7 ++---
 .../bindings/iio/amplifiers/adi,ada4250.yaml  |  7 ++---
 .../bindings/iio/dac/adi,ad5064.yaml          |  7 +++--
 .../bindings/iio/dac/adi,ad5360.yaml          |  7 +++--
 .../bindings/iio/dac/adi,ad5380.yaml          |  9 ++++---
 .../bindings/iio/dac/adi,ad5421.yaml          |  7 ++---
 .../bindings/iio/dac/adi,ad5449.yaml          |  7 +++--
 .../bindings/iio/dac/adi,ad5624r.yaml         |  9 ++++---
 .../bindings/iio/dac/adi,ad5686.yaml          |  9 ++++---
 .../bindings/iio/dac/adi,ad5755.yaml          |  9 ++++---
 .../bindings/iio/dac/adi,ad5758.yaml          |  4 +--
 .../bindings/iio/dac/adi,ad5761.yaml          |  7 +++--
 .../bindings/iio/dac/adi,ad5764.yaml          |  7 +++--
 .../bindings/iio/dac/adi,ad5770r.yaml         |  7 ++---
 .../bindings/iio/dac/adi,ad5791.yaml          |  9 ++++---
 .../bindings/iio/dac/adi,ad8801.yaml          |  7 +++--
 .../bindings/iio/dac/microchip,mcp4922.yaml   |  9 ++++---
 .../bindings/iio/dac/ti,dac082s085.yaml       |  9 ++++---
 .../bindings/iio/dac/ti,dac7311.yaml          |  7 ++---
 .../bindings/iio/dac/ti,dac7612.yaml          |  7 ++---
 .../bindings/iio/frequency/adf4371.yaml       |  7 ++---
 .../bindings/iio/health/ti,afe4403.yaml       |  9 ++++---
 .../bindings/iio/imu/adi,adis16460.yaml       |  7 ++---
 .../bindings/iio/imu/adi,adis16480.yaml       |  9 ++++---
 .../bindings/iio/imu/bosch,bmi160.yaml        |  7 ++---
 .../bindings/iio/imu/invensense,icm42600.yaml |  6 +++--
 .../bindings/iio/imu/invensense,mpu6050.yaml  |  5 ++--
 .../bindings/iio/imu/nxp,fxos8700.yaml        |  7 ++---
 .../bindings/iio/imu/st,lsm6dsx.yaml          |  9 ++++---
 .../iio/potentiometer/microchip,mcp41010.yaml |  9 ++++---
 .../iio/potentiometer/microchip,mcp4131.yaml  |  9 ++++---
 .../iio/samsung,sensorhub-rinato.yaml         |  9 ++++---
 .../iio/temperature/maxim,max31855k.yaml      |  4 +--
 .../iio/temperature/maxim,max31856.yaml       |  6 +++--
 .../iio/temperature/maxim,max31865.yaml       |  6 +++--
 78 files changed, 324 insertions(+), 249 deletions(-)

-- 
2.34.1

