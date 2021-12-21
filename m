Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2770147BFE9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhLUMm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhLUMm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:42:27 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFF0C061574;
        Tue, 21 Dec 2021 04:42:26 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f5so28380559edq.6;
        Tue, 21 Dec 2021 04:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k4hxvy8pqf+gc09rPwYSGhnBkUTuFNvjBCA7sQpk+bU=;
        b=EVEQvhInNWRB798PhHgKi7vkuwJb2Axyp0wR4E5KfodISQ0yQGlOtzTkBZVZpsgmE5
         E58S4sQOD5BQQsnTmICphq5+ODZ+ao/bfF/g/QkJLKxqyWSeszHyTwVHAwzy9j2bDnkB
         l4nLJiuu6sz07aV6Xpj0901Ye/JqT1cmQ+m4Pu0pBWJZ2KNdOQLC4OJjIpNMgtLXrzMw
         TRZerQbv4yB+pGFXNGPRuGYkpr7REImF98ZJbREjbiAuC1wEhW0LjRbIVt2tfPp/pf/e
         AWn+ykXsJfRC6B9MYjQ4Ueu/9ceGULcXj+2TcLjo3dOm/ooVvLsw2eKigZfubdZ2drlp
         UEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k4hxvy8pqf+gc09rPwYSGhnBkUTuFNvjBCA7sQpk+bU=;
        b=Oyg61X/af4ey0nbp6p1WzmdVne/ZkfTvx638csc5ry/Z+ybmTi7mxprxpwOE/BOA55
         dMssE0g15mpoq9z0iT3tGBzTkzvkTsFsAqauPXsnsf3KubD06PgY6AJ4D3cJVFJJuY0U
         JhmeWhz3ZTh2ZofqcZpPy82U1uGswddB9TKdEDkXZhIbhiWWzDJbo6/saQRDVTjnPNrI
         WHKqzKmhPDoMJIUbOjtkmZqKfkVB6FBMg/6Z12vMHwPbWISH23a3uU3q1BawX4A7a0L8
         sXoyAc01jnDVqUzDh8fzoeuh8+AUQxpY9fPt4HYmWbgKFk7Ep8BMygO3ddmDMdEJsfa4
         B3/Q==
X-Gm-Message-State: AOAM532LbyQm7OJNEwqiTSGyg0jlWUwPByxNQ4P/qEomDXC9S60954gy
        BAMbUpZJsNp62jY3ewj0yjg=
X-Google-Smtp-Source: ABdhPJxx9wHDPwSooBfGIlXW5cqW0FDdC1aznegR+cLjBDQ4rWo7BgGP03C3YkgbjDrLbDJFXDPf3w==
X-Received: by 2002:a17:907:720d:: with SMTP id dr13mr2458963ejc.271.1640090545489;
        Tue, 21 Dec 2021 04:42:25 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id eg12sm2756179edb.25.2021.12.21.04.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:42:25 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] hwmon: add debugfs register access
Date:   Tue, 21 Dec 2021 14:42:21 +0200
Message-Id: <20211221124221.2684214-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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
 drivers/hwmon/hwmon.c | 122 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/hwmon.h |  12 +++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 3501a3ead4ba..a3dc785cd885 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitops.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
@@ -35,6 +36,12 @@ struct hwmon_device {
 	struct list_head tzdata;
 	struct attribute_group group;
 	const struct attribute_group **groups;
+#if defined(CONFIG_DEBUG_FS)
+	struct dentry *debugfs_dentry;
+	unsigned int cached_reg_addr;
+	char read_buf[20];
+	unsigned int read_buf_len;
+#endif
 };
 
 #define to_hwmon_device(d) container_of(d, struct hwmon_device, dev)
@@ -64,6 +71,113 @@ struct hwmon_thermal_data {
 	struct thermal_zone_device *tzd;/* thermal zone device */
 };
 
+static struct dentry *hwmon_debugfs_dentry;
+
+#if defined(CONFIG_DEBUG_FS)
+static ssize_t hwmon_debugfs_read_reg(struct file *file, char __user *userbuf,
+				      size_t count, loff_t *ppos)
+{
+	struct hwmon_device *hwdev = file->private_data;
+	struct device *hdev = &hwdev->dev;
+	unsigned int val = 0;
+	int ret;
+
+	if (*ppos > 0)
+		return simple_read_from_buffer(userbuf, count, ppos,
+					       hwdev->read_buf,
+					       hwdev->read_buf_len);
+
+	ret = hwdev->chip->ops->debugfs_reg_access(hdev, hwdev->cached_reg_addr,
+						   0, &val);
+	if (ret) {
+		dev_err(hdev->parent, "%s: read failed\n", __func__);
+		return ret;
+	}
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
+	struct device *hdev = &hwdev->dev;
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
+		ret = hwdev->chip->ops->debugfs_reg_access(hdev, reg, val,
+							   NULL);
+		if (ret) {
+			dev_err(hdev->parent, "%s: write failed\n", __func__);
+			return ret;
+		}
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
+	if (IS_ERR(hwmon_debugfs_dentry))
+		return;
+
+	if (!hwdev->chip || !hwdev->chip->ops ||
+		!hwdev->chip->ops->debugfs_reg_access)
+		return;
+
+	hwdev->debugfs_dentry = debugfs_create_dir(dev_name(&hwdev->dev),
+						   hwmon_debugfs_dentry);
+
+	if (IS_ERR(hwdev->debugfs_dentry))
+		return;
+
+	debugfs_create_file("direct_reg_access", 0644, hwdev->debugfs_dentry,
+			    hwdev, &hwmon_debugfs_reg_fops);
+}
+
+static void hwmon_device_unregister_debugfs(struct hwmon_device *hwdev)
+{
+	debugfs_remove_recursive(hwdev->debugfs_dentry);
+}
+#else
+static void hwmon_device_register_debugfs(struct hwmon_device *hwdev)
+{
+}
+
+static void hwmon_device_unregister_debugfs(struct hwmon_device *hwdev)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static ssize_t
 name_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -114,6 +228,8 @@ static void hwmon_dev_release(struct device *dev)
 {
 	struct hwmon_device *hwdev = to_hwmon_device(dev);
 
+	hwmon_device_unregister_debugfs(hwdev);
+
 	if (hwdev->group.attrs)
 		hwmon_free_attrs(hwdev->group.attrs);
 	kfree(hwdev->groups);
@@ -817,6 +933,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 		}
 	}
 
+	hwmon_device_register_debugfs(hwdev);
+
 	return hdev;
 
 free_hwmon:
@@ -1062,12 +1180,16 @@ static int __init hwmon_init(void)
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
index fad1f1df26df..4cbbc1ed2d7b 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -390,6 +390,16 @@ enum hwmon_intrusion_attributes {
  *			Channel number
  *		@val:	Value to write
  *		The function returns 0 on success or a negative error number.
+ * @debugfs_reg_access:
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
+	int (*debugfs_reg_access)(struct device *dev, unsigned int reg,
+				  unsigned int writeval, unsigned int *readval);
 };
 
 /**
-- 
2.34.1

