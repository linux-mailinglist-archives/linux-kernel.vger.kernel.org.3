Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7855947ECDE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 08:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351913AbhLXHu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 02:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343632AbhLXHux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 02:50:53 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBFCC061401;
        Thu, 23 Dec 2021 23:50:53 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c2so7241617pfc.1;
        Thu, 23 Dec 2021 23:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ywzmsSXAMm3cMcciOYhk7EZ+Z7pIuG1WJJNvvsCVcM=;
        b=M7E2vztNEeXGZcjKPDsl4hxldrPpgR8U/5+7++xnsmH5iVQhd6QADQdet/kV9JoUT7
         Yy4l6zpCoNwu0nWBGqaxtwrxmB/jqTT5eHJKaXiRBqJpqV6L7qCrLrfRj7lkLXpprHmg
         OVSY15hIkmq43/hPFFh2ocnjU2tAJ+YCYmeTPRA5PGDuBE4Qbgdk8UWyBZIGiMeYmlne
         L7UonuL025NtYwxRneHh9/TAfoPJBO2OSNIwPf47wDvQQSHqE7Res6zFtdTlcBfM/qAe
         tXafqq6mLQfwgcTgyqXK5NCHkXgM9Uy7D2TCQApmEXFAs9II0Mm0UWfYgGieGBkrFAy7
         HKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ywzmsSXAMm3cMcciOYhk7EZ+Z7pIuG1WJJNvvsCVcM=;
        b=H5Tgd0YMhN3KoSjrFKKXqOTm0hU5waHXRVpOuVvteu+QrrMY1fyUEHJYq9R286rG/a
         em9XVGlZOPrj+UrvSRPKEllELaBVTDagzQkJkcgTZ5LFVNckADC51T7uceDvEmyxMqOO
         /gvbY1rS2kmTYZ2LE5aiFyi4IVbP1dpUJDPQ9D+THNHs8Vv9vdRfTam+mGnZ8GcC3OUa
         hptnERuOmaO/xrQ526umGr9lfKk30qU8i1Rb0RAidYLgCFzvqVIn5L6RUwuaoXAiKu38
         aQW57wwIT7vbaWkAMTciS3JydzLtU6TwOEjXhz104EJncqSNyKkMi5CwJXgzXbZXc/dU
         8Btw==
X-Gm-Message-State: AOAM5309kWyjQpuVAiEyjJ+ymebMAmf64SSlXzipNYsgsgDnnZRTSp3N
        csUh9OebeE4hVkHaESjQLIQ=
X-Google-Smtp-Source: ABdhPJxj2SOmHzB2xS6f6rCywIGPfwTKA2eLedmCkDIBwMJP06zuTGoEC2t39Bm5QGl3dIAD1MyVVg==
X-Received: by 2002:a63:b914:: with SMTP id z20mr5155061pge.496.1640332251951;
        Thu, 23 Dec 2021 23:50:51 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h15sm8649164pfc.134.2021.12.23.23.50.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 23:50:51 -0800 (PST)
From:   Wells Lu <wellslutw@gmail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     wells.lu@sunplus.com, dvorkin@tibbo.com,
        Wells Lu <wellslutw@gmail.com>
Subject: [PATCH v5 2/2] pinctrl: Add driver for Sunplus SP7021
Date:   Fri, 24 Dec 2021 15:42:59 +0800
Message-Id: <1640331779-18277-3-git-send-email-wellslutw@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640331779-18277-1-git-send-email-wellslutw@gmail.com>
References: <1640331779-18277-1-git-send-email-wellslutw@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for Sunplus SP7021 SoC.

Signed-off-by: Wells Lu <wellslutw@gmail.com>
---
Changes in V5
  - Addedssed comments of Mr. Andy Shevchenko
    - Re-ordered and added more header files.
    - Revised comment-style of multi-line.
    - Added inline functions for GPIO-related registers accesses.
    - Added lock/unlock for some GPIO operations.
    - Removed most of dev_dbg() functions. Only keep some for dt node debug.
    - Added extra comma at end of the last element of constant arraies.
    - Added 'check_mul_overflow' for devm_kcalloc() function.
    - Cleaned up code of sppctl_resource_map() function.
    - Modified and added more comments.
    - Others
  - Removed "GPIOXT2" registers

 MAINTAINERS                             |    1 +
 drivers/pinctrl/Kconfig                 |    1 +
 drivers/pinctrl/Makefile                |    1 +
 drivers/pinctrl/sunplus/Kconfig         |   21 +
 drivers/pinctrl/sunplus/Makefile        |    5 +
 drivers/pinctrl/sunplus/sppctl.c        | 1178 +++++++++++++++++++++++++++++++
 drivers/pinctrl/sunplus/sppctl.h        |  155 ++++
 drivers/pinctrl/sunplus/sppctl_sp7021.c |  584 +++++++++++++++
 8 files changed, 1946 insertions(+)
 create mode 100644 drivers/pinctrl/sunplus/Kconfig
 create mode 100644 drivers/pinctrl/sunplus/Makefile
 create mode 100644 drivers/pinctrl/sunplus/sppctl.c
 create mode 100644 drivers/pinctrl/sunplus/sppctl.h
 create mode 100644 drivers/pinctrl/sunplus/sppctl_sp7021.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b1cfc2..e0dca8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15134,6 +15134,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/pinctrl/sunplus,*
+F:	drivers/pinctrl/sunplus/
 F:	include/dt-bindings/pinctrl/sppctl*
 
 PKTCDVD DRIVER
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 6a961d5..5aa4e29 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -459,6 +459,7 @@ source "drivers/pinctrl/samsung/Kconfig"
 source "drivers/pinctrl/spear/Kconfig"
 source "drivers/pinctrl/sprd/Kconfig"
 source "drivers/pinctrl/stm32/Kconfig"
+source "drivers/pinctrl/sunplus/Kconfig"
 source "drivers/pinctrl/sunxi/Kconfig"
 source "drivers/pinctrl/tegra/Kconfig"
 source "drivers/pinctrl/ti/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 5e63de2..9f1eef3 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_PINCTRL_SAMSUNG)	+= samsung/
 obj-$(CONFIG_PINCTRL_SPEAR)	+= spear/
 obj-y				+= sprd/
 obj-$(CONFIG_PINCTRL_STM32)	+= stm32/
+obj-y				+= sunplus/
 obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
 obj-y				+= ti/
 obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
diff --git a/drivers/pinctrl/sunplus/Kconfig b/drivers/pinctrl/sunplus/Kconfig
new file mode 100644
index 0000000..d9291a7
--- /dev/null
+++ b/drivers/pinctrl/sunplus/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Sunplus Pin control driver configuration
+#
+
+config PINCTRL_SPPCTL
+	bool "Sunplus SP7021 PinMux and GPIO driver"
+	depends on SOC_SP7021
+	depends on OF && HAS_IOMEM
+	select GENERIC_PINCTRL_GROUPS
+	select GENERIC_PINMUX_FUNCTIONS
+	select GENERIC_PINCONF
+	select PINCONF
+	select PINMUX
+	select GPIOLIB
+	select OF_GPIO
+	help
+	  Say Y here to support Sunplus SP7021 pinmux controller.
+	  The driver is selected automatically by platform.
+	  This driver requires the pinctrl framework.
+	  GPIO is provided by the same driver.
diff --git a/drivers/pinctrl/sunplus/Makefile b/drivers/pinctrl/sunplus/Makefile
new file mode 100644
index 0000000..63482da
--- /dev/null
+++ b/drivers/pinctrl/sunplus/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Sunplus Pin control drivers.
+#
+obj-$(CONFIG_PINCTRL_SPPCTL) += sppctl.o sppctl_sp7021.o
diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
new file mode 100644
index 0000000..f932664
--- /dev/null
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -0,0 +1,1178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SP7021 Pin Controller Driver.
+ * Copyright (C) Sunplus Tech / Tibbo Tech.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/overflow.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/pinctrl/sppctl-sp7021.h>
+
+#include "../core.h"
+#include "../pinctrl-utils.h"
+
+#include "sppctl.h"
+
+/* inline functions */
+static inline u32 sppctl_first_readl(struct sppctl_gpio_chip *spp_gchip, u32 off)
+{
+	return readl(spp_gchip->first_base + SPPCTL_GPIO_OFF_FIRST + off);
+}
+
+static inline void sppctl_first_writel(struct sppctl_gpio_chip *spp_gchip, u32 val, u32 off)
+{
+	writel(val, spp_gchip->first_base + SPPCTL_GPIO_OFF_FIRST + off);
+}
+
+static inline u32 sppctl_gpio_master_readl(struct sppctl_gpio_chip *spp_gchip, u32 off)
+{
+	return readl(spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_MASTER + off);
+}
+
+static inline void sppctl_gpio_master_writel(struct sppctl_gpio_chip *spp_gchip, u32 val,
+					     u32 off)
+{
+	writel(val, spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_MASTER + off);
+}
+
+static inline u32 sppctl_gpio_oe_readl(struct sppctl_gpio_chip *spp_gchip, u32 off)
+{
+	return readl(spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_OE + off);
+}
+
+static inline void sppctl_gpio_oe_writel(struct sppctl_gpio_chip *spp_gchip, u32 val, u32 off)
+{
+	writel(val, spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_OE + off);
+}
+
+static inline void sppctl_gpio_out_writel(struct sppctl_gpio_chip *spp_gchip, u32 val, u32 off)
+{
+	writel(val, spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_OUT + off);
+}
+
+static inline u32 sppctl_gpio_in_readl(struct sppctl_gpio_chip *spp_gchip, u32 off)
+{
+	return readl(spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_IN + off);
+}
+
+static inline u32 sppctl_gpio_iinv_readl(struct sppctl_gpio_chip *spp_gchip, u32 off)
+{
+	return readl(spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_IINV + off);
+}
+
+static inline void sppctl_gpio_iinv_writel(struct sppctl_gpio_chip *spp_gchip, u32 val,
+					   u32 off)
+{
+	writel(val, spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_IINV + off);
+}
+
+static inline u32 sppctl_gpio_oinv_readl(struct sppctl_gpio_chip *spp_gchip, u32 off)
+{
+	return readl(spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_OINV + off);
+}
+
+static inline void sppctl_gpio_oinv_writel(struct sppctl_gpio_chip *spp_gchip, u32 val,
+					   u32 off)
+{
+	writel(val, spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_OINV + off);
+}
+
+static inline u32 sppctl_gpio_od_readl(struct sppctl_gpio_chip *spp_gchip, u32 off)
+{
+	return readl(spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_OD + off);
+}
+
+static inline void sppctl_gpio_od_writel(struct sppctl_gpio_chip *spp_gchip, u32 val, u32 off)
+{
+	writel(val, spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_OD + off);
+}
+
+/**
+ * sppctl_func_set() - Set pin of fully-pinmux function.
+ *
+ * Mask-fields and control-fields of fully-pinmux function of SP7021 are
+ * arranged as shown below:
+ *
+ *  func# | register |  mask-field  | control-field
+ * -------+----------+--------------+---------------
+ *    0   | base[0]  |  (22 : 16)   |   ( 6 : 0)
+ *    1   | base[0]  |  (30 : 24)   |   (14 : 8)
+ *    2   | base[1]  |  (22 : 16)   |   ( 6 : 0)
+ *    3   | baeg[1]  |  (30 : 24)   |   (14 : 8)
+ *    :   |    :     |      :       |       :
+ *
+ * where mask-fields are used to protect control-fields from write-in
+ * accidentally. Set the corresponding bits in the mask-field before
+ * you write a value into a control-field.
+ *
+ * Control-fields are used to set where the function pin is going to
+ * be routed to.
+ *
+ * Note that mask-fields and control-fields of even number of 'func'
+ * are located at bits (22:16) and (6:0), while odd number of 'func's
+ * are located at bits (30:24) and (14:8).
+ */
+static void sppctl_func_set(struct sppctl_pdata *pctl, u8 func, u8 val)
+{
+	u32 reg, offset;
+
+	/*
+	 * Note that upper 16-bit word are mask-fields and lower 16-bit
+	 * word are the control-fields. Set corresponding bits in mask-
+	 * field before write to a control-field.
+	 */
+	reg = SPPCTL_FULLY_PINMUX_MASK_MASK | val;
+
+	/*
+	 * Check if 'func' is an odd number or not. Mask and control-
+	 * fields of odd number 'func' is located at upper portion of
+	 * a register. Extra shift is needed.
+	 */
+	if (func & BIT(0))
+		reg <<= SPPCTL_FULLY_PINMUX_UPPER_SHIFT;
+
+	/* Convert func# to register offset w.r.t. base register. */
+	offset = func * 2;
+	offset &= GENMASK(31, 2);
+
+	writel(reg, pctl->moon2_base + offset);
+}
+
+/**
+ * sppctl_gmx_set() - Set pin of group-pinmux.
+ *
+ * Mask-fields and control-fields of group-pinmux function of SP7021 are
+ * arranged as shown below:
+ *
+ *  register |  mask-fields | control-fields
+ * ----------+--------------+----------------
+ *  base[0]  |  (31 : 16)   |   (15 : 0)
+ *  base[1]  |  (31 : 24)   |   (15 : 0)
+ *  base[2]  |  (31 : 24)   |   (15 : 0)
+ *     :     |      :       |       :
+ *
+ * where mask-fields are used to protect control-fields from write-in
+ * accidentally. Set the corresponding bits in the mask-field before
+ * you write a value into a control-field.
+ *
+ * Control-fields are used to set where the function pin is going to
+ * be routed to. A control-field consists of one or more bits.
+ */
+static void sppctl_gmx_set(struct sppctl_pdata *pctl, u8 reg_off, u8 bit_off, u8 bit_sz,
+			   u8 val)
+{
+	u32 mask, reg;
+
+	/*
+	 * Note that upper 16-bit word are mask-fields and lower 16-bit
+	 * word are the control-fields. Set corresponding bits in mask-
+	 * field before write to a control-field.
+	 */
+	mask = GENMASK(bit_sz - 1, 0) << (bit_off + SPPCTL_GROUP_PINMUX_MASK_SHIFT);
+	reg = mask | (val << bit_off);
+
+	writel(reg, pctl->moon1_base + reg_off * 4);
+}
+
+/**
+ * sppctl_first_get() - get bit of first register.
+ *
+ * There are 4 FIRST registers. Each has 32 control-bits.
+ * Totally, there are 4 * 32 = 128 control-bits.
+ * Control-bits are arranged as shown below:
+ *
+ *  registers | control-bits
+ * -----------+--------------
+ *  first[0]  |  (31 :  0)
+ *  first[1]  |  (63 : 32)
+ *  first[2]  |  (95 : 64)
+ *  first[3]  | (127 : 96)
+ *
+ * Each control-bit sets type of a GPIO pin.
+ *   0: a fully-pinmux pin
+ *   1: a GPIO or IOP pin
+ */
+static int sppctl_first_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off = (offset / 32) * 4;
+	u32 bit_off = offset % 32;
+	u32 reg;
+
+	reg = sppctl_first_readl(spp_gchip, reg_off);
+	return (reg & BIT(bit_off)) ? 1 : 0;
+}
+
+/**
+ * sppctl_master_get() - get bit of master register.
+ *
+ * There are 8 MASTER registers. Each has 16 mask-bits and 16 control-bits.
+ * Upper 16-bit of MASTER registers are mask-bits while lower 16-bit are
+ * control-bits. Totally, there are 128 mask-bits and 128 control-bits.
+ * They are arranged as shown below:
+ *
+ *  register  |  mask-bits  | control-bits
+ * -----------+-------------+--------------
+ *  master[0] |  (15 :   0) |  (15 :   0)
+ *  master[1] |  (31 :  16) |  (31 :  16)
+ *  master[2] |  (47 :  32) |  (47 :  32)
+ *     :      |      :      |      :
+ *  master[7] | (127 : 112) | (127 : 112)
+ *
+ * where mask-bits are used to protect control-bits from write-in
+ * accidentally. Set the corresponding mask-bit before you write
+ * a value into a control-bit.
+ *
+ * Each control-bit sets type of a GPIO pin when FIRST bit is 1.
+ *   0: a IOP pin
+ *   1: a GPIO pin
+ */
+static int sppctl_master_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off = (offset / 16) * 4;
+	u32 bit_off = offset % 16;
+	u32 reg;
+
+	reg = sppctl_gpio_master_readl(spp_gchip, reg_off);
+	return (reg & BIT(bit_off)) ? 1 : 0;
+}
+
+static void sppctl_first_master_set(struct gpio_chip *chip, unsigned int offset,
+				    enum mux_first_reg first, enum mux_master_reg master)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off, bit_off, reg;
+	int val;
+
+	/* FIRST register */
+	if (first != mux_f_keep) {
+		/*
+		 * Refer to descriptions of function sppctl_first_get()
+		 * for usage of FIRST registers.
+		 */
+		reg_off = (offset / 32) * 4;
+		bit_off = offset % 32;
+
+		reg = sppctl_first_readl(spp_gchip, reg_off);
+		val = (reg & BIT(bit_off)) ? 1 : 0;
+
+		if (first != val) {
+			if (first == mux_f_gpio)
+				reg |= BIT(bit_off);
+			else
+				reg &= ~BIT(bit_off);
+			sppctl_first_writel(spp_gchip, reg, reg_off);
+		}
+	}
+
+	/* MASTER register */
+	if (master != mux_m_keep) {
+		/*
+		 * Refer to descriptions of function sppctl_master_get()
+		 * for usage of MASTER registers.
+		 */
+		reg_off = (offset / 16) * 4;
+		bit_off = offset % 16;
+
+		reg = BIT(bit_off) << SPPCTL_MASTER_MASK_SHIFT;
+		if (master == mux_m_gpio)
+			reg |= BIT(bit_off);
+		sppctl_gpio_master_writel(spp_gchip, reg, reg_off);
+	}
+}
+
+static void sppctl_gpio_input_inv_set(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off, bit_off, reg;
+
+	/*
+	 * Upper 16-bit word is mask. Lower 16-bit word is value.
+	 * Refer to descriptions of function sppctl_master_get().
+	 */
+	reg_off = (offset / 16) * 4;
+	bit_off = offset % 16;
+	reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT) | BIT(bit_off);
+
+	sppctl_gpio_iinv_writel(spp_gchip, reg, reg_off);
+}
+
+static void sppctl_gpio_output_inv_set(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off, bit_off, reg;
+
+	/*
+	 * Upper 16-bit word is mask. Lower 16-bit word is value.
+	 * Refer to descriptions of function sppctl_master_get().
+	 */
+	reg_off = (offset / 16) * 4;
+	bit_off = offset % 16;
+	reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT) | BIT(bit_off);
+
+	sppctl_gpio_oinv_writel(spp_gchip, reg, reg_off);
+}
+
+static int sppctl_gpio_output_od_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off, bit_off, reg;
+
+	/*
+	 * Upper 16-bit word is mask. Lower 16-bit word is value.
+	 * Refer to descriptions of function sppctl_master_get().
+	 */
+	reg_off = (offset / 16) * 4;
+	bit_off = offset % 16;
+	reg = sppctl_gpio_od_readl(spp_gchip, reg_off);
+
+	return (reg & BIT(bit_off)) ? 1 : 0;
+}
+
+static void sppctl_gpio_output_od_set(struct gpio_chip *chip, unsigned int offset,
+				      unsigned int val)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off, bit_off, reg;
+
+	/*
+	 * Upper 16-bit word is mask. Lower 16-bit word is value.
+	 * Refer to descriptions of function sppctl_master_get().
+	 */
+	reg_off = (offset / 16) * 4;
+	bit_off = offset % 16;
+	reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT);
+	if (val)
+		reg |= BIT(bit_off);
+
+	sppctl_gpio_od_writel(spp_gchip, reg, reg_off);
+}
+
+static int sppctl_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off, bit_off, reg;
+
+	/*
+	 * Upper 16-bit word is mask. Lower 16-bit word is value.
+	 * Refer to descriptions of function sppctl_master_get().
+	 */
+	reg_off = (offset / 16) * 4;
+	bit_off = offset % 16;
+	reg = sppctl_gpio_oe_readl(spp_gchip, reg_off);
+
+	return (reg & BIT(bit_off)) ? 0 : 1;
+}
+
+static int sppctl_gpio_inv_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off, bit_off, reg;
+	unsigned long flags;
+
+	/*
+	 * Upper 16-bit word is mask. Lower 16-bit word is value.
+	 * Refer to descriptions of function sppctl_master_get().
+	 */
+	reg_off = (offset / 16) * 4;
+	bit_off = offset % 16;
+
+	spin_lock_irqsave(&spp_gchip->lock, flags);
+
+	if (sppctl_gpio_get_direction(chip, offset))
+		reg = sppctl_gpio_iinv_readl(spp_gchip, reg_off);
+	else
+		reg = sppctl_gpio_oinv_readl(spp_gchip, reg_off);
+
+	spin_unlock_irqrestore(&spp_gchip->lock, flags);
+
+	return (reg & BIT(bit_off)) ? 1 : 0;
+}
+
+static int sppctl_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off, bit_off, reg;
+	unsigned long flags;
+
+	/*
+	 * Upper 16-bit word is mask. Lower 16-bit word is value.
+	 * Refer to descriptions of function sppctl_master_get().
+	 */
+	reg_off = (offset / 16) * 4;
+	bit_off = offset % 16;
+	reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT);
+
+	spin_lock_irqsave(&spp_gchip->lock, flags);
+
+	sppctl_gpio_oe_writel(spp_gchip, reg, reg_off);
+
+	spin_unlock_irqrestore(&spp_gchip->lock, flags);
+	return 0;
+}
+
+static int sppctl_gpio_direction_output(struct gpio_chip *chip, unsigned int offset, int val)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off, bit_off, reg;
+	unsigned long flags;
+
+	/*
+	 * Upper 16-bit word is mask. Lower 16-bit word is value.
+	 * Refer to descriptions of function sppctl_master_get().
+	 */
+	reg_off = (offset / 16) * 4;
+	bit_off = offset % 16;
+	reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT) | BIT(bit_off);
+
+	spin_lock_irqsave(&spp_gchip->lock, flags);
+
+	sppctl_gpio_oe_writel(spp_gchip, reg, reg_off);
+
+	if (val < 0) {
+		spin_unlock_irqrestore(&spp_gchip->lock, flags);
+		return 0;
+	}
+
+	reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT);
+	if (val)
+		reg |= BIT(bit_off);
+
+	sppctl_gpio_out_writel(spp_gchip, reg, reg_off);
+
+	spin_unlock_irqrestore(&spp_gchip->lock, flags);
+	return 0;
+}
+
+static int sppctl_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off, bit_off, reg;
+
+	reg_off = (offset / 32) * 4;
+	bit_off = offset % 32;
+	reg = sppctl_gpio_in_readl(spp_gchip, reg_off);
+
+	return (reg & BIT(bit_off)) ? 1 : 0;
+}
+
+static void sppctl_gpio_set(struct gpio_chip *chip, unsigned int offset, int val)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off, bit_off, reg;
+
+	/*
+	 * Upper 16-bit word is mask. Lower 16-bit word is value.
+	 * Refer to descriptions of function sppctl_master_get().
+	 */
+	reg_off = (offset / 16) * 4;
+	bit_off = offset % 16;
+	reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT);
+	if (val)
+		reg |= BIT(bit_off);
+
+	sppctl_gpio_out_writel(spp_gchip, reg, reg_off);
+}
+
+static int sppctl_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
+				  unsigned long config)
+{
+	enum pin_config_param param = pinconf_to_config_param(config);
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg_off, bit_off, reg;
+	int ret = 0;
+
+	switch (param) {
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		/*
+		 * Upper 16-bit word is mask. Lower 16-bit word is value.
+		 * Refer to descriptions of function sppctl_master_get().
+		 */
+		reg_off = (offset / 16) * 4;
+		bit_off = offset % 16;
+		reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT) | BIT(bit_off);
+
+		sppctl_gpio_od_writel(spp_gchip, reg, reg_off);
+		break;
+
+	case PIN_CONFIG_INPUT_ENABLE:
+		break;
+
+	case PIN_CONFIG_OUTPUT:
+		ret = sppctl_gpio_direction_output(chip, offset, 0);
+		break;
+
+	case PIN_CONFIG_PERSIST_STATE:
+		ret = -ENOTSUPP;
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void sppctl_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
+{
+	const char *label;
+	int i;
+
+	for (i = 0; i < chip->ngpio; i++) {
+		label = gpiochip_is_requested(chip, i);
+		if (!label)
+			label = "";
+
+		seq_printf(s, " gpio-%03d (%-16.16s | %-16.16s)", i + chip->base,
+			   chip->names[i], label);
+		seq_printf(s, " %c", sppctl_gpio_get_direction(chip, i) ? 'I' : 'O');
+		seq_printf(s, ":%d", sppctl_gpio_get(chip, i));
+		seq_printf(s, " %s", sppctl_first_get(chip, i) ? "gpi" : "mux");
+		seq_printf(s, " %s", sppctl_master_get(chip, i) ? "gpi" : "iop");
+		seq_printf(s, " %s", sppctl_gpio_inv_get(chip, i) ? "inv" : "   ");
+		seq_printf(s, " %s", sppctl_gpio_output_od_get(chip, i) ? "oDr" : "");
+		seq_puts(s, "\n");
+	}
+}
+#endif
+
+static int sppctl_gpio_new(struct platform_device *pdev, struct sppctl_pdata *pctl)
+{
+	struct sppctl_gpio_chip *spp_gchip;
+	struct gpio_chip *gchip;
+	int err;
+
+	if (!of_find_property(pdev->dev.of_node, "gpio-controller", NULL))
+		return dev_err_probe(&pdev->dev, -EINVAL, "Not a gpio-controller!\n");
+
+	spp_gchip = devm_kzalloc(&pdev->dev, sizeof(*spp_gchip), GFP_KERNEL);
+	if (!spp_gchip)
+		return -ENOMEM;
+	pctl->spp_gchip = spp_gchip;
+
+	spp_gchip->gpioxt_base  = pctl->gpioxt_base;
+	spp_gchip->first_base   = pctl->first_base;
+	spin_lock_init(&spp_gchip->lock);
+
+	gchip                   = &spp_gchip->chip;
+	gchip->label            = SPPCTL_MODULE_NAME;
+	gchip->parent           = &pdev->dev;
+	gchip->owner            = THIS_MODULE;
+	gchip->request          = gpiochip_generic_request;
+	gchip->free             = gpiochip_generic_free;
+	gchip->get_direction    = sppctl_gpio_get_direction;
+	gchip->direction_input  = sppctl_gpio_direction_input;
+	gchip->direction_output = sppctl_gpio_direction_output;
+	gchip->get              = sppctl_gpio_get;
+	gchip->set              = sppctl_gpio_set;
+	gchip->set_config       = sppctl_gpio_set_config;
+#ifdef CONFIG_DEBUG_FS
+	gchip->dbg_show         = sppctl_gpio_dbg_show;
+#endif
+	gchip->base             = 0; /* it is main platform GPIO controller */
+	gchip->ngpio            = sppctl_gpio_list_sz;
+	gchip->names            = sppctl_gpio_list_s;
+	gchip->can_sleep        = 0;
+	gchip->of_gpio_n_cells  = 2;
+
+	pctl->pctl_grange.npins = gchip->ngpio;
+	pctl->pctl_grange.base  = gchip->base;
+	pctl->pctl_grange.name  = gchip->label;
+	pctl->pctl_grange.gc    = gchip;
+
+	err = devm_gpiochip_add_data(&pdev->dev, gchip, spp_gchip);
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to add gpiochip!\n");
+
+	return 0;
+}
+
+/* pinconf operations */
+static int sppctl_pin_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
+				 unsigned long *config)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int param = pinconf_to_config_param(*config);
+	unsigned int arg = 0;
+
+	switch (param) {
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if (!sppctl_gpio_output_od_get(&pctl->spp_gchip->chip, pin))
+			return -EINVAL;
+		break;
+
+	case PIN_CONFIG_OUTPUT:
+		if (!sppctl_first_get(&pctl->spp_gchip->chip, pin))
+			return -EINVAL;
+		if (!sppctl_master_get(&pctl->spp_gchip->chip, pin))
+			return -EINVAL;
+		if (sppctl_gpio_get_direction(&pctl->spp_gchip->chip, pin))
+			return -EINVAL;
+		arg = sppctl_gpio_get(&pctl->spp_gchip->chip, pin);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+	*config = pinconf_to_config_packed(param, arg);
+
+	return 0;
+}
+
+static int sppctl_pin_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
+				 unsigned long *configs, unsigned int num_configs)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	int i;
+
+	/* Special handling for IOP */
+	if (configs[0] == SPPCTL_IOP_CONFIGS) {
+		sppctl_first_master_set(&pctl->spp_gchip->chip, pin, mux_f_gpio, mux_m_iop);
+		return 0;
+	}
+
+	for (i = 0; i < num_configs; i++) {
+		if (configs[i] & SPPCTL_PCTL_L_OUT)
+			sppctl_gpio_direction_output(&pctl->spp_gchip->chip, pin, 0);
+		if (configs[i] & SPPCTL_PCTL_L_OU1)
+			sppctl_gpio_direction_output(&pctl->spp_gchip->chip, pin, 1);
+		if (configs[i] & SPPCTL_PCTL_L_INV)
+			sppctl_gpio_input_inv_set(&pctl->spp_gchip->chip, pin);
+		if (configs[i] & SPPCTL_PCTL_L_ONV)
+			sppctl_gpio_output_inv_set(&pctl->spp_gchip->chip, pin);
+		if (configs[i] & SPPCTL_PCTL_L_ODR)
+			sppctl_gpio_output_od_set(&pctl->spp_gchip->chip, pin, 1);
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops sppctl_pconf_ops = {
+	.is_generic     = true,
+	.pin_config_get = sppctl_pin_config_get,
+	.pin_config_set = sppctl_pin_config_set,
+};
+
+/* pinmux operations */
+static int sppctl_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	return sppctl_list_funcs_sz;
+}
+
+static const char *sppctl_get_function_name(struct pinctrl_dev *pctldev,
+					    unsigned int selector)
+{
+	return sppctl_list_funcs[selector].name;
+}
+
+static int sppctl_get_function_groups(struct pinctrl_dev *pctldev, unsigned int selector,
+				      const char * const **groups, unsigned int *num_groups)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct sppctl_func *f = &sppctl_list_funcs[selector];
+	int i;
+
+	*num_groups = 0;
+	switch (f->type) {
+	case pinmux_type_fpmx:  /* fully-pinmux */
+		*num_groups = sppctl_pmux_list_sz;
+		*groups = sppctl_pmux_list_s;
+		break;
+
+	case pinmux_type_grp:   /* group-pinmux */
+		if (!f->grps)
+			break;
+
+		*num_groups = f->gnum;
+		for (i = 0; i < pctl->unq_grps_sz; i++)
+			if (pctl->g2fp_maps[i].f_idx == selector)
+				break;
+		*groups = &pctl->unq_grps[i];
+		break;
+
+	default:
+		dev_err(pctldev->dev, "Unknown pinmux (selector: %d, type: %d)\n",
+			selector, f->type);
+		break;
+	}
+
+	return 0;
+}
+
+/** sppctl_fully_pinmux_conv - Convert GPIO# to fully-pinmux control-field setting
+ *
+ * Each fully-pinmux function can be mapped to any of GPIO 8 ~ 71 by
+ * settings its control-field. Refer to following table:
+ *
+ * control-field |  GPIO
+ * --------------+--------
+ *        0      |  No map
+ *        1      |    8
+ *        2      |    9
+ *        3      |   10
+ *        :      |    :
+ *       65      |   71
+ */
+static inline int sppctl_fully_pinmux_conv(unsigned int offset)
+{
+	return (offset < 8) ? 0 : offset - 7;
+}
+
+static int sppctl_set_mux(struct pinctrl_dev *pctldev, unsigned int func_selector,
+			  unsigned int group_selector)
+{
+	const struct sppctl_func *f = &sppctl_list_funcs[func_selector];
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct grp2fp_map g2fpm = pctl->g2fp_maps[group_selector];
+	int i;
+
+	switch (f->type) {
+	case pinmux_type_fpmx:  /* fully-pinmux */
+		sppctl_first_master_set(&pctl->spp_gchip->chip, group_selector,
+					mux_f_mux, mux_m_keep);
+		sppctl_func_set(pctl, func_selector, sppctl_fully_pinmux_conv(group_selector));
+		break;
+
+	case pinmux_type_grp:   /* group-pinmux*/
+		for (i = 0; i < f->grps[g2fpm.g_idx].pnum; i++)
+			sppctl_first_master_set(&pctl->spp_gchip->chip,
+						f->grps[g2fpm.g_idx].pins[i],
+						mux_f_mux, mux_m_keep);
+		sppctl_gmx_set(pctl, f->roff, f->boff, f->blen, f->grps[g2fpm.g_idx].gval);
+		break;
+
+	default:
+		dev_err(pctldev->dev, "Unknown pinmux type (func_selector: %d, type: %d)\n",
+			func_selector, f->type);
+		break;
+	}
+
+	return 0;
+}
+
+static int sppctl_gpio_request_enable(struct pinctrl_dev *pctldev,
+				      struct pinctrl_gpio_range *range, unsigned int offset)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	int g_f, g_m;
+
+	g_f = sppctl_first_get(&pctl->spp_gchip->chip, offset);
+	g_m = sppctl_master_get(&pctl->spp_gchip->chip, offset);
+	if (g_f == mux_f_gpio && g_m == mux_m_gpio)
+		return 0;
+
+	pin_desc_get(pctldev, offset);
+
+	sppctl_first_master_set(&pctl->spp_gchip->chip, offset, mux_f_gpio, mux_m_gpio);
+	return 0;
+}
+
+static const struct pinmux_ops sppctl_pinmux_ops = {
+	.get_functions_count = sppctl_get_functions_count,
+	.get_function_name   = sppctl_get_function_name,
+	.get_function_groups = sppctl_get_function_groups,
+	.set_mux             = sppctl_set_mux,
+	.gpio_request_enable = sppctl_gpio_request_enable,
+	.strict              = true
+};
+
+/* pinctrl operations */
+static int sppctl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->unq_grps_sz;
+}
+
+static const char *sppctl_get_group_name(struct pinctrl_dev *pctldev, unsigned int selector)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->unq_grps[selector];
+}
+
+static int sppctl_get_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
+				 const unsigned int **pins, unsigned int *num_pins)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct grp2fp_map g2fpm = pctl->g2fp_maps[selector];
+	const struct sppctl_func *f;
+
+	f = &sppctl_list_funcs[g2fpm.f_idx];
+	*num_pins = 0;
+
+	/* Except group-pinmux, each group has 1 pin. */
+	if (f->type != pinmux_type_grp) {
+		*num_pins = 1;
+		*pins = &sppctl_pins_gpio[selector];
+		return 0;
+	}
+
+	/* Group-pinmux may have more than one pin. */
+	if (!f->grps)
+		return 0;
+
+	if (f->gnum < 1)
+		return 0;
+
+	*num_pins = f->grps[g2fpm.g_idx].pnum;
+	*pins = f->grps[g2fpm.g_idx].pins;
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void sppctl_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
+				unsigned int offset)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const char *pin_type;
+	u8 first, master;
+
+	first = sppctl_first_get(&pctl->spp_gchip->chip, offset);
+	master = sppctl_master_get(&pctl->spp_gchip->chip, offset);
+	if (first)
+		if (master)
+			pin_type = "GPIO";
+		else
+			pin_type = " IOP";
+	else
+		pin_type = " MUX";
+	seq_printf(s, " %s", pin_type);
+}
+#endif
+
+static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node *np_config,
+				 struct pinctrl_map **map, unsigned int *num_maps)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	int nmG = of_property_count_strings(np_config, "groups");
+	const struct sppctl_func *f = NULL;
+	u8 pin_num, pin_type, pin_func;
+	struct device_node *parent;
+	unsigned long *configs;
+	struct property *prop;
+	const char *s_f, *s_g;
+
+	const __be32 *list;
+	u32 dt_pin, dt_fun;
+	int i, size = 0;
+
+	list = of_get_property(np_config, "sunplus,pins", &size);
+
+	if (nmG <= 0)
+		nmG = 0;
+
+	parent = of_get_parent(np_config);
+	*num_maps = size / sizeof(*list);
+
+	/*
+	 * Process property:
+	 *     sunplus,pins = < u32 u32 u32 ... >;
+	 *
+	 * Each 32-bit integer defines a individual pin in which:
+	 *
+	 *   Bit 32~24: defines GPIO pin number. Its range is 0 ~ 98.
+	 *   Bit 23~16: defines types: (1) fully-pinmux pins
+	 *                             (2) IO processor pins
+	 *                             (3) digital GPIO pins
+	 *   Bit 15~8:  defines pins of peripherals (which are defined in
+	 *              'include/dt-binging/pinctrl/sppctl.h').
+	 *   Bit 7~0:   defines types or initial-state of digital GPIO pins.
+	 */
+	for (i = 0; i < (*num_maps); i++) {
+		dt_pin = be32_to_cpu(list[i]);
+		pin_num = FIELD_GET(GENMASK(31, 24), dt_pin);
+
+		/* Check if out of range? */
+		if (pin_num >= sppctl_pins_all_sz) {
+			dev_err(pctldev->dev, "Invalid pin property at index %d (0x%08x)\n",
+				i, dt_pin);
+			return -EINVAL;
+		}
+	}
+
+	*map = kcalloc(*num_maps + nmG, sizeof(**map), GFP_KERNEL);
+	for (i = 0; i < (*num_maps); i++) {
+		dt_pin = be32_to_cpu(list[i]);
+		pin_num = FIELD_GET(GENMASK(31, 24), dt_pin);
+		pin_type = FIELD_GET(GENMASK(23, 16), dt_pin);
+		pin_func = FIELD_GET(GENMASK(15, 8), dt_pin);
+		(*map)[i].name = parent->name;
+
+		if (pin_type == SPPCTL_PCTL_G_GPIO) {
+			/* A digital GPIO pin */
+			(*map)[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
+			(*map)[i].data.configs.num_configs = 1;
+			(*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_num);
+			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
+			*configs = FIELD_GET(GENMASK(7, 0), dt_pin);
+			(*map)[i].data.configs.configs = configs;
+
+			dev_dbg(pctldev->dev, "%s: GPIO (%s)\n",
+				(*map)[i].data.configs.group_or_pin,
+				(*configs & (SPPCTL_PCTL_L_OUT | SPPCTL_PCTL_L_OU1)) ?
+				"OUT" : "IN");
+		} else if (pin_type == SPPCTL_PCTL_G_IOPP) {
+			/* A IO Processor (IOP) pin */
+			(*map)[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
+			(*map)[i].data.configs.num_configs = 1;
+			(*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_num);
+			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
+			*configs = SPPCTL_IOP_CONFIGS;
+			(*map)[i].data.configs.configs = configs;
+
+			dev_dbg(pctldev->dev, "%s: IOP\n",
+				(*map)[i].data.configs.group_or_pin);
+		} else {
+			/* A fully-pinmux pin */
+			(*map)[i].type = PIN_MAP_TYPE_MUX_GROUP;
+			(*map)[i].data.mux.function = sppctl_list_funcs[pin_func].name;
+			(*map)[i].data.mux.group = pin_get_name(pctldev, pin_num);
+
+			dev_dbg(pctldev->dev, "%s: %s\n", (*map)[i].data.mux.group,
+				(*map)[i].data.mux.function);
+		}
+	}
+
+	/*
+	 * Process properties:
+	 *     function = "xxx";
+	 *     groups = "yyy";
+	 */
+	if (nmG > 0 && of_property_read_string(np_config, "function", &s_f) == 0) {
+		of_property_for_each_string(np_config, "groups", prop, s_g) {
+			(*map)[*num_maps].type = PIN_MAP_TYPE_MUX_GROUP;
+			(*map)[*num_maps].data.mux.function = s_f;
+			(*map)[*num_maps].data.mux.group = s_g;
+			(*num_maps)++;
+
+			dev_dbg(pctldev->dev, "%s: %s\n", s_f, s_g);
+		}
+	}
+
+	/*
+	 * Process property:
+	 *     sunplus,zero_func = < u32 u32 u32 ...>
+	 */
+	list = of_get_property(np_config, "sunplus,zero_func", &size);
+	if (list) {
+		for (i = 0; i < (size / sizeof(*list)); i++) {
+			dt_fun = be32_to_cpu(list[i]);
+			if (dt_fun >= sppctl_list_funcs_sz) {
+				dev_err(pctldev->dev, "Zero-func %d out of range!\n",
+					dt_fun);
+				continue;
+			}
+
+			f = &sppctl_list_funcs[dt_fun];
+			switch (f->type) {
+			case pinmux_type_fpmx:
+				sppctl_func_set(pctl, dt_fun, 0);
+				dev_dbg(pctldev->dev, "%s: No map\n", f->name);
+				break;
+
+			case pinmux_type_grp:
+				sppctl_gmx_set(pctl, f->roff, f->boff, f->blen, 0);
+				dev_dbg(pctldev->dev, "%s: No map\n", f->name);
+				break;
+
+			default:
+				dev_err(pctldev->dev, "Wrong zero-group: %d (%s)\n",
+					dt_fun, f->name);
+				break;
+			}
+		}
+	}
+
+	of_node_put(parent);
+	dev_dbg(pctldev->dev, "%d pins mapped\n", *num_maps);
+	return 0;
+}
+
+static const struct pinctrl_ops sppctl_pctl_ops = {
+	.get_groups_count = sppctl_get_groups_count,
+	.get_group_name   = sppctl_get_group_name,
+	.get_group_pins   = sppctl_get_group_pins,
+#ifdef CONFIG_DEBUG_FS
+	.pin_dbg_show     = sppctl_pin_dbg_show,
+#endif
+	.dt_node_to_map   = sppctl_dt_node_to_map,
+	.dt_free_map      = pinctrl_utils_free_map,
+};
+
+/* platform driver functions */
+static int sppctl_group_groups(struct platform_device *pdev)
+{
+	struct sppctl_pdata *sppctl = platform_get_drvdata(pdev);
+	size_t prod;
+	int i, k, j;
+
+	/* Calculate number of total group (GPIO + group-pinmux group). */
+	sppctl->unq_grps_sz = sppctl_gpio_list_sz;
+	for (i = 0; i < sppctl_list_funcs_sz; i++)
+		if (sppctl_list_funcs[i].type == pinmux_type_grp)
+			sppctl->unq_grps_sz += sppctl_list_funcs[i].gnum;
+
+	sppctl->unq_grps = devm_kcalloc(&pdev->dev, sppctl->unq_grps_sz + 1,
+					sizeof(*sppctl->unq_grps), GFP_KERNEL);
+	if (!sppctl->unq_grps)
+		return -ENOMEM;
+
+	sppctl->g2fp_maps = devm_kcalloc(&pdev->dev, sppctl->unq_grps_sz + 1,
+					 sizeof(*sppctl->g2fp_maps), GFP_KERNEL);
+	if (!sppctl->g2fp_maps)
+		return -ENOMEM;
+
+	/*
+	 * Check only product of n and size of the second devm_kcalloc()
+	 * because its size is the largest of the two.
+	 */
+	if (unlikely(check_mul_overflow(sppctl->unq_grps_sz + 1,
+					sizeof(*sppctl->g2fp_maps), &prod)))
+		return -EINVAL;
+
+	/* Add GPIO pins. */
+	for (i = 0; i < sppctl_gpio_list_sz; i++) {
+		sppctl->unq_grps[i] = sppctl_gpio_list_s[i];
+		sppctl->g2fp_maps[i].f_idx = 0;
+		sppctl->g2fp_maps[i].g_idx = i;
+	}
+
+	/* Add group-pinmux to end of GPIO pins. */
+	j = sppctl_gpio_list_sz;
+	for (i = 0; i < sppctl_list_funcs_sz; i++) {
+		if (sppctl_list_funcs[i].type != pinmux_type_grp)
+			continue;
+
+		for (k = 0; k < sppctl_list_funcs[i].gnum; k++) {
+			sppctl->unq_grps[j] = sppctl_list_funcs[i].grps[k].name;
+			sppctl->g2fp_maps[j].f_idx = i;
+			sppctl->g2fp_maps[j].g_idx = k;
+			j++;
+		}
+	}
+
+	return 0;
+}
+
+static int sppctl_pinctrl_init(struct platform_device *pdev)
+{
+	struct sppctl_pdata *sppctl = platform_get_drvdata(pdev);
+	struct device_node *np = of_node_get(pdev->dev.of_node);
+	int err;
+
+	/* Initialize pctl_desc */
+	sppctl->pctl_desc.owner   = THIS_MODULE;
+	sppctl->pctl_desc.name    = dev_name(&pdev->dev);
+	sppctl->pctl_desc.pins    = sppctl_pins_all;
+	sppctl->pctl_desc.npins   = sppctl_pins_all_sz;
+	sppctl->pctl_desc.pctlops = &sppctl_pctl_ops;
+	sppctl->pctl_desc.confops = &sppctl_pconf_ops;
+	sppctl->pctl_desc.pmxops  = &sppctl_pinmux_ops;
+
+	err = sppctl_group_groups(pdev);
+	if (err) {
+		of_node_put(np);
+		return err;
+	}
+
+	err = devm_pinctrl_register_and_init(&pdev->dev, &sppctl->pctl_desc,
+					     sppctl, &sppctl->pctl_dev);
+	if (err) {
+		of_node_put(np);
+		return dev_err_probe(&pdev->dev, err, "Failed to register pinctrl!\n");
+	}
+
+	pinctrl_enable(sppctl->pctl_dev);
+	return 0;
+}
+
+static int sppctl_resource_map(struct platform_device *pdev, struct sppctl_pdata *sppctl)
+{
+	/* MOON2 registers */
+	sppctl->moon2_base = devm_platform_ioremap_resource_byname(pdev, "moon2");
+	if (IS_ERR(sppctl->moon2_base))
+		return PTR_ERR(sppctl->moon2_base);
+
+	/* GPIOXT registers */
+	sppctl->gpioxt_base = devm_platform_ioremap_resource_byname(pdev, "gpioxt");
+	if (IS_ERR(sppctl->gpioxt_base))
+		return PTR_ERR(sppctl->gpioxt_base);
+
+	/* FIRST registers */
+	sppctl->first_base = devm_platform_ioremap_resource_byname(pdev, "first");
+	if (IS_ERR(sppctl->first_base))
+		return PTR_ERR(sppctl->first_base);
+
+	/* MOON1 registers */
+	sppctl->moon1_base = devm_platform_ioremap_resource_byname(pdev, "moon1");
+	if (IS_ERR(sppctl->moon1_base))
+		return PTR_ERR(sppctl->moon1_base);
+
+	return 0;
+}
+
+static int sppctl_probe(struct platform_device *pdev)
+{
+	struct sppctl_pdata *sppctl;
+	int ret;
+
+	sppctl = devm_kzalloc(&pdev->dev, sizeof(*sppctl), GFP_KERNEL);
+	if (!sppctl)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, sppctl);
+
+	ret = sppctl_resource_map(pdev, sppctl);
+	if (ret)
+		return ret;
+
+	ret = sppctl_gpio_new(pdev, sppctl);
+	if (ret)
+		return ret;
+
+	ret = sppctl_pinctrl_init(pdev);
+	if (ret)
+		return ret;
+
+	pinctrl_add_gpio_range(sppctl->pctl_dev, &sppctl->pctl_grange);
+	dev_info(&pdev->dev, "SP7021 PinCtrl by Sunplus/Tibbo Tech.");
+
+	return 0;
+}
+
+static const struct of_device_id sppctl_match_table[] = {
+	{ .compatible = "sunplus,sp7021-pctl" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver sppctl_pinctrl_driver = {
+	.driver = {
+		.name           = SPPCTL_MODULE_NAME,
+		.of_match_table = sppctl_match_table,
+	},
+	.probe  = sppctl_probe,
+};
+builtin_platform_driver(sppctl_pinctrl_driver)
+
+MODULE_AUTHOR("Dvorkin Dmitry <dvorkin@tibbo.com>");
+MODULE_AUTHOR("Wells Lu <wellslutw@gmail.com>");
+MODULE_DESCRIPTION("Sunplus SP7021 Pin Control and GPIO driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/sunplus/sppctl.h b/drivers/pinctrl/sunplus/sppctl.h
new file mode 100644
index 0000000..ed4fae7
--- /dev/null
+++ b/drivers/pinctrl/sunplus/sppctl.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SP7021 Pin Controller Driver.
+ * Copyright (C) Sunplus Tech / Tibbo Tech.
+ */
+
+#ifndef __SPPCTL_H__
+#define __SPPCTL_H__
+
+#include <linux/bits.h>
+#include <linux/gpio/driver.h>
+#include <linux/kernel.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/spinlock.h>
+
+#define SPPCTL_MODULE_NAME		"sppctl_sp7021"
+#define SPPCTL_MAX_GROUPS		5
+
+#define SPPCTL_GPIO_OFF_FIRST		0x00
+#define SPPCTL_GPIO_OFF_MASTER		0x00
+#define SPPCTL_GPIO_OFF_OE		0x20
+#define SPPCTL_GPIO_OFF_OUT		0x40
+#define SPPCTL_GPIO_OFF_IN		0x60
+#define SPPCTL_GPIO_OFF_IINV		0x80
+#define SPPCTL_GPIO_OFF_OINV		0xa0
+#define SPPCTL_GPIO_OFF_OD		0xc0
+
+#define SPPCTL_FULLY_PINMUX_MASK_MASK	GENMASK(22, 16)
+#define SPPCTL_FULLY_PINMUX_SEL_MASK	GENMASK(6, 0)
+#define SPPCTL_FULLY_PINMUX_UPPER_SHIFT	8
+#define SPPCTL_GROUP_PINMUX_MASK_SHIFT	16
+#define SPPCTL_MASTER_MASK_SHIFT	16
+#define SPPCTL_GPIO_MASK_SHIFT		16
+
+#define SPPCTL_IOP_CONFIGS		0xff
+
+#define FNCE(n, r, o, bo, bl, g) { \
+	.name = n, \
+	.type = r, \
+	.roff = o, \
+	.boff = bo, \
+	.blen = bl, \
+	.grps = (g), \
+	.gnum = ARRAY_SIZE(g), \
+}
+
+#define FNCN(n, r, o, bo, bl) { \
+	.name = n, \
+	.type = r, \
+	.roff = o, \
+	.boff = bo, \
+	.blen = bl, \
+	.grps = NULL, \
+	.gnum = 0, \
+}
+
+#define EGRP(n, v, p) { \
+	.name = n, \
+	.gval = (v), \
+	.pins = (p), \
+	.pnum = ARRAY_SIZE(p), \
+}
+
+/** enum mux_first_reg - define modes of FIRST register accesses
+ *    - mux_f_mux:  Select the pin to a fully-pinmux pin
+ *    - mux_f_gpio: Select the pin to a GPIO or IOP pin
+ *    - mux_f_keep: Don't change (keep intact)
+ */
+enum mux_first_reg {
+	mux_f_mux = 0,		/* select fully-pinmux       */
+	mux_f_gpio = 1,		/* select GPIO or IOP pinmux */
+	mux_f_keep = 2,		/* keep no change            */
+};
+
+/** enum mux_master_reg - define modes of MASTER register accesses
+ *    - mux_m_iop:  Select the pin to a IO processor (IOP) pin
+ *    - mux_m_gpio: Select the pin to a digital GPIO pin
+ *    - mux_m_keep: Don't change (keep intact)
+ */
+enum mux_master_reg {
+	mux_m_iop = 0,		/* select IOP pin   */
+	mux_m_gpio = 1,		/* select GPIO pin  */
+	mux_m_keep = 2,		/* select no change */
+};
+
+/** enum pinmux_type - define types of pinmux pins
+ *    - pinmux_type_fpmx: It is a fully-pinmux pin
+ *    - pinmux_type_grp:  It is a group-pinmux pin
+ */
+enum pinmux_type {
+	pinmux_type_fpmx,	/* fully-pinmux */
+	pinmux_type_grp,	/* group-pinmux */
+};
+
+struct grp2fp_map {
+	u16 f_idx;		/* function index */
+	u16 g_idx;		/* group index    */
+};
+
+struct sppctl_gpio_chip {
+	void __iomem *gpioxt_base;	/* MASTER, OE, OUT, IN, I_INV, O_INV, OD */
+	void __iomem *first_base;	/* GPIO_FIRST                            */
+
+	struct gpio_chip chip;
+	spinlock_t lock;		/* lock for accessing OE register        */
+};
+
+struct sppctl_pdata {
+	/* base addresses */
+	void __iomem *moon2_base;	/* MOON2                                 */
+	void __iomem *gpioxt_base;	/* MASTER, OE, OUT, IN, I_INV, O_INV, OD */
+	void __iomem *first_base;	/* FIRST                                 */
+	void __iomem *moon1_base;	/* MOON1               */
+
+	/* pinctrl and gpio-chip */
+	struct pinctrl_desc pctl_desc;
+	struct pinctrl_dev *pctl_dev;
+	struct pinctrl_gpio_range pctl_grange;
+	struct sppctl_gpio_chip *spp_gchip;
+
+	/* groups */
+	char const **unq_grps;
+	size_t unq_grps_sz;
+	struct grp2fp_map *g2fp_maps;
+};
+
+struct sppctl_grp {
+	const char * const name;
+	const u8 gval;                  /* group number   */
+	const unsigned * const pins;    /* list of pins   */
+	const unsigned int pnum;        /* number of pins */
+};
+
+struct sppctl_func {
+	const char * const name;
+	const enum pinmux_type type;    /* function type          */
+	const u8 roff;                  /* register offset        */
+	const u8 boff;                  /* bit offset             */
+	const u8 blen;                  /* bit length             */
+	const struct sppctl_grp * const grps; /* list of groups   */
+	const unsigned int gnum;        /* number of groups       */
+};
+
+extern const struct sppctl_func sppctl_list_funcs[];
+extern const char * const sppctl_pmux_list_s[];
+extern const char * const sppctl_gpio_list_s[];
+extern const struct pinctrl_pin_desc sppctl_pins_all[];
+extern const unsigned int sppctl_pins_gpio[];
+
+extern const size_t sppctl_list_funcs_sz;
+extern const size_t sppctl_pmux_list_sz;
+extern const size_t sppctl_gpio_list_sz;
+extern const size_t sppctl_pins_all_sz;
+
+#endif
diff --git a/drivers/pinctrl/sunplus/sppctl_sp7021.c b/drivers/pinctrl/sunplus/sppctl_sp7021.c
new file mode 100644
index 0000000..49d3d04
--- /dev/null
+++ b/drivers/pinctrl/sunplus/sppctl_sp7021.c
@@ -0,0 +1,584 @@
+// SPDX-License-Identifier: GPL-2.0
+/* SP7021 Pin Controller Driver.
+ * Copyright (C) Sunplus Tech / Tibbo Tech.
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/kernel.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "sppctl.h"
+
+#define D_PIS(x, y)	"P" __stringify(x) "_0" __stringify(y)
+#define D(x, y)		((x) * 8 + (y))
+#define P(x, y)		PINCTRL_PIN(D(x, y), D_PIS(x, y))
+
+const char * const sppctl_gpio_list_s[] = {
+	D_PIS(0, 0),  D_PIS(0, 1),  D_PIS(0, 2),  D_PIS(0, 3),
+	D_PIS(0, 4),  D_PIS(0, 5),  D_PIS(0, 6),  D_PIS(0, 7),
+	D_PIS(1, 0),  D_PIS(1, 1),  D_PIS(1, 2),  D_PIS(1, 3),
+	D_PIS(1, 4),  D_PIS(1, 5),  D_PIS(1, 6),  D_PIS(1, 7),
+	D_PIS(2, 0),  D_PIS(2, 1),  D_PIS(2, 2),  D_PIS(2, 3),
+	D_PIS(2, 4),  D_PIS(2, 5),  D_PIS(2, 6),  D_PIS(2, 7),
+	D_PIS(3, 0),  D_PIS(3, 1),  D_PIS(3, 2),  D_PIS(3, 3),
+	D_PIS(3, 4),  D_PIS(3, 5),  D_PIS(3, 6),  D_PIS(3, 7),
+	D_PIS(4, 0),  D_PIS(4, 1),  D_PIS(4, 2),  D_PIS(4, 3),
+	D_PIS(4, 4),  D_PIS(4, 5),  D_PIS(4, 6),  D_PIS(4, 7),
+	D_PIS(5, 0),  D_PIS(5, 1),  D_PIS(5, 2),  D_PIS(5, 3),
+	D_PIS(5, 4),  D_PIS(5, 5),  D_PIS(5, 6),  D_PIS(5, 7),
+	D_PIS(6, 0),  D_PIS(6, 1),  D_PIS(6, 2),  D_PIS(6, 3),
+	D_PIS(6, 4),  D_PIS(6, 5),  D_PIS(6, 6),  D_PIS(6, 7),
+	D_PIS(7, 0),  D_PIS(7, 1),  D_PIS(7, 2),  D_PIS(7, 3),
+	D_PIS(7, 4),  D_PIS(7, 5),  D_PIS(7, 6),  D_PIS(7, 7),
+	D_PIS(8, 0),  D_PIS(8, 1),  D_PIS(8, 2),  D_PIS(8, 3),
+	D_PIS(8, 4),  D_PIS(8, 5),  D_PIS(8, 6),  D_PIS(8, 7),
+	D_PIS(9, 0),  D_PIS(9, 1),  D_PIS(9, 2),  D_PIS(9, 3),
+	D_PIS(9, 4),  D_PIS(9, 5),  D_PIS(9, 6),  D_PIS(9, 7),
+	D_PIS(10, 0), D_PIS(10, 1), D_PIS(10, 2), D_PIS(10, 3),
+	D_PIS(10, 4), D_PIS(10, 5), D_PIS(10, 6), D_PIS(10, 7),
+	D_PIS(11, 0), D_PIS(11, 1), D_PIS(11, 2), D_PIS(11, 3),
+	D_PIS(11, 4), D_PIS(11, 5), D_PIS(11, 6), D_PIS(11, 7),
+	D_PIS(12, 0), D_PIS(12, 1), D_PIS(12, 2),
+};
+
+const size_t sppctl_gpio_list_sz = ARRAY_SIZE(sppctl_gpio_list_s);
+
+/* function: GPIO. list of groups (pins) */
+const unsigned int sppctl_pins_gpio[] = {
+	D(0, 0), D(0, 1), D(0, 2), D(0, 3), D(0, 4), D(0, 5), D(0, 6), D(0, 7),
+	D(1, 0), D(1, 1), D(1, 2), D(1, 3), D(1, 4), D(1, 5), D(1, 6), D(1, 7),
+	D(2, 0), D(2, 1), D(2, 2), D(2, 3), D(2, 4), D(2, 5), D(2, 6), D(2, 7),
+	D(3, 0), D(3, 1), D(3, 2), D(3, 3), D(3, 4), D(3, 5), D(3, 6), D(3, 7),
+	D(4, 0), D(4, 1), D(4, 2), D(4, 3), D(4, 4), D(4, 5), D(4, 6), D(4, 7),
+	D(5, 0), D(5, 1), D(5, 2), D(5, 3), D(5, 4), D(5, 5), D(5, 6), D(5, 7),
+	D(6, 0), D(6, 1), D(6, 2), D(6, 3), D(6, 4), D(6, 5), D(6, 6), D(6, 7),
+	D(7, 0), D(7, 1), D(7, 2), D(7, 3), D(7, 4), D(7, 5), D(7, 6), D(7, 7),
+	D(8, 0), D(8, 1), D(8, 2), D(8, 3), D(8, 4), D(8, 5), D(8, 6), D(8, 7),
+	D(9, 0), D(9, 1), D(9, 2), D(9, 3), D(9, 4), D(9, 5), D(9, 6), D(9, 7),
+	D(10, 0), D(10, 1), D(10, 2), D(10, 3), D(10, 4), D(10, 5), D(10, 6), D(10, 7),
+	D(11, 0), D(11, 1), D(11, 2), D(11, 3), D(11, 4), D(11, 5), D(11, 6), D(11, 7),
+	D(12, 0), D(12, 1), D(12, 2),
+};
+
+const struct pinctrl_pin_desc sppctl_pins_all[] = {
+	/* gpio and iop only */
+	P(0, 0), P(0, 1), P(0, 2), P(0, 3), P(0, 4), P(0, 5), P(0, 6), P(0, 7),
+	/* gpio, iop, muxable */
+	P(1, 0), P(1, 1), P(1, 2), P(1, 3), P(1, 4), P(1, 5), P(1, 6), P(1, 7),
+	P(2, 0), P(2, 1), P(2, 2), P(2, 3), P(2, 4), P(2, 5), P(2, 6), P(2, 7),
+	P(3, 0), P(3, 1), P(3, 2), P(3, 3), P(3, 4), P(3, 5), P(3, 6), P(3, 7),
+	P(4, 0), P(4, 1), P(4, 2), P(4, 3), P(4, 4), P(4, 5), P(4, 6), P(4, 7),
+	P(5, 0), P(5, 1), P(5, 2), P(5, 3), P(5, 4), P(5, 5), P(5, 6), P(5, 7),
+	P(6, 0), P(6, 1), P(6, 2), P(6, 3), P(6, 4), P(6, 5), P(6, 6), P(6, 7),
+	P(7, 0), P(7, 1), P(7, 2), P(7, 3), P(7, 4), P(7, 5), P(7, 6), P(7, 7),
+	P(8, 0), P(8, 1), P(8, 2), P(8, 3), P(8, 4), P(8, 5), P(8, 6), P(8, 7),
+	/* gpio and iop only */
+	P(9, 0),  P(9, 1),  P(9, 2),  P(9, 3),  P(9, 4),  P(9, 5),  P(9, 6),  P(9, 7),
+	P(10, 0), P(10, 1), P(10, 2), P(10, 3), P(10, 4), P(10, 5), P(10, 6), P(10, 7),
+	P(11, 0), P(11, 1), P(11, 2), P(11, 3), P(11, 4), P(11, 5), P(11, 6), P(11, 7),
+	P(12, 0), P(12, 1), P(12, 2),
+};
+
+const size_t sppctl_pins_all_sz = ARRAY_SIZE(sppctl_pins_all);
+
+/* pmux groups: some pins are muxable. group = pin */
+const char * const sppctl_pmux_list_s[] = {
+	D_PIS(0, 0),
+	D_PIS(1, 0), D_PIS(1, 1), D_PIS(1, 2), D_PIS(1, 3),
+	D_PIS(1, 4), D_PIS(1, 5), D_PIS(1, 6), D_PIS(1, 7),
+	D_PIS(2, 0), D_PIS(2, 1), D_PIS(2, 2), D_PIS(2, 3),
+	D_PIS(2, 4), D_PIS(2, 5), D_PIS(2, 6), D_PIS(2, 7),
+	D_PIS(3, 0), D_PIS(3, 1), D_PIS(3, 2), D_PIS(3, 3),
+	D_PIS(3, 4), D_PIS(3, 5), D_PIS(3, 6), D_PIS(3, 7),
+	D_PIS(4, 0), D_PIS(4, 1), D_PIS(4, 2), D_PIS(4, 3),
+	D_PIS(4, 4), D_PIS(4, 5), D_PIS(4, 6), D_PIS(4, 7),
+	D_PIS(5, 0), D_PIS(5, 1), D_PIS(5, 2), D_PIS(5, 3),
+	D_PIS(5, 4), D_PIS(5, 5), D_PIS(5, 6), D_PIS(5, 7),
+	D_PIS(6, 0), D_PIS(6, 1), D_PIS(6, 2), D_PIS(6, 3),
+	D_PIS(6, 4), D_PIS(6, 5), D_PIS(6, 6), D_PIS(6, 7),
+	D_PIS(7, 0), D_PIS(7, 1), D_PIS(7, 2), D_PIS(7, 3),
+	D_PIS(7, 4), D_PIS(7, 5), D_PIS(7, 6), D_PIS(7, 7),
+	D_PIS(8, 0), D_PIS(8, 1), D_PIS(8, 2), D_PIS(8, 3),
+	D_PIS(8, 4), D_PIS(8, 5), D_PIS(8, 6), D_PIS(8, 7),
+};
+
+const size_t sppctl_pmux_list_sz = ARRAY_SIZE(sppctl_pmux_list_s);
+
+static const unsigned int pins_spif1[] = {
+	D(10, 3), D(10, 4), D(10, 6), D(10, 7),
+};
+
+static const unsigned int pins_spif2[] = {
+	D(9, 4), D(9, 6), D(9, 7), D(10, 1),
+};
+
+static const struct sppctl_grp sp7021grps_spif[] = {
+	EGRP("SPI_FLASH1", 1, pins_spif1),
+	EGRP("SPI_FLASH2", 2, pins_spif2),
+};
+
+static const unsigned int pins_spi41[] = {
+	D(10, 2), D(10, 5),
+};
+
+static const unsigned int pins_spi42[] = {
+	D(9, 5), D(9, 8),
+};
+
+static const struct sppctl_grp sp7021grps_spi4[] = {
+	EGRP("SPI_FLASH_4BIT1", 1, pins_spi41),
+	EGRP("SPI_FLASH_4BIT2", 2, pins_spi42),
+};
+
+static const unsigned int pins_snan[] = {
+	D(9, 4), D(9, 5), D(9, 6), D(9, 7), D(10, 0), D(10, 1),
+};
+
+static const struct sppctl_grp sp7021grps_snan[] = {
+	EGRP("SPI_NAND", 1, pins_snan),
+};
+
+static const unsigned int pins_emmc[] = {
+	D(9, 0), D(9, 1), D(9, 2), D(9, 3), D(9, 4), D(9, 5),
+	D(9, 6), D(9, 7), D(10, 0), D(10, 1),
+};
+
+static const struct sppctl_grp sp7021grps_emmc[] = {
+	EGRP("CARD0_EMMC", 1, pins_emmc),
+};
+
+static const unsigned int pins_sdsd[] = {
+	D(8, 1), D(8, 2), D(8, 3), D(8, 4), D(8, 5), D(8, 6),
+};
+
+static const struct sppctl_grp sp7021grps_sdsd[] = {
+	EGRP("SD_CARD", 1, pins_sdsd),
+};
+
+static const unsigned int pins_uar0[] = {
+	D(11, 0), D(11, 1),
+};
+
+static const struct sppctl_grp sp7021grps_uar0[] = {
+	EGRP("UA0", 1, pins_uar0),
+};
+
+static const unsigned int pins_adbg1[] = {
+	D(10, 2), D(10, 3),
+};
+
+static const unsigned int pins_adbg2[] = {
+	D(7, 1), D(7, 2),
+};
+
+static const struct sppctl_grp sp7021grps_adbg[] = {
+	EGRP("ACHIP_DEBUG1", 1, pins_adbg1),
+	EGRP("ACHIP_DEBUG2", 2, pins_adbg2),
+};
+
+static const unsigned int pins_aua2axi1[] = {
+	D(2, 0), D(2, 1), D(2, 2),
+};
+
+static const unsigned int pins_aua2axi2[] = {
+	D(1, 0), D(1, 1), D(1, 2),
+};
+
+static const struct sppctl_grp sp7021grps_au2x[] = {
+	EGRP("ACHIP_UA2AXI1", 1, pins_aua2axi1),
+	EGRP("ACHIP_UA2AXI2", 2, pins_aua2axi2),
+};
+
+static const unsigned int pins_fpga[] = {
+	D(0, 2), D(0, 3), D(0, 4), D(0, 5), D(0, 6), D(0, 7),
+	D(1, 0), D(1, 1), D(1, 2), D(1, 3), D(1, 4), D(1, 5),
+	D(1, 6), D(1, 7), D(2, 0), D(2, 1), D(2, 2), D(2, 3),
+	D(2, 4), D(2, 5), D(2, 6), D(2, 7), D(3, 0), D(3, 1),
+	D(3, 2), D(3, 3), D(3, 4), D(3, 5), D(3, 6), D(3, 7),
+	D(4, 0), D(4, 1), D(4, 2), D(4, 3), D(4, 4), D(4, 5),
+	D(4, 6), D(4, 7), D(5, 0), D(5, 1), D(5, 2),
+};
+
+static const struct sppctl_grp sp7021grps_fpga[] = {
+	EGRP("FPGA_IFX", 1, pins_fpga),
+};
+
+static const unsigned int pins_hdmi1[] = {
+	D(10, 6), D(12, 2), D(12, 1),
+};
+
+static const unsigned int pins_hdmi2[] = {
+	D(8, 3), D(8, 5), D(8, 6),
+};
+
+static const unsigned int pins_hdmi3[] = {
+	D(7, 4), D(7, 6), D(7, 7),
+};
+
+static const struct sppctl_grp sp7021grps_hdmi[] = {
+	EGRP("HDMI_TX1", 1, pins_hdmi1),
+	EGRP("HDMI_TX2", 2, pins_hdmi2),
+	EGRP("HDMI_TX3", 3, pins_hdmi3),
+};
+
+static const unsigned int pins_eadc[] = {
+	D(1, 0), D(1, 1), D(1, 2), D(1, 3), D(1, 4), D(1, 5), D(1, 6),
+};
+
+static const struct sppctl_grp sp7021grps_eadc[] = {
+	EGRP("AUD_EXT_ADC_IFX0", 1, pins_eadc),
+};
+
+static const unsigned int pins_edac[] = {
+	D(2, 5), D(2, 6), D(2, 7), D(3, 0), D(3, 1), D(3, 2), D(3, 4),
+};
+
+static const struct sppctl_grp sp7021grps_edac[] = {
+	EGRP("AUD_EXT_DAC_IFX0", 1, pins_edac),
+};
+
+static const unsigned int pins_spdi[] = {
+	D(2, 4),
+};
+
+static const struct sppctl_grp sp7021grps_spdi[] = {
+	EGRP("AUD_IEC_RX0", 1, pins_spdi),
+};
+
+static const unsigned int pins_spdo[] = {
+	D(3, 6),
+};
+
+static const struct sppctl_grp sp7021grps_spdo[] = {
+	EGRP("AUD_IEC_TX0", 1, pins_spdo),
+};
+
+static const unsigned int pins_tdmt[] = {
+	D(2, 5), D(2, 6), D(2, 7), D(3, 0), D(3, 1), D(3, 2),
+};
+
+static const struct sppctl_grp sp7021grps_tdmt[] = {
+	EGRP("TDMTX_IFX0", 1, pins_tdmt),
+};
+
+static const unsigned int pins_tdmr[] = {
+	D(1, 7), D(2, 0), D(2, 1), D(2, 2),
+};
+
+static const struct sppctl_grp sp7021grps_tdmr[] = {
+	EGRP("TDMRX_IFX0", 1, pins_tdmr),
+};
+
+static const unsigned int pins_pdmr[] = {
+	D(1, 7), D(2, 0), D(2, 1), D(2, 2), D(2, 3),
+};
+
+static const struct sppctl_grp sp7021grps_pdmr[] = {
+	EGRP("PDMRX_IFX0", 1, pins_pdmr),
+};
+
+static const unsigned int pins_pcmt[] = {
+	D(3, 7), D(4, 0), D(4, 1), D(4, 2), D(4, 3), D(4, 4),
+};
+
+static const struct sppctl_grp sp7021grps_pcmt[] = {
+	EGRP("PCM_IEC_TX", 1, pins_pcmt),
+};
+
+static const unsigned int pins_lcdi[] = {
+	D(1, 4), D(1, 5), D(1, 6), D(1, 7), D(2, 0), D(2, 1), D(2, 2), D(2, 3),
+	D(2, 4), D(2, 5), D(2, 6), D(2, 7), D(3, 0), D(3, 1), D(3, 2), D(3, 3),
+	D(3, 4), D(3, 5), D(3, 6), D(3, 7), D(4, 0), D(4, 1), D(4, 2), D(4, 3),
+	D(4, 4), D(4, 5), D(4, 6), D(4, 7),
+};
+
+static const struct sppctl_grp sp7021grps_lcdi[] = {
+	EGRP("LCDIF", 1, pins_lcdi),
+};
+
+static const unsigned int pins_dvdd[] = {
+	D(7, 0), D(7, 1), D(7, 2), D(7, 3), D(7, 4), D(7, 5), D(7, 6), D(7, 7),
+	D(8, 0), D(8, 1), D(8, 2), D(8, 3), D(8, 4), D(8, 5),
+};
+
+static const struct sppctl_grp sp7021grps_dvdd[] = {
+	EGRP("DVD_DSP_DEBUG", 1, pins_dvdd),
+};
+
+static const unsigned int pins_i2cd[] = {
+	D(1, 0), D(1, 1),
+};
+
+static const struct sppctl_grp sp7021grps_i2cd[] = {
+	EGRP("I2C_DEBUG", 1, pins_i2cd),
+};
+
+static const unsigned int pins_i2cs[] = {
+	D(0, 0), D(0, 1),
+};
+
+static const struct sppctl_grp sp7021grps_i2cs[] = {
+	EGRP("I2C_SLAVE", 1, pins_i2cs),
+};
+
+static const unsigned int pins_wakp[] = {
+	D(10, 5),
+};
+
+static const struct sppctl_grp sp7021grps_wakp[] = {
+	EGRP("WAKEUP", 1, pins_wakp),
+};
+
+static const unsigned int pins_u2ax[] = {
+	D(2, 0), D(2, 1), D(3, 0), D(3, 1),
+};
+
+static const struct sppctl_grp sp7021grps_u2ax[] = {
+	EGRP("UART2AXI", 1, pins_u2ax),
+};
+
+static const unsigned int pins_u0ic[] = {
+	D(0, 0), D(0, 1), D(0, 4), D(0, 5), D(1, 0), D(1, 1),
+};
+
+static const struct sppctl_grp sp7021grps_u0ic[] = {
+	EGRP("USB0_I2C", 1, pins_u0ic),
+};
+
+static const unsigned int pins_u1ic[] = {
+	D(0, 2), D(0, 3), D(0, 6), D(0, 7), D(1, 2), D(1, 3),
+};
+
+static const struct sppctl_grp sp7021grps_u1ic[] = {
+	EGRP("USB1_I2C", 1, pins_u1ic),
+};
+
+static const unsigned int pins_u0ot[] = {
+	D(11, 2),
+};
+
+static const struct sppctl_grp sp7021grps_u0ot[] = {
+	EGRP("USB0_OTG", 1, pins_u0ot),
+};
+
+static const unsigned int pins_u1ot[] = {
+	D(11, 3),
+};
+
+static const struct sppctl_grp sp7021grps_u1ot[] = {
+	EGRP("USB1_OTG", 1, pins_u1ot),
+};
+
+static const unsigned int pins_uphd[] = {
+	D(0, 1), D(0, 2), D(0, 3), D(7, 4), D(7, 5), D(7, 6),
+	D(7, 7), D(8, 0), D(8, 1), D(8, 2), D(8, 3),
+	D(9, 7), D(10, 2), D(10, 3), D(10, 4),
+};
+
+static const struct sppctl_grp sp7021grps_up0d[] = {
+	EGRP("UPHY0_DEBUG", 1, pins_uphd),
+};
+
+static const struct sppctl_grp sp7021grps_up1d[] = {
+	EGRP("UPHY1_DEBUG", 1, pins_uphd),
+};
+
+static const unsigned int pins_upex[] = {
+	D(0, 0), D(0, 1), D(0, 2), D(0, 3), D(0, 4), D(0, 5), D(0, 6), D(0, 7),
+	D(1, 0), D(1, 1), D(1, 2), D(1, 3), D(1, 4), D(1, 5), D(1, 6), D(1, 7),
+	D(2, 0), D(2, 1), D(2, 2), D(2, 3), D(2, 4), D(2, 5), D(2, 6), D(2, 7),
+	D(3, 0), D(3, 1), D(3, 2), D(3, 3), D(3, 4), D(3, 5), D(3, 6), D(3, 7),
+	D(4, 0), D(4, 1), D(4, 2), D(4, 3), D(4, 4), D(4, 5), D(4, 6), D(4, 7),
+	D(5, 0), D(5, 1), D(5, 2), D(5, 3), D(5, 4), D(5, 5), D(5, 6), D(5, 7),
+	D(6, 0), D(6, 1), D(6, 2), D(6, 3), D(6, 4), D(6, 5), D(6, 6), D(6, 7),
+	D(7, 0), D(7, 1), D(7, 2), D(7, 3), D(7, 4), D(7, 5), D(7, 6), D(7, 7),
+	D(8, 0), D(8, 1), D(8, 2), D(8, 3), D(8, 4), D(8, 5), D(8, 6), D(8, 7),
+	D(9, 0), D(9, 1), D(9, 2), D(9, 3), D(9, 4), D(9, 5), D(9, 6), D(9, 7),
+	D(10, 0), D(10, 1), D(10, 2), D(10, 3), D(10, 4), D(10, 5), D(10, 6), D(10, 7),
+};
+
+static const struct sppctl_grp sp7021grps_upex[] = {
+	EGRP("UPHY0_EXT", 1, pins_upex),
+};
+
+static const unsigned int pins_prp1[] = {
+	D(0, 6), D(0, 7),
+	D(1, 0), D(1, 1), D(1, 2), D(1, 3), D(1, 4), D(1, 5), D(1, 6), D(1, 7),
+	D(2, 1), D(2, 2), D(2, 3), D(2, 4), D(2, 5), D(2, 6), D(2, 7),
+	D(3, 0), D(3, 1), D(3, 2),
+};
+
+static const unsigned int pins_prp2[] = {
+	D(3, 4), D(3, 6), D(3, 7),
+	D(4, 0), D(4, 1), D(4, 2), D(4, 3), D(4, 4), D(4, 5), D(4, 6), D(4, 7),
+	D(5, 0), D(5, 1), D(5, 2), D(5, 3), D(5, 4), D(5, 5), D(5, 6), D(5, 7),
+	D(6, 4),
+};
+
+static const struct sppctl_grp sp7021grps_prbp[] = {
+	EGRP("PROBE_PORT1", 1, pins_prp1),
+	EGRP("PROBE_PORT2", 2, pins_prp2),
+};
+
+const struct sppctl_func sppctl_list_funcs[] = {
+	FNCN("L2SW_CLK_OUT",        pinmux_type_fpmx, 0x00, 0, 7),
+	FNCN("L2SW_MAC_SMI_MDC",    pinmux_type_fpmx, 0x00, 8, 7),
+	FNCN("L2SW_LED_FLASH0",     pinmux_type_fpmx, 0x01, 0, 7),
+	FNCN("L2SW_LED_FLASH1",     pinmux_type_fpmx, 0x01, 8, 7),
+	FNCN("L2SW_LED_ON0",        pinmux_type_fpmx, 0x02, 0, 7),
+	FNCN("L2SW_LED_ON1",        pinmux_type_fpmx, 0x02, 8, 7),
+	FNCN("L2SW_MAC_SMI_MDIO",   pinmux_type_fpmx, 0x03, 0, 7),
+	FNCN("L2SW_P0_MAC_RMII_TXEN",   pinmux_type_fpmx, 0x03, 8, 7),
+	FNCN("L2SW_P0_MAC_RMII_TXD0",   pinmux_type_fpmx, 0x04, 0, 7),
+	FNCN("L2SW_P0_MAC_RMII_TXD1",   pinmux_type_fpmx, 0x04, 8, 7),
+	FNCN("L2SW_P0_MAC_RMII_CRSDV",  pinmux_type_fpmx, 0x05, 0, 7),
+	FNCN("L2SW_P0_MAC_RMII_RXD0",   pinmux_type_fpmx, 0x05, 8, 7),
+	FNCN("L2SW_P0_MAC_RMII_RXD1",   pinmux_type_fpmx, 0x06, 0, 7),
+	FNCN("L2SW_P0_MAC_RMII_RXER",   pinmux_type_fpmx, 0x06, 8, 7),
+	FNCN("L2SW_P1_MAC_RMII_TXEN",   pinmux_type_fpmx, 0x07, 0, 7),
+	FNCN("L2SW_P1_MAC_RMII_TXD0",   pinmux_type_fpmx, 0x07, 8, 7),
+	FNCN("L2SW_P1_MAC_RMII_TXD1",   pinmux_type_fpmx, 0x08, 0, 7),
+	FNCN("L2SW_P1_MAC_RMII_CRSDV",  pinmux_type_fpmx, 0x08, 8, 7),
+	FNCN("L2SW_P1_MAC_RMII_RXD0",   pinmux_type_fpmx, 0x09, 0, 7),
+	FNCN("L2SW_P1_MAC_RMII_RXD1",   pinmux_type_fpmx, 0x09, 8, 7),
+	FNCN("L2SW_P1_MAC_RMII_RXER",   pinmux_type_fpmx, 0x0A, 0, 7),
+	FNCN("DAISY_MODE",      pinmux_type_fpmx, 0x0A, 8, 7),
+	FNCN("SDIO_CLK",        pinmux_type_fpmx, 0x0B, 0, 7),    /* 1x SDIO */
+	FNCN("SDIO_CMD",        pinmux_type_fpmx, 0x0B, 8, 7),
+	FNCN("SDIO_D0",         pinmux_type_fpmx, 0x0C, 0, 7),
+	FNCN("SDIO_D1",         pinmux_type_fpmx, 0x0C, 8, 7),
+	FNCN("SDIO_D2",         pinmux_type_fpmx, 0x0D, 0, 7),
+	FNCN("SDIO_D3",         pinmux_type_fpmx, 0x0D, 8, 7),
+	FNCN("PWM0",            pinmux_type_fpmx, 0x0E, 0, 7),    /* 8x PWM */
+	FNCN("PWM1",            pinmux_type_fpmx, 0x0E, 8, 7),
+	FNCN("PWM2",            pinmux_type_fpmx, 0x0F, 0, 7),
+	FNCN("PWM3",            pinmux_type_fpmx, 0x0F, 8, 7),
+
+	FNCN("PWM4",            pinmux_type_fpmx, 0x10, 0, 7),
+	FNCN("PWM5",            pinmux_type_fpmx, 0x10, 8, 7),
+	FNCN("PWM6",            pinmux_type_fpmx, 0x11, 0, 7),
+	FNCN("PWM7",            pinmux_type_fpmx, 0x11, 8, 7),
+	FNCN("ICM0_D",          pinmux_type_fpmx, 0x12, 0, 7),    /* 4x Input captures */
+	FNCN("ICM1_D",          pinmux_type_fpmx, 0x12, 8, 7),
+	FNCN("ICM2_D",          pinmux_type_fpmx, 0x13, 0, 7),
+	FNCN("ICM3_D",          pinmux_type_fpmx, 0x13, 8, 7),
+	FNCN("ICM0_CLK",        pinmux_type_fpmx, 0x14, 0, 7),
+	FNCN("ICM1_CLK",        pinmux_type_fpmx, 0x14, 8, 7),
+	FNCN("ICM2_CLK",        pinmux_type_fpmx, 0x15, 0, 7),
+	FNCN("ICM3_CLK",        pinmux_type_fpmx, 0x15, 8, 7),
+	FNCN("SPIM0_INT",       pinmux_type_fpmx, 0x16, 0, 7),    /* 4x SPI masters */
+	FNCN("SPIM0_CLK",       pinmux_type_fpmx, 0x16, 8, 7),
+	FNCN("SPIM0_EN",        pinmux_type_fpmx, 0x17, 0, 7),
+	FNCN("SPIM0_DO",        pinmux_type_fpmx, 0x17, 8, 7),
+	FNCN("SPIM0_DI",        pinmux_type_fpmx, 0x18, 0, 7),
+	FNCN("SPIM1_INT",       pinmux_type_fpmx, 0x18, 8, 7),
+	FNCN("SPIM1_CLK",       pinmux_type_fpmx, 0x19, 0, 7),
+	FNCN("SPIM1_EN",        pinmux_type_fpmx, 0x19, 8, 7),
+	FNCN("SPIM1_DO",        pinmux_type_fpmx, 0x1A, 0, 7),
+	FNCN("SPIM1_DI",        pinmux_type_fpmx, 0x1A, 8, 7),
+	FNCN("SPIM2_INT",       pinmux_type_fpmx, 0x1B, 0, 7),
+	FNCN("SPIM2_CLK",       pinmux_type_fpmx, 0x1B, 8, 7),
+	FNCN("SPIM2_EN",        pinmux_type_fpmx, 0x1C, 0, 7),
+	FNCN("SPIM2_DO",        pinmux_type_fpmx, 0x1C, 8, 7),
+	FNCN("SPIM2_DI",        pinmux_type_fpmx, 0x1D, 0, 7),
+	FNCN("SPIM3_INT",       pinmux_type_fpmx, 0x1D, 8, 7),
+	FNCN("SPIM3_CLK",       pinmux_type_fpmx, 0x1E, 0, 7),
+	FNCN("SPIM3_EN",        pinmux_type_fpmx, 0x1E, 8, 7),
+	FNCN("SPIM3_DO",        pinmux_type_fpmx, 0x1F, 0, 7),
+	FNCN("SPIM3_DI",        pinmux_type_fpmx, 0x1F, 8, 7),
+
+	FNCN("SPI0S_INT",       pinmux_type_fpmx, 0x20, 0, 7),    /* 4x SPI slaves */
+	FNCN("SPI0S_CLK",       pinmux_type_fpmx, 0x20, 8, 7),
+	FNCN("SPI0S_EN",        pinmux_type_fpmx, 0x21, 0, 7),
+	FNCN("SPI0S_DO",        pinmux_type_fpmx, 0x21, 8, 7),
+	FNCN("SPI0S_DI",        pinmux_type_fpmx, 0x22, 0, 7),
+	FNCN("SPI1S_INT",       pinmux_type_fpmx, 0x22, 8, 7),
+	FNCN("SPI1S_CLK",       pinmux_type_fpmx, 0x23, 0, 7),
+	FNCN("SPI1S_EN",        pinmux_type_fpmx, 0x23, 8, 7),
+	FNCN("SPI1S_DO",        pinmux_type_fpmx, 0x24, 0, 7),
+	FNCN("SPI1S_DI",        pinmux_type_fpmx, 0x24, 8, 7),
+	FNCN("SPI2S_INT",       pinmux_type_fpmx, 0x25, 0, 7),
+	FNCN("SPI2S_CLK",       pinmux_type_fpmx, 0x25, 8, 7),
+	FNCN("SPI2S_EN",        pinmux_type_fpmx, 0x26, 0, 7),
+	FNCN("SPI2S_DO",        pinmux_type_fpmx, 0x26, 8, 7),
+	FNCN("SPI2S_DI",        pinmux_type_fpmx, 0x27, 0, 7),
+	FNCN("SPI3S_INT",       pinmux_type_fpmx, 0x27, 8, 7),
+	FNCN("SPI3S_CLK",       pinmux_type_fpmx, 0x28, 0, 7),
+	FNCN("SPI3S_EN",        pinmux_type_fpmx, 0x28, 8, 7),
+	FNCN("SPI3S_DO",        pinmux_type_fpmx, 0x29, 0, 7),
+	FNCN("SPI3S_DI",        pinmux_type_fpmx, 0x29, 8, 7),
+	FNCN("I2CM0_CLK",       pinmux_type_fpmx, 0x2A, 0, 7),    /* 4x I2C masters */
+	FNCN("I2CM0_DAT",       pinmux_type_fpmx, 0x2A, 8, 7),
+	FNCN("I2CM1_CLK",       pinmux_type_fpmx, 0x2B, 0, 7),
+	FNCN("I2CM1_DAT",       pinmux_type_fpmx, 0x2B, 8, 7),
+	FNCN("I2CM2_CLK",       pinmux_type_fpmx, 0x2C, 0, 7),
+	FNCN("I2CM2_DAT",       pinmux_type_fpmx, 0x2C, 8, 7),
+	FNCN("I2CM3_CLK",       pinmux_type_fpmx, 0x2D, 0, 7),
+	FNCN("I2CM3_DAT",       pinmux_type_fpmx, 0x2D, 8, 7),
+	FNCN("UA1_TX",          pinmux_type_fpmx, 0x2E, 0, 7),    /* 4x UARTS */
+	FNCN("UA1_RX",          pinmux_type_fpmx, 0x2E, 8, 7),
+	FNCN("UA1_CTS",         pinmux_type_fpmx, 0x2F, 0, 7),
+	FNCN("UA1_RTS",         pinmux_type_fpmx, 0x2F, 8, 7),
+
+	FNCN("UA2_TX",          pinmux_type_fpmx, 0x30, 0, 7),
+	FNCN("UA2_RX",          pinmux_type_fpmx, 0x30, 8, 7),
+	FNCN("UA2_CTS",         pinmux_type_fpmx, 0x31, 0, 7),
+	FNCN("UA2_RTS",         pinmux_type_fpmx, 0x31, 8, 7),
+	FNCN("UA3_TX",          pinmux_type_fpmx, 0x32, 0, 7),
+	FNCN("UA3_RX",          pinmux_type_fpmx, 0x32, 8, 7),
+	FNCN("UA3_CTS",         pinmux_type_fpmx, 0x33, 0, 7),
+	FNCN("UA3_RTS",         pinmux_type_fpmx, 0x33, 8, 7),
+	FNCN("UA4_TX",          pinmux_type_fpmx, 0x34, 0, 7),
+	FNCN("UA4_RX",          pinmux_type_fpmx, 0x34, 8, 7),
+	FNCN("UA4_CTS",         pinmux_type_fpmx, 0x35, 0, 7),
+	FNCN("UA4_RTS",         pinmux_type_fpmx, 0x35, 8, 7),
+	FNCN("TIMER0_INT",      pinmux_type_fpmx, 0x36, 0, 7),    /* 4x timer int. */
+	FNCN("TIMER1_INT",      pinmux_type_fpmx, 0x36, 8, 7),
+	FNCN("TIMER2_INT",      pinmux_type_fpmx, 0x37, 0, 7),
+	FNCN("TIMER3_INT",      pinmux_type_fpmx, 0x37, 8, 7),
+	FNCN("GPIO_INT0",       pinmux_type_fpmx, 0x38, 0, 7),    /* 8x GPIO int. */
+	FNCN("GPIO_INT1",       pinmux_type_fpmx, 0x38, 8, 7),
+	FNCN("GPIO_INT2",       pinmux_type_fpmx, 0x39, 0, 7),
+	FNCN("GPIO_INT3",       pinmux_type_fpmx, 0x39, 8, 7),
+	FNCN("GPIO_INT4",       pinmux_type_fpmx, 0x3A, 0, 7),
+	FNCN("GPIO_INT5",       pinmux_type_fpmx, 0x3A, 8, 7),
+	FNCN("GPIO_INT6",       pinmux_type_fpmx, 0x3B, 0, 7),
+	FNCN("GPIO_INT7",       pinmux_type_fpmx, 0x3B, 8, 7),
+
+	/* MOON1 register */
+	FNCE("SPI_FLASH",       pinmux_type_grp, 0x01,  0, 2, sp7021grps_spif),
+	FNCE("SPI_FLASH_4BIT",  pinmux_type_grp, 0x01,  2, 2, sp7021grps_spi4),
+	FNCE("SPI_NAND",        pinmux_type_grp, 0x01,  4, 1, sp7021grps_snan),
+	FNCE("CARD0_EMMC",      pinmux_type_grp, 0x01,  5, 1, sp7021grps_emmc),
+	FNCE("SD_CARD",         pinmux_type_grp, 0x01,  6, 1, sp7021grps_sdsd),
+	FNCE("UA0",             pinmux_type_grp, 0x01,  7, 1, sp7021grps_uar0),
+	FNCE("ACHIP_DEBUG",     pinmux_type_grp, 0x01,  8, 2, sp7021grps_adbg),
+	FNCE("ACHIP_UA2AXI",    pinmux_type_grp, 0x01, 10, 2, sp7021grps_au2x),
+	FNCE("FPGA_IFX",        pinmux_type_grp, 0x01, 12, 1, sp7021grps_fpga),
+	FNCE("HDMI_TX",         pinmux_type_grp, 0x01, 13, 2, sp7021grps_hdmi),
+
+	FNCE("AUD_EXT_ADC_IFX0", pinmux_type_grp, 0x01, 15, 1, sp7021grps_eadc),
+	FNCE("AUD_EXT_DAC_IFX0", pinmux_type_grp, 0x02,  0, 1, sp7021grps_edac),
+	FNCE("SPDIF_RX",        pinmux_type_grp, 0x02,  2, 1, sp7021grps_spdi),
+	FNCE("SPDIF_TX",        pinmux_type_grp, 0x02,  3, 1, sp7021grps_spdo),
+	FNCE("TDMTX_IFX0",      pinmux_type_grp, 0x02,  4, 1, sp7021grps_tdmt),
+	FNCE("TDMRX_IFX0",      pinmux_type_grp, 0x02,  5, 1, sp7021grps_tdmr),
+	FNCE("PDMRX_IFX0",      pinmux_type_grp, 0x02,  6, 1, sp7021grps_pdmr),
+	FNCE("PCM_IEC_TX",      pinmux_type_grp, 0x02,  7, 1, sp7021grps_pcmt),
+	FNCE("LCDIF",           pinmux_type_grp, 0x04,  6, 1, sp7021grps_lcdi),
+	FNCE("DVD_DSP_DEBUG",   pinmux_type_grp, 0x02,  8, 1, sp7021grps_dvdd),
+	FNCE("I2C_DEBUG",       pinmux_type_grp, 0x02,  9, 1, sp7021grps_i2cd),
+	FNCE("I2C_SLAVE",       pinmux_type_grp, 0x02, 10, 1, sp7021grps_i2cs),
+	FNCE("WAKEUP",          pinmux_type_grp, 0x02, 11, 1, sp7021grps_wakp),
+	FNCE("UART2AXI",        pinmux_type_grp, 0x02, 12, 2, sp7021grps_u2ax),
+	FNCE("USB0_I2C",        pinmux_type_grp, 0x02, 14, 2, sp7021grps_u0ic),
+	FNCE("USB1_I2C",        pinmux_type_grp, 0x03,  0, 2, sp7021grps_u1ic),
+	FNCE("USB0_OTG",        pinmux_type_grp, 0x03,  2, 1, sp7021grps_u0ot),
+	FNCE("USB1_OTG",        pinmux_type_grp, 0x03,  3, 1, sp7021grps_u1ot),
+	FNCE("UPHY0_DEBUG",     pinmux_type_grp, 0x03,  4, 1, sp7021grps_up0d),
+	FNCE("UPHY1_DEBUG",     pinmux_type_grp, 0x03,  5, 1, sp7021grps_up1d),
+	FNCE("UPHY0_EXT",       pinmux_type_grp, 0x03,  6, 1, sp7021grps_upex),
+	FNCE("PROBE_PORT",      pinmux_type_grp, 0x03,  7, 2, sp7021grps_prbp),
+};
+
+const size_t sppctl_list_funcs_sz = ARRAY_SIZE(sppctl_list_funcs);
-- 
2.7.4

