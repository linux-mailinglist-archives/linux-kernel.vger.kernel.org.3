Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B9C578C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiGRU5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbiGRU5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:57:00 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F2C326C5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:56:58 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r22-20020a056830419600b0061c6edc5dcfso10199576otu.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tgfjbTgtl1dCbXPRs9I+NiSr15sxa3t9DE28+0ROZqs=;
        b=PFqbMz+GrYV4yNTUfe7rQQPASOEb3SNbicX5qCBmjndPs05i64yGcXwYNlLOQcJeDd
         TTqYXE2yTb1AyKgbHZZ+D+0kYTn0wQLRgwTiusY6gZLGco2q9LBUXylS8nTc4SzHWwqS
         RWutROyv65sCU3cbEJaxt4otmShzZCQDjwd8dzi2U1uVVll759HImyLKuwHqd8QzwLsB
         l+6Zy3zAcdjNEb5At3ng0pdIShcZ3n+WpostBFSa7XuskffVw8Qbi/FdmyZDeSVFu4L0
         KhbCcrpECE6VRZCVvL4DjNeDs6uZt6q4qA2r94z1bcYWcVg7ZLAhiRR5Evtsl0c8o3jk
         zwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tgfjbTgtl1dCbXPRs9I+NiSr15sxa3t9DE28+0ROZqs=;
        b=fpqhps/4cswZIWhcLHd1/F9ka6nyp4Kn11uoicmaIeS2LsVQCtoHvyO4URKB0Wl4xu
         /fx1W6LewTrOWUKIaogNqqQ/m/7uji+y9mgn+wKKZ/7DMeo/0gGD/+YTy6OMLTfN1FI3
         QMbQu6DVcDdCjdkzHc6e3jtCz02Qsa/54Vd/AzlrxEBlVsX4bD7JlVUtx59YSZWyd/rk
         YMg5t6YUa9VrkgUNDaApmvF44EzqjqRvacNxrCaJjeCTAnPGu5ggtBplm+pJ4LKDCPLj
         pVM+5HZx+IiN/F2jqM7WiMlkd1V7W1cy2DrLKE3ALIeSCgthO0QHB1terPDFq+n5ryjU
         6YOA==
X-Gm-Message-State: AJIora9Z2BdJk8jNxoDQwumd5DaODZ7C2Wr3SIVVm9SOqNIQ93FCoAwY
        ILzP1LkqdwXMkJU+YY4kYCsz8w==
X-Google-Smtp-Source: AGRyM1tijNYbc38ZTwokknOjSY8nY52EyzX3TWJIy9v0jdr9auENCRkffYW4XEOJa6av1HYTE1YFpw==
X-Received: by 2002:a9d:4d89:0:b0:61c:a0cf:7426 with SMTP id u9-20020a9d4d89000000b0061ca0cf7426mr3093569otk.248.1658177817739;
        Mon, 18 Jul 2022 13:56:57 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id l8-20020a4ab2c8000000b0035eb4e5a6cbsm5252065ooo.33.2022.07.18.13.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:56:57 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v3 3/6] gpio: i8255: Introduce the Intel 8255 interface library module
Date:   Fri, 15 Jul 2022 14:52:25 -0400
Message-Id: <e0f9ff79a4229cf0ccce4844745453dae633a1aa.1657907849.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657907849.git.william.gray@linaro.org>
References: <cover.1657907849.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Cc: John Hentges <jhentges@accesio.com>
Cc: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v3:
 - Updated contact information in MAINTAINERS
 - Added help text for GPIO_I8255 Kconfig option
 - Move include/linux/gpio/i8255.h to drivers/gpio/gpio-i8255.h
 - Include "gpio-i8255.h" instead of <linux/gpio/i8255.h>
 - Include linux/types.h instead of linux/compiler_types.h
 - Add underscores for *PORTC_LOWER* and *PORTC_UPPER* defines
 - Move (offset % 8) expression to the local definition block of
   i8255_direction_mask() as port_offset const near the io_port
   definition; this should help optimize assembly instructions on some
   architectures
 - Implement an opaque i8255_state struct to organize and access i8255
   device states; this replaces the control_state array passed to
   various i8255 library functions in previous patchsets
 - Implement and provide a i8255_state_init() function to initialize the
   i8255_state struct for a consumer
 - Use a spinlock within i8255 library functions to protect access to
   i8255 states and synchronize I/O operations; a spinlock is used so
   that these functions may be used within an interrupt context
 - Export the i8255 library symbols within a new I8255 namespace

 MAINTAINERS               |   6 +
 drivers/gpio/Kconfig      |  10 ++
 drivers/gpio/Makefile     |   1 +
 drivers/gpio/gpio-i8255.c | 292 ++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-i8255.h |  47 ++++++
 5 files changed, 356 insertions(+)
 create mode 100644 drivers/gpio/gpio-i8255.c
 create mode 100644 drivers/gpio/gpio-i8255.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..cca3059639e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9799,6 +9799,12 @@ L:	linux-fbdev@vger.kernel.org
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
index b01961999ced..4074a41008a8 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -829,6 +829,16 @@ endmenu
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
 config GPIO_104_DIO_48E
 	tristate "ACCES 104-DIO-48E GPIO support"
 	depends on PC104
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 14352f6dfe8e..06057e127949 100644
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
index 000000000000..4bde56475fa5
--- /dev/null
+++ b/drivers/gpio/gpio-i8255.c
@@ -0,0 +1,292 @@
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
+static int i8255_get_port(const struct i8255 __iomem *const ppi,
+			  const unsigned long io_port, const unsigned long mask)
+{
+	const unsigned long group = io_port / 3;
+	const unsigned long ppi_port = io_port % 3;
+
+	return ioread8(&ppi[group].port[ppi_port]) & mask;
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
+		if (port_offset > 3)
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
+			   const unsigned long io_mask,
+			   const unsigned long bit_mask)
+{
+	const unsigned long group = io_port / 3;
+	const unsigned long ppi_port = io_port % 3;
+	unsigned long flags;
+	unsigned long out_state;
+
+	spin_lock_irqsave(&state[group].lock, flags);
+
+	out_state = ioread8(&ppi[group].port[ppi_port]);
+	out_state &= ~io_mask;
+	out_state |= bit_mask;
+
+	iowrite8(out_state, &ppi[group].port[ppi_port]);
+
+	spin_unlock_irqrestore(&state[group].lock, flags);
+}
+
+/**
+ * i8255_direction_input - configure signal offset as input
+ * @ppi:	Intel 8255 Programmable Peripheral Interface groups
+ * @state:	devices states of the respective PPI groups
+ * @offset:	signal offset to configure as input
+ *
+ * Configures a signal @offset as input for the respective Intel 8255
+ * Programmable Peripheral Interface (@ppi) groups. The @state control_state
+ * values are updated to reflect the new configuration.
+ */
+void i8255_direction_input(struct i8255 __iomem *const ppi,
+			   struct i8255_state *const state,
+			   const unsigned long offset)
+{
+	const unsigned long io_port = offset / 8;
+	const unsigned long group = io_port / 3;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state[group].lock, flags);
+
+	state[group].control_state |= I8255_CONTROL_MODE_SET;
+	state[group].control_state |= i8255_direction_mask(offset);
+
+	iowrite8(state[group].control_state, &ppi[group].control);
+
+	spin_unlock_irqrestore(&state[group].lock, flags);
+}
+EXPORT_SYMBOL_NS_GPL(i8255_direction_input, I8255);
+
+/**
+ * i8255_direction_output - configure signal offset as output
+ * @ppi:	Intel 8255 Programmable Peripheral Interface groups
+ * @state:	devices states of the respective PPI groups
+ * @offset:	signal offset to configure as output
+ * @value:	signal value to output
+ *
+ * Configures a signal @offset as output for the respective Intel 8255
+ * Programmable Peripheral Interface (@ppi) groups and sets the respective
+ * signal output to the desired @value. The @state control_state values are
+ * updated to reflect the new configuration.
+ */
+void i8255_direction_output(struct i8255 __iomem *const ppi,
+			    struct i8255_state *const state,
+			    const unsigned long offset,
+			    const unsigned long value)
+{
+	const unsigned long io_port = offset / 8;
+	const unsigned long group = io_port / 3;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state[group].lock, flags);
+
+	state[group].control_state |= I8255_CONTROL_MODE_SET;
+	state[group].control_state &= ~i8255_direction_mask(offset);
+
+	iowrite8(state[group].control_state, &ppi[group].control);
+
+	spin_unlock_irqrestore(&state[group].lock, flags);
+
+	i8255_set(ppi, state, offset, value);
+}
+EXPORT_SYMBOL_NS_GPL(i8255_direction_output, I8255);
+
+/**
+ * i8255_get - get signal value at signal offset
+ * @ppi:	Intel 8255 Programmable Peripheral Interface groups
+ * @offset:	offset of signal to get
+ *
+ * Returns the signal value (0=low, 1=high) for the signal at @offset for the
+ * respective Intel 8255 Programmable Peripheral Interface (@ppi) groups.
+ */
+int i8255_get(const struct i8255 __iomem *const ppi, const unsigned long offset)
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
+ * @state:	devices states of the respective PPI groups
+ * @offset:	offset of signal to get direction
+ *
+ * Returns the signal direction (0=output, 1=input) for the signal at @offset.
+ * groups.
+ */
+int i8255_get_direction(const struct i8255_state *const state,
+			const unsigned long offset)
+{
+	const unsigned long io_port = offset / 8;
+	const unsigned long group = io_port / 3;
+
+	return !!(state[group].control_state & i8255_direction_mask(offset));
+}
+EXPORT_SYMBOL_NS_GPL(i8255_get_direction, I8255);
+
+/**
+ * i8255_get_multiple - get multiple signal values at multiple signal offsets
+ * @ppi:	Intel 8255 Programmable Peripheral Interface groups
+ * @mask:	mask of signals to get
+ * @bits:	bitmap to store signal values
+ * @ngpio:	number of GPIO signals of the respective PPI groups
+ *
+ * Stores in @bits the values (0=low, 1=high) for the signals defined by @mask
+ * for the respective Intel 8255 Programmable Peripheral Interface (@ppi)
+ * groups.
+ */
+void i8255_get_multiple(const struct i8255 __iomem *const ppi,
+			const unsigned long *const mask,
+			unsigned long *const bits, const unsigned long ngpio)
+{
+	unsigned long offset;
+	unsigned long gpio_mask;
+	unsigned long io_port;
+	unsigned long port_state;
+
+	bitmap_zero(bits, ngpio);
+
+	for_each_set_clump8(offset, gpio_mask, mask, ngpio) {
+		io_port = offset / 8;
+		port_state = i8255_get_port(ppi, io_port, gpio_mask);
+
+		bitmap_set_value8(bits, port_state, offset);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(i8255_get_multiple, I8255);
+
+/**
+ * i8255_mode0_output - configure all PPI ports to MODE 0 output mode
+ * @ppi:	Intel 8255 Programmable Peripheral Interface group
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
+ * @ppi:	Intel 8255 Programmable Peripheral Interface groups
+ * @state:	devices states of the respective PPI groups
+ * @offset:	offset of signal to set
+ * @value:	value of signal to set
+ *
+ * Assigns output @value for the signal at @offset for the respective Intel 8255
+ * Programmable Peripheral Interface (@ppi) groups.
+ */
+void i8255_set(struct i8255 __iomem *const ppi, struct i8255_state *const state,
+	       const unsigned long offset, const unsigned long value)
+{
+	const unsigned long io_port = offset / 8;
+	const unsigned long port_offset = offset % 8;
+	const unsigned long offset_mask = BIT(port_offset);
+	const unsigned long bit_mask = value << port_offset;
+
+	i8255_set_port(ppi, state, io_port, offset_mask, bit_mask);
+}
+EXPORT_SYMBOL_NS_GPL(i8255_set, I8255);
+
+/**
+ * i8255_set_multiple - set signal values at multiple signal offsets
+ * @ppi:	Intel 8255 Programmable Peripheral Interface groups
+ * @state:	devices states of the respective PPI groups
+ * @mask:	mask of signals to set
+ * @bits:	bitmap of signal output values
+ * @ngpio:	number of GPIO signals of the respective PPI groups
+ *
+ * Assigns output values defined by @bits for the signals defined by @mask for
+ * the respective Intel 8255 Programmable Peripheral Interface (@ppi) groups.
+ */
+void i8255_set_multiple(struct i8255 __iomem *const ppi,
+			struct i8255_state *const state,
+			const unsigned long *const mask,
+			const unsigned long *const bits,
+			const unsigned long ngpio)
+{
+	unsigned long offset;
+	unsigned long gpio_mask;
+	unsigned long bit_mask;
+	unsigned long io_port;
+
+	for_each_set_clump8(offset, gpio_mask, mask, ngpio) {
+		bit_mask = bitmap_get_value8(bits, offset) & gpio_mask;
+		io_port = offset / 8;
+		i8255_set_port(ppi, state, io_port, gpio_mask, bit_mask);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(i8255_set_multiple, I8255);
+
+/**
+ * i8255_state_init - initialize i8255_state structure
+ * @state:	devices states of the respective PPI groups
+ * @ngroups:	number of Intel 8255 Programmable Peripheral Interface groups
+ *
+ * Initializes the @state of each Intel 8255 Programmable Peripheral Interface
+ * group for use in i8255 library functions.
+ */
+void i8255_state_init(struct i8255_state *const state,
+		      const unsigned long ngroups)
+{
+	unsigned long group;
+
+	for (group = 0; group < ngroups; group++)
+		spin_lock_init(&state[group].lock);
+}
+EXPORT_SYMBOL_NS_GPL(i8255_state_init, I8255);
+
+MODULE_AUTHOR("William Breathitt Gray");
+MODULE_DESCRIPTION("Intel 8255 Programmable Peripheral Interface");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-i8255.h b/drivers/gpio/gpio-i8255.h
new file mode 100644
index 000000000000..b2bfe0ecb301
--- /dev/null
+++ b/drivers/gpio/gpio-i8255.h
@@ -0,0 +1,47 @@
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
+int i8255_get(const struct i8255 __iomem *ppi, unsigned long offset);
+int i8255_get_direction(const struct i8255_state *state, unsigned long offset);
+void i8255_get_multiple(const struct i8255 __iomem *ppi,
+			const unsigned long *mask, unsigned long *bits,
+			unsigned long ngpio);
+void i8255_mode0_output(struct i8255 __iomem *const ppi);
+void i8255_set(struct i8255 __iomem *ppi, struct i8255_state *state,
+	       unsigned long offset, unsigned long value);
+void i8255_set_multiple(struct i8255 __iomem *ppi, struct i8255_state *state,
+			const unsigned long *mask, const unsigned long *bits,
+			unsigned long ngpio);
+void i8255_state_init(struct i8255_state *const state, unsigned long ngroups);
+
+#endif /* _I8255_H_ */
-- 
2.36.1

