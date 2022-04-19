Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C405507B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357786AbiDSUzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357760AbiDSUz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16F3B3F8B5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650401562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lACn+sayb3RZanl5LMS+97tFXYXxnPqJYnAtULr0Juc=;
        b=TSJl+bK13hL/fxOQPs+E2iSrVK+CnIUvVhHfQDwACobDjtuCi0lvKvH3oLrmXci0m6CSRF
        D0np1rDJqE2TT7yxrbB+Mv/LzVddpPJUMBZZm1cos6c+xIt5SXY9ydlK7PKrFdp9dB1ohU
        tvPinPaAFA18e8R60IMyO5Nt8gDlr3s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-vH8Dj6FfNF20HaiDl3evbQ-1; Tue, 19 Apr 2022 16:52:39 -0400
X-MC-Unique: vH8Dj6FfNF20HaiDl3evbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACEAE811E83;
        Tue, 19 Apr 2022 20:52:25 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 305242166B4F;
        Tue, 19 Apr 2022 20:52:25 +0000 (UTC)
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
        Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH v9 3/6] drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT display driver
Date:   Tue, 19 Apr 2022 16:51:55 -0400
Message-Id: <20220419205158.28088-4-cmirabil@redhat.com>
In-Reply-To: <20220419205158.28088-1-cmirabil@redhat.com>
References: <20220419205158.28088-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the driver for the 8x8 RGB LED matrix display
on the Sense HAT. It appears as a character device named sense-hat
in /dev/. That special file is 192 bytes large and contains 64
RGB triplets (3 bytes each) one for each pixel in row major order.

Co-developed-by: Daniel Bauman <dbauman@redhat.com>
Signed-off-by: Daniel Bauman <dbauman@redhat.com>
Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 drivers/auxdisplay/Kconfig            |   8 +
 drivers/auxdisplay/Makefile           |   1 +
 drivers/auxdisplay/sensehat-display.c | 205 ++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 drivers/auxdisplay/sensehat-display.c

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
index 000000000000..9faaee5cde8a
--- /dev/null
+++ b/drivers/auxdisplay/sensehat-display.c
@@ -0,0 +1,205 @@
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
+
+#define DISPLAY_SMB_REG 0x00
+#define RGB_555_MASK 0x1f
+#define NUM_LEDS 8
+#define NUM_CHANNELS 3
+
+struct sensehat_display {
+	struct platform_device *pdev;
+	struct miscdevice mdev;
+	struct mutex rw_mtx;
+	u8 vmem[NUM_LEDS][NUM_LEDS][NUM_CHANNELS];
+	struct regmap *regmap;
+};
+
+#define VMEM_SIZE sizeof_field(struct sensehat_display, vmem)
+
+
+static int sensehat_update_display(struct sensehat_display *display)
+{
+	int i, j, k, ret;
+	u8 buff[NUM_LEDS][NUM_CHANNELS][NUM_LEDS];
+
+	for (i = 0; i < NUM_LEDS; ++i)
+		for (j = 0; j < NUM_LEDS; ++j)
+			for (k = 0; k < NUM_CHANNELS; ++k)
+				buff[i][k][j] =
+					display->vmem[i][j][k] & RGB_555_MASK;
+
+	ret = regmap_bulk_write(display->regmap, DISPLAY_SMB_REG, buff,
+				VMEM_SIZE);
+	if (ret < 0)
+		dev_err(&display->pdev->dev,
+			"Update to 8x8 LED matrix display failed");
+	return ret;
+}
+
+static loff_t sensehat_display_llseek(struct file *filp, loff_t offset,
+				      int whence)
+{
+	return fixed_size_llseek(filp, offset, whence, VMEM_SIZE);
+}
+
+static ssize_t sensehat_display_read(struct file *filp, char __user *buf,
+				     size_t count, loff_t *f_pos)
+{
+	struct sensehat_display *sensehat_display =
+		container_of(filp->private_data, struct sensehat_display, mdev);
+	ssize_t ret = -EFAULT;
+
+	if (*f_pos < 0 || *f_pos >= VMEM_SIZE)
+		return 0;
+	count = min_t(size_t, count, VMEM_SIZE - *f_pos);
+
+	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
+		return -ERESTARTSYS;
+	if (copy_to_user(buf, *f_pos + (u8 *)sensehat_display->vmem, count))
+		goto out;
+	*f_pos += count;
+	ret = count;
+out:
+	mutex_unlock(&sensehat_display->rw_mtx);
+	return ret;
+}
+
+static ssize_t sensehat_display_write(struct file *filp, const char __user *buf,
+				      size_t count, loff_t *f_pos)
+{
+	struct sensehat_display *sensehat_display =
+		container_of(filp->private_data, struct sensehat_display, mdev);
+	int ret = -EFAULT;
+
+	if (*f_pos < 0 || *f_pos >= VMEM_SIZE)
+		return -EFBIG;
+	count = min_t(size_t, count, VMEM_SIZE - *f_pos);
+
+	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
+		return -ERESTARTSYS;
+	if (copy_from_user(*f_pos + (u8 *)sensehat_display->vmem, buf, count))
+		goto out;
+	ret = sensehat_update_display(sensehat_display);
+	if (ret < 0) {
+		ret = -EIO;
+		goto out;
+	}
+	*f_pos += count;
+	ret = count;
+out:
+	mutex_unlock(&sensehat_display->rw_mtx);
+	return ret;
+}
+
+static const struct file_operations sensehat_display_fops = {
+	.owner = THIS_MODULE,
+	.llseek = sensehat_display_llseek,
+	.read = sensehat_display_read,
+	.write = sensehat_display_write,
+};
+
+static int sensehat_display_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	struct sensehat_display *sensehat_display =
+		devm_kmalloc(&pdev->dev, sizeof(*sensehat_display), GFP_KERNEL);
+	if (!sensehat_display)
+		return -ENOMEM;
+
+	sensehat_display->pdev = pdev;
+
+	dev_set_drvdata(&pdev->dev, sensehat_display);
+
+	sensehat_display->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!sensehat_display->regmap) {
+		dev_err(&pdev->dev,
+			"unable to get sensehat regmap");
+		return -ENODEV;
+	}
+
+	memset(sensehat_display->vmem, 0, VMEM_SIZE);
+
+	mutex_init(&sensehat_display->rw_mtx);
+
+	ret = sensehat_update_display(sensehat_display);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"Could not communicate with sensehat");
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
+			"Could not register 8x8 LED matrix display.");
+		return ret;
+	}
+
+	dev_info(&pdev->dev,
+		 "8x8 LED matrix display registered with minor number %i",
+		 sensehat_display->mdev.minor);
+
+	return 0;
+}
+
+static int sensehat_display_remove(struct platform_device *pdev)
+{
+	struct sensehat_display *sensehat_display = dev_get_drvdata(&pdev->dev);
+
+	misc_deregister(&sensehat_display->mdev);
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
+	.remove = sensehat_display_remove,
+	.driver = {
+		.name = "sensehat-display",
+		.of_match_table = sensehat_display_device_id,
+	},
+};
+
+module_platform_driver(sensehat_display_driver);
+
+MODULE_DESCRIPTION("Raspberry Pi Sense HAT 8x8 LED matrix display driver");
+MODULE_AUTHOR("Charles Mirabile <cmirabil@redhat.com>");
+MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
+MODULE_LICENSE("GPL");
-- 
2.31.1

