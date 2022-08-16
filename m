Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D22595C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbiHPMnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiHPMnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:43:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F1B9FFF
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:43:33 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id by6so10377646ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=AdLiJiQjcl9HDPKJkrKE1iI+melu2hq3hGx8aDYqrGE=;
        b=EUKi3xQOQ78BxZyhZC7NntxLnDi8HA7UjoBDApogZY2MDv5NxxeRhe27sSPtXPTdv9
         qtfgR1sAAHWoSxeNqDOF6jeqTOifdTETlFVACKJEQPSmKZA/P0SXlJpu4t9NH0YDeYTe
         SAFZhHiXko8IedT/MstR36LT3ccKQXNljp6eARBCQWWK0PC+XehVxWQtRxOXLk/ZndZx
         JuunaNlpzxdGg+pXw0rBDgX7ECJRHIUMYuNfhjnSIEmBNvfkBnTOvXIRJYaq35ixzggV
         3vNR/auVlNgTQb41Pk8WJPsSw8mAAR0aF14TNYaChQpF3lNzcy0rCqrrVeHP80zIM6ek
         uxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=AdLiJiQjcl9HDPKJkrKE1iI+melu2hq3hGx8aDYqrGE=;
        b=Avo3rf1yU+uYggOFbdm5a5Lhbj5+GTAFNQrZT466Vt5qWl7/rDZFtvKpWIhBWxmuqU
         c645ysDLsPmipH0bJjImVtqtAr+5cDoL1Rin/zdlUHb/qoKvroMWR+Hjp+RZdtwId4+n
         yCLtHPccufxfCJJFBOZwlYn6sxl3NJ+HwRvfFUIEV3jKvHDOonJyLRzhsJphnkBBJiaf
         21IaODV0smssTIowLH9Fug2SXVq+xxZ0mYW8ptMzZ12cy5DoEqEma1HCPb3i2zN8nJFL
         i1xWvaRSgZ5qFruRemRihaJgH0Z03vyOCeRpvc6Ins6f06IHMpYTsEKYvsWiqChGGb5i
         nfJw==
X-Gm-Message-State: ACgBeo0Wgb1jBDn4sG8cr92ZwHQ+qwV+gaxyc7ICV8Y8pwYo3SQAUaEC
        sCRoXf6y/OReedtTlvFcoaYnzQ==
X-Google-Smtp-Source: AA6agR4gQkEWsCtCKfK5BDqrGYgQen/BiyTzMJGGfwZ6Se+PxAslWxilY6QSzX5cUjpwbsyWPZThXg==
X-Received: by 2002:a05:651c:515:b0:25f:dce6:2e95 with SMTP id o21-20020a05651c051500b0025fdce62e95mr6568831ljp.327.1660653811790;
        Tue, 16 Aug 2022 05:43:31 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b0048ae4cf8a2csm1374331lfo.258.2022.08.16.05.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:43:31 -0700 (PDT)
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
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>,
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 00/10] dt-bindings: iio: use spi-peripheral-props.yaml
Date:   Tue, 16 Aug 2022 15:43:11 +0300
Message-Id: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patchset is independent of my other recent changes around SPI, so feel free
to apply it for next release.

Changes since v2
================
1. Keep spi-3wire also in device bindings (not in spi-peripheral-props.yaml).
2. Add Rb tag.

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
 .../bindings/iio/accel/adi,adxl313.yaml       |  7 ++---
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
 78 files changed, 324 insertions(+), 247 deletions(-)

-- 
2.34.1

