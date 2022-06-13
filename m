Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B87B548932
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357753AbiFMM7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356023AbiFMMxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:53:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9DED8B;
        Mon, 13 Jun 2022 04:12:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so3873678pjl.5;
        Mon, 13 Jun 2022 04:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uAu/7JYWKp3oO9Ew5zW36EZM8vLHAe2MUQSvRrU0KCU=;
        b=qOA/n9TUulSaWuEEntueeIl15Tc52Mrdtao4+8N/hbZH7nSSkqkcKq5HgNiQejILBX
         xEKYRQ740DxtlR+eeqAS1hXj8yfFR0o+K3/TMHIS1SVixtTJBNG3hi7M+nZ7KUcgEeXf
         YfcwgIT1zZZuEWhSAFvppsMlvE67qNUuUuoZyemMCa7RYoR/zG+A1I7KXN7K7ZAUWwM7
         xBhn4p9bmaSue8+iUnwtPY83+G8qLDWxHqyENc+q1PHQpffTWbkYFVO19TsIavlUibCa
         1bOmR5gGF5eEVRMSE+6g7DLHC9H0XZn0dZ26PKVBj45P/Jm7/a+WoUIfuuXJf+2uFttC
         ihGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uAu/7JYWKp3oO9Ew5zW36EZM8vLHAe2MUQSvRrU0KCU=;
        b=6Mqz40J1I8tw/l1fgHGiUEe0dZg5kUEp1QTpFhlaLOwPJNRBJpOfVu/i7zJXN8usVd
         Q1Ib8ymrQK5Dd+UoF9c94GCBAAX2b4N5HBf/O0CaeLn/FbAswzWxEB1C13zrPgup8Tiz
         eD7y4f4ilUVPVQuP3ZP6KayxOg7+R4c0EO2Uc7PmalTDtwNcJRA2du4AK/2SaqCw9Gez
         EV4K1W0j7N+IcQpMHzT7bsI1r/OsRzGyO6cJyK4Ag6LsT1LAmji2hVKs5wXQlz5SPtO5
         WIlKNYkzFXFYocVpQrZffDDWPcfzsPUttYRVMk3Uh8p2afBHJAeWGSXNBiWNIYeoQci7
         OKeA==
X-Gm-Message-State: AOAM533cZpwb8V//uOIjoMazc30FlS/IOMy7jWrTYyGSSlNEalfuXY2z
        AaVvI7+YWGda3vpO6weULNM=
X-Google-Smtp-Source: ABdhPJwSPCx8VFTSE///2fUU6bdpqYrFaHyryI80Nf1hUuilj72TC5BjLbf98HTK2DjAxP5Onk25tA==
X-Received: by 2002:a17:90a:8546:b0:1e8:61e8:7b2a with SMTP id a6-20020a17090a854600b001e861e87b2amr15165502pjw.228.1655118764475;
        Mon, 13 Jun 2022 04:12:44 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-115-109.emome-ip.hinet.net. [42.72.115.109])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a000b9100b0051b4e53c487sm5199989pfj.45.2022.06.13.04.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 04:12:44 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiaEn Wu <chiaen_wu@richtek.com>
Subject: [PATCH v2 00/15] Add Mediatek MT6370 PMIC support
Date:   Mon, 13 Jun 2022 19:11:31 +0800
Message-Id: <20220613111146.25221-1-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiaEn Wu <chiaen_wu@richtek.com>

This patch series add Mediatek MT6370 PMIC support. The MT6370 is a
highly-integrated smart power management IC, which includes a single
cell Li-Ion/Li-Polymer switching battery charger, a USB
Type-C & Power Delivery (PD) controller, dual Flash LED current sources,
a RGB LED driver, a backlight WLED driver, a display bias driver and a
general LDO for portable devices.

Among with this we took some changes and refined the device tree files to
comply with DT specifications.

Thank you,
ChiaEn Wu

---
Changes in v2:
- In patch 01/15:
		- Add "unevaluatedProperties: false".
		- Delete "DT bindings".
		- Refine the description to fit in 80 columns.
		- Skip the connector description.
- In patch 02/15:
		- Refine items description of interrupt-name
		- Rename "usb-otg-vbus" to "usb-otg-vbus-regulator"
		- Add constraint properties for ADC
- In patch 03/15:
		- Skip not useful description of "^(multi-)?led@[0-3]$"
		  and reg.
		- Due to the dependency, remove the mention of mfd
		  document directory.
		- Delete Soft-start property. In design aspect, we think
		  soft-restart should always be enabled, our new chip
		  has deleted the related setting register , also, we don’t
		  allow user adjust this parameter in this chip.
		- Refine the commit message.
- In patch 04/15:
		- Skip not useful description of "^led@[0-1]$" and reg.
		- Add apace after '#'.
		- Refine the commit message.
- In patch 05/15:
		- Remove "binding documentation" in subject title
		- Refine description of mt6370 backlight binding
		  document
		- Refine properties name(bled-pwm-hys-input-bit,
		  bled-ovp-microvolt, bled-ocp-microamp) and their
		  description
- In patch 06/15:
		- Refine ADC and Regulator descriptions
		- Refine include header usage in example
		- Refine node name to generic node name("pmic@34")
		- Refine led example indentation
		- Refine license of mediatek,mt6370_adc.h
		- Rename the dts example from IRQ define to number.
		- Remove mediatek,mt6370.h
- In patch 07/15:
		- Add ABI documentation for mt6370 non-standard ADC
		  sysfs interfaces.
- In patch 08/15:
		- Add all IRQ define into mt6370.c.
		- Refine include header usage
- In patch 09/15:
		- No changes.
- In patch 10/15:
		- Use 'gpiod_get_from_of_node' to replace
		  'fwnode_gpiod_get_index'.
- In patch 11/15:
		- Refine Kconfig mt6370 help text
		- Refine mask&shift to FIELD_PREP()
		- Refine mutex lock name ("lock" -> "adc_lock")
		- Refine mt6370_adc_read_scale()
		- Refine mt6370_adc_read_offset()
		- Refine mt6370_channel_labels[] by using enum to index
		  chan spec
		- Refine MT6370_ADC_CHAN()
		- Refine indio_dev->name
		- Remove useless include header files
- In patch 12/15:
		- Refine mt6370_chg_otg_rdesc.of_match
		  ("mt6370,otg-vbus" -> "usb-otg-vbus-regulator") to match
		  DT binding
- In patch 13/15:
		- Refine Kconfig description.
		- Remove include "linux/of.h" and use
		  "linux/mod_devicetable.h".
		- Place a comma for the last element of the const
		  unsigned int array.
		- Add a comment line for the mutex 'lock'.
		- In probe function, use 'dev_err_probe' in some
		  judgement to reduce the LOC.
		- Refine include header usage.
		  BIT/GENMASK -> linux/bits.h
		  FIELD_GET -> linux/bitfield.h
- In patch 14/15:
		- Add blank line.
		- Replace container_of() with to_mt6370_led() .
		- Refine description of ramping.
		- Refine the mt6370_init_common_properties function.
		- Refine the probe return.
- In patch 15/15:
		- Refine MT6370 help text in Kconfig
		- Refine DT Parse function
		- Remove useless enum
		- Add comment for 6372 backward compatible in
		  bl_update_status() and
		  check_vendor_info()
		- Using dev_err_probe(); insteads dev_err()&return; in
		  the probe()

Alice Chen (2):
  dt-bindings: leds: Add Mediatek MT6370 flashlight
  leds: flashlight: mt6370: Add Mediatek MT6370 flashlight support

ChiYuan Huang (8):
  dt-bindings: usb: Add Mediatek MT6370 TCPC
  dt-bindings: leds: mt6370: Add Mediatek mt6370 current sink type LED
    indicator
  dt-bindings: backlight: Add Mediatek MT6370 backlight
  dt-bindings: mfd: Add Mediatek MT6370
  mfd: mt6370: Add Mediatek MT6370 support
  usb: typec: tcpci_mt6370: Add Mediatek MT6370 tcpci driver
  regulator: mt6370: Add mt6370 DisplayBias and VibLDO support
  leds: mt6370: Add Mediatek MT6370 current sink type LED Indicator
    support

ChiaEn Wu (5):
  dt-bindings: power: supply: Add Mediatek MT6370 Charger
  Documentation: ABI: testing: mt6370: Add ADC sysfs guideline
  iio: adc: mt6370: Add Mediatek MT6370 support
  power: supply: mt6370: Add Mediatek MT6370 charger driver
  video: backlight: mt6370: Add Mediatek MT6370 support

 .../ABI/testing/sysfs-bus-iio-adc-mt6370      |   36 +
 .../backlight/mediatek,mt6370-backlight.yaml  |  107 ++
 .../leds/mediatek,mt6370-flashlight.yaml      |   44 +
 .../leds/mediatek,mt6370-indicator.yaml       |   48 +
 .../bindings/mfd/mediatek,mt6370.yaml         |  279 ++++
 .../power/supply/mediatek,mt6370-charger.yaml |   60 +
 .../bindings/usb/mediatek,mt6370-tcpc.yaml    |   36 +
 drivers/iio/adc/Kconfig                       |    9 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/mt6370-adc.c                  |  262 ++++
 drivers/leds/Kconfig                          |   11 +
 drivers/leds/Makefile                         |    1 +
 drivers/leds/flash/Kconfig                    |    9 +
 drivers/leds/flash/Makefile                   |    1 +
 drivers/leds/flash/leds-mt6370-flash.c        |  657 ++++++++++
 drivers/leds/leds-mt6370.c                    |  989 ++++++++++++++
 drivers/mfd/Kconfig                           |   13 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/mt6370.c                          |  349 +++++
 drivers/power/supply/Kconfig                  |   11 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/mt6370-charger.c         | 1132 +++++++++++++++++
 drivers/regulator/Kconfig                     |    8 +
 drivers/regulator/Makefile                    |    1 +
 drivers/regulator/mt6370-regulator.c          |  388 ++++++
 drivers/usb/typec/tcpm/Kconfig                |    8 +
 drivers/usb/typec/tcpm/Makefile               |    1 +
 drivers/usb/typec/tcpm/tcpci_mt6370.c         |  212 +++
 drivers/video/backlight/Kconfig               |    9 +
 drivers/video/backlight/Makefile              |    1 +
 drivers/video/backlight/mt6370-backlight.c    |  339 +++++
 .../dt-bindings/iio/adc/mediatek,mt6370_adc.h |   18 +
 32 files changed, 5042 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6370
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
 create mode 100644 drivers/iio/adc/mt6370-adc.c
 create mode 100644 drivers/leds/flash/leds-mt6370-flash.c
 create mode 100644 drivers/leds/leds-mt6370.c
 create mode 100644 drivers/mfd/mt6370.c
 create mode 100644 drivers/power/supply/mt6370-charger.c
 create mode 100644 drivers/regulator/mt6370-regulator.c
 create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6370.c
 create mode 100644 drivers/video/backlight/mt6370-backlight.c
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h

-- 
2.25.1

