Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810F356852D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiGFKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiGFKSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:18:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D1818E13;
        Wed,  6 Jul 2022 03:18:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s1so21354305wra.9;
        Wed, 06 Jul 2022 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6XVkH+FRDklHSQ61jiiN/g1120SGYSf462Y0l/EHI00=;
        b=QUjNNww5rGPJNE+NyXbivOvx14LJuS8Eyluh3ExEWQSjeLsrOpW7XUUpk4bAhxUW0a
         PPOXoKKmSsiETJXrxn7/+j6LkHpaWIuOkZvvMaM6+T6dkFRY4+ky7F1vNPgJOtaL0iHE
         ilF620FU52IOZio4rCx4kyrEOSyodoLg4jc/ZAsOZTR4O/+kSOkvhpO5A/uMqskAUpiC
         23Co7WW25VK3n0rLUZAQHule/BaZkY+swDT41o3320wP7hQuWXXpFTc/bQ8ZUfhi6gam
         X7i+bVr78PSdWQ6h7/tcpn6Ar7vS1lMn+KCBCw/bkZEW15yXZMUbu3ByChfuHzo/QsF0
         hHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6XVkH+FRDklHSQ61jiiN/g1120SGYSf462Y0l/EHI00=;
        b=EtfDY44pAlhLdJoUvNSMk479WeaWIFeugBN2enmMNOp6Zy50Vd0HpEkklwt7wO7jzy
         XrwrMApZRioZR5hSF2s5snP8bIR93MAe+NK6bA7SLqZdeyIi6P+WUEauCrfGuzmq8PzG
         qI0AJGT8Wv+WQuQPpv0Bgh9npBWd0FU8a4INmMGCHfTsulYkHPC0h3OUCMdiGNhbIgkU
         qCrSZ/oc25EVA0IxlViMQpUPpJy5hE3V8DUG/eY7WIhL+dXcuRc66xRFXB5zLA7c+L4A
         WEcnnxMZ9LMHQdugUHcYbhsWhtwLpO01ipAdEZ16in3VSYdI9WAqKRQrmGNlUxtBPGn6
         8EhA==
X-Gm-Message-State: AJIora8gjv6ejVlum/42YtpilZVddZ+aZ3GkAjozVw8UQIQ2/IS5MlfZ
        RyBwiIYDdbdbzHv7V+xSogw=
X-Google-Smtp-Source: AGRyM1udRsGsiYwhrOGBdZg4xYw3DrzUKBGkZO5JGyaWrsQHHOSQOZQV68TakS3QPX7GdVpvA4tH2w==
X-Received: by 2002:a05:6000:601:b0:21d:7f3e:e231 with SMTP id bn1-20020a056000060100b0021d7f3ee231mr1258354wrb.219.1657102710127;
        Wed, 06 Jul 2022 03:18:30 -0700 (PDT)
Received: from localhost (92.40.202.167.threembb.co.uk. [92.40.202.167])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000100300b0021b943a50b3sm35917569wrx.85.2022.07.06.03.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:18:29 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 00/13] Add support for AXP192 PMIC
Date:   Wed,  6 Jul 2022 11:18:49 +0100
Message-Id: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
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

This series adds support for the AXP192 PMIC to the AXP20x MFD driver
framework, including support for regulators, ADCs, and AC/USB/battery
power supplies.

This depends on the "regmap-irq cleanups and refactoring" series[1]
for the ->get_irq_reg() operation, needed by the AXP192's IRQ chip.

Changes in v5:

* Drop everything related to GPIO / pin control. It seems that driver
  is going to require further discussion while the rest of the series
  probably won't need much at this point, and I'd rather not hold the
  whole series up over one driver.

Older changelogs can be found in v4[2].

[1]: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/
[2]: https://lore.kernel.org/lkml/20220629143046.213584-1-aidanmacdonald.0x0@gmail.com/

Aidan MacDonald (13):
  dt-bindings: mfd: add bindings for AXP192 MFD device
  dt-bindings: iio: adc: axp209: Add AXP192 compatible
  dt-bindings: power: supply: axp20x: Add AXP192 compatible
  dt-bindings: power: axp20x-battery: Add AXP192 compatible
  mfd: axp20x: Add support for AXP192
  regulator: axp20x: Add support for AXP192
  iio: adc: axp20x_adc: Minor code cleanups
  iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field
  iio: adc: axp20x_adc: Add support for AXP192
  power: supply: axp20x_usb_power: Add support for AXP192
  power: axp20x_battery: Add constant charge current table
  power: axp20x_battery: Support battery status without fuel gauge
  power: axp20x_battery: Add support for AXP192

 .../bindings/iio/adc/x-powers,axp209-adc.yaml |  18 +
 .../bindings/mfd/x-powers,axp152.yaml         |   1 +
 .../x-powers,axp20x-battery-power-supply.yaml |   1 +
 .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
 drivers/iio/adc/axp20x_adc.c                  | 356 ++++++++++++++++--
 drivers/mfd/axp20x-i2c.c                      |   2 +
 drivers/mfd/axp20x.c                          | 141 +++++++
 drivers/power/supply/axp20x_battery.c         | 142 ++++++-
 drivers/power/supply/axp20x_usb_power.c       |  84 ++++-
 drivers/regulator/axp20x-regulator.c          | 100 ++++-
 include/linux/mfd/axp20x.h                    |  84 +++++
 11 files changed, 856 insertions(+), 74 deletions(-)


base-commit: e35e5b6f695d241ffb1d223207da58a1fbcdff4b
prerequisite-patch-id: a45db1cac7537769dc10087fc61f977dc150744c
prerequisite-patch-id: cb8aa009c7bb7a6575eb05e3af65342dc8d0efa3
prerequisite-patch-id: 8d32557e53b894d1fb17250d2d0eb3673f068d37
prerequisite-patch-id: 5b293867ef81e3697892ac51b941bb53680a70dc
prerequisite-patch-id: 8138d39a4817e804141bfe8c2ad37d9c55456a40
prerequisite-patch-id: b01216129e887519d441cf556bbc75c397871773
prerequisite-patch-id: b5dcf0c0609113c2d81bc557c1fc95ef23f40811
prerequisite-patch-id: 622ca1c10e851b1889aaa567c1d2a0adf43cca44
prerequisite-patch-id: d28c5187f9bf0e43f27b2f4aa8dcf7fd91842a03
prerequisite-patch-id: d29d54b756be73304f844abeeaf9b46a5c0119d5
prerequisite-patch-id: 5d405790ae89c0831b46a359f86e94bac5a67470
prerequisite-patch-id: c90120e79acbb52ffa148bfedee1df9d35b5eced
-- 
2.35.1

