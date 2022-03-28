Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D114E979D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242474AbiC1NKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243045AbiC1NKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:10:45 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079B113CD7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:08:57 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2e5e31c34bfso147896847b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Ay76oyJhUHbsDCaK8E3W4NPXHmWTlr325diqJd2z68k=;
        b=p88zezJ3/WWaJHGjroXJ5VvubeMX9eJhd27BS1kppz4qC4BVpbbwp9na0DoWjnE8LN
         CkuxeBXxvxtLYV8M76iCGASYqLQ8wo2yqJXL8eDzbvevB5b9SehxTzvKj+dq5dH6PzF0
         r0mjpiwCFbzlRlLrb5i2EnRCi2RELn6ITHt2pnxbV4ZktU+rP6N3rgqMVU6hMMWimSfb
         Nk0NFKVZ8tTtWdU6qXAUc1B3PoCReJJZzcJ/u3M/9XxFV2PbXe5fHy4kF9e4B21wK1CT
         VCpH4mGa0eBM0dfPq8H2aIEdSXweCDNcPfAbicxqpm2oeBU63cpPw0RyFPbCxib3hw9B
         20Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Ay76oyJhUHbsDCaK8E3W4NPXHmWTlr325diqJd2z68k=;
        b=bVRjt1c1eVP74ls4qH2ip4//1nny9uBtjHifXgVXY6aOmdppcU+VpKd+P0mftXTBFn
         uBAiN+GxhLIym4khR9vtdNUY3oGgV092JDTs+ze1I4p97dCep2Ot5Tsj3mqOqfq1ywNL
         1uUpVYNxZKjlKW0Bba8p6ZssZzr+rlQAQHCxRgC/5rMum03UGBnwrH1pQQrOG8SGYUaI
         foHCw3AIoYXyh0mdNKUtzYN/S/+kyekYelgSpi4U+TJwrKD6E7x8nQ1dxXqRSmftsa2G
         OhhemPzZWzxdHCgvheLTV372H+QdoTWCG0+wmF7IHd8I8j5kaGUoz4OL1kvyWXznSmP9
         xEVw==
X-Gm-Message-State: AOAM533GNJoFtt3cSVDtbln+CHdPScIyMTQxK7tOCe9PDRRNYG869AD+
        4vfIvzAeZ50+InzO27gEJYJSRQ5ehA7lfmkbIFN7/Q==
X-Google-Smtp-Source: ABdhPJyC25QBbJ650NNEEOk0JJwrQfgd1h92gA7u3HqAsrtaI3QDLqa5vXzPGp1mYB1xgTwFsaIOVNcSTenpvD21Ax0=
X-Received: by 2002:a0d:d68e:0:b0:2e5:9f48:a24a with SMTP id
 y136-20020a0dd68e000000b002e59f48a24amr25862511ywd.151.1648472933347; Mon, 28
 Mar 2022 06:08:53 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Mar 2022 15:08:42 +0200
Message-ID: <CACRpkdZ_Jr3OzfoOpSSsAJMy1Oe_=zD861jouDzCVD-BQ6yZMg@mail.gmail.com>
Subject: [GIT PULL] pin control bulk changes for v5.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this is the bulk of pin control changes for v5.18. Wanted to send
it earlier but the tree was a bit shaky so I had to wait and stabilize it
for a bit.

The one thing to notice is that the patch
4649b97042c3 ("pinctrl: sunxi: Use unique lockdep classes for IRQs")
appears again: this was already queued for next when it turned out
to be needed for v5.17 fixes. Entire sets of patches were pulled on
top. Not the prettiest, but git sorts it out flawlessly as there is no
textual difference (identical patch) though it is annoying to have it
in the history, such things happen.

The other details are in the signed tag, please pull it in!

Yours,
Linus Walleij

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07=
:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.18-1

for you to fetch changes up to 4a6d01495a167762de1691eb51e0413954db20eb:

  pinctrl: mediatek: common-v1: fix semicolon.cocci warnings
(2022-03-27 14:00:42 +0200)

----------------------------------------------------------------
Pin control bulk changes for the v5.18 kernel cycle

No core changes this time. Just new driver code and improvements!

New drivers:

- New driver for the Broadcom BCM4908 SoC.

- New subdriver for Tesla FSD (Full Self Driving) SoC, a
  derivative of the Samsung Exynos pin control driver.

- New driver for the Amlogic Meson S4 SoC.

- New driver for the Sunplus SP7021 SoC.

- New driver for the Microsemi Ocelot family ServalT SoC.

- New subdriver for Intel Alder Lake-M SoC.

- New subdriver for Intel Ice Lake-N SoC, including PCH support.

- New subdriver for Renesas R8A779F0 SoC.

- New subdriver for Mediatek MT8186 SoC.

- New subdriver for NXP Freescale i.MX93 SoC.

- New driver for Nuvoton WPCM450 SoC.

- New driver for Qualcomm SC8280XP SoC.

Improvements:

- Wakeup support on Samsung Exynos850 and ExynosAutov9.

- Serious and voluminous maintenance cleanup and refactoring in
  the Renesas drivers. Mainly sharing similar data between the
  different SoC subdrivers.

- Qualcomm SM8450 EGPIO support.

- Drive strength support on the Mediatek MT8195.

- Add some missing groups and functions to the Ralink RT2880.

----------------------------------------------------------------
Aidan MacDonald (1):
      pinctrl: ingenic: Fix regmap on X series SoCs

Alexander Stein (1):
      pinctrl: imx: Reduce printk message level for empty nodes

Alim Akhtar (2):
      dt-bindings: pinctrl: samsung: Add compatible for Tesla FSD SoC
      pinctrl: samsung: add FSD SoC specific data

Andy Shevchenko (6):
      pinctrl: Place correctly CONFIG_PINCTRL_ST in the Makefile
      pinctrl: intel: Fix a glitch when updating IRQ flags on a
preconfigured line
      pinctrl: tigerlake: Revert "Add Alder Lake-M ACPI ID"
      pinctrl: alderlake: Add Raptor Lake-S ACPI ID
      pinctrl: alderlake: Add Intel Alder Lake-N pin controller support
      pinctrl: icelake: Add Ice Lake-N PCH pin controller support

AngeloGioacchino Del Regno (8):
      pinctrl: mediatek: pinctrl-moore: Simplify with dev_err_probe()
      pinctrl: mediatek: pinctrl-paris: Simplify with dev_err_probe()
      pinctrl: mediatek: pinctrl-mtk-common: Simplify with dev_err_probe()
      pinctrl: mediatek: paris: Unify probe function by using OF match data
      pinctrl: mediatek: common-v1: Add common probe function
      pinctrl: mediatek: common-v1: Use common probe function
      pinctrl: mediatek: common-v1: Commonize spec_pupd callback
      pinctrl: mediatek: common-v1: Commonize spec_ies_smt_set callback

Ar=C4=B1n=C3=A7 =C3=9CNAL (1):
      dt-bindings: pinctrl: rt2880: add missing pin groups and functions

Biju Das (3):
      dt-bindings: pinctrl: renesas: Document RZ/V2L pinctrl
      pinctrl: renesas: Kconfig: Select PINCTRL_RZG2L if RZ/V2L SoC is enab=
led
      pinctrl: renesas: rzg2l: Improve rzg2l_gpio_register()

Bjorn Andersson (2):
      dt-bindings: pinctrl: qcom: Add sc8280xp TLMM binding
      pinctrl: qcom: Introduce sc8280xp TLMM driver

Chen-Yu Tsai (9):
      dt-bindings: pinctrl: mt8195: fix bias-pull-{up,down} checks
      pinctrl: pinconf-generic: Print arguments for bias-pull-*
      pinctrl: mediatek: paris: Fix PIN_CONFIG_BIAS_* readback
      pinctrl: mediatek: paris: Fix "argument" argument type for
mtk_pinconf_get()
      pinctrl: mediatek: paris: Fix pingroup pin config state readback
      pinctrl: mediatek: paris: Drop extra newline in mtk_pctrl_show_one_pi=
n()
      pinctrl: mediatek: paris: Skip custom extra pin config dump for
virtual GPIOs
      pinctrl: mediatek: paris: Rework mtk_pinconf_{get,set} switch/case lo=
gic
      pinctrl: mediatek: paris: Support generic PIN_CONFIG_DRIVE_STRENGTH_U=
A

Colin Ian King (1):
      pinctl: doc: Fix spelling mistake "resisitors" -> "resistors"

Dan Carpenter (1):
      pinctrl: nuvoton: wpcm450: off by one in wpcm450_gpio_register()

Dmitry Baryshkov (1):
      pinctrl: qcom-pmic-gpio: Add support for pm8450

Douglas Anderson (1):
      dt-bindings: pinctrl: drive-strength doesn't default to 2 if unspecif=
ied

Gary Bisson (1):
      pinctrl: meson-g12a: add more pwm_f options

Geert Uytterhoeven (90):
      pinctrl: renesas: r8a7790: Remove INTC_IRQx_N
      pinctrl: renesas: r8a7791: Remove INTC_IRQx_N
      pinctrl: renesas: r8a779a0: Rename MOD_SEL2_* definitions
      pinctrl: renesas: r8a7779: Restore pin function sort order
      pinctrl: renesas: r8a7790: Restore pin function sort order
      pinctrl: renesas: r8a77995: Restore pin group sort order
      pinctrl: renesas: r8a7794: Add range checking to .pin_to_pocctrl()
      pinctrl: renesas: r8a77470: Reduce size for narrow VIN1 channel
      pinctrl: renesas: Rename sh_pfc_soc_operations instances
      pinctrl: renesas: Reformat macros defining struct initializers
      pinctrl: renesas: Rename SH_PFC_PIN_GROUP{,_ALIAS} args
      pinctrl: renesas: Add generic support for pin group subsets
      pinctrl: renesas: Add generic support for resizable buses
      pinctrl: renesas: r8a7740: Share BSC pin group data
      pinctrl: renesas: emev2: Share CF pin group data
      pinctrl: renesas: r8a7791: Share HSCIF1 pin group data
      pinctrl: renesas: sh73a0: Share KEYIN pin group data
      pinctrl: renesas: r8a7740: Share LCD pin group data
      pinctrl: renesas: sh73a0: Share LCD pin group data
      pinctrl: renesas: r8a73a4: Share MMC pin group data
      pinctrl: renesas: r8a7740: Share MMC pin group data
      pinctrl: renesas: r8a77470: Share MMC pin group data
      pinctrl: renesas: r8a7778: Share MMC pin group data
      pinctrl: renesas: r8a7779: Share MMC pin group data
      pinctrl: renesas: r8a7790: Share MMC pin group data
      pinctrl: renesas: r8a7791: Share MMC pin group data
      pinctrl: renesas: r8a7794: Share MMC pin group data
      pinctrl: renesas: r8a77970: Share MMC pin group data
      pinctrl: renesas: r8a77980: Share MMC pin group data
      pinctrl: renesas: r8a77995: Share MMC pin group data
      pinctrl: renesas: r8a779a0: Share MMC pin group data
      pinctrl: renesas: sh73a0: Share MMC pin group data
      pinctrl: renesas: r8a77470: Share QSPI pin group data
      pinctrl: renesas: r8a7790: Share QSPI pin group data
      pinctrl: renesas: r8a7791: Share QSPI pin group data
      pinctrl: renesas: r8a7792: Share QSPI pin group data
      pinctrl: renesas: r8a7794: Share QSPI pin group data
      pinctrl: renesas: r8a77950: Share QSPI pin group data
      pinctrl: renesas: r8a77951: Share QSPI pin group data
      pinctrl: renesas: r8a77965: Share QSPI pin group data
      pinctrl: renesas: r8a7796: Share QSPI pin group data
      pinctrl: renesas: r8a77990: Share QSPI pin group data
      pinctrl: renesas: r8a779a0: Share QSPI pin group data
      pinctrl: renesas: r8a77970: Share RPC pin group data
      pinctrl: renesas: r8a77980: Share RPC pin group data
      pinctrl: renesas: r8a73a4: Share SDHI pin group data
      pinctrl: renesas: r8a7740: Share SDHI pin group data
      pinctrl: renesas: r8a77470: Share SDHI pin group data
      pinctrl: renesas: r8a7778: Share SDHI pin group data
      pinctrl: renesas: r8a7779: Share SDHI pin group data
      pinctrl: renesas: r8a7790: Share SDHI pin group data
      pinctrl: renesas: r8a7791: Share SDHI pin group data
      pinctrl: renesas: r8a7792: Share SDHI pin group data
      pinctrl: renesas: r8a7794: Share SDHI pin group data
      pinctrl: renesas: r8a77950: Share SDHI pin group data
      pinctrl: renesas: r8a77951: Share SDHI pin group data
      pinctrl: renesas: r8a77965: Share SDHI pin group data
      pinctrl: renesas: r8a7796: Share SDHI pin group data
      pinctrl: renesas: r8a77990: Share SDHI pin group data
      pinctrl: renesas: sh73a0: Share SDHI pin group data
      pinctrl: renesas: emev2: Share SDI pin group data
      pinctrl: renesas: r8a7790: Share USB1 pin group data
      pinctrl: renesas: r8a7790: Share more VIN pin group data
      pinctrl: renesas: r8a77951: Share more VIN pin group data
      pinctrl: renesas: r8a7796: Share more VIN pin group data
      pinctrl: renesas: r8a77965: Share more VIN pin group data
      pinctrl: renesas: r8a77990: Share more VIN pin group data
      pinctrl: renesas: Remove unused pfc parameter from .pin_to_pocctrl()
      pinctrl: renesas: Factor out .pin_to_portcr() address handling
      pinctrl: renesas: Pass sh_pfc_soc_info to rcar_pin_to_bias_reg()
      pinctrl: renesas: checker: Simplify same_name()
      pinctrl: renesas: checker: Add pin group sharing checks
      pinctrl: renesas: checker: Validate bias configs consistency
      pinctrl: renesas: checker: Validate drive strength configs consistenc=
y
      pinctrl: renesas: checker: Validate I/O voltage configs consistency
      pinctrl: renesas: checker: Check bias pin conflicts
      pinctrl: renesas: checker: Check drive pin conflicts
      pinctrl: renesas: checker: Fix miscalculation of number of states
      pinctrl: renesas: Remove unneeded #include <linux/gpio.h>
      pinctrl: renesas: Add PORT_GP_CFG_19 macros
      pinctrl: renesas: Initial R8A779F0 PFC support
      pinctrl: renesas: r8a779f0: Add SCIF pins, groups, and functions
      pinctrl: renesas: r8a779f0: Add I2C pins, groups, and functions
      pinctrl: renesas: r8a779f0: Add HSCIF pins, groups, and functions
      pinctrl: renesas: r8a779f0: Add INTC-EX pins, groups, and function
      pinctrl: renesas: r8a779f0: Add MMC pins, groups, and function
      pinctrl: renesas: r8a779f0: Add MSIOF pins, groups, and functions
      pinctrl: renesas: r8a779f0: Add PCIe pins, groups, and function
      pinctrl: renesas: r8a779f0: Add QSPI pins, groups, and functions
      pinctrl: renesas: r8a779f0: Add Ethernet pins, groups, and functions

Guodong Liu (3):
      dt-bindings: pinctrl: mt8186: add pinctrl file and binding document
      pinctrl: add pinctrl driver on mt8186
      pinctrl: canonical rsel resistance selection property

Hans de Goede (1):
      pinctrl: baytrail: Clear direct_irq_en flag on broken configs

Horatiu Vultur (4):
      dt-bindings: pinctrl: ocelot: Add ServalT SoC support
      pinctrl: ocelot: Add support for ServalT SoC
      dt-bindings: pinctrl: pinctrl-microchip-sgpio: Fix example
      pinctrl: ocelot: Fix interrupt parsing

Jacky Bai (1):
      pinctrl: imx93: Add pinctrl driver support

Jialin Zhang (1):
      pinctrl: nuvoton: Fix return value check in wpcm450_gpio_register()

Joel Stanley (1):
      dt-bindings: pinctrl: aspeed: Update gfx node in example

Jonathan Marek (2):
      pinctrl: qcom: sm8450: Add egpio support
      pinctrl: qcom: print egpio mode in debugfs

Jonathan Neusch=C3=A4fer (5):
      pinctrl: nuvoton: npcm7xx: Use %zu printk format for ARRAY_SIZE()
      pinctrl: nuvoton: npcm7xx: Rename DS() macro to DSTR()
      dt-bindings: pinctrl: Add Nuvoton WPCM450
      pinctrl: nuvoton: Add driver for WPCM450
      pinctrl: nuvoton: wpcm450: select GENERIC_PINCTRL_GROUPS

Krzysztof Kozlowski (5):
      pinctrl: samsung: drop pin banks references on error paths
      pinctrl: samsung: accept GPIO bank nodes with a suffix
      dt-bindings: pinctrl: samsung: convert to dtschema
      dt-bindings: pinctrl: samsung: describe Exynos850 and
ExynosAutov9 wake-ups
      pinctrl: samsung: add support for Exynos850 and ExynosAutov9 wake-ups

Kunihiko Hayashi (3):
      pinctrl: uniphier: Add missing audio pinmux settings for PXs2 SoC
      pinctrl: uniphier: Divide pinmux group to support 1ch and 2ch I2S
      pinctrl: uniphier: Add USB device pinmux settings

LUU HOAI (1):
      dt-bindings: pinctrl: renesas,pfc: Document r8a779f0 support

Lad Prabhakar (2):
      pinctrl: at91-pio4: Use platform_get_irq() to get the interrupt
      dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Add description for
power-source property

Linus Walleij (6):
      Merge tag 'renesas-pinctrl-for-v5.18-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Merge tag 'samsung-pinctrl-5.18-2' of
https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung into
devel
      Merge tag 'renesas-pinctrl-for-v5.18-tag2' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Merge tag 'intel-pinctrl-v5.18-1' of
gitolite.kernel.org:pub/scm/linux/kernel/git/pinctrl/intel into devel
      pinctrl: mediatek: mt8186: Account for probe refactoring
      pinctrl: nuvoton: Fix sparse warning

Luca Weiss (1):
      dt-bindings: pinctrl: qcom: msm8953: allow gpio-reserved-ranges

Manivannan Sadhasivam (1):
      pinctrl: qcom: Return -EINVAL for setting affinity if no IRQ parent

Mans Rullgard (1):
      pinctrl: sunxi: do not print error message for EPROBE_DEFER

Martin J=C3=BCcker (1):
      pinctrl: samsung: improve wake irq info on console

Meng Tang (1):
      pinctrl: berlin: fix error return code of berlin_pinctrl_build_state(=
)

Miaoqian Lin (3):
      pinctrl: mediatek: Fix missing of_node_put() in mtk_pctrl_init
      pinctrl: nomadik: Add missing of_node_put() in nmk_pinctrl_probe
      pinctrl/rockchip: Add missing of_node_put() in rockchip_pinctrl_probe

Michael Walle (7):
      pinctrl: ocelot: fix confops resource index
      pinctrl: ocelot: fix duplicate debugfs entry
      pinctrl: microchip-sgpio: lock RMW access
      pinctrl: microchip-sgpio: don't do RMW for interrupt ack register
      pinctrl: microchip-sgpio: use regmap_update_bits()
      pinctrl: microchip-sgpio: return error in spgio_output_set()
      pinctrl: microchip-sgpio: wait until output is actually set

Minghao Chi (1):
      drivers/pinctrl: remove redundant ret variable

Nikita Yushchenko (1):
      pinctrl: renesas: r8a7799[05]: Add MediaLB pins

Peng Fan (1):
      dt-bindings: pinctrl: imx93: Add pinctrl binding

Qianggui Song (3):
      dt-bindings: pinctrl: meson: Add compatible for S4
      dt-bindings: gpio: Add a header file for Amlogic Meson S4
      pinctrl: meson: add pinctrl driver support for Meson-S4 Soc

Rafa=C5=82 Mi=C5=82ecki (2):
      dt-bindings: pinctrl: Add binding for BCM4908 pinctrl
      pinctrl: bcm: add driver for BCM4908 pinmux

Rayyan Ansari (2):
      dt-bindings: pinctrl: qcom,pmic-mpp: Document PM8226 compatible
      pinctrl: qcom: spmi-mpp: Add PM8226 compatible

Sam Protsenko (1):
      pinctrl: samsung: Remove EINT handler for Exynos850 ALIVE and CMGP gp=
ios

Samuel Holland (1):
      pinctrl: sunxi: Use unique lockdep classes for IRQs

Shawn Guo (1):
      pinctrl: qcom: qcm2290: Add GPIO wakeirq map

Srinivas Neeli (1):
      pinctrl: zynq: use module_platform_driver to simplify the code

Tinghan Shen (1):
      dt-bindings: pinctrl: mt8195: Add mediatek,drive-strength-adv propert=
y

Tom Rix (1):
      pinctrl: qcom: cleanup comments

Wells Lu (2):
      dt-bindings: pinctrl: Add dt-bindings for Sunplus SP7021
      pinctrl: Add driver for Sunplus SP7021

Wolfram Sang (1):
      pinctrl: renesas: rcar: Do not enforce GPIO if already muxed

Zheng Bin (1):
      pinctrl: nuvoton: wpcm450: Fix build error without OF

kernel test robot (2):
      pinctrl: starfive: fix semicolon.cocci warnings
      pinctrl: mediatek: common-v1: fix semicolon.cocci warnings

=C5=81ukasz Bartosik (1):
      pinctrl: intel: fix unexpected interrupt

 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |   16 +
 .../bindings/pinctrl/brcm,bcm11351-pinctrl.txt     |    2 +-
 .../bindings/pinctrl/brcm,bcm4908-pinctrl.yaml     |   72 +
 .../bindings/pinctrl/fsl,imx93-pinctrl.yaml        |   85 +
 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |    1 +
 .../bindings/pinctrl/microchip,sparx5-sgpio.yaml   |    2 +-
 .../bindings/pinctrl/mscc,ocelot-pinctrl.txt       |    4 +-
 .../bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml  |  160 ++
 .../bindings/pinctrl/pinctrl-mt8186.yaml           |  297 +++
 .../bindings/pinctrl/pinctrl-mt8195.yaml           |   65 +-
 .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml     |    2 +
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |    1 +
 .../devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml |    1 +
 .../bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml    |  151 ++
 .../bindings/pinctrl/qcom,tlmm-common.yaml         |    1 -
 .../bindings/pinctrl/ralink,rt2880-pinmux.yaml     |   11 +-
 .../devicetree/bindings/pinctrl/renesas,pfc.yaml   |    1 +
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    |   16 +-
 .../pinctrl/samsung,pinctrl-gpio-bank.yaml         |   52 +
 .../bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml |   81 +
 .../pinctrl/samsung,pinctrl-wakeup-interrupt.yaml  |  106 +
 .../bindings/pinctrl/samsung,pinctrl.yaml          |  393 ++++
 .../bindings/pinctrl/samsung-pinctrl.txt           |  383 ----
 .../bindings/pinctrl/sunplus,sp7021-pinctrl.yaml   |  374 ++++
 MAINTAINERS                                        |   21 +-
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    5 +-
 drivers/pinctrl/bcm/Kconfig                        |   14 +
 drivers/pinctrl/bcm/Makefile                       |    1 +
 drivers/pinctrl/bcm/pinctrl-bcm4908.c              |  563 +++++
 drivers/pinctrl/berlin/berlin.c                    |    2 +
 drivers/pinctrl/freescale/Kconfig                  |    7 +
 drivers/pinctrl/freescale/Makefile                 |    1 +
 drivers/pinctrl/freescale/pinctrl-imx.c            |    2 +-
 drivers/pinctrl/freescale/pinctrl-imx93.c          |  272 +++
 drivers/pinctrl/intel/pinctrl-alderlake.c          |  317 ++-
 drivers/pinctrl/intel/pinctrl-baytrail.c           |   55 +-
 drivers/pinctrl/intel/pinctrl-icelake.c            |  291 ++-
 drivers/pinctrl/intel/pinctrl-intel.c              |   64 +-
 drivers/pinctrl/intel/pinctrl-tigerlake.c          |    1 -
 drivers/pinctrl/mediatek/Kconfig                   |    7 +
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/pinctrl-moore.c           |   25 +-
 drivers/pinctrl/mediatek/pinctrl-mt2701.c          |   40 +-
 drivers/pinctrl/mediatek/pinctrl-mt2712.c          |   44 +-
 drivers/pinctrl/mediatek/pinctrl-mt6765.c          |    9 +-
 drivers/pinctrl/mediatek/pinctrl-mt6779.c          |    9 +-
 drivers/pinctrl/mediatek/pinctrl-mt6797.c          |    9 +-
 drivers/pinctrl/mediatek/pinctrl-mt8127.c          |   39 +-
 drivers/pinctrl/mediatek/pinctrl-mt8135.c          |   17 +-
 drivers/pinctrl/mediatek/pinctrl-mt8167.c          |   40 +-
 drivers/pinctrl/mediatek/pinctrl-mt8173.c          |   29 +-
 drivers/pinctrl/mediatek/pinctrl-mt8183.c          |    9 +-
 drivers/pinctrl/mediatek/pinctrl-mt8186.c          | 1267 ++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mt8192.c          |    9 +-
 drivers/pinctrl/mediatek/pinctrl-mt8195.c          |    9 +-
 drivers/pinctrl/mediatek/pinctrl-mt8365.c          |   40 +-
 drivers/pinctrl/mediatek/pinctrl-mt8516.c          |   40 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |   88 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |   33 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8186.h      | 2186 ++++++++++++++++=
++++
 drivers/pinctrl/mediatek/pinctrl-paris.c           |  301 +--
 drivers/pinctrl/mediatek/pinctrl-paris.h           |    3 +-
 drivers/pinctrl/meson/Kconfig                      |    6 +
 drivers/pinctrl/meson/Makefile                     |    1 +
 drivers/pinctrl/meson/pinctrl-meson-g12a.c         |    6 +-
 drivers/pinctrl/meson/pinctrl-meson-s4.c           | 1232 +++++++++++
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |    4 +-
 drivers/pinctrl/nuvoton/Kconfig                    |   20 +
 drivers/pinctrl/nuvoton/Makefile                   |    1 +
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |  162 +-
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c          | 1151 +++++++++++
 drivers/pinctrl/pinconf-generic.c                  |    6 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |   16 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |   46 +-
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |  112 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |  109 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |    2 +
 drivers/pinctrl/pinctrl-starfive.c                 |    2 +-
 drivers/pinctrl/pinctrl-zynq.c                     |    7 +-
 drivers/pinctrl/pxa/pinctrl-pxa27x.c               |    5 +-
 drivers/pinctrl/qcom/Kconfig                       |    9 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   13 +-
 drivers/pinctrl/qcom/pinctrl-qcm2290.c             |   12 +
 drivers/pinctrl/qcom/pinctrl-sc8180x.c             |    4 +-
 drivers/pinctrl/qcom/pinctrl-sc8280xp.c            | 1953 ++++++++++++++++=
+
 drivers/pinctrl/qcom/pinctrl-sm6125.c              |    2 +-
 drivers/pinctrl/qcom/pinctrl-sm8450.c              |  106 +-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    1 +
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c            |    1 +
 drivers/pinctrl/renesas/Kconfig                    |   11 +-
 drivers/pinctrl/renesas/Makefile                   |    1 +
 drivers/pinctrl/renesas/core.c                     |  219 +-
 drivers/pinctrl/renesas/pfc-emev2.c                |   71 +-
 drivers/pinctrl/renesas/pfc-r8a73a4.c              |   97 +-
 drivers/pinctrl/renesas/pfc-r8a7740.c              |  282 +--
 drivers/pinctrl/renesas/pfc-r8a77470.c             |  240 +--
 drivers/pinctrl/renesas/pfc-r8a7778.c              |   69 +-
 drivers/pinctrl/renesas/pfc-r8a7779.c              |  118 +-
 drivers/pinctrl/renesas/pfc-r8a7790.c              |  530 ++---
 drivers/pinctrl/renesas/pfc-r8a7791.c              |  322 ++-
 drivers/pinctrl/renesas/pfc-r8a7792.c              |  446 ++--
 drivers/pinctrl/renesas/pfc-r8a7794.c              |  214 +-
 drivers/pinctrl/renesas/pfc-r8a77950.c             |  119 +-
 drivers/pinctrl/renesas/pfc-r8a77951.c             |  313 +--
 drivers/pinctrl/renesas/pfc-r8a7796.c              |  315 +--
 drivers/pinctrl/renesas/pfc-r8a77965.c             |  333 +--
 drivers/pinctrl/renesas/pfc-r8a77970.c             |  165 +-
 drivers/pinctrl/renesas/pfc-r8a77980.c             |  193 +-
 drivers/pinctrl/renesas/pfc-r8a77990.c             |  333 ++-
 drivers/pinctrl/renesas/pfc-r8a77995.c             |  200 +-
 drivers/pinctrl/renesas/pfc-r8a779a0.c             |  105 +-
 drivers/pinctrl/renesas/pfc-r8a779f0.c             | 2126 ++++++++++++++++=
+++
 drivers/pinctrl/renesas/pfc-sh7203.c               |    1 -
 drivers/pinctrl/renesas/pfc-sh7264.c               |    1 -
 drivers/pinctrl/renesas/pfc-sh7269.c               |    1 -
 drivers/pinctrl/renesas/pfc-sh73a0.c               |  269 +--
 drivers/pinctrl/renesas/pfc-sh7720.c               |    1 -
 drivers/pinctrl/renesas/pfc-sh7722.c               |    1 -
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |    4 +-
 drivers/pinctrl/renesas/pinctrl.c                  |   26 +-
 drivers/pinctrl/renesas/sh_pfc.h                   |  176 +-
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     |   73 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c           |    7 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   89 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |    1 +
 drivers/pinctrl/sunplus/Kconfig                    |   22 +
 drivers/pinctrl/sunplus/Makefile                   |    6 +
 drivers/pinctrl/sunplus/sppctl.c                   | 1118 ++++++++++
 drivers/pinctrl/sunplus/sppctl.h                   |  170 ++
 drivers/pinctrl/sunplus/sppctl_sp7021.c            |  583 ++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   18 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c   |   26 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c   |   64 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c   |   62 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c   |   62 +-
 include/dt-bindings/gpio/meson-s4-gpio.h           |   99 +
 include/dt-bindings/pinctrl/mt8186-pinfunc.h       | 1174 +++++++++++
 include/dt-bindings/pinctrl/sppctl-sp7021.h        |  179 ++
 include/dt-bindings/pinctrl/sppctl.h               |   31 +
 141 files changed, 19851 insertions(+), 4373 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/brcm,bcm4908-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-gpio-bank.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.=
yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
 create mode 100644 drivers/pinctrl/bcm/pinctrl-bcm4908.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx93.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8186.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8186.h
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-s4.c
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc8280xp.c
 create mode 100644 drivers/pinctrl/renesas/pfc-r8a779f0.c
 create mode 100644 drivers/pinctrl/sunplus/Kconfig
 create mode 100644 drivers/pinctrl/sunplus/Makefile
 create mode 100644 drivers/pinctrl/sunplus/sppctl.c
 create mode 100644 drivers/pinctrl/sunplus/sppctl.h
 create mode 100644 drivers/pinctrl/sunplus/sppctl_sp7021.c
 create mode 100644 include/dt-bindings/gpio/meson-s4-gpio.h
 create mode 100644 include/dt-bindings/pinctrl/mt8186-pinfunc.h
 create mode 100644 include/dt-bindings/pinctrl/sppctl-sp7021.h
 create mode 100644 include/dt-bindings/pinctrl/sppctl.h
