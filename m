Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEED44855A6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbiAEPQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:16:54 -0500
Received: from aposti.net ([89.234.176.197]:42302 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241296AbiAEPQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:16:33 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v2 2/2] hwmon: Add "label" attribute
Date:   Wed,  5 Jan 2022 15:15:51 +0000
Message-Id: <20220105151551.20285-3-paul@crapouillou.net>
In-Reply-To: <20220105151551.20285-1-paul@crapouillou.net>
References: <20220105151551.20285-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a label is defined in the device tree for this device add that
to the device specific attributes. This is useful for userspace to
be able to identify an individual device when multiple identical
chips are present in the system.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---

Notes:
    v2: - Cache label into hwmon_device
        - Rename hwmon_dev_name_is_visible() to hwmon_dev_attr_is_visible()
	- Add missing <linux/property.h> include

 drivers/hwmon/hwmon.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 3501a3ead4ba..22e1b47c09fc 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -18,6 +18,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/thermal.h>
@@ -30,6 +31,7 @@
 
 struct hwmon_device {
 	const char *name;
+	const char *label;
 	struct device dev;
 	const struct hwmon_chip_info *chip;
 	struct list_head tzdata;
@@ -71,17 +73,29 @@ name_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(name);
 
+static ssize_t
+label_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", to_hwmon_device(dev)->label);
+}
+static DEVICE_ATTR_RO(label);
+
 static struct attribute *hwmon_dev_attrs[] = {
 	&dev_attr_name.attr,
+	&dev_attr_label.attr,
 	NULL
 };
 
-static umode_t hwmon_dev_name_is_visible(struct kobject *kobj,
+static umode_t hwmon_dev_attr_is_visible(struct kobject *kobj,
 					 struct attribute *attr, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
+	struct hwmon_device *hdev = to_hwmon_device(dev);
 
-	if (to_hwmon_device(dev)->name == NULL)
+	if (attr == &dev_attr_name.attr && hdev->name == NULL)
+		return 0;
+
+	if (attr == &dev_attr_label.attr && hdev->label == NULL)
 		return 0;
 
 	return attr->mode;
@@ -89,7 +103,7 @@ static umode_t hwmon_dev_name_is_visible(struct kobject *kobj,
 
 static const struct attribute_group hwmon_dev_attr_group = {
 	.attrs		= hwmon_dev_attrs,
-	.is_visible	= hwmon_dev_name_is_visible,
+	.is_visible	= hwmon_dev_attr_is_visible,
 };
 
 static const struct attribute_group *hwmon_dev_attr_groups[] = {
@@ -117,6 +131,7 @@ static void hwmon_dev_release(struct device *dev)
 	if (hwdev->group.attrs)
 		hwmon_free_attrs(hwdev->group.attrs);
 	kfree(hwdev->groups);
+	kfree(hwdev->label);
 	kfree(hwdev);
 }
 
@@ -733,6 +748,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 			const struct attribute_group **groups)
 {
 	struct hwmon_device *hwdev;
+	const char *label;
 	struct device *hdev;
 	int i, err, id;
 
@@ -752,6 +768,18 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 		goto ida_remove;
 	}
 
+	if (device_property_present(dev, "label")) {
+		err = device_property_read_string(dev, "label", &label);
+		if (err < 0)
+			goto free_hwmon;
+
+		hwdev->label = kstrdup(label, GFP_KERNEL);
+		if (hwdev->label == NULL) {
+			err = -ENOMEM;
+			goto free_hwmon;
+		}
+	}
+
 	hdev = &hwdev->dev;
 
 	if (chip) {
-- 
2.34.1

