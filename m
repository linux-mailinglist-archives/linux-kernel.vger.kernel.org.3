Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9157548052B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 23:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhL0Wm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 17:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhL0Wm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 17:42:26 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6344C06173E;
        Mon, 27 Dec 2021 14:42:25 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w16so66712231edc.11;
        Mon, 27 Dec 2021 14:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=acGGMkplWtNeHQ2mdvAW/XLbQNWacsZS02d5/9vOayk=;
        b=BPhICOEdy9n0mW+PxvMqYCj9QMC8jQvQWJroFnUdX9quC6Gy/eDslOWgBoEGsaRcPE
         /8sUriPw1CgaSnT6b8nDUyxyJFowm64ZMApxqtF44ba57gmEWfCTkZExCXtpg748Tp/A
         ud2yBm/kHhoj4XiNB29qkBRE4wv/zGCan7PvcUSB6kff9aBJeX809qSss/Sb7BLVqqkV
         GJ3sVfcE616lH/AbPhuTE3qJPXufCi/TF1YoI+Lr1ks03JTJIQ7+BcSW55rpE+VkK1wj
         IdAQKZOQoWBiDuIzOqR2jlpLiEn/XKmfbg3Ir+4qblZ9xrk50OzvL2DMoN2DanXVuqIq
         eeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=acGGMkplWtNeHQ2mdvAW/XLbQNWacsZS02d5/9vOayk=;
        b=VuFdMFvqM+4rFrE6Vf2KCwTbPMTCYnbF28w8VOe06maPcEvi9dS+WI7Ir0MK35w7x4
         c9XQqFMSeufTYzeSdMO+cPRhYmoMwosA72ce+4FIsIoXgxfFcxVja8AN714mM8RjFJmc
         yX8A7FGpp5qVpgeRx2PYPIKXOcZetPP+HZRyKaBzRIhcGrLGtM/TF0mqd74RUARjorwA
         p/7B4vEzebd9GN5kTZLpBwmHeMJsFjpaKPUPeFqztBC7Q+CvjZNA9rIhvTUS3/2BjDXK
         +ZEwOpP3AxmuLPiAHo3aJwMYPVPQkeltt73AfWu6e2r30VAQEwwIgxFa4Pcmf4c5HA4/
         ja7A==
X-Gm-Message-State: AOAM5330BMfYlegeH+rAP32EygrMFGd4MncrPBPnzO4fkQvixA8Ne1R4
        ydytDE8MxIkR442oybh/dS8=
X-Google-Smtp-Source: ABdhPJzod+OsJmxXBEAnbfCvwmtPpIDMnyLqyTjcX6EO1qknX2r3SZxpqVqR5mSKqfX+k0KnXZc+WQ==
X-Received: by 2002:a17:906:5501:: with SMTP id r1mr15677804ejp.212.1640644944225;
        Mon, 27 Dec 2021 14:42:24 -0800 (PST)
Received: from demon-pc.localdomain ([79.112.215.103])
        by smtp.gmail.com with ESMTPSA id sb13sm5566806ejc.26.2021.12.27.14.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 14:42:23 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] hwmon: Add debugfs register access
Date:   Tue, 28 Dec 2021 00:42:01 +0200
Message-Id: <20211227224201.508331-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211227224201.508331-1-demonsingur@gmail.com>
References: <20211227224201.508331-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

Similar to IIO, create a device directory inside debugfs
mount point, and create a direct_reg_access file inside
that directory, if debugfs_reg_access callback is defined
inside hwmon_ops.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 Documentation/hwmon/hwmon-kernel-api.rst |  9 +++
 drivers/hwmon/hwmon.c                    | 97 ++++++++++++++++++++++++
 include/linux/hwmon.h                    | 12 +++
 3 files changed, 118 insertions(+)

diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
index c41eb6108103..d568a0bfa5fb 100644
--- a/Documentation/hwmon/hwmon-kernel-api.rst
+++ b/Documentation/hwmon/hwmon-kernel-api.rst
@@ -136,6 +136,8 @@ The list of hwmon operations is defined as::
 		    u32 attr, int, long *);
 	int (*write)(struct device *, enum hwmon_sensor_types type,
 		     u32 attr, int, long);
+	int (*reg_access)(struct device *dev, unsigned int reg,
+			  unsigned int writeval, unsigned int *readval);
   };
 
 It defines the following operations.
@@ -152,6 +154,13 @@ It defines the following operations.
     Pointer to a function for writing a value to the chip. This function is
     optional, but must be provided if any writeable attributes exist.
 
+* reg_access:
+    Pointer to a function for writing or reading a register to the chip.
+    This function is optional.
+    WARNING: Drivers implementing this function must block any access that
+    may cause issues such as power loss, board resets, flash corruption or
+    bricking.
+
 Each sensor channel is described with struct hwmon_channel_info, which is
 defined as follows::
 
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 3501a3ead4ba..027e5fc33114 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitops.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
@@ -35,6 +36,9 @@ struct hwmon_device {
 	struct list_head tzdata;
 	struct attribute_group group;
 	const struct attribute_group **groups;
+	unsigned int cached_reg_addr;
+	char read_buf[20];
+	unsigned int read_buf_len;
 };
 
 #define to_hwmon_device(d) container_of(d, struct hwmon_device, dev)
@@ -64,6 +68,90 @@ struct hwmon_thermal_data {
 	struct thermal_zone_device *tzd;/* thermal zone device */
 };
 
+static struct dentry *hwmon_debugfs_dentry;
+
+static ssize_t hwmon_debugfs_read_reg(struct file *file,
+				      char __user *userbuf,
+				      size_t count, loff_t *ppos)
+{
+	struct hwmon_device *hwdev = file->private_data;
+	unsigned int val;
+	int ret;
+
+	if (*ppos > 0)
+		return simple_read_from_buffer(userbuf, count, ppos,
+					       hwdev->read_buf,
+					       hwdev->read_buf_len);
+
+	ret = hwdev->chip->ops->reg_access(&hwdev->dev, hwdev->cached_reg_addr,
+					   0, &val);
+	if (ret)
+		return ret;
+
+	hwdev->read_buf_len = snprintf(hwdev->read_buf, sizeof(hwdev->read_buf),
+				       "0x%X\n", val);
+
+	return simple_read_from_buffer(userbuf, count, ppos, hwdev->read_buf,
+				       hwdev->read_buf_len);
+}
+
+static ssize_t hwmon_debugfs_write_reg(struct file *file,
+				       const char __user *userbuf,
+				       size_t count, loff_t *ppos)
+{
+	struct hwmon_device *hwdev = file->private_data;
+	unsigned int reg, val;
+	char buf[80];
+	int ret;
+
+	count = min_t(size_t, count, sizeof(buf) - 1);
+	if (copy_from_user(buf, userbuf, count))
+		return -EFAULT;
+
+	buf[count] = 0;
+
+	ret = sscanf(buf, "%i %i", &reg, &val);
+
+	switch (ret) {
+	case 1:
+		hwdev->cached_reg_addr = reg;
+		break;
+	case 2:
+		hwdev->cached_reg_addr = reg;
+		ret = hwdev->chip->ops->reg_access(&hwdev->dev, reg, val, NULL);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations hwmon_debugfs_reg_fops = {
+	.open = simple_open,
+	.read = hwmon_debugfs_read_reg,
+	.write = hwmon_debugfs_write_reg,
+};
+
+static void hwmon_device_register_debugfs(struct hwmon_device *hwdev)
+{
+	struct dentry *dir = debugfs_create_dir(dev_name(&hwdev->dev),
+						hwmon_debugfs_dentry);
+
+	debugfs_create_file("direct_reg_access", 0644, dir, hwdev,
+			    &hwmon_debugfs_reg_fops);
+}
+
+static void hwmon_device_unregister_debugfs(struct hwmon_device *hwdev)
+{
+	struct dentry *dir = debugfs_lookup(dev_name(&hwdev->dev),
+					    hwmon_debugfs_dentry);
+
+	debugfs_remove_recursive(dir);
+}
+
 static ssize_t
 name_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -114,6 +202,8 @@ static void hwmon_dev_release(struct device *dev)
 {
 	struct hwmon_device *hwdev = to_hwmon_device(dev);
 
+	hwmon_device_unregister_debugfs(hwdev);
+
 	if (hwdev->group.attrs)
 		hwmon_free_attrs(hwdev->group.attrs);
 	kfree(hwdev->groups);
@@ -817,6 +907,9 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 		}
 	}
 
+	if (chip && chip->ops->reg_access)
+		hwmon_device_register_debugfs(hwdev);
+
 	return hdev;
 
 free_hwmon:
@@ -1062,12 +1155,16 @@ static int __init hwmon_init(void)
 		pr_err("couldn't register hwmon sysfs class\n");
 		return err;
 	}
+
+	hwmon_debugfs_dentry = debugfs_create_dir("hwmon", NULL);
+
 	return 0;
 }
 
 static void __exit hwmon_exit(void)
 {
 	class_unregister(&hwmon_class);
+	debugfs_remove(hwmon_debugfs_dentry);
 }
 
 subsys_initcall(hwmon_init);
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index fad1f1df26df..587fb2931ac1 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -390,6 +390,16 @@ enum hwmon_intrusion_attributes {
  *			Channel number
  *		@val:	Value to write
  *		The function returns 0 on success or a negative error number.
+ * @reg_access:
+ *		Callback to read or write register values.
+ *		Parameters are:
+ *		@dev:	Pointer to hardware monitoring device
+ *		@reg:	Register address to read or write
+ *		@writeval:
+ *			Value to write to register. 0 when reading.
+ *		@readval:
+ *			Pointer to value read from register. NULL when writing.
+ *		The function returns 0 on success or a negative error number.
  */
 struct hwmon_ops {
 	umode_t (*is_visible)(const void *drvdata, enum hwmon_sensor_types type,
@@ -400,6 +410,8 @@ struct hwmon_ops {
 		    u32 attr, int channel, const char **str);
 	int (*write)(struct device *dev, enum hwmon_sensor_types type,
 		     u32 attr, int channel, long val);
+	int (*reg_access)(struct device *dev, unsigned int reg,
+			  unsigned int writeval, unsigned int *readval);
 };
 
 /**
-- 
2.34.1

