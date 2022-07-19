Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE9557A2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiGSPOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbiGSPOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:14:40 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31BA545F0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:14:38 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g20-20020a9d6a14000000b0061c84e679f5so9227343otn.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lwrLoj/gsX8PV38VFaS+KpyLxwepep4eBGx1ozQcAj4=;
        b=Vl6qIyGbI+DdJS86cocejPMn5Da+eScp2l//VdMZdqJBXVmGT6alwLTZ+ZjuJhT6vw
         Kvl00zbJBokfAoDtLoaetNWLUT3aPEJwEGzR5+17v5RaJzDIN5ZaF2WaCNo7Qw25SGsr
         JGxiRIdHFAsgicUCt6UZfGsinij0eGi37GhY8mYzmuzZ4KQ/EeZ4Skf7CZPiGdSIJcNn
         IecuKW2UQc1fwj3JdNcTpmJ9LgaDaHxeU98JzB0tEwBgpcfKPhXgJVRR0tQRLwIbABjr
         ugeX9G6VsFOjFFXqT0EjJTtR+Oeofuwr0Bzojb0armPD8A1Naf85RLyv8gKUlHyXLFxZ
         AFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwrLoj/gsX8PV38VFaS+KpyLxwepep4eBGx1ozQcAj4=;
        b=weI/2EgDBnBiGE993a0mfY1ELUY2tSa8wRdVq231vNY33Ky8ephMTGom4aDPF7AvTf
         ooIaa5f9B2n20EWWUqZThmR635SIavbl1xxMxq5ZIZW3YQiC00Yyql3KegPAM+OaQdf5
         Olc+ktjztQQ9eMdRVYA2GxH22/FK1uMn1jierHsenOUDp2s7hV9iDqsjimtT8o5SEBJM
         HKw6ct/63/+24FPktVltTZUQicSlqxc4k/A1TusW2CXs+up+zq8y/6eQ1ARPl3IVMuYO
         MBMoc8JtANendFpBupE4pEhrVJ33xe1hiI0UKuh6re0iv11aYykNEqwhlmOS/8XDmeKi
         DE9g==
X-Gm-Message-State: AJIora9wBpjm9vi3td0aZv5HhETOoBrt8F3XEWpd5/V4r0dPssyDpyeL
        PLSiDCtObvPdiiqoHVXVBWidwg==
X-Google-Smtp-Source: AGRyM1t+1vLDKEYnjN1Vzm4CSYiS4+TDvoCO0gQcGCawmEA07f1O9f3G47+PkDttwfm5BBD8RY126Q==
X-Received: by 2002:a05:6830:209a:b0:61c:8167:7fc3 with SMTP id y26-20020a056830209a00b0061c81677fc3mr9707129otq.208.1658243677910;
        Tue, 19 Jul 2022 08:14:37 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id l24-20020a056830155800b0061c8bca21d8sm2334308otp.2.2022.07.19.08.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:14:37 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 3/6] gpio: i8255: Introduce the Intel 8255 interface library module
Date:   Tue, 19 Jul 2022 09:47:05 -0400
Message-Id: <8747727cba3e185c4906fd5dc3c9459d60c8dd31.1658236877.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1658236876.git.william.gray@linaro.org>
References: <cover.1658236876.git.william.gray@linaro.org>
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
index b01961999ced..d8e60e3fcf44 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -829,6 +829,18 @@ endmenu
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

