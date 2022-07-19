Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F705795FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbiGSJR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbiGSJRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:17:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BF520BED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:17:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i132-20020a1c3b8a000000b003a2fa488efdso1182203wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=SZZ37ggY8cL3lV2zqapt5R6LZtjQRuWfQn9rSYJzCQc=;
        b=NAznUbwI5zPQQxFF+/UKcS02hHALSB60T9byhzp09iDqHIySZEV1o2iw4DibD06t/1
         1dYnMVLwa1GKmzOSetFn090mFrvBsZTHiy4Dbj4tJOoN4pGaNEtWiB/0GcGPmfUhLx+x
         9OQjAaif0daX3G/Nz9VBcuy6JzVI46Swn9oVh7RihbtUEg9PTeAINzMuqIAsRJz49GW0
         VLmBdatok+NjPPCi50T7z5cryfVibbysFZljUvvkLVLNE2V13lC7NfSXY9ORRBvLAd1s
         Qa78tpOyopiy6y2QVXfSwGL+9BjW1dZXzJZhr0d2L4uy/QYNNst+Ltd10Y0b1WEEVLim
         4pnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SZZ37ggY8cL3lV2zqapt5R6LZtjQRuWfQn9rSYJzCQc=;
        b=Hscox5TNIt4HfyXlbXrydO1/KN+UOACYzUCnzEJ8S6sbixZiNyLF2ybSMMEPj6C1Dk
         lUq793rVC76G7+50j5OsGD6Zm7yqfZ9QAnoi6MHUXEJ4IF/TvHPbthSox21irQuSArbI
         nzbfwMItcXzI6Flo35TniIzCmt/iJBkxB5n9r7lspUhDWjORUPctG0d8biGbN9NTxqNN
         pDBU04Ev4aJtBNe6eULKa+9ghLupiBEdOXlP2yTpAeEvSW7PkJHxxSZQXzC8zsWgSEUb
         FIF0cABhDracqPnByRT+5oorgzapdMwhNAnbpWYOkrhwvaCIjwsU1+wZSwHVQesenZMt
         fRqw==
X-Gm-Message-State: AJIora8aZqHww+sVYKDKKtBn8z4Yombdh4PdqJz07aAqw+pinX/wG6OO
        fvNFI1r8la5Q0Ry8cC13X+F4CQ==
X-Google-Smtp-Source: AGRyM1ucBnTJMXb3ACZMAXwW8pNBRooM87FAlYHu4qmN5qFiTH9nR4nVhX4m4+Vg291qmM13QHsKDA==
X-Received: by 2002:a1c:7209:0:b0:3a3:1f31:ef3a with SMTP id n9-20020a1c7209000000b003a31f31ef3amr5552976wmc.87.1658222268142;
        Tue, 19 Jul 2022 02:17:48 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b0021d63fe0f03sm12944281wrb.12.2022.07.19.02.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:17:47 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.c, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 00/14] Add support for TI TPS65219 PMIC.
Date:   Tue, 19 Jul 2022 11:17:28 +0200
Message-Id: <20220719091742.3221-1-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes vs RFC:
Use standard regmap helpers only.
Reshaped integrating review feedbacks.

2-Reset WARM/COLD
test procedure: launch reboot on the console and check visually

warm vs. cold can be configured on the kernel command-line at boot time.
Default is cold, but adding `reboot=w`
to kernel command allow testing warm reboot.

Alternative:
`# echo warm > /sys/kernel/reboot/mode` 

Changes vs RFC:
Hooked to standard linux/reboot.h
Add pr_flush to ensure output to console happens.


3-SW Shutdown
test procedure: launch halt on the console and check visually

Note: enters in competition with other source during probe

Board Test Points can be used to check voltage after system shutdown.
baseport is not handling wakeup.
A power OFF/ON cycle is needed to recover.

Changes vs RFC:
Standard system-power-controller has been implemented to enable override.

4-Interrupt Pin (nINT): NEW, was not implemented in RFC

Interrupt occurring on PMIC TPS65219 is propagated to SOC
through EXTINTn pin connected to gic500 interrupt controller

Interrupt lines for TPS65219 shows-up on console:
cat /proc/interrupts

Validation:
Create a Residual Voltage interrupt and handling and interrupt source is cleared.
`tps65219 0-0030: Registered residual voltage for LDO1`
`533:          1          0  tps65219_irq  35 Edge      LDO1_RV`

Mapped to power button (use TP90 to GND to emulate a physical button)

5-PB Startup and Shutdown: NEW, was not implemented in RFC
New implementation to support both rising and falling edge.

TPS65219 has different interrupts compared to other TPS6521* chips.
TPS65219 defines two interrupts for the powerbutton one for push and one
for release.


Interrupt support: cat proc/interrupts
`557:          0          0  tps65219_irq  47 Edge      tps65219-pwrbutton.1.auto`
`558:          0          0  tps65219_irq  48 Edge      tps65219-pwrbutton.1.auto`

Jerome Neanne (9):
  regulator: dt-bindings: Add TI TPS65219 PMIC bindings
  regulator: dt-bindings: Add interrupts support to TPS65219 PMIC
    bindings
  mfd: drivers: Add TI TPS65219 PMIC support
  mfd: drivers: Add interrupts support to TI TPS65219 PMIC
  regulator: drivers: Add TI TPS65219 PMIC regulators support
  arm64: defconfig: Add tps65219 as modules
  arm64: dts: ti: Add TI TPS65219 PMIC support for AM642 SK board.
  arm64: dts: ti: Add pinmux and irq mapping for TPS65219 external
    interrupts
  arm64: defconfig: Add tps65219 power-button as module

Markus Schneider-Pargmann (5):
  MAINTAINERS: OMAP2+ support, add tps65218-pwrbutton
  regulator: dt-bindings: tps65219: Add power-button property
  mfd: tps65219: Add power-button support
  Input: Add tps65219 interrupt driven powerbutton
  arm64: dts: ti: k3-am642-sk: Enable tps65219 power-button

 .../bindings/regulator/ti,tps65219.yaml       | 178 +++++++
 MAINTAINERS                                   |   4 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 117 +++++
 arch/arm64/configs/defconfig                  |   3 +
 drivers/input/misc/Kconfig                    |  10 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/tps65219-pwrbutton.c       | 150 ++++++
 drivers/mfd/Kconfig                           |  15 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/tps65219.c                        | 438 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/tps65219-regulator.c        | 414 +++++++++++++++++
 include/linux/mfd/tps65219.h                  | 364 +++++++++++++++
 14 files changed, 1705 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
 create mode 100644 drivers/input/misc/tps65219-pwrbutton.c
 create mode 100644 drivers/mfd/tps65219.c
 create mode 100644 drivers/regulator/tps65219-regulator.c
 create mode 100644 include/linux/mfd/tps65219.h

-- 
2.17.1

