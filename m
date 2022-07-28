Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E469583B11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbiG1JRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiG1JRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:17:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D66E61B3A;
        Thu, 28 Jul 2022 02:17:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ss3so2071103ejc.11;
        Thu, 28 Jul 2022 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34OXkZVhoqWAk9RLgGkdSxH/V2AFOl8zRtvbTJiSsxM=;
        b=EXekWpYH7uzm6Pu2+N8kFwzds4pAv86cqGy5pL5gvt6Qh3eFCXhdCmMmqwff8Hz3a7
         aW1kj1yn/XfannrcZMgiixqayG4xCxxNkZEVkDzIkP0t8sFT4Xrwq0PAV2dG46OpfUcY
         Gqu+UvjzWtxEIUKgWzIvyE2Blng/qysCeRU87xvYndpOeXzYKUVu9Au3TDsVcXAKaCv4
         7NKyZoPbp3khjXVPO4rqV2nP74qo8tD+xTiGtRCwDOP8ODumqi/lx8P2CkJshbeRy/gI
         xlMTq4qbmHXl2sZvriYe2G94kecCFD7sEbJbhe+AvoIC2F47bda+0sfv9bTQXkFszoVv
         srBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34OXkZVhoqWAk9RLgGkdSxH/V2AFOl8zRtvbTJiSsxM=;
        b=HTwXxv9NAYus99JBv1siUw6qiO2q7YiATBwb9BWHqARH8XbPXXUICep+VP7TD+A1Z+
         E+kfpTQZDbXFHgnEuUXojmgL9gApwCOYbWhrI8M2PEgtlhp39ajTHsYrzmLzoJweiYjC
         wKVTc7Wo1BFlxxVVWw4+CEe3ZdqPn6A1HZIhGrgaDlmx0lbRPt98rwfGJppGFFud7FES
         FMh/qEspsVZBb0PbsFo5AWY74DR97Qyy1ounmGTGGAAM1KSzAVKCK5TrEuCSJZnazI34
         MsNht82Zxo76e3VIlx5Mgv2RCgjYCDZCOoR6irtlTpwonovJcn71m5DvEz2uWQdR0VVH
         PJxg==
X-Gm-Message-State: AJIora+zG2xJVTy2GZ5nQc8WEKGkzWIE1FuIoF/8RInYMqX/9raNMe31
        8HMxssCYRJ36MhxAGnqmn5wy6N1WIrxX2qiAm30=
X-Google-Smtp-Source: AGRyM1u4i0fYnviY9iJyCQ2P+E5WUeDci1KoD7HDVnmZIrsLB25arRYSNWD0wT55cg0joN1kRwBPBA==
X-Received: by 2002:a17:906:9be0:b0:72b:4600:e9ce with SMTP id de32-20020a1709069be000b0072b4600e9cemr20461046ejc.224.1658999850075;
        Thu, 28 Jul 2022 02:17:30 -0700 (PDT)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709062f1700b0072ff4515792sm195760eji.54.2022.07.28.02.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 02:17:29 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mani@kernel.org,
        hemantk@codeaurora.org, elder@linaro.org, f.fainelli@gmail.com,
        linus.walleij@linaro.org, Michael.Srba@seznam.cz,
        jeffrey.l.hugo@gmail.com, gregkh@linuxfoundation.org,
        bjorn.andersson@linaro.org, saravanak@google.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCH RFC v1 1/2] bus: add Wiegand write-only GPIO driver
Date:   Thu, 28 Jul 2022 11:17:11 +0200
Message-Id: <20220728091712.13395-1-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wiegand is a communication protocol that is still widely used
especially for access control applications. It utilizes two wires to
transmit data - D0 and D1, the generic names of which are data-lo and
data-hi.

Both data lines are initially pulled up. To send a bit of value 1, the
D1 line is set low. Similarly to send a bit of value 0, the D0 line is
set low. Standard Wiegand formats include 26, 36 and 37 bit and they
reserve the first and last bits for parity. The first(MSB) parity bit
is set to 1 if the parity of the first half of the payload is odd. The
last(LSB) parity bit is set to 1 if the parity of the second half of
the payload even.

The driver currently supports the 3 standard formats - 26, 36 and 37
bits. When one of these formats is used, it automatically calculates
the values of parity bits and appends them to the messages. It also
offers to set a custom format. Using a custom format, the user is
responsible for setting the parity bits. The driver offers setting of
the following sysfs attributes:

	pulse_len - length of the low pulse in usec; defaults to 50us
	interval_len - length of a whole bit(pulse_len + high phase)
	in usec; defaults to 50us
	frame_gap - length of the last bit of a frame(pulse_len +
	high phase); defaults to interval_len
	format - valid values are 0 for custom, 26, 36, 37
	custom_payload_len - can be set when using a custom format(0);
	0 means all bits of a message will be sent

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
The driver was tested on NXP Verdin iMX8MP Plus.

I would like to kindly ask a few questions:
1. Is debug printing of the data being transmitted a valid thing to do?
Wiegand could potentially be used to transmit sensitive data which
might get exposed by the debug mode.
2. The part of the code, where sysfs files are being created does not
currently contain freeing of the ones already created on an error. Is
it better to use goto jumps to free them and exit, or let the driver
run without some of the attribute files?

If you have any suggestions to make this patch better, please let me
know, I am eager to learn. I am very much new to this field, so any
feedback will be aprreciated.
---
 MAINTAINERS                |   6 +
 drivers/bus/Kconfig        |  10 +
 drivers/bus/Makefile       |   1 +
 drivers/bus/wiegand-gpio.c | 661 +++++++++++++++++++++++++++++++++++++
 drivers/bus/wiegand-gpio.h |  54 +++
 5 files changed, 732 insertions(+)
 create mode 100644 drivers/bus/wiegand-gpio.c
 create mode 100644 drivers/bus/wiegand-gpio.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..9a519530e44e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21586,6 +21586,12 @@ L:	linux-rtc@vger.kernel.org
 S:	Maintained
 F:	drivers/rtc/rtc-sd3078.c
 
+WIEGAND WRITE-ONLY GPIO DRIVER
+M:	Martin Zaťovič <m.zatovic1@gmail.com>
+S:	Maintained
+F:	drivers/bus/wiegand-gpio.c
+F:	drivers/bus/wiegand-gpio.h
+
 WIIMOTE HID DRIVER
 M:	David Rheinsberg <david.rheinsberg@gmail.com>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 7bfe998f3514..f7c7d3b24710 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -231,6 +231,16 @@ config UNIPHIER_SYSTEM_BUS
 	  Support for UniPhier System Bus, a simple external bus.  This is
 	  needed to use on-board devices connected to UniPhier SoCs.
 
+config WIEGAND_GPIO
+    tristate "GPIO-based wiegand master (write only)"
+    depends on OF_GPIO
+    help
+      Say y here to enable a driver which uses GPIO pins to send
+      Wiegand data. Say m to build it as module. Say n to disable
+      building. The driver utilizes two data lines that need to be
+      defined as outputs in the device tree - wiegand-data-hi and
+      wiegand-data-lo.
+
 config VEXPRESS_CONFIG
 	tristate "Versatile Express configuration bus"
 	default y if ARCH_VEXPRESS
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index d90eed189a65..cc21530a441f 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_TI_SYSC)		+= ti-sysc.o
 obj-$(CONFIG_TS_NBUS)		+= ts-nbus.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
+obj-$(CONFIG_WIEGAND_GPIO)	+= wiegand-gpio.o
 
 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
 
diff --git a/drivers/bus/wiegand-gpio.c b/drivers/bus/wiegand-gpio.c
new file mode 100644
index 000000000000..ae4f36c7d96b
--- /dev/null
+++ b/drivers/bus/wiegand-gpio.c
@@ -0,0 +1,661 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Wiegand write-only GPIO driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/cdev.h>
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/gpio/consumer.h>
+
+#include "wiegand-gpio.h"
+
+static dev_t base_devno;
+static int max_devices = 1;
+static struct class *wiegand_gpio_cl;
+
+struct wiegand_gpio_device {
+	struct device *dev;
+	struct cdev cdev;
+	struct mutex mutex;
+	int flags;
+	struct gpio_desc *gpio_data_hi;
+	struct gpio_desc *gpio_data_lo;
+	struct wiegand_setup setup;
+	uint8_t data[WIEGAND_MAX_PAYLEN_BYTES];
+};
+
+struct wiegand_gpio_instance {
+	struct wiegand_gpio_device *dev;
+	unsigned long flags;
+};
+
+static const struct wiegand_setup WIEGAND_SETUP = {
+	.pulse_len	= 50,
+	.interval_len	= 2000,
+	.frame_gap	= 2000,
+	.format		= WIEGAND_V26,
+	.payload_len	= 24,
+};
+
+/*
+ * To send a bit of value 1 following the wiegand protocol, one must set
+ * the wiegand_data_hi to low for the duration of pulse. Similarly to send
+ * a bit of value 0, the wiegand_data_lo is set to low for pulse duration.
+ * This way the two lines are never low ar the same time.
+ */
+void wiegand_gpio_send_bit(struct wiegand_gpio_device *wiegand_gpio,
+				bool value, bool last)
+{
+	struct wiegand_setup *setup = &wiegand_gpio->setup;
+	struct gpio_desc *gpio = value ? wiegand_gpio->gpio_data_hi
+				: wiegand_gpio->gpio_data_lo;
+
+	gpiod_set_value_cansleep(gpio, 0);
+	udelay(setup->pulse_len);
+	gpiod_set_value_cansleep(gpio, 1);
+
+	if (last)
+		udelay(setup->frame_gap - setup->pulse_len);
+	else
+		udelay(setup->interval_len - setup->pulse_len);
+}
+
+static int wiegand_gpio_write_by_bits(struct wiegand_gpio_device *wiegand_gpio,
+				size_t len)
+{
+	size_t i, bitlen;
+	bool bit_value, is_last_bit;
+	struct wiegand_setup *setup = &wiegand_gpio->setup;
+
+	bitlen = setup->format ? setup->payload_len + 2 : setup->payload_len;
+
+	for (i = 0; i < bitlen; i++) {
+		bit_value = ((wiegand_gpio->data[i / 8] >> (7 - (i % 8)))
+									& 0x01);
+		is_last_bit = (i + 1) == bitlen;
+
+		wiegand_gpio_send_bit(wiegand_gpio, (bool)bit_value,
+				is_last_bit);
+	}
+
+	return 0;
+}
+
+static unsigned int wiegand_gpio_calc_bytes(unsigned int bits)
+{
+	if (bits % 8 != 0)
+		return (bits / 8) + 1;
+	else
+		return bits / 8;
+}
+
+static unsigned int wiegand_gpio_get_payload_size(
+						unsigned long payload_len_bits,
+						enum wiegand_format fmt)
+{
+	unsigned int ret;
+
+	if (fmt == WIEGAND_CUSTOM)
+		ret = wiegand_gpio_calc_bytes(payload_len_bits);
+	else
+		/* add 2 for parity bits */
+		ret = wiegand_gpio_calc_bytes(payload_len_bits + 2);
+
+	return ret;
+}
+
+static int wiegand_gpio_calc_parity8(uint8_t v)
+{
+	v = (v >> 4) ^ (v & ((1 << 4)-1));
+	v = (v >> 2) ^ (v & ((1 << 2)-1));
+	v = (v >> 1) ^ (v & ((1 << 1)-1));
+	return v;
+}
+
+static void wiegand_gpio_add_parity_to_data(unsigned char *tmp, uint8_t *data,
+						enum wiegand_format fmt)
+{
+	switch (fmt) {
+	case WIEGAND_V26:
+		data[0] = (tmp[0] >> 1) | (wiegand_gpio_calc_parity8(
+						tmp[0] ^ (tmp[1] & 0xf0)) << 7);
+		data[1] = (tmp[0] << 7) | (tmp[1] >> 1);
+		data[2] = (tmp[1] << 7) | (tmp[2] >> 1);
+		data[3] = (tmp[2] << 7) | (!wiegand_gpio_calc_parity8(
+						(tmp[1] & 0x0f) ^ tmp[2]) << 6);
+
+#ifdef DEBUG
+		printk(KERN_DEBUG
+			"%s: d[%02x,%02x,%02x] -> w[%02x,%02x,%02x,%02x]\n",
+			__func__,
+			tmp[0], tmp[1], tmp[2],
+			data[0], data[1],
+			data[2], data[3]);
+#endif
+		break;
+	case WIEGAND_V36:
+		tmp[4] &= 0xc0;
+
+		data[0] = (tmp[0] >> 1) | (wiegand_gpio_calc_parity8(
+				tmp[0] ^ tmp[1] ^ (tmp[2] & 0x80)) << 7);
+		data[1] = (tmp[0] << 7) | (tmp[1] >> 1);
+		data[2] = (tmp[1] << 7) | (tmp[2] >> 1);
+		data[3] = (tmp[2] << 7) | (tmp[3] >> 1);
+		data[4] = (tmp[3] << 7) | (tmp[4] >> 1) |
+			(!wiegand_gpio_calc_parity8(
+				(tmp[2] & 0x7f) ^ tmp[3] ^ tmp[4]) << 4);
+
+#ifdef DEBUG
+		printk(KERN_DEBUG
+			"%s: d[%02x,%02x,%02x,%02x,%02x] -> w[%02x,%02x,%02x,%02x,%02x]\n",
+			__func__,
+			tmp[0], tmp[1], tmp[2], tmp[3], tmp[4],
+			data[0], data[1],
+			data[2], data[3], data[4]);
+#endif
+		break;
+	case WIEGAND_V37:
+		tmp[4] &= 0xe0;
+
+		data[0] = (tmp[0] >> 1) | (wiegand_gpio_calc_parity8(
+				tmp[0] ^ tmp[1] ^ (tmp[2] & 0xc0)) << 7);
+		data[1] = (tmp[0] << 7) | (tmp[1] >> 1);
+		data[2] = (tmp[1] << 7) | (tmp[2] >> 1);
+		data[3] = (tmp[2] << 7) | (tmp[3] >> 1);
+		data[4] = (tmp[3] << 7) | (tmp[4] >> 1) |
+				(!wiegand_gpio_calc_parity8(
+				(tmp[2] & 0x7f) ^ tmp[3] ^ tmp[4]) << 3);
+
+#ifdef DEBUG
+		printk(KERN_DEBUG
+			"%s: d[%02x,%02x,%02x,%02x,%02x] -> w[%02x,%02x,%02x,%02x,%02x]\n",
+			__func__,
+			tmp[0], tmp[1], tmp[2], tmp[3], tmp[4],
+			data[0], data[1],
+			data[2], data[3], data[4]);
+#endif
+		break;
+	default:
+		WARN_ON(fmt != WIEGAND_V37 &&
+			fmt != WIEGAND_V36 &&
+			fmt != WIEGAND_V26);
+	}
+}
+
+static ssize_t wiegand_gpio_get_user_data(
+				struct wiegand_gpio_device *wiegand_gpio,
+				char __user const *buf, size_t len)
+{
+	size_t rc;
+	size_t num_copy;
+	unsigned char tmp[WIEGAND_MAX_PAYLEN_BYTES];
+	struct wiegand_setup *setup = &wiegand_gpio->setup;
+
+	num_copy = wiegand_gpio_get_payload_size(setup->payload_len,
+								setup->format);
+
+	if (setup->format == WIEGAND_CUSTOM) {
+		rc = copy_from_user(&wiegand_gpio->data[0], buf, num_copy);
+		if (rc < 0)
+			return rc;
+	} else {
+		rc = copy_from_user(tmp, buf, num_copy);
+		if (rc < 0)
+			return rc;
+		wiegand_gpio_add_parity_to_data(tmp, wiegand_gpio->data,
+								setup->format);
+	}
+	return num_copy;
+}
+
+static int wiegand_gpio_release(struct inode *ino, struct file *filp)
+{
+	struct wiegand_gpio_instance *info = filp->private_data;
+	struct wiegand_gpio_device *wiegand_gpio = info->dev;
+
+	mutex_lock(&wiegand_gpio->mutex);
+	wiegand_gpio->flags = 0;
+	mutex_unlock(&wiegand_gpio->mutex);
+
+	kfree(info);
+
+	return 0;
+}
+
+static ssize_t wiegand_gpio_write(struct file *filp,
+		char __user const *buf, size_t len, loff_t *offset)
+{
+	struct wiegand_gpio_instance *info = filp->private_data;
+	struct wiegand_gpio_device *wiegand_gpio = info->dev;
+	int rc;
+
+	if (len * 8 < wiegand_gpio->setup.payload_len)
+		return -EBADMSG;
+	if (buf == NULL || len == 0)
+		return -EINVAL;
+
+	wiegand_gpio_get_user_data(wiegand_gpio, buf, len);
+	rc = wiegand_gpio_write_by_bits(wiegand_gpio, len);
+
+	return len;
+}
+
+static int wiegand_gpio_open(struct inode *ino, struct file *filp)
+{
+	struct wiegand_gpio_device *wiegand_gpio;
+	struct wiegand_gpio_instance *info;
+	int rc;
+
+	wiegand_gpio = container_of(ino->i_cdev,
+			struct wiegand_gpio_device, cdev);
+
+	mutex_lock(&wiegand_gpio->mutex);
+
+	/* Only one device instance allowed */
+	if (wiegand_gpio->flags) {
+		dev_dbg(wiegand_gpio->dev,
+			"Device already open for writing\n");
+		rc = -EBUSY;
+		goto err;
+	}
+
+	if ((filp->f_flags & O_ACCMODE) == O_RDONLY ||
+		(filp->f_flags & O_ACCMODE) == O_RDWR) {
+		dev_err(wiegand_gpio->dev, "Device is write only\n");
+		rc = -EIO;
+		goto err;
+	}
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	gpiod_direction_output(wiegand_gpio->gpio_data_hi, 1);
+	gpiod_direction_output(wiegand_gpio->gpio_data_lo, 1);
+
+	info->dev = wiegand_gpio;
+	info->flags = filp->f_flags;
+	wiegand_gpio->flags = filp->f_flags;
+
+	mutex_unlock(&wiegand_gpio->mutex);
+
+	filp->private_data = info;
+
+	return 0;
+err:
+	wiegand_gpio->flags = 0;
+	mutex_unlock(&wiegand_gpio->mutex);
+
+	return rc;
+}
+
+const struct file_operations wiegand_gpio_fops = {
+	.owner		= THIS_MODULE,
+	.open		= wiegand_gpio_open,
+	.release	= wiegand_gpio_release,
+	.write		= wiegand_gpio_write,
+};
+
+static ssize_t store_ulong(unsigned long *val, const char *buf,
+				size_t size, unsigned long max)
+{
+	int ret;
+	unsigned long new;
+
+	ret = kstrtoul(buf, 0, &new);
+	if (ret)
+		return ret;
+	if (max != 0 && new > max)
+		return -EINVAL;
+
+	*val = new;
+	return size;
+}
+
+/* sysfs functions */
+static ssize_t show_ulong(unsigned long val, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%lu\n", val);
+}
+
+ssize_t pulse_len_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return show_ulong(device->setup.pulse_len, buf);
+}
+
+ssize_t pulse_len_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return store_ulong(&(device->setup.pulse_len), buf, count, 0);
+}
+
+ssize_t interval_len_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return show_ulong(device->setup.interval_len, buf);
+}
+
+ssize_t interval_len_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return store_ulong(&(device->setup.interval_len), buf, count, 0);
+}
+
+ssize_t frame_gap_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return show_ulong(device->setup.frame_gap, buf);
+}
+
+ssize_t frame_gap_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return store_ulong(&(device->setup.frame_gap), buf, count, 0);
+}
+
+ssize_t format_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return show_ulong(device->setup.format, buf);
+}
+
+/*
+ * To set a particular format, the number of bits the driver is supposed to
+ * transmit is written to the format sysfs file. For standard formats, the
+ * allowed inputs are 26, 36 and 37. To set a custom format, 0 is passed.
+ */
+ssize_t format_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	int ret;
+	unsigned long new;
+	enum wiegand_format *val;
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	val = &(device->setup.format);
+
+	ret = kstrtoul(buf, 0, &new);
+	if (ret)
+		return ret;
+
+	switch (new) {
+	case 0:
+		*val = WIEGAND_CUSTOM;
+		break;
+	case 26:
+		*val = WIEGAND_V26;
+		device->setup.payload_len = WIEGAND_V26_PAYLEN;
+		break;
+	case 36:
+		*val = WIEGAND_V36;
+		device->setup.payload_len = WIEGAND_V36_PAYLEN;
+		break;
+	case 37:
+		*val = WIEGAND_V37;
+		device->setup.payload_len = WIEGAND_V37_PAYLEN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+/*
+ * Using a custom format, the payload_len sysfs file configures the size of
+ * messages payload in bits. When one of the standard formats is used, this
+ * file is read-only and contains the size of the message in bits without the
+ * parity bits.
+ */
+ssize_t payload_len_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	return show_ulong(device->setup.payload_len, buf);
+}
+
+ssize_t payload_len_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct wiegand_gpio_device *device = dev_get_drvdata(dev);
+
+	if (!device)
+		return -ENODEV;
+
+	/* standard formats use fixed payload size */
+	if (device->setup.format != WIEGAND_CUSTOM)
+		return -EPERM;
+
+	return store_ulong(&(device->setup.payload_len), buf, count,
+					WIEGAND_MAX_PAYLEN_BYTES * 8);
+}
+
+DEVICE_ATTR_RW(pulse_len);
+DEVICE_ATTR_RW(interval_len);
+DEVICE_ATTR_RW(frame_gap);
+DEVICE_ATTR_RW(format);
+DEVICE_ATTR_RW(payload_len);
+
+static int wiegand_gpio_dev_probe(struct platform_device *pdev)
+{
+	int rc;
+	struct wiegand_gpio_device *wiegand_gpio;
+	struct wiegand_gpio_platform_data *pdata = pdev->dev.platform_data;
+
+	if (!pdata) {
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
+
+	wiegand_gpio = kzalloc(sizeof(struct wiegand_gpio_device), GFP_KERNEL);
+	if (!wiegand_gpio)
+		return -ENOMEM;
+
+	wiegand_gpio->dev = &pdev->dev;
+
+	/* Initialize character device */
+	cdev_init(&wiegand_gpio->cdev, &wiegand_gpio_fops);
+	wiegand_gpio->cdev.owner = THIS_MODULE;
+
+	rc = cdev_add(&wiegand_gpio->cdev, MKDEV(MAJOR(base_devno),
+				pdev->id == -1 ? 0 : pdev->id), 1);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "Failed to allocate cdev: %d\n", rc);
+		kfree(wiegand_gpio);
+		return rc;
+	}
+
+	wiegand_gpio->dev->devt = wiegand_gpio->cdev.dev;
+	mutex_init(&wiegand_gpio->mutex);
+
+	/* Get GPIO lines using device tree bindings. */
+	wiegand_gpio->gpio_data_lo = devm_gpiod_get(wiegand_gpio->dev,
+			"wiegand-data-lo", GPIOD_OUT_HIGH);
+	if (IS_ERR(wiegand_gpio->gpio_data_lo)) {
+		dev_info(wiegand_gpio->dev,
+			"Failed to get wiegand-data-lo pin.\n");
+		return PTR_ERR(wiegand_gpio->gpio_data_lo);
+	}
+	wiegand_gpio->gpio_data_hi = devm_gpiod_get(wiegand_gpio->dev,
+			"wiegand-data-hi", GPIOD_OUT_HIGH);
+	if (IS_ERR(wiegand_gpio->gpio_data_hi)) {
+		dev_info(wiegand_gpio->dev,
+			"Failed to get wiegand-data-hi pin.\n");
+		return PTR_ERR(wiegand_gpio->gpio_data_hi);
+	}
+
+	memcpy(&wiegand_gpio->setup, &WIEGAND_SETUP,
+			sizeof(struct wiegand_setup));
+
+	platform_set_drvdata(pdev, wiegand_gpio);
+
+	dev_info(&pdev->dev, "devno=%d:%d\n",
+		 MAJOR(wiegand_gpio->dev->devt),
+		 MINOR(wiegand_gpio->dev->devt));
+
+	rc = device_create_file(wiegand_gpio->dev, &dev_attr_pulse_len);
+	rc |= device_create_file(wiegand_gpio->dev, &dev_attr_interval_len);
+	rc |= device_create_file(wiegand_gpio->dev, &dev_attr_frame_gap);
+	rc |= device_create_file(wiegand_gpio->dev, &dev_attr_format);
+	rc |= device_create_file(wiegand_gpio->dev,
+				&dev_attr_payload_len);
+	if (rc != 0)
+		dev_warn(&pdev->dev,
+				"Failed to register attribute files(%d)\n", rc);
+
+	return 0;
+}
+
+static int wiegand_gpio_dev_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct wiegand_gpio_device *wiegand_gpio = platform_get_drvdata(pdev);
+
+	device_remove_file(dev, &dev_attr_pulse_len);
+	device_remove_file(dev, &dev_attr_interval_len);
+	device_remove_file(dev, &dev_attr_frame_gap);
+	device_remove_file(dev, &dev_attr_format);
+	device_remove_file(dev, &dev_attr_payload_len);
+	cdev_del(&wiegand_gpio->cdev);
+	kfree(wiegand_gpio);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id wiegand_gpio_dt_idtable[] = {
+	{ .compatible = "wiegand-gpio" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, wiegand_gpio_dt_idtable);
+#endif
+
+static struct platform_driver wiegand_gpio_driver = {
+	.probe		= wiegand_gpio_dev_probe,
+	.remove		= wiegand_gpio_dev_remove,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "wiegand-gpio",
+		.of_match_table = of_match_ptr(wiegand_gpio_dt_idtable),
+	}
+};
+MODULE_ALIAS("platform:wiegand-gpio");
+
+static int __init wiegand_gpio_init(void)
+{
+	int rc;
+	struct device *wiegand_device;
+	struct class *cl;
+
+	rc = alloc_chrdev_region(&base_devno, 0, max_devices, "wiegand-gpio");
+	if (rc < 0) {
+		pr_err("%s: Failed to allocate chardev region: %d\n",
+			__func__, rc);
+		return rc;
+	}
+
+	cl = class_create(THIS_MODULE, "chardrv");
+	if (IS_ERR(cl)) {
+		pr_err("Failed to create a class for character device");
+		unregister_chrdev_region(base_devno, max_devices);
+		return PTR_ERR(cl);
+	}
+	wiegand_gpio_cl = cl;
+
+	wiegand_device = device_create(cl, NULL, base_devno, NULL,
+			"wiegand-gpio");
+	if (IS_ERR(wiegand_device)) {
+		class_destroy(cl);
+		unregister_chrdev_region(base_devno, max_devices);
+		return PTR_ERR(wiegand_device);
+	}
+
+	rc = platform_driver_register(&wiegand_gpio_driver);
+	if (rc < 0) {
+		pr_err("Error %d while registering wiegand-gpio driver\n", rc);
+		unregister_chrdev_region(base_devno, max_devices);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void __exit wiegand_gpio_exit(void)
+{
+	platform_driver_unregister(&wiegand_gpio_driver);
+	unregister_chrdev_region(base_devno, max_devices);
+	device_destroy(wiegand_gpio_cl, base_devno);
+	class_destroy(wiegand_gpio_cl);
+}
+
+module_init(wiegand_gpio_init);
+module_exit(wiegand_gpio_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Wiegand write-only driver realized by GPIOs");
+MODULE_AUTHOR("Martin Zaťovič <m.zatovic1@gmail.com>");
diff --git a/drivers/bus/wiegand-gpio.h b/drivers/bus/wiegand-gpio.h
new file mode 100644
index 000000000000..f0f389d5bfec
--- /dev/null
+++ b/drivers/bus/wiegand-gpio.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Wiegand write-only GPIO driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef H_LINUX_INCLUDE_LINUX_WIEGAND_H
+#define H_LINUX_INCLUDE_LINUX_WIEGAND_H
+
+/* The used wiegand format; when data does not end at octet boundaries, the
+ * lower bits of the last octet will be ignored and only the upper ones will be
+ * used.
+ */
+enum wiegand_format {
+	WIEGAND_V26 = 26,
+	WIEGAND_V36 = 36,
+	WIEGAND_V37 = 37,
+	WIEGAND_CUSTOM = 0,
+};
+
+enum wiegand_paylen {
+	WIEGAND_V26_PAYLEN = 24,
+	WIEGAND_V36_PAYLEN = 34,
+	WIEGAND_V37_PAYLEN = 35,
+	WIEGAND_MAX_CUSTOM_PAYLEN = 256,
+};
+
+/**
+ * struct wiegand_setup - Wiegand communication attributes
+ * @pulse_len: length of the low pulse in usec; defaults to 50us
+ * @interval_len: length of a whole bit (both the pulse and the high phase) in
+ *	usec; defaults to 2000us
+ * @frame_gap: length of the last bit of a frame (both the pulse and the high
+ *	phase) in usec; defaults to \c interval_len
+ * @format: the used wiegand format
+ * @payload_len: payload of wiegand message in bits
+ */
+struct wiegand_setup {
+	unsigned long		pulse_len;
+	unsigned long		interval_len;
+	unsigned long		frame_gap;
+	enum wiegand_format	format;
+	unsigned long		payload_len;
+};
+
+#endif	/* H_LINUX_INCLUDE_LINUX_WIEGAND_H */
-- 
2.37.1

