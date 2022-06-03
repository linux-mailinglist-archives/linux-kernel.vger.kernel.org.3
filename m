Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7408A53CB00
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244893AbiFCN4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240660AbiFCN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:56:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA439393F4;
        Fri,  3 Jun 2022 06:56:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d5-20020a05600c34c500b0039776acee62so4849414wmq.1;
        Fri, 03 Jun 2022 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Sl8htrp7f/bLQiWVIbkoPljNFJKTHKXwOdHEn31bUE=;
        b=Rfl2TG6tufeeHWTdJNH1teNKgbTh0MtiZmWo+kzB4eCOJ2483TD38xdDYLBPK3hgmu
         cecrH2INclg+a1G4+bEpeQzYVzSuA06+xcxF1XHzqqzuZ+vncQ/LaxGH+cCJAuB4BkuR
         RCimEb3oiFE/mlYGs5eMwEtsyFNwPFGdDlir6oG+QzbXHyXWCusP9DSnGpCf7Zm5XtrW
         eMBkxfziiclXALG6gnXIW8hNrcE0jjJPdyf6wm9qUWaYO2J5y/53SSz5B5bsc5Tj6+8f
         bkTvIh7JRKaQzVnoSl31hZGZgkss6Kol9fmwlEHySpO31diwAtTE4xjMuh21csa6AbM1
         kY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Sl8htrp7f/bLQiWVIbkoPljNFJKTHKXwOdHEn31bUE=;
        b=4ioIsJbeP3CHuVakHpl6pqYn1PrluuJxr0znYfkvGccoAQRBlsdDHxr6ufIq86ioWA
         CupmLlh2qMgIxGLsH3lg47CwcTBcIAKAsKespPMQU96+5cDNGnCipRX+ejOK/G1Ej8wr
         5k03F7MCaOnWgaZqHNktccjJgGzVsDIwjBPRYn4ZOU2gl3/bEihWWubhNan097m/jJKZ
         jEX95vJ3QvIcLjHtpjwlBMZtnN0f/OKTd5Iz7Kmlk7PFfo73eh1M7Q1c5l2kCAZtShKy
         o9S9+e6i5h49DVwDoAigLBioDAbGHE+rfsMC2QVkhw1zsyuniErN2KFM15nMxkmiPFxp
         uxJA==
X-Gm-Message-State: AOAM532EdovK/dkY9BacY64FX4pDw7dRLSMDdMYlwyzAbcp0bqfKS7Kq
        52RYnccggpH+47JytlcDZrE=
X-Google-Smtp-Source: ABdhPJx3G6JcPO9f9Lx4lp6MC10FrxhY916fG6pxQTVuviBsQL7JtetKaQbK8nZ3y/6LrE/2wleVRA==
X-Received: by 2002:a05:600c:1d91:b0:39c:2d34:34e with SMTP id p17-20020a05600c1d9100b0039c2d34034emr7483879wms.55.1654264597300;
        Fri, 03 Jun 2022 06:56:37 -0700 (PDT)
Received: from localhost (92.40.203.126.threembb.co.uk. [92.40.203.126])
        by smtp.gmail.com with ESMTPSA id ay1-20020a5d6f01000000b0020fee88d0f2sm9596400wrb.0.2022.06.03.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:56:36 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] Add support for AXP192 PMIC
Date:   Fri,  3 Jun 2022 14:57:04 +0100
Message-Id: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series adds support for the X-Powers AXP192 PMIC to the
AXP20x driver framework.

The first patch is a small change to regmap-irq to support the AXP192's
unusual IRQ register layout. It isn't possible to include all of the
IRQ registers in one regmap-irq chip without this.

The rest of the changes are pretty straightforward, I think the only
notable parts are the axp20x_adc driver where there seems to be some
opportunities for code reuse (the axp192 is nearly a duplicate of the
axp20x) and the addition of a new pinctrl driver for the axp192, since
the axp20x pinctrl driver was not very easy to adapt.

Aidan MacDonald (10):
  regmap-irq: Add get_irq_reg to support unusual register layouts
  dt-bindings: mfd: add bindings for AXP192 MFD device
  dt-bindings: iio: adc: axp209: Add AXP192 compatible
  dt-bindings: power: supply: axp20x: Add AXP192 compatible
  dt-bindings: gpio: Add AXP192 GPIO bindings
  mfd: axp20x: Add support for AXP192
  regulator: axp20x: Add support for AXP192
  iio: adc: axp20x_adc: Add support for AXP192
  power: supply: axp20x_usb_power: Add support for AXP192
  pinctrl: Add AXP192 pin control driver

 .../bindings/gpio/x-powers,axp192-gpio.yaml   |  59 ++
 .../bindings/iio/adc/x-powers,axp209-adc.yaml |  18 +
 .../bindings/mfd/x-powers,axp152.yaml         |   1 +
 .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
 drivers/base/regmap/regmap-irq.c              |  19 +-
 drivers/iio/adc/axp20x_adc.c                  | 289 ++++++++-
 drivers/mfd/axp20x-i2c.c                      |   2 +
 drivers/mfd/axp20x.c                          | 150 +++++
 drivers/pinctrl/Kconfig                       |  14 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-axp192.c              | 589 ++++++++++++++++++
 drivers/power/supply/axp20x_usb_power.c       |  75 ++-
 drivers/regulator/axp20x-regulator.c          | 101 ++-
 include/linux/mfd/axp20x.h                    |  84 +++
 include/linux/regmap.h                        |   5 +
 15 files changed, 1375 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
 create mode 100644 drivers/pinctrl/pinctrl-axp192.c

-- 
2.35.1

