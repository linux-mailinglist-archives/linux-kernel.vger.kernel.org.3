Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5147A87D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhLTLT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhLTLTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:19:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56694C061574;
        Mon, 20 Dec 2021 03:19:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15DF6B80E4C;
        Mon, 20 Dec 2021 11:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCFFC36AE9;
        Mon, 20 Dec 2021 11:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639999161;
        bh=10FVIZPMYhnXccQdS0HX0uRmyH8OdT7D1W/gC+9tVhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVlBxoeJETuF3NxpS08hY0UH3u8XKGX1VVG44tZC6YDInyNp1/l57N1YFWDsZurav
         GSYBtKNTEjLUdERQV+dtqEV+PyRONFZiXK/GapObOzOtUwBs5I/rP7lps68aFja1Ds
         uW70j3g23/95pMbjtKl31dC3dcLx7sy7PzhrxYGQR+O3FjG7vBC50rAXAHu/LYW/98
         QETUgAX0wvmBXqolJB/8XaRxxHm+PvN1sgVA6YwVv8Ye5tkxsCq9lwYWiU0L4ZJjX8
         m62Rx61bwKibUPBvb6AgeorF9pmrz93EpR3YjUdcqKVwjLEXv7ESxnVZK9NdOb8oXh
         RT5ETJx6nJZqQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mzGhH-00063A-0O; Mon, 20 Dec 2021 12:19:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Marc Ferland <ferlandm@amotus.ca>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] gnss: add USB support
Date:   Mon, 20 Dec 2021 12:19:00 +0100
Message-Id: <20211220111901.23206-2-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211220111901.23206-1-johan@kernel.org>
References: <20211220111901.23206-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic driver for GNSS receivers with a USB interface with two
bulk endpoints.

The driver currently assumes that the device protocol is NMEA (only) but
this can be generalised later as needed.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/Kconfig  |  11 +++
 drivers/gnss/Makefile |   3 +
 drivers/gnss/usb.c    | 209 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+)
 create mode 100644 drivers/gnss/usb.c

diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
index bd12e3d57baa..d7fe265c2869 100644
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -54,4 +54,15 @@ config GNSS_UBX_SERIAL
 
 	  If unsure, say N.
 
+config GNSS_USB
+	tristate "USB GNSS receiver support"
+	depends on USB
+	help
+	  Say Y here if you have a GNSS receiver which uses a USB interface.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gnss-usb.
+
+	  If unsure, say N.
+
 endif # GNSS
diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
index 451f11401ecc..bb2cbada3435 100644
--- a/drivers/gnss/Makefile
+++ b/drivers/gnss/Makefile
@@ -17,3 +17,6 @@ gnss-sirf-y := sirf.o
 
 obj-$(CONFIG_GNSS_UBX_SERIAL)		+= gnss-ubx.o
 gnss-ubx-y := ubx.o
+
+obj-$(CONFIG_GNSS_USB)			+= gnss-usb.o
+gnss-usb-y := usb.o
diff --git a/drivers/gnss/usb.c b/drivers/gnss/usb.c
new file mode 100644
index 000000000000..5c0251034def
--- /dev/null
+++ b/drivers/gnss/usb.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic USB GNSS receiver driver
+ *
+ * Copyright (C) 2021 Johan Hovold <johan@kernel.org>
+ */
+
+#include <linux/errno.h>
+#include <linux/gnss.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+
+#define GNSS_USB_READ_BUF_LEN	512
+#define GNSS_USB_WRITE_TIMEOUT	1000
+
+static const struct usb_device_id gnss_usb_id_table[] = {
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, gnss_usb_id_table);
+
+struct gnss_usb {
+	struct usb_device *udev;
+	struct usb_interface *intf;
+	struct gnss_device *gdev;
+	struct urb *read_urb;
+	unsigned int write_pipe;
+};
+
+static void gnss_usb_rx_complete(struct urb *urb)
+{
+	struct gnss_usb *gusb = urb->context;
+	struct gnss_device *gdev = gusb->gdev;
+	int status = urb->status;
+	int len;
+	int ret;
+
+	switch (status) {
+	case 0:
+		break;
+	case -ENOENT:
+	case -ECONNRESET:
+	case -ESHUTDOWN:
+		dev_dbg(&gdev->dev, "urb stopped: %d\n", status);
+		return;
+	case -EPIPE:
+		dev_err(&gdev->dev, "urb stopped: %d\n", status);
+		return;
+	default:
+		dev_dbg(&gdev->dev, "nonzero urb status: %d\n", status);
+		goto resubmit;
+	}
+
+	len = urb->actual_length;
+	if (len == 0)
+		goto resubmit;
+
+	ret = gnss_insert_raw(gdev, urb->transfer_buffer, len);
+	if (ret < len)
+		dev_dbg(&gdev->dev, "dropped %d bytes\n", len - ret);
+resubmit:
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (ret && ret != -EPERM && ret != -ENODEV)
+		dev_err(&gdev->dev, "failed to resubmit urb: %d\n", ret);
+}
+
+static int gnss_usb_open(struct gnss_device *gdev)
+{
+	struct gnss_usb *gusb = gnss_get_drvdata(gdev);
+	int ret;
+
+	ret = usb_submit_urb(gusb->read_urb, GFP_KERNEL);
+	if (ret) {
+		if (ret != -EPERM && ret != -ENODEV)
+			dev_err(&gdev->dev, "failed to submit urb: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void gnss_usb_close(struct gnss_device *gdev)
+{
+	struct gnss_usb *gusb = gnss_get_drvdata(gdev);
+
+	usb_kill_urb(gusb->read_urb);
+}
+
+static int gnss_usb_write_raw(struct gnss_device *gdev,
+		const unsigned char *buf, size_t count)
+{
+	struct gnss_usb *gusb = gnss_get_drvdata(gdev);
+	void *tbuf;
+	int ret;
+
+	tbuf = kmemdup(buf, count, GFP_KERNEL);
+	if (!tbuf)
+		return -ENOMEM;
+
+	ret = usb_bulk_msg(gusb->udev, gusb->write_pipe, tbuf, count, NULL,
+			GNSS_USB_WRITE_TIMEOUT);
+	kfree(tbuf);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct gnss_operations gnss_usb_gnss_ops = {
+	.open		= gnss_usb_open,
+	.close		= gnss_usb_close,
+	.write_raw	= gnss_usb_write_raw,
+};
+
+static int gnss_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct usb_endpoint_descriptor *in, *out;
+	struct gnss_device *gdev;
+	struct gnss_usb *gusb;
+	struct urb *urb;
+	size_t buf_len;
+	void *buf;
+	int ret;
+
+	ret = usb_find_common_endpoints(intf->cur_altsetting, &in, &out, NULL,
+			NULL);
+	if (ret)
+		return ret;
+
+	gusb = kzalloc(sizeof(*gusb), GFP_KERNEL);
+	if (!gusb)
+		return -ENOMEM;
+
+	gdev = gnss_allocate_device(&intf->dev);
+	if (!gdev) {
+		ret = -ENOMEM;
+		goto err_free_gusb;
+	}
+
+	gdev->ops = &gnss_usb_gnss_ops;
+	gdev->type = GNSS_TYPE_NMEA;
+	gnss_set_drvdata(gdev, gusb);
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		goto err_put_gdev;
+
+	buf_len = max(usb_endpoint_maxp(in), GNSS_USB_READ_BUF_LEN);
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		goto err_free_urb;
+
+	usb_fill_bulk_urb(urb, udev,
+			usb_rcvbulkpipe(udev, usb_endpoint_num(in)),
+			buf, buf_len, gnss_usb_rx_complete, gusb);
+
+	gusb->intf = intf;
+	gusb->udev = udev;
+	gusb->gdev = gdev;
+	gusb->read_urb = urb;
+	gusb->write_pipe = usb_sndbulkpipe(udev, usb_endpoint_num(out));
+
+	ret = gnss_register_device(gdev);
+	if (ret)
+		goto err_free_buf;
+
+	usb_set_intfdata(intf, gusb);
+
+	return 0;
+
+err_free_buf:
+	kfree(buf);
+err_free_urb:
+	usb_free_urb(urb);
+err_put_gdev:
+	gnss_put_device(gdev);
+err_free_gusb:
+	kfree(gusb);
+
+	return ret;
+}
+
+static void gnss_usb_disconnect(struct usb_interface *intf)
+{
+	struct gnss_usb *gusb = usb_get_intfdata(intf);
+
+	gnss_deregister_device(gusb->gdev);
+
+	kfree(gusb->read_urb->transfer_buffer);
+	usb_free_urb(gusb->read_urb);
+	gnss_put_device(gusb->gdev);
+	kfree(gusb);
+}
+
+static struct usb_driver gnss_usb_driver = {
+	.name		= "gnss-usb",
+	.probe		= gnss_usb_probe,
+	.disconnect	= gnss_usb_disconnect,
+	.id_table	= gnss_usb_id_table,
+};
+module_usb_driver(gnss_usb_driver);
+
+MODULE_AUTHOR("Johan Hovold <johan@kernel.org>");
+MODULE_DESCRIPTION("Generic USB GNSS receiver driver");
+MODULE_LICENSE("GPL v2");
-- 
2.32.0

