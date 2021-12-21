Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB1B47C571
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbhLURuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:50:54 -0500
Received: from aposti.net ([89.234.176.197]:39354 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240646AbhLURux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:50:53 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH 2/2] hwmon: Add "label" attribute
Date:   Tue, 21 Dec 2021 17:50:29 +0000
Message-Id: <20211221175029.144906-3-paul@crapouillou.net>
In-Reply-To: <20211221175029.144906-1-paul@crapouillou.net>
References: <20211221175029.144906-1-paul@crapouillou.net>
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
 drivers/hwmon/hwmon.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 3501a3ead4ba..15826260a463 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -71,8 +71,23 @@ name_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(name);
 
+static ssize_t
+label_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	const char *label;
+	int ret;
+
+	ret = device_property_read_string(dev, "label", &label);
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%s\n", label);
+}
+static DEVICE_ATTR_RO(label);
+
 static struct attribute *hwmon_dev_attrs[] = {
 	&dev_attr_name.attr,
+	&dev_attr_label.attr,
 	NULL
 };
 
@@ -81,7 +96,12 @@ static umode_t hwmon_dev_name_is_visible(struct kobject *kobj,
 {
 	struct device *dev = kobj_to_dev(kobj);
 
-	if (to_hwmon_device(dev)->name == NULL)
+	if (attr == &dev_attr_name.attr &&
+	    to_hwmon_device(dev)->name == NULL)
+		return 0;
+
+	if (attr == &dev_attr_label.attr &&
+	    !device_property_present(dev, "label"))
 		return 0;
 
 	return attr->mode;
-- 
2.34.1

