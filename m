Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD91746E753
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhLILQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:16:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:51177 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235323AbhLILQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:16:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="238018647"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="238018647"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 03:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="601525075"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Dec 2021 03:12:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6478F109; Thu,  9 Dec 2021 13:12:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 1/1] pinctrl: Sort Kconfig and Makefile entries alphabetically
Date:   Thu,  9 Dec 2021 13:12:55 +0200
Message-Id: <20211209111255.67044-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort Kconfig and Makefile entries alphabetically for better maintenance
in the future.

While at it fix some style issues, such as:
  - "Say Y/yes/Yes" --> "Say Y"
  - "pullup/pulldown" --> "pull-up and pull-down"
  - wrong indentation

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on top of very recent pinctrl/devel (Linus), added some grammar fixes
 drivers/pinctrl/Kconfig  | 469 +++++++++++++++++++--------------------
 drivers/pinctrl/Makefile |  47 ++--
 2 files changed, 258 insertions(+), 258 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index a3457a4b4d9d..36066d7e1db3 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -31,6 +31,24 @@ config DEBUG_PINCTRL
 	help
 	  Say Y here to add some extra checks and diagnostics to PINCTRL calls.
 
+config PINCTRL_AMD
+	tristate "AMD GPIO pin control"
+	depends on HAS_IOMEM
+	depends on ACPI || COMPILE_TEST
+	select GPIOLIB
+	select GPIOLIB_IRQCHIP
+	select PINMUX
+	select PINCONF
+	select GENERIC_PINCONF
+	help
+	  driver for memory mapped GPIO functionality on AMD platforms
+	  (x86 or arm).Most pins are usually muxed to some other
+	  functionality by firmware,so only a small amount is available
+	  for GPIO use.
+
+	  Requires ACPI/FDT device enumeration code to set up a platform
+	  device.
+
 config PINCTRL_APPLE_GPIO
 	tristate "Apple SoC GPIO pin controller driver"
 	depends on ARCH_APPLE
@@ -69,20 +87,6 @@ config PINCTRL_AS3722
 	  open drain configuration for the GPIO pins of AS3722 devices. It also
 	  supports the GPIO functionality through gpiolib.
 
-config PINCTRL_AXP209
-	tristate "X-Powers AXP209 PMIC pinctrl and GPIO Support"
-	depends on MFD_AXP20X
-	depends on OF
-	select PINMUX
-	select GENERIC_PINCONF
-	select GPIOLIB
-	help
-	  AXP PMICs provides multiple GPIOs that can be muxed for different
-	  functions. This driver bundles a pinctrl driver to select the function
-	  muxing and a GPIO driver to handle the GPIO when the GPIO function is
-	  selected.
-	  Say yes to enable pinctrl and GPIO support for the AXP209 PMIC
-
 config PINCTRL_AT91
 	bool "AT91 pinctrl driver"
 	depends on OF
@@ -109,23 +113,19 @@ config PINCTRL_AT91PIO4
 	  Say Y here to enable the at91 pinctrl/gpio driver for Atmel PIO4
 	  controller available on sama5d2 SoC.
 
-config PINCTRL_AMD
-	tristate "AMD GPIO pin control"
-	depends on HAS_IOMEM
-	depends on ACPI || COMPILE_TEST
-	select GPIOLIB
-	select GPIOLIB_IRQCHIP
+config PINCTRL_AXP209
+	tristate "X-Powers AXP209 PMIC pinctrl and GPIO Support"
+	depends on MFD_AXP20X
+	depends on OF
 	select PINMUX
-	select PINCONF
 	select GENERIC_PINCONF
+	select GPIOLIB
 	help
-	  driver for memory mapped GPIO functionality on AMD platforms
-	  (x86 or arm).Most pins are usually muxed to some other
-	  functionality by firmware,so only a small amount is available
-	  for gpio use.
-
-	  Requires ACPI/FDT device enumeration code to set up a platform
-	  device.
+	  AXP PMICs provides multiple GPIOs that can be muxed for different
+	  functions. This driver bundles a pinctrl driver to select the function
+	  muxing and a GPIO driver to handle the GPIO when the GPIO function is
+	  selected.
+	  Say Y to enable pinctrl and GPIO support for the AXP209 PMIC.
 
 config PINCTRL_BM1880
 	bool "Bitmain BM1880 Pinctrl driver"
@@ -136,13 +136,13 @@ config PINCTRL_BM1880
 	  Pinctrl driver for Bitmain BM1880 SoC.
 
 config PINCTRL_DA850_PUPD
-	tristate "TI DA850/OMAP-L138/AM18XX pullup/pulldown groups"
+	tristate "TI DA850/OMAP-L138/AM18XX pull-up and pull-down groups"
 	depends on OF && (ARCH_DAVINCI_DA850 || COMPILE_TEST)
 	select PINCONF
 	select GENERIC_PINCONF
 	help
 	  Driver for TI DA850/OMAP-L138/AM18XX pinconf. Used to control
-	  pullup/pulldown pin groups.
+	  pull-up and pull-down pin groups.
 
 config PINCTRL_DA9062
 	tristate "Dialog Semiconductor DA9062 PMIC pinctrl and GPIO Support"
@@ -154,7 +154,7 @@ config PINCTRL_DA9062
 	  function muxing and a GPIO driver to handle the GPIO when the GPIO
 	  function is selected.
 
-	  Say yes to enable pinctrl and GPIO support for the DA9062 PMIC.
+	  Say Y to enable pinctrl and GPIO support for the DA9062 PMIC.
 
 config PINCTRL_DIGICOLOR
 	bool
@@ -162,12 +162,93 @@ config PINCTRL_DIGICOLOR
 	select PINMUX
 	select GENERIC_PINCONF
 
+config PINCTRL_EQUILIBRIUM
+	tristate "Generic pinctrl and GPIO driver for Intel Lightning Mountain SoC"
+	depends on OF && HAS_IOMEM
+	depends on X86 || COMPILE_TEST
+	select PINMUX
+	select PINCONF
+	select GPIOLIB
+	select GPIO_GENERIC
+	select GPIOLIB_IRQCHIP
+	select GENERIC_PINCONF
+	select GENERIC_PINCTRL_GROUPS
+	select GENERIC_PINMUX_FUNCTIONS
+	help
+	  Equilibrium driver is a pinctrl and GPIO driver for Intel Lightning
+	  Mountain network processor SoC that supports both the GPIO and pin
+	  control frameworks. It provides interfaces to setup pin muxing, assign
+	  desired pin functions, configure GPIO attributes for LGM SoC pins.
+	  Pin muxing and pin config settings are retrieved from device tree.
+
+config PINCTRL_GEMINI
+	bool
+	depends on ARCH_GEMINI
+	default ARCH_GEMINI
+	select PINMUX
+	select GENERIC_PINCONF
+	select MFD_SYSCON
+
+config PINCTRL_INGENIC
+	bool "Pinctrl driver for the Ingenic JZ47xx SoCs"
+	default MACH_INGENIC
+	depends on OF
+	depends on MIPS || COMPILE_TEST
+	select GENERIC_PINCONF
+	select GENERIC_PINCTRL_GROUPS
+	select GENERIC_PINMUX_FUNCTIONS
+	select GPIOLIB
+	select GPIOLIB_IRQCHIP
+	select REGMAP_MMIO
+
+config PINCTRL_K210
+	bool "Pinctrl driver for the Canaan Kendryte K210 SoC"
+	depends on RISCV && SOC_CANAAN && OF
+	select GENERIC_PINMUX_FUNCTIONS
+	select GENERIC_PINCONF
+	select GPIOLIB
+	select OF_GPIO
+	select REGMAP_MMIO
+	default SOC_CANAAN
+	help
+	  Add support for the Canaan Kendryte K210 RISC-V SOC Field
+	  Programmable IO Array (FPIOA) controller.
+
+config PINCTRL_KEEMBAY
+	tristate "Pinctrl driver for Intel Keem Bay SoC"
+	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
+	depends on HAS_IOMEM
+	select PINMUX
+	select PINCONF
+	select GENERIC_PINCONF
+	select GENERIC_PINCTRL_GROUPS
+	select GENERIC_PINMUX_FUNCTIONS
+	select GPIOLIB
+	select GPIOLIB_IRQCHIP
+	select GPIO_GENERIC
+	help
+	  This selects pin control driver for the Intel Keem Bay SoC.
+	  It provides pin config functions such as pull-up, pull-down,
+	  interrupt, drive strength, sec lock, Schmitt trigger, slew
+	  rate control and direction control. This module will be
+	  called as pinctrl-keembay.
+
 config PINCTRL_LANTIQ
 	bool
 	depends on LANTIQ
 	select PINMUX
 	select PINCONF
 
+config PINCTRL_FALCON
+	bool
+	depends on SOC_FALCON
+	depends on PINCTRL_LANTIQ
+
+config PINCTRL_XWAY
+	bool
+	depends on SOC_TYPE_XWAY
+	depends on PINCTRL_LANTIQ
+
 config PINCTRL_LPC18XX
 	bool "NXP LPC18XX/43XX SCU pinctrl driver"
 	depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
@@ -177,18 +258,16 @@ config PINCTRL_LPC18XX
 	help
 	  Pinctrl driver for NXP LPC18xx/43xx System Control Unit (SCU).
 
-config PINCTRL_FALCON
-	bool
-	depends on SOC_FALCON
-	depends on PINCTRL_LANTIQ
-
-config PINCTRL_GEMINI
-	bool
-	depends on ARCH_GEMINI
-	default ARCH_GEMINI
+config PINCTRL_MAX77620
+	tristate "MAX77620/MAX20024 Pincontrol support"
+	depends on MFD_MAX77620 && OF
 	select PINMUX
 	select GENERIC_PINCONF
-	select MFD_SYSCON
+	help
+	  Say Y here to enable Pin control support for Maxim MAX77620 PMIC.
+	  This PMIC has 8 GPIO pins that work as GPIO as well as special
+	  function in alternate mode. This driver also configure push-pull,
+	  open drain, FPS slots etc.
 
 config PINCTRL_MCP23S08_I2C
 	tristate
@@ -212,99 +291,47 @@ config PINCTRL_MCP23S08
 	  This provides a GPIO interface supporting inputs and outputs and a
 	  corresponding interrupt-controller.
 
-config PINCTRL_OXNAS
-	bool
+config PINCTRL_MICROCHIP_SGPIO
+	bool "Pinctrl driver for Microsemi/Microchip Serial GPIO"
 	depends on OF
-	select PINMUX
-	select PINCONF
-	select GENERIC_PINCONF
+	depends on HAS_IOMEM
 	select GPIOLIB
-	select OF_GPIO
 	select GPIOLIB_IRQCHIP
-	select MFD_SYSCON
-
-config PINCTRL_ROCKCHIP
-	tristate "Rockchip gpio and pinctrl driver"
-	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
-	select GPIOLIB
-	select PINMUX
 	select GENERIC_PINCONF
-	select GENERIC_IRQ_CHIP
-	select MFD_SYSCON
+	select GENERIC_PINCTRL_GROUPS
+	select GENERIC_PINMUX_FUNCTIONS
 	select OF_GPIO
-	default ARCH_ROCKCHIP
 	help
-          This support pinctrl and gpio driver for Rockchip SoCs.
+	  Support for the serial GPIO interface used on Microsemi and
+	  Microchip SoCs. By using a serial interface, the SIO
+	  controller significantly extends the number of available
+	  GPIOs with a minimum number of additional pins on the
+	  device. The primary purpose of the SIO controller is to
+	  connect control signals from SFP modules and to act as an
+	  LED controller.
 
-config PINCTRL_SINGLE
-	tristate "One-register-per-pin type device tree based pinctrl driver"
+config PINCTRL_OCELOT
+	bool "Pinctrl driver for the Microsemi Ocelot and Jaguar2 SoCs"
 	depends on OF
 	depends on HAS_IOMEM
-	select GENERIC_PINCTRL_GROUPS
-	select GENERIC_PINMUX_FUNCTIONS
-	select GENERIC_PINCONF
-	help
-	  This selects the device tree based generic pinctrl driver.
-
-config PINCTRL_SX150X
-	bool "Semtech SX150x I2C GPIO expander pinctrl driver"
-	depends on I2C=y
-	select PINMUX
-	select PINCONF
-	select GENERIC_PINCONF
 	select GPIOLIB
 	select GPIOLIB_IRQCHIP
-	select REGMAP
-	help
-	  Say yes here to provide support for Semtech SX150x-series I2C
-	  GPIO expanders as pinctrl module.
-	  Compatible models include:
-	  - 8 bits:  sx1508q, sx1502q
-	  - 16 bits: sx1509q, sx1506q
-
-config PINCTRL_PISTACHIO
-	bool "IMG Pistachio SoC pinctrl driver"
-	depends on OF && (MIPS || COMPILE_TEST)
-	depends on GPIOLIB
-	select PINMUX
 	select GENERIC_PINCONF
-	select GPIOLIB_IRQCHIP
+	select GENERIC_PINCTRL_GROUPS
+	select GENERIC_PINMUX_FUNCTIONS
 	select OF_GPIO
-    help
-	  This support pinctrl and gpio driver for IMG Pistachio SoC.
+	select REGMAP_MMIO
 
-config PINCTRL_ST
+config PINCTRL_OXNAS
 	bool
 	depends on OF
 	select PINMUX
 	select PINCONF
-	select GPIOLIB_IRQCHIP
-
-config PINCTRL_STMFX
-	tristate "STMicroelectronics STMFX GPIO expander pinctrl driver"
-	depends on I2C
-	depends on OF_GPIO
 	select GENERIC_PINCONF
+	select GPIOLIB
+	select OF_GPIO
 	select GPIOLIB_IRQCHIP
-	select MFD_STMFX
-	help
-	  Driver for STMicroelectronics Multi-Function eXpander (STMFX)
-	  GPIO expander.
-	  This provides a GPIO interface supporting inputs and outputs,
-	  and configuring push-pull, open-drain, and can also be used as
-	  interrupt-controller.
-
-config PINCTRL_MAX77620
-	tristate "MAX77620/MAX20024 Pincontrol support"
-	depends on MFD_MAX77620 && OF
-	select PINMUX
-	select GENERIC_PINCONF
-	help
-	  Say Yes here to enable Pin control support for Maxim PMIC MAX77620.
-	  This PMIC has 8 GPIO pins that work as GPIO as well as special
-	  function in alternate mode. This driver also configure push-pull,
-	  open drain, FPS slots etc.
+	select MFD_SYSCON
 
 config PINCTRL_PALMAS
 	tristate "Pinctrl driver for the PALMAS Series MFD devices"
@@ -334,41 +361,16 @@ config PINCTRL_PIC32MZDA
 	def_bool y if PIC32MZDA
 	select PINCTRL_PIC32
 
-config PINCTRL_ZYNQ
-	bool "Pinctrl driver for Xilinx Zynq"
-	depends on ARCH_ZYNQ
-	select PINMUX
-	select GENERIC_PINCONF
-	help
-	  This selects the pinctrl driver for Xilinx Zynq.
-
-config PINCTRL_ZYNQMP
-	tristate "Pinctrl driver for Xilinx ZynqMP"
-	depends on ZYNQMP_FIRMWARE
+config PINCTRL_PISTACHIO
+	bool "IMG Pistachio SoC pinctrl driver"
+	depends on OF && (MIPS || COMPILE_TEST)
+	depends on GPIOLIB
 	select PINMUX
 	select GENERIC_PINCONF
-	default ZYNQMP_FIRMWARE
-	help
-	  This selects the pinctrl driver for Xilinx ZynqMP platform.
-	  This driver will query the pin information from the firmware
-	  and allow configuring the pins.
-	  Configuration can include the mux function to select on those
-	  pin(s)/group(s), and various pin configuration parameters
-	  such as pull-up, slew rate, etc.
-	  This driver can also be built as a module. If so, the module
-	  will be called pinctrl-zynqmp.
-
-config PINCTRL_INGENIC
-	bool "Pinctrl driver for the Ingenic JZ47xx SoCs"
-	default MACH_INGENIC
-	depends on OF
-	depends on MIPS || COMPILE_TEST
-	select GENERIC_PINCONF
-	select GENERIC_PINCTRL_GROUPS
-	select GENERIC_PINMUX_FUNCTIONS
-	select GPIOLIB
 	select GPIOLIB_IRQCHIP
-	select REGMAP_MMIO
+	select OF_GPIO
+	help
+	  This support pinctrl and GPIO driver for IMG Pistachio SoC.
 
 config PINCTRL_RK805
 	tristate "Pinctrl and GPIO driver for RK805 PMIC"
@@ -379,53 +381,75 @@ config PINCTRL_RK805
 	help
 	  This selects the pinctrl driver for RK805.
 
-config PINCTRL_OCELOT
-	bool "Pinctrl driver for the Microsemi Ocelot and Jaguar2 SoCs"
+config PINCTRL_ROCKCHIP
+	tristate "Rockchip gpio and pinctrl driver"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on OF
-	depends on HAS_IOMEM
 	select GPIOLIB
-	select GPIOLIB_IRQCHIP
+	select PINMUX
 	select GENERIC_PINCONF
-	select GENERIC_PINCTRL_GROUPS
-	select GENERIC_PINMUX_FUNCTIONS
+	select GENERIC_IRQ_CHIP
+	select MFD_SYSCON
 	select OF_GPIO
-	select REGMAP_MMIO
+	default ARCH_ROCKCHIP
+	help
+          This support pinctrl and GPIO driver for Rockchip SoCs.
 
-config PINCTRL_MICROCHIP_SGPIO
-	bool "Pinctrl driver for Microsemi/Microchip Serial GPIO"
+config PINCTRL_SINGLE
+	tristate "One-register-per-pin type device tree based pinctrl driver"
 	depends on OF
 	depends on HAS_IOMEM
-	select GPIOLIB
-	select GPIOLIB_IRQCHIP
-	select GENERIC_PINCONF
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
-	select OF_GPIO
+	select GENERIC_PINCONF
 	help
-	  Support for the serial GPIO interface used on Microsemi and
-	  Microchip SoC's. By using a serial interface, the SIO
-	  controller significantly extends the number of available
-	  GPIOs with a minimum number of additional pins on the
-	  device. The primary purpose of the SIO controller is to
-	  connect control signals from SFP modules and to act as an
-	  LED controller.
+	  This selects the device tree based generic pinctrl driver.
 
-config PINCTRL_K210
-	bool "Pinctrl driver for the Canaan Kendryte K210 SoC"
-	depends on RISCV && SOC_CANAAN && OF
-	select GENERIC_PINMUX_FUNCTIONS
+config PINCTRL_ST
+	bool
+	depends on OF
+	select PINMUX
+	select PINCONF
+	select GPIOLIB_IRQCHIP
+
+config PINCTRL_STMFX
+	tristate "STMicroelectronics STMFX GPIO expander pinctrl driver"
+	depends on I2C
+	depends on OF_GPIO
+	select GENERIC_PINCONF
+	select GPIOLIB_IRQCHIP
+	select MFD_STMFX
+	help
+	  Driver for STMicroelectronics Multi-Function eXpander (STMFX)
+	  GPIO expander.
+	  This provides a GPIO interface supporting inputs and outputs,
+	  and configuring push-pull, open-drain, and can also be used as
+	  interrupt-controller.
+
+config PINCTRL_SX150X
+	bool "Semtech SX150x I2C GPIO expander pinctrl driver"
+	depends on I2C=y
+	select PINMUX
+	select PINCONF
 	select GENERIC_PINCONF
 	select GPIOLIB
-	select OF_GPIO
-	select REGMAP_MMIO
-	default SOC_CANAAN
+	select GPIOLIB_IRQCHIP
+	select REGMAP
 	help
-	  Add support for the Canaan Kendryte K210 RISC-V SOC Field
-	  Programmable IO Array (FPIOA) controller.
+	  Say Y here to provide support for Semtech SX150x-series I2C
+	  GPIO expanders as pinctrl module.
+	  Compatible models include:
+	  - 8 bits:  sx1508q, sx1502q
+	  - 16 bits: sx1509q, sx1506q
 
-config PINCTRL_KEEMBAY
-	tristate "Pinctrl driver for Intel Keem Bay SoC"
-	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
+config PINCTRL_TB10X
+	bool
+	depends on OF && ARC_PLAT_TB10X
+	select GPIOLIB
+
+config PINCTRL_THUNDERBAY
+	tristate "Generic pinctrl and GPIO driver for Intel Thunder Bay SoC"
+	depends on ARCH_THUNDERBAY || (ARM64 && COMPILE_TEST)
 	depends on HAS_IOMEM
 	select PINMUX
 	select PINCONF
@@ -436,18 +460,45 @@ config PINCTRL_KEEMBAY
 	select GPIOLIB_IRQCHIP
 	select GPIO_GENERIC
 	help
-	  This selects pin control driver for the Intel Keembay SoC.
-	  It provides pin config functions such as pullup, pulldown,
-	  interrupt, drive strength, sec lock, schmitt trigger, slew
+	  This selects pin control driver for the Intel Thunder Bay SoC.
+	  It provides pin config functions such as pull-up, pull-down,
+	  interrupt, drive strength, sec lock, Schmitt trigger, slew
 	  rate control and direction control. This module will be
-	  called as pinctrl-keembay.
+	  called as pinctrl-thunderbay.
+
+config PINCTRL_ZYNQ
+	bool "Pinctrl driver for Xilinx Zynq"
+	depends on ARCH_ZYNQ
+	select PINMUX
+	select GENERIC_PINCONF
+	help
+	  This selects the pinctrl driver for Xilinx Zynq.
+
+config PINCTRL_ZYNQMP
+	tristate "Pinctrl driver for Xilinx ZynqMP"
+	depends on ZYNQMP_FIRMWARE
+	select PINMUX
+	select GENERIC_PINCONF
+	default ZYNQMP_FIRMWARE
+	help
+	  This selects the pinctrl driver for Xilinx ZynqMP platform.
+	  This driver will query the pin information from the firmware
+	  and allow configuring the pins.
+	  Configuration can include the mux function to select on those
+	  pin(s)/group(s), and various pin configuration parameters
+	  such as pull-up, slew rate, etc.
+	  This driver can also be built as a module. If so, the module
+	  will be called pinctrl-zynqmp.
 
 source "drivers/pinctrl/actions/Kconfig"
 source "drivers/pinctrl/aspeed/Kconfig"
 source "drivers/pinctrl/bcm/Kconfig"
 source "drivers/pinctrl/berlin/Kconfig"
+source "drivers/pinctrl/cirrus/Kconfig"
 source "drivers/pinctrl/freescale/Kconfig"
 source "drivers/pinctrl/intel/Kconfig"
+source "drivers/pinctrl/mediatek/Kconfig"
+source "drivers/pinctrl/meson/Kconfig"
 source "drivers/pinctrl/mvebu/Kconfig"
 source "drivers/pinctrl/nomadik/Kconfig"
 source "drivers/pinctrl/nuvoton/Kconfig"
@@ -463,59 +514,7 @@ source "drivers/pinctrl/sunxi/Kconfig"
 source "drivers/pinctrl/tegra/Kconfig"
 source "drivers/pinctrl/ti/Kconfig"
 source "drivers/pinctrl/uniphier/Kconfig"
-source "drivers/pinctrl/vt8500/Kconfig"
-source "drivers/pinctrl/mediatek/Kconfig"
-source "drivers/pinctrl/meson/Kconfig"
-source "drivers/pinctrl/cirrus/Kconfig"
 source "drivers/pinctrl/visconti/Kconfig"
-
-config PINCTRL_XWAY
-	bool
-	depends on SOC_TYPE_XWAY
-	depends on PINCTRL_LANTIQ
-
-config PINCTRL_TB10X
-	bool
-	depends on OF && ARC_PLAT_TB10X
-	select GPIOLIB
-
-config PINCTRL_EQUILIBRIUM
-	tristate "Generic pinctrl and GPIO driver for Intel Lightning Mountain SoC"
-	depends on OF && HAS_IOMEM
-	depends on X86 || COMPILE_TEST
-	select PINMUX
-	select PINCONF
-	select GPIOLIB
-	select GPIO_GENERIC
-	select GPIOLIB_IRQCHIP
-	select GENERIC_PINCONF
-	select GENERIC_PINCTRL_GROUPS
-	select GENERIC_PINMUX_FUNCTIONS
-
-	help
-	  Equilibrium pinctrl driver is a pinctrl & GPIO driver for Intel Lightning
-	  Mountain network processor SoC that supports both the linux GPIO and pin
-	  control frameworks. It provides interfaces to setup pinmux, assign desired
-	  pin functions, configure GPIO attributes for LGM SoC pins. Pinmux and
-	  pinconf settings are retrieved from device tree.
-
-config PINCTRL_THUNDERBAY
-	tristate "Generic pinctrl and GPIO driver for Intel Thunder Bay SoC"
-	depends on ARCH_THUNDERBAY || (ARM64 && COMPILE_TEST)
-	depends on HAS_IOMEM
-	select PINMUX
-	select PINCONF
-	select GENERIC_PINCONF
-	select GENERIC_PINCTRL_GROUPS
-	select GENERIC_PINMUX_FUNCTIONS
-	select GPIOLIB
-	select GPIOLIB_IRQCHIP
-	select GPIO_GENERIC
-	help
-	  This selects pin control driver for the Intel Thunder Bay SoC.
-	  It provides pin config functions such as pullup, pulldown,
-	  interrupt, drive strength, sec lock, schmitt trigger, slew
-	  rate control and direction control. This module will be
-	  called as pinctrl-thunderbay.
+source "drivers/pinctrl/vt8500/Kconfig"
 
 endif
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 0d5744e7f8fb..6be6c3fc6663 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -6,57 +6,59 @@ subdir-ccflags-$(CONFIG_DEBUG_PINCTRL)	+= -DDEBUG
 obj-y				+= core.o pinctrl-utils.o
 obj-$(CONFIG_PINMUX)		+= pinmux.o
 obj-$(CONFIG_PINCONF)		+= pinconf.o
-obj-$(CONFIG_OF)		+= devicetree.o
 obj-$(CONFIG_GENERIC_PINCONF)	+= pinconf-generic.o
+obj-$(CONFIG_OF)		+= devicetree.o
+
+obj-$(CONFIG_PINCTRL_AMD)	+= pinctrl-amd.o
 obj-$(CONFIG_PINCTRL_APPLE_GPIO) += pinctrl-apple-gpio.o
 obj-$(CONFIG_PINCTRL_ARTPEC6)	+= pinctrl-artpec6.o
 obj-$(CONFIG_PINCTRL_AS3722)	+= pinctrl-as3722.o
-obj-$(CONFIG_PINCTRL_AXP209)	+= pinctrl-axp209.o
 obj-$(CONFIG_PINCTRL_AT91)	+= pinctrl-at91.o
 obj-$(CONFIG_PINCTRL_AT91PIO4)	+= pinctrl-at91-pio4.o
-obj-$(CONFIG_PINCTRL_AMD)	+= pinctrl-amd.o
+obj-$(CONFIG_PINCTRL_AXP209)	+= pinctrl-axp209.o
 obj-$(CONFIG_PINCTRL_BM1880)	+= pinctrl-bm1880.o
 obj-$(CONFIG_PINCTRL_DA850_PUPD) += pinctrl-da850-pupd.o
 obj-$(CONFIG_PINCTRL_DA9062)	+= pinctrl-da9062.o
 obj-$(CONFIG_PINCTRL_DIGICOLOR)	+= pinctrl-digicolor.o
-obj-$(CONFIG_PINCTRL_FALCON)	+= pinctrl-falcon.o
+obj-$(CONFIG_PINCTRL_EQUILIBRIUM)   += pinctrl-equilibrium.o
 obj-$(CONFIG_PINCTRL_GEMINI)	+= pinctrl-gemini.o
+obj-$(CONFIG_PINCTRL_INGENIC)	+= pinctrl-ingenic.o
+obj-$(CONFIG_PINCTRL_K210)	+= pinctrl-k210.o
+obj-$(CONFIG_PINCTRL_KEEMBAY)	+= pinctrl-keembay.o
+obj-$(CONFIG_PINCTRL_LANTIQ)	+= pinctrl-lantiq.o
+obj-$(CONFIG_PINCTRL_FALCON)	+= pinctrl-falcon.o
+obj-$(CONFIG_PINCTRL_XWAY)	+= pinctrl-xway.o
+obj-$(CONFIG_PINCTRL_LPC18XX)	+= pinctrl-lpc18xx.o
 obj-$(CONFIG_PINCTRL_MAX77620)	+= pinctrl-max77620.o
 obj-$(CONFIG_PINCTRL_MCP23S08_I2C)	+= pinctrl-mcp23s08_i2c.o
 obj-$(CONFIG_PINCTRL_MCP23S08_SPI)	+= pinctrl-mcp23s08_spi.o
 obj-$(CONFIG_PINCTRL_MCP23S08)	+= pinctrl-mcp23s08.o
-obj-$(CONFIG_PINCTRL_MESON)	+= meson/
+obj-$(CONFIG_PINCTRL_MICROCHIP_SGPIO)	+= pinctrl-microchip-sgpio.o
+obj-$(CONFIG_PINCTRL_OCELOT)	+= pinctrl-ocelot.o
 obj-$(CONFIG_PINCTRL_OXNAS)	+= pinctrl-oxnas.o
 obj-$(CONFIG_PINCTRL_PALMAS)	+= pinctrl-palmas.o
 obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
 obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
+obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
+obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
+obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
-obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
-obj-$(CONFIG_PINCTRL_XWAY)	+= pinctrl-xway.o
-obj-$(CONFIG_PINCTRL_LANTIQ)	+= pinctrl-lantiq.o
-obj-$(CONFIG_PINCTRL_LPC18XX)	+= pinctrl-lpc18xx.o
 obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
-obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
-obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
-obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
-obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
-obj-$(CONFIG_PINCTRL_INGENIC)	+= pinctrl-ingenic.o
-obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
-obj-$(CONFIG_PINCTRL_OCELOT)	+= pinctrl-ocelot.o
-obj-$(CONFIG_PINCTRL_MICROCHIP_SGPIO)	+= pinctrl-microchip-sgpio.o
-obj-$(CONFIG_PINCTRL_EQUILIBRIUM)   += pinctrl-equilibrium.o
-obj-$(CONFIG_PINCTRL_K210)	+= pinctrl-k210.o
-obj-$(CONFIG_PINCTRL_KEEMBAY)	+= pinctrl-keembay.o
 obj-$(CONFIG_PINCTRL_THUNDERBAY) += pinctrl-thunderbay.o
+obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
+obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 
 obj-y				+= actions/
 obj-$(CONFIG_ARCH_ASPEED)	+= aspeed/
 obj-y				+= bcm/
 obj-$(CONFIG_PINCTRL_BERLIN)	+= berlin/
+obj-y				+= cirrus/
 obj-y				+= freescale/
 obj-$(CONFIG_X86)		+= intel/
+obj-y				+= mediatek/
+obj-$(CONFIG_PINCTRL_MESON)	+= meson/
 obj-y				+= mvebu/
 obj-y				+= nomadik/
 obj-$(CONFIG_ARCH_NPCM7XX)	+= nuvoton/
@@ -69,9 +71,8 @@ obj-$(CONFIG_PINCTRL_SPEAR)	+= spear/
 obj-y				+= sprd/
 obj-$(CONFIG_PINCTRL_STM32)	+= stm32/
 obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
+obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-y				+= ti/
 obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
-obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
-obj-y				+= mediatek/
-obj-y				+= cirrus/
 obj-$(CONFIG_PINCTRL_VISCONTI)	+= visconti/
+obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
-- 
2.33.0

