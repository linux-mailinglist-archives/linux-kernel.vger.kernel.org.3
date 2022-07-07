Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9431656AEEB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiGGXQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiGGXQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:16:18 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE719675BA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:16:16 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10be0d7476aso20376993fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 16:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ael3to+pQw5kcMQjn9uyLd/aGdcqjP4ufwXWigGWHxA=;
        b=HyeCcX6zfK6ju/UZMlCfR3G3aJWHIFLO/qUunbC7r3xRAQHFGUyLqpXRPpgHA6v4BB
         TIAI4+U2VgOA5hJvi5+hVzLwlTur0Dif/cOWQoMaBoulErlejKxcJP3drjVKAR9+qnAz
         T6Rvw8z7ZcZLkHrSyFToTMAzoIeT+ubDoO9qpoYCBgv3wp6ua5hX0sXsaLpAWM33d4pQ
         QdBGm1oGDDBDc0fwxLOthSdHqmvLvFOhgqD0hjYuJya8uGefPHzxtxcO4yl3FvU40Wc2
         ZQJz08Xlq1uO5a7eFt+VEPWotaxCtuOMcUV4ZagZoaQxpA7/mXVqwtYBXHXhty/v6spm
         PrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ael3to+pQw5kcMQjn9uyLd/aGdcqjP4ufwXWigGWHxA=;
        b=eO7LTi1dWivYOmZji24afGZOu9Q2U3hwXg4QOZXyi6DfGYwL+8tBVRuoFN6ZoMYjmO
         U9kXY/EaiajJi4OS7r54Ab5JN64zJbo44oDzCP6hOuf3AoCBiVYWrv7v0aVciuTAseKL
         nWERvEWsT/CAVsMf9XQkPnI0kudJmtAH3xpV0iO/S2iGzJ+9Dkah5qZ+XmH4jgZCOknW
         9zVuudH4iC2xoiGH/lNtTIGRu32ufbhd33/yBYt7N+4HOAKxJimm2Dl/Rv7qF5Gt7ATX
         OQsu7TMre+FQ7GV0rcIfIPOum6PJqCZMiSoJ1teDbemopyLvLApKDMJ9mMg9RnRzh1cb
         9thQ==
X-Gm-Message-State: AJIora+7E3JcypmjeVgrNNha8+ZtTobOAsBK5HrBnF8moNvtgNtiLd3O
        8Wr6F7g4tWvkVQagmkV1gDpGoA==
X-Google-Smtp-Source: AGRyM1tlNmSH+B4wMw15/nh8eWfTqZLqfQBVqo7VMlmTROC9pe6veZ5fGU6Xoj6Mey5fT0e79FhFvQ==
X-Received: by 2002:a05:6871:611:b0:10c:4bc0:88b9 with SMTP id w17-20020a056871061100b0010c4bc088b9mr228790oan.81.1657235775988;
        Thu, 07 Jul 2022 16:16:15 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cg10-20020a056830630a00b006190efaf118sm2177606otb.66.2022.07.07.16.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:16:15 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v2 1/6] gpio: i8255: Introduce the i8255 module
Date:   Thu,  7 Jul 2022 14:10:03 -0400
Message-Id: <6be749842a4ad629c8697101f170dc7e425ae082.1657216200.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657216200.git.william.gray@linaro.org>
References: <cover.1657216200.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exposes consumer functions providing support for Intel 8255 Programmable
Peripheral Interface devices. A CONFIG_GPIO_I8255 Kconfig option is
introduced; modules wanting access to these functions should select this
Kconfig option.

Tested-by: Fred Eckert <Frede@cmslaser.com>
Cc: John Hentges <jhentges@accesio.com>
Cc: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 MAINTAINERS                |   6 +
 drivers/gpio/Kconfig       |   3 +
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-i8255.c  | 249 +++++++++++++++++++++++++++++++++++++
 include/linux/gpio/i8255.h |  34 +++++
 5 files changed, 293 insertions(+)
 create mode 100644 drivers/gpio/gpio-i8255.c
 create mode 100644 include/linux/gpio/i8255.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..c4ae792a8a43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9799,6 +9799,12 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/i810/
 
+INTEL 8255 GPIO DRIVER
+M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+L:	linux-gpio@vger.kernel.org
+S:	Maintained
+F:	drivers/gpio/gpio-i8255.c
+
 INTEL ASoC DRIVERS
 M:	Cezary Rojewski <cezary.rojewski@intel.com>
 M:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b01961999ced..5cbe93330213 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -829,6 +829,9 @@ endmenu
 menu "Port-mapped I/O GPIO drivers"
 	depends on X86 # Unconditional I/O space access
 
+config GPIO_I8255
+	tristate
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
index 000000000000..ef43312015f4
--- /dev/null
+++ b/drivers/gpio/gpio-i8255.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel 8255 Programmable Peripheral Interface
+ * Copyright (C) 2022 William Breathitt Gray
+ */
+#include <linux/bitmap.h>
+#include <linux/compiler_types.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/gpio/i8255.h>
+#include <linux/io.h>
+#include <linux/module.h>
+
+#define I8255_CONTROL_PORTCLOWER_DIRECTION BIT(0)
+#define I8255_CONTROL_PORTB_DIRECTION BIT(1)
+#define I8255_CONTROL_PORTCUPPER_DIRECTION BIT(3)
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
+		if (offset % 8 > 3)
+			return I8255_CONTROL_PORTCUPPER_DIRECTION;
+		return I8255_CONTROL_PORTCLOWER_DIRECTION;
+	default:
+		/* Should never reach this path */
+		return 0;
+	}
+}
+
+static void i8255_set_port(struct i8255 __iomem *const ppi,
+			   const unsigned long io_port,
+			   const unsigned long io_mask,
+			   const unsigned long bit_mask)
+{
+	const unsigned long group = io_port / 3;
+	const unsigned long ppi_port = io_port % 3;
+	unsigned long out_state;
+
+	out_state = ioread8(&ppi[group].port[ppi_port]);
+	out_state &= ~io_mask;
+	out_state |= bit_mask;
+
+	iowrite8(out_state, &ppi[group].port[ppi_port]);
+}
+
+/**
+ * i8255_direction_input - configure signal offset as input
+ * @ppi:		Intel 8255 Programmable Peripheral Interface groups
+ * @control_state:	control register states of the respective PPI groups
+ * @offset:		signal offset to configure as input
+ *
+ * Configures a signal @offset as input for the respective Intel 8255
+ * Programmable Peripheral Interface (@ppi) groups. The @control_state values
+ * are updated to reflect the new configuration.
+ */
+void i8255_direction_input(struct i8255 __iomem *const ppi,
+			   u8 *const control_state, const unsigned long offset)
+{
+	const unsigned long io_port = offset / 8;
+	const unsigned long group = io_port / 3;
+
+	control_state[group] |= I8255_CONTROL_MODE_SET;
+	control_state[group] |= i8255_direction_mask(offset);
+
+	iowrite8(control_state[group], &ppi[group].control);
+}
+EXPORT_SYMBOL_GPL(i8255_direction_input);
+
+/**
+ * i8255_direction_output - configure signal offset as output
+ * @control_state:	control register states of the respective PPI groups
+ * @ppi:		Intel 8255 Programmable Peripheral Interface groups
+ * @offset:		signal offset to configure as output
+ * @value:		signal value to output
+ *
+ * Configures a signal @offset as output for the respective Intel 8255
+ * Programmable Peripheral Interface (@ppi) groups and sets the respective
+ * signal output to the desired @value. The @control_state values are updated to
+ * reflect the new configuration.
+ */
+void i8255_direction_output(struct i8255 __iomem *const ppi,
+			    u8 *const control_state, const unsigned long offset,
+			    const unsigned long value)
+{
+	const unsigned long io_port = offset / 8;
+	const unsigned long group = io_port / 3;
+
+	control_state[group] |= I8255_CONTROL_MODE_SET;
+	control_state[group] &= ~i8255_direction_mask(offset);
+
+	iowrite8(control_state[group], &ppi[group].control);
+	i8255_set(ppi, offset, value);
+}
+EXPORT_SYMBOL_GPL(i8255_direction_output);
+
+/**
+ * i8255_get - get signal value at signal offset
+ * @ppi:		Intel 8255 Programmable Peripheral Interface groups
+ * @offset:		offset of signal to get
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
+EXPORT_SYMBOL_GPL(i8255_get);
+
+/**
+ * i8255_get_direction - get the I/O direction for a signal offset
+ * @control_state:	control register states of the respective PPI groups
+ * @offset:		offset of signal to get direction
+ *
+ * Returns the signal direction (0=output, 1=input) for the signal at @offset.
+ * groups.
+ */
+int i8255_get_direction(const u8 *const control_state,
+			const unsigned long offset)
+{
+	const unsigned long io_port = offset / 8;
+	const unsigned long group = io_port / 3;
+
+	return !!(control_state[group] & i8255_direction_mask(offset));
+}
+EXPORT_SYMBOL_GPL(i8255_get_direction);
+
+/**
+ * i8255_get_multiple - get multiple signal values at multiple signal offsets
+ * @ppi:		Intel 8255 Programmable Peripheral Interface groups
+ * @mask:		mask of signals to get
+ * @bits:		bitmap to store signal values
+ * @ngpio:		number of GPIO signals of the respective PPI groups
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
+EXPORT_SYMBOL_GPL(i8255_get_multiple);
+
+/**
+ * i8255_mode0_output - configure all PPI ports to MODE 0 output mode
+ * @ppi:		Intel 8255 Programmable Peripheral Interface group
+ *
+ * Configures all Intel 8255 Programmable Peripheral Interface (@ppi) ports to
+ * MODE 0 (Basic Input/Output) output mode.
+ */
+void i8255_mode0_output(struct i8255 __iomem *const ppi)
+{
+	iowrite8(I8255_CONTROL_MODE_SET, &ppi->control);
+}
+EXPORT_SYMBOL_GPL(i8255_mode0_output);
+
+/**
+ * i8255_set - set signal value at signal offset
+ * @ppi:		Intel 8255 Programmable Peripheral Interface groups
+ * @offset:		offset of signal to set
+ * @value:		value of signal to set
+ *
+ * Assigns output @value for the signal at @offset for the respective Intel 8255
+ * Programmable Peripheral Interface (@ppi) groups.
+ */
+void i8255_set(struct i8255 __iomem *const ppi, const unsigned long offset,
+	       const unsigned long value)
+{
+	const unsigned long io_port = offset / 8;
+	const unsigned long port_offset = offset % 8;
+	const unsigned long offset_mask = BIT(port_offset);
+	const unsigned long bit_mask = value << port_offset;
+
+	i8255_set_port(ppi, io_port, offset_mask, bit_mask);
+}
+EXPORT_SYMBOL_GPL(i8255_set);
+
+/**
+ * i8255_set_multiple - set signal values at multiple signal offsets
+ * @ppi:		Intel 8255 Programmable Peripheral Interface groups
+ * @mask:		mask of signals to set
+ * @bits:		bitmap of signal output values
+ * @ngpio:		number of GPIO signals of the respective PPI groups
+ *
+ * Assigns output values defined by @bits for the signals defined by @mask for
+ * the respective Intel 8255 Programmable Peripheral Interface (@ppi) groups.
+ */
+void i8255_set_multiple(struct i8255 __iomem *const ppi,
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
+		i8255_set_port(ppi, io_port, gpio_mask, bit_mask);
+	}
+}
+EXPORT_SYMBOL_GPL(i8255_set_multiple);
+
+MODULE_AUTHOR("William Breathitt Gray");
+MODULE_DESCRIPTION("Intel 8255 Programmable Peripheral Interface");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/gpio/i8255.h b/include/linux/gpio/i8255.h
new file mode 100644
index 000000000000..7ddcf7fcd1dd
--- /dev/null
+++ b/include/linux/gpio/i8255.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2022 William Breathitt Gray */
+#ifndef _I8255_H_
+#define _I8255_H_
+
+#include <linux/compiler_types.h>
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
+void i8255_direction_input(struct i8255 __iomem *ppi, u8 *control_state,
+			   unsigned long offset);
+void i8255_direction_output(struct i8255 __iomem *ppi, u8 *control_state,
+			    unsigned long offset, unsigned long value);
+int i8255_get(const struct i8255 __iomem *ppi, unsigned long offset);
+int i8255_get_direction(const u8 *control_state, unsigned long offset);
+void i8255_get_multiple(const struct i8255 __iomem *ppi,
+			const unsigned long *mask, unsigned long *bits,
+			unsigned long ngpio);
+void i8255_mode0_output(struct i8255 __iomem *const ppi);
+void i8255_set(struct i8255 __iomem *ppi, unsigned long offset,
+	       unsigned long value);
+void i8255_set_multiple(struct i8255 __iomem *ppi, const unsigned long *mask,
+			const unsigned long *bits, unsigned long ngpio);
+
+#endif /* _I8255_H_ */
-- 
2.36.1

