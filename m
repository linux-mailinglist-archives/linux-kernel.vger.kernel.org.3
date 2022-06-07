Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D135402CA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344356AbiFGPw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344354AbiFGPw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:52:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E452CDF5;
        Tue,  7 Jun 2022 08:52:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b8so6897064edj.11;
        Tue, 07 Jun 2022 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7WSf02wzt5xj7U1ZfNwlpnKYaY/88PxrNc7AsMYAPYE=;
        b=oQ65244PK3dAAwIUNJvhfz31nnynzdOZeGl5JqjAaJAwLeB1JwVVzxXRagDTQ+EXr6
         u3pu22m9RAIBN9H4Pj9xbPVAaODI1LXDpsUZKveNxNIDN/LQv4IgtHWguC4ojiu0CGYE
         Ccw6hYBlPQ07LcCW0Vm9HpECMWW7KMOHYNRHUcq/TR2wG0Y6YHac/ly8GDlNOtVsGqch
         W9dSDpmRAgBhhQGVxhbHGGwIXZL9o0md7HJFi2tPvNvEbNCCYfkV4cPl3iES45X4J329
         PhTGVcUs6gdRiAjhonLvZPu4CF0R5DlJhkvpwc0G2dvjC1jWTaDX2pmb5M9R0kdU++EM
         jRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7WSf02wzt5xj7U1ZfNwlpnKYaY/88PxrNc7AsMYAPYE=;
        b=oSVLfcIL7ZxoENglKFnrZU4oFUlsCC0mgHKO8XgFJRkFxEUHrusYtOqZJtd3dJlRBb
         vLX2gSBeFCIkU5sE3qdWm723MDyqJQCeTxMfEGNet6DZsjrDo8zEOVy0GP8rAmGBqdJz
         0zQ+nJsKwvMZN0Xow62bD+RrIJ6al++LM2rbjOWobFXNYGTYZYWmPY1rDJF9NbmdTL/p
         //ZJXd1w+cxqgXHMAIizoS1MnpAxXc0hbbHWw23J+P9YN9PJ7gRh3zxv/5ywvJCXnSD6
         cH4Eybgz5ANV9uwwe4xOWuiNhyjNcakR9oSTx1/gqSRv/1Rbw7QzlG/vrZKEwJpwP00R
         K3uw==
X-Gm-Message-State: AOAM532Y4VizH/CGcwpfmlH0rO8aZPSbEAfNQqpnkm8U1/OFAIuM31iM
        MFlXvX+FJleDpRCFH5VD0dw=
X-Google-Smtp-Source: ABdhPJw4MDtkxa92d06UvmSOWXXa3WAzFhpaCBvDESUtz0E9s01hviCjIvS0eCPxFZbvtUJeYeDjSA==
X-Received: by 2002:a05:6402:528a:b0:42d:e116:fab8 with SMTP id en10-20020a056402528a00b0042de116fab8mr33525868edb.134.1654617144824;
        Tue, 07 Jun 2022 08:52:24 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906348100b00702d8b37a03sm8053692ejb.17.2022.06.07.08.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:24 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 00/17] Add support for AXP192 PMIC
Date:   Tue,  7 Jun 2022 16:53:07 +0100
Message-Id: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
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

Thanks to all reviewers for the feedback on v1. I believe I've made all
the suggested changes, and I've also added support for the battery power
supply in this version.

Changes in v2:

* Do a little cleanup of axp20x_adc suggested by Jonathan Cameron
* Consolidate ADC read functions in axp20x_adc
* Drop the axp192's read_label callback in axp20x_adc
* Clean up the axp192-gpio dt bindings
* Rewrite a problematic bit of code in axp20x_usb_power reported
  by kernel test robot
* Support AXP192 in axp20x_battery
* Split up regmap-irq changes to two separate patches

Cover letter from v1:

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

Aidan MacDonald (17):
  regmap-irq: Use sub_irq_reg() to calculate unmask register address
  regmap-irq: Add get_irq_reg to support unusual register layouts
  dt-bindings: mfd: add bindings for AXP192 MFD device
  dt-bindings: iio: adc: axp209: Add AXP192 compatible
  dt-bindings: power: supply: axp20x: Add AXP192 compatible
  dt-bindings: gpio: Add AXP192 GPIO bindings
  dt-bindings: power: axp20x-battery: Add AXP192 compatible
  mfd: axp20x: Add support for AXP192
  regulator: axp20x: Add support for AXP192
  iio: adc: axp20x_adc: Minor code cleanups
  iio: adc: axp20x_adc: Consolidate ADC raw read functions
  iio: adc: axp20x_adc: Add support for AXP192
  power: supply: axp20x_usb_power: Add support for AXP192
  pinctrl: Add AXP192 pin control driver
  power: axp20x_battery: Add constant charge current table
  power: axp20x_battery: Support battery status without fuel gauge
  power: axp20x_battery: Add support for AXP192

 .../bindings/gpio/x-powers,axp192-gpio.yaml   |  57 ++
 .../bindings/iio/adc/x-powers,axp209-adc.yaml |  18 +
 .../bindings/mfd/x-powers,axp152.yaml         |   1 +
 .../x-powers,axp20x-battery-power-supply.yaml |   1 +
 .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
 drivers/base/regmap/regmap-irq.c              |  19 +-
 drivers/iio/adc/axp20x_adc.c                  | 389 ++++++++++--
 drivers/mfd/axp20x-i2c.c                      |   2 +
 drivers/mfd/axp20x.c                          | 153 +++++
 drivers/pinctrl/Kconfig                       |  14 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-axp192.c              | 589 ++++++++++++++++++
 drivers/power/supply/axp20x_battery.c         | 136 +++-
 drivers/power/supply/axp20x_usb_power.c       |  80 ++-
 drivers/regulator/axp20x-regulator.c          | 101 ++-
 include/linux/mfd/axp20x.h                    |  84 +++
 include/linux/regmap.h                        |   5 +
 17 files changed, 1540 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
 create mode 100644 drivers/pinctrl/pinctrl-axp192.c

-- 
2.35.1

