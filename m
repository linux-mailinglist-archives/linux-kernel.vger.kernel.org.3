Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B20F57B7BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiGTNq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiGTNqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:46:18 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD7357259
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:46:14 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g1so12853877qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4KtnYjVrkGGetCA5EGg8VtLpPVBjo70FhcQsFbEKhB8=;
        b=kEZM8unKk2r3n0oG3pJqZJ7j1tzFvEUfytKnkpHST259/0+Vj01kIizsT7jjEqjH2f
         fQGPyJpRAQS/0kxcHsnSwRAmXag8sF8bNSB9ZFCZuHtixGWTTcIw3V1WuzcKaZpLv91L
         2rYXbXFwEENovyG8yFVTITBY6v+8m5yHYtuQK4GI/ILvgO4tZNPpJqHwCiMaZCZEhgDU
         m+W8e4xTSqi88+vGLlC8/h6TrGE/uNp1rzXV18IPWkPAzw7SwW04UDZviuTZ3sq6O+aB
         Ycv3FcWww/GRjT5yejYZp/MSj7rfh//25Wc23Du4hgPsCgKXtQqQ7HRjCOsiJg0uUXRq
         jVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4KtnYjVrkGGetCA5EGg8VtLpPVBjo70FhcQsFbEKhB8=;
        b=aJmIvooMFyd3aoLLtGSz05gvXrUYykge4wC5BFaGoG8IZGS5FxD6H0mVqGIvE3RKYy
         75mDLzKwGqtlVe3ApEQNlaK8d7WuOX+wwAzvAaFQHHkniidhkusOpf8UDwgTqvdIwnj3
         kt41TRppuXf+rNHhRr3WBCvMShaPuL6+Yx0MDIE1UXYy+Ige258nNiFFff1nPxNLev9D
         HuI/EiX6sSlq07xFh3Y+IgjwCBekYdy068aeDs6OEvGWwqHP3syALcinIHLFy9lR7wvf
         8/CzK5o1Yb40e6d2UclG6cmiMyS7QqXCMmkov8hVpVMxdJTfVLQf1nLPRlm6vEBv9pwv
         pufA==
X-Gm-Message-State: AJIora/zePZBCqkOr4kfrJbeCbjyUnHedqiFoFQp0LVIFZITee6Y3+qW
        /2mqmpjWWbHJMIlh8WDc3Um2cg==
X-Google-Smtp-Source: AGRyM1uODid3TSsBVvhz9mffRFHxz/vzgNioj4PZBmBHD1H58AQqh7+pKBf/vkSR7Po9krBaBiCGGg==
X-Received: by 2002:a05:620a:2a0e:b0:6b3:583a:1031 with SMTP id o14-20020a05620a2a0e00b006b3583a1031mr24368629qkp.710.1658324773328;
        Wed, 20 Jul 2022 06:46:13 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bl13-20020a05620a1a8d00b006b5f8f32a8fsm5289853qkb.114.2022.07.20.06.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:46:13 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [RESEND PATCH v4 3/6] gpio: i8255: Introduce the Intel 8255 interface library module
Date:   Wed, 20 Jul 2022 09:45:59 -0400
Message-Id: <d1a24895f2ea67f689c24c34a20ddb43cd7246af.1658324498.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1658324498.git.william.gray@linaro.org>
References: <cover.1658324498.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exposes consumer library functions providing support for interfaces
compatible with the venerable Intel 8255 Programmable Peripheral
Interface (PPI).

The Intel 8255 PPI first appeared in the early 1970s, initially for the
Intel 8080 and later appearing in the original IBM-PC. The popularity of
the original Intel 8255 chip led to many subsequent variants and clones
of the interface in various chips and integrated circuits. Although
still popular, interfaces compatible with the Intel 8255 PPI are
nowdays typically found embedded in larger VLSI processing chips and
FPGA components rather than as discrete ICs.

A CONFIG_GPIO_I8255 Kconfig option is introduced by this patch. Modules
wanting access to these i8255 library functions should select this
Kconfig option, and import the I8255 symbol namespace.

Tested-by: Fred Eckert <Frede@cmslaser.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: John Hentges <jhentges@accesio.com>
Cc: Jay Dolan <jay.dolan@accesio.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v4:
 - Add note to CONFIG_GPIO_I8255 Kconfig that if built as a module the
   name will be 'gpio-i8255'
 - Remove 'const' from '__iomem' pointers
 - Replace ambiguous 'group' terminology with more understandable 'bank'
 - Use more natural '>= 4' expression to represent upper nibble
 - Refactor i8255_set_port() to take more common pattern of mask and
   bits

 MAINTAINERS               |   6 +
 drivers/gpio/Kconfig      |  12 ++
 drivers/gpio/Makefile     |   1 +
 drivers/gpio/gpio-i8255.c | 287 ++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-i8255.h |  46 ++++++
 5 files changed, 352 insertions(+)
 create mode 100644 drivers/gpio/gpio-i8255.c
 create mode 100644 drivers/gpio/gpio-i8255.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3405cb36cf02..960abc07304e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9902,6 +9902,12 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/i810/
 
+INTEL 8255 GPIO DRIVER
+M:	William Breathitt Gray <william.gray@linaro.org>
+L:	linux-gpio@vger.kernel.org
+S:	Maintained
+F:	drivers/gpio/gpio-i8255.c
+
 INTEL ASoC DRIVERS
 M:	Cezary Rojewski <cezary.rojewski@intel.com>
 M:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index cf6a2c745f3f..df484b72000d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -824,6 +824,18 @@ endmenu
 menu "Port-mapped I/O GPIO drivers"
 	depends on X86 # Unconditional I/O space access
 
+config GPIO_I8255
+	tristate
+	help
+	  Enables support for the i8255 interface library functions. The i8255
+	  interface library provides functions to facilitate communication with
+	  interfaces compatible with the venerable Intel 8255 Programmable
+	  Peripheral Interface (PPI). The Intel 8255 PPI chip was first released
+	  in the early 1970s but compatible interfaces are nowadays typically
+	  found embedded in larger VLSI processing chips and FPGA components.
+
+	  If built as a module its name will be gpio-i8255.
+
 config GPIO_104_DIO_48E
 	tristate "ACCES 104-DIO-48E GPIO support"
 	depends on PC104
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 9d4805b2b60b..a0985d30f51b 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_GPIO_GW_PLD)		+= gpio-gw-pld.o
 obj-$(CONFIG_GPIO_HISI)                 += gpio-hisi.o
 obj-$(CONFIG_GPIO_HLWD)			+= gpio-hlwd.o
 obj-$(CONFIG_HTC_EGPIO)			+= gpio-htc-egpio.o
+obj-$(CONFIG_GPIO_I8255)		+= gpio-i8255.o
 obj-$(CONFIG_GPIO_ICH)			+= gpio-ich.o
 obj-$(CONFIG_GPIO_IDT3243X)		+= gpio-idt3243x.o
 obj-$(CONFIG_GPIO_IOP)			+= gpio-iop.o
diff --git a/drivers/gpio/gpio-i8255.c b/drivers/gpio/gpio-i8255.c
new file mode 100644
index 000000000000..9b97db418df1
--- /dev/null
+++ b/drivers/gpio/gpio-i8255.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel 8255 Programmable Peripheral Interface
+ * Copyright (C) 2022 William Breathitt Gray
+ */
+#include <linux/bitmap.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "gpio-i8255.h"
+
+#define I8255_CONTROL_PORTC_LOWER_DIRECTION BIT(0)
+#define I8255_CONTROL_PORTB_DIRECTION BIT(1)
+#define I8255_CONTROL_PORTC_UPPER_DIRECTION BIT(3)
+#define I8255_CONTROL_PORTA_DIRECTION BIT(4)
+#define I8255_CONTROL_MODE_SET BIT(7)
+#define I8255_PORTA 0
+#define I8255_PORTB 1
+#define I8255_PORTC 2
+
+static int i8255_get_port(struct i8255 __iomem *const ppi,
+			  const unsigned long io_port, const unsigned long mask)
+{
+	const unsigned long bank = io_port / 3;
+	const unsigned long ppi_port = io_port % 3;
+
+	return ioread8(&ppi[bank].port[ppi_port]) & mask;
+}
+
+static u8 i8255_direction_mask(const unsigned long offset)
+{
+	const unsigned long port_offset = offset % 8;
+	const unsigned long io_port = offset / 8;
+	const unsigned long ppi_port = io_port % 3;
+
+	switch (ppi_port) {
+	case I8255_PORTA:
+		return I8255_CONTROL_PORTA_DIRECTION;
+	case I8255_PORTB:
+		return I8255_CONTROL_PORTB_DIRECTION;
+	case I8255_PORTC:
+		/* Port C can be configured by nibble */
+		if (port_offset >= 4)
+			return I8255_CONTROL_PORTC_UPPER_DIRECTION;
+		return I8255_CONTROL_PORTC_LOWER_DIRECTION;
+	default:
+		/* Should never reach this path */
+		return 0;
+	}
+}
+
+static void i8255_set_port(struct i8255 __iomem *const ppi,
+			   struct i8255_state *const state,
+			   const unsigned long io_port,
+			   const unsigned long mask, const unsigned long bits)
+{
+	const unsigned long bank = io_port / 3;
+	const unsigned long ppi_port = io_port % 3;
+	unsigned long flags;
+	unsigned long out_state;
+
+	spin_lock_irqsave(&state[bank].lock, flags);
+
+	out_state = ioread8(&ppi[bank].port[ppi_port]);
+	out_state = (out_state & ~mask) | (bits & mask);
+	iowrite8(out_state, &ppi[bank].port[ppi_port]);
+
+	spin_unlock_irqrestore(&state[bank].lock, flags);
+}
+
+/**
+ * i8255_direction_input - configure signal offset as input
+ * @ppi:	Intel 8255 Programmable Peripheral Interface banks
+ * @state:	devices states of the respective PPI banks
+ * @offset:	signal offset to configure as input
+ *
+ * Configures a signal @offset as input for the respective Intel 8255
+ * Programmable Peripheral Interface (@ppi) banks. The @state control_state
+ * values are updated to reflect the new configuration.
+ */
+void i8255_direction_input(struct i8255 __iomem *const ppi,
+			   struct i8255_state *const state,
+			   const unsigned long offset)
+{
+	const unsigned long io_port = offset / 8;
+	const unsigned long bank = io_port / 3;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state[bank].lock, flags);
+
+	state[bank].control_state |= I8255_CONTROL_MODE_SET;
+	state[bank].control_state |= i8255_direction_mask(offset);
+
+	iowrite8(state[bank].control_state, &ppi[bank].control);
+
+	spin_unlock_irqrestore(&state[bank].lock, flags);
+}
+EXPORT_SYMBOL_NS_GPL(i8255_direction_input, I8255);
+
+/**
+ * i8255_direction_output - configure signal offset as output
+ * @ppi:	Intel 8255 Programmable Peripheral Interface banks
+ * @state:	devices states of the respective PPI banks
+ * @offset:	signal offset to configure as output
+ * @value:	signal value to output
+ *
+ * Configures a signal @offset as output for the respective Intel 8255
+ * Programmable Peripheral Interface (@ppi) banks and sets the respective signal
+ * output to the desired @value. The @state control_state values are updated to
+ * reflect the new configuration.
+ */
+void i8255_direction_output(struct i8255 __iomem *const ppi,
+			    struct i8255_state *const state,
+			    const unsigned long offset,
+			    const unsigned long value)
+{
+	const unsigned long io_port = offset / 8;
+	const unsigned long bank = io_port / 3;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state[bank].lock, flags);
+
+	state[bank].control_state |= I8255_CONTROL_MODE_SET;
+	state[bank].control_state &= ~i8255_direction_mask(offset);
+
+	iowrite8(state[bank].control_state, &ppi[bank].control);
+
+	spin_unlock_irqrestore(&state[bank].lock, flags);
+
+	i8255_set(ppi, state, offset, value);
+}
+EXPORT_SYMBOL_NS_GPL(i8255_direction_output, I8255);
+
+/**
+ * i8255_get - get signal value at signal offset
+ * @ppi:	Intel 8255 Programmable Peripheral Interface banks
+ * @offset:	offset of signal to get
+ *
+ * Returns the signal value (0=low, 1=high) for the signal at @offset for the
+ * respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
+ */
+int i8255_get(struct i8255 __iomem *const ppi, const unsigned long offset)
+{
+	const unsigned long io_port = offset / 8;
+	const unsigned long offset_mask = BIT(offset % 8);
+
+	return !!i8255_get_port(ppi, io_port, offset_mask);
+}
+EXPORT_SYMBOL_NS_GPL(i8255_get, I8255);
+
+/**
+ * i8255_get_direction - get the I/O direction for a signal offset
+ * @state:	devices states of the respective PPI banks
+ * @offset:	offset of signal to get direction
+ *
+ * Returns the signal direction (0=output, 1=input) for the signal at @offset.
+ */
+int i8255_get_direction(const struct i8255_state *const state,
+			const unsigned long offset)
+{
+	const unsigned long io_port = offset / 8;
+	const unsigned long bank = io_port / 3;
+
+	return !!(state[bank].control_state & i8255_direction_mask(offset));
+}
+EXPORT_SYMBOL_NS_GPL(i8255_get_direction, I8255);
+
+/**
+ * i8255_get_multiple - get multiple signal values at multiple signal offsets
+ * @ppi:	Intel 8255 Programmable Peripheral Interface banks
+ * @mask:	mask of signals to get
+ * @bits:	bitmap to store signal values
+ * @ngpio:	number of GPIO signals of the respective PPI banks
+ *
+ * Stores in @bits the values (0=low, 1=high) for the signals defined by @mask
+ * for the respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
+ */
+void i8255_get_multiple(struct i8255 __iomem *const ppi,
+			const unsigned long *const mask,
+			unsigned long *const bits, const unsigned long ngpio)
+{
+	unsigned long offset;
+	unsigned long port_mask;
+	unsigned long io_port;
+	unsigned long port_state;
+
+	bitmap_zero(bits, ngpio);
+
+	for_each_set_clump8(offset, port_mask, mask, ngpio) {
+		io_port = offset / 8;
+		port_state = i8255_get_port(ppi, io_port, port_mask);
+
+		bitmap_set_value8(bits, port_state, offset);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(i8255_get_multiple, I8255);
+
+/**
+ * i8255_mode0_output - configure all PPI ports to MODE 0 output mode
+ * @ppi:	Intel 8255 Programmable Peripheral Interface bank
+ *
+ * Configures all Intel 8255 Programmable Peripheral Interface (@ppi) ports to
+ * MODE 0 (Basic Input/Output) output mode.
+ */
+void i8255_mode0_output(struct i8255 __iomem *const ppi)
+{
+	iowrite8(I8255_CONTROL_MODE_SET, &ppi->control);
+}
+EXPORT_SYMBOL_NS_GPL(i8255_mode0_output, I8255);
+
+/**
+ * i8255_set - set signal value at signal offset
+ * @ppi:	Intel 8255 Programmable Peripheral Interface banks
+ * @state:	devices states of the respective PPI banks
+ * @offset:	offset of signal to set
+ * @value:	value of signal to set
+ *
+ * Assigns output @value for the signal at @offset for the respective Intel 8255
+ * Programmable Peripheral Interface (@ppi) banks.
+ */
+void i8255_set(struct i8255 __iomem *const ppi, struct i8255_state *const state,
+	       const unsigned long offset, const unsigned long value)
+{
+	const unsigned long io_port = offset / 8;
+	const unsigned long port_offset = offset % 8;
+	const unsigned long mask = BIT(port_offset);
+	const unsigned long bits = value << port_offset;
+
+	i8255_set_port(ppi, state, io_port, mask, bits);
+}
+EXPORT_SYMBOL_NS_GPL(i8255_set, I8255);
+
+/**
+ * i8255_set_multiple - set signal values at multiple signal offsets
+ * @ppi:	Intel 8255 Programmable Peripheral Interface banks
+ * @state:	devices states of the respective PPI banks
+ * @mask:	mask of signals to set
+ * @bits:	bitmap of signal output values
+ * @ngpio:	number of GPIO signals of the respective PPI banks
+ *
+ * Assigns output values defined by @bits for the signals defined by @mask for
+ * the respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
+ */
+void i8255_set_multiple(struct i8255 __iomem *const ppi,
+			struct i8255_state *const state,
+			const unsigned long *const mask,
+			const unsigned long *const bits,
+			const unsigned long ngpio)
+{
+	unsigned long offset;
+	unsigned long port_mask;
+	unsigned long io_port;
+	unsigned long value;
+
+	for_each_set_clump8(offset, port_mask, mask, ngpio) {
+		io_port = offset / 8;
+		value = bitmap_get_value8(bits, offset);
+		i8255_set_port(ppi, state, io_port, port_mask, value);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(i8255_set_multiple, I8255);
+
+/**
+ * i8255_state_init - initialize i8255_state structure
+ * @state:	devices states of the respective PPI banks
+ * @nbanks:	number of Intel 8255 Programmable Peripheral Interface banks
+ *
+ * Initializes the @state of each Intel 8255 Programmable Peripheral Interface
+ * bank for use in i8255 library functions.
+ */
+void i8255_state_init(struct i8255_state *const state,
+		      const unsigned long nbanks)
+{
+	unsigned long bank;
+
+	for (bank = 0; bank < nbanks; bank++)
+		spin_lock_init(&state[bank].lock);
+}
+EXPORT_SYMBOL_NS_GPL(i8255_state_init, I8255);
+
+MODULE_AUTHOR("William Breathitt Gray");
+MODULE_DESCRIPTION("Intel 8255 Programmable Peripheral Interface");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-i8255.h b/drivers/gpio/gpio-i8255.h
new file mode 100644
index 000000000000..d9084aae9446
--- /dev/null
+++ b/drivers/gpio/gpio-i8255.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2022 William Breathitt Gray */
+#ifndef _I8255_H_
+#define _I8255_H_
+
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+/**
+ * struct i8255 - Intel 8255 register structure
+ * @port:	Port A, B, and C
+ * @control:	Control register
+ */
+struct i8255 {
+	u8 port[3];
+	u8 control;
+};
+
+/**
+ * struct i8255_state - Intel 8255 state structure
+ * @lock:		synchronization lock for accessing device state
+ * @control_state:	Control register state
+ */
+struct i8255_state {
+	spinlock_t lock;
+	u8 control_state;
+};
+
+void i8255_direction_input(struct i8255 __iomem *ppi, struct i8255_state *state,
+			   unsigned long offset);
+void i8255_direction_output(struct i8255 __iomem *ppi,
+			    struct i8255_state *state, unsigned long offset,
+			    unsigned long value);
+int i8255_get(struct i8255 __iomem *ppi, unsigned long offset);
+int i8255_get_direction(const struct i8255_state *state, unsigned long offset);
+void i8255_get_multiple(struct i8255 __iomem *ppi, const unsigned long *mask,
+			unsigned long *bits, unsigned long ngpio);
+void i8255_mode0_output(struct i8255 __iomem *const ppi);
+void i8255_set(struct i8255 __iomem *ppi, struct i8255_state *state,
+	       unsigned long offset, unsigned long value);
+void i8255_set_multiple(struct i8255 __iomem *ppi, struct i8255_state *state,
+			const unsigned long *mask, const unsigned long *bits,
+			unsigned long ngpio);
+void i8255_state_init(struct i8255_state *const state, unsigned long nbanks);
+
+#endif /* _I8255_H_ */
-- 
2.36.1

