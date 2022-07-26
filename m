Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2404E581138
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbiGZKeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbiGZKeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:34:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9043D2CC88
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:34:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q18so9110588wrx.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=L7cF1S0BR1iDtQS+rWz5OxrcNphL8d0/4H/6zzg8gsk=;
        b=FKiEkDsrBPnIBGldU7/Qea96rNYXmsCKktbZ+rZhW1SF9qhz7BSd61lB5Ksq3Lg0r8
         BSiBaQKv6OcEnFLxscbl8Ha/bhjIrdfpc3VC+rtoI6I9u1J/mne7u0uqIovexwzevepg
         aIwXxr/q8Go41bLTToTa4zZx0MZPYotCm27bIIqIPZdQE6tIxGzhKw0VXtGVZnlIMHi1
         ZuZsQe086wdw5OBuUDmLqTprsfBQdMfL7JJf+FkU8ZDDy9EnE67RbZsN4L9FFoc7CfOs
         L2enuSZYREynQRhUwIBGEutAh157j+iVWgz6tw7u3RGso9Z/DmJlQk8aNR4jlr2rttQ8
         41hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L7cF1S0BR1iDtQS+rWz5OxrcNphL8d0/4H/6zzg8gsk=;
        b=focw4n6NFy9H9x/dAz2KlbERTOoglG7o4EWB5AY19PE+FrhXzpxwGTFUtzvO4kJ2GQ
         QTsuKHV1p7zZ+KEOwQvv11c/2dlUw/gT6xozIzAPMZClPqscRid927NceNaxyYHgW2JZ
         /pisGpIQqaB21WkGScjK/WjJqxV894oCtXTRGWggcGVGt59VqyqqsG10wfAixI6j4cXU
         3CAHXnOadKbjVAAYgMSLM5d2Zv78wgv2+pKURjVU0DXv1EBwq/rp+s5mOgkX45UVqjJn
         1lx5Zp+zwiWqhdD6oc7M8ldS9H3UtaQCdNY4TJuRHFssZOUYvwMbJAvyPkb2IZM5H+J+
         P4vQ==
X-Gm-Message-State: AJIora+5Duu+FIL6aLRD1sAHXUBxhF6pQpDCsC/kpfmtfjouVqaYMd3S
        dvWSPzCEI7/PgNS5H/XGH3WuTw==
X-Google-Smtp-Source: AGRyM1uyiuaZ7sRQ/+/0vbZseRe6hCKHZv5K0YV4/qCtSPx8WCUAqPe3SrO3oPl2godcD/NnhhmFXA==
X-Received: by 2002:adf:e18b:0:b0:21e:894e:48c with SMTP id az11-20020adfe18b000000b0021e894e048cmr6008220wrb.341.1658831644991;
        Tue, 26 Jul 2022 03:34:04 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-4641-6f91-91b7-326a-5d27-a1c3.rev.sfr.net. [2a02:8440:4641:6f91:91b7:326a:5d27:a1c3])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b003a2e42ae9a4sm20617121wmb.14.2022.07.26.03.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:34:04 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/11] Add support for TI TPS65219 PMIC.
Date:   Tue, 26 Jul 2022 12:33:44 +0200
Message-Id: <20220726103355.17684-1-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not implemented
- DVS

1-Regulators:
Full implementation and test
Visual check: cat /sys/kernel/debug/regulator/regulator_summary
Full validation requires userspace-consumer and virtual-regulator
LDO1 is not used and output can be probbed on TP84.

2-Reset WARM/COLD
test procedure: launch reboot on the console and check visually

warm vs. cold can be configured on the kernel command-line at boot time.
Default is cold, but adding `reboot=w`
to kernel command allow testing warm reboot.

Alternative:
`# echo warm > /sys/kernel/reboot/mode` 

3-SW Shutdown
test procedure: launch halt on the console and check visually

Note: enters in competition with other source during probe

Board Test Points can be used to check voltage after system shutdown.
baseport is not handling wakeup.
A power OFF/ON cycle is needed to recover.

4-Interrupt Pin (nINT):

Interrupt occurring on PMIC TPS65219 is propagated to SOC
through EXTINTn pin connected to gic500 interrupt controller

Interrupt lines for TPS65219 shows-up on console:
cat /proc/interrupts

Validation:
Create a Residual Voltage interrupt and handling and interrupt source is cleared.
`tps65219 0-0030: Registered residual voltage for LDO1`
`533:          1          0  tps65219_irq  35 Edge      LDO1_RV`

Mapped to power button (use TP90 to GND to emulate a physical button)

5-PB Startup and Shutdown:
New implementation to support both rising and falling edge.

TPS65219 has different interrupts compared to other TPS6521* chips.
TPS65219 defines two interrupts for the powerbutton one for push and one
for release.


Interrupt support: cat proc/interrupts
`557:          0          0  tps65219_irq  47 Edge      tps65219-pwrbutton.1.auto`
`558:          0          0  tps65219_irq  48 Edge      tps65219-pwrbutton.1.auto`

TPS65219 has a multipurpose pin called EN/PB/VSENSE that can be either:
- EN in which case it functions as an enable pin.
- VSENSE which compares the voltages and triggers an automatic on/off request.
- PB in which case it can be configured to trigger an interrupt to the SoC.
ti,power-button reflects the last one of those options
where the board has a button wired to the pin and triggers
an interrupt on pressing it.

6-Changes vs v1:

6.1- Regulators:
- Further to Mark Brown review:
Use standard regmap helpers for set_voltage, enable and disable.
tps65219_set_mode, return -EINVAL in default statement for clarity.
Reshaped irq handler to report events through the notification API:
regulator_notifier_call_chain().
Use standard regulator events (consumer.h).

6.2- Device tree
- Further to Nishanth Menon review:
add tag DONOTMERGE
Board support is pending waiting for TI commitment.
This device tree is needed for driver test purpose but should not go upstream.

6.3- Bindings
- Further to Rob Herring review:
Squash interrupt commit into regulator dt-binding.
Squash pwrbutton commit into regulator dt-binding.
Remove interrupt-controller/cells properties because no consumer for those interrupts.

- Further to Mark Brown review:
Remove constraints on regulator-name.

- Pending for decision from Lee Jones further to Mark Brown review
The entire binding document should probably be in MFD if it's going to
have properties for other functions added to it.

6.4- Misc
- Further to Mark Brown review:
Use C++ (//) formatting for file header block including SPDX License
in mfd, regulator and pwrbutton.

Jerome Neanne (7):
  DONOTMERGE: arm64: dts: ti: Add TI TPS65219 PMIC support for AM642 SK
    board.
  DONOTMERGE: arm64: dts: ti: Add pinmux and irq mapping for TPS65219
    external interrupts
  regulator: dt-bindings: Add TI TPS65219 PMIC bindings
  mfd: drivers: Add TI TPS65219 PMIC support
  mfd: drivers: Add interrupts support to TI TPS65219 PMIC
  regulator: drivers: Add TI TPS65219 PMIC regulators support
  arm64: defconfig: Add tps65219 as modules

Markus Schneider-Pargmann (4):
  DONOTMERGE: arm64: dts: ti: k3-am642-sk: Enable tps65219 power-button
  MAINTAINERS: OMAP2+ support, add tps65218-pwrbutton
  mfd: tps65219: Add power-button support
  Input: Add tps65219 interrupt driven powerbutton

 .../bindings/regulator/ti,tps65219.yaml       | 164 +++++++
 MAINTAINERS                                   |   4 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 115 +++++
 arch/arm64/configs/defconfig                  |   3 +
 drivers/input/misc/Kconfig                    |  10 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/tps65219-pwrbutton.c       | 150 ++++++
 drivers/mfd/Kconfig                           |  15 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/tps65219.c                        | 437 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/tps65219-regulator.c        | 416 +++++++++++++++++
 include/linux/mfd/tps65219.h                  | 364 +++++++++++++++
 14 files changed, 1690 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
 create mode 100644 drivers/input/misc/tps65219-pwrbutton.c
 create mode 100644 drivers/mfd/tps65219.c
 create mode 100644 drivers/regulator/tps65219-regulator.c
 create mode 100644 include/linux/mfd/tps65219.h

-- 
2.17.1

