Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C93558E22D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiHIVxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHIVx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:53:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EEF6BD5D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:53:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y13so24446950ejp.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=E3CcxRwQkhp8Q26l3YEDYG2kM25URqGFvRXWb8+mQhM=;
        b=Mw448Q7xatD+bi+rNwHN1v8su2SblP7ceq4QFEWZl05vPFtcEsSkfUcaLwMFEK6z3X
         AHmp1RcvdwkLBI6Ne1EUzGe0q8LxGvkT7RbW87AIKN1kGHIpY7M+t8hIkeYy2MH7CeGS
         sOmO8jnhEiESwtP+rlQALzXvJTSiip0TmgA/890ZnTl+wY0/nmcY/PgX3xgILxx4SpUF
         hy92WO5n+QOjBxNcda3uFKM7k868VQAuqX0uJwIsTRxqFLPPUTVbWtNnOQ21D67br9lV
         65A7gjnvtmW7HGOYSFy2B7YPSLriiV9hIFu7vikfjPqUhjkQOFkCRnMvVPfl5cJxmPZr
         4icQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=E3CcxRwQkhp8Q26l3YEDYG2kM25URqGFvRXWb8+mQhM=;
        b=ziToouxze0loDEWtzZA8fruzsGlM2jbticWoTo5h8yt2mvyQfvfpVTBMCnOEMLMitg
         OS5gf3uy6i3bfaUOg6ybvgS+M4GxG7ejYKKZ8ffodaIYNP2HFd0puWe8wKM2LE3NH8jE
         bASk0ejLTQAXbvBlqCRDc+cMZ1dF4FpU/ra6Z4a4dkaqSH50+kATMHxMpOjB5udYFYAT
         MnyVY/wMH9GIoQRmhw941M5lmeqD+pDO/+48d40t9D6o/LqpaMNqEWfAaVvleibgvRwG
         ZgVtf0UmBBiyrIo7u66DW705u7kvwkTDyxYtmIKSCDsOZxsITN6sKJYUxaXz7HpnYx6G
         eNyw==
X-Gm-Message-State: ACgBeo1hXijkL9BQW83FSUe7VsO/FOb/gcbxum9aYb90JWE7VgG0x75o
        +wOi4RKlLcQeDv6ai/jp9/3UWlH/zGwrSOciujLnEA==
X-Google-Smtp-Source: AA6agR6wJvbcXorvsKnDQ1jcrAHji7Vo0PZAgPLmpl3qANPXRUQVgONhLdqmVdlAHrQ5sInc68I7ogNqG0TLLGrT5FY=
X-Received: by 2002:a17:906:5d0b:b0:731:3310:4188 with SMTP id
 g11-20020a1709065d0b00b0073133104188mr11446639ejt.208.1660082003456; Tue, 09
 Aug 2022 14:53:23 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Aug 2022 23:53:12 +0200
Message-ID: <CACRpkdY1pDDQyEJmD0+H-N8e1g7E7M8A6cbYfDr=Y=+cqB+otg@mail.gmail.com>
Subject: [GIT PULL] pin control bulk changes for the v6.0 cycle
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
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

here is the big pin control pull request for v6.0, coming from a shaky
wireless in Germany.

Details are in the signed tag as usual.

Outside the pinctrl driver and DT bindings we hit some Arm DT files,
patched by the maintainers.

Other than that it is business as usual.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56=
:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.0-1

for you to fetch changes up to 5b045200b53a9b95f87409b5c13f43adb6f1da6c:

  dt-bindings: pinctrl: qcom,pmic-gpio: add PM8226 constraints
(2022-08-03 20:32:57 +0200)

----------------------------------------------------------------
Pin control bulk changes for v6.0:

Core changes:

- Add PINCTRL_PINGROUP() helper macro (and use it in the AMD driver).

New drivers:

- Intel Meteor Lake support.

- Reneasas RZ/V2M and r8a779g0 (R-Car V4H).

- AXP209 variants AXP221, AXP223 and AXP809.

- Qualcomm MSM8909, PM8226, PMP8074 and SM6375.

- Allwinner D1.

Improvements:

- Proper pin multiplexing in the AMD driver.

- Mediatek MT8192 can use generic drive strength and pin
  bias, then fixes on top plus some I2C pin group fixes.

- Have the Allwinner Sunplus SP7021 use the generic DT schema and
  make interrupts optional.

- Handle Qualcomm SC7280 ADSP.

- Handle Qualcomm MSM8916 CAMSS GP clock muxing.

- High impedance bias on ZynqMP.

- Serialize StarFive access to MMIO.

- Immutable gpiochip for BCM2835, Ingenic, Qualcomm SPMI GPIO.

----------------------------------------------------------------
Aidan MacDonald (2):
      pinctrl: ingenic: Use irqd_to_hwirq()
      pinctrl: ingenic: Convert to immutable irq chip

Allen-KH Cheng (2):
      dt-bindings: pinctrl: mt8186: Add gpio-line-names property
      dt-bindings: pinctrl: mt8186: Add and use drive-strength-microamp

Andre Przywara (2):
      dt-bindings: pinctrl: sunxi: Make interrupts optional
      dt-bindings: pinctrl: sunxi: allow vcc-pi-supply

Andy Shevchenko (11):
      MAINTAINERS: Update Intel pin control to Supported
      Merge branch 'ib-v5.20-amd-pinctrl'
      pinctrl: intel: Embed struct pingroup into struct intel_pingroup
      pinctrl: baytrail: Switch to to embedded struct pingroup
      pinctrl: cherryview: Switch to to embedded struct pingroup
      pinctrl: lynxpoint: Switch to to embedded struct pingroup
      pinctrl: merrifield: Switch to to embedded struct pingroup
      pinctrl: intel: Switch to to embedded struct pingroup
      pinctrl: intel: Drop no more used members of struct intel_pingroup
      pinctrl: intel: Add Intel Meteor Lake pin controller support
      pinctrl: core: Use device_match_of_node() helper

AngeloGioacchino Del Regno (4):
      dt-bindings: pinctrl: mt8195: Fix name for
mediatek,rsel-resistance-in-si-unit
      dt-bindings: pinctrl: mt8195: Add and use drive-strength-microamp
      dt-bindings: pinctrl: mt8195: Add gpio-line-names property
      dt-bindings: pinctrl: mt8195: Use drive-strength-microamp in examples

Basavaraj Natikar (9):
      pinctrl: Add pingroup and define PINCTRL_PINGROUP
      pinctrl: amd: Remove amd_pingroup and use pingroup
      pinctrl: amd: Use PINCTRL_PINGROUP to manage pingroups
      pinctrl: amd: Define and use AMD_PINS macro
      pinctrl: amd: Add amd_get_iomux_res function
      pinctrl: amd: Implement pinmux functionality
      pinctrl: amd: Use devm_platform_get_and_ioremap_resource
      pinctrl: amd: Don't save/restore interrupt status and wake status bit=
s
      pinctrl: amd: Remove contact information

Claudiu Beznea (2):
      pinctrl: at91-pio4: remove #ifdef CONFIG_PM_SLEEP
      pinctrl: at91: remove #ifdef CONFIG_PM

Cl=C3=A9ment L=C3=A9ger (1):
      pinctrl: ocelot: allow building as a module

Dominik Kobinski (1):
      pinctrl: qcom: spmi-gpio: Add pm8226 compatibility

Fabio Estevam (1):
      pinctrl: imx93: Add MODULE_DEVICE_TABLE()

Geert Uytterhoeven (2):
      dt-bindings: pinctrl: renesas: Remove spaces before #define
      pinctrl: renesas: r8a779f0: Remove unused POC2

Guodong Liu (5):
      pinctrl: mediatek: add generic driving setup property on mt8192
      pinctrl: mediatek: add drive for I2C related pins on mt8192
      pinctrl: mediatek: add rsel setting on mt8192
      pinctrl: mediatek: dropping original advanced drive configuration fun=
ction
      pinctrl: mediatek: fix the pinconf definition of some GPIO pins

Jesse Taube (1):
      ARM: dts: imxrt1170-pinfunc: Add pinctrl binding header

Jianhua Lu (1):
      pinctrl: qcom: sm8250: Fix PDC map

Jianlong Huang (1):
      pinctrl: starfive: Serialize adding groups and functions

John Garry (1):
      pinctrl: qcom: Make PINCTRL_SM8450 depend on PINCTRL_MSM

Konrad Dybcio (2):
      dt-bindings: pinctrl: Add DT schema for SM6375 TLMM
      pinctrl: qcom: Add SM6375 TLMM driver

Krzysztof Kozlowski (4):
      dt-bindings: pinctrl: sunplus,sp7021-pinctrl: reference generic schem=
a
      pinctrl: samsung: do not use bindings header with constants
      dt-bindings: pinctrl: nuvoton,wpcm450-pinctrl: align key node name
      dt-bindings: pinctrl: qcom,pmic-gpio: add PM8226 constraints

Kuninori Morimoto (21):
      dt-bindings: pinctrl: renesas,pfc: Document r8a779g0 support
      pinctrl: renesas: Add PORT_GP_CFG_13 macros
      pinctrl: renesas: r8a779g0: Fixup MODSEL8
      pinctrl: renesas: r8a779g0: Remove unused NOGP definitions
      pinctrl: renesas: r8a779g0: Remove unused IPxSRx definitions
      pinctrl: renesas: r8a779g0: Remove unused MOD_SELx definitions
      pinctrl: renesas: r8a779g0: Tidy up ioctrl_regs
      pinctrl: renesas: r8a779g0: Tidyup POC1 voltage
      pinctrl: renesas: r8a779g0: Add missing TCLKx_A/TCLKx_B/TCLKx_X
      pinctrl: renesas: r8a779g0: Add missing IRQx_A/IRQx_B
      pinctrl: renesas: r8a779g0: Add missing HSCIF3_A
      pinctrl: renesas: r8a779g0: Add missing HSCIF1_X
      pinctrl: renesas: r8a779g0: Add missing SCIF3
      pinctrl: renesas: r8a779g0: Add missing SCIF1_X
      pinctrl: renesas: r8a779g0: Add missing CANFD5_B
      pinctrl: renesas: r8a779g0: Add missing TPU0TOx_A
      pinctrl: renesas: r8a779g0: Add missing FlexRay
      pinctrl: renesas: r8a779g0: Add missing PWM
      pinctrl: renesas: r8a779g0: Add missing ERROROUTC_A
      pinctrl: renesas: r8a779g0: Add missing MODSELx for TSN0
      pinctrl: renesas: r8a779g0: Add missing MODSELx for AVBx

LUU HOAI (1):
      pinctrl: renesas: Initial R8A779G0 (R-Car V4H) PFC support

Lad Prabhakar (1):
      pinctrl: renesas: rzg2l: Return -EINVAL for pins which have input dis=
abled

Linus Walleij (7):
      Merge branch 'ib-v5.20-amd-pinctrl' into devel
      pinctrl: mediatek: mt8192: Fix compile warnings
      Merge tag 'renesas-pinctrl-for-v5.20-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      pinctrl: qcom: sc7280: Fix compile bug
      Merge tag 'intel-pinctrl-v5.20-1' of
gitolite.kernel.org:pub/scm/linux/kernel/git/pinctrl/intel into devel
      Merge tag 'renesas-pinctrl-for-v5.20-tag2' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Revert "pinctrl: qcom: spmi-gpio: make the irqchip immutable"

Lukas Bulwahn (1):
      MAINTAINERS: add include/dt-bindings/pinctrl to PIN CONTROL SUBSYSTEM

Mario Limonciello (3):
      pinctrl: amd: Fix newline declaration in debugfs output
      pinctrl: amd: Use unicode for debugfs output
      pinctrl: amd: Fix an unused variable

Miaoqian Lin (1):
      pinctrl: nomadik: Fix refcount leak in nmk_pinctrl_dt_subnode_to_map

Nikita Travkin (1):
      pinctrl: qcom: msm8916: Allow CAMSS GP clocks to be muxed

N=C3=ADcolas F. R. A. Prado (3):
      dt-bindings: pinctrl: mt8192: Add drive-strength-microamp
      dt-bindings: pinctrl: mt8192: Use generic bias instead of pull-*-adv
      dt-bindings: pinctrl: mt8192: Add RSEL values to bias-pull-{up,down}

Phil Edworthy (2):
      dt-bindings: pinctrl: Add DT bindings for Renesas RZ/V2M pinctrl
      pinctrl: renesas: Add RZ/V2M pin and gpio controller driver

Phong Hoang (1):
      pinctrl: renesas: r8a779g0: Add pins, groups and functions

Rob Herring (1):
      dt-bindings: pinctrl: st,stm32: Correct 'resets' property name

Robert Marko (3):
      pinctrl: qcom: spmi-gpio: make the irqchip immutable
      dt-bindings: pinctrl: qcom,pmic-gpio: add PMP8074
      pinctrl: qcom-pmic-gpio: add support for PMP8074

Sai Krishna Potthuri (4):
      firmware: xilinx: Add configuration values for tri-state
      dt-bindings: pinctrl-zynqmp: Add output-enable configuration
      pinctrl: pinctrl-zynqmp: Add support for output-enable and
bias-high-impedance
      pinctrl: pinctrl-zynqmp: Fix kernel-doc warning

Samuel Holland (11):
      pinctrl: sunxi: Remove reset controller consumers
      ARM: dts: sunxi: Drop resets from r_pio nodes
      dt-bindings: pinctrl: sunxi: Disallow the resets property
      dt-bindings: gpio: Add AXP221/AXP223/AXP809 compatibles
      pinctrl: axp209: Support the AXP221/AXP223/AXP809 variant
      dt-bindings: pinctrl: Add compatible for Allwinner D1
      pinctrl: sunxi: Add I/O bias setting for H6 R-PIO
      pinctrl: sunxi: Support the 2.5V I/O bias mode
      pinctrl: sunxi: Refactor register/offset calculation
      pinctrl: sunxi: Make some layout parameters dynamic
      pinctrl: sunxi: Add driver for Allwinner D1

Slark Xiao (1):
      pinctrl: at91: Fix typo 'the the' in comment

Srinivasa Rao Mandadapu (3):
      dt-bindings: pinctrl: qcom: sc7280: Add boolean param for ADSP
bypass platforms
      pinctrl: qcom: sc7280: Add clock optional check for ADSP bypass targe=
ts
      pinctrl: qcom: sc7280: Fix compile bug

Stefan Wahren (2):
      pinctrl: bcm2835: drop irq_enable/disable callbacks
      pinctrl: bcm2835: Make the irqchip immutable

Stephan Gerhold (2):
      dt-bindings: pinctrl: Add DT schema for qcom,msm8909-tlmm
      pinctrl: qcom: Add pinctrl driver for MSM8909

Xiang wangx (1):
      pinctrl: aspeed: Fix typo in comment

Xin Gao (1):
      pinctrl: mvebu: Missing a blank line after declarations.

 .../bindings/gpio/x-powers,axp209-gpio.yaml        |    6 +
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml       |   34 +-
 .../bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml  |    2 +-
 .../bindings/pinctrl/pinctrl-mt8186.yaml           |   31 +-
 .../bindings/pinctrl/pinctrl-mt8192.yaml           |   64 +-
 .../bindings/pinctrl/pinctrl-mt8195.yaml           |   41 +-
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml        |  152 +
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |    4 +
 .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     |    5 +
 .../bindings/pinctrl/qcom,sm6375-tlmm.yaml         |  158 +
 .../devicetree/bindings/pinctrl/renesas,pfc.yaml   |    1 +
 .../bindings/pinctrl/renesas,rzv2m-pinctrl.yaml    |  170 +
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |    4 +-
 .../bindings/pinctrl/sunplus,sp7021-pinctrl.yaml   |    5 +-
 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml      |    4 +
 MAINTAINERS                                        |    3 +-
 arch/arm/boot/dts/imxrt1170-pinfunc.h              | 1561 +++++++
 arch/arm/boot/dts/sun6i-a31.dtsi                   |    1 -
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |    1 -
 arch/arm/boot/dts/sun9i-a80.dtsi                   |    1 -
 drivers/pinctrl/Kconfig                            |    2 +-
 drivers/pinctrl/aspeed/pinmux-aspeed.h             |    2 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   21 +-
 drivers/pinctrl/core.c                             |    2 +-
 drivers/pinctrl/freescale/pinctrl-imx93.c          |    1 +
 drivers/pinctrl/intel/Kconfig                      |    8 +
 drivers/pinctrl/intel/Makefile                     |    1 +
 drivers/pinctrl/intel/pinctrl-baytrail.c           |   18 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   16 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |   14 +-
 drivers/pinctrl/intel/pinctrl-intel.h              |   25 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c          |   10 +-
 drivers/pinctrl/intel/pinctrl-merrifield.c         |   14 +-
 drivers/pinctrl/intel/pinctrl-meteorlake.c         |  417 ++
 drivers/pinctrl/mediatek/pinctrl-mt8192.c          |  296 +-
 drivers/pinctrl/mvebu/pinctrl-mvebu.c              |   10 +
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |    4 +-
 drivers/pinctrl/pinctrl-amd.c                      |  242 +-
 drivers/pinctrl/pinctrl-amd.h                      | 1376 ++++++-
 drivers/pinctrl/pinctrl-at91-pio4.c                |    7 +-
 drivers/pinctrl/pinctrl-at91.c                     |   10 +-
 drivers/pinctrl/pinctrl-axp209.c                   |   14 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |   64 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |    4 +-
 drivers/pinctrl/pinctrl-starfive.c                 |    5 +
 drivers/pinctrl/pinctrl-zynqmp.c                   |   11 +
 drivers/pinctrl/qcom/Kconfig                       |   19 +-
 drivers/pinctrl/qcom/Makefile                      |    2 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           |    2 +-
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h           |    1 -
 drivers/pinctrl/qcom/pinctrl-msm8909.c             |  956 +++++
 drivers/pinctrl/qcom/pinctrl-msm8916.c             |    4 +-
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c    |    1 -
 drivers/pinctrl/qcom/pinctrl-sm6375.c              | 1544 +++++++
 drivers/pinctrl/qcom/pinctrl-sm8250.c              |    2 +-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    3 +
 drivers/pinctrl/renesas/Kconfig                    |   18 +
 drivers/pinctrl/renesas/Makefile                   |    2 +
 drivers/pinctrl/renesas/core.c                     |    6 +
 drivers/pinctrl/renesas/pfc-r8a779f0.c             |    2 -
 drivers/pinctrl/renesas/pfc-r8a779g0.c             | 4262 ++++++++++++++++=
++++
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |    2 +
 drivers/pinctrl/renesas/pinctrl-rzv2m.c            | 1119 +++++
 drivers/pinctrl/renesas/sh_pfc.h                   |    9 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c           |    6 +-
 drivers/pinctrl/samsung/pinctrl-exynos.h           |    3 +
 drivers/pinctrl/samsung/pinctrl-samsung.c          |    4 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |    8 +
 drivers/pinctrl/sunxi/Kconfig                      |    8 +-
 drivers/pinctrl/sunxi/Makefile                     |    1 +
 drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c          |  840 ++++
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c      |    1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c        |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c       |    1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c        |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c      |    1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c        |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c        |   22 +-
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c        |   25 +-
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c       |    1 -
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c        |    1 -
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |  156 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h              |  109 +-
 include/dt-bindings/pinctrl/r7s9210-pinctrl.h      |    2 +-
 include/dt-bindings/pinctrl/rzg2l-pinctrl.h        |    2 +-
 include/dt-bindings/pinctrl/rzv2m-pinctrl.h        |   23 +
 include/linux/firmware/xlnx-zynqmp.h               |    5 +
 include/linux/pinctrl/pinctrl.h                    |   20 +
 88 files changed, 13369 insertions(+), 672 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
 create mode 100644 arch/arm/boot/dts/imxrt1170-pinfunc.h
 create mode 100644 drivers/pinctrl/intel/pinctrl-meteorlake.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-msm8909.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm6375.c
 create mode 100644 drivers/pinctrl/renesas/pfc-r8a779g0.c
 create mode 100644 drivers/pinctrl/renesas/pinctrl-rzv2m.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c
 create mode 100644 include/dt-bindings/pinctrl/rzv2m-pinctrl.h
