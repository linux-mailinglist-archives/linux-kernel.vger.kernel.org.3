Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04DB4E8589
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 06:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiC0E0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 00:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiC0E0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 00:26:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87CB655B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:25:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso12382936pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mN/niLqfJ8QDbdjdXnq6QvtqWR1le0UX2YK45LPvIhw=;
        b=psTa7kCrhs4tMyx6aEJsEE3cDJP+UPQdD0Lch69/a7lzjML2Xza5ISY9n2ydrLuUBx
         tQraN+burhJmM7ZP0axzc6BRZ3dOEE+MwX9j7ISk0Ujb6a/L/u4mckQz0I7C1MN/XD6X
         Rxw3T3F8tPmideve0ihku0lwyxveBMQ79h30bdwH364fRmyC6X75A6yIY9lcmrqcvIvl
         8FOCylhUlgQ94pyaXhicf6GXcxGhJ/PvD4qbtUdVds8qOnqmBUnAms6vJTHDe3/t0bFW
         q2V8lPmu+quyv452vmpnapX8XyY8PdtP4xrnlU5QhzD7hys7cfW6J2gLVgC7iri/HXXB
         0oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mN/niLqfJ8QDbdjdXnq6QvtqWR1le0UX2YK45LPvIhw=;
        b=sii8IOCRayA5nqUzZ2XcLMRcSq18bPVxJMZ3um+0Giw03pl4TKw/mFoJa5I4HOpI8A
         +WNUH9rTmdGmgZFVI+whX7I2R2mt6xixBCp0P0TOzecETydQ/O2C+z0MtvBRg9/az5eL
         WIKcwxWuDAfykK8/JWcxjMoQvaOlt0Ox1G/ul/YFkpsrRNiKJYaRGZ+8um4ujefUgO3a
         FPi5JBcaxiZV5ZInonHAGBwytLTFF+dnu8HeBWTsqkrLAZxnqpjvWrPg3+5mh2WTyGtH
         GvVUpXCMrbpCRpNRm2kvhcZvw92D5i025YNNmIzT7pQ+F2PopuiOzyH9OKY8D4QwSLvy
         k9xA==
X-Gm-Message-State: AOAM531LwxG3rGSInpwZvZksFrSbio7irqIK0GCxoTu9sg8CSUxJHATW
        lwPB54Rep4aQTkwVQZbUnl1g7crDT+QkQA==
X-Google-Smtp-Source: ABdhPJwTTpHkx0BMvjAsuM3ICGN5yMdaqyTnki5O7mZf6YoRqZ+ONZjWQOCmcsAyXNIQSrcyXbKUsA==
X-Received: by 2002:a17:902:d48d:b0:154:54f6:9384 with SMTP id c13-20020a170902d48d00b0015454f69384mr20077297plg.83.1648355104762;
        Sat, 26 Mar 2022 21:25:04 -0700 (PDT)
Received: from yusufkhan-MS-7B17.lan ([24.17.200.29])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b0038085c0a9d7sm9121038pgo.49.2022.03.26.21.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 21:25:04 -0700 (PDT)
From:   Yusuf Khan <yusisamerican@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        gregkh@linuxfoundation.org, javier@javigon.com, arnd@arndb.de,
        will@kernel.org, axboe@kernel.dk,
        Yusuf Khan <yusisamerican@gmail.com>,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>
Subject: [PATCH v9] drivers: ddcci: upstream DDCCI driver
Date:   Sat, 26 Mar 2022 21:24:58 -0700
Message-Id: <20220327042459.141515-3-yusisamerican@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220327042459.141515-1-yusisamerican@gmail.com>
References: <20220327042459.141515-1-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the backlight driver that utilizes the DDCCI
protocol to add backlight support.

Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
Signed-off-by: Christoph Grenz <christophg+lkml@grenz-bonn.de>
---
 drivers/video/backlight/Kconfig           |  11 +
 drivers/video/backlight/Makefile          |   1 +
 drivers/video/backlight/ddcci-backlight.c | 411 ++++++++++++++++++++++
 3 files changed, 423 insertions(+)
 create mode 100644 drivers/video/backlight/ddcci-backlight.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index e32694c13da5..7a26088c3c3f 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -289,6 +289,17 @@ config BACKLIGHT_QCOM_WLED
 	  If you have the Qualcomm PMIC, say Y to enable a driver for the
 	  WLED block. Currently it supports PM8941 and PMI8998.
 
+config BACKLIGHT_DDCCI
+	tristate "DDCCI Backlight Driver"
+	depends on DDCCI
+	help
+	  If you have a DDC/CI supporing monitor, say Y to enable a driver
+	  to control its backlight using DDC/CI. This could be useful if
+	  your monitor does not include a backlight driver. For this to be
+	  useful you need to enable DDCCI support which can be found in
+	  Device Drivers -> Character devices and that further depends on
+	  I2C.
+
 config BACKLIGHT_RT4831
 	tristate "Richtek RT4831 Backlight Driver"
 	depends on MFD_RT4831
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index cae2c83422ae..7bfb6e506b35 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_BACKLIGHT_WM831X)		+= wm831x_bl.o
 obj-$(CONFIG_BACKLIGHT_ARCXCNN) 	+= arcxcnn_bl.o
 obj-$(CONFIG_BACKLIGHT_RAVE_SP)		+= rave-sp-backlight.o
 obj-$(CONFIG_BACKLIGHT_LED)		+= led_bl.o
+obj-$(CONFIG_BACKLIGHT_DDCCI)		+= ddcci-backlight.o
diff --git a/drivers/video/backlight/ddcci-backlight.c b/drivers/video/backlight/ddcci-backlight.c
new file mode 100644
index 000000000000..d37eb142311d
--- /dev/null
+++ b/drivers/video/backlight/ddcci-backlight.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  DDC/CI monitor backlight driver
+ *
+ *  Copyright (c) 2015 Christoph Grenz
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/backlight.h>
+#include <linux/module.h>
+#include <linux/fb.h>
+#include <linux/sysfs.h>
+
+#include <linux/ddcci.h>
+
+
+#define DDCCI_COMMAND_READ	0x01	/* read ctrl value */
+#define DDCCI_REPLY_READ	0x02	/* read ctrl value reply */
+#define DDCCI_COMMAND_WRITE	0x03	/* write ctrl value */
+#define DDCCI_COMMAND_SAVE	0x0c	/* save current settings */
+
+#define DDCCI_MONITOR_LUMINANCE	0x10
+#define DDCCI_MONITOR_BACKLIGHT	0x13
+#define DDCCI_MONITOR_BL_WHITE		0x6B
+
+static bool convenience_symlink = true;
+
+struct ddcci_monitor_drv_data {
+	struct ddcci_device *device;
+	struct backlight_device *bl_dev;
+	struct device *fb_dev;
+	unsigned char used_vcp;
+};
+
+static int ddcci_monitor_writectrl(struct ddcci_device *device,
+				   unsigned char ctrl, unsigned short value)
+{
+	unsigned char buf[4];
+	int ret;
+
+	buf[0] = DDCCI_COMMAND_WRITE;
+	buf[1] = ctrl;
+	buf[2] = (value >> 8);
+	buf[3] = (value & 255);
+
+	ret = ddcci_device_write(device, true, buf, sizeof(buf));
+
+	return ret;
+}
+
+static int ddcci_monitor_readctrl(struct ddcci_device *device,
+				  unsigned char ctrl, unsigned short *value,
+				  unsigned short *maximum)
+{
+	int ret;
+	unsigned char buf[10];
+
+	buf[0] = DDCCI_COMMAND_READ;
+	buf[1] = ctrl;
+
+	ret = ddcci_device_writeread(device, true, buf, 2, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	if (ret == 0)
+		return -ENOTSUPP;
+
+	if (ret == 8 && buf[0] == DDCCI_REPLY_READ && buf[2] == ctrl) {
+		if (value)
+			*value = buf[6] * 256 + buf[7];
+
+		if (maximum)
+			*maximum = buf[4] * 256 + buf[5];
+
+		if (buf[1] == 1)
+			return -ENOTSUPP;
+		if (buf[1] != 0)
+			return -EIO;
+		return 0;
+	}
+
+	return -EIO;
+}
+
+static int ddcci_backlight_check_fb(struct backlight_device *bl,
+				   struct fb_info *info)
+{
+	struct ddcci_monitor_drv_data *drv_data = bl_get_data(bl);
+
+	return drv_data->fb_dev == NULL || drv_data->fb_dev == info->dev;
+}
+
+static int ddcci_backlight_update_status(struct backlight_device *bl)
+{
+	struct ddcci_monitor_drv_data *drv_data = bl_get_data(bl);
+	int brightness = bl->props.brightness;
+	int ret;
+
+	if (bl->props.power != FB_BLANK_UNBLANK ||
+	    bl->props.state & BL_CORE_FBBLANK)
+		brightness = 0;
+
+	ret = ddcci_monitor_writectrl(drv_data->device, drv_data->used_vcp,
+				      brightness);
+	if (ret > 0)
+		ret = 0;
+	return ret;
+}
+
+static int ddcci_backlight_get_brightness(struct backlight_device *bl)
+{
+	unsigned short value = 0, maxval = 0;
+	int ret;
+	struct ddcci_monitor_drv_data *drv_data = bl_get_data(bl);
+
+	ret = ddcci_monitor_readctrl(drv_data->device, drv_data->used_vcp,
+				     &value, &maxval);
+	if (ret < 0)
+		return ret;
+
+	bl->props.brightness = value;
+	bl->props.max_brightness = maxval;
+	ret = value;
+
+	return ret;
+}
+
+static const struct backlight_ops ddcci_backlight_ops = {
+	.options	= 0,
+	.update_status	= ddcci_backlight_update_status,
+	.get_brightness = ddcci_backlight_get_brightness,
+	.check_fb	= ddcci_backlight_check_fb,
+};
+
+static const char *ddcci_monitor_vcp_name(unsigned char vcp)
+{
+	switch (vcp) {
+	case DDCCI_MONITOR_BL_WHITE:
+		return "backlight";
+	case DDCCI_MONITOR_LUMINANCE:
+		return "luminance";
+	default:
+		return "???";
+	}
+}
+
+static const char *ddcci_monitor_next_vcp_item(const char *ptr)
+{
+	int depth = 0;
+
+	/* Sanity check */
+	if (ptr == NULL || ptr[0] == '\0')
+		return NULL;
+
+	/* Find next white space outside of parentheses */
+	while ((ptr = strpbrk(ptr, " ()"))) {
+		if (!ptr || depth == INT_MAX)
+			return NULL;
+		else if (*ptr == '(')
+			depth++;
+		else if (depth > 0) {
+			if (*ptr == ')')
+				depth--;
+		} else
+			break;
+		++ptr;
+	}
+
+	/* Skip over whitespace */
+	ptr = skip_spaces(ptr);
+
+	/* Check if we're now at the end of the list */
+	if (*ptr == '\0' || *ptr == ')')
+		return NULL;
+
+	return ptr;
+}
+
+static bool ddcci_monitor_find_vcp(unsigned char vcp, const char *s)
+{
+	const char *ptr = s;
+	char vcp_hex[3];
+
+	/* Sanity check */
+	if (s == NULL || s[0] == '\0')
+		return false;
+
+	/* Create hex representation of VCP */
+	if (snprintf(vcp_hex, 3, "%02hhX", vcp) != 2) {
+		pr_err("snprintf failed to convert to hex. This should not happen.\n");
+		return false;
+	}
+
+	/* Search for it */
+	do {
+		if (strncasecmp(vcp_hex, ptr, 2) == 0) {
+			if (ptr[2] == ' ' || ptr[2] == '(' || ptr[2] == ')')
+				return true;
+		}
+	} while ((ptr = ddcci_monitor_next_vcp_item(ptr)));
+
+	return false;
+}
+
+static int ddcci_backlight_create_symlink(struct ddcci_device *ddcci_dev)
+{
+	int i, result;
+	struct device *dev = &ddcci_dev->dev;
+	struct kernfs_node *dirent;
+
+	for (i = 0; i < 3; ++i) {
+		dev = dev->parent;
+		if (!dev) {
+			dev_dbg(&ddcci_dev->dev, "failed to create convenience symlink: ancestor device not found\n");
+			return -ENOENT;
+		}
+	}
+	dirent = sysfs_get_dirent(dev->kobj.sd, "ddcci_backlight");
+	if (dirent) {
+		sysfs_put(dirent);
+		dev_dbg(&ddcci_dev->dev, "failed to create convenience symlink: %s/ddcci_backlight already exists\n", dev_name(dev));
+		return -EEXIST;
+	}
+
+	result = sysfs_create_link(&dev->kobj, &ddcci_dev->dev.kobj, "ddcci_backlight");
+	if (result == 0)
+		dev_dbg(&ddcci_dev->dev, "created symlink %s/ddcci_backlight\n", dev_name(dev));
+	else
+		dev_info(&ddcci_dev->dev, "failed to create convenience symlink: %d\n", result);
+	return result;
+}
+
+static int ddcci_backlight_remove_symlink(struct ddcci_device *ddcci_dev)
+{
+	int i;
+	struct device *dev = &ddcci_dev->dev;
+	struct kernfs_node *dirent;
+
+	for (i = 0; i < 3; ++i) {
+		dev = dev->parent;
+		if (!dev)
+			return -ENOENT;
+	}
+	dirent = sysfs_get_dirent(dev->kobj.sd, "ddcci_backlight");
+	if (!dirent)
+		return -ENOENT;
+
+	if ((dirent->flags & KERNFS_LINK) == 0) {
+		sysfs_put(dirent);
+		dev_dbg(&ddcci_dev->dev, "won't remove %s/ddcci_backlight: not a symlink\n", dev_name(dev));
+		return -EINVAL;
+	}
+
+	if (dirent->symlink.target_kn != ddcci_dev->dev.kobj.sd) {
+		sysfs_put(dirent);
+		dev_dbg(&ddcci_dev->dev, "won't remove %s/ddcci_backlight: we are not the link target\n", dev_name(dev));
+		return -EINVAL;
+	}
+
+	sysfs_put(dirent);
+
+	sysfs_remove_link(&dev->kobj, "ddcci_backlight");
+	dev_dbg(&ddcci_dev->dev, "removed symlink %s/ddcci_backlight\n", dev_name(dev));
+	return 0;
+}
+
+static int ddcci_monitor_probe(struct ddcci_device *dev,
+			       const struct ddcci_device_id *id)
+{
+	struct ddcci_monitor_drv_data *drv_data;
+	struct backlight_properties props;
+	struct backlight_device *bl = NULL;
+	int ret = 0;
+	bool support_luminance, support_bl_white;
+	unsigned short brightness = 0, max_brightness = 0;
+	const char *vcps;
+
+	dev_dbg(&dev->dev, "probing monitor backlight device\n");
+
+	/* Get VCP list */
+	vcps = ddcci_find_capstr_item(dev->capabilities, "vcp", NULL);
+	if (IS_ERR(vcps)) {
+		dev_info(&dev->dev,
+			 "monitor doesn't provide a list of supported controls.\n");
+		support_bl_white = support_luminance = true;
+	} else {
+		/* Check VCP list for supported VCPs */
+		support_bl_white = ddcci_monitor_find_vcp(DDCCI_MONITOR_BL_WHITE, vcps);
+		support_luminance = ddcci_monitor_find_vcp(DDCCI_MONITOR_LUMINANCE, vcps);
+		/* Fallback to trying if no support is found */
+		if (!support_bl_white && !support_luminance) {
+			dev_info(&dev->dev,
+				 "monitor doesn't announce support for backlight or luminance controls.\n");
+			support_bl_white = support_luminance = true;
+		}
+	}
+
+	/* Initialize driver data structure */
+	drv_data = devm_kzalloc(&dev->dev, sizeof(struct ddcci_monitor_drv_data),
+				GFP_KERNEL);
+	if (!drv_data)
+		return -ENOMEM;
+	drv_data->device = dev;
+
+	if (support_bl_white) {
+		/* Try getting backlight level */
+		dev_dbg(&dev->dev,
+			"trying to access \"backlight level white\" control\n");
+		ret = ddcci_monitor_readctrl(drv_data->device, DDCCI_MONITOR_BL_WHITE,
+						&brightness, &max_brightness);
+		if (ret < 0) {
+			if (ret == -ENOTSUPP)
+				dev_info(&dev->dev,
+					"monitor does not support reading backlight level\n");
+			else
+				goto err_free;
+		} else {
+			drv_data->used_vcp = DDCCI_MONITOR_BL_WHITE;
+		}
+	}
+
+	if (support_luminance && !drv_data->used_vcp) {
+		/* Try getting luminance */
+		dev_dbg(&dev->dev,
+			"trying to access \"luminance\" control\n");
+		ret = ddcci_monitor_readctrl(drv_data->device, DDCCI_MONITOR_LUMINANCE,
+					     &brightness, &max_brightness);
+		if (ret < 0) {
+			if (ret == -ENOTSUPP)
+				dev_info(&dev->dev,
+					"monitor does not support reading luminance\n");
+			else
+				goto err_free;
+		} else {
+			drv_data->used_vcp = DDCCI_MONITOR_LUMINANCE;
+		}
+		drv_data->used_vcp = DDCCI_MONITOR_LUMINANCE;
+	}
+
+	if (!drv_data->used_vcp)
+		goto err_free;
+
+	/* Create brightness device */
+	memset(&props, 0, sizeof(props));
+	props.type = BACKLIGHT_RAW;
+	props.max_brightness = max_brightness;
+	props.brightness = brightness;
+	bl = devm_backlight_device_register(&dev->dev, dev_name(&dev->dev),
+					    &dev->dev, drv_data,
+					    &ddcci_backlight_ops, &props);
+	drv_data->bl_dev = bl;
+	if (IS_ERR(bl)) {
+		dev_err(&dev->dev, "failed to register backlight\n");
+		return PTR_ERR(bl);
+	}
+	dev_info(&dev->dev, "registered %s as backlight device %s\n",
+		 ddcci_monitor_vcp_name(drv_data->used_vcp),
+		 dev_name(&dev->dev));
+
+	if (convenience_symlink)
+		ddcci_backlight_create_symlink(dev);
+
+	goto end;
+err_free:
+	devm_kfree(&dev->dev, drv_data);
+end:
+	return ret;
+}
+
+static int ddcci_monitor_remove(struct ddcci_device *dev)
+{
+	dev_dbg(&dev->dev, "removing device\n");
+	ddcci_backlight_remove_symlink(dev);
+	return 0;
+}
+
+static struct ddcci_device_id ddcci_monitor_idtable[] = {
+	{ "monitor", DDCCI_ANY_ID, DDCCI_ANY_ID, DDCCI_ANY_ID, DDCCI_ANY_ID, 0 },
+	{}
+};
+
+static struct ddcci_driver ddcci_backlight_driver = {
+	.driver = {
+		.name	= "ddcci-backlight",
+		.owner	= THIS_MODULE,
+	},
+
+	.id_table	= ddcci_monitor_idtable,
+	.probe		= ddcci_monitor_probe,
+	.remove		= ddcci_monitor_remove,
+};
+
+module_ddcci_driver(ddcci_backlight_driver);
+
+/* Module parameter description */
+module_param(convenience_symlink, bool, 0644);
+MODULE_PARM_DESC(convenience_symlink, "add convenience symlink \"ddcci_backlight\" to ancestor device in sysfs (default true)");
+
+MODULE_AUTHOR("Christoph Grenz <christophg+lkml@grenz-bonn.de>");
+MODULE_DESCRIPTION("DDC/CI generic monitor backlight driver");
+MODULE_VERSION("0.4.2");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS("ddcci:monitor-*-*-*-*");
-- 
2.25.1

