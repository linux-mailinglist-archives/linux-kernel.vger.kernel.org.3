Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90D74A7CD7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348551AbiBCA0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:26:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348542AbiBCA0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643847962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYslS7m5SgmQPPLdHBGtpXGXzgncNnW0l6Vv23WJHmw=;
        b=JRv6dCAWlvkdPsCiZOZhhkKynX1bq065tJPjOsaGZsm6Iw4oy4Zw6uO6e3nYnzb9tWJQ68
        LbXP30dN4bmgAOR6bZqr6XXQRmuaqo9c3uxTjzP8gGt7zDbTTTlP9cDOMe8i755Q1AoXRn
        W4ZRkg7OkVQOIQ7vE6dVm3YPXSmrM40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-S_yJ64IWNVSmCedFPMDJIw-1; Wed, 02 Feb 2022 19:25:59 -0500
X-MC-Unique: S_yJ64IWNVSmCedFPMDJIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4BD21091DA7;
        Thu,  3 Feb 2022 00:25:57 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A7844EC7B;
        Thu,  3 Feb 2022 00:25:51 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Miguel Ojeda <ojeda@kernel.org>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Daniel Bauman <dbauman@redhat.com>
Subject: [PATCH 3/6] drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT display driver
Date:   Wed,  2 Feb 2022 19:25:18 -0500
Message-Id: <20220203002521.162878-4-cmirabil@redhat.com>
In-Reply-To: <20220203002521.162878-1-cmirabil@redhat.com>
References: <20220203002521.162878-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the driver for the 8x8 RGB LED matrix display
on the Sense HAT. It appears as a character device named sense-hat
in /dev/. That special file is 192 bytes large and contains one byte
for each color channel of each pixel. The overall layout is:

    col 1       col 8
      |           |
      v           v
0x00: R   . . .   R \
0x08: G   . . .   G |> row 1
0x10: B   . . .   B /
      .   .       .
...   .     .     .
      .       .   .
0xA8: R   . . .   R \
0xB0: G   . . .   G |> row 8
0xB8: G   . . .   G /

Each channel may have any value between 0 and 31 (larger values are
wrapped) and are translated by a gamma table before being send to the
device to provide a linear experience of brightness (the gamma table
can be modified or reset using an ioctl call on the file). The constants
for the ioctl are in the sensehat.h header also added in this patch.

Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Co-developed-by: Daniel Bauman <dbauman@redhat.com>
Signed-off-by: Daniel Bauman <dbauman@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 drivers/auxdisplay/Kconfig            |   8 +
 drivers/auxdisplay/Makefile           |   1 +
 drivers/auxdisplay/sensehat-display.c | 264 ++++++++++++++++++++++++++
 include/uapi/linux/sensehat.h         |  28 +++
 4 files changed, 301 insertions(+)
 create mode 100644 drivers/auxdisplay/sensehat-display.c
 create mode 100644 include/uapi/linux/sensehat.h

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 64012cda4d12..9bad1aade7a0 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -203,6 +203,14 @@ config ARM_CHARLCD
 	  line and the Linux version on the second line, but that's
 	  still useful.
 
+config SENSEHAT_DISPLAY
+	tristate "Raspberry Pi Sense HAT display driver"
+	depends on I2C
+	select MFD_SIMPLE_MFD_I2C
+	help
+	 This is a driver for the Raspberry Pi Sensehat 8x8 RBG-LED matrix
+	 you can access it as a misc device at /dev/sense-hat
+
 menuconfig PARPORT_PANEL
 	tristate "Parallel port LCD/Keypad Panel support"
 	depends on PARPORT
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index 6968ed4d3f0a..30b2b7934046 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_HT16K33)		+= ht16k33.o
 obj-$(CONFIG_PARPORT_PANEL)	+= panel.o
 obj-$(CONFIG_LCD2S)		+= lcd2s.o
 obj-$(CONFIG_LINEDISP)		+= line-display.o
+obj-$(CONFIG_SENSEHAT_DISPLAY)	+= sensehat-display.o
diff --git a/drivers/auxdisplay/sensehat-display.c b/drivers/auxdisplay/sensehat-display.c
new file mode 100644
index 000000000000..08b397a544f0
--- /dev/null
+++ b/drivers/auxdisplay/sensehat-display.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Raspberry Pi Sense HAT 8x8 LED matrix display driver
+ * http://raspberrypi.org
+ *
+ * Copyright (C) 2015 Raspberry Pi
+ * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ *
+ * Original Author: Serge Schneider
+ * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/miscdevice.h>
+#include <linux/regmap.h>
+#include <linux/property.h>
+#include <linux/sensehat.h>
+
+#define GAMMA_SIZE 32
+#define VMEM_SIZE 192
+
+struct sensehat_display {
+	struct platform_device *pdev;
+	struct miscdevice mdev;
+	struct mutex rw_mtx;
+	u8 gamma[GAMMA_SIZE];
+	u8 vmem[VMEM_SIZE];
+	u32 display_register;
+};
+
+static bool lowlight;
+module_param(lowlight, bool, 0);
+MODULE_PARM_DESC(lowlight, "Reduce LED matrix brightness to one third");
+
+static const u8 gamma_presets[][GAMMA_SIZE] = {
+	[SENSEHAT_GAMMA_DEFAULT] = {
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01,
+		0x02, 0x02, 0x03, 0x03, 0x04, 0x05, 0x06, 0x07,
+		0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0E, 0x0F, 0x11,
+		0x12, 0x14, 0x15, 0x17, 0x19, 0x1B, 0x1D, 0x1F,
+	},
+	[SENSEHAT_GAMMA_LOWLIGHT] = {
+		0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
+		0x01, 0x01, 0x01, 0x01, 0x01, 0x02, 0x02, 0x02,
+		0x03, 0x03, 0x03, 0x04, 0x04, 0x05, 0x05, 0x06,
+		0x06, 0x07, 0x07, 0x08, 0x08, 0x09, 0x0A, 0x0A,
+	},
+};
+
+static void sensehat_update_display(struct sensehat_display *display)
+{
+	int i, ret;
+	struct regmap *regmap = dev_get_regmap(display->pdev->dev.parent, NULL);
+	u8 temp[VMEM_SIZE];
+
+	for (i = 0; i < VMEM_SIZE; ++i)
+		temp[i] = display->gamma[display->vmem[i] & 0x1f];
+
+	ret = regmap_bulk_write(regmap, display->display_register, temp,
+				VMEM_SIZE);
+	if (ret < 0)
+		dev_err(&display->pdev->dev,
+			"Update to 8x8 LED matrix display failed");
+}
+
+static loff_t sensehat_display_llseek(struct file *filp, loff_t offset,
+				      int whence)
+{
+	loff_t base, pos;
+
+	switch (whence) {
+	case SEEK_SET:
+		base = 0;
+		break;
+	case SEEK_CUR:
+		base = filp->f_pos;
+		break;
+	case SEEK_END:
+		base = VMEM_SIZE;
+		break;
+	default:
+		return -EINVAL;
+	}
+	pos = base + offset;
+	if (pos < 0 || pos >= VMEM_SIZE)
+		return -EINVAL;
+	filp->f_pos = pos;
+	return base;
+}
+
+static ssize_t sensehat_display_read(struct file *filp, char __user *buf,
+				     size_t count, loff_t *f_pos)
+{
+	struct sensehat_display *sensehat_display =
+		container_of(filp->private_data, struct sensehat_display, mdev);
+	ssize_t retval = -EFAULT;
+
+	if (*f_pos >= VMEM_SIZE)
+		return 0;
+	if (*f_pos + count > VMEM_SIZE)
+		count = VMEM_SIZE - *f_pos;
+	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
+		return -ERESTARTSYS;
+	if (copy_to_user(buf, sensehat_display->vmem + *f_pos, count))
+		goto out;
+	*f_pos += count;
+	retval = count;
+out:
+	mutex_unlock(&sensehat_display->rw_mtx);
+	return retval;
+}
+
+static ssize_t sensehat_display_write(struct file *filp, const char __user *buf,
+				      size_t count, loff_t *f_pos)
+{
+	struct sensehat_display *sensehat_display =
+		container_of(filp->private_data, struct sensehat_display, mdev);
+	int ret = count;
+
+	if (*f_pos >= VMEM_SIZE)
+		return -EFBIG;
+	if (*f_pos + count > VMEM_SIZE)
+		count = VMEM_SIZE - *f_pos;
+	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
+		return -ERESTARTSYS;
+	if (copy_from_user(sensehat_display->vmem + *f_pos, buf, count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	sensehat_update_display(sensehat_display);
+	*f_pos += count;
+out:
+	mutex_unlock(&sensehat_display->rw_mtx);
+	return ret;
+}
+
+static long sensehat_display_ioctl(struct file *filp, unsigned int cmd,
+				   unsigned long arg)
+{
+	struct sensehat_display *sensehat_display =
+		container_of(filp->private_data, struct sensehat_display, mdev);
+	void __user *user_ptr = (void __user *)arg;
+	int i, ret = 0;
+
+	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
+		return -ERESTARTSYS;
+	switch (cmd) {
+	case SENSEDISP_IOGET_GAMMA:
+		if (copy_to_user(user_ptr, sensehat_display->gamma, GAMMA_SIZE))
+			ret = -EFAULT;
+		goto no_update;
+	case SENSEDISP_IOSET_GAMMA:
+		if (copy_from_user(sensehat_display->gamma, user_ptr,
+				   GAMMA_SIZE))
+			ret = -EFAULT;
+		break;
+	case SENSEDISP_IORESET_GAMMA:
+		if (arg >= SENSEHAT_GAMMA_PRESET_COUNT) {
+			ret = -EINVAL;
+			goto no_update;
+		}
+		memcpy(sensehat_display->gamma, gamma_presets[arg], GAMMA_SIZE);
+		goto no_check;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	for (i = 0; i < GAMMA_SIZE; ++i)
+		sensehat_display->gamma[i] &= 0x1f;
+no_check:
+	sensehat_update_display(sensehat_display);
+no_update:
+	mutex_unlock(&sensehat_display->rw_mtx);
+	return ret;
+}
+
+static const struct file_operations sensehat_display_fops = {
+	.owner = THIS_MODULE,
+	.llseek = sensehat_display_llseek,
+	.read = sensehat_display_read,
+	.write = sensehat_display_write,
+	.unlocked_ioctl = sensehat_display_ioctl,
+};
+
+static int sensehat_display_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	struct sensehat_display *sensehat_display =
+		devm_kzalloc(&pdev->dev, sizeof(*sensehat_display), GFP_KERNEL);
+
+	sensehat_display->pdev = pdev;
+
+	memcpy(sensehat_display->gamma, gamma_presets[lowlight], GAMMA_SIZE);
+
+	memset(sensehat_display->vmem, 0, VMEM_SIZE);
+
+	mutex_init(&sensehat_display->rw_mtx);
+
+	ret = device_property_read_u32(&pdev->dev, "reg",
+				       &sensehat_display->display_register);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not read register property.\n");
+		return ret;
+	}
+
+	sensehat_display->mdev = (struct miscdevice){
+		.minor = MISC_DYNAMIC_MINOR,
+		.name = "sense-hat",
+		.mode = 0666,
+		.fops = &sensehat_display_fops,
+	};
+
+	ret = misc_register(&sensehat_display->mdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"Could not register 8x8 LED matrix display.\n");
+		return ret;
+	}
+
+	ret = devm_add_action(&pdev->dev, (void *)misc_deregister,
+			      &sensehat_display->mdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Could not add misc device to devm\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev,
+		 "8x8 LED matrix display registered with minor number %i",
+		 sensehat_display->mdev.minor);
+
+	sensehat_update_display(sensehat_display);
+	return 0;
+}
+
+static const struct of_device_id sensehat_display_device_id[] = {
+	{ .compatible = "raspberrypi,sensehat-display" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sensehat_display_device_id);
+
+static struct platform_driver sensehat_display_driver = {
+	.probe = sensehat_display_probe,
+	.driver = {
+		.name = "sensehat-display",
+		.of_match_table = sensehat_display_device_id,
+	},
+};
+
+module_platform_driver(sensehat_display_driver);
+
+MODULE_DESCRIPTION("Raspberry Pi Sense HAT 8x8 LED matrix display driver");
+MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/sensehat.h b/include/uapi/linux/sensehat.h
new file mode 100644
index 000000000000..cae07568a5eb
--- /dev/null
+++ b/include/uapi/linux/sensehat.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
+/*
+ * Raspberry Pi Sense HAT core driver
+ * http://raspberrypi.org
+ *
+ * Copyright (C) 2015 Raspberry Pi
+ * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ *
+ * Original Author: Serge Schneider
+ * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ */
+
+#ifndef _UAPILINUX_SENSEHAT_H_
+#define _UAPILINUX_SENSEHAT_H_
+
+#define SENSEDISP_IOC_MAGIC 0xF1
+
+#define SENSEDISP_IOGET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 0)
+#define SENSEDISP_IOSET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 1)
+#define SENSEDISP_IORESET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 2)
+
+enum gamma_preset {
+	SENSEHAT_GAMMA_DEFAULT = 0,
+	SENSEHAT_GAMMA_LOWLIGHT,
+	SENSEHAT_GAMMA_PRESET_COUNT,
+};
+
+#endif
-- 
2.31.1

