Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5EA4D7991
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 04:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiCNDLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 23:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiCNDK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 23:10:57 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986753EABC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 20:09:46 -0700 (PDT)
Received: (Authenticated sender: frank@zago.net)
        by mail.gandi.net (Postfix) with ESMTPSA id D7B3F240003;
        Mon, 14 Mar 2022 03:09:41 +0000 (UTC)
From:   frank zago <frank@zago.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jan-Niklas Burfeind <kernel@aiyionpri.me>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org, gunar@schorcht.net,
        Lee Jones <lee.jones@linaro.org>
Cc:     frank zago <frank@zago.net>
Subject: [PATCH v3] mfd: ch341: add driver for the WCH CH341 in I2C/GPIO mode
Date:   Sun, 13 Mar 2022 22:09:37 -0500
Message-Id: <20220314030937.22762-1-frank@zago.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CH341 is a multifunction chip, presenting 3 different USB PID. One
of these functions is for I2C/SPI/GPIO. This new driver manages I2C
and GPIO.

The I2C interface can run at 4 different speeds. This driver currently
only offer 100MHz. Tested with a variety of I2C sensors, and the IIO
subsystem.

The GPIO interface offers 16 GPIOs. 6 are read/write, and 10 are
read-only.

Signed-off-by: frank zago <frank@zago.net>
---

Changes from v2:
  - bug fixes
  - more robust USB enumeration
  - Changed to an MFD driver as suggested

During testing I found that i2c handles hot removal, but not gpio. The
gpio subsystem will complain with 'REMOVING GPIOCHIP WITH GPIOS STILL
REQUESTED', but it's a gpiolib issue.

Changes from v1:
  - Removed double Signed-off-by
  - Move Kconfig into the same directory as the driver


 Documentation/misc-devices/ch341.rst | 114 ++++++++
 Documentation/misc-devices/index.rst |   1 +
 MAINTAINERS                          |   6 +
 drivers/mfd/Kconfig                  |  12 +
 drivers/mfd/Makefile                 |   3 +
 drivers/mfd/ch341-core.c             | 109 ++++++++
 drivers/mfd/ch341-gpio.c             | 386 +++++++++++++++++++++++++++
 drivers/mfd/ch341-i2c.c              | 281 +++++++++++++++++++
 drivers/mfd/ch341.h                  |  64 +++++
 9 files changed, 976 insertions(+)
 create mode 100644 Documentation/misc-devices/ch341.rst
 create mode 100644 drivers/mfd/ch341-core.c
 create mode 100644 drivers/mfd/ch341-gpio.c
 create mode 100644 drivers/mfd/ch341-i2c.c
 create mode 100644 drivers/mfd/ch341.h

diff --git a/Documentation/misc-devices/ch341.rst b/Documentation/misc-devices/ch341.rst
new file mode 100644
index 000000000000..d1734a8f1bf3
--- /dev/null
+++ b/Documentation/misc-devices/ch341.rst
@@ -0,0 +1,114 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+===========================================================
+WinChipHead (沁恒) CH341 linux driver for I2C and GPIO mode
+===========================================================
+
+The CH341 is declined in several flavors, and may support one or more
+of UART, SPI, I2C and GPIO, but not always simultaneously:
+
+  - CH341 A/B/F: UART, Printer, SPI, I2C and GPIO
+  - CH341 C/T: UART and I2C
+  - CH341 H: SPI
+
+They work in 3 different modes, with only one being presented
+depending on the USB PID:
+
+  - 0x5523: UART mode, covered by the USB `ch341` serial driver
+  - 0x5512: SPI/I2C/GPIO mode, covered by the MFD `ch341_buses` driver
+  - 0x5584: Parallel printer mode, covered by the USB `usblp` driver
+
+Mode selection is done at the hardware level by tying some
+pins. Breakout boards with one of the CH341 chip usually have one or
+more jumpers to select which mode they work on. At least one model
+(CJMCU-341) appears to need bridging some solder pads to select a
+different default. Breakout boards also don't usually offer an option
+to configure the chip into printer mode; for that case, connect the
+SCL and SDA lines directly together.
+
+The various CH341 appear to be indistinguishable from the
+software. For instance the ch341-buses driver will present a GPIO
+interface for the CH341T although physical pins are not present, and
+the device will accept GPIO commands.
+
+The ch341-buses driver has been tested with a CH341A, CH341B and
+CH341T.
+
+Some breakout boards work in 3.3V and 5V depending on some jumpers.
+
+The black chip programmer with a ZIF socket will power the CH341 at
+3.3V if a jumper is set, but will only output 5V to the chips to be
+programmed, which is not always desirable. A hardware hack to use 3.3V
+everywhere, involving some soldering, is available at
+https://eevblog.com/forum/repair/ch341a-serial-memory-programmer-power-supply-fix/
+
+Some sample code for the CH341 is available at the manufacturer
+website, at http://wch-ic.com/products/CH341.html
+
+The repository at https://github.com/boseji/CH341-Store contains a lot
+of information on these chips, including datasheets.
+
+This driver is based on the pre-existing work at
+https://github.com/gschorcht/i2c-ch341-usb
+
+
+I2C Caveats
+-----------
+
+The ch341 doesn't work with a Wii nunchuk, possibly because the
+pull-up value is too low (1500 ohms).
+
+i2c AT24 eeproms can be read but not programmed properly because the
+at24 linux driver tries to write a byte at a time, and doesn't wait at
+all (or enough) between writes. Data corruption on writes does occur.
+
+The driver doesn't support detection of I2C device present on the
+bus. Apparently when a device is not present at a given address, the
+CH341 will return an extra byte of data, but the driver doesn't
+support that. This may be addressed in the future.
+
+
+The GPIOs
+---------
+
+16 GPIOs are available on the CH341 A/B/F. The first 6 are input/output,
+and the last 10 are input only.
+
+Pinout and their names as they appear on some breakout boards::
+
+  CH341A/B/F     GPIO  Names                    Mode
+    pin          line
+
+   15             0     D0, CS0                  input/output
+   16             1     D1, CS1                  input/output
+   17             2     D2, CS2                  input/output
+   18             3     D3, SCK, DCK             input/output
+   19             4     D4, DOUT2, CS3           input/output
+   20             5     D5, MOSI, DOUT, SDO      input/output
+   21             6     D6, DIN2                 input
+   22             7     D7, MISO, DIN            input
+    5             8     ERR                      input
+    6             9     PEMP                     input
+    7            10     INT                      input
+    8            11     SLCT (SELECT)            input
+   26            12     RST# (?)                 input
+   27            13     WT (WAIT)                input
+    4            14     DS (Data Select?)        input
+    3            15     AS (Address Select?)     input
+
+
+GPIO interrupt
+~~~~~~~~~~~~~~
+
+The INT pin, corresponding to GPIO 10 is an input pin that can trigger
+an interrupt on a rising edge. Only that pin is able to generate an
+interrupt, and only on a rising edge. Trying to monitor events on
+another GPIO, or that GPIO on something other than a rising edge, will
+be rejected.
+
+
+SPI
+---
+
+This driver doesn't offer an SPI interface (yet) due to the
+impossibility of declaring an SPI device like I2C does.
diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 30ac58f81901..190f93b56ec6 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -29,3 +29,4 @@ fit into other categories.
    spear-pcie-gadget
    uacce
    xilinx_sdfec
+   ch341
diff --git a/MAINTAINERS b/MAINTAINERS
index e127c2fb08a7..ef47ebb69cce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20843,6 +20843,12 @@ M:	David Härdeman <david@hardeman.nu>
 S:	Maintained
 F:	drivers/media/rc/winbond-cir.c

+WINCHIPHEAD CH341 I2C/GPIO MFD DRIVER
+M:	Frank Zago <frank@zago.net>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/mfd/ch341*
+
 WINSYSTEMS EBC-C384 WATCHDOG DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-watchdog@vger.kernel.org
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ba0b3eb131f1..ba8695d71e82 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1778,6 +1778,18 @@ config MFD_LOCHNAGAR
 	help
 	  Support for Cirrus Logic Lochnagar audio development board.

+config MFD_CH341
+	tristate "WinChipHead CH341 in I2C/SPI/GPIO mode"
+	depends on USB && GPIOLIB && I2C
+	help
+	  If you say yes to this option, support for the CH341 series
+	  of chips, running in I2C/SPI/GPIO mode will be included.
+
+	  The chip's SPI mode is not supported.
+
+	  This driver can also be built as a module.  If so, the
+	  module will be called ch341-buses.
+
 config MFD_ARIZONA
 	select REGMAP
 	select REGMAP_IRQ
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index df1ecc4a4c95..b12e92c98b72 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -75,6 +75,9 @@ wm8994-objs			:= wm8994-core.o wm8994-irq.o wm8994-regmap.o
 obj-$(CONFIG_MFD_WM8994)	+= wm8994.o
 obj-$(CONFIG_MFD_WM97xx)	+= wm97xx-core.o

+obj-$(CONFIG_MFD_CH341) := ch341-buses.o
+ch341-buses-objs := ch341-core.o ch341-i2c.o ch341-gpio.o
+
 madera-objs			:= madera-core.o
 ifeq ($(CONFIG_MFD_CS47L15),y)
 madera-objs			+= cs47l15-tables.o
diff --git a/drivers/mfd/ch341-core.c b/drivers/mfd/ch341-core.c
new file mode 100644
index 000000000000..7a820f34a228
--- /dev/null
+++ b/drivers/mfd/ch341-core.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the CH341A, and CH341B USB to I2C/SPI/GPIO adapter
+ * Driver for the CH341T USB to I2C adapter
+ *
+ * Copyright 2021, Frank Zago
+ * Copyright (c) 2017 Gunar Schorcht (gunar@schorcht.net)
+ * Copyright (c) 2016 Tse Lun Bien
+ * Copyright (c) 2014 Marco Gittler
+ * Copyright (c) 2006-2007 Till Harbaum (Till@Harbaum.org)
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "ch341.h"
+
+static void ch341_usb_free_device(struct ch341_device *dev)
+{
+	ch341_gpio_remove(dev);
+	ch341_i2c_remove(dev);
+
+	usb_set_intfdata(dev->iface, NULL);
+	usb_put_dev(dev->usb_dev);
+
+	kfree(dev);
+}
+
+static int ch341_usb_probe(struct usb_interface *iface,
+			   const struct usb_device_id *usb_id)
+{
+	struct usb_host_endpoint *endpoints;
+	struct ch341_device *dev;
+	int rc;
+
+	dev = kzalloc(sizeof(struct ch341_device), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->usb_dev = usb_get_dev(interface_to_usbdev(iface));
+	dev->iface = iface;
+	mutex_init(&dev->usb_lock);
+
+	if (iface->cur_altsetting->desc.bNumEndpoints != 3) {
+		rc = -EIO;
+		goto free_dev;
+	}
+
+	endpoints = iface->cur_altsetting->endpoint;
+	if (!usb_endpoint_is_bulk_in(&endpoints[0].desc) ||
+	    !usb_endpoint_is_bulk_out(&endpoints[1].desc) ||
+	    !usb_endpoint_xfer_int(&endpoints[2].desc)) {
+		rc = -EIO;
+		goto free_dev;
+	}
+
+	dev->ep_in = endpoints[0].desc.bEndpointAddress;
+	dev->ep_out = endpoints[1].desc.bEndpointAddress;
+	dev->ep_intr = endpoints[2].desc.bEndpointAddress;
+	dev->ep_intr_interval = endpoints[2].desc.bInterval;
+
+	usb_set_intfdata(iface, dev);
+
+	rc = ch341_i2c_init(dev);
+	if (rc)
+		goto free_dev;
+
+	rc = ch341_gpio_init(dev);
+	if (rc)
+		goto rem_i2c;
+
+	return 0;
+
+rem_i2c:
+	ch341_i2c_remove(dev);
+
+free_dev:
+	usb_put_dev(dev->usb_dev);
+	kfree(dev);
+
+	return rc;
+}
+
+static void ch341_usb_disconnect(struct usb_interface *usb_if)
+{
+	struct ch341_device *dev = usb_get_intfdata(usb_if);
+
+	ch341_usb_free_device(dev);
+}
+
+static const struct usb_device_id ch341_usb_table[] = {
+	{ USB_DEVICE(0x1a86, 0x5512) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(usb, ch341_usb_table);
+
+static struct usb_driver ch341_usb_driver = {
+	.name       = "ch341-buses",
+	.id_table   = ch341_usb_table,
+	.probe      = ch341_usb_probe,
+	.disconnect = ch341_usb_disconnect
+};
+
+module_usb_driver(ch341_usb_driver);
+
+MODULE_AUTHOR("Various");
+MODULE_DESCRIPTION("CH341 USB to I2C/GPIO adapter");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/ch341-gpio.c b/drivers/mfd/ch341-gpio.c
new file mode 100644
index 000000000000..fa1185e2cb5e
--- /dev/null
+++ b/drivers/mfd/ch341-gpio.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPIO interface for the CH341A and CH341B chips.
+ *
+ * Copyright 2021, Frank Zago
+ * Copyright (c) 2017 Gunar Schorcht (gunar@schorcht.net)
+ * Copyright (c) 2016 Tse Lun Bien
+ * Copyright (c) 2014 Marco Gittler
+ * Copyright (c) 2006-2007 Till Harbaum (Till@Harbaum.org)
+ */
+
+/* Notes.
+ *
+ * For the CH341, 0=IN, 1=OUT, but for the GPIO subsystem, 1=IN and
+ * 0=OUT. Some translation happens in a couple places.
+ */
+
+#include "ch341.h"
+
+#define CH341_GPIO_NUM_PINS         16    /* Number of GPIO pins */
+
+#define CH341_PARA_CMD_STS          0xA0  /* Get pins status */
+#define CH341_CMD_UIO_STREAM        0xAB  /* UIO stream command */
+
+#define CH341_CMD_UIO_STM_OUT       0x80  /* UIO interface OUT command (D0~D5) */
+#define CH341_CMD_UIO_STM_DIR       0x40  /* UIO interface DIR command (D0~D5) */
+#define CH341_CMD_UIO_STM_END       0x20  /* UIO interface END command */
+
+/* Masks to describe the 16 GPIOs. Pins D0 to D5 (mapped to GPIOs 0 to
+ * 5) can read/write, but the other pins can only read.
+ */
+static const u16 pin_can_output = 0b111111;
+
+/* Only GPIO 10 (INT# line) has hardware interrupt */
+#define CH341_GPIO_INT_LINE 10
+
+static void ch341_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+
+	seq_printf(s, "pin config  : %04x  (0=IN, 1=OUT)\n", dev->gpio_dir);
+	seq_printf(s, "last read   : %04x\n", dev->gpio_last_read);
+	seq_printf(s, "last written: %04x\n", dev->gpio_last_written);
+}
+
+/* Send a command and get a reply if requested */
+static int gpio_transfer(struct ch341_device *dev, int out_len, int in_len)
+{
+	int actual;
+	int rc;
+
+	mutex_lock(&dev->usb_lock);
+
+	rc = usb_bulk_msg(dev->usb_dev,
+			  usb_sndbulkpipe(dev->usb_dev, dev->ep_out),
+			  dev->gpio_buf, out_len,
+			  &actual, DEFAULT_TIMEOUT);
+	if (rc < 0)
+		goto done;
+
+	if (in_len == 0) {
+		rc = actual;
+		goto done;
+	}
+
+	rc = usb_bulk_msg(dev->usb_dev,
+			  usb_rcvbulkpipe(dev->usb_dev, dev->ep_in),
+			  dev->gpio_buf, SEG_SIZE, &actual, DEFAULT_TIMEOUT);
+
+	if (rc == 0)
+		rc = actual;
+
+done:
+	mutex_unlock(&dev->usb_lock);
+
+	return rc;
+}
+
+/* Read the GPIO line status. */
+static int read_inputs(struct ch341_device *dev)
+{
+	int result;
+
+	mutex_lock(&dev->gpio_lock);
+
+	dev->gpio_buf[0] = CH341_PARA_CMD_STS;
+
+	result = gpio_transfer(dev, 1, 1);
+
+	/* The status command returns 6 bytes of data. Byte 0 has
+	 * status for lines 0 to 7, and byte 1 is lines 8 to 15. The
+	 * 3rd has the status for the SCL/SDA/SCK pins. The 4th byte
+	 * might have some remaining pin status. Byte 5 and 6 content
+	 * is unknown.
+	 */
+	if (result == 6)
+		dev->gpio_last_read = le16_to_cpu(*(__le16 *)dev->gpio_buf);
+
+	mutex_unlock(&dev->gpio_lock);
+
+	return (result != 6) ? result : 0;
+}
+
+static int ch341_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+	int rc;
+
+	rc = read_inputs(dev);
+	if (rc)
+		return rc;
+
+	return (dev->gpio_last_read & BIT(offset)) ? 1 : 0;
+}
+
+static int ch341_gpio_get_multiple(struct gpio_chip *chip,
+				   unsigned long *mask, unsigned long *bits)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+	int rc;
+
+	rc = read_inputs(dev);
+	if (rc)
+		return rc;
+
+	*bits = dev->gpio_last_read & *mask;
+
+	return 0;
+}
+
+static void write_outputs(struct ch341_device *dev)
+{
+	mutex_lock(&dev->gpio_lock);
+
+	dev->gpio_buf[0] = CH341_CMD_UIO_STREAM;
+	dev->gpio_buf[1] = CH341_CMD_UIO_STM_DIR | dev->gpio_dir;
+	dev->gpio_buf[2] = CH341_CMD_UIO_STM_OUT | (dev->gpio_last_written & dev->gpio_dir);
+	dev->gpio_buf[3] = CH341_CMD_UIO_STM_END;
+
+	gpio_transfer(dev, 4, 0);
+
+	mutex_unlock(&dev->gpio_lock);
+}
+
+static void ch341_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+
+	if (value)
+		dev->gpio_last_written |= BIT(offset);
+	else
+		dev->gpio_last_written &= ~BIT(offset);
+
+	write_outputs(dev);
+}
+
+static void ch341_gpio_set_multiple(struct gpio_chip *chip,
+				    unsigned long *mask, unsigned long *bits)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+
+	dev->gpio_last_written &= ~*mask;
+	dev->gpio_last_written |= (*bits & *mask);
+
+	write_outputs(dev);
+}
+
+static int ch341_gpio_get_direction(struct gpio_chip *chip,
+				    unsigned int offset)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+
+	return (dev->gpio_dir & BIT(offset)) ? 0 : 1;
+}
+
+static int ch341_gpio_direction_input(struct gpio_chip *chip,
+				      unsigned int offset)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+
+	dev->gpio_dir &= ~BIT(offset);
+
+	write_outputs(dev);
+
+	return 0;
+}
+
+static int ch341_gpio_direction_output(struct gpio_chip *chip,
+				       unsigned int offset, int value)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+	u16 mask = BIT(offset);
+
+	if (!(pin_can_output & mask))
+		return -EINVAL;
+
+	dev->gpio_dir |= mask;
+
+	ch341_gpio_set(chip, offset, value);
+
+	return 0;
+}
+
+static void ch341_complete_intr_urb(struct urb *urb)
+{
+	struct ch341_device *dev = urb->context;
+	int rc;
+
+	if (!urb->status) {
+		/* Data is 8 bytes. Byte 0 might be the length of
+		 * significant data, which is 3 more bytes. Bytes 1
+		 * and 2, and possibly 3, are the pin status. The byte
+		 * order is different than for the GET_STATUS
+		 * command. Byte 1 is GPIOs 8 to 15, and byte 2 is
+		 * GPIOs 0 to 7.
+		 *
+		 * Something like this (with locking?) could be done,
+		 * but there's nothing to retrieve that info without
+		 * doing another USB read:
+		 *
+		 *   dev->gpio_last_read = be16_to_cpu(*(u16 *)&dev->gpio_buf_intr[1]);
+		 */
+
+		handle_nested_irq(dev->gpio_irq.num);
+
+		rc = usb_submit_urb(dev->gpio_irq.urb, GFP_ATOMIC);
+		if (rc)
+			usb_unanchor_urb(dev->gpio_irq.urb);
+	} else {
+		usb_unanchor_urb(dev->gpio_irq.urb);
+	}
+}
+
+static int ch341_gpio_irq_set_type(struct irq_data *data, u32 type)
+{
+	struct ch341_device *dev = irq_data_get_irq_chip_data(data);
+
+	if (data->irq != dev->gpio_irq.num || type != IRQ_TYPE_EDGE_RISING)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void ch341_gpio_irq_enable(struct irq_data *data)
+{
+	struct ch341_device *dev = irq_data_get_irq_chip_data(data);
+	int rc;
+
+	dev->gpio_irq.enabled = true;
+
+	/* The URB might have just been unlinked in
+	 * ch341_gpio_irq_disable, but the completion handler hasn't
+	 * been called yet.
+	 */
+	if (!usb_wait_anchor_empty_timeout(&dev->gpio_irq.urb_out, 5000))
+		usb_kill_anchored_urbs(&dev->gpio_irq.urb_out);
+
+	usb_anchor_urb(dev->gpio_irq.urb, &dev->gpio_irq.urb_out);
+	rc = usb_submit_urb(dev->gpio_irq.urb, GFP_ATOMIC);
+	if (rc)
+		usb_unanchor_urb(dev->gpio_irq.urb);
+}
+
+static void ch341_gpio_irq_disable(struct irq_data *data)
+{
+	struct ch341_device *dev = irq_data_get_irq_chip_data(data);
+
+	dev->gpio_irq.enabled = false;
+	usb_unlink_urb(dev->gpio_irq.urb);
+}
+
+/* Convert the GPIO index to the IRQ number */
+static int ch341_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ch341_device *dev = gpiochip_get_data(chip);
+
+	if (offset != CH341_GPIO_INT_LINE)
+		return -ENXIO;
+
+	return dev->gpio_irq.num;
+}
+
+/* Allocate a software driven IRQ, for GPIO 10 */
+static int ch341_gpio_get_irq(struct ch341_device *dev)
+{
+	int rc;
+
+	dev->gpio_irq.irq.name = dev->gpio_irq.name;
+	dev->gpio_irq.irq.irq_set_type = ch341_gpio_irq_set_type;
+	dev->gpio_irq.irq.irq_enable = ch341_gpio_irq_enable;
+	dev->gpio_irq.irq.irq_disable = ch341_gpio_irq_disable;
+
+	rc = irq_alloc_desc(0);
+	if (rc < 0) {
+		dev_err(&dev->usb_dev->dev, "Cannot allocate an IRQ desc");
+		return rc;
+	}
+
+	dev->gpio_irq.num = rc;
+	dev->gpio_irq.enabled = false;
+
+	irq_set_chip_data(dev->gpio_irq.num, dev);
+	irq_set_chip_and_handler(dev->gpio_irq.num, &dev->gpio_irq.irq,
+				 handle_simple_irq);
+
+	return 0;
+}
+
+void ch341_gpio_remove(struct ch341_device *dev)
+{
+	if (!dev->gpio_init)
+		return;
+
+	usb_kill_anchored_urbs(&dev->gpio_irq.urb_out);
+	usb_free_urb(dev->gpio_irq.urb);
+
+	gpiochip_remove(&dev->gpio);
+	irq_free_desc(dev->gpio_irq.num);
+}
+
+int ch341_gpio_init(struct ch341_device *dev)
+{
+	struct gpio_chip *gpio = &dev->gpio;
+	int rc;
+
+	snprintf(dev->gpio_irq.name, sizeof(dev->gpio_irq.name),
+		 "ch341-%s-gpio", dev_name(&dev->usb_dev->dev));
+	dev->gpio_irq.name[sizeof(dev->gpio_irq.name) - 1] = 0;
+
+	gpio->label = "ch341";
+	gpio->parent = &dev->usb_dev->dev;
+	gpio->owner = THIS_MODULE;
+	gpio->get_direction = ch341_gpio_get_direction;
+	gpio->direction_input = ch341_gpio_direction_input;
+	gpio->direction_output = ch341_gpio_direction_output;
+	gpio->get = ch341_gpio_get;
+	gpio->get_multiple = ch341_gpio_get_multiple;
+	gpio->set = ch341_gpio_set;
+	gpio->set_multiple = ch341_gpio_set_multiple;
+	gpio->dbg_show = ch341_gpio_dbg_show;
+	gpio->base = -1;
+	gpio->ngpio = CH341_GPIO_NUM_PINS;
+	gpio->can_sleep = true;
+	gpio->to_irq = ch341_gpio_to_irq;
+
+	dev->gpio_dir = 0;	/* All pins as input */
+
+	mutex_init(&dev->gpio_lock);
+
+	rc = ch341_gpio_get_irq(dev);
+	if (rc)
+		return rc;
+
+	rc = gpiochip_add_data(gpio, dev);
+	if (rc) {
+		dev_err(&dev->usb_dev->dev, "Could not add GPIO\n");
+		goto release_irq;
+	}
+
+	/* create an URB for handling interrupt */
+	dev->gpio_irq.urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!dev->gpio_irq.urb) {
+		dev_err(&dev->usb_dev->dev, "Cannot alloc the int URB");
+		rc = -ENOMEM;
+		goto release_gpio;
+	}
+
+	usb_fill_int_urb(dev->gpio_irq.urb, dev->usb_dev,
+			 usb_rcvintpipe(dev->usb_dev, dev->ep_intr),
+			 dev->gpio_irq.buf, CH341_USB_MAX_INTR_SIZE,
+			 ch341_complete_intr_urb, dev, dev->ep_intr_interval);
+
+	init_usb_anchor(&dev->gpio_irq.urb_out);
+
+	dev->gpio_init = true;
+
+	return 0;
+
+release_gpio:
+	gpiochip_remove(&dev->gpio);
+
+release_irq:
+	irq_free_desc(dev->gpio_irq.num);
+
+	return rc;
+}
diff --git a/drivers/mfd/ch341-i2c.c b/drivers/mfd/ch341-i2c.c
new file mode 100644
index 000000000000..d458526313ea
--- /dev/null
+++ b/drivers/mfd/ch341-i2c.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * I2C interface for the CH341A, CH341B and CH341T.
+ *
+ * Copyright 2021, Frank Zago
+ * Copyright (c) 2016 Tse Lun Bien
+ * Copyright (c) 2014 Marco Gittler
+ * Copyright (C) 2006-2007 Till Harbaum (Till@Harbaum.org)
+ */
+
+#include "ch341.h"
+
+/* I2C bus speed. Speed selection is not implemented. */
+#define CH341_I2C_20KHZ  0
+#define CH341_I2C_100KHZ 1
+#define CH341_I2C_400KHZ 2
+#define CH341_I2C_750KHZ 3
+
+#define CH341_CMD_I2C_STREAM 0xAA
+#define CH341_CMD_I2C_STM_END 0x00
+
+#define CH341_CMD_I2C_STM_STA 0x74
+#define CH341_CMD_I2C_STM_STO 0x75
+#define CH341_CMD_I2C_STM_OUT 0x80
+#define CH341_CMD_I2C_STM_IN 0xC0
+#define CH341_CMD_I2C_STM_SET 0x60
+
+/* Append a write command to the current request. A set of 32-byte
+ * packets is filled. Each packet starts with STREAM and finishes with
+ * END, and contains an OUT field, leaving up to 29 bytes of data. The
+ * first packet must also include a START and the device address.
+ */
+static int append_write(struct ch341_device *dev, const struct i2c_msg *msg)
+{
+	u8 *out = dev->i2c_buf;
+	int len;
+	u8 *p;
+	bool start_done = false;
+
+	len = msg->len;
+	p = msg->buf;
+
+	while (len) {
+		int to_write;
+		int avail;
+
+		if (dev->idx_out % SEG_SIZE) {
+			/* Finish current packet, and advance to the next one */
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_END;
+			dev->out_seg++;
+			dev->idx_out = dev->out_seg * SEG_SIZE;
+
+			if (dev->out_seg == SEG_COUNT)
+				return -E2BIG;
+		}
+
+		out[dev->idx_out++] = CH341_CMD_I2C_STREAM;
+
+		/* account for stream start and end */
+		avail = SEG_SIZE - 3;
+
+		if (!start_done) {
+			/* Each message has a start */
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_STA;
+
+			avail -= 2; /* room for STA and device address */
+		}
+
+		to_write = min_t(int, len, avail);
+
+		if (!start_done) {
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_OUT | (to_write + 1);
+			out[dev->idx_out++] = msg->addr << 1;
+
+			start_done = true;
+		} else {
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_OUT | to_write;
+		}
+
+		memcpy(&out[dev->idx_out], p, to_write);
+		dev->idx_out += to_write;
+		len -= to_write;
+		p += to_write;
+	}
+
+	return 0;
+}
+
+/* Append a read command to the request. It usually follows a write
+ * command. When that happens, the driver will attempt to concat the
+ * read command into the same packet.  Each read command, of up to 32
+ * bytes, must be written to a new packet. It is not possible to
+ * concat them.
+ */
+static int append_read(struct ch341_device *dev, const struct i2c_msg *msg)
+{
+	u8 *out = dev->i2c_buf;
+	bool start_done = false;
+	int len;
+
+	len = msg->len;
+
+	while (len) {
+		int to_read;
+
+		if (dev->idx_out % SEG_SIZE) {
+			if (!start_done &&
+			    (dev->idx_out % SEG_SIZE) <  (SEG_SIZE - 7)) {
+				/* There's enough left for a read */
+			} else {
+				/* Finish current packet, and advance to the next one */
+				out[dev->idx_out++] = CH341_CMD_I2C_STM_END;
+				dev->out_seg++;
+				dev->idx_out = dev->out_seg * SEG_SIZE;
+
+				if (dev->out_seg == SEG_COUNT)
+					return -E2BIG;
+
+				out[dev->idx_out++] = CH341_CMD_I2C_STREAM;
+			}
+		} else {
+			out[dev->idx_out++] = CH341_CMD_I2C_STREAM;
+		}
+
+		if (!start_done) {
+			/* Each message has a start */
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_STA;
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_OUT | 1;
+			out[dev->idx_out++] = msg->addr << 1 | 1;
+
+			start_done = true;
+		}
+
+		/* Apparently the last command must be an STM_IN to
+		 * read the last byte. Without it, the adapter gets
+		 * lost.
+		 */
+		to_read = min_t(int, len, 32);
+		len -= to_read;
+		if (len == 0) {
+			if (to_read > 1)
+				out[dev->idx_out++] = CH341_CMD_I2C_STM_IN | (to_read - 1);
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_IN;
+		} else {
+			out[dev->idx_out++] = CH341_CMD_I2C_STM_IN | to_read;
+		}
+	}
+
+	return 0;
+}
+
+static int ch341_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
+{
+	struct ch341_device *dev = adapter->algo_data;
+	int retval;
+	int i;
+	u8 *out = dev->i2c_buf;
+	int actual;
+
+	/* Prepare the request */
+	dev->idx_out = 0;
+	dev->out_seg = 0;
+
+	for (i = 0; i != num; i++) {
+		if (msgs[i].flags & I2C_M_RD)
+			retval = append_read(dev, &msgs[i]);
+		else
+			retval = append_write(dev, &msgs[i]);
+
+		if (retval)
+			return retval;
+	}
+
+	/* Finish the last packet */
+	if (SEG_SIZE - (dev->idx_out % SEG_SIZE) < 2) {
+		out[dev->idx_out++] = CH341_CMD_I2C_STM_END;
+
+		dev->out_seg++;
+		if (dev->out_seg == SEG_COUNT)
+			return -E2BIG;
+
+		dev->idx_out = dev->out_seg * SEG_SIZE;
+
+		out[dev->idx_out++] = CH341_CMD_I2C_STREAM;
+	}
+
+	out[dev->idx_out++] = CH341_CMD_I2C_STM_STO;
+	out[dev->idx_out++] = CH341_CMD_I2C_STM_END;
+
+	dev_dbg(&dev->adapter.dev, "bulk_out request with %d bytes\n",
+		dev->idx_out);
+
+	mutex_lock(&dev->usb_lock);
+
+	/* Issue the request */
+	retval = usb_bulk_msg(dev->usb_dev,
+			      usb_sndbulkpipe(dev->usb_dev, dev->ep_out),
+			      dev->i2c_buf, dev->idx_out, &actual, DEFAULT_TIMEOUT);
+	if (retval < 0) {
+		mutex_unlock(&dev->usb_lock);
+		return retval;
+	}
+
+	for (i = 0; i != num; i++) {
+		if (!(msgs[i].flags & I2C_M_RD))
+			continue;
+
+		retval = usb_bulk_msg(dev->usb_dev,
+				      usb_rcvbulkpipe(dev->usb_dev, dev->ep_in),
+				      dev->i2c_buf, msgs[i].len, &actual, DEFAULT_TIMEOUT);
+
+		if (retval) {
+			mutex_unlock(&dev->usb_lock);
+			return retval;
+		}
+
+		if (actual != msgs[i].len) {
+			mutex_unlock(&dev->usb_lock);
+			return -EIO;
+		}
+
+		memcpy(msgs[i].buf, dev->i2c_buf, actual);
+	}
+
+	mutex_unlock(&dev->usb_lock);
+
+	return num;
+}
+
+static u32 ch341_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm ch341_i2c_algorithm = {
+	.master_xfer = ch341_i2c_xfer,
+	.functionality = ch341_i2c_func,
+};
+
+void ch341_i2c_remove(struct ch341_device *dev)
+{
+	if (!dev->i2c_init)
+		return;
+
+	i2c_del_adapter(&dev->adapter);
+}
+
+int ch341_i2c_init(struct ch341_device *dev)
+{
+	int retval;
+	int actual;
+
+	dev->adapter.owner = THIS_MODULE;
+	dev->adapter.class = I2C_CLASS_HWMON;
+	dev->adapter.algo = &ch341_i2c_algorithm;
+	dev->adapter.algo_data = dev;
+	snprintf(dev->adapter.name, sizeof(dev->adapter.name),
+		 "CH341 I2C USB bus %03d device %03d",
+		 dev->usb_dev->bus->busnum, dev->usb_dev->devnum);
+
+	dev->adapter.dev.parent = &dev->iface->dev;
+
+	/* Set ch341 i2c speed */
+	dev->i2c_buf[0] = CH341_CMD_I2C_STREAM;
+	dev->i2c_buf[1] = CH341_CMD_I2C_STM_SET | CH341_I2C_100KHZ;
+	dev->i2c_buf[2] = CH341_CMD_I2C_STM_END;
+	mutex_lock(&dev->usb_lock);
+	retval = usb_bulk_msg(dev->usb_dev,
+			      usb_sndbulkpipe(dev->usb_dev, dev->ep_out),
+			      dev->i2c_buf, 3, &actual, DEFAULT_TIMEOUT);
+	mutex_unlock(&dev->usb_lock);
+	if (retval < 0) {
+		dev_err(&dev->iface->dev, "Cannot set I2C speed\n");
+		return -EIO;
+	}
+
+	i2c_add_adapter(&dev->adapter);
+	dev->i2c_init = true;
+
+	return 0;
+}
diff --git a/drivers/mfd/ch341.h b/drivers/mfd/ch341.h
new file mode 100644
index 000000000000..530db669eb02
--- /dev/null
+++ b/drivers/mfd/ch341.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Definitions for CH341 driver
+ */
+
+#include <linux/usb.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+
+#define DEFAULT_TIMEOUT 1000	/* 1s USB requests timeout */
+
+/* I2C - The maximum request size is 4096 bytes, both for reading and
+ * writing, split in up to 128 32-byte segments. The I2C stream must
+ * start and stop in each 32-byte segment. Reading must also be
+ * split, with up to 32-byte per segment.
+ */
+#define SEG_SIZE 32
+#define SEG_COUNT 128
+
+#define CH341_USB_MAX_INTR_SIZE 8
+
+struct ch341_device {
+	struct usb_device *usb_dev;
+	struct usb_interface *iface;
+	struct mutex usb_lock;
+
+	int ep_in;
+	int ep_out;
+	int ep_intr;
+	u8 ep_intr_interval;
+
+	/* I2C */
+	struct i2c_adapter adapter;
+	bool i2c_init;
+
+	/* I2C request and response state */
+	int idx_out;		/* current offset in buf */
+	int out_seg;		/* current segment */
+	u8 i2c_buf[SEG_COUNT * SEG_SIZE];
+
+	/* GPIO */
+	struct gpio_chip gpio;
+	struct mutex gpio_lock;
+	bool gpio_init;
+	u16 gpio_dir;		/* 1 bit per pin, 0=IN, 1=OUT. */
+	u16 gpio_last_read;	/* last GPIO values read */
+	u16 gpio_last_written;	/* last GPIO values written */
+	u8 gpio_buf[SEG_SIZE];
+
+	struct {
+		char name[32];
+		bool enabled;
+		struct irq_chip irq;
+		int num;
+		struct urb *urb;
+		struct usb_anchor urb_out;
+		u8 buf[CH341_USB_MAX_INTR_SIZE];
+	} gpio_irq;
+};
+
+void ch341_i2c_remove(struct ch341_device *dev);
+int ch341_i2c_init(struct ch341_device *dev);
+void ch341_gpio_remove(struct ch341_device *dev);
+int ch341_gpio_init(struct ch341_device *dev);
--
2.32.0
