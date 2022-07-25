Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4167557F870
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 05:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiGYDGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 23:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGYDGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 23:06:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F309E021;
        Sun, 24 Jul 2022 20:06:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c22so5988829wmr.2;
        Sun, 24 Jul 2022 20:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gOEP+E9vEvmvs8/MLAucoh0GM1fTWokr8r32cEEhGnA=;
        b=mYDvNxeTMr71SJxS+KOy2KPcVem7hK81JydJ9AiYjPuhDVroBIThLG1ricE3gio0nI
         W3ktsWbTeNGTSsAojvKBLqA6JR6EXXhOsL+/AuX4aLqncq9ZxlfQ67T+V2tle6CCmAXT
         vbLfBVkaSDC+2RbdV2u3R8VxVkOQkUc4bxor4fMjFummgcPWvYarzGUTKmnIe7P0+cll
         RyygBJYKwSPajEpI8WmUzkGnPNnnc3eGLTwy/7wTLkjVaTWzsSTkCCpPS6Igxv1+slur
         Kgem9VasY1SvW9cc1bHZ8nIJw1T1zSAqi9LwMosyA6qeVxVq6jFGpGIRqi2Kj9F05qP6
         8KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gOEP+E9vEvmvs8/MLAucoh0GM1fTWokr8r32cEEhGnA=;
        b=qnVQA1hn7czJVi91MQoTIrB3uuJ9DThnXzELXXQaJXHSDScnD7Hg5CpsczoGt5mnYS
         nUmE06nCm3tntDg0qQwiG0RJHRk/3tdA8AfGNW412iQuB3c6kUGA5fd4W9xKe9ubunIf
         zlAG3V2RT5PIIShhlFgMLQjPfsGK4SjpRiiZ1W0XkWrwomiPLTWn3W00aFHgkWjmQk2I
         Iie5k37zhzw4wuVmdTiaKzHAfEk/G6pwAXvcyCZdPg4dkV+phi9mX3V7nOPYx6KqUM+J
         TmUhWrRs9v2MooiAiz8kPpP2CzyHbAwqx9OaRoKWGy7jPPZk7uqLrYaQorF/AXTbRd8g
         idqQ==
X-Gm-Message-State: AJIora9+HCKXzcpPNfA8cW6OPTg2yu7Rx27TzCh8DzawTI4Bys4e5xAp
        5RLi7P5ZfTmhokUOyQSG858gXQ61jzvPyA==
X-Google-Smtp-Source: AGRyM1tQqhrShSdxdB5nZ+zpWFy1pDSmnACwXGiN9SwTMwCM6ZhhCjfiyJE1Mx+x1BqGjMorF1EYKA==
X-Received: by 2002:a05:600c:3ac7:b0:3a3:64c3:6ddf with SMTP id d7-20020a05600c3ac700b003a364c36ddfmr676407wms.105.1658718371634;
        Sun, 24 Jul 2022 20:06:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:9414:100:70ae:aa59:3138:f63c])
        by smtp.gmail.com with ESMTPSA id p10-20020adff20a000000b0021baf5e590dsm10523227wro.71.2022.07.24.20.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 20:06:10 -0700 (PDT)
From:   Alexey Klimov <klimov.linux@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, oneukum@suse.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        atishp@rivosinc.com, atishp@atishpatra.org, yury.norov@gmail.com,
        aklimov@redhat.com, atomlin@redhat.com, klimov.linux@gmail.com
Subject: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog device
Date:   Mon, 25 Jul 2022 04:06:05 +0100
Message-Id: <20220725030605.1808710-1-klimov.linux@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver supports StreamLabs usb watchdog device. The device plugs
into 9-pin usb header and connects to reset pins and reset button
pins on desktop PC.

USB commands used to communicate with device were reverse
engineered using usbmon.

Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
---
Changes since v4:
	-- added more comments;
	-- added nowayout check in ->disconnect();
	-- completely rework usb_streamlabs_wdt_cmd() ->
                __usb_streamlabs_wdt_cmd() and functions
		that handle validation of the response;
	-- usb sending and receiving msgs are moved to separate
		functions;
        -- added soft_unbind=1 flag in usb_driver struct
		to make it possible to send URBs in ->disconnect();
        -- buffer is declared as __le16 now;
        -- made checkpatch.pl --strict happy;

Previous version:
https://lore.kernel.org/linux-watchdog/20220715234442.3910204-1-klimov.linux@gmail.com/


 MAINTAINERS                       |   6 +
 drivers/watchdog/Kconfig          |  15 ++
 drivers/watchdog/Makefile         |   1 +
 drivers/watchdog/streamlabs_wdt.c | 360 ++++++++++++++++++++++++++++++
 4 files changed, 382 insertions(+)
 create mode 100644 drivers/watchdog/streamlabs_wdt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..fb31c1823043 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19190,6 +19190,12 @@ W:	http://www.stlinux.com
 F:	Documentation/networking/device_drivers/ethernet/stmicro/
 F:	drivers/net/ethernet/stmicro/stmmac/
 
+STREAMLABS USB WATCHDOG DRIVER
+M:	Alexey Klimov <klimov.linux@gmail.com>
+L:	linux-watchdog@vger.kernel.org
+S:	Maintained
+F:	drivers/watchdog/streamlabs_wdt.c
+
 SUN3/3X
 M:	Sam Creasey <sammy@sammy.net>
 S:	Maintained
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 32fd37698932..64b7f947b196 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2171,6 +2171,21 @@ config USBPCWATCHDOG
 
 	  Most people will say N.
 
+config USB_STREAMLABS_WATCHDOG
+	tristate "StreamLabs USB watchdog driver"
+	depends on USB
+	help
+	  This is the driver for the USB Watchdog dongle from StreamLabs.
+	  If you correctly connect reset pins to motherboard Reset pin and
+	  to Reset button then this device will simply watch your kernel to make
+	  sure it doesn't freeze, and if it does, it reboots your computer
+	  after a certain amount of time.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called streamlabs_wdt.
+
+	  Most people will say N. Say yes or M if you want to use such usb device.
+
 config KEEMBAY_WATCHDOG
 	tristate "Intel Keem Bay SoC non-secure watchdog"
 	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index c324e9d820e9..2d601da9b5bd 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_WDTPCI) += wdt_pci.o
 
 # USB-based Watchdog Cards
 obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
+obj-$(CONFIG_USB_STREAMLABS_WATCHDOG) += streamlabs_wdt.o
 
 # ALPHA Architecture
 
diff --git a/drivers/watchdog/streamlabs_wdt.c b/drivers/watchdog/streamlabs_wdt.c
new file mode 100644
index 000000000000..f1130fe5559c
--- /dev/null
+++ b/drivers/watchdog/streamlabs_wdt.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StreamLabs USB Watchdog driver
+ *
+ * Copyright (c) 2016-2017,2022 Alexey Klimov <klimov.linux@gmail.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/usb.h>
+#include <linux/watchdog.h>
+#include <asm/byteorder.h>
+
+/*
+ * USB Watchdog device from Streamlabs:
+ * https://www.stream-labs.com/products/devices/watch-dog/
+ *
+ * USB commands have been reverse engineered using usbmon.
+ */
+
+#define DRIVER_AUTHOR "Alexey Klimov <klimov.linux@gmail.com>"
+#define DRIVER_DESC "StreamLabs USB watchdog driver"
+#define DRIVER_NAME "usb_streamlabs_wdt"
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+#define USB_STREAMLABS_WATCHDOG_VENDOR	0x13c0
+#define USB_STREAMLABS_WATCHDOG_PRODUCT	0x0011
+
+/*
+ * one buffer is used for communication, however transmitted message is only
+ * 32 bytes long
+ */
+#define BUFFER_TRANSFER_LENGTH	32
+#define BUFFER_LENGTH		64
+#define USB_TIMEOUT		350
+
+#define STREAMLABS_CMD_START	0xaacc
+#define STREAMLABS_CMD_STOP	0xbbff
+
+/* timeout values are taken from windows program */
+#define STREAMLABS_WDT_MIN_TIMEOUT	1
+#define STREAMLABS_WDT_MAX_TIMEOUT	46
+
+struct streamlabs_wdt {
+	struct watchdog_device wdt_dev;
+	struct usb_interface *intf;
+	/* Serialises usb communication with a device */
+	struct mutex lock;
+	__le16 *buffer;
+};
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+/* USB call wrappers to send and receive messages to/from the device. */
+static int usb_streamlabs_send_msg(struct usb_device *usbdev, __le16 *buf)
+{
+	int retval;
+	int size;
+
+	retval = usb_interrupt_msg(usbdev, usb_sndintpipe(usbdev, 0x02),
+				   buf, BUFFER_TRANSFER_LENGTH,
+				   &size, USB_TIMEOUT);
+
+	if (size != BUFFER_TRANSFER_LENGTH)
+		return -EIO;
+
+	return retval;
+}
+
+static int usb_streamlabs_get_msg(struct usb_device *usbdev, __le16 *buf)
+{
+	int retval;
+	int size;
+
+	retval = usb_interrupt_msg(usbdev, usb_rcvintpipe(usbdev, 0x81),
+				   buf, BUFFER_LENGTH,
+				   &size, USB_TIMEOUT);
+
+	if (size != BUFFER_LENGTH)
+		return -EIO;
+
+	return retval;
+}
+
+/*
+ * This function is used to check if watchdog timeout in the received buffer
+ * matches the timeout passed from watchdog subsystem.
+ */
+static int usb_streamlabs_wdt_check_timeout(__le16 *buf, unsigned long timeout)
+{
+	if (buf[3] != cpu_to_le16(timeout))
+		return -EPROTO;
+
+	return 0;
+}
+
+static int usb_streamlabs_wdt_check_response(u8 *buf)
+{
+	/*
+	 * If watchdog device understood the command it will acknowledge
+	 * with values 1,2,3,4 at indexes 10, 11, 12, 13 in response message
+	 * when response treated as 8bit message.
+	 */
+	if (buf[10] != 1 || buf[11] != 2 || buf[12] != 3 || buf[13] != 4)
+		return -EPROTO;
+
+	return 0;
+}
+
+/*
+ * This function is used to check if watchdog command in the received buffer
+ * matches the command passed to the device.
+ */
+static int usb_streamlabs_wdt_check_command(__le16 *buf, u16 cmd)
+{
+	if (buf[0] != cpu_to_le16(cmd))
+		return -EPROTO;
+
+	return 0;
+}
+
+static int usb_streamlabs_wdt_validate_response(__le16 *buf, u16 cmd,
+						unsigned long timeout_msec)
+{
+	int retval;
+
+	retval = usb_streamlabs_wdt_check_response((u8 *)buf);
+	if (retval)
+		return retval;
+
+	retval = usb_streamlabs_wdt_check_command(buf, cmd);
+	if (retval)
+		return retval;
+
+	retval = usb_streamlabs_wdt_check_timeout(buf, timeout_msec);
+	return retval;
+}
+
+static void usb_streamlabs_wdt_prepare_buf(__le16 *buf, u16 cmd,
+					   unsigned long timeout_msec)
+{
+	/*
+	 * remaining elements expected to be zero everytime during
+	 * communication
+	 */
+	buf[0] = cpu_to_le16(cmd);
+	buf[1] = cpu_to_le16(0x8000);
+	buf[3] = cpu_to_le16(timeout_msec);
+	buf[5] = 0x0;
+	buf[6] = 0x0;
+}
+
+static int __usb_streamlabs_wdt_cmd(struct streamlabs_wdt *wdt, u16 cmd)
+{
+	struct usb_device *usbdev;
+	unsigned long timeout_msec;
+	/* how many times to re-try getting the state of the device */
+	unsigned int retry_counter = 10;
+	int retval;
+
+	if (unlikely(!wdt->intf))
+		return -ENODEV;
+
+	usbdev = interface_to_usbdev(wdt->intf);
+	timeout_msec = wdt->wdt_dev.timeout * MSEC_PER_SEC;
+
+	usb_streamlabs_wdt_prepare_buf(wdt->buffer, cmd, timeout_msec);
+
+	/* send command to watchdog */
+	retval = usb_streamlabs_send_msg(usbdev, wdt->buffer);
+	if (retval)
+		return retval;
+
+	/*
+	 * Transition from one state to another in this device
+	 * doesn't happen immediately, especially stopping the device
+	 * is not observed on the first reading of the response.
+	 * Plus to avoid potentially stale response message in the device
+	 * we keep reading the state of the device until we see:
+	 * -- that device recognised the sent command;
+	 * -- the received state (started or stopped) matches the state
+	 * that was requested;
+	 * -- the timeout passed matches the timeout value read from
+	 * the device.
+	 * Keep retrying 10 times and if watchdog device doesn't respond
+	 * correctly as expected we bail out and return an error.
+	 */
+	do {
+		retval = usb_streamlabs_get_msg(usbdev, wdt->buffer);
+		if (retval)
+			break;
+
+		retval = usb_streamlabs_wdt_validate_response(wdt->buffer, cmd,
+							      timeout_msec);
+	} while (retval && retry_counter--);
+
+	return retry_counter ? retval : -EIO;
+}
+
+static int usb_streamlabs_wdt_cmd(struct streamlabs_wdt *streamlabs_wdt, u16 cmd)
+{
+	int retval;
+
+	mutex_lock(&streamlabs_wdt->lock);
+	retval = __usb_streamlabs_wdt_cmd(streamlabs_wdt, cmd);
+	mutex_unlock(&streamlabs_wdt->lock);
+
+	return retval;
+}
+
+static int usb_streamlabs_wdt_start(struct watchdog_device *wdt_dev)
+{
+	struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
+
+	return usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_START);
+}
+
+static int usb_streamlabs_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
+
+	return usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_STOP);
+}
+
+static const struct watchdog_info streamlabs_wdt_ident = {
+	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity	= DRIVER_NAME,
+};
+
+static const struct watchdog_ops usb_streamlabs_wdt_ops = {
+	.owner	= THIS_MODULE,
+	.start	= usb_streamlabs_wdt_start,
+	.stop	= usb_streamlabs_wdt_stop,
+};
+
+static int usb_streamlabs_wdt_probe(struct usb_interface *intf,
+				    const struct usb_device_id *id)
+{
+	struct usb_device *usbdev = interface_to_usbdev(intf);
+	struct streamlabs_wdt *streamlabs_wdt;
+	int retval;
+
+	/*
+	 * USB IDs of this device appear to be weird/unregistered. Hence, do
+	 * an additional check on product and manufacturer.
+	 * If there is similar device in the field with same values then
+	 * there is stop command in probe() below that checks if the device
+	 * behaves as a watchdog.
+	 */
+	if (!usbdev->product || !usbdev->manufacturer ||
+	    strncmp(usbdev->product, "USBkit", 6) ||
+	    strncmp(usbdev->manufacturer, "STREAM LABS", 11))
+		return -ENODEV;
+
+	streamlabs_wdt = devm_kzalloc(&intf->dev, sizeof(struct streamlabs_wdt),
+				      GFP_KERNEL);
+	if (!streamlabs_wdt)
+		return -ENOMEM;
+
+	streamlabs_wdt->buffer = devm_kzalloc(&intf->dev, BUFFER_LENGTH,
+					      GFP_KERNEL);
+	if (!streamlabs_wdt->buffer)
+		return -ENOMEM;
+
+	mutex_init(&streamlabs_wdt->lock);
+
+	streamlabs_wdt->wdt_dev.info = &streamlabs_wdt_ident;
+	streamlabs_wdt->wdt_dev.ops = &usb_streamlabs_wdt_ops;
+	streamlabs_wdt->wdt_dev.timeout = STREAMLABS_WDT_MAX_TIMEOUT;
+	streamlabs_wdt->wdt_dev.max_timeout = STREAMLABS_WDT_MAX_TIMEOUT;
+	streamlabs_wdt->wdt_dev.min_timeout = STREAMLABS_WDT_MIN_TIMEOUT;
+	streamlabs_wdt->wdt_dev.parent = &intf->dev;
+
+	streamlabs_wdt->intf = intf;
+	usb_set_intfdata(intf, &streamlabs_wdt->wdt_dev);
+	watchdog_set_drvdata(&streamlabs_wdt->wdt_dev, streamlabs_wdt);
+	watchdog_set_nowayout(&streamlabs_wdt->wdt_dev, nowayout);
+
+	retval = usb_streamlabs_wdt_stop(&streamlabs_wdt->wdt_dev);
+	if (retval)
+		return -ENODEV;
+
+	retval = devm_watchdog_register_device(&intf->dev,
+					       &streamlabs_wdt->wdt_dev);
+	if (retval) {
+		dev_err(&intf->dev, "failed to register watchdog device\n");
+		return retval;
+	}
+
+	dev_info(&intf->dev, "StreamLabs USB watchdog driver loaded.\n");
+	return 0;
+}
+
+static int usb_streamlabs_wdt_suspend(struct usb_interface *intf,
+				      pm_message_t message)
+{
+	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
+
+	if (watchdog_active(&streamlabs_wdt->wdt_dev))
+		return usb_streamlabs_wdt_stop(&streamlabs_wdt->wdt_dev);
+
+	return 0;
+}
+
+static int usb_streamlabs_wdt_resume(struct usb_interface *intf)
+{
+	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
+
+	if (watchdog_active(&streamlabs_wdt->wdt_dev))
+		return usb_streamlabs_wdt_start(&streamlabs_wdt->wdt_dev);
+
+	return 0;
+}
+
+static void usb_streamlabs_wdt_disconnect(struct usb_interface *intf)
+{
+	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
+
+	mutex_lock(&streamlabs_wdt->lock);
+	/*
+	 * If disconnect happens via sysfs or on rmmod, then try to stop
+	 * the watchdog. In case of physical detachment of the device this call
+	 * will fail but we continue.
+	 */
+	if (!nowayout)
+		__usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_STOP);
+	/* Stop sending (new) messages to the device */
+	streamlabs_wdt->intf = NULL;
+	mutex_unlock(&streamlabs_wdt->lock);
+}
+
+static const struct usb_device_id usb_streamlabs_wdt_device_table[] = {
+	{ USB_DEVICE(USB_STREAMLABS_WATCHDOG_VENDOR, USB_STREAMLABS_WATCHDOG_PRODUCT) },
+	{ }	/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, usb_streamlabs_wdt_device_table);
+
+static struct usb_driver usb_streamlabs_wdt_driver = {
+	.name		= DRIVER_NAME,
+	.probe		= usb_streamlabs_wdt_probe,
+	.disconnect	= usb_streamlabs_wdt_disconnect,
+	.suspend	= usb_streamlabs_wdt_suspend,
+	.resume		= usb_streamlabs_wdt_resume,
+	.reset_resume	= usb_streamlabs_wdt_resume,
+	.id_table	= usb_streamlabs_wdt_device_table,
+	.soft_unbind	= 1,
+};
+
+module_usb_driver(usb_streamlabs_wdt_driver);
-- 
2.36.1

