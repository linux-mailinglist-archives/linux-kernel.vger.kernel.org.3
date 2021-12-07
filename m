Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E731846B1CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhLGEVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbhLGEVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:21:21 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F0DC061354;
        Mon,  6 Dec 2021 20:17:51 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id q14so13104803qtx.10;
        Mon, 06 Dec 2021 20:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pdpd9b1F+ZOrqyu0dSF5tcigGqUuSkU99dsOg+OJOPU=;
        b=MZ7BXglSQJNMoVYBDOMPU3V10vgXKM9svQedlYAOdBAZySYvz9ZtdYXgJTMCd5eWMG
         s3my/9VHhKxqwzXn33LT0AzRquP0A+i4xglrcikZkoyAh//Xo+arcAU0uBVONaapwXnu
         idH9EBoEZXlNNEtSl+QGk4reqaubESL6N7famH0wuljLUjNc5L7iqIeCTKgH8xoOxn+b
         kTlJBkZEhMQyoyJCFV+jBc4MCHKmNWYEValm4T/Ru2IUdeAE57/pUWOsmENZ1wvLAUXL
         CJq97v/FixjIHx2vge8gY+IvloPRNPFMFOhC+yo1pxpywzGUj0necmht4ZX15033CRfS
         nGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pdpd9b1F+ZOrqyu0dSF5tcigGqUuSkU99dsOg+OJOPU=;
        b=rwJC8yq3zvZTap8WEFpw5yJpzNZ8D5uzfLVqCqwCLuwvTi5UnR9VWQe8e+NA6UFaTX
         qm0zCKpcDU9N8NjyC2jfeqeC+gZ3Gv4maecrNZsr6SHtT4DBx5v0GIhq08I2mvbvKijA
         +tJDvH0sAtju7TYE3nH0TRtsCiEm9klfWakr8SmxGKa0jDdvvZl6bKUdhLb5yL/gailm
         hbW+CE7HEMp+TBSEKGK4Fzu6ukDfEqW7V56//sOdLAwSnmVkWt69tiojfPy4Wdet5+N4
         iOkNxh6KL9qMdAx6mftIY1z/bb8d0PFxSn4UG9PDm6VQU8VZyu15eAgfihSR+9EIdqrk
         Rdnw==
X-Gm-Message-State: AOAM533UA3aDbBYHxCfbkwEoILyglCTc/w4nvR0h9bIDOnFzLYOBl+DY
        7abvBllWbupPNANi1H52M14=
X-Google-Smtp-Source: ABdhPJzXQbU+9mCoJR9RlzXPcmVt9c807fzya/MFrszp3SJnvVJJ1Va2Qyu5I1x6Jm4c4aQCklHpnA==
X-Received: by 2002:ac8:5e4d:: with SMTP id i13mr46134543qtx.452.1638850669817;
        Mon, 06 Dec 2021 20:17:49 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id q12sm8745004qtx.16.2021.12.06.20.17.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 20:17:49 -0800 (PST)
From:   Wells Lu <wellslutw@gmail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     wells.lu@sunplus.com, dvorkin@tibbo.com,
        Wells Lu <wellslutw@gmail.com>
Subject: [PATCH v3 2/2] pinctrl: Add driver for Sunplus SP7021
Date:   Tue,  7 Dec 2021 12:17:45 +0800
Message-Id: <1638850665-9474-3-git-send-email-wellslutw@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638850665-9474-1-git-send-email-wellslutw@gmail.com>
References: <1638850665-9474-1-git-send-email-wellslutw@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for Sunplus SP7021.

Signed-off-by: Wells Lu <wellslutw@gmail.com>
---
Changes in V3
  - Addressed comments of Mr. Linus Walleij.
  - Remove sysfs functions.
  - Cleaned up code.

 MAINTAINERS                             |    1 +
 drivers/pinctrl/Kconfig                 |    1 +
 drivers/pinctrl/Makefile                |    1 +
 drivers/pinctrl/sunplus/Kconfig         |   21 +
 drivers/pinctrl/sunplus/Makefile        |    5 +
 drivers/pinctrl/sunplus/sppctl.c        | 1074 +++++++++++++++++++++++++++++++
 drivers/pinctrl/sunplus/sppctl.h        |  154 +++++
 drivers/pinctrl/sunplus/sppctl_sp7021.c |  536 +++++++++++++++
 8 files changed, 1793 insertions(+)
 create mode 100644 drivers/pinctrl/sunplus/Kconfig
 create mode 100644 drivers/pinctrl/sunplus/Makefile
 create mode 100644 drivers/pinctrl/sunplus/sppctl.c
 create mode 100644 drivers/pinctrl/sunplus/sppctl.h
 create mode 100644 drivers/pinctrl/sunplus/sppctl_sp7021.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 723bbe3..c19bbfd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15135,6 +15135,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
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
index 0000000..f8b382e
--- /dev/null
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -0,0 +1,1074 @@
+// SPDX-License-Identifier: GPL-2.0
+/* SP7021 Pin Controller Driver.
+ * Copyright (C) Sunplus Tech/Tibbo Tech.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+
+#include <dt-bindings/pinctrl/sppctl-sp7021.h>
+#include "../pinctrl-utils.h"
+#include "../core.h"
+#include "sppctl.h"
+
+static void sppctl_func_set(struct sppctl_pdata *pctl, u8 func, u8 val)
+{
+	u32 reg, offset;
+
+	/* Note that upper 16-bit word is mask
+	 * and lower 16-bit word is value.
+	 * Enable mask before write.
+	 */
+	reg = 0x007f0000 | val;	/* Set value and enable mask. */
+
+	if (func & 1)
+		reg <<= 8;
+
+	/* Convert function # to register offset. */
+	offset = func & ~1;
+	offset <<= 1;
+
+	dev_dbg(pctl->pctl_dev->dev, "%s(0x%x, 0x%x): offset: 0x%x, reg: 0x%08x\n",
+		__func__, func, val, offset, reg);
+	writel(reg, pctl->moon2_base + offset);
+}
+
+static u8 sppctl_func_get(struct sppctl_pdata *pctl, u8 func)
+{
+	u32 reg, offset;
+	u8 val;
+
+	/* Convert function # to register offset. */
+	offset = func & ~1;
+	offset <<= 1;
+
+	reg = readl(pctl->moon2_base + offset);
+	if (func & 1)
+		val = reg >> 8;
+	else
+		val = reg;
+	val &= 0x7f;
+
+	dev_dbg(pctl->pctl_dev->dev, "%s(0x%x): offset: 0x%x, reg: 0x%08X, val: 0x%x\n",
+		__func__, func, offset, reg, val);
+
+	return val;
+}
+
+static void sppctl_gmx_set(struct sppctl_pdata *pctl, u8 reg_off, u8 bit_off, u8 bit_sz,
+			   u8 val)
+{
+	u32 mask, reg;
+
+	/* Note that upper 16-bit word is mask
+	 * and lower 16-bit word is value.
+	 * Enable mask before write.
+	 */
+	mask = ~(~0 << bit_sz);
+	reg = (mask << 16) | (val & mask);
+	reg <<= bit_off;
+	writel(reg, pctl->moon1_base + (reg_off << 2));
+
+	dev_dbg(pctl->pctl_dev->dev, "%s(0x%x, 0x%x, 0x%x, 0x%x): reg: 0x%08X\n",
+		__func__, reg_off, bit_off, bit_sz, val, reg);
+}
+
+static int sppctl_first_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg;
+
+	reg = readl(spp_gchip->first_base + SPPCTL_GPIO_OFF_FIRST + R32_ROF(offset));
+
+	dev_dbg(chip->parent, "%s(%u): addr = %p, reg = %08x, val = %d\n",
+		__func__, offset, spp_gchip->first_base + SPPCTL_GPIO_OFF_FIRST +
+		R32_ROF(offset), reg, (int)R32_VAL(reg, R32_BOF(offset)));
+
+	return R32_VAL(reg, R32_BOF(offset));
+}
+
+static int sppctl_master_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg;
+
+	reg = readl(spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_MASTER + R16_ROF(offset));
+
+	dev_dbg(chip->parent, "%s(%u): addr = %p, reg = %08x, val = %d\n",
+		__func__, offset, spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_MASTER +
+		R16_ROF(offset), reg, (int)R32_VAL(reg, R16_BOF(offset)));
+
+	return R32_VAL(reg, R16_BOF(offset));
+}
+
+static void sppctl_first_master_set(struct gpio_chip *chip, unsigned int offset,
+				    enum mux_f_mg first, enum mux_m_ig master)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg;
+
+	/* FIRST register */
+	if (first != mux_f_keep) {
+		reg = readl(spp_gchip->first_base + SPPCTL_GPIO_OFF_FIRST + R32_ROF(offset));
+		dev_dbg(chip->parent, "First: %08x (%p)\n", reg, spp_gchip->first_base +
+			SPPCTL_GPIO_OFF_FIRST + R32_ROF(offset));
+		if (first != R32_VAL(reg, R32_BOF(offset))) {
+			if (first == mux_f_gpio)
+				reg |= BIT(R32_BOF(offset));
+			else
+				reg &= ~BIT(R32_BOF(offset));
+			dev_dbg(chip->parent, "First: %08x\n", reg);
+			writel(reg, spp_gchip->first_base + SPPCTL_GPIO_OFF_FIRST +
+			       R32_ROF(offset));
+		}
+	}
+
+	/* MASTER register */
+	if (master != mux_m_keep) {
+		reg = (BIT(R16_BOF(offset)) << 16);
+		if (master == mux_m_gpio)
+			reg |= BIT(R16_BOF(offset));
+		dev_dbg(chip->parent, "Master: %08x (%p)\n", reg, spp_gchip->gpioxt_base +
+			SPPCTL_GPIO_OFF_MASTER + R16_ROF(offset));
+		writel(reg, spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_MASTER +
+		       R16_ROF(offset));
+	}
+}
+
+static void sppctl_gpio_input_inv_set(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg;
+
+	/* Upper 16-bit word is mask. Lower 16-bit word is value. */
+	reg = (BIT(R16_BOF(offset)) << 16) | BIT(R16_BOF(offset));
+	writel(reg, spp_gchip->gpioxt2_base + SPPCTL_GPIO_OFF_IINV + R16_ROF(offset));
+}
+
+static void sppctl_gpio_output_inv_set(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg;
+
+	/* Upper 16-bit word is mask. Lower 16-bit word is value. */
+	reg = (BIT(R16_BOF(offset)) << 16) | BIT(R16_BOF(offset));
+	writel(reg, spp_gchip->gpioxt2_base + SPPCTL_GPIO_OFF_OINV + R16_ROF(offset));
+}
+
+static int sppctl_gpio_output_od_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg;
+
+	reg = readl(spp_gchip->gpioxt2_base + SPPCTL_GPIO_OFF_OD + R16_ROF(offset));
+
+	return R32_VAL(reg, R16_BOF(offset));
+}
+
+static void sppctl_gpio_output_od_set(struct gpio_chip *chip, unsigned int offset,
+				      unsigned int val)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg;
+
+	/* Upper 16-bit word is mask. Lower 16-bit word is value. */
+	reg = (BIT(R16_BOF(offset)) << 16) | ((val & BIT(0)) << R16_BOF(offset));
+	writel(reg, spp_gchip->gpioxt2_base + SPPCTL_GPIO_OFF_OD + R16_ROF(offset));
+}
+
+static int sppctl_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg;
+
+	reg = readl(spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_OE + R16_ROF(offset));
+
+	return R32_VAL(reg, R16_BOF(offset)) ^ BIT(0);
+}
+
+static int sppctl_gpio_inv_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u16 inv_off;
+	u32 reg;
+
+	inv_off = SPPCTL_GPIO_OFF_IINV;
+	if (sppctl_gpio_get_direction(chip, offset) == 0)
+		inv_off = SPPCTL_GPIO_OFF_OINV;
+
+	reg = readl(spp_gchip->gpioxt2_base + inv_off + R16_ROF(offset));
+
+	return R32_VAL(reg, R16_BOF(offset));
+}
+
+static int sppctl_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg;
+
+	/* Upper 16-bit word is mask. Lower 16-bit word is value. */
+	reg = (BIT(R16_BOF(offset)) << 16);
+	writel(reg, spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_OE + R16_ROF(offset));
+
+	return 0;
+}
+
+static int sppctl_gpio_direction_output(struct gpio_chip *chip, unsigned int offset, int val)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg;
+
+	/* Upper 16-bit word is mask. Lower 16-bit word is value. */
+	reg = (BIT(R16_BOF(offset)) << 16) | BIT(R16_BOF(offset));
+	writel(reg, spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_OE + R16_ROF(offset));
+
+	if (val < 0)
+		return 0;
+
+	/* Upper 16-bit word is mask. Lower 16-bit word is value. */
+	reg = (BIT(R16_BOF(offset)) << 16) | ((val & BIT(0)) << R16_BOF(offset));
+	writel(reg, spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_OUT + R16_ROF(offset));
+
+	return 0;
+}
+
+static int sppctl_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg;
+
+	reg = readl(spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_IN + R32_ROF(offset));
+
+	return R32_VAL(reg, R32_BOF(offset));
+}
+
+static void sppctl_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u32 reg;
+
+	/* Upper 16-bit word is mask. Lower 16-bit word is value. */
+	reg = (BIT(R16_BOF(offset)) << 16) | (value & 0x0001) << R16_BOF(offset);
+	writel(reg, spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_OUT + R16_ROF(offset));
+}
+
+static int sppctl_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
+				  unsigned long config)
+{
+	enum pin_config_param param = pinconf_to_config_param(config);
+	struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
+	u16 arg = pinconf_to_config_argument(config);
+	int ret = 0;
+	u32 reg;
+
+	dev_dbg(chip->parent, "%s(%03d, %lX) param: %d, arg: %d\n", __func__,
+		offset, config, param, arg);
+
+	switch (param) {
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		/* Upper 16-bit word is mask. Lower 16-bit word is value. */
+		reg = (BIT(R16_BOF(offset)) << 16) | BIT(R16_BOF(offset));
+		writel(reg, spp_gchip->gpioxt2_base + SPPCTL_GPIO_OFF_OD + R16_ROF(offset));
+		break;
+
+	case PIN_CONFIG_INPUT_ENABLE:
+		dev_dbg(chip->parent, "%s(%03d, %lX) arg: %d\n", __func__,
+			offset, config, arg);
+		break;
+
+	case PIN_CONFIG_OUTPUT:
+		ret = sppctl_gpio_direction_output(chip, offset, 0);
+		break;
+
+	case PIN_CONFIG_PERSIST_STATE:
+		dev_dbg(chip->parent, "%s(%03d, %lX) not support, param: %d\n", __func__,
+			offset, config, param);
+		ret = -EOPNOTSUPP;
+		break;
+
+	default:
+		dev_dbg(chip->parent, "%s(%03d, %lX) unknown, param: %d\n", __func__,
+			offset, config, param);
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
+		seq_printf(s, " %c", sppctl_gpio_get_direction(chip, i) == 0 ? 'O' : 'I');
+		seq_printf(s, ":%d", sppctl_gpio_get(chip, i));
+		seq_printf(s, " %s", (sppctl_first_get(chip, i) ? "gpi" : "mux"));
+		seq_printf(s, " %s", (sppctl_master_get(chip, i) ? "gpi" : "iop"));
+		seq_printf(s, " %s", (sppctl_gpio_inv_get(chip, i) ? "inv" : "   "));
+		seq_printf(s, " %s", (sppctl_gpio_output_od_get(chip, i) ? "oDr" : ""));
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
+	if (!of_find_property(pdev->dev.of_node, "gpio-controller", NULL)) {
+		dev_err_probe(&pdev->dev, -EINVAL, "Not a gpio-controller!\n");
+		return -EINVAL;
+	}
+
+	spp_gchip = devm_kzalloc(&pdev->dev, sizeof(*spp_gchip), GFP_KERNEL);
+	if (!spp_gchip)
+		return -ENOMEM;
+	pctl->spp_gchip = spp_gchip;
+
+	spp_gchip->gpioxt_base  = pctl->gpioxt_base;
+	spp_gchip->gpioxt2_base = pctl->gpioxt2_base;
+	spp_gchip->first_base   = pctl->first_base;
+
+	gchip =                    &spp_gchip->chip;
+	gchip->label =             SPPCTL_MODULE_NAME;
+	gchip->parent =            &pdev->dev;
+	gchip->owner =             THIS_MODULE;
+	gchip->request =           gpiochip_generic_request;
+	gchip->free =              gpiochip_generic_free;
+	gchip->get_direction =     sppctl_gpio_get_direction;
+	gchip->direction_input =   sppctl_gpio_direction_input;
+	gchip->direction_output =  sppctl_gpio_direction_output;
+	gchip->get =               sppctl_gpio_get;
+	gchip->set =               sppctl_gpio_set;
+	gchip->set_config =        sppctl_gpio_set_config;
+#ifdef CONFIG_DEBUG_FS
+	gchip->dbg_show =          sppctl_gpio_dbg_show;
+#endif
+	gchip->base =              0; /* it is main platform GPIO controller */
+	gchip->ngpio =             sppctl_gpio_list_sz;
+	gchip->names =             sppctl_gpio_list_s;
+	gchip->can_sleep =         0;
+	gchip->of_node =           pdev->dev.of_node;
+	gchip->of_gpio_n_cells =   2;
+
+	pctl->pctl_grange.npins = gchip->ngpio;
+	pctl->pctl_grange.base =  gchip->base;
+	pctl->pctl_grange.name =  gchip->label;
+	pctl->pctl_grange.gc =    gchip;
+
+	err = devm_gpiochip_add_data(&pdev->dev, gchip, spp_gchip);
+	if (err) {
+		dev_err_probe(&pdev->dev, err, "Failed to add gpiochip!\n");
+		return err;
+	}
+
+	return 0;
+}
+
+/* pinconf operations */
+static int stpctl_pin_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
+				 unsigned long *config)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int param = pinconf_to_config_param(*config);
+	unsigned int arg = 0;
+
+	dev_dbg(pctldev->dev, "%s(%d)\n", __func__, pin);
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
+		if (sppctl_gpio_get_direction(&pctl->spp_gchip->chip, pin) != 0)
+			return -EINVAL;
+		arg = sppctl_gpio_get(&pctl->spp_gchip->chip, pin);
+		break;
+
+	default:
+		dev_dbg(pctldev->dev, "%s(%d) skipping, param: 0x%x\n",
+			__func__, pin, param);
+		return -EOPNOTSUPP;
+	}
+	*config = pinconf_to_config_packed(param, arg);
+
+	return 0;
+}
+
+static int stpctl_pin_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
+				 unsigned long *configs, unsigned int num_configs)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	int i = 0;
+
+	dev_dbg(pctldev->dev, "%s(%d, %ld, %d)\n", __func__, pin, *configs, num_configs);
+
+	/* Special handling for IOP */
+	if (configs[i] == 0xFF) {
+		sppctl_first_master_set(&pctl->spp_gchip->chip, pin, mux_f_gpio, mux_m_iop);
+		return 0;
+	}
+
+	for (i = 0; i < num_configs; i++) {
+		if (configs[i] & SPPCTL_PCTL_L_OUT) {
+			dev_dbg(pctldev->dev, "%d: OUT\n", i);
+			sppctl_gpio_direction_output(&pctl->spp_gchip->chip, pin, 0);
+		}
+		if (configs[i] & SPPCTL_PCTL_L_OU1) {
+			dev_dbg(pctldev->dev, "%d: OU1\n", i);
+			sppctl_gpio_direction_output(&pctl->spp_gchip->chip, pin, 1);
+		}
+		if (configs[i] & SPPCTL_PCTL_L_INV) {
+			dev_dbg(pctldev->dev, "%d: INV\n", i);
+			sppctl_gpio_input_inv_set(&pctl->spp_gchip->chip, pin);
+		}
+		if (configs[i] & SPPCTL_PCTL_L_ONV) {
+			dev_dbg(pctldev->dev, "%d: ONV\n", i);
+			sppctl_gpio_output_inv_set(&pctl->spp_gchip->chip, pin);
+		}
+		if (configs[i] & SPPCTL_PCTL_L_ODR) {
+			dev_dbg(pctldev->dev, "%d: ODR\n", i);
+			sppctl_gpio_output_od_set(&pctl->spp_gchip->chip, pin, 1);
+		}
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void stpctl_config_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
+				   unsigned int offset)
+{
+	dev_dbg(pctldev->dev, "%s(%d)\n", __func__, offset);
+	seq_printf(s, " %s", dev_name(pctldev->dev));
+}
+
+static void stpctl_config_group_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
+					 unsigned int selector)
+{
+	dev_dbg(pctldev->dev, "%s(%d)\n", __func__, selector);
+}
+
+static void stpctl_config_config_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
+					  unsigned long config)
+{
+	dev_dbg(pctldev->dev, "%s(%ld)\n", __func__, config);
+}
+#endif
+
+static const struct pinconf_ops sppctl_pconf_ops = {
+	.is_generic                 = true,
+	.pin_config_get             = stpctl_pin_config_get,
+	.pin_config_set             = stpctl_pin_config_set,
+#ifdef CONFIG_DEBUG_FS
+	.pin_config_dbg_show        = stpctl_config_dbg_show,
+	.pin_config_group_dbg_show  = stpctl_config_group_dbg_show,
+	.pin_config_config_dbg_show = stpctl_config_config_dbg_show,
+#endif
+};
+
+/* pinmux operations */
+static int stpctl_request(struct pinctrl_dev *pctldev, unsigned int offset)
+{
+	dev_dbg(pctldev->dev, "%s(%d)\n", __func__, offset);
+	return 0;
+}
+
+static int stpctl_free(struct pinctrl_dev *pctldev, unsigned int offset)
+{
+	dev_dbg(pctldev->dev, "%s(%d)\n", __func__, offset);
+	return 0;
+}
+
+static int stpctl_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	return sppctl_list_funcs_sz;
+}
+
+static const char *stpctl_get_function_name(struct pinctrl_dev *pctldev,
+					    unsigned int selector)
+{
+	return sppctl_list_funcs[selector].name;
+}
+
+static int stpctl_get_function_groups(struct pinctrl_dev *pctldev, unsigned int selector,
+				      const char * const **groups, unsigned int *num_groups)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct sppctl_func *f = &sppctl_list_funcs[selector];
+
+	*num_groups = 0;
+	switch (f->freg) {
+	case f_off_i:
+	case f_off_0:   /* gen GPIO/IOP: all groups = all pins */
+		*num_groups = sppctl_gpio_list_sz;
+		*groups = sppctl_gpio_list_s;
+		break;
+
+	case f_off_m:   /* pin-mux */
+		*num_groups = sppctl_pmux_list_sz;
+		*groups = sppctl_pmux_list_s;
+		break;
+
+	case f_off_g:   /* pin-group */
+		if (!f->grps)
+			break;
+		*num_groups = f->gnum;
+		*groups = &pctl->groups_name[selector * SPPCTL_MAX_GROUPS];
+		break;
+
+	default:
+		dev_err(pctldev->dev, "%s(selector: %d) unknown fOFF %d\n", __func__,
+			selector, f->freg);
+		break;
+	}
+
+	dev_dbg(pctldev->dev, "%s(selector: %d) %d\n", __func__, selector, *num_groups);
+	return 0;
+}
+
+static int stpctl_set_mux(struct pinctrl_dev *pctldev, unsigned int func_selector,
+			  unsigned int group_selector)
+{
+	const struct sppctl_func *f = &sppctl_list_funcs[func_selector];
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct grp2fp_map g2fpm = pctl->g2fp_maps[group_selector];
+	int i = -1, j = -1;
+
+	dev_dbg(pctldev->dev, "%s(func: %d, grp: %d)\n", __func__,
+		func_selector, group_selector);
+
+	switch (f->freg) {
+	case f_off_0:   /* GPIO. detouch from all funcs - ? */
+		for (i = 0; i < sppctl_list_funcs_sz; i++) {
+			if (sppctl_list_funcs[i].freg != f_off_m)
+				continue;
+			j++;
+			if (sppctl_func_get(pctl, j) != group_selector)
+				continue;
+			sppctl_func_set(pctl, j, 0);
+		}
+		break;
+
+	case f_off_m:   /* Mux */
+		sppctl_first_master_set(&pctl->spp_gchip->chip, group_selector,
+					mux_f_mux, mux_m_keep);
+		sppctl_func_set(pctl, func_selector - 2, (group_selector == 0) ?
+				group_selector : group_selector - 7);
+		break;
+
+	case f_off_g:   /* Group */
+		for (i = 0; i < f->grps[g2fpm.g_idx].pnum; i++)
+			sppctl_first_master_set(&pctl->spp_gchip->chip,
+						f->grps[g2fpm.g_idx].pins[i],
+						mux_f_mux, mux_m_keep);
+		sppctl_gmx_set(pctl, f->roff, f->boff, f->blen, f->grps[g2fpm.g_idx].gval);
+		break;
+
+	case f_off_i:   /* IOP */
+		sppctl_first_master_set(&pctl->spp_gchip->chip, group_selector,
+					mux_f_gpio, mux_m_iop);
+		break;
+
+	default:
+		dev_err(pctldev->dev, "%s(func_selector: %d) unknown f_off: %d\n",
+			__func__, func_selector, f->freg);
+		break;
+	}
+
+	return 0;
+}
+
+static int stpctl_gpio_request_enable(struct pinctrl_dev *pctldev,
+				      struct pinctrl_gpio_range *range, unsigned int offset)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct pin_desc *pdesc;
+	int g_f, g_m;
+
+	dev_dbg(pctldev->dev, "%s(%d)\n", __func__, offset);
+
+	g_f = sppctl_first_get(&pctl->spp_gchip->chip, offset);
+	g_m = sppctl_master_get(&pctl->spp_gchip->chip, offset);
+	if (g_f == mux_f_gpio && g_m == mux_m_gpio)
+		return 0;
+
+	pdesc = pin_desc_get(pctldev, offset);
+	if (pdesc->mux_owner)
+		return -EACCES;
+
+	sppctl_first_master_set(&pctl->spp_gchip->chip, offset, mux_f_gpio, mux_m_gpio);
+	return 0;
+}
+
+static void stpctl_gpio_disable_free(struct pinctrl_dev *pctldev,
+				     struct pinctrl_gpio_range *range, unsigned int offset)
+{
+	dev_dbg(pctldev->dev, "%s(%d)\n", __func__, offset);
+}
+
+static int stpctl_gpio_set_direction(struct pinctrl_dev *pctldev,
+				     struct pinctrl_gpio_range *range, unsigned int offset,
+				     bool input)
+{
+	dev_dbg(pctldev->dev, "%s(%d,%d)\n", __func__, offset, input);
+	return 0;
+}
+
+static const struct pinmux_ops sppctl_pinmux_ops = {
+	.request             = stpctl_request,
+	.free                = stpctl_free,
+	.get_functions_count = stpctl_get_functions_count,
+	.get_function_name   = stpctl_get_function_name,
+	.get_function_groups = stpctl_get_function_groups,
+	.set_mux             = stpctl_set_mux,
+	.gpio_request_enable = stpctl_gpio_request_enable,
+	.gpio_disable_free   = stpctl_gpio_disable_free,
+	.gpio_set_direction  = stpctl_gpio_set_direction,
+	.strict              = 1
+};
+
+/* pinctrl operations */
+static int stpctl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->unq_grps_sz;
+}
+
+static const char *stpctl_get_group_name(struct pinctrl_dev *pctldev, unsigned int selector)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->unq_grps[selector];
+}
+
+static int stpctl_get_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
+				 const unsigned int **pins, unsigned int *num_pins)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct grp2fp_map g2fpm = pctl->g2fp_maps[selector];
+	const struct sppctl_func *f;
+
+	f = &sppctl_list_funcs[g2fpm.f_idx];
+	dev_dbg(pctldev->dev, "%s(%d), f_idx: %d, g_idx: %d, freg: %d\n",
+		__func__, selector, g2fpm.f_idx, g2fpm.g_idx, f->freg);
+
+	*num_pins = 0;
+
+	/* MUX | GPIO | IOP: 1 pin -> 1 group */
+	if (f->freg != f_off_g) {
+		*num_pins = 1;
+		*pins = &sppctl_pins_gpio[selector];
+		return 0;
+	}
+
+	/* IOP (several pins at once in a group) */
+	if (!f->grps)
+		return 0;
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
+static void stpctl_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
+				unsigned int offset)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const char *tmpp;
+	u8 g_f, g_m;
+
+	seq_printf(s, "%s", dev_name(pctldev->dev));
+	g_f = sppctl_first_get(&pctl->spp_gchip->chip, offset);
+	g_m = sppctl_master_get(&pctl->spp_gchip->chip, offset);
+
+	tmpp = "?";
+	if (g_f &&  g_m)
+		tmpp = "GPIO";
+	if (g_f && !g_m)
+		tmpp = " IOP";
+	if (!g_f)
+		tmpp = " MUX";
+	seq_printf(s, " %s", tmpp);
+}
+#endif
+
+static int stpctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node *np_config,
+				 struct pinctrl_map **map, unsigned int *num_maps)
+{
+	struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
+	int nmG = of_property_count_strings(np_config, "groups");
+	const struct sppctl_func *f = NULL;
+	struct device_node *parent;
+	unsigned long *configs;
+	struct property *prop;
+	const char *s_f, *s_g;
+	u8 p_p, p_g, p_f, p_l;
+	const __be32 *list;
+	u32 dt_pin, dt_fun;
+	int i, size = 0;
+
+	list = of_get_property(np_config, "pins", &size);
+
+	if (nmG <= 0)
+		nmG = 0;
+
+	parent = of_get_parent(np_config);
+	*num_maps = size / sizeof(*list);
+
+	/* Check if out of range or invalid? */
+	for (i = 0; i < (*num_maps); i++) {
+		dt_pin = be32_to_cpu(list[i]);
+		p_p = SPPCTL_PCTLD_P(dt_pin);
+		p_g = SPPCTL_PCTLD_G(dt_pin);
+
+		if (p_p >= sppctl_pins_all_sz) {
+			dev_dbg(pctldev->dev, "Invalid pin property at index %d (0x%08x)\n",
+				i, dt_pin);
+			return -EINVAL;
+		}
+	}
+
+	*map = kcalloc(*num_maps + nmG, sizeof(**map), GFP_KERNEL);
+	for (i = 0; i < (*num_maps); i++) {
+		dt_pin = be32_to_cpu(list[i]);
+		p_p = SPPCTL_PCTLD_P(dt_pin);
+		p_g = SPPCTL_PCTLD_G(dt_pin);
+		p_f = SPPCTL_PCTLD_F(dt_pin);
+		p_l = SPPCTL_PCTLD_L(dt_pin);
+		(*map)[i].name = parent->name;
+		dev_dbg(pctldev->dev, "map [%d]=%08x, p=%d, g=%d, f=%d, l=%d\n",
+			i, dt_pin, p_p, p_g, p_f, p_l);
+
+		if (p_g == SPPCTL_PCTL_G_GPIO) {
+			(*map)[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
+			(*map)[i].data.configs.num_configs = 1;
+			(*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, p_p);
+			configs = kcalloc(1, sizeof(*configs), GFP_KERNEL);
+			*configs = p_l;
+			(*map)[i].data.configs.configs = configs;
+
+			dev_dbg(pctldev->dev, "%s(%d) = 0x%x\n",
+				(*map)[i].data.configs.group_or_pin, p_p, p_l);
+		} else if (p_g == SPPCTL_PCTL_G_IOPP) {
+			(*map)[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
+			(*map)[i].data.configs.num_configs = 1;
+			(*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, p_p);
+			configs = kcalloc(1, sizeof(*configs), GFP_KERNEL);
+			*configs = 0xFF;
+			(*map)[i].data.configs.configs = configs;
+
+			dev_dbg(pctldev->dev, "%s(%d) = 0x%x\n",
+				(*map)[i].data.configs.group_or_pin, p_p, p_l);
+		} else {
+			(*map)[i].type = PIN_MAP_TYPE_MUX_GROUP;
+			(*map)[i].data.mux.function = sppctl_list_funcs[p_f].name;
+			(*map)[i].data.mux.group = pin_get_name(pctldev, p_p);
+
+			dev_dbg(pctldev->dev, "f->p: %s(%d)->%s(%d)\n",
+				(*map)[i].data.mux.function, p_f,
+				(*map)[i].data.mux.group, p_p);
+		}
+	}
+
+	/* Handle pin-group function. */
+	if (nmG > 0 && of_property_read_string(np_config, "function", &s_f) == 0) {
+		dev_dbg(pctldev->dev, "found func: %s\n", s_f);
+		of_property_for_each_string(np_config, "groups", prop, s_g) {
+			dev_dbg(pctldev->dev, " %s: %s\n", s_f, s_g);
+			(*map)[*num_maps].type = PIN_MAP_TYPE_MUX_GROUP;
+			(*map)[*num_maps].data.mux.function = s_f;
+			(*map)[*num_maps].data.mux.group = s_g;
+			dev_dbg(pctldev->dev, "f->g: %s->%s\n",
+				(*map)[*num_maps].data.mux.function,
+				(*map)[*num_maps].data.mux.group);
+			(*num_maps)++;
+		}
+	}
+
+	/* Handle zero function. */
+	list = of_get_property(np_config, "zero_func", &size);
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
+			switch (f->freg) {
+			case f_off_m:
+				dev_dbg(pctldev->dev, "Zero-func: %d (%s)\n",
+					dt_fun, f->name);
+				sppctl_func_set(pctl, dt_fun - 2, 0);
+				break;
+
+			case f_off_g:
+				dev_dbg(pctldev->dev, "zero-group: %d (%s)\n",
+					dt_fun, f->name);
+				sppctl_gmx_set(pctl, f->roff, f->boff, f->blen, 0);
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
+static void stpctl_dt_free_map(struct pinctrl_dev *pctldev, struct pinctrl_map *map,
+			       unsigned int num_maps)
+{
+	dev_dbg(pctldev->dev, "%s(%d)\n", __func__, num_maps);
+	pinctrl_utils_free_map(pctldev, map, num_maps);
+}
+
+static const struct pinctrl_ops sppctl_pctl_ops = {
+	.get_groups_count = stpctl_get_groups_count,
+	.get_group_name   = stpctl_get_group_name,
+	.get_group_pins   = stpctl_get_group_pins,
+#ifdef CONFIG_DEBUG_FS
+	.pin_dbg_show     = stpctl_pin_dbg_show,
+#endif
+	.dt_node_to_map   = stpctl_dt_node_to_map,
+	.dt_free_map      = stpctl_dt_free_map,
+};
+
+/* platform driver functions */
+static int sppctl_group_groups(struct platform_device *pdev)
+{
+	struct sppctl_pdata *sppctl = pdev->dev.platform_data;
+	const char *name;
+	int i, k, j;
+
+	/* Fill array of all groups. */
+	sppctl->unq_grps = NULL;
+	sppctl->unq_grps_sz = sppctl_gpio_list_sz;
+
+	/* Calculate unique group names array size. */
+	for (i = 0; i < sppctl_list_funcs_sz; i++)
+		if (sppctl_list_funcs[i].freg == f_off_g)
+			sppctl->unq_grps_sz += sppctl_list_funcs[i].gnum;
+
+	/* Fill up unique group names array. */
+	sppctl->unq_grps = devm_kzalloc(&pdev->dev, (sppctl->unq_grps_sz + 1) *
+					sizeof(char *), GFP_KERNEL);
+	if (!sppctl->unq_grps)
+		return -ENOMEM;
+
+	sppctl->g2fp_maps = devm_kzalloc(&pdev->dev, (sppctl->unq_grps_sz + 1) *
+					 sizeof(struct grp2fp_map), GFP_KERNEL);
+	if (!sppctl->g2fp_maps)
+		return -ENOMEM;
+
+	sppctl->groups_name = devm_kzalloc(&pdev->dev, sppctl_list_funcs_sz *
+					   SPPCTL_MAX_GROUPS * sizeof(char *), GFP_KERNEL);
+	if (!sppctl->groups_name)
+		return -ENOMEM;
+
+	/* gpio */
+	for (i = 0; i < sppctl_gpio_list_sz; i++) {
+		sppctl->unq_grps[i] = sppctl_gpio_list_s[i];
+		sppctl->g2fp_maps[i].f_idx = 0;
+		sppctl->g2fp_maps[i].g_idx = i;
+	}
+
+	/* groups */
+	j = sppctl_gpio_list_sz;
+	for (i = 0; i < sppctl_list_funcs_sz; i++) {
+		if (sppctl_list_funcs[i].freg != f_off_g)
+			continue;
+
+		for (k = 0; k < sppctl_list_funcs[i].gnum; k++) {
+			name = sppctl_list_funcs[i].grps[k].name;
+			sppctl->groups_name[i * SPPCTL_MAX_GROUPS + k] = name;
+			sppctl->unq_grps[j] = name;
+			sppctl->g2fp_maps[j].f_idx = i;
+			sppctl->g2fp_maps[j].g_idx = k;
+			j++;
+		}
+	}
+
+	dev_dbg(&pdev->dev, "funcs: %zd unq_grps: %zd\n", sppctl_list_funcs_sz,
+		sppctl->unq_grps_sz);
+	return 0;
+}
+
+static int sppctl_pinctrl_init(struct platform_device *pdev)
+{
+	struct device_node *np = of_node_get(pdev->dev.of_node);
+	struct sppctl_pdata *sppctl = pdev->dev.platform_data;
+	int err;
+
+	/* Initialize pctl_desc */
+	sppctl->pctl_desc.owner   = THIS_MODULE;
+	sppctl->pctl_desc.name    = dev_name(&pdev->dev);
+	sppctl->pctl_desc.pins    = &sppctl_pins_all[0];
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
+		dev_err_probe(&pdev->dev, err, "Failed to register pinctrl!\n");
+		of_node_put(np);
+		return err;
+	}
+
+	pinctrl_enable(sppctl->pctl_dev);
+	return 0;
+}
+
+static int sppctl_resource_map(struct platform_device *pdev, struct sppctl_pdata *sppctl)
+{
+	struct resource *rp;
+	int ret;
+
+	/* MOON2 registers */
+	rp = platform_get_resource_byname(pdev, IORESOURCE_MEM, "moon2");
+	sppctl->moon2_base = devm_ioremap_resource(&pdev->dev, rp);
+	if (IS_ERR(sppctl->moon2_base)) {
+		ret = PTR_ERR(sppctl->moon2_base);
+		goto ioremap_failed;
+	}
+	dev_dbg(&pdev->dev, "MOON2:   %pr\n", rp);
+
+	/* GPIOXT registers */
+	rp = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpioxt");
+	sppctl->gpioxt_base = devm_ioremap_resource(&pdev->dev, rp);
+	if (IS_ERR(sppctl->gpioxt_base)) {
+		ret = PTR_ERR(sppctl->gpioxt_base);
+		goto ioremap_failed;
+	}
+	dev_dbg(&pdev->dev, "GPIOXT:  %pr\n", rp);
+
+	/* GPIOXT 2 registers */
+	rp = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpioxt2");
+	sppctl->gpioxt2_base = devm_ioremap_resource(&pdev->dev, rp);
+	if (IS_ERR(sppctl->gpioxt2_base)) {
+		ret = PTR_ERR(sppctl->gpioxt2_base);
+		goto ioremap_failed;
+	}
+	dev_dbg(&pdev->dev, "GPIOXT2: %pr\n", rp);
+
+	/* FIRST registers */
+	rp = platform_get_resource_byname(pdev, IORESOURCE_MEM, "first");
+	sppctl->first_base = devm_ioremap_resource(&pdev->dev, rp);
+	if (IS_ERR(sppctl->first_base)) {
+		ret = PTR_ERR(sppctl->first_base);
+		goto ioremap_failed;
+	}
+	dev_dbg(&pdev->dev, "FIRST:   %pr\n", rp);
+
+	/* MOON1 registers */
+	rp = platform_get_resource_byname(pdev, IORESOURCE_MEM, "moon1");
+	sppctl->moon1_base = devm_ioremap_resource(&pdev->dev, rp);
+	if (IS_ERR(sppctl->moon1_base)) {
+		ret = PTR_ERR(sppctl->moon1_base);
+		goto ioremap_failed;
+	}
+	dev_dbg(&pdev->dev, "MOON1:   %pr\n", rp);
+
+	return 0;
+
+ioremap_failed:
+	dev_err_probe(&pdev->dev, ret, "ioremap failed!\n");
+	return ret;
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
+	pdev->dev.platform_data = sppctl;
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
+	dev_info(&pdev->dev, "SP7021 PinCtrl by Sunplus/Tibbo Tech. (C) 2020");
+
+	return 0;
+}
+
+static int sppctl_remove(struct platform_device *pdev)
+{
+	struct sppctl_pdata *sppctl = pdev->dev.platform_data;
+
+	devm_pinctrl_unregister(&pdev->dev, sppctl->pctl_dev);
+	return 0;
+}
+
+static const struct of_device_id sppctl_match_table[] = {
+	{ .compatible = "sunplus,sp7021-pctl" },
+	{ /* zero */ }
+};
+
+static struct platform_driver sppctl_pinctrl_driver = {
+	.driver = {
+		.name           = SPPCTL_MODULE_NAME,
+		.owner          = THIS_MODULE,
+		.of_match_table = sppctl_match_table,
+	},
+	.probe  = sppctl_probe,
+	.remove = sppctl_remove,
+};
+builtin_platform_driver(sppctl_pinctrl_driver)
+
+MODULE_AUTHOR("Dvorkin Dmitry <dvorkin@tibbo.com>");
+MODULE_AUTHOR("Wells Lu <wellslutw@gmail.com>");
+MODULE_DESCRIPTION("Sunplus SP7021 Pin Control and GPIO driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/sunplus/sppctl.h b/drivers/pinctrl/sunplus/sppctl.h
new file mode 100644
index 0000000..49a59fe
--- /dev/null
+++ b/drivers/pinctrl/sunplus/sppctl.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* SP7021 Pin Controller Driver.
+ * Copyright (C) Sunplus Tech/Tibbo Tech.
+ */
+
+#ifndef __SPPCTL_H__
+#define __SPPCTL_H__
+
+#define SPPCTL_MODULE_NAME	"sppctl_sp7021"
+#define SPPCTL_MAX_GROUPS	5
+
+#define SPPCTL_GPIO_OFF_FIRST	0x00
+#define SPPCTL_GPIO_OFF_MASTER	0x00
+#define SPPCTL_GPIO_OFF_OE	0x20
+#define SPPCTL_GPIO_OFF_OUT	0x40
+#define SPPCTL_GPIO_OFF_IN	0x60
+#define SPPCTL_GPIO_OFF_IINV	0x00
+#define SPPCTL_GPIO_OFF_OINV	0x20
+#define SPPCTL_GPIO_OFF_OD	0x40
+
+/* (/16)*4 */
+#define R16_ROF(r)		(((r) >> 4) << 2)
+#define R16_BOF(r)		((r) % 16)
+
+/* (/32)*4 */
+#define R32_ROF(r)		(((r) >> 5) << 2)
+#define R32_BOF(r)		((r) % 32)
+#define R32_VAL(r, boff)	(((r) >> (boff)) & BIT(0))
+
+#define FNCE(n, r, o, bo, bl, g) { \
+	.name = n, \
+	.freg = r, \
+	.roff = o, \
+	.boff = bo, \
+	.blen = bl, \
+	.grps = (g), \
+	.gnum = ARRAY_SIZE(g), \
+}
+
+#define FNCN(n, r, o, bo, bl) { \
+	.name = n, \
+	.freg = r, \
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
+/* FIRST register:
+ *   0: MUX
+ *   1: GPIO/IOP
+ *   2: No change
+ */
+enum mux_f_mg {
+	mux_f_mux = 0,
+	mux_f_gpio = 1,
+	mux_f_keep = 2,
+};
+
+/* MASTER register:
+ *   0: IOP
+ *   1: GPIO
+ *   2: No change
+ */
+enum mux_m_ig {
+	mux_m_iop = 0,
+	mux_m_gpio = 1,
+	mux_m_keep = 2,
+};
+
+enum f_off {
+	f_off_0,	/* nowhere          */
+	f_off_m,	/* mux registers    */
+	f_off_g,	/* group registers  */
+	f_off_i,	/* iop registers    */
+};
+
+struct grp2fp_map {
+	u16 f_idx;      /* function index   */
+	u16 g_idx;      /* pins/group index */
+};
+
+struct sppctl_sdata {
+	u8 i;
+	u8 ridx;
+	struct sppctl_pdata *pdata;
+};
+
+struct sppctl_gpio_chip {
+	void __iomem *gpioxt_base;	/* MASTER, OE, OUT, IN */
+	void __iomem *gpioxt2_base;	/* I_INV, O_INV, OD    */
+	void __iomem *first_base;	/* GPIO_FIRST          */
+
+	struct gpio_chip chip;
+};
+
+struct sppctl_pdata {
+	/* base addresses */
+	void __iomem *moon2_base;	/* MOON2               */
+	void __iomem *gpioxt_base;	/* MASTER, OE, OUT, IN */
+	void __iomem *gpioxt2_base;	/* I_INV, O_INV, OD    */
+	void __iomem *first_base;	/* FIRST               */
+	void __iomem *moon1_base;	/* MOON1               */
+
+	/* pinctrl and gpio-chip */
+	struct pinctrl_desc pctl_desc;
+	struct pinctrl_dev *pctl_dev;
+	struct pinctrl_gpio_range pctl_grange;
+	struct sppctl_gpio_chip *spp_gchip;
+
+	/* others */
+	char const **unq_grps;
+	struct grp2fp_map *g2fp_maps;
+	size_t unq_grps_sz;
+	const char **groups_name;
+};
+
+struct sppctl_grp {
+	const char * const name;
+	const u8 gval;                  /* group number    */
+	const unsigned * const pins;    /* list of pins    */
+	const unsigned int pnum;        /* number of pins  */
+};
+
+struct sppctl_func {
+	const char * const name;
+	const enum f_off freg;          /* function register type */
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
index 0000000..457342e
--- /dev/null
+++ b/drivers/pinctrl/sunplus/sppctl_sp7021.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0
+/* SP7021 Pin Controller Driver.
+ * Copyright (C) Sunplus Tech/Tibbo Tech.
+ */
+
+#include <linux/gpio/driver.h>
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
+	D_PIS(12, 0), D_PIS(12, 1), D_PIS(12, 2)
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
+	D(12, 0), D(12, 1), D(12, 2)
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
+	/* gpio (not wired) and iop only */
+	P(9, 0),  P(9, 1),  P(9, 2),  P(9, 3),  P(9, 4),  P(9, 5),  P(9, 6),  P(9, 7),
+	P(10, 0), P(10, 1), P(10, 2), P(10, 3), P(10, 4), P(10, 5), P(10, 6), P(10, 7),
+	P(11, 0), P(11, 1), P(11, 2), P(11, 3), P(11, 4), P(11, 5), P(11, 6), P(11, 7),
+	P(12, 0), P(12, 1), P(12, 2)
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
+	D_PIS(8, 4), D_PIS(8, 5), D_PIS(8, 6), D_PIS(8, 7)
+};
+
+const size_t sppctl_pmux_list_sz = ARRAY_SIZE(sppctl_pmux_list_s);
+
+static const unsigned int pins_spif1[] = { D(10, 3), D(10, 4), D(10, 6), D(10, 7) };
+static const unsigned int pins_spif2[] = { D(9, 4), D(9, 6), D(9, 7), D(10, 1) };
+static const struct sppctl_grp sp7021grps_spif[] = {
+	EGRP("SPI_FLASH1", 1, pins_spif1),
+	EGRP("SPI_FLASH2", 2, pins_spif2)
+};
+
+static const unsigned int pins_spi41[] = { D(10, 2), D(10, 5) };
+static const unsigned int pins_spi42[] = { D(9, 5), D(9, 8) };
+static const struct sppctl_grp sp7021grps_spi4[] = {
+	EGRP("SPI_FLASH_4BIT1", 1, pins_spi41),
+	EGRP("SPI_FLASH_4BIT2", 2, pins_spi42)
+};
+
+static const unsigned int pins_snan[] = {
+	D(9, 4), D(9, 5), D(9, 6), D(9, 7), D(10, 0), D(10, 1)
+};
+
+static const struct sppctl_grp sp7021grps_snan[] = {
+	EGRP("SPI_NAND", 1, pins_snan)
+};
+
+static const unsigned int pins_emmc[] = {
+	D(9, 0), D(9, 1), D(9, 2), D(9, 3), D(9, 4), D(9, 5),
+	D(9, 6), D(9, 7), D(10, 0), D(10, 1) };
+
+static const struct sppctl_grp sp7021grps_emmc[] = {
+	EGRP("CARD0_EMMC", 1, pins_emmc)
+};
+
+static const unsigned int pins_sdsd[] = {
+	D(8, 1), D(8, 2), D(8, 3), D(8, 4), D(8, 5), D(8, 6)
+};
+
+static const struct sppctl_grp sp7021grps_sdsd[] = {
+	EGRP("SD_CARD", 1, pins_sdsd)
+};
+
+static const unsigned int pins_uar0[] = { D(11, 0), D(11, 1) };
+
+static const struct sppctl_grp sp7021grps_uar0[] = {
+	EGRP("UA0", 1, pins_uar0)
+};
+
+static const unsigned int pins_adbg1[] = { D(10, 2), D(10, 3) };
+static const unsigned int pins_adbg2[] = { D(7, 1), D(7, 2) };
+
+static const struct sppctl_grp sp7021grps_adbg[] = {
+	EGRP("ACHIP_DEBUG1", 1, pins_adbg1),
+	EGRP("ACHIP_DEBUG2", 2, pins_adbg2)
+};
+
+static const unsigned int pins_aua2axi1[] = { D(2, 0), D(2, 1), D(2, 2) };
+static const unsigned int pins_aua2axi2[] = { D(1, 0), D(1, 1), D(1, 2) };
+
+static const struct sppctl_grp sp7021grps_au2x[] = {
+	EGRP("ACHIP_UA2AXI1", 1, pins_aua2axi1),
+	EGRP("ACHIP_UA2AXI2", 2, pins_aua2axi2)
+};
+
+static const unsigned int pins_fpga[] = {
+	D(0, 2), D(0, 3), D(0, 4), D(0, 5), D(0, 6), D(0, 7),
+	D(1, 0), D(1, 1), D(1, 2), D(1, 3), D(1, 4), D(1, 5),
+	D(1, 6), D(1, 7), D(2, 0), D(2, 1), D(2, 2), D(2, 3),
+	D(2, 4), D(2, 5), D(2, 6), D(2, 7), D(3, 0), D(3, 1),
+	D(3, 2), D(3, 3), D(3, 4), D(3, 5), D(3, 6), D(3, 7),
+	D(4, 0), D(4, 1), D(4, 2), D(4, 3), D(4, 4), D(4, 5),
+	D(4, 6), D(4, 7), D(5, 0), D(5, 1), D(5, 2)
+};
+
+static const struct sppctl_grp sp7021grps_fpga[] = {
+	EGRP("FPGA_IFX", 1, pins_fpga)
+};
+
+static const unsigned int pins_hdmi1[] = { D(10, 6), D(12, 2), D(12, 1) };
+static const unsigned int pins_hdmi2[] = { D(8, 3), D(8, 5), D(8, 6) };
+static const unsigned int pins_hdmi3[] = { D(7, 4), D(7, 6), D(7, 7) };
+
+static const struct sppctl_grp sp7021grps_hdmi[] = {
+	EGRP("HDMI_TX1", 1, pins_hdmi1),
+	EGRP("HDMI_TX2", 2, pins_hdmi2),
+	EGRP("HDMI_TX3", 3, pins_hdmi3)
+};
+
+static const unsigned int pins_eadc[] = {
+	D(1, 0), D(1, 1), D(1, 2), D(1, 3), D(1, 4), D(1, 5), D(1, 6)
+};
+
+static const struct sppctl_grp sp7021grps_eadc[] = {
+	EGRP("AUD_EXT_ADC_IFX0", 1, pins_eadc)
+};
+
+static const unsigned int pins_edac[] = {
+	D(2, 5), D(2, 6), D(2, 7), D(3, 0), D(3, 1), D(3, 2), D(3, 4)
+};
+
+static const struct sppctl_grp sp7021grps_edac[] = {
+	EGRP("AUD_EXT_DAC_IFX0", 1, pins_edac)
+};
+
+static const unsigned int pins_spdi[] = { D(2, 4) };
+
+static const struct sppctl_grp sp7021grps_spdi[] = {
+	EGRP("AUD_IEC_RX0", 1, pins_spdi)
+};
+
+static const unsigned int pins_spdo[] = { D(3, 6) };
+
+static const struct sppctl_grp sp7021grps_spdo[] = {
+	EGRP("AUD_IEC_TX0", 1, pins_spdo)
+};
+
+static const unsigned int pins_tdmt[] = {
+	D(2, 5), D(2, 6), D(2, 7), D(3, 0), D(3, 1), D(3, 2)
+};
+
+static const struct sppctl_grp sp7021grps_tdmt[] = {
+	EGRP("TDMTX_IFX0", 1, pins_tdmt)
+};
+
+static const unsigned int pins_tdmr[] = { D(1, 7), D(2, 0), D(2, 1), D(2, 2) };
+
+static const struct sppctl_grp sp7021grps_tdmr[] = {
+	EGRP("TDMRX_IFX0", 1, pins_tdmr)
+};
+
+static const unsigned int pins_pdmr[] = {
+	D(1, 7), D(2, 0), D(2, 1), D(2, 2), D(2, 3)
+};
+
+static const struct sppctl_grp sp7021grps_pdmr[] = {
+	EGRP("PDMRX_IFX0", 1, pins_pdmr)
+};
+
+static const unsigned int pins_pcmt[] = {
+	D(3, 7), D(4, 0), D(4, 1), D(4, 2), D(4, 3), D(4, 4)
+};
+
+static const struct sppctl_grp sp7021grps_pcmt[] = {
+	EGRP("PCM_IEC_TX", 1, pins_pcmt)
+};
+
+static const unsigned int pins_lcdi[] = {
+	D(1, 4), D(1, 5),
+	D(1, 6), D(1, 7), D(2, 0), D(2, 1), D(2, 2), D(2, 3),
+	D(2, 4), D(2, 5), D(2, 6), D(2, 7), D(3, 0), D(3, 1),
+	D(3, 2), D(3, 3), D(3, 4), D(3, 5), D(3, 6), D(3, 7),
+	D(4, 0), D(4, 1), D(4, 2), D(4, 3), D(4, 4), D(4, 5),
+	D(4, 6), D(4, 7)
+};
+
+static const struct sppctl_grp sp7021grps_lcdi[] = {
+	EGRP("LCDIF", 1, pins_lcdi)
+};
+
+static const unsigned int pins_dvdd[] = {
+	D(7, 0), D(7, 1), D(7, 2), D(7, 3), D(7, 4), D(7, 5), D(7, 6), D(7, 7),
+	D(8, 0), D(8, 1), D(8, 2), D(8, 3), D(8, 4), D(8, 5)
+};
+
+static const struct sppctl_grp sp7021grps_dvdd[] = {
+	EGRP("DVD_DSP_DEBUG", 1, pins_dvdd)
+};
+
+static const unsigned int pins_i2cd[] = { D(1, 0), D(1, 1) };
+
+static const struct sppctl_grp sp7021grps_i2cd[] = {
+	EGRP("I2C_DEBUG", 1, pins_i2cd)
+};
+
+static const unsigned int pins_i2cs[] = { D(0, 0), D(0, 1) };
+
+static const struct sppctl_grp sp7021grps_i2cs[] = {
+	EGRP("I2C_SLAVE", 1, pins_i2cs)
+};
+
+static const unsigned int pins_wakp[] = { D(10, 5) };
+
+static const struct sppctl_grp sp7021grps_wakp[] = {
+	EGRP("WAKEUP", 1, pins_wakp)
+};
+
+static const unsigned int pins_u2ax[] = { D(2, 0), D(2, 1), D(3, 0), D(3, 1) };
+
+static const struct sppctl_grp sp7021grps_u2ax[] = {
+	EGRP("UART2AXI", 1, pins_u2ax)
+};
+
+static const unsigned int pins_u0ic[] = {
+	D(0, 0), D(0, 1), D(0, 4), D(0, 5), D(1, 0), D(1, 1)
+};
+
+static const struct sppctl_grp sp7021grps_u0ic[] = {
+	EGRP("USB0_I2C", 1, pins_u0ic)
+};
+
+static const unsigned int pins_u1ic[] = {
+	D(0, 2), D(0, 3), D(0, 6), D(0, 7), D(1, 2), D(1, 3)
+};
+
+static const struct sppctl_grp sp7021grps_u1ic[] = {
+	EGRP("USB1_I2C", 1, pins_u1ic)
+};
+
+static const unsigned int pins_u0ot[] = { D(11, 2) };
+
+static const struct sppctl_grp sp7021grps_u0ot[] = {
+	EGRP("USB0_OTG", 1, pins_u0ot)
+};
+
+static const unsigned int pins_u1ot[] = { D(11, 3) };
+
+static const struct sppctl_grp sp7021grps_u1ot[] = {
+	EGRP("USB1_OTG", 1, pins_u1ot)
+};
+
+static const unsigned int pins_uphd[] = {
+	D(0, 1), D(0, 2), D(0, 3), D(7, 4), D(7, 5), D(7, 6),
+	D(7, 7), D(8, 0), D(8, 1), D(8, 2), D(8, 3),
+	D(9, 7), D(10, 2), D(10, 3), D(10, 4)
+};
+
+static const struct sppctl_grp sp7021grps_up0d[] = {
+	EGRP("UPHY0_DEBUG", 1, pins_uphd)
+};
+
+static const struct sppctl_grp sp7021grps_up1d[] = {
+	EGRP("UPHY1_DEBUG", 1, pins_uphd)
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
+	D(10, 0), D(10, 1), D(10, 2), D(10, 3), D(10, 4), D(10, 5), D(10, 6), D(10, 7)
+};
+
+static const struct sppctl_grp sp7021grps_upex[] = {
+	EGRP("UPHY0_EXT", 1, pins_upex)
+};
+
+static const unsigned int pins_prp1[] = {
+	D(0, 6), D(0, 7),
+	D(1, 0), D(1, 1), D(1, 2), D(1, 3), D(1, 4), D(1, 5), D(1, 6), D(1, 7),
+	D(2, 1), D(2, 2), D(2, 3), D(2, 4), D(2, 5), D(2, 6), D(2, 7),
+	D(3, 0), D(3, 1), D(3, 2)
+};
+
+static const unsigned int pins_prp2[] = {
+	D(3, 4), D(3, 6), D(3, 7),
+	D(4, 0), D(4, 1), D(4, 2), D(4, 3), D(4, 4), D(4, 5), D(4, 6), D(4, 7),
+	D(5, 0), D(5, 1), D(5, 2), D(5, 3), D(5, 4), D(5, 5), D(5, 6), D(5, 7),
+	D(6, 4)
+};
+
+static const struct sppctl_grp sp7021grps_prbp[] = {
+	EGRP("PROBE_PORT1", 1, pins_prp1),
+	EGRP("PROBE_PORT2", 2, pins_prp2)
+};
+
+const struct sppctl_func sppctl_list_funcs[] = {
+	FNCN("GPIO",            f_off_0, 0x00, 0, 0),
+	FNCN("IOP",             f_off_0, 0x00, 0, 0),
+
+	FNCN("L2SW_CLK_OUT",        f_off_m, 0x00, 0, 7),
+	FNCN("L2SW_MAC_SMI_MDC",    f_off_m, 0x00, 8, 7),
+	FNCN("L2SW_LED_FLASH0",     f_off_m, 0x01, 0, 7),
+	FNCN("L2SW_LED_FLASH1",     f_off_m, 0x01, 8, 7),
+	FNCN("L2SW_LED_ON0",        f_off_m, 0x02, 0, 7),
+	FNCN("L2SW_LED_ON1",        f_off_m, 0x02, 8, 7),
+	FNCN("L2SW_MAC_SMI_MDIO",   f_off_m, 0x03, 0, 7),
+	FNCN("L2SW_P0_MAC_RMII_TXEN",   f_off_m, 0x03, 8, 7),
+	FNCN("L2SW_P0_MAC_RMII_TXD0",   f_off_m, 0x04, 0, 7),
+	FNCN("L2SW_P0_MAC_RMII_TXD1",   f_off_m, 0x04, 8, 7),
+	FNCN("L2SW_P0_MAC_RMII_CRSDV",  f_off_m, 0x05, 0, 7),
+	FNCN("L2SW_P0_MAC_RMII_RXD0",   f_off_m, 0x05, 8, 7),
+	FNCN("L2SW_P0_MAC_RMII_RXD1",   f_off_m, 0x06, 0, 7),
+	FNCN("L2SW_P0_MAC_RMII_RXER",   f_off_m, 0x06, 8, 7),
+	FNCN("L2SW_P1_MAC_RMII_TXEN",   f_off_m, 0x07, 0, 7),
+	FNCN("L2SW_P1_MAC_RMII_TXD0",   f_off_m, 0x07, 8, 7),
+	FNCN("L2SW_P1_MAC_RMII_TXD1",   f_off_m, 0x08, 0, 7),
+	FNCN("L2SW_P1_MAC_RMII_CRSDV",  f_off_m, 0x08, 8, 7),
+	FNCN("L2SW_P1_MAC_RMII_RXD0",   f_off_m, 0x09, 0, 7),
+	FNCN("L2SW_P1_MAC_RMII_RXD1",   f_off_m, 0x09, 8, 7),
+	FNCN("L2SW_P1_MAC_RMII_RXER",   f_off_m, 0x0A, 0, 7),
+	FNCN("DAISY_MODE",      f_off_m, 0x0A, 8, 7),
+	FNCN("SDIO_CLK",        f_off_m, 0x0B, 0, 7),
+	FNCN("SDIO_CMD",        f_off_m, 0x0B, 8, 7),
+	FNCN("SDIO_D0",         f_off_m, 0x0C, 0, 7),
+	FNCN("SDIO_D1",         f_off_m, 0x0C, 8, 7),
+	FNCN("SDIO_D2",         f_off_m, 0x0D, 0, 7),
+	FNCN("SDIO_D3",         f_off_m, 0x0D, 8, 7),
+	FNCN("PWM0",            f_off_m, 0x0E, 0, 7),
+	FNCN("PWM1",            f_off_m, 0x0E, 8, 7),
+	FNCN("PWM2",            f_off_m, 0x0F, 0, 7),
+	FNCN("PWM3",            f_off_m, 0x0F, 8, 7),
+
+	FNCN("PWM4",            f_off_m, 0x10, 0, 7),
+	FNCN("PWM5",            f_off_m, 0x10, 8, 7),
+	FNCN("PWM6",            f_off_m, 0x11, 0, 7),
+	FNCN("PWM7",            f_off_m, 0x11, 8, 7),
+	FNCN("ICM0_D",          f_off_m, 0x12, 0, 7),    /* 4x Input captures */
+	FNCN("ICM1_D",          f_off_m, 0x12, 8, 7),
+	FNCN("ICM2_D",          f_off_m, 0x13, 0, 7),
+	FNCN("ICM3_D",          f_off_m, 0x13, 8, 7),
+	FNCN("ICM0_CLK",        f_off_m, 0x14, 0, 7),
+	FNCN("ICM1_CLK",        f_off_m, 0x14, 8, 7),
+	FNCN("ICM2_CLK",        f_off_m, 0x15, 0, 7),
+	FNCN("ICM3_CLK",        f_off_m, 0x15, 8, 7),
+	FNCN("SPIM0_INT",       f_off_m, 0x16, 0, 7),    /* 4x SPI masters */
+	FNCN("SPIM0_CLK",       f_off_m, 0x16, 8, 7),
+	FNCN("SPIM0_EN",        f_off_m, 0x17, 0, 7),
+	FNCN("SPIM0_DO",        f_off_m, 0x17, 8, 7),
+	FNCN("SPIM0_DI",        f_off_m, 0x18, 0, 7),
+	FNCN("SPIM1_INT",       f_off_m, 0x18, 8, 7),
+	FNCN("SPIM1_CLK",       f_off_m, 0x19, 0, 7),
+	FNCN("SPIM1_EN",        f_off_m, 0x19, 8, 7),
+	FNCN("SPIM1_DO",        f_off_m, 0x1A, 0, 7),
+	FNCN("SPIM1_DI",        f_off_m, 0x1A, 8, 7),
+	FNCN("SPIM2_INT",       f_off_m, 0x1B, 0, 7),
+	FNCN("SPIM2_CLK",       f_off_m, 0x1B, 8, 7),
+	FNCN("SPIM2_EN",        f_off_m, 0x1C, 0, 7),
+	FNCN("SPIM2_DO",        f_off_m, 0x1C, 8, 7),
+	FNCN("SPIM2_DI",        f_off_m, 0x1D, 0, 7),
+	FNCN("SPIM3_INT",       f_off_m, 0x1D, 8, 7),
+	FNCN("SPIM3_CLK",       f_off_m, 0x1E, 0, 7),
+	FNCN("SPIM3_EN",        f_off_m, 0x1E, 8, 7),
+	FNCN("SPIM3_DO",        f_off_m, 0x1F, 0, 7),
+	FNCN("SPIM3_DI",        f_off_m, 0x1F, 8, 7),
+
+	FNCN("SPI0S_INT",       f_off_m, 0x20, 0, 7),    /* 4x SPI slaves */
+	FNCN("SPI0S_CLK",       f_off_m, 0x20, 8, 7),
+	FNCN("SPI0S_EN",        f_off_m, 0x21, 0, 7),
+	FNCN("SPI0S_DO",        f_off_m, 0x21, 8, 7),
+	FNCN("SPI0S_DI",        f_off_m, 0x22, 0, 7),
+	FNCN("SPI1S_INT",       f_off_m, 0x22, 8, 7),
+	FNCN("SPI1S_CLK",       f_off_m, 0x23, 0, 7),
+	FNCN("SPI1S_EN",        f_off_m, 0x23, 8, 7),
+	FNCN("SPI1S_DO",        f_off_m, 0x24, 0, 7),
+	FNCN("SPI1S_DI",        f_off_m, 0x24, 8, 7),
+	FNCN("SPI2S_INT",       f_off_m, 0x25, 0, 7),
+	FNCN("SPI2S_CLK",       f_off_m, 0x25, 8, 7),
+	FNCN("SPI2S_EN",        f_off_m, 0x26, 0, 7),
+	FNCN("SPI2S_DO",        f_off_m, 0x26, 8, 7),
+	FNCN("SPI2S_DI",        f_off_m, 0x27, 0, 7),
+	FNCN("SPI3S_INT",       f_off_m, 0x27, 8, 7),
+	FNCN("SPI3S_CLK",       f_off_m, 0x28, 0, 7),
+	FNCN("SPI3S_EN",        f_off_m, 0x28, 8, 7),
+	FNCN("SPI3S_DO",        f_off_m, 0x29, 0, 7),
+	FNCN("SPI3S_DI",        f_off_m, 0x29, 8, 7),
+	FNCN("I2CM0_CLK",       f_off_m, 0x2A, 0, 7),    /* 4x I2C masters */
+	FNCN("I2CM0_DAT",       f_off_m, 0x2A, 8, 7),
+	FNCN("I2CM1_CLK",       f_off_m, 0x2B, 0, 7),
+	FNCN("I2CM1_DAT",       f_off_m, 0x2B, 8, 7),
+	FNCN("I2CM2_CLK",       f_off_m, 0x2C, 0, 7),
+	FNCN("I2CM2_DAT",       f_off_m, 0x2C, 8, 7),
+	FNCN("I2CM3_CLK",       f_off_m, 0x2D, 0, 7),
+	FNCN("I2CM3_DAT",       f_off_m, 0x2D, 8, 7),
+	FNCN("UA1_TX",          f_off_m, 0x2E, 0, 7),    /* 4x UARTS */
+	FNCN("UA1_RX",          f_off_m, 0x2E, 8, 7),
+	FNCN("UA1_CTS",         f_off_m, 0x2F, 0, 7),
+	FNCN("UA1_RTS",         f_off_m, 0x2F, 8, 7),
+
+	FNCN("UA2_TX",          f_off_m, 0x30, 0, 7),
+	FNCN("UA2_RX",          f_off_m, 0x30, 8, 7),
+	FNCN("UA2_CTS",         f_off_m, 0x31, 0, 7),
+	FNCN("UA2_RTS",         f_off_m, 0x31, 8, 7),
+	FNCN("UA3_TX",          f_off_m, 0x32, 0, 7),
+	FNCN("UA3_RX",          f_off_m, 0x32, 8, 7),
+	FNCN("UA3_CTS",         f_off_m, 0x33, 0, 7),
+	FNCN("UA3_RTS",         f_off_m, 0x33, 8, 7),
+	FNCN("UA4_TX",          f_off_m, 0x34, 0, 7),
+	FNCN("UA4_RX",          f_off_m, 0x34, 8, 7),
+	FNCN("UA4_CTS",         f_off_m, 0x35, 0, 7),
+	FNCN("UA4_RTS",         f_off_m, 0x35, 8, 7),
+	FNCN("TIMER0_INT",      f_off_m, 0x36, 0, 7),    /* 4x timer int. */
+	FNCN("TIMER1_INT",      f_off_m, 0x36, 8, 7),
+	FNCN("TIMER2_INT",      f_off_m, 0x37, 0, 7),
+	FNCN("TIMER3_INT",      f_off_m, 0x37, 8, 7),
+	FNCN("GPIO_INT0",       f_off_m, 0x38, 0, 7),    /* 8x GPIO int. */
+	FNCN("GPIO_INT1",       f_off_m, 0x38, 8, 7),
+	FNCN("GPIO_INT2",       f_off_m, 0x39, 0, 7),
+	FNCN("GPIO_INT3",       f_off_m, 0x39, 8, 7),
+	FNCN("GPIO_INT4",       f_off_m, 0x3A, 0, 7),
+	FNCN("GPIO_INT5",       f_off_m, 0x3A, 8, 7),
+	FNCN("GPIO_INT6",       f_off_m, 0x3B, 0, 7),
+	FNCN("GPIO_INT7",       f_off_m, 0x3B, 8, 7),
+
+	/* MOON1 register */
+	FNCE("SPI_FLASH",       f_off_g, 0x01,  0, 2, sp7021grps_spif),
+	FNCE("SPI_FLASH_4BIT",  f_off_g, 0x01,  2, 2, sp7021grps_spi4),
+	FNCE("SPI_NAND",        f_off_g, 0x01,  4, 1, sp7021grps_snan),
+	FNCE("CARD0_EMMC",      f_off_g, 0x01,  5, 1, sp7021grps_emmc),
+	FNCE("SD_CARD",         f_off_g, 0x01,  6, 1, sp7021grps_sdsd),
+	FNCE("UA0",             f_off_g, 0x01,  7, 1, sp7021grps_uar0),
+	FNCE("ACHIP_DEBUG",     f_off_g, 0x01,  8, 2, sp7021grps_adbg),
+	FNCE("ACHIP_UA2AXI",    f_off_g, 0x01, 10, 2, sp7021grps_au2x),
+	FNCE("FPGA_IFX",        f_off_g, 0x01, 12, 1, sp7021grps_fpga),
+	FNCE("HDMI_TX",         f_off_g, 0x01, 13, 2, sp7021grps_hdmi),
+
+	FNCE("AUD_EXT_ADC_IFX0", f_off_g, 0x01, 15, 1, sp7021grps_eadc),
+	FNCE("AUD_EXT_DAC_IFX0", f_off_g, 0x02,  0, 1, sp7021grps_edac),
+	FNCE("SPDIF_RX",        f_off_g, 0x02,  2, 1, sp7021grps_spdi),
+	FNCE("SPDIF_TX",        f_off_g, 0x02,  3, 1, sp7021grps_spdo),
+	FNCE("TDMTX_IFX0",      f_off_g, 0x02,  4, 1, sp7021grps_tdmt),
+	FNCE("TDMRX_IFX0",      f_off_g, 0x02,  5, 1, sp7021grps_tdmr),
+	FNCE("PDMRX_IFX0",      f_off_g, 0x02,  6, 1, sp7021grps_pdmr),
+	FNCE("PCM_IEC_TX",      f_off_g, 0x02,  7, 1, sp7021grps_pcmt),
+	FNCE("LCDIF",           f_off_g, 0x04,  6, 1, sp7021grps_lcdi),
+	FNCE("DVD_DSP_DEBUG",   f_off_g, 0x02,  8, 1, sp7021grps_dvdd),
+	FNCE("I2C_DEBUG",       f_off_g, 0x02,  9, 1, sp7021grps_i2cd),
+	FNCE("I2C_SLAVE",       f_off_g, 0x02, 10, 1, sp7021grps_i2cs),
+	FNCE("WAKEUP",          f_off_g, 0x02, 11, 1, sp7021grps_wakp),
+	FNCE("UART2AXI",        f_off_g, 0x02, 12, 2, sp7021grps_u2ax),
+	FNCE("USB0_I2C",        f_off_g, 0x02, 14, 2, sp7021grps_u0ic),
+	FNCE("USB1_I2C",        f_off_g, 0x03,  0, 2, sp7021grps_u1ic),
+	FNCE("USB0_OTG",        f_off_g, 0x03,  2, 1, sp7021grps_u0ot),
+	FNCE("USB1_OTG",        f_off_g, 0x03,  3, 1, sp7021grps_u1ot),
+	FNCE("UPHY0_DEBUG",     f_off_g, 0x03,  4, 1, sp7021grps_up0d),
+	FNCE("UPHY1_DEBUG",     f_off_g, 0x03,  5, 1, sp7021grps_up1d),
+	FNCE("UPHY0_EXT",       f_off_g, 0x03,  6, 1, sp7021grps_upex),
+	FNCE("PROBE_PORT",      f_off_g, 0x03,  7, 2, sp7021grps_prbp),
+};
+
+const size_t sppctl_list_funcs_sz = ARRAY_SIZE(sppctl_list_funcs);
-- 
2.7.4

