Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6A5602B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiF2O3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiF2O3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:29:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCA11EC55;
        Wed, 29 Jun 2022 07:29:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v14so22749097wra.5;
        Wed, 29 Jun 2022 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/PXRQGK8TJhXm19HFrifqHWkSQsE6OVYhnj4QH2dbs4=;
        b=VW+dcxw5pDUMc2R231H81MOut5zXYYNiZKBO1O1EW9swi5295A8xm2UcgY2UFrsq0g
         dg6lyN+sQkPpTrXV16+yRmp1p21AE75/tTCoKy6LmzBcuS4HXnph2QWgsWePlvqjjcl1
         4QN8agZFs8pn0anSi9SMyoYRsX/Yd0DR28HgNcO8srzGZvN3AJ+JosrkOOQnhDOrp5fu
         fMwuny2ja/xbfyrKczzd0N3AeIZeCJIZOvcgQVAi1BTsLk6dY30qG+yJh8GFEdklkkuQ
         v/rTRUComnyn811y57iNgF7pJY+7kHtCs1QLLSN+bmYSe8Y0EP2FV7OEJeUIauE1g2c8
         cP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/PXRQGK8TJhXm19HFrifqHWkSQsE6OVYhnj4QH2dbs4=;
        b=yjb23Gs5i0wmNNvbA3n/ZUzSrEIkQnagC717i4OdXZK6sSwYka/6+6OSzl/7JD6XDa
         tPCQVu3tZ5MKHev9LSOy2aAtoE1n9DyLLuGN7IYqiV/Ag1MOkr17Nvzy4St9xMNbsD+f
         Uq+fVnHtDpBh4CBFoRRo77hyo3hdonShRlLasUIRQv08Kbky/xBqGis2vKZFy30drNtP
         7Q8UEd70f6eDIHnGmljh5JL4LKof3OwCSOZmo4OfTzEjm/EXF4YC8ByZJGNeG6+5ZU14
         90yY5UcrPJ666abW8n/zUs/eR25tJe6tqqJmWDqiAMjxJh7MlxFJxL6c4YEMKmpr9iiC
         P5PA==
X-Gm-Message-State: AJIora+XMPc8bSx58VMPeCmflbIUX4Pdrm8KTooUooWr5r5zD+y6132p
        G5EVmvPPxaCjBNe/ucKawBreWro0S9w=
X-Google-Smtp-Source: AGRyM1v2kIb49CgnzoHkrPteakkrLfTXsqf1qyOdMzWAE3i4yZ7XkCNRei6Be7GYEixE+CrQK9sxtw==
X-Received: by 2002:a05:6000:1d84:b0:20e:5fae:6e71 with SMTP id bk4-20020a0560001d8400b0020e5fae6e71mr3504337wrb.224.1656512984923;
        Wed, 29 Jun 2022 07:29:44 -0700 (PDT)
Received: from localhost (92.40.168.16.threembb.co.uk. [92.40.168.16])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600c20c600b003a0426fae52sm3291758wmm.24.2022.06.29.07.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:29:44 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        sre@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 00/15] Add support for AXP192 PMIC
Date:   Wed, 29 Jun 2022 15:30:31 +0100
Message-Id: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
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

Changes in v4:

* Drop regmap-irq patches and rebase on top of the regmap-irq
  refactoring series[1], which implements the same functionality.
* Reorder mfd_cells, putting one-line entries at the bottom.
* Fix incorrect example in axp192-gpio device tree bindings.
* Perform adc_en2 flag -> adc_en2_mask conversion in axp20x_adc
  as a separate patch.
* Simplify axp192_usb_power_set_current_max().
* Drop unneeded OF dependency in pin control driver, and document
  tables used for describing register layouts.
* Various style fixups suggested by Andy Shevchenko.

[1]: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/

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

Aidan MacDonald (15):
  dt-bindings: mfd: add bindings for AXP192 MFD device
  dt-bindings: iio: adc: axp209: Add AXP192 compatible
  dt-bindings: power: supply: axp20x: Add AXP192 compatible
  dt-bindings: gpio: Add AXP192 GPIO bindings
  dt-bindings: power: axp20x-battery: Add AXP192 compatible
  mfd: axp20x: Add support for AXP192
  regulator: axp20x: Add support for AXP192
  iio: adc: axp20x_adc: Minor code cleanups
  iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field
  iio: adc: axp20x_adc: Add support for AXP192
  power: supply: axp20x_usb_power: Add support for AXP192
  pinctrl: Add AXP192 pin control driver
  power: axp20x_battery: Add constant charge current table
  power: axp20x_battery: Support battery status without fuel gauge
  power: axp20x_battery: Add support for AXP192

 .../bindings/gpio/x-powers,axp192-gpio.yaml   |  68 ++
 .../bindings/iio/adc/x-powers,axp209-adc.yaml |  18 +
 .../bindings/mfd/x-powers,axp152.yaml         |   1 +
 .../x-powers,axp20x-battery-power-supply.yaml |   1 +
 .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
 drivers/iio/adc/axp20x_adc.c                  | 356 +++++++++--
 drivers/mfd/axp20x-i2c.c                      |   2 +
 drivers/mfd/axp20x.c                          | 152 +++++
 drivers/pinctrl/Kconfig                       |  13 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-axp192.c              | 598 ++++++++++++++++++
 drivers/power/supply/axp20x_battery.c         | 142 ++++-
 drivers/power/supply/axp20x_usb_power.c       |  84 ++-
 drivers/regulator/axp20x-regulator.c          | 100 ++-
 include/linux/mfd/axp20x.h                    |  84 +++
 15 files changed, 1547 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
 create mode 100644 drivers/pinctrl/pinctrl-axp192.c

-- 
2.35.1

