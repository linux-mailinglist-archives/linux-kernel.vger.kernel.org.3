Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A7D5506DE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiFRVkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiFRVj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:39:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3AB7D6;
        Sat, 18 Jun 2022 14:39:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z7so10318064edm.13;
        Sat, 18 Jun 2022 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hvr1nu2yN593GMlX8fO+Db7irapWGKQJ5Kq9iaHCuaM=;
        b=jAFDSnYK8/BQsquv0b2CwSQCP6pOzp6zNH3EAQI51CFiGEPYjw/rwiI5BKWsbHcqLg
         cetwkRIyIa6YDKHZcBbS1lkkIrI2MYRrqSTXv1v4IGJ2dsiwjGeDP70m89mgTOA1mID9
         kmnfJhbjySezuuJZLjx3VNYjq5SzCty+BbWXel4rY03bjO8dBtB8+SkZL5rk85EkxJyV
         lP2UbaIS/+lqSYikugVlqV/U4xArPCBX7tC/VLGFxTxg13/YThx8pYaqwRzKFQxD0Gh2
         WO48/5g22Va/v8YcbP3VTr3GO5M177F68qBOjhpXvKJ/UG0k7EnRF0f8TcLeeVJ4YkbJ
         2hxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hvr1nu2yN593GMlX8fO+Db7irapWGKQJ5Kq9iaHCuaM=;
        b=QoNm9SHXkTvioX9IDrM7ieCKF/5w0EiMocZnyELKon/JNg3NMRTIse3gcylyjuwyT2
         e9H8qaSpfSDVHIbYYf+rUAVexFYdeZCv3U30iPxy/IuyQGuPYiCNmk1WBJpKI0SNN9dg
         9Az4o7hygjLuLfz5wExTDo7rR3cjXnkOyWJssmNbG3q6y04qSbhP2/9odRg30yNk0IfF
         MqNA3kvQOek6OrGb7/Y2CleJyGn9Q7hR8ooF07mNFVzv1i6bl7GUhQMrHsULE0D4k7VN
         stzGrxqfzHu3U4TP9xhvNOPyDRyIKWJLea8P9I4XiPoDBQIBG6zqgtS0kOTTr1EsBWS6
         0bqA==
X-Gm-Message-State: AJIora/esjZ+clEyZngjNkD5KfzNlxg0DD6o3aCKXWUOF/6t1ZTxn5mS
        dHvqHbWrFzrsHCEr+hUUbvCljT+CRvE=
X-Google-Smtp-Source: AGRyM1tT1x47MeQd6Iylql9Nl6MNb7pG8YHh7zkmkAOKiZFR1Ga8iGYltb/wW4xPNBrnwRMFHI+rFA==
X-Received: by 2002:a05:6402:1941:b0:435:5972:7811 with SMTP id f1-20020a056402194100b0043559727811mr14716285edz.234.1655588396494;
        Sat, 18 Jun 2022 14:39:56 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id k11-20020a17090632cb00b00705cdfec71esm3825355ejk.7.2022.06.18.14.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:39:56 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 00/16] Add support for AXP192 PMIC
Date:   Sat, 18 Jun 2022 22:39:53 +0100
Message-Id: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
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

Changes in v3:

* Update pinctrl driver to address Andy Shevchenko's review comments
  from v1, and fix a few other issues.
* Add gpio-ranges property and example snippet to gpio DT bindings.
* Update commit message of patch 01/16 to point out that all register
  addresses are obtained using sub_irq_reg().
* Document ccc_table in axp20x_battery. Also update commit message to
  note a small fix that is part of that patch.
* Drop axp20x_adc consolidation patch in favor of using separate adc_raw
  functions. It's a minor code size optimization that may not be worth
  the effort due to implementation complexity.
* Use the FIELD_GET macro in axp20x_adc to further clarify intent.
* Fix a typo in the regulator driver where an AXP20X regulator ID was
  mistakenly used instead of an AXP192 regulator ID. Also carry over
  an Acked-by: tag from v1. Hope that's okay.
* Accumulate Acked-by: tags from v1 on DT patches.
* Accumulate Acked-by: tags from v2.

Note that regmap maintainer Mark Brown has said the first two patches to
regmap-irq aren't suitable for inclusion into the kernel in their current
state. I'm including them for v3 so the series remains testable.

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

Aidan MacDonald (16):
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
  iio: adc: axp20x_adc: Add support for AXP192
  power: supply: axp20x_usb_power: Add support for AXP192
  pinctrl: Add AXP192 pin control driver
  power: axp20x_battery: Add constant charge current table
  power: axp20x_battery: Support battery status without fuel gauge
  power: axp20x_battery: Add support for AXP192

 .../bindings/gpio/x-powers,axp192-gpio.yaml   |  68 +++
 .../bindings/iio/adc/x-powers,axp209-adc.yaml |  18 +
 .../bindings/mfd/x-powers,axp152.yaml         |   1 +
 .../x-powers,axp20x-battery-power-supply.yaml |   1 +
 .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
 drivers/base/regmap/regmap-irq.c              |  19 +-
 drivers/iio/adc/axp20x_adc.c                  | 359 +++++++++--
 drivers/mfd/axp20x-i2c.c                      |   2 +
 drivers/mfd/axp20x.c                          | 153 +++++
 drivers/pinctrl/Kconfig                       |  14 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-axp192.c              | 562 ++++++++++++++++++
 drivers/power/supply/axp20x_battery.c         | 143 ++++-
 drivers/power/supply/axp20x_usb_power.c       |  80 ++-
 drivers/regulator/axp20x-regulator.c          | 101 +++-
 include/linux/mfd/axp20x.h                    |  84 +++
 include/linux/regmap.h                        |   5 +
 17 files changed, 1529 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
 create mode 100644 drivers/pinctrl/pinctrl-axp192.c

-- 
2.35.1

