Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE24B4CC42A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiCCRlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiCCRlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:41:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 443F41A1C40
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646329215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zD9CRRokuyq4RwGr8z+E2Zq2ENImi9twRvZkoxkJfXI=;
        b=XLCOzInyOl4X7HbMkAjEUupvv4+jVduQw5F3w5D5Z38xeinx5IQ9jQEWktHLQ3hLOC/6Bd
        /wuOOigrmLgtYb8LN4GOExbP35sVlg+bcBhqhlwKw9+zYuq0nIdYJYy/zVp1V+My02I8DS
        7tLttxJhtA1oPJ/AGeWT7ViDs0BJzXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-3hHfExraPP2WpGqQXUooZg-1; Thu, 03 Mar 2022 12:40:12 -0500
X-MC-Unique: 3hHfExraPP2WpGqQXUooZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B45C61854E21;
        Thu,  3 Mar 2022 17:40:10 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.9.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0E63804EA;
        Thu,  3 Mar 2022 17:39:56 +0000 (UTC)
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
Subject: [PATCH v7 3/6] drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT display driver
Date:   Thu,  3 Mar 2022 12:39:32 -0500
Message-Id: <20220303173935.100622-4-cmirabil@redhat.com>
In-Reply-To: <20220303173935.100622-1-cmirabil@redhat.com>
References: <20220303173935.100622-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the driver for the 8x8 RGB LED matrix display
on the Sense HAT. It appears as a character device named sense-hat
in /dev/. That special file is 128 bytes large and contains 64
RGB565 triples (2 bytes each) one for each pixel.

Co-developed-by: Daniel Bauman <dbauman@redhat.com>
Signed-off-by: Daniel Bauman <dbauman@redhat.com>
Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 drivers/auxdisplay/Kconfig            |   8 ++
 drivers/auxdisplay/Makefile           |   1 +
 drivers/auxdisplay/sensehat-display.c | 188 ++++++++++++++++++++++++++
 3 files changed, 197 insertions(+)
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
index 000000000000..56d013d12293
--- /dev/null
+++ b/drivers/auxdisplay/sensehat-display.c
@@ -0,0 +1,188 @@
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
+
+struct sensehat_display {
+	struct platform_device *pdev;
+	struct miscdevice mdev;
+	struct mutex rw_mtx;
+	struct {
+		u16 b : 5, u : 1, g : 5, r : 5;
+	} vmem[8][8];
+	struct regmap *regmap;
+};
+
+#define VMEM_SIZE sizeof_field(struct sensehat_display, vmem)
+
+static void sensehat_update_display(struct sensehat_display *display)
+{
+	int i, j, ret;
+	u8 temp[8][3][8];
+
+	for (i = 0; i < 8; ++i) {
+		for (j = 0; j < 8; ++j)
+			temp[i][0][j] = display->vmem[i][j].r;
+		for (j = 0; j < 8; ++j)
+			temp[i][1][j] = display->vmem[i][j].g;
+		for (j = 0; j < 8; ++j)
+			temp[i][2][j] = display->vmem[i][j].b;
+	}
+
+	ret = regmap_bulk_write(display->regmap, DISPLAY_SMB_REG, temp,
+				sizeof(temp));
+	if (ret < 0)
+		dev_err(&display->pdev->dev,
+			"Update to 8x8 LED matrix display failed");
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
+	if (copy_to_user(buf, *f_pos + (char *)sensehat_display->vmem, count))
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
+	if (copy_from_user(*f_pos + (char *)sensehat_display->vmem, buf, count))
+		goto out;
+	sensehat_update_display(sensehat_display);
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
+
+	sensehat_display->pdev = pdev;
+
+	dev_set_drvdata(&pdev->dev, sensehat_display);
+
+	sensehat_display->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+
+	memset(sensehat_display->vmem, 0, VMEM_SIZE);
+
+	mutex_init(&sensehat_display->rw_mtx);
+
+	sensehat_update_display(sensehat_display);
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
+MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
+MODULE_LICENSE("GPL");
-- 
2.31.1

